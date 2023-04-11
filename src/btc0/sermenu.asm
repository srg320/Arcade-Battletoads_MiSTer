L7D8888:										;void main_func_24()
7D8888 19C0                     MOVK   #$0E,A0                  	;
7D888A 0580 00024250            MOVE   A0 ,@00024250,0          	;*(u16*)0x00024250 = 0x000E;
7D8890 0D5F FFD4A5D0            CALLA  L7A94BA                	;pallete_write()
7D8896 09E0 FFE73830            MOVI   #$FFE73830,A0            	;
7D889C 0D5F FFE74F20            CALLA  L7CE9E4                	;change_di_int_table(init_di_int_table);
7D88A2 5600                     XOR    A0 ,A0                   	;
7D88A4 0580 00057D40            MOVE   A0 ,@00057D40,0          	;di_int_pos = 0x0000;
7D88AA 1820                     MOVK   #$01,A0                  	;
7D88AC 0543                     SETF   $03,0,0                  	;disp_ctrl &= ~0x0700;
7D88AE 0580 00058658            MOVE   A0 ,@00058658,0          	;disp_ctrl |= 1 << 8;
7D88B4 0570                     SETF   $10,1,0                  	;
7D88B6 0D5F FFD01FD0            CALLA  L7A03FA                	;bg0_clear();
7D88BC 0D5F FFD020A0            CALLA  L7A0414                	;bg1_clear();
7D88C2 0D5F FFD020D0            CALLA  L7A041A                	;fg01_clear();
7D88C8 0D5F FFD5A140            CALLA  L7AB428                	;L7AB428();
7D88CE 0D5F FFD5ADD0            CALLA  L7AB5BA                	;func_24_var_init();
7D88D4 0D5F FFFDB020            CALLA  L7FB604                	;load_pal_01_08_40();
7D88DA 0D5F FFD07DF0            CALLA  L7A0FBE                	;z80_init();
7D88E0 0D3F 0050                CALLR  L7D8984                 	;func_24_bg0_draw();
7D88E4 0D5F FFD4A5F0            CALLA  L7A94BE                	;pallete_fadeout_write();
7D88EA 5600                     XOR    A0 ,A0                   	;
7D88EC 0580 0002D280            MOVE   A0 ,@0002D280,0          	;*(u16*)0x0002D280 = 0x0000;
7D88F2 0580 0002C6D0            MOVE   A0 ,@0002C6D0,0          	;*(u16*)0x0002C6D0 = 0x0000;
7D88F8 0580 00023DB0            MOVE   A0 ,@00023DB0,0          	;port1_curr = 0x00;
7D88FE 0580 00023DD0            MOVE   A0 ,@00023DD0,0          	;port2_curr = 0x00;
7D8904 0580 00023DF0            MOVE   A0 ,@00023DF0,0          	;port2_curr = 0x00;
7D890A 0580 00023DC0            MOVE   A0 ,@00023DC0,0          	;port1_prev = 0x00;
7D8910 0580 00023DE0            MOVE   A0 ,@00023DE0,0          	;port2_prev = 0x00;
7D8916 0580 00023E00            MOVE   A0 ,@00023E00,0          	;port3_prev = 0x00;
7D891C 09E0 FFFD0120            MOVI   #$FFFD0120,A0            	;
7D8922 0780 0002D150            MOVE   A0 ,@0002D150,1          	;menu_draw_tbl = 0xFFFD0120; //L7FA024
7D8928 05A1 001A01C0            MOVE   @001A01C0,A1 ,0          	;
7D892E CA00 0002                JREQ   L7D8936                   	;if (*(u16*)0x001A01C0)
7D8932 0D3F 0941                CALLR  L7D9BB8                 	;  L7D9BB8();
7D8936 0D5F FFD626F0            CALLA  L7AC4DE                	;L7AC4DE();
7D893C 09E0 00000025            MOVI   #$00000025,A0            	;
7D8942 0580 00023E10            MOVE   A0 ,@00023E10,0          	;main_fn = 0x25;
7D8948 0960                     RETS                            	;

L7D894A:										;void main_func_25()
7D894A 0D3F 0092                CALLR  L7D8A72                 	;func_25_fg_draw();
7D894E 0D3F 0522                CALLR  L7D9396                	;func_25_joy();
7D8952 0D5F FFD62290            CALLA  L7AC452                	;nvram_state_init();
7D8958 0960                     RETS                            	;

7D895A 0D5F FFD04A70            CALLA  L7A094E                	;bg1_set_fill_param();
7D8960 09F9 02020202            MOVI   #$02020202,B9            	;COLOR1 = 0x02020202;
7D8966 5718                     XOR    B8 ,B8                   	;COLOR0 = 0x00000000;
7D8968 1900                     MOVK   #$08,A0                  	;
7D896A 0580 C0000150            MOVE   A0 ,@C0000150,0          	;PSIZE = 8;
7D8970 09E1 00680124            MOVI   #$00680124,A1            	;
7D8976 07A0 00023C90            MOVE   @00023C90,A0 ,1          	;
7D897C 0D5F FFD0BD60            CALLA  L7A17AC                	;L7A17AC
7D8982 0960                     RETS                            	;

L7D8984:										;void func_24_bg0_draw()
7D8984 0D5F FFD04980            CALLA  L7A0930                	;bg0_set_fill_param();
7D898A 1900                     MOVK   #$08,A0                  	;
7D898C 0580 C0000150            MOVE   A0 ,@C0000150,0          	;PSIZE = 8;
7D8992 57BD                     XOR    B13,B13                  	;
7D8994 09F9 01010101            MOVI   #$01010101,B9            	;COLOR1 = 0x01010101;
7D899A 5652                     XOR    B2 ,B2                   	;
7D899C 09F7 00080200            MOVI   #$00080200,B7            	;
7D89A2 0FE0                     FILL   XY                       	;
7D89A4 5652                     XOR    B2 ,B2                   	;
7D89A6 09F7 00E0000C            MOVI   #$00E0000C,B7            	;
7D89AC 0FE0                     FILL   XY                       	;
7D89AE 09F2 00D80000            MOVI   #$00D80000,B2            	;
7D89B4 09F7 00080200            MOVI   #$00080200,B7            	;
7D89BA 0FE0                     FILL   XY                       	;
7D89BC 09F2 000001F4            MOVI   #$000001F4,B2            	;
7D89C2 09F7 00E0000C            MOVI   #$00E0000C,B7            	;
7D89C8 0FE0                     FILL   XY                       	;
7D89CA 09F9 02020202            MOVI   #$02020202,B9            	;COLOR1 = 0x02020202;
7D89D0 09F2 0008000C            MOVI   #$0008000C,B2            	;
7D89D6 09F7 001801E8            MOVI   #$001801E8,B7            	;
7D89DC 0FE0                     FILL   XY                       	;
7D89DE 05A0 001A01C0            MOVE   @001A01C0,A0 ,0          	;
7D89E4 CB00 0024                JRNE   L7D8A30                  	;if (*(u16*)0x001A01C0) return;
7D89E8 09F9 03030303            MOVI   #$03030303,B9            	;COLOR1 = 0x03030303;
7D89EE 09F2 00CC000C            MOVI   #$00CC000C,B2            	;
7D89F4 09F7 000C01E8            MOVI   #$000C01E8,B7            	;
7D89FA 0FE0                     FILL   XY                       	;
7D89FC 19C0                     MOVK   #$0E,A0                  	;
7D89FE 0580 00024250            MOVE   A0 ,@00024250,0          	;u16 str_id = *(u16*)0x00024250;

