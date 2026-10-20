module TMS34020_RF (
	input             CLK,
	input             RST_N,
	input             CE,
	input             EN,
	
	input     [ 4: 0] WA_A,
	input     [31: 0] WA_D,
	input             WA_WE,
	input     [ 4: 0] WB_A,
	input     [31: 0] WB_D,
	input             WB_WE,
	
	input     [ 4: 0] RA_A,
	output    [31: 0] RA_Q,
	input     [ 4: 0] RB_A,
	output    [31: 0] RB_Q

`ifdef DEBUG
	                  ,
	output     [31:0] A0,
	output     [31:0] A1,
	output     [31:0] A2,
	output     [31:0] A3,
	output     [31:0] A4,
	output     [31:0] A5,
	output     [31:0] A6,
	output     [31:0] A7,
	output     [31:0] A8,
	output     [31:0] A9,
	output     [31:0] A10,
	output     [31:0] A11,
	output     [31:0] A12,
	output     [31:0] A13,
	output     [31:0] A14,
	output     [31:0] B0,
	output     [31:0] B1,
	output     [31:0] B2,
	output     [31:0] B3,
	output     [31:0] B4,
	output     [31:0] B5,
	output     [31:0] B6,
	output     [31:0] B7,
	output     [31:0] B8,
	output     [31:0] B9,
	output     [31:0] B10,
	output     [31:0] B11,
	output     [31:0] B12,
	output     [31:0] B13,
	output     [31:0] B14,
	output     [31:0] SP
`endif
);
	
