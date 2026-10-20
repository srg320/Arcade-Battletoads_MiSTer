module TMS34020_MC #(parameter bit EARLY_ADDR_SELECT = 0)
 (
	input              CLK,
	input              RST_N,
	input              EN,
	
	input              CE_F,
	input              CE_R,
	
	input              RES_N,
	
	input      [31: 0] ADDR,
	input      [31: 0] DOUT,
	output     [31: 0] DIN,
	output     [31: 0] DIN_F,      // the read word as seen by CE_F consumers
	input      [ 5: 0] FS,
	input      [ 5: 0] FS0,FS1,
	input              FIELD_SELECT,
	input              READ,
	input              WRITE,
	input              WRITE_PRE,   // WRITE before the pixel transparency gate
	input              PIX,
	input      [31: 0] PC,
	input              CACHE,
	input              CACHE_ADDRESS,
	input              LAUNCH_KILL,   // late pause-finish mask; READ/WRITE/WRITE_PRE/CACHE arrive unmasked
	output             CACHE_WR,
	input              VECT,
	output             WAIT,
	input      [31: 0] PIX_WMASK,
	
	input      [31: 0] SCRREF_ADDR,
	input              SCRREF_RUN,
	
	input              CST,
	
	output reg [31: 0] DBUS_A,
	input      [31: 0] DBUS_DI,
	input      [31: 0] DBUS_DI_E,   // DBUS_DI as it will read one clock later (IO next-state)
	output reg [31: 0] DBUS_DO,
	output reg         DBUS_RAS,
	output reg         DBUS_WE,
	output reg         DBUS_RD,
	// External read strobe: set with DBUS_RD in CE_R for ordinary reads and
	// fetches only, never in the CE_F internal (PIX/CST, screen refresh)
	// cases, so the board's DDR read request is qualified by a strobe that
	// rises two memory clocks after the address and code were published.
	output reg         DBUS_RD_EXT,
	output reg [ 3: 0] DBUS_BE,
	output reg [ 3: 0] DBUS_CODE,
	input              DBUS_RDY,
	output reg         DBUS_ANY_BE,
	output reg         DBUS_ANY_BE_FG
	
`ifdef DEBUG
	,
	output reg [31: 0] DBG_DBUS_A
`endif
	, output reg [ 3: 0] DBUS_ADDR_CLASS
	, output reg [3:0] VRAM_REQUEST
	, output wire PAUSE_READY
);

	import TMS34020_PKG::*;
	wire READ_K = READ && !LAUNCH_KILL;
	wire WRITE_K = WRITE && !LAUNCH_KILL;
	wire WRITE_PRE_K = WRITE_PRE && !LAUNCH_KILL;
	wire CACHE_K = CACHE && !LAUNCH_KILL;

	// Published with DBUS_A, so the fast VRAM input needs no wide decode.
	// Bits: normal foreground, serial foreground, background 0, background 1.
	function automatic [3:0] AddressClass(input logic [31:0] address);
		AddressClass = {
			address[31:22] == {8'hB4,2'b00},
			address[31:22] == {8'hB0,2'b00},
			(address[31:27] & 5'b10111) == 5'b10100,
			address[31:27] == 5'b10100 && address[25:22] == 4'b0000
		};
	endfunction
	
	// Bank-independent requests, published on the original bus update edge.
	// Display page selection stays live in BT; no bus state or cycle moves.
	function automatic [3:0] VramRequests(input logic [31:0] address,
	                                      input logic [3:0] code,
	                                      input logic ras_active);
		logic [3:0] classes;
		logic fg_match;
		classes = AddressClass(address);
		fg_match = classes[0] || (code == 4'b0101 && classes[1]);
		VramRequests = {
			ras_active && (classes[3] || code == 4'b0100),
			ras_active && (classes[2] || code == 4'b0100),
			ras_active && fg_match && address[26],
			ras_active && ((fg_match && !address[26]) || code == 4'b0100)
		};
	endfunction


	// Decode before the EN/phase launch selection; no bus update edge moves.
	wire [3:0] vram_mc_normal = VramRequests(MC_ADDR, 4'b1111, 1'b1);
	wire [3:0] vram_mc_pixel = VramRequests(MC_ADDR, PIX && CST ? 4'b0101 : 4'b1000, 1'b1);
	wire [3:0] vram_existing_normal = VramRequests(DBUS_A, 4'b1111, 1'b1);
	wire [3:0] vram_existing_pixel = VramRequests(DBUS_A, PIX && CST ? 4'b0101 : 4'b1000, 1'b1);
	wire [3:0] vram_existing_code = VramRequests(DBUS_A, DBUS_CODE, 1'b1);
	wire [3:0] vram_refresh = VramRequests(SCRREF_ADDR, 4'b0100, 1'b1);
	wire [3:0] vram_fetch = VramRequests(PC, 4'b1001, 1'b1);
	logic [3:0] vram_request_unkilled, vram_request_killed;
	function automatic logic [3:0] vram_request_f(input logic rd, input logic wr, input logic wr_pre, input logic cache);
		logic [3:0] r;
		r = vram_existing_code & {4{DBUS_RAS}};
		if (EN) begin
			if (CE_F) begin
				if (!MC_STATE) begin
					if (MC_READ_EXT || MC_WRITE_EXT)
						r = vram_mc_pixel;
					else if (SCRREF_PEND)
						r = vram_refresh;
					else if (rd && !cache)
						r = vram_mc_pixel;
					else if (wr && !cache)
						r = wr_pre ? vram_mc_pixel : vram_existing_pixel;
					else if (cache)
						r = vram_fetch;
					else
						r = (wr_pre ? vram_mc_normal : vram_existing_normal) & {4{DBUS_RAS}};
				end
			end else if (CE_R && MC_STATE) begin
				if (MC_WRITE_PEND || MC_WRITE_PEND2)
					r = vram_existing_code;
				else if (READ_LATCH || WRITE_LATCH || FETCH_LATCH)
					r = 4'b0000;
			end
		end
		return r;
	endfunction
	assign vram_request_unkilled = vram_request_f(READ, WRITE, WRITE_PRE, CACHE);
	assign vram_request_killed = vram_request_f(1'b0, 1'b0, 1'b0, 1'b0);
	(* keep *) wire [3:0] vram_request_unkilled_k = vram_request_unkilled;
	(* keep *) wire [3:0] vram_request_killed_k = vram_request_killed;
	wire [3:0] vram_request_next = LAUNCH_KILL ? vram_request_killed_k : vram_request_unkilled_k;

	bit [1:0] FETCH_LSB;
	// The qualified launch predicate owns the register enable. Its late pause
	// qualifier does not select the wide address data on an admitted launch.
	wire dbus_addr_ce = EN && CE_F && !MC_STATE &&
	    (MC_READ_EXT || MC_WRITE_EXT || SCRREF_PEND || READ_K || WRITE_PRE_K || CACHE_K);
	wire address_cache_select = EARLY_ADDR_SELECT ? CACHE_ADDRESS : CACHE_K;
	wire [31:0] dbus_addr_data = MC_READ_EXT || MC_WRITE_EXT ? MC_ADDR :
	    SCRREF_PEND ? {SCRREF_ADDR[31:5],5'b00000} :
	    address_cache_select ? {PC[31:7],PC[6:5]+FETCH_LSB,5'b00000} : MC_ADDR;
	wire [3:0] dbus_addr_class_data = MC_READ_EXT || MC_WRITE_EXT ? AddressClass(MC_ADDR) :
	    SCRREF_PEND ? AddressClass(SCRREF_ADDR) :
	    address_cache_select ? AddressClass(PC) : AddressClass(MC_ADDR);
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin
			DBUS_A <= '0;
			DBUS_ADDR_CLASS <= 4'b0000;
		end else if (dbus_addr_ce) begin
			DBUS_A <= dbus_addr_data;
			DBUS_ADDR_CLASS <= dbus_addr_class_data;
		end
	end

	bit  [31: 0] MC_ADDR;
	bit  [ 3: 0] MC_BE;
	bit  [ 4: 0] DIN_BA;
	bit  [ 5: 0] DIN_FS;
	bit  [ 5: 0] DIN_FS_OLD;
	bit  [ 5: 0] DOUT_FS;
	
	bit  [31: 0] DOUT_BUF;
	bit  [31: 0] DIN_BUF;
	bit  [31: 0] READ_WORD, READ_PREVIOUS;
`ifndef SYNTHESIS
	bit  [31: 0] DBUS_A_REF = '0;
	integer      dbus_a_skips = 0;
	bit          early_loaded_last_edge = 0;
`endif
	bit  [ 4: 0] READ_ALIGN;
	bit  [ 5: 0] READ_SIZE, READ_OLD_SIZE;
	bit          READ_EXTENDED;
	// Capture the bus first; alignment uses the captured transaction metadata.
	// This retains the same F-phase result without a barrel shifter on the
	// fast-VRAM-to-system-register input path.
	assign DIN_BUF = READ_EXTENDED ?
		InAlignerExt(READ_WORD, READ_PREVIOUS, READ_SIZE, READ_OLD_SIZE) :
		InAligner(READ_WORD, 32'b0, READ_ALIGN, READ_SIZE);
	// Early copy of the capture group, loaded in the CE_R between the READ_LATCH
	// set (CE_F) and the CE_F capture above. The bus data is already stable
	// there (asserted below), so CPU R-phase consumers read the same word two
	// system clocks before their CE_R instead of one. CE_F consumers keep DIN_F.
	bit  [31: 0] READ_WORD_E, READ_PREVIOUS_E;
	bit  [ 4: 0] READ_ALIGN_E;
	bit  [ 5: 0] READ_SIZE_E, READ_OLD_SIZE_E;
	bit          READ_EXTENDED_E;
	wire [31: 0] DIN_EARLY = READ_EXTENDED_E ?
		InAlignerExt(READ_WORD_E, READ_PREVIOUS_E, READ_SIZE_E, READ_OLD_SIZE_E) :
		InAligner(READ_WORD_E, 32'b0, READ_ALIGN_E, READ_SIZE_E);
	bit          MC_EXT_WORD;
	bit          FETCH_LATCH;
	bit          RMW;
	bit          MC_READ_EXT;
	bit          MC_WRITE_EXT;
	bit  [31: 0] MC_WMASK_EXT;
	// The second-word write mask is first used at a later F (after the first
	// word completes), so it is captured at the CE_R right after the launch, from
	// the same R-owned state, giving the wide mask logic two system clocks.
	bit          WMASK_EXT_PEND;
`ifndef SYNTHESIS
	bit  [31: 0] WMASK_EXT_REF;   // the original CE_F capture
`endif
		
	// A bit belongs to the field exactly when it lies between its start and
	// exclusive end. Constant comparisons avoid two wide barrel shifters.
	function automatic bit [63:0] FastDataWriteMask(input bit [4:0] ba, input bit [5:0] fsize);
		bit [5:0] field_end;
		// The original shift amount adds in six bits, including its wrap.
		field_end = {1'b0,ba} + fsize;
		for (int j=0; j<64; j++)
			FastDataWriteMask[j] = ({2'b0,ba} <= 7'(j)) && (field_end > 7'(j));
	endfunction
	function automatic bit [3:0] FastDataWriteBE(input bit [4:0] ba, input bit [5:0] fsize);
		// Constant truth tables map the low-bit carry and upper thresholds
		// directly into LUTs; avoid a second ripple carry after address addition.
		localparam bit [63:0] LOW_CARRY = 64'hfefcf8f0e0c08000;
		localparam bit [63:0] LOW_PAST8 = 64'hfcf8f0e0c0800000;
		localparam bit [127:0] HIGH_GT = {32'hfefcf8f0, 32'hfffefcf8, 32'hfffffefc, 32'hfffffffe};
		localparam bit [127:0] HIGH_EQ = {32'h01020408, 32'h00010204, 32'h00000102, 32'h00000001};
		localparam bit [127:0] HIGH_PREV = {32'h00010204, 32'h00000102, 32'h00000001, 32'h00000000};
		localparam bit [31:0] HIGH_OVER = 32'he0c08000;
		localparam bit [31:0] HIGH_SEVEN = 32'h10204080;
		bit [5:0] low_index;
		bit [4:0] high_index;
		bit overflow, past_boundary;
		bit [31:0] gt_table, eq_table, prev_table;
		low_index = {ba[2:0],fsize[2:0]};
		high_index = {ba[4:3],fsize[5:3]};
		overflow = HIGH_OVER[high_index] || (HIGH_SEVEN[high_index] && LOW_CARRY[low_index]);
		for (int j=0; j<4; j++) begin
			gt_table = 32'(HIGH_GT >> (32*j));
			eq_table = 32'(HIGH_EQ >> (32*j));
			prev_table = 32'(HIGH_PREV >> (32*j));
			past_boundary = gt_table[high_index] ||
			    (eq_table[high_index] && (|{ba[2:0],fsize[2:0]})) ||
			    (prev_table[high_index] && LOW_PAST8[low_index]);
			FastDataWriteBE[j] = (fsize != 0) && !overflow &&
			    (ba[4:3] <= 2'(j)) && past_boundary;
		end
	endfunction
	bit  [63: 0] DATA_WMASK;
	(* keep = "true" *) wire [3:0] DATA_BE0 = FastDataWriteBE(ADDR[4:0],FS0);
	(* keep = "true" *) wire [3:0] DATA_BE1 = FastDataWriteBE(ADDR[4:0],FS1);
	wire [3:0] DATA_BE = FIELD_SELECT ? DATA_BE1 : DATA_BE0;
	(* keep = "true" *) wire [63:0] DATA_WMASK0 = FastDataWriteMask(ADDR[4:0],FS0);
	(* keep = "true" *) wire [63:0] DATA_WMASK1 = FastDataWriteMask(ADDR[4:0],FS1);
	always_comb begin
		MC_ADDR <= !MC_READ_EXT && !MC_WRITE_EXT ? ADDR : {DBUS_A[31:5],5'b00000} + 32'h20;

		DATA_WMASK <= FIELD_SELECT ? DATA_WMASK1 : DATA_WMASK0;
	end
	`ifdef VERILATOR
	always @(posedge CLK) if (RST_N && EN && CE_F) begin
		assert (DATA_BE == FastDataWriteBE(ADDR[4:0],FS))
			else $fatal(1,"CPU field selection changed byte enables");
		assert (DATA_WMASK == FastDataWriteMask(ADDR[4:0],FS))
			else $fatal(1,"CPU field selection changed write mask");
	end
	`endif
	
	always_comb begin
		if (MC_WRITE_EXT) begin
			MC_BE <= { |MC_WMASK_EXT[31:24], |MC_WMASK_EXT[23:16], |MC_WMASK_EXT[15: 8], |MC_WMASK_EXT[ 7: 0] };
		end else if (WRITE_K && PIX) begin
			MC_BE <= { |PIX_WMASK[31:24], |PIX_WMASK[23:16], |PIX_WMASK[15: 8], |PIX_WMASK[ 7: 0] } & DATA_BE;
		end else if (WRITE_K) begin
			MC_BE <= DATA_BE;
		end else begin
			MC_BE <= 4'b1111;
		end
	end
	
	bit  [31: 0] DATA_OLD;
	bit  [ 4: 0] DOUT_BA_OLD;
	
	bit          MC_STATE;
	// DBUS_BE is consumed only with a write strobe, which never rises before
	// the CE_R that follows its CE_F launch (PIX/CST transfers raise the read
	// strobe too, which forces every CAS low). The launch records its selects;
	// the address/field byte-enable decode is taken in that CE_R from CPU
	// R-phase state, which cannot change before that edge.
	bit          BE_PEND, BE_ONES, BE_EXT, BE_WR, BE_PIX;
	bit  [ 3: 0] BE_PIXMASK;
`ifndef SYNTHESIS
	bit  [ 3: 0] DBUS_BE_REF;   // the original CE_F byte-enable register
`endif
	wire [ 3: 0] PIX_BE = { |PIX_WMASK[31:24], |PIX_WMASK[23:16], |PIX_WMASK[15: 8], |PIX_WMASK[ 7: 0] };
	wire [ 3: 0] EXT_BE = { |MC_WMASK_EXT[31:24], |MC_WMASK_EXT[23:16], |MC_WMASK_EXT[15: 8], |MC_WMASK_EXT[ 7: 0] };
	bit          MC_READ_WAIT;
	bit          MC_WRITE_WAIT;
	bit          MC_FETCH_WAIT;
	bit          MC_SCRREF_WAIT;
	
		bit         MC_READ_PEND;
		bit         MC_WRITE_PEND,MC_WRITE_PEND2;
		bit         MC_WRITE_RMW;
		bit         MC_FETCH_PEND;
//		bit         MC_WRITE_SKEEP;
		bit         MC_SCRREF_PEND;
	wire [3:0] BE_NEXT = BE_ONES ? 4'b1111 : BE_EXT ? EXT_BE : BE_WR && BE_PIX ? BE_PIXMASK & DATA_BE : BE_WR ? DATA_BE : 4'b1111;
`ifndef SYNTHESIS
	always @(posedge CLK) if (RST_N) begin
		assert (VRAM_REQUEST === VramRequests(DBUS_A, DBUS_CODE, DBUS_RAS))
			else $fatal(1,"Published VRAM request differs from current bus state");
		assert (DBUS_ADDR_CLASS === AddressClass(DBUS_A))
			else $fatal(1,"Published address class differs from DBUS_A");
		if (DBUS_ANY_BE !== (|DBUS_BE) || DBUS_ANY_BE_FG !== (DBUS_BE[0] | DBUS_BE[2]))
			$fatal(1,"Published scalar byte enables differ from lanes");
	end
`endif
	// Same two-state startup values and reset/assignment sites; only scope moves.
	bit SCRREF_PEND, READ_LATCH, WRITE_LATCH;
	// A finish-F may consume READ/FETCH_LATCH, but no bus close may remain.
	assign PAUSE_READY = RST_N && !MC_STATE && !WRITE_LATCH &&
	    !MC_READ_PEND && !MC_WRITE_PEND && !MC_WRITE_PEND2 &&
	    !MC_FETCH_PEND && !MC_SCRREF_PEND && !MC_READ_EXT && !MC_WRITE_EXT &&
	    !BE_PEND && !WMASK_EXT_PEND && !WAIT &&
	    !DBUS_RAS && !DBUS_WE && !DBUS_RD && !DBUS_RD_EXT &&
	    (EN || (!READ_LATCH && !FETCH_LATCH));
	always @(posedge CLK or negedge RST_N) begin		

		
		if (!RST_N) begin
			DBUS_BE <= '0;

			DBUS_ANY_BE <= 0;
			DBUS_ANY_BE_FG <= 0;
			BE_PEND <= 0;
			WMASK_EXT_PEND <= 0;
`ifndef SYNTHESIS
			DBUS_BE_REF <= '0;
			DBUS_A_REF <= '0;
`endif
//			DBUS_DO <= '0;
			DBUS_WE <= 0;
			DBUS_RD <= 0;
			DBUS_RD_EXT <= 0;
			DBUS_CODE <= 4'b1111;
			VRAM_REQUEST <= 4'b0000;
			DIN_BA <= '0;
			DIN_FS <= '0;
			DOUT_FS <= '0;
			SCRREF_PEND <= 0;
			
			MC_STATE <= 0;
			MC_READ_WAIT <= 0;
			MC_WRITE_WAIT <= 0;
			MC_FETCH_WAIT <= 0;
			MC_SCRREF_WAIT <= 0;
			DOUT_BUF <= '0;
			READ_WORD <= '0;
			READ_PREVIOUS <= '0;
			READ_WORD_E <= '0;
			READ_PREVIOUS_E <= '0;
			READ_ALIGN_E <= '0;
			READ_SIZE_E <= '0;
			READ_OLD_SIZE_E <= '0;
			READ_EXTENDED_E <= 0;
`ifndef SYNTHESIS
			early_loaded_last_edge <= 0;
`endif
			READ_ALIGN <= '0;
			READ_SIZE <= '0;
			READ_OLD_SIZE <= '0;
			READ_EXTENDED <= 0;
			RMW <= 0;
			MC_READ_PEND <= 0;
			MC_WRITE_PEND <= 0;
			MC_WRITE_PEND2 <= 0;
			MC_FETCH_PEND <= 0;
			MC_SCRREF_PEND <= 0;
//			MC_WRITE_SKEEP <= 0;
			MC_EXT_WORD <= 0;
			READ_LATCH <= 0;
			WRITE_LATCH <= 0;
			FETCH_LATCH <= 0;
			FETCH_LSB <= '0;
			MC_READ_EXT <= 0;
			MC_WRITE_EXT <= 0;
		end
		else begin
			// Prepare the return snapshot on every SYS edge, including EN pauses.
			// READ_LATCH and its metadata remain held until an admitted CE_F;
			// a resumed F must see the current word, not the previous transaction.
			// The following admitted R still requires two clocks of snapshot age.
			if (READ_LATCH && !CE_F) begin
				READ_WORD_E <= DBUS_DI_E;
				READ_PREVIOUS_E <= DIN_BUF;
				READ_ALIGN_E <= DIN_BA;
				READ_SIZE_E <= DIN_FS;
				READ_OLD_SIZE_E <= DIN_FS_OLD;
				READ_EXTENDED_E <= MC_EXT_WORD;
			end
`ifndef SYNTHESIS
			// The early capture group must be >= 2 clocks old at every CE_R.
			if (EN && CE_R) assert (!early_loaded_last_edge)
				else $fatal(1,"early read capture loaded one clock before a CE_R");
			early_loaded_last_edge <= READ_LATCH && !CE_F;
`endif
			if (EN) begin
			if (SCRREF_RUN && CE_R) begin	
				SCRREF_PEND <= 1;
			end
			
			if (CE_F) begin
				// DBUS_A load: the same launch priority chain as the case below,
				// but the pixel-write transparency gate (PIX_WE, inside WRITE) is
				// not in its enable. A skipped pixel write presents its address
				// with no strobe and no transaction; nothing samples DBUS_A
				// without a strobe or a pending transaction.

`ifndef SYNTHESIS
				if (!MC_STATE && (MC_READ_EXT || MC_WRITE_EXT || SCRREF_PEND || READ_K || WRITE_K || CACHE_K))
					DBUS_A_REF <= MC_READ_EXT || MC_WRITE_EXT ? MC_ADDR :
					              SCRREF_PEND ? {SCRREF_ADDR[31:5],5'b00000} :
					              (READ_K || WRITE_K) && !CACHE_K ? MC_ADDR :
					              {PC[31:7],PC[6:5]+FETCH_LSB,5'b00000};
`endif
				case (MC_STATE)
				1'b0: begin
					MC_EXT_WORD <= 0;
					DBUS_CODE <= 4'b1111;
					if (MC_READ_EXT) begin
						BE_PEND <= 1; BE_ONES <= 0; BE_EXT <= MC_WRITE_EXT; BE_WR <= WRITE_K; BE_PIX <= PIX; BE_PIXMASK <= PIX_BE;
`ifndef SYNTHESIS
						DBUS_BE_REF <= MC_BE;
`endif
						DBUS_RD <= PIX && CST;
						DBUS_WE <= 0;
						DBUS_RAS <= 1;
						DBUS_CODE <= PIX && CST ? 4'b0101 : 4'b1000;
						DIN_BA <= '0;
//						DIN_FS <= DIN_FS - {1'b0,DIN_BA};
						MC_READ_PEND <= 1;
						MC_READ_WAIT <= 1;
						MC_READ_EXT <= 0;
						MC_EXT_WORD <= 1;
					end else if (MC_WRITE_EXT) begin
						BE_PEND <= 1; BE_ONES <= 0; BE_EXT <= MC_WRITE_EXT; BE_WR <= WRITE_K; BE_PIX <= PIX; BE_PIXMASK <= PIX_BE;
`ifndef SYNTHESIS
						DBUS_BE_REF <= MC_BE;
`endif
						DBUS_RAS <= 1;
						DBUS_CODE <= PIX && CST ? 4'b0101 : 4'b1000;
						DATA_OLD <= '0;
						DIN_BA <= '0;
//						DIN_FS <= DIN_FS - {1'b0,DIN_BA};
						DOUT_BA_OLD <= DBUS_A[4:0];
						if (MC_WRITE_RMW) begin
							MC_READ_PEND <= 1;
							RMW <= 1;
						end else begin
							DBUS_RD <= PIX && CST;
							DBUS_WE <= PIX && CST;
							MC_WRITE_PEND2 <= 1;
							RMW <= 0;
						end
//						MC_WRITE_WAIT <= 0;
						MC_WRITE_EXT <= 0;
						MC_EXT_WORD <= 1;
					end else if (SCRREF_PEND) begin
						BE_PEND <= 1; BE_ONES <= 1;
`ifndef SYNTHESIS
						DBUS_BE_REF <= 4'b1111;
`endif
						DBUS_WE <= 0;
						DBUS_RD <= 1;
						DBUS_RAS <= 1;
						DBUS_CODE <= 4'b0100;
						DIN_BA <= '0;
						DIN_FS <= 6'h20;
						MC_SCRREF_PEND <= 1;
						MC_SCRREF_WAIT <= 1;
						SCRREF_PEND <= 0;
					end else if (READ_K && !CACHE_K) begin
						BE_PEND <= 1; BE_ONES <= 0; BE_EXT <= MC_WRITE_EXT; BE_WR <= WRITE_K; BE_PIX <= PIX; BE_PIXMASK <= PIX_BE;
`ifndef SYNTHESIS
						DBUS_BE_REF <= MC_BE;
`endif
						DBUS_RD <= PIX && CST;
						DBUS_WE <= 0;
						DBUS_RAS <= 1;
						DBUS_CODE <= PIX && CST ? 4'b0101 : VECT ? 4'b1011 : 4'b1000;
						DIN_BA <= MC_ADDR[4:0];
						DIN_FS <= FS;
						MC_READ_PEND <= 1;
						MC_READ_WAIT <= 1;
						MC_READ_EXT <= (({1'b0,MC_ADDR[4:0]} + FS) > 6'h20);
					end else if (WRITE_K && !CACHE_K) begin
						BE_PEND <= 1; BE_ONES <= 0; BE_EXT <= MC_WRITE_EXT; BE_WR <= WRITE_K; BE_PIX <= PIX; BE_PIXMASK <= PIX_BE;
`ifndef SYNTHESIS
						DBUS_BE_REF <= MC_BE;
`endif
						DBUS_RAS <= 1;
						DBUS_CODE <= PIX && CST ? 4'b0101 : 4'b1000;
						DATA_OLD <= '0;
						DIN_BA <= MC_ADDR[4:0];
						DIN_FS <= FS;
						DOUT_FS <= FS;
						if ((MC_ADDR[2:0] || FS[2:0]) && !RMW) begin
							MC_READ_PEND <= 1;
							RMW <= 1;
							MC_WRITE_RMW <= 1;
						end else begin
							DBUS_RD <= PIX && CST;
							DBUS_WE <= PIX && CST;
//							DBUS_CODE <= PIX && CST ? 4'b0101 : 4'b1000;
							MC_WRITE_PEND <= 1;
							MC_WRITE_RMW <= 0;
							RMW <= 0;
						end
						MC_WRITE_WAIT <= 0;
						MC_WRITE_EXT <= (({1'b0,MC_ADDR[4:0]} + FS) > 6'h20);
						WMASK_EXT_PEND <= 1;
`ifndef SYNTHESIS
						WMASK_EXT_REF <= DATA_WMASK[63:32];
`endif
					end else if (CACHE_K) begin
						BE_PEND <= 1; BE_ONES <= 1;
`ifndef SYNTHESIS
						DBUS_BE_REF <= 4'b1111;
`endif
						DBUS_RAS <= 1;
						DBUS_CODE <= 4'b1001;
						DIN_BA <= '0;
						DIN_FS <= 6'h20;
						MC_FETCH_PEND <= 1;
						MC_FETCH_WAIT <= 1;
					end
				end
				
				1'b1: if (DBUS_RDY) begin
					if (MC_SCRREF_PEND) begin
						MC_SCRREF_PEND <= 0;
						MC_SCRREF_WAIT <= 0;
						WRITE_LATCH <= 1;
					end
					else if (MC_FETCH_PEND) begin
						MC_FETCH_PEND <= 0;
						FETCH_LATCH <= 1;
						WRITE_LATCH <= 1;
						FETCH_LSB <= FETCH_LSB + 2'd1;
						if (FETCH_LSB == 2'd3) MC_FETCH_WAIT <= 0;
					end
					else if (MC_READ_PEND) begin	
						MC_READ_PEND <= 0;
						READ_LATCH <= 1;
						WRITE_LATCH <= 1;
						RMW <= 0;
						if (!RMW) begin
							MC_READ_WAIT <= MC_READ_EXT;
						end else begin
							MC_WRITE_PEND <= 1;
						end
					end
					else if (MC_WRITE_PEND) begin	
						MC_WRITE_PEND <= 0;
						WRITE_LATCH <= 1;
					end
					else if (MC_WRITE_PEND2) begin	
						MC_WRITE_PEND2 <= 0;
						WRITE_LATCH <= 1;
					end
				end
				endcase
					
				if (FETCH_LATCH && !WRITE_LATCH) begin
					FETCH_LATCH <= 0;
				end
`ifndef SYNTHESIS
				// The early capture group must equal what this CE_F capture loads.
				if (READ_LATCH)
					assert ({READ_WORD_E,READ_PREVIOUS_E,READ_ALIGN_E,READ_SIZE_E,READ_OLD_SIZE_E,READ_EXTENDED_E} ===
					        {DBUS_DI,DIN_BUF,DIN_BA,DIN_FS,DIN_FS_OLD,MC_EXT_WORD})
						else $fatal(1,"early read capture differs from the CE_F capture: early=%h %h %h %h %h %b late=%h %h %h %h %h %b",READ_WORD_E,READ_PREVIOUS_E,READ_ALIGN_E,READ_SIZE_E,READ_OLD_SIZE_E,READ_EXTENDED_E,DBUS_DI,DIN_BUF,DIN_BA,DIN_FS,DIN_FS_OLD,MC_EXT_WORD);
`endif
				if (READ_LATCH) begin	
					READ_WORD <= DBUS_DI;
					READ_PREVIOUS <= DIN_BUF;
					READ_ALIGN <= DIN_BA;
					READ_SIZE <= DIN_FS;
					READ_OLD_SIZE <= DIN_FS_OLD;
					READ_EXTENDED <= MC_EXT_WORD;
					if (!MC_EXT_WORD) begin
						DIN_FS_OLD <= 6'h20 - {1'b0,DIN_BA};
					end
					DATA_OLD <= DBUS_DI;
					READ_LATCH <= 0;
				end
				
				if ((MC_READ_PEND && RMW) || MC_WRITE_PEND || MC_WRITE_PEND2 || MC_WRITE_EXT || MC_SCRREF_PEND) begin
					if (READ_K && !MC_READ_WAIT) begin
						MC_READ_WAIT <= 1;
					end
					if (WRITE_K && !MC_WRITE_WAIT) begin
						MC_WRITE_WAIT <= 1;
					end
				end
			end 
			else if (CE_R) begin	
				// Byte enables load in the CE_R right after the CE_F launch (see the
				// BE_* registers): the strobes that use them rise in this same CE_R.
				if (WMASK_EXT_PEND) begin
					WMASK_EXT_PEND <= 0;
					MC_WMASK_EXT <= DATA_WMASK[63:32];
				end
				if (BE_PEND) begin
					BE_PEND <= 0;
					DBUS_BE <= BE_NEXT;
					DBUS_ANY_BE <= |BE_NEXT;
					DBUS_ANY_BE_FG <= BE_NEXT[0] | BE_NEXT[2];
				end
				case (MC_STATE)
				1'b0: begin
					if (MC_READ_PEND || MC_WRITE_PEND || MC_WRITE_PEND2 || MC_FETCH_PEND || MC_SCRREF_PEND) begin
						MC_STATE <= 1;
					end
					if ((MC_READ_PEND && RMW) || MC_WRITE_PEND) begin
						DOUT_BUF <= DOUT;
					end
					if (MC_WRITE_PEND || MC_WRITE_PEND2 /*|| MC_SCRREF_PEND*/) begin
						DBUS_WE <= 1;
					end
					if (MC_READ_PEND || MC_FETCH_PEND) begin
						DBUS_RD <= 1;
						DBUS_RD_EXT <= 1;
					end
				end
				
				1'b1: begin
					WRITE_LATCH <= 0;
					if (READ_LATCH || WRITE_LATCH || FETCH_LATCH) begin
						DBUS_RD <= 0;
						DBUS_RD_EXT <= 0;
						DBUS_WE <= 0;
						DBUS_RAS <= 0;
					end
					
					if (!MC_READ_PEND && !MC_WRITE_PEND && !MC_WRITE_PEND2 && !MC_FETCH_PEND && !MC_SCRREF_PEND) begin
						MC_STATE <= 0;
					end
					if (MC_WRITE_PEND || MC_WRITE_PEND2) begin
						DBUS_WE <= 1;
						DBUS_RAS <= 1;
					end
				end
				endcase
			end
			end // Only architectural/bus state is EN-gated.
			VRAM_REQUEST <= vram_request_next;
		end
	end
	assign WAIT = MC_READ_WAIT || MC_WRITE_WAIT || MC_FETCH_WAIT || MC_SCRREF_WAIT;
	assign DIN = DIN_EARLY;
	assign DIN_F = DIN_BUF;
	assign CACHE_WR = FETCH_LATCH;
	
	always_comb begin
		if (!MC_EXT_WORD)
			DBUS_DO <= OutAligner   (DOUT_BUF, DATA_OLD, DBUS_A[4:0], DOUT_FS);
		else
			DBUS_DO <= OutAlignerExt(DOUT_BUF, DATA_OLD, DOUT_BA_OLD, DOUT_FS);
	end
		
`ifdef DEBUG
	assign DBG_DBUS_A = {DBUS_A[31:4],4'h0};
`endif
	
`ifndef SYNTHESIS
	// The original CE_F byte-enable register. DBUS_BE must equal it whenever
	// no launch is pending, and must be settled whenever a write strobe is up
	// without the read strobe.
	always @(posedge CLK) if (RST_N && EN) begin
		if (!WMASK_EXT_PEND) assert (MC_WMASK_EXT == WMASK_EXT_REF || !MC_WRITE_EXT)
			else $fatal(1,"late second-word write mask differs from the CE_F capture");
		if (!BE_PEND) assert (DBUS_BE == DBUS_BE_REF)
			else $fatal(1,"late byte enables differ from the CE_F launch value");
		if (DBUS_WE && !DBUS_RD) assert (!BE_PEND)
			else $fatal(1,"write strobe up before its byte enables settled");
	end
`endif
`ifndef SYNTHESIS
	// Reference: the original in-chain DBUS_A loads (WRITE after the PIX_WE
	// gate). DBUS_A may differ only while no transaction is launched or in
	// progress.
	always @(posedge CLK) if (RST_N && EN) begin
		if (DBUS_A !== DBUS_A_REF) begin
			assert (!MC_STATE && !DBUS_RAS && !MC_READ_PEND && !MC_WRITE_PEND && !MC_WRITE_PEND2 && !MC_FETCH_PEND && !MC_SCRREF_PEND)
				else $fatal(1,"DBUS_A differs from the gated reference during a transaction");
			if (CE_F) dbus_a_skips++;
		end
	end
`endif
endmodule
