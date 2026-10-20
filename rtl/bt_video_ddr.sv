// Memory-only Avalon command/skid register slice toward the HPS DDR port.
// The rotation ports remain for wrapper compatibility; they have no logic.
module bt_video_ddr(
    input reset, video_clk, mem_clk,
    input rot_we,
    input [28:0] rot_addr,
    input [63:0] rot_data,
    input [7:0] rot_be,
    input [7:0] mem_burst,
    input [28:0] mem_addr,
    input [63:0] mem_data,
    input [7:0] mem_be,
    input mem_we, mem_rd,
    input ddr_busy,
    output mem_busy,
    output [7:0] ddr_burst,
    output [28:0] ddr_addr,
    output [63:0] ddr_data,
    output [7:0] ddr_be,
    output ddr_we, ddr_rd
);
    // Preserve the original one-cycle reset delay at the memory boundary.
    reg fifo_reset=1'b1;
    always @(posedge mem_clk) fifo_reset<=reset;
    // Avalon register slice toward the HPS port: registered command outputs,
    // registered wait-request upstream, full throughput via a skid register.
    // A presented command is held unchanged while ddr_busy is high.
    localparam CW = 1+1+8+29+64+8;
    reg  [CW-1:0] d_cmd = '0, s_cmd = '0;
    reg d_valid = 1'b0, s_valid = 1'b0;
    assign mem_busy = s_valid;
    wire accept = (mem_we || mem_rd) && !s_valid;
    wire [CW-1:0] mem_payload = {mem_we,mem_rd,mem_burst,mem_addr,mem_data,mem_be};
    wire open_slot = !d_valid || !ddr_busy;
    // The HPS wait-request is late and open_slot enables all of d_cmd: four
    // same-cycle d_valid copies give four independent enable LUTs. An open
    // slot loads the offered command unconditionally (d_valid says whether it
    // is real), keeping payload selection independent of the late busy input.
    (* preserve, dont_merge *) reg [3:0] d_valid_k = 4'b0;
    wire [3:0] open_k = ~d_valid_k | {4{~ddr_busy}};
    // The HPS wait-request arrives late (hard-block output delay), so it only
    // gates the flop enable; the next command is selected independently of it.
    wire have_next = !fifo_reset && (s_valid || mem_we || mem_rd);
    wire [CW-1:0] next_cmd = s_valid ? s_cmd : mem_payload;
    always @(posedge mem_clk) begin
        for (integer i = 0; i < CW; i = i + 1)
            if (open_k[i/28])
                d_cmd[i] <= next_cmd[i];
        // The skid word is loaded whenever it is free and a command is offered,
        // independent of the HPS wait-request; it only matters while s_valid.
        if (!s_valid && have_next)
            s_cmd <= mem_payload;
    end
    always @(posedge mem_clk) begin
        if (fifo_reset) begin
            d_valid <= 1'b0;
            d_valid_k <= 4'b0;
            s_valid <= 1'b0;
        end else if (!d_valid || !ddr_busy) begin
            if (s_valid) begin
                d_valid <= 1'b1; d_valid_k <= 4'hf; s_valid <= 1'b0;
            end else if (accept) begin
                d_valid <= 1'b1; d_valid_k <= 4'hf;
            end else begin
                d_valid <= 1'b0; d_valid_k <= 4'b0;
            end
        end else if (accept) begin
            s_valid <= 1'b1;
        end
    end
    assign ddr_we    = d_valid && d_cmd[CW-1];
    assign ddr_rd    = d_valid && d_cmd[CW-2];
    assign ddr_burst = d_cmd[CW-3 -: 8];
    assign ddr_addr  = d_cmd[CW-11 -: 29];
    assign ddr_data  = d_cmd[CW-40 -: 64];
    assign ddr_be    = d_cmd[7:0];
endmodule