L7D8A04:										;void func_24_bg0_print_tip(str_id)
7D8A04 0D5F FFD04980            CALLA  L7A0930                	;bg0_set_fill_param();
7D8A0A 1900                     MOVK   #$08,A0                  	;
7D8A0C 0580 C0000150            MOVE   A0 ,@C0000150,0          	;PSIZE = 8;
7D8A12 09F9 04040404            MOVI   #$04040404,B9            	;COLOR1 = 0x04040404;
7D8A18 09F8 03030303            MOVI   #$03030303,B8            	;COLOR0 = 0x03030303;
7D8A1E 09E1 00CE0034            MOVI   #$00CE0034,A1            	;
7D8A24 05A0 00024250            MOVE   @00024250,A0 ,0          	;
7D8A2A CB80 FFD02EB0            JRNE   L7A05D6                	;if (str_id) return draw_res_string(str_id, {0x00CE,0x0034});
L7D8A30:
7D8A30 0960                     RETS                            	;

L7D8A32:
	dc.l	L7D8AC2
	dc.l	L7D8AC4
	dc.l	L7D8ACE
	dc.l	L7D8AD8
	dc.l	L7D8AE2
	dc.l	L7D8AEC
	dc.l	L7D8AF6
	dc.l	L7D8B1E
	dc.l	L7D8B38
	dc.l	L7D8B42
	dc.l	L7D8BB6
	dc.l	L7D8BD6
	dc.l	L7D8C04
	dc.l	L7D8C10
	dc.l	L7D8C6A
	dc.l	L7D8C92

