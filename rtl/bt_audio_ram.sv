// Z80 byte reads/writes and word-wide ROM loading share one write owner.
// ROM loading resets the Z80, so loader writes take priority during download.
module bt_audio_ram (
    input clock,
    input [14:0] load_addr,
    input [15:0] load_data,
    input load_we,
    input [15:0] cpu_addr,
    input [7:0] cpu_data,
    input cpu_we,
    output [7:0] cpu_q
);
    wire [14:0] write_addr = load_we ? load_addr : cpu_addr[15:1];
    wire [15:0] write_data = load_we ? load_data : {2{cpu_data}};
    wire we_low  = load_we || (cpu_we && !cpu_addr[0]);
    wire we_high = load_we || (cpu_we &&  cpu_addr[0]);
    wire [7:0] rom_low_q, rom_high_q, ram_low_q, ram_high_q;
    // Four 16Kx8 banks, each split 5+2+1 bits so the 5-bit part uses 2Kx5
    // M10K blocks (14 blocks per bank instead of 16). Contents start at zero,
    // reads are registered by address as before.
    bt_ram16k8 rom_low  (.clock(clock), .wa(write_addr[13:0]), .d(write_data[7:0]),  .we(we_low  && !write_addr[14]), .ra(cpu_addr[14:1]), .q(rom_low_q));
    bt_ram16k8 rom_high (.clock(clock), .wa(write_addr[13:0]), .d(write_data[15:8]), .we(we_high && !write_addr[14]), .ra(cpu_addr[14:1]), .q(rom_high_q));
    bt_ram16k8 low_byte (.clock(clock), .wa(write_addr[13:0]), .d(write_data[7:0]),  .we(we_low  &&  write_addr[14]), .ra(cpu_addr[14:1]), .q(ram_low_q));
    bt_ram16k8 high_byte(.clock(clock), .wa(write_addr[13:0]), .d(write_data[15:8]), .we(we_high &&  write_addr[14]), .ra(cpu_addr[14:1]), .q(ram_high_q));
    reg read_lane = 0;
    reg read_bank = 0;
    always @(posedge clock) begin
        read_lane <= cpu_addr[0];
        read_bank <= cpu_addr[15];
    end
    wire [15:0] read_word = read_bank ? {ram_high_q, ram_low_q} : {rom_high_q, rom_low_q};
    assign cpu_q = read_lane ? read_word[15:8] : read_word[7:0];
endmodule

// 16Kx8 simple dual-port RAM, registered read address, old data on a
// same-address read during write, zero initial contents.
module bt_ram16k8 (
    input clock,
    input [13:0] wa,
    input [7:0] d,
    input we,
    input [13:0] ra,
    output [7:0] q
);
    bt_ram16k_slice #(.W(5), .MAX_DEPTH(2048)) s5 (clock, wa, d[4:0], we, ra, q[4:0]);
    bt_ram16k_slice #(.W(2), .MAX_DEPTH(0))    s2 (clock, wa, d[6:5], we, ra, q[6:5]);
    bt_ram16k_slice #(.W(1), .MAX_DEPTH(0))    s1 (clock, wa, d[7],   we, ra, q[7]);
endmodule

module bt_ram16k_slice #(parameter W = 5, parameter MAX_DEPTH = 0) (
    input clock,
    input [13:0] wa,
    input [W-1:0] d,
    input we,
    input [13:0] ra,
    output [W-1:0] q
);
// synopsys translate_off
`define SIM
// synopsys translate_on
`ifdef SIM
    reg [W-1:0] mem [0:16383];
    reg [W-1:0] q_r;
    initial for (integer i = 0; i < 16384; i = i + 1) mem[i] = 0;
    always @(posedge clock) begin
        if (we) mem[wa] <= d;
        q_r <= mem[ra];
    end
    assign q = q_r;
`else
    altsyncram ram (
        .clock0(clock), .address_a(wa), .data_a(d), .wren_a(we), .address_b(ra), .q_b(q),
        .q_a(), .data_b({W{1'b1}}), .wren_b(1'b0), .byteena_a(1'b1), .byteena_b(1'b1),
        .aclr0(1'b0), .aclr1(1'b0), .addressstall_a(1'b0), .addressstall_b(1'b0), .clock1(1'b1),
        .clocken0(1'b1), .clocken1(1'b1), .clocken2(1'b1), .clocken3(1'b1), .eccstatus(),
        .rden_a(1'b1), .rden_b(1'b1));
    defparam
        ram.operation_mode = "DUAL_PORT",
        ram.width_a = W, ram.widthad_a = 14, ram.numwords_a = 16384,
        ram.width_b = W, ram.widthad_b = 14, ram.numwords_b = 16384,
        ram.address_reg_b = "CLOCK0", ram.outdata_reg_b = "UNREGISTERED",
        ram.rdcontrol_reg_b = "CLOCK0",
        ram.read_during_write_mode_mixed_ports = "OLD_DATA",
        ram.maximum_depth = MAX_DEPTH, ram.ram_block_type = "M10K",
        ram.clock_enable_input_a = "BYPASS", ram.clock_enable_input_b = "BYPASS",
        ram.clock_enable_output_b = "BYPASS", ram.power_up_uninitialized = "FALSE",
        ram.intended_device_family = "Cyclone V", ram.lpm_type = "altsyncram";
`endif
endmodule
