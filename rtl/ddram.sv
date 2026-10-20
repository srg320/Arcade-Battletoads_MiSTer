module ddram #(parameter USE_PREDECODED_TAGS=0, parameter USE_PREDECODED_WORD=0, parameter USE_PREDECODED_WE=0, parameter USE_PREDECODED_MISS=0, parameter USE_PARALLEL_DIN=0, parameter FG_FAST=0)
(
	output         DDRAM_CLK,
	input          DDRAM_BUSY,
	output [ 7: 0] DDRAM_BURSTCNT,
	output [28: 0] DDRAM_ADDR,
	input  [63: 0] DDRAM_DOUT,
	input          DDRAM_DOUT_READY,
	output         DDRAM_RD,
	output [63: 0] DDRAM_DIN,
	output [ 7: 0] DDRAM_BE,
	output         DDRAM_WE,

	input          clk,
	input          rst,

	input  [27: 1] io_addr,
	output [31: 0] io_dout,
	input  [31: 0] io_din,
	input          io_rd,
	input  [ 3: 0] io_we,
	output         io_busy,

	input          sclk,
	input  [27: 1] addr,
	output [31: 0] dout,
	input  [31: 0] din,
	input          rd,
	input  [ 3: 0] we,
	input  [ 1: 0] cache,
	output         busy,
	input  [3:0]   external_tag_hit,
	input  [2:0]   external_read_hit_part,
	input  [3:0]   external_read_word,
	input          external_we_any,
	output [3:0][23:0] tag_keys,

	input  [27: 1] baddr,
	input  [63: 0] bin,
	output reg [63: 0] bout,
	input          bwr,
	input          brd,
	output reg [ 9: 3] ba,
	output reg     bte,

	output reg [31: 0] dbg_din,
	input [3:0][31:0] parallel_din,
	input [3:0] parallel_din_sel,
	// FG_FAST: foreground upper-half beats (64-bit, lanes 0/2/4/6) through the
	// otherwise idle io write path. fg_done pulses when a beat has been issued.
	input          fg_we,
	input  [27: 1] fg_addr,
	input  [63: 0] fg_din,
	output reg     fg_done = 0
);

	reg  [ 27:  1] ram_address;
	reg  [ 63:  0] ram_din;
	reg  [  7:  0] ram_ba;
	reg  [  7:  0] ram_burst;
	reg            ram_read = 0;
	reg            ram_write = 0;

	reg            burst_read_busy = 0;
	reg            burst_write_busy = 0;
	reg            read_busy = 0;
	reg            write_pend = 0;
	reg            write_busy = 0;
	reg            io_read_busy = 0;
	reg            io_write_busy = 0;
	(* preserve, dont_merge *) bit old_io_we_busy = 0;

	reg  [ 27:  1] burst_addr;
	reg  [ 27:  1] write_addr;
	wire [31:0] write_data;
	// Copy of write_data dedicated to the DDR write beat: write_data itself fans
	// out to the cache patch storage across the chip, which stretched the route
	// into ram_din. Same value, loaded at the same edge.
	wire [31:0] write_data_o;
	reg  [  3:  0] write_be;
	reg  [  1:  0] write_cache;
	reg            cache_write_commit = 0;
	(* keep = "true" *) reg [3:0] write_tag_hit = 0;
	reg  [ 27:  1] read_addr[4] = '{4{'1}};
	reg  [  1:  0] read_cache;
	wire [ 31:  0] rbuf[4][4];
	// Decode the two read selectors when their metadata is captured. This
	// removes the tag-address mux from the CPU's combinational return path.
	(* keep = "true" *) reg [3:0] read_bank_sel = 4'b0001;
	(* keep = "true" *) reg [3:0] read_word_sel[4] = '{4{4'b1000}};
	wire [31:0] read_bank_data[4];
	// Compare tags before selecting a bank. A wide dynamic tag mux on the
	// request address path adds delay before the miss detector.
	(* keep = "true" *) wire [3:0] read_tag_hit;
	(* keep = "true" *) wire [3:0] read_bank_miss;
	// The predecoded form folds cache==bank into the tag compare's region flags.
	wire read_miss = USE_PREDECODED_MISS ? !(|external_read_hit_part) : |read_bank_miss;
	genvar tag_bank;
	generate for (tag_bank=0; tag_bank<4; tag_bank=tag_bank+1) begin : read_tags
		assign tag_keys[tag_bank] = read_addr[tag_bank][27:4];
		assign read_tag_hit[tag_bank] = USE_PREDECODED_TAGS ? external_tag_hit[tag_bank] :
		                              read_addr[tag_bank][27:4] == addr[27:4];
		assign read_bank_miss[tag_bank] = cache == tag_bank && !read_tag_hit[tag_bank];
		assign read_bank_data[tag_bank] =
			(rbuf[tag_bank][0] & {32{read_word_sel[tag_bank][0]}}) |
			(rbuf[tag_bank][1] & {32{read_word_sel[tag_bank][1]}}) |
			(rbuf[tag_bank][2] & {32{read_word_sel[tag_bank][2]}}) |
			(rbuf[tag_bank][3] & {32{read_word_sel[tag_bank][3]}});
	end endgenerate

	// Each cache word has fixed fill/patch inputs and byte enables. Keep DDR
	// response data out of the CPU write mux while preserving fill priority,
	// initialization, output bytes and the original capture cycle.
	reg [6:0] rpos;
	genvar store_bank, store_word, store_byte;
	generate for (store_bank=0; store_bank<4; store_bank=store_bank+1) begin : cache_store_bank
		for (store_word=0; store_word<4; store_word=store_word+1) begin : cache_store_word
			wire fill = DDRAM_DOUT_READY && state == 3'd4 && read_cache == store_bank &&
			            rpos == (store_word/2)*2;
			wire patch_word = !rst && cache_write_commit && write_cache == store_bank &&
			                  write_tag_hit[store_bank] &&
			                  write_addr[3:2] == store_word;
			// Keep incoming DDR data on a direct register input. CPU byte patches
			// have separate storage, selected only after the fill is registered.
			// A fill wins over every simultaneous patch, as in the original cache.
			(* preserve = "true" *) reg [31:0] fill_data = '1;
			(* preserve = "true" *) reg [31:0] patch_data = '0;
			(* preserve = "true" *) reg [3:0] patch_valid = '0;
			always @(posedge clk)
				if (fill) fill_data <= (store_word%2)==0 ? DDRAM_DOUT[63:32] : DDRAM_DOUT[31:0];
			for (store_byte=0; store_byte<4; store_byte=store_byte+1) begin : cache_store_byte
				always @(posedge clk) begin
					if (fill) patch_valid[store_byte] <= 0;
					else if (patch_word && write_be[store_byte]) patch_valid[store_byte] <= 1;
					if (patch_word && write_be[store_byte])
						patch_data[store_byte*8 +: 8] <= write_data[store_byte*8 +: 8];
				end
				assign rbuf[store_bank][store_word][store_byte*8 +: 8] = patch_valid[store_byte] ?
					patch_data[store_byte*8 +: 8] : fill_data[store_byte*8 +: 8];
			end
		end
	end endgenerate
	reg  [ 27:  1] io_write_addr;
	reg  [ 31:  0] io_write_data;
	// Same-cycle copy that feeds only the DDR write-beat register, so it can be
	// placed next to ram_din instead of next to the HPS io path.
	(* preserve, dont_merge *) reg [63:0] io_write_data_din;
	reg  [  7:  0] io_write_be;
	reg            io_write_fg = 0;
	reg  [ 27:  1] io_read_addr;
	reg  [ 31:  0] io_rbuf;

	reg  [  2:  0] state = 0;
	// Decode each original literal state D into local idle/bin flags on the same edge.
	(* preserve, dont_merge *) reg [1:0] din_phase_lane[4] = '{4{2'b01}};
	reg            write_prepend = 0;
	bit old_brd, old_bwr, old_rd, old_we;

	// Register the reduction of the next handshake flags, rather than adding
	// a cycle to the requester. This is exactly the flag OR after this edge;
	// the fast DDR clock no longer drives the CPU ready input through an OR tree.
	(* keep = "true" *) reg busy_reg = 0;
	// Factor local completion/reset terms before the late request/tag input.
	// Completion retains the last-assignment priority of the original process.
	(* keep = "true" *) wire state_idle = state == 3'd0;
	(* keep = "true" *) wire read_clear = rst ||
	    (DDRAM_DOUT_READY && state == 3'd4 && rpos == 7'd2);
	(* keep = "true" *) wire write_clear = rst ||
	    (!DDRAM_BUSY && state_idle && !burst_write_busy &&
	     !burst_read_busy && write_pend);
	wire request_write = USE_PREDECODED_WE ? external_we_any : |we;
	(* keep = "true" *) wire write_start = request_write && !old_we;
	// Local controls arrive before the request-address tag comparison.
	(* keep = "true" *) wire read_hold_local = !read_clear && read_busy;
	(* keep = "true" *) wire read_permit_local = !read_clear && rd && !old_rd;
	wire read_busy_next = read_hold_local || (read_permit_local && read_miss);
	wire write_busy_next = !write_clear && (write_busy || write_start) &&
	                       (!write_start || !state_idle);
	always @(posedge clk) begin
		read_busy <= read_busy_next;
		write_busy <= write_busy_next;
	end
	// Each physical tag bank owns its capture enable. A new read retains
	// priority over simultaneous write invalidation, exactly as before.
	// A foreground beat bypasses the cached main port: drop any cached
	// foreground-region line (address bit 25) when the beat is issued.
	wire [3:0] fg_invalidate;
	genvar fg_bank;
	generate for (fg_bank=0; fg_bank<4; fg_bank=fg_bank+1) begin : fg_inval
		assign fg_invalidate[fg_bank] = FG_FAST && fg_done && read_addr[fg_bank][25];
	end endgenerate
	genvar request_bank;
	generate for (request_bank=0; request_bank<4; request_bank=request_bank+1) begin : request_tags
		(* keep = "true" *) wire capture = rd && !old_rd && cache == request_bank;
		wire invalidate = (cache_write_commit && write_cache == request_bank &&
		                  !write_tag_hit[request_bank]) || fg_invalidate[request_bank];
		always @(posedge clk) begin
			if (rst) begin
				read_addr[request_bank] <= '1;
				read_word_sel[request_bank] <= 4'b1000;
			end else if (capture) begin
				read_addr[request_bank] <= addr;
				read_word_sel[request_bank] <= request_word;
			end else if (invalidate) begin
				read_addr[request_bank] <= '1;
				read_word_sel[request_bank] <= 4'b1000;
			end
		end
	end endgenerate
	// Combine bank and word selection at their existing metadata edge.
	// Writes to another bank leave this selector untouched; invalidating the
	// active bank selects its original all-ones tag's word three.
	(* keep = "true", altera_attribute = "-name AUTO_CLOCK_ENABLE_RECOGNITION OFF" *) reg [15:0] read_return_sel = 16'h0008;
	// Decode local metadata before the late request word. Each selector bit's
	// D input is one sum of products, including the original reset/read/write
	// priorities; request_word no longer passes through a second feedback mux.
	wire [3:0] return_capture_bank, return_hold_bank, return_word3_bank;
	genvar return_bank;
	generate for (return_bank=0; return_bank<4; return_bank=return_bank+1) begin : return_select
		(* keep = "true" *) wire capture_bank = !rst && rd && !old_rd && cache == return_bank;
		wire invalidate_active = ((cache_write_commit && write_cache == return_bank &&
		                         !write_tag_hit[return_bank]) || fg_invalidate[return_bank]) &&
		                         read_bank_sel[return_bank];
		(* keep = "true" *) wire hold_bank = !rst && !(rd && !old_rd) && !invalidate_active;
		(* keep = "true" *) wire word3_bank = (rst && read_bank_sel[return_bank]) ||
		                                     (!rst && !(rd && !old_rd) && invalidate_active);
		assign return_capture_bank[return_bank] = capture_bank;
		assign return_hold_bank[return_bank] = hold_bank;
		assign return_word3_bank[return_bank] = word3_bank;
		always @(posedge clk) begin
			read_return_sel[return_bank*4 +: 4] <=
				({4{capture_bank}} & request_word) |
				({4{hold_bank}} & read_return_sel[return_bank*4 +: 4]) |
				{word3_bank, 3'b000};
		end
	end endgenerate
	// Identical selectors at the existing edge, local to each return byte.
	genvar return_lane;
	generate for(return_lane=1;return_lane<4;return_lane=return_lane+1) begin: return_lanes
		(* preserve, dont_merge, altera_attribute = "-name AUTO_CLOCK_ENABLE_RECOGNITION OFF" *) reg [15:0] read_return_sel_lane = 16'h0008;
	genvar lane_bank;
	for (lane_bank=0; lane_bank<4; lane_bank=lane_bank+1) begin : lane_select
		always @(posedge clk) begin
			read_return_sel_lane[lane_bank*4 +: 4] <=
				({4{return_capture_bank[lane_bank]}} & request_word) |
				({4{return_hold_bank[lane_bank]}} & read_return_sel_lane[lane_bank*4 +: 4]) |
				{return_word3_bank[lane_bank], 3'b000};
		end
	end
	end endgenerate
	wire [3:0] request_word = USE_PREDECODED_WORD ? external_read_word : (4'b0001 << addr[3:2]);
	reg [6:0] busy_next;
	always_comb begin
		busy_next = {ram_write,write_pend,write_prepend,read_busy,write_busy,
		             burst_write_busy,burst_read_busy};
		if (rst) busy_next[5:0] = 0;
		else begin
			if (brd && !old_brd) busy_next[0] = 1;
			if (bwr && !old_bwr) busy_next[1] = 1;
			
			if (write_prepend && sclk) begin
				busy_next[4] = 0;
				busy_next[5] = 1;
			end
		end
		if (!DDRAM_BUSY) begin
			busy_next[6] = 0;
			case (state)
				0: if (!burst_write_busy && !burst_read_busy) begin
					if (write_pend) begin
						busy_next[5] = 0;
						
						busy_next[6] = 1;
					end else if (!read_busy && io_write_busy) busy_next[6] = 1;
				end
				1: begin
					busy_next[6] = 1;
					if (rpos == 7'd127) busy_next[1] = 0;
				end
				default: ;
			endcase
		end
		if (DDRAM_DOUT_READY) begin
			if (state == 3'd2 && rpos == 7'd127) busy_next[0] = 0;
			
		end
	end
	// Every new write leaves at least prepend, pending or ram_write busy.
	// Reduce the local completion flags first, then add the late request once.
	// This is the exact original post-edge flag OR, including reset priority.
	(* keep = "true" *) wire busy_local = |{busy_next[6:4],
	    (!read_clear && read_busy), (!write_clear && write_busy), busy_next[1:0]};
	wire read_start_busy = !read_clear && !old_rd && read_miss;
	(* keep = "true" *) wire busy_without_new_read = busy_local || (!rst && write_start);
	always @(posedge clk)
		busy_reg <= busy_without_new_read || (read_permit_local && read_miss);

	// BT_PARALLEL_DDR_CAPTURE_BEGIN
	// Preserve the acceptance edge. The owner no longer gates wide raw-data
	// register inputs; selection happens after the four words are captured.
	// Module-scope write_data* names retain the existing qualified endpoint
	// family. Owner registers are separate, ordinary single-cycle targets.
	(* preserve, dont_merge *) reg [3:0][31:0] write_data_parallel;
	(* preserve, dont_merge *) reg [3:0][31:0] write_data_o_parallel;
	reg [31:0] write_data_serial;
	(* preserve, dont_merge *) reg [31:0] write_data_o_serial;
	generate if (USE_PARALLEL_DIN) begin : parallel_write_capture
		(* preserve, dont_merge *) reg [3:0] cache_owner, beat_owner;
		always @(posedge clk) if (!rst && write_prepend && sclk) begin
			write_data_parallel <= parallel_din;
			write_data_o_parallel <= parallel_din;
			cache_owner <= parallel_din_sel;
			beat_owner <= parallel_din_sel;
		end
		assign write_data =
			(write_data_parallel[0] & {32{cache_owner[0]}}) |
			(write_data_parallel[1] & {32{cache_owner[1]}}) |
			(write_data_parallel[2] & {32{cache_owner[2]}}) |
			(write_data_parallel[3] & {32{cache_owner[3]}});
		assign write_data_o =
			(write_data_o_parallel[0] & {32{beat_owner[0]}}) |
			(write_data_o_parallel[1] & {32{beat_owner[1]}}) |
			(write_data_o_parallel[2] & {32{beat_owner[2]}}) |
			(write_data_o_parallel[3] & {32{beat_owner[3]}});
`ifndef SYNTHESIS
		always @(posedge clk) if (!rst && write_prepend && sclk)
			assert ($onehot(parallel_din_sel) && din ==
				((parallel_din[0] & {32{parallel_din_sel[0]}}) |
				 (parallel_din[1] & {32{parallel_din_sel[1]}}) |
				 (parallel_din[2] & {32{parallel_din_sel[2]}}) |
				 (parallel_din[3] & {32{parallel_din_sel[3]}})))
			else $fatal(1,"DDR parallel source/owner changed accepted input word");
`endif
	end else begin : serial_write_capture
		always @(posedge clk) if (!rst && write_prepend && sclk) begin
			write_data_serial <= din;
			write_data_o_serial <= din;
		end
		assign write_data = write_data_serial;
		assign write_data_o = write_data_o_serial;
	end endgenerate
	// BT_PARALLEL_DDR_CAPTURE_END

	// The original procedural IO conditions accept only a known one. Preserve
	// that four-state behavior while keeping the busy latch off the data enable.
	function automatic bit BtDdrKnownOne(input logic value);
		BtDdrKnownOne = value;
	endfunction
	(* keep = "true" *) wire io_write_finish_local = BtDdrKnownOne(!DDRAM_BUSY && state == 3'd5);
	(* keep = "true" *) wire io_write_hold_local = io_write_busy && !io_write_finish_local;
	(* keep = "true" *) wire io_write_permit_local = !old_io_we_busy && !io_write_finish_local;
	wire fg_request = FG_FAST && BtDdrKnownOne(fg_we);
	wire io_write_request_known = BtDdrKnownOne(|io_we) || fg_request;
	always @(posedge clk) begin
		old_io_we_busy <= |io_we || fg_request;
		fg_done <= FG_FAST && io_write_fg && io_write_busy && io_write_finish_local;
		io_write_busy <= io_write_hold_local || (io_write_request_known && io_write_permit_local);
	end

	always @(posedge clk) begin
		bit old_io_rd, old_io_we;

		old_bwr <= bwr;
		old_brd <= brd;
		old_rd <= rd;
		old_we <= request_write;
		cache_write_commit <= 0;
		if (rst) begin
			burst_write_busy <= 0;
		end else if (bwr && !old_bwr) begin
			burst_addr <= baddr;
			burst_write_busy <= 1;
		end
		if (rst) begin
			burst_read_busy <= 0;
		end else if (brd && !old_brd) begin
			burst_addr <= baddr;
			burst_read_busy <= 1;
		end

		if (!rst && rd && !old_rd) begin
			read_cache <= cache;
			read_bank_sel <= 4'b0001 << cache;
		end

		if (rst) begin
			write_prepend <= 0;
		end else if (request_write && !old_we) begin
			write_prepend <= 1;
		end

		if (rst) begin
			write_pend <= 0;
		end else if (write_prepend && sclk) begin
			write_prepend <= 0;
			write_addr <= addr;
			write_be <= we;
			write_cache <= cache;
			// Compare while capturing metadata, before the byte stores. Account
			// for tag writes at this same edge, including a simultaneous read.
			for (integer bank=0; bank<4; bank=bank+1) begin
				if (rd && !old_rd && cache == bank) write_tag_hit[bank] <= 1;
				else if (cache_write_commit && write_cache == bank && !write_tag_hit[bank])
					write_tag_hit[bank] <= &addr[27:4];
				else write_tag_hit[bank] <= read_tag_hit[bank];
			end
			cache_write_commit <= 1;
			write_pend <= 1;
			if (addr == 27'h4001EA)
				dbg_din <= din;
		end

		old_io_rd <= io_rd;
		old_io_we <= |io_we || fg_request;
		if (io_rd && !old_io_rd) begin
			io_read_addr <= io_addr;
			io_read_busy <= 1;
		end
		if (fg_request && !old_io_we) begin
			io_write_addr <= fg_addr;
			io_write_data_din <= fg_din;
			io_write_be <= 8'h55;
			io_write_fg <= 1;
		end else if (|io_we && !old_io_we) begin
			io_write_addr <= io_addr;
			io_write_data <= io_din;
			io_write_data_din <= {io_din,io_din};
			io_write_be <= !io_addr[2] ? {io_we,4'b0000} : {4'b0000,io_we};
			io_write_fg <= 0;
		end

		bte <= 0;
		if(!DDRAM_BUSY) begin
			ram_write <= 0;
			ram_read  <= 0;
			case (state)
				0: begin
					if (burst_write_busy) begin
//						ram_address <= {burst_addr[27:3],2'b00};
//						ram_din		<= bin;
						ram_ba      <= 8'hFF;
//						ram_write 	<= 1;
						ram_burst   <= 1;
						rpos <= '0;
						state       <= 3'h1;
						for (integer din_copy=0; din_copy<4; din_copy=din_copy+1)
							din_phase_lane[din_copy] <= 2'b10;
					end
					else if (burst_read_busy) begin
						ram_address <= {burst_addr[27:3],2'b00};
						ram_ba      <= 8'hFF;
						ram_read 	<= 1;
						ram_burst   <= 128;
						rpos <= '0;
						state       <= 3'h2;
						for (integer din_copy=0; din_copy<4; din_copy=din_copy+1)
							din_phase_lane[din_copy] <= 2'b00;
					end
					else if (write_pend) begin
						write_pend <= 0;
						ram_address <= {write_addr[27:3],2'b00};
						ram_ba      <= !write_addr[2] ? {write_be,4'b0000} : {4'b0000,write_be};
						ram_write 	<= 1;
						ram_burst   <= 1;
						state       <= 3'h3;
						for (integer din_copy=0; din_copy<4; din_copy=din_copy+1)
							din_phase_lane[din_copy] <= 2'b00;
					end
					else if (read_busy) begin
						ram_address <= {read_addr[read_cache][27:4],3'b000};
						ram_ba      <= 8'hFF;
						ram_read    <= 1;
						ram_burst   <= 2;
						rpos <= '0;
						state       <= 3'h4;
						for (integer din_copy=0; din_copy<4; din_copy=din_copy+1)
							din_phase_lane[din_copy] <= 2'b00;
					end
					else if (io_write_busy) begin
						ram_address <= {io_write_addr[27:3],2'b00};
						ram_ba      <= io_write_be;
						ram_write 	<= 1;
						ram_burst   <= 1;
						state       <= 3'h5;
						for (integer din_copy=0; din_copy<4; din_copy=din_copy+1)
							din_phase_lane[din_copy] <= 2'b00;
					end
					else if (io_read_busy) begin
						ram_address <= {io_read_addr[27:3],2'b00};
						ram_ba      <= 8'hFF;
						ram_read    <= 1;
						ram_burst   <= 1;
						rpos <= '0;
						state       <= 3'h6;
						for (integer din_copy=0; din_copy<4; din_copy=din_copy+1)
							din_phase_lane[din_copy] <= 2'b00;
					end
				end

				1: begin
					ram_address <= {burst_addr[27:3],2'b00};
					ram_write 	<= 1;
					ba <= rpos;
					bte <= 1;
					rpos <= rpos + 7'd1;
					state <= 7;
					for (integer din_copy=0; din_copy<4; din_copy=din_copy+1)
						din_phase_lane[din_copy] <= 2'b00;
					if (rpos == 7'd127) begin
						burst_write_busy <= 0;
						state <= 0;
						for (integer din_copy=0; din_copy<4; din_copy=din_copy+1)
							din_phase_lane[din_copy] <= 2'b01;
					end
				end

				7: begin
					burst_addr <= burst_addr + 27'd4;
					state <= 1;
					for (integer din_copy=0; din_copy<4; din_copy=din_copy+1)
						din_phase_lane[din_copy] <= 2'b10;
				end


				3: begin
					state <= 0;
					for (integer din_copy=0; din_copy<4; din_copy=din_copy+1)
						din_phase_lane[din_copy] <= 2'b01;
				end


				5: begin
					state <= 0;
					for (integer din_copy=0; din_copy<4; din_copy=din_copy+1)
						din_phase_lane[din_copy] <= 2'b01;
				end

			endcase
		end
		// Read responses are independent of command-port backpressure.
		if (DDRAM_DOUT_READY) begin
			case (state)
				2: begin
					bout <= DDRAM_DOUT;
					ba <= rpos;
					bte <= 1;
					rpos <= rpos + 7'd1;
					if (rpos == 7'd127) begin
						burst_read_busy <= 0;
						state <= 0;
						for (integer din_copy=0; din_copy<4; din_copy=din_copy+1)
							din_phase_lane[din_copy] <= 2'b01;
					end
				end
				4: begin
					rpos <= rpos + 7'd2;
					if (rpos == 7'd2) begin
						state <= 0;
						for (integer din_copy=0; din_copy<4; din_copy=din_copy+1)
							din_phase_lane[din_copy] <= 2'b01;
					end
				end
				6: begin
					io_rbuf <= !io_read_addr[2] ? DDRAM_DOUT[63:32] : DDRAM_DOUT[31:0];
					io_read_busy <= 0;
					state <= 0;
					for (integer din_copy=0; din_copy<4; din_copy=din_copy+1)
						din_phase_lane[din_copy] <= 2'b01;
				end
			endcase
		end
	end

	assign dout[7:0] = (rbuf[0][0][7:0] & {8{read_return_sel[0]}}) |
	       (rbuf[0][1][7:0] & {8{read_return_sel[1]}}) |
	       (rbuf[0][2][7:0] & {8{read_return_sel[2]}}) |
	       (rbuf[0][3][7:0] & {8{read_return_sel[3]}}) |
	       (rbuf[1][0][7:0] & {8{read_return_sel[4]}}) |
	       (rbuf[1][1][7:0] & {8{read_return_sel[5]}}) |
	       (rbuf[1][2][7:0] & {8{read_return_sel[6]}}) |
	       (rbuf[1][3][7:0] & {8{read_return_sel[7]}}) |
	       (rbuf[2][0][7:0] & {8{read_return_sel[8]}}) |
	       (rbuf[2][1][7:0] & {8{read_return_sel[9]}}) |
	       (rbuf[2][2][7:0] & {8{read_return_sel[10]}}) |
	       (rbuf[2][3][7:0] & {8{read_return_sel[11]}}) |
	       (rbuf[3][0][7:0] & {8{read_return_sel[12]}}) |
	       (rbuf[3][1][7:0] & {8{read_return_sel[13]}}) |
	       (rbuf[3][2][7:0] & {8{read_return_sel[14]}}) |
	       (rbuf[3][3][7:0] & {8{read_return_sel[15]}});
	assign dout[15:8] = (rbuf[0][0][15:8] & {8{return_lanes[1].read_return_sel_lane[0]}}) |
	       (rbuf[0][1][15:8] & {8{return_lanes[1].read_return_sel_lane[1]}}) |
	       (rbuf[0][2][15:8] & {8{return_lanes[1].read_return_sel_lane[2]}}) |
	       (rbuf[0][3][15:8] & {8{return_lanes[1].read_return_sel_lane[3]}}) |
	       (rbuf[1][0][15:8] & {8{return_lanes[1].read_return_sel_lane[4]}}) |
	       (rbuf[1][1][15:8] & {8{return_lanes[1].read_return_sel_lane[5]}}) |
	       (rbuf[1][2][15:8] & {8{return_lanes[1].read_return_sel_lane[6]}}) |
	       (rbuf[1][3][15:8] & {8{return_lanes[1].read_return_sel_lane[7]}}) |
	       (rbuf[2][0][15:8] & {8{return_lanes[1].read_return_sel_lane[8]}}) |
	       (rbuf[2][1][15:8] & {8{return_lanes[1].read_return_sel_lane[9]}}) |
	       (rbuf[2][2][15:8] & {8{return_lanes[1].read_return_sel_lane[10]}}) |
	       (rbuf[2][3][15:8] & {8{return_lanes[1].read_return_sel_lane[11]}}) |
	       (rbuf[3][0][15:8] & {8{return_lanes[1].read_return_sel_lane[12]}}) |
	       (rbuf[3][1][15:8] & {8{return_lanes[1].read_return_sel_lane[13]}}) |
	       (rbuf[3][2][15:8] & {8{return_lanes[1].read_return_sel_lane[14]}}) |
	       (rbuf[3][3][15:8] & {8{return_lanes[1].read_return_sel_lane[15]}});
	assign dout[23:16] = (rbuf[0][0][23:16] & {8{return_lanes[2].read_return_sel_lane[0]}}) |
	       (rbuf[0][1][23:16] & {8{return_lanes[2].read_return_sel_lane[1]}}) |
	       (rbuf[0][2][23:16] & {8{return_lanes[2].read_return_sel_lane[2]}}) |
	       (rbuf[0][3][23:16] & {8{return_lanes[2].read_return_sel_lane[3]}}) |
	       (rbuf[1][0][23:16] & {8{return_lanes[2].read_return_sel_lane[4]}}) |
	       (rbuf[1][1][23:16] & {8{return_lanes[2].read_return_sel_lane[5]}}) |
	       (rbuf[1][2][23:16] & {8{return_lanes[2].read_return_sel_lane[6]}}) |
	       (rbuf[1][3][23:16] & {8{return_lanes[2].read_return_sel_lane[7]}}) |
	       (rbuf[2][0][23:16] & {8{return_lanes[2].read_return_sel_lane[8]}}) |
	       (rbuf[2][1][23:16] & {8{return_lanes[2].read_return_sel_lane[9]}}) |
	       (rbuf[2][2][23:16] & {8{return_lanes[2].read_return_sel_lane[10]}}) |
	       (rbuf[2][3][23:16] & {8{return_lanes[2].read_return_sel_lane[11]}}) |
	       (rbuf[3][0][23:16] & {8{return_lanes[2].read_return_sel_lane[12]}}) |
	       (rbuf[3][1][23:16] & {8{return_lanes[2].read_return_sel_lane[13]}}) |
	       (rbuf[3][2][23:16] & {8{return_lanes[2].read_return_sel_lane[14]}}) |
	       (rbuf[3][3][23:16] & {8{return_lanes[2].read_return_sel_lane[15]}});
	assign dout[31:24] = (rbuf[0][0][31:24] & {8{return_lanes[3].read_return_sel_lane[0]}}) |
	       (rbuf[0][1][31:24] & {8{return_lanes[3].read_return_sel_lane[1]}}) |
	       (rbuf[0][2][31:24] & {8{return_lanes[3].read_return_sel_lane[2]}}) |
	       (rbuf[0][3][31:24] & {8{return_lanes[3].read_return_sel_lane[3]}}) |
	       (rbuf[1][0][31:24] & {8{return_lanes[3].read_return_sel_lane[4]}}) |
	       (rbuf[1][1][31:24] & {8{return_lanes[3].read_return_sel_lane[5]}}) |
	       (rbuf[1][2][31:24] & {8{return_lanes[3].read_return_sel_lane[6]}}) |
	       (rbuf[1][3][31:24] & {8{return_lanes[3].read_return_sel_lane[7]}}) |
	       (rbuf[2][0][31:24] & {8{return_lanes[3].read_return_sel_lane[8]}}) |
	       (rbuf[2][1][31:24] & {8{return_lanes[3].read_return_sel_lane[9]}}) |
	       (rbuf[2][2][31:24] & {8{return_lanes[3].read_return_sel_lane[10]}}) |
	       (rbuf[2][3][31:24] & {8{return_lanes[3].read_return_sel_lane[11]}}) |
	       (rbuf[3][0][31:24] & {8{return_lanes[3].read_return_sel_lane[12]}}) |
	       (rbuf[3][1][31:24] & {8{return_lanes[3].read_return_sel_lane[13]}}) |
	       (rbuf[3][2][31:24] & {8{return_lanes[3].read_return_sel_lane[14]}}) |
	       (rbuf[3][3][31:24] & {8{return_lanes[3].read_return_sel_lane[15]}});

`ifdef VERILATOR
	always @(posedge clk) if (!rst && rd && !old_rd && USE_PREDECODED_WORD)
		assert (external_read_word == (4'b0001 << addr[3:2]))
			else $fatal(1,"DDR predecoded word differs at existing request edge");
	always @(posedge clk) if (USE_PREDECODED_WE)
		assert (external_we_any == (|we))
			else $fatal(1,"DDR scalar write request differs from byte enables");
	// Only the addressed bank's hit is consumed (read miss gating and
	// write_tag_hit[write_cache]); the other banks' predecoded hits are unused.
	always @(posedge clk) if (!rst && USE_PREDECODED_TAGS &&
		((rd && !old_rd) || (write_prepend && sclk)))
		assert (external_tag_hit[cache] == (read_addr[cache][27:4] == addr[27:4]))
			else $fatal(1,"DDR factored address tag changed at request capture");
	always @(posedge clk) if (!rst && USE_PREDECODED_MISS && rd && !old_rd)
		assert ((!(|external_read_hit_part)) == (read_addr[cache][27:4] != addr[27:4]))
			else $fatal(1,"DDR predecoded read miss differs from the tag compare at read start");
	always @(posedge clk) if (!rst && cache_write_commit)
		assert (write_tag_hit[write_cache] ==
		        (read_addr[write_cache][27:4] == write_addr[27:4]))
			else $fatal(1,"DDR predecoded write tag disagrees at cache commit");
	always @(negedge clk) if (!rst) begin
		assert (busy_reg == (burst_read_busy | burst_write_busy | write_busy |
		                     read_busy | write_prepend | write_pend | ram_write))
			else $fatal(1,"DDR next-state busy disagrees with the handshake flags");
		for (integer return_check=0;return_check<16;return_check=return_check+1)
			assert (read_return_sel[return_check] ==
				(read_bank_sel[return_check/4] && read_word_sel[return_check/4][return_check%4]))
				else $fatal(1,"DDR combined selector disagrees with original metadata");
		assert (read_bank_sel == (4'b0001 << read_cache))
			else $fatal(1,"DDR read bank selector disagrees with metadata");
		for (integer check_bank=0; check_bank<4; check_bank=check_bank+1)
			assert (read_word_sel[check_bank] == (4'b0001 << read_addr[check_bank][3:2]))
				else $fatal(1,"DDR read word selector disagrees with metadata");
	end
`endif
	// Keep the requester parked through capture and the final accepted write.
	assign busy = busy_reg;

	assign io_dout = io_rbuf;
	assign io_busy = io_read_busy | io_write_busy;

	assign DDRAM_CLK      = clk;
	assign DDRAM_BURSTCNT = ram_burst;
	assign DDRAM_BE       = ram_ba;
	assign DDRAM_ADDR     = {4'b0011, ram_address[27:3]}; // RAM at 0x30000000
	assign DDRAM_RD       = ram_read;
	// The DDR write beat. The three loads were case-state assignments; they are
	// pulled out so the sprite beat (bin, from distributed RAM) passes through one
	// 2:1 select and the other two sources are chosen independently of it.
	genvar din_lane;
	generate for (din_lane=0; din_lane<4; din_lane=din_lane+1) begin : din_lanes
		wire st0_idle_pick = din_phase_lane[din_lane][0] && !burst_write_busy && !burst_read_busy;
		wire take_din_bin = !DDRAM_BUSY && din_phase_lane[din_lane][1];
		wire take_din_wr = !DDRAM_BUSY && st0_idle_pick && write_pend;
		wire take_din_io = !DDRAM_BUSY && st0_idle_pick && !write_pend && !read_busy && io_write_busy;
		(* keep = "true" *) wire [1:0] din_sel = {take_din_wr || take_din_io, take_din_bin || take_din_io};
		// Decode exactly the known case values, including its hold default.
		// Compute the other sources before the late asynchronous sprite word;
		// that word then crosses only the final select, on the same capture edge.
		wire pick_bin = BtDdrKnownOne(din_sel == 2'd1);
		wire pick_wr = BtDdrKnownOne(din_sel == 2'd2);
		wire pick_io = BtDdrKnownOne(din_sel == 2'd3);
		(* keep = "true" *) wire [15:0] din_nonbin =
			pick_wr ? write_data_o[(din_lane%2)*16 +: 16] :
			pick_io ? io_write_data_din[din_lane*16 +: 16] :
			          ram_din[din_lane*16 +: 16];
		always @(posedge clk)
			ram_din[din_lane*16 +: 16] <= pick_bin ?
				bin[din_lane*16 +: 16] : din_nonbin;
	end endgenerate
	assign DDRAM_DIN      = ram_din;
	assign DDRAM_WE       = ram_write;

endmodule