L7D8A72:										;void func_25_fg_draw()
7D8A72 5600                     XOR    A0 ,A0                   	;
7D8A74 0D5F FFD03ED0            CALLA  L7A07DA                	;set_control_ppop(0);
7D8A7A 0D5F FFD04B60            CALLA  L7A096C                	;fg1_set_fill_param();
7D8A80 1A00                     MOVK   #$10,A0                  	;
7D8A82 0580 C0000150            MOVE   A0 ,@C0000150,0          	;PSIZE = 16;
7D8A88 07AA 0002D150            MOVE   @0002D150,A10,1          	;void* tbl = menu_draw_tbl;
7D8A8E 05C0 0002D190  0002D1B0  MOVE   @0002D190,@0002D1B0,0    	;str_draw_color = menu_normal_color;
7D8A98 1940                     MOVK   #$0A,A0                  	;
7D8A9A 0580 0002D1C0            MOVE   A0 ,@0002D1C0,0          	;*(u16*)0x0002D1C0 = 0x000A;
7D8AA0 0580 0002D1D0            MOVE   A0 ,@0002D1D0,0          	;str_draw_color2 = 0x000A;
7D8AA6 5600                     XOR    A0 ,A0                   	;
7D8AA8 0580 0002D1E0            MOVE   A0 ,@0002D1E0,0          	;menu_item_num = 0x0000;
7D8AAE 0780 0002D200            MOVE   A0 ,@0002D200,1          	;menu_item_handler = 0;
L7D8AB4:
7D8AB4 9540                     MOVE   *A10+,A0 ,0              	;
7D8AB6 24A0                     SLL    #5,A0                   	;
7D8AB8 0B20 FFEC5190            ADDI   #$FFEC5190,A0            	;u8* str;
7D8ABE 8600                     MOVE   *A0 ,A0 ,1               	;
7D8AC0 0160                     JUMP   A0                       	;switch (*(u16*)tbl++) {
L7D8AC2:										;case 0:
7D8AC2 0960                     RETS                            	;  return;
L7D8AC4:
7D8AC4 9540                     MOVE   *A10+,A0 ,0              	;case 1:
7D8AC6 0580 0002D180            MOVE   A0 ,@0002D180,0          	;  str_draw_pos.y = *(u16*)tbl++;
7D8ACC C0F3                     JRUC   L7D8AB4                  	;  break;
L7D8ACE:
7D8ACE 9540                     MOVE   *A10+,A0 ,0              	;case 2:
7D8AD0 0580 0002D170            MOVE   A0 ,@0002D170,0          	;  str_draw_pos.x = *(u16*)tbl++;
7D8AD6 C0EE                     JRUC   L7D8AB4                 	;  break;
L7D8AD8:										;
7D8AD8 9540                     MOVE   *A10+,A0 ,0              	;case 3:
7D8ADA 0580 0002D190            MOVE   A0 ,@0002D190,0          	;  menu_normal_color = *(u16*)tbl++;
7D8AE0 C0E9                     JRUC   L7D8AB4                 	;  break;
L7D8AE2:
7D8AE2 9540                     MOVE   *A10+,A0 ,0              	;case 4:
7D8AE4 0580 0002D1A0            MOVE   A0 ,@0002D1A0,0          	;  menu_active_color = *(u16*)tbl++;
7D8AEA C0E4                     JRUC   L7D8AB4                 	;  break;
L7D8AEC:
7D8AEC 974A                     MOVE   *A10+,A10,1              	;case 5:
7D8AEE 078A 0002D150            MOVE   A10,@0002D150,1          	;  menu_draw_tbl = *tbl++;
7D8AF4 0960                     RETS                            	;  return;
L7D8AF6:
7D8AF6 9740                     MOVE   *A10+,A0 ,1              	;case 6:
L7D8AF8:										;  str = *tbl++;
7D8AF8 05B9 0002D1B0            MOVE   @0002D1B0,B9 ,0          	;  COLOR1 = str_draw_color;
L7D8AFE:
7D8AFE 07A1 0002D170            MOVE   @0002D170,A1 ,1          	;
7D8B04 0299                     RPIX   B9                       	;  RPIX(COLOR1);
7D8B06 5718                     XOR    B8 ,B8                   	;  COLOR0 = 0x00000000;
7D8B08 098F 0020                MMTM   SP ,#$0020                	;
7D8B0C 0D5F FFD02F00            CALLA  L7A05E0                	;  xy_t ret = draw_string(str,str_draw_pos);
7D8B12 09AF 0400                MMFM   SP ,#$0400                	;
7D8B16 0581 0002D170            MOVE   A1 ,@0002D170,0          	;  str_draw_pos.x = ret.x;
7D8B1C C0CB                     JRUC   L7D8AB4                  	;  break;
L7D8B1E:
7D8B1E 05A0 0002D180            MOVE   @0002D180,A0 ,0          	;case 7:
7D8B24 1100                     ADDK   #$08,A0                  	;
7D8B26 0580 0002D180            MOVE   A0 ,@0002D180,0          	;  str_draw_pos.y += 8;
7D8B2C 09C0 000E                MOVI   #$000E,A0                	;
7D8B30 0580 0002D170            MOVE   A0 ,@0002D170,0          	;  str_draw_pos.x = 0x000E;
7D8B36 C0BE                     JRUC   L7D8AB4                  	;  break;
L7D8B38:
7D8B38 9540                     MOVE   *A10+,A0 ,0              	;case 8:
7D8B3A 0580 0002D1B0            MOVE   A0 ,@0002D1B0,0          	;  str_draw_color = *ptr++;
7D8B40 C0B9                     JRUC   L7D8AB4                  	;  break;
L7D8B42:
7D8B42 9740                     MOVE   *A10+,A0 ,1              	;case 9:
7D8B44 05A1 0002D1E0            MOVE   @0002D1E0,A1 ,0          	;  void* h = *tbl++;
7D8B4A 1021                     INC    A1                       	;  u16 pos = menu_item_num;
7D8B4C 0581 0002D1E0            MOVE   A1 ,@0002D1E0,0          	;  menu_item_num++;
7D8B52 1421                     DEC    A1                       	;
7D8B54 05A2 0002D1F0            MOVE   @0002D1F0,A2 ,0          	;
7D8B5A 4822                     CMP    A1 ,A2                   	;
7D8B5C CB21                     JRNE   L7D8BA0                   	;  if (menu_item_pos == pos) {
7D8B5E 0780 0002D200            MOVE   A0 ,@0002D200,1          	;    menu_item_handler = h;
7D8B64 05C0 0002D1A0  0002D1B0  MOVE   @0002D1A0,@0002D1B0,0    	;    str_draw_color = menu_active_color;
7D8B6E 05C0 0002D1C0  0002D1D0  MOVE   @0002D1C0,@0002D1D0,0    	;    str_draw_color2 = *(u16*)0x0002D1C0;
7D8B78 07A1 0002D170            MOVE   @0002D170,A1 ,1          	;
7D8B7E 1501                     SUBK   #$08,A1                  	;    xy_t pos = str_draw_pos - 8;
7D8B80 098F 0020                MMTM   SP ,#$0020                	;
7D8B84 09C0 007E                MOVI   #$007E,A0                	;
7D8B88 09F9 0D0D0D0D            MOVI   #$0D0D0D0D,B9            	;    COLOR1 = 0x0D0D0D0D;
7D8B8E 0D5F FFD02FF0            CALLA  L7A05FE                	;    set_char_draw_param(font_src);
7D8B94 0D5F FFD02E40            CALLA  L7A05C8                	;    draw_char(0x7E,pos,font_src);
7D8B9A 09AF 0400                MMFM   SP ,#$0400                	;
7D8B9E C009                     JRUC   L7D8BB2                   	;  
L7D8BA0:										;  } else {
7D8BA0 05C0 0002D190  0002D1B0  MOVE   @0002D190,@0002D1B0,0    	;    str_draw_color = menu_normal_color;
7D8BAA 1960                     MOVK   #$0B,A0                  	;
7D8BAC 0580 0002D1D0            MOVE   A0 ,@0002D1D0,0          	;    str_draw_color2 = 0x000B;
L7D8BB2:										;  }
7D8BB2 C000 FF7F                JRUC   L7D8AB4                  	;  break;
L7D8BB6:
7D8BB6 9740                     MOVE   *A10+,A0 ,1              	;case 0xA:
7D8BB8 4C01                     MOVE   A0 ,A1                   	;  str = *tbl++;
7D8BBA 5642                     XOR    A2 ,A2                   	;  u8* temp = str;
7D8BBC C002                     JRUC   L7D8BC2                  	;  u16 width = 0; 
L7D8BBE:
7D8BBE 1101                     ADDK   #$08,A1                  	;  while (*temp++)
7D8BC0 1102                     ADDK   #$08,A2                  	;    width += 8;
7D8BC2 8E23                     MOVB   *A1 ,A3                  	;
7D8BC4 CBFC                     JRNE   L7D8BBE                   	;  
7D8BC6 09C1 0100                MOVI   #$0100,A1                	;
7D8BCA 4441                     SUB    A2 ,A1                   	;
7D8BCC 2BE1                     SRA    #1,A1                   	;
7D8BCE 0581 0002D170            MOVE   A1 ,@0002D170,0          	;    str_draw_pos.x = (256 - width) / 2;
7D8BD4 C091                     JRUC   L7D8AF8                 	;  goto L7D8AF8;
L7D8BD6:
7D8BD6 9740                     MOVE   *A10+,A0 ,1              	;case 0xB:
7D8BD8 8400                     MOVE   *A0 ,A0 ,0               	;  u16* ptr = *tbl++;
7D8BDA 07A1 0002D170            MOVE   @0002D170,A1 ,1          	;  u16 temp = *ptr;
7D8BE0 05B9 0002D1D0            MOVE   @0002D1D0,B9 ,0          	;  COLOR1 = str_draw_color2;
7D8BE6 0299                     RPIX   B9                       	;  RPIX(COLOR1);
7D8BE8 5718                     XOR    B8 ,B8                   	;  COLOR0 = 0x00000000;
7D8BEA 098F 0020                MMTM   SP ,#$0020                	;
7D8BEE 5729                     XOR    A9 ,A9                   	;
7D8BF0 0D5F FFD0AE10            CALLA  L7A15C2                	;  xy_t ret = L7A15C2(str_draw_pos);
7D8BF6 09AF 0400                MMFM   SP ,#$0400                	;
7D8BFA 0581 0002D170            MOVE   A1 ,@0002D170,0          	;  str_draw_pos.x = ret.x;
7D8C00 C000 FF58                JRUC   L7D8AB4                  	;  break;
L7D8C04:
7D8C04 9540                     MOVE   *A10+,A0 ,0              	;case 0xC:
7D8C06 0580 0002D1D0            MOVE   A0 ,@0002D1D0,0          	;  str_draw_color2 = *(u16*)tbl++;
7D8C0C C000 FF52                JRUC   L7D8AB4                  	;  break;
L7D8C10:
7D8C10 05A0 0002D170            MOVE   @0002D170,A0 ,0          	;case 0xD:
7D8C16 1100                     ADDK   #$08,A0                  	;
7D8C18 0580 0002D170            MOVE   A0 ,@0002D170,0          	;  str_draw_pos.x += 8;
7D8C1E 9541                     MOVE   *A10+,A1 ,0              	;  u16 bit_mask = *(u16*)tbl++;
7D8C20 05B9 0002D1D0            MOVE   @0002D1D0,B9 ,0          	;  COLOR1 = str_draw_color2;
7D8C26 098F 6000                MMTM   SP ,#$6000                	;
7D8C2A 05A0 20000280            MOVE   @20000280,A0 ,0          	;
7D8C30 03E0                     NOT    A0                       	;
7D8C32 05A1 001A0310            MOVE   @001A0310,A1 ,0          	;
7D8C38 09C2 007F                MOVI   #$007F,A2                	;
7D8C3C 5040                     AND    A2 ,A0                   	;
7D8C3E 5241                     ANDN   A2 ,A1                   	;
7D8C40 5401                     OR     A0 ,A1                   	;
7D8C42 0581 001A0310            MOVE   A1 ,@001A0310,0          	;  sw1_save = (sw1_save & ~0x7F) | (~SW1 & 0x7F);
7D8C48 09AF 0006                MMFM   SP ,#$0006                	;
7D8C4C 05A0 001A0310            MOVE   @001A0310,A0 ,0          	;
7D8C52 4A20                     BTST   A1 ,A0                   	;
7D8C54 CB05                     JRNE   L7D8C60                  	;
7D8C56 09E0 FFFD35F0            MOVI   #$FFFD35F0,A0            	;
7D8C5C C000 FF4F                JRUC   L7D8AFE                 	;
7D8C60 09E0 FFFD35D0            MOVI   #$FFFD35D0,A0            	;  str = !(sw1_save & bit_mask) ? L7FA6BE : L7FA6BA;
7D8C66 C000 FF4A                JRUC   L7D8AFE                 	;  goto L7D8AFE;
L7D8C6A:
7D8C6A 9740                     MOVE   *A10+,A0 ,1              	;case 0xE:
7D8C6C 098F 0020                MMTM   SP ,#$0020                	;  void* h = *tbl++;
7D8C70 0920                     CALL   A0                       	;  h();
7D8C72 09AF 0001                MMFM   SP ,#$0001                	;
7D8C76 5718                     XOR    B8 ,B8                   	;  COLOR0 = 0x00000000;
7D8C78 5600                     XOR    A0 ,A0                   	;
7D8C7A 0D5F FFD03ED0            CALLA  L7A07DA                	;  set_control_ppop(0);
7D8C80 0D5F FFD04B60            CALLA  L7A096C                	;  fg1_set_fill_param();
7D8C86 1A00                     MOVK   #$10,A0                  	;
7D8C88 0580 C0000150            MOVE   A0 ,@C0000150,0          	;  PSIZE = 16;
7D8C8E C000 FF11                JRUC   L7D8AB4                  	;  break;
L7D8C92:
7D8C92 09C4 0010                MOVI   #$0010,A4                	;case 0xF:
7D8C96 05A0 00023DB0            MOVE   @00023DB0,A0 ,0          	;
7D8C9C 5080                     AND    A4 ,A0                   	;
7D8C9E 05A1 00023DD0            MOVE   @00023DD0,A1 ,0          	;
7D8CA4 5081                     AND    A4 ,A1                   	;
7D8CA6 05A2 00023DF0            MOVE   @00023DF0,A2 ,0          	;
7D8CAC 5082                     AND    A4 ,A2                   	;  u8 temp = (port1_curr & 0x10) + 
7D8CAE 4020                     ADD    A1 ,A0                   	;            (port2_curr & 0x10) + 
7D8CB0 4040                     ADD    A2 ,A0                   	;            (port3_curr & 0x10);
7D8CB2 2F60                     SRL    #5,A0                   	;
7D8CB4 CB01                     JRNE   L7D8CB8                  	;  if (temp >> 5 == 0) return;
7D8CB6 0960                     RETS                            	;
7D8CB8 09C0 0010                MOVI   #$0010,A0                	;
7D8CBC 0580 00023DE0            MOVE   A0 ,@00023DE0,0          	;  port2_prev = 0x10;
7D8CC2 09E0 FFEC74F0            MOVI   #$FFEC74F0,A0            	;
7D8CC8 0780 0002D200            MOVE   A0 ,@0002D200,1          	;  menu_item_handler = L7D8E9E;
7D8CCE C000 FEF1                JRUC   L7D8AB4                  	;  break;}