// synopsys translate_off
`define SIM
// synopsys translate_on
	
`ifdef SIM

	reg [31:0]  A[16];
	reg [31:0]  B[16];
	
	bit [ 4: 0] WB_A_LATCH;
	bit [31: 0] WB_D_LATCH;
	bit         WB_WE_LATCH;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin
			WB_A_LATCH <= '0;
			WB_D_LATCH <= '0;
			WB_WE_LATCH <= 0;
		end
		else begin
			WB_WE_LATCH <= 0;
			if (CE) begin
				WB_A_LATCH <= WB_A;
				WB_D_LATCH <= WB_D;
				WB_WE_LATCH <= WB_WE;
			end
		end
	end 

	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin
			A <= '{16{'0}};
		end
		else if (EN) begin
			if (WA_WE && CE) begin
				if (!WA_A[4] || WA_A[3:0] == 4'hF) begin
					A[WA_A[3:0]] <= WA_D;
				end
			end
			
			if (WB_WE && CE) begin
				if (!WB_A[4] || WB_A[3:0] == 4'hF) begin
					A[WB_A[3:0]] <= WB_D;
				end
			end
//			if (WB_WE_LATCH) begin
//				if (!WB_A_LATCH[4] || WB_A_LATCH[3:0] == 4'hF) begin
//					A[WB_A_LATCH[3:0]] <= WB_D_LATCH;
//				end
//			end 
		end
	end

	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin
			B <= '{16{'0}};
		end
		else if (EN) begin
			if (WA_WE && CE) begin
				if (WA_A[4] || WA_A[3:0] == 4'hF) begin
					B[WA_A[3:0]] <= WA_D;
				end
			end
			
			if (WB_WE && CE) begin
				if (WB_A[4] || WB_A[3:0] == 4'hF) begin
					B[WB_A[3:0]] <= WB_D;
				end
			end
//			if (WB_WE_LATCH) begin
//				if (WB_A_LATCH[4] || WB_A_LATCH[3:0] == 4'hF) begin
//					B[WB_A_LATCH[3:0]] <= WB_D_LATCH;
//				end
//			end
		end
	end

	assign RA_Q  = !RA_A[4] ? A[RA_A[3:0]       ] : B[RA_A[3:0]       ];
	assign RB_Q  = !RB_A[4] ? A[RB_A[3:0]       ] : B[RB_A[3:0]       ];
	
`else

//	bit [ 4: 0] WB_A_LATCH;
//	bit [31: 0] WB_D_LATCH;
//	bit         WB_WE_LATCH;
//	always @(posedge CLK or negedge RST_N) begin
//		if (!RST_N) begin
//			WB_A_LATCH <= '0;
//			WB_D_LATCH <= '0;
//			WB_WE_LATCH <= '0;
//		end
//		else begin
//			WB_WE_LATCH <= '0;
//			if (CE) begin
//				WB_A_LATCH <= WB_A;
//				WB_D_LATCH <= WB_D;
//				WB_WE_LATCH <= WB_WE;
//			end
//		end
//	end 
	
//	wire [ 4: 0] REG_W_A = CE ? {~&WA_A[3:0]&WA_A[4],WA_A[3:0]} : {~&WB_A_LATCH[3:0]&WB_A_LATCH[4],WB_A_LATCH[3:0]};
//	wire [31: 0] REG_D  = CE ? WA_D  : WB_D_LATCH;
//	wire         REG_WE = CE ? WA_WE : WB_WE_LATCH;
	wire [ 4: 0] REG_W_A = WA_WE ? {~&WA_A[3:0]&WA_A[4],WA_A[3:0]} : {~&WB_A[3:0]&WB_A[4],WB_A[3:0]};
	wire [31: 0] REG_D  = WA_WE ? WA_D  : WB_D;
	wire         REG_WE = WA_WE | WB_WE;
	wire [ 4: 0] REG_RA_A = {~&RA_A[3:0]&RA_A[4],RA_A[3:0]};
	wire [ 4: 0] REG_RB_A = {~&RB_A[3:0]&RB_A[4],RB_A[3:0]};

	bit  [31: 0] RAMA_Q, RAMAO_Q, RAMB_Q;
	TMS34020_regram regramA (.CLK(CLK), .WADDR(REG_W_A), .DATA(REG_D), .WREN(REG_WE & EN & CE), .RADDR(REG_RA_A        ), .Q(RAMA_Q));
	TMS34020_regram regramAO(.CLK(CLK), .WADDR(REG_W_A), .DATA(REG_D), .WREN(REG_WE & EN & CE), .RADDR(REG_RA_A | 5'h01), .Q(RAMAO_Q));
	TMS34020_regram regramB (.CLK(CLK), .WADDR(REG_W_A), .DATA(REG_D), .WREN(REG_WE & EN & CE), .RADDR(REG_RB_A        ), .Q(RAMB_Q));

	assign RA_Q  = RAMA_Q;
	assign RB_Q  = RAMB_Q;
	
`endif

`ifdef DEBUG

	reg [31:0] DBG_R[32];
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin
			DBG_R <= '{32{'0}};
		end
		else if (CE && EN) begin
			if (WA_WE) begin
				DBG_R[WA_A] <= WA_D;
				if (WA_A[3:0] == 4'hF) begin
					DBG_R[{1'b0,WA_A[3:0]}] <= WA_D;
				end
			end
			if (WB_WE) begin
				DBG_R[WB_A] <= WB_D;
				if (WB_A[3:0] == 4'hF) begin
					DBG_R[{1'b0,WB_A[3:0]}] <= WB_D;
				end
			end
		end
	end
	
	assign A0 = DBG_R[0];
	assign A1 = DBG_R[1];
	assign A2 = DBG_R[2];
	assign A3 = DBG_R[3];
	assign A4 = DBG_R[4];
	assign A5 = DBG_R[5];
	assign A6 = DBG_R[6];
	assign A7 = DBG_R[7];
	assign A8 = DBG_R[8];
	assign A9 = DBG_R[9];
	assign A10 = DBG_R[10];
	assign A11 = DBG_R[11];
	assign A12 = DBG_R[12];
	assign A13 = DBG_R[13];
	assign A14 = DBG_R[14];
	assign SP = DBG_R[15];
	assign B0 = DBG_R[16];
	assign B1 = DBG_R[17];
	assign B2 = DBG_R[18];
	assign B3 = DBG_R[19];
	assign B4 = DBG_R[20];
	assign B5 = DBG_R[21];
	assign B6 = DBG_R[22];
	assign B7 = DBG_R[23];
	assign B8 = DBG_R[24];
	assign B9 = DBG_R[25];
	assign B10 = DBG_R[26];
	assign B11 = DBG_R[27];
	assign B12 = DBG_R[28];
	assign B13 = DBG_R[29];
	assign B14 = DBG_R[30];
`endif
	
endmodule
