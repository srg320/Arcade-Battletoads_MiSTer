// index 0: 8 MiB maincpu, 2 MiB samples, 32 KiB audiocpu.
module bt_rom_loader
(
	input             clk,
	input             ioctl_download,
	input      [15:0] ioctl_index,
	input      [26:0] ioctl_addr,
	input      [15:0] ioctl_dout,
	input             ioctl_wr,
	output reg        ioctl_wait = 0,
	input             ddr_busy,
	input             sdr_busy,
	output            downloading,
	output reg        ready = 0,
	output reg [27:1] ddr_addr = 0,
	output reg [3:0]  ddr_we = 0,
	output reg [24:0] sample_addr = 0,
	output reg        sample_we = 0,
	output reg [14:0] audio_addr = 0,
	output reg        audio_we = 0,
	output reg [15:0] data = 0
);
	localparam [26:0] SAMPLE_BASE = 27'h0800000;
	localparam [26:0] AUDIO_BASE  = 27'h0a00000;
	localparam [26:0] ROM_END     = 27'h0a08000;

	assign downloading = ioctl_download && ioctl_index == 16'd0;
	reg download_old = 0;
	reg [26:0] next_addr = 0;
	reg load_error = 0;
	reg finish_pending = 0;
	reg pending_sample = 0;
	reg sample_issue_pending = 0;
	reg busy_seen = 0;
	wire memory_busy = pending_sample ? sdr_busy : ddr_busy;

	always @(posedge clk) begin
		download_old <= downloading;
		ddr_we <= 0;
		sample_we <= 0;
		audio_we <= 0;

		if (downloading && !download_old) begin
			ready <= 0;
			next_addr <= 0;
			load_error <= 0;
			finish_pending <= 0;
		end

		// Busy must rise before it falls: idle before acceptance is not an ACK.
		if (ioctl_wait) begin
			if (pending_sample && sample_issue_pending) begin
				// An autonomous refresh may already own SDRAM. Launch the
				// captured write only after it is idle; refresh is not its ACK.
				if (!sdr_busy) begin
					sample_we <= 1;
					sample_issue_pending <= 0;
					busy_seen <= 0;
				end
			end else begin
				if (memory_busy) busy_seen <= 1;
				if (busy_seen && !memory_busy) begin
					ioctl_wait <= 0;
					busy_seen <= 0;
				end
			end
		end

		if (downloading && ioctl_wr && !ioctl_wait) begin
			if (ioctl_addr != (download_old ? next_addr : 27'd0) ||
			    ioctl_addr[0] || ioctl_addr >= ROM_END) load_error <= 1;
			next_addr <= ioctl_addr + 27'd2;
			data <= ioctl_dout;
			if (ioctl_addr < SAMPLE_BASE) begin
				ddr_addr <= {1'b0, ioctl_addr[26:1]};
				ddr_we <= ioctl_addr[1] ? 4'b1100 : 4'b0011;
				ioctl_wait <= 1;
				pending_sample <= 0;
				busy_seen <= 0;
			end else if (ioctl_addr < AUDIO_BASE) begin
				sample_addr <= {4'b0000, ioctl_addr[20:0]};
				sample_issue_pending <= 1;
				ioctl_wait <= 1;
				pending_sample <= 1;
				busy_seen <= 0;
			end else if (ioctl_addr < ROM_END) begin
				audio_addr <= {1'b0, ioctl_addr[14:1]};
				audio_we <= 1;
			end
		end

		if (!downloading && download_old) finish_pending <= 1;
		if (finish_pending && !downloading && !ioctl_wait && !ddr_busy && !sdr_busy) begin
			ready <= !load_error && next_addr == ROM_END;
			finish_pending <= 0;
		end
	end
endmodule
