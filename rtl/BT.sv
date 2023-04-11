module BT
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
	output     [31: 0] EDATA,
	output     [ 3: 0] EWE,
	output             ERD,
	input      [31: 0] EQ,
	output             ERAM,
	output             EROM,
	output             ENVRAM,
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
);

	bit [31: 0] LA;
	bit [31: 0] LDI;
	bit [31: 0] LDO;
	bit         RAS_N;
	bit [ 3: 0] CAS_N;
	bit         WE_N;
	bit         QE_N;
	bit         LRDY;
	
	TMS34020 CPU (
		.CLK(CLK),
		.RST_N(RST_N),
		.EN(EN),
		
		.CE_F(CE_F),
		.CE_R(CE_R),
	
		.RES_N(1),
		.NMI_N(1),
		.LINT1_N(1),
		.LINT2_N(1),
		
		.LA(LA),
		.LDI(LDI),
		.LDO(LDO),
		.RAS_N(RAS_N),
		.CAS_N(CAS_N),
		.WE_N(WE_N),
		.QE_N(QE_N),
		.ALTCH_N(),
		.LRDY(LRDY),
		
		.VCE_R(VCE_R),
		.HS_N(HS_N),
		.VS_N(VS_N),
		.HBL_N(HBL_N),
		.VBL_N(VBL_N)
	);
			  
	bit          VCE_DIV;
	always @(posedge CLK or negedge RST_N) begin		
		if (!RST_N) begin
			VCE_DIV <= 0;
		end else begin
			if (VCE_R) begin
				VCE_DIV <= ~VCE_DIV;
			end
		end
	end
	wire SC = VCE_DIV && VCE_R && HBL_N && VBL_N;
	
	wire BG0_SEL = LA[31:22] == {8'hB0,2'b00};
	wire [15: 0] BG0_A = LA[3:0] == 4'b0100 ? {LA[21:14]+SCROLL0[15:8],LA[11:5]+SCROLL0[7:1],1'b0} : {LA[21:14],LA[11:5],1'b0};
	bit  [15: 0] BG0_Q_0;
	bit  [15: 0] BG0_Q_1;
	bit  [15: 0] BG0_SQ;
	bit          BG0_GRID;
	BG_VRAM BG0_VRAM_0 (
		.CLK(CLK2X),
		.RST_N(RST_N),
		
		.A(BG0_A),
		.D({LDO[23:16],LDO[7:0]}),
		.Q(BG0_Q_0),
		.RAS_N(RAS_N | ~(BG0_SEL || LA[3:0] == 4'b0100)),
		.CAS_N({CAS_N[2],CAS_N[0]}),
		.WE_N(WE_N | ~CE_R),
		.OE_N(QE_N),
		
		.SC(SC),
		.SE_N(0),
		.SQ(BG0_SQ[7:0]),
		
		.RDY(),
		
		.GRID(BG0_GRID)
	);
	
	BG_VRAM BG0_VRAM_1 (
		.CLK(CLK2X),
		.RST_N(RST_N),
		
		.A(BG0_A),
		.D({LDO[31:24],LDO[15:8]}),
		.Q(BG0_Q_1),
		.RAS_N(RAS_N | ~(BG0_SEL || LA[3:0] == 4'b0100)),
		.CAS_N({CAS_N[3],CAS_N[1]}),
		.WE_N(WE_N | ~CE_R),
		.OE_N(QE_N),
		
		.SC(SC),
		.SE_N(0),
		.SQ(BG0_SQ[15:8]),
		
		.RDY()
	);
	
	wire BG1_SEL = LA[31:22] == {8'hB4,2'b00};
	wire [15: 0] BG1_A = LA[3:0] == 4'b0100 ? {LA[21:14]+SCROLL1[15:8],LA[11:5]+SCROLL1[7:1],1'b0} : {LA[21:14],LA[11:5],1'b0};
	bit  [15: 0] BG1_Q_0;
	bit  [15: 0] BG1_Q_1;
	bit  [15: 0] BG1_SQ;
	bit          BG1_GRID;
	BG_VRAM BG1_VRAM_0 (
		.CLK(CLK2X),
		.RST_N(RST_N),
		
		.A(BG1_A),
		.D({LDO[23:16],LDO[7:0]}),
		.Q(BG1_Q_0),
		.RAS_N(RAS_N | ~(BG1_SEL || LA[3:0] == 4'b0100)),
		.CAS_N({CAS_N[2],CAS_N[0]}),
		.WE_N(WE_N | ~CE_R),
		.OE_N(QE_N),
		
		.SC(SC),
		.SE_N(0),
		.SQ(BG1_SQ[7:0]),
		
		.RDY(),
		
		.GRID(BG1_GRID)
	);
	
	BG_VRAM BG1_VRAM_1 (
		.CLK(CLK2X),
		.RST_N(RST_N),
		
		.A(BG1_A),
		.D({LDO[31:24],LDO[15:8]}),
		.Q(BG1_Q_1),
		.RAS_N(RAS_N | ~(BG1_SEL || LA[3:0] == 4'b0100)),
		.CAS_N({CAS_N[3],CAS_N[1]}),
		.WE_N(WE_N | ~CE_R),
		.OE_N(QE_N),
		
		.SC(SC),
		.SE_N(0),
		.SQ(BG1_SQ[15:8]),
		
		.RDY()
	);
	
	
	bit         SPR_EXEC, FG_EXEC;
	bit [ 8: 0] SPR_CNT_INT, SPR_CNT_INT_PREV;
	bit [ 7: 0] SPR_CNT_FRAC;
	bit [ 8: 0] FG_CNT_INT, FG_CNT_INT_PREV;
	bit [ 7: 0] FG_CNT_FRAC;
	bit [15: 0] SPR_PAT_DATA;
	bit [ 1: 0] SPR_PAT_POS;
	bit [ 3: 0] SPR_COLOR;
	always @(posedge CLK or negedge RST_N) begin
		bit         RAS_N_OLD;
		bit         SPR_PEND;
		bit         SPR_START;
		bit [16: 0] SPR_CNT_NEXT;
		bit [16: 0] FG_CNT_NEXT;
		
		if (!RST_N) begin
			SPR_EXEC <= 0;
			FG_EXEC <= 0;
			{SPR_CNT_INT,SPR_CNT_FRAC} <= '0;
			{FG_CNT_INT,FG_CNT_FRAC} <= '0;
			SPR_START <= 0;
		end else begin
			SPR_CNT_NEXT = {SPR_CNT_INT,SPR_CNT_FRAC} + (17'h00100 - SPR_SCALE0);
			FG_CNT_NEXT = {FG_CNT_INT,FG_CNT_FRAC} + (17'h00100 - SPR_SCALE1);
					
			if (CE_R) begin
				if (SPR_EXEC) begin
					SPR_CNT_INT_PREV <= SPR_CNT_INT;
					{SPR_CNT_INT,SPR_CNT_FRAC} <= SPR_CNT_NEXT;
					
					if (SPR_CNT_INT == {~SPR_CONTROL[8:1],1'b1} && SPR_CNT_NEXT[7:0] <= SPR_CNT_FRAC) begin
						SPR_EXEC <= 0;
					end
					
					case (SPR_CNT_INT[1:0] ^ {2{SPR_CONTROL[10]}})
						2'b00: SPR_COLOR <= SPR_SQ[ 3: 0];
						2'b01: SPR_COLOR <= SPR_SQ[ 7: 4];
						2'b10: SPR_COLOR <= SPR_SQ[11: 8];
						2'b11: SPR_COLOR <= SPR_SQ[15:12];
					endcase
					
					FG_EXEC <= 1;
				end else begin
					SPR_EXEC <= SPR_START;
					FG_EXEC <= 0;
					SPR_START <= 0;
				end
				
				if (FG_EXEC) begin
					FG_CNT_INT_PREV <= FG_CNT_INT;
					{FG_CNT_INT,FG_CNT_FRAC} <= FG_CNT_NEXT;
				end
			end else if (CE_F) begin
				
			end
			
//			if (CE_R) begin
				RAS_N_OLD <= RAS_N;
				if (LA[31:24] == 8'hAC && !RAS_N && RAS_N_OLD && !QE_N && !WE_N) begin
					SPR_PEND <= 1;
				end else if (SPR_PEND && RAS_N && !RAS_N_OLD) begin
					SPR_START <= 1;
					SPR_PEND <= 0;
					{SPR_CNT_INT,SPR_CNT_FRAC} <= '0;
					SPR_CNT_INT_PREV <= '1;
					{FG_CNT_INT,FG_CNT_FRAC} <= '0;
					FG_CNT_INT_PREV <= '1;
				end
//			end
		end
	end
	wire SPR_SC = SPR_EXEC && (SPR_CNT_INT_PREV != SPR_CNT_INT) && (SPR_CNT_INT[1:0] == 2'b00) && CE_F;
	wire FG_SC = FG_EXEC && (FG_CNT_INT_PREV != FG_CNT_INT) && CE_F;
	
	
	wire SPR_SEL = LA[31:23] == {8'hA8,1'b0};
	bit  [31: 0] SPR_Q;
	bit  [15: 0] SPR_SQ;
	bit          SPR_RDY;
	SPR_VRAM SPR_VRAM (
		.CLK(CLK2X),
		.RST_N(RST_N),
		
		.A({LA[22:14],LA[13:5]}),
		.D(LDO),
		.Q(SPR_Q),
		.RAS_N(RAS_N | ~SPR_SEL),
		.CAS_N(CAS_N),
		.WE_N(WE_N),
		.OE_N(QE_N),
		
		.SC(SPR_SC),
		.SE_N(0),
		.SQ(SPR_SQ),
		
		.RDY(SPR_RDY),
		
		.ESADDR(ESADDR),
		.ESDATA(ESDATA),
		.ESWR(ESWR),
		.ESRD(ESRD),
		.ESQ(ESQ),
		.ESTE(ESTE)
	);
	
	bit  [ 8: 0] FG_POS;
	always @(posedge CLK2X or negedge RST_N) begin
		bit        RAS_N_OLD;
		bit        FG_SC_OLD;
		
		if (!RST_N) begin
			FG_POS <= 0;
		end else begin
			RAS_N_OLD <= RAS_N;
			if (LA[31:22] == {8'hAC,2'b00} && !RAS_N && RAS_N_OLD) begin
				FG_POS <= LA[13:5];
			end
			
			FG_SC_OLD <= FG_SC;
			if (FG_SC && !FG_SC_OLD) begin
				FG_POS <= FG_POS + 9'd1;
			end
		end
	end
	wire FG_SE = |SPR_COLOR & ~FG_POS[8];
	wire [7:0] FG_SD = {~SPR_CONTROL[15:12],SPR_COLOR & ~{4{MISC_CONTROL[4]}}};
	
	wire FG_DISP_SEL = LA[31:22] == {8'hA0,2'b00};
	wire FG_DISP_SC = SC;
	wire FG_DISP_SE_N = 1'b0;
	
	wire FG_DRAW_SEL = LA[31:22] == {8'hA4,2'b00} || LA[31:22] == {8'hAC,2'b00};
	wire FG_DRAW_SC = FG_SC;
	wire FG_DRAW_SE_N = FG_DRAW_SEL && !RAS_N ? LA[27] : FG_EXEC ? ~FG_SE : 1'b0;
	
	wire FG0_SEL = DISP_CONTROL[15] ? FG_DISP_SEL : FG_DRAW_SEL;
	wire FG0_SCRN = DISP_CONTROL[15] ? (LA[3:0] == 4'b0100) : 1'b0;
	wire FG0_SC = DISP_CONTROL[15] ? FG_DISP_SC : FG_DRAW_SC;
	wire FG0_SE_N = DISP_CONTROL[15] ? FG_DISP_SE_N : FG_DRAW_SE_N;
	bit  [15: 0] FG0_Q;
	bit          FG0_RDY;
	bit  [ 7: 0] FG0_SQ;
	FG_VRAM FG0_VRAM (
		.CLK(CLK2X),
		.RST_N(RST_N),
		
		.A({LA[21:14],LA[12:5]}),
		.D({LDO[23:16],LDO[7:0]}),
		.Q(FG0_Q),
		.RAS_N(RAS_N | ~(FG0_SEL | FG0_SCRN)),
		.CAS_N({CAS_N[2],CAS_N[0]}),
		.WE_N(WE_N),
		.OE_N(QE_N),
		
		.SC(FG0_SC),
		.SE_N(FG0_SE_N),
		.SD(FG_SD),
		.SQ(FG0_SQ),
		
		.RDY(FG0_RDY)
	);
	
	wire FG1_SEL = DISP_CONTROL[15] ? FG_DRAW_SEL : FG_DISP_SEL;
	wire FG1_SCRN = DISP_CONTROL[15] ? 1'b0 : (LA[3:0] == 4'b0100);
	wire FG1_SC = DISP_CONTROL[15] ? FG_DRAW_SC : FG_DISP_SC;
	wire FG1_SE_N = DISP_CONTROL[15] ? FG_DRAW_SE_N : FG_DISP_SE_N;
	bit  [15:0] FG1_Q;
	bit         FG1_RDY;
	bit  [ 7:0] FG1_SQ;
	FG_VRAM FG1_VRAM(
		.CLK(CLK2X),
		.RST_N(RST_N),
		
		.A({LA[21:14],LA[12:5]}),
		.D({LDO[23:16],LDO[7:0]}),
		.Q(FG1_Q),
		.RAS_N(RAS_N | ~(FG1_SEL | FG1_SCRN)),
		.CAS_N({CAS_N[2],CAS_N[0]}),
		.WE_N(WE_N),
		.OE_N(QE_N),
		
		.SC(FG1_SC),
		.SE_N(FG1_SE_N),
		.SD(FG_SD),
		.SQ(FG1_SQ),
		
		.RDY(FG1_RDY)
	);	
	
	
	bit [ 7:0] PIX_OUT;
	always @(posedge CLK or negedge RST_N) begin
		bit [7:0] FG0_PIX;
		bit [7:0] BG0_PIX;
		bit [7:0] BG1_PIX;
		bit [7:0] SPR_PIX;
		
		if (!RST_N) begin
			PIX_OUT <= '0;
		end else begin
			SPR_PIX = DISP_CONTROL[15] ? FG0_SQ : FG1_SQ;
			case (VCE_DIV)
				1'b0: BG0_PIX = BG0_SQ[ 7: 0];
				1'b1: BG0_PIX = BG0_SQ[15: 8];
			endcase
			case (VCE_DIV)
				1'b0: BG1_PIX = BG1_SQ[ 7: 0];
				1'b1: BG1_PIX = BG1_SQ[15: 8];
			endcase;
		
			case (DISP_CONTROL[9:8])
				2'b00: begin
					if (SPR_PIX && !SPR_PIX[7] && BG_EN[2]) 
						PIX_OUT <= SPR_PIX;
					else if (BG1_PIX[7] && BG_EN[1]) 
						PIX_OUT <= BG1_PIX;
					else if (SPR_PIX && BG_EN[2]) 
						PIX_OUT <= SPR_PIX;
					else if (BG1_PIX && BG_EN[1]) 
						PIX_OUT <= BG1_PIX;
					else if (BG_EN[0]) 
						PIX_OUT <= BG0_PIX;
					else
						PIX_OUT <= '0;
				end
				2'b01: begin
					if (SPR_PIX && !SPR_PIX[7] && BG_EN[2]) 
						PIX_OUT <= SPR_PIX;
					else if (BG0_PIX && BG_EN[0]) 
						PIX_OUT <= BG0_PIX;
					else if (BG1_PIX[7] && BG_EN[1]) 
						PIX_OUT <= BG1_PIX;
					else if (SPR_PIX && BG_EN[2]) 
						PIX_OUT <= SPR_PIX;
					else if (BG_EN[1]) 
						PIX_OUT <= BG1_PIX;
					else
						PIX_OUT <= '0;
				end
				2'b10: begin
					if (SPR_PIX && BG_EN[2]) 
						PIX_OUT <= SPR_PIX;
					else if (BG1_PIX && BG_EN[1]) 
						PIX_OUT <= BG1_PIX;
					else if (BG_EN[0]) 
						PIX_OUT <= BG0_PIX;
					else
						PIX_OUT <= '0;
				end
				2'b11: begin
					if (BG1_PIX[7] && BG_EN[1]) 
						PIX_OUT <= BG1_PIX;
					else if (SPR_PIX[7] && BG_EN[2]) 
						PIX_OUT <= SPR_PIX;
					else if (BG1_PIX && BG_EN[1]) 
						PIX_OUT <= BG1_PIX;
					else if (SPR_PIX && BG_EN[2]) 
						PIX_OUT <= SPR_PIX;
					else if (BG_EN[0]) 
						PIX_OUT <= BG0_PIX;
					else
						PIX_OUT <= '0;
				end
			endcase
		end
	end
	
	//Misc/sound control
	wire MISC_SEL = (LA[31:4] >= 28'h2000000 && LA[31:4] <= 28'h200007F);
	bit [15: 0] SPR_SCALE0,SPR_SCALE1;
	bit [15: 0] SPR_CONTROL;
	bit [15: 0] DISP_CONTROL;
	bit [15: 0] SCROLL0,SCROLL1;
	bit [ 7: 0] PAL_WADDR;
	bit [23: 0] PAL_WDATA;
	bit [15: 0] MISC_CONTROL;
	bit         Z80_CTRL_DATA_WRITE;
	bit         Z80_RESP_DATA_READ;
	
	bit [ 7: 0] PAL_RAM_A;
	bit         PAL_RAM_WE;
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
			PAL_WDATA <= '0;
			MISC_CONTROL <= '0;
			PAL_RAM_WE <= 0;
		end
		else if (CE_R) begin
			PAL_RAM_WE <= 0;
			Z80_CTRL_DATA_WRITE <= 0;
			Z80_RESP_DATA_READ <= 0;
			
			if (MISC_SEL && !WE_N) begin
				case ({LA[11:5],5'b00000})
					12'h000: SPR_SCALE0 <= LDO[15:0];
					12'h080: SPR_SCALE1 <= LDO[15:0];
					12'h100: SPR_CONTROL <= LDO[15:0];
					12'h180: DISP_CONTROL <= LDO[15:0];
					12'h200: SCROLL0 <= LDO[15:0];
					12'h280: SCROLL1 <= LDO[15:0];
					12'h300: begin //tlc34076 reg0
						PAL_WADDR <= LDO[7:0]; 
						PAL_BYTE_CNT <= 2'd0;
					end
					12'h320: begin	//tlc34076 reg1
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
					12'h380: begin Z80_CTRL_DATA <= LDO[7:0]; Z80_CTRL_DATA_WRITE <= 1; end
					12'h400: MISC_CONTROL <= LDO[15:0];
					default: ;
				endcase
			end
			if (MISC_SEL && !QE_N) begin
				case ({LA[11:5],5'b00000})
					12'h380: Z80_RESP_DATA_READ <= 1;
					default: ;
				endcase
			end
		end
	end

	wire [18:0] PAL_Q;
	wire [18:0] IO_PAL_Q;
	dpram #(8,18) pal_ram
	(
		.clock(CLK),
		.address_a(PAL_RAM_A),
		.data_a({PAL_WDATA[21:16],PAL_WDATA[13:8],PAL_WDATA[5:0]}),
		.wren_a(PAL_RAM_WE & CE_R),
		.q_a(IO_PAL_Q),

		.address_b(PIX_OUT),
		.data_b('0),
		.wren_b(0),
		.q_b(PAL_Q)
	);

	bit [ 7: 0] MISC_DO;
	always_comb begin
		case ({LA[11:5],5'b00000})
			12'h000: MISC_DO = P1;
			12'h080: MISC_DO = P2;
			12'h100: MISC_DO = P3;
			12'h180: MISC_DO = 8'hFF;
			12'h200: MISC_DO = {Z80_CTRL_RDY,5'b00000,SERVICE,Z80_RESP_RDY};
			12'h280: MISC_DO = SW1;
			12'h380: MISC_DO = Z80_RESP_DATA; 
			default: MISC_DO = 8'hFF;
		endcase
	end

	
	assign LDI = MISC_SEL  ? {24'h000000,MISC_DO} :
					 SPR_SEL ? EQ :
					 FG0_SEL ? {8'h00,FG0_Q[15:8],8'h00,FG0_Q[7:0]} :
					 FG1_SEL ? {8'h00,FG1_Q[15:8],8'h00,FG1_Q[7:0]} :
					 BG0_SEL ? {BG0_Q_1[15:8],BG0_Q_0[15:8],BG0_Q_1[7:0],BG0_Q_0[7:0]} :
					 BG1_SEL ? {BG1_Q_1[15:8],BG1_Q_0[15:8],BG1_Q_1[7:0],BG1_Q_0[7:0]} :
					 EQ;
	assign LRDY = MISC_SEL ? ~SPR_EXEC :
	              LA[31:24] == 8'h40 ? ~SPR_EXEC :
	              SPR_SEL ? SPR_RDY & ERDY:
					  FG0_SEL ? FG0_RDY : 
					  FG1_SEL ? FG1_RDY :
					  BG0_SEL ? 1'b1 :
					  BG1_SEL ? 1'b1 :
					  ERDY;
							
	assign EADDR = {LA[25:5],2'b00};
	assign EDATA = LDO;
	assign EWE = ~CAS_N & ~{4{WE_N}} & {4{QE_N}} & {4{LA[3]}};
	assign ERD = ~QE_N & LA[3];
	assign EROM = LA[31:24] >= 8'hFC;
	assign ERAM = LA[31:24] == 8'h00;
	assign ENVRAM = LA[31:24] == 8'h60;
	assign ESPR = SPR_SEL;
						  
	assign {R,G,B} = (BG0_GRID && GRID_EN[0]) || (BG1_GRID && GRID_EN[1]) ? 24'hFFFFFF : {{PAL_Q[17:12],PAL_Q[17:16]},{PAL_Q[11:6],PAL_Q[11:10]},{PAL_Q[5:0],PAL_Q[5:4]}};
	
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
	spram #(16,8,"rtl/bt.mif") ramZ80
	(
		.clock(CLK),
		.address(Z80_A),
		.data(Z80_DO),
		.wren(Z80_RAM_WE),
		.q(Z80_RAM_DO)
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
