// DDR tag compare for the board address classes, restructured for logic depth.
//
// Only the tag of the bank the request addresses is ever consumed (the DDR
// controller gates every miss with cache==bank and only uses write_tag_hit of
// write_cache), and that bank is a function of the same region flags:
//   cache 0 = foreground / ROM / invalid, 1 = RAM, 2 = NVRAM, 3 = sprite.
// So each bank only evaluates the address class that can reach it, and the
// four-bank miss reduction is formed here from the region flags instead of in
// the controller. Required of the caller (asserted below in simulation):
//   * select_address is at most one-hot;
//   * a foreground/sprite/hole candidate (0..3) is only selected with EFG, and
//     candidate 4 is selected exactly when EFG is low.
// Tag keys are stable for >= 2 memory ticks before any use (bt_ddr_phase.sdc,
// asserted in native_sim.sv), so the address-independent part of the compare
// (the region prefix of each tag, the zero tag) is registered one tick behind
// the tag instead of being compared on the request path.
module bt_ddr_tag_compare (
    input clk,
    input [3:0][23:0] tags,
    input [4:0][22:0] addresses,
    input [4:0] select_address,
    input eram,efg,envram,espr,erom,
    // hit[b] is the original per-bank result whenever bank b is the addressed
    // cache bank; other banks are not used by the controller.
    output [3:0] hit,
    // The addressed bank's hit split in three; the read miss is !(|hit_part).
    output [2:0] hit_part
);
    // Tag prefix class of each bank: FG 0x10 (bank 0), RAM 0x04, NV 0x08, SPR 0x0c.
    reg [3:0] tag_class = 4'b0000;
    reg tag0_rom_prefix = 1'b0;   // tag[0][23:19]==0 (ROM class)
    reg tag0_zero = 1'b0;         // invalid-region sentinel
    always @(posedge clk) begin
        tag_class[0] <= tags[0][23:17]==7'h10;
        tag_class[1] <= tags[1][23:17]==7'h04;
        tag_class[2] <= tags[2][23:17]==7'h08;
        tag_class[3] <= tags[3][23:17]==7'h0c;
        tag0_rom_prefix <= tags[0][23:19]==5'd0;
        tag0_zero <= tags[0]==24'd0;
    end
    wire [4:0] s=select_address;
    // Addressed bank == ddr_addr[24:23] of the board's address map. The four
    // regions partition every EFG/ERAM/ENVRAM/ESPR/EROM combination.
    wire region_nv=!eram && !efg && envram;
    wire region_sp=!eram && !efg && !envram && espr;
    wire region_0=!eram && !region_nv && !region_sp;
    wire [4:0] low0,low1;
    genvar c;
    generate for(c=0;c<5;c=c+1) begin : cand
        assign low0[c]=tags[0][16:0]==addresses[c][20:4];
        assign low1[c]=tags[1][16:0]==addresses[c][20:4];
    end endgenerate
    wire low2=tags[2][16:0]==addresses[4][20:4];
    wire low3=tags[3][16:0]==addresses[4][20:4];
    wire rom_hit=low0[4] && tag0_rom_prefix && tags[0][18:17]==addresses[4][22:21];
    assign hit[0]=(tag_class[0] && ((s[0]&&low0[0]) || (s[1]&&low0[1]) ||
                                    (s[2]&&low0[2]) || (s[3]&&low0[3]))) ||
                  (s[4] && (erom ? rom_hit : tag0_zero));
    assign hit[1]=tag_class[1] && ((s[0]&&low1[0]) || (s[1]&&low1[1]) || (s[2]&&low1[2]) ||
                                   (s[3]&&low1[3]) || (s[4]&&low1[4]));
    assign hit[2]=tag_class[2] && s[4] && low2;
    assign hit[3]=tag_class[3] && s[4] && low3;
    // The addressed bank's hit as a sum of products in three groups, so the
    // controller adds only one small OR after the address compares: the region
    // and candidate gates are folded into each term's AND, no per-bank select
    // follows, and each group is at most four terms.
    (* keep = "true" *) wire hit_part0=
        (region_0 && tag_class[0] && ((s[0]&&low0[0]) || (s[1]&&low0[1]))) ||
        (eram && tag_class[1] && ((s[0]&&low1[0]) || (s[1]&&low1[1])));
    (* keep = "true" *) wire hit_part1=
        (region_0 && tag_class[0] && ((s[2]&&low0[2]) || (s[3]&&low0[3]))) ||
        (eram && tag_class[1] && ((s[2]&&low1[2]) || (s[3]&&low1[3])));
    (* keep = "true" *) wire hit_part2=
        (region_0 && s[4] && (erom ? rom_hit : tag0_zero)) ||
        (eram && tag_class[1] && s[4] && low1[4]) ||
        (region_nv && tag_class[2] && s[4] && low2) ||
        (region_sp && tag_class[3] && s[4] && low3);
    assign hit_part={hit_part2,hit_part1,hit_part0};
`ifndef SYNTHESIS
    always @(posedge clk) begin
        assert ($onehot0(select_address))
            else $fatal(1,"DDR tag compare: address candidates are not one-hot");
        assert (!(|select_address[3:0]) || efg)
            else $fatal(1,"DDR tag compare: candidate 0..3 selected without EFG");
        assert (!select_address[4] || !efg)
            else $fatal(1,"DDR tag compare: CPU candidate selected with EFG");
    end
`endif
endmodule
