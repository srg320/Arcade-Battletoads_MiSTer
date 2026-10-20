import TMS34020_PKG::*;
module TMS34020_CACHE
 (
	input              CLK,
	input              RST_N,
	input              EN,
	
	input              CE_F,
	input              CE_R,
	
	input              RES_N,
	input              RST_EXEC,
	
	input      [31: 0] CACHE_DATA,
	input              CACHE_MEM_CAPTURE,
	input              CACHE_DDR_CAPTURE,
	input              CACHE_DDR_BYTES,
	input      [31: 0] CACHE_DDR_DATA,
	input      [31: 0] CACHE_RAM_DATA,
	input      [31: 0] CACHE_LATE_DATA,
	input              CACHE_WR,
	
	input      [31: 0] PC,
	output     [31: 0] CACHE_Q,
	// Per half-word {DecodeICRFAddress(h,0,1), DecodeICRFAddress(h,0,0)},
	// computed from the written long-word and stored beside it.
	output     [39: 0] CACHE_RF_PRE,
	output             CACHE_MISS,
	output reg         CACHE_WAIT
);
	
	bit  [31: 0] SSA[4];
	bit  [ 7: 0] P[4];
	bit  [ 1: 0] LRU_STACK[4];
	bit          SEG_MISS;
	bit          SUBSEG_MISS;
	bit  [ 1: 0] SEG;
	wire [ 2: 0] SUBSEG = PC[9:7];
	always_comb begin
		bit [ 1: 0] S;
		
		SEG_MISS <= 0;
		if (SSA[0][31:10] == PC[31:10]) begin
			S = 2'd0;
		end else if (SSA[1][31:10] == PC[31:10]) begin
			S = 2'd1;
		end else if (SSA[2][31:10] == PC[31:10]) begin
			S = 2'd2;
		end else if (SSA[3][31:10] == PC[31:10]) begin
			S = 2'd3;
		end else begin
			S = LRU_STACK[3];
			SEG_MISS <= 1;
		end
		SEG <= S;
		SUBSEG_MISS <= ~P[S][SUBSEG];
	end
	
	bit  [ 6: 0] RAM_WADDR;
	// Each fetch prepares its address/tag on R before any F payload write.
	// Preserve that preparation across CE pauses and debugger EN holds.
	bit CACHE_WRITE_READY;
	bit CACHE_MEM_USED;
	bit [31:0] CACHE_MEM_WORD,CACHE_DDR_WORD;
	bit CACHE_DDR_USED,CACHE_DDR_BYTES_USED;
	// The first preparing R captures only a stable memory-owned return.
	// SYS-owned side effects stay live through the following F write.
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin CACHE_MEM_USED <= 0; CACHE_DDR_USED <= 0; CACHE_DDR_BYTES_USED <= 0; end
		else if (!CACHE_WR) begin CACHE_MEM_USED <= 0; CACHE_DDR_USED <= 0; CACHE_DDR_BYTES_USED <= 0; end
		else if (EN && CE_R && !CACHE_WRITE_READY) begin
			CACHE_MEM_USED <= CACHE_MEM_CAPTURE;
			CACHE_DDR_USED <= CACHE_MEM_CAPTURE && CACHE_DDR_CAPTURE;
			CACHE_DDR_BYTES_USED <= CACHE_DDR_BYTES;
			if (CACHE_MEM_CAPTURE) begin
				if (CACHE_DDR_CAPTURE) CACHE_DDR_WORD <= CACHE_DDR_DATA;
				else CACHE_MEM_WORD <= CACHE_RAM_DATA;
			end
		end
	end
	wire [31:0] CACHE_DDR_RETURN_WORD = CACHE_DDR_WORD & (CACHE_DDR_BYTES_USED ? 32'h00ff00ff : 32'hffffffff);
	wire [31:0] CACHE_HELD_WORD = CACHE_DDR_USED ? CACHE_DDR_RETURN_WORD : CACHE_MEM_WORD;
	wire [31:0] CACHE_FILL_WORD = CACHE_MEM_USED ? CACHE_HELD_WORD : CACHE_LATE_DATA;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) CACHE_WRITE_READY <= 0;
		else if (!CACHE_WR) CACHE_WRITE_READY <= 0;
		else if (EN && CE_R) CACHE_WRITE_READY <= 1;
	end

	always @(posedge CLK or negedge RST_N) begin		
		bit  [ 1: 0] LWORD_POS;
		
		if (!RST_N) begin
			SSA <= '{4{'0}};
			P <= '{4{'0}};
			LRU_STACK <= '{2'd0,2'd1,2'd2,2'd3};
			LWORD_POS <= '0;
		end
		else if (EN && CE_F) begin
			CACHE_WAIT <= (SEG_MISS || SUBSEG_MISS) && !RST_EXEC;
		end
		else if (EN && CE_R) begin
			if (CACHE_WR && !CACHE_WRITE_READY) begin
				LWORD_POS <= LWORD_POS + 2'd1;
				if (LWORD_POS == 2'd3) begin
					if (SEG_MISS)
						P[SEG] <= '0;
					SSA[SEG] <= PC;
					P[SEG][SUBSEG] <= 1;
					if (SEG == LRU_STACK[1] || SEG == LRU_STACK[2] || SEG == LRU_STACK[3]) begin
						LRU_STACK[0] <= SEG;
						LRU_STACK[1] <= LRU_STACK[0];
					end
					if (SEG == LRU_STACK[2] || SEG == LRU_STACK[3]) begin
						LRU_STACK[2] <= LRU_STACK[1];
					end
					if (SEG == LRU_STACK[3]) begin
						LRU_STACK[3] <= LRU_STACK[2];
					end
				end
				RAM_WADDR <= {SEG,SUBSEG,PC[6:5]+LWORD_POS};
			end
		end
	end
	assign CACHE_MISS = (SEG_MISS || SUBSEG_MISS) && !RST_EXEC;
	
	wire [ 6: 0] RAM_RADDR = {SEG,PC[9:5]};
	// Instruction loads decode register-file addresses from the cached word.
	// The word can be written in the CE_F immediately before the CE_R load,
	// so the decode is done once at write time and stored with the word.
	wire [9:0] RF_PRE_HI = DecodeICRFAddress(CACHE_FILL_WORD[31:16],5'd0,1'b0);
	wire [9:0] RF_PRE_LO = DecodeICRFAddress(CACHE_FILL_WORD[15:0],5'd0,1'b0);
	wire [49:0] RAM_Q;
	TMS34020_CACHE_RAM #(.DATA_WIDTH(50)) CACHE_RAM (
		.CLK(CLK),
		
		.WADDR(RAM_WADDR),
		.DATA({RF_PRE_HI[8:0],RF_PRE_LO[8:0],CACHE_FILL_WORD}),
		.WREN(CACHE_WR && CE_F && CACHE_WRITE_READY),
		
		.RADDR(RAM_RADDR),
		.Q(RAM_Q)
	);
