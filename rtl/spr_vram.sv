module SPR_VRAM (
	input          CLK,
	input          RST_N,
	
	input  [17: 0] A,
	input  [31: 0] D,
	output [31: 0] Q,
	input          RAS_N,
	input  [ 3: 0] CAS_N,
	input          WE_N,
	input          OE_N,
	output         RDY,
	
	input          SC,
	input          SE_N,
	output [15: 0] SQ,
	
	output [17: 0] ESADDR,
	output [63: 0] ESDATA,
	output         ESWR,
	output         ESRD,
	input  [63: 0] ESQ,
	input          ESTE
);


	bit  [15: 3] RAM_SA;
	bit          RAM_SWE;
	bit  [63: 0] RAM_SQ;
	bit  [ 8: 0] SR_WA;
	bit          SR_WA0;
	bit  [63: 0] SR_WD;
	bit  [ 7: 0] SR_WE;
	bit  [ 8: 0] SR_RA;
	bit  [63: 0] SR_Q;

	assign Q = '0;
	
	bit  [ 8: 0] MEM_ROW;
	bit  [ 8: 0] MEM_COL;
	bit  [ 8: 0] SREG_POS;
	bit          SREG_POS0;
	bit          MRT_EXEC;	//memory-to-register transfer
	bit          RMT_EXEC;	//register-to-memory transfer
	always @(posedge CLK or negedge RST_N) begin
		bit        RAS_N_OLD;
		bit        SC_OLD;
		
		if (!RST_N) begin
			MEM_ROW <= '0;
			MEM_COL <= '0;
			MRT_EXEC <= 0;
			RMT_EXEC <= 0;
			SREG_POS <= '0;
			SR_WA <= '0;
			SR_WA0 <= 0;
			SR_WE <= '0;
			SR_RA <= '0;
		end else begin
			RAS_N_OLD <= RAS_N;
			if (!RAS_N && RAS_N_OLD) begin
				MRT_EXEC <= 0;
				RMT_EXEC <= 0;
				if (!OE_N && WE_N) begin
					MEM_ROW <= A[17:9];
					MEM_COL <= A[8:0];
					MRT_EXEC <= 1;
					{SREG_POS, SREG_POS0} <= '0;
					SR_RA <= A[8:0];
				end else if (!OE_N && !WE_N) begin
					MEM_ROW <= A[17:9];
					MEM_COL <= A[8:0];
					RMT_EXEC <= !SE_N;
					{SREG_POS, SREG_POS0} <= '0;
				end
			end
			SC_OLD <= SC;
			if (SC && !SC_OLD) begin
				SR_RA <= SR_RA + 9'h1;
				case (SR_RA[1:0])
					2'b00: SQ <= SR_Q[15: 0];
					2'b01: SQ <= SR_Q[31:16];
					2'b10: SQ <= SR_Q[47:32];
					2'b11: SQ <= SR_Q[63:48];
				endcase
			end
			
			SR_WE <= '0;
			if ((MRT_EXEC || RMT_EXEC) && ESTE) begin
				SR_WA0 <= SREG_POS0;
				SR_WA <= SREG_POS;
				SR_WD <= {ESQ[31:0],ESQ[63:32]};
				SR_WE <= {8{MRT_EXEC}};
				
				SREG_POS0 <= ~SREG_POS0;
				if (SREG_POS0) begin					
					SREG_POS <= SREG_POS + 9'h8;
					if (SREG_POS == 9'h1F8) begin
						MRT_EXEC <= 0;
						RMT_EXEC <= 0;
					end
				end
			end
		end
	end
//	assign RAM_SA = {SREG_ROW,SREG_POS[7:3]};
//	assign RAM_SWE = RMT_EXEC;
	
	
	VRAM_SHIFTREG  #(10) shiftreg(
		.CLK(CLK),
		.WADDR({SR_WA[8:3],SR_WA0}),
		.DATA(SR_WD),
		.WREN(SR_WE),
		.RADDR(RMT_EXEC ? {SREG_POS[8:3],SREG_POS0} : SR_RA[8:2]),
		.Q(SR_Q)
	);
	
	assign ESADDR = {MEM_ROW,9'h000};
	assign ESDATA = {SR_Q[31:0],SR_Q[63:32]};
	assign ESWR = RMT_EXEC;
	assign ESRD = MRT_EXEC;
	
	assign RDY = ~(MRT_EXEC | RMT_EXEC);

endmodule
