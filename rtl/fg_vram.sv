module FG_VRAM (
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
	input  [ 7: 0] SD,
	output [ 7: 0] SQ
);


	bit  [15: 3] RAM_SA;
	bit          RAM_SWE;
	bit  [63: 0] RAM_SQ;
	bit  [ 7: 0] SR_WA;
	bit  [ 7: 0] SR_WE;
	bit          SR_MRT;
	bit  [ 7: 0] SR_RA;
	bit  [63: 0] SR_Q;
	
	bit          WE_N_OLD;
	always @(posedge CLK) WE_N_OLD <= WE_N;
	
	VRAM_MEM_64Kx8 mem
	(
		.CLK(CLK),
		
		.ADDR({A[15:8],A[6:0]}),
		.DATA(D),
		.WREN(~WE_N & WE_N_OLD & OE_N & ~RAS_N),
		.BE(~CAS_N),
		.Q(Q),

		.SADDR(RAM_SA),
		.SDATA(SR_Q),
		.SWREN(RAM_SWE),
		.SQ(RAM_SQ)
	);
	
	bit  [ 7: 0] MEM_ROW;
	bit  [ 7: 0] MEM_COL;
	bit  [ 7: 0] SREG_POS;
	bit          MRT_EXEC;	//memory-to-register transfer
	bit          RMT_EXEC;	//register-to-memory transfer
	bit          SIM;			//serial input mode
	bit          SOM;			//serial output mode
	always @(posedge CLK or negedge RST_N) begin
		bit        RAS_N_OLD;
		bit        SC_OLD;
		
		if (!RST_N) begin
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
		end else begin
			RAS_N_OLD <= RAS_N;
			SC_OLD <= SC;
			if (!RAS_N && RAS_N_OLD) begin
				MRT_EXEC <= 0;
				RMT_EXEC <= 0;
				if (!OE_N && WE_N) begin
					MEM_ROW <= A[15:8];
					MEM_COL <= A[7:0];
					MRT_EXEC <= 1;
					SREG_POS <= '0;
					SIM <= 0;
					SOM <= 1;
					SR_RA <= A[7:0];
				end else if (!OE_N && !WE_N) begin
					MEM_ROW <= A[15:8];
					MEM_COL <= A[7:0];
					RMT_EXEC <= !SE_N;
					SREG_POS <= '0;
					SIM <= 1;
					SOM <= 0;
				end
			end
			
			SR_WE <= '0;
			if (SC && !SC_OLD && SIM) begin
				SR_WA <= MEM_COL;
				if (!SE_N)
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
			if (SC && !SC_OLD && SOM) begin
				MEM_COL <= MEM_COL + 8'h1;
				SR_RA <= SR_RA + 8'h1;
			end
			
			SR_MRT <= 0;
			if (MRT_EXEC || RMT_EXEC) begin
				SR_WA <= SREG_POS;
				SR_WE <= {8{MRT_EXEC}};
				SR_MRT <= MRT_EXEC;
				
				SREG_POS <= SREG_POS + 8'h8;
				if (SREG_POS == 8'hF8) begin
					MRT_EXEC <= 0;
					RMT_EXEC <= 0;
				end
			end
		end
	end
	assign RAM_SA = {MEM_ROW,SREG_POS[7:3]};
	assign RAM_SWE = RMT_EXEC;
	
	VRAM_SHIFTREG #(8) shiftreg
	(
		.CLK(CLK),
		.WADDR(SR_WA[7:3]),
		.DATA(SR_MRT ? RAM_SQ : {8{SD}}),
		.WREN(SR_WE),
		.RADDR(RMT_EXEC ? SREG_POS[7:3] : SR_RA[7:3]),
		.Q(SR_Q)
	);
	
	always_comb begin
		case (SR_RA[2:0])
			3'd0: SQ = SR_Q[ 7: 0];
			3'd1: SQ = SR_Q[15: 8];
			3'd2: SQ = SR_Q[23:16];
			3'd3: SQ = SR_Q[31:24];
			3'd4: SQ = SR_Q[39:32];
			3'd5: SQ = SR_Q[47:40];
			3'd6: SQ = SR_Q[55:48];
			3'd7: SQ = SR_Q[63:56];
		endcase
	end
	
	assign RDY = ~(MRT_EXEC | RMT_EXEC);

endmodule
