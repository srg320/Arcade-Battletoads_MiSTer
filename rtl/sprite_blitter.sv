// Battletoads bitmap sprite row producer. The A4 and A8 shift reads latch
// independent cursors; AC writes use those cursors, not the write address.
module BT_SPRITE_BLITTER #(parameter NONZERO_PREDECODE=0) (
    input CLK, RST_N, CE_R,
    input [31:0] A,
    input RAS_N, WE_N, OE_N, SHIFT,
    input [15:0] CONTROL, SOURCE_SCALE, DEST_SCALE,
    input SHADOW, DEST_PAGE,
    input DRAW_READY,
    output [8:0] SOURCE_WORD,
    input [15:0] SOURCE_DATA,
    output reg DRAW_WE,
    output reg [16:0] DRAW_ADDR,
    output reg [7:0] DRAW_DATA,
    output reg DRAW_PAGE,
    (* maxfan = 8, preserve *) output reg [1:0] DRAW_PAGE_WE,
    (* maxfan = 8, preserve *) output reg [1:0][15:0] DRAW_BANK_WE, DRAW_RAM_BANK_WE,
    output BUSY,
    input [3:0] SOURCE_NONZERO
);
    reg ras_old;
    reg exec;
    reg [15:0] source_offset, dest_offset;
    reg [7:0] dest_row;
    reg [24:0] source_cursor, source_end;
    reg [23:0] dest_cursor;
    wire [9:0] width = {1'b0,~CONTROL[8:0]} + 10'd2;
    wire signed [16:0] source_step = 17'sh00100 - $signed({1'b0,SOURCE_SCALE});
    wire signed [16:0] dest_step = 17'sh00100 - $signed({1'b0,DEST_SCALE});
    wire [24:0] source_next = source_cursor + {{8{source_step[16]}},source_step};
    wire [23:0] dest_next = dest_cursor + {{7{dest_step[16]}},dest_step};
    wire [1:0] nibble = source_cursor[9:8] ^ {2{CONTROL[10]}};
    wire [3:0] color = (SOURCE_DATA >> {nibble,2'b00}) & 4'hf;
    wire color_valid=NONZERO_PREDECODE ? SOURCE_NONZERO[nibble] : |color;
    wire [31:0] address = A & 32'hbfffffff;
    assign SOURCE_WORD = source_cursor[18:10];
    assign BUSY = exec | DRAW_WE;
    // Same-edge copies of the page-qualified draw strobe. Keep the page
    // decode off the short SYS-to-MEM path into foreground VRAM.
    wire load_page = !RAS_N && ras_old && !OE_N && SHIFT && WE_N && address[31:26] == 6'b101001;
    wire page_next = load_page ? DEST_PAGE : DRAW_PAGE;
    wire draw_next = exec && CE_R && (!DRAW_WE || DRAW_READY) ? color_valid : DRAW_WE && !DRAW_READY;
    wire emit_pixel = exec && CE_R && (!DRAW_WE || DRAW_READY);
    wire [3:0] bank_next = emit_pixel ? dest_row[7:4] : DRAW_ADDR[16:13];
    wire hole_next = emit_pixel ? dest_cursor[16] : DRAW_ADDR[8];
    // SOURCE_NONZERO arrives from the 160 MHz sprite RAM; color_valid is the only
    // late term. Every strobe is (emit-side early select & color_valid) | hold-side
    // early select, so the late bit sees one AND-OR instead of the whole decode.
    wire hold_pixel = !emit_pixel && DRAW_WE && !DRAW_READY;
    always @(posedge CLK or negedge RST_N) begin
        if (!RST_N) DRAW_PAGE_WE <= 0;
        else begin
            DRAW_PAGE_WE[0] <= (emit_pixel && color_valid && !page_next) || (hold_pixel && !page_next);
            DRAW_PAGE_WE[1] <= (emit_pixel && color_valid &&  page_next) || (hold_pixel &&  page_next);
        end
    end
    // Local page/group predicates each feed four bank strobes and four RAM
    // strobes. Keep the shared draw qualifier off the long route to all 64
    // bank registers without adding a clock or changing an emission edge.
    genvar page, group;
    generate
        for (page=0;page<2;page=page+1) begin : draw_page_group
            for (group=0;group<4;group=group+1) begin : draw_bank_group
                (* keep *) wire emit_group = emit_pixel && page_next==page && dest_row[7:6]==group;
                (* keep *) wire hold_group = hold_pixel && page_next==page && DRAW_ADDR[16:15]==group;
                always @(posedge CLK or negedge RST_N) begin
                    if (!RST_N) begin
                        DRAW_BANK_WE[page][group*4 +: 4] <= 0;
                        DRAW_RAM_BANK_WE[page][group*4 +: 4] <= 0;
                    end else begin
                        for (integer bank=0;bank<4;bank=bank+1) begin
                            DRAW_BANK_WE[page][group*4+bank] <=
                                (emit_group && dest_row[5:4]==bank && color_valid) ||
                                (hold_group && DRAW_ADDR[14:13]==bank);
                            DRAW_RAM_BANK_WE[page][group*4+bank] <=
                                (emit_group && dest_row[5:4]==bank && !dest_cursor[16] && color_valid) ||
                                (hold_group && DRAW_ADDR[14:13]==bank && !DRAW_ADDR[8]);
                        end
                    end
                end
            end
        end
    endgenerate
`ifdef MISTER_CPU_PHASE_CHECK
    always @(negedge CLK)
        if (RST_N) assert (DRAW_PAGE_WE == ({2{DRAW_WE}} & {DRAW_PAGE,!DRAW_PAGE}))
            else $fatal(1,"Page draw strobe changed transfer timing");
`endif


    always @(posedge CLK or negedge RST_N) begin
        if (!RST_N) begin
            ras_old <= 1;
            exec <= 0;
            source_offset <= 0;
            dest_offset <= 0;
            dest_row <= 0;
            DRAW_PAGE <= 0;
            source_cursor <= 0;
            source_end <= 0;
            dest_cursor <= 0;
            DRAW_WE <= 0;
            DRAW_ADDR <= 0;
            DRAW_DATA <= 0;
        end else begin
            ras_old <= RAS_N;
            DRAW_WE <= DRAW_WE && !DRAW_READY;
            if (!RAS_N && ras_old && !OE_N && SHIFT) begin
                if (WE_N && address[31:26] == 6'b101001) begin
                    dest_row <= address[21:14];
                    DRAW_PAGE <= DEST_PAGE;
                    dest_offset <= {7'b0,address[13:5]};
                end
                if (WE_N && address[31:26] == 6'b101010)
                    source_offset <= {5'b0,address[13:3]};
                if (!WE_N && address[31:26] == 6'b101011) begin
                    source_cursor <= {1'b0,source_offset,8'b0};
                    source_end <= {1'b0,source_offset,8'b0} + {7'b0,width,8'b0};
                    dest_cursor <= {dest_offset,8'b0};
                    exec <= 1;
                end
            end
            if (exec && CE_R && (!DRAW_WE || DRAW_READY)) begin
                DRAW_ADDR <= {dest_row,dest_cursor[16:8]};
                DRAW_DATA <= {~CONTROL[15:12],color & {4{!SHADOW}}};
                DRAW_WE <= color_valid;
                source_cursor <= source_next;
                dest_cursor <= dest_next;
                if (source_next >= source_end) begin
                    exec <= 0;
                    source_offset <= source_offset + {6'b0,width};
                    dest_offset <= dest_next[23:8];
                end
            end
        end
    end
endmodule
