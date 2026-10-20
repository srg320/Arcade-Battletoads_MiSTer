// Core-local ordinary 2x path derived from sys/scandoubler.v; upstream license below.
//
// scandoubler.v
// 
// Copyright (c) 2015 Till Harbaum <till@harbaum.org> 
// Copyright (c) 2017-2021 Alexey Melnikov
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

// TODO: Delay vsync one line

module bt_scandoubler #(parameter LENGTH, parameter HALF_DEPTH)
(
	// system interface
	input             clk_vid,
	input             hq2x,

	// shifter video interface
	input             ce_pix,
	input             hs_in,
	input             vs_in,
	input             hb_in,
	input             vb_in,
	input  [DWIDTH:0] r_in,
	input  [DWIDTH:0] g_in,
	input  [DWIDTH:0] b_in,

	// output interface
	output            ce_pix_out,
	output reg        hs_out,
	output            vs_out,
	output            hb_out,
	output            vb_out,
	output [DWIDTH:0] r_out,
	output [DWIDTH:0] g_out,
	output [DWIDTH:0] b_out
);

localparam DWIDTH = HALF_DEPTH ? 3 : 7;

reg  [7:0] pix_len = 0;
wire [7:0] pl = pix_len + 1'b1;

reg  [7:0] pix_in_cnt = 0;
wire [7:0] pc_in = pix_in_cnt + 1'b1;
reg  [7:0] pixsz, pixsz2, pixsz4 = 0;

