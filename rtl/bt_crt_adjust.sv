// SPDX-License-Identifier: GPL-3.0-or-later
// Battletoads glue for the core-side crt_adjust line buffer (rmonic79).
// Native raster (TMS34020 program, MAME-measured): 80 MHz / 8 = 10 MHz pixels,
// HTOTAL 640 (HS 0..31, active 96..607 = 512 px), VTOTAL 257.
// A 512-px line in a 640-px raster leaves no room to enlarge, so H-Size only
// shrinks (read period 8/7/6 clocks); each size is auto-centred and the OSD
// H-Position (-16..+15 read pixels) is added on top. Worst read window end:
// (608+117+15)*6=4440, (608+50+15)*7=4711, (608+15)*8=4984 <= 5120 clocks.
// Off = the original signals pass straight through, untouched.
module bt_crt_adjust (
	input             clk,
	input             available,      // no scandoubler on this path
	input             enable,         // OSD CRT Adjust On
	input       [1:0] hsize_sel,      // 0: 0, 1: -1, 2: -2 (3 treated as 0)
	input  signed [6:0] hposition,
	input  signed [4:0] vposition,
	input             ce_in,
	input       [7:0] r_in, g_in, b_in,
	input             hs_in, vs_in, hb_in, vb_in, // positive pulses
	output            ce_out,
	output      [7:0] r_out, g_out, b_out,
	output            hs_out, vs_out, hb_out, vb_out
);
	// Settings change only at the start of vertical blanking.
	reg vb_old = 1'b0;
	reg request_q = 1'b0;
	reg [2:0] last_count = 3'd7;       // read period - 1
	reg signed [8:0] hoffset_q = 9'sd0;
	reg signed [5:0] voffset_q = 6'sd0;
	always @(posedge clk) begin
		if (ce_in) vb_old <= vb_in;
		if (ce_in && vb_in && !vb_old) begin
			request_q <= available && enable;
			case (hsize_sel)
				2'd1: begin last_count <= 3'd6; hoffset_q <= 9'sd50  + 9'(hposition); end
				2'd2: begin last_count <= 3'd5; hoffset_q <= 9'sd117 + 9'(hposition); end
				default: begin last_count <= 3'd7; hoffset_q <= 9'(hposition); end
			endcase
			voffset_q <= 6'(vposition);
		end
		if (!available) request_q <= 1'b0;
	end

	// Fixed integer read period restarted on the HSync reference rise.
	wire hs_reference;
	reg hs_reference_old = 1'b0;
	reg [2:0] read_counter = 3'd0;
	reg read_ce = 1'b0;
	always @(posedge clk) begin
		hs_reference_old <= hs_reference;
		if (!request_q || (hs_reference && !hs_reference_old)) begin
			read_counter <= 3'd0;
			read_ce <= 1'b0;
		end else begin
			read_counter <= (read_counter == last_count) ? 3'd0 : read_counter + 3'd1;
			read_ce <= read_counter == last_count - 3'd1;
		end
	end

	wire [7:0] ar, ag, ab;
	wire ahs, avs, ahb, avb;
	crt_adjust #(.VTOTAL(257), .HTOTAL(640), .HPOS_MODE(1), .SEPARATE_BLANK(0)) donor (
		.clk(clk), .pxl_cen(ce_in), .pxl2_cen(read_ce), .active(request_q),
		.hsize(5'sd0), .hoffset(hoffset_q), .voffset(voffset_q),
		.r_in(r_in), .g_in(g_in), .b_in(b_in),
		.hs_in(hs_in), .vs_in(vs_in), .hb_in(hb_in), .vb_in(vb_in),
		.r_out(ar), .g_out(ag), .b_out(ab),
		.hs_out(ahs), .vs_out(avs), .hb_out(ahb), .vb_out(avb),
		.hs_ref_out(hs_reference));

	assign ce_out = request_q ? read_ce : ce_in;
	assign {r_out, g_out, b_out} = request_q ? {ar, ag, ab} : {r_in, g_in, b_in};
	assign {hs_out, vs_out, hb_out, vb_out} = request_q ? {ahs, avs, ahb, avb} : {hs_in, vs_in, hb_in, vb_in};
endmodule
