module BG_VRAM (
	input          CLK,
	input          RST_N,
	
	input  [15: 0] A,
	input  [15: 0] D,
	output [15: 0] Q,
	input          RAS_N,
	input  [ 1: 0] CAS_N,
	input          WE_N,
	input          OE_N,
	output         RDY,
	
	input          SC,
	input          SE_N,
	output [ 7: 0] SQ,
	
	output         GRID
);


	bit  [15: 3] RAM_SA;
	bit          RAM_SWE;
	bit  [63: 0] RAM_SQ;
	bit  [63: 0] SR_Q;
	
	bit          WE_N_OLD;
	always @(posedge CLK) WE_N_OLD <= WE_N;
	
	VRAM_MEM_64Kx8 mem
	(
		.CLK(CLK),
		
		.ADDR(A[15:1]),
		.DATA(D),
		.WREN(~WE_N & WE_N_OLD & ~RAS_N),
		.BE(~CAS_N),
		.Q(Q),

		.SADDR(RAM_SA),
		.SDATA(64'h0),
		.SWREN(1'b0),
		.SQ(RAM_SQ)
	);
	
	bit  [ 7: 0] SREG_ROW;
	bit  [ 7: 0] SREG_COL;
	bit          MRT_EXEC;	//memory-to-register transfer
	bit          RMT_EXEC;	//register-to-memory transfer
	always @(posedge CLK or negedge RST_N) begin
		bit        RAS_N_OLD;
		bit        SC_OLD;
		
		if (!RST_N) begin
			SREG_ROW <= '0;
			SREG_COL <= '0;
			MRT_EXEC <= 0;
			RMT_EXEC <= 0;
		end else begin
			RAS_N_OLD <= RAS_N;
			if (!RAS_N && RAS_N_OLD) begin
				if (!OE_N && WE_N) begin
					SREG_ROW <= A[15:8];
					SREG_COL <= A[7:0];
					MRT_EXEC <= 1;
//					SR_RA <= '0;
				end
			end
			SC_OLD <= SC;
			if (!SC && SC_OLD) begin
				SREG_COL <= SREG_COL + 8'h1;
			end
		end
	end
	assign RAM_SA = {SREG_ROW,SREG_COL[7:3]};
	
	assign SR_Q = RAM_SQ;
	
	always_comb begin
		case (SREG_COL[2:0])
			3'd0: SQ = SR_Q[ 7: 0];
			3'd1: SQ = SR_Q[15: 8];
			3'd2: SQ = SR_Q[23:16];
			3'd3: SQ = SR_Q[31:24];
			3'd4: SQ = SR_Q[39:32];
			3'd5: SQ = SR_Q[47:40];
			3'd6: SQ = SR_Q[55:48];
			3'd7: SQ = SR_Q[63:56];
		endcase
		GRID <= (SREG_ROW == 8'h00 || SREG_COL == 8'h00) && MRT_EXEC;
	end
	
	assign RDY = ~(MRT_EXEC | RMT_EXEC);

endmodule
