module BT #(parameter DISPLAY_SERVICE_PAUSE = 0, parameter FG_FAST = 0)
(
	input              CLK,
	input              CLK2X,
	input              RST_N,
	input              EN,
	
	input              CE_F,
	input              CE_R,
	input              VCE_R,
	input              SCE_F,
	input              SCE_R,
	
	input              SERVICE,
	
	output     [22: 0] EADDR,
	output [4:0][22:0] EADDR_CANDIDATES,
	output [4:0]       EADDR_SELECT,
	output     [12: 0] NVRAM_ADDR,
	output     [31: 0] EDATA,
	output     [ 3: 0] EWE,
	output             EWE_ANY,
	output             ERD,
	input      [31: 0] EQ,
	input      [31: 0] FG_DDR_Q,
	input      [31: 0] NVRAM_Q,
	output             ERAM,
	output             EROM,
	output             EFG,
	// The CPU's own foreground-DDR class, without the sprite/hole-copy terms:
	// the external ready for the CPU bus is selected by this one.
	output             EFG_RDY,
	output             ENVRAM,
	output     [ 7: 0] NVRAM_DATA,
	output             NVRAM_WE,
	output             ESPR,
	input              ERDY,
	
	output     [17: 0] ESADDR,
	output     [63: 0] ESDATA,
	output             ESWR,
	output             ESRD,
	input      [63: 0] ESQ,
	input              ESTE,
	input              SRDY,
	
	output     [20: 0] BSMT_ROM_A,
	input      [ 7: 0] BSMT_ROM_DI,
	output             BSMT_ROM_RD,
	input      [14: 0] AUDIO_ROM_A,
	input      [15: 0] AUDIO_ROM_D,
	input              AUDIO_ROM_WR,
	
	input      [ 7: 0] SW1,
	input      [ 7: 0] P1,
	input      [ 7: 0] P2,
	input      [ 7: 0] P3,
	
	output     [ 7: 0] R,
	output     [ 7: 0] G,
	output     [ 7: 0] B,
	output             HS_N,
	output             VS_N,
	output             HBL_N,
	output             VBL_N,
	
	output     [15: 0] SL,
	output     [15: 0] SR,
	
	input      [ 2: 0] BG_EN,
	input      [ 2: 0] GRID_EN
	
`ifdef DEBUG
	,
	output     [15: 0] DBG_MISC,
	output             DBG_SCALE,
	output reg         DBG_FUNC_1,
	output reg         DBG_FUNC_2,
	output reg         DBG_FUNC_3,
	output reg         DBG_FUNC_D
`endif
	, output [3:0][31:0] EDATA_CANDIDATES
	, output [3:0] EDATA_SELECT
	, input wire PAUSE_REQUEST, CPU_HALTED, RAW_CE_F, RAW_CE_R
	, output wire PAUSE_READY
	// FG_FAST: foreground upper-half write-transfer beats for ddram's io path.
	, output wire EFAST_WE
	, output wire [27:1] EFAST_ADDR
	, output wire [63:0] EFAST_DATA
	, input wire EFAST_DONE
);

	bit [31: 0] LA;
	wire [31:0] BIT_ADDR;
	bit [31: 0] LDI;
	wire [31:0] LDI_CACHE_LATE;
	wire [31:0] LDI_CACHE_LATE_E;
	wire LDI_CACHE_MEM;
	wire LDI_CACHE_DDR;
	wire LDI_CACHE_DDR_BYTES;
	wire [31:0] LDI_CACHE_RAM_DATA;
	bit [31: 0] LDO;
	bit         RAS_N;
	bit [ 3: 0] CAS_N;
	bit         WE_N;
	bit         QE_N;
	wire CPU_WRITE_ANY_ALL, CPU_WRITE_ANY_FG;
	bit         RD_EXT;
	bit         LRDY;
	
	wire [3:0] CPU_ADDR_CLASS;
	wire [3:0] CPU_VRAM_REQUEST;
	wire VIDEO_EN;
	TMS34020 #(.DISPLAY_SERVICE_PAUSE(DISPLAY_SERVICE_PAUSE)) CPU (
		.CLK(CLK),
		.RST_N(RST_N),
		.EN(EN),
		
		.CE_F(CE_F),
		.CE_R(CE_R),
		.PAUSE_REQUEST(PAUSE_REQUEST), .CPU_HALTED(CPU_HALTED),
		.RAW_CE_F(RAW_CE_F), .RAW_CE_R(RAW_CE_R), .PAUSE_READY(PAUSE_READY),
	
		.RES_N(1),
		.NMI_N(1),
		.LINT1_N(1),
		.LINT2_N(1),
		
		.LA(LA),
		.ADDR_CLASS(CPU_ADDR_CLASS),
		.VRAM_REQUEST(CPU_VRAM_REQUEST),
		.BIT_ADDR(BIT_ADDR),
		.LDI(LDI),
		.LDI_CACHE_MEM(LDI_CACHE_MEM),
		.LDI_CACHE_DDR(LDI_CACHE_DDR),
		.LDI_CACHE_DDR_BYTES(LDI_CACHE_DDR_BYTES),
		.LDI_CACHE_DDR_DATA(FG_DDR_Q),
		.LDI_CACHE_RAM_DATA(LDI_CACHE_RAM_DATA),
		.LDI_CACHE_LATE(LDI_CACHE_LATE),
		.LDI_CACHE_LATE_E(LDI_CACHE_LATE_E),
		.LDO(LDO),
		.RAS_N(RAS_N),
		.CAS_N(CAS_N),
		.WE_N(WE_N),
		.QE_N(QE_N),
		.WRITE_ANY_ALL(CPU_WRITE_ANY_ALL),
		.WRITE_ANY_FG(CPU_WRITE_ANY_FG),
		.RD_EXT(RD_EXT),
		.ALTCH_N(),
		.LRDY(LRDY),
		
		.VCE_R(VCE_R),
		.HS_N(HS_N),
		.VS_N(VS_N),
		.HBL_N(HBL_N),
		.VBL_N(VBL_N),
		.VIDEO_EN(VIDEO_EN)
	);
			  
	bit          VCE_DIV;
	always @(posedge CLK or negedge RST_N) begin		
		if (!RST_N) begin
			VCE_DIV <= 0;
		end else begin
			// A row starts with its low background byte. Keep the divider in
			// the high phase during blanking, while the compositor preloads low.
			if (!HBL_N) VCE_DIV <= 1;
			else if (VCE_R) begin
				VCE_DIV <= ~VCE_DIV;
			end
		end
	end
	bit SC;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) SC <= 0;
		else SC <= VCE_DIV && VCE_R && HBL_N && VBL_N;
	end
	
	// Isolate the fast VRAM reset tree from the HPS download/address decode.
	reg VRAM_RST_N = 1'b0;
	always @(posedge CLK2X) VRAM_RST_N <= RST_N;
	// One same-cycle copy of the VRAM reset per consumer: the single register
	// fanned out to ~2000 loads and its routes failed timing.
	(* preserve, dont_merge *) reg [6:0] VRAM_RST_N_C = 7'd0;
	always @(posedge CLK2X) VRAM_RST_N_C <= {7{RST_N}};
	wire BG0_SEL = CPU_ADDR_CLASS[2];
	wire [7:0] BG0_ROW = LA[21:14] + SCROLL0[15:8];
	wire [7:0] BG0_COL = LA[11:4] + SCROLL0[7:0];
	wire [15: 0] BG0_A = LA[3:0] == 4'b0100 ? {BG0_ROW,BG0_COL} : {LA[21:14],LA[11:5],1'b0};
	bit  [15: 0] BG0_Q_0;
	bit  [15: 0] BG0_Q_1;
	bit  [15: 0] BG0_SQ;
	wire [1:0] BG0_SQ_NZ;
	wire [1:0] BG0_SQ_HIGH;
	bit          BG0_GRID;
	BG_VRAM #(.MEM_SCROLL_ADDER(1)) BG0_VRAM_0 (
		.CLK(CLK2X),
		.CPU_CLK(CLK),
		.RST_N(VRAM_RST_N_C[0]),
		
		.A(BG0_A),
		.CPU_A({LA[21:14],LA[11:5]}),
		.D({LDO[23:16],LDO[7:0]}),
		.Q(BG0_Q_0),
		.RAS_N(~CPU_VRAM_REQUEST[2]),
		.CAS_N({CAS_N[2],CAS_N[0]}),
		.WE_N(WE_N | ~CE_R),
		.OE_N(QE_N),
		.TRANSFER(LA[3:0] == 4'b0100),
		
		.SC(SC),
		.SE_N(0),
		.SQ(BG0_SQ[7:0]),
		.SQ_NZ(BG0_SQ_NZ[0]),
		.SQ_HIGH(BG0_SQ_HIGH[0]),
		.SCROLL_BASE({LA[21:14],LA[11:4]}),
		.SCROLL_OFFSET(SCROLL0),
		.SCROLL_TRANSFER(LA[3:0] == 4'b0100),
		
		.RDY(),
		
		.GRID(BG0_GRID)
	);
	
	BG_VRAM #(.MEM_SCROLL_ADDER(1)) BG0_VRAM_1 (
		.CLK(CLK2X),
		.CPU_CLK(CLK),
		.RST_N(VRAM_RST_N_C[1]),
		
		.A(BG0_A),
		.CPU_A({LA[21:14],LA[11:5]}),
		.D({LDO[31:24],LDO[15:8]}),
		.Q(BG0_Q_1),
		.RAS_N(~CPU_VRAM_REQUEST[2]),
		.CAS_N({CAS_N[3],CAS_N[1]}),
		.WE_N(WE_N | ~CE_R),
		.OE_N(QE_N),
		.TRANSFER(LA[3:0] == 4'b0100),
		
		.SC(SC),
		.SE_N(0),
		.SQ(BG0_SQ[15:8]),
		.SQ_NZ(BG0_SQ_NZ[1]),
		.SQ_HIGH(BG0_SQ_HIGH[1]),
		.SCROLL_BASE({LA[21:14],LA[11:4]}),
		.SCROLL_OFFSET(SCROLL0),
		.SCROLL_TRANSFER(LA[3:0] == 4'b0100),
		
		.RDY()
	);
	
	wire BG1_SEL = CPU_ADDR_CLASS[3];
	wire [7:0] BG1_ROW = LA[21:14] + SCROLL1[15:8];
	wire [7:0] BG1_COL = LA[11:4] + SCROLL1[7:0];
	wire [15: 0] BG1_A = LA[3:0] == 4'b0100 ? {BG1_ROW,BG1_COL} : {LA[21:14],LA[11:5],1'b0};
	bit  [15: 0] BG1_Q_0;
	bit  [15: 0] BG1_Q_1;
	bit  [15: 0] BG1_SQ;
	wire [1:0] BG1_SQ_NZ;
	wire [1:0] BG1_SQ_HIGH;
	bit          BG1_GRID;
	BG_VRAM #(.MEM_SCROLL_ADDER(1)) BG1_VRAM_0 (
		.CLK(CLK2X),
		.CPU_CLK(CLK),
		.RST_N(VRAM_RST_N_C[2]),
		
		.A(BG1_A),
		.CPU_A({LA[21:14],LA[11:5]}),
		.D({LDO[23:16],LDO[7:0]}),
		.Q(BG1_Q_0),
		.RAS_N(~CPU_VRAM_REQUEST[3]),
		.CAS_N({CAS_N[2],CAS_N[0]}),
		.WE_N(WE_N | ~CE_R),
		.OE_N(QE_N),
		.TRANSFER(LA[3:0] == 4'b0100),
		
		.SC(SC),
		.SE_N(0),
		.SQ(BG1_SQ[7:0]),
		.SQ_NZ(BG1_SQ_NZ[0]),
		.SQ_HIGH(BG1_SQ_HIGH[0]),
		.SCROLL_BASE({LA[21:14],LA[11:4]}),
		.SCROLL_OFFSET(SCROLL1),
		.SCROLL_TRANSFER(LA[3:0] == 4'b0100),
		
		.RDY(),
		
		.GRID(BG1_GRID)
	);
	
	BG_VRAM #(.MEM_SCROLL_ADDER(1)) BG1_VRAM_1 (
		.CLK(CLK2X),
		.CPU_CLK(CLK),
		.RST_N(VRAM_RST_N_C[3]),
		
		.A(BG1_A),
		.CPU_A({LA[21:14],LA[11:5]}),
		.D({LDO[31:24],LDO[15:8]}),
		.Q(BG1_Q_1),
		.RAS_N(~CPU_VRAM_REQUEST[3]),
		.CAS_N({CAS_N[3],CAS_N[1]}),
		.WE_N(WE_N | ~CE_R),
		.OE_N(QE_N),
		.TRANSFER(LA[3:0] == 4'b0100),
		
		.SC(SC),
		.SE_N(0),
		.SQ(BG1_SQ[15:8]),
		.SQ_NZ(BG1_SQ_NZ[1]),
		.SQ_HIGH(BG1_SQ_HIGH[1]),
		.SCROLL_BASE({LA[21:14],LA[11:4]}),
		.SCROLL_OFFSET(SCROLL1),
		.SCROLL_TRANSFER(LA[3:0] == 4'b0100),
		
		.RDY()
	);
	
	
	wire SPR_BUSY;
	wire SPR_DRAW_WE;
	wire [1:0] SPR_DRAW_PAGE_WE;
	wire [1:0][15:0] SPR_DRAW_BANK_WE, SPR_DRAW_RAM_BANK_WE;
	wire SPR_DRAW_PAGE;
	wire [16:0] SPR_DRAW_ADDR;
	wire [7:0] SPR_DRAW_DATA;
	wire [8:0] SPR_SOURCE_A;
	wire [15:0] SPR_SOURCE_Q;
	reg [1:0] SPR_DDR_STATE;
	wire SPR_DDR_REQ = SPR_DDR_STATE == 2'd1;
	wire SPR_DRAW_READY = !SPR_DRAW_ADDR[8] || SPR_DDR_STATE == 2'd3;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) SPR_DDR_STATE <= 0;
		else case (SPR_DDR_STATE)
			2'd0: if (SPR_DRAW_WE && SPR_DRAW_ADDR[8]) SPR_DDR_STATE <= 2'd1;
			2'd1: if (CE_R) SPR_DDR_STATE <= 2'd2;
			2'd2: if (SRDY) SPR_DDR_STATE <= 2'd3;
			2'd3: if (!SPR_DRAW_WE || CE_R) SPR_DDR_STATE <= 0;
		endcase
	end
	wire [3:0] SPR_SOURCE_NONZERO;
	BT_SPRITE_BLITTER #(.NONZERO_PREDECODE(1)) blitter (
		.CLK(CLK), .RST_N(RST_N), .CE_R(CE_R),
		.A(BIT_ADDR), .RAS_N(RAS_N), .WE_N(WE_N), .OE_N(QE_N),
		.SHIFT(LA[3:0] == 4'b0101),
		.CONTROL(SPR_CONTROL), .SOURCE_SCALE(SPR_SCALE0), .DEST_SCALE(SPR_SCALE1),
		.SHADOW(MISC_CONTROL[4]), .DEST_PAGE(DISP_CONTROL[15]),
		.DRAW_READY(SPR_DRAW_READY),
		.SOURCE_WORD(SPR_SOURCE_A), .SOURCE_DATA(SPR_SOURCE_Q), .SOURCE_NONZERO(SPR_SOURCE_NONZERO),
		.DRAW_PAGE(SPR_DRAW_PAGE),
		.DRAW_WE(SPR_DRAW_WE), .DRAW_PAGE_WE(SPR_DRAW_PAGE_WE), .DRAW_BANK_WE(SPR_DRAW_BANK_WE), .DRAW_RAM_BANK_WE(SPR_DRAW_RAM_BANK_WE), .DRAW_ADDR(SPR_DRAW_ADDR), .DRAW_DATA(SPR_DRAW_DATA),
		.BUSY(SPR_BUSY)
	);

	wire SPR_SEL = LA[3:0] == 4'b0101 ?
		(LA[31:26] & 6'b101111) == 6'b101010 : LA[31:23] == {8'hA8,1'b0};
	// The serial RAS accepts only nibble 5, so its decode uses that branch
	// directly instead of traversing the ordinary sprite-read select mux.
	(* keep *) wire SPR_SERIAL_SEL = (LA[31:26] & 6'b101111) == 6'b101010 && LA[3:0] == 4'b0101;
	bit  [31: 0] SPR_Q;
	bit  [15: 0] SPR_SQ;
	bit          SPR_RDY;
	wire FG0_COPY_WE, FG1_COPY_WE, FG0_COPY_RD, FG1_COPY_RD;
	wire [5:0] FG0_COPY_WA, FG1_COPY_WA, FG0_COPY_A, FG1_COPY_A;
	wire [63:0] FG0_COPY_DATA, FG1_COPY_DATA, CPU_SHIFT_Q;
	wire [1:0][63:0] FG_PACKET_D;
	wire [63:0] FG0_SHIFT_Q, FG1_SHIFT_Q;
	wire [1:0][3:0][63:0] FG_BANK_SHIFT_Q;
	wire CPU_SHIFT_BUSY;
	wire SPR_CPU_SHIFT_WE = FG0_COPY_WE | FG1_COPY_WE;
	wire SPR_COMPLETE_RDY, SPR_PACKET_IDLE, SPR_COMPLETE_RDY_L, SPR_PACKET_IDLE_L;
	SPR_VRAM #(.LOCAL_FG_Q(1), .REGISTERED_FG_BANK_Q(1), .FG_BANK_ADDR_PERMUTE(1), .LOCAL_FG_PACKET_D(1)) SPR_VRAM (
		.CLK(CLK2X),
		.RST_N(VRAM_RST_N_C[4]),
		
		.A({LA[22:14],LA[13:5]}),
		.D(LDO),
		.Q(SPR_Q),
		.RAS_N(RAS_N | ~SPR_SERIAL_SEL),
		.CAS_N(CAS_N),
		.WE_N(WE_N),
		.OE_N(QE_N),
		
		.SC(1'b0),
		.SE_N(0),
		.SQ(SPR_SQ),
		.BLIT_A(SPR_SOURCE_A), .BLIT_Q(SPR_SOURCE_Q), .BLIT_NONZERO(SPR_SOURCE_NONZERO),
		.CPU_SHIFT_WE(SPR_CPU_SHIFT_WE),
		.CPU_SHIFT_WA(FG0_COPY_WE ? FG0_COPY_WA : FG1_COPY_WA),
		.CPU_SHIFT_DATA(FG0_COPY_WE ? FG0_COPY_DATA : FG1_COPY_DATA),
		.FG_PACKET_D(FG_PACKET_D), .FG_PACKET_SELECT(FG0_COPY_WE),
		.CPU_SHIFT_BUSY(CPU_SHIFT_BUSY),
		.CPU_SHIFT_RD(FG0_COPY_RD | FG1_COPY_RD),
		.CPU_SHIFT_A(FG0_COPY_RD ? FG0_COPY_A : FG1_COPY_A),
		.CPU_SHIFT_Q(CPU_SHIFT_Q),
		.FG0_SHIFT_Q(FG0_SHIFT_Q), .FG1_SHIFT_Q(FG1_SHIFT_Q), .FG_BANK_SHIFT_Q(FG_BANK_SHIFT_Q),
		
		.RDY(SPR_RDY),
		.COMPLETE_RDY(SPR_COMPLETE_RDY), .PACKET_IDLE(SPR_PACKET_IDLE), .COMPLETE_RDY_L(SPR_COMPLETE_RDY_L), .PACKET_IDLE_L(SPR_PACKET_IDLE_L),
		
		.ESADDR(ESADDR),
		.ESDATA(ESDATA),
		.ESWR(ESWR),
		.ESRD(ESRD),
		.ESQ(ESQ),
		.ESTE(ESTE)
	);
	
	wire [7:0] FG_SD = SPR_DRAW_DATA;
	wire [17:0] FG_A = LA[3:0] == 4'b0100 ?
		{LA[21:14],2'b00,LA[11:4]} : {BIT_ADDR[21:14],BIT_ADDR[13:4]};
	// Foreground holes always use DDR. SRDY is the direct DDR ready signal;
	// selecting it through the unrelated CPU address decode adds a late mux.
	// Every foreground use of HOLE_RDY implies HOLE_SEL, which also asserts EFG.
	wire [17:0] FG0_HOLE_A, FG1_HOLE_A;
	wire FG0_HOLE_SEL, FG1_HOLE_SEL, FG0_HOLE_RD, FG1_HOLE_RD;
	wire FG_HOLE_COPY = FG0_HOLE_SEL || FG1_HOLE_SEL;
`ifdef MISTER_CPU_PHASE_CHECK
	always @(negedge CLK2X) if (RST_N && FG_HOLE_COPY) begin
		assert (EFG)
			else $fatal(1,"Foreground DDR copy without the foreground DDR class");
	end
`endif
	wire [3:0] FG0_HOLE_WE, FG1_HOLE_WE;
	wire [31:0] FG0_HOLE_DATA, FG1_HOLE_DATA;
	wire FG_DISP_SEL = FG_CPU_ADDR_MATCH && !LA[26];
	wire FG_DISP_SC = SC;
	wire FG_DISP_SE_N = 1'b0;
	
	wire FG_DRAW_SEL = FG_CPU_ADDR_MATCH && LA[26];
	wire FG_DRAW_SC = 1'b0;
	wire FG_DRAW_SE_N = 1'b1;
	
	// The display/draw regions differ only in address bit 26. Decode the
	// common class before routing it to the selected physical foreground bank.
	wire FG_CPU_ADDR_MATCH = CPU_ADDR_CLASS[0] ||
		(LA[3:0] == 4'b0101 && CPU_ADDR_CLASS[1]);
	wire FG0_SEL = FG_CPU_ADDR_MATCH && (LA[26] ^ DISP_CONTROL[15]);
	wire FG0_SCRN = DISP_CONTROL[15] ? (LA[3:0] == 4'b0100) : 1'b0;
	wire FG0_SC = DISP_CONTROL[15] ? FG_DISP_SC : FG_DRAW_SC;
	wire FG0_SE_N = DISP_CONTROL[15] ? FG_DISP_SE_N : FG_DRAW_SE_N;
	bit  [15: 0] FG0_Q;
	bit          FG0_RDY;
	bit  [ 7: 0] FG0_SQ, FG0_SQ_M;
	wire FG0_FAST_WE, FG1_FAST_WE;
	wire [16:0] FG0_FAST_WORD, FG1_FAST_WORD;
	wire [63:0] FG0_FAST_DATA, FG1_FAST_DATA;
	// Only one foreground bank runs a CPU write transfer at a time. The DDR
	// address follows the hole map: bank bit 25, physical page, hole word.
	assign EFAST_WE = FG0_FAST_WE || FG1_FAST_WE;
	wire [16:0] FG_FAST_WORD = FG1_FAST_WE ? FG1_FAST_WORD : FG0_FAST_WORD;
	assign EFAST_ADDR = {2'b00,1'b1,4'b0000,1'b0,FG1_FAST_WE,FG_FAST_WORD,1'b0}; // byte address bits 27:1
	assign EFAST_DATA = FG1_FAST_WE ? FG1_FAST_DATA : FG0_FAST_DATA;
	FG_VRAM #(.REGISTERED_FG_BANK_Q(1), .FAST_UPPER(FG_FAST)) FG0_VRAM (
		.CLK(CLK2X),
		.CPU_CLK(CLK),
		.RST_N(VRAM_RST_N_C[5]),
		
		.A(FG_A),
		.D({LDO[23:16],LDO[7:0]}),
		.Q(FG0_Q),
		.RAS_N(~(DISP_CONTROL[15] ? CPU_VRAM_REQUEST[0] : CPU_VRAM_REQUEST[1])),
		.CAS_N({CAS_N[2],CAS_N[0]}),
		.WE_N(WE_N),
		.OE_N(QE_N),
		
		.SC(FG0_SC),
		.SE_N(FG0_SE_N),
		.SD(FG_SD),
		.SQ(FG0_SQ_M),
		.DRAW_WE(SPR_DRAW_PAGE_WE[0]),
		.DRAW_BANK_WE(SPR_DRAW_BANK_WE[0]), .DRAW_RAM_BANK_WE(SPR_DRAW_RAM_BANK_WE[0]),
		.DRAW_ADDR(SPR_DRAW_ADDR), .DRAW_DATA(SPR_DRAW_DATA),
		.TRANSFER((LA[3:0] == 4'b0101 && CPU_ADDR_CLASS[1] && !LA[26]) || LA[3:0] == 4'b0100),
		.CPU_SHIFT(LA[3:0] == 4'b0101), .CPU_SHIFT_Q(FG0_SHIFT_Q), .CPU_SHIFT_BANK_Q(FG_BANK_SHIFT_Q[0]),
		.MEM_CE(CE_R), .HOLE_A(FG0_HOLE_A), .HOLE_SEL(FG0_HOLE_SEL),
		.HOLE_RD(FG0_HOLE_RD), .HOLE_WE(FG0_HOLE_WE), .HOLE_DATA(FG0_HOLE_DATA),
		.HOLE_Q(FG_DDR_Q), .HOLE_RDY(SRDY),
		.CPU_SHIFT_A(FG0_COPY_A), .CPU_SHIFT_RD(FG0_COPY_RD),
		.CPU_SHIFT_WA(FG0_COPY_WA), .CPU_SHIFT_DATA(FG0_COPY_DATA), .CPU_SHIFT_WE(FG0_COPY_WE),
		.CPU_SHIFT_SOURCE_D(FG_PACKET_D[0]),
		.FAST_WE(FG0_FAST_WE), .FAST_WORD(FG0_FAST_WORD), .FAST_DATA(FG0_FAST_DATA), .FAST_DONE(EFAST_DONE),
		
		.RDY(FG0_RDY)
	);
	
	wire FG1_SEL = FG_CPU_ADDR_MATCH && !(LA[26] ^ DISP_CONTROL[15]);
	wire FG1_SCRN = DISP_CONTROL[15] ? 1'b0 : (LA[3:0] == 4'b0100);
	wire FG1_SC = DISP_CONTROL[15] ? FG_DRAW_SC : FG_DISP_SC;
	wire FG1_SE_N = DISP_CONTROL[15] ? FG_DRAW_SE_N : FG_DISP_SE_N;
	bit  [15:0] FG1_Q;
	bit         FG1_RDY;
	bit  [ 7:0] FG1_SQ, FG1_SQ_M;
	FG_VRAM #(.REGISTERED_FG_BANK_Q(1), .FAST_UPPER(FG_FAST)) FG1_VRAM(
		.CLK(CLK2X),
		.CPU_CLK(CLK),
		.RST_N(VRAM_RST_N_C[6]),
		
		.A(FG_A),
		.D({LDO[23:16],LDO[7:0]}),
		.Q(FG1_Q),
		.RAS_N(~(DISP_CONTROL[15] ? CPU_VRAM_REQUEST[1] : CPU_VRAM_REQUEST[0])),
		.CAS_N({CAS_N[2],CAS_N[0]}),
		.WE_N(WE_N),
		.OE_N(QE_N),
		
		.SC(FG1_SC),
		.SE_N(FG1_SE_N),
		.SD(FG_SD),
		.SQ(FG1_SQ_M),
		.DRAW_WE(SPR_DRAW_PAGE_WE[1]),
		.DRAW_BANK_WE(SPR_DRAW_BANK_WE[1]), .DRAW_RAM_BANK_WE(SPR_DRAW_RAM_BANK_WE[1]),
		.DRAW_ADDR(SPR_DRAW_ADDR), .DRAW_DATA(SPR_DRAW_DATA),
		.TRANSFER((LA[3:0] == 4'b0101 && CPU_ADDR_CLASS[1] && !LA[26]) || LA[3:0] == 4'b0100),
		.CPU_SHIFT(LA[3:0] == 4'b0101), .CPU_SHIFT_Q(FG1_SHIFT_Q), .CPU_SHIFT_BANK_Q(FG_BANK_SHIFT_Q[1]),
		.MEM_CE(CE_R), .HOLE_A(FG1_HOLE_A), .HOLE_SEL(FG1_HOLE_SEL),
		.HOLE_RD(FG1_HOLE_RD), .HOLE_WE(FG1_HOLE_WE), .HOLE_DATA(FG1_HOLE_DATA),
		.HOLE_Q(FG_DDR_Q), .HOLE_RDY(SRDY),
		.CPU_SHIFT_A(FG1_COPY_A), .CPU_SHIFT_RD(FG1_COPY_RD),
		.CPU_SHIFT_WA(FG1_COPY_WA), .CPU_SHIFT_DATA(FG1_COPY_DATA), .CPU_SHIFT_WE(FG1_COPY_WE),
		.CPU_SHIFT_SOURCE_D(FG_PACKET_D[1]),
		.FAST_WE(FG1_FAST_WE), .FAST_WORD(FG1_FAST_WORD), .FAST_DATA(FG1_FAST_DATA), .FAST_DONE(EFAST_DONE),
		
		.RDY(FG1_RDY)
	);	
	
	
	// System-clock capture of the foreground serial bytes ahead of the
	// priority mixer: the memory-clock VRAM output no longer drives the
	// four-way priority decode within one memory clock. Each byte settles
	// several system clocks before the pixel enable that displays it.
	always @(posedge CLK) begin
		FG0_SQ <= FG0_SQ_M;
		FG1_SQ <= FG1_SQ_M;
	end
	// Parallel source masks preserve the original per-mode pixel priorities.
	function automatic bit [7:0] BT_SELECT_PIXEL;
		input logic [1:0] mode;
		input bit [7:0] spr, bg0, bg1, previous;
		input logic [2:0] enabled;
		input bit bg0_pixel_nz, bg1_pixel_nz, bg1_pixel_high;
		bit spr_nz, spr_low, spr_high, bg0_nz, bg1_nz, bg1_high;
		bit bg0_enabled, bg1_enabled, take_spr, take_bg0, take_bg1, valid;
		begin
			spr_nz = spr && enabled[2];
			spr_low = spr && !spr[7] && enabled[2];
			spr_high = spr[7] && enabled[2];
			bg0_nz = bg0_pixel_nz && enabled[0];
			bg1_nz = bg1_pixel_nz && enabled[1];
			bg1_high = bg1_pixel_high && enabled[1];
			bg0_enabled = enabled[0];
			bg1_enabled = enabled[1];
			take_spr = 0; take_bg0 = 0; take_bg1 = 0; valid = 1;
			case (mode)
				2'b00: begin
					take_spr = spr_low || (!bg1_high && spr_nz);
					take_bg1 = !spr_low && (bg1_high || (!spr_nz && bg1_nz));
					take_bg0 = !spr_nz && !bg1_nz && bg0_enabled;
				end
				2'b01: begin
					take_spr = spr_low || (!bg0_nz && !bg1_high && spr_nz);
					take_bg0 = !spr_low && bg0_nz;
					take_bg1 = !spr_low && !bg0_nz && (bg1_high || (!spr_nz && bg1_enabled));
				end
				2'b10: begin
					take_spr = spr_nz;
					take_bg1 = !spr_nz && bg1_nz;
					take_bg0 = !spr_nz && !bg1_nz && bg0_enabled;
				end
				2'b11: begin
					take_bg1 = bg1_high || (!spr_high && bg1_nz);
					take_spr = !bg1_high && (spr_high || (!bg1_nz && spr_nz));
					take_bg0 = !spr_nz && !bg1_nz && bg0_enabled;
				end
				default: valid = 0;
			endcase
			BT_SELECT_PIXEL = previous;
			if (valid) BT_SELECT_PIXEL = (spr & {8{take_spr}}) |
			                              (bg0 & {8{take_bg0}}) |
			                              (bg1 & {8{take_bg1}});
		end
	endfunction

	bit [ 7:0] PIX_OUT;
	always @(posedge CLK or negedge RST_N) begin
		bit [7:0] FG0_PIX;
		bit [7:0] BG0_PIX;
		bit [7:0] BG1_PIX;
		bit [7:0] SPR_PIX;
		bit BG0_PIX_NZ, BG1_PIX_NZ, BG1_PIX_HIGH;

		if (!RST_N) begin
			PIX_OUT <= '0;
		end else begin
			SPR_PIX = DISP_CONTROL[15] ? FG0_SQ : FG1_SQ;
			case (VCE_DIV && HBL_N)
				1'b0: begin
					BG0_PIX = BG0_SQ[ 7: 0];
					BG0_PIX_NZ = BG0_SQ_NZ[0];
				end
				1'b1: begin
					BG0_PIX = BG0_SQ[15: 8];
					BG0_PIX_NZ = BG0_SQ_NZ[1];
				end
			endcase
			case (VCE_DIV && HBL_N)
				1'b0: begin
					BG1_PIX = BG1_SQ[ 7: 0];
					BG1_PIX_NZ = BG1_SQ_NZ[0];
					BG1_PIX_HIGH = BG1_SQ_HIGH[0];
				end
				1'b1: begin
					BG1_PIX = BG1_SQ[15: 8];
					BG1_PIX_NZ = BG1_SQ_NZ[1];
					BG1_PIX_HIGH = BG1_SQ_HIGH[1];
				end
			endcase;
		
			PIX_OUT <= BT_SELECT_PIXEL(DISP_CONTROL[9:8], SPR_PIX, BG0_PIX, BG1_PIX, PIX_OUT, BG_EN,
			                           BG0_PIX_NZ,BG1_PIX_NZ,BG1_PIX_HIGH);
		end
	end
	
	//Misc/sound control
	wire MISC_SEL = (LA[31:4] >= 28'h2000000 && LA[31:4] <= 28'h200007F);
	bit [15: 0] SPR_SCALE0,SPR_SCALE1;
	bit [15: 0] SPR_CONTROL;
	bit [15: 0] DISP_CONTROL;
	bit [15: 0] SCROLL0,SCROLL1;
	bit [ 7: 0] PAL_WADDR;
	bit [ 7: 0] PAL_RADDR;
	bit [ 7: 0] PAL_MASK;
	bit [ 7: 0] PAL_READ_DATA;
	bit [23: 0] PAL_WDATA;
	bit [ 1: 0] PAL_RBYTE;
	bit         PAL_ACCESSED;
	bit [15: 0] MISC_CONTROL;
	bit         Z80_CTRL_DATA_WRITE;
	bit         Z80_RESP_DATA_READ;
	
	bit [ 7: 0] PAL_RAM_A;
	bit         PAL_RAM_WE;
	wire PAL_ACCESS = MISC_SEL && !RAS_N && LA[11:7] == 5'b00110;
	always @(posedge CLK or negedge RST_N) begin
		bit [ 1: 0] PAL_BYTE_CNT;
		
		if (!RST_N) begin
			SPR_SCALE0 <= '0;
			SPR_SCALE1 <= '0;
			SPR_CONTROL <= '0;
			DISP_CONTROL <= '0;
			SCROLL0 <= '0;
			SCROLL1 <= '0;
			PAL_WADDR <= '0;
			PAL_RADDR <= '0;
			PAL_MASK <= 8'hFF;
			PAL_READ_DATA <= '0;
			PAL_BYTE_CNT <= '0;
			PAL_RBYTE <= '0;
			PAL_ACCESSED <= 0;
			PAL_WDATA <= '0;
			PAL_RAM_A <= '0;
			MISC_CONTROL <= '0;
			PAL_RAM_WE <= 0;
		end
		else begin
			if (!PAL_ACCESS) PAL_ACCESSED <= 0;
			else if (CE_R && (!WE_N || !QE_N)) PAL_ACCESSED <= 1;
		if (CE_R) begin
			PAL_RAM_WE <= 0;
			Z80_CTRL_DATA_WRITE <= 0;
			Z80_RESP_DATA_READ <= 0;
			
			if (MISC_SEL && !WE_N) begin
				case ({LA[11:5],5'b00000})
					12'h000: begin
						if (!CAS_N[0]) SPR_SCALE0[7:0] <= LDO[7:0];
						if (!CAS_N[1]) SPR_SCALE0[15:8] <= LDO[15:8];
					end
					12'h080: begin
						if (!CAS_N[0]) SPR_SCALE1[7:0] <= LDO[7:0];
						if (!CAS_N[1]) SPR_SCALE1[15:8] <= LDO[15:8];
					end
					12'h100: begin
						if (!CAS_N[0]) SPR_CONTROL[7:0] <= LDO[7:0];
						if (!CAS_N[1]) SPR_CONTROL[15:8] <= LDO[15:8];
					end
					12'h180: if (!CAS_N[1]) DISP_CONTROL[15:8] <= LDO[15:8];
					12'h200: begin
						if (!CAS_N[0]) SCROLL0[7:0] <= LDO[7:0];
						if (!CAS_N[1]) SCROLL0[15:8] <= LDO[15:8];
					end
					12'h280: begin
						if (!CAS_N[0]) SCROLL1[7:0] <= LDO[7:0];
						if (!CAS_N[1]) SCROLL1[15:8] <= LDO[15:8];
					end
					12'h300: if (!PAL_ACCESSED && !CAS_N[0]) begin //tlc34076 reg0
						PAL_WADDR <= LDO[7:0]; 
						PAL_BYTE_CNT <= 2'd0;
					end
					12'h320: if (!PAL_ACCESSED && !CAS_N[0]) begin	//tlc34076 reg1
						case (PAL_BYTE_CNT)
							2'd0: PAL_WDATA[23:16] <= LDO[7:0];
							2'd1: PAL_WDATA[15: 8] <= LDO[7:0];
							2'd2: PAL_WDATA[ 7: 0] <= LDO[7:0];
							default:;
						endcase
						PAL_BYTE_CNT <= PAL_BYTE_CNT + 2'd1;
						if (PAL_BYTE_CNT == 2'd2) begin
							PAL_BYTE_CNT <= 2'd0;
							PAL_WADDR <= PAL_WADDR + 8'd1;
							PAL_RAM_A <= PAL_WADDR;
							PAL_RAM_WE <= 1;
						end
					end
					12'h340: if (!PAL_ACCESSED && !CAS_N[0]) PAL_MASK <= LDO[7:0];
					12'h360: if (!PAL_ACCESSED && !CAS_N[0]) begin
						PAL_RADDR <= LDO[7:0];
						PAL_RBYTE <= 0;
					end
					12'h380: begin Z80_CTRL_DATA <= LDO[7:0]; Z80_CTRL_DATA_WRITE <= 1; end
					12'h400: begin
						if (!CAS_N[0]) MISC_CONTROL[7:0] <= LDO[7:0];
						if (!CAS_N[1]) MISC_CONTROL[15:8] <= LDO[15:8];
					end
					default: ;
				endcase
			end
			if (MISC_SEL && !QE_N) begin
				case ({LA[11:5],5'b00000})
					12'h320: if (!PAL_ACCESSED) begin
						case (PAL_RBYTE)
							0: begin
								PAL_WDATA <= IO_PAL_Q;
								PAL_READ_DATA <= IO_PAL_Q[23:16];
							end
							1: PAL_READ_DATA <= PAL_WDATA[15:8];
							2: PAL_READ_DATA <= PAL_WDATA[7:0];
							default: ;
						endcase
						if (PAL_RBYTE == 2) begin
							PAL_RBYTE <= 0;
							PAL_RADDR <= PAL_RADDR + 8'd1;
						end else PAL_RBYTE <= PAL_RBYTE + 2'd1;
					end
					12'h380: Z80_RESP_DATA_READ <= 1;
					default: ;
				endcase
			end
		end
		end
	end

	// Preserve raw DAC bytes for CPU readback; only display conversion truncates
	// them to six bits. MAME blacks out disallowed pens rather than remapping them.
	wire [23:0] PAL_Q;
	wire [23:0] IO_PAL_Q;
	bit [7:0] PAL_PIXEL;
	always @(posedge CLK) PAL_PIXEL <= PIX_OUT;
	dpram #(8,24) pal_ram
	(
		.clock(CLK),
		.address_a(PAL_RAM_WE ? PAL_RAM_A : PAL_RADDR),
		.data_a(PAL_WDATA),
		.wren_a(PAL_RAM_WE & CE_R),
		.q_a(IO_PAL_Q),

		.address_b(PIX_OUT),
		.data_b('0),
		.wren_b(0),
		.q_b(PAL_Q)
	);

	// Predict the existing palette register's value after this R edge.
	// The clocked block intentionally has no EN guard; preserve that contract.
	bit [7:0] PAL_READ_DATA_E;
	always_comb begin
	    PAL_READ_DATA_E = PAL_READ_DATA;
	    if (!RST_N) PAL_READ_DATA_E = 8'd0;
	    else if (CE_R && MISC_SEL && !QE_N && !PAL_ACCESSED &&
	             {LA[11:5],5'b00000} == 12'h320) begin
	        case (PAL_RBYTE)
	            2'd0: PAL_READ_DATA_E = IO_PAL_Q[23:16];
	            2'd1: PAL_READ_DATA_E = PAL_WDATA[15:8];
	            2'd2: PAL_READ_DATA_E = PAL_WDATA[7:0];
	            default: ;
	        endcase
	    end
	end

	bit [ 7: 0] MISC_DO;
	always_comb begin
		case ({LA[11:5],5'b00000})
			12'h000: MISC_DO = P1;
			12'h080: MISC_DO = P2;
			12'h100: MISC_DO = P3;
			12'h180: MISC_DO = 8'hFF;
			12'h200: MISC_DO = {Z80_CTRL_RDY,5'b00000,SERVICE,Z80_RESP_RDY};
			12'h280: MISC_DO = SW1;
			12'h300: MISC_DO = PAL_WADDR;
			12'h320: MISC_DO = PAL_READ_DATA;
			12'h340: MISC_DO = PAL_MASK;
			12'h360: MISC_DO = PAL_RADDR;
			12'h380: MISC_DO = Z80_RESP_DATA; 
			default: MISC_DO = 8'hFF;
		endcase
	end

	
	// Parallel data gates preserve the original priority even when a shift
	// transfer overlaps a CPU address change, without a seven-level data mux.
	wire [7:0] LDI_SELECT_NEXT = {
	    !MISC_SEL && !EFG && !SPR_SEL && !FG0_SEL && !FG1_SEL && !BG0_SEL && !BG1_SEL,
	    !MISC_SEL && !EFG && !SPR_SEL && !FG0_SEL && !FG1_SEL && !BG0_SEL && BG1_SEL,
	    !MISC_SEL && !EFG && !SPR_SEL && !FG0_SEL && !FG1_SEL && BG0_SEL,
	    !MISC_SEL && !EFG && !SPR_SEL && !FG0_SEL && FG1_SEL,
	    !MISC_SEL && !EFG && !SPR_SEL && FG0_SEL,
	    !MISC_SEL && !EFG && SPR_SEL,
	    !MISC_SEL && EFG,
	    MISC_SEL};
	bit [7:0] LDI_SELECT;
	bit LDI_EXTERNAL_VALID;
	always @(posedge CLK) begin
	    LDI_SELECT <= LDI_SELECT_NEXT;
	    LDI_EXTERNAL_VALID <= ERAM || EROM || ENVRAM;
	end
	// Each data source remains live: palette read side effects and memory
	// writes can change its value after the selector publication edge.
	assign LDI = ({32{LDI_SELECT[0]}} & {24'h000000,MISC_DO}) |
	             ({32{LDI_SELECT[1]}} & EQ & 32'h00ff00ff) |
	             ({32{LDI_SELECT[2]}} & EQ) |
	             ({32{LDI_SELECT[3]}} & {8'h00,FG0_Q[15:8],8'h00,FG0_Q[7:0]}) |
	             ({32{LDI_SELECT[4]}} & {8'h00,FG1_Q[15:8],8'h00,FG1_Q[7:0]}) |
	             ({32{LDI_SELECT[5]}} & {BG0_Q_1[15:8],BG0_Q_0[15:8],BG0_Q_1[7:0],BG0_Q_0[7:0]}) |
	             ({32{LDI_SELECT[6]}} & {BG1_Q_1[15:8],BG1_Q_0[15:8],BG1_Q_1[7:0],BG1_Q_0[7:0]}) |
	             ({32{LDI_SELECT[7]}} & (LDI_EXTERNAL_VALID ? EQ : 32'hffffffff));

	// Only memory-owned returns are sampled at the cache's preparing R edge.
	// Late palette, NVRAM and CPU-local IO values retain their F-edge semantics.
	// DDR bypasses the return-priority mux before the SYS holding registers.
	// Its EFG byte mask is captured and applied after those registers.
	assign LDI_CACHE_DDR = !ENVRAM && (LDI_SELECT[1] || LDI_SELECT[2] ||
	                         (LDI_SELECT[7] && LDI_EXTERNAL_VALID));
	assign LDI_CACHE_DDR_BYTES = LDI_SELECT[1];
	assign LDI_CACHE_MEM = |LDI_SELECT[6:3] || LDI_CACHE_DDR;
	assign LDI_CACHE_RAM_DATA =
	    ({32{LDI_SELECT[3]}} & {8'h00,FG0_Q[15:8],8'h00,FG0_Q[7:0]}) |
	    ({32{LDI_SELECT[4]}} & {8'h00,FG1_Q[15:8],8'h00,FG1_Q[7:0]}) |
	    ({32{LDI_SELECT[5]}} & {BG0_Q_1[15:8],BG0_Q_0[15:8],BG0_Q_1[7:0],BG0_Q_0[7:0]}) |
	    ({32{LDI_SELECT[6]}} & {BG1_Q_1[15:8],BG1_Q_0[15:8],BG1_Q_1[7:0],BG1_Q_0[7:0]});
	// This separate bus has no DDR/foreground/background data input. A full
	// live-return mux here would retain those physical paths into RF predecode.
	assign LDI_CACHE_LATE =
	    ({32{LDI_SELECT[0]}} & {24'd0,MISC_DO}) |
	    ({32{LDI_SELECT[1] && ENVRAM}} & NVRAM_Q & 32'h00ff00ff) |
	    ({32{ENVRAM && (LDI_SELECT[2] || (LDI_SELECT[7] && LDI_EXTERNAL_VALID))}} & NVRAM_Q) |
	    ({32{LDI_SELECT[7] && !LDI_EXTERNAL_VALID}} & 32'hffffffff);
	wire [7:0] MISC_DO_E = ({LA[11:5],5'b00000} == 12'h320) ?
	    PAL_READ_DATA_E : MISC_DO;
	assign LDI_CACHE_LATE_E =
	    ({32{LDI_SELECT[0]}} & {24'd0,MISC_DO_E}) |
	    ({32{LDI_SELECT[1] && ENVRAM}} & NVRAM_Q & 32'h00ff00ff) |
	    ({32{ENVRAM && (LDI_SELECT[2] || (LDI_SELECT[7] && LDI_EXTERNAL_VALID))}} & NVRAM_Q) |
	    ({32{LDI_SELECT[7] && !LDI_EXTERNAL_VALID}} & 32'hffffffff);
`ifdef MISTER_CPU_PHASE_CHECK
	// synthesis translate_off

	always @(posedge CLK) if (RST_N) begin
	    assert (LDI_CACHE_MEM == (|LDI_SELECT[6:3] ||
	        (!ENVRAM && (LDI_SELECT[1] || LDI_SELECT[2] || (LDI_SELECT[7] && LDI_EXTERNAL_VALID)))))
	        else $fatal(1,"Split return eligibility differs from the unchanged prior predicate");
	end
	always @(posedge CLK) if (RST_N && LDI_CACHE_MEM && !CPU.IO_SEL) begin
	    assert ((LDI_CACHE_DDR ? (FG_DDR_Q & (LDI_CACHE_DDR_BYTES ? 32'h00ff00ff : 32'hffffffff)) : LDI_CACHE_RAM_DATA) == LDI)
	        else $fatal(1,"Split memory channels differ from the original sample-edge word");
	end

	// Exact physical return ownership at preparing R and consuming F.
	wire [127:0] CACHE_FG0_OWNER_0 = {16'd0,
	    FG0_VRAM.DRAW_WE_M,FG0_VRAM.WRITE_PENDING,FG0_VRAM.mem.ADDR,
	    FG0_VRAM.mem.banks[0].ram.WREN,(FG0_VRAM.mem.banks[0].ram.WREN ? FG0_VRAM.mem.banks[0].ram.BE : 2'd0),
	    (FG0_VRAM.mem.banks[0].ram.WREN ? FG0_VRAM.mem.banks[0].ram.DATA : 16'd0),FG0_VRAM.mem.banks[0].ram.SWREN,
	    (FG0_VRAM.mem.banks[0].ram.SWREN ? FG0_VRAM.mem.banks[0].ram.SADDR : 11'd0),
	    (FG0_VRAM.mem.banks[0].ram.SWREN ? FG0_VRAM.mem.banks[0].ram.SDATA : 64'd0)};
	wire [127:0] CACHE_FG0_OWNER_1 = {16'd0,
	    FG0_VRAM.DRAW_WE_M,FG0_VRAM.WRITE_PENDING,FG0_VRAM.mem.ADDR,
	    FG0_VRAM.mem.banks[1].ram.WREN,(FG0_VRAM.mem.banks[1].ram.WREN ? FG0_VRAM.mem.banks[1].ram.BE : 2'd0),
	    (FG0_VRAM.mem.banks[1].ram.WREN ? FG0_VRAM.mem.banks[1].ram.DATA : 16'd0),FG0_VRAM.mem.banks[1].ram.SWREN,
	    (FG0_VRAM.mem.banks[1].ram.SWREN ? FG0_VRAM.mem.banks[1].ram.SADDR : 11'd0),
	    (FG0_VRAM.mem.banks[1].ram.SWREN ? FG0_VRAM.mem.banks[1].ram.SDATA : 64'd0)};
	wire [127:0] CACHE_FG0_OWNER_2 = {16'd0,
	    FG0_VRAM.DRAW_WE_M,FG0_VRAM.WRITE_PENDING,FG0_VRAM.mem.ADDR,
	    FG0_VRAM.mem.banks[2].ram.WREN,(FG0_VRAM.mem.banks[2].ram.WREN ? FG0_VRAM.mem.banks[2].ram.BE : 2'd0),
	    (FG0_VRAM.mem.banks[2].ram.WREN ? FG0_VRAM.mem.banks[2].ram.DATA : 16'd0),FG0_VRAM.mem.banks[2].ram.SWREN,
	    (FG0_VRAM.mem.banks[2].ram.SWREN ? FG0_VRAM.mem.banks[2].ram.SADDR : 11'd0),
	    (FG0_VRAM.mem.banks[2].ram.SWREN ? FG0_VRAM.mem.banks[2].ram.SDATA : 64'd0)};
	wire [127:0] CACHE_FG0_OWNER_3 = {16'd0,
	    FG0_VRAM.DRAW_WE_M,FG0_VRAM.WRITE_PENDING,FG0_VRAM.mem.ADDR,
	    FG0_VRAM.mem.banks[3].ram.WREN,(FG0_VRAM.mem.banks[3].ram.WREN ? FG0_VRAM.mem.banks[3].ram.BE : 2'd0),
	    (FG0_VRAM.mem.banks[3].ram.WREN ? FG0_VRAM.mem.banks[3].ram.DATA : 16'd0),FG0_VRAM.mem.banks[3].ram.SWREN,
	    (FG0_VRAM.mem.banks[3].ram.SWREN ? FG0_VRAM.mem.banks[3].ram.SADDR : 11'd0),
	    (FG0_VRAM.mem.banks[3].ram.SWREN ? FG0_VRAM.mem.banks[3].ram.SDATA : 64'd0)};
	wire [127:0] CACHE_FG0_OWNER = FG0_VRAM.mem.ADDR[15:14]==0 ? CACHE_FG0_OWNER_0 :
	    FG0_VRAM.mem.ADDR[15:14]==1 ? CACHE_FG0_OWNER_1 :
	    FG0_VRAM.mem.ADDR[15:14]==2 ? CACHE_FG0_OWNER_2 : CACHE_FG0_OWNER_3;
	bit [127:0] CACHE_FG0_OWNER_1M,CACHE_FG0_OWNER_2M;
	always @(posedge CLK2X) begin
	    CACHE_FG0_OWNER_1M <= CACHE_FG0_OWNER;
	    CACHE_FG0_OWNER_2M <= CACHE_FG0_OWNER_1M;
	end
	wire [127:0] CACHE_BG0_0_OWNER = {15'd0,
	    BG0_VRAM_0.WRITE_PENDING,BG0_VRAM_0.mem.ADDR,BG0_VRAM_0.mem.WREN,
	    (BG0_VRAM_0.mem.WREN ? BG0_VRAM_0.mem.BE : 2'd0),(BG0_VRAM_0.mem.WREN ? BG0_VRAM_0.mem.DATA : 16'd0),
	    BG0_VRAM_0.mem.SWREN,(BG0_VRAM_0.mem.SWREN ? BG0_VRAM_0.mem.SADDR : 13'd0),
	    (BG0_VRAM_0.mem.SWREN ? BG0_VRAM_0.mem.SDATA : 64'd0)};
	bit [127:0] CACHE_BG0_0_OWNER_1M,CACHE_BG0_0_OWNER_2M;
	always @(posedge CLK2X) begin
	    CACHE_BG0_0_OWNER_1M <= CACHE_BG0_0_OWNER;
	    CACHE_BG0_0_OWNER_2M <= CACHE_BG0_0_OWNER_1M;
	end
	wire [127:0] CACHE_BG0_1_OWNER = {15'd0,
	    BG0_VRAM_1.WRITE_PENDING,BG0_VRAM_1.mem.ADDR,BG0_VRAM_1.mem.WREN,
	    (BG0_VRAM_1.mem.WREN ? BG0_VRAM_1.mem.BE : 2'd0),(BG0_VRAM_1.mem.WREN ? BG0_VRAM_1.mem.DATA : 16'd0),
	    BG0_VRAM_1.mem.SWREN,(BG0_VRAM_1.mem.SWREN ? BG0_VRAM_1.mem.SADDR : 13'd0),
	    (BG0_VRAM_1.mem.SWREN ? BG0_VRAM_1.mem.SDATA : 64'd0)};
	bit [127:0] CACHE_BG0_1_OWNER_1M,CACHE_BG0_1_OWNER_2M;
	always @(posedge CLK2X) begin
	    CACHE_BG0_1_OWNER_1M <= CACHE_BG0_1_OWNER;
	    CACHE_BG0_1_OWNER_2M <= CACHE_BG0_1_OWNER_1M;
	end
	wire [127:0] CACHE_FG1_OWNER_0 = {16'd0,
	    FG1_VRAM.DRAW_WE_M,FG1_VRAM.WRITE_PENDING,FG1_VRAM.mem.ADDR,
	    FG1_VRAM.mem.banks[0].ram.WREN,(FG1_VRAM.mem.banks[0].ram.WREN ? FG1_VRAM.mem.banks[0].ram.BE : 2'd0),
	    (FG1_VRAM.mem.banks[0].ram.WREN ? FG1_VRAM.mem.banks[0].ram.DATA : 16'd0),FG1_VRAM.mem.banks[0].ram.SWREN,
	    (FG1_VRAM.mem.banks[0].ram.SWREN ? FG1_VRAM.mem.banks[0].ram.SADDR : 11'd0),
	    (FG1_VRAM.mem.banks[0].ram.SWREN ? FG1_VRAM.mem.banks[0].ram.SDATA : 64'd0)};
	wire [127:0] CACHE_FG1_OWNER_1 = {16'd0,
	    FG1_VRAM.DRAW_WE_M,FG1_VRAM.WRITE_PENDING,FG1_VRAM.mem.ADDR,
	    FG1_VRAM.mem.banks[1].ram.WREN,(FG1_VRAM.mem.banks[1].ram.WREN ? FG1_VRAM.mem.banks[1].ram.BE : 2'd0),
	    (FG1_VRAM.mem.banks[1].ram.WREN ? FG1_VRAM.mem.banks[1].ram.DATA : 16'd0),FG1_VRAM.mem.banks[1].ram.SWREN,
	    (FG1_VRAM.mem.banks[1].ram.SWREN ? FG1_VRAM.mem.banks[1].ram.SADDR : 11'd0),
	    (FG1_VRAM.mem.banks[1].ram.SWREN ? FG1_VRAM.mem.banks[1].ram.SDATA : 64'd0)};
	wire [127:0] CACHE_FG1_OWNER_2 = {16'd0,
	    FG1_VRAM.DRAW_WE_M,FG1_VRAM.WRITE_PENDING,FG1_VRAM.mem.ADDR,
	    FG1_VRAM.mem.banks[2].ram.WREN,(FG1_VRAM.mem.banks[2].ram.WREN ? FG1_VRAM.mem.banks[2].ram.BE : 2'd0),
	    (FG1_VRAM.mem.banks[2].ram.WREN ? FG1_VRAM.mem.banks[2].ram.DATA : 16'd0),FG1_VRAM.mem.banks[2].ram.SWREN,
	    (FG1_VRAM.mem.banks[2].ram.SWREN ? FG1_VRAM.mem.banks[2].ram.SADDR : 11'd0),
	    (FG1_VRAM.mem.banks[2].ram.SWREN ? FG1_VRAM.mem.banks[2].ram.SDATA : 64'd0)};
	wire [127:0] CACHE_FG1_OWNER_3 = {16'd0,
	    FG1_VRAM.DRAW_WE_M,FG1_VRAM.WRITE_PENDING,FG1_VRAM.mem.ADDR,
	    FG1_VRAM.mem.banks[3].ram.WREN,(FG1_VRAM.mem.banks[3].ram.WREN ? FG1_VRAM.mem.banks[3].ram.BE : 2'd0),
	    (FG1_VRAM.mem.banks[3].ram.WREN ? FG1_VRAM.mem.banks[3].ram.DATA : 16'd0),FG1_VRAM.mem.banks[3].ram.SWREN,
	    (FG1_VRAM.mem.banks[3].ram.SWREN ? FG1_VRAM.mem.banks[3].ram.SADDR : 11'd0),
	    (FG1_VRAM.mem.banks[3].ram.SWREN ? FG1_VRAM.mem.banks[3].ram.SDATA : 64'd0)};
	wire [127:0] CACHE_FG1_OWNER = FG1_VRAM.mem.ADDR[15:14]==0 ? CACHE_FG1_OWNER_0 :
	    FG1_VRAM.mem.ADDR[15:14]==1 ? CACHE_FG1_OWNER_1 :
	    FG1_VRAM.mem.ADDR[15:14]==2 ? CACHE_FG1_OWNER_2 : CACHE_FG1_OWNER_3;
	bit [127:0] CACHE_FG1_OWNER_1M,CACHE_FG1_OWNER_2M;
	always @(posedge CLK2X) begin
	    CACHE_FG1_OWNER_1M <= CACHE_FG1_OWNER;
	    CACHE_FG1_OWNER_2M <= CACHE_FG1_OWNER_1M;
	end
	wire [127:0] CACHE_BG1_0_OWNER = {15'd0,
	    BG1_VRAM_0.WRITE_PENDING,BG1_VRAM_0.mem.ADDR,BG1_VRAM_0.mem.WREN,
	    (BG1_VRAM_0.mem.WREN ? BG1_VRAM_0.mem.BE : 2'd0),(BG1_VRAM_0.mem.WREN ? BG1_VRAM_0.mem.DATA : 16'd0),
	    BG1_VRAM_0.mem.SWREN,(BG1_VRAM_0.mem.SWREN ? BG1_VRAM_0.mem.SADDR : 13'd0),
	    (BG1_VRAM_0.mem.SWREN ? BG1_VRAM_0.mem.SDATA : 64'd0)};
	bit [127:0] CACHE_BG1_0_OWNER_1M,CACHE_BG1_0_OWNER_2M;
	always @(posedge CLK2X) begin
	    CACHE_BG1_0_OWNER_1M <= CACHE_BG1_0_OWNER;
	    CACHE_BG1_0_OWNER_2M <= CACHE_BG1_0_OWNER_1M;
	end
	wire [127:0] CACHE_BG1_1_OWNER = {15'd0,
	    BG1_VRAM_1.WRITE_PENDING,BG1_VRAM_1.mem.ADDR,BG1_VRAM_1.mem.WREN,
	    (BG1_VRAM_1.mem.WREN ? BG1_VRAM_1.mem.BE : 2'd0),(BG1_VRAM_1.mem.WREN ? BG1_VRAM_1.mem.DATA : 16'd0),
	    BG1_VRAM_1.mem.SWREN,(BG1_VRAM_1.mem.SWREN ? BG1_VRAM_1.mem.SADDR : 13'd0),
	    (BG1_VRAM_1.mem.SWREN ? BG1_VRAM_1.mem.SDATA : 64'd0)};
	bit [127:0] CACHE_BG1_1_OWNER_1M,CACHE_BG1_1_OWNER_2M;
	always @(posedge CLK2X) begin
	    CACHE_BG1_1_OWNER_1M <= CACHE_BG1_1_OWNER;
	    CACHE_BG1_1_OWNER_2M <= CACHE_BG1_1_OWNER_1M;
	end
	wire [255:0] CACHE_RETURN_OWNER =
	    LDI_SELECT[3] ? {128'd0,CACHE_FG0_OWNER_2M} :
	    LDI_SELECT[4] ? {128'd0,CACHE_FG1_OWNER_2M} :
	    LDI_SELECT[5] ? {CACHE_BG0_1_OWNER_2M,CACHE_BG0_0_OWNER_2M} :
	    LDI_SELECT[6] ? {CACHE_BG1_1_OWNER_2M,CACHE_BG1_0_OWNER_2M} :
	    {164'd0,EADDR,EADDR_SELECT,BIT_ADDR,LA};
	bit [255:0] CACHE_HELD_OWNER;
	bit [9:0] CACHE_HELD_SELECTION;
	always @(posedge CLK) if (RST_N) begin
	    if (EN && CE_R && CPU.MC.CACHE_WR && !CPU.CACHE.CACHE_WRITE_READY && !CPU.IO_SEL) begin
	        CACHE_HELD_OWNER <= CACHE_RETURN_OWNER;
	        CACHE_HELD_SELECTION <= {LDI_SELECT,LDI_EXTERNAL_VALID,ENVRAM};
	    end
	    if (CPU.CACHE.CACHE_RAM.WREN && CPU.CACHE.CACHE_MEM_USED) begin
	        assert (!CPU.IO_SEL && LDI_CACHE_MEM &&
	                CACHE_HELD_SELECTION == {LDI_SELECT,LDI_EXTERNAL_VALID,ENVRAM} &&
	                CACHE_HELD_OWNER == CACHE_RETURN_OWNER)
	            else $fatal(1,"Cache memory return owner changed between preparing R and consuming F");
	    end
	end
	bit [255:0] MC_PREVIOUS_SYS_OWNER;
	bit [9:0] MC_PREVIOUS_SYS_SELECTION;
	always @(posedge CLK) begin
		MC_PREVIOUS_SYS_OWNER <= CACHE_RETURN_OWNER;
		MC_PREVIOUS_SYS_SELECTION <= {LDI_SELECT,LDI_EXTERNAL_VALID,ENVRAM};
		if (RST_N && EN && CE_F && CPU.MC.READ_LATCH && CPU.MC_MEM_SELECTED) begin
			assert (!CPU.IO_SEL && LDI_CACHE_MEM &&
			        MC_PREVIOUS_SYS_SELECTION == {LDI_SELECT,LDI_EXTERNAL_VALID,ENVRAM} &&
			        MC_PREVIOUS_SYS_OWNER == CACHE_RETURN_OWNER)
				else $fatal(1,"MC memory return owner changed between previous SYS sample and F consume");
			assert (CPU.MC_RETURN_WORD == LDI)
				else $fatal(1,"MC held memory word changed before the actual F consumer");
		end
	end
	wire [31:0] LDI_ORIGINAL_SHADOW = ({32{MISC_SEL}} & {24'h000000,MISC_DO}) |
	             ({32{!MISC_SEL && EFG}} & EQ & 32'h00ff00ff) |
	             ({32{!MISC_SEL && !EFG && SPR_SEL}} & EQ) |
	             ({32{!MISC_SEL && !EFG && !SPR_SEL && FG0_SEL}} &
	              {8'h00,FG0_Q[15:8],8'h00,FG0_Q[7:0]}) |
	             ({32{!MISC_SEL && !EFG && !SPR_SEL && !FG0_SEL && FG1_SEL}} &
	              {8'h00,FG1_Q[15:8],8'h00,FG1_Q[7:0]}) |
	             ({32{!MISC_SEL && !EFG && !SPR_SEL && !FG0_SEL && !FG1_SEL && BG0_SEL}} &
	              {BG0_Q_1[15:8],BG0_Q_0[15:8],BG0_Q_1[7:0],BG0_Q_0[7:0]}) |
	             ({32{!MISC_SEL && !EFG && !SPR_SEL && !FG0_SEL && !FG1_SEL && !BG0_SEL && BG1_SEL}} &
	              {BG1_Q_1[15:8],BG1_Q_0[15:8],BG1_Q_1[7:0],BG1_Q_0[7:0]}) |
	             ({32{!MISC_SEL && !EFG && !SPR_SEL && !FG0_SEL && !FG1_SEL && !BG0_SEL && !BG1_SEL}} &
	              ((ERAM || EROM || ENVRAM) ? EQ : 32'hffffffff));
	always @(posedge CLK) if (RST_N && CE_F && !CPU.IO_SEL &&
	    ((EN && CPU.MC.READ_LATCH) || CPU.MC.CACHE_WR)) begin
	    assert (LDI_SELECT == LDI_SELECT_NEXT &&
	            (!LDI_SELECT[7] || LDI_EXTERNAL_VALID == (ERAM || EROM || ENVRAM)))
	        else $fatal(1,"CPU return selector changed at a valid read/cache capture");
	    assert (LDI == LDI_ORIGINAL_SHADOW)
	        else $fatal(1,"CPU live return data differs at a valid read/cache capture");
	end
	// synthesis translate_on
`endif
	// CPU-decoded foreground DDR access, without the hole-copy/sprite terms.
	wire EFG_CPU = LA[3] && (|BIT_ADDR[13:12]) && (FG0_SEL || FG1_SEL);
	// Ready stays combinational: a DDR cache miss raises busy one memory clock
	// before the controller's CE_F sample. The source selection is decoded from
	// the CPU address one system clock ahead: the controller samples ready only
	// in CE_F state 1, at least two system clocks after it publishes the
	// address in CE_F state 0. Register the resource-use masks, so each
	// memory-clock busy source enters a single selected-busy reduction.
	// Priority as before: misc, foreground pair transfer,
	// 0x40 page, CPU foreground DDR, sprite, FG0, FG1, BG0, BG1, external.
	// The DDR arm is selected by the CPU decode alone: a hole copy or sprite
	// DDR request never coincides with an external access that is not already
	// stalled by its own VRAM/blit ready.
	wire LRDY_PLAIN = LA[3:0] != 4'b0100 && LA[31:24] != 8'h40;
	wire LRDY_DECODE_ONE = MISC_SEL || (LA[3:0] != 4'b0100 && (LA[31:24] == 8'h40 ||
	                      (!EFG_CPU && !SPR_SEL && !FG0_SEL && !FG1_SEL && (BG0_SEL || BG1_SEL))));
	wire LRDY_DECODE_FGPAIR = !MISC_SEL && LA[3:0] == 4'b0100;
	wire LRDY_DECODE_ERDY = !MISC_SEL && LRDY_PLAIN && (EFG_CPU || (!SPR_SEL && !FG0_SEL && !FG1_SEL && !BG0_SEL && !BG1_SEL));
	wire LRDY_DECODE_SPR = !MISC_SEL && LRDY_PLAIN && !EFG_CPU && SPR_SEL;
	wire LRDY_DECODE_FG0 = !MISC_SEL && LRDY_PLAIN && !EFG_CPU && !SPR_SEL && FG0_SEL;
	wire LRDY_DECODE_FG1 = !MISC_SEL && LRDY_PLAIN && !EFG_CPU && !SPR_SEL && !FG0_SEL && FG1_SEL;
	bit LRDY_USE_FG0, LRDY_USE_FG1, LRDY_USE_ERDY, LRDY_USE_SPR, LRDY_SELECT_VALID;
	always @(posedge CLK) begin
		LRDY_USE_FG0 <= LRDY_DECODE_FGPAIR || LRDY_DECODE_FG0;
		LRDY_USE_FG1 <= LRDY_DECODE_FGPAIR || LRDY_DECODE_FG1;
		LRDY_USE_ERDY <= LRDY_DECODE_ERDY || LRDY_DECODE_SPR;
		LRDY_USE_SPR <= LRDY_DECODE_SPR;
		// The original selectors all start low before the first system edge.
		LRDY_SELECT_VALID <= LRDY_DECODE_ONE || LRDY_DECODE_FGPAIR || LRDY_DECODE_ERDY ||
		                     LRDY_DECODE_SPR || LRDY_DECODE_FG0 || LRDY_DECODE_FG1;
	end
	assign LRDY = LRDY_SELECT_VALID && !(SPR_BUSY || SPR_CPU_SHIFT_WE ||
	              (LRDY_USE_FG0 && !FG0_RDY) || (LRDY_USE_FG1 && !FG1_RDY) ||
	              (LRDY_USE_ERDY && !ERDY) ||
	              (LRDY_USE_SPR ? !SPR_COMPLETE_RDY_L : !SPR_PACKET_IDLE_L));
	`ifndef SYNTHESIS
	// synthesis translate_off
	// A gathered hole byte always belongs to DDR, even though the CPU's EQ
	// bus also has an NVRAM arm. Check the actual gather consumer, whose data
	// was captured on the preceding memory edge; the bypass adds no latency.
	always @(posedge CLK2X) if (RST_N &&
	    ((FG0_VRAM.UNALIGNED_EXEC && FG0_VRAM.COPY_DDR && FG0_VRAM.COPY_STATE == 3'd3) ||
	     (FG1_VRAM.UNALIGNED_EXEC && FG1_VRAM.COPY_DDR && FG1_VRAM.COPY_STATE == 3'd3))) begin
		assert (FG_DDR_Q == EQ)
			else $fatal(1,"Foreground hole gather differs from selected CPU DDR return");
	end
	// synthesis translate_on
	// Whenever the decode inputs have been stable across the last system clock
	// (always true when the controller samples), ready equals the original mux.
	bit [32:0] LRDY_DECODE_PREVIOUS;
	always @(posedge CLK) LRDY_DECODE_PREVIOUS <= {LA,DISP_CONTROL[15]};
	always @(posedge CLK2X) if (RST_N) begin
		if (LRDY_DECODE_PREVIOUS == {LA,DISP_CONTROL[15]})
			assert (LRDY == (SPR_BUSY || CPU_SHIFT_BUSY ? 1'b0 : MISC_SEL ? 1'b1 :
			                 LA[3:0] == 4'b0100 ? FG0_RDY & FG1_RDY : LA[31:24] == 8'h40 ? 1'b1 :
			                 EFG && LA[3] ? ERDY : SPR_SEL ? SPR_RDY & ERDY : FG0_SEL ? FG0_RDY :
			                 FG1_SEL ? FG1_RDY : BG0_SEL ? 1'b1 : BG1_SEL ? 1'b1 : ERDY))
				else $fatal(1,"CPU ready differs from the original external-ready selection");
		assert (ERD == (SPR_DDR_REQ ? 1'b0 : FG_HOLE_COPY ? (FG0_HOLE_RD || FG1_HOLE_RD) : ~QE_N & LA[3]))
			else $fatal(1,"external read request differs from the original strobe decode");
	end
`endif
							
	// Preserve the full logical row layout in the otherwise unused DDR bank.
	// FG1_SEL names the physical page, independently of its draw/display role.
	wire [16:0] FG_HOLE_WORD = FG0_HOLE_SEL ? FG0_HOLE_A[17:1] : FG1_HOLE_A[17:1];
	// Publish the address alternatives before the late transfer-mode mux.
	// DDR compares their tags in parallel, then applies this exact priority.
	assign EADDR_CANDIDATES[0] = {3'b000,SPR_DRAW_PAGE,SPR_DRAW_ADDR[16:9],1'b0,SPR_DRAW_ADDR[8:1],2'b00};
	assign EADDR_CANDIDATES[1] = {3'b000,FG1_HOLE_SEL,FG0_HOLE_A[17:1],2'b00};
	assign EADDR_CANDIDATES[2] = {3'b000,1'b1,FG1_HOLE_A[17:1],2'b00};
	// Same-cycle copy of the display page bit for the DDR request-address
	// candidate cone, so that cone is not tied to the page register's placement.
	(* preserve, dont_merge *) reg DISP_PAGE_E = 1'b0;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) DISP_PAGE_E <= 1'b0;
		else if (CE_R && MISC_SEL && !WE_N && {LA[11:5],5'b00000} == 12'h180 && !CAS_N[1]) DISP_PAGE_E <= LDO[15];
	end
	wire FG1_SEL_E = DISP_PAGE_E ? FG_DRAW_SEL : FG_DISP_SEL;
`ifndef SYNTHESIS
	always @(posedge CLK) assert (DISP_PAGE_E == DISP_CONTROL[15]) else $fatal(1,"DISP_PAGE_E copy differs from DISP_CONTROL[15]");
`endif
	assign EADDR_CANDIDATES[3] = {3'b000,FG1_SEL_E,BIT_ADDR[21:5],2'b00};
	assign EADDR_CANDIDATES[4] = {LA[25:5],2'b00};
	assign EADDR_SELECT = { !SPR_DDR_REQ && !FG_HOLE_COPY && !EFG,
	                       !SPR_DDR_REQ && !FG_HOLE_COPY && EFG,
	                       !SPR_DDR_REQ && !FG0_HOLE_SEL && FG1_HOLE_SEL,
	                       !SPR_DDR_REQ && FG0_HOLE_SEL,
	                       SPR_DDR_REQ };
	assign EADDR = SPR_DDR_REQ ? {3'b000,SPR_DRAW_PAGE,SPR_DRAW_ADDR[16:9],1'b0,SPR_DRAW_ADDR[8:1],2'b00} :
	               FG_HOLE_COPY ? {3'b000,FG1_HOLE_SEL,FG_HOLE_WORD,2'b00} :
	               EFG ? {3'b000,FG1_SEL_E,BIT_ADDR[21:5],2'b00} :
	                    {LA[25:5],2'b00};
	`ifdef VERILATOR
	wire [22:0] parallel_eaddr =
		(EADDR_CANDIDATES[0] & {23{EADDR_SELECT[0]}}) |
		(EADDR_CANDIDATES[1] & {23{EADDR_SELECT[1]}}) |
		(EADDR_CANDIDATES[2] & {23{EADDR_SELECT[2]}}) |
		(EADDR_CANDIDATES[3] & {23{EADDR_SELECT[3]}}) |
		(EADDR_CANDIDATES[4] & {23{EADDR_SELECT[4]}});
	always @(posedge CLK2X) if(RST_N && EN) begin
		assert ($onehot(EADDR_SELECT) && parallel_eaddr == EADDR &&
                EADDR_SELECT[4] == !EFG)
			else $fatal(1,"Parallel DDR address candidates changed request priority");
	end
	`endif
	// NVRAM belongs to the CPU bus. Concurrent sprite/foreground DDR requests
	// must not redirect its address through the shared external DDR mux.
	assign NVRAM_ADDR = LA[17:5];
	// BT_PARALLEL_DDR_DATA_BEGIN
	// Raw data and the exact existing owner are sampled together by ddram.
	// Source order: sprite, foreground zero, foreground one, CPU bus.
	assign EDATA_CANDIDATES[0] = {8'b0,SPR_DRAW_DATA,8'b0,SPR_DRAW_DATA};
	assign EDATA_CANDIDATES[1] = FG0_HOLE_DATA;
	assign EDATA_CANDIDATES[2] = FG1_HOLE_DATA;
	assign EDATA_CANDIDATES[3] = LDO;
	assign EDATA_SELECT[0] = SPR_DDR_REQ;
	assign EDATA_SELECT[1] = !SPR_DDR_REQ && FG_HOLE_COPY && FG0_HOLE_SEL;
	assign EDATA_SELECT[2] = !SPR_DDR_REQ && FG_HOLE_COPY && !FG0_HOLE_SEL;
	assign EDATA_SELECT[3] = !SPR_DDR_REQ && !FG_HOLE_COPY;
	// BT_PARALLEL_DDR_DATA_END
	assign EDATA = SPR_DDR_REQ ? {8'b0,SPR_DRAW_DATA,8'b0,SPR_DRAW_DATA} :
	               FG_HOLE_COPY ? (FG0_HOLE_SEL ? FG0_HOLE_DATA : FG1_HOLE_DATA) : LDO;
	assign EWE = SPR_DDR_REQ ? (SPR_DRAW_ADDR[0] ? 4'b0100 : 4'b0001) :
	             FG_HOLE_COPY ? (FG0_HOLE_WE | FG1_HOLE_WE) :
	             ~CAS_N & ~{4{WE_N}} & {4{QE_N}} & {4{LA[3]}} & (EFG ? 4'b0101 : 4'b1111);
	// RD_EXT rises only in CE_R, two memory clocks after the address and code
	// (bt_ddr_phase.sdc); the CE_F internal strobes carry code bit 3 clear.
	assign ERD = SPR_DDR_REQ ? 1'b0 : FG_HOLE_COPY ? (FG0_HOLE_RD || FG1_HOLE_RD) : RD_EXT & LA[3];
	assign EROM = LA[31:24] >= 8'hFC;
	assign ERAM = LA[31:24] == 8'h00;
	assign EFG = SPR_DDR_REQ || FG_HOLE_COPY || EFG_CPU;
	assign EFG_RDY = EFG_CPU;
	assign ENVRAM = LA[31:24] == 8'h60;
	// NVRAM is written only by ordinary CPU accesses. Its input must not pass
	// through the foreground-copy / sprite DDR data mux, which is unrelated.
	assign NVRAM_DATA = LDO[7:0];
	// CPU-bus byte write only: foreground-copy and sprite DDR strobes in EWE
	// launch from the memory clock and must not gate the CE_R NVRAM write.
	// The CPU mirrors both byte-mask reductions on their existing capture edge.
	// Preserve sprite/foreground DMA priority and every original byte strobe.
	assign EWE_ANY = SPR_DDR_REQ ? 1'b1 : FG_HOLE_COPY ?
		(|FG0_HOLE_WE || |FG1_HOLE_WE) :
		(EFG ? CPU_WRITE_ANY_FG : CPU_WRITE_ANY_ALL) && QE_N && LA[3];
`ifdef VERILATOR
	always @(posedge CLK2X) if (RST_N)
		assert (EWE_ANY == (|EWE)) else $fatal(1,"DDR write mask reduction changed");
`endif
	assign NVRAM_WE = ENVRAM & ~CAS_N[0] & ~WE_N & QE_N & LA[3];
	assign ESPR = SPR_SEL;
						  
	// DPYCTL.ENV off: the raster and sync keep running, the picture is black.
	assign {R,G,B} = !VIDEO_EN ? 24'h000000 :
		(BG0_GRID && GRID_EN[0]) || (BG1_GRID && GRID_EN[1]) ? 24'hFFFFFF :
		((PAL_PIXEL & PAL_MASK) != PAL_PIXEL) ? 24'h000000 :
		{{PAL_Q[21:16],PAL_Q[21:20]},{PAL_Q[13:8],PAL_Q[13:12]},{PAL_Q[5:0],PAL_Q[5:4]}};
	
	//sound
	bit [15: 0] Z80_A;
	bit [ 7: 0] Z80_DI;
	bit [ 7: 0] Z80_DO;
	bit         Z80_MREQ_N;
	bit         Z80_IORQ_N;
	bit         Z80_RD_N;
	bit         Z80_WR_N;
	bit         Z80_WAIT_N;
	bit         Z80_INT_N;
	
	bit [11: 0] BSMT_A;
	bit [15: 0] BSMT_DI;
	bit [15: 0] BSMT_DO;
	bit         BSMT_WE_N;
	bit         BSMT_DEN_N;
	bit         BSMT_BIO_N;
	bit         BSMT_RS_N;
	bit         BSMT_CMD_PEND;
	// BIOZ polls the command latch; reading DSP port 1 acknowledges it.
	assign BSMT_BIO_N = ~BSMT_CMD_PEND;
	
	bit [ 7: 0] Z80_CTRL_DATA;
	bit         Z80_CTRL_RDY;
	bit [ 7: 0] Z80_RESP_DATA;
	bit         Z80_RESP_RDY;
	bit [15: 0] BSMT_PORTR[8] = '{8{'1}};
	bit [15: 0] BSMT_PORTW[8] = '{8{'1}};

`ifdef SOUND_EN
	T80pa Z80
	(
		.RESET_n(MISC_CONTROL[3]),
		.CLK(CLK),
		.CEN_n(SCE_F),
		.CEN_p(SCE_R),
		.WAIT_n(1),
		.INT_n(Z80_INT_N),
		.MREQ_n(Z80_MREQ_N),
		.IORQ_n(Z80_IORQ_N),
		.RD_n(Z80_RD_N),
		.WR_n(Z80_WR_N),
		.A(Z80_A),
		.DI(Z80_DI),
		.DO(Z80_DO)
	);
	
	
	bit [ 7: 0] IO_DO;
	always @(posedge CLK or negedge RST_N) begin
		bit         RD_N_OLD,WR_N_OLD;
		bit [14: 0] INT_TIMER;
		
		if (!RST_N) begin
			IO_DO <= '0;
			Z80_CTRL_RDY <= 0;
			Z80_RESP_RDY <= 0;
			Z80_INT_N <= 1;
			BSMT_PORTW <= '{8{'0}};
			BSMT_CMD_PEND <= 0;
			BSMT_RS_N <= 1;
`ifdef DEBUG
			DBG_FUNC_1 <= 0;
			DBG_FUNC_2 <= 0;
			DBG_FUNC_3 <= 0;
			DBG_FUNC_D <= 0;
`endif
		end else begin
			if (Z80_CTRL_DATA_WRITE && CE_R) begin
				Z80_CTRL_RDY <= 1;
			end
			if (Z80_RESP_DATA_READ && CE_R) begin
				Z80_RESP_RDY <= 0;
			end
				
			RD_N_OLD <= Z80_RD_N; 
			if (!Z80_RD_N && RD_N_OLD && !Z80_IORQ_N) begin
				if (!Z80_A[15]) begin
					IO_DO <= '0;
				end else begin
					case (Z80_A[2:0])
						3'h0: begin IO_DO <= Z80_CTRL_DATA; Z80_CTRL_RDY <= 0; end
						3'h4: IO_DO <= {~Z80_CTRL_RDY,7'b0000000};
						3'h5: IO_DO <= {~Z80_RESP_RDY,7'b0000000};
						3'h6: IO_DO <= {~BSMT_CMD_PEND,7'b0000000};
						default: IO_DO <= '0;
					endcase
				end
			end
				
			WR_N_OLD <= Z80_WR_N; 
			if (!Z80_WR_N && WR_N_OLD && !Z80_IORQ_N) begin
				if (!Z80_A[15]) begin
					BSMT_PORTR[0] <= {8'h00,Z80_A[15:8]};
					BSMT_PORTR[1] <= {Z80_A[7:0],Z80_DO};
					BSMT_CMD_PEND <= 1;
				end else begin
					case (Z80_A[2:0])
						3'h0: begin Z80_RESP_DATA <= Z80_DO; Z80_RESP_RDY <= 1; end
						3'h2: begin BSMT_RS_N <= Z80_DO[7]; Z80_INT_N <= 1; end
					endcase
				end
			end
			
			Z80_RAM_WE <= 0;
			if (!Z80_WR_N && WR_N_OLD && !Z80_MREQ_N && Z80_A[15]) begin
				Z80_RAM_WE <= 1;
			end
			
			if (SCE_R) begin
				INT_TIMER <= INT_TIMER + 15'd1;
				if (INT_TIMER == 15'h7FFF)
					Z80_INT_N <= 0;
			end
			
			//BSMT2000
			if (!BSMT_WE_N && SCE_R) begin
				BSMT_PORTW[BSMT_A[2:0]] <= BSMT_DO;
			end
			if (BSMT_A[2:0] == 3'd1 && !BSMT_DEN_N && SCE_R) begin
				BSMT_CMD_PEND <= 0;
			end
			if (!BSMT_RS_N) begin
				BSMT_CMD_PEND <= 0;
			end
			
`ifdef DEBUG
			if (Z80_A == 16'h02E7 && !Z80_MREQ_N && !Z80_RD_N) begin
				DBG_FUNC_D <= 1;
			end
			if (Z80_A == 16'h021D && !Z80_MREQ_N && !Z80_RD_N) begin
				DBG_FUNC_1 <= 1;
			end
			if (Z80_A == 16'h023E && !Z80_MREQ_N && !Z80_RD_N) begin
				DBG_FUNC_2 <= 1;
			end
			if (Z80_A == 16'h02C5 && !Z80_MREQ_N && !Z80_RD_N) begin
				DBG_FUNC_3 <= 1;
			end
`endif
		end
	end
	
	bit [ 7: 0] Z80_RAM_DO;
	bit         Z80_RAM_WE;
	bt_audio_ram ramZ80
	(
		.clock(CLK),
		.load_addr(AUDIO_ROM_A),
		.load_data(AUDIO_ROM_D),
		.load_we(AUDIO_ROM_WR),
		.cpu_addr(Z80_A),
		.cpu_data(Z80_DO),
		.cpu_we(Z80_RAM_WE & RST_N),
		.cpu_q(Z80_RAM_DO)
	);
	
	assign Z80_DI = !Z80_IORQ_N ? IO_DO : Z80_RAM_DO;
	
	
	TMS320C1X #("rtl/bsmt2000.mif") BSMT
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.EN(1),
		
		.CE_F(SCE_F),
		.CE_R(SCE_R),
		
		.RS_N(BSMT_RS_N),
		.INT_N(1),
		.BIO_N(BSMT_BIO_N),
		
		.A(BSMT_A),
		.DI(BSMT_DI),
		.DO(BSMT_DO),
		.WE_N(BSMT_WE_N),
		.DEN_N(BSMT_DEN_N),
		.MEN_N(),
		.RDY(1)
	);
	assign BSMT_DI = BSMT_A[2:0] == 3'd2 ? {BSMT_ROM_DI,8'h00} : BSMT_PORTR[BSMT_A[2:0]];
	
	assign BSMT_ROM_A = {BSMT_PORTW[1][4:0],BSMT_PORTW[0]};
	assign BSMT_ROM_RD = SCE_F;//BSMT_A[2:0] == 3'd2 && !BSMT_DEN_N;
`endif
	
	assign SL = BSMT_PORTW[3];
	assign SR = BSMT_PORTW[7];
	
`ifdef DEBUG
	assign DBG_MISC = SPR_SCALE0^SPR_SCALE1^SPR_CONTROL^DISP_CONTROL^MISC_CONTROL;
	assign DBG_SCALE = |SPR_SCALE0 || |SPR_SCALE1;
`endif
	
endmodule
