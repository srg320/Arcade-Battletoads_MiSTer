// Close admitted R/F work before halting; resume with an F edge.
// The free-running clock/pixel generator and CPU EN are independent.
module bt_pause_bridge #(parameter DISPLAY_SERVICE_PAUSE = 0) (
    input wire clk, reset, pause_req,
    input wire raw_ce_f, raw_ce_r,
    output wire ce_f, ce_r, halted,
    input wire pause_ready
);
    reg halted_reg = 0;
    assign halted = halted_reg;
    assign ce_f = !reset && raw_ce_f && (!halted_reg || !pause_req);
    assign ce_r = !reset && raw_ce_r && !halted_reg;
    always @(posedge clk) begin
        if (reset) halted_reg <= 0;
        else if (halted_reg) begin
            if (!pause_req && raw_ce_f) halted_reg <= 0;
        end else if (pause_req && (DISPLAY_SERVICE_PAUSE ? (raw_ce_f && pause_ready) : raw_ce_r)) halted_reg <= 1;
    end
endmodule
