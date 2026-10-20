//
// sdram.v
//
// sdram controller implementation
// Copyright (c) 2018 Sorgelig
// 
// This source file is free software: you can redistribute it and/or modify 
// it under the terms of the GNU General Public License as published 
// by the Free Software Foundation, either version 3 of the License, or 
// (at your option) any later version. 
// 
// This source file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of 
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License 
// along with this program.  If not, see <http://www.gnu.org/licenses/>. 
//

module sdram #(
	// The board schedules refresh between its unbackpressured audio reads.
	parameter bit CONTROLLED_REFRESH = 1'b0
)
(

	// interface to the MT48LC16M16 chip
	inout      [15:0] SDRAM_DQ,   // 16 bit bidirectional data bus
	output reg [12:0] SDRAM_A,    // 13 bit multiplexed address bus
	output reg        SDRAM_DQML, // byte mask
	output reg        SDRAM_DQMH, // byte mask
	output reg  [1:0] SDRAM_BA,   // two banks
	output            SDRAM_nCS,  // a single chip select
	output reg        SDRAM_nWE,  // write enable
	output reg        SDRAM_nRAS, // row address select
	output reg        SDRAM_nCAS, // columns address select
	output            SDRAM_CLK,
	output            SDRAM_CKE,

	// cpu/chipset interface
	input             init,			// init signal after FPGA config to initialize RAM
	input             clk,			// sdram is accessed at up to 128MHz
	input             sample_clk, // phase-qualified 80 MHz receive clock

	input      [24:0] addr,
	input             rd,
	input             wr,
	input             word,
	input      [15:0] din,
	output     [15:0] dout,
	output            busy,
	input             refresh_slot
);

assign SDRAM_nCS = 0;
assign SDRAM_CKE = 1;
assign {SDRAM_DQMH,SDRAM_DQML} = SDRAM_A[12:11];

localparam RASCAS_DELAY   = 3'd2; // tRCD=20ns -> 25ns at 80MHz
localparam BURST_LENGTH   = 3'd0; // 0=1, 1=2, 2=4, 3=8, 7=full page
localparam ACCESS_TYPE    = 1'd0; // 0=sequential, 1=interleaved
localparam CAS_LATENCY    = 3'd2; // 2/3 allowed
localparam OP_MODE        = 2'd0; // only 0 (standard operation) allowed
localparam NO_WRITE_BURST = 1'd1; // 0=write burst enabled, 1=only single access write

