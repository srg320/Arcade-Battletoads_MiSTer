module FG_VRAM #(parameter REGISTERED_FG_BANK_Q=0, parameter FAST_UPPER=0) (
	input          CLK,
	input          CPU_CLK,
	input          RST_N,
	
	input  [17: 0] A,
	input  [15: 0] D,
	output [15: 0] Q,
	input          RAS_N,
	input  [ 1: 0] CAS_N,
	input          WE_N,
	input          OE_N,
	output         RDY,
	
	input          SC,
	input          SE_N,
	input  [ 7: 0] SD,
	output logic [ 7: 0] SQ,
	input          DRAW_WE,
	input [15:0]   DRAW_BANK_WE, DRAW_RAM_BANK_WE,
	input  [16: 0] DRAW_ADDR,
	input  [ 7: 0] DRAW_DATA,
	input          TRANSFER,
	input          CPU_SHIFT,
	input          MEM_CE,
	output [17: 0] HOLE_A,
	output         HOLE_SEL,
	output         HOLE_RD,
	output [3:0]   HOLE_WE,
	output [31:0]  HOLE_DATA,
	input  [31: 0] HOLE_Q,
	input          HOLE_RDY,
	input  [63: 0] CPU_SHIFT_Q,
	output [ 5: 0] CPU_SHIFT_A,
	output         CPU_SHIFT_RD,
	output [ 5: 0] CPU_SHIFT_WA,
	output [63: 0] CPU_SHIFT_DATA,
	output         CPU_SHIFT_WE,
	input [3:0][63:0] CPU_SHIFT_BANK_Q,
	output [63:0] CPU_SHIFT_SOURCE_D,
	// FAST_UPPER: CPU write transfers send the DDR-backed upper half as one
	// 64-bit beat per word pair on a native memory-clock port.
	output         FAST_WE,
	output [16: 0] FAST_WORD,
	output [63: 0] FAST_DATA,
	input          FAST_DONE
);
	// DDR-phase position step and last position of a CPU write transfer.
	localparam [8:0] DDR_STEP = FAST_UPPER ? 9'd4 : 9'd2;
	localparam [8:0] DDR_END = FAST_UPPER ? 9'h1fc : 9'h1fe;
    // Same-edge state shadow, kept separately for the four serial banks.
    (* preserve, dont_merge *) bit [3:0] COPY_PREFETCH_B;



	bit  [15: 3] RAM_SA;
	bit          RAM_SWE;
	bit  [63: 0] RAM_SQ;
	bit  [ 8: 0] SR_WA;
	bit  [ 7: 0] SR_WE;
	bit          SR_MRT;
	bit  [ 8: 0] SR_RA;
	bit  [63: 0] SR_Q;
	bit  [15: 3] CPU_RAM_A, CPU_RAM_A2;
	bit          CPU_RAM_WE, CPU_RAM_WE2;
	(* preserve *) bit [3:0] CPU_COPY_MODE_B;
	// Four copies of each bank's copy-mode select, one per 16-bit chunk of the
	// 64-bit serial data mux (one net would drive all 64 mux selects).
	wire [3:0][3:0] CPU_COPY_MODE_B4;
	(* preserve *) bit [3:0] CPU_RAM_WE_B, CPU_RAM_WE_B2;
	// Per-bank serial write enable, bank decode folded in one stage early: the
	// RAM write-enable pin is driven directly by this register.
	(* preserve *) bit [3:0] CPU_RAM_WREN_B2;
	// The same write-stage edge also decodes each physical 5-bit segment.
	// Keep these enables local; no read address enters the write cone.
	(* preserve, dont_merge *) bit [3:0][3:0] CPU_RAM_WREN_SEG_B2;
	(* preserve, dont_merge *) bit [3:0] UNALIGNED_B;
	(* preserve *) bit [3:0][12:0] CPU_RAM_A_B, CPU_RAM_A_B2;
	// Copy-address decodes kept in lockstep with COPY_ADDR/COPY_POS.
	bit          COPY_DDR, COPY_ODD;
	// Four copies of the original owner D, one per gathered 16-bit pair.
	(* preserve, dont_merge *) bit [3:0] COPY_DDR_CHUNK;
	bit          READ_DDR_R; // UNALIGNED_EXEC && COPY_DDR, held as one register
	bit  [ 7: 0] COPY_LANE, COPY_POS_OH;
	(* preserve *) bit [2:0] COPY_LANE_BIN;   // COPY_ADDR[2:0], local copy for the byte pick
	(* preserve, dont_merge *) bit [7:0][2:0] COPY_LANE_BIN8;   // one copy per bit of the picked byte
	// Gather pipeline: the RAM address of the byte after the one being
	// collected is presented during the collect tick (COPY_ADDR_N = COPY_ADDR+1),
	// so a byte whose predecessor was collected needs no extra read wait.
	bit  [17: 0] COPY_ADDR_N;
	bit          COPY_PRE;
	bit  [ 5: 0] CPU_CACHE_A, CPU_CACHE_A2;
	// Every serial-port RAM read (bank RAMs, shift-register RAM, sprite
	// mirror) now leaves through the M10K output register: two memory clocks
	// from address to data. The serial write strobe/address, the refresh
	// write stage and the lane selects below carry a matching second stage.
	bit  [ 8: 0] SR_WA2;
	bit  [ 7: 0] SR_WE2;
	bit          SR_MRT2;
	bit  [ 7: 0] SD_M2;

	// The shift-register RAM's output register is cleared by reset, so its
	// word reads as zero until the first clock after reset, with no gate.
	wire [63:0] SERIAL_WRITE_WORD = SR_Q;
	
	// Keep the address, both byte lanes and byte enables together across
	// the related CPU/RAM clocks; commit once before the next CPU command.
	bit          WE_N_OLD;
	// dont_replicate: a fitter duplicate of this CPU-clock toggle placed next to
	// its memory-clock capture register failed hold (c26).
	(* preserve, dont_replicate *) bit WRITE_TOGGLE;
	bit          WRITE_SEEN;
	bit [14:0]   WRITE_ADDR;
	bit [15:0]   WRITE_DATA;
	bit [1:0]    WRITE_BE;
	bit [15:0]   WRITE_BANK_SEL;
	// Memory-clock copies of every CPU-clock input the memory-clock logic
	// uses: CPU bus, serial controls and the sprite draw packet. Each
	// system-clock launch lands on a plain register first, so the
	// address/data muxes, bank strobes and transfer decode stay inside the
	// memory clock. Every command arrives one memory clock later, so their
	// relative order is unchanged; the CPU samples ready and read data at
	// least four memory clocks after presenting an address. MEM_CE is not
	// copied: it is the DDR controller's CE_R acceptance window, and the
	// hole state machines must leave their request up through that window.
	// Decode at the original raw-command capture edge. The bit casts
	// reproduce the original individual two-state flag captures, also
	// when a four-state simulator presents X/Z at an input.
	// Bit-valued automatic arguments reproduce the original flag captures
	// before evaluating the predicate, including four-state simulator inputs.
	function automatic bit FG_READ_COMMAND;
		input bit ras_n, oe_n, we_n, transfer;
		begin
			FG_READ_COMMAND = !ras_n && !oe_n && we_n && transfer;
		end
	endfunction
	// These predicates are evaluated inside the original raw-command edge.
	// bit-valued arguments match the original individual flag X/Z captures.
	function automatic bit FG_TRANSFER_COMMAND;
		input bit ras_n, oe_n, transfer;
		begin FG_TRANSFER_COMMAND = !ras_n && !oe_n && transfer; end
	endfunction
	function automatic bit FG_RMT_COMMAND;
		input bit ras_n, oe_n, we_n, transfer, se_n;
		begin FG_RMT_COMMAND = !ras_n && !oe_n && !we_n && transfer && !se_n; end
	endfunction
	(* preserve, dont_merge *) bit [2:0] HOLE_RAS_N_M = '1;
	(* preserve, dont_merge *) bit [2:0] HOLE_TRANSFER_REQUEST_M = '0;
	(* preserve, dont_merge *) bit [2:0] HOLE_RMT_REQUEST_M = '0;
	(* preserve, dont_merge *) bit [7:0] COPY_READ_REQUEST_M = '0;
	bit [17: 0] A_M;
	bit         RAS_N_M = 1'b1, OE_N_M = 1'b1, WE_N_M = 1'b1, SC_M, SE_N_M = 1'b1;
	bit         TRANSFER_M, CPU_SHIFT_M, DRAW_WE_M;
	bit [ 7: 0] SD_M, DRAW_DATA_M;
	bit [3:0] DRAW_BANK_ACTIVE_M, DRAW_RAM_BANK_ACTIVE_M;
	bit [16: 0] DRAW_ADDR_M;
	always @(posedge CLK) begin
		HOLE_RAS_N_M <= {3{RAS_N}};
		HOLE_TRANSFER_REQUEST_M <= {3{FG_TRANSFER_COMMAND(RAS_N, OE_N, TRANSFER)}};
		HOLE_RMT_REQUEST_M <= {3{FG_RMT_COMMAND(RAS_N, OE_N, WE_N, TRANSFER, SE_N)}};
		COPY_READ_REQUEST_M <= {8{FG_READ_COMMAND(RAS_N, OE_N, WE_N, TRANSFER)}};
		A_M <= A;
		RAS_N_M <= RAS_N;
		OE_N_M <= OE_N;
		WE_N_M <= WE_N;
		SC_M <= SC;
		SE_N_M <= SE_N;
		SD_M <= SD;
		TRANSFER_M <= TRANSFER;
		CPU_SHIFT_M <= CPU_SHIFT;
		DRAW_WE_M <= DRAW_WE;
		for (integer bank=0; bank<4; bank=bank+1) begin
			DRAW_BANK_ACTIVE_M[bank] <= |DRAW_BANK_WE[bank*4 +: 4];
			DRAW_RAM_BANK_ACTIVE_M[bank] <= |DRAW_RAM_BANK_WE[bank*4 +: 4];
		end
		DRAW_ADDR_M <= DRAW_ADDR;
		DRAW_DATA_M <= DRAW_DATA;
	end
	// CPU-clock copy of the VRAM reset: the memory-clock reset tree must not
	// fan out directly into CPU-clock write-packet registers.
	reg CPU_RST_N = 1'b0;
	always @(posedge CPU_CLK) CPU_RST_N <= RST_N;
	always @(posedge CPU_CLK) begin
		if (!CPU_RST_N) begin
			WE_N_OLD <= 1;
			WRITE_TOGGLE <= 0;
			WRITE_ADDR <= '0;
			WRITE_DATA <= '0;
			WRITE_BE <= '0;
			WRITE_BANK_SEL <= 16'b1;
		end else begin
			WE_N_OLD <= WE_N;
			if (!WE_N && WE_N_OLD && OE_N && !RAS_N && !(|A[9:8])) begin
				WRITE_ADDR <= {A[17:10],A[7:1]};
				WRITE_BANK_SEL <= 16'b1 << A[17:14];
				WRITE_DATA <= D;
				WRITE_BE <= ~CAS_N;
				WRITE_TOGGLE <= ~WRITE_TOGGLE;
			end
		end
	end
	// The toggle crosses into the memory clock through one plain register;
	// the pending compare and the bank write-enable mux start from it.
	// Two kept identity cells delay only the first MEM capture data path.
	// No register, clock edge, packet consumer or memory mode changes.
	(* keep *) wire WRITE_TOGGLE_DELAY0, WRITE_TOGGLE_DELAY1;
	lcell write_toggle_delay0(.in(WRITE_TOGGLE), .out(WRITE_TOGGLE_DELAY0));
	lcell write_toggle_delay1(.in(WRITE_TOGGLE_DELAY0), .out(WRITE_TOGGLE_DELAY1));
	bit WRITE_TOGGLE_M;
	always @(posedge CLK) begin
		if (!RST_N) begin
			WRITE_TOGGLE_M <= 0;
			WRITE_SEEN <= 0;
		end else begin
			WRITE_TOGGLE_M <= WRITE_TOGGLE_DELAY1;
			WRITE_SEEN <= WRITE_TOGGLE_M;
		end
	end
	wire WRITE_PENDING = WRITE_TOGGLE_M != WRITE_SEEN;
	// Port-A source selection as registers: each is loaded with the value the
	// original combinational select takes after this edge (DRAW_WE_M is DRAW_WE
	// delayed, WRITE_PENDING compares the toggle with its memory-clock copy).
	wire PENDING_NEXT = WRITE_TOGGLE != WRITE_TOGGLE_M;
	(* preserve *) bit SEL_DRAW_R, SEL_WR_R, SEL_RD_R;
	// Per-bank copies: each bank's port-A address/data mux has its own selects.
	(* preserve, dont_merge *) bit [3:0] SEL_DRAW_RB, SEL_WR_RB, SEL_RD_RB;
	(* preserve *) bit [3:0] BANK_WREN_R;
	(* preserve, maxfan = 4 *) bit [3:0][1:0] BANK_LANE_WREN_R;   // BANK_WREN_R[b] & byte enable, per lane
	always @(posedge CLK) begin
		if (!RST_N) begin SEL_DRAW_RB <= '0; SEL_WR_RB <= '0; SEL_RD_RB <= '1; SEL_DRAW_R <= 1'b0; SEL_WR_R <= 1'b0; SEL_RD_R <= 1'b1; BANK_WREN_R <= '0; BANK_LANE_WREN_R <= '0; end
		else begin
			SEL_DRAW_RB <= {4{DRAW_WE}};
			SEL_WR_RB <= {4{!DRAW_WE && PENDING_NEXT}};
			SEL_RD_RB <= {4{!DRAW_WE && !PENDING_NEXT}};
			SEL_DRAW_R <= DRAW_WE;
			SEL_WR_R <= !DRAW_WE && PENDING_NEXT;
			SEL_RD_R <= !DRAW_WE && !PENDING_NEXT;
			for (integer b = 0; b < 4; b = b + 1) begin
				BANK_WREN_R[b] <= (|DRAW_RAM_BANK_WE[b*4 +: 4]) |
				    (PENDING_NEXT ? (DRAW_WE ? (|DRAW_BANK_WE[b*4 +: 4]) : (|WRITE_BANK_SEL[b*4 +: 4])) : 1'b0);
				BANK_LANE_WREN_R[b] <= {2{(|DRAW_RAM_BANK_WE[b*4 +: 4]) |
				    (PENDING_NEXT ? (DRAW_WE ? (|DRAW_BANK_WE[b*4 +: 4]) : (|WRITE_BANK_SEL[b*4 +: 4])) : 1'b0)}} &
				    (DRAW_WE ? (DRAW_ADDR[0] ? 2'b10 : 2'b01) : WRITE_BE);
			end
		end
	end

	// Scanout uses 256 columns. The remaining logical columns live in DDR.
	// Per-bank copies of the serial B-port address sources, each loaded with the
	// value the shared register takes after the edge: every bank's address mux
	// then starts from registers local to it instead of one high-fanout net.
	(* preserve, dont_merge *) bit [3:0][10:0] SADDR_C_BK, SADDR_CN_BK;
	// The video serial address and copy-mode select are tracked per bank by a
	// local replica of the row/position state machine (BT_FG_VIDEO_ADDR_TRACK):
	// its inputs are per-bank register copies, so no shared next-state net
	// fans out to the four bank regions.
	wire [3:0][10:0] SADDR_V_BK;
	wire [3:0] CPU_COPY_MODE_T;
	(* preserve, dont_merge *) bit [3:0] SERIAL_COPY_RAS_OLD_B;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) SERIAL_COPY_RAS_OLD_B <= '1;
		else SERIAL_COPY_RAS_OLD_B <= {4{RAS_N_M}};
	end
	genvar serial_copy_bank;
	generate for (serial_copy_bank=0; serial_copy_bank<4; serial_copy_bank=serial_copy_bank+1) begin : serial_copy_address
		(* keep *) wire read_start = COPY_READ_REQUEST_M[serial_copy_bank] && SERIAL_COPY_RAS_OLD_B[serial_copy_bank];
		(* keep *) wire advance_copy = UNALIGNED_B[serial_copy_bank] && COPY_PREFETCH_B[serial_copy_bank];
		(* keep *) wire start_copy = read_start && !advance_copy;
		(* keep *) wire hold_copy = !read_start && !advance_copy;
		// Preserve the original later collect-over-restart priority, with
		// each bank selecting the complete next address beside its flops.
		wire [17:0] next_addr = ({18{advance_copy}} & COPY_ADDR_N) |
			({18{start_copy}} & A_M) | ({18{hold_copy}} & COPY_ADDR);
		wire [17:0] next_copy_addr = ({18{advance_copy}} & COPY_ADDR_STEP_VALUE) |
			({18{start_copy}} & COPY_ADDR_START_VALUE) | ({18{hold_copy}} & COPY_ADDR_N);
		always @(posedge CLK) begin
			if (!RST_N) begin
				SADDR_C_BK[serial_copy_bank] <= '0;
				SADDR_CN_BK[serial_copy_bank] <= '0;
			end else begin
				SADDR_C_BK[serial_copy_bank] <= {next_addr[15:10],next_addr[7:3]};
				SADDR_CN_BK[serial_copy_bank] <= {next_copy_addr[15:10],next_copy_addr[7:3]};
			end
		end
`ifndef SYNTHESIS
		always @(posedge CLK) if (RST_N)
			assert (SERIAL_COPY_RAS_OLD_B[serial_copy_bank] == RDY_RAS_N_OLD && next_copy_addr == HOLE_NEXT_ADDR_N)
				else $fatal(1,"foreground serial next-address priority/history differs");
`endif
	end endgenerate
`ifndef SYNTHESIS
	always @(posedge CLK) if (RST_N) begin
		for (integer b = 0; b < 4; b = b + 1) begin
			assert (video_addr_track[0].track.pos == SREG_POS && video_addr_track[1].track.pos == SREG_POS && video_addr_track[2].track.pos == SREG_POS && video_addr_track[3].track.pos == SREG_POS &&
			        video_addr_track[0].track.row == MEM_ROW[5:0] && video_addr_track[0].track.mrt == MRT_EXEC && video_addr_track[0].track.rmt == RMT_EXEC &&
			        video_addr_track[0].track.copy_mode == CPU_COPY_MODE && video_addr_track[0].track.ddr_state == RMT_DDR_STATE)
				else $fatal(1,"per-bank video address tracker differs from the shared state");
			assert (SADDR_V_BK[b] == {MEM_ROW[5:0], SREG_POS[7:3]} && SADDR_C_BK[b] == {COPY_ADDR[15:10], COPY_ADDR[7:3]} &&
			        SADDR_CN_BK[b] == {COPY_ADDR_N[15:10], COPY_ADDR_N[7:3]})
				else $fatal(1,"per-bank serial address copy differs from the shared register");
		end
	end
	genvar cache_check;
	generate for (cache_check=0; cache_check<4; cache_check=cache_check+1) begin : video_cache_check
		always @(posedge CLK) if (RST_N)
			assert (video_addr_track[cache_check].track.cache_a2 == CPU_CACHE_A2 &&
			        video_addr_track[cache_check].track.pair_pos == CPU_PAIR_POS &&
			        video_addr_track[cache_check].track.CPU_CACHE_READY == CPU_CACHE_READY &&
			        video_addr_track[cache_check].track.ddr_state == RMT_DDR_STATE)
				else $fatal(1,"per-bank cache-ready state differs from the shared state");
	end endgenerate
`endif
	// Port-A address and data per bank, from the per-bank selects: the mux
	// output no longer fans out to all four banks' RAM slices.
	wire [3:0][15:1] ADDR_BK;
	wire [3:0][15:0] DATA_BK;
	genvar abank;
	generate for (abank = 0; abank < 4; abank = abank + 1) begin : port_a_copy
		assign ADDR_BK[abank] = ({15{SEL_DRAW_RB[abank]}} & {DRAW_ADDR_M[16:9],DRAW_ADDR_M[7:1]}) |
		                        ({15{SEL_WR_RB[abank]}} & WRITE_ADDR) | ({15{SEL_RD_RB[abank]}} & {A_M[17:10],A_M[7:1]});
		assign DATA_BK[abank] = SEL_DRAW_RB[abank] ? {2{DRAW_DATA_M}} : WRITE_DATA;
	end endgenerate
`ifndef SYNTHESIS
	always @(posedge CLK) if (RST_N)
		for (integer b = 0; b < 4; b = b + 1)
			assert (ADDR_BK[b] == ((SEL_DRAW_R ? {DRAW_ADDR_M[16:9],DRAW_ADDR_M[7:1]} : 15'd0) |
			                       (SEL_WR_R ? WRITE_ADDR : 15'd0) | (SEL_RD_R ? {A_M[17:10],A_M[7:1]} : 15'd0)) &&
			        DATA_BK[b] == (SEL_DRAW_R ? {2{DRAW_DATA_M}} : WRITE_DATA) &&
			        CPU_COPY_MODE_B4[b] == {4{CPU_COPY_MODE_B[b]}})
				else $fatal(1,"per-bank port-A copies differ from the shared muxes");
`endif
	BT_FG_BANKED_VRAM #(.QA_REG(1), .COPY_PREFETCH_LOCAL(1), .BANK_WRITE_PREDECODED(1), .SERIAL_SEGMENT_PRE(1), .REGISTERED_FG_BANK_Q(REGISTERED_FG_BANK_Q)) mem
	(
		.CLK(CLK),

		.ADDR(({15{SEL_DRAW_R}} & {DRAW_ADDR_M[16:9],DRAW_ADDR_M[7:1]}) |
		      ({15{SEL_WR_R}} & WRITE_ADDR) | ({15{SEL_RD_R}} & {A_M[17:10],A_M[7:1]})),
		.ADDR_B(ADDR_BK), .DATA_B(DATA_BK),
		.DATA(SEL_DRAW_R ? {2{DRAW_DATA_M}} : WRITE_DATA),
        // Preserve the original draw-address priority even when an ordinary
        // CPU packet overlaps a draw into the DDR-backed logical columns.
        .BANK_WREN(16'd0),
        .BANK_WREN_PRE(BANK_WREN_R), .BANK_LANE_WREN_PRE(BANK_LANE_WREN_R),
		.BE(SEL_DRAW_R ? (DRAW_ADDR_M[0] ? 2'b10 : 2'b01) : WRITE_BE),
		.Q(Q),

		.SADDR_VB(SADDR_V_BK), .SADDR_CB(SADDR_C_BK), .SADDR_CNB(SADDR_CN_BK),
		.SADDR_W(CPU_RAM_A2), .SADDR_WB(CPU_RAM_A_B2), .SADDR_C({COPY_ADDR[17:10],COPY_ADDR[7:3]}), .SADDR_CN({COPY_ADDR_N[17:10],COPY_ADDR_N[7:3]}), .COPY_PREFETCH_B(COPY_PREFETCH_B), .SADDR_V({MEM_ROW,SREG_POS[7:3]}),
		.SRSEL(UNALIGNED_B), .SWSEL(CPU_RAM_WE_B2), .SWREN_B(CPU_RAM_WREN_B2), .SWREN_SEG_B(CPU_RAM_WREN_SEG_B2),
		.SDATA_C(CPU_SHIFT_Q), .SDATA_CB(CPU_SHIFT_BANK_Q), .SDATA_S(SERIAL_WRITE_WORD), .SCSEL(CPU_COPY_MODE_B), .SCSEL4(CPU_COPY_MODE_B4),
		.SQ(RAM_SQ), .SQ_D(SQ_D), .COPY_WE_NEXT(RDY_NEXT_COPY_WE)
	);
`ifndef SYNTHESIS
	always @(posedge CLK) if (RST_N)
		assert ((SQ_D | (COPY_WORD & {64{COPY_WE}})) == (COPY_WE ? COPY_WORD : RAM_SQ))
			else $fatal(1,"gated serial data differs from the copy-word mux");
`endif
	
	bit  [ 7: 0] MEM_ROW;
	bit  [ 8: 0] MEM_COL;
	bit  [ 8: 0] SREG_POS;
	bit          MRT_EXEC;	//memory-to-register transfer
	bit          RMT_EXEC;	//register-to-memory transfer
	bit          SIM;			//serial input mode
	bit          SOM;			//serial output mode
	bit          CPU_COPY_MODE;
	bit          RMT_PENDING;
	bit          UNALIGNED_EXEC;
	bit [17: 0]  COPY_ADDR;
	bit [ 8: 0]  COPY_POS;
	bit [ 2: 0]  COPY_STATE;
	bit [63: 0]  COPY_WORD;
	// The gather captures only the byte it will use: the lane/odd select is made
	// before the register (COPY_LANE/COPY_ODD change only when a byte is
	// collected, never between the address and its capture).
	bit [ 7: 0]  COPY_RAM_BYTE, COPY_DDR_BYTE;
	// Full DDR word, kept for bench observation (unused: removed in synthesis).
	bit [31: 0]  COPY_DDR_WORD;
	always @(posedge CLK) COPY_DDR_WORD <= HOLE_Q;
	// The gather state waits three RAM clocks after changing address (address
	// register, output register, this capture) before assembling a byte.
	always @(posedge CLK) begin
		for (integer j = 0; j < 8; j = j + 1) COPY_RAM_BYTE[j] <= RAM_SQ[COPY_LANE_BIN8[j]*8 + j];
		COPY_DDR_BYTE <= COPY_ODD ? HOLE_Q[23:16] : HOLE_Q[7:0];
	end
	bit [ 5: 0]  COPY_WA;
	bit          COPY_WE;
	bit [1:0]    RMT_DDR_STATE;
`ifndef SYNTHESIS
	// bt_fg_copy_phase.sdc gives RAM serial output -> COPY_RAM_BYTE two clocks:
	// the byte consumed in the collect state must come from a RAM word that did
	// not change on the edge before the capturing edge.
	reg [63:0] sq_prev;
	reg sq_chg1 = 1'b0, sq_chg2 = 1'b0;
	always @(posedge CLK) begin
		sq_prev <= RAM_SQ;
		sq_chg1 <= RAM_SQ !== sq_prev;
		sq_chg2 <= sq_chg1;
		if (COPY_STATE == 3'd3 && !COPY_DDR && RST_N)
			assert (!sq_chg2) else $fatal(1,"FG copy RAM word changed one clock before the byte capture");
	end
`endif
	
	bit RDY_FF=1'b1;
	bit RDY_RAS_N_OLD, RDY_SC_OLD;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin RDY_RAS_N_OLD <= 1; RDY_SC_OLD <= 0; end
		else begin RDY_RAS_N_OLD <= RAS_N_M; RDY_SC_OLD <= SC_M; end
	end
	bit RDY_NEXT_MRT_EXEC;
	bit RDY_NEXT_RMT_EXEC;
	bit RDY_NEXT_RMT_PENDING;
	bit RDY_NEXT_SR_MRT;
	bit [7:0] RDY_NEXT_SR_WE;
	bit RDY_NEXT_SR_MRT2;
	bit [7:0] RDY_NEXT_SR_WE2;
	bit RDY_NEXT_UNALIGNED_EXEC;
	bit RDY_NEXT_COPY_WE;
	bit RDY_NEXT_CPU_RAM_WE;
	bit RDY_NEXT_CPU_RAM_WE2;
	logic RDY_NEXT_READ_DDR_R;
	logic [2:0] RDY_NEXT_COPY_STATE;
		logic HOLE_NEXT_CPU_COPY_MODE, HOLE_NEXT_SREG_POS_5, HOLE_NEXT_SREG_POS_8, HOLE_NEXT_COPY_ADDR_5;
		logic [8:0] HOLE_NEXT_POS; logic [7:0] HOLE_NEXT_ROW; logic [17:0] HOLE_NEXT_ADDR, HOLE_NEXT_ADDR_N;
	always_comb begin
		
		
		
				RDY_NEXT_MRT_EXEC = MRT_EXEC;
		RDY_NEXT_RMT_EXEC = RMT_EXEC;
		RDY_NEXT_RMT_PENDING = RMT_PENDING;
		RDY_NEXT_SR_MRT = SR_MRT;
		RDY_NEXT_SR_WE = SR_WE;
		RDY_NEXT_SR_MRT2 = SR_MRT2;
		RDY_NEXT_SR_WE2 = SR_WE2;
		RDY_NEXT_UNALIGNED_EXEC = UNALIGNED_EXEC;
		RDY_NEXT_COPY_WE = COPY_WE;
		RDY_NEXT_CPU_RAM_WE = CPU_RAM_WE;
		RDY_NEXT_CPU_RAM_WE2 = CPU_RAM_WE2;
		RDY_NEXT_READ_DDR_R = READ_DDR_R;
		RDY_NEXT_COPY_STATE = COPY_STATE;
		HOLE_NEXT_CPU_COPY_MODE = CPU_COPY_MODE;
		HOLE_NEXT_SREG_POS_5 = SREG_POS[5];
		HOLE_NEXT_SREG_POS_8 = SREG_POS[8];
		HOLE_NEXT_COPY_ADDR_5 = COPY_ADDR[5];
		HOLE_NEXT_POS = SREG_POS; HOLE_NEXT_ROW = MEM_ROW; HOLE_NEXT_ADDR = COPY_ADDR; HOLE_NEXT_ADDR_N = COPY_ADDR_N;
		if (!RST_N) begin
			;
			;
			;
			;
			RDY_NEXT_MRT_EXEC = 0;
			RDY_NEXT_RMT_EXEC = 0;
			;
			;
			begin HOLE_NEXT_SREG_POS_5 = 1'b0; HOLE_NEXT_SREG_POS_8 = 1'b0; end HOLE_NEXT_POS = 9'd0; HOLE_NEXT_ROW = 8'd0;
			RDY_NEXT_SR_WE = '0;
			;
			RDY_NEXT_SR_MRT = 0;
			HOLE_NEXT_CPU_COPY_MODE = 0;
			RDY_NEXT_RMT_PENDING = 0;
			RDY_NEXT_UNALIGNED_EXEC = 0;
			;
			HOLE_NEXT_COPY_ADDR_5 = 1'b0; HOLE_NEXT_ADDR = 18'd0; HOLE_NEXT_ADDR_N = 18'd1;
			;
			;
			;
			;
			RDY_NEXT_READ_DDR_R = 0;
			;
			;
			;
			begin RDY_NEXT_COPY_STATE = '0; ; end
			;
			;
			RDY_NEXT_COPY_WE = 0;
			;
			;
			;
			RDY_NEXT_CPU_RAM_WE = 0;
			;
			;
			;
			RDY_NEXT_CPU_RAM_WE2 = 0;
			;
			;
			;
			;
			RDY_NEXT_SR_WE2 = '0;
			RDY_NEXT_SR_MRT2 = 0;

		end else begin
			// The shared CPU shift cache and the shift-register RAM return a
			// wide word two clocks after the address (address register, then
			// the M10K output register). Keep the destination and write strobe
			// on the same two-clock pipeline.
			;
			for (integer b = 0; b < 4; b = b + 1) ;
			RDY_NEXT_CPU_RAM_WE = RAM_SWE;
			;
			;
			;
			RDY_NEXT_CPU_RAM_WE2 = CPU_RAM_WE;
			;
			;
			;
			;
			RDY_NEXT_SR_WE2 = SR_WE;
			RDY_NEXT_SR_MRT2 = SR_MRT;
			;

			RDY_NEXT_RMT_PENDING = RMT_EXEC;
			RDY_NEXT_COPY_WE = 0;
			;
			;
			if (!RAS_N_M && RDY_RAS_N_OLD) begin
				RDY_NEXT_MRT_EXEC = 0;
				RDY_NEXT_RMT_EXEC = 0;
				RDY_NEXT_UNALIGNED_EXEC = 0;
				;
				RDY_NEXT_READ_DDR_R = 0;
				;
				if (!OE_N_M && WE_N_M && TRANSFER_M) begin
					HOLE_NEXT_CPU_COPY_MODE = CPU_SHIFT_M;
					;
					;
					if (!CPU_SHIFT_M) ;
					RDY_NEXT_MRT_EXEC = !CPU_SHIFT_M;
					RDY_NEXT_UNALIGNED_EXEC = CPU_SHIFT_M;
					;
					HOLE_NEXT_COPY_ADDR_5 = A_M[5]; HOLE_NEXT_ADDR = A_M; HOLE_NEXT_ADDR_N = A_M + 18'd1; HOLE_NEXT_ROW = A_M[17:10];
					;
					;
					;
					RDY_NEXT_READ_DDR_R = CPU_SHIFT_M && |A_M[9:8];
					;
					;
					;
					;
					begin RDY_NEXT_COPY_STATE = '0; ; end
					;
					begin HOLE_NEXT_SREG_POS_5 = 1'b0; HOLE_NEXT_SREG_POS_8 = 1'b0; end HOLE_NEXT_POS = 9'd0;
					if (!CPU_SHIFT_M) begin
						;
						;
						;
					end
				end else if (!OE_N_M && !WE_N_M && TRANSFER_M) begin
					HOLE_NEXT_CPU_COPY_MODE = CPU_SHIFT_M;
					;
					;
					if (!CPU_SHIFT_M) ;
					RDY_NEXT_RMT_EXEC = !SE_N_M;
					begin HOLE_NEXT_SREG_POS_5 = 1'b0; HOLE_NEXT_SREG_POS_8 = 1'b0; end HOLE_NEXT_POS = 9'd0; HOLE_NEXT_ROW = A_M[17:10];
					if (!CPU_SHIFT_M) begin
						;
						;
					end
				end
			end
			
			RDY_NEXT_SR_WE = '0;
			if (SC_M && !RDY_SC_OLD && SIM) begin
				;
				if (!SE_N_M)
					case (MEM_COL[2:0])
						3'd0: RDY_NEXT_SR_WE = 8'h01;
						3'd1: RDY_NEXT_SR_WE = 8'h02;
						3'd2: RDY_NEXT_SR_WE = 8'h04;
						3'd3: RDY_NEXT_SR_WE = 8'h08;
						3'd4: RDY_NEXT_SR_WE = 8'h10;
						3'd5: RDY_NEXT_SR_WE = 8'h20;
						3'd6: RDY_NEXT_SR_WE = 8'h40;
						3'd7: RDY_NEXT_SR_WE = 8'h80;
					endcase
				;
//				if (MEM_COL == 8'hFF) ;
			end
			if (SC_M && !RDY_SC_OLD && SOM) begin
				;
				;
			end
			
			RDY_NEXT_SR_MRT = 0;
			if (MRT_EXEC || (RMT_EXEC && (!CPU_COPY_MODE || !SREG_POS[8]))) begin
				;
				RDY_NEXT_SR_WE = {8{MRT_EXEC}};
				RDY_NEXT_SR_MRT = MRT_EXEC;
				
				begin HOLE_NEXT_SREG_POS_5 = SREG_POS[5] ^ (&SREG_POS[4:3]); HOLE_NEXT_SREG_POS_8 = SREG_POS[8] ^ (&SREG_POS[7:3]); HOLE_NEXT_POS = SREG_POS + 9'h8; end
				if (SREG_POS == 9'h1F8) begin
					RDY_NEXT_MRT_EXEC = 0;
					RDY_NEXT_RMT_EXEC = 0;
				end
			end
			// A CPU write copies all 512 drawing bytes. The second half is DDR
			// backed; each word retains the CPU's two separated byte lanes.
			if (RMT_EXEC && CPU_COPY_MODE && SREG_POS[8]) begin
				case (RMT_DDR_STATE)
					2'd0: if (MEM_CE && CPU_CACHE_READY) ;
					2'd1: if (HOLE_RDY) ;
					2'd2: begin
						begin HOLE_NEXT_SREG_POS_5 = SREG_POS[5] ^ (FAST_UPPER ? &SREG_POS[4:2] : &SREG_POS[4:1]); HOLE_NEXT_SREG_POS_8 = SREG_POS[8] ^ (FAST_UPPER ? &SREG_POS[7:2] : &SREG_POS[7:1]); HOLE_NEXT_POS = SREG_POS + DDR_STEP; end
						;
						if (SREG_POS == DDR_END) RDY_NEXT_RMT_EXEC = 0;
					end
				endcase
			end
			// CPU reads gather the complete logical row, including DDR-backed
			// off-screen drawing columns and upper halves. Video stays local.
			if (UNALIGNED_EXEC) begin
				case (COPY_STATE)
					2'd0: begin
						if (COPY_DDR) begin
							if (MEM_CE) begin RDY_NEXT_COPY_STATE = 2'd2; ; end
						end else begin RDY_NEXT_COPY_STATE = 2'd1; ; end
					end
					2'd1: begin RDY_NEXT_COPY_STATE = COPY_PRE ? 3'd3 : 3'd5; ; end // address register settles (output register too unless prefetched)
					3'd5: begin RDY_NEXT_COPY_STATE = 3'd3; ; end // RAM output register settles
					2'd2: if (HOLE_RDY) begin RDY_NEXT_COPY_STATE = 3'd4; ; end
					3'd4: begin RDY_NEXT_COPY_STATE = 3'd3; ; end // registered DDR result settles
					2'd3: begin : collect_copy_byte
						// Existing exact COPY_ADDR + 1 shadow.
						RDY_NEXT_READ_DDR_R = |COPY_ADDR_N[9:8] && !(&COPY_POS);
						if (COPY_POS_OH[7]) begin
							;
							RDY_NEXT_COPY_WE = 1;
						end
						;
						HOLE_NEXT_COPY_ADDR_5 = COPY_ADDR_N[5]; HOLE_NEXT_ADDR = COPY_ADDR_N; HOLE_NEXT_ADDR_N = COPY_ADDR_N + 18'd1;
						;
						;
						begin RDY_NEXT_COPY_STATE = 2'd0; ; end
						if (&COPY_POS) begin
							RDY_NEXT_UNALIGNED_EXEC = 0;
							;
						end
					end
				endcase
			end
		end
	end

	// Same-D state predecode for ready only: no old-Q pipeline or extra
	// consumer edge. Restart is followed by the original collect priority.
	(* preserve, dont_merge *) bit RDY_COPY_COLLECT;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) RDY_COPY_COLLECT <= 1'b0;
		else RDY_COPY_COLLECT <= RDY_NEXT_COPY_STATE == 3'd3;
	end
	wire RDY_LOCAL_START_RAS = !RAS_N_M && RDY_RAS_N_OLD;
	wire RDY_LOCAL_START_READ = COPY_READ_REQUEST_M[7] && RDY_RAS_N_OLD;
	wire RDY_LOCAL_UNALIGNED_NEXT = ((UNALIGNED_EXEC && !RDY_LOCAL_START_RAS) ||
		(RDY_LOCAL_START_READ && CPU_SHIFT_M)) && !(UNALIGNED_EXEC && RDY_COPY_COLLECT && (&COPY_POS));
	wire RDY_LOCAL_COPY_WE = UNALIGNED_EXEC && RDY_COPY_COLLECT && COPY_POS_OH[7];
	// Capture the complete next ready predicate on the existing MEM edge.
	// The final write pair simplifies exactly to COPY_WE OR reduction(SR_WE2).
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) RDY_FF <= 1'b1;
		else RDY_FF <= ~(RDY_NEXT_MRT_EXEC | RDY_NEXT_RMT_EXEC | RDY_NEXT_RMT_PENDING | (RDY_NEXT_SR_MRT && |RDY_NEXT_SR_WE) | (RDY_NEXT_SR_MRT2 && |RDY_NEXT_SR_WE2) | RDY_LOCAL_UNALIGNED_NEXT | RDY_LOCAL_COPY_WE | RDY_NEXT_CPU_RAM_WE | RDY_NEXT_CPU_RAM_WE2 | COPY_WE | (|SR_WE2));
	end
	always @(posedge CLK or negedge RST_N) begin
		bit        RAS_N_OLD;
		bit        SC_OLD;
		
		if (!RST_N) begin
			RAS_N_OLD <= 1;
			SC_OLD <= 0;
			MEM_ROW <= '0;
			MEM_COL <= '0;
			MRT_EXEC <= 0;
			RMT_EXEC <= 0;
			SIM <= 0;
			SOM <= 0;
			SREG_POS <= '0;
			SR_WE <= '0;
			SR_RA <= '0;
			SR_MRT <= 0;
			CPU_COPY_MODE <= 0;
			RMT_PENDING <= 0;
			UNALIGNED_EXEC <= 0;
			UNALIGNED_B <= '0;
			COPY_ADDR <= '0;
			COPY_PRE <= 0;
			COPY_POS <= '0;
			COPY_DDR <= 0;
			COPY_DDR_CHUNK <= '0;
			READ_DDR_R <= 0;
			COPY_ODD <= 0;
			COPY_LANE <= 8'd1;
			COPY_LANE_BIN <= 3'd0;
			COPY_LANE_BIN8 <= '0;
			COPY_POS_OH <= 8'd1;
			begin COPY_STATE <= '0; COPY_PREFETCH_B <= {4{('0) == 3'd3}}; end
			COPY_WA <= '0;
			COPY_WE <= 0;
			RMT_DDR_STATE <= 0;
			CPU_RAM_A <= '0;
			CPU_RAM_A_B <= '0;
			CPU_RAM_WE <= 0;
			CPU_RAM_WE_B <= '0;
			CPU_RAM_A2 <= '0;
			CPU_RAM_A_B2 <= '0;
			CPU_RAM_WE2 <= 0;
			CPU_RAM_WE_B2 <= '0;
			CPU_RAM_WREN_B2 <= '0;
			CPU_RAM_WREN_SEG_B2 <= '0;
			CPU_COPY_MODE_B <= '0;
			CPU_CACHE_A <= 0;
			CPU_CACHE_A2 <= 0;
			SR_WE2 <= '0;
			SR_MRT2 <= 0;

		end else begin
			// The shared CPU shift cache and the shift-register RAM return a
			// wide word two clocks after the address (address register, then
			// the M10K output register). Keep the destination and write strobe
			// on the same two-clock pipeline.
			CPU_RAM_A <= RAM_SA;
			for (integer b = 0; b < 4; b = b + 1) CPU_RAM_A_B[b] <= RAM_SA;
			CPU_RAM_WE <= RAM_SWE;
			CPU_RAM_WE_B <= {4{RAM_SWE}};
			CPU_RAM_A2 <= CPU_RAM_A;
			CPU_RAM_A_B2 <= CPU_RAM_A_B;
			CPU_RAM_WE2 <= CPU_RAM_WE;
			CPU_RAM_WE_B2 <= CPU_RAM_WE_B;
			for (integer b = 0; b < 4; b = b + 1) begin
				CPU_RAM_WREN_B2[b] <= CPU_RAM_WE_B[b] && CPU_RAM_A_B[b][12:11] == b;
				for (integer s = 0; s < 4; s = s + 1)
					CPU_RAM_WREN_SEG_B2[b][s] <= CPU_RAM_WE_B[b] && CPU_RAM_A_B[b][12:11] == b && CPU_RAM_A_B[b][10:9] == s;
			end
			CPU_CACHE_A <= CPU_SHIFT_A;
			CPU_CACHE_A2 <= CPU_CACHE_A;
			SR_WA2 <= SR_WA;
			SR_WE2 <= SR_WE;
			SR_MRT2 <= SR_MRT;
			SD_M2 <= SD_M;

			RMT_PENDING <= RMT_EXEC;
			COPY_WE <= 0;
			RAS_N_OLD <= RAS_N_M;
			SC_OLD <= SC_M;
			if (!RAS_N_M && RAS_N_OLD) begin
				MRT_EXEC <= 0;
				RMT_EXEC <= 0;
				UNALIGNED_EXEC <= 0;
				UNALIGNED_B <= '0;
				READ_DDR_R <= 0;
				RMT_DDR_STATE <= 0;
				if (!OE_N_M && WE_N_M && TRANSFER_M) begin
					CPU_COPY_MODE <= CPU_SHIFT_M;
					CPU_COPY_MODE_B <= {4{CPU_SHIFT_M}};
					MEM_ROW <= A_M[17:10];
					if (!CPU_SHIFT_M) MEM_COL <= A_M[8:0];
					MRT_EXEC <= !CPU_SHIFT_M;
					UNALIGNED_EXEC <= CPU_SHIFT_M;
					UNALIGNED_B <= {4{CPU_SHIFT_M}};
					COPY_ADDR <= A_M;
					COPY_PRE <= 0;
					COPY_DDR <= |A_M[9:8];
					COPY_DDR_CHUNK <= {4{|A_M[9:8]}};
					READ_DDR_R <= CPU_SHIFT_M && |A_M[9:8];
					COPY_ODD <= A_M[0];
					COPY_LANE <= 8'd1 << A_M[2:0];
					COPY_LANE_BIN <= A_M[2:0];
					COPY_LANE_BIN8 <= {8{A_M[2:0]}};
					COPY_POS <= '0;
					COPY_POS_OH <= 8'd1;
					begin COPY_STATE <= '0; COPY_PREFETCH_B <= {4{('0) == 3'd3}}; end
					SREG_POS <= '0;
					if (!CPU_SHIFT_M) begin
						SIM <= 0;
						SOM <= 1;
						SR_RA <= A_M[8:0];
					end
				end else if (!OE_N_M && !WE_N_M && TRANSFER_M) begin
					CPU_COPY_MODE <= CPU_SHIFT_M;
					CPU_COPY_MODE_B <= {4{CPU_SHIFT_M}};
					MEM_ROW <= A_M[17:10];
					if (!CPU_SHIFT_M) MEM_COL <= A_M[8:0];
					RMT_EXEC <= !SE_N_M;
					SREG_POS <= '0;
					if (!CPU_SHIFT_M) begin
						SIM <= 1;
						SOM <= 0;
					end
				end
			end
			
			SR_WE <= '0;
			if (SC_M && !SC_OLD && SIM) begin
				SR_WA <= MEM_COL;
				if (!SE_N_M)
					case (MEM_COL[2:0])
						3'd0: SR_WE <= 8'h01;
						3'd1: SR_WE <= 8'h02;
						3'd2: SR_WE <= 8'h04;
						3'd3: SR_WE <= 8'h08;
						3'd4: SR_WE <= 8'h10;
						3'd5: SR_WE <= 8'h20;
						3'd6: SR_WE <= 8'h40;
						3'd7: SR_WE <= 8'h80;
					endcase
				MEM_COL <= MEM_COL + 8'h1;
//				if (MEM_COL == 8'hFF) SIM <= 0;
			end
			if (SC_M && !SC_OLD && SOM) begin
				MEM_COL <= MEM_COL + 8'h1;
				SR_RA <= {SR_RA[8],SR_RA[7:0] + 8'h1};
			end
			
			SR_MRT <= 0;
			if (MRT_EXEC || (RMT_EXEC && (!CPU_COPY_MODE || !SREG_POS[8]))) begin
				SR_WA <= SREG_POS;
				SR_WE <= {8{MRT_EXEC}};
				SR_MRT <= MRT_EXEC;
				
				SREG_POS <= SREG_POS + 9'h8;
				if (SREG_POS == 9'h1F8) begin
					MRT_EXEC <= 0;
					RMT_EXEC <= 0;
				end
			end
			// A CPU write copies all 512 drawing bytes. The second half is DDR
			// backed; each word retains the CPU's two separated byte lanes.
			if (RMT_EXEC && CPU_COPY_MODE && SREG_POS[8]) begin
				case (RMT_DDR_STATE)
					// FAST_UPPER: each beat-aligned position issues both pairs of its
					// half-word as one 64-bit beat and waits for completion.
					2'd0: if (FAST_UPPER ? CPU_CACHE_READY : (MEM_CE && CPU_CACHE_READY))
						RMT_DDR_STATE <= 2'd1;
					2'd1: if (FAST_UPPER ? FAST_DONE : HOLE_RDY) RMT_DDR_STATE <= 2'd2;
					2'd2: begin
						SREG_POS <= SREG_POS + DDR_STEP;
						RMT_DDR_STATE <= 0;
						if (SREG_POS == DDR_END) RMT_EXEC <= 0;
					end
				endcase
			end
			// CPU reads gather the complete logical row, including DDR-backed
			// off-screen drawing columns and upper halves. Video stays local.
			if (UNALIGNED_EXEC) begin
				case (COPY_STATE)
					2'd0: begin
						if (COPY_DDR) begin
							if (MEM_CE) begin COPY_STATE <= 2'd2; COPY_PREFETCH_B <= {4{(2'd2) == 3'd3}}; end
						end else begin COPY_STATE <= 2'd1; COPY_PREFETCH_B <= {4{(2'd1) == 3'd3}}; end
					end
					2'd1: begin COPY_STATE <= COPY_PRE ? 3'd3 : 3'd5; COPY_PREFETCH_B <= {4{(COPY_PRE ? 3'd3 : 3'd5) == 3'd3}}; end // address register settles (output register too unless prefetched)
					3'd5: begin COPY_STATE <= 3'd3; COPY_PREFETCH_B <= {4{(3'd3) == 3'd3}}; end // RAM output register settles
					2'd2: if (HOLE_RDY) begin COPY_STATE <= 3'd4; COPY_PREFETCH_B <= {4{(3'd4) == 3'd3}}; end
					3'd4: begin COPY_STATE <= 3'd3; COPY_PREFETCH_B <= {4{(3'd3) == 3'd3}}; end // registered DDR result settles
					2'd3: begin : collect_copy_byte
						logic [17:0] next_addr;
						next_addr = COPY_ADDR + 18'd1;
						COPY_DDR <= |next_addr[9:8];
						COPY_DDR_CHUNK <= {4{|next_addr[9:8]}};
						READ_DDR_R <= |next_addr[9:8] && !(&COPY_POS);
						COPY_ODD <= next_addr[0];
						COPY_LANE <= {COPY_LANE[6:0], COPY_LANE[7]};
						COPY_LANE_BIN <= COPY_LANE_BIN + 3'd1;
						for (integer j = 0; j < 8; j = j + 1) COPY_LANE_BIN8[j] <= COPY_LANE_BIN8[j] + 3'd1;
						COPY_POS_OH <= {COPY_POS_OH[6:0], COPY_POS_OH[7]};
						if (COPY_POS_OH[7]) begin
							COPY_WA <= COPY_POS[8:3];
							COPY_WE <= 1;
						end
						COPY_POS <= COPY_POS + 9'd1;
						COPY_ADDR <= COPY_ADDR + 18'd1;
						COPY_PRE <= !(|next_addr[9:8]);
						begin COPY_STATE <= 2'd0; COPY_PREFETCH_B <= {4{(2'd0) == 3'd3}}; end
						if (&COPY_POS) begin
							UNALIGNED_EXEC <= 0;
							UNALIGNED_B <= '0;
						end
					end
				endcase
			end
		end
	end
	// COPY_PREFETCH_B is captured from the original state D expression, so each
	// local pair sees state 3 on the original collect edge. Keep the capture
	// control beside its 16 data bits instead of sharing the wide state decode.
	// RDY_RAS_N_OLD has the same reset and RAS_N_M capture as RAS_N_OLD above.
	wire COPY_WORD_START = !RAS_N_M && RDY_RAS_N_OLD && !OE_N_M && WE_N_M && TRANSFER_M;
	genvar copy_word_bank;
	generate for (copy_word_bank = 0; copy_word_bank < 4; copy_word_bank = copy_word_bank + 1) begin : copy_word_pair
		(* keep *) wire collect = UNALIGNED_B[copy_word_bank] && COPY_PREFETCH_B[copy_word_bank];
		always @(posedge CLK or negedge RST_N) begin
			if (!RST_N) COPY_WORD[copy_word_bank*16 +: 16] <= '0;
			else begin
				if (COPY_WORD_START) COPY_WORD[copy_word_bank*16 +: 16] <= '0;
				// The original later collect assignment wins for its selected byte
				// when a new transfer and the old byte capture occur together.
				for (integer byte_index = 0; byte_index < 2; byte_index = byte_index + 1)
					if (collect && COPY_POS_OH[copy_word_bank*2 + byte_index])
						COPY_WORD[(copy_word_bank*2 + byte_index)*8 +: 8] <= COPY_DDR_CHUNK[copy_word_bank] ? COPY_DDR_BYTE : COPY_RAM_BYTE;
			end
		end
	end endgenerate
	assign RAM_SA = UNALIGNED_EXEC ? {COPY_ADDR[17:10],COPY_ADDR[7:3]} :
	                              {MEM_ROW,SREG_POS[7:3]};
	wire RMT_DDR = RMT_EXEC && CPU_COPY_MODE && SREG_POS[8];
	// At each new cache word, wait for its registered read before requesting
	// DDR. Hold the same payload until the controller acknowledges that write.
	wire CPU_CACHE_READY = CPU_CACHE_A2 == SREG_POS[8:3] && CPU_PAIR_POS == SREG_POS;
	// Per-bank video serial address / copy-mode replicas (declared above).
	genvar vb;
	generate for (vb = 0; vb < 4; vb = vb + 1) begin : video_addr_track
		BT_FG_VIDEO_ADDR_TRACK #(.FAST_UPPER(FAST_UPPER)) track (
			.CLK(CLK), .RST_N(RST_N), .A_ROW(A[15:10]), .RAS_N(RAS_N), .OE_N(OE_N), .WE_N(WE_N),
			.TRANSFER(TRANSFER), .CPU_SHIFT(CPU_SHIFT), .SE_N(SE_N), .MEM_CE(MEM_CE),
			.CPU_CACHE_A(CPU_CACHE_A), .HOLE_RDY(HOLE_RDY), .FAST_DONE(FAST_DONE),
			.SADDR_V(SADDR_V_BK[vb]), .COPY_MODE(CPU_COPY_MODE_T[vb]),
			.COPY_MODE_CHUNKS(CPU_COPY_MODE_B4[vb]));
	end endgenerate
	wire READ_DDR = READ_DDR_R;
`ifndef SYNTHESIS
	always @(posedge CLK) if (RST_N) begin
		assert (COPY_DDR_CHUNK == {4{COPY_DDR}})
			else $fatal(1,"foreground local copy-owner changed capture edge");
		assert (COPY_DDR == |COPY_ADDR[9:8] && COPY_ODD == COPY_ADDR[0] &&
		        COPY_LANE == 8'd1 << COPY_ADDR[2:0] && COPY_LANE_BIN == COPY_ADDR[2:0] && COPY_LANE_BIN8 == {8{COPY_ADDR[2:0]}} && COPY_POS_OH == 8'd1 << COPY_POS[2:0] &&
		        UNALIGNED_B == {4{UNALIGNED_EXEC}} && READ_DDR_R == (UNALIGNED_EXEC && COPY_DDR))
			else $fatal(1,"Foreground copy decode shadow diverged");
	end
`endif
	bit [15:0] RMT_PAIR;
	bit [8:0] CPU_PAIR_POS;
	always @(posedge CLK) begin
		RMT_PAIR <= CPU_SHIFT_Q[SREG_POS[2:1]*16 +: 16];
		// The wide word's address tag is from its registered read (two
		// clocks behind the position), while the pair index selects the
		// current lane within that returned word.
		CPU_PAIR_POS <= {CPU_CACHE_A2,SREG_POS[2:0]};
	end
	wire [17:0] HOLE_A_COMB = RMT_DDR ? {MEM_ROW,1'b0,SREG_POS} : COPY_ADDR;
	// The whole hole address is one register, loaded with the value HOLE_A_COMB
	// takes after this edge: the DDR tag compare starts from flops, not from the
	// RMT_DDR select and the SREG_POS/COPY_ADDR/MEM_ROW fan-in.
	bit [17:0] HOLE_A_FF = 18'd0;
	// Capture the original flag/history D at its original edge. Each six-bit
	// address group has local controls instead of the shared request decoder.
	(* preserve, dont_merge *) bit [2:0] HOLE_RMT_EXEC_B;
	(* preserve, dont_merge *) bit [2:0] COPY_ADDR_RAS_OLD_B;
	// Factor the original next-position equality at its original capture.
	// logic inputs retain X/Z through arithmetic/equality; only the returned
	// bit converts the result, exactly as the original flag assignment did.
	function automatic bit FG_POSITION_END_NEXT;
		input logic [8:0] pos;
		input logic step_ram, step_ddr, restart;
		input bit ddr_end;
		begin
			if (step_ddr) FG_POSITION_END_NEXT = pos == (ddr_end ? DDR_END - DDR_STEP : 9'h1f8 - DDR_STEP);
			else if (step_ram) FG_POSITION_END_NEXT = pos == (ddr_end ? DDR_END - 9'd8 : 9'h1f0);
			else if (restart) FG_POSITION_END_NEXT = 1'b0;
			else FG_POSITION_END_NEXT = pos == (ddr_end ? DDR_END : 9'h1f8);
		end
	endfunction
	// Decode the original position D at the position capture edge. Each
	// packet-address group gets its own completion flags, with identical
	// zero startup and asynchronous reset to the original position.
	(* preserve, dont_merge *) bit [2:0] HOLE_POS_END_RAM_B, HOLE_POS_END_DDR_B;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin
			HOLE_RMT_EXEC_B <= '0;
			COPY_ADDR_RAS_OLD_B <= '1;
		end else begin
			HOLE_RMT_EXEC_B <= {3{RDY_NEXT_RMT_EXEC}};
			COPY_ADDR_RAS_OLD_B <= {3{RAS_N_M}};
		end
	end
	wire [17:0] COPY_ADDR_STEP_VALUE = COPY_ADDR_N + 18'd1;
	wire [17:0] COPY_ADDR_START_VALUE = A_M + 18'd1;
	genvar hole_group;
	generate for (hole_group = 0; hole_group < 3; hole_group = hole_group + 1) begin : hole_addr_local
		localparam [5:0] COPY_RESET_VALUE = 18'd1 >> (6*hole_group);
		(* keep *) wire start_ras = !HOLE_RAS_N_M[hole_group] && COPY_ADDR_RAS_OLD_B[hole_group];
		(* keep *) wire start_transfer = HOLE_TRANSFER_REQUEST_M[hole_group] && COPY_ADDR_RAS_OLD_B[hole_group];
		(* keep *) wire start_read = COPY_READ_REQUEST_M[4+hole_group] && COPY_ADDR_RAS_OLD_B[hole_group];
		(* keep *) wire start_rmt = HOLE_RMT_REQUEST_M[hole_group] && COPY_ADDR_RAS_OLD_B[hole_group];
		(* keep *) wire step_ram = MRT_EXEC ||
			(HOLE_RMT_EXEC_B[hole_group] && (!CPU_COPY_MODE_B[hole_group] || !SREG_POS[8]));
		(* keep *) wire step_ddr = HOLE_RMT_EXEC_B[hole_group] && CPU_COPY_MODE_B[hole_group] &&
			SREG_POS[8] && RMT_DDR_STATE == 2'd2;
		(* keep *) wire stop_rmt = (step_ram && HOLE_POS_END_RAM_B[hole_group]) ||
			(step_ddr && HOLE_POS_END_DDR_B[hole_group]);
		// A later transfer completion overrides a simultaneous CPU restart.
		(* keep *) wire next_rmt = ((HOLE_RMT_EXEC_B[hole_group] && !start_ras) || start_rmt) && !stop_rmt;
		wire next_copy_mode = start_transfer ? CPU_SHIFT_M : CPU_COPY_MODE_B[hole_group];
		wire [8:0] next_pos = step_ddr ? SREG_POS + DDR_STEP :
			step_ram ? SREG_POS + 9'd8 : start_transfer ? 9'd0 : SREG_POS;
		// De Morgan distributes completion masking without changing any state,
		// capture edge or four-state value. Avoid the kept stop/next-RMT cascade.
		(* keep *) wire remote_addr =
			((HOLE_RMT_EXEC_B[hole_group] && !start_ras) || start_rmt) &&
			next_copy_mode && next_pos[8] &&
			!(step_ram && HOLE_POS_END_RAM_B[hole_group]) &&
			!(step_ddr && HOLE_POS_END_DDR_B[hole_group]);
		wire [17:0] remote_value = {HOLE_NEXT_ROW,1'b0,next_pos};
		(* keep *) wire copy_advance = UNALIGNED_B[hole_group] && COPY_PREFETCH_B[hole_group];
		(* keep *) wire copy_start = start_read && !copy_advance;
		(* keep *) wire copy_hold = !start_read && !copy_advance;
		always @(posedge CLK or negedge RST_N) begin
			if (!RST_N) begin
				HOLE_A_FF[6*hole_group +: 6] <= '0;
				COPY_ADDR_N[6*hole_group +: 6] <= COPY_RESET_VALUE;
				HOLE_POS_END_RAM_B[hole_group] <= 1'b0;
				HOLE_POS_END_DDR_B[hole_group] <= 1'b0;
			end else begin
				HOLE_POS_END_RAM_B[hole_group] <= FG_POSITION_END_NEXT(SREG_POS, step_ram, step_ddr, start_transfer, 1'b0);
				HOLE_POS_END_DDR_B[hole_group] <= FG_POSITION_END_NEXT(SREG_POS, step_ram, step_ddr, start_transfer, 1'b1);
				HOLE_A_FF[6*hole_group +: 6] <=
					({6{remote_addr}} & remote_value[6*hole_group +: 6]) |
					({6{!remote_addr}} & HOLE_NEXT_ADDR[6*hole_group +: 6]);
				// The collect assignment was last in the original controller.
				COPY_ADDR_N[6*hole_group +: 6] <=
					({6{copy_advance}} & COPY_ADDR_STEP_VALUE[6*hole_group +: 6]) |
					({6{copy_start}} & COPY_ADDR_START_VALUE[6*hole_group +: 6]) |
					({6{copy_hold}} & COPY_ADDR_N[6*hole_group +: 6]);
			end
		end
`ifndef SYNTHESIS
		always @(posedge CLK) if (RST_N) begin
			assert (HOLE_RMT_EXEC_B[hole_group] == RMT_EXEC &&
			        COPY_ADDR_RAS_OLD_B[hole_group] == RDY_RAS_N_OLD)
				else $fatal(1,"foreground local flag/history changed capture edge");
			assert (HOLE_RAS_N_M[hole_group] == RAS_N_M &&
			        HOLE_TRANSFER_REQUEST_M[hole_group] == (!RAS_N_M && !OE_N_M && TRANSFER_M) &&
			        HOLE_RMT_REQUEST_M[hole_group] == (!RAS_N_M && !OE_N_M && !WE_N_M && TRANSFER_M && !SE_N_M))
				else $fatal(1,"foreground local raw command differs after capture");
			assert (HOLE_POS_END_RAM_B[hole_group] == (SREG_POS == 9'h1f8) &&
			        HOLE_POS_END_DDR_B[hole_group] == (SREG_POS == DDR_END))
				else $fatal(1,"foreground local position completion differs after capture");
			assert (next_rmt == RDY_NEXT_RMT_EXEC && next_pos == HOLE_NEXT_POS &&
			        next_copy_mode == HOLE_NEXT_CPU_COPY_MODE)
				else $fatal(1,"foreground local next-state priority differs");
		end
`endif
	end endgenerate
	assign HOLE_A = HOLE_A_FF;
`ifndef SYNTHESIS
	always @(posedge CLK) if (RST_N)
		assert (HOLE_A_FF == HOLE_A_COMB) else $fatal(1,"registered HOLE_A differs from the combinational hole address");
	always @(posedge CLK) if (RST_N) begin
		assert (SEL_DRAW_R == DRAW_WE_M && SEL_WR_R == (!DRAW_WE_M && WRITE_PENDING) && SEL_RD_R == (!DRAW_WE_M && !WRITE_PENDING))
			else $fatal(1,"registered FG port-A selects differ from the combinational selects");
		assert (BANK_LANE_WREN_R == {{2{BANK_WREN_R[3]}} & (SEL_DRAW_R ? (DRAW_ADDR_M[0] ? 2'b10 : 2'b01) : WRITE_BE),
		                             {2{BANK_WREN_R[2]}} & (SEL_DRAW_R ? (DRAW_ADDR_M[0] ? 2'b10 : 2'b01) : WRITE_BE),
		                             {2{BANK_WREN_R[1]}} & (SEL_DRAW_R ? (DRAW_ADDR_M[0] ? 2'b10 : 2'b01) : WRITE_BE),
		                             {2{BANK_WREN_R[0]}} & (SEL_DRAW_R ? (DRAW_ADDR_M[0] ? 2'b10 : 2'b01) : WRITE_BE)})
			else $fatal(1,"registered FG lane write enables differ from bank enable & byte enable");
		assert (BANK_WREN_R == (DRAW_RAM_BANK_ACTIVE_M |
		        (WRITE_PENDING ? (DRAW_WE_M ? DRAW_BANK_ACTIVE_M :
		            {|WRITE_BANK_SEL[15:12], |WRITE_BANK_SEL[11:8], |WRITE_BANK_SEL[7:4], |WRITE_BANK_SEL[3:0]}) : 4'd0)))
			else $fatal(1,"registered FG bank write enable differs from the combinational enable");
	end
`endif
	// HOLE_SEL feeds the DDR request/bank decode: hold it in one register, loaded
	// with the value READ_DDR || RMT_DDR takes after this edge.
	bit HOLE_SEL_FF = 1'b0;
	always @(posedge CLK) begin
		if (!RST_N) HOLE_SEL_FF <= 1'b0;
		else HOLE_SEL_FF <= RDY_NEXT_READ_DDR_R || (RDY_NEXT_RMT_EXEC && HOLE_NEXT_CPU_COPY_MODE && HOLE_NEXT_SREG_POS_8);
	end
	assign HOLE_SEL = HOLE_SEL_FF;
`ifndef SYNTHESIS
	always @(posedge CLK) if (RST_N)
		assert (HOLE_SEL_FF == (READ_DDR || RMT_DDR)) else $fatal(1,"registered HOLE_SEL differs from READ_DDR || RMT_DDR");
`endif
	// Capture the exact existing predicate at its flag-update edge.
	bit HOLE_RD_FF = 1'b0;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) HOLE_RD_FF <= 1'b0;
		else HOLE_RD_FF <= RDY_NEXT_READ_DDR_R && RDY_NEXT_COPY_STATE == 3'd0;
	end
	assign HOLE_RD = HOLE_RD_FF;
	// DDR captures the payload after the request edge, on a later MEM_CE.
	assign HOLE_WE = !FAST_UPPER && RMT_DDR && RMT_DDR_STATE != 2 && CPU_CACHE_READY ? 4'b0101 : 4'b0000;
	// Both pairs of the current 32-bit half of the shift-register word.
	bit [31:0] RMT_QUAD;
	always @(posedge CLK) RMT_QUAD <= CPU_SHIFT_Q[SREG_POS[2]*32 +: 32];
	assign FAST_WE = FAST_UPPER && RMT_DDR && RMT_DDR_STATE == 2'd1;
	assign FAST_WORD = {MEM_ROW,1'b0,SREG_POS[8:2],1'b0};
	// Lower DDR address (even word) occupies the upper 32 bits, as in ddram's
	// single-word byte-enable mapping.
	assign FAST_DATA = {8'b0,RMT_QUAD[15:8],8'b0,RMT_QUAD[7:0],8'b0,RMT_QUAD[31:24],8'b0,RMT_QUAD[23:16]};
	assign HOLE_DATA = {8'b0,RMT_PAIR[15:8],8'b0,RMT_PAIR[7:0]};
	assign RAM_SWE = RMT_EXEC && !SREG_POS[8];
	// The sprite cache read leaves through the M10K output register (two clocks).
	// In the DDR half a pair completes in RMT_DDR_STATE 2 and SREG_POS then steps
	// by two; present the stepped position's word one clock early so each word
	// crossing is ready at the same memory-clock alignment as before.
	wire [8:0] SHIFT_POS = (RMT_DDR && RMT_DDR_STATE == 2'd2) ? SREG_POS + DDR_STEP : SREG_POS;
	assign CPU_SHIFT_A = SHIFT_POS[8:3];
	assign CPU_SHIFT_RD = CPU_COPY_MODE && RMT_EXEC;
	// Register the packet at the module boundary: the banked-RAM serial mux and
	// the far-away sprite packet capture no longer share one memory cycle. RDY
	// stays low until this stage drains, so completion timing is preserved.
	bit [ 5: 0]  CPU_SHIFT_WA_Q;
	bit [63: 0]  CPU_SHIFT_DATA_Q;
	wire [63: 0] SQ_D;   // serial word with the copy-word case already gated out
	bit          CPU_SHIFT_WE_Q;
	always @(posedge CLK) begin
		CPU_SHIFT_WA_Q <= COPY_WE ? COPY_WA : SR_WA2[8:3];
		CPU_SHIFT_DATA_Q <= SQ_D | (COPY_WORD & {64{COPY_WE}});
	end
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) CPU_SHIFT_WE_Q <= 0;
		else CPU_SHIFT_WE_Q <= COPY_WE || (CPU_COPY_MODE && SR_MRT2 && |SR_WE2);
	end
	assign CPU_SHIFT_WA = CPU_SHIFT_WA_Q;
	assign CPU_SHIFT_DATA = CPU_SHIFT_DATA_Q;
	assign CPU_SHIFT_SOURCE_D = SQ_D | (COPY_WORD & {64{COPY_WE}});
	assign CPU_SHIFT_WE = CPU_SHIFT_WE_Q;
	
	// Shift-register writes are registered once more, after the bank RAM's
	// output register: the banked-RAM serial mux and the shift-register RAM
	// input never share one memory cycle. RDY stays low until the delayed
	// write lands.
	bit [ 5: 0] SRW_A;
	bit [63: 0] SRW_D;
	bit [ 7: 0] SRW_E;
	always @(posedge CLK) begin
		SRW_A <= SR_WA2[8:3];
		SRW_D <= SR_MRT2 ? RAM_SQ : {8{SD_M2}};
	end
	always @(posedge CLK or negedge RST_N) begin
		// CPU copies share bitmap memory, but never replace or redirect video's register.
		if (!RST_N) SRW_E <= '0;
		else SRW_E <= CPU_COPY_MODE && SR_MRT2 ? 8'b0 : SR_WE2;
	end
	// The shift-register RAM read also leaves through its output register.
	VRAM_SHIFTREG #(9,1,1) shiftreg
	(
		.CLK(CLK),
		.ACLR(~RST_N),
		.WADDR(SRW_A),
		.DATA(SRW_D),
		.WREN(SRW_E),
		.RADDR(RMT_EXEC && !CPU_COPY_MODE ? SREG_POS[8:3] : SR_RA[8:3]),
		.Q(SR_Q)
	);
	
	// The serial byte changes once per two pixels. Pipeline the wide cache
	// lookup and byte selection before the system-clock priority mixer.

	wire [63:0] VIDEO_WORD = SR_Q;
	bit [2:0] VIDEO_LANE, VIDEO_LANE2;
	bit [7:0] VIDEO_LANE_OH2;   // one-hot VIDEO_LANE2
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin
			VIDEO_LANE <= '0;
			VIDEO_LANE2 <= '0;
			VIDEO_LANE_OH2 <= 8'd1;
			SQ <= '0;
		end else begin
			VIDEO_LANE <= SR_RA[2:0];
			VIDEO_LANE2 <= VIDEO_LANE;
			VIDEO_LANE_OH2 <= 8'd1 << VIDEO_LANE;
			SQ <= ({8{VIDEO_LANE_OH2[0]}} & VIDEO_WORD[ 7: 0]) | ({8{VIDEO_LANE_OH2[1]}} & VIDEO_WORD[15: 8]) |
			      ({8{VIDEO_LANE_OH2[2]}} & VIDEO_WORD[23:16]) | ({8{VIDEO_LANE_OH2[3]}} & VIDEO_WORD[31:24]) |
			      ({8{VIDEO_LANE_OH2[4]}} & VIDEO_WORD[39:32]) | ({8{VIDEO_LANE_OH2[5]}} & VIDEO_WORD[47:40]) |
			      ({8{VIDEO_LANE_OH2[6]}} & VIDEO_WORD[55:48]) | ({8{VIDEO_LANE_OH2[7]}} & VIDEO_WORD[63:56]);
		end
	end

	// Include the delayed final shift-register write in transfer completion.
	// Same-edge next-value capture preserves the existing completion and CE_F
	// contract while removing the wide flag reduction after the MEM register.
	assign RDY = RDY_FF;


`ifndef SYNTHESIS
    always @(negedge CLK) if (RST_N)
        assert (COPY_PREFETCH_B == {4{COPY_STATE == 3'd3}})
            else $fatal(1,"Foreground local prefetch shadow diverged");
`endif
endmodule

// Four 16 Kbyte banks use the mixed-width bit-sliced RAM leaf; the serial
// read retains the leaf's output register. Each four producer-side one-hot
// write strobes selects one larger bank. The CPU read-bank selector latches
// with the leaf address register, the serial one a clock later with its
// output register.
module BT_FG_BANKED_VRAM #(parameter QA_REG = 0, parameter COPY_PREFETCH_LOCAL = 0, parameter BANK_WRITE_PREDECODED = 0, parameter SERIAL_SEGMENT_PRE = 0, parameter REGISTERED_FG_BANK_Q = 0) (
    input CLK,
    input [15:1] ADDR,
    input [3:0][15:1] ADDR_B,
    input [3:0][15:0] DATA_B,
    input [15:0] DATA, BANK_WREN,
    input [1:0] BE,
    output logic [15:0] Q,
    // Serial port: per-bank copies of the write strobe and copy-mode select
    // keep each bank's address/data mux local.
    input [15:3] SADDR_W, SADDR_C, SADDR_V,
    input [3:0][12:0] SADDR_WB,
    input [3:0] SRSEL, SWSEL, SWREN_B,
    input [63:0] SDATA_C, SDATA_S,
    input [3:0] SCSEL,
    input [3:0][3:0] SCSEL4,
    output logic [63:0] SQ,
    // SQ with every bank gated off while a copy word is being written out:
    // the following mux with the copy word then needs no select.
    output logic [63:0] SQ_D,
    input COPY_WE_NEXT,
    input [15:3] SADDR_CN,
    input [3:0][10:0] SADDR_VB, SADDR_CB, SADDR_CNB,
    input [3:0] COPY_PREFETCH_B,
    input [3:0] BANK_WREN_PRE,
    input [3:0][1:0] BANK_LANE_WREN_PRE,
    input [3:0][3:0] SWREN_SEG_B,
    input [3:0][63:0] SDATA_CB
);
    wire [15:3] SADDR = SWSEL[0] ? SADDR_W : SRSEL[0] ? (COPY_PREFETCH_LOCAL && COPY_PREFETCH_B[0] ? SADDR_CN : SADDR_C) : SADDR_V;
    wire [3:0][15:0] bank_q;
    wire [3:0][63:0] bank_sq;
    logic [15:0] selected_q;
    logic [15:0] registered_q=0;
    generate if (QA_REG) begin : post_mux_qa
        always @(posedge CLK) registered_q <= selected_q;
        assign Q=registered_q;
    end else begin : raw_qa
        assign Q=selected_q;
    end endgenerate
    reg [3:0] serial_bank=4'b1, serial_bank2=4'b1, serial_bank2_nc=4'b1;
    always @(posedge CLK) begin
        serial_bank <= 4'b1 << SADDR[15:14];
        serial_bank2 <= serial_bank;
        serial_bank2_nc <= serial_bank & {4{!COPY_WE_NEXT}};
    end
    genvar bank;
    generate for (bank=0;bank<4;bank=bank+1) begin : banks
        wire [63:0] bank_cpu_data = REGISTERED_FG_BANK_Q ? SDATA_CB[bank] : SDATA_C;
        VRAM_MEM_64Kx8 #(.ADDR_WIDTH(14), .SQ_REG(1), .QA_REG(0), .SERIAL_WRITE_DECODE(1), .LANE_WREN_PRE(BANK_WRITE_PREDECODED), .QSEL_EN(1), .SERIAL_SEGMENT_PRE(SERIAL_SEGMENT_PRE)) ram (
            .QGATE_D(ADDR[15:14] == bank),
            .WREN_LANE(BANK_LANE_WREN_PRE[bank]), .CLK(CLK),.ADDR(ADDR_B[bank][13:1]),.DATA(DATA_B[bank]),.WREN(BANK_WRITE_PREDECODED ? BANK_WREN_PRE[bank] : |BANK_WREN[bank*4 +: 4]),.BE(BE),.Q(bank_q[bank]),
            .SADDR(SWSEL[bank] ? SADDR_WB[bank][10:0] : SRSEL[bank] ? (COPY_PREFETCH_LOCAL && COPY_PREFETCH_B[bank] ? SADDR_CNB[bank] : SADDR_CB[bank]) : SADDR_VB[bank]),.SDATA({SCSEL4[bank][3] ? bank_cpu_data[63:48] : SDATA_S[63:48], SCSEL4[bank][2] ? bank_cpu_data[47:32] : SDATA_S[47:32], SCSEL4[bank][1] ? bank_cpu_data[31:16] : SDATA_S[31:16], SCSEL4[bank][0] ? bank_cpu_data[15:0] : SDATA_S[15:0]}),
            .SWREN(SWREN_B[bank]), .SWREN_SEGMENT(SWREN_SEG_B[bank]),.SQ(bank_sq[bank]), .SADDR_W(SADDR_WB[bank][10:0]));
    end endgenerate
    always_comb begin
        selected_q=0; SQ=0; SQ_D=0;
        for (integer bank=0;bank<4;bank=bank+1) begin
            selected_q |= bank_q[bank];
            SQ |= bank_sq[bank] & {64{serial_bank2[bank]}};
            SQ_D |= bank_sq[bank] & {64{serial_bank2_nc[bank]}};
        end
    end
endmodule

// Per-bank replica of the foreground serial row/position state (MEM_ROW,
// SREG_POS, MRT_EXEC, RMT_EXEC, CPU_COPY_MODE, RMT_DDR_STATE) for the video
// serial address and the copy-mode select of one bank. Every input is
// registered here again (same loads as the shared boundary registers), so the
// next-state logic is local to the bank's RAM slices. fg_vram asserts that the
// replica equals the shared registers on every clock.
module BT_FG_VIDEO_ADDR_TRACK #(parameter FAST_UPPER=0) (
	input         CLK,
	input         RST_N,
	input  [5:0]  A_ROW,
	input         RAS_N, OE_N, WE_N, TRANSFER, CPU_SHIFT, SE_N,
	input         MEM_CE, HOLE_RDY, FAST_DONE,
	input  [5:0]  CPU_CACHE_A,
	output [10:0] SADDR_V,
	output        COPY_MODE,
	output [3:0]  COPY_MODE_CHUNKS
);
	(* preserve, dont_merge *) bit ras_n = 1'b1, oe_n = 1'b1, we_n = 1'b1, transfer = 1'b0, cpu_shift = 1'b0, se_n = 1'b1;
	(* preserve, dont_merge *) bit [5:0] a_row = '0;
	bit       ras_old = 1'b1;
	bit       mrt = 1'b0, rmt = 1'b0, copy_mode = 1'b0;
	// Capture the original D at the original edge; each 16-bit RAM mux has its own control.
	(* preserve, dont_merge *) bit [3:0] copy_mode_chunks = 4'b0;
	bit [1:0] ddr_state = '0;
	(* preserve, dont_merge *) bit [8:0] pos = '0;
	bit [5:0] row = '0;
	// Copy existing cache metadata at its original edges. The ready comparison
	// belongs to this bank's position state, rather than a shared SREG_POS cone
	// routed to every bank's DDR state register.
	(* preserve, dont_merge *) bit [5:0] cache_a2 = '0;
	(* preserve, dont_merge *) bit [8:0] pair_pos = '0;
	wire CPU_CACHE_READY = cache_a2 == pos[8:3] && pair_pos == pos;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) cache_a2 <= '0;
		else cache_a2 <= CPU_CACHE_A;
	end
	always @(posedge CLK) pair_pos <= {cache_a2, pos[2:0]};
	always @(posedge CLK) begin
		ras_n <= RAS_N; oe_n <= OE_N; we_n <= WE_N; transfer <= TRANSFER; cpu_shift <= CPU_SHIFT; se_n <= SE_N;
		a_row <= A_ROW;
	end
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin
			ras_old <= 1'b1; mrt <= 0; rmt <= 0; copy_mode <= 0; copy_mode_chunks <= '0; ddr_state <= '0; pos <= '0; row <= '0;
		end else begin
			ras_old <= ras_n;
			if (!ras_n && ras_old) begin
				mrt <= 0; rmt <= 0; ddr_state <= '0;
				if (!oe_n && we_n && transfer) begin
					copy_mode <= cpu_shift; copy_mode_chunks <= {4{cpu_shift}}; row <= a_row; mrt <= !cpu_shift; pos <= '0;
				end else if (!oe_n && !we_n && transfer) begin
					copy_mode <= cpu_shift; copy_mode_chunks <= {4{cpu_shift}}; row <= a_row; rmt <= !se_n; pos <= '0;
				end
			end
			if (mrt || (rmt && (!copy_mode || !pos[8]))) begin
				pos <= pos + 9'h8;
				if (pos == 9'h1F8) begin mrt <= 0; rmt <= 0; end
			end
			if (rmt && copy_mode && pos[8]) begin
				case (ddr_state)
					2'd0: if (FAST_UPPER ? CPU_CACHE_READY : (MEM_CE && CPU_CACHE_READY))
						ddr_state <= 2'd1;
					2'd1: if (FAST_UPPER ? FAST_DONE : HOLE_RDY) ddr_state <= 2'd2;
					2'd2: begin
						pos <= pos + (FAST_UPPER ? 9'd4 : 9'd2);
						ddr_state <= '0;
						if (pos == (FAST_UPPER ? 9'h1fc : 9'h1fe)) rmt <= 0;
					end
					default: ;
				endcase
			end
		end
	end
	assign SADDR_V = {row, pos[7:3]};
	assign COPY_MODE = copy_mode;
	assign COPY_MODE_CHUNKS = copy_mode_chunks;
`ifndef SYNTHESIS
	always @(posedge CLK) if (RST_N)
		assert (copy_mode_chunks == {4{copy_mode}})
			else $fatal(1,"foreground serial mux control changed capture edge");
`endif
endmodule

