// 80 MHz system clock: steady 10 MHz pixels, original 32 MHz CPU phases.
module bt_clock_enables(input clk, reset, output ce_f, ce_r, vce);
    reg [2:0] cpu_slot = 0;
    reg cpu_phase = 0;
    reg [2:0] pixel_slot = 0;
    wire cpu_tick = cpu_slot != 0;
    wire [2:0] cpu_slot_next = cpu_slot == 4 ? 3'd0 : cpu_slot + 3'd1;
    wire cpu_phase_next = cpu_tick ? ~cpu_phase : cpu_phase;
    (* preserve, dont_merge *) reg cpu_ce_f = 0, cpu_ce_r = 0;
    assign ce_f = !reset && cpu_ce_f;
    assign ce_r = !reset && cpu_ce_r;
    assign vce = !reset && pixel_slot == 7;
    always @(posedge clk) begin
        if (reset) begin
            cpu_slot <= 0;
            cpu_phase <= 0;
            cpu_ce_f <= 0;
            cpu_ce_r <= 0;
            pixel_slot <= 0;
        end else begin
            cpu_slot <= cpu_slot_next;
            cpu_phase <= cpu_phase_next;
            cpu_ce_f <= cpu_slot_next != 0 && !cpu_phase_next;
            cpu_ce_r <= cpu_slot_next != 0 && cpu_phase_next;
            pixel_slot <= pixel_slot + 3'd1;
        end
    end
endmodule
