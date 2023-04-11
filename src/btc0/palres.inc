L7FB444:
	dc.l	0xFFFDA470								;L7FB48E
	dc.l	0xFFFDA4E0								;
	dc.l	0xFFFDA570								;
	dc.l	0xFFFDA610								;
	dc.l	0xFFFDA680								;
	dc.l	0xFFFDA700								;
	dc.l	0xFFFDA7A0								;
	dc.l	0xFFFDA880								;
	dc.l	0xFFFDA920								;
	dc.l	0xFFFDA9C0								;
	dc.l	0xFFFDAA50								;
	dc.l	0xFFFDA920								;
L7FB48E:
	dc.w	0x0000,0x0002,0x0001,0x0008,0x0003,0x0004,0xFFFF 
	dc.w	0x0000,0x0002,0x0001,0x0008,0x0005,0x001D,0x000B,0x0051,0xFFFF 
	dc.w	0x0004,0x0007,0x0000,0x0002,0x0001,0x0008,0x000E,0x0089,0x000C,0xFFFF 
	dc.w	0x0000,0x0002,0x0001,0x0008,0x000F,0x0011,0xFFFF 
	dc.w	0x0000,0x0002,0x0041,0x0008,0x001C,0x0015,0x0013,0xFFFF 
	dc.w	0x0000,0x0002,0x0001,0x0008,0x0003,0x0018,0x0027,0x0028,0x0026,0xFFFF 
	dc.w	0x0004,0x0000,0x0002,0x0001,0x0008,0x000C,0x000D,0x000E,0x0024,0x0025,0x001B,0x0022,0x0023,0xFFFF 
	dc.w	0x0000,0x0002,0x0001,0x0008,0x0003,0x0018,0x0027,0x0028,0x0026,0xFFFF 
	dc.w	0x001C,0x0004,0x0000,0x0002,0x0001,0x0008,0x0029,0x002A,0x002C,0xFFFF 
	dc.w	0x0003,0x0004,0x0000,0x0002,0x0001,0x0008,0x002B,0x0035,0xFFFF 
	dc.w	0x0003,0x0004,0x0000,0x0002,0x0001,0x0008,0x002D,0x002E,0x0033,0x002F,0xFFFF 
	dc.w	0x0000,0x0002,0x0001,0x0008,0x007D,0xFFFF 


L7FB5E0:										;void load_pal_9D()
7FB5E0 09E0 0000009D            MOVI   #$0000009D,A0            	;
7FB5E6 C000 0049                JRUC   L7FB67C                  	;load_pal_by_id(0x9D);

7FB5EA 1A40                     MOVK   #$12,A0                  	;
7FB5EC C000 0046                JRUC   $0008C                   	;
7FB5F0 09E0 00000037            MOVI   #$00000037,A0            	;
7FB5F6 0D3F 0041                CALLR  #$00082                 	;
7FB5FA 09E0 0000003C            MOVI   #$0000003C,A0            	;
7FB600 C000 003C                JRUC   $00078                   	;

L7FB604:										;void load_pal_01_08_40()
7FB604 09E0 00000001            MOVI   #$00000001,A0            	;
7FB60A 0D3F 0037                CALLR  L7FB67C                 	;load_pal_by_id(0x01);
7FB60E 09E0 00000008            MOVI   #$00000008,A0            	;
7FB614 0D3F 0032                CALLR  L7FB67C                 	;load_pal_by_id(0x08);
7FB618 09E0 00000040            MOVI   #$00000040,A0            	;
7FB61E C000 002D                JRUC   L7FB67C                  	;load_pal_by_id(0x40);

7FB622 09E1 FFFDA3A0            MOVI   #$FFFDA3A0,A1            	;
7FB628 C000 0018                JRUC   $00030                   	;
7FB62C 05A1 0002C630            MOVE   @0002C630,A1 ,0          	;
7FB632 24A1                     SLL    #5,A1                   	;
7FB634 0B21 FFFDA0A0            ADDI   #$FFFDA0A0,A1            	;
7FB63A 8621                     MOVE   *A1 ,A1 ,1               	;
7FB63C C00F                     JRUC   $01E                     	;