7D8CD2 0960                     RETS                            	;
7D8CD4 C080 FFD481B0            JRUC   $FFD481B0                	;


L7D8D7E:										;joystick check screen
	dc.w	0x0003,0x000F 
	dc.w	0x0004,0x0006 
	dc.w	0x0001,0x0010 
	dc.w	0x0002,0x0054 
	dc.w	0x0008,0x0005 
	dc.w	0x000A  								;draw title center
	dc.l	L7FA53C 								;"JOYSTICK & BUTTON CHECK"
	dc.w	0x0008,0x000F 
	dc.w	0x0001,0x0030 
	dc.w	0x0002,0x000E 
	dc.w	0x000E 
	dc.l	0xFFECA340 
	dc.w	0x000F 
	dc.w	0x0005 
	dc.l	0xFFEC6BF0 
 

L7D8E4A

L7D8E50:										;void func_25_menu_open(void* tbl)
7D8E50 0780 0002D150            MOVE   A0 ,@0002D150,1          	;menu_draw_tbl = tbl;
7D8E56 5600                     XOR    A0 ,A0                   	;
7D8E58 0780 0002D200            MOVE   A0 ,@0002D200,1          	;menu_item_handler = 0;
7D8E5E 0580 0002D1F0            MOVE   A0 ,@0002D1F0,0          	;menu_item_pos = 0;
7D8E64 0D5F FFD020A0            CALLA  L7A0414                	;bg1_clear();
7D8E6A 0D3F FDCB                CALLR  L7D8A04                 	;func_24_bg0_print_tip(0);
7D8E6E 0960                     RETS                            	;

