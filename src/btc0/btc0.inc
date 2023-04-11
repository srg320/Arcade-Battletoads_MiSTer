0x00000000-0x00001FFF		;u8 stack[0x400];

					;struct {
					;  u16 id;//0x000
					;
					;  s32 z;//24.8 //0x020
					;  s32 x;//24.8 //0x040
					;  s32 y;//24.8 //0x060
					;  s16 m80;//0x080
					;  s16 m90;//0x090
					;  s16 mA0;//0x0A0
					;  u16 mB0;//0x0B0

					;  u6 mE0;//0xE0

					;  u8 mF8;//0xF8
					;  u16 m100;//0x100

					;  u16 dx;//8.8 //0x120
					;  u16 dy;//8.8 //0x130

					;  u1 m141;//0x141

					;  u1 m190;//0x190
					;  u1 m191;//0x191
					;  u2 m196;//0x196

					;  u1 m19C;//0x19C
					;  u16 m1C0;//0x1C0
					;
					;  u16 pal;//0x2C0
					;  u32 m320;//0x320
					;} obj_t;
0x00002000-0x00021FFF		;obj_t obj_array[128];

0x00022400  			;u16 spr_ctrl;
0x00022410  			;u16 di_flag;
0x00022420  			;u16 fg_vram_sel;
0x00022470				;u8 pal_buf[256*3];

0x00023C90  			;u32 frame_count;

0x00023D70 				;u32 port_all_curr;
0x00023D90 				;u32 port_all_prev;
0x00023DB0 				;u8 port1_curr;
0x00023DC0 				;u8 port1_prev;
0x00023DD0 				;u8 port2_curr;
0x00023DE0 				;u8 port2_prev;
0x00023DF0 				;u8 port3_curr;
0x00023E00 				;u8 port3_prev;

0x00023E10  			;u16 main_fn;
0x00023E20  			;u16 ;
0x00023E50  			;u16 ;
0x00023E60  			;u16 ;
0x00023EA0  			;u16 ;
0x00023EB0  			;u16 ;
0x00023EC0  			;u16 ;
0x00023ED0  			;u16 ;
0x00023EF0  			;u16 ;

0x00023F10  			;u16 ;
0x00023F30  			;u16 ;
0x00023F50 				;void* ;

0x00023F90  			;u16 ;
0x00023FA0  			;u16 ;

0x00024010 				;void* ;

0x00024110 				;s32 ;
0x00024130 				;s32 ;
0x00024150  			;u16 ;
0x00024170  			;u16 ;

0x00024250   			;u16 ;

0x00024750  			;u16 ;

0x00026A50   			;u16 ;

0x00026E90  			;u16 ;

0x00027690  			;u16 ;

0x00027E90  			;u16 ;

0x0002A270 				;u16 obj_num;
0x0002A280-0x0002AA7F		;u16 obj_pos_list[128];
0x0002AA80				;u16 ;

0x0002AC50 				;u16 ;

0x0002AD00 				;u16 pal_fade;

0x0002C600 				;u16 ;
0x0002C610 				;u16 ;
0x0002C630				;u16 ;
0x0002C660 				;u16 ;
0x0002C6D0 				;u16 ;

0x0002C720				;u16 ; 

0x0002C800-0x0002CFFF		;u8 z80_data_buf[256];
0x0002D000 				;u8 *z80_data_curr;
0x0002D020 				;u8 *z80_data_last;
0x0002D040 				;u16 z80_resp0;
0x0002D050 				;u16 z80_resp1;
0x0002D060 				;u16 z80_resp2;
0x0002D070 				;u16 ;
0x0002D080 				;u16 ;

0x0002D0C0				;u8 hex_str[10];

0x0002D150				;void* menu_draw_tbl;
0x0002D170-0x0002D18F		;xy_t str_draw_pos;
0x0002D190 				;u16 menu_normal_color;
0x0002D1A0 				;u16 menu_active_color;
0x0002D1B0 				;u16 str_draw_color;
0x0002D1C0 				;u16 ;
0x0002D1D0 				;u16 str_draw_color2;
0x0002D1E0 				;u16 menu_item_num;
0x0002D1F0  			;u16 menu_item_pos;
0x0002D200  			;void* menu_item_handler;

0x0002D270				;u16 ;
0x0002D280 				;u16 ;
0x0002D290 				;u16 [3];
0x0002D2C0 				;u16 [3];
0x0002D2F0 				;u16 [3];

0x0002D570				;u16 [];

0x000555C0				;u8 pallete[256*3];

0x00056EC0 				;u16 []

0x000576C0 				;void *di_int_table;

0x00057950 				;u32 

0x00057990				;u16 

0x00057B30-0x00057D2F		;u16 scroll_ctrl[2][16];

0x00057D40				;u16 di_int_pos;

0x00058640				;u16 
0x00058650				;u16 disp_ctrl;

0x00058A40 				;u32 ;

0x00058B80				;u16 frame_miss_flags;
0x00058B90				;u16 ;

0x00058C10 				;u16 ;

0x0005ED80				;u16 misc_ctrl;
0x0005ED90				;u16 ;

0x0005EF00				;u8 img_buf[];

0x0019EF00 				;u16 ;
0x0019EF60 				;u16 target_fade;

0x0019F170  			;u16 timer;

0x001A01B0-0x001A01B7		;u8
0x001A01B8-0x001A01BF		;u8
0x001A01C0 				;u16 ;

0x001A0210 				;u32 ;

0x001A0270-0x001A02FF
0x001A0300
0x001A0310				;u16 sw1_save;
0x001A0320
0x001A0330
0x001A0340 
0x001A0350 
0x001A0360

0x001A0390-0x001A090F		;u8 [0xB0];
0x001A0820 				;u16
0x001A0830 				;u16
0x001A0840 				;u16
0x001A0850 				;u16
0x001A0890				;u8 

0x001A0910-0x001A092F		;

0x001A0930-0x001A329F		;u8 [0x52E];


0x001A2940-0x001A32BF
