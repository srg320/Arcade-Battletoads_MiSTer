// Battery-backed 8 KiB, one byte per TMS34020 32-bit word (MAME btoads.cpp).
// The MiSTer WIDE ioctl port packs two consecutive NVRAM bytes per transfer.
module bt_nvram(
    input clk, new_game, osd_open,
    input [12:0] cpu_addr,
    input [7:0] cpu_data,
    input cpu_we,
    output [7:0] cpu_q,
    output cpu_ready,
    input ioctl_download, ioctl_upload, ioctl_wr,
    input [15:0] ioctl_index,
    input [26:0] ioctl_addr,
    input [15:0] ioctl_dout,
    output [15:0] ioctl_din,
    output reg upload_req = 0,
    output pause_cpu,
    input cpu_halted
);
    (* ramstyle = "M10K" *) reg [15:0] ram [0:4095];
    reg [15:0] read_word_q;
    reg cpu_lane;
    reg initializing = 1;
    reg [11:0] clear_addr = 0;
    reg dirty = 0, save_pending = 0, save_issued = 0;
    reg old_game = 0, old_osd = 0, old_upload = 0;
    wire selected = ioctl_index == 16'd4;
    wire restoring = selected && ioctl_download;
    wire uploading = selected && ioctl_upload;
    // A save request waits for the final admitted R write to complete.
    // Physical port owners and an acknowledged halt still exclude CPU writes.
    wire cpu_write = cpu_we && !initializing && !restoring && !uploading && !cpu_halted;
    // CPU writes, restore and initialization share one physical write port.
    // Upload pauses the CPU and borrows its registered read port.
    wire [11:0] write_addr = initializing ? clear_addr :
                              restoring ? ioctl_addr[12:1] : cpu_addr[12:1];
    wire [15:0] write_data = initializing ? 16'd0 :
                              restoring ? ioctl_dout : {2{cpu_data}};
    wire [1:0] write_be = initializing ? 2'b11 :
                         restoring ? ((ioctl_wr && ioctl_addr < 8192) ? 2'b11 : 2'b00) :
                         cpu_write ? (cpu_addr[0] ? 2'b10 : 2'b01) : 2'b00;
    wire [11:0] ram_read_addr = uploading ? ioctl_addr[12:1] : cpu_addr[12:1];
    reg [12:0] read_addr = 0;
    reg read_valid = 0;
    assign cpu_ready = read_valid && read_addr == cpu_addr &&
                       !initializing && !restoring && !uploading;
    assign pause_cpu = initializing || restoring || uploading || save_pending;
    assign cpu_q = cpu_lane ? read_word_q[15:8] : read_word_q[7:0];
    assign ioctl_din = read_word_q;

    // Read a complete word before selecting its byte. A dynamic byte select
    // on the memory read prevents Quartus from recognizing the RAM port.
    always @(posedge clk) begin
        // Upload pauses the CPU. One physical read port can serve both users.
        read_word_q <= ram[ram_read_addr];
        cpu_lane <= cpu_addr[0];
    end

    // A single write port and shared registered read avoid RAM duplication.
    always @(posedge clk) begin
        if (write_be[0]) ram[write_addr][7:0] <= write_data[7:0];
        if (write_be[1]) ram[write_addr][15:8] <= write_data[15:8];
    end

    always @(posedge clk) begin
        read_addr <= cpu_addr;
        read_valid <= !initializing && !restoring && !uploading;
        old_game <= new_game;
        old_osd <= osd_open;
        old_upload <= uploading;
        upload_req <= 0;
        if (new_game && !old_game) begin
            initializing <= 1;
            clear_addr <= 0;
            dirty <= 0;
            save_pending <= 0;
            save_issued <= 0;
        end else if (initializing) begin
            clear_addr <= clear_addr + 12'd1;
            if (&clear_addr) initializing <= 0;
        end else begin
            if (cpu_write) dirty <= 1;
            if (restoring) dirty <= 0;
            // Capture the event even when still clean: the closing R write
            // can make RAM dirty after the OSD opens but before halt settles.
            if (osd_open && !old_osd && !restoring && !save_pending) begin
                save_pending <= 1;
                save_issued <= 0;
            end
            // The closing R write has settled before this acknowledgement.
            // Never issue again for the same request or during port ownership.
            if (save_pending && cpu_halted && !save_issued &&
                !restoring && !uploading && !old_upload) begin
                if (dirty) begin
                    upload_req <= 1;
                    save_issued <= 1;
                end else begin
                    // No closing write occurred, so release this clean save.
                    save_pending <= 0;
                end
            end
            if (old_upload && !uploading) begin
                dirty <= 0;
                save_pending <= 0;
                save_issued <= 0;
            end
        end
    end
endmodule
