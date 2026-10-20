/*
Not implemented:
- big endian mode
- host interface and host interrupt
- 16 bit bus size
- interrupt during graphic instruction execition (IX flag)
- window mode 1,2 and window interrupt
- horizontal/vertical direction
- pixel processing operation
- extern sync for video interface
- instructions:
  - EMU,IDLE,BLMOVE,CEXEC,CMOVxx,RETM,SWAPF
  - VBLT,VLCOL,VFILL
  - CLIP,PFILL,TFILL,FLINE,FPIXEQ,FPIXNE,LINIT,DRAV
  - PIXBLT L,M,L
  - PIXBLT XY,L
  - PIXBLT XY,XY
*/

module TMS34020 #(parameter DISPLAY_SERVICE_PAUSE = 0)
 (
	input              CLK,
	input              RST_N,
	input              EN,
	
	input              CE_F,
	input              CE_R,
	
	input              RES_N,
	input              NMI_N,
	input              LINT1_N,
	input              LINT2_N,
	
	output     [31: 0] LA,
	output     [31: 0] BIT_ADDR,
	input      [31: 0] LDI,
	input              LDI_CACHE_MEM,
	input              LDI_CACHE_DDR,
	input              LDI_CACHE_DDR_BYTES,
	input      [31: 0] LDI_CACHE_DDR_DATA,
	input      [31: 0] LDI_CACHE_RAM_DATA,
	input      [31: 0] LDI_CACHE_LATE,
	input      [31: 0] LDI_CACHE_LATE_E,
	output     [31: 0] LDO,
	output             RAS_N,
	output     [ 3: 0] CAS_N,
	output             WE_N,
	output             QE_N,
	output             RD_EXT,  // external read strobe: QE for CE_R reads/fetches only
	output             ALTCH_N,
	input              LRDY,
	
	input              VCE_R,
	output             HS_N,
	output             VS_N,
	output             HBL_N,
	output             VBL_N,
	output             VIDEO_EN,
	output             WRITE_ANY_ALL,
	output             WRITE_ANY_FG
	
`ifdef DEBUG
	,
	output reg [25: 3] DBG_PC,
	output reg [31: 0] DBG_ALU_R,
	output reg         DBG_ALU_C,
	output reg         DBG_ALU_Z,
	output reg         DBG_ALU_N,
	output reg         DBG_ALU_V,
	output reg [31: 0] DBG_PIX_WMASK,
	output reg [31: 0] DBG_PIX_PAT,
	output reg         DBG_UNUSED,
	output reg         DBG_UNUSED_PC,
	output reg [31: 0] DBG_SAVE_PC,
	output reg [15: 0] DBG_DI_FLAG,
	output     [31: 0] DBG_TEMP
`endif
	, output     [ 3: 0] ADDR_CLASS
	, output [3:0] VRAM_REQUEST
	, input wire PAUSE_REQUEST, CPU_HALTED, RAW_CE_F, RAW_CE_R
	, output wire PAUSE_READY
);
	 
	 import TMS34020_PKG::*;
	 
	//MC
	wire MC_PAUSE_READY;
	wire DISPLAY_ONLY = DISPLAY_SERVICE_PAUSE && CPU_HALTED;
	// Finish the held return/cache F before acknowledging halt. Fresh normal
	// launches are masked on that edge; architectural F captures still run.
	// LRDY is a late 160 MHz-domain term. Keep it out of the launch decode: the MC
	// receives unmasked requests plus LAUNCH_KILL (= PAUSE_FINISH_F) and applies it
	// as the last select, which is logically identical to masking each request.
	wire PAUSE_FINISH_BASE = DISPLAY_SERVICE_PAUSE && PAUSE_REQUEST &&
	!CPU_HALTED && RAW_CE_F && MC_PAUSE_READY;
	// The pause handshake uses LRDY from the previous system clock. MC_PAUSE_READY
	// already requires a fully idle bus (no strobe, wait or pending transfer), so
	// no MC transaction consumes LRDY at that edge; the registered copy only
	// removes the 160 MHz -> 80 MHz combinational path into the MC and halt logic.
	// The finish mask and the bridge's halt decision use the same signal.
	bit LRDY_PAUSE_Q;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) LRDY_PAUSE_Q <= 1'b0;
		else LRDY_PAUSE_Q <= LRDY;
	end
	wire PAUSE_FINISH_F = PAUSE_FINISH_BASE && LRDY_PAUSE_Q;
	wire MC_LAUNCH_ALLOW = !DISPLAY_ONLY || (!PAUSE_REQUEST && RAW_CE_F);
	wire MC_CE_F = DISPLAY_ONLY ? RAW_CE_F : CE_F;
	wire MC_CE_R = DISPLAY_ONLY ? RAW_CE_R : CE_R;
	assign PAUSE_READY = MC_PAUSE_READY && LRDY_PAUSE_Q;
	bit  [31: 0] MC_ADDR;
	bit  [31: 0] MC_DIN;
	bit  [31: 0] MC_DIN_F;   // read word for CE_F consumers (pattern source)
	bit  [31: 0] MC_DOUT;
	bit          MC_WAIT;
	bit          MC_CACHE_WR;
	
	bit  [31: 0] DBUS_A;
	bit  [31: 0] DBUS_DI;
	bit  [31: 0] DBUS_DO;
	bit          DBUS_RAS;
	bit          DBUS_WE;
	bit          DBUS_RD;
	bit          DBUS_RD_EXT;
	bit  [ 3: 0] DBUS_BE;
	bit DBUS_ANY_BE, DBUS_ANY_BE_FG;
	bit  [ 3: 0] DBUS_CODE;
	bit          DBUS_RDY;
	

	//IO
	IOReg_t      IO_REGS;
	bit  [31: 0] IO_DO;
	bit  [31: 0] IO_DO_NEXT;
	bit  [31: 0] SCRREF_ADDR;
	bit          SCRREF_RUN;
	bit          INT1_REQ;
	bit          INT2_REQ;
	bit          HI_REQ;
	bit          DI_REQ;
	bit          WV_REQ;
	
	//IE
	bit  [31: 0] PC;
	ST_t         ST;
	bit  [ 4: 0] RF_WA_N;
	bit  [31: 0] RF_WA_D;
	bit          RF_WA_WE;
	bit  [ 4: 0] RF_WB_N;
	bit  [31: 0] RF_WB_D;
	bit          RF_WB_WE;
	bit  [ 4: 0] RF_RA_N;
	bit  [ 4: 0] RF_RB_N;
	bit  [31: 0] RF_RA_Q;
	bit  [31: 0] RF_RB_Q;
	
	bit  [15: 0] IC;
	ICMatches_t IC_MATCHES;
	bit [3:0] IC_RS_STATIC;
	ICRFAddress_t IC_RF_ADDR, IC_RF_ADDR_POS;
	OpSel_t OPSEL, OPSEL_COMB, OPSEL_NX, OPSEL_CACHE;
	// Field-size selection is instruction/state-only, like OPSEL. Keep its
	// decode ahead of the ALU extension masks without delaying live field data.
	(* preserve, dont_merge *) bit [5:0] OPSEL_ALU_FSI_OH;
	function automatic bit [5:0] DecodeAluFSI(input bit [2:0] fsi);
		case (fsi)
			FSI_F:  return 6'b000001;
			FSI_PS: return 6'b000010;
			FSI_PW: return 6'b000100;
			FSI_8:  return 6'b001000;
			FSI_16: return 6'b010000;
			default:return 6'b100000;
		endcase
	endfunction
	bit  [31: 0] IW;
	bit          RST_EXEC;
	DecInstr_t   DECI;
	MemAccess_t  DECI_AT_PRE;
`ifndef SYNTHESIS
	always @(posedge CLK) assert ((DECI_AT_PRE == MA_READ) == (DECI.MC.AT == MA_READ)) else $fatal(1,"READ decode depends on the PIX_WE gate");
`endif
	bit  [ 4: 0] STATE;
	bit [31:0] STATE_OH = 32'b1;
`ifndef SYNTHESIS
	always @(negedge CLK) if (RST_N) assert (OPSEL == OPSEL_COMB) else $fatal(1,"Registered operand-select predecode differs from the combinational decode");
	always @(negedge CLK) if (RST_N) begin
		assert (OPSEL_ALU_FSI_OH == DecodeAluFSI(DECI.FT.FSI))
			else $fatal(1, "Registered ALU field-size selection changed instruction/state identity");
		assert (STATE_OH == (32'b1 << STATE))
			else $fatal(1, "TMS34020 state/shadow divergence");
	end
`endif
	bit  [ 5: 0] FS;
	bit          FE;
	bit          DS_Z;
	bit  [31: 0] ALU_A,ALU_B;
	bit  [63: 0] MD_ACC;
	bit  [63: 0] MD_SHIFT;
	bit  [31: 0] MD_Q;
	bit          DIV_V;
	bit  [31: 0] ALU_R;
	bit          ALU_C,ALU_V,ALU_Z,ALU_N;
	bit  [ 3: 0] ALU_XY_CC;
	bit          MD_COND;
	bit          MD_NEG;
	bit          MD_DIVIDEND_NEG;
	bit          J_COND;
	bit          DS_COND;
	bit          MM_COND;
	bit          RP_COND;
	bit  [ 5: 0] PSIZE;
	bit  [15: 0] CONVDP;
	bit  [15: 0] CONVSP;
	bit  [15: 0] CONVMP;
	bit  [31: 0] PIXALU_NEXT;
	XY_t         PIX_POS;
	XY_t         PIX_DYDX;
	bit  [ 3: 0] PIX_WINCC;
	bit  [31: 0] PIX_DOFFS;
	bit  [31: 0] PIX_SOFFS;
	bit  [31: 0] PIX_MOFFS;
	bit  [ 5: 0] PIXBLT_PPW;
	bit  [15: 0] PIXBLT_X;
	bit  [31: 0] PIX_BIT;
	bit  [31: 0] PIX_BITV;
	bit  [63: 0] PIX_NE;
	bit  [31: 0] PIX_PAT;
	bit          PIX_XEND;
	bit          PIX_YEND;
	bit          PIX_BL;
	bit  [31: 0] PIX_WMASK;
	bit          PIX_WE;
	bit          LINE_GZ;
	bit          ALU_LINE_GZ;
	bit          LINE_COND;
	bit  [31: 0] WSTART;
	bit  [31: 0] WEND;
	bit  [31: 0] COLOR0;
	bit  [31: 0] COLOR1;
	bit  [31: 0] PATTERN;
	
	wire IO_SEL;
	// BEGIN MC_MEM_RETURN_STAGE: shared verbatim by the directed owner proof.
	// Capture each channel on the exact original continuous SYS sample edge.
	bit MC_MEM_SELECTED;
	bit MC_DDR_SELECTED;
	bit MC_DDR_BYTES_SELECTED;
	bit [31:0] MC_MEM_WORD,MC_DDR_WORD;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin
			MC_MEM_SELECTED <= 0;
			MC_DDR_SELECTED <= 0;
			MC_DDR_BYTES_SELECTED <= 0;
		end else begin
			MC_MEM_SELECTED <= LDI_CACHE_MEM && !IO_SEL;
			MC_DDR_SELECTED <= LDI_CACHE_MEM && !IO_SEL && LDI_CACHE_DDR;
			MC_DDR_BYTES_SELECTED <= LDI_CACHE_DDR_BYTES;
			if (LDI_CACHE_MEM && !IO_SEL) begin
				if (LDI_CACHE_DDR) MC_DDR_WORD <= LDI_CACHE_DDR_DATA;
				else MC_MEM_WORD <= LDI_CACHE_RAM_DATA;
			end
		end
	end
	wire [31:0] MC_DDR_RETURN_WORD = MC_DDR_WORD &
	    (MC_DDR_BYTES_SELECTED ? 32'h00ff00ff : 32'hffffffff);
	// Both memory alternatives below are SYS registers; SYS owners stay live.
	wire [31:0] MC_RETURN_WORD = MC_MEM_SELECTED ?
	    (MC_DDR_SELECTED ? MC_DDR_RETURN_WORD : MC_MEM_WORD) :
	    IO_SEL ? IO_DO : LDI_CACHE_LATE;
	// The same word as the MC's CE_R early capture sees it, one clock before
	// the CE_F capture: the held memory words are already final there, the IO
	// register mux is taken before its output register (DO_NEXT).
	wire [31:0] MC_RETURN_WORD_E = MC_MEM_SELECTED ?
	    (MC_DDR_SELECTED ? MC_DDR_RETURN_WORD : MC_MEM_WORD) :
	    IO_SEL ? IO_DO_NEXT : LDI_CACHE_LATE_E;