7D8E70 05C0 20000280  0019F170  MOVE   @20000280,@0019F170,0    	;
7D8E7A 1880                     MOVK   #$04,A0                  	;
7D8E7C 0580 0019F180            MOVE   A0 ,@0019F180,0          	;
7D8E82 09E0 FFFD1630            MOVI   #$FFFD1630,A0            	;
7D8E88 C0E3                     JRUC   $1C6                     	;
7D8E8A 0D5F FFD07DF0            CALLA  L7A0FBE                  	;
7D8E90 09E0 FFFD0120            MOVI   #$FFFD0120,A0            	;
7D8E96 C0DC                     JRUC   $1B8                     	;
7D8E98 0D5F FFD07DF0            CALLA  L7A0FBE                  	;
7D8E9E 09E0 FFFD07A0            MOVI   #$FFFD07A0,A0            	;
7D8EA4 C0D5                     JRUC   $1AA                     	;
7D8EA6 09E0 FFFD0B80            MOVI   #$FFFD0B80,A0            	;
7D8EAC C0D1                     JRUC   $1A2                     	;
7D8EAE 09E0 FFFD13F0            MOVI   #$FFFD13F0,A0            	;
7D8EB4 0D3F FFCC                CALLR  L7D8E50                 	;
7D8EB8 09E4 FFFD6F70            MOVI   #$FFFD6F70,A4            	;
7D8EBE 0D3F 01B0                CALLR  L7D9222                 	;
7D8EC2 09F9 09090909            MOVI   #$09090909,B9            	;
7D8EC8 09F2 00800014            MOVI   #$00800014,B2            	;
7D8ECE 09F7 000101D8            MOVI   #$000101D8,B7            	;
7D8ED4 0FE0                     FILL   XY                       	;
7D8ED6 0D3F 0125                CALLR  L7D9124                 	;
7D8EDA 0960                     RETS                            	;
7D8EDC 09E0 FFFD11B0            MOVI   #$FFFD11B0,A0            	;
7D8EE2 0D3F FFB5                CALLR  L7D8E50                 	;
7D8EE6 09E4 FFFD6E50            MOVI   #$FFFD6E50,A4            	;
7D8EEC 0D3F 0199                CALLR  L7D9222                 	;
7D8EF0 0D3F 0153                CALLR  L7D919A                 	;
7D8EF4 0960                     RETS                            	;
7D8EF6 09E0 FFFD0F70            MOVI   #$FFFD0F70,A0            	;
7D8EFC 0D3F FFA8                CALLR  L7D8E50                 	;
7D8F00 09E4 FFFD6C30            MOVI   #$FFFD6C30,A4            	;
7D8F06 0D3F 018C                CALLR  L7D9222                 	;
7D8F0A 0D3F 002E                CALLR  L7D8F6A                 	;
7D8F0E 09F9 09090909            MOVI   #$09090909,B9            	;
7D8F14 09F2 003C0014            MOVI   #$003C0014,B2            	;
7D8F1A 09F7 000101D8            MOVI   #$000101D8,B7            	;
7D8F20 0FE0                     FILL   XY                       	;
7D8F22 09F2 005A0014            MOVI   #$005A0014,B2            	;
7D8F28 09F7 000101D8            MOVI   #$000101D8,B7            	;
7D8F2E 0FE0                     FILL   XY                       	;
7D8F30 09F2 008B0014            MOVI   #$008B0014,B2            	;
7D8F36 09F7 000101D8            MOVI   #$000101D8,B7            	;
7D8F3C 0FE0                     FILL   XY                       	;
7D8F3E 09F2 002C00D4            MOVI   #$002C00D4,B2            	;
7D8F44 09F7 00600001            MOVI   #$00600001,B7            	;
7D8F4A 0FE0                     FILL   XY                       	;
7D8F4C 09F2 002C0134            MOVI   #$002C0134,B2            	;
7D8F52 09F7 00600001            MOVI   #$00600001,B7            	;
7D8F58 0FE0                     FILL   XY                       	;
7D8F5A 09F2 002C0194            MOVI   #$002C0194,B2            	;
7D8F60 09F7 00600001            MOVI   #$00600001,B7            	;
7D8F66 0FE0                     FILL   XY                       	;
7D8F68 0960                     RETS                            	;
7D8F6A 0D5F FFD00030            CALLA  L7A0006                  	;
7D8F70 09F9 08080808            MOVI   #$08080808,B9            	;
7D8F76 09EC 001A0390            MOVI   #$001A0390,A12           	;
7D8F7C 09E1 004C0090            MOVI   #$004C0090,A1            	;
7D8F82 0D3F 001E                CALLR  L7D8FC2                 	;
7D8F86 09EC 001A05D0            MOVI   #$001A05D0,A12           	;
7D8F8C 09E1 006C0090            MOVI   #$006C0090,A1            	;
7D8F92 0D3F 0016                CALLR  L7D8FC2                 	;
7D8F96 05A0 001A0320            MOVE   @001A0320,A0 ,0          	;
7D8F9C 09E1 00940138            MOVI   #$00940138,A1            	;
7D8FA2 5729                     XOR    A9 ,A9                   	;
7D8FA4 0D5F FFD0AE10            CALLA  L7A15C2                  	;
7D8FAA 09EC 001A05D0            MOVI   #$001A05D0,A12           	;
7D8FB0 09E1 007C00B0            MOVI   #$007C00B0,A1            	;
7D8FB6 5729                     XOR    A9 ,A9                   	;
7D8FB8 0D3F 0053                CALLR  L7D9062                 	;
7D8FBC C080 FFD000B0            JAUC   L7A0016                  	;
7D8FC2 05A0 001A0310            MOVE   @001A0310,A0 ,0          	;
7D8FC8 1FA0                     BTST   #2,A0                   	;
7D8FCA CA00 0018                JREQ   L7D8FFE                  	;
7D8FCE B780 0040                MOVE   *A12($0040),A0 ,1        	;
7D8FD2 098F 4000                MMTM   SP ,A,1                	;
7D8FD6 1829                     MOVK   #$01,A9                  	;
7D8FD8 0D5F FFD0AEB0            CALLA  L7A15D6                  	;
7D8FDE 09AF 0002                MMFM   SP ,A,1                	;
7D8FE2 098F 4000                MMTM   SP ,A,1                	;
7D8FE6 B780 0040                MOVE   *A12($0040),A0 ,1        	;
7D8FEA 0C01 00000060            ADDXYI #$00000060,A1            	;
7D8FF0 1829                     MOVK   #$01,A9                  	;
7D8FF2 0D5F FFD0AEB0            CALLA  L7A15D6                  	;
7D8FF8 09AF 0002                MMFM   SP ,A,1                	;
7D8FFC 0960                     RETS                            	;
7D8FFE B780 00C0                MOVE   *A12($00C0),A0 ,1        	;
7D9002 B782 00E0                MOVE   *A12($00E0),A2 ,1        	;
7D9006 4040                     ADD    A2 ,A0                   	;
7D9008 05A2 001A0310            MOVE   @001A0310,A2 ,0          	;
7D900E 1F82                     BTST   #3,A2                   	;
7D9010 CA00 0003                JREQ   L7D901A                  	;
7D9014 B782 0100                MOVE   *A12($0100),A2 ,1        	;
7D9018 4040                     ADD    A2 ,A0                   	;
7D901A 098F 4000                MMTM   SP ,A,1                	;
7D901E 1829                     MOVK   #$01,A9                  	;
7D9020 0D5F FFD0AEB0            CALLA  L7A15D6                  	;
7D9026 09AF 0002                MMFM   SP ,A,1                	;
7D902A 0C01 0000000C            ADDXYI #$0000000C,A1            	;
7D9030 1866                     MOVK   #$03,A6                  	;
7D9032 05A0 001A0310            MOVE   @001A0310,A0 ,0          	;
7D9038 1F80                     BTST   #3,A0                   	;
7D903A CB00 0001                JRNE   L7D9040                  	;
7D903E 1846                     MOVK   #$02,A6                  	;
7D9040 0C01 00000060            ADDXYI #$00000060,A1            	;
7D9046 B780 00C0                MOVE   *A12($00C0),A0 ,1        	;
7D904A 098F 4200                MMTM   SP ,A,1,6                	;
7D904E 1829                     MOVK   #$01,A9                  	;
7D9050 0D5F FFD0AEB0            CALLA  L7A15D6                  	;
7D9056 09AF 0042                MMFM   SP ,A,1,6                	;
7D905A 0B0C 0020                ADDI   #$0020,A12               	;
7D905E 3E06                     DSJS   A6 ,#$E0                 	;
7D9060 0960                     RETS                            	;
7D9062 05A0 001A0310            MOVE   @001A0310,A0 ,0          	;
7D9068 1FA0                     BTST   #2,A0                   	;
7D906A CA00 000F                JREQ   L7D908C                  	;
7D906E B783 0040                MOVE   *A12($0040),A3 ,1        	;
7D9072 098F 4000                MMTM   SP ,A,1                	;
7D9076 0D3F 002F                CALLR  L7D90D8                 	;
7D907A 09AF 0002                MMFM   SP ,A,1                	;
7D907E 0C01 00000060            ADDXYI #$00000060,A1            	;
7D9084 B783 0040                MOVE   *A12($0040),A3 ,1        	;
7D9088 C000 0026                JRUC   L7D90D8                  	;
7D908C B783 00C0                MOVE   *A12($00C0),A3 ,1        	;
7D9090 B782 00E0                MOVE   *A12($00E0),A2 ,1        	;
7D9094 4043                     ADD    A2 ,A3                   	;
7D9096 05A2 001A0310            MOVE   @001A0310,A2 ,0          	;
7D909C 1F82                     BTST   #3,A2                   	;
7D909E CA00 0003                JREQ   L7D90A8                  	;
7D90A2 B782 0100                MOVE   *A12($0100),A2 ,1        	;
7D90A6 4043                     ADD    A2 ,A3                   	;
7D90A8 0D3F 0016                CALLR  L7D90D8                 	;
7D90AC 0C01 0000000C            ADDXYI #$0000000C,A1            	;
7D90B2 1866                     MOVK   #$03,A6                  	;
7D90B4 05A0 001A0310            MOVE   @001A0310,A0 ,0          	;
7D90BA 1F80                     BTST   #3,A0                   	;
7D90BC CB00 0001                JRNE   L7D90C2                  	;
7D90C0 1846                     MOVK   #$02,A6                  	;
7D90C2 0C01 00000060            ADDXYI #$00000060,A1            	;
7D90C8 B783 00C0                MOVE   *A12($00C0),A3 ,1        	;
7D90CC 0B0C 0020                ADDI   #$0020,A12               	;
7D90D0 0D3F 0002                CALLR  L7D90D8                 	;
7D90D4 3D46                     DSJS   A6 ,#$EC                 	;
7D90D6 0960                     RETS                            	;
7D90D8 09C0 0064                MOVI   #$0064,A0                	;
7D90DC 5E03                     MPYU   A0 ,A3                   	;
7D90DE 05A0 001A0320            MOVE   @001A0320,A0 ,0          	;
7D90E4 5A03                     DIVU   A0 ,A3                   	;
7D90E6 4C60                     MOVE   A3 ,A0                   	;
7D90E8 098F 4200                MMTM   SP ,A,1,6                	;
7D90EC 1829                     MOVK   #$01,A9                  	;
7D90EE 0D5F FFD0B700            CALLA  L7A16E0                  	;
7D90F4 09AF 0042                MMFM   SP ,A,1,6                	;
7D90F8 0960                     RETS                            	;

L7D90FA:										;void func_25_joycheck_open()
7D90FA 1AA0                     MOVK   #$15,A0                  	;
7D90FC 0580 00024250            MOVE   A0 ,@00024250,0          	;
7D9102 09E0 FFEC6BF0            MOVI   #$FFEC6BF0,A0            	;
7D9108 0D3F FEA2                CALLR  L7D8E50                 	;func_25_menu_open(L7D8D7E);
7D910C 0D3F 0177                CALLR  L7D93FE                 	;L7D93FE
7D9110 19C0                     MOVK   #$0E,A0                  	;
7D9112 0580 00024250            MOVE   A0 ,@00024250,0          	;
7D9118 0960                     RETS                            	;