L7FB63E:										;void load_pal_by_list()
7FB63E 05A1 0002C630            MOVE   @0002C630,A1 ,0          	;
7FB644 24A1                     SLL    #5,A1                   	;
7FB646 0B21 FFFDA220            ADDI   #$FFFDA220,A1            	;
7FB64C 8621                     MOVE   *A1 ,A1 ,1               	;u16* ptr = L7FB444[*(u16*)0x0002C630];
7FB64E C006                     JRUC   L7FB65C                  	;
L7FB650:
7FB650 098F 4000                MMTM   SP ,#$4000                	;while ((id = *ptr++) != 0xFFFF) {
7FB654 0D3F 0012                CALLR  L7FB67C                 	;  load_pal_by_id(id);
7FB658 09AF 0002                MMFM   SP ,#$0002                	;
L7FB65C:
7FB65C 9420                     MOVE   *A1+,A0 ,0              	;
7FB65E CFF8                     JRNN   L7FB650                  	;}
7FB660 0960                     RETS                            	;

7FB662 09F0 00058C50            MOVI   #$00058C50,B0            	;
7FB668 09F2 00022470            MOVI   #$00022470,B2            	;pal_buf
7FB66E 09D7 0300                MOVI   #$0300,B7                	;
L7FB672:
7FB672 9C12                     MOVB   *B0 ,*B2                  	;
7FB674 1110                     ADDK   #$08,B0                  	;
7FB676 1112                     ADDK   #$08,B2                  	;
7FB678 3C97                     DSJS   B7 ,L7FB672             	;
7FB67A 0960                     RETS                            	;

L7FB67C:										;void load_pal_by_id(u32 id)
7FB67C 4C03                     MOVE   A0 ,A3                   	;
7FB67E 24C3                     SLL    #6,A3                   	;
7FB680 0B23 FFFDB5C0            ADDI   #$FFFDB5C0,A3            	;palres_t entry = palette_resources[id];
7FB686 9660                     MOVE   *A3+,A0 ,1              	;u8* src = entry.dst;
7FB688 9462                     MOVE   *A3+,A2 ,0              	;u16 pos = entry.pos;
7FB68A 8461                     MOVE   *A3 ,A1 ,0               	;u16 num = entry.num;
7FB68C 2481                     SLL    #4,A1                   	;
7FB68E 4C23                     MOVE   A1 ,A3                   	;
7FB690 2421                     SLL    #1,A1                   	;
7FB692 4061                     ADD    A3 ,A1                   	;
7FB694 C080 FFD02AA0            JRUC   L7A0554                	;load_pal(src,num*16*3,pos);

7FB69A 4C03                     MOVE   A0 ,A3                   	;
7FB69C 24C3                     SLL    #6,A3                   	;
7FB69E 0B23 FFFDB5C0            ADDI   #$FFFDB5C0,A3            	;
7FB6A4 9660                     MOVE   *A3 +,A0 ,1              	;
7FB6A6 1203                     ADDK   #$10,A3                  	;
7FB6A8 8461                     MOVE   *A3 ,A1 ,0               	;
7FB6AA 2481                     SLL    #4,A1                   	;
7FB6AC 4C23                     MOVE   A1 ,A3                   	;
7FB6AE 2421                     SLL    #1,A1                   	;
7FB6B0 4061                     ADD    A3 ,A1                   	;
7FB6B2 C080 FFD026A0            JRUC   $FFD026A0                	;

