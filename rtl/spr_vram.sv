module SPR_VRAM #(parameter LOCAL_FG_Q=0, parameter REGISTERED_FG_BANK_Q=0, parameter FG_BANK_ADDR_PERMUTE=0, parameter LOCAL_FG_PACKET_D=0) (
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
	output logic [15: 0] SQ,
	input  [ 8: 0] BLIT_A,
	output [15: 0] BLIT_Q,
	input          CPU_SHIFT_WE,
	input  [ 5: 0] CPU_SHIFT_WA,
	input  [63: 0] CPU_SHIFT_DATA,
	output         CPU_SHIFT_BUSY,
	input          CPU_SHIFT_RD,
	input  [ 5: 0] CPU_SHIFT_A,
	output [63: 0] CPU_SHIFT_Q,
	
	output [17: 0] ESADDR,
	output [63: 0] ESDATA,
	output         ESWR,
	output         ESRD,
	input  [63: 0] ESQ,
	input          ESTE,
	output         COMPLETE_RDY,
	output         COMPLETE_RDY_L,
	output         PACKET_IDLE_L,
	output         PACKET_IDLE,
	output [3:0] BLIT_NONZERO,
	output [63:0] FG0_SHIFT_Q,
	output [63:0] FG1_SHIFT_Q,
	output [1:0][3:0][63:0] FG_BANK_SHIFT_Q,
	input [1:0][63:0] FG_PACKET_D,
	input FG_PACKET_SELECT
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
	wire [63:0] mirror_q;
	wire [15:0] mirror_nz;
	// The registered mirror read is used directly. Its consumers (blitter,
	// foreground copy) are idle in reset, so the old post-reset blanking flop
	// only added a 64-bit gate on a cross-chip path.
	wire [63:0] BLIT_WORD = mirror_q;
	bit  [ 1: 0] BLIT_LANE;

	assign Q = '0;
	
	bit  [ 8: 0] MEM_ROW;
	bit  [ 8: 0] MEM_COL;
	bit  [ 8: 0] SREG_POS;
	bit          SREG_POS0;
	bit          MRT_EXEC;	//memory-to-register transfer
	bit          RMT_EXEC;	//register-to-memory transfer
	// Memory-clock copies of the CPU-clock command inputs: the transfer
	// decode starts from plain registers. Commands arrive one memory clock
	// later; the CPU samples ready at least four memory clocks after RAS.
	bit  [17: 0] A_M;
	bit          RAS_N_M = 1'b1, OE_N_M = 1'b1, WE_N_M = 1'b1, SC_M, SE_N_M = 1'b1;
	always @(posedge CLK) begin
		A_M <= A;
		RAS_N_M <= RAS_N;
		OE_N_M <= OE_N;
		WE_N_M <= WE_N;
		SC_M <= SC;
		SE_N_M <= SE_N;
	end
	bit RAS_N_OLD;
	always @(posedge CLK or negedge RST_N) begin

		bit        SC_OLD;

		if (!RST_N) begin
			RAS_N_OLD <= 1;
			SC_OLD <= 0;
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
			RAS_N_OLD <= RAS_N_M;
			if (!RAS_N_M && RAS_N_OLD) begin
				MRT_EXEC <= 0;
				RMT_EXEC <= 0;
				if (!OE_N_M && WE_N_M) begin
					MEM_ROW <= A_M[17:9];
					MEM_COL <= A_M[8:0];
					MRT_EXEC <= 1;
					{SREG_POS, SREG_POS0} <= '0;
					SR_RA <= A_M[8:0];
				end else if (!OE_N_M && !WE_N_M) begin
					MEM_ROW <= A_M[17:9];
					MEM_COL <= A_M[8:0];
					RMT_EXEC <= !SE_N_M;
					{SREG_POS, SREG_POS0} <= '0;
				end
			end
			SC_OLD <= SC_M;
			if (SC_M && !SC_OLD) begin
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
	
	
	// Capture a complete foreground packet before the distributed RAM port.
	// Keep completion low until the last registered packet commits.
	// Optional local replicas sample each foreground's original packet D on
	// its original MEM edge.  The live owner selector and the following
	// CPU_PACKET_DATA capture retain the original priority and latency.
	wire [63:0] CPU_PACKET_SOURCE_DATA;
	generate if (LOCAL_FG_PACKET_D) begin : local_foreground_packet
		(* preserve, dont_merge *) bit [1:0][63:0] fg_packet_data_q;
		always @(posedge CLK) fg_packet_data_q <= FG_PACKET_D;
		assign CPU_PACKET_SOURCE_DATA = FG_PACKET_SELECT ? fg_packet_data_q[0] : fg_packet_data_q[1];
	end else begin : original_foreground_packet
		assign CPU_PACKET_SOURCE_DATA = CPU_SHIFT_DATA;
	end endgenerate
	bit CPU_PACKET_WE;
	bit [5:0] CPU_PACKET_WA;
	bit [63:0] CPU_PACKET_DATA;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) CPU_PACKET_WE <= 0;
		else begin
			CPU_PACKET_WE <= CPU_SHIFT_WE;
			if (CPU_SHIFT_WE) begin
				CPU_PACKET_WA <= CPU_SHIFT_WA;
				CPU_PACKET_DATA <= CPU_PACKET_SOURCE_DATA;
			end
		end
	end
	assign CPU_SHIFT_BUSY = CPU_SHIFT_WE || CPU_PACKET_WE;
	VRAM_SHIFTREG  #(10) shiftreg(
		.CLK(CLK), .ACLR(1'b0),
		.WADDR(CPU_PACKET_WE ? {1'b0,CPU_PACKET_WA} : {SR_WA[8:3],SR_WA0}),
		.DATA(CPU_PACKET_WE ? CPU_PACKET_DATA : SR_WD),
		.WREN(CPU_PACKET_WE ? 8'hFF : SR_WE),
		.RADDR(CPU_SHIFT_RD ? {1'b0,CPU_SHIFT_A} :
			RMT_EXEC ? {SREG_POS[8:3],SREG_POS0} : BLIT_A[8:2]),
		.Q(SR_Q)
	);
	// The original asynchronous port is also used by serial DDR transfers.
	// Mirror its writes in M10K RAM and use the clocked read for the blitter.
	// The mirror's read leaves through the M10K output register: the blitter
	// and the foreground copy both tolerate the second clock (see below).
	BT_SPR_POST_NONZERO_MIRROR #(10,LOCAL_FG_Q,REGISTERED_FG_BANK_Q,FG_BANK_ADDR_PERMUTE) read_mirror(
		.CLK(CLK), .ACLR(1'b0),
		.WADDR(CPU_PACKET_WE ? {1'b0,CPU_PACKET_WA} : {SR_WA[8:3],SR_WA0}),
		.DATA(CPU_PACKET_WE ? CPU_PACKET_DATA : SR_WD),
		.WREN(CPU_PACKET_WE ? 8'hFF : SR_WE),
		.RADDR(CPU_SHIFT_RD ? {1'b0,CPU_SHIFT_A} :
			RMT_EXEC ? {SREG_POS[8:3],SREG_POS0} : BLIT_A[8:2]),
		.Q(mirror_q),.NZ(mirror_nz),.FG0_Q(FG0_SHIFT_Q),.FG1_Q(FG1_SHIFT_Q),.FG_BANK_Q(FG_BANK_SHIFT_Q)
	);
	
	assign ESADDR = {MEM_ROW,9'h000};
	// Serial DDR transfers read their own copy, addressed only by this module's
	// serial position. A foreground copy (CPU_SHIFT_RD) and a sprite serial
	// transfer never overlap: each is a separate CPU command that waits for
	// the previous one to complete.
	wire [63:0] serial_q;
	VRAM_SHIFTREG  #(10) serial_copy(
		.CLK(CLK), .ACLR(1'b0),
		.WADDR(CPU_PACKET_WE ? {1'b0,CPU_PACKET_WA} : {SR_WA[8:3],SR_WA0}),
		.DATA(CPU_PACKET_WE ? CPU_PACKET_DATA : SR_WD),
		.WREN(CPU_PACKET_WE ? 8'hFF : SR_WE),
		.RADDR({SREG_POS[8:3],SREG_POS0}),
		.Q(serial_q)
	);
`ifndef SYNTHESIS
	always @(posedge CLK) if (RST_N && RMT_EXEC && CPU_SHIFT_RD)
		$fatal(1,"Foreground copy overlapped a sprite serial transfer");
`endif
	assign ESDATA = {serial_q[31:0],serial_q[63:32]};
	assign ESWR = RMT_EXEC;
	assign ESRD = MRT_EXEC;
	

	// Predict exactly the flags published at this same memory edge. The
	// original state/register processes and packet write timing remain intact.
	bit MRT_READY_NEXT,RMT_READY_NEXT,SR_READY_NEXT;
	always_comb begin
		MRT_READY_NEXT=MRT_EXEC;
		RMT_READY_NEXT=RMT_EXEC;
		if (!RAS_N_M && RAS_N_OLD) begin
			MRT_READY_NEXT=0;
			RMT_READY_NEXT=0;
			if (!OE_N_M && WE_N_M) MRT_READY_NEXT=1;
			else if (!OE_N_M && !WE_N_M) RMT_READY_NEXT=!SE_N_M;
		end
		// This later original assignment overrides a simultaneous new command.
		if ((MRT_EXEC || RMT_EXEC) && ESTE && SREG_POS0 && SREG_POS==9'h1f8) begin
			MRT_READY_NEXT=0;
			RMT_READY_NEXT=0;
		end
		SR_READY_NEXT=MRT_EXEC && ESTE;
	end
	(* keep = "true" *) bit READY_REGISTER;
	(* keep = "true" *) bit COMPLETE_READY_REGISTER;
	(* keep = "true" *) bit PACKET_IDLE_REGISTER;
	// Same-cycle copies that feed only the CPU ready decode, so the fitter can
	// place them next to it instead of next to the sprite RAMs.
	(* preserve, dont_merge *) bit COMPLETE_READY_L;
	(* preserve, dont_merge *) bit PACKET_IDLE_L_REG;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin
			READY_REGISTER<=1;
			COMPLETE_READY_REGISTER<=1;
			PACKET_IDLE_REGISTER<=1;
			COMPLETE_READY_L<=1;
			PACKET_IDLE_L_REG<=1;
		end else begin
			READY_REGISTER<=!(MRT_READY_NEXT || RMT_READY_NEXT || SR_READY_NEXT);
			COMPLETE_READY_REGISTER<=!(MRT_READY_NEXT || RMT_READY_NEXT || SR_READY_NEXT || CPU_SHIFT_WE);
			PACKET_IDLE_REGISTER<=!CPU_SHIFT_WE;
			COMPLETE_READY_L<=!(MRT_READY_NEXT || RMT_READY_NEXT || SR_READY_NEXT || CPU_SHIFT_WE);
			PACKET_IDLE_L_REG<=!CPU_SHIFT_WE;
		end
	end
	assign RDY=READY_REGISTER;
	assign COMPLETE_RDY=COMPLETE_READY_REGISTER;
	assign PACKET_IDLE=PACKET_IDLE_REGISTER;
	assign COMPLETE_RDY_L=COMPLETE_READY_L;
	assign PACKET_IDLE_L=PACKET_IDLE_L_REG;
`ifndef SYNTHESIS
	always @(posedge CLK) assert (COMPLETE_READY_L === COMPLETE_READY_REGISTER && PACKET_IDLE_L_REG === PACKET_IDLE_REGISTER);
`endif

	// Source cursors advance only at CE_R. The mirror's address register and
	// its M10K output register take the two intervening memory clocks; the
	// lane select is delayed alongside, so the selected word settles before
	// the next blitter sample exactly as the former external register did.
	bit  [ 1: 0] BLIT_LANE2;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin
			BLIT_LANE <= '0;
			BLIT_LANE2 <= '0;
		end else begin
			BLIT_LANE <= BLIT_A[1:0];
			BLIT_LANE2 <= BLIT_LANE;
		end
	end
	assign BLIT_Q = BLIT_WORD >> {BLIT_LANE2,4'b0000};
	assign CPU_SHIFT_Q = BLIT_WORD;
	assign BLIT_NONZERO = mirror_nz >> {BLIT_LANE2,2'b00};

endmodule
module BT_SPR_POST_NONZERO_MIRROR #(parameter addr_width=10,parameter LOCAL_FG_Q=0,parameter REGISTERED_FG_BANK_Q=0,parameter FG_BANK_ADDR_PERMUTE=0)(
 input CLK,ACLR,input [addr_width-1:3] WADDR,RADDR,
 input [63:0] DATA,input [7:0] WREN,
 output reg [63:0] Q=64'b0,output reg [15:0] NZ=16'b0,
 output [63:0] FG0_Q,FG1_Q,
 output [1:0][3:0][63:0] FG_BANK_Q
);
 wire [63:0] raw_q;
 VRAM_SHIFTREG #(addr_width,1,0) raw_mirror(
  .CLK(CLK),.ACLR(ACLR),.WADDR(WADDR),.RADDR(RADDR),
  .DATA(DATA),.WREN(WREN),.Q(raw_q));
 // Same old registered-output edge, with unchanged address stage. No reset
 // is added: the original mirror ACLR is tied low and powers up at zero.
 always @(posedge CLK) begin
  Q<=raw_q;
  for(integer nibble=0;nibble<16;nibble=nibble+1)
   NZ[nibble]<=|raw_q[nibble*4+:4];
 end
 genvar foreground,bank,address_bit;
 generate if (REGISTERED_FG_BANK_Q) begin : registered_foreground_banks
  // Same CLOCK0 address and output edges as raw_mirror followed by Q.
  // The hard output is never cleared, matching the original init-zero Q.
  for(foreground=0;foreground<2;foreground=foreground+1) begin : foregrounds
   for(bank=0;bank<4;bank=bank+1) begin : banks
    wire [addr_width-1:3] mirror_waddr,mirror_raddr;
    if (FG_BANK_ADDR_PERMUTE) begin : permuted_row_bits
     // Rewire both row addresses by the same bijection.  This changes no
     // data/mask/clock/output edge, and preserves X/Z without a data XOR.
     for(address_bit=0;address_bit<addr_width-3;address_bit=address_bit+1) begin : bits
      localparam integer variant=foreground*4+bank;
      localparam integer source_bit=variant<6 ? (address_bit+variant+1)%(addr_width-3) :
       variant==6 ? addr_width-4-address_bit : address_bit==0 ? 1 : address_bit==1 ? 0 : address_bit;
      assign mirror_waddr[address_bit+3]=WADDR[source_bit+3];
      assign mirror_raddr[address_bit+3]=RADDR[source_bit+3];
     end
    end else begin : original_row_bits
     assign mirror_waddr=WADDR;
     assign mirror_raddr=RADDR;
    end
    VRAM_SHIFTREG #(addr_width,1,1) mirror(
     .CLK(CLK),.ACLR(1'b0),.WADDR(mirror_waddr),.RADDR(mirror_raddr),
     .DATA(DATA),.WREN(WREN),.Q(FG_BANK_Q[foreground][bank]));
   end
  end
  assign FG0_Q=FG_BANK_Q[0][0];
  assign FG1_Q=FG_BANK_Q[1][0];
 end else if (LOCAL_FG_Q) begin : local_foreground_q
  (* preserve, dont_merge *) reg [63:0] fg0_q = 64'b0;
  (* preserve, dont_merge *) reg [63:0] fg1_q = 64'b0;
  // Capture the original mirror's D on its original edge, never its old Q.
  always @(posedge CLK) begin
   fg0_q<=raw_q;
   fg1_q<=raw_q;
  end
  assign FG0_Q=fg0_q;
  assign FG1_Q=fg1_q;
 end else begin : shared_foreground_q
  assign FG0_Q=Q;
  assign FG1_Q=Q;
 end endgenerate
 generate if (!REGISTERED_FG_BANK_Q) begin : original_foreground_banks
  for(foreground=0;foreground<2;foreground=foreground+1) begin : foregrounds
   for(bank=0;bank<4;bank=bank+1) begin : banks
    assign FG_BANK_Q[foreground][bank] = foreground==0 ? FG0_Q : FG1_Q;
   end
  end
 end endgenerate
endmodule