7D911A 09E0 FFEC6D90            MOVI   #$FFEC6D90,A0            	;
7D9120 C000 FE96                JRUC   L7D8E50                  	;
7D9124 09F9 08080808            MOVI   #$08080808,B9            	;
7D912A 09E1 008A012C            MOVI   #$008A012C,A1            	;
7D9130 098F 4000                MMTM   SP ,A,1                	;
7D9134 09EC 001A05D0            MOVI   #$001A05D0,A12           	;
7D913A 0D3F 000C                CALLR  L7D9156                 	;
7D913E 09AF 0002                MMFM   SP ,A,1                	;
7D9142 09EC 001A0390            MOVI   #$001A0390,A12           	;
7D9148 0C01 001000A0            ADDXYI #$001000A0,A1            	;
7D914E 0D3F 0012                CALLR  L7D9176                 	;
7D9152 C000 007D                JRUC   L7D9250                  	;
7D9156 098F 4000                MMTM   SP ,A,1                	;
7D915A 5600                     XOR    A0 ,A0                   	;
7D915C 09AF 0002                MMFM   SP ,A,1                	;
7D9160 0C01 00080000            ADDXYI #$00080000,A1            	;
7D9166 098F 4000                MMTM   SP ,A,1                	;
7D916A 5600                     XOR    A0 ,A0                   	;
7D916C 09AF 0002                MMFM   SP ,A,1                	;
7D9170 0C01 00080000            ADDXYI #$00080000,A1            	;
7D9176 098F 4000                MMTM   SP ,A,1                	;
7D917A B780 0020                MOVE   *A12($0020),A0 ,1        	;
7D917E 0D5F FFD0BD60            CALLA  L7A17AC                  	;
7D9184 09AF 0002                MMFM   SP ,A,1                	;
7D9188 0C01 00080000            ADDXYI #$00080000,A1            	;
7D918E B780 0000                MOVE   *A12($0000),A0 ,1        	;
7D9192 0D5F FFD0BD60            CALLA  L7A17AC                  	;
7D9198 0960                     RETS                            	;
7D919A 09F9 08080808            MOVI   #$08080808,B9            	;
7D91A0 09EC 001A0730            MOVI   #$001A0730,A12           	;
7D91A6 09E1 004800A4            MOVI   #$004800A4,A1            	;
7D91AC 0D3F 000A                CALLR  L7D91C4                 	;
7D91B0 0BEC FFDF                SUBI   #$0020,A12               	;
7D91B4 0B01 0078                ADDI   #$0078,A1                	;
7D91B8 0D3F 0004                CALLR  L7D91C4                 	;
7D91BC 0BEC FFDF                SUBI   #$0020,A12               	;
7D91C0 0B01 0078                ADDI   #$0078,A1                	;
7D91C4 098F 4000                MMTM   SP ,A,1                	;
7D91C8 8780                     MOVE   *A12,A0 ,1               	;
7D91CA 5729                     XOR    A9 ,A9                   	;
7D91CC 098F 4000                MMTM   SP ,A,1                	;
7D91D0 0D5F FFD0AEB0            CALLA  L7A15D6                  	;
7D91D6 09AF 0002                MMFM   SP ,A,1                	;
7D91DA 0C01 00100000            ADDXYI #$00100000,A1            	;
7D91E0 B780 0060                MOVE   *A12($0060),A0 ,1        	;
7D91E4 B789 00C0                MOVE   *A12($00C0),A9 ,1        	;
7D91E8 4120                     ADD    A9 ,A0                   	;
7D91EA 5729                     XOR    A9 ,A9                   	;
7D91EC 098F 4000                MMTM   SP ,A,1                	;
7D91F0 0D5F FFD0AEB0            CALLA  L7A15D6                  	;
7D91F6 09AF 0002                MMFM   SP ,A,1                	;
7D91FA 0C01 00180000            ADDXYI #$00180000,A1            	;
7D9200 B780 00C0                MOVE   *A12($00C0),A0 ,1        	;
7D9204 B782 0060                MOVE   *A12($0060),A2 ,1        	;
7D9208 4040                     ADD    A2 ,A0                   	;
7D920A 8782                     MOVE   *A12,A2 ,1               	;
7D920C 4040                     ADD    A2 ,A0                   	;
7D920E 098F 4000                MMTM   SP ,A,1                	;
7D9212 0D5F FFD0AEB0            CALLA  L7A15D6                  	;
7D9218 09AF 0002                MMFM   SP ,A,1                	;
7D921C 09AF 0002                MMFM   SP ,A,1                	;
7D9220 0960                     RETS                            	;

L7D9222:										;void draw_strings(u32* tbl)
7D9222 0D5F FFD04A70            CALLA  L7A094E                	;bg1_set_fill_param();
7D9228 1900                     MOVK   #$08,A0                  	;
7D922A 0580 C0000150            MOVE   A0 ,@C0000150,0          	;PSIZE = 8;
7D9230 5718                     XOR    B8 ,B8                   	;COLOR0 = 0x00000000;
7D9232 09F9 07070707            MOVI   #$07070707,B9            	;COLOR1 = 0x07070707;
7D9238 C008                     JRUC   L7D924A                  	;
L7D923A:
7D923A 9680                     MOVE   *A4+,A0 ,1              	;while (xy_t pos = *tbl++) {
7D923C 098F 0800                MMTM   SP ,#$0800                	;  u8* str = *tbl++;
7D9240 0D5F FFD02F00            CALLA  $FFD02F00                	;  draw_string(str, pos);
7D9246 09AF 0010                MMFM   SP ,#$0010                	;
L7D924A:
7D924A 9681                     MOVE   *A4+,A1 ,1              	;
7D924C CBF6                     JRNE   L7D923A                  	;}
7D924E 0960                     RETS                            	;






L7D9396:										;void func_25_joy()
7D9396 05A8 00023DE0            MOVE   @00023DE0,A8 ,0          	;
7D939C 05A0 00023DC0            MOVE   @00023DC0,A0 ,0          	;
7D93A2 5408                     OR     A0 ,A8                   	;
7D93A4 05A0 00023E00            MOVE   @00023E00,A0 ,0          	;
7D93AA 5408                     OR     A0 ,A8                   	;u8 port_prev = port1_prev | port2_prev | port3_prev;
7D93AC 05A9 00023DD0            MOVE   @00023DD0,A9 ,0          	;
7D93B2 05A0 00023DB0            MOVE   @00023DB0,A0 ,0          	;
7D93B8 5409                     OR     A0 ,A9                   	;
7D93BA 05A0 00023DF0            MOVE   @00023DF0,A0 ,0          	;
7D93C0 5409                     OR     A0 ,A9                   	;u8 port_curr = port1_curr | port2_curr | port3_curr;
7D93C2 05A0 0002D1F0            MOVE   @0002D1F0,A0 ,0          	;u16 pos = menu_item_pos;
7D93C8 1FE8                     BTST   #0,A8                   	;
7D93CA CA04                     JREQ   L7D93D4                  	;if (port_prev & 0x01) { //UP
7D93CC 1420                     DEC    A0                       	;  pos--;
7D93CE CF0C                     JRNN   L7D93E8                  	;
7D93D0 5600                     XOR    A0 ,A0                   	;  if (pos < 0) pos = 0;
7D93D2 C00A                     JRUC   L7D93E8                  	;}
L7D93D4:
7D93D4 1FA8                     BTST   #2,A8                   	;
7D93D6 CA08                     JREQ   L7D93E8                  	;else if (port_prev & 0x04) { //DOWN
7D93D8 1020                     INC    A0                       	;  pos++;
7D93DA 05A1 0002D1E0            MOVE   @0002D1E0,A1 ,0          	;
7D93E0 4820                     CMP    A1 ,A0                   	;
7D93E2 C402                     JRLT   L7D93E8                  	;
7D93E4 4C20                     MOVE   A1 ,A0                   	;  if (pos >= menu_item_num) pos = menu_item_num - 1;
7D93E6 1420                     DEC    A0                       	;}
L7D93E8:
7D93E8 0580 0002D1F0            MOVE   A0 ,@0002D1F0,0          	;menu_item_pos = pos;
7D93EE 1F68                     BTST   #4,A8                   	;
7D93F0 CA05                     JREQ   L7D93FC                  	;if (port_prev & 0x10) { //BUTTON1
7D93F2 07A0 0002D200            MOVE   @0002D200,A0 ,1          	;
7D93F8 CA01                     JREQ   L7D93FC                  	;  if (menu_item_handler)
7D93FA 0920                     CALL   A0                       	;    menu_item_handler();
L7D93FC:
7D93FC 0960                     RETS                            	;}