L7FB6B8:										;palres_t palette_resources[] = {
	dc.l	0xFFCA2CB0
	dc.w	0x00D0,0x0001 
	dc.l	0xFFCA2FB0 
	dc.w	0x00F0,0x0001 
	dc.l	0xFFCA3130 
	dc.w	0x00E0,0x0001 
	dc.l	0xFFCA3730 
	dc.w	0x0000,0x0008 
	dc.l	0xFFCA4F30 
	dc.w	0x0080,0x0004 
	dc.l	0xFFCA7630 
	dc.w	0x0000,0x0008 
	dc.l	0xFFCA8230 
	dc.w	0x0080,0x0001 
	dc.l	0xFFCA5E30 
	dc.w	0x0000,0x0010 
	dc.l	0xFFCA2B30 
	dc.w	0x00C0,0x0001 
	dc.l	0xFFCA29B0 
	dc.w	0x0090,0x0001 
	dc.l	0xFFCA2830 
	dc.w	0x00A0,0x0001 
	dc.l	0xFFCA26B0 
	dc.w	0x00B0,0x0001 
	dc.l	0xFFCA2530 
	dc.w	0x00A0,0x0001 
	dc.l	0xFFCA23B0 
	dc.w	0x0090,0x0001 
	dc.l	0xFFCA20B0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFCA0D30 
	dc.w	0x0000,0x000C 
	dc.l	0xFFCA0D30 
	dc.w	0x00A0,0x0001 
	dc.l	0xFFCA0BB0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC9FFB0 
	dc.w	0x0000,0x0004 
	dc.l	0xFFC9FE30 
	dc.w	0x00B0,0x0001 
	dc.l	0xFFC9FCB0 
	dc.w	0x00A0,0x0001 
	dc.l	0xFFCA5830 
	dc.w	0x0080,0x0004 
	dc.l	0xFFC9FCB0 
	dc.w	0x0000,0x0002 
	dc.l	0xFFC9FCB0 
	dc.w	0x0000,0x0002 
	dc.l	0xFFC9FB30 
	dc.w	0x00B0,0x0001 
	dc.l	0xFFC9FB30 
	dc.w	0x0000,0x0002 
	dc.l	0xFFC9FB30 
	dc.w	0x0090,0x0001 
	dc.l	0xFFC9FB30 
	dc.w	0x0080,0x0001 
	dc.l	0xFFCA4330 
	dc.w	0x0000,0x0008 
	dc.l	0xFFC9F530 
	dc.w	0x0080,0x0004 
	dc.l	0xFFCA05B0 
	dc.w	0x0080,0x0004 
	dc.l	0xFFCA32B0 
	dc.w	0x00D0,0x0001 
	dc.l	0xFFCA35B0 
	dc.w	0x00F0,0x0001 
	dc.l	0xFFCA3430 
	dc.w	0x00E0,0x0001 
	dc.l	0xFFC9F530 
	dc.w	0x0090,0x0001 
	dc.l	0xFFC9F530 
	dc.w	0x00A0,0x0001 
	dc.l	0xFFC9F530 
	dc.w	0x0000,0x0006 
	dc.l	0xFFC9F530 
	dc.w	0x00B0,0x0001 
	dc.l	0xFFC9E330 
	dc.w	0x0000,0x000C 
	dc.l	0xFFC9E1B0 
	dc.w	0x00A0,0x0001 
	dc.l	0xFFC9E030 
	dc.w	0x0090,0x0001 
	dc.l	0xFFC9D730 
	dc.w	0x0000,0x0006 
	dc.l	0xFFC9D2B0 
	dc.w	0x0090,0x0003 
	dc.l	0xFFC9C230 
	dc.w	0x0010,0x000B 
	dc.l	0xFFC9C0B0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC9B4B0 
	dc.w	0x0000,0x0008 
	dc.l	0xFFC9B1B0 
	dc.w	0x00A0,0x0002 
	dc.l	0xFFFDE058 
	dc.w	0x0090,0x0001 
	dc.l	0xFFC9AD30 
	dc.w	0x0080,0x0003 
	dc.l	0xFFFDE6E8 
	dc.w	0x00A0,0x0001 
	dc.l	0xFFFDE868 
	dc.w	0x00A0,0x0001 
	dc.l	0xFFCA56B0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC9C230 
	dc.w	0x0090,0x0003 
	dc.l	0xFFC9AD30 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC9ABB0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC9A2B0 
	dc.w	0x0010,0x0006 
	dc.l	0xFFC9A130 
	dc.w	0x00F0,0x0001 
	dc.l	0xFFC99FB0 
	dc.w	0x00E0,0x0001 
	dc.l	0xFFC99E30 
	dc.w	0x00D0,0x0001 
	dc.l	0xFFC9A130 
	dc.w	0x00C0,0x0001 
	dc.l	0xFFC99CB0 
	dc.w	0x0000,0x0001 
	dc.l	0xFFC99CB0 
	dc.w	0x0000,0x000C 
	dc.l	0xFFC99C68 
	dc.w	0x00C0,0x0001 
	dc.l	0xFFC99C20 
	dc.w	0x00B0,0x0001 
	dc.l	0xFFC99AA0 
	dc.w	0x0000,0x0001 
	dc.l	0xFFCA2E30 
	dc.w	0x00F0,0x0001 
	dc.l	0xFFC99920 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC997A0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC99620 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC994A0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC99320 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC991A0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC98D20 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC98EA0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC99020 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC988A0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC98A20 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC98BA0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC98720 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC985A0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC982A0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC97FA0 
	dc.w	0x0000,0x0001 
	dc.l	0xFFC97FA0 
	dc.w	0x0000,0x000F 
	dc.l	0xFFC98120 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC98420 
	dc.w	0x0080,0x0001 
	dc.l	0xFFCA3130 
	dc.w	0x00F0,0x0001 
	dc.l	0xFFCA2FB0 
	dc.w	0x00E0,0x0001 
	dc.l	0xFFC97CA0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC97E20 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC97B20 
	dc.w	0x0070,0x0001 
	dc.l	0xFFC979A0 
	dc.w	0x0020,0x0001 
	dc.l	0xFFC97820 
	dc.w	0x00A0,0x0001 
	dc.l	0xFFC9E330 
	dc.w	0x0000,0x0001 
	dc.l	0xFFC97520 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC976A0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC970A0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC97220 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC973A0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC97058 
	dc.w	0x0080,0x0001 
	dc.l	0xFFCA5530 
	dc.w	0x00B0,0x0001 
	dc.l	0xFFC96ED8 
	dc.w	0x0000,0x0001 
	dc.l	0xFFC96ED8 
	dc.w	0x0000,0x0001 
	dc.l	0xFFC96ED8 
	dc.w	0x0000,0x0001 
	dc.l	0xFFC956D8 
	dc.w	0x0000,0x0010 
	dc.l	0xFFC94058 
	dc.w	0x0000,0x000F 
	dc.l	0xFFC92858 
	dc.w	0x0000,0x0010 
	dc.l	0xFFC91058 
	dc.w	0x0000,0x0010 
	dc.l	0xFFC8F858 
	dc.w	0x0000,0x0010 
	dc.l	0xFFC8C6D8 
	dc.w	0x0000,0x0001 
	dc.l	0xFFC8E058 
	dc.w	0x0000,0x0010 
	dc.l	0xFFC8C858 
	dc.w	0x0000,0x0010 
	dc.l	0xFFFDE1D8 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC9B1B0 
	dc.w	0x00A0,0x0001 
	dc.l	0xFFC8C258 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC8C3D8 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC8C558 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC8BDD8 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC8BF58 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC8C0D8 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC8B7D8 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC8BC58 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC8B958 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC8BAD8 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC8B658 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC9B1B0 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC8B058 
	dc.w	0x0000,0x0004 
	dc.l	0xFFC8B358 
	dc.w	0x0020,0x0001 
	dc.l	0xFFC8B4D8 
	dc.w	0x0030,0x0001 
	dc.l	0xFFC89858 
	dc.w	0x0000,0x0010 
	dc.l	0xFFC896D8 
	dc.w	0x0000,0x0001 
	dc.l	0xFFC89258 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC893D8 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC89558 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC88DD8 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC88F58 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC890D8 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC9B330 
	dc.w	0x0080,0x0001 
	dc.l	0xFFFDDED8 
	dc.w	0x0030,0x0001 
	dc.l	0xFFFDDD40 
	dc.w	0x00A0,0x0001 
	dc.l	0xFFCA2230 
	dc.w	0x0090,0x0001 
	dc.l	0xFFCA1F30 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC88C58 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC884D8 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC88658 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC887D8 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC88958 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC88AD8 
	dc.w	0x0080,0x0001 
	dc.l	0xFFC86CD8 
	dc.w	0x0000,0x0010 
	dc.l	0xFFC854D8 
	dc.w	0x0000,0x0010 
	dc.l	0xFFC83CD8 
	dc.w	0x0000,0x0010 
	dc.l	0xFFC81800 
	dc.w	0x0000,0x0004 
	dc.l	0xFFC81E00 
	dc.w	0x0000,0x0004 
	dc.l	0xFFC82400 
	dc.w	0x0000,0x0004 
	dc.l	0xFFC82A00 
	dc.w	0x0000,0x0003 
	dc.l	0xFFC82E80 
	dc.w	0x00A0,0x0003 
	dc.l	0xFFC83858 
	dc.w	0x0050,0x0003 
	dc.l	0xFFC83258 
	dc.w	0x0040,0x0004 
	dc.l	0xFFC80000 
	dc.w	0x0000,0x0010 