localparam MODE = { 3'b000, NO_WRITE_BURST, OP_MODE, CAS_LATENCY, ACCESS_TYPE, BURST_LENGTH}; 

localparam STATE_IDLE  = 3'd0;             // state to check the requests
localparam STATE_START = STATE_IDLE+1'd1;  // state in which a new command is started
// Issue ACTIVE on request acceptance, then READ/WRITE two clocks later.
// Receive data before the original six-clock completion boundary.
localparam STATE_CONT  = STATE_IDLE+RASCAS_DELAY;
localparam STATE_READY = STATE_CONT+CAS_LATENCY+2'd2;
localparam STATE_LAST  = STATE_READY;      // last state in cycle

reg  [2:0] state = STATE_IDLE;
reg [24:0] a;
reg [15:0] data;
reg        we;
reg        ds;
reg        ram_req=0;
reg        cache_valid = 0;
reg        access_busy = 0;
reg        refresh_cycle = 0;
// 600 clocks plus the next audio slot stays below 625 clocks (7.8125us).
localparam [9:0] REFRESH_LIMIT = 10'd599;
localparam [2:0] REFRESH_LAST = 3'd5;
reg [9:0] refresh_timer = 0;
wire       initializing = init || init_old || init_wait != 0 || reset != 0 || mode != MODE_NORMAL;
wire       ram_req_test = wr || !cache_valid || (a[24:1] != addr[24:1]);
reg old_rd=0, old_wr=0;
wire accept_request = state == STATE_IDLE && !initializing &&
                      ((~old_rd & rd) | (~old_wr & wr));
wire start_refresh = !initializing && !accept_request &&
	(refresh_timer == REFRESH_LIMIT) && (!CONTROLLED_REFRESH || refresh_slot) &&
	(state == STATE_IDLE || (state == STATE_READY && access_busy && !refresh_cycle));
// Reserve ownership before the command edge: the loader and reset-release
// gate must not admit a write or an audio read into the refresh cooldown.
assign busy = initializing || access_busy || start_refresh;
reg [15:0] sampled_data;
(* preserve, dont_merge *) reg [15:0] sys_received_data;
reg [15:0] last_data;
reg [15:0] dq_out;
reg dq_write = 0;
assign SDRAM_DQ = dq_write ? dq_out : 16'hzzzz;

// access manager
always @(posedge clk) begin
	old_rd <= old_rd & rd;
	old_wr <= old_wr & wr;

	if(accept_request) begin
			old_rd <= rd;
			old_wr <= wr;
			we <= wr;
			ds <= word;
			a <= addr;
			data <= word ? din : {din[7:0],din[7:0]};
			ram_req <= ram_req_test;
			access_busy <= 1;
			refresh_cycle <= 0;
			state <= STATE_START;
	end

	if(state == STATE_READY && access_busy && !refresh_cycle) begin
		ram_req <= 0;
		we <= 0;
		access_busy <= 0;
		if(ram_req) begin
			if(we) begin
				a <= '1;
				cache_valid <= 0;
			end else begin
				last_data <= sys_received_data;
				cache_valid <= 1;
			end
		end
	end

	if(initializing || state != STATE_IDLE) begin
		state <= state + 1'd1;
		if(state == STATE_LAST) state <= STATE_IDLE;
	end
	if(refresh_cycle && state == REFRESH_LAST) begin
		state <= STATE_IDLE;
		access_busy <= 0;
		refresh_cycle <= 0;
	end
	if(start_refresh) begin
		state <= STATE_START;
		access_busy <= 1;
		refresh_cycle <= 1;
		ram_req <= 0;
		we <= 0;
	end
	if(initializing) begin
		old_rd <= 0;
		old_wr <= 0;
		access_busy <= 0;
		refresh_cycle <= 0;
		ram_req <= 0;
		cache_valid <= 0;
		we <= 0;
	end
	if(init || init_old) state <= STATE_IDLE;
end

always @(posedge clk) begin
	if(initializing || start_refresh || (accept_request && !ram_req_test))
		refresh_timer <= 0;
	else if(refresh_timer != REFRESH_LIMIT)
		refresh_timer <= refresh_timer + 10'd1;
end

// The single read word belongs to the preceding SDRAM rising edge. Capture
// it inside that word's valid window, then bridge into the sys clock at the
// original completion edge. CL2 starts driving after the first clock after
// READ, so receive precedes completion by one whole sys cycle.
always @(posedge sample_clk) begin
	if(state == STATE_READY-1 && access_busy && ram_req && !we)
		sampled_data <= SDRAM_DQ;
end

// Resynchronize on the SYS falling edge, 10 ns after the sample edge.
// The word is held before the original following completion/R rising edge.
// SDRAM commands, IO capture, cache completion and DSP cadence are unchanged.
always @(negedge clk) begin
    if(state == STATE_READY && access_busy && ram_req && !we)
        sys_received_data <= sampled_data;
end

// The DSP samples DI on the completion edge, before last_data's NBA update.
// Expose the captured word for that edge, then retain it in the read cache.
wire [15:0] read_data = (state == STATE_READY && access_busy && ram_req && !we)
                     ? sys_received_data : last_data;
assign dout = ((~ds & a[0]) ? {read_data[7:0],read_data[15:8]} : read_data);

localparam MODE_NORMAL = 2'b00;
localparam MODE_RESET  = 2'b01;
localparam MODE_LDM    = 2'b10;
localparam MODE_PRE    = 2'b11;

// initialization 
reg [1:0] mode = MODE_RESET;
reg [4:0] reset = '1;
reg init_old = 0;
// Keep valid clocks, CKE and NOP for the device's 200us initialization wait.
reg [14:0] init_wait = 15'd16000;
always @(posedge clk) begin
	init_old <= init;

	if(init || init_old) begin
		reset <= '1;
		init_wait <= 15'd16000;
		mode <= MODE_RESET;
	end else if(init_wait != 0) init_wait <= init_wait - 15'd1;
	else if(state == STATE_LAST) begin
		if(reset != 0) begin
			reset <= reset - 5'd1;
			if(reset == 14)     mode <= MODE_PRE;
			else if(reset == 3) mode <= MODE_LDM;
			else                mode <= MODE_RESET;
		end
		else mode <= MODE_NORMAL;
	end
end

localparam CMD_NOP             = 3'b111;
localparam CMD_ACTIVE          = 3'b011;
localparam CMD_READ            = 3'b101;
localparam CMD_WRITE           = 3'b100;
localparam CMD_BURST_TERMINATE = 3'b110;
localparam CMD_PRECHARGE       = 3'b010;
localparam CMD_AUTO_REFRESH    = 3'b001;
localparam CMD_LOAD_MODE       = 3'b000;

wire [1:0] dqm = {we & ~ds & ~a[0], we & ~ds & a[0]};

// SDRAM state machines
always @(posedge clk) begin
	if(accept_request) SDRAM_BA <= addr[24:23];
	else if(state == STATE_START && mode != MODE_NORMAL) SDRAM_BA <= 2'b00;

	dq_write <= 0;
	if(init || init_old || init_wait != 0)
		{SDRAM_nRAS, SDRAM_nCAS, SDRAM_nWE} <= CMD_NOP;
	else if(start_refresh)
		{SDRAM_nRAS, SDRAM_nCAS, SDRAM_nWE} <= CMD_AUTO_REFRESH;
	else casex({ram_req,we,mode,state})
		{2'bXX, MODE_NORMAL, STATE_IDLE }: {SDRAM_nRAS, SDRAM_nCAS, SDRAM_nWE} <= accept_request ? (ram_req_test ? CMD_ACTIVE : CMD_AUTO_REFRESH) : CMD_NOP;
		{2'b11, MODE_NORMAL, STATE_CONT }: begin
			{SDRAM_nRAS, SDRAM_nCAS, SDRAM_nWE} <= CMD_WRITE;
			dq_out <= data;
			dq_write <= 1;
		end
		{2'b10, MODE_NORMAL, STATE_CONT }: {SDRAM_nRAS, SDRAM_nCAS, SDRAM_nWE} <= CMD_READ;

		// init
		{2'bXX,  MODE_RESET, STATE_START}: {SDRAM_nRAS, SDRAM_nCAS, SDRAM_nWE} <=
			(reset == 12 || reset == 11) ? CMD_AUTO_REFRESH : CMD_NOP;
		{2'bXX,    MODE_LDM, STATE_START}: {SDRAM_nRAS, SDRAM_nCAS, SDRAM_nWE} <= CMD_LOAD_MODE;
		{2'bXX,    MODE_PRE, STATE_START}: {SDRAM_nRAS, SDRAM_nCAS, SDRAM_nWE} <= CMD_PRECHARGE;

		                          default: {SDRAM_nRAS, SDRAM_nCAS, SDRAM_nWE} <= CMD_NOP;
	endcase

	if(mode == MODE_NORMAL) begin
		casex(state)
			STATE_IDLE: if(accept_request) SDRAM_A <= addr[13:1];
			STATE_CONT:  SDRAM_A <= {dqm, 2'b10, a[22:14]};
		endcase;
	end
	else if(mode == MODE_LDM && state == STATE_START) SDRAM_A <= MODE;
	else if(mode == MODE_PRE && state == STATE_START) SDRAM_A <= 13'b0010000000000;
	else SDRAM_A <= 0;
end

altddio_out
#(
	.extend_oe_disable("OFF"),
	.intended_device_family("Cyclone V"),
	.invert_output("OFF"),
	.lpm_hint("UNUSED"),
	.lpm_type("altddio_out"),
	.oe_reg("UNREGISTERED"),
	.power_up_high("OFF"),
	.width(1)
)
sdramclk_ddr
(
	.datain_h(1'b0),
	.datain_l(1'b1),
	.outclock(clk),
	.dataout(SDRAM_CLK),
	.aclr(1'b0),
	.aset(1'b0),
	.oe(1'b1),
	.outclocken(1'b1),
	.sclr(1'b0),
	.sset(1'b0)
);

endmodule
