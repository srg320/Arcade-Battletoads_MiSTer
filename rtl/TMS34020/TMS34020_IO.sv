import TMS34020_PKG::*; 

module TMS34020_IO #(parameter DISPLAY_SERVICE_PAUSE = 0)
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
	
	input      [12: 0] A,
	input      [31: 0] DI,
	output     [31: 0] DO,
	output     [31: 0] DO_NEXT,   // the value DO takes at the next clock
	input              WE,
	input              RD,
	input      [ 3: 0] BE,
	
	output     IOReg_t REGS,
	output             INT1_REQ,
	output             INT2_REQ,
	output             HI_REQ,
	output             DI_REQ,
	output             WV_REQ,
	
	output reg [31: 0] SCRREF_ADDR,
	output reg         SCRREF_RUN,
	
	input              VCE_R,
	output             HS_N,
	output             VS_N,
	output             HBL_N,
	output             VBL_N
	
`ifdef DEBUG
	,
	output reg [ 8: 0] DBG_X,
	output reg [ 7: 0] DBG_Y
`endif
	, input wire SCRREF_CE_R
);

	IOReg_t     IO_REGS;
	
	bit         HSYNC;
	bit         HBL;
	bit         VSYNC;
	bit         VBL;
	bit         VINT;
	
	//IO registers
	bit [31: 0] IO_DO;
	always @(posedge CLK or negedge RST_N) begin
		bit         VINT_OLD;
		
		if (!RST_N) begin
			IO_REGS.VESYNC  <= VESYNC_INIT;
			IO_REGS.HESYNC  <= HESYNC_INIT;
			IO_REGS.VEBLNK  <= VEBLNK_INIT;
			IO_REGS.HEBLNK  <= HEBLNK_INIT;
			IO_REGS.VSBLNK  <= VSBLNK_INIT;
			IO_REGS.HSBLNK  <= HSBLNK_INIT;
			IO_REGS.VTOTAL  <= VTOTAL_INIT;
			IO_REGS.HTOTAL  <= HTOTAL_INIT;
			IO_REGS.DPYCTL  <= DPYCTL_INIT;
			IO_REGS.DPYSTRT <= DPYSTRT_INIT;
			IO_REGS.DPYINT  <= DPYINT_INIT;
			IO_REGS.CONTROL <= CONTROL_INIT;
			IO_REGS.HSTDATA <= HSTDATA_INIT;
			IO_REGS.HSTADRL <= HSTADRL_INIT;
			IO_REGS.HSTADRH <= HSTADRH_INIT;
			IO_REGS.HSTCTLL <= HSTCTLL_INIT;
			IO_REGS.HSTCTLH <= HSTCTLH_INIT;
			IO_REGS.INTENB  <= INTENB_INIT;
			IO_REGS.INTPEND <= INTPEND_INIT;
			IO_REGS.CONVSP  <= CONVSP_INIT;
			IO_REGS.CONVDP  <= CONVDP_INIT;
			IO_REGS.PSIZE   <= PSIZE_INIT;
			IO_REGS.PMASK   <= PMASK_INIT;
			IO_REGS.CONVMP  <= CONVMP_INIT;
			IO_REGS.CONFIG  <= CONFIG_INIT;
			IO_REGS.DPYTAP  <= DPYTAP_INIT;
			IO_REGS.DPYADR  <= DPYADR_INIT;
			IO_REGS.REFADR  <= REFADR_INIT;
			IO_REGS.DPYST   <= DPYST_INIT;
			IO_REGS.DINC    <= DINC_INIT;
			IO_REGS.HESERR  <= HESERR_INIT;
			IO_REGS.SCOUNT  <= SCOUNT_INIT;
			IO_REGS.BSFLTST <= BSFLTST_INIT;
			IO_REGS.DPYMSK  <= DPYMSK_INIT;
			IO_REGS.SETVCNT <= SETVCNT_INIT;
			IO_REGS.SETHCNT <= SETHCNT_INIT;
			IO_REGS.BSFLTD  <= BSFLTD_INIT;
			IO_REGS.IHOST1  <= IHOSTx_INIT;
			IO_REGS.IHOST2  <= IHOSTx_INIT;
			IO_REGS.IHOST3  <= IHOSTx_INIT;
			IO_REGS.IHOST4  <= IHOSTx_INIT;
		end
		else if (EN && CE_R) begin	
			if (WE) begin
				case ({A[12:5],5'b00000})
					13'h0000: begin
						if (BE[3]) IO_REGS.HESYNC[15: 8] <= DI[31:24];
						if (BE[2]) IO_REGS.HESYNC[ 7: 0] <= DI[23:16];
						if (BE[1]) IO_REGS.VESYNC[15: 8] <= DI[15: 8];
						if (BE[0]) IO_REGS.VESYNC[ 7: 0] <= DI[ 7: 0];
					end
					13'h0020: begin
						if (BE[3]) IO_REGS.HEBLNK[15: 8] <= DI[31:24];
						if (BE[2]) IO_REGS.HEBLNK[ 7: 0] <= DI[23:16];
						if (BE[1]) IO_REGS.VEBLNK[15: 8] <= DI[15: 8];
						if (BE[0]) IO_REGS.VEBLNK[ 7: 0] <= DI[ 7: 0];
					end
					13'h0040: begin
						if (BE[3]) IO_REGS.HSBLNK[15: 8] <= DI[31:24];
						if (BE[2]) IO_REGS.HSBLNK[ 7: 0] <= DI[23:16];
						if (BE[1]) IO_REGS.VSBLNK[15: 8] <= DI[15: 8];
						if (BE[0]) IO_REGS.VSBLNK[ 7: 0] <= DI[ 7: 0];
					end
					13'h0060: begin
						if (BE[3]) IO_REGS.HTOTAL[15: 8] <= DI[31:24];
						if (BE[2]) IO_REGS.HTOTAL[ 7: 0] <= DI[23:16];
						if (BE[1]) IO_REGS.VTOTAL[15: 8] <= DI[15: 8];
						if (BE[0]) IO_REGS.VTOTAL[ 7: 0] <= DI[ 7: 0];
					end
					13'h0080: begin
						if (BE[3]) IO_REGS.DPYSTRT[15: 8] <= DI[31:24] & 8'h00;
						if (BE[2]) IO_REGS.DPYSTRT[ 7: 0] <= DI[23:16] & 8'h00;
						if (BE[1]) IO_REGS.DPYCTL[15: 8] <= DI[15: 8];
						if (BE[0]) IO_REGS.DPYCTL[ 7: 0] <= DI[ 7: 0];
					end
					13'h00A0: begin
						if (BE[3]) IO_REGS.CONTROL[15: 8] <= DI[31:24];
						if (BE[2]) IO_REGS.CONTROL[ 7: 0] <= DI[23:16];
						if (BE[1]) IO_REGS.DPYINT[15: 8] <= DI[15: 8];
						if (BE[0]) IO_REGS.DPYINT[ 7: 0] <= DI[ 7: 0];
					end
					13'h00C0: begin
						if (BE[3]) IO_REGS.HSTADRL[15: 8] <= DI[31:24] & 8'h00;
						if (BE[2]) IO_REGS.HSTADRL[ 7: 0] <= DI[23:16] & 8'h00;
						if (BE[1]) IO_REGS.HSTDATA[15: 8] <= DI[15: 8] & 8'h00;
						if (BE[0]) IO_REGS.HSTDATA[ 7: 0] <= DI[ 7: 0] & 8'h00;
					end
					13'h00E0: begin
						if (BE[3]) IO_REGS.HSTCTLL[15: 8] <= DI[31:24] & 8'h00;
						if (BE[2]) IO_REGS.HSTCTLL[ 7: 0] <= DI[23:16] & 8'h00;
						if (BE[1]) IO_REGS.HSTADRH[15: 8] <= DI[15: 8] & 8'h00;
						if (BE[0]) IO_REGS.HSTADRH[ 7: 0] <= DI[ 7: 0] & 8'h00;
					end
					13'h0100: begin
						if (BE[3]) IO_REGS.INTENB[15: 8] <= DI[31:24];
						if (BE[2]) IO_REGS.INTENB[ 7: 0] <= DI[23:16];
						if (BE[1]) IO_REGS.HSTCTLH[15: 8] <= DI[15: 8] & 8'h00;
						if (BE[0]) IO_REGS.HSTCTLH[ 7: 0] <= DI[ 7: 0] & 8'h00;
					end
					13'h0120: begin
						if (BE[3]) IO_REGS.CONVSP[15: 8] <= DI[31:24];
						if (BE[2]) IO_REGS.CONVSP[ 7: 0] <= DI[23:16];
						if (BE[1] && !DI[9]) begin	
							IO_REGS.INTPEND.WVP <= 0;
						end
						if (BE[1] && !DI[10]) begin	
							IO_REGS.INTPEND.DIP <= 0;
						end
					end
					13'h0140: begin
						if (BE[3]) IO_REGS.PSIZE[15: 8] <= DI[31:24];
						if (BE[2]) IO_REGS.PSIZE[ 7: 0] <= DI[23:16];
						if (BE[1]) IO_REGS.CONVDP[15: 8] <= DI[15: 8];
						if (BE[0]) IO_REGS.CONVDP[ 7: 0] <= DI[ 7: 0];
					end
					13'h0160: begin
						if (BE[3]) IO_REGS.PMASK[31:24] <= DI[31:24];
						if (BE[2]) IO_REGS.PMASK[23:16] <= DI[23:16];
						if (BE[1]) IO_REGS.PMASK[15: 8] <= DI[15: 8];
						if (BE[0]) IO_REGS.PMASK[ 7: 0] <= DI[ 7: 0];
					end
					13'h0180: begin
						if (BE[3]) IO_REGS.CONTROL[15: 8] <= DI[31:24];
						if (BE[2]) IO_REGS.CONTROL[ 7: 0] <= DI[23:16];
						if (BE[1]) IO_REGS.CONVMP[15: 8] <= DI[15: 8];
						if (BE[0]) IO_REGS.CONVMP[ 7: 0] <= DI[ 7: 0];
					end
					13'h01A0: begin
						if (BE[3]) IO_REGS.DPYTAP[15: 8] <= DI[31:24] & 8'h00;
						if (BE[2]) IO_REGS.DPYTAP[ 7: 0] <= DI[23:16] & 8'h00;
						if (BE[1]) IO_REGS.CONFIG[15: 8] <= DI[15: 8];
						if (BE[0]) IO_REGS.CONFIG[ 7: 0] <= DI[ 7: 0];
					end
					13'h01C0: ;
					13'h01E0: begin
						if (BE[3]) IO_REGS.REFADR[15: 8] <= DI[31:24];
						if (BE[2]) IO_REGS.REFADR[ 7: 0] <= DI[23:16];
						if (BE[1]) IO_REGS.DPYADR[15: 8] <= DI[15: 8] & 8'h00;
						if (BE[0]) IO_REGS.DPYADR[ 7: 0] <= DI[ 7: 0] & 8'h00;
					end
					13'h0200: begin
						if (BE[3]) IO_REGS.DPYST[31:24] <= DI[31:24];
						if (BE[2]) IO_REGS.DPYST[23:16] <= DI[23:16];
						if (BE[1]) IO_REGS.DPYST[15: 8] <= DI[15: 8];
						if (BE[0]) IO_REGS.DPYST[ 7: 0] <= DI[ 7: 0];
					end
					13'h0220: ;
					13'h0240: begin
						if (BE[3]) IO_REGS.DINC[31:24] <= DI[31:24];
						if (BE[2]) IO_REGS.DINC[23:16] <= DI[23:16];
						if (BE[1]) IO_REGS.DINC[15: 8] <= DI[15: 8];
						if (BE[0]) IO_REGS.DINC[ 7: 0] <= DI[ 7: 0];
					end
					13'h0260: begin
						if (BE[3]) IO_REGS.HESERR[15: 8] <= DI[31:24];
						if (BE[2]) IO_REGS.HESERR[ 7: 0] <= DI[23:16];
					end
					13'h0280: ;
					13'h02A0: ;
					13'h02C0: begin
						if (BE[3]) IO_REGS.BSFLTST[15: 8] <= DI[31:24] & 8'h00;
						if (BE[2]) IO_REGS.BSFLTST[ 7: 0] <= DI[23:16] & 8'h00;
						if (BE[1]) IO_REGS.SCOUNT[15: 8] <= DI[15: 8];
						if (BE[0]) IO_REGS.SCOUNT[ 7: 0] <= DI[ 7: 0];
					end
					13'h02E0: begin
						if (BE[1]) IO_REGS.DPYMSK[15: 8] <= DI[15: 8];
						if (BE[0]) IO_REGS.DPYMSK[ 7: 0] <= DI[ 7: 0];
					end
					13'h0300: begin
						if (BE[3]) IO_REGS.SETHCNT[15: 8] <= DI[31:24] & 8'h00;
						if (BE[2]) IO_REGS.SETHCNT[ 7: 0] <= DI[23:16] & 8'h00;
						if (BE[1]) IO_REGS.SETVCNT[15: 8] <= DI[15: 8] & 8'h00;
						if (BE[0]) IO_REGS.SETVCNT[ 7: 0] <= DI[ 7: 0] & 8'h00;
					end
					13'h0320: begin
						if (BE[3]) IO_REGS.BSFLTD[31:24] <= DI[31:24] & 8'h00;
						if (BE[2]) IO_REGS.BSFLTD[23:16] <= DI[23:16] & 8'h00;
						if (BE[1]) IO_REGS.BSFLTD[15: 8] <= DI[15: 8] & 8'h00;
						if (BE[0]) IO_REGS.BSFLTD[ 7: 0] <= DI[ 7: 0] & 8'h00;
					end
					13'h0340: ;
					13'h0360: ;
					13'h0380: begin
						if (BE[3]) IO_REGS.IHOST1[31:24] <= DI[31:24] & 8'h00;
						if (BE[2]) IO_REGS.IHOST1[23:16] <= DI[23:16] & 8'h00;
						if (BE[1]) IO_REGS.IHOST1[15: 8] <= DI[15: 8] & 8'h00;
						if (BE[0]) IO_REGS.IHOST1[ 7: 0] <= DI[ 7: 0] & 8'h00;
					end
					13'h03A0: begin
						if (BE[3]) IO_REGS.IHOST2[31:24] <= DI[31:24] & 8'h00;
						if (BE[2]) IO_REGS.IHOST2[23:16] <= DI[23:16] & 8'h00;
						if (BE[1]) IO_REGS.IHOST2[15: 8] <= DI[15: 8] & 8'h00;
						if (BE[0]) IO_REGS.IHOST2[ 7: 0] <= DI[ 7: 0] & 8'h00;
					end
					13'h03C0: begin
						if (BE[3]) IO_REGS.IHOST3[31:24] <= DI[31:24] & 8'h00;
						if (BE[2]) IO_REGS.IHOST3[23:16] <= DI[23:16] & 8'h00;
						if (BE[1]) IO_REGS.IHOST3[15: 8] <= DI[15: 8] & 8'h00;
						if (BE[0]) IO_REGS.IHOST3[ 7: 0] <= DI[ 7: 0] & 8'h00;
					end
					13'h03E0: begin
						if (BE[3]) IO_REGS.IHOST4[31:24] <= DI[31:24] & 8'h00;
						if (BE[2]) IO_REGS.IHOST4[23:16] <= DI[23:16] & 8'h00;
						if (BE[1]) IO_REGS.IHOST4[15: 8] <= DI[15: 8] & 8'h00;
						if (BE[0]) IO_REGS.IHOST4[ 7: 0] <= DI[ 7: 0] & 8'h00;
					end
					default: ;
				endcase
			end
			
			IO_REGS.INTPEND.X1P <= ~LINT1_N;
			IO_REGS.INTPEND.X2P <= ~LINT2_N;
			
			VINT_OLD <= VINT;
			if (VINT && !VINT_OLD) begin	
				IO_REGS.INTPEND.DIP <= 1;
			end
			
		end
	end
	
	// Read mux as a function of the current registers, so the memory
	// controller's early capture can see next clock's DO one clock early.
	bit [31:0] IO_DO_NEXT;
	always_comb begin
		IO_DO_NEXT = IO_DO;
		case ({A[12:5],5'h00})
		13'h0000: IO_DO_NEXT = {IO_REGS.HESYNC ,IO_REGS.VESYNC };
		13'h0020: IO_DO_NEXT = {IO_REGS.HEBLNK ,IO_REGS.VEBLNK };
		13'h0040: IO_DO_NEXT = {IO_REGS.HSBLNK ,IO_REGS.VSBLNK };
		13'h0060: IO_DO_NEXT = {IO_REGS.HTOTAL ,IO_REGS.VTOTAL };
		13'h0080: IO_DO_NEXT = {IO_REGS.DPYSTRT,IO_REGS.DPYCTL };
		13'h00A0: IO_DO_NEXT = {IO_REGS.CONTROL,IO_REGS.DPYINT };
		13'h00C0: IO_DO_NEXT = {IO_REGS.HSTADRL,IO_REGS.HSTDATA};
		13'h00E0: IO_DO_NEXT = {IO_REGS.HSTCTLL,IO_REGS.HSTADRH};
		13'h0100: IO_DO_NEXT = {IO_REGS.INTENB ,IO_REGS.HSTCTLH};
		13'h0120: IO_DO_NEXT = {IO_REGS.CONVSP ,IO_REGS.INTPEND};
		13'h0140: IO_DO_NEXT = {IO_REGS.PSIZE  ,IO_REGS.CONVDP };
		13'h0160: IO_DO_NEXT = {IO_REGS.PMASK                  };
		13'h0180: IO_DO_NEXT = {IO_REGS.CONTROL,IO_REGS.CONVMP };
		13'h01A0: IO_DO_NEXT = {IO_REGS.DPYTAP ,IO_REGS.CONFIG };
		13'h01C0: IO_DO_NEXT = {IO_REGS.HCOUNT ,IO_REGS.VCOUNT };
		13'h01E0: IO_DO_NEXT = {IO_REGS.REFADR ,IO_REGS.DPYADR };
		13'h0200: IO_DO_NEXT = {IO_REGS.DPYST                  };
		13'h0220: IO_DO_NEXT = {IO_REGS.DPYNX                  };
		13'h0240: IO_DO_NEXT = {IO_REGS.DINC                   };
		13'h0260: IO_DO_NEXT = {IO_REGS.HESERR                 };
		13'h0280: IO_DO_NEXT = '0;
		13'h02A0: IO_DO_NEXT = '0;
		13'h02C0: IO_DO_NEXT = {IO_REGS.BSFLTST,IO_REGS.SCOUNT };
		13'h02E0: IO_DO_NEXT = {16'h0000       ,IO_REGS.DPYMSK };
		13'h0300: IO_DO_NEXT = {IO_REGS.SETHCNT,IO_REGS.SETVCNT};
		13'h0320: IO_DO_NEXT = {IO_REGS.BSFLTD                 };
		13'h0340: IO_DO_NEXT = '0;
		13'h0360: IO_DO_NEXT = '0;
		13'h0380: IO_DO_NEXT = {IO_REGS.IHOST1                 };
		13'h03A0: IO_DO_NEXT = {IO_REGS.IHOST2                 };
		13'h03C0: IO_DO_NEXT = {IO_REGS.IHOST3                 };
		13'h03E0: IO_DO_NEXT = {IO_REGS.IHOST4                 };
		default:  IO_DO_NEXT = '0;
		endcase
	end
	assign DO_NEXT = IO_DO_NEXT;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) IO_DO <= '0;
		else if (EN) IO_DO <= IO_DO_NEXT;
	end
	
	assign DO = IO_DO;
	
	assign REGS = IO_REGS;
	
	//Interrupts
	assign INT1_REQ = (IO_REGS.INTPEND.X1P & IO_REGS.INTENB.X1E);
	assign INT2_REQ = (IO_REGS.INTPEND.X2P & IO_REGS.INTENB.X2E);
	assign HI_REQ   = (IO_REGS.INTPEND.HIP & IO_REGS.INTENB.HIE);
	assign DI_REQ   = (IO_REGS.INTPEND.DIP & IO_REGS.INTENB.DIE);
	assign WV_REQ   = (IO_REGS.INTPEND.WVP & IO_REGS.INTENB.WVE);

	// The transfer at HSBLNK preloads the *next* raster line. MAME advances
	// DPYNX after the current visible line and reloads it at VSBLNK.
	wire DISPLAY_LINE = IO_REGS.VCOUNT >= IO_REGS.VEBLNK && IO_REGS.VCOUNT < IO_REGS.VSBLNK;
	// The raster starts when the game first sets DPYCTL.ENV and then keeps running
	// (MAME's scanline timer does the same), so clearing ENV blanks the picture but
	// never removes sync; a total lowered below the live count wraps the counter
	// instead of running it to 65535. Start phase is identical to ENV-gated counting.
	bit RASTER_ON;
	wire RASTER_RUN = RASTER_ON | IO_REGS.DPYCTL.ENV;
	wire [15:0] NEXT_VCOUNT = IO_REGS.VCOUNT >= IO_REGS.VTOTAL ? 16'd0 : IO_REGS.VCOUNT + 16'd1;
	wire NEXT_DISPLAY_LINE = NEXT_VCOUNT >= IO_REGS.VEBLNK && NEXT_VCOUNT < IO_REGS.VSBLNK;
	DPYNX_t DISPLAY_AFTER_LINE;
	always_comb begin
		DISPLAY_AFTER_LINE = IO_REGS.DPYNX;
		if (IO_REGS.VCOUNT == IO_REGS.VSBLNK)
			DISPLAY_AFTER_LINE = {IO_REGS.DPYST.SRST,5'b0};
		else if (DISPLAY_LINE) begin
			DISPLAY_AFTER_LINE.YZCNT = IO_REGS.DPYNX.YZCNT + IO_REGS.DINC.YZINC;
			if (DISPLAY_AFTER_LINE.YZCNT == 0)
				DISPLAY_AFTER_LINE.SRNX = IO_REGS.DPYNX.SRNX + IO_REGS.DINC.SRINC;
		end
	end

	//Video controller
	always @(posedge CLK or negedge RST_N) begin				
		if (!RST_N) begin
			IO_REGS.VCOUNT  <= VCOUNT_INIT;
			IO_REGS.HCOUNT  <= HCOUNT_INIT;
			IO_REGS.DPYNX   <= DPYNX_INIT;
			HSYNC <= 0;
			VSYNC <= 0;
			HBL <= 0;
			VBL <= 0;
			SCRREF_ADDR <= '0;
			SCRREF_RUN <= 0;
			RASTER_ON <= 0;
		end
		else if (EN) begin	
			if (IO_REGS.DPYCTL.ENV) RASTER_ON <= 1;
			if (DISPLAY_SERVICE_PAUSE ? SCRREF_CE_R : CE_R) begin
				SCRREF_RUN <= 0;
			end
			
			if (VCE_R) begin	
				VINT <= 0;
				
				if (RASTER_RUN) begin
					IO_REGS.HCOUNT <= IO_REGS.HCOUNT + 16'd1;
`ifdef DEBUG
					DBG_X <= DBG_X + 1'd1;
`endif
					if (IO_REGS.HCOUNT >= IO_REGS.HTOTAL) begin
						IO_REGS.HCOUNT <= 16'd0;
						HSYNC <= 1;
					end else if (IO_REGS.HCOUNT == IO_REGS.HESYNC) begin
						HSYNC <= 0;
					end
					
					if (IO_REGS.HCOUNT == IO_REGS.HSBLNK) begin
						HBL <= 1;
					end else if (IO_REGS.HCOUNT == IO_REGS.HEBLNK) begin
						HBL <= 0;
`ifdef DEBUG
						DBG_X <= '0;
`endif
					end
					
					if (IO_REGS.HCOUNT >= IO_REGS.HTOTAL) begin
						IO_REGS.VCOUNT <= IO_REGS.VCOUNT + 16'd1;
`ifdef DEBUG
						DBG_Y <= DBG_Y + 1'd1;
`endif
						if (IO_REGS.VCOUNT >= IO_REGS.VTOTAL) begin
							IO_REGS.VCOUNT <= 16'd0;
							VSYNC <= 1;
						end else if (IO_REGS.VCOUNT == IO_REGS.VESYNC/2) begin
							VSYNC <= 0;
						end
						
						if (NEXT_VCOUNT == IO_REGS.VSBLNK) begin
							VBL <= 1;
						end else if (NEXT_VCOUNT == IO_REGS.VEBLNK) begin
							VBL <= 0;
`ifdef DEBUG
							DBG_Y <= '0;
`endif
						end
					end
									
					if (IO_REGS.HCOUNT == IO_REGS.HSBLNK && IO_REGS.DPYCTL.ENV) begin
						IO_REGS.DPYNX <= DISPLAY_AFTER_LINE;
						if (NEXT_DISPLAY_LINE) begin
							SCRREF_ADDR <= DISPLAY_AFTER_LINE;
							SCRREF_RUN <= 1;
						end
						
						if (IO_REGS.VCOUNT == IO_REGS.DPYINT) begin
							VINT <= 1;
						end
					end
				end else begin
					// Video has never been enabled: no raster.
					HSYNC <= 0;
					VSYNC <= 0;
					HBL <= 1;
					VBL <= 1;
				end
			end
			// DPYNX is R/W on the 34020. Keep the write in this register's sole
			// owner; a CPU write takes precedence over the automatic line step.
			if (CE_R && WE && {A[12:5],5'b0} == 13'h0220) begin
				if (BE[3]) IO_REGS.DPYNX[31:24] <= DI[31:24];
				if (BE[2]) IO_REGS.DPYNX[23:16] <= DI[23:16];
				if (BE[1]) IO_REGS.DPYNX[15:8] <= DI[15:8];
				if (BE[0]) IO_REGS.DPYNX[7:0] <= DI[7:0];
			end
		end
	end
	
	assign HS_N = ~HSYNC;
	assign VS_N = ~VSYNC;
	assign HBL_N = ~HBL;
	assign VBL_N = ~VBL;
	
endmodule