`ifdef MISTER_CPU_PHASE_CHECK
	// synthesis translate_off
	// Verbatim unchanged prior-stage capture, renamed only for the oracle.
	// Sample only memory-owned LDI on every SYS edge, including CE pauses.
	// READ_LATCH may consume on a resumed F before any closing R has occurred.
	bit MC_OLD_MEM_SELECTED;
	bit [31:0] MC_OLD_MEM_WORD;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) MC_OLD_MEM_SELECTED <= 0;
		else begin
			MC_OLD_MEM_SELECTED <= LDI_CACHE_MEM && !IO_SEL;
			if (LDI_CACHE_MEM && !IO_SEL) MC_OLD_MEM_WORD <= LDI;
		end
	end
	// The live alternative contains only SYS-owned IO/MISC/NVRAM/constants.
	wire [31:0] MC_OLD_RETURN_WORD = MC_OLD_MEM_SELECTED ? MC_OLD_MEM_WORD :
	    IO_SEL ? IO_DO : LDI_CACHE_LATE;
	always @(posedge CLK) if (RST_N) begin
		assert (MC_MEM_SELECTED == MC_OLD_MEM_SELECTED)
			else $fatal(1,"Split MC sampling predicate differs from the prior stage");
		if (MC_MEM_SELECTED) assert (MC_RETURN_WORD == MC_OLD_RETURN_WORD)
			else $fatal(1,"Split MC held word differs from the exact prior SYS sample");
	end
	// synthesis translate_on
`endif
	// END MC_MEM_RETURN_STAGE