L7D93FE:										;
7D93FE 0D5F FFD04A70            CALLA  L7A094E                  	;
7D9404 191A                     MOVK   #$08,B10                 	;
7D9406 059A C0000150            MOVE   B10,@C0000150,0          	;
7D940C 05A0 001A01C0            MOVE   @001A01C0,A0 ,0          	;
7D9412 CB00 000D                JRNE   L7D9430                  	;
7D9416 5718                     XOR    B8 ,B8                   	;
7D9418 09F9 0C0C0C0C            MOVI   #$0C0C0C0C,B9            	;
7D941E 09E1 00AC0034            MOVI   #$00AC0034,A1            	;
7D9424 09E0 FFFD4B70            MOVI   #$FFFD4B70,A0            	;
7D942A 0D5F FFD02F00            CALLA  L7A05E0                  	;
7D9430 09F7 007C0002            MOVI   #$007C0002,B7            	;
7D9436 19F9                     MOVK   #$0F,B9                  	;
7D9438 09F2 002400AF            MOVI   #$002400AF,B2            	;
7D943E 099F 0100                MMTM   SP ,B,7                	;
7D9442 0FE0                     FILL   XY                       	;
7D9444 09BF 0080                MMFM   SP ,B,7                	;
7D9448 09F2 0024014F            MOVI   #$0024014F,B2            	;
7D944E 099F 0100                MMTM   SP ,B,7                	;
7D9452 0FE0                     FILL   XY                       	;
7D9454 09BF 0080                MMFM   SP ,B,7                	;
7D9458 5600                     XOR    A0 ,A0                   	;
7D945A 0780 00022430            MOVE   A0 ,@00022430,1          	;
7D9460 0780 00022450            MOVE   A0 ,@00022450,1          	;
7D9466 0960                     RETS                            	;





L7D9762:										;void func_25_dipswitch_open()
7D9762 09E0 FFFD7A70            MOVI   #$FFFD7A70,A0            	;
7D9768 0D3F FB72                CALLR  L7D8E50                	;func_25_menu_open(L7FAF4E);
7D976C 0960                     RETS                            	;

7D976E 09C0 0003                MOVI   #$0003,A0                	;
7D9772 C000 0018                JRUC   $00030                   	;
7D9776 09C0 0002                MOVI   #$0002,A0                	;
7D977A C000 0014                JRUC   $00028                   	;
7D977E 09C0 0000                MOVI   #$0000,A0                	;
7D9782 C000 0010                JRUC   $00020                   	;
7D9786 09C0 0004                MOVI   #$0004,A0                	;
7D978A C000 000C                JRUC   $00018                   	;
7D978E 09C0 0001                MOVI   #$0001,A0                	;
7D9792 C000 0008                JRUC   $00010                   	;
7D9796 09C0 0005                MOVI   #$0005,A0                	;
7D979A C000 0004                JRUC   $00008                   	;
L7D979E:
7D979E 09C0 0006                MOVI   #$0006,A0                	;
7D97A2 C000 0000                JRUC   $00000                   	;

L7D97A6:										;(u32 bit)
7D97A6 05A0 20000280            MOVE   @20000280,A0 ,0          	;
7D97AC 03E0                     NOT    A0                       	;
7D97AE 05A1 001A0310            MOVE   @001A0310,A1 ,0          	;
7D97B4 09C2 007F                MOVI   #$007F,A2                	;
7D97B8 5040                     AND    A2 ,A0                   	;
7D97BA 5241                     ANDN   A2 ,A1                   	;
7D97BC 5401                     OR     A0 ,A1                   	;sw1_save = (sw1_save & ~0x7F) | (~SW1 & 0x7F);
7D97BE 0581 001A0310            MOVE   A1 ,@001A0310,0          	;
7D97C4 0960                     RETS                            	;






L7D99A6:										;void func_25_memcheck_open()
7D99A6 0D5F FFD020D0            CALLA  L7A041A                	;fg01_clear();
7D99AC 09E0 FFFD92C0            MOVI   #$FFFD92C0,A0            	;
7D99B2 0D3F FA4D                CALLR  L7D8E50                 	;func_25_menu_open(L7FB258);
7D99B6 09E4 FFFD94D0            MOVI   #$FFFD94D0,A4            	;
7D99BC 0D3F FC31                CALLR  L7D9222                	;draw_strings(testres_str);//L7FB29A
7D99C0 09EA 003C00F0            MOVI   #$003C00F0,A10           	;
7D99C6 5708                     XOR    A8 ,A8                   	;u32 fail = 0;
7D99C8 0550                     SETF   $10,0,0                  	;
7D99CA 05A0 FFFFF000            MOVE   @FFFFF000,A0 ,0          	;
7D99D0 05A1 FFFFF020            MOVE   @FFFFF020,A1 ,0          	;
7D99D6 4C22                     MOVE   A1 ,A2                   	;
7D99D8 2602                     SLL    #16,A2                   	;
7D99DA 5402                     OR     A0 ,A2                   	;
7D99DC 4402                     SUB    A0 ,A2                   	;
7D99DE 4422                     SUB    A1 ,A2                   	;
7D99E0 05A0 FFFFF010            MOVE   @FFFFF010,A0 ,0          	;
7D99E6 05A1 FFFFF030            MOVE   @FFFFF030,A1 ,0          	;
7D99EC 4C23                     MOVE   A1 ,A3                   	;
7D99EE 2603                     SLL    #16,A3                   	;
7D99F0 5403                     OR     A0 ,A3                   	;
7D99F2 4403                     SUB    A0 ,A3                   	;
7D99F4 4423                     SUB    A1 ,A3                   	;
7D99F6 05A0 20000180            MOVE   @20000180,A0 ,0          	;
7D99FC 09E0 FC000000            MOVI   #$FC000000,A0            	;
7D9A02 1905                     MOVK   #$08,A5                  	;
7D9A04 09E1 00040000            MOVI   #$00040000,A1            	;
7D9A0A 9404                     MOVE   *A0 +,A4 ,0              	;
7D9A0C 4082                     ADD    A4 ,A2                   	;
7D9A0E 9404                     MOVE   *A0 +,A4 ,0              	;
7D9A10 4083                     ADD    A4 ,A3                   	;
7D9A12 3CA1                     DSJS   A1 ,#$F6                 	;
7D9A14 05A1 20000180            MOVE   @20000180,A1 ,0          	;
7D9A1A 3D85                     DSJS   A5 ,#$E8                 	;
7D9A1C 4C42                     MOVE   A2 ,A2                   	;
7D9A1E CA00 000A                JREQ   L7D9A36                  	;
7D9A22 09ED 30323155            MOVI   #$30323155,A13           	;
7D9A28 098F 1000                MMTM   SP ,A,3                	;
7D9A2C 0D3F 0065                CALLR  L7D9AFA                 	;
7D9A30 09AF 0008                MMFM   SP ,A,3                	;
7D9A34 2428                     SLL    #1,A8                   	;
7D9A36 4C63                     MOVE   A3 ,A3                   	;
7D9A38 CA00 0005                JREQ   L7D9A46                  	;
7D9A3C 09ED 31323155            MOVI   #$31323155,A13           	;
7D9A42 0D3F 005A                CALLR  L7D9AFA                 	;
7D9A46 0D3F 0079                CALLR  L7D9B3C                 	;draw_pass_fail(fail, {0x003C,0x00F0});
7D9A4A 0570                     SETF   $10,1,0                  	;
7D9A4C 09EA 004C00F0            MOVI   #$004C00F0,A10           	;xy_t pos = {0x004C,0x00F0};
7D9A52 5708                     XOR    A8 ,A8                   	;fail = 0;
7D9A54 09EE FFFD9670            MOVI   #$FFFD9670,A14           	;u8* tbl = L7FB2CE;
L7D9A5A:										;{ 
7D9A5A 97CD                     MOVE   *A14+,A13,1              	;  u8 ic[4] = *(u32*)tbl++;
7D9A5C 97C0                     MOVE   *A14+,A0 ,1              	;  u8* addr = *(u32*)tbl++;
7D9A5E 95CC                     MOVE   *A14+,A12,0              	;  u16 len = *(u16*)tbl++;
7D9A60 95CB                     MOVE   *A14+,A11,0              	;  u16 gap = *(u16*)tbl++;
7D9A62 95C1                     MOVE   *A14+,A1 ,0              	;  u16 st_fse = *(u16*)tbl++;
7D9A64 0182                     GETST  A2                       	;
7D9A66 0B82 00000FFF            ANDI   #$FFFFF000,A2            	;
7D9A6C 5422                     OR     A1 ,A2                   	;
7D9A6E 01A2                     PUTST  A2                       	;
7D9A70 0D3F 0017                CALLR  L7D9AA2                 	;  L7D9AA2(addr,gap,len);
7D9A74 0570                     SETF   $10,1,0                  	;
7D9A76 0740                     SETF   $00,0,1                  	;
7D9A78 4C21                     MOVE   A1 ,A1                   	;
7D9A7A CA00 0002                JREQ   L7D9A82                  	;  if ()
7D9A7E 0D3F 003C                CALLR  L7D9AFA                 	;    L7D9AFA();
7D9A82 8FCD                     MOVB   *A14,A13                 	;  u8 end = *(u8*)tbl;
7D9A84 0B4D 0001                CMPI   #$FFFE,A13               	;
7D9A88 C8E8                     JRLO   L7D9A5A                  	;  if (end == 0xFF) continue;
7D9A8A 110E                     ADDK   #$08,A14                 	;  tbl++;
7D9A8C 4D08                     MOVE   A8 ,A8                   	;
7D9A8E 0D3F 0055                CALLR  L7D9B3C                 	;  draw_pass_fail(fail, pos);
7D9A92 5708                     XOR    A8 ,A8                   	;  fail = 0;
7D9A94 0B2A 00100000            ADDI   #$00100000,A10           	;  pos.y += 16;
7D9A9A 0B4D 0001                CMPI   #$FFFE,A13               	;
7D9A9E CBDD                     JRNE   L7D9A5A                  	;} while (end != 0xFE);
7D9AA0 0960                     RETS                            	;