`ifndef SYNTHESIS
	// synthesis translate_off
	bit CACHE_OLD_MEM_USED;
	bit [31:0] CACHE_OLD_MEM_WORD;
	// Verbatim unchanged first-R capture, renamed only for the oracle.
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) CACHE_OLD_MEM_USED <= 0;
		else if (!CACHE_WR) CACHE_OLD_MEM_USED <= 0;
		else if (EN && CE_R && !CACHE_WRITE_READY) begin
			CACHE_OLD_MEM_USED <= CACHE_MEM_CAPTURE;
			if (CACHE_MEM_CAPTURE) CACHE_OLD_MEM_WORD <= CACHE_DATA;
		end
	end
	always @(posedge CLK) if (RST_N) begin
		assert (CACHE_MEM_USED == CACHE_OLD_MEM_USED)
			else $fatal(1,"Split cache sampling predicate differs from the prior stage");
		if (CACHE_MEM_USED) assert (CACHE_HELD_WORD == CACHE_OLD_MEM_WORD)
			else $fatal(1,"Split cache held word differs from the exact prior R sample");
	end
	always @(posedge CLK) if (RST_N && EN && CE_R && CACHE_WR && !CACHE_WRITE_READY && CACHE_MEM_CAPTURE) begin
		assert ((CACHE_DDR_CAPTURE ? (CACHE_DDR_DATA & (CACHE_DDR_BYTES ? 32'h00ff00ff : 32'hffffffff)) : CACHE_RAM_DATA) == CACHE_DATA)
			else $fatal(1,"Cache split channels differ at the original preparing R sample");
	end
	always @(posedge CLK) if (RST_N && CACHE_RAM.WREN) begin
		assert (CACHE_FILL_WORD == CACHE_DATA)
			else $fatal(1,"Cache staged/live word differs at actual F payload write");
		if (CACHE_MEM_USED)
			assert (CACHE_MEM_CAPTURE && CACHE_HELD_WORD == CACHE_DATA &&
			        CACHE_DDR_USED == CACHE_DDR_CAPTURE &&
			        (!CACHE_DDR_USED || CACHE_DDR_BYTES_USED == CACHE_DDR_BYTES))
				else $fatal(1,"Cache held memory return changed before actual F payload write");
	end
	// synthesis translate_on
`endif
	assign CACHE_Q = RAM_Q[31:0];
	assign CACHE_RF_PRE = {1'b0,RAM_Q[49:41],1'b0,RAM_Q[49:41],1'b0,RAM_Q[40:32],1'b0,RAM_Q[40:32]};
	
endmodule