`ifdef MISTER_CPU_PHASE_CHECK
	// synthesis translate_off
	always @(posedge CLK) if (RST_N && EN && CE_F && MC.READ_LATCH) begin
		assert (MC_RETURN_WORD == DBUS_DI)
			else $fatal(1,"MC memory stage differs from the original F-edge return word");
		assert (MC_DDR_SELECTED == (LDI_CACHE_MEM && !IO_SEL && LDI_CACHE_DDR) &&
		        (!MC_DDR_SELECTED || MC_DDR_BYTES_SELECTED == LDI_CACHE_DDR_BYTES))
			else $fatal(1,"MC split DDR owner or byte mask changed before F consume");
		assert (MC_MEM_SELECTED == (LDI_CACHE_MEM && !IO_SEL))
			else $fatal(1,"MC memory stage selected a different F-edge return owner");
	end
	// synthesis translate_on
`endif

	//Cache
	bit  [31: 0] CACHE_Q;
	bit  [39: 0] CACHE_RF_PRE;
	bit          CACHE_MISS;
	bit          CACHE_WAIT;
	TMS34020_CACHE CACHE
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.EN(EN),
		
		.CE_F(CE_F),
		.CE_R(CE_R),
		
		.RES_N(RES_N),
		.RST_EXEC(RST_EXEC),
		
		.CACHE_DATA(DBUS_DI),
		.CACHE_MEM_CAPTURE(LDI_CACHE_MEM && !IO_SEL),
		.CACHE_DDR_CAPTURE(LDI_CACHE_DDR),
		.CACHE_DDR_BYTES(LDI_CACHE_DDR_BYTES),
		.CACHE_DDR_DATA(LDI_CACHE_DDR_DATA),
		.CACHE_RAM_DATA(LDI_CACHE_RAM_DATA),
		.CACHE_LATE_DATA(IO_SEL ? IO_DO : LDI_CACHE_LATE),
		.CACHE_WR(MC_CACHE_WR),
		
		.PC(PC),
		.CACHE_Q(CACHE_Q),
		.CACHE_RF_PRE(CACHE_RF_PRE),
		.CACHE_MISS(CACHE_MISS),
		.CACHE_WAIT(CACHE_WAIT)
	);
	
	
	TMS34020_ID #(.OPSEL_REG(1)) ID (
		.CLK(CLK),
		.RST_N(RST_N),
		.EN(EN),
		
		.CE_F(CE_F),
		.CE_R(CE_R),
		
		.IC(IC),
		.IC_MATCHES(IC_MATCHES),
		.IC_RS_STATIC(IC_RS_STATIC),
		.IC_RF_ADDR(IC_RF_ADDR),
		.IC_RF_ADDR_POS(IC_RF_ADDR_POS),
		.OPSEL(OPSEL),
		.OPSEL_COMB(OPSEL_COMB),
		.STATE(STATE),
		.STATE_OH(STATE_OH),
		.MD_COND(MD_COND),
		.MD_NEG(MD_NEG),
		.MD_DIVIDEND_NEG(MD_DIVIDEND_NEG),
		.DIV_V(DIV_V),
		.J_COND(J_COND),
		.DS_COND(DS_COND),
		.MM_COND(MM_COND),
		.FE0(ST.FE0),
		.FE1(ST.FE1),
		.RP_COND(RP_COND),
		.LINE_GZ(LINE_GZ),
		.LINE_COND(LINE_COND),
		.PIX_XEND(PIX_XEND),
		.PIX_YEND(PIX_YEND),
		.PIX_WINEN(&IO_REGS.CONTROL.W),
		.PIX_WINCC(PIX_WINCC),
		.PIX_BL(PIX_BL),
		.PIX_WE(PIX_WE),
		
		.DECI(DECI),
		.DECI_AT_PRE(DECI_AT_PRE)
	);
	
	// Operand-select predecode. DECI.AIA/AIB/SHC/F/MC.AS/MC.DS depend only on
	// (IC,STATE), never on condition flags, so they are registered with IC/STATE
	// and ID forwards the flops (OPSEL_REG). The next-value decoders below are
	// the same ID with flags tied off; their other outputs are unused and pruned.
	wire [15:0] OPSEL_CIC = !PC[4] ? CACHE_Q[15:0] : CACHE_Q[31:16];
	DecInstr_t OPSEL_NX_DECI, OPSEL_C_DECI;
	TMS34020_ID #(.OPSEL_REG(0)) ID_OPSEL_NX (
		.CLK(CLK),.RST_N(RST_N),.EN(EN),.CE_F(CE_F),.CE_R(CE_R),
		.IC(IC),.IC_MATCHES(IC_MATCHES),.IC_RS_STATIC(IC_RS_STATIC),
		.IC_RF_ADDR('0),.IC_RF_ADDR_POS('0),.OPSEL('0),.OPSEL_COMB(OPSEL_NX),
		.STATE(DECI.NST),.STATE_OH(32'b1 << DECI.NST),
		.MD_COND(1'b0),.MD_NEG(1'b0),.MD_DIVIDEND_NEG(1'b0),.DIV_V(1'b0),.J_COND(1'b0),.DS_COND(1'b0),.MM_COND(1'b0),
		.FE0(1'b0),.FE1(1'b0),.RP_COND(1'b0),.LINE_GZ(1'b0),.LINE_COND(1'b0),
		.PIX_XEND(1'b0),.PIX_YEND(1'b0),.PIX_WINEN(1'b0),.PIX_WINCC(4'b0),.PIX_BL(1'b0),.PIX_WE(1'b0),
		.DECI(OPSEL_NX_DECI),.DECI_AT_PRE());
	TMS34020_ID #(.OPSEL_REG(0)) ID_OPSEL_C (
		.CLK(CLK),.RST_N(RST_N),.EN(EN),.CE_F(CE_F),.CE_R(CE_R),
		.IC(OPSEL_CIC),.IC_MATCHES(DecodeICMatches(OPSEL_CIC)),.IC_RS_STATIC(DecodeICRS(OPSEL_CIC)),
		.IC_RF_ADDR('0),.IC_RF_ADDR_POS('0),.OPSEL('0),.OPSEL_COMB(OPSEL_CACHE),
		.STATE(5'd0),.STATE_OH(32'b1),
		.MD_COND(1'b0),.MD_NEG(1'b0),.MD_DIVIDEND_NEG(1'b0),.DIV_V(1'b0),.J_COND(1'b0),.DS_COND(1'b0),.MM_COND(1'b0),
		.FE0(1'b0),.FE1(1'b0),.RP_COND(1'b0),.LINE_GZ(1'b0),.LINE_COND(1'b0),
		.PIX_XEND(1'b0),.PIX_YEND(1'b0),.PIX_WINEN(1'b0),.PIX_WINCC(4'b0),.PIX_BL(1'b0),.PIX_WE(1'b0),
		.DECI(OPSEL_C_DECI),.DECI_AT_PRE());
	// Decoded (IC,STATE) at reset (0900,0) and at interrupt entry (090A,0).
	localparam OpSel_t OPSEL_RST = OPSEL_RST_CONST;
	localparam OpSel_t OPSEL_INT = OPSEL_INT_CONST;
	
	bit  [ 1: 0] WORD_MASK;
	wire IW_WAIT = DECI.IWL[1] && PC[4];
	wire INT_REQ = (DI_REQ || HI_REQ || WV_REQ || INT1_REQ || INT2_REQ) && ST.IE;
	
	always @(posedge CLK or negedge RST_N) begin		
		bit [31: 0] PC_NEXT;
		bit         STATE_DONE;
		
		if (!RST_N) begin
			PC <= 32'hFFFFFFFF;
			IC <= 16'h0900;
			IC_MATCHES <= DecodeICMatches(16'h0900);
			IC_RS_STATIC <= DecodeICRS(16'h0900);
			OPSEL_ALU_FSI_OH <= 6'b100000;
			IW <= '0;
			RST_EXEC <= 1;
			begin STATE <= '0; STATE_OH <= 32'b1 << ('0); IC_RF_ADDR <= DecodeICRFAddress(16'h0900, '0, 0); IC_RF_ADDR_POS <= DecodeICRFAddress(16'h0900, '0, 1); OPSEL <= OPSEL_RST; end
			WORD_MASK <= '0;
		end
		else if (EN && CE_R) begin
			if (!MC_WAIT && !CACHE_WAIT) begin
				if (INT_REQ && DECI.LST) begin
					IC <= 16'h090A;
					IC_MATCHES <= DecodeICMatches(16'h090A);
					IC_RS_STATIC <= DecodeICRS(16'h090A);
					OPSEL_ALU_FSI_OH <= 6'b100000;
					begin STATE <= 5'd0; STATE_OH <= 32'b1 << (5'd0); IC_RF_ADDR <= DecodeICRFAddress(16'h090A, 5'd0, 0); IC_RF_ADDR_POS <= DecodeICRFAddress(16'h090A, 5'd0, 1); OPSEL <= OPSEL_INT; end
				end else if (!DECI.IWL) begin
					begin STATE <= DECI.NST; STATE_OH <= 32'b1 << (DECI.NST); IC_RF_ADDR <= DecodeICRFAddress(IC, DECI.NST, 0); IC_RF_ADDR_POS <= DecodeICRFAddress(IC, DECI.NST, 1); OPSEL <= OPSEL_NX; OPSEL_ALU_FSI_OH <= DecodeAluFSI(OPSEL_NX_DECI.FT.FSI); end
					if (DECI.LST) begin
						IC <= !PC[4] ? CACHE_Q[15:0] : CACHE_Q[31:16];
						IC_MATCHES <= !PC[4] ? DecodeICMatches(CACHE_Q[15:0]) : DecodeICMatches(CACHE_Q[31:16]);
						IC_RS_STATIC <= !PC[4] ? DecodeICRS(CACHE_Q[15:0]) : DecodeICRS(CACHE_Q[31:16]);
						OPSEL_ALU_FSI_OH <= DecodeAluFSI(OPSEL_C_DECI.FT.FSI);
						begin STATE <= 5'd0; STATE_OH <= 32'b1 << (5'd0); IC_RF_ADDR <= !PC[4] ? CACHE_RF_PRE[9:0] : CACHE_RF_PRE[29:20]; IC_RF_ADDR_POS <= !PC[4] ? CACHE_RF_PRE[19:10] : CACHE_RF_PRE[39:30]; OPSEL <= OPSEL_CACHE; end
					end
					
					if (DECI.JC == JC_JUMP) begin
						case (DECI.PCS)
							PCS_REG: PC_NEXT = {RF_RB_Q[31:4],4'h0};
							default: PC_NEXT = PC;
						endcase
					end else if (DECI.JC == JC_COND && J_COND) begin
						case (DECI.PCS)
							PCS_IB: PC_NEXT = PC + { {20{IC[ 7]}},IC[ 7: 0],4'h0 };
							PCS_IW: PC_NEXT = PC + { {12{IW[15]}},IW[15: 0],4'h0 };
							PCS_IL: PC_NEXT = {IW[31: 4],4'h0 };
							default: PC_NEXT = PC;
						endcase
					end else if (DECI.JC == JC_DS && DS_COND) begin
						case (DECI.PCS)
							PCS_K: PC_NEXT = !IC[10] ? PC + { {23{1'b0}},IC[9:5],4'h0 } : PC - { {23{1'b0}},IC[9:5],4'h0 };
							PCS_IW: PC_NEXT = PC + { {12{IW[15]}},IW[15:0],4'h0 };
							default: PC_NEXT = PC;
						endcase
					end else if (DECI.PCW) begin
						if (DECI.LST) begin
							PC_NEXT = PC + 32'h10;
						end else begin
							case (DECI.PCS)
								PCS_IW: PC_NEXT = PC + { {12{IW[15]}},IW[15: 0],4'h0 };
								PCS_IL: PC_NEXT = {IW[31: 4],4'h0 };
								PCS_REG: PC_NEXT = {RF_RB_Q[31:4],4'h0};
								PCS_MEM: PC_NEXT = {MC_DIN[31:4],4'h0};
								default: PC_NEXT = PC;
							endcase
						end
					end
					
					WORD_MASK <= 2'b00;
				end else begin
					if (!PC[4] && !WORD_MASK[0]) begin
						if (DECI.IWL[0]) begin IW[15: 0] <= CACHE_Q[15: 0]; WORD_MASK[0] <= 1; end
						if (DECI.IWL[1]) begin IW[31:16] <= CACHE_Q[31:16]; WORD_MASK[1] <= 1; end
						if (!DECI.IWL[1]) begin
							PC_NEXT = PC + 32'h10;
						end else begin
							PC_NEXT = PC + 32'h20;
						end
						begin STATE <= DECI.NST; STATE_OH <= 32'b1 << (DECI.NST); IC_RF_ADDR <= DecodeICRFAddress(IC, DECI.NST, 0); IC_RF_ADDR_POS <= DecodeICRFAddress(IC, DECI.NST, 1); OPSEL <= OPSEL_NX; OPSEL_ALU_FSI_OH <= DecodeAluFSI(OPSEL_NX_DECI.FT.FSI); end
					end else if (!PC[4] && WORD_MASK[0]) begin
						if (DECI.IWL[1]) begin IW[31:16] <= CACHE_Q[15: 0]; WORD_MASK[1] <= 1; end
						PC_NEXT = PC + 32'h10;
						begin STATE <= DECI.NST; STATE_OH <= 32'b1 << (DECI.NST); IC_RF_ADDR <= DecodeICRFAddress(IC, DECI.NST, 0); IC_RF_ADDR_POS <= DecodeICRFAddress(IC, DECI.NST, 1); OPSEL <= OPSEL_NX; OPSEL_ALU_FSI_OH <= DecodeAluFSI(OPSEL_NX_DECI.FT.FSI); end
					end else begin
						if (DECI.IWL[0]) begin IW[15: 0] <= CACHE_Q[31:16]; WORD_MASK[0] <= 1; end
						PC_NEXT = PC + 32'h10;
						if (!DECI.IWL[1]) begin STATE <= DECI.NST; STATE_OH <= 32'b1 << (DECI.NST); IC_RF_ADDR <= DecodeICRFAddress(IC, DECI.NST, 0); IC_RF_ADDR_POS <= DecodeICRFAddress(IC, DECI.NST, 1); OPSEL <= OPSEL_NX; OPSEL_ALU_FSI_OH <= DecodeAluFSI(OPSEL_NX_DECI.FT.FSI); end
					end
				end
				if (STATE == 5'd7 && RST_EXEC) begin
					RST_EXEC <= 0;
				end
				
				PC <= PC_NEXT;
			end
		end
	end 
	
	bit  [15: 0] LIST;
	bit  [ 3: 0] MM_RN;	
	always @(posedge CLK or negedge RST_N) begin		
		if (!RST_N) begin
			LIST <= 16'h0000;
			MM_RN <= 4'd0;
		end
		else if (EN) begin	
			if (CE_R) begin	
				if (!MC_WAIT && !CACHE_WAIT) begin
					if (DECI.MMS) begin
						LIST <= IW[15:0];
						MM_RN <= BitToReg(IW[15:0],4'd0,0);
					end else if (DECI.MMA) begin
						MM_RN <= BitToReg(LIST,4'd0,0);
					end else begin
						LIST[MM_RN] <= 0;
					end
				end
			end
		end
	end
	assign MM_COND = ~|LIST;

	(* keep = "true" *) bit [10:0] RF_WRITE_SEL;
	bit [31:0] RF_WRITE_D;
	always_comb begin
		RF_WRITE_SEL = '0;
		case (RF_WA_WE ? DECI.RWA.WS : DECI.RWB.WS)
			RS_REGA: RF_WRITE_SEL[0] = 1;
			RS_REGB: RF_WRITE_SEL[1] = 1;
			RS_MEM:  RF_WRITE_SEL[2] = 1;
			RS_PC:   RF_WRITE_SEL[3] = 1;
			RS_ST:   RF_WRITE_SEL[4] = 1;
			RS_ALU: case (DECI.ALU.OP)
				ALUOP_ADD,ALUOP_MUL,ALUOP_DIV: RF_WRITE_SEL[5] = 1;
				ALUOP_ADDXY: RF_WRITE_SEL[6] = 1;
				ALUOP_CPW: RF_WRITE_SEL[7] = 1;
				ALUOP_LOG: RF_WRITE_SEL[8] = 1;
				ALUOP_SHIFT: RF_WRITE_SEL[9] = 1;
				ALUOP_LOC: RF_WRITE_SEL[10] = 1;
				default: RF_WRITE_SEL[2] = 1;
			endcase
			default: RF_WRITE_SEL = '0;
		endcase
	end
	// synopsys translate_off
	always @(posedge CLK) if (RST_N && EN && CE_R && (RF_WA_WE || RF_WB_WE))
		assert (RF_WRITE_D === (RF_WA_WE ? RF_WA_D : RF_WB_D))
			else $fatal(1,"RF flat write source changed actual memory payload");
	// synopsys translate_on

	//Registers bank
	TMS34020_RF RF (
		.CLK(CLK),
		.RST_N(RST_N),
		.CE(CE_R),
		.EN(EN),
		
		.WA_A(RF_WA_N),
		.WA_D(RF_WRITE_D),
		.WA_WE(RF_WA_WE),
		.WB_A(RF_WB_N),
		.WB_D(RF_WRITE_D),
		.WB_WE(RF_WB_WE),
		
		.RA_A(RF_RA_N),
		.RA_Q(RF_RA_Q),
		.RB_A(RF_RB_N),
		.RB_Q(RF_RB_Q)
	);
	assign RF_RA_N = {DECI.R,DECI.RD};
	assign RF_RB_N = DECI.MMA ? {DECI.R,MM_RN^{4{~IC[5]}}} : {DECI.R,DECI.RS};
	
	assign RF_WA_N = {DECI.R^DECI.M,DECI.RD};
	assign RF_WA_WE = ~IW_WAIT & ~MC_WAIT & ~CACHE_WAIT & DECI.RWA.WE;
	assign RF_WB_N = DECI.MMA ? {DECI.R,MM_RN^{4{~IC[5]}}} : {DECI.R,DECI.RS};
	assign RF_WB_WE = ~IW_WAIT & ~MC_WAIT & ~CACHE_WAIT & DECI.RWB.WE;
	
	//ALU
	always_comb begin
		case (DECI.RWA.WS)
			RS_REGA: RF_WA_D <= RF_RA_Q;
			RS_REGB: RF_WA_D <= RF_RB_Q;
			RS_ALU:  RF_WA_D <= ALU_R;
			RS_MEM:  RF_WA_D <= MC_DIN;
//			RS_PIX:  RF_WA_D <= PIX_PAT;
			RS_PC:   RF_WA_D <= PC;
			RS_ST:   RF_WA_D <= ST;
			RS_REV:  RF_WA_D <= 32'h00000000;
			default: RF_WA_D <= '0;
		endcase
		
		case (DECI.RWB.WS)
			RS_REGA: RF_WB_D <= RF_RA_Q;
			RS_REGB: RF_WB_D <= RF_RB_Q;
			RS_ALU:  RF_WB_D <= ALU_R;
			RS_MEM:  RF_WB_D <= MC_DIN;
//			RS_PIX:  RF_WB_D <= PIX_PAT;
			RS_PC:   RF_WB_D <= PC;
			RS_ST:   RF_WB_D <= ST & ST_RMASK;
			RS_REV:  RF_WB_D <= 32'h00000000;
			default: RF_WB_D <= '0;
		endcase
	end
	
	assign VIDEO_EN = IO_REGS.DPYCTL.ENV;
	assign PSIZE = IO_REGS.PSIZE[5:0];
	assign CONVDP = IO_REGS.CONVDP;
	assign CONVSP = IO_REGS.CONVSP;
	assign CONVMP = IO_REGS.CONVMP;
	
	bit [5:0] FS0,FS1;
	function automatic bit [5:0] AluFieldSize(input bit [5:0] sel,
		input bit [4:0] status_fs, input bit [5:0] pixel_fs, input bit [5:0] word_fs);
		return ({6{sel[0]}} & {~|status_fs,status_fs}) |
		       ({6{sel[1]}} & pixel_fs) | ({6{sel[2]}} & word_fs) |
		       ({6{sel[3]}} & 6'd8) | ({6{sel[4]}} & 6'd16) |
		       ({6{sel[5]}} & 6'd32);
	endfunction
	always_comb begin
		case (DECI.FT.FSI)
			FSI_F:  FE <= !DECI.F ? ST.FE0 : ST.FE1;
			default:FE <= DECI.FT.FE;
		endcase
		// Keep field selection after the nonlinear extension/mask logic.
		FS0 = AluFieldSize(OPSEL_ALU_FSI_OH,ST.FS0,PSIZE,PPWToFS(PIXBLT_PPW,PSIZE));
		FS1 = AluFieldSize(OPSEL_ALU_FSI_OH,ST.FS1,PSIZE,PPWToFS(PIXBLT_PPW,PSIZE));
		// FS is the F-selected field size. It reuses the registered one-hot
		// selection (identical to decoding DECI.FT.FSI), so immediate/shift-amount
		// uses of FS no longer pass through the FSI decode.
		FS = DECI.F ? FS1 : FS0;
	end
	
	bit [ 4: 0] ALU_SA;
	// Per-function copies of the shift amount (same load as ALU_SA): the net
	// fed 90 loads through one register. Each copy drives one shifter function.
	(* preserve, dont_merge *) bit [4:0] ALU_SA_C, ALU_SA_V, ALU_SA_Z;
	bit [31:0] ALU_A_D, ALU_B_D;
	(* keep = "true" *) bit [31:0] ALU_A_F0,ALU_A_F1,ALU_B_F0,ALU_B_F1;
	bit [4:0] ALU_SA_D;
	// Decode and execute are separate system-clock stages. CPU consumption
	// remains on CE_R, after the intermediate operand capture has settled.
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin
			ALU_A <= '0;
			ALU_B <= '0;
			ALU_SA <= '0;
			ALU_SA_C <= '0;
			ALU_SA_V <= '0;
			ALU_SA_Z <= '0;
		end else begin
			ALU_A <= ALU_A_D;
			ALU_B <= ALU_B_D;
			ALU_SA <= ALU_SA_D;
			ALU_SA_C <= ALU_SA_D;
			ALU_SA_V <= ALU_SA_D;
			ALU_SA_Z <= ALU_SA_D;
		end
	end
	always_comb begin
		bit [31: 0] IMMA, IMMB;
		bit [31: 0] CONSTA, CONSTB;
		bit [31: 0] REGA, REGB;
		
		// CPU state and write enables hold reset; these combinational values
		// require no reset mux in the arithmetic path.
			case (DECI.AIA.IT)
				IMM_K:    IMMA = {{26{1'b0}} ,~|IC[9:5],IC[9:5]};
				IMM_IW:   IMMA = {{16{IW[15]}},IW[15:0]};
				IMM_IL:   IMMA = IW;
				IMM_FS:   IMMA = {{26{1'b0}},FS};
				default:  IMMA = 32'h00000000;
			endcase
			case (DECI.AIB.IT)
				IMM_K:    IMMB = {{26{1'b0}} ,~|IC[9:5],IC[9:5]};
				IMM_IW:   IMMB = {{16{IW[15]}},IW[15:0]};
				IMM_IL:   IMMB = IW;
				IMM_FS:   IMMB = {{26{1'b0}},FS};
				default:  IMMB = 32'h00000000;
			endcase
			
			case (DECI.AIA.CV)
				CV_0:    CONSTA = 32'h00000000;
				CV_1:    CONSTA = 32'h00000001;
				CV_2:    CONSTA = 32'h00000002;
				CV_4:    CONSTA = 32'h00000004;
				CV_8:    CONSTA = 32'h00000008;
				CV_16:   CONSTA = 32'h00000010;
				CV_32:   CONSTA = 32'h00000020;
				default: CONSTA = 32'h00000000;
			endcase
			case (DECI.AIB.CV)
				CV_0:    CONSTB = 32'h00000000;
				CV_1:    CONSTB = 32'h00000001;
				CV_2:    CONSTB = 32'h00000002;
				CV_4:    CONSTB = 32'h00000004;
				CV_8:    CONSTB = 32'h00000008;
				CV_16:   CONSTB = 32'h00000010;
				CV_32:   CONSTB = 32'h00000020;
				default: CONSTB = 32'h00000000;
			endcase
			
			case (DECI.AIA.AS)
				AS_REGA:  REGA = RF_RA_Q;
				AS_REGB:  REGA = RF_RB_Q;
				AS_IMM:   REGA = IMMA;
				AS_CONST: REGA = CONSTA;
				AS_STF:   REGA = {{26{1'b0}},!IC[9] ? ST[5:0] : ST[11:6]};
				AS_PS:    REGA = {16'h0000,IO_REGS.PSIZE};
				AS_PIX:   REGA = '0;
				AS_MDAL:  REGA = MD_ACC[31:0];
				AS_MDAH:  REGA = MD_ACC[63:32];
				AS_MDQ:   REGA = MD_Q;
				default:  REGA = '0;
			endcase
			case (DECI.AIB.AS)
				AS_REGA:  REGB = RF_RA_Q;
				AS_REGB:  REGB = RF_RB_Q;
				AS_IMM:   REGB = IMMB;
				AS_CONST: REGB = CONSTB;
				AS_STF:   REGB = {{26{1'b0}},!IC[9] ? ST[5:0] : ST[11:6]};
				AS_PS:    REGB = {16'h0000,IO_REGS.PSIZE};
				AS_PIX:   REGB = '0;
				AS_MDAL:  REGB = MD_ACC[31:0];
				AS_MDAH:  REGB = MD_ACC[63:32];
				AS_MDQ:   REGB = MD_Q;
				default:  REGB = '0;
			endcase
						
			// Every AS_PIX decoder assignment selects EO_NONE. Keep the
			// complete pixel-helper result outside the general extension mux.
			ALU_A_F0 = Ext(REGA, FS0, DECI.AIA.EO);
			ALU_A_F1 = Ext(REGA, FS1, DECI.AIA.EO);
			ALU_B_F0 = Ext(REGB, FS0, DECI.AIB.EO);
			ALU_B_F1 = Ext(REGB, FS1, DECI.AIB.EO);
			ALU_A_D = DECI.AIA.AS == AS_PIX ? PIXALU_NEXT : (DECI.F ? ALU_A_F1 : ALU_A_F0);
			ALU_B_D = DECI.AIB.AS == AS_PIX ? PIXALU_NEXT : (DECI.F ? ALU_B_F1 : ALU_B_F0);
			`ifdef MISTER_ALU_PIPE_CHECK
			UNPIPE_ALU_A = Ext(DECI.AIA.AS == AS_PIX ? PIXALU_NEXT : REGA, FS, DECI.AIA.EO);
			UNPIPE_ALU_B = Ext(DECI.AIB.AS == AS_PIX ? PIXALU_NEXT : REGB, FS, DECI.AIB.EO);
			`endif
			
			case (DECI.SHC.AMS)
				SS_REG:   ALU_SA_D = RF_RB_Q[4:0];
				SS_IMM:   ALU_SA_D = IMMB[4:0];
				SS_CONST: ALU_SA_D = CONSTB[4:0];
				SS_FS:    ALU_SA_D = FS[4:0];
				default:  ALU_SA_D = '0;
			endcase
	end

`ifdef MISTER_ALU_PIPE_CHECK
	bit [31:0] UNPIPE_ALU_A, UNPIPE_ALU_B;
	bit [31:0] LEGACY_ALU_A, LEGACY_ALU_B;
	bit [4:0] LEGACY_ALU_SA;
`ifndef SYNTHESIS
	always @(posedge CLK) if (RST_N) assert (ALU_SA_C == ALU_SA && ALU_SA_V == ALU_SA && ALU_SA_Z == ALU_SA)
		else $fatal(1,"ALU shift amount copies differ from ALU_SA");
`endif
	bit [68:0] ALU_PHASE_PREVIOUS;
	bit ALU_PHASE_VALID, ALU_PHASE_R;
	always @(posedge CLK) begin
		ALU_PHASE_R <= CE_R;
		if (RST_N && EN && CE_R) begin
			assert ((DECI.AIA.AS != AS_PIX || DECI.AIA.EO == EO_NONE) &&
			        (DECI.AIB.AS != AS_PIX || DECI.AIB.EO == EO_NONE))
				else $fatal(1,"pixel operand unexpectedly requires field extension");
			assert ({ALU_A,ALU_B,ALU_SA} === {LEGACY_ALU_A,LEGACY_ALU_B,LEGACY_ALU_SA})
				else $fatal(1,"ALU operands differ from the original pipeline at CPU consumption");
			assert (!(RF_WA_WE && RF_WB_WE))
				else $fatal(1,"simulation register file used simultaneous hardware writes");
		end
		LEGACY_ALU_A <= UNPIPE_ALU_A;
		LEGACY_ALU_B <= UNPIPE_ALU_B;
		LEGACY_ALU_SA <= ALU_SA_D;
	end
	always @(negedge CLK) begin
		if (RST_N && EN && ALU_PHASE_VALID && !ALU_PHASE_R)
			assert ({UNPIPE_ALU_A,UNPIPE_ALU_B,ALU_SA_D} === ALU_PHASE_PREVIOUS)
				else $fatal(1,"decoded ALU operand changed outside CE_R");
		ALU_PHASE_VALID <= RST_N && EN;
		ALU_PHASE_PREVIOUS <= {UNPIPE_ALU_A,UNPIPE_ALU_B,ALU_SA_D};
	end
`endif
			
	// Resolve nibble priorities in parallel, before selecting direction.
	// Keep the package locator's zero cases: dir=0 -> 31, dir=1 -> 0.
	function bit [4:0] BtOneLocate(input bit [31:0] val, input bit dir);
		bit [7:0] present, high_group, low_group;
		bit [4:0] high_index, low_index, index;
		present[0] = |val[3:0];
		present[1] = |val[7:4];
		present[2] = |val[11:8];
		present[3] = |val[15:12];
		present[4] = |val[19:16];
		present[5] = |val[23:20];
		present[6] = |val[27:24];
		present[7] = |val[31:28];
		high_group[0] = present[0] & ~|present[7:1];
		high_group[1] = present[1] & ~|present[7:2];
		high_group[2] = present[2] & ~|present[7:3];
		high_group[3] = present[3] & ~|present[7:4];
		high_group[4] = present[4] & ~|present[7:5];
		high_group[5] = present[5] & ~|present[7:6];
		high_group[6] = present[6] & ~|present[7:7];
		high_group[7] = present[7];
		low_group[0] = present[0];
		low_group[1] = present[1] & ~|present[0:0];
		low_group[2] = present[2] & ~|present[1:0];
		low_group[3] = present[3] & ~|present[2:0];
		low_group[4] = present[4] & ~|present[3:0];
		low_group[5] = present[5] & ~|present[4:0];
		low_group[6] = present[6] & ~|present[5:0];
		low_group[7] = present[7] & ~|present[6:0];
		high_index[4] = |(high_group & 8'b11110000);
		high_index[3] = |(high_group & 8'b11001100);
		high_index[2] = |(high_group & 8'b10101010);
		low_index[4] = |(low_group & 8'b11110000);
		low_index[3] = |(low_group & 8'b11001100);
		low_index[2] = |(low_group & 8'b10101010);
		high_index[1] = (high_group[0] & |val[3:2])
			| (high_group[1] & |val[7:6])
			| (high_group[2] & |val[11:10])
			| (high_group[3] & |val[15:14])
			| (high_group[4] & |val[19:18])
			| (high_group[5] & |val[23:22])
			| (high_group[6] & |val[27:26])
			| (high_group[7] & |val[31:30]);
		high_index[0] = (high_group[0] & (val[3] | (~val[2] & val[1])))
			| (high_group[1] & (val[7] | (~val[6] & val[5])))
			| (high_group[2] & (val[11] | (~val[10] & val[9])))
			| (high_group[3] & (val[15] | (~val[14] & val[13])))
			| (high_group[4] & (val[19] | (~val[18] & val[17])))
			| (high_group[5] & (val[23] | (~val[22] & val[21])))
			| (high_group[6] & (val[27] | (~val[26] & val[25])))
			| (high_group[7] & (val[31] | (~val[30] & val[29])));
		low_index[1] = (low_group[0] & ~|val[1:0] & |val[3:2])
			| (low_group[1] & ~|val[5:4] & |val[7:6])
			| (low_group[2] & ~|val[9:8] & |val[11:10])
			| (low_group[3] & ~|val[13:12] & |val[15:14])
			| (low_group[4] & ~|val[17:16] & |val[19:18])
			| (low_group[5] & ~|val[21:20] & |val[23:22])
			| (low_group[6] & ~|val[25:24] & |val[27:26])
			| (low_group[7] & ~|val[29:28] & |val[31:30]);
		low_index[0] = (low_group[0] & ((val[1] & ~val[0]) | (val[3] & ~|val[2:0])))
			| (low_group[1] & ((val[5] & ~val[4]) | (val[7] & ~|val[6:4])))
			| (low_group[2] & ((val[9] & ~val[8]) | (val[11] & ~|val[10:8])))
			| (low_group[3] & ((val[13] & ~val[12]) | (val[15] & ~|val[14:12])))
			| (low_group[4] & ((val[17] & ~val[16]) | (val[19] & ~|val[18:16])))
			| (low_group[5] & ((val[21] & ~val[20]) | (val[23] & ~|val[22:20])))
			| (low_group[6] & ((val[25] & ~val[24]) | (val[27] & ~|val[26:24])))
			| (low_group[7] & ((val[29] & ~val[28]) | (val[31] & ~|val[30:28])));
		// LMO returns 31 - leftmost bit, RMO the rightmost bit number itself;
		// both return 0 for a zero source (MAME 0.289 34010ops.hxx LMO/RMO).
		index = dir ? low_index : ~high_index;
		return index & {5{|present}};
	endfunction

	function bit [32:0] BtCarryShifter(input bit [31:0] val, input bit [4:0] sa, input bit [3:0] code);
		bit [31: 0] tmp0, tmp1, tmp2, tmp3, tmp4;
		bit         cl0, cl1, cl2, cl3, cl4;
		bit         cr0, cr1, cr2, cr3, cr4;
		bit [ 4: 0] s;
		bit         rot,arith,dir;
		
		// Negating the five-bit amount does not need a serial carry chain.
		// A negative count flips bit k exactly when a lower bit is set.
		s[0] = sa[0];
		s[1] = sa[1] ^ (code[0] & sa[0]);
		s[2] = sa[2] ^ (code[0] & |sa[1:0]);
		s[3] = sa[3] ^ (code[0] & |sa[2:0]);
		s[4] = sa[4] ^ (code[0] & |sa[3:0]);
		{rot,arith,dir} = code[2:0];
		
		{cl0,tmp0,cr0} = !s[0] ? {1'b0, val,1'b0} : (dir ? { 1'b0,{ 1{ val[31]}}&{ 1{arith}}, val[31: 1], val[ 0]} : { val[31], val[30:0], val[31:31]&{ 1{rot}},1'b0 });
		{cl1,tmp1,cr1} = !s[1] ? { cl0,tmp0, cr0} : (dir ? { 1'b0,{ 2{tmp0[31]}}&{ 2{arith}},tmp0[31: 2],tmp0[ 1]} : {tmp0[30],tmp0[29:0],tmp0[31:30]&{ 2{rot}},1'b0 });
		{cl2,tmp2,cr2} = !s[2] ? { cl1,tmp1, cr1} : (dir ? { 1'b0,{ 4{tmp1[31]}}&{ 4{arith}},tmp1[31: 4],tmp1[ 3]} : {tmp1[28],tmp1[27:0],tmp1[31:28]&{ 4{rot}},1'b0 });
		{cl3,tmp3,cr3} = !s[3] ? { cl2,tmp2, cr2} : (dir ? { 1'b0,{ 8{tmp2[31]}}&{ 8{arith}},tmp2[31: 8],tmp2[ 7]} : {tmp2[24],tmp2[23:0],tmp2[31:24]&{ 8{rot}},1'b0 });
		{cl4,tmp4,cr4} = !s[4] ? { cl3,tmp3, cr3} : (dir ? { 1'b0,{16{tmp3[31]}}&{16{arith}},tmp3[31:16],tmp3[15]} : {tmp3[16],tmp3[15:0],tmp3[31:16]&{16{rot}},1'b0 });
		return {dir?cr4:cl4,tmp4};
	endfunction

	function bit BtShiftLeftOvf(input bit [31:0] val, input bit [4:0] sa);
		bit [30:0] terms;
		// SLA overflows when a discarded bit or the new sign differs from
		// the original sign. Include bit 30 for count 1 and bit 0 for count 31.
		for (int n = 0; n < 31; n = n + 1)
			terms[n] = (val[n] ^ val[31]) & (sa >= 5'(31 - n));
		return |terms;
	endfunction

	function automatic bit BtShiftZero(input bit [31:0] val, input bit [4:0] sa, input bit [3:0] code);
		bit [31:0] kept;
		// Test the original bits that survive. Right counts use -sa modulo32;
		// sign-fill adds no nonzero bit unless the retained sign is already1.
		for (int n = 0; n < 32; n = n + 1)
			kept[n] = val[n] & (code[0]
				? ((sa == 5'd0) | ({1'b0,sa} >= 6'(32 - n)))
				: (code[2] | ({1'b0,sa} < 6'(32 - n))));
		return ~|kept;
	endfunction

	function automatic bit BtLoggerZero(input bit [31:0] a, input bit [31:0] b, input bit [3:0] code, input bit a_zero);
		bit [31:0] b2, bmask;
		bit zero;
		b2 = b ^ {32{code[0]}};
		bmask = 32'h00000001 << b2[4:0];
		// Reduce each operation before the flag selector. The data result and
		// its original Logger/overflow/carry paths remain independent.
		case (code[2:1])
			2'b00: zero = ~|(a & b2);
			2'b01: zero = a_zero & ~|b2;
			2'b10: zero = ~|(a ^ b2);
			2'b11: zero = ~|(a & bmask);
		endcase
		return zero;
	endfunction

	bit         ADDXY_CX;
	bit         ADDXY_CY;
	always_comb begin
//		bit [31: 0] ADD_B;
		bit [ 1: 0] ADD_CD;
		bit         ADD_BCOMP;
		bit [31: 0] ADDER_RES;
		bit         ADDER_C;
		bit         ADDER_V;
		bit         ADDER_Z;
		bit [31: 0] ADDXY_RES;
		bit [ 1: 0] ADDXY_Z;
		bit [31: 0] LOG_RES;
		bit         LOG_V;
		bit [31: 0] SHIFT_RES;
		bit         SHIFT_C;
		bit         SHIFT_V;
		bit         SHIFT_Z, LOG_Z;
		bit [ 4: 0] LOC_RES;
				
		{SHIFT_C,SHIFT_RES} = BtCarryShifter(ALU_A, ALU_SA_C, DECI.SHC.SHOP);
		SHIFT_V = BtShiftLeftOvf(ALU_A, ALU_SA_V);
		SHIFT_Z = BtShiftZero(ALU_A, ALU_SA_Z, DECI.SHC.SHOP);
		
//		ADD_B <= DECI.ALU.OP == ALUOP_DIV ? DIV_Q : ALU_B;
		{ADD_CD,ADD_BCOMP} = !DECI.ALU.CD[2] ? {DECI.ALU.CD[1:0],DECI.ALU.BCOMP} : {1'b0,ALU_B[31],ALU_B[31]};
		{ADDER_C,ADDER_RES} = CarryAdder(ALU_A, ALU_B, ST.C, ADD_CD, ADD_BCOMP, DECI.ALU.OP==ALUOP_ADDXY); 
		ADDER_V = ((ALU_A[31] ^ (ALU_B[31] ^ ~ADD_BCOMP)) ^ ~ADD_CD[0]) & (ALU_A[31] ^ ADDER_RES[31]);
		ADDER_Z = ~|ADDER_RES;
		
		{ADDXY_CY,ADDXY_CX,ADDXY_RES} = XYAdjust(ADDER_RES, PIX_DYDX, DECI.ALU.CD[3]);
		ADDXY_Z = {~|ADDER_RES[31:16], ~|ADDER_RES[15:0]};
		
		ALU_XY_CC = XYCompareWin(RF_RB_Q, WSTART, WEND);
		
		LOG_RES = Logger(SHIFT_RES, ALU_B, DECI.ALU.CD);
		LOG_Z = BtLoggerZero(SHIFT_RES, ALU_B, DECI.ALU.CD, SHIFT_Z); 
		LOG_V = ~((~|LOG_RES & ~SHIFT_RES[31]) | (&LOG_RES & SHIFT_RES[31]));
		 
		LOC_RES = BtOneLocate(ALU_B, DECI.ALU.CD[0]);
		
		case (DECI.ALU.OP)
			ALUOP_ADD:   {ALU_N,ALU_Z,ALU_V,ALU_C,ALU_R} <= {ADDER_RES[31],ADDER_Z     ,ADDER_V      ,ADDER_C      ,ADDER_RES};
			ALUOP_ADDXY: {ALU_N,ALU_Z,ALU_V,ALU_C,ALU_R} <= {ADDXY_Z[0]   ,ADDXY_Z[1]  ,ADDXY_RES[15],ADDXY_RES[31],ADDXY_RES};
			ALUOP_CPW:   {ALU_N,ALU_Z,ALU_V,ALU_C,ALU_R} <= {1'b0         ,1'b0        ,|ALU_XY_CC   ,1'b0         ,{24'h000000,ALU_XY_CC,4'h0}};
			ALUOP_LOG:   {ALU_N,ALU_Z,ALU_V,ALU_C,ALU_R} <= {1'b0         ,LOG_Z       ,LOG_V        ,1'b0         ,LOG_RES};
			ALUOP_SHIFT: {ALU_N,ALU_Z,ALU_V,ALU_C,ALU_R} <= {SHIFT_RES[31],SHIFT_Z     ,SHIFT_V      ,SHIFT_C      ,SHIFT_RES};
			ALUOP_LOC:   {ALU_N,ALU_Z,ALU_V,ALU_C,ALU_R} <= {1'b0         ,~|ALU_B     ,1'b0         ,1'b0         ,{27'h0000000,LOC_RES}};
			ALUOP_MUL:   {ALU_N,ALU_Z,ALU_V,ALU_C,ALU_R} <= {MD_ACC[63]   ,~|MD_ACC    ,1'b0         ,1'b0         ,ADDER_RES};
			ALUOP_DIV:   {ALU_N,ALU_Z,ALU_V,ALU_C,ALU_R} <= {ADDER_RES[31] && !DIV_V,ADDER_Z && !DIV_V,DIV_V,1'b0,ADDER_RES};
			default:     {ALU_N,ALU_Z,ALU_V,ALU_C,ALU_R} <= {MC_DIN[31]   ,~|MC_DIN    ,1'b0         ,1'b0         ,MC_DIN};
		endcase

		// Factor the line predicate directly from each operation's flags.
		// The three N=0 operations always satisfy it. For ADD/MUL/SHIFT and MOV,
		// zero implies sign=0, so the zero term adds no information.
		// ADDXY uses independent half-word zero flags and keeps IC[7] live.
		case (DECI.ALU.OP)
			ALUOP_ADD: ALU_LINE_GZ = ~ADDER_RES[31];
			ALUOP_DIV: ALU_LINE_GZ = DIV_V || ~ADDER_RES[31];
			ALUOP_ADDXY: ALU_LINE_GZ = ~ADDXY_Z[0] | (ADDXY_Z[1] & ~IC[7]);
			ALUOP_CPW, ALUOP_LOG, ALUOP_LOC: ALU_LINE_GZ = 1'b1;
			ALUOP_MUL: ALU_LINE_GZ = ~MD_ACC[63];
			ALUOP_SHIFT: ALU_LINE_GZ = ~SHIFT_RES[31];
			default: ALU_LINE_GZ = ~MC_DIN[31];
		endcase
		RF_WRITE_D = ({32{RF_WRITE_SEL[0]}} & RF_RA_Q)
			| ({32{RF_WRITE_SEL[1]}} & RF_RB_Q)
			| ({32{RF_WRITE_SEL[2]}} & MC_DIN)
			| ({32{RF_WRITE_SEL[3]}} & PC)
			| ({32{RF_WRITE_SEL[4]}} & ST & ({32{RF_WA_WE}} | ST_RMASK))
			| ({32{RF_WRITE_SEL[5]}} & ADDER_RES)
			| ({32{RF_WRITE_SEL[6]}} & ADDXY_RES)
			| ({32{RF_WRITE_SEL[7]}} & {24'h000000,ALU_XY_CC,4'h0})
			| ({32{RF_WRITE_SEL[8]}} & LOG_RES)
			| ({32{RF_WRITE_SEL[9]}} & SHIFT_RES)
			| ({32{RF_WRITE_SEL[10]}} & {27'h0000000,LOC_RES});
	end
	
	//DIV unit
		bit [63: 0] MDALU_A;
		bit [63: 0] MDALU_B;
		bit [63: 0] MDALU_R;
		bit [63: 0] MDSHT_R;
		bit         MDALU_C;
		bit         MDALU_Z;
		bit [ 5: 0] MD_STEP;
	always_comb begin
		bit [ 1: 0] ADD_CD;
		bit         ADD_BCOMP;
		bit [63: 0] ADDER_RES;
		bit         ADDER_C;
		bit         ADDER_Z;
		
		case (DECI.MDC.ACCS)
			MDA_ZERO: begin
				MDALU_A = '0;
				MDALU_B = '0;
				{ADD_CD,ADD_BCOMP} = {2'b00,1'b0};
			end
			MDA_MULT: begin
				MDALU_A = MD_ACC;
				MDALU_B = MultStep2Mode(RF_RA_Q, MD_SHIFT[1:0], MD_STEP, ~IC[9]);
				{ADD_CD,ADD_BCOMP} = {2'b00,1'b0};
			end
			MDA_DIV: begin
				MDALU_A = MD_ACC;
				MDALU_B = MD_SHIFT;
				{ADD_CD,ADD_BCOMP} = {2'b01,1'b1};
			end
			MDA_LDL: begin
				MDALU_A = '0;
				MDALU_B = '0;
				{ADD_CD,ADD_BCOMP} = {2'b00,1'b0};
			end
			MDA_LDH: begin
				MDALU_A = '0;
				MDALU_B = '0;
				{ADD_CD,ADD_BCOMP} = {2'b00,1'b0};
			end
			MDA_NEG: begin
				MDALU_A = '0;
				MDALU_B = MD_ACC;
				{ADD_CD,ADD_BCOMP} = {{1'b0,MD_NEG},MD_NEG};
			end
			default: begin
				MDALU_A = MD_ACC;
				MDALU_B = '0;
				{ADD_CD,ADD_BCOMP} = {2'b00,1'b0};
			end
		endcase
					
		{ADDER_C,ADDER_RES} = MDCarryAdder(MDALU_A, MDALU_B, ADD_CD, ADD_BCOMP);
		ADDER_Z = ~|ADDER_RES;
		
		// Loads already have their final value. Avoid cascading the 32-bit ALU
		// through a second 64-bit adder just to add zero.
		case (DECI.MDC.ACCS)
			MDA_LDL: {MDALU_Z, MDALU_C, MDALU_R} <=
				{~|ALU_R, 1'b0, {32{ALU_R[31] && !IC_MATCHES[77] && !IC_MATCHES[87]}}, ALU_R};
			MDA_LDH: {MDALU_Z, MDALU_C, MDALU_R} <=
				{~|{ALU_R,MD_ACC[31:0]}, 1'b0, ALU_R, MD_ACC[31:0]};
			default: {MDALU_Z, MDALU_C, MDALU_R} <=
				{ADDER_Z, ADDER_C, ADDER_C && DECI.MDC.ACCS == MDA_DIV ? MD_ACC : ADDER_RES};
		endcase
		
		case (DECI.MDC.SHS)
			MDSH_MULT: MDSHT_R <= {MD_SHIFT[63],MD_SHIFT[63],MD_SHIFT[63:2]};
			MDSH_DIV:  MDSHT_R <= {1'b0,MD_SHIFT[63:1]};
			MDSH_LDM:  MDSHT_R <= {{32{ALU_R[31]}},ALU_R};
			MDSH_LDD:  MDSHT_R <= {ALU_R,32'h00000000}; 
			default:   MDSHT_R <= MD_SHIFT;
		endcase 
	end
	
	always @(posedge CLK or negedge RST_N) begin	
		bit [ 5: 0] MUL_STEP_NEXT;
		bit         MUL_STEP_LAST;
		bit [ 5: 0] DIV_STEP_NEXT;
		
		if (!RST_N) begin
			MD_ACC <= '0;
			MD_SHIFT <= '0;
			MD_Q <= '0;
			MD_STEP <= '0;
			MD_COND <= 0;
			MD_NEG <= 0;
			MD_DIVIDEND_NEG <= 0;
			DIV_V <= 0;
		end
		else if (EN && CE_R) begin
			if (!IW_WAIT && !MC_WAIT && !CACHE_WAIT) begin
				MUL_STEP_NEXT = MD_STEP + 6'd2;
				MUL_STEP_LAST = MUL_STEP_NEXT >= (FS - 6'd2);
				DIV_STEP_NEXT = MD_STEP + 6'd1; 
				
				MD_ACC <= MDALU_R;
				MD_SHIFT <= MDSHT_R;
				case (DECI.MDC.OP)
					MDO_MULINIT: begin
						MD_STEP <= '0;
						MD_COND <= 0;
					end
					MDO_MULCHK: begin
						MD_NEG <= ALU_B[31] & ~IC[9];
						MD_COND <= FS <= 6'd2;
					end
					MDO_MULSTEP: begin
						MD_STEP <= MUL_STEP_NEXT; 
						MD_COND <= MUL_STEP_LAST;
					end
					
					MDO_DIVINIT: begin
						MD_Q <= '0;
						MD_NEG <= ALU_B[31] & ~IC[9]; 
						MD_DIVIDEND_NEG <= ALU_B[31] & ~IC[9];
						MD_STEP <= '0; 
						MD_COND <= 0; 
					end
					MDO_DIVDVNT: begin
						MD_NEG <= ALU_B[31] & ~IC[9]; 
						MD_DIVIDEND_NEG <= ALU_B[31] & ~IC[9];
					end
					MDO_DIVDVSR: begin
						DIV_V <= ALU_Z;
						MD_NEG <= (ALU_B[31] ^ MD_NEG) & ~IC[9];
					end
					MDO_DIVSTEP: begin
						// The first subtraction compares |dividend| with |divisor|<<32.
						// Reuse its borrow to detect a quotient wider than 32 bits.
						if (MD_STEP == 0) DIV_V <= DIV_V | !MDALU_C;
						MD_Q <= {MD_Q[30:0],~MDALU_C};
						MD_STEP <= DIV_STEP_NEXT; 
						MD_COND <= MD_STEP == 6'd31;
					end
					MDO_DIVQUOT: begin 
						// Signed results allow -2^31, but no other magnitude with bit31.
						DIV_V <= DIV_V | (!IC[9] && MD_Q[31] &&
							(!MD_NEG || |MD_Q[30:0]));
						MD_Q <= (MD_Q ^ {32{MD_NEG}}) + MD_NEG;
					end
						
					default: ;
				endcase
			end
		end
	end 
	
	
	//Conditions
	always @(posedge CLK or negedge RST_N) begin		
		if (!RST_N) begin
			DS_Z <= 0;
		end
		else if (EN && CE_R) begin
			if (!IW_WAIT && !MC_WAIT && !CACHE_WAIT) begin
				DS_Z <= ALU_Z;
			end
		end
	end 
	
	always_comb begin
		case (IC[11:8])
			4'h0: J_COND <= 1'b1;	//UC
			4'h1: J_COND <= ~ST.N & ~ST.Z;	//P
			4'h2: J_COND <= ST.C | ST.Z;//LS
			4'h3: J_COND <= ~ST.C & ~ST.Z;//HI
			4'h4: J_COND <= (ST.N & ~ST.V) | (~ST.N & ST.V);//LT
			4'h5: J_COND <= (ST.N & ST.V) | (~ST.N & ~ST.V);//GE
			4'h6: J_COND <= (ST.N & ~ST.V) | (~ST.N & ST.V) | ST.Z;//LE
			4'h7: J_COND <= (ST.N & ST.V & ~ST.Z) | (~ST.N & ~ST.V & ~ST.Z);//GT
			4'h8: J_COND <= ST.C;//LO
			4'h9: J_COND <= ~ST.C;//HS
			4'hA: J_COND <= ST.Z;//EQ
			4'hB: J_COND <= ~ST.Z;//NE
			4'hC: J_COND <= ST.V;//V
			4'hD: J_COND <= ~ST.V;	//NV
			4'hE: J_COND <= ST.N;//N
			4'hF: J_COND <= ~ST.N;//NN
		endcase 
		
		case (STATE)
			5'd0: DS_COND <= ST.Z;
			5'd1: DS_COND <= ~DS_Z;
			default: DS_COND <= 0;
		endcase
	end
	
	//STATUS register
	always @(posedge CLK or negedge RST_N) begin		
		if (!RST_N) begin
			ST <= ST_INIT;
		end
		else if (EN && CE_R) begin
			if (!IW_WAIT && !MC_WAIT && !CACHE_WAIT) begin
				case (DECI.STW.STU)
					STU_ST:  ST <= RF_RA_Q & ST_WMASK;
					STU_MEM: ST <= MC_DIN & ST_WMASK;
					STU_RES: ST <= ST_INIT;
					STU_FS: case (DECI.F)
						1'b0: {ST.FE0,ST.FS0} <= IC[5:0];
						1'b1: {ST.FE1,ST.FS1} <= IC[5:0];
					endcase
					STU_EXFS: case (DECI.F)
						1'b0: {ST.FE0,ST.FS0} <= RF_RA_Q[5:0];
						1'b1: {ST.FE1,ST.FS1} <= RF_RA_Q[5:0];
					endcase
					STU_C:  ST.C <= IC[11];
					STU_IE: ST.IE <= IC[11];
					STU_ALU: begin
						if (DECI.STW.AFU[3]) ST.N <= ALU_N;
						if (DECI.STW.AFU[2]) ST.C <= ALU_C;
						if (DECI.STW.AFU[1]) ST.Z <= ALU_Z;
						if (DECI.STW.AFU[0]) ST.V <= ALU_V;
					end
					default:;
				endcase
			end
		end
	end 
	
	//Pixel unit
	// Pixel arithmetic depends only on R-phase state. Keep it combinational
	// so the next R-phase writeback has the full interval between R edges.
	always_comb begin
		bit [31: 0] REGS;
		bit [31: 0] REGD;
		bit [ 4: 0] CONVxP;
		bit [31: 0] PIX_OFFS;
		
		case (DECI.PALU.AS)
			PIXAS_REGA: begin REGS = RF_RA_Q; REGD = RF_RB_Q; end
			PIXAS_REGB: begin REGS = RF_RB_Q; REGD = RF_RA_Q; end
		endcase
			
		case (DECI.PALU.CNVS)
			CNVS_DP: begin CONVxP = CONVDP[4:0]; PIX_OFFS = PIX_DOFFS; end
			CNVS_SP: begin CONVxP = CONVSP[4:0]; PIX_OFFS = PIX_SOFFS; end
			CNVS_MP: begin CONVxP = CONVMP[4:0]; PIX_OFFS = PIX_MOFFS; end
			default: begin CONVxP = '0; PIX_OFFS = '0; end
		endcase
		
		case (DECI.PALU.AOP)
			PIXOP_PPW:   PIXALU_NEXT = PPWToFS(PIXBLT_PPW, PSIZE);
			PIXOP_XYL:   PIXALU_NEXT = XYToL(REGS, PSIZE, CONVxP);
			PIXOP_XYS:   PIXALU_NEXT = {16'h0000,PIXBLT_PPW};
			PIXOP_MOVX:  PIXALU_NEXT = {REGD[31:16],REGS[15:0]};
			PIXOP_MOVY:  PIXALU_NEXT = {REGS[31:16],REGD[15:0]};
			PIXOP_OFFS:  PIXALU_NEXT = PIX_OFFS;
			PIXOP_LNS:   PIXALU_NEXT = LineStep(PIX_DYDX, LINE_GZ);
			PIXOP_WSTA:  PIXALU_NEXT = XYWinOffset(REGS, WSTART);
			default:  PIXALU_NEXT = '0;
		endcase
	end
	
	always @(posedge CLK or negedge RST_N) begin		
		if (!RST_N) begin
			WSTART <= '0;
			WEND <= '0;
			COLOR0 <= '0;
			COLOR1 <= '0;
			PATTERN <= '0;
		end
		else if (EN) begin	
			if (!IW_WAIT & !MC_WAIT && !CACHE_WAIT && CE_R) begin
				if (RF_WA_N[4] && RF_WA_WE)
					case (RF_WA_N[3:0])
						4'd5: WSTART <= RF_WA_D;
						4'd6: WEND <= RF_WA_D;
						4'd8: COLOR0 <= RF_WA_D;
						4'd9: COLOR1 <= RF_WA_D;
						4'd13: PATTERN <= RF_WA_D;
					endcase
					
				if (RF_WB_N[4] && RF_WB_WE)
					case (RF_WB_N[3:0])
						4'd5: WSTART <= RF_WB_D;
						4'd6: WEND <= RF_WB_D;
						4'd8: COLOR0 <= RF_WB_D;
						4'd9: COLOR1 <= RF_WB_D;
						4'd13: PATTERN <= RF_WB_D;
					endcase
			end
		end
	end
	
	always @(posedge CLK or negedge RST_N) begin		
		bit [ 5:0] prest;
		bit [ 5:0] pmax;
		bit [15:0] temp;
		bit [15:0] temp2;
		bit [15:0] pm;
		bit [31:0] PAT;
		
		if (!RST_N) begin
			RP_COND <= 0;
			PIX_XEND <= 0;
			PIX_YEND <= 0;
			PIX_BL <= 0;
			PIXBLT_PPW <= '0;
			PIXBLT_X <= '0;
			PIX_POS <= '0;
			PIX_BIT <= '0;
			LINE_GZ <= 0;
			LINE_COND <= 0;
		end
		else if (EN && CE_R) begin
			if (!IW_WAIT && !MC_WAIT && !CACHE_WAIT) begin
				LINE_COND <= ALU_Z;
		
				case (STATE)
					5'd0: RP_COND <= PSIZE == 6'h20;
					5'd2: RP_COND <= PSIZE == 6'h10;
					5'd3: RP_COND <= PSIZE == 6'h08;
					5'd4: RP_COND <= PSIZE == 6'h04;
					5'd5: RP_COND <= PSIZE == 6'h02;
					5'd6: RP_COND <= PSIZE == 6'h01;
					default: RP_COND <= 0;
				endcase
				
				case (PSIZE)
					default: pm = 16'h0000;
					6'h01: pm = 16'hFFE0;
					6'h02: pm = 16'hFFF0;
					6'h04: pm = 16'hFFF8;
					6'h08: pm = 16'hFFFC;
					6'h10: pm = 16'hFFFE;
					6'h20: pm = 16'hFFFF;
				endcase
				
				case (DECI.PF.BLT)
					PBLT_STRT: begin
						{PIX_YEND,PIX_XEND} <= '0;
						
						case (PSIZE)
							6'h01: pmax = 6'h20 - {1'b0,RF_RA_Q[4:0]};
							6'h02: pmax = 6'h10 - {2'b00,RF_RA_Q[4:1]};
							6'h04: pmax = 6'h08 - {3'b000,RF_RA_Q[4:2]};
							6'h08: pmax = 6'h04 - {4'b0000,RF_RA_Q[4:3]};
							6'h10: pmax = 6'h02 - {5'b00000,RF_RA_Q[4:4]};
							default: pmax = 6'h01;
						endcase
						
						temp = PIX_DYDX.X - 16'd1;
						if (!(temp & pm)) begin
							case (PSIZE)
								6'h01: prest = {PIX_DYDX.X[5:0]};
								6'h02: prest = {1'b0,PIX_DYDX.X[4:0]};
								6'h04: prest = {2'b00,PIX_DYDX.X[3:0]};
								6'h08: prest = {3'b000,PIX_DYDX.X[2:0]};
								6'h10: prest = {4'b0000,PIX_DYDX.X[1:0]};
								default: prest = 6'h01;
							endcase
							PIXBLT_PPW <= prest < pmax ? prest : pmax;
						end else begin
							PIXBLT_PPW <= pmax;
						end
						PIXBLT_X <= '0;
						PIX_POS <= '0;
					end
					
					PBLT_NEXT: begin
						{PIX_YEND,PIX_XEND} <= {ADDXY_CY,ADDXY_CX};

						PIXBLT_X <= RF_RA_Q[15:0];
						
						case (PSIZE)
							default: PIX_BL = 0;
							6'h01: PIX_BL <= 1;
							6'h02: PIX_BL <= &RF_RA_Q[4:4];
							6'h04: PIX_BL <= &RF_RA_Q[4:3];
							6'h08: PIX_BL <= &RF_RA_Q[4:2];
							6'h10: PIX_BL <= &RF_RA_Q[4:1];
							6'h20: PIX_BL <= &RF_RA_Q[4:0];
						endcase
						
						PIX_POS <= ALU_R;
					end
					
					PBLT_BMLD: PIX_BIT <= MC_DIN;
					
					PBLT_STEP: ;
					
					PBLT_DRAW: begin
						temp2 = (PIX_DYDX.X - PIX_POS.X);
						if (!(temp2 & pm)) begin
							PIXBLT_PPW <= (temp2[5:0] & ~pm[5:0]);
						end else begin
							case (PSIZE)
								6'h01: PIXBLT_PPW <= 6'h20;
								6'h02: PIXBLT_PPW <= 6'h10;
								6'h04: PIXBLT_PPW <= 6'h08;
								6'h08: PIXBLT_PPW <= 6'h04;
								6'h10: PIXBLT_PPW <= 6'h02;
								default: PIXBLT_PPW <= 6'h01;
							endcase
						end
					end
					
					default: ;
				endcase
				
				case (DECI.PF.OFFS)
					POFFS_INIT: case (DECI.PALU.CNVS)
						CNVS_DP: PIX_DOFFS <= RF_RA_Q + RF_RB_Q;
						CNVS_SP: PIX_SOFFS <= RF_RA_Q + RF_RB_Q;
						CNVS_MP: PIX_MOFFS <= RF_RA_Q + RF_RB_Q;
						default: ;
					endcase
					POFFS_NEXT: case (DECI.PALU.CNVS)
						CNVS_DP: PIX_DOFFS <= PIX_DOFFS + RF_RB_Q;
						CNVS_SP: PIX_SOFFS <= PIX_SOFFS + RF_RB_Q;
						CNVS_MP: PIX_MOFFS <= PIX_MOFFS + RF_RB_Q;
						default: ;
					endcase
					default: ;
				endcase
					
				case (DECI.PF.LINE)
					PLN_INIT: PIX_BIT <= PATTERN;
					PLN_COND: LINE_GZ <= ALU_LINE_GZ;
					PLN_STEP: PIX_BIT <= {PIX_BIT[0],PIX_BIT[31:1]};
					default: ;
				endcase
				
				case (DECI.PF.WIN)
					WIN_INIT:  PIX_DYDX <= RF_RB_Q;
						WIN_DADJ:  PIX_DYDX <= WinAdjust(RF_RB_Q, PIX_DYDX, WSTART, WEND, &IO_REGS.CONTROL.W);
					WIN_CHECK: PIX_WINCC <= XYCompareBltWin(RF_RB_Q, PIX_DYDX, WSTART, WEND);
//					WIN_CHECK: XYWinOffset();
					default: ;
				endcase
			end
		end
	end 
	
	// PATS_B (bitmap pixel write, class 52 state 18) predecode, exact factorisation
	// of PatternExpand/PatternEqual/PatternWritable (see the package helpers):
	//  PIX_BITV : per-pixel bitmap select, PatternBitView(PIX_BIT,PIXBLT_X,PSIZE).
	//             It is loaded from the D inputs of PIX_BIT/PIXBLT_X (PIXBLT_X is
	//             written by the edge that enters state 18, so the next-state values
	//             are used) and tracks them exactly.
	//  PIX_NE   : {ne1,ne0} from COLOR0/COLOR1/CONTROL.TM/T/PSIZE, which are not
	//             written by the edge entering state 18 (asserted below).
	// Both change only under CE_R. PATS_B write mask = (view&ne1)|(~view&ne0), the
	// write enable is its OR-reduction and the pixel data is (view&C1)|(~view&C0):
	// a few LUT levels from registers instead of the 32:1 select + compare chain.
	// Only the PATS_MEM source (late read word) is kept apart from the other
	// sources so the aligned word is the last-arriving input of the transparency
	// compare: the compare is applied per source before the select (exact, the
	// source select is a whole-vector mux).
	wire [31:0] PIX_WMASK_B = PatternWriteMask(PIX_NE, PIX_BITV);
	assign PIX_WE = |PIX_WMASK_B;
	bit [31:0] PIX_BIT_N;
	bit [15:0] PIXBLT_X_N;
	always_comb begin
		PIX_BIT_N = PIX_BIT;
		PIXBLT_X_N = PIXBLT_X;
		if (!RST_N) begin
			PIX_BIT_N = '0;
			PIXBLT_X_N = '0;
		end
		else if (EN && CE_R && !IW_WAIT && !MC_WAIT && !CACHE_WAIT) begin
			case (DECI.PF.BLT)
				PBLT_STRT: PIXBLT_X_N = '0;
				PBLT_NEXT: PIXBLT_X_N = RF_RA_Q[15:0];
				PBLT_BMLD: PIX_BIT_N = MC_DIN;
				default: ;
			endcase
			case (DECI.PF.LINE)
				PLN_INIT: PIX_BIT_N = PATTERN;
				PLN_STEP: PIX_BIT_N = {PIX_BIT[0],PIX_BIT[31:1]};
				default: ;
			endcase
		end
	end
	always @(posedge CLK) if (CE_R) begin
		PIX_BITV <= PatternBitView(PIX_BIT_N, PIXBLT_X_N[4:0], PSIZE);
		PIX_NE <= PatternWriteNE(COLOR0, COLOR1, IO_REGS.CONTROL.TM, IO_REGS.CONTROL.T, PSIZE);
	end

	always_comb begin
		bit  [31: 0] SRC_PAT;
		bit  [31: 0] SRC_PAT_O;
		bit  [31: 0] PAT0_O, PAT0_M;
		bit  [31: 0] PAT1;
		bit  [31: 0] TMASK_O, TMASK_M;
		bit          TGATE;

		SRC_PAT_O = '0;
		case (DECI.PIXO.PATS)
			PATS_LN:   SRC_PAT_O = PatternExpand(PIX_BIT, COLOR0, COLOR1, 5'h00,         6'h20);
			PATS_COL0: SRC_PAT_O = COLOR0;
			PATS_COL1: SRC_PAT_O = COLOR1;
			PATS_REG:  SRC_PAT_O = RF_RB_Q;
			default: ;
		endcase
		case (DECI.PIXO.PATS)
			PATS_B:    SRC_PAT = (PIX_BITV & COLOR1) | (~PIX_BITV & COLOR0);
			PATS_MEM:  SRC_PAT = MC_DIN_F;
			default:   SRC_PAT = SRC_PAT_O;
		endcase

		// PAT0 = the source, or 0 (DST_PAT) for TM=101; PAT1 = COLOR0 when TM[0]
		PAT0_O = IO_REGS.CONTROL.TM == 3'b101 ? 32'b0 : SRC_PAT_O;
		PAT0_M = IO_REGS.CONTROL.TM == 3'b101 ? 32'b0 : MC_DIN_F;
		PAT1 = COLOR0 & {32{IO_REGS.CONTROL.TM[0]}};
		TGATE = IO_REGS.CONTROL.T && !IO_REGS.CONTROL.TM[1];	// casex 4'b1x0x
		TMASK_O = TGATE ? PatternEqual(PAT0_O, PAT1, PSIZE) : 32'b0;
		TMASK_M = TGATE ? PatternEqual(PAT0_M, PAT1, PSIZE) : 32'b0;

		PIX_PAT <= SRC_PAT;
		case (DECI.PIXO.PATS)
			PATS_B:   PIX_WMASK <= PIX_WMASK_B;
			PATS_MEM: PIX_WMASK <= ~TMASK_M;
			default:  PIX_WMASK <= ~TMASK_O;
		endcase
	end

`ifndef SYNTHESIS
	// Reference (original) combinational PIX_PAT / PIX_WMASK / PIX_WE. The
	// factored logic must equal them at every clock (PATS_B: predecode check).
	bit [31:0] PIX_PAT_REF, PIX_WMASK_REF;
	bit        PIX_WE_REF;
	always_comb begin
		bit [31:0] SRC_PAT, DST_PAT, RES_PAT, PAT0, PAT1, TMASK;
		bit [31:0] bitmap, transparent_source, transparent_color;
		case (DECI.PIXO.PATS)
			PATS_B:    SRC_PAT = PatternExpand(PIX_BIT, COLOR0, COLOR1, PIXBLT_X[4:0], PSIZE);
			PATS_LN:   SRC_PAT = PatternExpand(PIX_BIT, COLOR0, COLOR1, 5'h00,         6'h20);
			PATS_COL0: SRC_PAT = COLOR0;
			PATS_COL1: SRC_PAT = COLOR1;
			PATS_REG:  SRC_PAT = RF_RB_Q;
			PATS_MEM:  SRC_PAT = MC_DIN_F;
			default:   SRC_PAT = '0;
		endcase
		DST_PAT = '0;
		RES_PAT = SRC_PAT;
		case (IO_REGS.CONTROL.TM)
			default: PAT0 = RES_PAT;
			3'b001:  PAT0 = SRC_PAT;
			3'b101:  PAT0 = DST_PAT;
		endcase
		PAT1 = COLOR0 & {32{IO_REGS.CONTROL.TM[0]}};
		casex ({IO_REGS.CONTROL.T,IO_REGS.CONTROL.TM})
			4'b1x0x: TMASK = PatternEqual(PAT0, PAT1, PSIZE);
			default: TMASK = 0;
		endcase
		PIX_PAT_REF = RES_PAT;
		PIX_WMASK_REF = ~TMASK;
		bitmap = PatternExpand(PIX_BIT, COLOR0, COLOR1, PIXBLT_X[4:0], PSIZE);
		transparent_source = IO_REGS.CONTROL.TM == 3'b101 ? 32'b0 : bitmap;
		transparent_color = COLOR0 & {32{IO_REGS.CONTROL.TM[0]}};
		casex ({IO_REGS.CONTROL.T,IO_REGS.CONTROL.TM})
			4'b1x0x: PIX_WE_REF = PatternWritable(transparent_source, transparent_color, PSIZE);
			default: PIX_WE_REF = 1'b1;
		endcase
	end
	always @(negedge CLK) if (RST_N) begin
		assert (PIX_PAT === PIX_PAT_REF) else $fatal(1,"Factored PIX_PAT differs from the original source select");
		assert (PIX_WMASK === PIX_WMASK_REF) else $fatal(1,"Factored PIX_WMASK differs from the original TMASK");
		if (IC_MATCHES[52] && STATE_OH[18])
			assert (PIX_WE === PIX_WE_REF) else $fatal(1,"Registered PIX_WE predecode differs from the combinational PatternWritable");
	end
`endif

	//IO
	assign IO_SEL = DBUS_A >= 32'hC0000000 && DBUS_A <= 32'hC0001FFF;
	TMS34020_IO #(.DISPLAY_SERVICE_PAUSE(DISPLAY_SERVICE_PAUSE)) IO
	(
		.CLK(CLK),
		.RST_N(RST_N),
		.EN(EN),
		
		.CE_F(CE_F),
		.CE_R(CE_R),
		
		.RES_N(RES_N),
		.NMI_N(NMI_N),
		.LINT1_N(LINT1_N),
		.LINT2_N(LINT2_N),
		
		.A(DBUS_A[12:0]),
		.DI(DBUS_DO),
		.DO(IO_DO),
		.DO_NEXT(IO_DO_NEXT),
		.WE(IO_SEL & DBUS_WE),
		.RD(IO_SEL & DBUS_RD),
		.BE(DBUS_BE),
		
		.REGS(IO_REGS),
		.INT1_REQ(INT1_REQ),
		.INT2_REQ(INT2_REQ),
		.HI_REQ(HI_REQ),
		.DI_REQ(DI_REQ),
		.WV_REQ(WV_REQ),
		
		.SCRREF_ADDR(SCRREF_ADDR),
		.SCRREF_RUN(SCRREF_RUN),
		.SCRREF_CE_R(MC_CE_R),
		
		.VCE_R(VCE_R),
		.HS_N(HS_N),
		.VS_N(VS_N),
		.HBL_N(HBL_N),
		.VBL_N(VBL_N)
	);
	
	
	//Memory controller
	always_comb begin
		bit  [11: 0] IO_ADDR;
		
		IO_ADDR = 12'h150;
		
		case (DECI.MC.AS)
			MAS_RA:   MC_ADDR <= RF_RA_Q;
			MAS_RB:   MC_ADDR <= RF_RB_Q;
			MAS_RAIW: MC_ADDR <= RF_RA_Q + {{16{IW[15]}},IW[15:0]};
			MAS_RBIW: MC_ADDR <= RF_RB_Q + {{16{IW[15]}},IW[15:0]};
			MAS_IO:   MC_ADDR <= {20'hC0000,IO_ADDR};
			MAS_IL:   MC_ADDR <= IW;
			MAS_VEC:  MC_ADDR <= {{22{1'b1}},~IC[4:0],5'h00};
			default:  MC_ADDR <= '1;
		endcase
		
		case (DECI.MC.DS)
			MDS_REGA: MC_DOUT <= RF_RA_Q;
			MDS_REGB: MC_DOUT <= RF_RB_Q;
			MDS_PIX:  MC_DOUT <= PIX_PAT;
			MDS_PC:   MC_DOUT <= PC;
			MDS_ST:   MC_DOUT <= ST;
			default:  MC_DOUT <= MC_DIN;
		endcase 
	end

	TMS34020_MC #(.EARLY_ADDR_SELECT(1)) MC (
		.CLK(CLK),
		.RST_N(RST_N),
		.EN(EN),
		
		.CE_F(MC_CE_F),
		.CE_R(MC_CE_R),
		.PAUSE_READY(MC_PAUSE_READY),
		
		.RES_N(RES_N),
		
		.ADDR(MC_ADDR),
		.DOUT(MC_DOUT),
		.DIN(MC_DIN),
		.DIN_F(MC_DIN_F),
		.FS(FS),
		.FS0(FS0),.FS1(FS1),.FIELD_SELECT(DECI.F),
		.READ(MC_LAUNCH_ALLOW && DECI_AT_PRE == MA_READ),
		.WRITE(MC_LAUNCH_ALLOW && DECI.MC.AT == MA_WRITE),
		.WRITE_PRE(MC_LAUNCH_ALLOW && DECI_AT_PRE == MA_WRITE),
		.PIX(DECI.MC.MT),
		.PC(PC),
		.CACHE(MC_LAUNCH_ALLOW && CACHE_MISS),
		.CACHE_ADDRESS(CACHE_MISS),
		.LAUNCH_KILL(PAUSE_FINISH_F),
		.CACHE_WR(MC_CACHE_WR),
		.VECT(DECI.MC.AS == MAS_VEC),
		.WAIT(MC_WAIT),
		.PIX_WMASK(PIX_WMASK),
		
		.SCRREF_ADDR(SCRREF_ADDR),
		.SCRREF_RUN(SCRREF_RUN),
		
		.DBUS_A(DBUS_A),
		.DBUS_ADDR_CLASS(ADDR_CLASS),
		.VRAM_REQUEST(VRAM_REQUEST),
		.DBUS_DI(MC_RETURN_WORD),
		.DBUS_DI_E(MC_RETURN_WORD_E),
		.DBUS_DO(DBUS_DO),
		.DBUS_RAS(DBUS_RAS),
		.DBUS_WE(DBUS_WE),
		.DBUS_RD(DBUS_RD),
		.DBUS_RD_EXT(DBUS_RD_EXT),
		.DBUS_BE(DBUS_BE),.DBUS_ANY_BE(DBUS_ANY_BE),.DBUS_ANY_BE_FG(DBUS_ANY_BE_FG),
		.DBUS_CODE(DBUS_CODE),
		.DBUS_RDY(DBUS_RDY),
		
		.CST(IO_REGS.DPYCTL.CST)
	);
	
	assign DBUS_DI = IO_SEL ? IO_DO : LDI;
	assign DBUS_RDY = IO_SEL | LRDY;
	
	assign LA = {DBUS_A[31:4],DBUS_CODE};
	assign BIT_ADDR = DBUS_A;
	assign LDO = DBUS_DO;
	assign RAS_N = ~DBUS_RAS;
	assign CAS_N = ~((DBUS_BE & {4{DBUS_WE}}) | {4{DBUS_RD}});
	assign WE_N = ~DBUS_WE;
	assign WRITE_ANY_ALL = DBUS_WE && DBUS_ANY_BE;
	assign WRITE_ANY_FG = DBUS_WE && DBUS_ANY_BE_FG;
	assign QE_N = ~DBUS_RD;
	assign RD_EXT = DBUS_RD_EXT;
	assign ALTCH_N = ~(DBUS_WE | DBUS_RD);
`ifndef SYNTHESIS
	// Every external read (code bit 3 set) is announced by both strobes; the
	// CE_F internal strobes carry codes 0100/0101 and never set RD_EXT.
	always @(posedge CLK) if (RST_N)
		assert ((DBUS_RD & DBUS_CODE[3]) == (DBUS_RD_EXT & DBUS_CODE[3]) && (!DBUS_RD_EXT || DBUS_RD))
			else $fatal(1,"external read strobe differs from the CE_R qualified read strobe");
`endif
	
	
		
`ifdef DEBUG
	assign DBG_PC = PC[25:3];
	assign DBG_ALU_R = ALU_R;
	assign DBG_ALU_C = ALU_C;
	assign DBG_ALU_Z = ALU_Z;
	assign DBG_ALU_N = ALU_N;
	assign DBG_ALU_V = ALU_V;
	
	assign DBG_PIX_WMASK = PIX_WMASK;
	assign DBG_PIX_PAT = PIX_PAT;
	
//	assign DBG_DBUS_A = {DBUS_A[31:4],4'h0};
	bit  [ 7: 0] OBJ_N[16];
	bit  [15: 0] OBJ_ID[16];
	bit  [31: 0] OBJ_H[16];
	bit  [31: 0] OBJ_X[16];
	bit  [31: 0] OBJ_Y[16];
	always @(posedge CLK or negedge RST_N) begin	
		if (!RST_N) begin
			DBG_SAVE_PC <= '0;
		end
		else if (EN) begin
			DBG_UNUSED <= ~((DBUS_A[31:4] <= 28'h003FFFF) || 
			                (DBUS_A[31:4] >= 28'h2000000 && DBUS_A[31:4] <= 28'h200007F) || 
			                (DBUS_A[31:4] >= 28'h4000000 && DBUS_A[31:4] <= 28'h4000001) || 
							    (DBUS_A[31:4] >= 28'h6000000 && DBUS_A[31:4] <= 28'h6003FFF) || 
							    (DBUS_A[31:4] >= 28'hA000000 && DBUS_A[31:4] <= 28'hA07FFFF) || 
							    (DBUS_A[31:4] >= 28'hA400000 && DBUS_A[31:4] <= 28'hA47FFFF) || 
							    (DBUS_A[31:4] >= 28'hA800000 && DBUS_A[31:4] <= 28'hA8FFFFF) || 
							    (DBUS_A[31:4] >= 28'hAC00000 && DBUS_A[31:4] <= 28'hAC7FFFF) || 
							    (DBUS_A[31:4] >= 28'hB000000 && DBUS_A[31:4] <= 28'hB03FFFF) || 
							    (DBUS_A[31:4] >= 28'hB400000 && DBUS_A[31:4] <= 28'hB43FFFF) || 
							    (DBUS_A[31:4] >= 28'hC000000 && DBUS_A[31:4] <= 28'hC0001FF) || 
			                (DBUS_A[31:4] >= 28'hFC00000 && DBUS_A[31:4] <= 28'hFFFFFFF));
			DBG_UNUSED_PC <= ~(PC[31:4] >= 28'hFC00000 && PC[31:4] <= 28'hFFFFFFF);
			
			if (DBUS_A >= 32'h00002000 && DBUS_A <= 32'h00005FFF && DBUS_WE && CE_R) begin
				case ({DBUS_A[9:5],5'b00000})
					10'h000: if (DBUS_BE[1:0]) OBJ_ID[DBUS_A[13:10]-4'd8] <= DBUS_DO[15:0];
					10'h020: OBJ_H[DBUS_A[13:10]-4'd8] <= DBUS_DO;
					10'h040: OBJ_X[DBUS_A[13:10]-4'd8] <= DBUS_DO;
					10'h060: OBJ_Y[DBUS_A[13:10]-4'd8] <= DBUS_DO;
					default:;
				endcase
			end
			if (DBUS_A >= 32'h0002A280 && DBUS_A <= 32'h0002A37F && DBUS_WE && CE_R) begin
				if (DBUS_BE[1:0]) OBJ_N[{~DBUS_A[7],DBUS_A[6:5],1'b0}] <= DBUS_DO[7:0];
				if (DBUS_BE[3:2]) OBJ_N[{~DBUS_A[7],DBUS_A[6:5],1'b1}] <= DBUS_DO[23:16];
			end
			if ({DBUS_A[31:5],5'b00000} == 32'h00022400 && DBUS_WE && CE_R) begin
				if (DBUS_BE[3:2]) DBG_DI_FLAG <= DBUS_DO[31:16];
			end
			if (MC_ADDR == 32'h00001EA0 && MC_DOUT == 32'h00000000 && DECI.MC.AT == MA_WRITE && CE_R) begin
				DBG_SAVE_PC <= PC;
			end
		end
	end
	assign DBG_TEMP = {OBJ_N[0],OBJ_N[1],OBJ_N[2],OBJ_N[3]}^{OBJ_N[4],OBJ_N[5],OBJ_N[6],OBJ_N[7]}^{OBJ_N[8],OBJ_N[9],OBJ_N[10],OBJ_N[11]}^{OBJ_N[12],OBJ_N[13],OBJ_N[14],OBJ_N[15]}^
	                  {OBJ_ID[0],OBJ_ID[1]}^{OBJ_ID[2],OBJ_ID[3]}^{OBJ_ID[4],OBJ_ID[5]}^{OBJ_ID[6],OBJ_ID[7]}^{OBJ_ID[8],OBJ_ID[9]}^{OBJ_ID[10],OBJ_ID[11]}^{OBJ_ID[12],OBJ_ID[13]}^{OBJ_ID[14],OBJ_ID[15]}^
							OBJ_H[0]^OBJ_H[1]^OBJ_H[2]^OBJ_H[3]^OBJ_H[4]^OBJ_H[5]^OBJ_H[6]^OBJ_H[7]^OBJ_H[8]^OBJ_H[9]^OBJ_H[10]^OBJ_H[11]^OBJ_H[12]^OBJ_H[13]^OBJ_H[14]^OBJ_H[15]^
							OBJ_X[0]^OBJ_X[1]^OBJ_X[2]^OBJ_X[3]^OBJ_X[4]^OBJ_X[5]^OBJ_X[6]^OBJ_X[7]^OBJ_X[8]^OBJ_X[9]^OBJ_X[10]^OBJ_X[11]^OBJ_X[12]^OBJ_X[13]^OBJ_X[14]^OBJ_X[15]^
							OBJ_Y[0]^OBJ_Y[1]^OBJ_Y[2]^OBJ_Y[3]^OBJ_Y[4]^OBJ_Y[5]^OBJ_Y[6]^OBJ_Y[7]^OBJ_Y[8]^OBJ_Y[9]^OBJ_Y[10]^OBJ_Y[11]^OBJ_Y[12]^OBJ_Y[13]^OBJ_Y[14]^OBJ_Y[15];
`endif
	
	`ifdef MISTER_CPU_PHASE_CHECK
	bit sampled_ce_r;
	bit sampled_mc_ce_r;
	localparam MC_R_PHASE_BITS = $bits({MC.DBUS_BE,MC.MC_WMASK_EXT});
	bit [MC_R_PHASE_BITS-1:0] previous_mc_r_phase;
	wire [MC_R_PHASE_BITS-1:0] mc_r_phase_view = {MC.DBUS_BE,MC.MC_WMASK_EXT};
	bit previous_reset_n;
	localparam R_PHASE_BITS = $bits({IC,IC_MATCHES,IC_RS_STATIC,IC_RF_ADDR,IC_RF_ADDR_POS,OPSEL,OPSEL_ALU_FSI_OH,IW,PC,STATE,STATE_OH,MD_ACC,
		RST_EXEC,WORD_MASK,LIST,MM_RN,MD_SHIFT,MD_Q,MD_STEP,MD_COND,MD_NEG,MD_DIVIDEND_NEG,DIV_V,
		DS_Z,ST,WSTART,WEND,COLOR0,COLOR1,PATTERN,RP_COND,PIX_XEND,PIX_YEND,
		PIX_BL,PIXBLT_PPW,PIXBLT_X,PIX_POS,PIX_BIT,PIX_BITV,PIX_NE,LINE_GZ,LINE_COND,
		PIX_DOFFS,PIX_SOFFS,PIX_MOFFS,PIX_DYDX,PIX_WINCC,
		RF_RA_Q,RF_RB_Q,IO_REGS.PSIZE,IO_REGS.CONTROL,
		IO_REGS.CONVSP,IO_REGS.CONVDP,IO_REGS.CONVMP,
		CACHE.SSA[0],CACHE.SSA[1],CACHE.SSA[2],CACHE.SSA[3]});
	bit [R_PHASE_BITS-1:0] previous_r_phase;
	wire [R_PHASE_BITS-1:0] r_phase_view = {IC,IC_MATCHES,IC_RS_STATIC,IC_RF_ADDR,IC_RF_ADDR_POS,OPSEL,OPSEL_ALU_FSI_OH,IW,PC,STATE,STATE_OH,MD_ACC,
		RST_EXEC,WORD_MASK,LIST,MM_RN,MD_SHIFT,MD_Q,MD_STEP,MD_COND,MD_NEG,MD_DIVIDEND_NEG,DIV_V,
		DS_Z,ST,WSTART,WEND,COLOR0,COLOR1,PATTERN,RP_COND,PIX_XEND,PIX_YEND,
		PIX_BL,PIXBLT_PPW,PIXBLT_X,PIX_POS,PIX_BIT,PIX_BITV,PIX_NE,LINE_GZ,LINE_COND,
		PIX_DOFFS,PIX_SOFFS,PIX_MOFFS,PIX_DYDX,PIX_WINCC,
		RF_RA_Q,RF_RB_Q,IO_REGS.PSIZE,IO_REGS.CONTROL,
		IO_REGS.CONVSP,IO_REGS.CONVDP,IO_REGS.CONVMP,
		CACHE.SSA[0],CACHE.SSA[1],CACHE.SSA[2],CACHE.SSA[3]};
	always @(posedge CLK) begin
		sampled_ce_r <= CE_R;
		sampled_mc_ce_r <= MC_CE_R;
	end
	// Enabled R-phase consumers read the early capture; it equals the CE_F capture.
	always @(posedge CLK) if (RST_N && EN && CE_R) assert (MC_DIN === MC_DIN_F) else $fatal(1,"early and late read words differ at CE_R");
	always @(negedge CLK) begin
		if (RST_N)
			assert (IC_MATCHES == DecodeICMatches(IC))
				else $fatal(1,"Opcode predecode changed instruction identity");
		if (RST_N) assert (IC_RF_ADDR == DecodeICRFAddress(IC,STATE,0) && IC_RF_ADDR_POS == DecodeICRFAddress(IC,STATE,1))
			else $fatal(1,"Registered RF address changed instruction/state identity");
		if (RST_N) assert (IC_RS_STATIC == DecodeICRS(IC))
			else $fatal(1,"Static source register changed instruction identity");
		if (RST_N && previous_reset_n && !sampled_ce_r)
			assert (r_phase_view == previous_r_phase)
				else $fatal(1,"TMS34020 R-phase register changed outside CE_R");
		if (RST_N && previous_reset_n && !sampled_mc_ce_r)
			assert (mc_r_phase_view == previous_mc_r_phase)
				else $fatal(1,"TMS34020 MC R-phase register changed outside MC_CE_R");
		previous_mc_r_phase <= mc_r_phase_view;
		previous_r_phase <= r_phase_view;
		previous_reset_n <= RST_N;
	end
	`endif
endmodule