L7D9AA2:										;(u8* addr,u16 gap,u16 len)//addr-A0,gap-A11,len-A12
7D9AA2 5642                     XOR    A2 ,A2                   	;
7D9AA4 09E3 55555555            MOVI   #$55555555,A3            	;
7D9AAA 0523                     ZEXT   A3 ,0                    	;
7D9AAC 09E4 AAAAAAAA            MOVI   #$AAAAAAAA,A4            	;
7D9AB2 0524                     ZEXT   A4 ,0                    	;
7D9AB4 09C5 FFFF                MOVI   #$FFFF,A5                	;
7D9AB8 0525                     ZEXT   A5 ,0                    	;
L7D9ABA:
7D9ABA 09C1 0100                MOVI   #$0100,A1                	;for (int i=0;i<len;i++) {
L7D9ABE:
7D9ABE 8406                     MOVE   *A0 ,A6 ,0               	;  for (int j=0;j<256;j++) {
7D9AC0 8040                     MOVE   A2 ,*A0 ,0               	;
7D9AC2 8407                     MOVE   *A0 ,A7 ,0               	;
7D9AC4 4847                     CMP    A2 ,A7                   	;
7D9AC6 CB00 0017                JRNE   L7D9AF8                  	;
7D9ACA 8060                     MOVE   A3 ,*A0 ,0               	;
7D9ACC 8407                     MOVE   *A0 ,A7 ,0               	;
7D9ACE 4867                     CMP    A3 ,A7                   	;
7D9AD0 CB00 0012                JRNE   L7D9AF8                  	;
7D9AD4 8080                     MOVE   A4 ,*A0 ,0               	;
7D9AD6 8407                     MOVE   *A0 ,A7 ,0               	;
7D9AD8 4887                     CMP    A4 ,A7                   	;
7D9ADA CB00 000D                JRNE   L7D9AF8                  	;
7D9ADE 80A0                     MOVE   A5 ,*A0 ,0               	;
7D9AE0 8407                     MOVE   *A0 ,A7 ,0               	;
7D9AE2 48A7                     CMP    A5 ,A7                   	;
7D9AE4 CB00 0008                JRNE   L7D9AF8                  	;
7D9AE8 80C0                     MOVE   A6 ,*A0 ,0               	;
7D9AEA 9606                     MOVE   *A0 +,A6 ,1              	;
7D9AEC 3F01                     DSJS   A1 ,L7D9ABE               	;  }
7D9AEE 05A7 20000180            MOVE   @20000180,A7 ,0          	;
7D9AF4 4160                     ADD    A11,A0                   	;  addr += gap;
7D9AF6 3FEC                     DSJS   A12,L7D9ABA              	;}
7D9AF8 0960                     RETS                            	;
7D9AFA 4D00                     MOVE   A8 ,A0                   	;
7D9AFC 2FC0                     SRL    #2,A0                   	;
7D9AFE 2660                     SLL    #19,A0                   	;
7D9B00 4D09                     MOVE   A8 ,A9                   	;
7D9B02 0B89 FFFFFFFC            ANDI   #$00000003,A9            	;
7D9B08 1069                     ADDK   #$03,A9                  	;
7D9B0A 24A9                     SLL    #5,A9                   	;
7D9B0C 5409                     OR     A0 ,A9                   	;
7D9B0E E149                     ADDXY  A10,A9                   	;
7D9B10 0D5F FFD02FF0            CALLA  L7A05FE                  	;
7D9B16 09F9 0C0C0C0C            MOVI   #$0C0C0C0C,B9            	;
7D9B1C 1883                     MOVK   #$04,A3                  	;
7D9B1E 4DA0                     MOVE   A13,A0                   	;
7D9B20 0B80 FFFFFF00            ANDI   #$000000FF,A0            	;
7D9B26 2F0D                     SRL    #8,A13                  	;
7D9B28 1400                     SUBK   #$20,A0                  	;
7D9B2A 24C0                     SLL    #6,A0                   	;
7D9B2C 4040                     ADD    A2 ,A0                   	;
7D9B2E 4E00                     MOVE   A0 ,B0                   	;
7D9B30 4F22                     MOVE   A9 ,B2                   	;
7D9B32 0FA0                     PIXBLT B,XY                     	;
7D9B34 1109                     ADDK   #$08,A9                  	;
7D9B36 3DA3                     DSJS   A3 ,#$E6                 	;
7D9B38 1028                     INC    A8                       	;
7D9B3A 0960                     RETS                            	;

L7D9B3C:										;void draw_pass_fail(int v, xy_t pos)//v-A8,pos-A10
7D9B3C 09E0 FFFD5140            MOVI   #$FFFD5140,A0            	;
7D9B42 09F9 07070707            MOVI   #$07070707,B9            	;
7D9B48 4D08                     MOVE   A8 ,A8                   	;
7D9B4A CA00 0006                JREQ   L7D9B5A                  	;
7D9B4E 09E0 FFFD5170            MOVI   #$FFFD5170,A0            	;u8* s = !v ? L7FAA28 : L7FAA2E;
7D9B54 09F9 0C0C0C0C            MOVI   #$0C0C0C0C,B9            	;COLOR1 = !v ? 0x07070707: 0x0C0C0C0C;
L7D9B5A:
7D9B5A 4D41                     MOVE   A10,A1                   	;
7D9B5C 0D5F FFD02F00            CALLA  L7A05E0                  	;draw_string(s,pos);
7D9B62 09F9 07070707            MOVI   #$07070707,B9            	;COLOR1 = 0x07070707;
7D9B68 0960                     RETS                            	;