reg ce_x4i, ce_x1i;
always @(posedge clk_vid) begin
	reg old_ce, valid, hs;

	if(~&pix_len) pix_len <= pl;
	if(~&pix_in_cnt) pix_in_cnt <= pc_in;

	ce_x4i <= 0;
	ce_x1i <= 0;

	// use such odd comparison to place ce_x4 evenly if master clock isn't multiple of 4.
	if((pc_in == pixsz4) || (pc_in == pixsz2) || (pc_in == (pixsz2+pixsz4))) ce_x4i <= 1;

	old_ce <= ce_pix;
	if(~old_ce & ce_pix) begin
		if(valid & ~hb_in & ~vb_in) begin
			pixsz  <= pl;
			pixsz2 <= {1'b0,  pl[7:1]};
			pixsz4 <= {2'b00, pl[7:2]};
		end
		pix_len <= 0;
		valid <= 1;
	end

	hs <= hs_in;
	if((~hs & hs_in) || (pc_in >= pixsz)) begin
		ce_x4i <= 1;
		ce_x1i <= 1;
		pix_in_cnt <= 0;
	end

	if(hb_in | vb_in) valid <= 0;
end

reg req_line_reset;
reg [DWIDTH:0] r_d, g_d, b_d;
always @(posedge clk_vid) begin
	if(ce_x1i) begin
		req_line_reset <= hb_in;
		r_d <= r_in;
		g_d <= g_in;
		b_d <= b_in;
	end
end

bt_sd_pixels #(.LENGTH(LENGTH), .HALF_DEPTH(HALF_DEPTH)) pixels
(
	.clk(clk_vid),

	.ce_in(ce_x4i),
	.inputpixel({b_d,g_d,r_d}),
	.reset_frame(vb_in),
	.reset_line(req_line_reset),

	.ce_out(ce_x4o),
	.read_y(sd_line),
	.hblank(hbo[0]&hbo[8]),
	.outpixel({b_out,g_out,r_out})
);

reg  [7:0] pix_out_cnt = 0;
wire [7:0] pc_out = pix_out_cnt + 1'b1;

reg ce_x4o, ce_x2o;
always @(posedge clk_vid) begin
	reg hs;

	if(~&pix_out_cnt) pix_out_cnt <= pc_out;

	ce_x4o <= 0;
	ce_x2o <= 0;

	// use such odd comparison to place ce_x4 evenly if master clock isn't multiple of 4.
	if((pc_out == pixsz4) || (pc_out == pixsz2) || (pc_out == (pixsz2+pixsz4))) ce_x4o <= 1;
	if( pc_out == pixsz2) ce_x2o <= 1;

	hs <= hs_out;
	if((~hs & hs_out) || (pc_out >= pixsz)) begin
		ce_x2o <= 1;
		ce_x4o <= 1;
		pix_out_cnt <= 0;
	end
end

reg [1:0] sd_line;
reg [3:0] vbo;
reg [3:0] vso;
reg [8:0] hbo;
always @(posedge clk_vid) begin

	reg [31:0] hcnt;
	reg [30:0] sd_hcnt;
	reg [30:0] hs_start, hs_end;
	reg [30:0] hde_start, hde_end;

	reg hs, hb;

	if(ce_x4o) begin
		hbo[8:1] <= hbo[7:0];
	end

	// output counter synchronous to input and at twice the rate
	sd_hcnt <= sd_hcnt + 1'd1;
	if(sd_hcnt == hde_start) begin
		sd_hcnt <= 0;
		vbo[3:1] <= vbo[2:0];
	end

	if(sd_hcnt == hs_end) begin
		sd_line <= sd_line + 1'd1;
		if(&vbo[3:2]) sd_line <= 1;
		vso[3:1] <= vso[2:0];
	end

	if(sd_hcnt == hde_start)hbo[0] <= 0;
	if(sd_hcnt == hde_end)  hbo[0] <= 1;

	// replicate horizontal sync at twice the speed
	if(sd_hcnt == hs_end)   hs_out <= 0;
	if(sd_hcnt == hs_start) hs_out <= 1;

	hs <= hs_in;
	hb <= hb_in;

	hcnt <= hcnt + 1'd1;
	if(hb && !hb_in) begin
		hde_start <= hcnt[31:1];
		hbo[0] <= 0;
		hcnt <= 0;
		sd_hcnt <= 0;
		vbo <= {vbo[2:0],vb_in};
	end

	if(!hb && hb_in) hde_end <= hcnt[31:1];

	// falling edge of hsync indicates start of line
	if(hs && !hs_in) begin
		hs_end <= hcnt[31:1];
		vso[0] <= vs_in;
	end

	// save position of rising edge
	if(!hs && hs_in) hs_start <= hcnt[31:1];
end

assign vs_out = vso[3];
assign ce_pix_out = hq2x ? ce_x4o : ce_x2o;

//Compensate picture shift after HQ2x
assign vb_out = vbo[3];
assign hb_out = hbo[6];

endmodule

// Ordinary pixel backend derived from sys/hq2x.sv:
// Copyright (c) 2012-2013 Ludvig Strigeus; Copyright (c) 2017,2018 Sorgelig.
// GPL licensed, see COPYING. The input and output line banks retain the bank
// cadence and four CE pipeline stages. With HQ2x disabled, Blend returns
// Curr0 unchanged and all four pixels in each output word are identical.
// Store one native pixel instead of a 2x2 block. Keeping both pairs of line
// banks avoids a read/write overlap when the raster is repeating a line.
module bt_sd_pixels #(parameter LENGTH, parameter HALF_DEPTH)
(
	input clk, ce_in,
	input [HALF_DEPTH ? 11 : 23:0] inputpixel,
	input reset_frame, reset_line,
	input ce_out,
	input [1:0] read_y,
	input hblank,
	output [HALF_DEPTH ? 11 : 23:0] outpixel
);
localparam AWIDTH = $clog2(LENGTH)-1;
localparam DWIDTH = HALF_DEPTH ? 11 : 23;
reg [1:0] cyc;
reg curbuf;
wire iobuf = !curbuf;
reg [AWIDTH:0] offs, wrin_addr;
reg [DWIDTH:0] wrpix;
reg wrin_en;
wire [DWIDTH:0] in0, in1;
wire [DWIDTH:0] curpixel = curbuf ? in1 : in0;

bt_sd_ram #(.NUMWORDS(LENGTH), .AWIDTH(AWIDTH), .DWIDTH(DWIDTH)) in_bank0
  (clk, wrpix, offs, wrin_addr, wrin_en && !iobuf, in0);
bt_sd_ram #(.NUMWORDS(LENGTH), .AWIDTH(AWIDTH), .DWIDTH(DWIDTH)) in_bank1
  (clk, wrpix, offs, wrin_addr, wrin_en && iobuf, in1);

reg [DWIDTH:0] curr0, curr1, curr2;
reg [DWIDTH:0] copy0, copy1, copy2, copy3;
always @(posedge clk) if (ce_in) begin
	copy0 <= curr0;
	copy1 <= copy0;
	copy2 <= copy1;
	copy3 <= copy2;
end

reg [AWIDTH+1:0] read_x, wrout_addr;
reg wrout_en;
reg [DWIDTH:0] wrdata;
wire [DWIDTH:0] rddata;
reg [DWIDTH:0] pixel_hold;
bt_sd_ram #(.NUMWORDS(LENGTH*2), .AWIDTH(AWIDTH+1), .DWIDTH(DWIDTH)) out_banks
  (clk, wrdata, {read_x[AWIDTH+1:1],read_y[1]}, wrout_addr, wrout_en, rddata);
assign outpixel = pixel_hold;
always @(posedge clk) if (ce_out) begin
	if(read_x[0]) pixel_hold <= rddata;
	if(~hblank & ~&read_x) read_x <= read_x + 1'd1;
	if(hblank) read_x <= 0;
end

always @(posedge clk) begin
	reg old_reset_line;
	reg old_reset_frame;
	reg [3:0] wrdata_finished;
	reg [AWIDTH+1:0] waddr;
	wrout_en <= 0;
	wrin_en <= 0;
	if(ce_in) begin
		if(cyc == 0) wrdata <= copy3;
		wrdata_finished <= wrdata_finished << 1;
		if(wrdata_finished[3]) begin
			wrout_en <= 1;
			wrout_addr <= waddr;
		end
		if(~&offs) begin
			if(cyc == 1) begin
				curr2 <= curpixel;
				wrpix <= inputpixel;
				wrin_addr <= offs;
				wrin_en <= 1;
			end
			if(cyc == 3) begin
				offs <= offs + 1'd1;
				waddr <= {offs,curbuf};
				wrdata_finished[0] <= 1;
			end
		end
		if(cyc == 3) begin
			curr0 <= curr1;
			curr1 <= curr2;
		end
		cyc <= cyc + 1'b1;
		if(old_reset_line && ~reset_line) begin
			old_reset_frame <= reset_frame;
			offs <= 0;
			cyc <= 0;
			curbuf <= ~curbuf;
			{curr0,curr1,curr2} <= '0;
			if(old_reset_frame & ~reset_frame) curbuf <= 0;
		end
		old_reset_line <= reset_line;
	end
end
endmodule

// Derived from the existing sys/hq2x.sv hq2x_buf memory contract. The small
// tail retains its delayed commit/forwarding for old-data read collisions.
module bt_sd_ram #(parameter NUMWORDS, parameter AWIDTH, parameter DWIDTH)
(
	input clock,
	input [DWIDTH:0] data,
	input [AWIDTH:0] rdaddress, wraddress,
	input wren,
	output [DWIDTH:0] q
);
localparam MAIN = 1 << ($clog2(NUMWORDS+1)-1);
localparam TAIL = NUMWORDS - MAIN;
localparam MBITS = $clog2(MAIN);
generate if(TAIL == 0) begin : single
	reg [DWIDTH:0] ram[0:NUMWORDS-1];
	reg [DWIDTH:0] q_r;
	always @(posedge clock) begin
		if(wren) ram[wraddress] <= data;
		q_r <= ram[rdaddress];
	end
	assign q = q_r;
end else begin : split
	reg [DWIDTH:0] ram[0:MAIN-1];
	(* ramstyle = "MLAB" *) reg [DWIDTH:0] tail[0:TAIL-1];
	reg [DWIDTH:0] q_main, q_tail;
	reg q_sel, tail_we=0;
	reg [AWIDTH:0] tail_wa;
	reg [DWIDTH:0] tail_data;
	wire wr_tail = wraddress >= MAIN;
	wire rd_tail = rdaddress >= MAIN;
	wire [AWIDTH:0] tail_ra = rdaddress - MAIN;
	always @(posedge clock) begin
		if(wren && !wr_tail) ram[wraddress[MBITS-1:0]] <= data;
		q_main <= ram[rdaddress[MBITS-1:0]];
	end
	always @(posedge clock) begin
		if(tail_we) tail[tail_wa] <= tail_data;
		q_tail <= tail_we && tail_wa == tail_ra ? tail_data : tail[tail_ra];
		tail_we <= wren && wr_tail;
		tail_wa <= wraddress - MAIN;
		tail_data <= data;
		q_sel <= rd_tail;
	end
	assign q = q_sel ? q_tail : q_main;
end endgenerate
endmodule

