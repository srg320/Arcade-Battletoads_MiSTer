module BG_VRAM #(parameter MEM_SCROLL_ADDER = 0) (
	input          CLK,
	input          CPU_CLK,
	input          RST_N,
	
	input  [15: 0] A,
	input  [14: 0] CPU_A,
	input  [15: 0] D,
	output [15: 0] Q,
	input          RAS_N,
	input  [ 1: 0] CAS_N,
	input          WE_N,
	input          OE_N,
	input          TRANSFER,
	output         RDY,
	
	input          SC,
	input          SE_N,
	output logic [ 7: 0] SQ,
	
	output logic   GRID,
output bit     SQ_NZ,
output bit     SQ_HIGH,
input [15:0]   SCROLL_BASE,
input [15:0]   SCROLL_OFFSET,
input          SCROLL_TRANSFER
);


	bit  [15: 3] RAM_SA;
	bit  [63: 0] RAM_SQ;
	bit  [63: 0] SR_Q;
	bit  [63: 0] VIDEO_WORD;
	bit  [ 2: 0] VIDEO_LANE;
	// One-hot copy of VIDEO_LANE: the byte select is an AND-OR, not a 3-bit mux.
	bit  [ 7: 0] VIDEO_LANE_OH;
	// A VRAM refresh copies a complete serial row. Ordinary CPU writes after
	// that refresh must not change pixels still being shifted out of the row.
	(* ramstyle = "MLAB" *) bit [63:0] LINE_CACHE [0:31];
	bit [4:0] LINE_CACHE_RA;
	bit [5:0] COPY_NEXT;
	bit [4:0] COPY_WADDR;
	bit COPY_RUN, COPY_VALID;
	// Register the wide serial word before the line cache: the sliced M10K
	// output mux and the MLAB write no longer share one memory cycle.
	bit COPY_VALID2;
	bit [4:0] COPY_WADDR2;
	bit [63:0] RAM_SQ_R;
	
	// Memory-clock copies of every CPU-clock input the memory-clock logic
	// uses. Each system-clock launch lands on a plain register first, so the
	// address mux, RAM address fan-out and transfer decode stay inside the
	// memory clock. Every command arrives one memory clock later, so their
	// relative order is unchanged; the CPU samples ready and read data at
	// least four memory clocks after presenting an address.
	bit  [15: 0] A_M;
	generate
		if (MEM_SCROLL_ADDER) begin : scroll_address_mem
			// Capture raw operands on the original A_M edge. Four-state storage
			// preserves unknown arithmetic until the original final bit boundary.
			(* preserve, dont_merge *) reg [15:0] base_m = 16'd0;
			(* preserve, dont_merge *) reg [15:0] offset_m = 16'd0;
			(* preserve, dont_merge *) reg transfer_m = 1'b0;
			always @(posedge CLK) begin
				base_m <= SCROLL_BASE;
				offset_m <= SCROLL_OFFSET;
				transfer_m <= SCROLL_TRANSFER;
			end
			wire [7:0] row_d = base_m[15:8] + offset_m[15:8];
			wire [7:0] col_d = base_m[7:0] + offset_m[7:0];
			always_comb A_M = transfer_m ? {row_d,col_d} : {base_m[15:8],base_m[7:1],1'b0};
		end else begin : unscrolled_address_input
			always @(posedge CLK) A_M <= A;
		end
	endgenerate
	(* maxfan = 16 *) bit [14: 0] CPU_A_M;
	bit          RAS_N_M = 1'b1, OE_N_M = 1'b1, WE_N_M = 1'b1, TRANSFER_M, SC_M;
	always @(posedge CLK) begin
		CPU_A_M <= CPU_A;
		RAS_N_M <= RAS_N;
		OE_N_M <= OE_N;
		WE_N_M <= WE_N;
		TRANSFER_M <= TRANSFER;
		SC_M <= SC;
	end

	// Capture the complete CPU write on its 80 MHz clock.  The old direct
	// port made the CPU's output aligner meet the 160 MHz RAM half-cycle.
	bit          WE_N_OLD;
	bit          WRITE_TOGGLE, WRITE_TOGGLE_M, WRITE_SEEN;
	bit [14:0]   WRITE_ADDR;
	bit [15:0]   WRITE_DATA;
	// Retain one identity cell on the measured short RAM data branch.
	// The CPU packet, RAM capture edge and every other consumer are unchanged.
	(* keep *) wire [15:0] RAM_WRITE_DATA;
	assign RAM_WRITE_DATA[14:0] = WRITE_DATA[14:0];
	lcell write_data_hold_delay(.in(WRITE_DATA[15]), .out(RAM_WRITE_DATA[15]));
	bit [1:0]    WRITE_BE;
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
		end else begin
			WE_N_OLD <= WE_N;
			if (!WE_N && WE_N_OLD && OE_N && !RAS_N) begin
				WRITE_ADDR <= CPU_A;
				WRITE_DATA <= D;
				WRITE_BE <= ~CAS_N;
				WRITE_TOGGLE <= ~WRITE_TOGGLE;
			end
		end
	end
	// The toggle crosses into the memory clock through one plain register;
	// the pending compare and the RAM write-enable mux start from it.
	always @(posedge CLK) begin
		if (!RST_N) begin
			WRITE_TOGGLE_M <= 0;
			WRITE_SEEN <= 0;
		end else begin
			WRITE_TOGGLE_M <= WRITE_TOGGLE;
			WRITE_SEEN <= WRITE_TOGGLE_M;
		end
	end
	wire WRITE_PENDING = WRITE_TOGGLE_M != WRITE_SEEN;
	// Capture the address the ordinary RAM mux selects after this edge.
	// A qualified CPU write is already stable before its pending window.
	// Reset selects the same newly captured CPU read address.
	(* preserve, maxfan = 16 *) bit [14:0] RAM_ADDR_M;
	always @(posedge CLK) begin
		if (!RST_N) RAM_ADDR_M <= CPU_A;
		else RAM_ADDR_M <= (WRITE_TOGGLE != WRITE_TOGGLE_M) ? WRITE_ADDR : CPU_A;
	end

	wire [15:0] RAM_Q_RAW;
	reg [15:0] RAM_Q_POST=0;
	always @(posedge CLK) RAM_Q_POST <= RAM_Q_RAW;
	assign Q=RAM_Q_POST;
	VRAM_MEM_64Kx8 #(.QA_REG(0)) mem
	(
		.CLK(CLK),

		// The serial address uses A; the ordinary port uses the registered
		// CPU address. Its read data is unused during a serial refresh.
		.ADDR(RAM_ADDR_M),
		.DATA(RAM_WRITE_DATA),
		.WREN(WRITE_PENDING),
		.BE(WRITE_BE),
		.Q(RAM_Q_RAW),

		.SADDR(RAM_SA),
		.SDATA(64'h0),
		.SWREN(1'b0),
		.SQ(RAM_SQ)
	);
	
	(* maxfan = 8, preserve *) bit  [ 7: 0] SREG_ROW;
	bit  [ 7: 0] SREG_COL;
	bit          MRT_EXEC;	//memory-to-register transfer
	bit          RMT_EXEC;	//register-to-memory transfer
	always @(posedge CLK or negedge RST_N) begin
		bit        RAS_N_OLD;
		bit        SC_OLD;
		
		if (!RST_N) begin
			RAS_N_OLD <= 1;
			SC_OLD <= 0;
			SREG_ROW <= '0;
			SREG_COL <= '0;
			MRT_EXEC <= 0;
			RMT_EXEC <= 0;
			COPY_NEXT <= 0;
			COPY_WADDR <= 0;
			COPY_RUN <= 0;
			COPY_VALID <= 0;
			COPY_VALID2 <= 0;
		end else begin
			// The M10K serial address is registered; its output is unregistered.
			// Delay the write index once to pair it with that RAM result.
			COPY_VALID <= COPY_RUN && COPY_NEXT < 6'd32;
			COPY_WADDR <= COPY_NEXT[4:0];
			COPY_VALID2 <= COPY_VALID;
			COPY_WADDR2 <= COPY_WADDR;
			RAM_SQ_R <= RAM_SQ;
			if (COPY_VALID2) LINE_CACHE[COPY_WADDR2] <= RAM_SQ_R;
			if (COPY_RUN) begin
				if (COPY_NEXT < 6'd32) COPY_NEXT <= COPY_NEXT + 6'd1;
				else if (!COPY_VALID && !COPY_VALID2) COPY_RUN <= 0;
			end
			RAS_N_OLD <= RAS_N_M;
			if (!RAS_N_M && RAS_N_OLD) begin
				if (!OE_N_M && WE_N_M && TRANSFER_M) begin
					SREG_ROW <= A_M[15:8];
					SREG_COL <= A_M[7:0];
					MRT_EXEC <= 1;
					COPY_NEXT <= 0;
					COPY_RUN <= 1;
					COPY_VALID <= 0;
					COPY_VALID2 <= 0;
				end
			end
			SC_OLD <= SC_M;
			if (!SC_M && SC_OLD) begin
				SREG_COL <= SREG_COL + 8'h1;
			end
		end
	end
	assign RAM_SA = {SREG_ROW,COPY_NEXT[4:0]};
	
	assign SR_Q = LINE_CACHE[LINE_CACHE_RA];
	
	// These predicates use the exact SQ D value on its original MEM edge.
	// bit outputs match the BT bit-byte conversion even for X/Z inputs.
	wire [7:0] SERIAL_BYTE_D = ({8{VIDEO_LANE_OH[0]}} & VIDEO_WORD[ 7: 0]) | ({8{VIDEO_LANE_OH[1]}} & VIDEO_WORD[15: 8]) |
			      ({8{VIDEO_LANE_OH[2]}} & VIDEO_WORD[23:16]) | ({8{VIDEO_LANE_OH[3]}} & VIDEO_WORD[31:24]) |
			      ({8{VIDEO_LANE_OH[4]}} & VIDEO_WORD[39:32]) | ({8{VIDEO_LANE_OH[5]}} & VIDEO_WORD[47:40]) |
			      ({8{VIDEO_LANE_OH[6]}} & VIDEO_WORD[55:48]) | ({8{VIDEO_LANE_OH[7]}} & VIDEO_WORD[63:56]);
	// Reduce each lane before the one-hot mask and scalar OR.
	wire SERIAL_NZ_D = (VIDEO_LANE_OH[0] & (|VIDEO_WORD[7: 0])) |
		(VIDEO_LANE_OH[1] & (|VIDEO_WORD[15: 8])) |
		(VIDEO_LANE_OH[2] & (|VIDEO_WORD[23: 16])) |
		(VIDEO_LANE_OH[3] & (|VIDEO_WORD[31: 24])) |
		(VIDEO_LANE_OH[4] & (|VIDEO_WORD[39: 32])) |
		(VIDEO_LANE_OH[5] & (|VIDEO_WORD[47: 40])) |
		(VIDEO_LANE_OH[6] & (|VIDEO_WORD[55: 48])) |
		(VIDEO_LANE_OH[7] & (|VIDEO_WORD[63: 56]));

	// The 10 MHz serial pixel cadence leaves sixteen 160 MHz clocks per
	// pixel. Register the wide RAM result before selecting its byte, as on FG.
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin
			LINE_CACHE_RA <= '0;
			VIDEO_WORD <= '0;
			VIDEO_LANE <= '0;
			VIDEO_LANE_OH <= 8'd1;
			SQ <= '0;
			SQ_NZ <= 1'b0;
			SQ_HIGH <= 1'b0;
		end else begin
			LINE_CACHE_RA <= SREG_COL[7:3];
			VIDEO_WORD <= SR_Q;
			VIDEO_LANE <= SREG_COL[2:0];
			VIDEO_LANE_OH <= 8'd1 << SREG_COL[2:0];
			SQ <= SERIAL_BYTE_D;
			SQ_NZ <= SERIAL_NZ_D;
			SQ_HIGH <= SERIAL_BYTE_D[7];
		end
	end
	assign GRID = (SREG_ROW == 8'h00 || SREG_COL == 8'h00) && MRT_EXEC;
	
	assign RDY = ~(MRT_EXEC | RMT_EXEC);

endmodule
