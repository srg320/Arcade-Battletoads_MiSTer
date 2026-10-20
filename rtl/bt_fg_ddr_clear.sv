// Initialize all foreground bytes outside the on-chip 256-column display area.
// The loader and this client share the existing DDR I/O write port.
module bt_fg_ddr_clear (
    input  wire        clk,
    input  wire        init_n,
    input  wire        io_busy,
    output wire [27:1] io_addr,
    output wire [3:0]  io_we,
    output reg         ready
);
    reg [17:0] pair;
    reg waiting;
    // Each logical byte occupies the low byte of a TMS sixteen-bit slot.
    // Skip the visible quarter of each row; page/row/pair match BT's EADDR.
    wire [27:0] byte_addr = 28'h2000000 |
        {8'b0,pair[17],pair[16:9],pair[8:0],2'b00};
    assign io_addr = byte_addr[27:1];
    assign io_we = init_n && !ready && !waiting && !io_busy && (|pair[8:7]) ? 4'hf : 4'h0;
    always @(posedge clk or negedge init_n) begin
        if (!init_n) begin
            pair <= 0;
            waiting <= 0;
            ready <= 0;
        end else if (!ready) begin
            if (!waiting) begin
                if (!io_busy) begin
                    if (|pair[8:7]) waiting <= 1;
                    else pair <= pair + 18'd1;
                end
            end else if (!io_busy) begin
                waiting <= 0;
                if (&pair) ready <= 1;
                else pair <= pair + 18'd1;
            end
        end
    end
endmodule
