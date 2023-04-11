; Disassembly of the file "D:\Docs\bt\roms\bt.u102"
; 
; CPU Type: Z80
; 
; Created with dZ80 2.0
; 
; on Thursday, 09 of February 2023 at 01:58 PM
; 
0000 f3        di      
0001 310000    ld      sp,0000h
0004 ed56      im      1
0006 c30001    jp      0100h
0009 45        ld      b,l
000a 4c        ld      c,h
000b 2000      jr      nz,000dh
000d 00        nop     
000e 00        nop     
000f 00        nop     
0010 a8        xor     b
0011 1d        dec     e
0012 46        ld      b,(hl)
0013 0f        rrca    
0014 00        nop     
0015 00        nop     
0016 73        ld      (hl),e
0017 8a        adc     a,d
0018 91        sub     c
0019 1b        dec     de
001a d1        pop     de
001b 52        ld      d,d
001c bd        cp      l
001d 45        ld      b,l
001e 00        nop     
001f 00        nop     
0020 53        ld      d,e
0021 45        ld      b,l
0022 54        ld      d,h
0023 55        ld      d,l
0024 50        ld      d,b
0025 2020      jr      nz,0047h
0027 2058      jr      nz,0081h
0029 52        ld      d,d
002a 46        ld      b,(hl)
002b 2000      jr      nz,002dh
002d 00        nop     
002e 00        nop     
002f 00        nop     
0030 00        nop     
0031 00        nop     
0032 00        nop     
0033 00        nop     
0034 00        nop     
0035 00        nop     
0036 73        ld      (hl),e
0037 8a        adc     a,d
0038 f5        push    af
0039 c5        push    bc
003a d5        push    de
003b e5        push    hl
003c d9        exx     
003d 08        ex      af,af'
003e f5        push    af
003f c5        push    bc
0040 d5        push    de
0041 e5        push    hl
0042 211d95    ld      hl,951dh
0045 34        inc     (hl)
0046 cd5306    call    0653h
0049 010280    ld      bc,8002h
004c 3e80      ld      a,80h
004e ed79      out     (c),a
0050 e1        pop     hl
0051 d1        pop     de
0052 c1        pop     bc
0053 f1        pop     af
0054 08        ex      af,af'
0055 d9        exx     
0056 e1        pop     hl
0057 d1        pop     de
0058 c1        pop     bc
0059 f1        pop     af
005a fb        ei      
005b ed4d      reti    

005d 64        ld      h,h
005e 00        nop     
005f 00        nop     
0060 53        ld      d,e
0061 45        ld      b,l
0062 54        ld      d,h
0063 55        ld      d,l
0064 50        ld      d,b
0065 20ed      jr      nz,0054h
0067 45        ld      b,l
0068 24        inc     h
0069 59        ld      e,c
006a 4d        ld      c,l
006b 2000      jr      nz,006dh
006d 00        nop     
006e 00        nop     
006f 00        nop     
0070 00        nop     
0071 00        nop     
0072 00        nop     
0073 00        nop     
0074 00        nop     
0075 00        nop     
0076 73        ld      (hl),e
0077 8a        adc     a,d
0078 91        sub     c
0079 1b        dec     de
007a db52      in      a,(52h)
007c 80        add     a,b
007d 64        ld      h,h
007e 00        nop     
007f 00        nop     
0080 4e        ld      c,(hl)
0081 50        ld      d,b
0082 43        ld      b,e
0083 2020      jr      nz,00a5h
0085 2020      jr      nz,00a7h
0087 2052      jr      nz,00dbh
0089 45        ld      b,l
008a 4c        ld      c,h
008b 2000      jr      nz,008dh
008d 00        nop     
008e 00        nop     
008f 00        nop     
0090 00        nop     
0091 00        nop     
0092 00        nop     
0093 00        nop     
0094 00        nop     
0095 00        nop     
0096 74        ld      (hl),h
0097 8a        adc     a,d
0098 91        sub     c
0099 1b        dec     de
009a f5        push    af
009b 52        ld      d,d
009c a3        and     e
009d 2f        cpl     
009e 00        nop     
009f 00        nop     
00a0 4e        ld      c,(hl)
00a1 50        ld      d,b
00a2 43        ld      b,e
00a3 2020      jr      nz,00c5h
00a5 2020      jr      nz,00c7h
00a7 2058      jr      nz,0101h
00a9 52        ld      d,d
00aa 46        ld      b,(hl)
00ab 2000      jr      nz,00adh
00ad 00        nop     
00ae 00        nop     
00af 00        nop     
00b0 00        nop     
00b1 00        nop     
00b2 00        nop     
00b3 00        nop     
00b4 00        nop     
00b5 00        nop     
00b6 74        ld      (hl),h
00b7 8a        adc     a,d
00b8 91        sub     c
00b9 1b        dec     de
00ba ea5285    jp      pe,8552h
00bd 07        rlca    
00be 00        nop     
00bf 00        nop     
00c0 4e        ld      c,(hl)
00c1 50        ld      d,b
00c2 43        ld      b,e
00c3 2020      jr      nz,00e5h
00c5 2020      jr      nz,00e7h
00c7 2053      jr      nz,011ch
00c9 59        ld      e,c
00ca 4d        ld      c,l
00cb 2000      jr      nz,00cdh
00cd 00        nop     
00ce 00        nop     
00cf 00        nop     
00d0 00        nop     
00d1 00        nop     
00d2 00        nop     
00d3 00        nop     
00d4 00        nop     
00d5 00        nop     
00d6 74        ld      (hl),h
00d7 8a        adc     a,d
00d8 91        sub     c
00d9 1b        dec     de
00da eb        ex      de,hl
00db 52        ld      d,d
00dc 4d        ld      c,l
00dd 51        ld      d,c
00de 00        nop     
00df 00        nop     
00e0 4e        ld      c,(hl)
00e1 50        ld      d,b
00e2 43        ld      b,e
00e3 2020      jr      nz,0105h
00e5 2020      jr      nz,0107h
00e7 2024      jr      nz,010dh
00e9 59        ld      e,c
00ea 4d        ld      c,l
00eb 2000      jr      nz,00edh
00ed 00        nop     
00ee 00        nop     
00ef 00        nop     
00f0 00        nop     
00f1 00        nop     
00f2 00        nop     
00f3 00        nop     
00f4 00        nop     
00f5 00        nop     
00f6 74        ld      (hl),h
00f7 8a        adc     a,d
00f8 91        sub     c
00f9 1b        dec     de
00fa f8        ret     m

00fb 52        ld      d,d
00fc 50        ld      d,b
00fd 51        ld      d,c
00fe 00        nop     
00ff 00        nop     

0100 cd240d    call    0d24h
0103 210080    ld      hl,8000h
0106 44        ld      b,h
0107 4d        ld      c,l
0108 1e00      ld      e,00h
010a 73        ld      (hl),e
010b 23        inc     hl
010c 0b        dec     bc
010d 78        ld      a,b
010e b1        or      c
010f 20f9      jr      nz,010ah
0111 3e01      ld      a,01h
0113 323ed8    ld      (0d83eh),a
0116 21781d    ld      hl,1d78h
0119 111e95    ld      de,951eh
011c 010003    ld      bc,0300h
011f edb0      ldir    
0121 21671d    ld      hl,1d67h
0124 111ed8    ld      de,0d81eh
0127 012000    ld      bc,0020h
012a edb0      ldir    
012c 1e54      ld      e,54h
012e cd4b0d    call    0d4bh		;send_resp_to_main(0x54);
0131 1e6f      ld      e,6fh
0133 cd4b0d    call    0d4bh		;send_resp_to_main(0x6F);
0136 1e61      ld      e,61h
0138 cd4b0d    call    0d4bh		;send_resp_to_main(0x61);
013b 1e64      ld      e,64h
013d cd4b0d    call    0d4bh		;send_resp_to_main(0x64);
0140 1e52      ld      e,52h
0142 cd370d    call    0d37h		;wait_ctrl_from_main(0x52)
0145 1e61      ld      e,61h
0147 cd370d    call    0d37h		;wait_ctrl_from_main(0x61)
014a 1e72      ld      e,72h
014c cd370d    call    0d37h		;wait_ctrl_from_main(0x72)
014f 1e65      ld      e,65h
0151 cd370d    call    0d37h		;wait_ctrl_from_main(0x65)
0154 fb        ei      
L0155:
0155 fb        ei      			;main_loop:
0156 010480    ld      bc,8004h
0159 cd5a0d    call    0d5ah		;u8 c = receive_ctrl_from_main();
015c fe3f      cp      3fh
015e 300e      jr      nc,L016e	;if (c <= 0x3F) {
0160 cb27      sla     a
0162 6f        ld      l,a
0163 2600      ld      h,00h
0165 117c01    ld      de,017ch
0168 19        add     hl,de		;  u16* ptr = 0x017C + (c << 1);
0169 7e        ld      a,(hl)
016a 23        inc     hl
016b 66        ld      h,(hl)
016c 6f        ld      l,a
016d e9        jp      (hl)		;  goto ptr;
L016e:					;}
016e 11eeee    ld      de,0eeeeh
0171 21bbee    ld      hl,0eebbh
0174 3eee      ld      a,0eeh
0176 01eeee    ld      bc,0eeeeh
0179 c38604    jp      L0486		;else goto cmd_failed;

L017c:
	dc.w	L01fa				;  nop,
	dc.w	L0215				;
	dc.w	L0220				;
	dc.w	L0298				;
	dc.w	L041d				;  send_BC_to_main,
	dc.w	L042d				;  send_11_to_main,
	dc.w	0x0241
	dc.w	0x043d
	dc.w	0x027d
	dc.w	0x046a
	dc.w	L044d				;  send_2E_6B_to_main,
	dc.w	0x0328
	dc.w	0x0359
	dc.w	L02c8				;  load_B81E_from_main,
	dc.w	L01fd
	dc.w	0x02ea
	dc.w	L01f1				;  write_D83E_from_main,
	dc.w	L01a4
	dc.w	L01e2				;  set_D83F,
	dc.w	L01ea				;  clear_D83F,

L01a4:
01a4 cd5a0d    call    0d5ah
01a6 0d        dec     c
01a7 6f        ld      l,a
01a8 cd5a0d    call    0d5ah
01ab 67        ld      h,a
01ac cd5a0d    call    0d5ah
01af 44        ld      b,h
01b0 f3        di      
01b1 e5        push    hl
01b2 48        ld      c,b
01b3 cdce01    call    01ceh
01b6 41        ld      b,c
01b7 e1        pop     hl
01b8 380b      jr      c,01c5h
01ba dd3604c8  ld      (ix+04h),0c8h
01be dd750b    ld      (ix+0bh),l
01c1 fb        ei      
01c2 c35501    jp      L0155		;goto main_loop;

01c5 e5        push    hl
01c6 cd7605    call    0576h
01c9 e1        pop     hl
01ca 38f5      jr      c,01c1h
01cc 18f0      jr      01beh
01ce 21368c    ld      hl,8c36h
01d1 0608      ld      b,08h
01d3 be        cp      (hl)
01d4 2805      jr      z,01dbh
01d6 24        inc     h
01d7 10fa      djnz    01d3h
01d9 37        scf     
01da c9        ret     

01db 2e00      ld      l,00h
01dd e5        push    hl
01de dde1      pop     ix
01e0 a7        and     a
01e1 c9        ret     

L01e2:					;void set_D83F()
01e2 3e01      ld      a,01h
01e4 323fd8    ld      (0d83fh),a	;*(u8*)0xD83F = 1;
01e7 c35501    jp      L0155		;goto main_loop;

L01ea:					;void clear_D83F()
01ea af        xor     a
01eb 323fd8    ld      (0d83fh),a	;*(u8*)0xD83F = 0;
01ee c35501    jp      L0155		;goto main_loop;

L01f1:					;void write_D83E_from_main()
01f1 cd5a0d    call    0d5ah
01f4 323ed8    ld      (0d83eh),a	;*(u8*)0xD83E = receive_ctrl_from_main();
01f7 c35501    jp      L0155		;goto main_loop;

L01fa:					;void nop()
01fa c35501    jp      L0155		;goto main_loop;

L01fd:
01fd cd5a0d    call    0d5ah
0200 4f        ld      c,a
0201 f3        di      
0202 3a1995    ld      a,(9519h)
0205 5f        ld      e,a
0206 1600      ld      d,00h
0208 211ed8    ld      hl,0d81eh
020b 19        add     hl,de
020c 7e        ld      a,(hl)
020d 81        add     a,c
020e 321b95    ld      (951bh),a
0211 fb        ei      
0212 c35501    jp      0155h

L0215:					;
0215 cd5a0d    call    0d5ah		;u8 c = receive_ctrl_from_main();
0218 f3        di      
0219 cd8b04    call    048bh		;L048B(c);
021c fb        ei      
021d c35501    jp      L0155		;goto main_loop;

L0220:
0220 cd5a0d    call    0d5ah		;u8 c1 = receive_ctrl_from_main();
0223 67        ld      h,a
0224 cd5a0d    call    0d5ah		;u8 c2 = receive_ctrl_from_main();
0227 44        ld      b,h
0228 f3        di      
0229 4f        ld      c,a
022a 3a3ed8    ld      a,(0d83eh)
L022d:
022d f5        push    af		;for (int i=0;i<*(u8*)0xD83E;i++) {
022e c5        push    bc
022f 79        ld      a,c
0230 cd7605    call    L0576		;  L0576(c2,c1);
0233 c1        pop     bc
0234 f1        pop     af
0235 3d        dec     a
0236 20f5      jr      nz,L022d	;}
0238 3e01      ld      a,01h
023a 323ed8    ld      (0d83eh),a	;*(u8*)0xD83E = 0x01;
023d fb        ei      
023e c35501    jp      L0155		;goto main_loop;

0241 cd5a0d    call    0d5ah
0244 5f        ld      e,a
0245 cd5a0d    call    0d5ah
0248 57        ld      d,a
0249 cd5a0d    call    0d5ah
024c 6f        ld      l,a
024d cd5a0d    call    0d5ah
0250 67        ld      h,a
0251 43        ld      b,e
0252 7c        ld      a,h
0253 d5        push    de
0254 e5        push    hl
0255 f3        di      
0256 cd7605    call    0576h
0259 e1        pop     hl
025a d1        pop     de
025b 381c      jr      c,0279h
025d cb63      bit     4,e
025f 200a      jr      nz,026bh
0261 7b        ld      a,e
0262 e60f      and     0fh
0264 dd770c    ld      (ix+0ch),a
0267 af        xor     a
0268 dd7708    ld      (ix+08h),a
026b 7a        ld      a,d
026c dd8633    add     a,(ix+33h)
026f dd7733    ld      (ix+33h),a
0272 7d        ld      a,l
0273 dd8620    add     a,(ix+20h)
0276 dd7720    ld      (ix+20h),a
0279 fb        ei      
027a c35501    jp      0155h
027d cd5a0d    call    0d5ah
0280 6f        ld      l,a
0281 cd5a0d    call    0d5ah
0284 67        ld      h,a
0285 cd5a0d    call    0d5ah
0288 44        ld      b,h
0289 f3        di      
028a e5        push    hl
028b cd7605    call    0576h
028e e1        pop     hl
028f 3803      jr      c,0294h
0291 dd750b    ld      (ix+0bh),l
0294 fb        ei      
0295 c35501    jp      0155h

L0298:					;
0298 cd5a0d    call    0d5ah		;u8 c0 = receive_ctrl_from_main();
029b 5f        ld      e,a
029c f3        di      
029d 211eb8    ld      hl,0b81eh	;u8* ptr = 0xB81E;
02a0 4e        ld      c,(hl)		;
02a1 23        inc     hl
02a2 46        ld      b,(hl)		;u16 len = (ptr[1] << 8) | ptr[0];
02a3 23        inc     hl		;ptr += 2;
02a4 7e        ld      a,(hl)
02a5 23        inc     hl
02a6 321fd8    ld      (0d81fh),a	;*(u8*)0xD81F = *ptr++;
02a9 0b        dec     bc		;len--;
02aa c5        push    bc
02ab 113695    ld      de,9536h	;u8* dst = 0x9536;
02ae 0618      ld      b,18h
L02b0:
02b0 7e        ld      a,(hl)		;for (int i=0;i<24;i++) {
02b1 23        inc     hl
02b2 12        ld      (de),a		;  *dst++ = *ptr++;
02b3 13        inc     de
02b4 10fa      djnz    L02b0		;}
02b6 c1        pop     bc
02b7 79        ld      a,c
02b8 d618      sub     18h
02ba 4f        ld      c,a
02bb 78        ld      a,b
02bc de00      sbc     a,00h
02be 47        ld      b,a		;len -= 24;
02bf 111e98    ld      de,981eh	;dst = 0x981E;
02c2 edb0      ldir    			;for (int i=0;i<len;i++)
02c4 fb        ei      			;  *dst++ = *ptr++;
02c5 c35501    jp      L0155		;goto main_loop;

L02c8:					;void load_B81E_from_main()
02c8 cd5a0d    call    0d5ah		;u8 c0 = receive_ctrl_from_main();
02cb 5f        ld      e,a
02cc cd5a0d    call    0d5ah		;u16 len = receive_ctrl_from_main();
02cf 6f        ld      l,a
02d0 cd5a0d    call    0d5ah		;len |= receive_ctrl_from_main() << 8;
02d3 67        ld      h,a
02d4 111eb8    ld      de,0b81eh	;u8* ptr = 0xB81E;
02d7 7d        ld      a,l
02d8 12        ld      (de),a		;*ptr++ = len;
02d9 13        inc     de
02da 7c        ld      a,h
02db 12        ld      (de),a		;*ptr++ = len>>8;
02dc 13        inc     de
L02dd:
02dd cd5a0d    call    0d5ah		;for (int i=0;i<len;i++) 
02e0 12        ld      (de),a		;  *ptr++ = receive_ctrl_from_main();
02e1 13        inc     de
02e2 2b        dec     hl
02e3 7c        ld      a,h
02e4 b5        or      l
02e5 20f6      jr      nz,L02dd	;
02e7 c35501    jp      L0155		;goto main_loop;

02ea 0e01      ld      c,01h
02ec 21348c    ld      hl,8c34h
02ef 0608      ld      b,08h
02f1 2e00      ld      l,00h
02f3 7e        ld      a,(hl)
02f4 fe02      cp      02h
02f6 2006      jr      nz,02feh
02f8 2e34      ld      l,34h
02fa 7e        ld      a,(hl)
02fb a1        and     c
02fc 2006      jr      nz,0304h
02fe 24        inc     h
02ff 10f0      djnz    02f1h
0301 c35501    jp      0155h
0304 2e36      ld      l,36h
0306 7e        ld      a,(hl)
0307 fe6f      cp      6fh
0309 28f3      jr      z,02feh
030b f3        di      
030c 2e01      ld      l,01h
030e 3683      ld      (hl),83h
0310 2c        inc     l
0311 360d      ld      (hl),0dh
0313 2e33      ld      l,33h
0315 36ff      ld      (hl),0ffh
0317 2e0d      ld      l,0dh
0319 3600      ld      (hl),00h
031b 2e08      ld      l,08h
031d 3600      ld      (hl),00h
031f 2e04      ld      l,04h
0321 3601      ld      (hl),01h
0323 2e34      ld      l,34h
0325 fb        ei      
0326 18d6      jr      02feh
0328 cd5a0d    call    0d5ah
032b 0e60      ld      c,60h
032d a1        and     c
032e 57        ld      d,a
032f 21348c    ld      hl,8c34h
0332 0608      ld      b,08h
0334 7e        ld      a,(hl)
0335 a1        and     c
0336 ba        cp      d
0337 2806      jr      z,033fh
0339 24        inc     h
033a 10f8      djnz    0334h
033c c35501    jp      0155h
033f f3        di      
0340 2e01      ld      l,01h
0342 3683      ld      (hl),83h
0344 2c        inc     l
0345 360d      ld      (hl),0dh
0347 2e33      ld      l,33h
0349 36ff      ld      (hl),0ffh
034b 2e0d      ld      l,0dh
034d 3600      ld      (hl),00h
034f 2e08      ld      l,08h
0351 3600      ld      (hl),00h
0353 2e34      ld      l,34h
0355 fb        ei      
0356 c35501    jp      0155h
0359 cd5a0d    call    0d5ah
035c 0e60      ld      c,60h
035e a1        and     c
035f 57        ld      d,a
0360 21348c    ld      hl,8c34h
0363 0608      ld      b,08h
0365 7e        ld      a,(hl)
0366 a1        and     c
0367 ba        cp      d
0368 2806      jr      z,0370h
036a 24        inc     h
036b 10f8      djnz    0365h
036d c35501    jp      0155h
0370 2e08      ld      l,08h
0372 cb66      bit     4,(hl)
0374 2004      jr      nz,037ah
0376 2e34      ld      l,34h
0378 18f0      jr      036ah
037a 2e08      ld      l,08h
037c cba6      res     4,(hl)
037e c35501    jp      0155h
0381 cd5a0d    call    0d5ah
0384 67        ld      h,a
0385 cd5a0d    call    0d5ah
0388 4c        ld      c,h
0389 f3        di      
038a cd1305    call    0513h
038d fb        ei      
038e c35501    jp      0155h
0391 cd5a0d    call    0d5ah
0394 5f        ld      e,a
0395 cd5a0d    call    0d5ah
0398 57        ld      d,a
0399 cd5a0d    call    0d5ah
039c 6f        ld      l,a
039d cd5a0d    call    0d5ah
03a0 67        ld      h,a
03a1 cd5a0d    call    0d5ah
03a4 4f        ld      c,a
03a5 7c        ld      a,h
03a6 d5        push    de
03a7 e5        push    hl
03a8 f3        di      
03a9 cd1305    call    0513h
03ac e1        pop     hl
03ad d1        pop     de
03ae 381c      jr      c,03cch
03b0 cb63      bit     4,e
03b2 200a      jr      nz,03beh
03b4 7b        ld      a,e
03b5 e60f      and     0fh
03b7 dd770c    ld      (ix+0ch),a
03ba af        xor     a
03bb dd7708    ld      (ix+08h),a
03be 7a        ld      a,d
03bf dd8633    add     a,(ix+33h)
03c2 dd7733    ld      (ix+33h),a
03c5 7d        ld      a,l
03c6 dd8620    add     a,(ix+20h)
03c9 dd7720    ld      (ix+20h),a
03cc fb        ei      
03cd c35501    jp      0155h
03d0 cd5a0d    call    0d5ah
03d3 6f        ld      l,a
03d4 cd5a0d    call    0d5ah
03d7 67        ld      h,a
03d8 cd5a0d    call    0d5ah
03db 4c        ld      c,h
03dc f3        di      
03dd e5        push    hl
03de cd1305    call    0513h
03e1 e1        pop     hl
03e2 3803      jr      c,03e7h
03e4 dd750b    ld      (ix+0bh),l
03e7 fb        ei      
03e8 c35501    jp      0155h
03eb cd5a0d    call    0d5ah
03ee 2694      ld      h,94h
03f0 6f        ld      l,a
03f1 7e        ld      a,(hl)
03f2 a7        and     a
03f3 2003      jr      nz,03f8h
03f5 c35501    jp      0155h
03f8 d68c      sub     8ch
03fa 3c        inc     a
03fb 47        ld      b,a
03fc 3e0c      ld      a,0ch
03fe 90        sub     b
03ff 5f        ld      e,a
0400 0e00      ld      c,00h
0402 51        ld      d,c
0403 3e18      ld      a,18h
0405 f3        di      
0406 3600      ld      (hl),00h
0408 cdde09    call    09deh
040b af        xor     a
040c 77        ld      (hl),a
040d 2e00      ld      l,00h
040f 77        ld      (hl),a
0410 2e21      ld      l,21h
0412 77        ld      (hl),a
0413 2e0d      ld      l,0dh
0415 77        ld      (hl),a
0416 2e35      ld      l,35h
0418 77        ld      (hl),a
0419 fb        ei      
041a c35501    jp      L0155		;goto main_loop;

L041d:					;void send_BC_to_main()
041d 0e05      ld      c,05h
041f ed78      in      a,(c)
0421 f21f04    jp      p,041fh
0424 0e00      ld      c,00h
0426 3ebc      ld      a,0bch
0428 ed79      out     (c),a		;*RESP_DATA = 0xBC;
042a c35501    jp      L0155		;goto main_loop;

L042d:					;void send_11_to_main()
042d 0e05      ld      c,05h
042f ed78      in      a,(c)
0431 f22f04    jp      p,042fh
0434 0e00      ld      c,00h
0436 3e11      ld      a,11h
0438 ed79      out     (c),a		;*RESP_DATA = 0x11;
043a c35501    jp      L0155		;goto main_loop;

043d 210080    ld      hl,8000h
0440 1614      ld      d,14h
0442 5e        ld      e,(hl)
0443 cd4b0d    call    0d4bh
0446 24        inc     h
0447 15        dec     d
0448 20f8      jr      nz,0442h
044a c35501    jp      0155h

L044d:					;void send_2E_6B_to_main()
044d 0e05      ld      c,05h
044f ed78      in      a,(c)
0451 f24f04    jp      p,044fh
0454 0e00      ld      c,00h
0456 3e2e      ld      a,2eh
0458 ed79      out     (c),a		;*RESP_DATA = 0x2E;
045a 0e05      ld      c,05h
045c ed78      in      a,(c)
045e f25c04    jp      p,045ch
0461 0e00      ld      c,00h
0463 3e6b      ld      a,6bh
0465 ed79      out     (c),a		;*RESP_DATA = 0x6B;
0467 c35501    jp      L0155		;goto main_loop;

046a cd5a0d    call    0d5ah
046d 6f        ld      l,a
046e cd5a0d    call    0d5ah
0471 67        ld      h,a
0472 2204f0    ld      (0f004h),hl
0475 c35501    jp      0155h
0478 3e0b      ld      a,0bh
047a cd8b04    call    048bh
047d 3e00      ld      a,00h
047f 0600      ld      b,00h
0481 fb        ei      
0482 76        halt    
0483 fb        ei      
0484 18fd      jr      0483h

L0486:					;cmd_failed:
0486 3200f0    ld      (0f000h),a
0489 18fe      jr      0489h		;while (1);

L048b:					;void (u8 d)
048b 321995    ld      (9519h),a	;*0x9519 = d;
048e 5f        ld      e,a
048f 1600      ld      d,00h
0491 211ed8    ld      hl,0d81eh	;
0494 19        add     hl,de		;
0495 7e        ld      a,(hl)
0496 321b95    ld      (951bh),a	;*0x951B = *(0xD81E+d);
0499 af        xor     a
049a 321c95    ld      (951ch),a	;*0x951C = 0;
049d 62        ld      h,d
049e 6b        ld      l,e
049f 23        inc     hl
04a0 29        add     hl,hl
04a1 29        add     hl,hl
04a2 29        add     hl,hl
04a3 54        ld      d,h
04a4 5d        ld      e,l
04a5 29        add     hl,hl
04a6 19        add     hl,de
04a7 111e95    ld      de,951eh
04aa 19        add     hl,de		;u8* ptr = 0x951E + (d+1) * 24;
04ab dd210080  ld      ix,8000h	;u8* dst = 0x8000;
04af 110001    ld      de,0100h
04b2 060c      ld      b,0ch
L04b4:
04b4 2b        dec     hl		;for (int i=0;i<12;i++) {
04b5 7e        ld      a,(hl)
04b6 dd7702    ld      (ix+02h),a	;  dst[0x2] = *--ptr;
04b9 2b        dec     hl
04ba 7e        ld      a,(hl)
04bb dd7701    ld      (ix+01h),a	;  dst[0x1] = *--ptr;
04be dd360001  ld      (ix+00h),01h	;  dst[0x0] = 0x01;
04c2 af        xor     a
04c3 dd7722    ld      (ix+22h),a	;  dst[0x22] = 0x00;
04c6 dd7723    ld      (ix+23h),a	;  dst[0x23] = 0x00;
04c9 dd772e    ld      (ix+2eh),a	;  dst[0x2E] = 0x00;
04cc dd7707    ld      (ix+07h),a	;  dst[0x07] = 0x00;
04cf dd7706    ld      (ix+06h),a	;  dst[0x06] = 0x00;
04d2 dd7720    ld      (ix+20h),a	;  dst[0x20] = 0x00;
04d5 dd771d    ld      (ix+1dh),a	;  dst[0x1D] = 0x00;
04d8 dd770d    ld      (ix+0dh),a	;  dst[0x0D] = 0x00;
04db dd7703    ld      (ix+03h),a	;  dst[0x03] = 0x00;
04de dd7708    ld      (ix+08h),a	;  dst[0x08] = 0x00;
04e1 dd772c    ld      (ix+2ch),a	;  dst[0x2C] = 0x00;
04e4 dd772d    ld      (ix+2dh),a	;  dst[0x2D] = 0x00;
04e7 3c        inc     a
04e8 dd7704    ld      (ix+04h),a	;  dst[0x04] = 0x01;
04eb dd360b0f  ld      (ix+0bh),0fh ;  dst[0x0B] = 0x0F;
04ef dd360c07  ld      (ix+0ch),07h ;  dst[0x0C] = 0x07;
04f3 dd7721    ld      (ix+21h),a	;  dst[0x21] = 0x01;
04f6 3eff      ld      a,0ffh
04f8 dd770e    ld      (ix+0eh),a	;  dst[0x0E] = 0xFF;
04fb dd770f    ld      (ix+0fh),a	;  dst[0x0F] = 0xFF;
04fe 3c        inc     a
04ff dd7710    ld      (ix+10h),a	;  dst[0x10] = 0x00;
0502 dd7711    ld      (ix+11h),a	;  dst[0x11] = 0x00;
0505 dd7712    ld      (ix+12h),a	;  dst[0x12] = 0x00;
0508 dd7713    ld      (ix+13h),a	;  dst[0x13] = 0x00;
050b dd7714    ld      (ix+14h),a	;  dst[0x14] = 0x00;
050e dd19      add     ix,de		;  dst += 0x100;
0510 10a2      djnz    L04b4		;}
0512 c9        ret     

0513 08        ex      af,af'
0514 cb79      bit     7,c
0516 2020      jr      nz,0538h
0518 0694      ld      b,94h
051a 0a        ld      a,(bc)
051b a7        and     a
051c 2809      jr      z,0527h
051e 67        ld      h,a
051f 2e35      ld      l,35h
0521 71        ld      (hl),c
0522 2e00      ld      l,00h
0524 c3cf05    jp      05cfh
0527 c5        push    bc
0528 cd4805    call    0548h
052b c1        pop     bc
052c 3818      jr      c,0546h
052e 7c        ld      a,h
052f 02        ld      (bc),a
0530 2e35      ld      l,35h
0532 71        ld      (hl),c
0533 2e00      ld      l,00h
0535 c3cf05    jp      05cfh
0538 cd4805    call    0548h
053b 3809      jr      c,0546h
053d 2e35      ld      l,35h
053f 36ff      ld      (hl),0ffh
0541 2e00      ld      l,00h
0543 c3cf05    jp      05cfh
0546 37        scf     
0547 c9        ret     

0548 21358c    ld      hl,8c35h
054b 0608      ld      b,08h
054d 1e03      ld      e,03h
054f 0e00      ld      c,00h
0551 7e        ld      a,(hl)
0552 17        rla     
0553 3809      jr      c,055eh
0555 1f        rra     
0556 3d        dec     a
0557 fa7305    jp      m,0573h
055a bb        cp      e
055b 3801      jr      c,055eh
055d 4c        ld      c,h
055e 24        inc     h
055f 10f0      djnz    0551h
0561 61        ld      h,c
0562 7c        ld      a,h
0563 a7        and     a
0564 2002      jr      nz,0568h
0566 37        scf     
0567 c9        ret     

0568 2e35      ld      l,35h
056a 7e        ld      a,(hl)
056b a7        and     a
056c 2805      jr      z,0573h
056e 4f        ld      c,a
056f 0694      ld      b,94h
0571 af        xor     a
0572 02        ld      (bc),a
0573 af        xor     a
0574 6f        ld      l,a
0575 c9        ret     

L0576:					;
0576 08        ex      af,af'
0577 78        ld      a,b
0578 e6e0      and     0e0h
057a 57        ld      d,a
057b 21348c    ld      hl,8c34h
057e 0608      ld      b,08h
0580 cb17      rl      a
0582 5f        ld      e,a
0583 2010      jr      nz,0595h
0585 7e        ld      a,(hl)
0586 a7        and     a
0587 2839      jr      z,05c2h
0589 17        rla     
058a 3804      jr      c,0590h
058c e6c0      and     0c0h
058e 2818      jr      z,05a8h
0590 24        inc     h
0591 10f2      djnz    0585h
0593 37        scf     
0594 c9        ret     

0595 7e        ld      a,(hl)
0596 a7        and     a
0597 2829      jr      z,05c2h
0599 17        rla     
059a 3807      jr      c,05a3h
059c e6c0      and     0c0h
059e 2812      jr      z,05b2h
05a0 bb        cp      e
05a1 280f      jr      z,05b2h
05a3 24        inc     h
05a4 10ef      djnz    0595h
05a6 37        scf     
05a7 c9        ret     

05a8 08        ex      af,af'
05a9 2e36      ld      l,36h
05ab 4e        ld      c,(hl)
05ac b9        cp      c
05ad 2806      jr      z,05b5h
05af 2e34      ld      l,34h
05b1 08        ex      af,af'
05b2 4c        ld      c,h
05b3 1809      jr      05beh
05b5 08        ex      af,af'
05b6 2e34      ld      l,34h
05b8 1808      jr      05c2h
05ba 7e        ld      a,(hl)
05bb a7        and     a
05bc 2804      jr      z,05c2h
05be 24        inc     h
05bf 10f9      djnz    05bah
05c1 61        ld      h,c
05c2 14        inc     d
05c3 72        ld      (hl),d
05c4 2e00      ld      l,00h
05c6 1807      jr      05cfh
05c8 08        ex      af,af'
05c9 21008c    ld      hl,8c00h
05cc 7c        ld      a,h
05cd 80        add     a,b
05ce 67        ld      h,a
05cf e5        push    hl
05d0 dde1      pop     ix
05d2 3e80      ld      a,80h
05d4 80        add     a,b
05d5 67        ld      h,a
05d6 2e08      ld      l,08h
05d8 cbde      set     3,(hl)
05da 2e21      ld      l,21h
05dc 3600      ld      (hl),00h
05de 08        ex      af,af'
05df dd7736    ld      (ix+36h),a
05e2 6f        ld      l,a
05e3 2600      ld      h,00h
05e5 29        add     hl,hl
05e6 29        add     hl,hl
05e7 11460f    ld      de,0f46h
05ea 19        add     hl,de
05eb 7e        ld      a,(hl)
05ec 23        inc     hl
05ed dd7720    ld      (ix+20h),a
05f0 7e        ld      a,(hl)
05f1 23        inc     hl
05f2 dd7733    ld      (ix+33h),a
05f5 7e        ld      a,(hl)
05f6 23        inc     hl
05f7 dd7701    ld      (ix+01h),a
05fa 7e        ld      a,(hl)
05fb 23        inc     hl
05fc dd7702    ld      (ix+02h),a
05ff dd360002  ld      (ix+00h),02h
0603 af        xor     a
0604 dd7722    ld      (ix+22h),a
0607 dd7723    ld      (ix+23h),a
060a dd772e    ld      (ix+2eh),a
060d dd7707    ld      (ix+07h),a
0610 dd7706    ld      (ix+06h),a
0613 dd7732    ld      (ix+32h),a
0616 dd771d    ld      (ix+1dh),a
0619 dd770d    ld      (ix+0dh),a
061c dd7703    ld      (ix+03h),a
061f dd772c    ld      (ix+2ch),a
0622 dd772d    ld      (ix+2dh),a
0625 3c        inc     a
0626 dd7704    ld      (ix+04h),a
0629 dd7721    ld      (ix+21h),a
062c dd360b0f  ld      (ix+0bh),0fh
0630 dd360c07  ld      (ix+0ch),07h
0634 3e02      ld      a,02h
0636 dd7708    ld      (ix+08h),a
0639 3eff      ld      a,0ffh
063b dd770e    ld      (ix+0eh),a
063e dd770f    ld      (ix+0fh),a
0641 3c        inc     a
0642 dd7710    ld      (ix+10h),a
0645 dd7711    ld      (ix+11h),a
0648 dd7712    ld      (ix+12h),a
064b dd7713    ld      (ix+13h),a
064e dd7714    ld      (ix+14h),a
0651 a7        and     a
0652 c9        ret     

0653 cd0907    call    0709h
0656 3a1b95    ld      a,(951bh)
0659 47        ld      b,a
065a 3a1c95    ld      a,(951ch)
065d 80        add     a,b
065e 321c95    ld      (951ch),a
0661 301d      jr      nc,0680h
0663 dd210080  ld      ix,8000h
0667 060c      ld      b,0ch
0669 dd7e00    ld      a,(ix+00h)
066c a7        and     a
066d 280a      jr      z,0679h
066f dd3504    dec     (ix+04h)
0672 2005      jr      nz,0679h
0674 c5        push    bc
0675 cd6b07    call    076bh
0678 c1        pop     bc
0679 110001    ld      de,0100h
067c dd19      add     ix,de
067e 10e9      djnz    0669h
0680 dd21008c  ld      ix,8c00h
0684 0608      ld      b,08h
0686 dd7e00    ld      a,(ix+00h)
0689 a7        and     a
068a 2820      jr      z,06ach
068c dd7e33    ld      a,(ix+33h)
068f dd8632    add     a,(ix+32h)
0692 dd7732    ld      (ix+32h),a
0695 3015      jr      nc,06ach
0697 dd3504    dec     (ix+04h)
069a 2010      jr      nz,06ach
069c ddcb0866  bit     4,(ix+08h)
06a0 2805      jr      z,06a7h
06a2 dd3404    inc     (ix+04h)
06a5 1805      jr      06ach
06a7 c5        push    bc
06a8 cd6b07    call    076bh
06ab c1        pop     bc
06ac 110001    ld      de,0100h
06af dd19      add     ix,de
06b1 10d3      djnz    0686h
06b3 110080    ld      de,8000h
06b6 01008c    ld      bc,8c00h
06b9 210095    ld      hl,9500h
06bc d9        exx     
06bd 0608      ld      b,08h
06bf 0e0c      ld      c,0ch
06c1 0d        dec     c
06c2 d9        exx     
06c3 0a        ld      a,(bc)
06c4 a7        and     a
06c5 2803      jr      z,06cah
06c7 70        ld      (hl),b
06c8 1805      jr      06cfh
06ca 1a        ld      a,(de)
06cb a7        and     a
06cc 2807      jr      z,06d5h
06ce 72        ld      (hl),d
06cf 2c        inc     l
06d0 d9        exx     
06d1 79        ld      a,c
06d2 d9        exx     
06d3 77        ld      (hl),a
06d4 2c        inc     l
06d5 04        inc     b
06d6 14        inc     d
06d7 d9        exx     
06d8 10e7      djnz    06c1h
06da 79        ld      a,c
06db d9        exx     
06dc 4f        ld      c,a
06dd 0604      ld      b,04h
06df 0d        dec     c
06e0 72        ld      (hl),d
06e1 2c        inc     l
06e2 71        ld      (hl),c
06e3 2c        inc     l
06e4 14        inc     d
06e5 10f8      djnz    06dfh
06e7 3600      ld      (hl),00h
06e9 fd210095  ld      iy,9500h
06ed 1813      jr      0702h
06ef 67        ld      h,a
06f0 2e00      ld      l,00h
06f2 fd23      inc     iy
06f4 e5        push    hl
06f5 dde1      pop     ix
06f7 fd5e00    ld      e,(iy+00h)
06fa fd23      inc     iy
06fc 2e0d      ld      l,0dh
06fe 7e        ld      a,(hl)
06ff cd3d07    call    073dh
0702 fd7e00    ld      a,(iy+00h)
0705 a7        and     a
0706 20e7      jr      nz,06efh
0708 c9        ret     

0709 fd210095  ld      iy,9500h
070d 1827      jr      0736h
070f fd23      inc     iy
0711 67        ld      h,a
0712 2e21      ld      l,21h
0714 7e        ld      a,(hl)
0715 a7        and     a
0716 281c      jr      z,0734h
0718 1e00      ld      e,00h		;i = 256;
071a 010680    ld      bc,8006h
L071d:
071d ed78      in      a,(c)		;do {
071f fa2807    jp      m,L0728	;  if (BSMT_PORTR[6] & 0x80) break;
0722 1d        dec     e
0723 20f8      jr      nz,L071d	;} while (--i);
0725 c3180d    jp      L0d18		;goto L0d18;
L0728:
0728 fd7e00    ld      a,(iy+00h)
072b c618      add     a,18h
072d 47        ld      b,a
072e 2c        inc     l
072f 7e        ld      a,(hl)
0730 2c        inc     l
0731 4e        ld      c,(hl)
0732 ed79      out     (c),a
0734 fd23      inc     iy
0736 fd7e00    ld      a,(iy+00h)
0739 a7        and     a
073a 20d3      jr      nz,070fh
073c c9        ret     

073d cb27      sla     a
073f 6f        ld      l,a
0740 2600      ld      h,00h
0742 012a08    ld      bc,082ah
0745 09        add     hl,bc
0746 7e        ld      a,(hl)
0747 23        inc     hl
0748 66        ld      h,(hl)
0749 6f        ld      l,a
074a e9        jp      (hl)
074b dd7e07    ld      a,(ix+07h)
074e a7        and     a
074f 2006      jr      nz,0757h
0751 af        xor     a
0752 dd770d    ld      (ix+0dh),a
0755 181e      jr      0775h
0757 dd7704    ld      (ix+04h),a
075a dd360d05  ld      (ix+0dh),05h
075e dd7e13    ld      a,(ix+13h)
0761 dd7715    ld      (ix+15h),a
0764 dd7e14    ld      a,(ix+14h)
0767 dd7716    ld      (ix+16h),a
076a c9        ret     

076b dd7e0d    ld      a,(ix+0dh)
076e a7        and     a
076f 2804      jr      z,0775h
0771 fe05      cp      05h
0773 20d6      jr      nz,074bh
0775 dd5e01    ld      e,(ix+01h)
0778 dd5602    ld      d,(ix+02h)
077b 1a        ld      a,(de)
077c 13        inc     de
077d cb7f      bit     7,a
077f 201e      jr      nz,079fh
0781 07        rlca    
0782 6f        ld      l,a
0783 2600      ld      h,00h
0785 01ba0c    ld      bc,0cbah
0788 09        add     hl,bc
0789 7e        ld      a,(hl)
078a 23        inc     hl
078b 66        ld      h,(hl)
078c 6f        ld      l,a
078d e9        jp      (hl)
078e dd7e06    ld      a,(ix+06h)
0791 c32008    jp      0820h
0794 dd7e05    ld      a,(ix+05h)
0797 187d      jr      0816h
0799 dd362100  ld      (ix+21h),00h
079d 180c      jr      07abh
079f ddcb08de  set     3,(ix+08h)
07a3 fe80      cp      80h
07a5 28f2      jr      z,0799h
07a7 ddcb089e  res     3,(ix+08h)
07ab dd6e20    ld      l,(ix+20h)
07ae 85        add     a,l
07af dd360d01  ld      (ix+0dh),01h
07b3 d680      sub     80h
07b5 6f        ld      l,a
07b6 2600      ld      h,00h
07b8 29        add     hl,hl
07b9 01840d    ld      bc,0d84h
07bc 09        add     hl,bc
07bd 7e        ld      a,(hl)
07be dd7722    ld      (ix+22h),a
07c1 23        inc     hl
07c2 7e        ld      a,(hl)
07c3 dd7723    ld      (ix+23h),a
07c6 dde5      push    ix
07c8 e1        pop     hl
07c9 44        ld      b,h
07ca 2e0e      ld      l,0eh
07cc 0e15      ld      c,15h
07ce 7e        ld      a,(hl)
07cf 2c        inc     l
07d0 02        ld      (bc),a
07d1 0c        inc     c
07d2 7e        ld      a,(hl)
07d3 02        ld      (bc),a
07d4 af        xor     a
07d5 2e17      ld      l,17h
07d7 77        ld      (hl),a
07d8 2c        inc     l
07d9 77        ld      (hl),a
07da 2e1d      ld      l,1dh
07dc 7e        ld      a,(hl)
07dd a7        and     a
07de 2811      jr      z,07f1h
07e0 cb3f      srl     a
07e2 2e1c      ld      l,1ch
07e4 77        ld      (hl),a
07e5 2e1e      ld      l,1eh
07e7 7e        ld      a,(hl)
07e8 2e1a      ld      l,1ah
07ea 77        ld      (hl),a
07eb 2e1f      ld      l,1fh
07ed 7e        ld      a,(hl)
07ee 2e1b      ld      l,1bh
07f0 77        ld      (hl),a
07f1 2e2e      ld      l,2eh
07f3 7e        ld      a,(hl)
07f4 dd7726    ld      (ix+26h),a
07f7 a7        and     a
07f8 2813      jr      z,080dh
07fa dd362801  ld      (ix+28h),01h
07fe 2c        inc     l
07ff 7e        ld      a,(hl)
0800 2c        inc     l
0801 dd7727    ld      (ix+27h),a
0804 7e        ld      a,(hl)
0805 2c        inc     l
0806 dd7729    ld      (ix+29h),a
0809 7e        ld      a,(hl)
080a dd772b    ld      (ix+2bh),a
080d dd7e08    ld      a,(ix+08h)
0810 4f        ld      c,a
0811 1f        rra     
0812 3880      jr      c,0794h
0814 1a        ld      a,(de)
0815 13        inc     de
0816 dd7704    ld      (ix+04h),a
0819 cb51      bit     2,c
081b ca8e07    jp      z,078eh
081e 1a        ld      a,(de)
081f 13        inc     de
0820 dd7707    ld      (ix+07h),a
0823 dd7301    ld      (ix+01h),e
0826 dd7202    ld      (ix+02h),d
0829 c9        ret     

082a ef        rst     28h
082b 08        ex      af,af'
082c 3608      ld      (hl),08h
082e 7c        ld      a,h
082f 08        ex      af,af'
0830 8d        adc     a,l
0831 09        add     hl,bc
0832 b6        or      (hl)
0833 09        add     hl,bc
0834 bc        cp      h
0835 09        add     hl,bc
0836 0e00      ld      c,00h
0838 51        ld      d,c
0839 3e18      ld      a,18h
083b cdde09    call    09deh
083e dd6e09    ld      l,(ix+09h)
0841 dd660a    ld      h,(ix+0ah)
0844 29        add     hl,hl
0845 44        ld      b,h
0846 4d        ld      c,l
0847 29        add     hl,hl
0848 29        add     hl,hl
0849 09        add     hl,bc
084a 013e65    ld      bc,653eh
084d 09        add     hl,bc
084e 3e24      ld      a,24h
0850 cdda09    call    09dah
0853 3e00      ld      a,00h
0855 cdda09    call    09dah
0858 3e30      ld      a,30h
085a cdda09    call    09dah
085d 3e3c      ld      a,3ch
085f cdda09    call    09dah
0862 4e        ld      c,(hl)
0863 23        inc     hl
0864 46        ld      b,(hl)
0865 dd6e22    ld      l,(ix+22h)
0868 dd6623    ld      h,(ix+23h)
086b 09        add     hl,bc
086c dd4e2c    ld      c,(ix+2ch)
086f dd462d    ld      b,(ix+2dh)
0872 09        add     hl,bc
0873 dd7522    ld      (ix+22h),l
0876 dd7423    ld      (ix+23h),h
0879 dd340d    inc     (ix+0dh)
087c dde5      push    ix
087e e1        pop     hl
087f 44        ld      b,h
0880 0e15      ld      c,15h
0882 2e17      ld      l,17h
0884 0a        ld      a,(bc)
0885 86        add     a,(hl)
0886 77        ld      (hl),a
0887 2c        inc     l
0888 0c        inc     c
0889 0a        ld      a,(bc)
088a 8e        adc     a,(hl)
088b 77        ld      (hl),a
088c feff      cp      0ffh
088e ca7709    jp      z,0977h
0891 57        ld      d,a
0892 dd7e0b    ld      a,(ix+0bh)
0895 cdf709    call    09f7h
0898 ddcb084e  bit     1,(ix+08h)
089c 2052      jr      nz,08f0h
089e 6f        ld      l,a
089f 3a3fd8    ld      a,(0d83fh)
08a2 a7        and     a
08a3 205e      jr      nz,0903h
08a5 7d        ld      a,l
08a6 e6fe      and     0feh
08a8 6f        ld      l,a
08a9 2600      ld      h,00h
08ab 01470e    ld      bc,0e47h
08ae 09        add     hl,bc
08af 7e        ld      a,(hl)
08b0 57        ld      d,a
08b1 08        ex      af,af'
08b2 dd7e0c    ld      a,(ix+0ch)
08b5 cdf709    call    09f7h
08b8 6f        ld      l,a
08b9 1600      ld      d,00h
08bb cb3f      srl     a
08bd cb1a      rr      d
08bf 4f        ld      c,a
08c0 3e54      ld      a,54h
08c2 cdde09    call    09deh
08c5 08        ex      af,af'
08c6 95        sub     l
08c7 1600      ld      d,00h
08c9 cb3f      srl     a
08cb cb1a      rr      d
08cd 4f        ld      c,a
08ce 3e60      ld      a,60h
08d0 cdde09    call    09deh
08d3 dde5      push    ix
08d5 e1        pop     hl
08d6 2e1d      ld      l,1dh
08d8 7e        ld      a,(hl)
08d9 a7        and     a
08da c41b09    call    nz,091bh
08dd 2e26      ld      l,26h
08df 7e        ld      a,(hl)
08e0 a7        and     a
08e1 c44409    call    nz,0944h
08e4 ddcb085e  bit     3,(ix+08h)
08e8 2005      jr      nz,08efh
08ea 3e01      ld      a,01h
08ec dd7721    ld      (ix+21h),a
08ef c9        ret     

08f0 1600      ld      d,00h
08f2 cb3f      srl     a
08f4 cb1a      rr      d
08f6 4f        ld      c,a
08f7 3e54      ld      a,54h
08f9 cdde09    call    09deh
08fc 3e60      ld      a,60h
08fe cdde09    call    09deh
0901 18d0      jr      08d3h
0903 7d        ld      a,l
0904 1600      ld      d,00h
0906 cb3f      srl     a
0908 cb1a      rr      d
090a cb3f      srl     a
090c cb1a      rr      d
090e 4f        ld      c,a
090f 3e54      ld      a,54h
0911 cdde09    call    09deh
0914 3e60      ld      a,60h
0916 cdde09    call    09deh
0919 18b8      jr      08d3h
091b 2e1a      ld      l,1ah
091d 35        dec     (hl)
091e c0        ret     nz

091f 2d        dec     l
0920 7e        ld      a,(hl)
0921 2c        inc     l
0922 77        ld      (hl),a
0923 2c        inc     l
0924 7e        ld      a,(hl)
0925 4f        ld      c,a
0926 af        xor     a
0927 cb79      bit     7,c
0929 2801      jr      z,092ch
092b 3d        dec     a
092c 47        ld      b,a
092d 2e22      ld      l,22h
092f 7e        ld      a,(hl)
0930 81        add     a,c
0931 77        ld      (hl),a
0932 2c        inc     l
0933 7e        ld      a,(hl)
0934 88        adc     a,b
0935 77        ld      (hl),a
0936 2e1c      ld      l,1ch
0938 35        dec     (hl)
0939 c0        ret     nz

093a 2c        inc     l
093b 7e        ld      a,(hl)
093c 2d        dec     l
093d 77        ld      (hl),a
093e 2d        dec     l
093f 7e        ld      a,(hl)
0940 ed44      neg     
0942 77        ld      (hl),a
0943 c9        ret     

0944 47        ld      b,a
0945 2e27      ld      l,27h
0947 7e        ld      a,(hl)
0948 a7        and     a
0949 2802      jr      z,094dh
094b 35        dec     (hl)
094c c9        ret     

094d 2c        inc     l
094e 35        dec     (hl)
094f c0        ret     nz

0950 70        ld      (hl),b
0951 2c        inc     l
0952 35        dec     (hl)
0953 2004      jr      nz,0959h
0955 2e26      ld      l,26h
0957 3600      ld      (hl),00h
0959 0600      ld      b,00h
095b 2e2b      ld      l,2bh
095d 7e        ld      a,(hl)
095e a7        and     a
095f 2e2a      ld      l,2ah
0961 7e        ld      a,(hl)
0962 2805      jr      z,0969h
0964 2e2b      ld      l,2bh
0966 35        dec     (hl)
0967 ed44      neg     
0969 cb7f      bit     7,a
096b 2801      jr      z,096eh
096d 05        dec     b
096e 2e22      ld      l,22h
0970 86        add     a,(hl)
0971 77        ld      (hl),a
0972 78        ld      a,b
0973 2c        inc     l
0974 8e        adc     a,(hl)
0975 77        ld      (hl),a
0976 c9        ret     

0977 dd340d    inc     (ix+0dh)
097a 3eff      ld      a,0ffh
097c 77        ld      (hl),a
097d 2d        dec     l
097e 77        ld      (hl),a
097f 2d        dec     l
0980 dd5611    ld      d,(ix+11h)
0983 72        ld      (hl),d
0984 2d        dec     l
0985 dd5610    ld      d,(ix+10h)
0988 72        ld      (hl),d
0989 57        ld      d,a
098a c39208    jp      0892h
098d dde5      push    ix
098f e1        pop     hl
0990 44        ld      b,h
0991 0e17      ld      c,17h
0993 2e15      ld      l,15h
0995 0a        ld      a,(bc)
0996 96        sub     (hl)
0997 02        ld      (bc),a
0998 2c        inc     l
0999 0c        inc     c
099a 0a        ld      a,(bc)
099b 9e        sbc     a,(hl)
099c 02        ld      (bc),a
099d dd5612    ld      d,(ix+12h)
09a0 3807      jr      c,09a9h
09a2 ba        cp      d
09a3 3804      jr      c,09a9h
09a5 57        ld      d,a
09a6 c39208    jp      0892h
09a9 dd340d    inc     (ix+0dh)
09ac dd361700  ld      (ix+17h),00h
09b0 dd7218    ld      (ix+18h),d
09b3 c39208    jp      0892h
09b6 dd5612    ld      d,(ix+12h)
09b9 c39208    jp      0892h
09bc dde5      push    ix
09be e1        pop     hl
09bf 44        ld      b,h
09c0 0e17      ld      c,17h
09c2 2e15      ld      l,15h
09c4 0a        ld      a,(bc)
09c5 96        sub     (hl)
09c6 02        ld      (bc),a
09c7 2c        inc     l
09c8 0c        inc     c
09c9 0a        ld      a,(bc)
09ca 9e        sbc     a,(hl)
09cb 02        ld      (bc),a
09cc 3804      jr      c,09d2h
09ce 57        ld      d,a
09cf c39208    jp      0892h
09d2 af        xor     a
09d3 dd770d    ld      (ix+0dh),a
09d6 57        ld      d,a
09d7 c39208    jp      0892h
09da 56        ld      d,(hl)
09db 23        inc     hl
09dc 4e        ld      c,(hl)
09dd 23        inc     hl
09de 83        add     a,e
09df 47        ld      b,a
09e0 d9        exx     
09e1 1e00      ld      e,00h
09e3 010680    ld      bc,8006h
09e6 ed78      in      a,(c)
09e8 faf209    jp      m,09f2h
09eb 1d        dec     e
09ec 20f8      jr      nz,09e6h
09ee d9        exx     
09ef c3180d    jp      0d18h
09f2 d9        exx     
09f3 7a        ld      a,d
09f4 ed79      out     (c),a
09f6 c9        ret     

09f7 6f        ld      l,a
09f8 2600      ld      h,00h
09fa 29        add     hl,hl
09fb 01070a    ld      bc,0a07h
09fe 09        add     hl,bc
09ff 42        ld      b,d
0a00 0e00      ld      c,00h
0a02 7e        ld      a,(hl)
0a03 23        inc     hl
0a04 66        ld      h,(hl)
0a05 6f        ld      l,a
0a06 e9        jp      (hl)
0a07 27        daa     
0a08 0a        ld      a,(bc)
0a09 29        add     hl,hl
0a0a 0a        ld      a,(bc)
0a0b 310a3c    ld      sp,3c0ah
0a0e 0a        ld      a,(bc)
0a0f 42        ld      b,d
0a10 0a        ld      a,(bc)
0a11 4d        ld      c,l
0a12 0a        ld      a,(bc)
0a13 56        ld      d,(hl)
0a14 0a        ld      a,(bc)
0a15 61        ld      h,c
0a16 0a        ld      a,(bc)
0a17 65        ld      h,l
0a18 0a        ld      a,(bc)
0a19 70        ld      (hl),b
0a1a 0a        ld      a,(bc)
0a1b 79        ld      a,c
0a1c 0a        ld      a,(bc)
0a1d 85        add     a,l
0a1e 0a        ld      a,(bc)
0a1f 8c        adc     a,h
0a20 0a        ld      a,(bc)
0a21 98        sbc     a,b
0a22 0a        ld      a,(bc)
0a23 a1        and     c
0a24 0a        ld      a,(bc)
0a25 ac        xor     h
0a26 0a        ld      a,(bc)
0a27 af        xor     a
0a28 c9        ret     

0a29 cb3a      srl     d
0a2b cb3a      srl     d
0a2d cb3a      srl     d
0a2f 7a        ld      a,d
0a30 c9        ret     

0a31 cb3a      srl     d
0a33 cb3a      srl     d
0a35 7a        ld      a,d
0a36 cb3a      srl     d
0a38 cb3a      srl     d
0a3a 92        sub     d
0a3b c9        ret     

0a3c cb3a      srl     d
0a3e cb3a      srl     d
0a40 7a        ld      a,d
0a41 c9        ret     

0a42 cb3a      srl     d
0a44 cb3a      srl     d
0a46 7a        ld      a,d
0a47 cb3a      srl     d
0a49 cb3a      srl     d
0a4b 82        add     a,d
0a4c c9        ret     

0a4d cb3a      srl     d
0a4f cb3a      srl     d
0a51 7a        ld      a,d
0a52 cb3a      srl     d
0a54 82        add     a,d
0a55 c9        ret     

0a56 cb3a      srl     d
0a58 7a        ld      a,d
0a59 cb3a      srl     d
0a5b cb3a      srl     d
0a5d cb3a      srl     d
0a5f 92        sub     d
0a60 c9        ret     

0a61 cb3a      srl     d
0a63 7a        ld      a,d
0a64 c9        ret     

0a65 cb3a      srl     d
0a67 7a        ld      a,d
0a68 cb3a      srl     d
0a6a cb3a      srl     d
0a6c cb3a      srl     d
0a6e 82        add     a,d
0a6f c9        ret     

0a70 cb3a      srl     d
0a72 7a        ld      a,d
0a73 cb3a      srl     d
0a75 cb3a      srl     d
0a77 82        add     a,d
0a78 c9        ret     

0a79 cb3a      srl     d
0a7b 7a        ld      a,d
0a7c cb3a      srl     d
0a7e cb3a      srl     d
0a80 82        add     a,d
0a81 cb3a      srl     d
0a83 82        add     a,d
0a84 c9        ret     

0a85 cb3a      srl     d
0a87 7a        ld      a,d
0a88 cb3a      srl     d
0a8a 82        add     a,d
0a8b c9        ret     

0a8c cb3a      srl     d
0a8e 7a        ld      a,d
0a8f cb3a      srl     d
0a91 82        add     a,d
0a92 cb3a      srl     d
0a94 cb3a      srl     d
0a96 82        add     a,d
0a97 c9        ret     

0a98 7a        ld      a,d
0a99 cb3a      srl     d
0a9b cb3a      srl     d
0a9d cb3a      srl     d
0a9f 92        sub     d
0aa0 c9        ret     

0aa1 7a        ld      a,d
0aa2 cb3a      srl     d
0aa4 cb3a      srl     d
0aa6 cb3a      srl     d
0aa8 cb3a      srl     d
0aaa 92        sub     d
0aab c9        ret     

0aac 7a        ld      a,d
0aad c9        ret     

0aae 1b        dec     de
0aaf dd7e00    ld      a,(ix+00h)
0ab2 fe02      cp      02h
0ab4 200e      jr      nz,0ac4h
0ab6 dd4e35    ld      c,(ix+35h)
0ab9 79        ld      a,c
0aba 3c        inc     a
0abb 2804      jr      z,0ac1h
0abd 0694      ld      b,94h
0abf af        xor     a
0ac0 02        ld      (bc),a
0ac1 dd7735    ld      (ix+35h),a
0ac4 af        xor     a
0ac5 dd7700    ld      (ix+00h),a
0ac8 dd770d    ld      (ix+0dh),a
0acb dd7721    ld      (ix+21h),a
0ace dd7734    ld      (ix+34h),a
0ad1 dd7736    ld      (ix+36h),a
0ad4 d5        push    de
0ad5 dde5      push    ix
0ad7 e1        pop     hl
0ad8 010080    ld      bc,8000h
0adb af        xor     a
0adc ed42      sbc     hl,bc
0ade 7c        ld      a,h
0adf fe0c      cp      0ch
0ae1 3803      jr      c,0ae6h
0ae3 d60c      sub     0ch
0ae5 67        ld      h,a
0ae6 3e0b      ld      a,0bh
0ae8 94        sub     h
0ae9 5f        ld      e,a
0aea 0e00      ld      c,00h
0aec 51        ld      d,c
0aed 3e18      ld      a,18h
0aef cdde09    call    09deh
0af2 d1        pop     de
0af3 c32308    jp      0823h
0af6 dde5      push    ix
0af8 e1        pop     hl
0af9 dd7e03    ld      a,(ix+03h)
0afc 6f        ld      l,a
0afd 1a        ld      a,(de)
0afe 13        inc     de
0aff 4f        ld      c,a
0b00 2d        dec     l
0b01 72        ld      (hl),d
0b02 2d        dec     l
0b03 73        ld      (hl),e
0b04 2d        dec     l
0b05 71        ld      (hl),c
0b06 7d        ld      a,l
0b07 dd7703    ld      (ix+03h),a
0b0a 1a        ld      a,(de)
0b0b 13        inc     de
0b0c 4f        ld      c,a
0b0d 1a        ld      a,(de)
0b0e 57        ld      d,a
0b0f 59        ld      e,c
0b10 c37b07    jp      077bh
0b13 dde5      push    ix
0b15 e1        pop     hl
0b16 dd7e03    ld      a,(ix+03h)
0b19 6f        ld      l,a
0b1a 35        dec     (hl)
0b1b 2806      jr      z,0b23h
0b1d 2c        inc     l
0b1e 5e        ld      e,(hl)
0b1f 2c        inc     l
0b20 56        ld      d,(hl)
0b21 18e7      jr      0b0ah
0b23 2c        inc     l
0b24 5e        ld      e,(hl)
0b25 2c        inc     l
0b26 56        ld      d,(hl)
0b27 2c        inc     l
0b28 7d        ld      a,l
0b29 dd7703    ld      (ix+03h),a
0b2c 13        inc     de
0b2d 13        inc     de
0b2e c37b07    jp      077bh
0b31 1a        ld      a,(de)
0b32 13        inc     de
0b33 dd7709    ld      (ix+09h),a
0b36 1a        ld      a,(de)
0b37 13        inc     de
0b38 dd770a    ld      (ix+0ah),a
0b3b af        xor     a
0b3c dd772c    ld      (ix+2ch),a
0b3f dd772d    ld      (ix+2dh),a
0b42 c37b07    jp      077bh
0b45 1a        ld      a,(de)
0b46 13        inc     de
0b47 dd7705    ld      (ix+05h),a
0b4a ddcb08c6  set     0,(ix+08h)
0b4e c37b07    jp      077bh
0b51 ddcb0886  res     0,(ix+08h)
0b55 c37b07    jp      077bh
0b58 1a        ld      a,(de)
0b59 13        inc     de
0b5a dd770e    ld      (ix+0eh),a
0b5d 1a        ld      a,(de)
0b5e 13        inc     de
0b5f dd770f    ld      (ix+0fh),a
0b62 1a        ld      a,(de)
0b63 13        inc     de
0b64 dd7710    ld      (ix+10h),a
0b67 1a        ld      a,(de)
0b68 13        inc     de
0b69 dd7711    ld      (ix+11h),a
0b6c 1a        ld      a,(de)
0b6d 13        inc     de
0b6e dd7712    ld      (ix+12h),a
0b71 1a        ld      a,(de)
0b72 13        inc     de
0b73 dd7713    ld      (ix+13h),a
0b76 1a        ld      a,(de)
0b77 13        inc     de
0b78 dd7714    ld      (ix+14h),a
0b7b c37b07    jp      077bh
0b7e 1a        ld      a,(de)
0b7f 13        inc     de
0b80 dd770b    ld      (ix+0bh),a
0b83 c37b07    jp      077bh
0b86 1a        ld      a,(de)
0b87 13        inc     de
0b88 dd770c    ld      (ix+0ch),a
0b8b c37b07    jp      077bh
0b8e 1a        ld      a,(de)
0b8f 13        inc     de
0b90 dd771d    ld      (ix+1dh),a
0b93 1a        ld      a,(de)
0b94 13        inc     de
0b95 dd7719    ld      (ix+19h),a
0b98 1a        ld      a,(de)
0b99 13        inc     de
0b9a dd771f    ld      (ix+1fh),a
0b9d 1a        ld      a,(de)
0b9e 13        inc     de
0b9f dd771e    ld      (ix+1eh),a
0ba2 c37b07    jp      077bh
0ba5 dd361d00  ld      (ix+1dh),00h
0ba9 c37b07    jp      077bh
0bac 1a        ld      a,(de)
0bad 13        inc     de
0bae dd7720    ld      (ix+20h),a
0bb1 c37b07    jp      077bh
0bb4 1a        ld      a,(de)
0bb5 13        inc     de
0bb6 dd8620    add     a,(ix+20h)
0bb9 dd7720    ld      (ix+20h),a
0bbc c37b07    jp      077bh
0bbf 1a        ld      a,(de)
0bc0 13        inc     de
0bc1 321b95    ld      (951bh),a
0bc4 c37b07    jp      077bh
0bc7 3a1b95    ld      a,(951bh)
0bca 4f        ld      c,a
0bcb 1a        ld      a,(de)
0bcc 13        inc     de
0bcd 81        add     a,c
0bce 321b95    ld      (951bh),a
0bd1 c37b07    jp      077bh
0bd4 1a        ld      a,(de)
0bd5 13        inc     de
0bd6 212080    ld      hl,8020h
0bd9 060c      ld      b,0ch
0bdb 77        ld      (hl),a
0bdc 24        inc     h
0bdd 10fc      djnz    0bdbh
0bdf c37b07    jp      077bh
0be2 1a        ld      a,(de)
0be3 13        inc     de
0be4 4f        ld      c,a
0be5 212080    ld      hl,8020h
0be8 060c      ld      b,0ch
0bea 7e        ld      a,(hl)
0beb 81        add     a,c
0bec 77        ld      (hl),a
0bed 24        inc     h
0bee 10fa      djnz    0beah
0bf0 c37b07    jp      077bh
0bf3 1a        ld      a,(de)
0bf4 13        inc     de
0bf5 dd772f    ld      (ix+2fh),a
0bf8 1a        ld      a,(de)
0bf9 13        inc     de
0bfa 3c        inc     a
0bfb dd772e    ld      (ix+2eh),a
0bfe 1a        ld      a,(de)
0bff 13        inc     de
0c00 3c        inc     a
0c01 dd7730    ld      (ix+30h),a
0c04 1a        ld      a,(de)
0c05 13        inc     de
0c06 ed44      neg     
0c08 dd772a    ld      (ix+2ah),a
0c0b 1a        ld      a,(de)
0c0c 13        inc     de
0c0d dd7731    ld      (ix+31h),a
0c10 c37b07    jp      077bh
0c13 1a        ld      a,(de)
0c14 13        inc     de
0c15 dd772f    ld      (ix+2fh),a
0c18 1a        ld      a,(de)
0c19 13        inc     de
0c1a 3c        inc     a
0c1b dd772e    ld      (ix+2eh),a
0c1e 1a        ld      a,(de)
0c1f 13        inc     de
0c20 3c        inc     a
0c21 dd7730    ld      (ix+30h),a
0c24 1a        ld      a,(de)
0c25 13        inc     de
0c26 dd772a    ld      (ix+2ah),a
0c29 1a        ld      a,(de)
0c2a 13        inc     de
0c2b dd7731    ld      (ix+31h),a
0c2e c37b07    jp      077bh
0c31 1a        ld      a,(de)
0c32 13        inc     de
0c33 dd771d    ld      (ix+1dh),a
0c36 1a        ld      a,(de)
0c37 13        inc     de
0c38 dd7719    ld      (ix+19h),a
0c3b dd771e    ld      (ix+1eh),a
0c3e 1a        ld      a,(de)
0c3f 13        inc     de
0c40 dd771f    ld      (ix+1fh),a
0c43 c37b07    jp      077bh
0c46 ddcb08ce  set     1,(ix+08h)
0c4a c37b07    jp      077bh
0c4d ddcb088e  res     1,(ix+08h)
0c51 c37b07    jp      077bh
0c54 1a        ld      a,(de)
0c55 13        inc     de
0c56 dd7706    ld      (ix+06h),a
0c59 c37b07    jp      077bh
0c5c ddcb08d6  set     2,(ix+08h)
0c60 c37b07    jp      077bh
0c63 ddcb0896  res     2,(ix+08h)
0c67 c37b07    jp      077bh
0c6a af        xor     a
0c6b dd770d    ld      (ix+0dh),a
0c6e dd7722    ld      (ix+22h),a
0c71 dd7723    ld      (ix+23h),a
0c74 3c        inc     a
0c75 dd7721    ld      (ix+21h),a
0c78 d5        push    de
0c79 dde5      push    ix
0c7b e1        pop     hl
0c7c 010080    ld      bc,8000h
0c7f af        xor     a
0c80 ed42      sbc     hl,bc
0c82 7c        ld      a,h
0c83 fe0c      cp      0ch
0c85 3803      jr      c,0c8ah
0c87 d60c      sub     0ch
0c89 67        ld      h,a
0c8a 3e0b      ld      a,0bh
0c8c 94        sub     h
0c8d 5f        ld      e,a
0c8e 0e00      ld      c,00h
0c90 51        ld      d,c
0c91 3e18      ld      a,18h
0c93 cdde09    call    09deh
0c96 d1        pop     de
0c97 c37b07    jp      077bh
0c9a dd362e00  ld      (ix+2eh),00h
0c9e c37b07    jp      077bh
0ca1 1a        ld      a,(de)
0ca2 13        inc     de
0ca3 dd772c    ld      (ix+2ch),a
0ca6 0e00      ld      c,00h
0ca8 cb7f      bit     7,a
0caa 2801      jr      z,0cadh
0cac 0d        dec     c
0cad dd712d    ld      (ix+2dh),c
0cb0 c37b07    jp      077bh
0cb3 ddcb08e6  set     4,(ix+08h)
0cb7 c37b07    jp      077bh
0cba ae        xor     (hl)
0cbb 0a        ld      a,(bc)
0cbc 0a        ld      a,(bc)
0cbd 0b        dec     bc
0cbe 310bf6    ld      sp,0f60bh
0cc1 0a        ld      a,(bc)
0cc2 13        inc     de
0cc3 0b        dec     bc
0cc4 45        ld      b,l
0cc5 0b        dec     bc
0cc6 51        ld      d,c
0cc7 0b        dec     bc
0cc8 58        ld      e,b
0cc9 0b        dec     bc
0cca 7e        ld      a,(hl)
0ccb 0b        dec     bc
0ccc 86        add     a,(hl)
0ccd 0b        dec     bc
0cce 8e        adc     a,(hl)
0ccf 0b        dec     bc
0cd0 a5        and     l
0cd1 0b        dec     bc
0cd2 ac        xor     h
0cd3 0b        dec     bc
0cd4 b4        or      h
0cd5 0b        dec     bc
0cd6 bf        cp      a
0cd7 0b        dec     bc
0cd8 c7        rst     00h
0cd9 0b        dec     bc
0cda d40be2    call    nc,0e20bh
0cdd 0b        dec     bc
0cde 13        inc     de
0cdf 0c        inc     c
0ce0 f3        di      
0ce1 0b        dec     bc
0ce2 310c46    ld      sp,460ch
0ce5 0c        inc     c
0ce6 4d        ld      c,l
0ce7 0c        inc     c
0ce8 54        ld      d,h
0ce9 0c        inc     c
0cea 5c        ld      e,h
0ceb 0c        inc     c
0cec 63        ld      h,e
0ced 0c        inc     c
0cee 6a        ld      l,d
0cef 0c        inc     c
0cf0 9a        sbc     a,d
0cf1 0c        inc     c
0cf2 a1        and     c
0cf3 0c        inc     c
0cf4 b3        or      e
0cf5 0c        inc     c
0cf6 010000    ld      bc,0000h
0cf9 0b        dec     bc
0cfa 78        ld      a,b
0cfb b1        or      c
0cfc 20fb      jr      nz,0cf9h
0cfe 15        dec     d
0cff 20f5      jr      nz,0cf6h
0d01 c9        ret     

0d02 1e00      ld      e,00h
0d04 010680    ld      bc,8006h
0d07 ed78      in      a,(c)
0d09 fa120d    jp      m,0d12h
0d0c 1d        dec     e
0d0d 20f8      jr      nz,0d07h
0d0f c3180d    jp      0d18h
0d12 7d        ld      a,l
0d13 4c        ld      c,h
0d14 42        ld      b,d
0d15 ed79      out     (c),a
0d17 c9        ret     

L0d18:
0d18 af        xor     a
0d19 010280    ld      bc,8002h
0d1c ed79      out     (c),a
0d1e 3e80      ld      a,80h
0d20 ed79      out     (c),a
0d22 18f4      jr      L0d18

0d24 ed56      im      1
0d26 af        xor     a
0d27 4f        ld      c,a
0d28 0605      ld      b,05h
0d2a ed79      out     (c),a
0d2c af        xor     a
0d2d 010280    ld      bc,8002h
0d30 ed79      out     (c),a
0d32 3e80      ld      a,80h
0d34 ed79      out     (c),a
0d36 c9        ret     

L0d37:					;void wait_ctrl_from_main(u8 c)
0d37 010080    ld      bc,8000h
0d3a d9        exx     
0d3b 010480    ld      bc,8004h
0d3e ed78      in      a,(c)		;do {
0d40 fa3e0d    jp      m,0d3eh
0d43 d9        exx     
0d44 ed78      in      a,(c)		;  u8 d = *CTRL_DATA;
0d46 bb        cp      e
0d47 d9        exx     
0d48 20f4      jr      nz,0d3eh	;} while (d != c);
0d4a c9        ret     

L0d4b:					;void send_resp_to_main(u8 d)
0d4b 010580    ld      bc,8005h
0d4e ed78      in      a,(c)
0d50 f24e0d    jp      p,0d4eh
0d53 010080    ld      bc,8000h
0d56 7b        ld      a,e
0d57 ed79      out     (c),a		;*RESP_DATA = d;
0d59 c9        ret     

L0d5a:					;void receive_ctrl_from_main(u8* port)
0d5a 0e04      ld      c,04h
0d5c ed78      in      a,(c)	
0d5e fa5c0d    jp      m,0d5ch	;while ((u8 d = *port) & 0x80);
0d61 0e00      ld      c,00h
0d63 ed78      in      a,(c)		;return *CTRL_DATA;
0d65 c9        ret     

0d66 1600      ld      d,00h
0d68 010480    ld      bc,8004h
0d6b ed78      in      a,(c)
0d6d fa6b0d    jp      m,0d6bh
0d70 010080    ld      bc,8000h
0d73 ed78      in      a,(c)
0d75 7a        ld      a,d
0d76 ed79      out     (c),a
0d78 14        inc     d
0d79 010580    ld      bc,8005h
0d7c ed78      in      a,(c)
0d7e f27c0d    jp      p,0d7ch
0d81 18e8      jr      0d6bh
0d83 00        nop     
0d84 00        nop     
0d85 00        nop     
0d86 77        ld      (hl),a
0d87 00        nop     
0d88 7d        ld      a,l
0d89 00        nop     
0d8a 85        add     a,l
0d8b 00        nop     
0d8c 8d        adc     a,l
0d8d 00        nop     
0d8e 96        sub     (hl)
0d8f 00        nop     
0d90 9e        sbc     a,(hl)
0d91 00        nop     
0d92 a8        xor     b
0d93 00        nop     
0d94 b1        or      c
0d95 00        nop     
0d96 bd        cp      l
0d97 00        nop     
0d98 c8        ret     z

0d99 00        nop     
0d9a d400e0    call    nc,0e000h
0d9d 00        nop     
0d9e ee00      xor     00h
0da0 fc000b    call    m,0b00h
0da3 011a01    ld      bc,011ah
0da6 2b        dec     hl
0da7 013d01    ld      bc,013dh
0daa 50        ld      d,b
0dab 016401    ld      bc,0164h
0dae 79        ld      a,c
0daf 019001    ld      bc,0190h
0db2 a8        xor     b
0db3 01c101    ld      bc,01c1h
0db6 dc01f8    call    c,0f801h
0db9 011502    ld      bc,0215h
0dbc 35        dec     (hl)
0dbd 02        ld      (bc),a
0dbe 57        ld      d,a
0dbf 02        ld      (bc),a
0dc0 7b        ld      a,e
0dc1 02        ld      (bc),a
0dc2 a1        and     c
0dc3 02        ld      (bc),a
0dc4 c9        ret     

0dc5 02        ld      (bc),a
0dc6 f20220    jp      p,2002h
0dc9 03        inc     bc
0dca 4f        ld      c,a
0dcb 03        inc     bc
0dcc 82        add     a,d
0dcd 03        inc     bc
0dce b7        or      a
0dcf 03        inc     bc
0dd0 ef        rst     28h
0dd1 03        inc     bc
0dd2 2c        inc     l
0dd3 04        inc     b
0dd4 6b        ld      l,e
0dd5 04        inc     b
0dd6 af        xor     a
0dd7 04        inc     b
0dd8 f5        push    af
0dd9 04        inc     b
0dda 41        ld      b,c
0ddb 05        dec     b
0ddc 91        sub     c
0ddd 05        dec     b
0dde e605      and     05h
0de0 40        ld      b,b
0de1 069f      ld      b,9fh
0de3 0604      ld      b,04h
0de5 07        rlca    
0de6 6f        ld      l,a
0de7 07        rlca    
0de8 df        rst     18h
0de9 07        rlca    
0dea 57        ld      d,a
0deb 08        ex      af,af'
0dec d7        rst     10h
0ded 08        ex      af,af'
0dee 5d        ld      e,l
0def 09        add     hl,bc
0df0 eb        ex      de,hl
0df1 09        add     hl,bc
0df2 83        add     a,e
0df3 0a        ld      a,(bc)
0df4 23        inc     hl
0df5 0b        dec     bc
0df6 cc0b80    call    z,800bh
0df9 0c        inc     c
0dfa 3f        ccf     
0dfb 0d        dec     c
0dfc 08        ex      af,af'
0dfd 0ede      ld      c,0deh
0dff 0ec0      ld      c,0c0h
0e01 0f        rrca    
0e02 af        xor     a
0e03 10ad      djnz    0db2h
0e05 11ba12    ld      de,12bah
0e08 d8        ret     c

0e09 13        inc     de
0e0a 0615      ld      b,15h
0e0c 46        ld      b,(hl)
0e0d 1699      ld      d,99h
0e0f 17        rla     
0e10 00        nop     
0e11 19        add     hl,de
0e12 7d        ld      a,l
0e13 1a        ld      a,(de)
0e14 101c      djnz    0e32h
0e16 bc        cp      h
0e17 1d        dec     e
0e18 80        add     a,b
0e19 1f        rra     
0e1a 60        ld      h,b
0e1b 215b23    ld      hl,235bh
0e1e 76        halt    
0e1f 25        dec     h
0e20 b0        or      b
0e21 27        daa     
0e22 0c        inc     c
0e23 2a8d2c    ld      hl,(2c8dh)
0e26 322f01    ld      (012fh),a
0e29 32fa34    ld      (34fah),a
0e2c 213877    ld      hl,7738h
0e2f 3b        dec     sp
0e30 00        nop     
0e31 3f        ccf     
0e32 bf        cp      a
0e33 42        ld      b,d
0e34 b7        or      a
0e35 46        ld      b,(hl)
0e36 ec4a61    call    pe,614ah
0e39 4f        ld      c,a
0e3a 19        add     hl,de
0e3b 54        ld      d,h
0e3c 19        add     hl,de
0e3d 59        ld      e,c
0e3e 65        ld      h,l
0e3f 5e        ld      e,(hl)
0e40 02        ld      (bc),a
0e41 64        ld      h,h
0e42 f46941    call    p,4169h
0e45 70        ld      (hl),b
0e46 00        nop     
0e47 00        nop     
0e48 00        nop     
0e49 02        ld      (bc),a
0e4a 00        nop     
0e4b 02        ld      (bc),a
0e4c 00        nop     
0e4d 02        ld      (bc),a
0e4e 00        nop     
0e4f 02        ld      (bc),a
0e50 00        nop     
0e51 04        inc     b
0e52 00        nop     
0e53 04        inc     b
0e54 00        nop     
0e55 04        inc     b
0e56 00        nop     
0e57 04        inc     b
0e58 00        nop     
0e59 0600      ld      b,00h
0e5b 0600      ld      b,00h
0e5d 0600      ld      b,00h
0e5f 08        ex      af,af'
0e60 00        nop     
0e61 08        ex      af,af'
0e62 00        nop     
0e63 0a        ld      a,(bc)
0e64 00        nop     
0e65 0a        ld      a,(bc)
0e66 00        nop     
0e67 0a        ld      a,(bc)
0e68 00        nop     
0e69 0c        inc     c
0e6a 00        nop     
0e6b 0c        inc     c
0e6c 00        nop     
0e6d 0c        inc     c
0e6e 00        nop     
0e6f 0e00      ld      c,00h
0e71 0e00      ld      c,00h
0e73 1000      djnz    0e75h
0e75 1000      djnz    0e77h
0e77 1000      djnz    0e79h
0e79 12        ld      (de),a
0e7a 00        nop     
0e7b 12        ld      (de),a
0e7c 00        nop     
0e7d 14        inc     d
0e7e 00        nop     
0e7f 14        inc     d
0e80 00        nop     
0e81 1600      ld      d,00h
0e83 1600      ld      d,00h
0e85 1800      jr      0e87h
0e87 1800      jr      0e89h
0e89 1a        ld      a,(de)
0e8a 00        nop     
0e8b 1a        ld      a,(de)
0e8c 00        nop     
0e8d 1a        ld      a,(de)
0e8e 00        nop     
0e8f 1c        inc     e
0e90 00        nop     
0e91 1c        inc     e
0e92 00        nop     
0e93 1c        inc     e
0e94 00        nop     
0e95 1e00      ld      e,00h
0e97 1e00      ld      e,00h
0e99 2000      jr      nz,0e9bh
0e9b 220022    ld      (2200h),hl
0e9e 00        nop     
0e9f 24        inc     h
0ea0 00        nop     
0ea1 24        inc     h
0ea2 00        nop     
0ea3 2600      ld      h,00h
0ea5 2600      ld      h,00h
0ea7 2800      jr      z,0ea9h
0ea9 2a002a    ld      hl,(2a00h)
0eac 00        nop     
0ead 2c        inc     l
0eae 00        nop     
0eaf 2c        inc     l
0eb0 00        nop     
0eb1 2e00      ld      l,00h
0eb3 2e00      ld      l,00h
0eb5 3000      jr      nc,0eb7h
0eb7 3000      jr      nc,0eb9h
0eb9 320034    ld      (3400h),a
0ebc 00        nop     
0ebd 3600      ld      (hl),00h
0ebf 3600      ld      (hl),00h
0ec1 3800      jr      c,0ec3h
0ec3 3a003c    ld      a,(3c00h)
0ec6 00        nop     
0ec7 3c        inc     a
0ec8 00        nop     
0ec9 3e00      ld      a,00h
0ecb 3e00      ld      a,00h
0ecd 40        ld      b,b
0ece 00        nop     
0ecf 42        ld      b,d
0ed0 00        nop     
0ed1 44        ld      b,h
0ed2 00        nop     
0ed3 46        ld      b,(hl)
0ed4 00        nop     
0ed5 48        ld      c,b
0ed6 00        nop     
0ed7 48        ld      c,b
0ed8 00        nop     
0ed9 4a        ld      c,d
0eda 00        nop     
0edb 4a        ld      c,d
0edc 00        nop     
0edd 4c        ld      c,h
0ede 00        nop     
0edf 4e        ld      c,(hl)
0ee0 00        nop     
0ee1 50        ld      d,b
0ee2 00        nop     
0ee3 50        ld      d,b
0ee4 00        nop     
0ee5 52        ld      d,d
0ee6 00        nop     
0ee7 54        ld      d,h
0ee8 00        nop     
0ee9 56        ld      d,(hl)
0eea 00        nop     
0eeb 58        ld      e,b
0eec 00        nop     
0eed 5a        ld      e,d
0eee 00        nop     
0eef 5c        ld      e,h
0ef0 00        nop     
0ef1 5e        ld      e,(hl)
0ef2 00        nop     
0ef3 60        ld      h,b
0ef4 00        nop     
0ef5 62        ld      h,d
0ef6 00        nop     
0ef7 64        ld      h,h
0ef8 00        nop     
0ef9 66        ld      h,(hl)
0efa 00        nop     
0efb 68        ld      l,b
0efc 00        nop     
0efd 6a        ld      l,d
0efe 00        nop     
0eff 6c        ld      l,h
0f00 00        nop     
0f01 6e        ld      l,(hl)
0f02 00        nop     
0f03 70        ld      (hl),b
0f04 00        nop     
0f05 72        ld      (hl),d
0f06 00        nop     
0f07 74        ld      (hl),h
0f08 00        nop     
0f09 76        halt    
0f0a 00        nop     
0f0b 78        ld      a,b
0f0c 00        nop     
0f0d 7a        ld      a,d
0f0e 00        nop     
0f0f 7c        ld      a,h
0f10 00        nop     
0f11 7e        ld      a,(hl)
0f12 00        nop     
0f13 80        add     a,b
0f14 00        nop     
0f15 82        add     a,d
0f16 00        nop     
0f17 84        add     a,h
0f18 00        nop     
0f19 88        adc     a,b
0f1a 00        nop     
0f1b 8c        adc     a,h
0f1c 00        nop     
0f1d 90        sub     b
0f1e 00        nop     
0f1f 94        sub     h
0f20 00        nop     
0f21 98        sbc     a,b
0f22 00        nop     
0f23 9a        sbc     a,d
0f24 00        nop     
0f25 9c        sbc     a,h
0f26 00        nop     
0f27 a0        and     b
0f28 00        nop     
0f29 a4        and     h
0f2a 00        nop     
0f2b a8        xor     b
0f2c 00        nop     
0f2d ac        xor     h
0f2e 00        nop     
0f2f b2        or      d
0f30 00        nop     
0f31 b6        or      (hl)
0f32 00        nop     
0f33 ba        cp      d
0f34 00        nop     
0f35 c0        ret     nz

0f36 00        nop     
0f37 c8        ret     z

0f38 00        nop     
0f39 d0        ret     nc

0f3a 00        nop     
0f3b d8        ret     c

0f3c 00        nop     
0f3d dc00e6    call    c,0e600h
0f40 00        nop     
0f41 e600      and     00h
0f43 f0        ret     p

0f44 00        nop     
0f45 fe20      cp      20h
0f47 30cb      jr      nc,0f14h
0f49 1c        inc     e
0f4a 2050      jr      nz,0f9ch
0f4c c5        push    bc
0f4d 1c        inc     e
0f4e 2050      jr      nz,0fa0h
0f50 b9        cp      c
0f51 1c        inc     e
0f52 1c        inc     e
0f53 50        ld      d,b
0f54 b3        or      e
0f55 1c        inc     e
0f56 2050      jr      nz,0fa8h
0f58 ad        xor     l
0f59 1c        inc     e
0f5a 2050      jr      nz,0fach
0f5c a5        and     l
0f5d 1c        inc     e
0f5e 2050      jr      nz,0fb0h
0f60 9f        sbc     a,a
0f61 1c        inc     e
0f62 1860      jr      0fc4h
0f64 80        add     a,b
0f65 1c        inc     e
0f66 00        nop     
0f67 60        ld      h,b
0f68 70        ld      (hl),b
0f69 1c        inc     e
0f6a 2060      jr      nz,0fcch
0f6c 5e        ld      e,(hl)
0f6d 1c        inc     e
0f6e 2060      jr      nz,0fd0h
0f70 4e        ld      c,(hl)
0f71 1c        inc     e
0f72 2060      jr      nz,0fd4h
0f74 061c      ld      b,1ch
0f76 2060      jr      nz,0fd8h
0f78 00        nop     
0f79 1c        inc     e
0f7a 2060      jr      nz,0fdch
0f7c e61b      and     1bh
0f7e 2060      jr      nz,0fe0h
0f80 d1        pop     de
0f81 1b        dec     de
0f82 2060      jr      nz,0fe4h
0f84 c61b      add     a,1bh
0f86 2060      jr      nz,0fe8h
0f88 be        cp      (hl)
0f89 1b        dec     de
0f8a 2060      jr      nz,0fech
0f8c b5        or      l
0f8d 1b        dec     de
0f8e 2060      jr      nz,0ff0h
0f90 ac        xor     h
0f91 1b        dec     de
0f92 1d        dec     e
0f93 60        ld      h,b
0f94 a6        and     (hl)
0f95 1b        dec     de
0f96 1660      ld      d,60h
0f98 a0        and     b
0f99 1b        dec     de
0f9a 02        ld      (bc),a
0f9b 60        ld      h,b
0f9c 90        sub     b
0f9d 1b        dec     de
0f9e 2060      jr      nz,1000h
0fa0 86        add     a,(hl)
0fa1 1b        dec     de
0fa2 2060      jr      nz,1004h
0fa4 76        halt    
0fa5 1b        dec     de
0fa6 23        inc     hl
0fa7 60        ld      h,b
0fa8 60        ld      h,b
0fa9 1b        dec     de
0faa 1a        ld      a,(de)
0fab 60        ld      h,b
0fac 4a        ld      c,d
0fad 1b        dec     de
0fae 2060      jr      nz,1010h
0fb0 34        inc     (hl)
0fb1 1b        dec     de
0fb2 1f        rra     
0fb3 60        ld      h,b
0fb4 2e1b      ld      l,1bh
0fb6 1f        rra     
0fb7 60        ld      h,b
0fb8 161b      ld      d,1bh
0fba 0b        dec     bc
0fbb 60        ld      h,b
0fbc 0e1b      ld      c,1bh
0fbe 1b        dec     de
0fbf 60        ld      h,b
0fc0 061b      ld      b,1bh
0fc2 2860      jr      z,1024h
0fc4 fe1a      cp      1ah
0fc6 2060      jr      nz,1028h
0fc8 f61a      or      1ah
0fca 204f      jr      nz,101bh
0fcc eb        ex      de,hl
0fcd 1a        ld      a,(de)
0fce 2060      jr      nz,1030h
0fd0 e0        ret     po

0fd1 1a        ld      a,(de)
0fd2 2060      jr      nz,1034h
0fd4 b4        or      h
0fd5 1a        ld      a,(de)
0fd6 2060      jr      nz,1038h
0fd8 a4        and     h
0fd9 1a        ld      a,(de)
0fda 2060      jr      nz,103ch
0fdc 9e        sbc     a,(hl)
0fdd 1a        ld      a,(de)
0fde 105f      djnz    103fh
0fe0 7e        ld      a,(hl)
0fe1 1a        ld      a,(de)
0fe2 2060      jr      nz,1044h
0fe4 181c      jr      1002h
0fe6 2060      jr      nz,1048h
0fe8 1e1c      ld      e,1ch
0fea 2060      jr      nz,104ch
0fec 24        inc     h
0fed 1c        inc     e
0fee 2060      jr      nz,1050h
0ff0 2a1c20    ld      hl,(201ch)
0ff3 60        ld      h,b
0ff4 301c      jr      nc,1012h
0ff6 2060      jr      nz,1058h
0ff8 361c      ld      (hl),1ch
0ffa 2060      jr      nz,105ch
0ffc 3c        inc     a
0ffd 1c        inc     e
0ffe 2060      jr      nz,1060h
1000 6c        ld      l,h
1001 1a        ld      a,(de)
1002 2060      jr      nz,1064h
1004 72        ld      (hl),d
1005 1a        ld      a,(de)
1006 2060      jr      nz,1068h
1008 78        ld      a,b
1009 1a        ld      a,(de)
100a 113066    ld      de,6630h
100d 1a        ld      a,(de)
100e 2060      jr      nz,1070h
1010 42        ld      b,d
1011 1c        inc     e
1012 2060      jr      nz,1074h
1014 48        ld      c,b
1015 1c        inc     e
1016 2060      jr      nz,1078h
1018 57        ld      d,a
1019 1a        ld      a,(de)
101a 2060      jr      nz,107ch
101c 4d        ld      c,l
101d 1a        ld      a,(de)
101e 1f        rra     
101f 82        add     a,d
1020 45        ld      b,l
1021 1a        ld      a,(de)
1022 1e6c      ld      e,6ch
1024 3a1a20    ld      a,(201ah)
1027 60        ld      h,b
1028 34        inc     (hl)
1029 1a        ld      a,(de)
102a 1f        rra     
102b 60        ld      h,b
102c 2e1a      ld      l,1ah
102e 1660      ld      d,60h
1030 161a      ld      d,1ah
1032 1d        dec     e
1033 56        ld      d,(hl)
1034 101a      djnz    1050h
1036 2060      jr      nz,1098h
1038 0a        ld      a,(bc)
1039 1a        ld      a,(de)
103a 1d        dec     e
103b 60        ld      h,b
103c 04        inc     b
103d 1a        ld      a,(de)
103e 2060      jr      nz,10a0h
1040 ee19      xor     19h
1042 2060      jr      nz,10a4h
1044 e8        ret     pe

1045 19        add     hl,de
1046 2060      jr      nz,10a8h
1048 e21920    jp      po,2019h
104b 60        ld      h,b
104c d0        ret     nc

104d 1820      jr      106fh
104f 60        ld      h,b
1050 dc1920    call    c,2019h
1053 60        ld      h,b
1054 d619      sub     19h
1056 2060      jr      nz,10b8h
1058 d0        ret     nc

1059 19        add     hl,de
105a 2060      jr      nz,10bch
105c c8        ret     z

105d 19        add     hl,de
105e f660      or      60h
1060 b6        or      (hl)
1061 19        add     hl,de
1062 fb        ei      
1063 60        ld      h,b
1064 a6        and     (hl)
1065 19        add     hl,de
1066 2060      jr      nz,10c8h
1068 a0        and     b
1069 19        add     hl,de
106a 2078      jr      nz,10e4h
106c 90        sub     b
106d 19        add     hl,de
106e 2060      jr      nz,10d0h
1070 8a        adc     a,d
1071 19        add     hl,de
1072 2060      jr      nz,10d4h
1074 84        add     a,h
1075 19        add     hl,de
1076 2060      jr      nz,10d8h
1078 7e        ld      a,(hl)
1079 19        add     hl,de
107a 2060      jr      nz,10dch
107c 78        ld      a,b
107d 19        add     hl,de
107e 2060      jr      nz,10e0h
1080 72        ld      (hl),d
1081 19        add     hl,de
1082 2860      jr      z,10e4h
1084 6c        ld      l,h
1085 19        add     hl,de
1086 1860      jr      10e8h
1088 66        ld      h,(hl)
1089 19        add     hl,de
108a 1860      jr      10ech
108c 221a20    ld      (201ah),hl
108f 60        ld      h,b
1090 60        ld      h,b
1091 19        add     hl,de
1092 2060      jr      nz,10f4h
1094 4e        ld      c,(hl)
1095 19        add     hl,de
1096 2060      jr      nz,10f8h
1098 3c        inc     a
1099 19        add     hl,de
109a 2060      jr      nz,10fch
109c 2a1920    ld      hl,(2019h)
109f 60        ld      h,b
10a0 1819      jr      10bbh
10a2 2060      jr      nz,1104h
10a4 0619      ld      b,19h
10a6 2060      jr      nz,1108h
10a8 f41820    call    p,2018h
10ab 60        ld      h,b
10ac e21820    jp      po,2018h
10af 60        ld      h,b
10b0 c8        ret     z

10b1 1820      jr      10d3h
10b3 60        ld      h,b
10b4 be        cp      (hl)
10b5 1820      jr      10d7h
10b7 60        ld      h,b
10b8 b6        or      (hl)
10b9 1820      jr      10dbh
10bb 60        ld      h,b
10bc a4        and     h
10bd 1820      jr      10dfh
10bf 60        ld      h,b
10c0 98        sbc     a,b
10c1 1820      jr      10e3h
10c3 60        ld      h,b
10c4 82        add     a,d
10c5 1820      jr      10e7h
10c7 60        ld      h,b
10c8 72        ld      (hl),d
10c9 1820      jr      10ebh
10cb 60        ld      h,b
10cc 60        ld      h,b
10cd 180e      jr      10ddh
10cf 60        ld      h,b
10d0 50        ld      d,b
10d1 1820      jr      10f3h
10d3 60        ld      h,b
10d4 40        ld      b,b
10d5 1820      jr      10f7h
10d7 60        ld      h,b
10d8 34        inc     (hl)
10d9 1820      jr      10fbh
10db 60        ld      h,b
10dc 2e18      ld      l,18h
10de 15        dec     d
10df 60        ld      h,b
10e0 2818      jr      z,10fah
10e2 1860      jr      1144h
10e4 111820    ld      de,2018h
10e7 60        ld      h,b
10e8 0b        dec     bc
10e9 1820      jr      110bh
10eb 60        ld      h,b
10ec fd17      rla     
10ee 2060      jr      nz,1150h
10f0 f7        rst     30h
10f1 17        rla     
10f2 2060      jr      nz,1154h
10f4 e21720    jp      po,2017h
10f7 60        ld      h,b
10f8 dc1720    call    c,2017h
10fb 60        ld      h,b
10fc cc1720    call    z,2017h
10ff 60        ld      h,b
1100 b6        or      (hl)
1101 17        rla     
1102 14        inc     d
1103 60        ld      h,b
1104 b0        or      b
1105 17        rla     
1106 2060      jr      nz,1168h
1108 97        sub     a
1109 17        rla     
110a 2060      jr      nz,116ch
110c 81        add     a,c
110d 17        rla     
110e 2060      jr      nz,1170h
1110 75        ld      (hl),l
1111 17        rla     
1112 2060      jr      nz,1174h
1114 5f        ld      e,a
1115 17        rla     
1116 1b        dec     de
1117 6d        ld      l,l
1118 47        ld      b,a
1119 17        rla     
111a 2060      jr      nz,117ch
111c 39        add     hl,sp
111d 17        rla     
111e 2060      jr      nz,1180h
1120 23        inc     hl
1121 17        rla     
1122 2060      jr      nz,1184h
1124 ce1a      adc     a,1ah
1126 2060      jr      nz,1188h
1128 bc        cp      h
1129 1a        ld      a,(de)
112a 105f      djnz    118bh
112c 8e        adc     a,(hl)
112d 1a        ld      a,(de)
112e 0c        inc     c
112f 60        ld      h,b
1130 11170c    ld      de,0c17h
1133 60        ld      h,b
1134 ff        rst     38h
1135 1620      ld      d,20h
1137 60        ld      h,b
1138 f9        ld      sp,hl
1139 161c      ld      d,1ch
113b 7d        ld      a,l
113c de16      sbc     a,16h
113e 2060      jr      nz,11a0h
1140 d8        ret     c

1141 1620      ld      d,20h
1143 60        ld      h,b
1144 d21620    jp      nc,2016h
1147 60        ld      h,b
1148 cc1620    call    z,2016h
114b 60        ld      h,b
114c c0        ret     nz

114d 160c      ld      d,0ch
114f 60        ld      h,b
1150 b8        cp      b
1151 1620      ld      d,20h
1153 60        ld      h,b
1154 ae        xor     (hl)
1155 1620      ld      d,20h
1157 60        ld      h,b
1158 a8        xor     b
1159 1620      ld      d,20h
115b 60        ld      h,b
115c 8f        adc     a,a
115d 1620      ld      d,20h
115f 60        ld      h,b
1160 87        add     a,a
1161 1620      ld      d,20h
1163 60        ld      h,b
1164 77        ld      (hl),a
1165 1620      ld      d,20h
1167 60        ld      h,b
1168 67        ld      h,a
1169 1620      ld      d,20h
116b 60        ld      h,b
116c 57        ld      d,a
116d 160b      ld      d,0bh
116f 60        ld      h,b
1170 3016      jr      nc,1188h
1172 016014    ld      bc,1460h
1175 160b      ld      d,0bh
1177 60        ld      h,b
1178 f8        ret     m

1179 15        dec     d
117a 0b        dec     bc
117b 60        ld      h,b
117c e3        ex      (sp),hl
117d 15        dec     d
117e 0e60      ld      c,60h
1180 cb15      rl      l
1182 2060      jr      nz,11e4h
1184 bf        cp      a
1185 15        dec     d
1186 3c        inc     a
1187 60        ld      h,b
1188 b5        or      l
1189 15        dec     d
118a 14        inc     d
118b 60        ld      h,b
118c a5        and     l
118d 15        dec     d
118e 0660      ld      b,60h
1190 99        sbc     a,c
1191 15        dec     d
1192 13        inc     de
1193 60        ld      h,b
1194 93        sub     e
1195 15        dec     d
1196 3c        inc     a
1197 60        ld      h,b
1198 83        add     a,e
1199 15        dec     d
119a 1c        inc     e
119b 60        ld      h,b
119c 75        ld      (hl),l
119d 15        dec     d
119e 00        nop     
119f 60        ld      h,b
11a0 4a        ld      c,d
11a1 15        dec     d
11a2 00        nop     
11a3 60        ld      h,b
11a4 2e15      ld      l,15h
11a6 00        nop     
11a7 60        ld      h,b
11a8 d314      out     (14h),a
11aa 00        nop     
11ab 60        ld      h,b
11ac b4        or      h
11ad 14        inc     d
11ae 2060      jr      nz,1210h
11b0 ae        xor     (hl)
11b1 14        inc     d
11b2 2060      jr      nz,1214h
11b4 86        add     a,(hl)
11b5 14        inc     d
11b6 2060      jr      nz,1218h
11b8 80        add     a,b
11b9 14        inc     d
11ba 2060      jr      nz,121ch
11bc 7a        ld      a,d
11bd 14        inc     d
11be 2060      jr      nz,1220h
11c0 74        ld      (hl),h
11c1 14        inc     d
11c2 2060      jr      nz,1224h
11c4 6e        ld      l,(hl)
11c5 14        inc     d
11c6 2060      jr      nz,1228h
11c8 5e        ld      e,(hl)
11c9 14        inc     d
11ca 23        inc     hl
11cb 60        ld      h,b
11cc 58        ld      e,b
11cd 14        inc     d
11ce 2060      jr      nz,1230h
11d0 52        ld      d,d
11d1 14        inc     d
11d2 2060      jr      nz,1234h
11d4 4c        ld      c,h
11d5 14        inc     d
11d6 2060      jr      nz,1238h
11d8 46        ld      b,(hl)
11d9 14        inc     d
11da 2060      jr      nz,123ch
11dc 40        ld      b,b
11dd 14        inc     d
11de 2060      jr      nz,1240h
11e0 3a1420    ld      a,(2014h)
11e3 60        ld      h,b
11e4 34        inc     (hl)
11e5 14        inc     d
11e6 2060      jr      nz,1248h
11e8 24        inc     h
11e9 14        inc     d
11ea 2c        inc     l
11eb 60        ld      h,b
11ec 1c        inc     e
11ed 14        inc     d
11ee 2e60      ld      l,60h
11f0 ff        rst     38h
11f1 13        inc     de
11f2 3c        inc     a
11f3 60        ld      h,b
11f4 e5        push    hl
11f5 13        inc     de
11f6 1c        inc     e
11f7 60        ld      h,b
11f8 dd13      inc     de
11fa 2060      jr      nz,125ch
11fc d7        rst     10h
11fd 13        inc     de
11fe 2060      jr      nz,1260h
1200 d1        pop     de
1201 13        inc     de
1202 2060      jr      nz,1264h
1204 c613      add     a,13h
1206 2060      jr      nz,1268h
1208 ae        xor     (hl)
1209 13        inc     de
120a 2060      jr      nz,126ch
120c 99        sbc     a,c
120d 13        inc     de
120e 364e      ld      (hl),4eh
1210 7e        ld      a,(hl)
1211 13        inc     de
1212 2060      jr      nz,1274h
1214 72        ld      (hl),d
1215 13        inc     de
1216 2060      jr      nz,1278h
1218 62        ld      h,d
1219 13        inc     de
121a 3d        dec     a
121b 6e        ld      l,(hl)
121c 22133d    ld      (3d13h),hl
121f 6e        ld      l,(hl)
1220 e21220    jp      po,2012h
1223 60        ld      h,b
1224 d21220    jp      nc,2012h
1227 60        ld      h,b
1228 cc1220    call    z,2012h
122b 60        ld      h,b
122c c612      add     a,12h
122e 3d        dec     a
122f 6e        ld      l,(hl)
1230 7e        ld      a,(hl)
1231 12        ld      (de),a
1232 3d        dec     a
1233 6e        ld      l,(hl)
1234 3612      ld      (hl),12h
1236 02        ld      (bc),a
1237 48        ld      c,b
1238 00        nop     
1239 13        inc     de
123a 00        nop     
123b 00        nop     
123c 14        inc     d
123d 2800      jr      z,123fh
123f 98        sbc     a,b
1240 03        inc     bc
1241 96        sub     (hl)
1242 03        inc     bc
1243 98        sbc     a,b
1244 03        inc     bc
1245 96        sub     (hl)
1246 03        inc     bc
1247 98        sbc     a,b
1248 03        inc     bc
1249 96        sub     (hl)
124a 03        inc     bc
124b 97        sub     a
124c 03        inc     bc
124d 95        sub     l
124e 03        inc     bc
124f 96        sub     (hl)
1250 03        inc     bc
1251 94        sub     h
1252 03        inc     bc
1253 95        sub     l
1254 03        inc     bc
1255 93        sub     e
1256 03        inc     bc
1257 94        sub     h
1258 03        inc     bc
1259 92        sub     d
125a 03        inc     bc
125b 93        sub     e
125c 03        inc     bc
125d 91        sub     c
125e 03        inc     bc
125f 92        sub     d
1260 03        inc     bc
1261 90        sub     b
1262 03        inc     bc
1263 91        sub     c
1264 03        inc     bc
1265 8f        adc     a,a
1266 03        inc     bc
1267 90        sub     b
1268 03        inc     bc
1269 8e        adc     a,(hl)
126a 03        inc     bc
126b 8f        adc     a,a
126c 03        inc     bc
126d 8d        adc     a,l
126e 03        inc     bc
126f 8e        adc     a,(hl)
1270 03        inc     bc
1271 07        rlca    
1272 ff        rst     38h
1273 ff        rst     38h
1274 0100ff    ld      bc,0ff00h
1277 54        ld      d,h
1278 01188c    ld      bc,8c18h
127b 03        inc     bc
127c 40        ld      b,b
127d 00        nop     
127e 02        ld      (bc),a
127f 48        ld      c,b
1280 00        nop     
1281 12        ld      (de),a
1282 00        nop     
1283 00        nop     
1284 14        inc     d
1285 2800      jr      z,1287h
1287 8c        adc     a,h
1288 03        inc     bc
1289 8e        adc     a,(hl)
128a 03        inc     bc
128b 8c        adc     a,h
128c 03        inc     bc
128d 8e        adc     a,(hl)
128e 03        inc     bc
128f 8c        adc     a,h
1290 03        inc     bc
1291 8e        adc     a,(hl)
1292 03        inc     bc
1293 8d        adc     a,l
1294 03        inc     bc
1295 8f        adc     a,a
1296 03        inc     bc
1297 8e        adc     a,(hl)
1298 03        inc     bc
1299 90        sub     b
129a 03        inc     bc
129b 8f        adc     a,a
129c 03        inc     bc
129d 91        sub     c
129e 03        inc     bc
129f 90        sub     b
12a0 03        inc     bc
12a1 92        sub     d
12a2 03        inc     bc
12a3 91        sub     c
12a4 03        inc     bc
12a5 93        sub     e
12a6 03        inc     bc
12a7 92        sub     d
12a8 03        inc     bc
12a9 94        sub     h
12aa 03        inc     bc
12ab 93        sub     e
12ac 03        inc     bc
12ad 95        sub     l
12ae 03        inc     bc
12af 94        sub     h
12b0 03        inc     bc
12b1 96        sub     (hl)
12b2 03        inc     bc
12b3 95        sub     l
12b4 03        inc     bc
12b5 97        sub     a
12b6 03        inc     bc
12b7 96        sub     (hl)
12b8 03        inc     bc
12b9 07        rlca    
12ba ff        rst     38h
12bb ff        rst     38h
12bc 0100ff    ld      bc,0ff00h
12bf 54        ld      d,h
12c0 011898    ld      bc,9818h
12c3 03        inc     bc
12c4 40        ld      b,b
12c5 00        nop     
12c6 02        ld      (bc),a
12c7 04        inc     b
12c8 00        nop     
12c9 8e        adc     a,(hl)
12ca 7f        ld      a,a
12cb 00        nop     
12cc 02        ld      (bc),a
12cd 4b        ld      c,e
12ce 00        nop     
12cf 8b        adc     a,e
12d0 40        ld      b,b
12d1 00        nop     
12d2 1807      jr      12dbh
12d4 ff        rst     38h
12d5 ff        rst     38h
12d6 0100ff    ld      bc,0ff00h
12d9 54        ld      d,h
12da 010219    ld      bc,1902h
12dd 00        nop     
12de 90        sub     b
12df 40        ld      b,b
12e0 40        ld      b,b
12e1 00        nop     
12e2 02        ld      (bc),a
12e3 48        ld      c,b
12e4 00        nop     
12e5 12        ld      (de),a
12e6 00        nop     
12e7 00        nop     
12e8 14        inc     d
12e9 2800      jr      z,12ebh
12eb 8c        adc     a,h
12ec 03        inc     bc
12ed 8e        adc     a,(hl)
12ee 03        inc     bc
12ef 8d        adc     a,l
12f0 03        inc     bc
12f1 8f        adc     a,a
12f2 03        inc     bc
12f3 8e        adc     a,(hl)
12f4 03        inc     bc
12f5 90        sub     b
12f6 03        inc     bc
12f7 8f        adc     a,a
12f8 03        inc     bc
12f9 91        sub     c
12fa 03        inc     bc
12fb 90        sub     b
12fc 03        inc     bc
12fd 92        sub     d
12fe 03        inc     bc
12ff 91        sub     c
1300 03        inc     bc
1301 93        sub     e
1302 03        inc     bc
1303 92        sub     d
1304 03        inc     bc
1305 94        sub     h
1306 03        inc     bc
1307 93        sub     e
1308 03        inc     bc
1309 95        sub     l
130a 03        inc     bc
130b 94        sub     h
130c 03        inc     bc
130d 96        sub     (hl)
130e 03        inc     bc
130f 95        sub     l
1310 03        inc     bc
1311 97        sub     a
1312 03        inc     bc
1313 96        sub     (hl)
1314 03        inc     bc
1315 07        rlca    
1316 ff        rst     38h
1317 ff        rst     38h
1318 0100ff    ld      bc,0ff00h
131b 54        ld      d,h
131c 011898    ld      bc,9818h
131f 03        inc     bc
1320 40        ld      b,b
1321 00        nop     
1322 02        ld      (bc),a
1323 48        ld      c,b
1324 00        nop     
1325 13        inc     de
1326 00        nop     
1327 00        nop     
1328 14        inc     d
1329 2800      jr      z,132bh
132b 98        sbc     a,b
132c 03        inc     bc
132d 96        sub     (hl)
132e 03        inc     bc
132f 97        sub     a
1330 03        inc     bc
1331 95        sub     l
1332 03        inc     bc
1333 96        sub     (hl)
1334 03        inc     bc
1335 94        sub     h
1336 03        inc     bc
1337 95        sub     l
1338 03        inc     bc
1339 93        sub     e
133a 03        inc     bc
133b 94        sub     h
133c 03        inc     bc
133d 92        sub     d
133e 03        inc     bc
133f 93        sub     e
1340 03        inc     bc
1341 91        sub     c
1342 03        inc     bc
1343 92        sub     d
1344 03        inc     bc
1345 90        sub     b
1346 03        inc     bc
1347 91        sub     c
1348 03        inc     bc
1349 8f        adc     a,a
134a 03        inc     bc
134b 90        sub     b
134c 03        inc     bc
134d 8e        adc     a,(hl)
134e 03        inc     bc
134f 8f        adc     a,a
1350 03        inc     bc
1351 8d        adc     a,l
1352 03        inc     bc
1353 8e        adc     a,(hl)
1354 03        inc     bc
1355 07        rlca    
1356 ff        rst     38h
1357 ff        rst     38h
1358 0100ff    ld      bc,0ff00h
135b 54        ld      d,h
135c 01188c    ld      bc,8c18h
135f 03        inc     bc
1360 40        ld      b,b
1361 00        nop     
1362 1807      jr      136bh
1364 ff        rst     38h
1365 ff        rst     38h
1366 0100ff    ld      bc,0ff00h
1369 54        ld      d,h
136a 010219    ld      bc,1902h
136d 00        nop     
136e 90        sub     b
136f c0        ret     nz

1370 40        ld      b,b
1371 00        nop     
1372 02        ld      (bc),a
1373 15        dec     d
1374 00        nop     
1375 90        sub     b
1376 08        ex      af,af'
1377 91        sub     c
1378 08        ex      af,af'
1379 92        sub     d
137a 08        ex      af,af'
137b 94        sub     h
137c 12        ld      (de),a
137d 00        nop     
137e 07        rlca    
137f ff        rst     38h
1380 ff        rst     38h
1381 0100ff    ld      bc,0ff00h
1384 54        ld      d,h
1385 010265    ld      bc,6502h
1388 00        nop     
1389 0a        ld      a,(bc)
138a 14        inc     d
138b 011406    ld      bc,0614h
138e 13        inc     de
138f 0600      ld      b,00h
1391 2803      jr      z,1396h
1393 00        nop     
1394 1890      jr      1326h
1396 14        inc     d
1397 34        inc     (hl)
1398 00        nop     
1399 08        ex      af,af'
139a 08        ex      af,af'
139b 07        rlca    
139c ff        rst     38h
139d ff        rst     38h
139e 0100ff    ld      bc,0ff00h
13a1 54        ld      d,h
13a2 011802    ld      bc,0218h
13a5 7a        ld      a,d
13a6 00        nop     
13a7 89        adc     a,c
13a8 04        inc     b
13a9 0c        inc     c
13aa 8a        adc     a,d
13ab 04        inc     b
13ac 1800      jr      13aeh
13ae 08        ex      af,af'
13af 08        ex      af,af'
13b0 02        ld      (bc),a
13b1 34        inc     (hl)
13b2 00        nop     
13b3 13        inc     de
13b4 14        inc     d
13b5 00        nop     
13b6 ff        rst     38h
13b7 3c        inc     a
13b8 00        nop     
13b9 07        rlca    
13ba ff        rst     38h
13bb ff        rst     38h
13bc 0100ff    ld      bc,0ff00h
13bf f0        ret     p

13c0 0f        rrca    
13c1 18a9      jr      136ch
13c3 2c        inc     l
13c4 08        ex      af,af'
13c5 00        nop     
13c6 02        ld      (bc),a
13c7 61        ld      h,c
13c8 00        nop     
13c9 9b        sbc     a,e
13ca 0f        rrca    
13cb 02        ld      (bc),a
13cc 33        inc     sp
13cd 00        nop     
13ce 9c        sbc     a,h
13cf 50        ld      d,b
13d0 00        nop     
13d1 02        ld      (bc),a
13d2 00        nop     
13d3 00        nop     
13d4 90        sub     b
13d5 88        adc     a,b
13d6 00        nop     
13d7 02        ld      (bc),a
13d8 00        nop     
13d9 00        nop     
13da 9a        sbc     a,d
13db 58        ld      e,b
13dc 00        nop     
13dd 08        ex      af,af'
13de 0f        rrca    
13df 02        ld      (bc),a
13e0 210090    ld      hl,9000h
13e3 1c        inc     e
13e4 00        nop     
13e5 14        inc     d
13e6 2801      jr      z,13e9h
13e8 0b        dec     bc
13e9 02        ld      (bc),a
13ea 2e00      ld      l,00h
13ec 90        sub     b
13ed 04        inc     b
13ee 80        add     a,b
13ef 019004    ld      bc,0490h
13f2 80        add     a,b
13f3 019005    ld      bc,0590h
13f6 80        add     a,b
13f7 019006    ld      bc,0690h
13fa 80        add     a,b
13fb 019014    ld      bc,1490h
13fe 00        nop     
13ff 08        ex      af,af'
1400 07        rlca    
1401 02        ld      (bc),a
1402 8d        adc     a,l
1403 00        nop     
1404 02        ld      (bc),a
1405 0c        inc     c
1406 00        nop     
1407 90        sub     b
1408 08        ex      af,af'
1409 91        sub     c
140a 07        rlca    
140b 92        sub     d
140c 0693      ld      b,93h
140e 05        dec     b
140f 95        sub     l
1410 05        dec     b
1411 96        sub     (hl)
1412 04        inc     b
1413 97        sub     a
1414 04        inc     b
1415 98        sbc     a,b
1416 04        inc     b
1417 99        sbc     a,c
1418 03        inc     bc
1419 9a        sbc     a,d
141a 03        inc     bc
141b 00        nop     
141c 08        ex      af,af'
141d 0b        dec     bc
141e 02        ld      (bc),a
141f 210090    ld      hl,9000h
1422 1800      jr      1424h
1424 02        ld      (bc),a
1425 2800      jr      z,1427h
1427 1807      jr      1430h
1429 ff        rst     38h
142a ff        rst     38h
142b 0100ff    ld      bc,0ff00h
142e f8        ret     m

142f 07        rlca    
1430 90        sub     b
1431 1007      djnz    143ah
1433 00        nop     
1434 02        ld      (bc),a
1435 04        inc     b
1436 00        nop     
1437 90        sub     b
1438 50        ld      d,b
1439 00        nop     
143a 02        ld      (bc),a
143b 07        rlca    
143c 00        nop     
143d 90        sub     b
143e 70        ld      (hl),b
143f 00        nop     
1440 02        ld      (bc),a
1441 23        inc     hl
1442 00        nop     
1443 90        sub     b
1444 60        ld      h,b
1445 00        nop     
1446 02        ld      (bc),a
1447 04        inc     b
1448 00        nop     
1449 90        sub     b
144a 70        ld      (hl),b
144b 00        nop     
144c 02        ld      (bc),a
144d 04        inc     b
144e 00        nop     
144f 90        sub     b
1450 78        ld      a,b
1451 00        nop     
1452 02        ld      (bc),a
1453 04        inc     b
1454 00        nop     
1455 90        sub     b
1456 40        ld      b,b
1457 00        nop     
1458 02        ld      (bc),a
1459 5f        ld      e,a
145a 00        nop     
145b 90        sub     b
145c 2000      jr      nz,145eh
145e 07        rlca    
145f ff        rst     38h
1460 ff        rst     38h
1461 0100ff    ld      bc,0ff00h
1464 a8        xor     b
1465 02        ld      (bc),a
1466 1802      jr      146ah
1468 3a0090    ld      a,(9000h)
146b 3038      jr      nc,14a5h
146d 00        nop     
146e 02        ld      (bc),a
146f 3a008c    ld      a,(8c00h)
1472 48        ld      c,b
1473 00        nop     
1474 02        ld      (bc),a
1475 85        add     a,l
1476 00        nop     
1477 90        sub     b
1478 40        ld      b,b
1479 00        nop     
147a 02        ld      (bc),a
147b 47        ld      b,a
147c 00        nop     
147d 90        sub     b
147e 2000      jr      nz,1480h
1480 02        ld      (bc),a
1481 33        inc     sp
1482 00        nop     
1483 90        sub     b
1484 50        ld      d,b
1485 00        nop     
1486 02        ld      (bc),a
1487 2800      jr      z,1489h
1489 1807      jr      1492h
148b ff        rst     38h
148c ff        rst     38h
148d 0100ff    ld      bc,0ff00h
1490 f8        ret     m

1491 07        rlca    
1492 90        sub     b
1493 1807      jr      149ch
1495 80        add     a,b
1496 2000      jr      nz,1498h
1498 90        sub     b
1499 48        ld      c,b
149a 00        nop     
149b 02        ld      (bc),a
149c 49        ld      c,c
149d 00        nop     
149e 8c        adc     a,h
149f 40        ld      b,b
14a0 00        nop     
14a1 02        ld      (bc),a
14a2 6f        ld      l,a
14a3 00        nop     
14a4 88        adc     a,b
14a5 2000      jr      nz,14a7h
14a7 02        ld      (bc),a
14a8 0e00      ld      c,00h
14aa 90        sub     b
14ab 80        add     a,b
14ac 00        nop     
14ad 00        nop     
14ae 02        ld      (bc),a
14af 6c        ld      l,h
14b0 00        nop     
14b1 90        sub     b
14b2 46        ld      b,(hl)
14b3 00        nop     
14b4 1802      jr      14b8h
14b6 3600      ld      (hl),00h
14b8 15        dec     d
14b9 08        ex      af,af'
14ba 0f        rrca    
14bb 07        rlca    
14bc ff        rst     38h
14bd ff        rst     38h
14be 0100ff    ld      bc,0ff00h
14c1 c8        ret     z

14c2 011200    ld      bc,0012h
14c5 02        ld      (bc),a
14c6 ff        rst     38h
14c7 04        inc     b
14c8 03        inc     bc
14c9 a8        xor     b
14ca 08        ex      af,af'
14cb 018008    ld      bc,0880h
14ce 00        nop     
14cf a8        xor     b
14d0 40        ld      b,b
14d1 40        ld      b,b
14d2 00        nop     
14d3 1802      jr      14d7h
14d5 1e00      ld      e,00h
14d7 15        dec     d
14d8 08        ex      af,af'
14d9 0e07      ld      c,07h
14db ff        rst     38h
14dc ff        rst     38h
14dd 0100ff    ld      bc,0ff00h
14e0 00        nop     
14e1 018005    ld      bc,0580h
14e4 00        nop     
14e5 bf        cp      a
14e6 0101b9    ld      bc,0b901h
14e9 02        ld      (bc),a
14ea 00        nop     
14eb aa        xor     d
14ec 02        ld      (bc),a
14ed 00        nop     
14ee 99        sbc     a,c
14ef 05        dec     b
14f0 02        ld      (bc),a
14f1 80        add     a,b
14f2 010080    ld      bc,8000h
14f5 05        dec     b
14f6 00        nop     
14f7 c1        pop     bc
14f8 0101b9    ld      bc,0b901h
14fb 02        ld      (bc),a
14fc 00        nop     
14fd aa        xor     d
14fe 02        ld      (bc),a
14ff 00        nop     
1500 99        sbc     a,c
1501 05        dec     b
1502 02        ld      (bc),a
1503 9a        sbc     a,d
1504 05        dec     b
1505 02        ld      (bc),a
1506 9b        sbc     a,e
1507 04        inc     b
1508 02        ld      (bc),a
1509 93        sub     e
150a 0602      ld      b,02h
150c 94        sub     h
150d 05        dec     b
150e 02        ld      (bc),a
150f 95        sub     l
1510 04        inc     b
1511 02        ld      (bc),a
1512 96        sub     (hl)
1513 04        inc     b
1514 02        ld      (bc),a
1515 97        sub     a
1516 04        inc     b
1517 019804    ld      bc,0498h
151a 019905    ld      bc,0599h
151d 02        ld      (bc),a
151e 97        sub     a
151f 04        inc     b
1520 02        ld      (bc),a
1521 96        sub     (hl)
1522 04        inc     b
1523 011200    ld      bc,0012h
1526 01ff04    ld      bc,04ffh
1529 018f80    ld      bc,808fh
152c 80        add     a,b
152d 00        nop     
152e 1802      jr      1532h
1530 2c        inc     l
1531 00        nop     
1532 15        dec     d
1533 08        ex      af,af'
1534 0f        rrca    
1535 07        rlca    
1536 ff        rst     38h
1537 ff        rst     38h
1538 0100ff    ld      bc,0ff00h
153b c8        ret     z

153c 011200    ld      bc,0012h
153f 01ff04    ld      bc,04ffh
1542 03        inc     bc
1543 92        sub     d
1544 1009      djnz    154fh
1546 91        sub     c
1547 40        ld      b,b
1548 60        ld      h,b
1549 00        nop     
154a 1802      jr      154eh
154c 1e00      ld      e,00h
154e 15        dec     d
154f 08        ex      af,af'
1550 0f        rrca    
1551 07        rlca    
1552 ff        rst     38h
1553 ff        rst     38h
1554 0100ff    ld      bc,0ff00h
1557 00        nop     
1558 01c101    ld      bc,01c1h
155b 01c101    ld      bc,01c1h
155e 01b902    ld      bc,02b9h
1561 00        nop     
1562 aa        xor     d
1563 02        ld      (bc),a
1564 00        nop     
1565 99        sbc     a,c
1566 05        dec     b
1567 02        ld      (bc),a
1568 9a        sbc     a,d
1569 05        dec     b
156a 02        ld      (bc),a
156b 9b        sbc     a,e
156c 04        inc     b
156d 02        ld      (bc),a
156e 93        sub     e
156f 0602      ld      b,02h
1571 94        sub     h
1572 80        add     a,b
1573 80        add     a,b
1574 00        nop     
1575 07        rlca    
1576 55        ld      d,l
1577 55        ld      d,l
1578 0100ff    ld      bc,0ff00h
157b ff        rst     38h
157c 00        nop     
157d 02        ld      (bc),a
157e 68        ld      l,b
157f 00        nop     
1580 90        sub     b
1581 24        inc     h
1582 00        nop     
1583 1807      jr      158ch
1585 ff        rst     38h
1586 ff        rst     38h
1587 0100ff    ld      bc,0ff00h
158a ff        rst     38h
158b 00        nop     
158c 02        ld      (bc),a
158d 48        ld      c,b
158e 00        nop     
158f 90        sub     b
1590 04        inc     b
1591 60        ld      h,b
1592 00        nop     
1593 02        ld      (bc),a
1594 09        add     hl,bc
1595 00        nop     
1596 90        sub     b
1597 3000      jr      nc,1599h
1599 02        ld      (bc),a
159a 78        ld      a,b
159b 00        nop     
159c 12        ld      (de),a
159d 00        nop     
159e 00        nop     
159f 2808      jr      z,15a9h
15a1 00        nop     
15a2 82        add     a,d
15a3 3000      jr      nc,15a5h
15a5 02        ld      (bc),a
15a6 51        ld      d,c
15a7 00        nop     
15a8 8e        adc     a,(hl)
15a9 2002      jr      nz,15adh
15ab 5d        ld      e,l
15ac 00        nop     
15ad 8e        adc     a,(hl)
15ae 3002      jr      nc,15b2h
15b0 5d        ld      e,l
15b1 00        nop     
15b2 8d        adc     a,l
15b3 40        ld      b,b
15b4 00        nop     
15b5 14        inc     d
15b6 2801      jr      z,15b9h
15b8 0b        dec     bc
15b9 02        ld      (bc),a
15ba 2e00      ld      l,00h
15bc 90        sub     b
15bd 14        inc     d
15be 00        nop     
15bf 02        ld      (bc),a
15c0 1f        rra     
15c1 00        nop     
15c2 90        sub     b
15c3 08        ex      af,af'
15c4 91        sub     c
15c5 08        ex      af,af'
15c6 92        sub     d
15c7 08        ex      af,af'
15c8 94        sub     h
15c9 12        ld      (de),a
15ca 00        nop     
15cb 08        ex      af,af'
15cc 0c        inc     c
15cd 02        ld      (bc),a
15ce 25        dec     h
15cf 00        nop     
15d0 07        rlca    
15d1 55        ld      d,l
15d2 05        dec     b
15d3 0100ff    ld      bc,0ff00h
15d6 50        ld      d,b
15d7 05        dec     b
15d8 13        inc     de
15d9 0600      ld      b,00h
15db 1e0c      ld      e,0ch
15dd 00        nop     
15de 1890      jr      1570h
15e0 40        ld      b,b
15e1 0c        inc     c
15e2 00        nop     
15e3 02        ld      (bc),a
15e4 1a        ld      a,(de)
15e5 00        nop     
15e6 1807      jr      15efh
15e8 ff        rst     38h
15e9 ff        rst     38h
15ea 0100ff    ld      bc,0ff00h
15ed 00        nop     
15ee 010a08    ld      bc,080ah
15f1 010b01    ld      bc,010bh
15f4 92        sub     d
15f5 40        ld      b,b
15f6 1000      djnz    15f8h
15f8 1815      jr      160fh
15fa 02        ld      (bc),a
15fb 01000a    ld      bc,0a00h
15fe 05        dec     b
15ff 02        ld      (bc),a
1600 0b        dec     bc
1601 1612      ld      d,12h
1603 00        nop     
1604 010e58    ld      bc,580eh
1607 04        inc     b
1608 07        rlca    
1609 ff        rst     38h
160a 3f        ccf     
160b 87        add     a,a
160c 07        rlca    
160d 80        add     a,b
160e 88        adc     a,b
160f 00        nop     
1610 9a        sbc     a,d
1611 04        inc     b
1612 80        add     a,b
1613 00        nop     
1614 1815      jr      162bh
1616 02        ld      (bc),a
1617 58        ld      e,b
1618 00        nop     
1619 0a        ld      a,(bc)
161a 04        inc     b
161b 010803    ld      bc,0308h
161e 12        ld      (de),a
161f 00        nop     
1620 05        dec     b
1621 0e0b      ld      c,0bh
1623 02        ld      (bc),a
1624 07        rlca    
1625 ff        rst     38h
1626 ff        rst     38h
1627 f0        ret     p

1628 00        nop     
1629 1010      djnz    163bh
162b 00        nop     
162c 9a        sbc     a,d
162d 05        dec     b
162e f0        ret     p

162f 00        nop     
1630 1802      jr      1634h
1632 2c        inc     l
1633 00        nop     
1634 15        dec     d
1635 08        ex      af,af'
1636 0f        rrca    
1637 07        rlca    
1638 ff        rst     38h
1639 ff        rst     38h
163a 0100ff    ld      bc,0ff00h
163d c8        ret     z

163e 011200    ld      bc,0012h
1641 01ff04    ld      bc,04ffh
1644 03        inc     bc
1645 91        sub     c
1646 a0        and     b
1647 100c      djnz    1655h
1649 201b      jr      nz,1666h
164b 08        ex      af,af'
164c 0f        rrca    
164d 02        ld      (bc),a
164e 54        ld      d,h
164f 00        nop     
1650 8a        adc     a,d
1651 05        dec     b
1652 00        nop     
1653 8a        adc     a,d
1654 40        ld      b,b
1655 00        nop     
1656 00        nop     
1657 02        ld      (bc),a
1658 77        ld      (hl),a
1659 00        nop     
165a 07        rlca    
165b aa        xor     d
165c 2a4000    ld      hl,(0040h)
165f c0        ret     nz

1660 00        nop     
1661 0618      ld      b,18h
1663 8c        adc     a,h
1664 05        dec     b
1665 04        inc     b
1666 00        nop     
1667 02        ld      (bc),a
1668 77        ld      (hl),a
1669 00        nop     
166a 07        rlca    
166b aa        xor     d
166c 2a4000    ld      hl,(0040h)
166f c0        ret     nz

1670 00        nop     
1671 0618      ld      b,18h
1673 9a        sbc     a,d
1674 05        dec     b
1675 04        inc     b
1676 00        nop     
1677 02        ld      (bc),a
1678 77        ld      (hl),a
1679 00        nop     
167a 07        rlca    
167b aa        xor     d
167c 2a4000    ld      hl,(0040h)
167f c0        ret     nz

1680 00        nop     
1681 0618      ld      b,18h
1683 98        sbc     a,b
1684 05        dec     b
1685 04        inc     b
1686 00        nop     
1687 08        ex      af,af'
1688 0602      ld      b,02h
168a 86        add     a,(hl)
168b 00        nop     
168c a0        and     b
168d 3000      jr      nc,168fh
168f 14        inc     d
1690 2801      jr      z,1693h
1692 0b        dec     bc
1693 02        ld      (bc),a
1694 48        ld      c,b
1695 00        nop     
1696 90        sub     b
1697 f0        ret     p

1698 02        ld      (bc),a
1699 2e00      ld      l,00h
169b 90        sub     b
169c f0        ret     p

169d 02        ld      (bc),a
169e 010090    ld      bc,9000h
16a1 f0        ret     p

16a2 02        ld      (bc),a
16a3 69        ld      l,c
16a4 00        nop     
16a5 90        sub     b
16a6 f0        ret     p

16a7 00        nop     
16a8 02        ld      (bc),a
16a9 4d        ld      c,l
16aa 00        nop     
16ab 8b        adc     a,e
16ac 15        dec     d
16ad 00        nop     
16ae 02        ld      (bc),a
16af 1600      ld      d,00h
16b1 90        sub     b
16b2 56        ld      d,(hl)
16b3 90        sub     b
16b4 50        ld      d,b
16b5 90        sub     b
16b6 68        ld      l,b
16b7 00        nop     
16b8 08        ex      af,af'
16b9 08        ex      af,af'
16ba 02        ld      (bc),a
16bb 6a        ld      l,d
16bc 00        nop     
16bd 90        sub     b
16be 1000      djnz    16c0h
16c0 02        ld      (bc),a
16c1 46        ld      b,(hl)
16c2 00        nop     
16c3 13        inc     de
16c4 14        inc     d
16c5 00        nop     
16c6 0a        ld      a,(bc)
16c7 46        ld      b,(hl)
16c8 00        nop     
16c9 90        sub     b
16ca 70        ld      (hl),b
16cb 00        nop     
16cc 02        ld      (bc),a
16cd 46        ld      b,(hl)
16ce 00        nop     
16cf 97        sub     a
16d0 2000      jr      nz,16d2h
16d2 02        ld      (bc),a
16d3 3d        dec     a
16d4 00        nop     
16d5 90        sub     b
16d6 50        ld      d,b
16d7 00        nop     
16d8 02        ld      (bc),a
16d9 0a        ld      a,(bc)
16da 00        nop     
16db 90        sub     b
16dc 50        ld      d,b
16dd 00        nop     
16de 02        ld      (bc),a
16df 8d        adc     a,l
16e0 00        nop     
16e1 02        ld      (bc),a
16e2 0c        inc     c
16e3 00        nop     
16e4 90        sub     b
16e5 08        ex      af,af'
16e6 91        sub     c
16e7 07        rlca    
16e8 92        sub     d
16e9 0693      ld      b,93h
16eb 05        dec     b
16ec 95        sub     l
16ed 05        dec     b
16ee 96        sub     (hl)
16ef 04        inc     b
16f0 97        sub     a
16f1 04        inc     b
16f2 98        sbc     a,b
16f3 04        inc     b
16f4 99        sbc     a,c
16f5 03        inc     bc
16f6 9a        sbc     a,d
16f7 03        inc     bc
16f8 00        nop     
16f9 02        ld      (bc),a
16fa 92        sub     d
16fb 00        nop     
16fc 90        sub     b
16fd 1000      djnz    16ffh
16ff 08        ex      af,af'
1700 0f        rrca    
1701 07        rlca    
1702 55        ld      d,l
1703 05        dec     b
1704 0100ff    ld      bc,0ff00h
1707 fc0302    call    m,0203h
170a 15        dec     d
170b 00        nop     
170c 1890      jr      169eh
170e 3010      jr      nc,1720h
1710 00        nop     
1711 08        ex      af,af'
1712 05        dec     b
1713 02        ld      (bc),a
1714 09        add     hl,bc
1715 00        nop     
1716 07        rlca    
1717 ff        rst     38h
1718 07        rlca    
1719 0100ff    ld      bc,0ff00h
171c 50        ld      d,b
171d 05        dec     b
171e 1890      jr      16b0h
1720 40        ld      b,b
1721 1000      djnz    1723h
1723 02        ld      (bc),a
1724 34        inc     (hl)
1725 00        nop     
1726 13        inc     de
1727 14        inc     d
1728 00        nop     
1729 ff        rst     38h
172a 3c        inc     a
172b 00        nop     
172c 07        rlca    
172d ff        rst     38h
172e ff        rst     38h
172f 0100ff    ld      bc,0ff00h
1732 f0        ret     p

1733 0f        rrca    
1734 18a9      jr      16dfh
1736 2c        inc     l
1737 08        ex      af,af'
1738 00        nop     
1739 08        ex      af,af'
173a 04        inc     b
173b 02        ld      (bc),a
173c 8d        adc     a,l
173d 00        nop     
173e 13        inc     de
173f 00        nop     
1740 00        nop     
1741 321400    ld      (0014h),a
1744 90        sub     b
1745 1c        inc     e
1746 00        nop     
1747 02        ld      (bc),a
1748 8d        adc     a,l
1749 00        nop     
174a 90        sub     b
174b 08        ex      af,af'
174c 91        sub     c
174d 07        rlca    
174e 92        sub     d
174f 0693      ld      b,93h
1751 05        dec     b
1752 95        sub     l
1753 05        dec     b
1754 96        sub     (hl)
1755 04        inc     b
1756 97        sub     a
1757 04        inc     b
1758 98        sbc     a,b
1759 04        inc     b
175a 99        sbc     a,c
175b 03        inc     bc
175c 9a        sbc     a,d
175d 03        inc     bc
175e 00        nop     
175f 02        ld      (bc),a
1760 41        ld      b,c
1761 00        nop     
1762 13        inc     de
1763 64        ld      h,h
1764 00        nop     
1765 320f00    ld      (000fh),a
1768 07        rlca    
1769 ff        rst     38h
176a ff        rst     38h
176b 0100ff    ld      bc,0ff00h
176e a0        and     b
176f 0a        ld      a,(bc)
1770 188f      jr      1701h
1772 50        ld      d,b
1773 1000      djnz    1775h
1775 02        ld      (bc),a
1776 09        add     hl,bc
1777 00        nop     
1778 13        inc     de
1779 00        nop     
177a 00        nop     
177b 50        ld      d,b
177c 64        ld      h,h
177d 00        nop     
177e 9f        sbc     a,a
177f 1000      djnz    1781h
1781 02        ld      (bc),a
1782 25        dec     h
1783 00        nop     
1784 07        rlca    
1785 ff        rst     38h
1786 ff        rst     38h
1787 0100ff    ld      bc,0ff00h
178a f0        ret     p

178b 0f        rrca    
178c 1813      jr      17a1h
178e 00        nop     
178f 00        nop     
1790 14        inc     d
1791 58        ld      e,b
1792 02        ld      (bc),a
1793 91        sub     c
1794 1c        inc     e
1795 08        ex      af,af'
1796 00        nop     
1797 08        ex      af,af'
1798 0b        dec     bc
1799 1d        dec     e
179a 02        ld      (bc),a
179b 2b        dec     hl
179c 00        nop     
179d 07        rlca    
179e ff        rst     38h
179f ff        rst     38h
17a0 0100ff    ld      bc,0ff00h
17a3 9c        sbc     a,h
17a4 00        nop     
17a5 1812      jr      17b9h
17a7 1e00      ld      e,00h
17a9 fa0600    jp      m,0006h
17ac 90        sub     b
17ad c0        ret     nz

17ae 90        sub     b
17af 00        nop     
17b0 02        ld      (bc),a
17b1 6e        ld      l,(hl)
17b2 00        nop     
17b3 90        sub     b
17b4 40        ld      b,b
17b5 00        nop     
17b6 02        ld      (bc),a
17b7 25        dec     h
17b8 00        nop     
17b9 07        rlca    
17ba ff        rst     38h
17bb ff        rst     38h
17bc 0100ff    ld      bc,0ff00h
17bf 50        ld      d,b
17c0 05        dec     b
17c1 1813      jr      17d6h
17c3 00        nop     
17c4 00        nop     
17c5 14        inc     d
17c6 58        ld      e,b
17c7 02        ld      (bc),a
17c8 91        sub     c
17c9 3018      jr      nc,17e3h
17cb 00        nop     
17cc 02        ld      (bc),a
17cd 4c        ld      c,h
17ce 00        nop     
17cf 1807      jr      17d8h
17d1 ff        rst     38h
17d2 ff        rst     38h
17d3 0100ff    ld      bc,0ff00h
17d6 50        ld      d,b
17d7 05        dec     b
17d8 90        sub     b
17d9 0c        inc     c
17da 1000      djnz    17dch
17dc 02        ld      (bc),a
17dd 78        ld      a,b
17de 00        nop     
17df 84        add     a,h
17e0 2000      jr      nz,17e2h
17e2 02        ld      (bc),a
17e3 78        ld      a,b
17e4 00        nop     
17e5 82        add     a,d
17e6 2602      ld      h,02h
17e8 4c        ld      c,h
17e9 00        nop     
17ea 84        add     a,h
17eb 2602      ld      h,02h
17ed 54        ld      d,h
17ee 00        nop     
17ef 81        add     a,c
17f0 1802      jr      17f4h
17f2 44        ld      b,h
17f3 00        nop     
17f4 82        add     a,d
17f5 3000      jr      nc,17f7h
17f7 02        ld      (bc),a
17f8 74        ld      (hl),h
17f9 00        nop     
17fa 95        sub     l
17fb 1e00      ld      e,00h
17fd 08        ex      af,af'
17fe 03        inc     bc
17ff 02        ld      (bc),a
1800 0c        inc     c
1801 00        nop     
1802 13        inc     de
1803 00        nop     
1804 00        nop     
1805 0a        ld      a,(bc)
1806 7f        ld      a,a
1807 00        nop     
1808 90        sub     b
1809 24        inc     h
180a 00        nop     
180b 02        ld      (bc),a
180c 37        scf     
180d 00        nop     
180e 90        sub     b
180f 310018    ld      sp,1800h
1812 02        ld      (bc),a
1813 0c        inc     c
1814 00        nop     
1815 99        sbc     a,c
1816 07        rlca    
1817 019907    ld      bc,0799h
181a 019906    ld      bc,0699h
181d 019905    ld      bc,0599h
1820 019804    ld      bc,0498h
1823 00        nop     
1824 80        add     a,b
1825 0a        ld      a,(bc)
1826 00        nop     
1827 00        nop     
1828 02        ld      (bc),a
1829 6a        ld      l,d
182a 00        nop     
182b 84        add     a,h
182c 13        inc     de
182d 00        nop     
182e 02        ld      (bc),a
182f 6a        ld      l,d
1830 00        nop     
1831 84        add     a,h
1832 0c        inc     c
1833 00        nop     
1834 02        ld      (bc),a
1835 78        ld      a,b
1836 00        nop     
1837 12        ld      (de),a
1838 00        nop     
1839 00        nop     
183a 2808      jr      z,1844h
183c 00        nop     
183d 82        add     a,d
183e 1800      jr      1840h
1840 02        ld      (bc),a
1841 4c        ld      c,h
1842 00        nop     
1843 07        rlca    
1844 ff        rst     38h
1845 ff        rst     38h
1846 0100ff    ld      bc,0ff00h
1849 a0        and     b
184a 0a        ld      a,(bc)
184b 1881      jr      17ceh
184d 0d        dec     c
184e 0600      ld      b,00h
1850 02        ld      (bc),a
1851 63        ld      h,e
1852 00        nop     
1853 07        rlca    
1854 ff        rst     38h
1855 ff        rst     38h
1856 0100ff    ld      bc,0ff00h
1859 a0        and     b
185a 0a        ld      a,(bc)
185b 1890      jr      17edh
185d 0e06      ld      c,06h
185f 00        nop     
1860 08        ex      af,af'
1861 08        ex      af,af'
1862 02        ld      (bc),a
1863 78        ld      a,b
1864 00        nop     
1865 07        rlca    
1866 ff        rst     38h
1867 ff        rst     38h
1868 0100ff    ld      bc,0ff00h
186b a0        and     b
186c 0a        ld      a,(bc)
186d 1882      jr      17f1h
186f 0c        inc     c
1870 0600      ld      b,00h
1872 02        ld      (bc),a
1873 6b        ld      l,e
1874 00        nop     
1875 07        rlca    
1876 ff        rst     38h
1877 ff        rst     38h
1878 0100ff    ld      bc,0ff00h
187b a0        and     b
187c 0a        ld      a,(bc)
187d 1895      jr      1814h
187f 100b      djnz    188ch
1881 00        nop     
1882 02        ld      (bc),a
1883 63        ld      h,e
1884 00        nop     
1885 13        inc     de
1886 00        nop     
1887 00        nop     
1888 2820      jr      z,18aah
188a 00        nop     
188b 07        rlca    
188c ff        rst     38h
188d ff        rst     38h
188e 0100ff    ld      bc,0ff00h
1891 f0        ret     p

1892 0f        rrca    
1893 1899      jr      182eh
1895 0c        inc     c
1896 04        inc     b
1897 00        nop     
1898 02        ld      (bc),a
1899 7a        ld      a,d
189a 00        nop     
189b 12        ld      (de),a
189c 00        nop     
189d 00        nop     
189e 1e0f      ld      e,0fh
18a0 0a        ld      a,(bc)
18a1 9e        sbc     a,(hl)
18a2 2000      jr      nz,18a4h
18a4 08        ex      af,af'
18a5 08        ex      af,af'
18a6 02        ld      (bc),a
18a7 77        ld      (hl),a
18a8 00        nop     
18a9 07        rlca    
18aa aa        xor     d
18ab 2a4000    ld      hl,(0040h)
18ae c0        ret     nz

18af 00        nop     
18b0 0618      ld      b,18h
18b2 91        sub     c
18b3 05        dec     b
18b4 04        inc     b
18b5 00        nop     
18b6 08        ex      af,af'
18b7 0f        rrca    
18b8 02        ld      (bc),a
18b9 0c        inc     c
18ba 00        nop     
18bb a4        and     h
18bc 1c        inc     e
18bd 00        nop     
18be 08        ex      af,af'
18bf 0f        rrca    
18c0 02        ld      (bc),a
18c1 29        add     hl,hl
18c2 00        nop     
18c3 9e        sbc     a,(hl)
18c4 069e      ld      b,9eh
18c6 2000      jr      nz,18c8h
18c8 08        ex      af,af'
18c9 0f        rrca    
18ca 02        ld      (bc),a
18cb 1c        inc     e
18cc 00        nop     
18cd a2        and     d
18ce 3000      jr      nc,18d0h
18d0 08        ex      af,af'
18d1 0c        inc     c
18d2 07        rlca    
18d3 ff        rst     38h
18d4 ff        rst     38h
18d5 0100ff    ld      bc,0ff00h
18d8 f8        ret     m

18d9 07        rlca    
18da 02        ld      (bc),a
18db 56        ld      d,(hl)
18dc 00        nop     
18dd 1893      jr      1872h
18df 1e10      ld      e,10h
18e1 00        nop     
18e2 08        ex      af,af'
18e3 0602      ld      b,02h
18e5 70        ld      (hl),b
18e6 00        nop     
18e7 07        rlca    
18e8 ff        rst     38h
18e9 ff        rst     38h
18ea 0100ff    ld      bc,0ff00h
18ed f0        ret     p

18ee 0f        rrca    
18ef 1890      jr      1881h
18f1 08        ex      af,af'
18f2 0c        inc     c
18f3 00        nop     
18f4 08        ex      af,af'
18f5 0602      ld      b,02h
18f7 5a        ld      e,d
18f8 00        nop     
18f9 07        rlca    
18fa ff        rst     38h
18fb ff        rst     38h
18fc 0100ff    ld      bc,0ff00h
18ff f0        ret     p

1900 0f        rrca    
1901 1890      jr      1893h
1903 08        ex      af,af'
1904 0c        inc     c
1905 00        nop     
1906 08        ex      af,af'
1907 0602      ld      b,02h
1909 58        ld      e,b
190a 00        nop     
190b 07        rlca    
190c ff        rst     38h
190d ff        rst     38h
190e 0100ff    ld      bc,0ff00h
1911 f0        ret     p

1912 0f        rrca    
1913 1890      jr      18a5h
1915 08        ex      af,af'
1916 0c        inc     c
1917 00        nop     
1918 08        ex      af,af'
1919 0602      ld      b,02h
191b 7b        ld      a,e
191c 00        nop     
191d 07        rlca    
191e ff        rst     38h
191f ff        rst     38h
1920 0100ff    ld      bc,0ff00h
1923 f0        ret     p

1924 0f        rrca    
1925 1890      jr      18b7h
1927 08        ex      af,af'
1928 1000      djnz    192ah
192a 08        ex      af,af'
192b 0602      ld      b,02h
192d 1800      jr      192fh
192f 07        rlca    
1930 ff        rst     38h
1931 ff        rst     38h
1932 0100ff    ld      bc,0ff00h
1935 f0        ret     p

1936 0f        rrca    
1937 1890      jr      18c9h
1939 08        ex      af,af'
193a 1000      djnz    193ch
193c 08        ex      af,af'
193d 0602      ld      b,02h
193f 8a        adc     a,d
1940 00        nop     
1941 07        rlca    
1942 ff        rst     38h
1943 ff        rst     38h
1944 0100ff    ld      bc,0ff00h
1947 f0        ret     p

1948 0f        rrca    
1949 1890      jr      18dbh
194b 08        ex      af,af'
194c 1000      djnz    194eh
194e 08        ex      af,af'
194f 0c        inc     c
1950 02        ld      (bc),a
1951 4c        ld      c,h
1952 00        nop     
1953 1807      jr      195ch
1955 ff        rst     38h
1956 ff        rst     38h
1957 0100ff    ld      bc,0ff00h
195a 1b        dec     de
195b 09        add     hl,bc
195c 90        sub     b
195d 03        inc     bc
195e 08        ex      af,af'
195f 00        nop     
1960 02        ld      (bc),a
1961 43        ld      b,e
1962 00        nop     
1963 90        sub     b
1964 44        ld      b,h
1965 00        nop     
1966 02        ld      (bc),a
1967 8e        adc     a,(hl)
1968 00        nop     
1969 90        sub     b
196a 0c        inc     c
196b 00        nop     
196c 02        ld      (bc),a
196d 8d        adc     a,l
196e 00        nop     
196f 90        sub     b
1970 1000      djnz    1972h
1972 02        ld      (bc),a
1973 5c        ld      e,h
1974 00        nop     
1975 90        sub     b
1976 3000      jr      nc,1978h
1978 02        ld      (bc),a
1979 74        ld      (hl),h
197a 00        nop     
197b 8d        adc     a,l
197c 3000      jr      nc,197eh
197e 02        ld      (bc),a
197f 5d        ld      e,l
1980 00        nop     
1981 8f        adc     a,a
1982 2000      jr      nz,1984h
1984 02        ld      (bc),a
1985 70        ld      (hl),b
1986 00        nop     
1987 8e        adc     a,(hl)
1988 3000      jr      nc,198ah
198a 02        ld      (bc),a
198b 51        ld      d,c
198c 00        nop     
198d 8e        adc     a,(hl)
198e 2c        inc     l
198f 00        nop     
1990 02        ld      (bc),a
1991 51        ld      d,c
1992 00        nop     
1993 8e        adc     a,(hl)
1994 0b        dec     bc
1995 02        ld      (bc),a
1996 5d        ld      e,l
1997 00        nop     
1998 8e        adc     a,(hl)
1999 17        rla     
199a 02        ld      (bc),a
199b 5d        ld      e,l
199c 00        nop     
199d 8d        adc     a,l
199e 3000      jr      nc,19a0h
19a0 02        ld      (bc),a
19a1 0f        rrca    
19a2 00        nop     
19a3 94        sub     h
19a4 3000      jr      nc,19a6h
19a6 02        ld      (bc),a
19a7 010007    ld      bc,0700h
19aa ff        rst     38h
19ab 1f        rra     
19ac 0100ff    ld      bc,0ff00h
19af a0        and     b
19b0 0a        ld      a,(bc)
19b1 1890      jr      1943h
19b3 1006      djnz    19bbh
19b5 00        nop     
19b6 08        ex      af,af'
19b7 08        ex      af,af'
19b8 02        ld      (bc),a
19b9 55        ld      d,l
19ba 00        nop     
19bb 07        rlca    
19bc 55        ld      d,l
19bd 05        dec     b
19be 0100ff    ld      bc,0ff00h
19c1 50        ld      d,b
19c2 05        dec     b
19c3 1890      jr      1955h
19c5 40        ld      b,b
19c6 0c        inc     c
19c7 00        nop     
19c8 08        ex      af,af'
19c9 04        inc     b
19ca 02        ld      (bc),a
19cb 81        add     a,c
19cc 00        nop     
19cd 88        adc     a,b
19ce 2000      jr      nz,19d0h
19d0 02        ld      (bc),a
19d1 15        dec     d
19d2 00        nop     
19d3 90        sub     b
19d4 2800      jr      z,19d6h
19d6 02        ld      (bc),a
19d7 61        ld      h,c
19d8 00        nop     
19d9 90        sub     b
19da 2800      jr      z,19dch
19dc 02        ld      (bc),a
19dd 46        ld      b,(hl)
19de 00        nop     
19df 90        sub     b
19e0 3000      jr      nc,19e2h
19e2 02        ld      (bc),a
19e3 4d        ld      c,l
19e4 00        nop     
19e5 90        sub     b
19e6 3000      jr      nc,19e8h
19e8 02        ld      (bc),a
19e9 14        inc     d
19ea 00        nop     
19eb 90        sub     b
19ec 60        ld      h,b
19ed 00        nop     
19ee 07        rlca    
19ef ff        rst     38h
19f0 ff        rst     38h
19f1 0100ff    ld      bc,0ff00h
19f4 a8        xor     b
19f5 02        ld      (bc),a
19f6 12        ld      (de),a
19f7 00        nop     
19f8 00        nop     
19f9 46        ld      b,(hl)
19fa 19        add     hl,de
19fb 03        inc     bc
19fc 02        ld      (bc),a
19fd 2b        dec     hl
19fe 00        nop     
19ff 188d      jr      198eh
1a01 2840      jr      z,1a43h
1a03 00        nop     
1a04 02        ld      (bc),a
1a05 0c        inc     c
1a06 00        nop     
1a07 90        sub     b
1a08 58        ld      e,b
1a09 00        nop     
1a0a 02        ld      (bc),a
1a0b 0c        inc     c
1a0c 00        nop     
1a0d 8f        adc     a,a
1a0e 60        ld      h,b
1a0f 00        nop     
1a10 02        ld      (bc),a
1a11 0c        inc     c
1a12 00        nop     
1a13 90        sub     b
1a14 40        ld      b,b
1a15 00        nop     
1a16 02        ld      (bc),a
1a17 2e00      ld      l,00h
1a19 12        ld      (de),a
1a1a 00        nop     
1a1b 00        nop     
1a1c 320c00    ld      (000ch),a
1a1f 90        sub     b
1a20 3000      jr      nc,1a22h
1a22 02        ld      (bc),a
1a23 25        dec     h
1a24 00        nop     
1a25 13        inc     de
1a26 0600      ld      b,00h
1a28 1e0c      ld      e,0ch
1a2a 00        nop     
1a2b 90        sub     b
1a2c 40        ld      b,b
1a2d 00        nop     
1a2e 02        ld      (bc),a
1a2f 0c        inc     c
1a30 00        nop     
1a31 8e        adc     a,(hl)
1a32 60        ld      h,b
1a33 00        nop     
1a34 02        ld      (bc),a
1a35 1600      ld      d,00h
1a37 90        sub     b
1a38 68        ld      l,b
1a39 00        nop     
1a3a 02        ld      (bc),a
1a3b 0c        inc     c
1a3c 00        nop     
1a3d 90        sub     b
1a3e 48        ld      c,b
1a3f 02        ld      (bc),a
1a40 0c        inc     c
1a41 00        nop     
1a42 90        sub     b
1a43 70        ld      (hl),b
1a44 00        nop     
1a45 02        ld      (bc),a
1a46 2000      jr      nz,1a48h
1a48 80        add     a,b
1a49 0a        ld      a,(bc)
1a4a 90        sub     b
1a4b 88        adc     a,b
1a4c 00        nop     
1a4d 02        ld      (bc),a
1a4e 2000      jr      nz,1a50h
1a50 80        add     a,b
1a51 50        ld      d,b
1a52 80        add     a,b
1a53 70        ld      (hl),b
1a54 90        sub     b
1a55 60        ld      h,b
1a56 00        nop     
1a57 02        ld      (bc),a
1a58 0c        inc     c
1a59 00        nop     
1a5a 07        rlca    
1a5b ff        rst     38h
1a5c ff        rst     38h
1a5d 0100ff    ld      bc,0ff00h
1a60 f8        ret     m

1a61 07        rlca    
1a62 90        sub     b
1a63 04        inc     b
1a64 08        ex      af,af'
1a65 00        nop     
1a66 02        ld      (bc),a
1a67 1800      jr      1a69h
1a69 90        sub     b
1a6a 40        ld      b,b
1a6b 00        nop     
1a6c 02        ld      (bc),a
1a6d 52        ld      d,d
1a6e 00        nop     
1a6f 8d        adc     a,l
1a70 40        ld      b,b
1a71 00        nop     
1a72 02        ld      (bc),a
1a73 40        ld      b,b
1a74 00        nop     
1a75 8c        adc     a,h
1a76 40        ld      b,b
1a77 00        nop     
1a78 02        ld      (bc),a
1a79 39        add     hl,sp
1a7a 00        nop     
1a7b 8f        adc     a,a
1a7c 40        ld      b,b
1a7d 00        nop     
1a7e 07        rlca    
1a7f ff        rst     38h
1a80 ff        rst     38h
1a81 0100ff    ld      bc,0ff00h
1a84 fc0318    call    m,1803h
1a87 02        ld      (bc),a
1a88 0d        dec     c
1a89 00        nop     
1a8a 90        sub     b
1a8b 50        ld      d,b
1a8c 1000      djnz    1a8eh
1a8e 07        rlca    
1a8f ff        rst     38h
1a90 ff        rst     38h
1a91 0100ff    ld      bc,0ff00h
1a94 66        ld      h,(hl)
1a95 00        nop     
1a96 1802      jr      1a9ah
1a98 0d        dec     c
1a99 00        nop     
1a9a 90        sub     b
1a9b 02        ld      (bc),a
1a9c c0        ret     nz

1a9d 00        nop     
1a9e 02        ld      (bc),a
1a9f 03        inc     bc
1aa0 00        nop     
1aa1 90        sub     b
1aa2 70        ld      (hl),b
1aa3 00        nop     
1aa4 02        ld      (bc),a
1aa5 1c        inc     e
1aa6 00        nop     
1aa7 07        rlca    
1aa8 ff        rst     38h
1aa9 ff        rst     38h
1aaa 0100ff    ld      bc,0ff00h
1aad fc0318    call    m,1803h
1ab0 89        adc     a,c
1ab1 58        ld      e,b
1ab2 1000      djnz    1ab4h
1ab4 08        ex      af,af'
1ab5 0c        inc     c
1ab6 02        ld      (bc),a
1ab7 00        nop     
1ab8 00        nop     
1ab9 9a        sbc     a,d
1aba 58        ld      e,b
1abb 00        nop     
1abc 1680      ld      d,80h
1abe 1b        dec     de
1abf 08        ex      af,af'
1ac0 09        add     hl,bc
1ac1 09        add     hl,bc
1ac2 02        ld      (bc),a
1ac3 0a        ld      a,(bc)
1ac4 04        inc     b
1ac5 010b03    ld      bc,030bh
1ac8 02        ld      (bc),a
1ac9 29        add     hl,hl
1aca 00        nop     
1acb 90        sub     b
1acc 50        ld      d,b
1acd 00        nop     
1ace 1680      ld      d,80h
1ad0 0b        dec     bc
1ad1 0a        ld      a,(bc)
1ad2 02        ld      (bc),a
1ad3 010602    ld      bc,0206h
1ad6 08        ex      af,af'
1ad7 0c        inc     c
1ad8 09        add     hl,bc
1ad9 0c        inc     c
1ada 02        ld      (bc),a
1adb 29        add     hl,hl
1adc 00        nop     
1add 90        sub     b
1ade 50        ld      d,b
1adf 00        nop     
1ae0 1608      ld      d,08h
1ae2 0f        rrca    
1ae3 09        add     hl,bc
1ae4 08        ex      af,af'
1ae5 02        ld      (bc),a
1ae6 29        add     hl,hl
1ae7 00        nop     
1ae8 90        sub     b
1ae9 50        ld      d,b
1aea 00        nop     
1aeb 02        ld      (bc),a
1aec 0c        inc     c
1aed 00        nop     
1aee 90        sub     b
1aef 3002      jr      nc,1af3h
1af1 0c        inc     c
1af2 00        nop     
1af3 90        sub     b
1af4 40        ld      b,b
1af5 00        nop     
1af6 08        ex      af,af'
1af7 09        add     hl,bc
1af8 02        ld      (bc),a
1af9 8e        adc     a,(hl)
1afa 00        nop     
1afb 96        sub     (hl)
1afc 1800      jr      1afeh
1afe 08        ex      af,af'
1aff 04        inc     b
1b00 02        ld      (bc),a
1b01 8d        adc     a,l
1b02 00        nop     
1b03 90        sub     b
1b04 1000      djnz    1b06h
1b06 08        ex      af,af'
1b07 08        ex      af,af'
1b08 02        ld      (bc),a
1b09 63        ld      h,e
1b0a 00        nop     
1b0b 90        sub     b
1b0c 08        ex      af,af'
1b0d 00        nop     
1b0e 08        ex      af,af'
1b0f 03        inc     bc
1b10 02        ld      (bc),a
1b11 86        add     a,(hl)
1b12 00        nop     
1b13 90        sub     b
1b14 3000      jr      nc,1b16h
1b16 08        ex      af,af'
1b17 07        rlca    
1b18 02        ld      (bc),a
1b19 09        add     hl,bc
1b1a 00        nop     
1b1b 07        rlca    
1b1c ff        rst     38h
1b1d ff        rst     38h
1b1e 0100ff    ld      bc,0ff00h
1b21 fc0313    call    m,1303h
1b24 00        nop     
1b25 00        nop     
1b26 64        ld      h,h
1b27 2800      jr      z,1b29h
1b29 1890      jr      1abbh
1b2b 0c        inc     c
1b2c 1000      djnz    1b2eh
1b2e 02        ld      (bc),a
1b2f 4c        ld      c,h
1b30 00        nop     
1b31 90        sub     b
1b32 3800      jr      c,1b34h
1b34 02        ld      (bc),a
1b35 3600      ld      (hl),00h
1b37 1807      jr      1b40h
1b39 ff        rst     38h
1b3a ff        rst     38h
1b3b 0100ff    ld      bc,0ff00h
1b3e fc0313    call    m,1303h
1b41 00        nop     
1b42 00        nop     
1b43 c8        ret     z

1b44 1e1e      ld      e,1eh
1b46 90        sub     b
1b47 1813      jr      1b5ch
1b49 00        nop     
1b4a 02        ld      (bc),a
1b4b 3600      ld      (hl),00h
1b4d 07        rlca    
1b4e ff        rst     38h
1b4f ff        rst     38h
1b50 0100ff    ld      bc,0ff00h
1b53 fc0312    call    m,1203h
1b56 00        nop     
1b57 00        nop     
1b58 c8        ret     z

1b59 0a        ld      a,(bc)
1b5a 00        nop     
1b5b 1890      jr      1aedh
1b5d 0c        inc     c
1b5e 1000      djnz    1b60h
1b60 02        ld      (bc),a
1b61 3600      ld      (hl),00h
1b63 07        rlca    
1b64 ff        rst     38h
1b65 ff        rst     38h
1b66 0100ff    ld      bc,0ff00h
1b69 fc0313    call    m,1303h
1b6c 00        nop     
1b6d 00        nop     
1b6e c8        ret     z

1b6f 08        ex      af,af'
1b70 00        nop     
1b71 1890      jr      1b03h
1b73 08        ex      af,af'
1b74 1000      djnz    1b76h
1b76 02        ld      (bc),a
1b77 3600      ld      (hl),00h
1b79 07        rlca    
1b7a ff        rst     38h
1b7b 1f        rra     
1b7c 0100ff    ld      bc,0ff00h
1b7f fc0318    call    m,1803h
1b82 90        sub     b
1b83 14        inc     d
1b84 1000      djnz    1b86h
1b86 08        ex      af,af'
1b87 0602      ld      b,02h
1b89 86        add     a,(hl)
1b8a 00        nop     
1b8b 90        sub     b
1b8c 04        inc     b
1b8d 90        sub     b
1b8e 07        rlca    
1b8f 00        nop     
1b90 02        ld      (bc),a
1b91 4c        ld      c,h
1b92 00        nop     
1b93 07        rlca    
1b94 ff        rst     38h
1b95 ff        rst     38h
1b96 0100ff    ld      bc,0ff00h
1b99 f8        ret     m

1b9a 07        rlca    
1b9b 1890      jr      1b2dh
1b9d 1020      djnz    1bbfh
1b9f 00        nop     
1ba0 02        ld      (bc),a
1ba1 48        ld      c,b
1ba2 00        nop     
1ba3 90        sub     b
1ba4 3000      jr      nc,1ba6h
1ba6 02        ld      (bc),a
1ba7 44        ld      b,h
1ba8 00        nop     
1ba9 90        sub     b
1baa 0c        inc     c
1bab 00        nop     
1bac 08        ex      af,af'
1bad 09        add     hl,bc
1bae 1602      ld      d,02h
1bb0 09        add     hl,bc
1bb1 00        nop     
1bb2 90        sub     b
1bb3 0e00      ld      c,00h
1bb5 08        ex      af,af'
1bb6 0616      ld      b,16h
1bb8 02        ld      (bc),a
1bb9 86        add     a,(hl)
1bba 00        nop     
1bbb 90        sub     b
1bbc 0e00      ld      c,00h
1bbe 08        ex      af,af'
1bbf 0a        ld      a,(bc)
1bc0 02        ld      (bc),a
1bc1 54        ld      d,h
1bc2 00        nop     
1bc3 8a        adc     a,d
1bc4 2000      jr      nz,1bc6h
1bc6 02        ld      (bc),a
1bc7 4c        ld      c,h
1bc8 00        nop     
1bc9 1893      jr      1b5eh
1bcb 02        ld      (bc),a
1bcc 0690      ld      b,90h
1bce 1020      djnz    1bf0h
1bd0 00        nop     
1bd1 02        ld      (bc),a
1bd2 3600      ld      (hl),00h
1bd4 90        sub     b
1bd5 1802      jr      1bd9h
1bd7 4c        ld      c,h
1bd8 00        nop     
1bd9 90        sub     b
1bda 1c        inc     e
1bdb 02        ld      (bc),a
1bdc 4a        ld      c,d
1bdd 00        nop     
1bde 90        sub     b
1bdf 2002      jr      nz,1be3h
1be1 62        ld      h,d
1be2 00        nop     
1be3 90        sub     b
1be4 40        ld      b,b
1be5 00        nop     
1be6 02        ld      (bc),a
1be7 4c        ld      c,h
1be8 00        nop     
1be9 86        add     a,(hl)
1bea 0e02      ld      c,02h
1bec 3600      ld      (hl),00h
1bee 90        sub     b
1bef 14        inc     d
1bf0 02        ld      (bc),a
1bf1 4c        ld      c,h
1bf2 00        nop     
1bf3 90        sub     b
1bf4 0602      ld      b,02h
1bf6 3600      ld      (hl),00h
1bf8 81        add     a,c
1bf9 2002      jr      nz,1bfdh
1bfb 4a        ld      c,d
1bfc 00        nop     
1bfd 90        sub     b
1bfe 40        ld      b,b
1bff 00        nop     
1c00 02        ld      (bc),a
1c01 7a        ld      a,d
1c02 00        nop     
1c03 90        sub     b
1c04 2000      jr      nz,1c06h
1c06 02        ld      (bc),a
1c07 13        inc     de
1c08 00        nop     
1c09 1808      jr      1c13h
1c0b 04        inc     b
1c0c 07        rlca    
1c0d 55        ld      d,l
1c0e 15        dec     d
1c0f 0100ff    ld      bc,0ff00h
1c12 02        ld      (bc),a
1c13 02        ld      (bc),a
1c14 90        sub     b
1c15 3030      jr      nc,1c47h
1c17 00        nop     
1c18 02        ld      (bc),a
1c19 1b        dec     de
1c1a 00        nop     
1c1b 90        sub     b
1c1c 3000      jr      nc,1c1eh
1c1e 02        ld      (bc),a
1c1f 5b        ld      e,e
1c20 00        nop     
1c21 90        sub     b
1c22 2800      jr      z,1c24h
1c24 02        ld      (bc),a
1c25 59        ld      e,c
1c26 00        nop     
1c27 90        sub     b
1c28 40        ld      b,b
1c29 00        nop     
1c2a 02        ld      (bc),a
1c2b 6c        ld      l,h
1c2c 00        nop     
1c2d 90        sub     b
1c2e 40        ld      b,b
1c2f 00        nop     
1c30 02        ld      (bc),a
1c31 5a        ld      e,d
1c32 00        nop     
1c33 90        sub     b
1c34 3000      jr      nc,1c36h
1c36 02        ld      (bc),a
1c37 58        ld      e,b
1c38 00        nop     
1c39 90        sub     b
1c3a 3000      jr      nc,1c3ch
1c3c 02        ld      (bc),a
1c3d 1800      jr      1c3fh
1c3f 90        sub     b
1c40 40        ld      b,b
1c41 00        nop     
1c42 02        ld      (bc),a
1c43 7b        ld      a,e
1c44 00        nop     
1c45 90        sub     b
1c46 2000      jr      nz,1c48h
1c48 02        ld      (bc),a
1c49 8a        adc     a,d
1c4a 00        nop     
1c4b 90        sub     b
1c4c 40        ld      b,b
1c4d 00        nop     
1c4e 02        ld      (bc),a
1c4f 6b        ld      l,e
1c50 00        nop     
1c51 07        rlca    
1c52 ff        rst     38h
1c53 ff        rst     38h
1c54 0100ff    ld      bc,0ff00h
1c57 f0        ret     p

1c58 0f        rrca    
1c59 1892      jr      1bedh
1c5b 0603      ld      b,03h
1c5d 00        nop     
1c5e 08        ex      af,af'
1c5f 0e02      ld      c,02h
1c61 63        ld      h,e
1c62 00        nop     
1c63 07        rlca    
1c64 ff        rst     38h
1c65 ff        rst     38h
1c66 0100ff    ld      bc,0ff00h
1c69 f0        ret     p

1c6a 0f        rrca    
1c6b 1892      jr      1bffh
1c6d 0603      ld      b,03h
1c6f 00        nop     
1c70 1802      jr      1c74h
1c72 0c        inc     c
1c73 00        nop     
1c74 07        rlca    
1c75 aa        xor     d
1c76 2a0100    ld      hl,(0001h)
1c79 ff        rst     38h
1c7a 00        nop     
1c7b 019320    ld      bc,2093h
1c7e 3800      jr      c,1c80h
1c80 1802      jr      1c84h
1c82 0c        inc     c
1c83 00        nop     
1c84 07        rlca    
1c85 ff        rst     38h
1c86 ff        rst     38h
1c87 0100ff    ld      bc,0ff00h
1c8a 00        nop     
1c8b 019907    ld      bc,0799h
1c8e 019907    ld      bc,0799h
1c91 019906    ld      bc,0699h
1c94 019905    ld      bc,0599h
1c97 019804    ld      bc,0498h
1c9a 00        nop     
1c9b 80        add     a,b
1c9c 0a        ld      a,(bc)
1c9d 00        nop     
1c9e 00        nop     
1c9f 02        ld      (bc),a
1ca0 210090    ld      hl,9000h
1ca3 1c        inc     e
1ca4 00        nop     
1ca5 02        ld      (bc),a
1ca6 4c        ld      c,h
1ca7 00        nop     
1ca8 8e        adc     a,(hl)
1ca9 0691      ld      b,91h
1cab 2600      ld      h,00h
1cad 02        ld      (bc),a
1cae 09        add     hl,bc
1caf 00        nop     
1cb0 90        sub     b
1cb1 2000      jr      nz,1cb3h
1cb3 02        ld      (bc),a
1cb4 86        add     a,(hl)
1cb5 00        nop     
1cb6 90        sub     b
1cb7 1000      djnz    1cb9h
1cb9 02        ld      (bc),a
1cba 6b        ld      l,e
1cbb 00        nop     
1cbc 12        ld      (de),a
1cbd 00        nop     
1cbe 00        nop     
1cbf 05        dec     b
1cc0 7f        ld      a,a
1cc1 05        dec     b
1cc2 90        sub     b
1cc3 1b        dec     de
1cc4 00        nop     
1cc5 02        ld      (bc),a
1cc6 63        ld      h,e
1cc7 00        nop     
1cc8 90        sub     b
1cc9 2000      jr      nz,1ccbh
1ccb 00        nop     
1ccc 02        ld      (bc),a
1ccd 47        ld      b,a
1cce 00        nop     
1ccf 90        sub     b
1cd0 40        ld      b,b
1cd1 80        add     a,b
1cd2 2002      jr      nz,1cd6h
1cd4 85        add     a,l
1cd5 00        nop     
1cd6 90        sub     b
1cd7 40        ld      b,b
1cd8 80        add     a,b
1cd9 2002      jr      nz,1cddh
1cdb 4d        ld      c,l
1cdc 00        nop     
1cdd 90        sub     b
1cde 40        ld      b,b
1cdf 80        add     a,b
1ce0 2002      jr      nz,1ce4h
1ce2 07        rlca    
1ce3 00        nop     
1ce4 90        sub     b
1ce5 40        ld      b,b
1ce6 80        add     a,b
1ce7 2002      jr      nz,1cebh
1ce9 17        rla     
1cea 00        nop     
1ceb 90        sub     b
1cec 40        ld      b,b
1ced 80        add     a,b
1cee 2002      jr      nz,1cf2h
1cf0 1d        dec     e
1cf1 00        nop     
1cf2 90        sub     b
1cf3 40        ld      b,b
1cf4 80        add     a,b
1cf5 2002      jr      nz,1cf9h
1cf7 04        inc     b
1cf8 00        nop     
1cf9 90        sub     b
1cfa 40        ld      b,b
1cfb 80        add     a,b
1cfc 2002      jr      nz,1d00h
1cfe 220090    ld      (9000h),hl
1d01 40        ld      b,b
1d02 80        add     a,b
1d03 2002      jr      nz,1d07h
1d05 23        inc     hl
1d06 00        nop     
1d07 90        sub     b
1d08 40        ld      b,b
1d09 80        add     a,b
1d0a 2002      jr      nz,1d0eh
1d0c 2800      jr      z,1d0eh
1d0e 90        sub     b
1d0f 40        ld      b,b
1d10 80        add     a,b
1d11 2002      jr      nz,1d15h
1d13 33        inc     sp
1d14 00        nop     
1d15 90        sub     b
1d16 40        ld      b,b
1d17 80        add     a,b
1d18 2002      jr      nz,1d1ch
1d1a 27        daa     
1d1b 00        nop     
1d1c 90        sub     b
1d1d 40        ld      b,b
1d1e 80        add     a,b
1d1f 2002      jr      nz,1d23h
1d21 3a0090    ld      a,(9000h)
1d24 40        ld      b,b
1d25 80        add     a,b
1d26 2002      jr      nz,1d2ah
1d28 3e00      ld      a,00h
1d2a 90        sub     b
1d2b 40        ld      b,b
1d2c 80        add     a,b
1d2d 2002      jr      nz,1d31h
1d2f 4b        ld      c,e
1d30 00        nop     
1d31 90        sub     b
1d32 40        ld      b,b
1d33 80        add     a,b
1d34 2002      jr      nz,1d38h
1d36 5f        ld      e,a
1d37 00        nop     
1d38 90        sub     b
1d39 40        ld      b,b
1d3a 80        add     a,b
1d3b 2002      jr      nz,1d3fh
1d3d 6f        ld      l,a
1d3e 00        nop     
1d3f 90        sub     b
1d40 40        ld      b,b
1d41 80        add     a,b
1d42 2002      jr      nz,1d46h
1d44 0c        inc     c
1d45 00        nop     
1d46 90        sub     b
1d47 40        ld      b,b
1d48 80        add     a,b
1d49 2002      jr      nz,1d4dh
1d4b 19        add     hl,de
1d4c 00        nop     
1d4d 90        sub     b
1d4e 40        ld      b,b
1d4f 80        add     a,b
1d50 2002      jr      nz,1d54h
1d52 12        ld      (de),a
1d53 00        nop     
1d54 90        sub     b
1d55 40        ld      b,b
1d56 80        add     a,b
1d57 2002      jr      nz,1d5bh
1d59 8b        adc     a,e
1d5a 00        nop     
1d5b 90        sub     b
1d5c 40        ld      b,b
1d5d 80        add     a,b
1d5e 2002      jr      nz,1d62h
1d60 49        ld      c,c
1d61 00        nop     
1d62 90        sub     b
1d63 40        ld      b,b
1d64 80        add     a,b
1d65 2000      jr      nz,1d67h
1d67 60        ld      h,b
1d68 50        ld      d,b
1d69 50        ld      d,b
1d6a 50        ld      d,b
1d6b 58        ld      e,b
1d6c 50        ld      d,b
1d6d 46        ld      b,(hl)
1d6e 60        ld      h,b
1d6f 5a        ld      e,d
1d70 5c        ld      e,h
1d71 384a      jr      c,1dbdh
1d73 5c        ld      e,h
1d74 40        ld      b,b
1d75 5a        ld      e,d
1d76 4a        ld      c,d
1d77 68        ld      l,b
1d78 101f      djnz    1d99h
1d7a 101f      djnz    1d9bh
1d7c 101f      djnz    1d9dh
1d7e 101f      djnz    1d9fh
1d80 101f      djnz    1da1h
1d82 101f      djnz    1da3h
1d84 101f      djnz    1da5h
1d86 101f      djnz    1da7h
1d88 101f      djnz    1da9h
1d8a 101f      djnz    1dabh
1d8c 101f      djnz    1dadh
1d8e 101f      djnz    1dafh
1d90 101f      djnz    1db1h
1d92 101f      djnz    1db3h
1d94 101f      djnz    1db5h
1d96 101f      djnz    1db7h
1d98 101f      djnz    1db9h
1d9a 101f      djnz    1dbbh
1d9c 101f      djnz    1dbdh
1d9e 101f      djnz    1dbfh
1da0 101f      djnz    1dc1h
1da2 101f      djnz    1dc3h
1da4 101f      djnz    1dc5h
1da6 101f      djnz    1dc7h
1da8 15        dec     d
1da9 2002      jr      nz,1dadh
1dab 219d26    ld      hl,269dh
1dae ee25      xor     25h
1db0 ae        xor     (hl)
1db1 24        inc     h
1db2 ce25      adc     a,25h
1db4 be        cp      (hl)
1db5 23        inc     hl
1db6 9b        sbc     a,e
1db7 226427    ld      (2764h),hl
1dba 65        ld      h,l
1dbb 27        daa     
1dbc 66        ld      h,(hl)
1dbd 27        daa     
1dbe 67        ld      h,a
1dbf 27        daa     
1dc0 101f      djnz    1de1h
1dc2 101f      djnz    1de3h
1dc4 101f      djnz    1de5h
1dc6 101f      djnz    1de7h
1dc8 101f      djnz    1de9h
1dca 101f      djnz    1debh
1dcc 101f      djnz    1dedh
1dce 101f      djnz    1defh
1dd0 101f      djnz    1df1h
1dd2 101f      djnz    1df3h
1dd4 101f      djnz    1df5h
1dd6 101f      djnz    1df7h
1dd8 68        ld      l,b
1dd9 27        daa     
1dda 2b        dec     hl
1ddb 2d        dec     l
1ddc 39        add     hl,sp
1ddd 2f        cpl     
1dde 02        ld      (bc),a
1ddf 32ff34    ld      (34ffh),a
1de2 82        add     a,d
1de3 35        dec     (hl)
1de4 05        dec     b
1de5 369d      ld      (hl),9dh
1de7 363e      ld      (hl),3eh
1de9 3ae83a    ld      a,(3ae8h)
1dec 92        sub     d
1ded 3b        dec     sp
1dee 93        sub     e
1def 3b        dec     sp
1df0 101f      djnz    1e11h
1df2 101f      djnz    1e13h
1df4 101f      djnz    1e15h
1df6 101f      djnz    1e17h
1df8 101f      djnz    1e19h
1dfa 101f      djnz    1e1bh
1dfc 101f      djnz    1e1dh
1dfe 101f      djnz    1e1fh
1e00 101f      djnz    1e21h
1e02 101f      djnz    1e23h
1e04 101f      djnz    1e25h
1e06 101f      djnz    1e27h
1e08 101f      djnz    1e29h
1e0a 101f      djnz    1e2bh
1e0c 101f      djnz    1e2dh
1e0e 101f      djnz    1e2fh
1e10 101f      djnz    1e31h
1e12 101f      djnz    1e33h
1e14 101f      djnz    1e35h
1e16 101f      djnz    1e37h
1e18 101f      djnz    1e39h
1e1a 101f      djnz    1e3bh
1e1c 101f      djnz    1e3dh
1e1e 101f      djnz    1e3fh
1e20 94        sub     h
1e21 3b        dec     sp
1e22 89        adc     a,c
1e23 3d        dec     a
1e24 2d        dec     l
1e25 3e66      ld      a,66h
1e27 40        ld      b,b
1e28 56        ld      d,(hl)
1e29 42        ld      b,d
1e2a 2e43      ld      l,43h
1e2c ce43      adc     a,43h
1e2e 4e        ld      c,(hl)
1e2f 46        ld      b,(hl)
1e30 60        ld      h,b
1e31 44        ld      b,h
1e32 2c        inc     l
1e33 48        ld      c,b
1e34 a0        and     b
1e35 48        ld      c,b
1e36 1649      ld      d,49h
1e38 101f      djnz    1e59h
1e3a 101f      djnz    1e5bh
1e3c 101f      djnz    1e5dh
1e3e 101f      djnz    1e5fh
1e40 101f      djnz    1e61h
1e42 101f      djnz    1e63h
1e44 101f      djnz    1e65h
1e46 101f      djnz    1e67h
1e48 101f      djnz    1e69h
1e4a 101f      djnz    1e6bh
1e4c 101f      djnz    1e6dh
1e4e 101f      djnz    1e6fh
1e50 101f      djnz    1e71h
1e52 101f      djnz    1e73h
1e54 101f      djnz    1e75h
1e56 101f      djnz    1e77h
1e58 101f      djnz    1e79h
1e5a 101f      djnz    1e7bh
1e5c 101f      djnz    1e7dh
1e5e 101f      djnz    1e7fh
1e60 101f      djnz    1e81h
1e62 101f      djnz    1e83h
1e64 101f      djnz    1e85h
1e66 101f      djnz    1e87h
1e68 101f      djnz    1e89h
1e6a 101f      djnz    1e8bh
1e6c 101f      djnz    1e8dh
1e6e 101f      djnz    1e8fh
1e70 101f      djnz    1e91h
1e72 101f      djnz    1e93h
1e74 101f      djnz    1e95h
1e76 101f      djnz    1e97h
1e78 101f      djnz    1e99h
1e7a 101f      djnz    1e9bh
1e7c 101f      djnz    1e9dh
1e7e 101f      djnz    1e9fh
1e80 90        sub     b
1e81 49        ld      c,c
1e82 f0        ret     p

1e83 4b        ld      c,e
1e84 59        ld      e,c
1e85 4d        ld      c,l
1e86 c7        rst     00h
1e87 4e        ld      c,(hl)
1e88 3250e4    ld      (0e450h),a
1e8b 54        ld      d,h
1e8c bb        cp      e
1e8d 58        ld      e,b
1e8e 2c        inc     l
1e8f 5a        ld      e,d
1e90 2c        inc     l
1e91 5a        ld      e,d
1e92 b5        or      l
1e93 5c        ld      e,h
1e94 a6        and     (hl)
1e95 5e        ld      e,(hl)
1e96 97        sub     a
1e97 60        ld      h,b
1e98 101f      djnz    1eb9h
1e9a 101f      djnz    1ebbh
1e9c 101f      djnz    1ebdh
1e9e 101f      djnz    1ebfh
1ea0 101f      djnz    1ec1h
1ea2 101f      djnz    1ec3h
1ea4 101f      djnz    1ec5h
1ea6 101f      djnz    1ec7h
1ea8 101f      djnz    1ec9h
1eaa 101f      djnz    1ecbh
1eac 101f      djnz    1ecdh
1eae 101f      djnz    1ecfh
1eb0 101f      djnz    1ed1h
1eb2 101f      djnz    1ed3h
1eb4 101f      djnz    1ed5h
1eb6 101f      djnz    1ed7h
1eb8 101f      djnz    1ed9h
1eba 101f      djnz    1edbh
1ebc 101f      djnz    1eddh
1ebe 101f      djnz    1edfh
1ec0 101f      djnz    1ee1h
1ec2 101f      djnz    1ee3h
1ec4 101f      djnz    1ee5h
1ec6 101f      djnz    1ee7h
1ec8 101f      djnz    1ee9h
1eca 101f      djnz    1eebh
1ecc 101f      djnz    1eedh
1ece 101f      djnz    1eefh
1ed0 101f      djnz    1ef1h
1ed2 101f      djnz    1ef3h
1ed4 101f      djnz    1ef5h
1ed6 101f      djnz    1ef7h
1ed8 101f      djnz    1ef9h
1eda 101f      djnz    1efbh
1edc 101f      djnz    1efdh
1ede 101f      djnz    1effh
1ee0 f1        pop     af
1ee1 60        ld      h,b
1ee2 b0        or      b
1ee3 61        ld      h,c
1ee4 4e        ld      c,(hl)
1ee5 62        ld      h,d
1ee6 a8        xor     b
1ee7 62        ld      h,d
1ee8 02        ld      (bc),a
1ee9 63        ld      h,e
1eea 61        ld      h,c
1eeb 63        ld      h,e
1eec a9        xor     c
1eed 63        ld      h,e
1eee f1        pop     af
1eef 63        ld      h,e
1ef0 39        add     hl,sp
1ef1 64        ld      h,h
1ef2 68        ld      l,b
1ef3 64        ld      h,h
1ef4 84        add     a,h
1ef5 64        ld      h,h
1ef6 e1        pop     hl
1ef7 64        ld      h,h
1ef8 94        sub     h
1ef9 3b        dec     sp
1efa 89        adc     a,c
1efb 3d        dec     a
1efc 2d        dec     l
1efd 3e66      ld      a,66h
1eff 40        ld      b,b
1f00 101f      djnz    1f21h
1f02 101f      djnz    1f23h
1f04 101f      djnz    1f25h
1f06 101f      djnz    1f27h
1f08 101f      djnz    1f29h
1f0a 101f      djnz    1f2bh
1f0c 101f      djnz    1f2dh
1f0e 101f      djnz    1f2fh
1f10 00        nop     
1f11 2002      jr      nz,1f15h
1f13 33        inc     sp
1f14 00        nop     
1f15 90        sub     b
1f16 40        ld      b,b
1f17 80        add     a,b
1f18 2002      jr      nz,1f1ch
1f1a 27        daa     
1f1b 00        nop     
1f1c 90        sub     b
1f1d 40        ld      b,b
1f1e 80        add     a,b
1f1f 2002      jr      nz,1f23h
1f21 3a0090    ld      a,(9000h)
1f24 40        ld      b,b
1f25 80        add     a,b
1f26 2002      jr      nz,1f2ah
1f28 3e00      ld      a,00h
1f2a 90        sub     b
1f2b 40        ld      b,b
1f2c 80        add     a,b
1f2d 2002      jr      nz,1f31h
1f2f 4b        ld      c,e
1f30 00        nop     
1f31 90        sub     b
1f32 40        ld      b,b
1f33 80        add     a,b
1f34 2002      jr      nz,1f38h
1f36 5f        ld      e,a
1f37 00        nop     
1f38 90        sub     b
1f39 40        ld      b,b
1f3a 80        add     a,b
1f3b 2002      jr      nz,1f3fh
1f3d 6f        ld      l,a
1f3e 00        nop     
1f3f 90        sub     b
1f40 40        ld      b,b
1f41 80        add     a,b
1f42 2002      jr      nz,1f46h
1f44 0c        inc     c
1f45 00        nop     
1f46 90        sub     b
1f47 40        ld      b,b
1f48 80        add     a,b
1f49 2002      jr      nz,1f4dh
1f4b 19        add     hl,de
1f4c 00        nop     
1f4d 90        sub     b
1f4e 40        ld      b,b
1f4f 80        add     a,b
1f50 2002      jr      nz,1f54h
1f52 12        ld      (de),a
1f53 00        nop     
1f54 90        sub     b
1f55 40        ld      b,b
1f56 80        add     a,b
1f57 2002      jr      nz,1f5bh
1f59 8b        adc     a,e
1f5a 00        nop     
1f5b 90        sub     b
1f5c 40        ld      b,b
1f5d 80        add     a,b
1f5e 2002      jr      nz,1f62h
1f60 49        ld      c,c
1f61 00        nop     
1f62 90        sub     b
1f63 40        ld      b,b
1f64 80        add     a,b
1f65 2000      jr      nz,1f67h
1f67 60        ld      h,b
1f68 50        ld      d,b
1f69 50        ld      d,b
1f6a 50        ld      d,b
1f6b 58        ld      e,b
1f6c 50        ld      d,b
1f6d 46        ld      b,(hl)
1f6e 60        ld      h,b
1f6f 5a        ld      e,d
1f70 5c        ld      e,h
1f71 384a      jr      c,1fbdh
1f73 5c        ld      e,h
1f74 40        ld      b,b
1f75 5a        ld      e,d
1f76 4a        ld      c,d
1f77 68        ld      l,b
1f78 101f      djnz    1f99h
1f7a 101f      djnz    1f9bh
1f7c 101f      djnz    1f9dh
1f7e 101f      djnz    1f9fh
1f80 101f      djnz    1fa1h
1f82 101f      djnz    1fa3h
1f84 101f      djnz    1fa5h
1f86 101f      djnz    1fa7h
1f88 101f      djnz    1fa9h
1f8a 101f      djnz    1fabh
1f8c 101f      djnz    1fadh
1f8e 101f      djnz    1fafh
1f90 101f      djnz    1fb1h
1f92 101f      djnz    1fb3h
1f94 101f      djnz    1fb5h
1f96 101f      djnz    1fb7h
1f98 101f      djnz    1fb9h
1f9a 101f      djnz    1fbbh
1f9c 101f      djnz    1fbdh
1f9e 101f      djnz    1fbfh
1fa0 101f      djnz    1fc1h
1fa2 101f      djnz    1fc3h
1fa4 101f      djnz    1fc5h
1fa6 101f      djnz    1fc7h
1fa8 15        dec     d
1fa9 2002      jr      nz,1fadh
1fab 219d26    ld      hl,269dh
1fae ee25      xor     25h
1fb0 ae        xor     (hl)
1fb1 24        inc     h
1fb2 ce25      adc     a,25h
1fb4 be        cp      (hl)
1fb5 23        inc     hl
1fb6 9b        sbc     a,e
1fb7 226427    ld      (2764h),hl
1fba 65        ld      h,l
1fbb 27        daa     
1fbc 66        ld      h,(hl)
1fbd 27        daa     
1fbe 67        ld      h,a
1fbf 27        daa     
1fc0 101f      djnz    1fe1h
1fc2 101f      djnz    1fe3h
1fc4 101f      djnz    1fe5h
1fc6 101f      djnz    1fe7h
1fc8 101f      djnz    1fe9h
1fca 101f      djnz    1febh
1fcc 101f      djnz    1fedh
1fce 101f      djnz    1fefh
1fd0 101f      djnz    1ff1h
1fd2 101f      djnz    1ff3h
1fd4 101f      djnz    1ff5h
1fd6 101f      djnz    1ff7h
1fd8 68        ld      l,b
1fd9 27        daa     
1fda 2b        dec     hl
1fdb 2d        dec     l
1fdc 39        add     hl,sp
1fdd 2f        cpl     
1fde 02        ld      (bc),a
1fdf 32ff34    ld      (34ffh),a
1fe2 82        add     a,d
1fe3 35        dec     (hl)
1fe4 05        dec     b
1fe5 369d      ld      (hl),9dh
1fe7 363e      ld      (hl),3eh
1fe9 3ae83a    ld      a,(3ae8h)
1fec 92        sub     d
1fed 3b        dec     sp
1fee 93        sub     e
1fef 3b        dec     sp
1ff0 101f      djnz    2011h
1ff2 101f      djnz    2013h
1ff4 101f      djnz    2015h
1ff6 101f      djnz    2017h
1ff8 101f      djnz    2019h
1ffa 101f      djnz    201bh
1ffc 101f      djnz    201dh
1ffe 101f      djnz    201fh
2000 08        ex      af,af'
2001 05        dec     b
2002 99        sbc     a,c
2003 05        dec     b
2004 03        inc     bc
2005 08        ex      af,af'
2006 03        inc     bc
2007 95        sub     l
2008 05        dec     b
2009 03        inc     bc
200a 08        ex      af,af'
200b 069a      ld      b,9ah
200d 05        dec     b
200e 03        inc     bc
200f 08        ex      af,af'
2010 03        inc     bc
2011 95        sub     l
2012 05        dec     b
2013 03        inc     bc
2014 04        inc     b
2015 1802      jr      2019h
2017 90        sub     b
2018 00        nop     
2019 0c        inc     c
201a 24        inc     h
201b 07        rlca    
201c ff        rst     38h
201d ff        rst     38h
201e ff        rst     38h
201f 00        nop     
2020 ff        rst     38h
2021 55        ld      d,l
2022 1c        inc     e
2023 08        ex      af,af'
2024 0d        dec     c
2025 0a        ld      a,(bc)
2026 07        rlca    
2027 03        inc     bc
2028 0e16      ld      c,16h
202a 03        inc     bc
202b 02        ld      (bc),a
202c bb        cp      e
202d 2003      jr      nz,2032h
202f 03        inc     bc
2030 bb        cp      e
2031 2003      jr      nz,2036h
2033 019020    ld      bc,2090h
2036 03        inc     bc
2037 02        ld      (bc),a
2038 61        ld      h,c
2039 2003      jr      nz,203eh
203b 016e20    ld      bc,206eh
203e 03        inc     bc
203f 014620    ld      bc,2046h
2042 011520    ld      bc,2015h
2045 00        nop     
2046 91        sub     c
2047 08        ex      af,af'
2048 08        ex      af,af'
2049 91        sub     c
204a 07        rlca    
204b 019108    ld      bc,0891h
204e 08        ex      af,af'
204f 91        sub     c
2050 08        ex      af,af'
2051 08        ex      af,af'
2052 91        sub     c
2053 08        ex      af,af'
2054 1008      djnz    205eh
2056 0f        rrca    
2057 85        add     a,l
2058 07        rlca    
2059 018508    ld      bc,0885h
205c 08        ex      af,af'
205d 85        add     a,l
205e 08        ex      af,af'
205f 1004      djnz    2065h
2061 03        inc     bc
2062 016e20    ld      bc,206eh
2065 03        inc     bc
2066 01e620    ld      bc,20e6h
2069 03        inc     bc
206a 01c420    ld      bc,20c4h
206d 04        inc     b
206e 8f        adc     a,a
206f 08        ex      af,af'
2070 08        ex      af,af'
2071 8f        adc     a,a
2072 08        ex      af,af'
2073 08        ex      af,af'
2074 8f        adc     a,a
2075 08        ex      af,af'
2076 08        ex      af,af'
2077 8f        adc     a,a
2078 07        rlca    
2079 018f07    ld      bc,078fh
207c 018008    ld      bc,0880h
207f 00        nop     
2080 8f        adc     a,a
2081 07        rlca    
2082 018f08    ld      bc,088fh
2085 08        ex      af,af'
2086 8f        adc     a,a
2087 08        ex      af,af'
2088 08        ex      af,af'
2089 8f        adc     a,a
208a 07        rlca    
208b 018f07    ld      bc,078fh
208e 01048a    ld      bc,8a04h
2091 08        ex      af,af'
2092 08        ex      af,af'
2093 8a        adc     a,d
2094 08        ex      af,af'
2095 08        ex      af,af'
2096 8a        adc     a,d
2097 0602      ld      b,02h
2099 88        adc     a,b
209a 0e02      ld      c,02h
209c 8a        adc     a,d
209d 08        ex      af,af'
209e 08        ex      af,af'
209f 8a        adc     a,d
20a0 05        dec     b
20a1 03        inc     bc
20a2 8a        adc     a,d
20a3 08        ex      af,af'
20a4 08        ex      af,af'
20a5 8a        adc     a,d
20a6 05        dec     b
20a7 03        inc     bc
20a8 8d        adc     a,l
20a9 07        rlca    
20aa 01880e    ld      bc,0e88h
20ad 02        ld      (bc),a
20ae 8a        adc     a,d
20af 1808      jr      20b9h
20b1 8a        adc     a,d
20b2 07        rlca    
20b3 018810    ld      bc,1088h
20b6 08        ex      af,af'
20b7 8a        adc     a,d
20b8 1030      djnz    20eah
20ba 04        inc     b
20bb 03        inc     bc
20bc 01e620    ld      bc,20e6h
20bf 03        inc     bc
20c0 01c420    ld      bc,20c4h
20c3 04        inc     b
20c4 8a        adc     a,d
20c5 08        ex      af,af'
20c6 08        ex      af,af'
20c7 8a        adc     a,d
20c8 08        ex      af,af'
20c9 08        ex      af,af'
20ca 8a        adc     a,d
20cb 0602      ld      b,02h
20cd 88        adc     a,b
20ce 0e02      ld      c,02h
20d0 8a        adc     a,d
20d1 08        ex      af,af'
20d2 08        ex      af,af'
20d3 8a        adc     a,d
20d4 05        dec     b
20d5 03        inc     bc
20d6 8a        adc     a,d
20d7 08        ex      af,af'
20d8 08        ex      af,af'
20d9 8a        adc     a,d
20da 05        dec     b
20db 03        inc     bc
20dc 8d        adc     a,l
20dd 07        rlca    
20de 018a07    ld      bc,078ah
20e1 018807    ld      bc,0788h
20e4 01048a    ld      bc,8a04h
20e7 08        ex      af,af'
20e8 08        ex      af,af'
20e9 8a        adc     a,d
20ea 08        ex      af,af'
20eb 08        ex      af,af'
20ec 8a        adc     a,d
20ed 0602      ld      b,02h
20ef 88        adc     a,b
20f0 0e02      ld      c,02h
20f2 8a        adc     a,d
20f3 08        ex      af,af'
20f4 08        ex      af,af'
20f5 8a        adc     a,d
20f6 05        dec     b
20f7 03        inc     bc
20f8 8a        adc     a,d
20f9 08        ex      af,af'
20fa 08        ex      af,af'
20fb 8a        adc     a,d
20fc 05        dec     b
20fd 03        inc     bc
20fe 8d        adc     a,l
20ff 14        inc     d
2100 04        inc     b
2101 04        inc     b
2102 1803      jr      2107h
2104 01f621    ld      bc,21f6h
2107 03        inc     bc
2108 07        rlca    
2109 42        ld      b,d
210a 220301    ld      (0103h),hl
210d 93        sub     e
210e 210307    ld      hl,0703h
2111 42        ld      b,d
2112 220301    ld      (0103h),hl
2115 1b        dec     de
2116 210102    ld      hl,0201h
2119 210002    ld      hl,0200h
211c 1e00      ld      e,00h
211e 0c        inc     c
211f 24        inc     h
2120 08        ex      af,af'
2121 0f        rrca    
2122 07        rlca    
2123 ff        rst     38h
2124 ff        rst     38h
2125 00        nop     
2126 00        nop     
2127 ff        rst     38h
2128 00        nop     
2129 010909    ld      bc,0909h
212c 08        ex      af,af'
212d 0f        rrca    
212e 8e        adc     a,(hl)
212f 08        ex      af,af'
2130 00        nop     
2131 09        add     hl,bc
2132 05        dec     b
2133 08        ex      af,af'
2134 0a        ld      a,(bc)
2135 8e        adc     a,(hl)
2136 08        ex      af,af'
2137 00        nop     
2138 09        add     hl,bc
2139 09        add     hl,bc
213a 08        ex      af,af'
213b 0f        rrca    
213c 8e        adc     a,(hl)
213d 08        ex      af,af'
213e 00        nop     
213f 8e        adc     a,(hl)
2140 08        ex      af,af'
2141 00        nop     
2142 09        add     hl,bc
2143 05        dec     b
2144 08        ex      af,af'
2145 0a        ld      a,(bc)
2146 8e        adc     a,(hl)
2147 08        ex      af,af'
2148 00        nop     
2149 09        add     hl,bc
214a 09        add     hl,bc
214b 08        ex      af,af'
214c 0f        rrca    
214d 8e        adc     a,(hl)
214e 08        ex      af,af'
214f 00        nop     
2150 09        add     hl,bc
2151 05        dec     b
2152 08        ex      af,af'
2153 0a        ld      a,(bc)
2154 8e        adc     a,(hl)
2155 08        ex      af,af'
2156 00        nop     
2157 09        add     hl,bc
2158 09        add     hl,bc
2159 08        ex      af,af'
215a 0f        rrca    
215b 8e        adc     a,(hl)
215c 08        ex      af,af'
215d 00        nop     
215e 09        add     hl,bc
215f 05        dec     b
2160 08        ex      af,af'
2161 0a        ld      a,(bc)
2162 8e        adc     a,(hl)
2163 08        ex      af,af'
2164 00        nop     
2165 09        add     hl,bc
2166 0d        dec     c
2167 08        ex      af,af'
2168 05        dec     b
2169 8e        adc     a,(hl)
216a 08        ex      af,af'
216b 00        nop     
216c 09        add     hl,bc
216d 09        add     hl,bc
216e 08        ex      af,af'
216f 0f        rrca    
2170 8e        adc     a,(hl)
2171 08        ex      af,af'
2172 00        nop     
2173 8e        adc     a,(hl)
2174 08        ex      af,af'
2175 00        nop     
2176 09        add     hl,bc
2177 05        dec     b
2178 08        ex      af,af'
2179 0a        ld      a,(bc)
217a 8e        adc     a,(hl)
217b 08        ex      af,af'
217c 00        nop     
217d 09        add     hl,bc
217e 09        add     hl,bc
217f 08        ex      af,af'
2180 0f        rrca    
2181 8e        adc     a,(hl)
2182 08        ex      af,af'
2183 00        nop     
2184 09        add     hl,bc
2185 04        inc     b
2186 08        ex      af,af'
2187 0a        ld      a,(bc)
2188 8e        adc     a,(hl)
2189 08        ex      af,af'
218a 00        nop     
218b 09        add     hl,bc
218c 0f        rrca    
218d 08        ex      af,af'
218e 08        ex      af,af'
218f 8e        adc     a,(hl)
2190 08        ex      af,af'
2191 00        nop     
2192 04        inc     b
2193 02        ld      (bc),a
2194 1e00      ld      e,00h
2196 0c        inc     c
2197 24        inc     h
2198 08        ex      af,af'
2199 0f        rrca    
219a 07        rlca    
219b ff        rst     38h
219c ff        rst     38h
219d 00        nop     
219e 00        nop     
219f ff        rst     38h
21a0 00        nop     
21a1 010909    ld      bc,0909h
21a4 08        ex      af,af'
21a5 0f        rrca    
21a6 8e        adc     a,(hl)
21a7 08        ex      af,af'
21a8 00        nop     
21a9 09        add     hl,bc
21aa 05        dec     b
21ab 08        ex      af,af'
21ac 0c        inc     c
21ad 8e        adc     a,(hl)
21ae 08        ex      af,af'
21af 00        nop     
21b0 09        add     hl,bc
21b1 0c        inc     c
21b2 08        ex      af,af'
21b3 08        ex      af,af'
21b4 8e        adc     a,(hl)
21b5 08        ex      af,af'
21b6 00        nop     
21b7 09        add     hl,bc
21b8 010805    ld      bc,0508h
21bb 8e        adc     a,(hl)
21bc 08        ex      af,af'
21bd 00        nop     
21be 09        add     hl,bc
21bf 09        add     hl,bc
21c0 08        ex      af,af'
21c1 0f        rrca    
21c2 8e        adc     a,(hl)
21c3 08        ex      af,af'
21c4 00        nop     
21c5 8e        adc     a,(hl)
21c6 08        ex      af,af'
21c7 00        nop     
21c8 09        add     hl,bc
21c9 03        inc     bc
21ca 08        ex      af,af'
21cb 0c        inc     c
21cc 8e        adc     a,(hl)
21cd 08        ex      af,af'
21ce 00        nop     
21cf 09        add     hl,bc
21d0 0d        dec     c
21d1 08        ex      af,af'
21d2 08        ex      af,af'
21d3 8e        adc     a,(hl)
21d4 08        ex      af,af'
21d5 00        nop     
21d6 09        add     hl,bc
21d7 09        add     hl,bc
21d8 08        ex      af,af'
21d9 0f        rrca    
21da 8e        adc     a,(hl)
21db 08        ex      af,af'
21dc 00        nop     
21dd 09        add     hl,bc
21de 05        dec     b
21df 08        ex      af,af'
21e0 0c        inc     c
21e1 8e        adc     a,(hl)
21e2 08        ex      af,af'
21e3 00        nop     
21e4 09        add     hl,bc
21e5 0c        inc     c
21e6 08        ex      af,af'
21e7 08        ex      af,af'
21e8 8e        adc     a,(hl)
21e9 08        ex      af,af'
21ea 00        nop     
21eb 09        add     hl,bc
21ec 010805    ld      bc,0508h
21ef 8e        adc     a,(hl)
21f0 08        ex      af,af'
21f1 00        nop     
21f2 80        add     a,b
21f3 2000      jr      nz,21f5h
21f5 04        inc     b
21f6 80        add     a,b
21f7 80        add     a,b
21f8 00        nop     
21f9 80        add     a,b
21fa 80        add     a,b
21fb 00        nop     
21fc 80        add     a,b
21fd 80        add     a,b
21fe 00        nop     
21ff 80        add     a,b
2200 3800      jr      c,2202h
2202 02        ld      (bc),a
2203 1e00      ld      e,00h
2205 0c        inc     c
2206 24        inc     h
2207 08        ex      af,af'
2208 0f        rrca    
2209 07        rlca    
220a ff        rst     38h
220b ff        rst     38h
220c 00        nop     
220d 00        nop     
220e ff        rst     38h
220f 00        nop     
2210 010909    ld      bc,0909h
2213 08        ex      af,af'
2214 0f        rrca    
2215 09        add     hl,bc
2216 0b        dec     bc
2217 8f        adc     a,a
2218 1000      djnz    221ah
221a 8f        adc     a,a
221b 08        ex      af,af'
221c 00        nop     
221d 0c        inc     c
221e 1802      jr      2222h
2220 5e        ld      e,(hl)
2221 00        nop     
2222 07        rlca    
2223 ff        rst     38h
2224 ff        rst     38h
2225 2000      jr      nz,2227h
2227 e0        ret     po

2228 e0        ret     po

2229 00        nop     
222a 08        ex      af,af'
222b 0f        rrca    
222c 09        add     hl,bc
222d 05        dec     b
222e 95        sub     l
222f 08        ex      af,af'
2230 00        nop     
2231 95        sub     l
2232 08        ex      af,af'
2233 00        nop     
2234 09        add     hl,bc
2235 03        inc     bc
2236 95        sub     l
2237 1000      djnz    2239h
2239 09        add     hl,bc
223a 0d        dec     c
223b 8f        adc     a,a
223c 08        ex      af,af'
223d 00        nop     
223e 8f        adc     a,a
223f 08        ex      af,af'
2240 00        nop     
2241 04        inc     b
2242 02        ld      (bc),a
2243 93        sub     e
2244 00        nop     
2245 0c        inc     c
2246 24        inc     h
2247 08        ex      af,af'
2248 0f        rrca    
2249 07        rlca    
224a ff        rst     38h
224b ff        rst     38h
224c 0100ff    ld      bc,0ff00h
224f 00        nop     
2250 110908    ld      de,0809h
2253 8d        adc     a,l
2254 08        ex      af,af'
2255 1802      jr      2259h
2257 1e00      ld      e,00h
2259 0c        inc     c
225a 24        inc     h
225b 08        ex      af,af'
225c 0f        rrca    
225d 07        rlca    
225e ff        rst     38h
225f ff        rst     38h
2260 00        nop     
2261 00        nop     
2262 ff        rst     38h
2263 00        nop     
2264 010909    ld      bc,0909h
2267 8e        adc     a,(hl)
2268 1602      ld      d,02h
226a 09        add     hl,bc
226b 07        rlca    
226c 90        sub     b
226d 0f        rrca    
226e 010293    ld      bc,9302h
2271 00        nop     
2272 0c        inc     c
2273 24        inc     h
2274 08        ex      af,af'
2275 0f        rrca    
2276 07        rlca    
2277 ff        rst     38h
2278 ff        rst     38h
2279 0100ff    ld      bc,0ff00h
227c 00        nop     
227d 110908    ld      de,0809h
2280 8d        adc     a,l
2281 07        rlca    
2282 018d08    ld      bc,088dh
2285 08        ex      af,af'
2286 02        ld      (bc),a
2287 1e00      ld      e,00h
2289 0c        inc     c
228a 24        inc     h
228b 08        ex      af,af'
228c 0f        rrca    
228d 07        rlca    
228e ff        rst     38h
228f ff        rst     38h
2290 00        nop     
2291 00        nop     
2292 ff        rst     38h
2293 00        nop     
2294 010909    ld      bc,0909h
2297 8e        adc     a,(hl)
2298 1808      jr      22a2h
229a 04        inc     b
229b 180c      jr      22a9h
229d 24        inc     h
229e 02        ld      (bc),a
229f 65        ld      h,l
22a0 00        nop     
22a1 07        rlca    
22a2 71        ld      (hl),c
22a3 1c        inc     e
22a4 0100ff    ld      bc,0ff00h
22a7 3a0308    ld      a,(0803h)
22aa 0609      ld      b,09h
22ac 07        rlca    
22ad 03        inc     bc
22ae 02        ld      (bc),a
22af b1        or      c
22b0 23        inc     hl
22b1 03        inc     bc
22b2 03        inc     bc
22b3 b1        or      c
22b4 23        inc     hl
22b5 03        inc     bc
22b6 016e23    ld      bc,236eh
22b9 03        inc     bc
22ba 02        ld      (bc),a
22bb 25        dec     h
22bc 23        inc     hl
22bd 02        ld      (bc),a
22be 50        ld      d,b
22bf 00        nop     
22c0 0c        inc     c
22c1 1807      jr      22cah
22c3 ff        rst     38h
22c4 ff        rst     38h
22c5 33        inc     sp
22c6 03        inc     bc
22c7 d0        ret     nc

22c8 6c        ld      l,h
22c9 04        inc     b
22ca 08        ex      af,af'
22cb 0603      ld      b,03h
22cd 014c23    ld      bc,234ch
22d0 03        inc     bc
22d1 01d822    ld      bc,22d8h
22d4 019b22    ld      bc,229bh
22d7 00        nop     
22d8 08        ex      af,af'
22d9 07        rlca    
22da a4        and     h
22db 08        ex      af,af'
22dc 00        nop     
22dd 08        ex      af,af'
22de 04        inc     b
22df a4        and     h
22e0 08        ex      af,af'
22e1 00        nop     
22e2 08        ex      af,af'
22e3 07        rlca    
22e4 a4        and     h
22e5 08        ex      af,af'
22e6 00        nop     
22e7 a4        and     h
22e8 08        ex      af,af'
22e9 00        nop     
22ea 08        ex      af,af'
22eb 04        inc     b
22ec a4        and     h
22ed 08        ex      af,af'
22ee 00        nop     
22ef 08        ex      af,af'
22f0 07        rlca    
22f1 a5        and     l
22f2 08        ex      af,af'
22f3 00        nop     
22f4 08        ex      af,af'
22f5 04        inc     b
22f6 a5        and     l
22f7 08        ex      af,af'
22f8 00        nop     
22f9 08        ex      af,af'
22fa 07        rlca    
22fb a7        and     a
22fc 08        ex      af,af'
22fd 00        nop     
22fe 08        ex      af,af'
22ff 04        inc     b
2300 a7        and     a
2301 08        ex      af,af'
2302 00        nop     
2303 08        ex      af,af'
2304 02        ld      (bc),a
2305 a7        and     a
2306 08        ex      af,af'
2307 00        nop     
2308 08        ex      af,af'
2309 07        rlca    
230a a7        and     a
230b 08        ex      af,af'
230c 00        nop     
230d a7        and     a
230e 08        ex      af,af'
230f 00        nop     
2310 08        ex      af,af'
2311 04        inc     b
2312 a7        and     a
2313 08        ex      af,af'
2314 00        nop     
2315 08        ex      af,af'
2316 07        rlca    
2317 a7        and     a
2318 08        ex      af,af'
2319 00        nop     
231a 08        ex      af,af'
231b 04        inc     b
231c a7        and     a
231d 08        ex      af,af'
231e 00        nop     
231f 08        ex      af,af'
2320 02        ld      (bc),a
2321 a7        and     a
2322 08        ex      af,af'
2323 00        nop     
2324 04        inc     b
2325 02        ld      (bc),a
2326 50        ld      d,b
2327 00        nop     
2328 0c        inc     c
2329 1807      jr      2332h
232b ff        rst     38h
232c ff        rst     38h
232d 33        inc     sp
232e 03        inc     bc
232f d0        ret     nc

2330 6c        ld      l,h
2331 04        inc     b
2332 08        ex      af,af'
2333 0603      ld      b,03h
2335 014c23    ld      bc,234ch
2338 0c        inc     c
2339 24        inc     h
233a 02        ld      (bc),a
233b 65        ld      h,l
233c 00        nop     
233d 07        rlca    
233e 71        ld      (hl),c
233f 1c        inc     e
2340 0100ff    ld      bc,0ff00h
2343 3a0308    ld      a,(0803h)
2346 0603      ld      b,03h
2348 01b123    ld      bc,23b1h
234b 04        inc     b
234c a2        and     d
234d 0602      ld      b,02h
234f a5        and     l
2350 0602      ld      b,02h
2352 a5        and     l
2353 08        ex      af,af'
2354 08        ex      af,af'
2355 a2        and     d
2356 08        ex      af,af'
2357 08        ex      af,af'
2358 a2        and     d
2359 0602      ld      b,02h
235b a2        and     d
235c 08        ex      af,af'
235d 08        ex      af,af'
235e a5        and     l
235f 0602      ld      b,02h
2361 a5        and     l
2362 08        ex      af,af'
2363 08        ex      af,af'
2364 a2        and     d
2365 08        ex      af,af'
2366 08        ex      af,af'
2367 a2        and     d
2368 0602      ld      b,02h
236a a2        and     d
236b 0602      ld      b,02h
236d 04        inc     b
236e 9d        sbc     a,l
236f 3800      jr      c,2371h
2371 9d        sbc     a,l
2372 48        ld      c,b
2373 00        nop     
2374 9d        sbc     a,l
2375 2800      jr      z,2377h
2377 9b        sbc     a,e
2378 1800      jr      237ah
237a 9d        sbc     a,l
237b 1000      djnz    237dh
237d 02        ld      (bc),a
237e 50        ld      d,b
237f 00        nop     
2380 0c        inc     c
2381 1807      jr      238ah
2383 ff        rst     38h
2384 ff        rst     38h
2385 33        inc     sp
2386 03        inc     bc
2387 d0        ret     nc

2388 6c        ld      l,h
2389 04        inc     b
238a 08        ex      af,af'
238b 07        rlca    
238c 96        sub     (hl)
238d 04        inc     b
238e 00        nop     
238f 97        sub     a
2390 04        inc     b
2391 00        nop     
2392 95        sub     l
2393 04        inc     b
2394 00        nop     
2395 99        sbc     a,c
2396 04        inc     b
2397 00        nop     
2398 9a        sbc     a,d
2399 04        inc     b
239a 00        nop     
239b 9b        sbc     a,e
239c 04        inc     b
239d 00        nop     
239e 9c        sbc     a,h
239f 04        inc     b
23a0 00        nop     
23a1 9d        sbc     a,l
23a2 04        inc     b
23a3 00        nop     
23a4 9e        sbc     a,(hl)
23a5 04        inc     b
23a6 00        nop     
23a7 9f        sbc     a,a
23a8 04        inc     b
23a9 00        nop     
23aa a0        and     b
23ab 04        inc     b
23ac 00        nop     
23ad a1        and     c
23ae 04        inc     b
23af 00        nop     
23b0 04        inc     b
23b1 9d        sbc     a,l
23b2 3800      jr      c,23b4h
23b4 9d        sbc     a,l
23b5 48        ld      c,b
23b6 00        nop     
23b7 9b        sbc     a,e
23b8 3800      jr      c,23bah
23ba 9b        sbc     a,e
23bb 48        ld      c,b
23bc 00        nop     
23bd 04        inc     b
23be 180c      jr      23cch
23c0 24        inc     h
23c1 02        ld      (bc),a
23c2 65        ld      h,l
23c3 00        nop     
23c4 07        rlca    
23c5 71        ld      (hl),c
23c6 1c        inc     e
23c7 0100ff    ld      bc,0ff00h
23ca 3a0308    ld      a,(0803h)
23cd 0609      ld      b,09h
23cf 0b        dec     bc
23d0 03        inc     bc
23d1 02        ld      (bc),a
23d2 a1        and     c
23d3 24        inc     h
23d4 03        inc     bc
23d5 03        inc     bc
23d6 a1        and     c
23d7 24        inc     h
23d8 03        inc     bc
23d9 019124    ld      bc,2491h
23dc 03        inc     bc
23dd 02        ld      (bc),a
23de 48        ld      c,b
23df 24        inc     h
23e0 02        ld      (bc),a
23e1 50        ld      d,b
23e2 00        nop     
23e3 0c        inc     c
23e4 1807      jr      23edh
23e6 ff        rst     38h
23e7 ff        rst     38h
23e8 33        inc     sp
23e9 03        inc     bc
23ea d0        ret     nc

23eb 6c        ld      l,h
23ec 04        inc     b
23ed 08        ex      af,af'
23ee 0603      ld      b,03h
23f0 016f24    ld      bc,246fh
23f3 03        inc     bc
23f4 01fb23    ld      bc,23fbh
23f7 01be23    ld      bc,23beh
23fa 00        nop     
23fb 08        ex      af,af'
23fc 07        rlca    
23fd a1        and     c
23fe 08        ex      af,af'
23ff 00        nop     
2400 08        ex      af,af'
2401 04        inc     b
2402 a1        and     c
2403 08        ex      af,af'
2404 00        nop     
2405 08        ex      af,af'
2406 07        rlca    
2407 a1        and     c
2408 08        ex      af,af'
2409 00        nop     
240a a1        and     c
240b 08        ex      af,af'
240c 00        nop     
240d 08        ex      af,af'
240e 04        inc     b
240f a1        and     c
2410 08        ex      af,af'
2411 00        nop     
2412 08        ex      af,af'
2413 07        rlca    
2414 a1        and     c
2415 08        ex      af,af'
2416 00        nop     
2417 08        ex      af,af'
2418 04        inc     b
2419 a1        and     c
241a 08        ex      af,af'
241b 00        nop     
241c 08        ex      af,af'
241d 07        rlca    
241e a4        and     h
241f 08        ex      af,af'
2420 00        nop     
2421 08        ex      af,af'
2422 04        inc     b
2423 a4        and     h
2424 08        ex      af,af'
2425 00        nop     
2426 08        ex      af,af'
2427 02        ld      (bc),a
2428 a4        and     h
2429 08        ex      af,af'
242a 00        nop     
242b 08        ex      af,af'
242c 07        rlca    
242d a4        and     h
242e 08        ex      af,af'
242f 00        nop     
2430 a4        and     h
2431 08        ex      af,af'
2432 00        nop     
2433 08        ex      af,af'
2434 04        inc     b
2435 a4        and     h
2436 08        ex      af,af'
2437 00        nop     
2438 08        ex      af,af'
2439 07        rlca    
243a a4        and     h
243b 08        ex      af,af'
243c 00        nop     
243d 08        ex      af,af'
243e 04        inc     b
243f a4        and     h
2440 08        ex      af,af'
2441 00        nop     
2442 08        ex      af,af'
2443 02        ld      (bc),a
2444 a4        and     h
2445 08        ex      af,af'
2446 00        nop     
2447 04        inc     b
2448 02        ld      (bc),a
2449 50        ld      d,b
244a 00        nop     
244b 0c        inc     c
244c 1807      jr      2455h
244e ff        rst     38h
244f ff        rst     38h
2450 33        inc     sp
2451 03        inc     bc
2452 d0        ret     nc

2453 6c        ld      l,h
2454 04        inc     b
2455 08        ex      af,af'
2456 0603      ld      b,03h
2458 016f24    ld      bc,246fh
245b 0c        inc     c
245c 24        inc     h
245d 02        ld      (bc),a
245e 65        ld      h,l
245f 00        nop     
2460 07        rlca    
2461 71        ld      (hl),c
2462 1c        inc     e
2463 0100ff    ld      bc,0ff00h
2466 3a0308    ld      a,(0803h)
2469 0603      ld      b,03h
246b 01a124    ld      bc,24a1h
246e 04        inc     b
246f 9e        sbc     a,(hl)
2470 0602      ld      b,02h
2472 a2        and     d
2473 0602      ld      b,02h
2475 a2        and     d
2476 08        ex      af,af'
2477 08        ex      af,af'
2478 9e        sbc     a,(hl)
2479 08        ex      af,af'
247a 08        ex      af,af'
247b 9e        sbc     a,(hl)
247c 0602      ld      b,02h
247e 9e        sbc     a,(hl)
247f 08        ex      af,af'
2480 08        ex      af,af'
2481 a2        and     d
2482 0602      ld      b,02h
2484 a2        and     d
2485 08        ex      af,af'
2486 08        ex      af,af'
2487 9e        sbc     a,(hl)
2488 08        ex      af,af'
2489 08        ex      af,af'
248a 9e        sbc     a,(hl)
248b 0602      ld      b,02h
248d 9e        sbc     a,(hl)
248e 0602      ld      b,02h
2490 04        inc     b
2491 99        sbc     a,c
2492 3800      jr      c,2494h
2494 99        sbc     a,c
2495 48        ld      c,b
2496 00        nop     
2497 99        sbc     a,c
2498 2800      jr      z,249ah
249a 98        sbc     a,b
249b 1800      jr      249dh
249d 99        sbc     a,c
249e 1030      djnz    24d0h
24a0 04        inc     b
24a1 99        sbc     a,c
24a2 3800      jr      c,24a4h
24a4 99        sbc     a,c
24a5 48        ld      c,b
24a6 00        nop     
24a7 98        sbc     a,b
24a8 3800      jr      c,24aah
24aa 96        sub     (hl)
24ab 48        ld      c,b
24ac 00        nop     
24ad 04        inc     b
24ae 180c      jr      24bch
24b0 24        inc     h
24b1 02        ld      (bc),a
24b2 65        ld      h,l
24b3 00        nop     
24b4 07        rlca    
24b5 71        ld      (hl),c
24b6 1c        inc     e
24b7 0100ff    ld      bc,0ff00h
24ba 3a0308    ld      a,(0803h)
24bd 0609      ld      b,09h
24bf 02        ld      (bc),a
24c0 03        inc     bc
24c1 02        ld      (bc),a
24c2 c1        pop     bc
24c3 25        dec     h
24c4 03        inc     bc
24c5 03        inc     bc
24c6 c1        pop     bc
24c7 25        dec     h
24c8 03        inc     bc
24c9 018125    ld      bc,2581h
24cc 03        inc     bc
24cd 02        ld      (bc),a
24ce 3825      jr      c,24f5h
24d0 02        ld      (bc),a
24d1 50        ld      d,b
24d2 00        nop     
24d3 0c        inc     c
24d4 1807      jr      24ddh
24d6 ff        rst     38h
24d7 ff        rst     38h
24d8 33        inc     sp
24d9 03        inc     bc
24da d0        ret     nc

24db 6c        ld      l,h
24dc 04        inc     b
24dd 08        ex      af,af'
24de 0603      ld      b,03h
24e0 015f25    ld      bc,255fh
24e3 03        inc     bc
24e4 01eb24    ld      bc,24ebh
24e7 01ae24    ld      bc,24aeh
24ea 00        nop     
24eb 08        ex      af,af'
24ec 07        rlca    
24ed 9d        sbc     a,l
24ee 08        ex      af,af'
24ef 00        nop     
24f0 08        ex      af,af'
24f1 04        inc     b
24f2 9d        sbc     a,l
24f3 08        ex      af,af'
24f4 00        nop     
24f5 08        ex      af,af'
24f6 07        rlca    
24f7 9d        sbc     a,l
24f8 08        ex      af,af'
24f9 00        nop     
24fa 9d        sbc     a,l
24fb 08        ex      af,af'
24fc 00        nop     
24fd 08        ex      af,af'
24fe 04        inc     b
24ff 9d        sbc     a,l
2500 08        ex      af,af'
2501 00        nop     
2502 08        ex      af,af'
2503 07        rlca    
2504 9d        sbc     a,l
2505 08        ex      af,af'
2506 00        nop     
2507 08        ex      af,af'
2508 04        inc     b
2509 9d        sbc     a,l
250a 08        ex      af,af'
250b 00        nop     
250c 08        ex      af,af'
250d 07        rlca    
250e a1        and     c
250f 08        ex      af,af'
2510 00        nop     
2511 08        ex      af,af'
2512 04        inc     b
2513 a1        and     c
2514 08        ex      af,af'
2515 00        nop     
2516 08        ex      af,af'
2517 02        ld      (bc),a
2518 a1        and     c
2519 08        ex      af,af'
251a 00        nop     
251b 08        ex      af,af'
251c 07        rlca    
251d a1        and     c
251e 08        ex      af,af'
251f 00        nop     
2520 a1        and     c
2521 08        ex      af,af'
2522 00        nop     
2523 08        ex      af,af'
2524 04        inc     b
2525 a1        and     c
2526 08        ex      af,af'
2527 00        nop     
2528 08        ex      af,af'
2529 07        rlca    
252a a1        and     c
252b 08        ex      af,af'
252c 00        nop     
252d 08        ex      af,af'
252e 04        inc     b
252f a1        and     c
2530 08        ex      af,af'
2531 00        nop     
2532 08        ex      af,af'
2533 02        ld      (bc),a
2534 a1        and     c
2535 08        ex      af,af'
2536 00        nop     
2537 04        inc     b
2538 02        ld      (bc),a
2539 50        ld      d,b
253a 00        nop     
253b 0c        inc     c
253c 1807      jr      2545h
253e ff        rst     38h
253f ff        rst     38h
2540 33        inc     sp
2541 03        inc     bc
2542 d0        ret     nc

2543 6c        ld      l,h
2544 04        inc     b
2545 08        ex      af,af'
2546 0603      ld      b,03h
2548 015f25    ld      bc,255fh
254b 0c        inc     c
254c 24        inc     h
254d 02        ld      (bc),a
254e 65        ld      h,l
254f 00        nop     
2550 07        rlca    
2551 71        ld      (hl),c
2552 1c        inc     e
2553 0100ff    ld      bc,0ff00h
2556 3a0308    ld      a,(0803h)
2559 0603      ld      b,03h
255b 01c125    ld      bc,25c1h
255e 04        inc     b
255f 9b        sbc     a,e
2560 0602      ld      b,02h
2562 9e        sbc     a,(hl)
2563 0602      ld      b,02h
2565 9e        sbc     a,(hl)
2566 08        ex      af,af'
2567 08        ex      af,af'
2568 9b        sbc     a,e
2569 08        ex      af,af'
256a 08        ex      af,af'
256b 9b        sbc     a,e
256c 0602      ld      b,02h
256e 9b        sbc     a,e
256f 08        ex      af,af'
2570 08        ex      af,af'
2571 9e        sbc     a,(hl)
2572 0602      ld      b,02h
2574 9e        sbc     a,(hl)
2575 08        ex      af,af'
2576 08        ex      af,af'
2577 9b        sbc     a,e
2578 08        ex      af,af'
2579 08        ex      af,af'
257a 9b        sbc     a,e
257b 0602      ld      b,02h
257d 9b        sbc     a,e
257e 0602      ld      b,02h
2580 04        inc     b
2581 96        sub     (hl)
2582 3800      jr      c,2584h
2584 94        sub     h
2585 48        ld      c,b
2586 00        nop     
2587 96        sub     (hl)
2588 2800      jr      z,258ah
258a 94        sub     h
258b 1800      jr      258dh
258d 96        sub     (hl)
258e 1000      djnz    2590h
2590 02        ld      (bc),a
2591 50        ld      d,b
2592 00        nop     
2593 0c        inc     c
2594 1807      jr      259dh
2596 ff        rst     38h
2597 ff        rst     38h
2598 33        inc     sp
2599 03        inc     bc
259a d0        ret     nc

259b 6c        ld      l,h
259c 04        inc     b
259d 08        ex      af,af'
259e 03        inc     bc
259f 80        add     a,b
25a0 09        add     hl,bc
25a1 00        nop     
25a2 96        sub     (hl)
25a3 04        inc     b
25a4 00        nop     
25a5 97        sub     a
25a6 04        inc     b
25a7 00        nop     
25a8 95        sub     l
25a9 04        inc     b
25aa 00        nop     
25ab 99        sbc     a,c
25ac 04        inc     b
25ad 00        nop     
25ae 9a        sbc     a,d
25af 04        inc     b
25b0 00        nop     
25b1 9b        sbc     a,e
25b2 04        inc     b
25b3 00        nop     
25b4 9c        sbc     a,h
25b5 04        inc     b
25b6 00        nop     
25b7 9d        sbc     a,l
25b8 04        inc     b
25b9 00        nop     
25ba 9e        sbc     a,(hl)
25bb 04        inc     b
25bc 00        nop     
25bd 9f        sbc     a,a
25be 03        inc     bc
25bf 00        nop     
25c0 04        inc     b
25c1 96        sub     (hl)
25c2 3800      jr      c,25c4h
25c4 94        sub     h
25c5 48        ld      c,b
25c6 00        nop     
25c7 94        sub     h
25c8 3800      jr      c,25cah
25ca 93        sub     e
25cb 48        ld      c,b
25cc 00        nop     
25cd 04        inc     b
25ce 1802      jr      25d2h
25d0 97        sub     a
25d1 00        nop     
25d2 0c        inc     c
25d3 1807      jr      25dch
25d5 ff        rst     38h
25d6 ff        rst     38h
25d7 2000      jr      nz,25d9h
25d9 e0        ret     po

25da 00        nop     
25db e0        ret     po

25dc 09        add     hl,bc
25dd 02        ld      (bc),a
25de 03        inc     bc
25df 1000      djnz    25e1h
25e1 2003      jr      nz,25e6h
25e3 2000      jr      nz,25e5h
25e5 2003      jr      nz,25eah
25e7 2000      jr      nz,25e9h
25e9 2001      jr      nz,25ech
25eb ce25      adc     a,25h
25ed 00        nop     
25ee 1803      jr      25f3h
25f0 04        inc     b
25f1 39        add     hl,sp
25f2 2603      ld      h,03h
25f4 03        inc     bc
25f5 322680    ld      (8026h),a
25f8 80        add     a,b
25f9 00        nop     
25fa 80        add     a,b
25fb 57        ld      d,a
25fc 00        nop     
25fd 02        ld      (bc),a
25fe 2c        inc     l
25ff 00        nop     
2600 0c        inc     c
2601 24        inc     h
2602 07        rlca    
2603 ff        rst     38h
2604 ff        rst     38h
2605 0100ff    ld      bc,0ff00h
2608 0f        rrca    
2609 00        nop     
260a 09        add     hl,bc
260b 0f        rrca    
260c 08        ex      af,af'
260d 07        rlca    
260e 12        ld      (de),a
260f 00        nop     
2610 09        add     hl,bc
2611 2c        inc     l
2612 1600      ld      d,00h
2614 09        add     hl,bc
2615 08        ex      af,af'
2616 89        adc     a,c
2617 29        add     hl,hl
2618 00        nop     
2619 1b        dec     de
261a 03        inc     bc
261b 013926    ld      bc,2639h
261e 03        inc     bc
261f 013226    ld      bc,2632h
2622 03        inc     bc
2623 013926    ld      bc,2639h
2626 03        inc     bc
2627 013226    ld      bc,2632h
262a 03        inc     bc
262b 02        ld      (bc),a
262c 39        add     hl,sp
262d 2601      ld      h,01h
262f ee25      xor     25h
2631 00        nop     
2632 80        add     a,b
2633 80        add     a,b
2634 00        nop     
2635 80        add     a,b
2636 80        add     a,b
2637 00        nop     
2638 04        inc     b
2639 02        ld      (bc),a
263a 95        sub     l
263b 00        nop     
263c 0c        inc     c
263d 1807      jr      2646h
263f ff        rst     38h
2640 ff        rst     38h
2641 2000      jr      nz,2643h
2643 e0        ret     po

2644 ee0e      xor     0eh
2646 80        add     a,b
2647 1000      djnz    2649h
2649 08        ex      af,af'
264a 09        add     hl,bc
264b 09        add     hl,bc
264c 019f05    ld      bc,059fh
264f 03        inc     bc
2650 9f        sbc     a,a
2651 05        dec     b
2652 03        inc     bc
2653 9f        sbc     a,a
2654 05        dec     b
2655 03        inc     bc
2656 9f        sbc     a,a
2657 05        dec     b
2658 03        inc     bc
2659 08        ex      af,af'
265a 05        dec     b
265b 09        add     hl,bc
265c 0d        dec     c
265d 9f        sbc     a,a
265e 05        dec     b
265f 03        inc     bc
2660 08        ex      af,af'
2661 09        add     hl,bc
2662 09        add     hl,bc
2663 019f05    ld      bc,059fh
2666 03        inc     bc
2667 08        ex      af,af'
2668 05        dec     b
2669 09        add     hl,bc
266a 0d        dec     c
266b 9f        sbc     a,a
266c 05        dec     b
266d 03        inc     bc
266e 02        ld      (bc),a
266f 31000c    ld      sp,0c00h
2672 1807      jr      267bh
2674 ff        rst     38h
2675 ff        rst     38h
2676 2000      jr      nz,2678h
2678 e0        ret     po

2679 ee0e      xor     0eh
267b 08        ex      af,af'
267c 09        add     hl,bc
267d 09        add     hl,bc
267e 0e9c      ld      c,9ch
2680 05        dec     b
2681 03        inc     bc
2682 9c        sbc     a,h
2683 05        dec     b
2684 03        inc     bc
2685 9c        sbc     a,h
2686 05        dec     b
2687 03        inc     bc
2688 9c        sbc     a,h
2689 05        dec     b
268a 03        inc     bc
268b 9c        sbc     a,h
268c 05        dec     b
268d 03        inc     bc
268e 08        ex      af,af'
268f 05        dec     b
2690 09        add     hl,bc
2691 03        inc     bc
2692 9c        sbc     a,h
2693 05        dec     b
2694 03        inc     bc
2695 08        ex      af,af'
2696 03        inc     bc
2697 09        add     hl,bc
2698 0d        dec     c
2699 9c        sbc     a,h
269a 05        dec     b
269b 03        inc     bc
269c 04        inc     b
269d 1803      jr      26a2h
269f 011827    ld      bc,2718h
26a2 02        ld      (bc),a
26a3 2c        inc     l
26a4 00        nop     
26a5 0c        inc     c
26a6 24        inc     h
26a7 07        rlca    
26a8 ff        rst     38h
26a9 ff        rst     38h
26aa 0100ff    ld      bc,0ff00h
26ad 0f        rrca    
26ae 00        nop     
26af 09        add     hl,bc
26b0 0c        inc     c
26b1 08        ex      af,af'
26b2 0a        ld      a,(bc)
26b3 03        inc     bc
26b4 03        inc     bc
26b5 02        ld      (bc),a
26b6 27        daa     
26b7 03        inc     bc
26b8 01d726    ld      bc,26d7h
26bb 08        ex      af,af'
26bc 0a        ld      a,(bc)
26bd 09        add     hl,bc
26be 0c        inc     c
26bf 8f        adc     a,a
26c0 40        ld      b,b
26c1 40        ld      b,b
26c2 03        inc     bc
26c3 010227    ld      bc,2702h
26c6 8f        adc     a,a
26c7 40        ld      b,b
26c8 40        ld      b,b
26c9 03        inc     bc
26ca 010227    ld      bc,2702h
26cd 8f        adc     a,a
26ce 40        ld      b,b
26cf 40        ld      b,b
26d0 91        sub     c
26d1 40        ld      b,b
26d2 40        ld      b,b
26d3 019d26    ld      bc,269dh
26d6 00        nop     
26d7 8a        adc     a,d
26d8 1e02      ld      e,02h
26da 8a        adc     a,d
26db 0e02      ld      c,02h
26dd 8d        adc     a,l
26de 3e02      ld      a,02h
26e0 88        adc     a,b
26e1 0e02      ld      c,02h
26e3 8a        adc     a,d
26e4 1010      djnz    26f6h
26e6 8a        adc     a,d
26e7 07        rlca    
26e8 018810    ld      bc,1088h
26eb 00        nop     
26ec 80        add     a,b
26ed 08        ex      af,af'
26ee 00        nop     
26ef 8a        adc     a,d
26f0 0e02      ld      c,02h
26f2 1a        ld      a,(de)
26f3 08        ex      af,af'
26f4 0c        inc     c
26f5 12        ld      (de),a
26f6 08        ex      af,af'
26f7 09        add     hl,bc
26f8 2c        inc     l
26f9 1600      ld      d,00h
26fb 09        add     hl,bc
26fc 09        add     hl,bc
26fd 89        adc     a,c
26fe 2e02      ld      l,02h
2700 1b        dec     de
2701 04        inc     b
2702 8a        adc     a,d
2703 1e02      ld      e,02h
2705 8a        adc     a,d
2706 0e02      ld      c,02h
2708 8d        adc     a,l
2709 4e        ld      c,(hl)
270a 02        ld      (bc),a
270b 88        adc     a,b
270c 1e02      ld      e,02h
270e 88        adc     a,b
270f 0e02      ld      c,02h
2711 8f        adc     a,a
2712 3f        ccf     
2713 00        nop     
2714 8f        adc     a,a
2715 0e03      ld      c,03h
2717 04        inc     b
2718 80        add     a,b
2719 80        add     a,b
271a 00        nop     
271b 80        add     a,b
271c 80        add     a,b
271d 00        nop     
271e 80        add     a,b
271f 80        add     a,b
2720 00        nop     
2721 80        add     a,b
2722 3800      jr      c,2724h
2724 80        add     a,b
2725 09        add     hl,bc
2726 00        nop     
2727 02        ld      (bc),a
2728 1e00      ld      e,00h
272a 0c        inc     c
272b 24        inc     h
272c 08        ex      af,af'
272d 0f        rrca    
272e 07        rlca    
272f ff        rst     38h
2730 ff        rst     38h
2731 00        nop     
2732 00        nop     
2733 ff        rst     38h
2734 00        nop     
2735 010909    ld      bc,0909h
2738 08        ex      af,af'
2739 0b        dec     bc
273a 09        add     hl,bc
273b 0d        dec     c
273c 8f        adc     a,a
273d 1000      djnz    273fh
273f 8f        adc     a,a
2740 08        ex      af,af'
2741 00        nop     
2742 0c        inc     c
2743 1802      jr      2747h
2745 5e        ld      e,(hl)
2746 00        nop     
2747 07        rlca    
2748 ff        rst     38h
2749 ff        rst     38h
274a 2000      jr      nz,274ch
274c e0        ret     po

274d e0        ret     po

274e 00        nop     
274f 08        ex      af,af'
2750 0b        dec     bc
2751 09        add     hl,bc
2752 03        inc     bc
2753 95        sub     l
2754 08        ex      af,af'
2755 00        nop     
2756 95        sub     l
2757 08        ex      af,af'
2758 00        nop     
2759 09        add     hl,bc
275a 019510    ld      bc,1095h
275d 00        nop     
275e 09        add     hl,bc
275f 0f        rrca    
2760 8f        adc     a,a
2761 07        rlca    
2762 00        nop     
2763 04        inc     b
2764 00        nop     
2765 00        nop     
2766 00        nop     
2767 00        nop     
2768 1880      jr      26eah
276a 08        ex      af,af'
276b 08        ex      af,af'
276c 80        add     a,b
276d 80        add     a,b
276e 80        add     a,b
276f 80        add     a,b
2770 80        add     a,b
2771 00        nop     
2772 03        inc     bc
2773 016f2c    ld      bc,2c6fh
2776 03        inc     bc
2777 01082c    ld      bc,2c08h
277a 03        inc     bc
277b 01112c    ld      bc,2c11h
277e 03        inc     bc
277f 011d2b    ld      bc,2b1dh
2782 03        inc     bc
2783 01682a    ld      bc,2a68h
2786 03        inc     bc
2787 017829    ld      bc,2978h
278a 03        inc     bc
278b 01682a    ld      bc,2a68h
278e 03        inc     bc
278f 017829    ld      bc,2978h
2792 03        inc     bc
2793 02        ld      (bc),a
2794 99        sbc     a,c
2795 27        daa     
2796 017627    ld      bc,2776h
2799 03        inc     bc
279a 03        inc     bc
279b a2        and     d
279c 27        daa     
279d 03        inc     bc
279e 018328    ld      bc,2883h
27a1 04        inc     b
27a2 02        ld      (bc),a
27a3 93        sub     e
27a4 00        nop     
27a5 09        add     hl,bc
27a6 09        add     hl,bc
27a7 0c        inc     c
27a8 24        inc     h
27a9 08        ex      af,af'
27aa 0f        rrca    
27ab 07        rlca    
27ac ff        rst     38h
27ad ff        rst     38h
27ae 0100ff    ld      bc,0ff00h
27b1 00        nop     
27b2 118c06    ld      de,068ch
27b5 02        ld      (bc),a
27b6 02        ld      (bc),a
27b7 93        sub     e
27b8 00        nop     
27b9 09        add     hl,bc
27ba 07        rlca    
27bb 0c        inc     c
27bc 24        inc     h
27bd 08        ex      af,af'
27be 0f        rrca    
27bf 07        rlca    
27c0 ff        rst     38h
27c1 ff        rst     38h
27c2 0100ff    ld      bc,0ff00h
27c5 00        nop     
27c6 118c06    ld      de,068ch
27c9 02        ld      (bc),a
27ca 02        ld      (bc),a
27cb 93        sub     e
27cc 00        nop     
27cd 09        add     hl,bc
27ce 09        add     hl,bc
27cf 0c        inc     c
27d0 24        inc     h
27d1 08        ex      af,af'
27d2 0f        rrca    
27d3 07        rlca    
27d4 ff        rst     38h
27d5 ff        rst     38h
27d6 0100ff    ld      bc,0ff00h
27d9 00        nop     
27da 118c06    ld      de,068ch
27dd 02        ld      (bc),a
27de 02        ld      (bc),a
27df 93        sub     e
27e0 00        nop     
27e1 09        add     hl,bc
27e2 07        rlca    
27e3 0c        inc     c
27e4 24        inc     h
27e5 08        ex      af,af'
27e6 0f        rrca    
27e7 07        rlca    
27e8 ff        rst     38h
27e9 ff        rst     38h
27ea 0100ff    ld      bc,0ff00h
27ed 00        nop     
27ee 118c06    ld      de,068ch
27f1 02        ld      (bc),a
27f2 02        ld      (bc),a
27f3 1e00      ld      e,00h
27f5 0c        inc     c
27f6 24        inc     h
27f7 1c        inc     e
27f8 1608      ld      d,08h
27fa 0f        rrca    
27fb 07        rlca    
27fc ff        rst     38h
27fd ff        rst     38h
27fe 1000      djnz    2800h
2800 f0        ret     p

2801 a0        and     b
2802 00        nop     
2803 09        add     hl,bc
2804 09        add     hl,bc
2805 92        sub     d
2806 0e02      ld      c,02h
2808 02        ld      (bc),a
2809 93        sub     e
280a 00        nop     
280b 09        add     hl,bc
280c 09        add     hl,bc
280d 0c        inc     c
280e 24        inc     h
280f 08        ex      af,af'
2810 0f        rrca    
2811 07        rlca    
2812 ff        rst     38h
2813 ff        rst     38h
2814 0100ff    ld      bc,0ff00h
2817 00        nop     
2818 118c06    ld      de,068ch
281b 02        ld      (bc),a
281c 02        ld      (bc),a
281d 93        sub     e
281e 00        nop     
281f 09        add     hl,bc
2820 07        rlca    
2821 0c        inc     c
2822 24        inc     h
2823 08        ex      af,af'
2824 0f        rrca    
2825 07        rlca    
2826 ff        rst     38h
2827 ff        rst     38h
2828 0100ff    ld      bc,0ff00h
282b 00        nop     
282c 118b06    ld      de,068bh
282f 02        ld      (bc),a
2830 02        ld      (bc),a
2831 93        sub     e
2832 00        nop     
2833 0c        inc     c
2834 24        inc     h
2835 08        ex      af,af'
2836 0f        rrca    
2837 07        rlca    
2838 ff        rst     38h
2839 ff        rst     38h
283a 0100ff    ld      bc,0ff00h
283d 00        nop     
283e 110908    ld      de,0809h
2841 8c        adc     a,h
2842 08        ex      af,af'
2843 08        ex      af,af'
2844 02        ld      (bc),a
2845 93        sub     e
2846 00        nop     
2847 09        add     hl,bc
2848 09        add     hl,bc
2849 0c        inc     c
284a 24        inc     h
284b 08        ex      af,af'
284c 0f        rrca    
284d 07        rlca    
284e ff        rst     38h
284f ff        rst     38h
2850 0100ff    ld      bc,0ff00h
2853 00        nop     
2854 118c06    ld      de,068ch
2857 02        ld      (bc),a
2858 02        ld      (bc),a
2859 93        sub     e
285a 00        nop     
285b 09        add     hl,bc
285c 07        rlca    
285d 0c        inc     c
285e 24        inc     h
285f 08        ex      af,af'
2860 0f        rrca    
2861 07        rlca    
2862 ff        rst     38h
2863 ff        rst     38h
2864 0100ff    ld      bc,0ff00h
2867 00        nop     
2868 118c06    ld      de,068ch
286b 02        ld      (bc),a
286c 02        ld      (bc),a
286d 1e00      ld      e,00h
286f 0c        inc     c
2870 24        inc     h
2871 1c        inc     e
2872 1608      ld      d,08h
2874 0f        rrca    
2875 07        rlca    
2876 ff        rst     38h
2877 ff        rst     38h
2878 1000      djnz    287ah
287a f0        ret     p

287b a0        and     b
287c 00        nop     
287d 09        add     hl,bc
287e 09        add     hl,bc
287f 92        sub     d
2880 1808      jr      288ah
2882 04        inc     b
2883 02        ld      (bc),a
2884 93        sub     e
2885 00        nop     
2886 09        add     hl,bc
2887 09        add     hl,bc
2888 0c        inc     c
2889 24        inc     h
288a 08        ex      af,af'
288b 0f        rrca    
288c 07        rlca    
288d ff        rst     38h
288e ff        rst     38h
288f 0100ff    ld      bc,0ff00h
2892 00        nop     
2893 118c06    ld      de,068ch
2896 02        ld      (bc),a
2897 02        ld      (bc),a
2898 93        sub     e
2899 00        nop     
289a 09        add     hl,bc
289b 07        rlca    
289c 0c        inc     c
289d 24        inc     h
289e 08        ex      af,af'
289f 0f        rrca    
28a0 07        rlca    
28a1 ff        rst     38h
28a2 ff        rst     38h
28a3 0100ff    ld      bc,0ff00h
28a6 00        nop     
28a7 118c06    ld      de,068ch
28aa 02        ld      (bc),a
28ab 02        ld      (bc),a
28ac 93        sub     e
28ad 00        nop     
28ae 09        add     hl,bc
28af 09        add     hl,bc
28b0 0c        inc     c
28b1 24        inc     h
28b2 08        ex      af,af'
28b3 0f        rrca    
28b4 07        rlca    
28b5 ff        rst     38h
28b6 ff        rst     38h
28b7 0100ff    ld      bc,0ff00h
28ba 00        nop     
28bb 118c06    ld      de,068ch
28be 02        ld      (bc),a
28bf 02        ld      (bc),a
28c0 93        sub     e
28c1 00        nop     
28c2 09        add     hl,bc
28c3 07        rlca    
28c4 0c        inc     c
28c5 24        inc     h
28c6 08        ex      af,af'
28c7 0f        rrca    
28c8 07        rlca    
28c9 ff        rst     38h
28ca ff        rst     38h
28cb 0100ff    ld      bc,0ff00h
28ce 00        nop     
28cf 118c06    ld      de,068ch
28d2 02        ld      (bc),a
28d3 02        ld      (bc),a
28d4 1e00      ld      e,00h
28d6 0c        inc     c
28d7 24        inc     h
28d8 1c        inc     e
28d9 1608      ld      d,08h
28db 0f        rrca    
28dc 07        rlca    
28dd ff        rst     38h
28de ff        rst     38h
28df 1000      djnz    28e1h
28e1 f0        ret     p

28e2 a0        and     b
28e3 00        nop     
28e4 09        add     hl,bc
28e5 09        add     hl,bc
28e6 92        sub     d
28e7 0e02      ld      c,02h
28e9 02        ld      (bc),a
28ea 93        sub     e
28eb 00        nop     
28ec 09        add     hl,bc
28ed 09        add     hl,bc
28ee 0c        inc     c
28ef 24        inc     h
28f0 08        ex      af,af'
28f1 0f        rrca    
28f2 07        rlca    
28f3 ff        rst     38h
28f4 ff        rst     38h
28f5 0100ff    ld      bc,0ff00h
28f8 00        nop     
28f9 118c06    ld      de,068ch
28fc 02        ld      (bc),a
28fd 02        ld      (bc),a
28fe 93        sub     e
28ff 00        nop     
2900 09        add     hl,bc
2901 07        rlca    
2902 0c        inc     c
2903 24        inc     h
2904 08        ex      af,af'
2905 0f        rrca    
2906 07        rlca    
2907 ff        rst     38h
2908 ff        rst     38h
2909 0100ff    ld      bc,0ff00h
290c 00        nop     
290d 118b06    ld      de,068bh
2910 02        ld      (bc),a
2911 02        ld      (bc),a
2912 93        sub     e
2913 00        nop     
2914 0c        inc     c
2915 24        inc     h
2916 08        ex      af,af'
2917 0f        rrca    
2918 07        rlca    
2919 ff        rst     38h
291a ff        rst     38h
291b 0100ff    ld      bc,0ff00h
291e 00        nop     
291f 110908    ld      de,0809h
2922 8c        adc     a,h
2923 08        ex      af,af'
2924 0c        inc     c
2925 02        ld      (bc),a
2926 93        sub     e
2927 00        nop     
2928 09        add     hl,bc
2929 09        add     hl,bc
292a 0c        inc     c
292b 24        inc     h
292c 08        ex      af,af'
292d 0f        rrca    
292e 07        rlca    
292f ff        rst     38h
2930 ff        rst     38h
2931 0100ff    ld      bc,0ff00h
2934 00        nop     
2935 118c03    ld      de,038ch
2938 010293    ld      bc,9302h
293b 00        nop     
293c 09        add     hl,bc
293d 07        rlca    
293e 0c        inc     c
293f 24        inc     h
2940 08        ex      af,af'
2941 0f        rrca    
2942 07        rlca    
2943 ff        rst     38h
2944 ff        rst     38h
2945 0100ff    ld      bc,0ff00h
2948 00        nop     
2949 118c03    ld      de,038ch
294c 010293    ld      bc,9302h
294f 00        nop     
2950 09        add     hl,bc
2951 09        add     hl,bc
2952 0c        inc     c
2953 24        inc     h
2954 08        ex      af,af'
2955 0f        rrca    
2956 07        rlca    
2957 ff        rst     38h
2958 ff        rst     38h
2959 0100ff    ld      bc,0ff00h
295c 00        nop     
295d 118c03    ld      de,038ch
2960 01021e    ld      bc,1e02h
2963 00        nop     
2964 0c        inc     c
2965 24        inc     h
2966 1c        inc     e
2967 1608      ld      d,08h
2969 0f        rrca    
296a 07        rlca    
296b ff        rst     38h
296c ff        rst     38h
296d 1000      djnz    296fh
296f f0        ret     p

2970 a0        and     b
2971 00        nop     
2972 09        add     hl,bc
2973 09        add     hl,bc
2974 92        sub     d
2975 1808      jr      297fh
2977 04        inc     b
2978 02        ld      (bc),a
2979 93        sub     e
297a 00        nop     
297b 09        add     hl,bc
297c 09        add     hl,bc
297d 0c        inc     c
297e 24        inc     h
297f 08        ex      af,af'
2980 0f        rrca    
2981 07        rlca    
2982 ff        rst     38h
2983 ff        rst     38h
2984 0100ff    ld      bc,0ff00h
2987 00        nop     
2988 118c06    ld      de,068ch
298b 02        ld      (bc),a
298c 02        ld      (bc),a
298d 93        sub     e
298e 00        nop     
298f 09        add     hl,bc
2990 07        rlca    
2991 0c        inc     c
2992 24        inc     h
2993 08        ex      af,af'
2994 0f        rrca    
2995 07        rlca    
2996 ff        rst     38h
2997 ff        rst     38h
2998 0100ff    ld      bc,0ff00h
299b 00        nop     
299c 118c06    ld      de,068ch
299f 02        ld      (bc),a
29a0 02        ld      (bc),a
29a1 93        sub     e
29a2 00        nop     
29a3 09        add     hl,bc
29a4 09        add     hl,bc
29a5 0c        inc     c
29a6 24        inc     h
29a7 08        ex      af,af'
29a8 0f        rrca    
29a9 07        rlca    
29aa ff        rst     38h
29ab ff        rst     38h
29ac 0100ff    ld      bc,0ff00h
29af 00        nop     
29b0 118c06    ld      de,068ch
29b3 02        ld      (bc),a
29b4 02        ld      (bc),a
29b5 93        sub     e
29b6 00        nop     
29b7 09        add     hl,bc
29b8 07        rlca    
29b9 0c        inc     c
29ba 24        inc     h
29bb 08        ex      af,af'
29bc 0f        rrca    
29bd 07        rlca    
29be ff        rst     38h
29bf ff        rst     38h
29c0 0100ff    ld      bc,0ff00h
29c3 00        nop     
29c4 118c06    ld      de,068ch
29c7 02        ld      (bc),a
29c8 02        ld      (bc),a
29c9 1e00      ld      e,00h
29cb 0c        inc     c
29cc 24        inc     h
29cd 1c        inc     e
29ce 1608      ld      d,08h
29d0 0f        rrca    
29d1 07        rlca    
29d2 ff        rst     38h
29d3 ff        rst     38h
29d4 1000      djnz    29d6h
29d6 f0        ret     p

29d7 a0        and     b
29d8 00        nop     
29d9 09        add     hl,bc
29da 09        add     hl,bc
29db 92        sub     d
29dc 0e02      ld      c,02h
29de 02        ld      (bc),a
29df 93        sub     e
29e0 00        nop     
29e1 0c        inc     c
29e2 24        inc     h
29e3 08        ex      af,af'
29e4 0f        rrca    
29e5 07        rlca    
29e6 ff        rst     38h
29e7 ff        rst     38h
29e8 0100ff    ld      bc,0ff00h
29eb 00        nop     
29ec 110908    ld      de,0809h
29ef 8c        adc     a,h
29f0 08        ex      af,af'
29f1 188c      jr      297fh
29f3 08        ex      af,af'
29f4 08        ex      af,af'
29f5 02        ld      (bc),a
29f6 1e00      ld      e,00h
29f8 0c        inc     c
29f9 24        inc     h
29fa 1c        inc     e
29fb 1608      ld      d,08h
29fd 0f        rrca    
29fe 07        rlca    
29ff ff        rst     38h
2a00 ff        rst     38h
2a01 1000      djnz    2a03h
2a03 f0        ret     p

2a04 a0        and     b
2a05 00        nop     
2a06 09        add     hl,bc
2a07 09        add     hl,bc
2a08 92        sub     d
2a09 0e02      ld      c,02h
2a0b 02        ld      (bc),a
2a0c 93        sub     e
2a0d 00        nop     
2a0e 0c        inc     c
2a0f 24        inc     h
2a10 08        ex      af,af'
2a11 0f        rrca    
2a12 07        rlca    
2a13 ff        rst     38h
2a14 ff        rst     38h
2a15 0100ff    ld      bc,0ff00h
2a18 00        nop     
2a19 110908    ld      de,0809h
2a1c 8d        adc     a,l
2a1d 08        ex      af,af'
2a1e 1802      jr      2a22h
2a20 1e00      ld      e,00h
2a22 0c        inc     c
2a23 24        inc     h
2a24 1c        inc     e
2a25 1608      ld      d,08h
2a27 0f        rrca    
2a28 07        rlca    
2a29 ff        rst     38h
2a2a ff        rst     38h
2a2b 1000      djnz    2a2dh
2a2d f0        ret     p

2a2e a0        and     b
2a2f 00        nop     
2a30 09        add     hl,bc
2a31 09        add     hl,bc
2a32 92        sub     d
2a33 0e02      ld      c,02h
2a35 92        sub     d
2a36 08        ex      af,af'
2a37 0c        inc     c
2a38 0c        inc     c
2a39 1802      jr      2a3dh
2a3b 5e        ld      e,(hl)
2a3c 00        nop     
2a3d 07        rlca    
2a3e ff        rst     38h
2a3f ff        rst     38h
2a40 2000      jr      nz,2a42h
2a42 e0        ret     po

2a43 e0        ret     po

2a44 00        nop     
2a45 08        ex      af,af'
2a46 0b        dec     bc
2a47 09        add     hl,bc
2a48 0f        rrca    
2a49 9a        sbc     a,d
2a4a 03        inc     bc
2a4b 019b03    ld      bc,039bh
2a4e 019b03    ld      bc,039bh
2a51 01080f    ld      bc,0f08h
2a54 09        add     hl,bc
2a55 0e9c      ld      c,9ch
2a57 08        ex      af,af'
2a58 08        ex      af,af'
2a59 9b        sbc     a,e
2a5a 08        ex      af,af'
2a5b 08        ex      af,af'
2a5c 9b        sbc     a,e
2a5d 08        ex      af,af'
2a5e 00        nop     
2a5f 09        add     hl,bc
2a60 03        inc     bc
2a61 95        sub     l
2a62 08        ex      af,af'
2a63 00        nop     
2a64 94        sub     h
2a65 0e02      ld      c,02h
2a67 04        inc     b
2a68 02        ld      (bc),a
2a69 93        sub     e
2a6a 00        nop     
2a6b 0c        inc     c
2a6c 24        inc     h
2a6d 08        ex      af,af'
2a6e 0f        rrca    
2a6f 07        rlca    
2a70 ff        rst     38h
2a71 ff        rst     38h
2a72 0100ff    ld      bc,0ff00h
2a75 00        nop     
2a76 110908    ld      de,0809h
2a79 8c        adc     a,h
2a7a 08        ex      af,af'
2a7b 08        ex      af,af'
2a7c 8c        adc     a,h
2a7d 08        ex      af,af'
2a7e 08        ex      af,af'
2a7f 02        ld      (bc),a
2a80 1e00      ld      e,00h
2a82 0c        inc     c
2a83 24        inc     h
2a84 1c        inc     e
2a85 1608      ld      d,08h
2a87 0f        rrca    
2a88 07        rlca    
2a89 ff        rst     38h
2a8a ff        rst     38h
2a8b 1000      djnz    2a8dh
2a8d f0        ret     p

2a8e a0        and     b
2a8f 00        nop     
2a90 09        add     hl,bc
2a91 09        add     hl,bc
2a92 92        sub     d
2a93 0e02      ld      c,02h
2a95 02        ld      (bc),a
2a96 93        sub     e
2a97 00        nop     
2a98 0c        inc     c
2a99 24        inc     h
2a9a 08        ex      af,af'
2a9b 0f        rrca    
2a9c 07        rlca    
2a9d ff        rst     38h
2a9e ff        rst     38h
2a9f 0100ff    ld      bc,0ff00h
2aa2 00        nop     
2aa3 110908    ld      de,0809h
2aa6 8c        adc     a,h
2aa7 08        ex      af,af'
2aa8 188c      jr      2a36h
2aaa 08        ex      af,af'
2aab 08        ex      af,af'
2aac 02        ld      (bc),a
2aad 1e00      ld      e,00h
2aaf 0c        inc     c
2ab0 24        inc     h
2ab1 1c        inc     e
2ab2 1608      ld      d,08h
2ab4 0f        rrca    
2ab5 07        rlca    
2ab6 ff        rst     38h
2ab7 ff        rst     38h
2ab8 1000      djnz    2abah
2aba f0        ret     p

2abb a0        and     b
2abc 00        nop     
2abd 09        add     hl,bc
2abe 09        add     hl,bc
2abf 92        sub     d
2ac0 0e02      ld      c,02h
2ac2 02        ld      (bc),a
2ac3 93        sub     e
2ac4 00        nop     
2ac5 0c        inc     c
2ac6 24        inc     h
2ac7 08        ex      af,af'
2ac8 0f        rrca    
2ac9 07        rlca    
2aca ff        rst     38h
2acb ff        rst     38h
2acc 0100ff    ld      bc,0ff00h
2acf 00        nop     
2ad0 110908    ld      de,0809h
2ad3 8d        adc     a,l
2ad4 08        ex      af,af'
2ad5 188c      jr      2a63h
2ad7 08        ex      af,af'
2ad8 08        ex      af,af'
2ad9 02        ld      (bc),a
2ada 1e00      ld      e,00h
2adc 0c        inc     c
2add 24        inc     h
2ade 1c        inc     e
2adf 1608      ld      d,08h
2ae1 0f        rrca    
2ae2 07        rlca    
2ae3 ff        rst     38h
2ae4 ff        rst     38h
2ae5 1000      djnz    2ae7h
2ae7 f0        ret     p

2ae8 a0        and     b
2ae9 00        nop     
2aea 09        add     hl,bc
2aeb 09        add     hl,bc
2aec 92        sub     d
2aed 1e02      ld      e,02h
2aef 02        ld      (bc),a
2af0 93        sub     e
2af1 00        nop     
2af2 0c        inc     c
2af3 24        inc     h
2af4 08        ex      af,af'
2af5 0f        rrca    
2af6 07        rlca    
2af7 ff        rst     38h
2af8 ff        rst     38h
2af9 0100ff    ld      bc,0ff00h
2afc 00        nop     
2afd 110908    ld      de,0809h
2b00 8c        adc     a,h
2b01 08        ex      af,af'
2b02 08        ex      af,af'
2b03 8b        adc     a,e
2b04 08        ex      af,af'
2b05 08        ex      af,af'
2b06 02        ld      (bc),a
2b07 1e00      ld      e,00h
2b09 0c        inc     c
2b0a 24        inc     h
2b0b 1c        inc     e
2b0c 1608      ld      d,08h
2b0e 0f        rrca    
2b0f 07        rlca    
2b10 ff        rst     38h
2b11 ff        rst     38h
2b12 1000      djnz    2b14h
2b14 f0        ret     p

2b15 a0        and     b
2b16 00        nop     
2b17 09        add     hl,bc
2b18 09        add     hl,bc
2b19 92        sub     d
2b1a 1e02      ld      e,02h
2b1c 04        inc     b
2b1d 03        inc     bc
2b1e 06ac      ld      b,0ach
2b20 2b        dec     hl
2b21 03        inc     bc
2b22 01262b    ld      bc,2b26h
2b25 04        inc     b
2b26 02        ld      (bc),a
2b27 93        sub     e
2b28 00        nop     
2b29 0c        inc     c
2b2a 24        inc     h
2b2b 08        ex      af,af'
2b2c 0f        rrca    
2b2d 07        rlca    
2b2e ff        rst     38h
2b2f ff        rst     38h
2b30 0100ff    ld      bc,0ff00h
2b33 00        nop     
2b34 110908    ld      de,0809h
2b37 8b        adc     a,e
2b38 08        ex      af,af'
2b39 08        ex      af,af'
2b3a 02        ld      (bc),a
2b3b 1e00      ld      e,00h
2b3d 0c        inc     c
2b3e 24        inc     h
2b3f 1c        inc     e
2b40 1608      ld      d,08h
2b42 0f        rrca    
2b43 07        rlca    
2b44 ff        rst     38h
2b45 ff        rst     38h
2b46 1000      djnz    2b48h
2b48 f0        ret     p

2b49 a0        and     b
2b4a 00        nop     
2b4b 09        add     hl,bc
2b4c 09        add     hl,bc
2b4d 88        adc     a,b
2b4e 08        ex      af,af'
2b4f 08        ex      af,af'
2b50 88        adc     a,b
2b51 08        ex      af,af'
2b52 08        ex      af,af'
2b53 09        add     hl,bc
2b54 04        inc     b
2b55 85        add     a,l
2b56 1808      jr      2b60h
2b58 02        ld      (bc),a
2b59 93        sub     e
2b5a 00        nop     
2b5b 0c        inc     c
2b5c 24        inc     h
2b5d 08        ex      af,af'
2b5e 0f        rrca    
2b5f 07        rlca    
2b60 ff        rst     38h
2b61 ff        rst     38h
2b62 0100ff    ld      bc,0ff00h
2b65 00        nop     
2b66 110908    ld      de,0809h
2b69 8b        adc     a,e
2b6a 08        ex      af,af'
2b6b 08        ex      af,af'
2b6c 8c        adc     a,h
2b6d 08        ex      af,af'
2b6e 08        ex      af,af'
2b6f 8b        adc     a,e
2b70 1808      jr      2b7ah
2b72 02        ld      (bc),a
2b73 1e00      ld      e,00h
2b75 0c        inc     c
2b76 24        inc     h
2b77 1c        inc     e
2b78 1608      ld      d,08h
2b7a 0f        rrca    
2b7b 07        rlca    
2b7c ff        rst     38h
2b7d ff        rst     38h
2b7e 1000      djnz    2b80h
2b80 f0        ret     p

2b81 a0        and     b
2b82 00        nop     
2b83 09        add     hl,bc
2b84 09        add     hl,bc
2b85 88        adc     a,b
2b86 08        ex      af,af'
2b87 08        ex      af,af'
2b88 88        adc     a,b
2b89 08        ex      af,af'
2b8a 08        ex      af,af'
2b8b 09        add     hl,bc
2b8c 0e86      ld      c,86h
2b8e 1800      jr      2b90h
2b90 09        add     hl,bc
2b91 09        add     hl,bc
2b92 08        ex      af,af'
2b93 07        rlca    
2b94 90        sub     b
2b95 03        inc     bc
2b96 00        nop     
2b97 91        sub     c
2b98 03        inc     bc
2b99 00        nop     
2b9a 92        sub     d
2b9b 02        ld      (bc),a
2b9c 00        nop     
2b9d 08        ex      af,af'
2b9e 0f        rrca    
2b9f 92        sub     d
2ba0 0e02      ld      c,02h
2ba2 92        sub     d
2ba3 0602      ld      b,02h
2ba5 93        sub     e
2ba6 0602      ld      b,02h
2ba8 92        sub     d
2ba9 0e02      ld      c,02h
2bab 04        inc     b
2bac 02        ld      (bc),a
2bad 93        sub     e
2bae 00        nop     
2baf 0c        inc     c
2bb0 24        inc     h
2bb1 08        ex      af,af'
2bb2 0f        rrca    
2bb3 07        rlca    
2bb4 ff        rst     38h
2bb5 ff        rst     38h
2bb6 0100ff    ld      bc,0ff00h
2bb9 00        nop     
2bba 110908    ld      de,0809h
2bbd 8b        adc     a,e
2bbe 2000      jr      nz,2bc0h
2bc0 02        ld      (bc),a
2bc1 1e00      ld      e,00h
2bc3 0c        inc     c
2bc4 24        inc     h
2bc5 1c        inc     e
2bc6 1608      ld      d,08h
2bc8 0f        rrca    
2bc9 07        rlca    
2bca ff        rst     38h
2bcb ff        rst     38h
2bcc 1000      djnz    2bceh
2bce f0        ret     p

2bcf a0        and     b
2bd0 00        nop     
2bd1 09        add     hl,bc
2bd2 09        add     hl,bc
2bd3 09        add     hl,bc
2bd4 05        dec     b
2bd5 88        adc     a,b
2bd6 1800      jr      2bd8h
2bd8 02        ld      (bc),a
2bd9 93        sub     e
2bda 00        nop     
2bdb 0c        inc     c
2bdc 24        inc     h
2bdd 08        ex      af,af'
2bde 0f        rrca    
2bdf 07        rlca    
2be0 ff        rst     38h
2be1 ff        rst     38h
2be2 0100ff    ld      bc,0ff00h
2be5 00        nop     
2be6 110908    ld      de,0809h
2be9 8c        adc     a,h
2bea 08        ex      af,af'
2beb 00        nop     
2bec 8b        adc     a,e
2bed 2000      jr      nz,2befh
2bef 02        ld      (bc),a
2bf0 1e00      ld      e,00h
2bf2 0c        inc     c
2bf3 24        inc     h
2bf4 1c        inc     e
2bf5 1608      ld      d,08h
2bf7 0f        rrca    
2bf8 07        rlca    
2bf9 ff        rst     38h
2bfa ff        rst     38h
2bfb 1000      djnz    2bfdh
2bfd f0        ret     p

2bfe a0        and     b
2bff 00        nop     
2c00 09        add     hl,bc
2c01 09        add     hl,bc
2c02 09        add     hl,bc
2c03 0d        dec     c
2c04 84        add     a,h
2c05 2000      jr      nz,2c07h
2c07 04        inc     b
2c08 03        inc     bc
2c09 0600      ld      b,00h
2c0b 2d        dec     l
2c0c 03        inc     bc
2c0d 011a2c    ld      bc,2c1ah
2c10 04        inc     b
2c11 03        inc     bc
2c12 0600      ld      b,00h
2c14 2d        dec     l
2c15 03        inc     bc
2c16 016f2c    ld      bc,2c6fh
2c19 04        inc     b
2c1a 02        ld      (bc),a
2c1b 93        sub     e
2c1c 00        nop     
2c1d 0c        inc     c
2c1e 24        inc     h
2c1f 08        ex      af,af'
2c20 0f        rrca    
2c21 07        rlca    
2c22 ff        rst     38h
2c23 ff        rst     38h
2c24 0100ff    ld      bc,0ff00h
2c27 00        nop     
2c28 110908    ld      de,0809h
2c2b 8b        adc     a,e
2c2c 2000      jr      nz,2c2eh
2c2e 02        ld      (bc),a
2c2f 1e00      ld      e,00h
2c31 0c        inc     c
2c32 24        inc     h
2c33 1c        inc     e
2c34 1608      ld      d,08h
2c36 0f        rrca    
2c37 07        rlca    
2c38 ff        rst     38h
2c39 ff        rst     38h
2c3a 1000      djnz    2c3ch
2c3c f0        ret     p

2c3d a0        and     b
2c3e 00        nop     
2c3f 09        add     hl,bc
2c40 09        add     hl,bc
2c41 92        sub     d
2c42 2008      jr      nz,2c4ch
2c44 02        ld      (bc),a
2c45 93        sub     e
2c46 00        nop     
2c47 0c        inc     c
2c48 24        inc     h
2c49 08        ex      af,af'
2c4a 0f        rrca    
2c4b 07        rlca    
2c4c ff        rst     38h
2c4d ff        rst     38h
2c4e 0100ff    ld      bc,0ff00h
2c51 00        nop     
2c52 110908    ld      de,0809h
2c55 8b        adc     a,e
2c56 1008      djnz    2c60h
2c58 02        ld      (bc),a
2c59 1e00      ld      e,00h
2c5b 0c        inc     c
2c5c 24        inc     h
2c5d 1c        inc     e
2c5e 1608      ld      d,08h
2c60 0f        rrca    
2c61 07        rlca    
2c62 ff        rst     38h
2c63 ff        rst     38h
2c64 1000      djnz    2c66h
2c66 f0        ret     p

2c67 a0        and     b
2c68 00        nop     
2c69 09        add     hl,bc
2c6a 09        add     hl,bc
2c6b 92        sub     d
2c6c 2000      jr      nz,2c6eh
2c6e 04        inc     b
2c6f 02        ld      (bc),a
2c70 93        sub     e
2c71 00        nop     
2c72 0c        inc     c
2c73 24        inc     h
2c74 08        ex      af,af'
2c75 0f        rrca    
2c76 07        rlca    
2c77 ff        rst     38h
2c78 ff        rst     38h
2c79 0100ff    ld      bc,0ff00h
2c7c 00        nop     
2c7d 110908    ld      de,0809h
2c80 8b        adc     a,e
2c81 2000      jr      nz,2c83h
2c83 02        ld      (bc),a
2c84 1e00      ld      e,00h
2c86 0c        inc     c
2c87 24        inc     h
2c88 1c        inc     e
2c89 1608      ld      d,08h
2c8b 0f        rrca    
2c8c 07        rlca    
2c8d ff        rst     38h
2c8e ff        rst     38h
2c8f 1000      djnz    2c91h
2c91 f0        ret     p

2c92 a0        and     b
2c93 00        nop     
2c94 09        add     hl,bc
2c95 09        add     hl,bc
2c96 92        sub     d
2c97 2008      jr      nz,2ca1h
2c99 02        ld      (bc),a
2c9a 93        sub     e
2c9b 00        nop     
2c9c 0c        inc     c
2c9d 24        inc     h
2c9e 08        ex      af,af'
2c9f 0f        rrca    
2ca0 07        rlca    
2ca1 ff        rst     38h
2ca2 ff        rst     38h
2ca3 0100ff    ld      bc,0ff00h
2ca6 00        nop     
2ca7 110908    ld      de,0809h
2caa 8b        adc     a,e
2cab 1000      djnz    2cadh
2cad 02        ld      (bc),a
2cae 93        sub     e
2caf 00        nop     
2cb0 09        add     hl,bc
2cb1 09        add     hl,bc
2cb2 0c        inc     c
2cb3 24        inc     h
2cb4 08        ex      af,af'
2cb5 0f        rrca    
2cb6 07        rlca    
2cb7 ff        rst     38h
2cb8 ff        rst     38h
2cb9 0100ff    ld      bc,0ff00h
2cbc 00        nop     
2cbd 118c03    ld      de,038ch
2cc0 00        nop     
2cc1 02        ld      (bc),a
2cc2 93        sub     e
2cc3 00        nop     
2cc4 09        add     hl,bc
2cc5 07        rlca    
2cc6 0c        inc     c
2cc7 24        inc     h
2cc8 08        ex      af,af'
2cc9 0f        rrca    
2cca 07        rlca    
2ccb ff        rst     38h
2ccc ff        rst     38h
2ccd 0100ff    ld      bc,0ff00h
2cd0 00        nop     
2cd1 118b03    ld      de,038bh
2cd4 00        nop     
2cd5 02        ld      (bc),a
2cd6 93        sub     e
2cd7 00        nop     
2cd8 09        add     hl,bc
2cd9 09        add     hl,bc
2cda 0c        inc     c
2cdb 24        inc     h
2cdc 08        ex      af,af'
2cdd 0f        rrca    
2cde 07        rlca    
2cdf ff        rst     38h
2ce0 ff        rst     38h
2ce1 0100ff    ld      bc,0ff00h
2ce4 00        nop     
2ce5 118c02    ld      de,028ch
2ce8 00        nop     
2ce9 02        ld      (bc),a
2cea 1e00      ld      e,00h
2cec 0c        inc     c
2ced 24        inc     h
2cee 1c        inc     e
2cef 1608      ld      d,08h
2cf1 0f        rrca    
2cf2 07        rlca    
2cf3 ff        rst     38h
2cf4 ff        rst     38h
2cf5 1000      djnz    2cf7h
2cf7 f0        ret     p

2cf8 a0        and     b
2cf9 00        nop     
2cfa 09        add     hl,bc
2cfb 09        add     hl,bc
2cfc 92        sub     d
2cfd 2000      jr      nz,2cffh
2cff 04        inc     b
2d00 02        ld      (bc),a
2d01 93        sub     e
2d02 00        nop     
2d03 0c        inc     c
2d04 24        inc     h
2d05 08        ex      af,af'
2d06 0f        rrca    
2d07 07        rlca    
2d08 ff        rst     38h
2d09 ff        rst     38h
2d0a 0100ff    ld      bc,0ff00h
2d0d 00        nop     
2d0e 110908    ld      de,0809h
2d11 8b        adc     a,e
2d12 2000      jr      nz,2d14h
2d14 02        ld      (bc),a
2d15 1e00      ld      e,00h
2d17 0c        inc     c
2d18 24        inc     h
2d19 1c        inc     e
2d1a 1608      ld      d,08h
2d1c 0f        rrca    
2d1d 07        rlca    
2d1e ff        rst     38h
2d1f ff        rst     38h
2d20 1000      djnz    2d22h
2d22 f0        ret     p

2d23 a0        and     b
2d24 00        nop     
2d25 09        add     hl,bc
2d26 09        add     hl,bc
2d27 92        sub     d
2d28 2000      jr      nz,2d2ah
2d2a 04        inc     b
2d2b 1880      jr      2cadh
2d2d 08        ex      af,af'
2d2e 08        ex      af,af'
2d2f 02        ld      (bc),a
2d30 73        ld      (hl),e
2d31 00        nop     
2d32 0c        inc     c
2d33 1809      jr      2d3eh
2d35 0a        ld      a,(bc)
2d36 09        add     hl,bc
2d37 09        add     hl,bc
2d38 03        inc     bc
2d39 0c        inc     c
2d3a 04        inc     b
2d3b 2f        cpl     
2d3c 03        inc     bc
2d3d 01b32e    ld      bc,2eb3h
2d40 03        inc     bc
2d41 02        ld      (bc),a
2d42 8f        adc     a,a
2d43 2e02      ld      l,02h
2d45 97        sub     a
2d46 00        nop     
2d47 0c        inc     c
2d48 1807      jr      2d51h
2d4a ff        rst     38h
2d4b ff        rst     38h
2d4c 2000      jr      nz,2d4eh
2d4e e0        ret     po

2d4f 00        nop     
2d50 e0        ret     po

2d51 09        add     hl,bc
2d52 02        ld      (bc),a
2d53 03        inc     bc
2d54 2000      jr      nz,2d56h
2d56 2003      jr      nz,2d5bh
2d58 01212e    ld      bc,2e21h
2d5b 03        inc     bc
2d5c 01b32d    ld      bc,2db3h
2d5f 03        inc     bc
2d60 01212e    ld      bc,2e21h
2d63 03        inc     bc
2d64 01b32d    ld      bc,2db3h
2d67 03        inc     bc
2d68 02        ld      (bc),a
2d69 6e        ld      l,(hl)
2d6a 2d        dec     l
2d6b 01402d    ld      bc,2d40h
2d6e 0c        inc     c
2d6f 1802      jr      2d73h
2d71 0600      ld      b,00h
2d73 08        ex      af,af'
2d74 0a        ld      a,(bc)
2d75 09        add     hl,bc
2d76 0107ff    ld      bc,0ff07h
2d79 ff        rst     38h
2d7a 3000      jr      nc,2d7ch
2d7c d0        ret     nc

2d7d 0d        dec     c
2d7e 00        nop     
2d7f 95        sub     l
2d80 1808      jr      2d8ah
2d82 03        inc     bc
2d83 07        rlca    
2d84 9b        sbc     a,e
2d85 2d        dec     l
2d86 0c        inc     c
2d87 1c        inc     e
2d88 02        ld      (bc),a
2d89 0600      ld      b,00h
2d8b 08        ex      af,af'
2d8c 0b        dec     bc
2d8d 09        add     hl,bc
2d8e 0e07      ld      c,07h
2d90 ff        rst     38h
2d91 ff        rst     38h
2d92 3000      jr      nc,2d94h
2d94 d0        ret     nc

2d95 0d        dec     c
2d96 00        nop     
2d97 95        sub     l
2d98 1808      jr      2da2h
2d9a 04        inc     b
2d9b 02        ld      (bc),a
2d9c 3800      jr      c,2d9eh
2d9e 0c        inc     c
2d9f 1809      jr      2daah
2da1 0a        ld      a,(bc)
2da2 08        ex      af,af'
2da3 07        rlca    
2da4 07        rlca    
2da5 ff        rst     38h
2da6 ff        rst     38h
2da7 5f        ld      e,a
2da8 00        nop     
2da9 d0        ret     nc

2daa a0        and     b
2dab 019710    ld      bc,1097h
2dae 1095      djnz    2d45h
2db0 1010      djnz    2dc2h
2db2 04        inc     b
2db3 0c        inc     c
2db4 1802      jr      2db8h
2db6 0600      ld      b,00h
2db8 08        ex      af,af'
2db9 0a        ld      a,(bc)
2dba 09        add     hl,bc
2dbb 0107ff    ld      bc,0ff07h
2dbe ff        rst     38h
2dbf 3000      jr      nc,2dc1h
2dc1 d0        ret     nc

2dc2 0d        dec     c
2dc3 00        nop     
2dc4 95        sub     l
2dc5 2000      jr      nz,2dc7h
2dc7 02        ld      (bc),a
2dc8 3800      jr      c,2dcah
2dca 0c        inc     c
2dcb 1809      jr      2dd6h
2dcd 0a        ld      a,(bc)
2dce 08        ex      af,af'
2dcf 07        rlca    
2dd0 07        rlca    
2dd1 ff        rst     38h
2dd2 ff        rst     38h
2dd3 5f        ld      e,a
2dd4 00        nop     
2dd5 d0        ret     nc

2dd6 a0        and     b
2dd7 019710    ld      bc,1097h
2dda 00        nop     
2ddb 0c        inc     c
2ddc 1802      jr      2de0h
2dde 0600      ld      b,00h
2de0 08        ex      af,af'
2de1 0f        rrca    
2de2 09        add     hl,bc
2de3 04        inc     b
2de4 07        rlca    
2de5 ff        rst     38h
2de6 ff        rst     38h
2de7 ff        rst     38h
2de8 02        ld      (bc),a
2de9 1080      djnz    2d6bh
2deb 00        nop     
2dec 9a        sbc     a,d
2ded 1010      djnz    2dffh
2def 95        sub     l
2df0 1010      djnz    2e02h
2df2 99        sbc     a,c
2df3 1010      djnz    2e05h
2df5 0c        inc     c
2df6 1e02      ld      e,02h
2df8 0600      ld      b,00h
2dfa 08        ex      af,af'
2dfb 09        add     hl,bc
2dfc 09        add     hl,bc
2dfd 05        dec     b
2dfe 07        rlca    
2dff ff        rst     38h
2e00 ff        rst     38h
2e01 40        ld      b,b
2e02 00        nop     
2e03 c0        ret     nz

2e04 c0        ret     nz

2e05 00        nop     
2e06 9a        sbc     a,d
2e07 1000      djnz    2e09h
2e09 0c        inc     c
2e0a 2002      jr      nz,2e0eh
2e0c 0600      ld      b,00h
2e0e 08        ex      af,af'
2e0f 09        add     hl,bc
2e10 09        add     hl,bc
2e11 0a        ld      a,(bc)
2e12 07        rlca    
2e13 ff        rst     38h
2e14 ff        rst     38h
2e15 40        ld      b,b
2e16 00        nop     
2e17 c0        ret     nz

2e18 c0        ret     nz

2e19 00        nop     
2e1a 9b        sbc     a,e
2e1b 1010      djnz    2e2dh
2e1d 80        add     a,b
2e1e 40        ld      b,b
2e1f 00        nop     
2e20 04        inc     b
2e21 0c        inc     c
2e22 1802      jr      2e26h
2e24 0600      ld      b,00h
2e26 08        ex      af,af'
2e27 0a        ld      a,(bc)
2e28 09        add     hl,bc
2e29 0107ff    ld      bc,0ff07h
2e2c ff        rst     38h
2e2d 3000      jr      nc,2e2fh
2e2f d0        ret     nc

2e30 0d        dec     c
2e31 00        nop     
2e32 95        sub     l
2e33 2000      jr      nz,2e35h
2e35 02        ld      (bc),a
2e36 3800      jr      c,2e38h
2e38 0c        inc     c
2e39 1809      jr      2e44h
2e3b 0a        ld      a,(bc)
2e3c 08        ex      af,af'
2e3d 07        rlca    
2e3e 07        rlca    
2e3f ff        rst     38h
2e40 ff        rst     38h
2e41 5f        ld      e,a
2e42 00        nop     
2e43 d0        ret     nc

2e44 a0        and     b
2e45 019710    ld      bc,1097h
2e48 00        nop     
2e49 0c        inc     c
2e4a 1802      jr      2e4eh
2e4c 0600      ld      b,00h
2e4e 08        ex      af,af'
2e4f 0f        rrca    
2e50 09        add     hl,bc
2e51 04        inc     b
2e52 07        rlca    
2e53 ff        rst     38h
2e54 ff        rst     38h
2e55 ff        rst     38h
2e56 02        ld      (bc),a
2e57 1080      djnz    2dd9h
2e59 00        nop     
2e5a 9a        sbc     a,d
2e5b 1010      djnz    2e6dh
2e5d 95        sub     l
2e5e 1010      djnz    2e70h
2e60 0c        inc     c
2e61 1c        inc     e
2e62 02        ld      (bc),a
2e63 0600      ld      b,00h
2e65 08        ex      af,af'
2e66 0b        dec     bc
2e67 09        add     hl,bc
2e68 0e07      ld      c,07h
2e6a ff        rst     38h
2e6b ff        rst     38h
2e6c 3000      jr      nc,2e6eh
2e6e d0        ret     nc

2e6f 0d        dec     c
2e70 00        nop     
2e71 99        sbc     a,c
2e72 2010      jr      nz,2e84h
2e74 02        ld      (bc),a
2e75 3800      jr      c,2e77h
2e77 0c        inc     c
2e78 1809      jr      2e83h
2e7a 0a        ld      a,(bc)
2e7b 08        ex      af,af'
2e7c 07        rlca    
2e7d 07        rlca    
2e7e ff        rst     38h
2e7f ff        rst     38h
2e80 5f        ld      e,a
2e81 00        nop     
2e82 d0        ret     nc

2e83 a0        and     b
2e84 019710    ld      bc,1097h
2e87 1095      djnz    2e1eh
2e89 1010      djnz    2e9bh
2e8b 97        sub     a
2e8c 1010      djnz    2e9eh
2e8e 04        inc     b
2e8f 0c        inc     c
2e90 1c        inc     e
2e91 02        ld      (bc),a
2e92 0600      ld      b,00h
2e94 08        ex      af,af'
2e95 0b        dec     bc
2e96 09        add     hl,bc
2e97 0e07      ld      c,07h
2e99 ff        rst     38h
2e9a ff        rst     38h
2e9b 3000      jr      nc,2e9dh
2e9d d0        ret     nc

2e9e 0d        dec     c
2e9f 00        nop     
2ea0 9a        sbc     a,d
2ea1 2000      jr      nz,2ea3h
2ea3 02        ld      (bc),a
2ea4 73        ld      (hl),e
2ea5 00        nop     
2ea6 0c        inc     c
2ea7 1809      jr      2eb2h
2ea9 0a        ld      a,(bc)
2eaa 03        inc     bc
2eab 0b        dec     bc
2eac 04        inc     b
2ead 2f        cpl     
2eae 03        inc     bc
2eaf 01b32e    ld      bc,2eb3h
2eb2 04        inc     b
2eb3 0c        inc     c
2eb4 1802      jr      2eb8h
2eb6 0600      ld      b,00h
2eb8 08        ex      af,af'
2eb9 0a        ld      a,(bc)
2eba 09        add     hl,bc
2ebb 0107ff    ld      bc,0ff07h
2ebe ff        rst     38h
2ebf 3000      jr      nc,2ec1h
2ec1 d0        ret     nc

2ec2 0d        dec     c
2ec3 00        nop     
2ec4 9a        sbc     a,d
2ec5 2000      jr      nz,2ec7h
2ec7 0c        inc     c
2ec8 1c        inc     e
2ec9 02        ld      (bc),a
2eca 0600      ld      b,00h
2ecc 08        ex      af,af'
2ecd 0b        dec     bc
2ece 09        add     hl,bc
2ecf 0e07      ld      c,07h
2ed1 ff        rst     38h
2ed2 ff        rst     38h
2ed3 3000      jr      nc,2ed5h
2ed5 d0        ret     nc

2ed6 0d        dec     c
2ed7 00        nop     
2ed8 9b        sbc     a,e
2ed9 2008      jr      nz,2ee3h
2edb 0c        inc     c
2edc 1802      jr      2ee0h
2ede 0600      ld      b,00h
2ee0 08        ex      af,af'
2ee1 0a        ld      a,(bc)
2ee2 09        add     hl,bc
2ee3 0107ff    ld      bc,0ff07h
2ee6 ff        rst     38h
2ee7 3000      jr      nc,2ee9h
2ee9 d0        ret     nc

2eea 0d        dec     c
2eeb 00        nop     
2eec 95        sub     l
2eed 1008      djnz    2ef7h
2eef 0c        inc     c
2ef0 1c        inc     e
2ef1 02        ld      (bc),a
2ef2 0600      ld      b,00h
2ef4 08        ex      af,af'
2ef5 0b        dec     bc
2ef6 09        add     hl,bc
2ef7 0e07      ld      c,07h
2ef9 ff        rst     38h
2efa ff        rst     38h
2efb 3000      jr      nc,2efdh
2efd d0        ret     nc

2efe 0d        dec     c
2eff 00        nop     
2f00 99        sbc     a,c
2f01 1010      djnz    2f13h
2f03 04        inc     b
2f04 08        ex      af,af'
2f05 0d        dec     c
2f06 07        rlca    
2f07 ff        rst     38h
2f08 ff        rst     38h
2f09 cc0c80    call    z,800ch
2f0c 00        nop     
2f0d 019a04    ld      bc,049ah
2f10 04        inc     b
2f11 08        ex      af,af'
2f12 07        rlca    
2f13 07        rlca    
2f14 ff        rst     38h
2f15 ff        rst     38h
2f16 cc0c80    call    z,800ch
2f19 00        nop     
2f1a 019504    ld      bc,0495h
2f1d 04        inc     b
2f1e 08        ex      af,af'
2f1f 0a        ld      a,(bc)
2f20 07        rlca    
2f21 ff        rst     38h
2f22 ff        rst     38h
2f23 cc0c80    call    z,800ch
2f26 00        nop     
2f27 019904    ld      bc,0499h
2f2a 04        inc     b
2f2b 08        ex      af,af'
2f2c 07        rlca    
2f2d 07        rlca    
2f2e ff        rst     38h
2f2f ff        rst     38h
2f30 cc0c80    call    z,800ch
2f33 00        nop     
2f34 019504    ld      bc,0495h
2f37 04        inc     b
2f38 04        inc     b
2f39 1880      jr      2ebbh
2f3b 08        ex      af,af'
2f3c 08        ex      af,af'
2f3d 03        inc     bc
2f3e 01c930    ld      bc,30c9h
2f41 03        inc     bc
2f42 01d230    ld      bc,30d2h
2f45 03        inc     bc
2f46 01c930    ld      bc,30c9h
2f49 02        ld      (bc),a
2f4a 7c        ld      a,h
2f4b 00        nop     
2f4c 0c        inc     c
2f4d 1f        rra     
2f4e 03        inc     bc
2f4f 014830    ld      bc,3048h
2f52 03        inc     bc
2f53 04        inc     b
2f54 213003    ld      hl,0330h
2f57 02        ld      (bc),a
2f58 5d        ld      e,l
2f59 2f        cpl     
2f5a 01412f    ld      bc,2f41h
2f5d 02        ld      (bc),a
2f5e 7c        ld      a,h
2f5f 00        nop     
2f60 0c        inc     c
2f61 1f        rra     
2f62 03        inc     bc
2f63 02        ld      (bc),a
2f64 0630      ld      b,30h
2f66 03        inc     bc
2f67 02        ld      (bc),a
2f68 e8        ret     pe

2f69 2f        cpl     
2f6a 02        ld      (bc),a
2f6b 2c        inc     l
2f6c 00        nop     
2f6d 0c        inc     c
2f6e 1808      jr      2f78h
2f70 0c        inc     c
2f71 09        add     hl,bc
2f72 0a        ld      a,(bc)
2f73 07        rlca    
2f74 ff        rst     38h
2f75 ff        rst     38h
2f76 3f        ccf     
2f77 00        nop     
2f78 e0        ret     po

2f79 73        ld      (hl),e
2f7a 00        nop     
2f7b 97        sub     a
2f7c 1808      jr      2f86h
2f7e 02        ld      (bc),a
2f7f 7c        ld      a,h
2f80 00        nop     
2f81 0c        inc     c
2f82 1f        rra     
2f83 0d        dec     c
2f84 04        inc     b
2f85 03        inc     bc
2f86 02        ld      (bc),a
2f87 0630      ld      b,30h
2f89 03        inc     bc
2f8a 02        ld      (bc),a
2f8b e8        ret     pe

2f8c 2f        cpl     
2f8d 02        ld      (bc),a
2f8e 2c        inc     l
2f8f 00        nop     
2f90 0c        inc     c
2f91 1808      jr      2f9bh
2f93 0c        inc     c
2f94 09        add     hl,bc
2f95 0a        ld      a,(bc)
2f96 07        rlca    
2f97 ff        rst     38h
2f98 ff        rst     38h
2f99 3f        ccf     
2f9a 00        nop     
2f9b e0        ret     po

2f9c 73        ld      (hl),e
2f9d 00        nop     
2f9e 9b        sbc     a,e
2f9f 1808      jr      2fa9h
2fa1 02        ld      (bc),a
2fa2 7c        ld      a,h
2fa3 00        nop     
2fa4 0c        inc     c
2fa5 1f        rra     
2fa6 0d        dec     c
2fa7 ff        rst     38h
2fa8 03        inc     bc
2fa9 02        ld      (bc),a
2faa 0630      ld      b,30h
2fac 03        inc     bc
2fad 02        ld      (bc),a
2fae e8        ret     pe

2faf 2f        cpl     
2fb0 02        ld      (bc),a
2fb1 2c        inc     l
2fb2 00        nop     
2fb3 0c        inc     c
2fb4 1808      jr      2fbeh
2fb6 0c        inc     c
2fb7 09        add     hl,bc
2fb8 0a        ld      a,(bc)
2fb9 07        rlca    
2fba ff        rst     38h
2fbb ff        rst     38h
2fbc 3f        ccf     
2fbd 00        nop     
2fbe e0        ret     po

2fbf 73        ld      (hl),e
2fc0 00        nop     
2fc1 96        sub     (hl)
2fc2 1808      jr      2fcch
2fc4 02        ld      (bc),a
2fc5 7c        ld      a,h
2fc6 00        nop     
2fc7 0c        inc     c
2fc8 1f        rra     
2fc9 0d        dec     c
2fca 02        ld      (bc),a
2fcb 03        inc     bc
2fcc 02        ld      (bc),a
2fcd 0630      ld      b,30h
2fcf 03        inc     bc
2fd0 02        ld      (bc),a
2fd1 e8        ret     pe

2fd2 2f        cpl     
2fd3 02        ld      (bc),a
2fd4 2c        inc     l
2fd5 00        nop     
2fd6 0c        inc     c
2fd7 1808      jr      2fe1h
2fd9 0c        inc     c
2fda 09        add     hl,bc
2fdb 0a        ld      a,(bc)
2fdc 07        rlca    
2fdd ff        rst     38h
2fde ff        rst     38h
2fdf 3f        ccf     
2fe0 00        nop     
2fe1 e0        ret     po

2fe2 73        ld      (hl),e
2fe3 00        nop     
2fe4 99        sbc     a,c
2fe5 1808      jr      2fefh
2fe7 04        inc     b
2fe8 08        ex      af,af'
2fe9 0e07      ld      c,07h
2feb ff        rst     38h
2fec ff        rst     38h
2fed 1100ff    ld      de,0ff00h
2ff0 00        nop     
2ff1 019708    ld      bc,0897h
2ff4 08        ex      af,af'
2ff5 08        ex      af,af'
2ff6 0c        inc     c
2ff7 07        rlca    
2ff8 ff        rst     38h
2ff9 ff        rst     38h
2ffa 2202e0    ld      (0e002h),hl
2ffd e0        ret     po

2ffe 00        nop     
2fff 97        sub     a
3000 0602      ld      b,02h
3002 97        sub     a
3003 0602      ld      b,02h
3005 04        inc     b
3006 08        ex      af,af'
3007 0e07      ld      c,07h
3009 ff        rst     38h
300a ff        rst     38h
300b 1100ff    ld      de,0ff00h
300e 00        nop     
300f 019706    ld      bc,0697h
3012 02        ld      (bc),a
3013 08        ex      af,af'
3014 0c        inc     c
3015 07        rlca    
3016 ff        rst     38h
3017 ff        rst     38h
3018 2202e0    ld      (0e002h),hl
301b e0        ret     po

301c 00        nop     
301d 97        sub     a
301e 0602      ld      b,02h
3020 04        inc     b
3021 02        ld      (bc),a
3022 2c        inc     l
3023 00        nop     
3024 0c        inc     c
3025 1808      jr      302fh
3027 0c        inc     c
3028 09        add     hl,bc
3029 0a        ld      a,(bc)
302a 07        rlca    
302b ff        rst     38h
302c ff        rst     38h
302d 3f        ccf     
302e 00        nop     
302f e0        ret     po

3030 73        ld      (hl),e
3031 00        nop     
3032 92        sub     d
3033 2010      jr      nz,3045h
3035 99        sbc     a,c
3036 1010      djnz    3048h
3038 99        sbc     a,c
3039 1010      djnz    304bh
303b 94        sub     h
303c 1010      djnz    304eh
303e 02        ld      (bc),a
303f 7c        ld      a,h
3040 00        nop     
3041 0c        inc     c
3042 1f        rra     
3043 03        inc     bc
3044 07        rlca    
3045 5d        ld      e,l
3046 3004      jr      nc,304ch
3048 03        inc     bc
3049 105d      djnz    30a8h
304b 3003      jr      nc,3050h
304d 08        ex      af,af'
304e ae        xor     (hl)
304f 3003      jr      nc,3054h
3051 04        inc     b
3052 93        sub     e
3053 3003      jr      nc,3058h
3055 04        inc     b
3056 78        ld      a,b
3057 3003      jr      nc,305ch
3059 205d      jr      nz,30b8h
305b 3004      jr      nc,3061h
305d 08        ex      af,af'
305e 0c        inc     c
305f 07        rlca    
3060 ff        rst     38h
3061 ff        rst     38h
3062 2202e0    ld      (0e002h),hl
3065 e0        ret     po

3066 00        nop     
3067 94        sub     h
3068 0602      ld      b,02h
306a 08        ex      af,af'
306b 0a        ld      a,(bc)
306c 07        rlca    
306d ff        rst     38h
306e ff        rst     38h
306f 33        inc     sp
3070 03        inc     bc
3071 d0        ret     nc

3072 d0        ret     nc

3073 00        nop     
3074 94        sub     h
3075 0602      ld      b,02h
3077 04        inc     b
3078 08        ex      af,af'
3079 0c        inc     c
307a 07        rlca    
307b ff        rst     38h
307c ff        rst     38h
307d 2202e0    ld      (0e002h),hl
3080 e0        ret     po

3081 00        nop     
3082 99        sbc     a,c
3083 0602      ld      b,02h
3085 08        ex      af,af'
3086 0a        ld      a,(bc)
3087 07        rlca    
3088 ff        rst     38h
3089 ff        rst     38h
308a 33        inc     sp
308b 03        inc     bc
308c d0        ret     nc

308d d0        ret     nc

308e 00        nop     
308f 99        sbc     a,c
3090 0602      ld      b,02h
3092 04        inc     b
3093 08        ex      af,af'
3094 0c        inc     c
3095 07        rlca    
3096 ff        rst     38h
3097 ff        rst     38h
3098 2202e0    ld      (0e002h),hl
309b e0        ret     po

309c 00        nop     
309d 92        sub     d
309e 0602      ld      b,02h
30a0 08        ex      af,af'
30a1 0a        ld      a,(bc)
30a2 07        rlca    
30a3 ff        rst     38h
30a4 ff        rst     38h
30a5 33        inc     sp
30a6 03        inc     bc
30a7 d0        ret     nc

30a8 d0        ret     nc

30a9 00        nop     
30aa 92        sub     d
30ab 0602      ld      b,02h
30ad 04        inc     b
30ae 08        ex      af,af'
30af 0c        inc     c
30b0 07        rlca    
30b1 ff        rst     38h
30b2 ff        rst     38h
30b3 2202e0    ld      (0e002h),hl
30b6 e0        ret     po

30b7 00        nop     
30b8 9b        sbc     a,e
30b9 0602      ld      b,02h
30bb 08        ex      af,af'
30bc 0a        ld      a,(bc)
30bd 07        rlca    
30be ff        rst     38h
30bf ff        rst     38h
30c0 33        inc     sp
30c1 03        inc     bc
30c2 d0        ret     nc

30c3 d0        ret     nc

30c4 00        nop     
30c5 9b        sbc     a,e
30c6 0602      ld      b,02h
30c8 04        inc     b
30c9 03        inc     bc
30ca 03        inc     bc
30cb 7a        ld      a,d
30cc 310301    ld      sp,0103h
30cf db30      in      a,(30h)
30d1 04        inc     b
30d2 03        inc     bc
30d3 03        inc     bc
30d4 7a        ld      a,d
30d5 310301    ld      sp,0103h
30d8 f9        ld      sp,hl
30d9 3004      jr      nc,30dfh
30db 02        ld      (bc),a
30dc 2c        inc     l
30dd 00        nop     
30de 0c        inc     c
30df 1808      jr      30e9h
30e1 0c        inc     c
30e2 09        add     hl,bc
30e3 0a        ld      a,(bc)
30e4 07        rlca    
30e5 ff        rst     38h
30e6 ff        rst     38h
30e7 3f        ccf     
30e8 00        nop     
30e9 e0        ret     po

30ea 73        ld      (hl),e
30eb 00        nop     
30ec 93        sub     e
30ed 1010      djnz    30ffh
30ef 94        sub     h
30f0 1018      djnz    310ah
30f2 9b        sbc     a,e
30f3 1008      djnz    30fdh
30f5 96        sub     (hl)
30f6 1010      djnz    3108h
30f8 04        inc     b
30f9 08        ex      af,af'
30fa 0e07      ld      c,07h
30fc ff        rst     38h
30fd ff        rst     38h
30fe 1100ff    ld      de,0ff00h
3101 00        nop     
3102 019306    ld      bc,0693h
3105 02        ld      (bc),a
3106 08        ex      af,af'
3107 0c        inc     c
3108 07        rlca    
3109 ff        rst     38h
310a ff        rst     38h
310b 2202e0    ld      (0e002h),hl
310e e0        ret     po

310f 00        nop     
3110 93        sub     e
3111 0602      ld      b,02h
3113 93        sub     e
3114 0602      ld      b,02h
3116 93        sub     e
3117 0602      ld      b,02h
3119 08        ex      af,af'
311a 0e07      ld      c,07h
311c ff        rst     38h
311d ff        rst     38h
311e 1100ff    ld      de,0ff00h
3121 00        nop     
3122 019406    ld      bc,0694h
3125 02        ld      (bc),a
3126 08        ex      af,af'
3127 0c        inc     c
3128 07        rlca    
3129 ff        rst     38h
312a ff        rst     38h
312b 2202e0    ld      (0e002h),hl
312e e0        ret     po

312f 00        nop     
3130 94        sub     h
3131 0602      ld      b,02h
3133 94        sub     h
3134 0602      ld      b,02h
3136 94        sub     h
3137 0602      ld      b,02h
3139 94        sub     h
313a 0602      ld      b,02h
313c 08        ex      af,af'
313d 0e07      ld      c,07h
313f ff        rst     38h
3140 ff        rst     38h
3141 1100ff    ld      de,0ff00h
3144 00        nop     
3145 019b06    ld      bc,069bh
3148 02        ld      (bc),a
3149 08        ex      af,af'
314a 0c        inc     c
314b 07        rlca    
314c ff        rst     38h
314d ff        rst     38h
314e 2202e0    ld      (0e002h),hl
3151 e0        ret     po

3152 00        nop     
3153 9b        sbc     a,e
3154 0602      ld      b,02h
3156 9b        sbc     a,e
3157 0602      ld      b,02h
3159 08        ex      af,af'
315a 0e07      ld      c,07h
315c ff        rst     38h
315d ff        rst     38h
315e 1100ff    ld      de,0ff00h
3161 00        nop     
3162 019a06    ld      bc,069ah
3165 02        ld      (bc),a
3166 08        ex      af,af'
3167 0c        inc     c
3168 07        rlca    
3169 ff        rst     38h
316a ff        rst     38h
316b 2202e0    ld      (0e002h),hl
316e e0        ret     po

316f 00        nop     
3170 9a        sbc     a,d
3171 0602      ld      b,02h
3173 9a        sbc     a,d
3174 0602      ld      b,02h
3176 9a        sbc     a,d
3177 0602      ld      b,02h
3179 04        inc     b
317a 02        ld      (bc),a
317b 7c        ld      a,h
317c 00        nop     
317d 0c        inc     c
317e 1f        rra     
317f 09        add     hl,bc
3180 0b        dec     bc
3181 08        ex      af,af'
3182 0e07      ld      c,07h
3184 ff        rst     38h
3185 ff        rst     38h
3186 1100ff    ld      de,0ff00h
3189 00        nop     
318a 019606    ld      bc,0696h
318d 02        ld      (bc),a
318e 95        sub     l
318f 0602      ld      b,02h
3191 08        ex      af,af'
3192 0c        inc     c
3193 07        rlca    
3194 ff        rst     38h
3195 ff        rst     38h
3196 2202e0    ld      (0e002h),hl
3199 e0        ret     po

319a 00        nop     
319b 95        sub     l
319c 0602      ld      b,02h
319e 95        sub     l
319f 0602      ld      b,02h
31a1 08        ex      af,af'
31a2 0e07      ld      c,07h
31a4 ff        rst     38h
31a5 ff        rst     38h
31a6 1100ff    ld      de,0ff00h
31a9 00        nop     
31aa 019506    ld      bc,0695h
31ad 02        ld      (bc),a
31ae 08        ex      af,af'
31af 0c        inc     c
31b0 07        rlca    
31b1 ff        rst     38h
31b2 ff        rst     38h
31b3 2202e0    ld      (0e002h),hl
31b6 e0        ret     po

31b7 00        nop     
31b8 95        sub     l
31b9 0602      ld      b,02h
31bb 95        sub     l
31bc 0602      ld      b,02h
31be 95        sub     l
31bf 0602      ld      b,02h
31c1 08        ex      af,af'
31c2 0e07      ld      c,07h
31c4 ff        rst     38h
31c5 ff        rst     38h
31c6 1100ff    ld      de,0ff00h
31c9 00        nop     
31ca 019606    ld      bc,0696h
31cd 02        ld      (bc),a
31ce 08        ex      af,af'
31cf 0c        inc     c
31d0 07        rlca    
31d1 ff        rst     38h
31d2 ff        rst     38h
31d3 2202e0    ld      (0e002h),hl
31d6 e0        ret     po

31d7 00        nop     
31d8 95        sub     l
31d9 0602      ld      b,02h
31db 95        sub     l
31dc 0602      ld      b,02h
31de 95        sub     l
31df 0602      ld      b,02h
31e1 08        ex      af,af'
31e2 0e07      ld      c,07h
31e4 ff        rst     38h
31e5 ff        rst     38h
31e6 1100ff    ld      de,0ff00h
31e9 00        nop     
31ea 019b06    ld      bc,069bh
31ed 02        ld      (bc),a
31ee 08        ex      af,af'
31ef 0c        inc     c
31f0 07        rlca    
31f1 ff        rst     38h
31f2 ff        rst     38h
31f3 2202e0    ld      (0e002h),hl
31f6 e0        ret     po

31f7 00        nop     
31f8 95        sub     l
31f9 0602      ld      b,02h
31fb 95        sub     l
31fc 0602      ld      b,02h
31fe 95        sub     l
31ff 0602      ld      b,02h
3201 04        inc     b
3202 1880      jr      3184h
3204 08        ex      af,af'
3205 08        ex      af,af'
3206 0c        inc     c
3207 2c        inc     l
3208 02        ld      (bc),a
3209 2d        dec     l
320a 00        nop     
320b 07        rlca    
320c ff        rst     38h
320d ff        rst     38h
320e 0100ff    ld      bc,0ff00h
3211 00        nop     
3212 110908    ld      de,0809h
3215 80        add     a,b
3216 80        add     a,b
3217 80        add     a,b
3218 80        add     a,b
3219 80        add     a,b
321a 00        nop     
321b 03        inc     bc
321c 017534    ld      bc,3475h
321f 03        inc     bc
3220 02        ld      (bc),a
3221 6c        ld      l,h
3222 34        inc     (hl)
3223 03        inc     bc
3224 017233    ld      bc,3372h
3227 03        inc     bc
3228 02        ld      (bc),a
3229 a2        and     d
322a 320302    ld      (0203h),a
322d 323201    ld      (0132h),a
3230 1f        rra     
3231 320301    ld      (0103h),a
3234 4b        ld      c,e
3235 320d04    ld      (040dh),a
3238 03        inc     bc
3239 014b32    ld      bc,324bh
323c 0d        dec     c
323d fb        ei      
323e 03        inc     bc
323f 014b32    ld      bc,324bh
3242 0d        dec     c
3243 03        inc     bc
3244 03        inc     bc
3245 014b32    ld      bc,324bh
3248 0d        dec     c
3249 fe04      cp      04h
324b 08        ex      af,af'
324c 0f        rrca    
324d 07        rlca    
324e ff        rst     38h
324f ff        rst     38h
3250 5f        ld      e,a
3251 015055    ld      bc,5550h
3254 05        dec     b
3255 8b        adc     a,e
3256 0602      ld      b,02h
3258 08        ex      af,af'
3259 0c        inc     c
325a 07        rlca    
325b ff        rst     38h
325c ff        rst     38h
325d ff        rst     38h
325e 014044    ld      bc,4440h
3261 04        inc     b
3262 8b        adc     a,e
3263 0602      ld      b,02h
3265 08        ex      af,af'
3266 0f        rrca    
3267 07        rlca    
3268 ff        rst     38h
3269 ff        rst     38h
326a 5f        ld      e,a
326b 015055    ld      bc,5550h
326e 05        dec     b
326f 8b        adc     a,e
3270 0602      ld      b,02h
3272 08        ex      af,af'
3273 0c        inc     c
3274 07        rlca    
3275 ff        rst     38h
3276 ff        rst     38h
3277 ff        rst     38h
3278 014044    ld      bc,4440h
327b 04        inc     b
327c 8b        adc     a,e
327d 0602      ld      b,02h
327f 03        inc     bc
3280 03        inc     bc
3281 84        add     a,h
3282 320408    ld      (0804h),a
3285 0f        rrca    
3286 07        rlca    
3287 ff        rst     38h
3288 ff        rst     38h
3289 5f        ld      e,a
328a 015055    ld      bc,5550h
328d 05        dec     b
328e 8b        adc     a,e
328f 08        ex      af,af'
3290 08        ex      af,af'
3291 08        ex      af,af'
3292 0c        inc     c
3293 07        rlca    
3294 ff        rst     38h
3295 ff        rst     38h
3296 ff        rst     38h
3297 014044    ld      bc,4440h
329a 04        inc     b
329b 8b        adc     a,e
329c 0602      ld      b,02h
329e 8b        adc     a,e
329f 0602      ld      b,02h
32a1 04        inc     b
32a2 03        inc     bc
32a3 012933    ld      bc,3329h
32a6 03        inc     bc
32a7 01ab32    ld      bc,32abh
32aa 04        inc     b
32ab 08        ex      af,af'
32ac 0f        rrca    
32ad 07        rlca    
32ae ff        rst     38h
32af ff        rst     38h
32b0 5f        ld      e,a
32b1 015055    ld      bc,5550h
32b4 05        dec     b
32b5 86        add     a,(hl)
32b6 0602      ld      b,02h
32b8 86        add     a,(hl)
32b9 0602      ld      b,02h
32bb 08        ex      af,af'
32bc 0c        inc     c
32bd 07        rlca    
32be ff        rst     38h
32bf ff        rst     38h
32c0 ff        rst     38h
32c1 014044    ld      bc,4440h
32c4 04        inc     b
32c5 86        add     a,(hl)
32c6 0602      ld      b,02h
32c8 86        add     a,(hl)
32c9 0602      ld      b,02h
32cb 08        ex      af,af'
32cc 0f        rrca    
32cd 07        rlca    
32ce ff        rst     38h
32cf ff        rst     38h
32d0 5f        ld      e,a
32d1 015055    ld      bc,5550h
32d4 05        dec     b
32d5 86        add     a,(hl)
32d6 08        ex      af,af'
32d7 08        ex      af,af'
32d8 85        add     a,l
32d9 1010      djnz    32ebh
32db 8d        adc     a,l
32dc 1010      djnz    32eeh
32de 88        adc     a,b
32df 1010      djnz    32f1h
32e1 88        adc     a,b
32e2 08        ex      af,af'
32e3 08        ex      af,af'
32e4 88        adc     a,b
32e5 08        ex      af,af'
32e6 08        ex      af,af'
32e7 08        ex      af,af'
32e8 0c        inc     c
32e9 07        rlca    
32ea ff        rst     38h
32eb ff        rst     38h
32ec ff        rst     38h
32ed 014044    ld      bc,4440h
32f0 04        inc     b
32f1 88        adc     a,b
32f2 08        ex      af,af'
32f3 08        ex      af,af'
32f4 08        ex      af,af'
32f5 0f        rrca    
32f6 07        rlca    
32f7 ff        rst     38h
32f8 ff        rst     38h
32f9 5f        ld      e,a
32fa 015055    ld      bc,5550h
32fd 05        dec     b
32fe 88        adc     a,b
32ff 08        ex      af,af'
3300 08        ex      af,af'
3301 08        ex      af,af'
3302 0c        inc     c
3303 07        rlca    
3304 ff        rst     38h
3305 ff        rst     38h
3306 ff        rst     38h
3307 014044    ld      bc,4440h
330a 04        inc     b
330b 88        adc     a,b
330c 08        ex      af,af'
330d 08        ex      af,af'
330e 08        ex      af,af'
330f 0f        rrca    
3310 07        rlca    
3311 ff        rst     38h
3312 ff        rst     38h
3313 5f        ld      e,a
3314 015055    ld      bc,5550h
3317 05        dec     b
3318 88        adc     a,b
3319 08        ex      af,af'
331a 08        ex      af,af'
331b 08        ex      af,af'
331c 0c        inc     c
331d 07        rlca    
331e ff        rst     38h
331f ff        rst     38h
3320 ff        rst     38h
3321 014044    ld      bc,4440h
3324 04        inc     b
3325 88        adc     a,b
3326 08        ex      af,af'
3327 08        ex      af,af'
3328 04        inc     b
3329 08        ex      af,af'
332a 0f        rrca    
332b 07        rlca    
332c ff        rst     38h
332d ff        rst     38h
332e 5f        ld      e,a
332f 015055    ld      bc,5550h
3332 05        dec     b
3333 86        add     a,(hl)
3334 08        ex      af,af'
3335 08        ex      af,af'
3336 88        adc     a,b
3337 08        ex      af,af'
3338 08        ex      af,af'
3339 8a        adc     a,d
333a 08        ex      af,af'
333b 08        ex      af,af'
333c 85        add     a,l
333d 1010      djnz    334fh
333f 8d        adc     a,l
3340 1010      djnz    3352h
3342 8c        adc     a,h
3343 1010      djnz    3355h
3345 08        ex      af,af'
3346 0c        inc     c
3347 07        rlca    
3348 ff        rst     38h
3349 ff        rst     38h
334a ff        rst     38h
334b 014044    ld      bc,4440h
334e 04        inc     b
334f 8c        adc     a,h
3350 08        ex      af,af'
3351 08        ex      af,af'
3352 03        inc     bc
3353 03        inc     bc
3354 57        ld      d,a
3355 33        inc     sp
3356 04        inc     b
3357 08        ex      af,af'
3358 0f        rrca    
3359 07        rlca    
335a ff        rst     38h
335b ff        rst     38h
335c 5f        ld      e,a
335d 015055    ld      bc,5550h
3360 05        dec     b
3361 8c        adc     a,h
3362 08        ex      af,af'
3363 08        ex      af,af'
3364 08        ex      af,af'
3365 0c        inc     c
3366 07        rlca    
3367 ff        rst     38h
3368 ff        rst     38h
3369 ff        rst     38h
336a 014044    ld      bc,4440h
336d 04        inc     b
336e 8c        adc     a,h
336f 08        ex      af,af'
3370 08        ex      af,af'
3371 04        inc     b
3372 03        inc     bc
3373 08        ex      af,af'
3374 51        ld      d,c
3375 34        inc     (hl)
3376 03        inc     bc
3377 04        inc     b
3378 3634      ld      (hl),34h
337a 03        inc     bc
337b 04        inc     b
337c 1b        dec     de
337d 34        inc     (hl)
337e 03        inc     bc
337f 08        ex      af,af'
3380 51        ld      d,c
3381 34        inc     (hl)
3382 03        inc     bc
3383 018733    ld      bc,3387h
3386 04        inc     b
3387 08        ex      af,af'
3388 0f        rrca    
3389 07        rlca    
338a ff        rst     38h
338b ff        rst     38h
338c 5f        ld      e,a
338d 015055    ld      bc,5550h
3390 05        dec     b
3391 8c        adc     a,h
3392 08        ex      af,af'
3393 08        ex      af,af'
3394 8d        adc     a,l
3395 08        ex      af,af'
3396 08        ex      af,af'
3397 8e        adc     a,(hl)
3398 08        ex      af,af'
3399 08        ex      af,af'
339a 08        ex      af,af'
339b 0e07      ld      c,07h
339d ff        rst     38h
339e ff        rst     38h
339f 2000      jr      nz,33a1h
33a1 e0        ret     po

33a2 ee0e      xor     0eh
33a4 0a        ld      a,(bc)
33a5 08        ex      af,af'
33a6 02        ld      (bc),a
33a7 1602      ld      d,02h
33a9 8f        adc     a,a
33aa 1808      jr      33b4h
33ac 0b        dec     bc
33ad 08        ex      af,af'
33ae 0f        rrca    
33af 07        rlca    
33b0 ff        rst     38h
33b1 ff        rst     38h
33b2 5f        ld      e,a
33b3 015055    ld      bc,5550h
33b6 05        dec     b
33b7 83        add     a,e
33b8 08        ex      af,af'
33b9 08        ex      af,af'
33ba 85        add     a,l
33bb 08        ex      af,af'
33bc 08        ex      af,af'
33bd 08        ex      af,af'
33be 0e07      ld      c,07h
33c0 ff        rst     38h
33c1 ff        rst     38h
33c2 2000      jr      nz,33c4h
33c4 e0        ret     po

33c5 ee0e      xor     0eh
33c7 0a        ld      a,(bc)
33c8 08        ex      af,af'
33c9 02        ld      (bc),a
33ca 1602      ld      d,02h
33cc 86        add     a,(hl)
33cd 1808      jr      33d7h
33cf 0b        dec     bc
33d0 08        ex      af,af'
33d1 0f        rrca    
33d2 07        rlca    
33d3 ff        rst     38h
33d4 ff        rst     38h
33d5 5f        ld      e,a
33d6 015055    ld      bc,5550h
33d9 05        dec     b
33da 88        adc     a,b
33db 08        ex      af,af'
33dc 08        ex      af,af'
33dd 8a        adc     a,d
33de 08        ex      af,af'
33df 08        ex      af,af'
33e0 08        ex      af,af'
33e1 0e07      ld      c,07h
33e3 ff        rst     38h
33e4 ff        rst     38h
33e5 2000      jr      nz,33e7h
33e7 e0        ret     po

33e8 ee0e      xor     0eh
33ea 0a        ld      a,(bc)
33eb 08        ex      af,af'
33ec 02        ld      (bc),a
33ed 1602      ld      d,02h
33ef 8d        adc     a,l
33f0 1808      jr      33fah
33f2 0b        dec     bc
33f3 08        ex      af,af'
33f4 0c        inc     c
33f5 07        rlca    
33f6 ff        rst     38h
33f7 ff        rst     38h
33f8 ff        rst     38h
33f9 014044    ld      bc,4440h
33fc 04        inc     b
33fd 8d        adc     a,l
33fe 08        ex      af,af'
33ff 08        ex      af,af'
3400 08        ex      af,af'
3401 0f        rrca    
3402 07        rlca    
3403 ff        rst     38h
3404 ff        rst     38h
3405 5f        ld      e,a
3406 015055    ld      bc,5550h
3409 05        dec     b
340a 8f        adc     a,a
340b 08        ex      af,af'
340c 08        ex      af,af'
340d 08        ex      af,af'
340e 0c        inc     c
340f 07        rlca    
3410 ff        rst     38h
3411 ff        rst     38h
3412 ff        rst     38h
3413 014044    ld      bc,4440h
3416 04        inc     b
3417 8d        adc     a,l
3418 08        ex      af,af'
3419 08        ex      af,af'
341a 04        inc     b
341b 08        ex      af,af'
341c 0f        rrca    
341d 07        rlca    
341e ff        rst     38h
341f ff        rst     38h
3420 5f        ld      e,a
3421 015055    ld      bc,5550h
3424 05        dec     b
3425 86        add     a,(hl)
3426 08        ex      af,af'
3427 08        ex      af,af'
3428 08        ex      af,af'
3429 0c        inc     c
342a 07        rlca    
342b ff        rst     38h
342c ff        rst     38h
342d ff        rst     38h
342e 014044    ld      bc,4440h
3431 04        inc     b
3432 86        add     a,(hl)
3433 08        ex      af,af'
3434 08        ex      af,af'
3435 04        inc     b
3436 08        ex      af,af'
3437 0f        rrca    
3438 07        rlca    
3439 ff        rst     38h
343a ff        rst     38h
343b 5f        ld      e,a
343c 015055    ld      bc,5550h
343f 05        dec     b
3440 8f        adc     a,a
3441 08        ex      af,af'
3442 08        ex      af,af'
3443 08        ex      af,af'
3444 0c        inc     c
3445 07        rlca    
3446 ff        rst     38h
3447 ff        rst     38h
3448 ff        rst     38h
3449 014044    ld      bc,4440h
344c 04        inc     b
344d 8f        adc     a,a
344e 08        ex      af,af'
344f 08        ex      af,af'
3450 04        inc     b
3451 08        ex      af,af'
3452 0f        rrca    
3453 07        rlca    
3454 ff        rst     38h
3455 ff        rst     38h
3456 5f        ld      e,a
3457 015055    ld      bc,5550h
345a 05        dec     b
345b 88        adc     a,b
345c 08        ex      af,af'
345d 08        ex      af,af'
345e 08        ex      af,af'
345f 0c        inc     c
3460 07        rlca    
3461 ff        rst     38h
3462 ff        rst     38h
3463 ff        rst     38h
3464 014044    ld      bc,4440h
3467 04        inc     b
3468 88        adc     a,b
3469 08        ex      af,af'
346a 08        ex      af,af'
346b 04        inc     b
346c 03        inc     bc
346d 0c        inc     c
346e e43403    call    po,0334h
3471 017534    ld      bc,3475h
3474 04        inc     b
3475 08        ex      af,af'
3476 0f        rrca    
3477 07        rlca    
3478 ff        rst     38h
3479 ff        rst     38h
347a 5f        ld      e,a
347b 015055    ld      bc,5550h
347e 05        dec     b
347f 87        add     a,a
3480 08        ex      af,af'
3481 08        ex      af,af'
3482 08        ex      af,af'
3483 0c        inc     c
3484 07        rlca    
3485 ff        rst     38h
3486 ff        rst     38h
3487 ff        rst     38h
3488 014044    ld      bc,4440h
348b 04        inc     b
348c 87        add     a,a
348d 08        ex      af,af'
348e 08        ex      af,af'
348f 08        ex      af,af'
3490 0f        rrca    
3491 07        rlca    
3492 ff        rst     38h
3493 ff        rst     38h
3494 5f        ld      e,a
3495 015055    ld      bc,5550h
3498 05        dec     b
3499 88        adc     a,b
349a 08        ex      af,af'
349b 08        ex      af,af'
349c 08        ex      af,af'
349d 0c        inc     c
349e 07        rlca    
349f ff        rst     38h
34a0 ff        rst     38h
34a1 ff        rst     38h
34a2 014044    ld      bc,4440h
34a5 04        inc     b
34a6 88        adc     a,b
34a7 08        ex      af,af'
34a8 08        ex      af,af'
34a9 08        ex      af,af'
34aa 0a        ld      a,(bc)
34ab 07        rlca    
34ac ff        rst     38h
34ad ff        rst     38h
34ae 24        inc     h
34af 03        inc     bc
34b0 50        ld      d,b
34b1 00        nop     
34b2 0a        ld      a,(bc)
34b3 88        adc     a,b
34b4 08        ex      af,af'
34b5 00        nop     
34b6 08        ex      af,af'
34b7 0e07      ld      c,07h
34b9 ff        rst     38h
34ba ff        rst     38h
34bb 2000      jr      nz,34bdh
34bd e0        ret     po

34be ee0e      xor     0eh
34c0 0a        ld      a,(bc)
34c1 08        ex      af,af'
34c2 02        ld      (bc),a
34c3 1602      ld      d,02h
34c5 8f        adc     a,a
34c6 1602      ld      d,02h
34c8 0b        dec     bc
34c9 08        ex      af,af'
34ca 0f        rrca    
34cb 07        rlca    
34cc ff        rst     38h
34cd ff        rst     38h
34ce 5f        ld      e,a
34cf 015055    ld      bc,5550h
34d2 05        dec     b
34d3 8e        adc     a,(hl)
34d4 08        ex      af,af'
34d5 08        ex      af,af'
34d6 08        ex      af,af'
34d7 0c        inc     c
34d8 07        rlca    
34d9 ff        rst     38h
34da ff        rst     38h
34db ff        rst     38h
34dc 014044    ld      bc,4440h
34df 04        inc     b
34e0 8e        adc     a,(hl)
34e1 08        ex      af,af'
34e2 08        ex      af,af'
34e3 04        inc     b
34e4 08        ex      af,af'
34e5 0f        rrca    
34e6 07        rlca    
34e7 ff        rst     38h
34e8 ff        rst     38h
34e9 5f        ld      e,a
34ea 015055    ld      bc,5550h
34ed 05        dec     b
34ee 8c        adc     a,h
34ef 08        ex      af,af'
34f0 08        ex      af,af'
34f1 08        ex      af,af'
34f2 0c        inc     c
34f3 07        rlca    
34f4 ff        rst     38h
34f5 ff        rst     38h
34f6 ff        rst     38h
34f7 014044    ld      bc,4440h
34fa 04        inc     b
34fb 8c        adc     a,h
34fc 08        ex      af,af'
34fd 08        ex      af,af'
34fe 04        inc     b
34ff 1880      jr      3481h
3501 08        ex      af,af'
3502 08        ex      af,af'
3503 02        ld      (bc),a
3504 34        inc     (hl)
3505 00        nop     
3506 0c        inc     c
3507 1807      jr      3510h
3509 92        sub     d
350a 24        inc     h
350b 2000      jr      nz,350dh
350d e0        ret     po

350e 92        sub     d
350f 00        nop     
3510 08        ex      af,af'
3511 05        dec     b
3512 09        add     hl,bc
3513 05        dec     b
3514 03        inc     bc
3515 016c35    ld      bc,356ch
3518 03        inc     bc
3519 02        ld      (bc),a
351a 6c        ld      l,h
351b 35        dec     (hl)
351c 03        inc     bc
351d 03        inc     bc
351e 5f        ld      e,a
351f 35        dec     (hl)
3520 03        inc     bc
3521 015235    ld      bc,3552h
3524 03        inc     bc
3525 04        inc     b
3526 3c        inc     a
3527 35        dec     (hl)
3528 03        inc     bc
3529 02        ld      (bc),a
352a 2f        cpl     
352b 35        dec     (hl)
352c 011835    ld      bc,3518h
352f a2        and     d
3530 60        ld      h,b
3531 20a2      jr      nz,34d5h
3533 60        ld      h,b
3534 20a2      jr      nz,34d8h
3536 60        ld      h,b
3537 20a0      jr      nz,34d9h
3539 60        ld      h,b
353a 2004      jr      nz,3540h
353c a2        and     d
353d 2010      jr      nz,354fh
353f a0        and     b
3540 1010      djnz    3552h
3542 a0        and     b
3543 1010      djnz    3555h
3545 a0        and     b
3546 2010      jr      nz,3558h
3548 a0        and     b
3549 1010      djnz    355bh
354b a0        and     b
354c 1010      djnz    355eh
354e a0        and     b
354f 1010      djnz    3561h
3551 04        inc     b
3552 95        sub     l
3553 2010      jr      nz,3565h
3555 96        sub     (hl)
3556 3010      jr      nc,3568h
3558 96        sub     (hl)
3559 3010      jr      nc,356bh
355b 94        sub     h
355c 3020      jr      nc,357eh
355e 04        inc     b
355f 95        sub     l
3560 2010      jr      nz,3572h
3562 96        sub     (hl)
3563 3020      jr      nc,3585h
3565 96        sub     (hl)
3566 2010      jr      nz,3578h
3568 94        sub     h
3569 3020      jr      nc,358bh
356b 04        inc     b
356c 9f        sbc     a,a
356d 40        ld      b,b
356e 40        ld      b,b
356f 9d        sbc     a,l
3570 40        ld      b,b
3571 40        ld      b,b
3572 a0        and     b
3573 40        ld      b,b
3574 40        ld      b,b
3575 a2        and     d
3576 1010      djnz    3588h
3578 a2        and     d
3579 1810      jr      358bh
357b a2        and     d
357c 1008      djnz    3586h
357e a2        and     d
357f 1010      djnz    3591h
3581 04        inc     b
3582 1880      jr      3504h
3584 08        ex      af,af'
3585 08        ex      af,af'
3586 02        ld      (bc),a
3587 34        inc     (hl)
3588 00        nop     
3589 0c        inc     c
358a 1807      jr      3593h
358c 92        sub     d
358d 24        inc     h
358e 2000      jr      nz,3590h
3590 e0        ret     po

3591 92        sub     d
3592 00        nop     
3593 08        ex      af,af'
3594 05        dec     b
3595 09        add     hl,bc
3596 0c        inc     c
3597 03        inc     bc
3598 01ef35    ld      bc,35efh
359b 03        inc     bc
359c 02        ld      (bc),a
359d ef        rst     28h
359e 35        dec     (hl)
359f 03        inc     bc
35a0 03        inc     bc
35a1 e23503    jp      po,0335h
35a4 01d535    ld      bc,35d5h
35a7 03        inc     bc
35a8 04        inc     b
35a9 bf        cp      a
35aa 35        dec     (hl)
35ab 03        inc     bc
35ac 02        ld      (bc),a
35ad b2        or      d
35ae 35        dec     (hl)
35af 019b35    ld      bc,359bh
35b2 9e        sbc     a,(hl)
35b3 60        ld      h,b
35b4 209e      jr      nz,3554h
35b6 60        ld      h,b
35b7 209d      jr      nz,3556h
35b9 60        ld      h,b
35ba 209d      jr      nz,3559h
35bc 60        ld      h,b
35bd 2004      jr      nz,35c3h
35bf 9e        sbc     a,(hl)
35c0 2010      jr      nz,35d2h
35c2 9d        sbc     a,l
35c3 1010      djnz    35d5h
35c5 9d        sbc     a,l
35c6 1010      djnz    35d8h
35c8 9b        sbc     a,e
35c9 2010      jr      nz,35dbh
35cb 9b        sbc     a,e
35cc 1010      djnz    35deh
35ce 9b        sbc     a,e
35cf 1010      djnz    35e1h
35d1 9b        sbc     a,e
35d2 1010      djnz    35e4h
35d4 04        inc     b
35d5 94        sub     h
35d6 2010      jr      nz,35e8h
35d8 93        sub     e
35d9 3010      jr      nc,35ebh
35db 92        sub     d
35dc 3010      jr      nc,35eeh
35de 91        sub     c
35df 3020      jr      nc,3601h
35e1 04        inc     b
35e2 94        sub     h
35e3 2010      jr      nz,35f5h
35e5 93        sub     e
35e6 3020      jr      nc,3608h
35e8 92        sub     d
35e9 2010      jr      nz,35fbh
35eb 91        sub     c
35ec 3020      jr      nc,360eh
35ee 04        inc     b
35ef 9b        sbc     a,e
35f0 40        ld      b,b
35f1 40        ld      b,b
35f2 9a        sbc     a,d
35f3 40        ld      b,b
35f4 40        ld      b,b
35f5 9b        sbc     a,e
35f6 40        ld      b,b
35f7 40        ld      b,b
35f8 9d        sbc     a,l
35f9 1010      djnz    360bh
35fb 9b        sbc     a,e
35fc 1810      jr      360eh
35fe 9f        sbc     a,a
35ff 1008      djnz    3609h
3601 9d        sbc     a,l
3602 1010      djnz    3614h
3604 04        inc     b
3605 1880      jr      3587h
3607 08        ex      af,af'
3608 08        ex      af,af'
3609 02        ld      (bc),a
360a 34        inc     (hl)
360b 00        nop     
360c 0c        inc     c
360d 1807      jr      3616h
360f 92        sub     d
3610 24        inc     h
3611 2000      jr      nz,3613h
3613 e0        ret     po

3614 92        sub     d
3615 00        nop     
3616 08        ex      af,af'
3617 05        dec     b
3618 09        add     hl,bc
3619 010301    ld      bc,0103h
361c 87        add     a,a
361d 3603      ld      (hl),03h
361f 02        ld      (bc),a
3620 87        add     a,a
3621 3603      ld      (hl),03h
3623 03        inc     bc
3624 7a        ld      a,d
3625 3603      ld      (hl),03h
3627 016d36    ld      bc,366dh
362a 03        inc     bc
362b 02        ld      (bc),a
362c 42        ld      b,d
362d 3603      ld      (hl),03h
362f 02        ld      (bc),a
3630 35        dec     (hl)
3631 3601      ld      (hl),01h
3633 1e36      ld      e,36h
3635 9b        sbc     a,e
3636 60        ld      h,b
3637 209b      jr      nz,35d4h
3639 60        ld      h,b
363a 2099      jr      nz,35d5h
363c 60        ld      h,b
363d 2099      jr      nz,35d8h
363f 60        ld      h,b
3640 2004      jr      nz,3646h
3642 99        sbc     a,c
3643 2010      jr      nz,3655h
3645 99        sbc     a,c
3646 1010      djnz    3658h
3648 99        sbc     a,c
3649 1010      djnz    365bh
364b 95        sub     l
364c 2010      jr      nz,365eh
364e 95        sub     l
364f 1010      djnz    3661h
3651 95        sub     l
3652 1010      djnz    3664h
3654 95        sub     l
3655 1010      djnz    3667h
3657 99        sbc     a,c
3658 2010      jr      nz,366ah
365a 99        sbc     a,c
365b 1010      djnz    366dh
365d 99        sbc     a,c
365e 1010      djnz    3670h
3660 a4        and     h
3661 2010      jr      nz,3673h
3663 a4        and     h
3664 1010      djnz    3676h
3666 a4        and     h
3667 1010      djnz    3679h
3669 a4        and     h
366a 1010      djnz    367ch
366c 04        inc     b
366d 8f        adc     a,a
366e 2010      jr      nz,3680h
3670 8f        adc     a,a
3671 3010      jr      nc,3683h
3673 8d        adc     a,l
3674 3010      jr      nc,3686h
3676 8d        adc     a,l
3677 3020      jr      nc,3699h
3679 04        inc     b
367a 8f        adc     a,a
367b 2010      jr      nz,368dh
367d 8f        adc     a,a
367e 3020      jr      nc,36a0h
3680 8d        adc     a,l
3681 2010      jr      nz,3693h
3683 8d        adc     a,l
3684 3020      jr      nc,36a6h
3686 04        inc     b
3687 95        sub     l
3688 40        ld      b,b
3689 40        ld      b,b
368a 96        sub     (hl)
368b 40        ld      b,b
368c 40        ld      b,b
368d 95        sub     l
368e 40        ld      b,b
368f 40        ld      b,b
3690 9a        sbc     a,d
3691 1010      djnz    36a3h
3693 95        sub     l
3694 1810      jr      36a6h
3696 9b        sbc     a,e
3697 1008      djnz    36a1h
3699 9a        sbc     a,d
369a 1010      djnz    36ach
369c 04        inc     b
369d 19        add     hl,de
369e 80        add     a,b
369f 1002      djnz    36a3h
36a1 02        ld      (bc),a
36a2 00        nop     
36a3 0c        inc     c
36a4 24        inc     h
36a5 07        rlca    
36a6 ff        rst     38h
36a7 ff        rst     38h
36a8 0100ff    ld      bc,0ff00h
36ab 00        nop     
36ac 0f        rrca    
36ad 03        inc     bc
36ae 03        inc     bc
36af c7        rst     00h
36b0 39        add     hl,sp
36b1 1802      jr      36b5h
36b3 3000      jr      nc,36b5h
36b5 0c        inc     c
36b6 2007      jr      nz,36bfh
36b8 ff        rst     38h
36b9 ff        rst     38h
36ba 0100ff    ld      bc,0ff00h
36bd ef        rst     28h
36be 00        nop     
36bf 09        add     hl,bc
36c0 07        rlca    
36c1 08        ex      af,af'
36c2 0c        inc     c
36c3 03        inc     bc
36c4 017c38    ld      bc,387ch
36c7 9b        sbc     a,e
36c8 1e02      ld      e,02h
36ca 0b        dec     bc
36cb 1b        dec     de
36cc 02        ld      (bc),a
36cd 34        inc     (hl)
36ce 00        nop     
36cf 0c        inc     c
36d0 24        inc     h
36d1 0a        ld      a,(bc)
36d2 05        dec     b
36d3 02        ld      (bc),a
36d4 08        ex      af,af'
36d5 1607      ld      d,07h
36d7 ff        rst     38h
36d8 ff        rst     38h
36d9 ff        rst     38h
36da 00        nop     
36db ff        rst     38h
36dc ef        rst     28h
36dd 00        nop     
36de 09        add     hl,bc
36df 09        add     hl,bc
36e0 08        ex      af,af'
36e1 07        rlca    
36e2 03        inc     bc
36e3 014338    ld      bc,3843h
36e6 02        ld      (bc),a
36e7 3000      jr      nc,36e9h
36e9 0c        inc     c
36ea 2007      jr      nz,36f3h
36ec ff        rst     38h
36ed ff        rst     38h
36ee 0100ff    ld      bc,0ff00h
36f1 ef        rst     28h
36f2 00        nop     
36f3 09        add     hl,bc
36f4 07        rlca    
36f5 08        ex      af,af'
36f6 0c        inc     c
36f7 03        inc     bc
36f8 01cf37    ld      bc,37cfh
36fb 02        ld      (bc),a
36fc 34        inc     (hl)
36fd 00        nop     
36fe 0c        inc     c
36ff 24        inc     h
3700 0a        ld      a,(bc)
3701 05        dec     b
3702 02        ld      (bc),a
3703 08        ex      af,af'
3704 1607      ld      d,07h
3706 ff        rst     38h
3707 ff        rst     38h
3708 ff        rst     38h
3709 00        nop     
370a ff        rst     38h
370b ef        rst     28h
370c 00        nop     
370d 09        add     hl,bc
370e 09        add     hl,bc
370f 08        ex      af,af'
3710 07        rlca    
3711 03        inc     bc
3712 019c37    ld      bc,379ch
3715 02        ld      (bc),a
3716 69        ld      l,c
3717 00        nop     
3718 0c        inc     c
3719 0f        rrca    
371a 09        add     hl,bc
371b 07        rlca    
371c 08        ex      af,af'
371d 0c        inc     c
371e 07        rlca    
371f ff        rst     38h
3720 ff        rst     38h
3721 88        adc     a,b
3722 00        nop     
3723 80        add     a,b
3724 78        ld      a,b
3725 00        nop     
3726 03        inc     bc
3727 015c37    ld      bc,375ch
372a 02        ld      (bc),a
372b 02        ld      (bc),a
372c 00        nop     
372d 0c        inc     c
372e 24        inc     h
372f 07        rlca    
3730 ff        rst     38h
3731 ff        rst     38h
3732 0100ff    ld      bc,0ff00h
3735 00        nop     
3736 0f        rrca    
3737 19        add     hl,de
3738 03        inc     bc
3739 03        inc     bc
373a c7        rst     00h
373b 39        add     hl,sp
373c 1802      jr      3740h
373e 3000      jr      nc,3740h
3740 0c        inc     c
3741 2007      jr      nz,374ah
3743 ff        rst     38h
3744 ff        rst     38h
3745 0100ff    ld      bc,0ff00h
3748 ef        rst     28h
3749 00        nop     
374a 09        add     hl,bc
374b 07        rlca    
374c 08        ex      af,af'
374d 0c        inc     c
374e 0b        dec     bc
374f 03        inc     bc
3750 01e338    ld      bc,38e3h
3753 03        inc     bc
3754 017138    ld      bc,3871h
3757 0b        dec     bc
3758 1b        dec     de
3759 01cc36    ld      bc,36cch
375c 80        add     a,b
375d 1000      djnz    375fh
375f a2        and     d
3760 0e02      ld      c,02h
3762 a2        and     d
3763 0e02      ld      c,02h
3765 a2        and     d
3766 0e02      ld      c,02h
3768 a2        and     d
3769 3010      jr      nc,377bh
376b 80        add     a,b
376c 1000      djnz    376eh
376e a2        and     d
376f 0e02      ld      c,02h
3771 a2        and     d
3772 0e02      ld      c,02h
3774 a2        and     d
3775 0e02      ld      c,02h
3777 a2        and     d
3778 2020      jr      nz,379ah
377a 80        add     a,b
377b 1010      djnz    378dh
377d a2        and     d
377e 0e02      ld      c,02h
3780 a2        and     d
3781 0e02      ld      c,02h
3783 a2        and     d
3784 0e02      ld      c,02h
3786 a3        and     e
3787 0e02      ld      c,02h
3789 a5        and     l
378a 0e02      ld      c,02h
378c a0        and     b
378d 2020      jr      nz,37afh
378f a2        and     d
3790 0e02      ld      c,02h
3792 a0        and     b
3793 0e02      ld      c,02h
3795 9e        sbc     a,(hl)
3796 0e02      ld      c,02h
3798 9b        sbc     a,e
3799 1010      djnz    37abh
379b 04        inc     b
379c 80        add     a,b
379d 40        ld      b,b
379e 00        nop     
379f 0d        dec     c
37a0 f49b0e    call    p,0e9bh
37a3 02        ld      (bc),a
37a4 9e        sbc     a,(hl)
37a5 0e02      ld      c,02h
37a7 9b        sbc     a,e
37a8 0e02      ld      c,02h
37aa a2        and     d
37ab 2010      jr      nz,37bdh
37ad 9b        sbc     a,e
37ae 08        ex      af,af'
37af 08        ex      af,af'
37b0 9b        sbc     a,e
37b1 2010      jr      nz,37c3h
37b3 80        add     a,b
37b4 2040      jr      nz,37f6h
37b6 a2        and     d
37b7 0e02      ld      c,02h
37b9 a3        and     e
37ba 0e02      ld      c,02h
37bc a2        and     d
37bd 0e02      ld      c,02h
37bf a0        and     b
37c0 2020      jr      nz,37e2h
37c2 a2        and     d
37c3 0e02      ld      c,02h
37c5 a0        and     b
37c6 0e02      ld      c,02h
37c8 9e        sbc     a,(hl)
37c9 0e02      ld      c,02h
37cb 9b        sbc     a,e
37cc 1010      djnz    37deh
37ce 04        inc     b
37cf 0b        dec     bc
37d0 80        add     a,b
37d1 80        add     a,b
37d2 1094      djnz    3768h
37d4 08        ex      af,af'
37d5 08        ex      af,af'
37d6 95        sub     l
37d7 0e02      ld      c,02h
37d9 94        sub     h
37da 08        ex      af,af'
37db 08        ex      af,af'
37dc 99        sbc     a,c
37dd 0c        inc     c
37de 04        inc     b
37df 94        sub     h
37e0 08        ex      af,af'
37e1 08        ex      af,af'
37e2 0a        ld      a,(bc)
37e3 0b        dec     bc
37e4 02        ld      (bc),a
37e5 0e05      ld      c,05h
37e7 95        sub     l
37e8 1808      jr      37f2h
37ea 0b        dec     bc
37eb 80        add     a,b
37ec 80        add     a,b
37ed 1094      djnz    3783h
37ef 08        ex      af,af'
37f0 08        ex      af,af'
37f1 95        sub     l
37f2 0e02      ld      c,02h
37f4 94        sub     h
37f5 08        ex      af,af'
37f6 08        ex      af,af'
37f7 99        sbc     a,c
37f8 0c        inc     c
37f9 04        inc     b
37fa 95        sub     l
37fb 0c        inc     c
37fc 04        inc     b
37fd 0a        ld      a,(bc)
37fe 0b        dec     bc
37ff 02        ld      (bc),a
3800 0e05      ld      c,05h
3802 94        sub     h
3803 1808      jr      380dh
3805 0b        dec     bc
3806 80        add     a,b
3807 80        add     a,b
3808 1094      djnz    379eh
380a 08        ex      af,af'
380b 08        ex      af,af'
380c 95        sub     l
380d 0e02      ld      c,02h
380f 94        sub     h
3810 08        ex      af,af'
3811 08        ex      af,af'
3812 99        sbc     a,c
3813 0c        inc     c
3814 04        inc     b
3815 94        sub     h
3816 08        ex      af,af'
3817 08        ex      af,af'
3818 0a        ld      a,(bc)
3819 0b        dec     bc
381a 02        ld      (bc),a
381b 0e05      ld      c,05h
381d 9b        sbc     a,e
381e 1808      jr      3828h
3820 0b        dec     bc
3821 80        add     a,b
3822 1000      djnz    3824h
3824 99        sbc     a,c
3825 0c        inc     c
3826 04        inc     b
3827 95        sub     l
3828 08        ex      af,af'
3829 08        ex      af,af'
382a 94        sub     h
382b 08        ex      af,af'
382c 08        ex      af,af'
382d 95        sub     l
382e 0c        inc     c
382f 04        inc     b
3830 99        sbc     a,c
3831 08        ex      af,af'
3832 08        ex      af,af'
3833 95        sub     l
3834 08        ex      af,af'
3835 08        ex      af,af'
3836 0a        ld      a,(bc)
3837 0b        dec     bc
3838 02        ld      (bc),a
3839 0e05      ld      c,05h
383b 94        sub     h
383c 2808      jr      z,3846h
383e 80        add     a,b
383f 60        ld      h,b
3840 00        nop     
3841 0b        dec     bc
3842 04        inc     b
3843 80        add     a,b
3844 50        ld      d,b
3845 00        nop     
3846 96        sub     (hl)
3847 010fa2    ld      bc,0a20fh
384a 012f80    ld      bc,802fh
384d 40        ld      b,b
384e 00        nop     
384f 94        sub     h
3850 010fa0    ld      bc,0a00fh
3853 012f80    ld      bc,802fh
3856 80        add     a,b
3857 70        ld      (hl),b
3858 80        add     a,b
3859 50        ld      d,b
385a 00        nop     
385b 96        sub     (hl)
385c 010fa2    ld      bc,0a20fh
385f 012f80    ld      bc,802fh
3862 40        ld      b,b
3863 00        nop     
3864 94        sub     h
3865 010fa0    ld      bc,0a00fh
3868 012f80    ld      bc,802fh
386b 70        ld      (hl),b
386c 00        nop     
386d 80        add     a,b
386e 80        add     a,b
386f 00        nop     
3870 04        inc     b
3871 0a        ld      a,(bc)
3872 08        ex      af,af'
3873 02        ld      (bc),a
3874 0b        dec     bc
3875 019b1e    ld      bc,1e9bh
3878 02        ld      (bc),a
3879 0b        dec     bc
387a 1b        dec     de
387b 04        inc     b
387c 03        inc     bc
387d 014139    ld      bc,3941h
3880 0a        ld      a,(bc)
3881 08        ex      af,af'
3882 02        ld      (bc),a
3883 0b        dec     bc
3884 019b1e    ld      bc,1e9bh
3887 02        ld      (bc),a
3888 0b        dec     bc
3889 1b        dec     de
388a 80        add     a,b
388b 3000      jr      nc,388dh
388d 9b        sbc     a,e
388e 0602      ld      b,02h
3890 95        sub     l
3891 0602      ld      b,02h
3893 12        ld      (de),a
3894 00        nop     
3895 02        ld      (bc),a
3896 1014      djnz    38ach
3898 00        nop     
3899 9b        sbc     a,e
389a 2602      ld      h,02h
389c 1b        dec     de
389d 80        add     a,b
389e 48        ld      c,b
389f 00        nop     
38a0 9b        sbc     a,e
38a1 0602      ld      b,02h
38a3 95        sub     l
38a4 0602      ld      b,02h
38a6 12        ld      (de),a
38a7 00        nop     
38a8 02        ld      (bc),a
38a9 0f        rrca    
38aa 1600      ld      d,00h
38ac 9b        sbc     a,e
38ad 0e02      ld      c,02h
38af 1b        dec     de
38b0 9b        sbc     a,e
38b1 0602      ld      b,02h
38b3 95        sub     l
38b4 0602      ld      b,02h
38b6 12        ld      (de),a
38b7 00        nop     
38b8 02        ld      (bc),a
38b9 0f        rrca    
38ba 1600      ld      d,00h
38bc 9b        sbc     a,e
38bd 1e02      ld      e,02h
38bf 1b        dec     de
38c0 80        add     a,b
38c1 3000      jr      nc,38c3h
38c3 96        sub     (hl)
38c4 0602      ld      b,02h
38c6 93        sub     e
38c7 0602      ld      b,02h
38c9 12        ld      (de),a
38ca 00        nop     
38cb 02        ld      (bc),a
38cc 0f        rrca    
38cd 1600      ld      d,00h
38cf 96        sub     (hl)
38d0 0e02      ld      c,02h
38d2 1b        dec     de
38d3 96        sub     (hl)
38d4 0602      ld      b,02h
38d6 93        sub     e
38d7 0602      ld      b,02h
38d9 12        ld      (de),a
38da 00        nop     
38db 02        ld      (bc),a
38dc 0d        dec     c
38dd 14        inc     d
38de 00        nop     
38df 94        sub     h
38e0 1e02      ld      e,02h
38e2 1b        dec     de
38e3 03        inc     bc
38e4 016639    ld      bc,3966h
38e7 80        add     a,b
38e8 80        add     a,b
38e9 00        nop     
38ea 93        sub     e
38eb 04        inc     b
38ec 00        nop     
38ed 80        add     a,b
38ee 04        inc     b
38ef 00        nop     
38f0 93        sub     e
38f1 04        inc     b
38f2 00        nop     
38f3 80        add     a,b
38f4 04        inc     b
38f5 00        nop     
38f6 9b        sbc     a,e
38f7 04        inc     b
38f8 00        nop     
38f9 80        add     a,b
38fa 04        inc     b
38fb 00        nop     
38fc 9b        sbc     a,e
38fd 04        inc     b
38fe 00        nop     
38ff 80        add     a,b
3900 04        inc     b
3901 00        nop     
3902 9a        sbc     a,d
3903 04        inc     b
3904 00        nop     
3905 80        add     a,b
3906 04        inc     b
3907 00        nop     
3908 9a        sbc     a,d
3909 04        inc     b
390a 00        nop     
390b 80        add     a,b
390c 04        inc     b
390d 00        nop     
390e 96        sub     (hl)
390f 04        inc     b
3910 00        nop     
3911 80        add     a,b
3912 04        inc     b
3913 00        nop     
3914 96        sub     (hl)
3915 04        inc     b
3916 00        nop     
3917 80        add     a,b
3918 04        inc     b
3919 00        nop     
391a 93        sub     e
391b 04        inc     b
391c 00        nop     
391d 80        add     a,b
391e 04        inc     b
391f 00        nop     
3920 93        sub     e
3921 04        inc     b
3922 00        nop     
3923 80        add     a,b
3924 04        inc     b
3925 00        nop     
3926 95        sub     l
3927 04        inc     b
3928 00        nop     
3929 80        add     a,b
392a 04        inc     b
392b 00        nop     
392c 95        sub     l
392d 04        inc     b
392e 00        nop     
392f 80        add     a,b
3930 04        inc     b
3931 00        nop     
3932 96        sub     (hl)
3933 04        inc     b
3934 00        nop     
3935 80        add     a,b
3936 1c        inc     e
3937 00        nop     
3938 03        inc     bc
3939 016639    ld      bc,3966h
393c 03        inc     bc
393d 014139    ld      bc,3941h
3940 04        inc     b
3941 93        sub     e
3942 0602      ld      b,02h
3944 96        sub     (hl)
3945 0602      ld      b,02h
3947 95        sub     l
3948 0602      ld      b,02h
394a 96        sub     (hl)
394b 0602      ld      b,02h
394d 95        sub     l
394e 0602      ld      b,02h
3950 9b        sbc     a,e
3951 0602      ld      b,02h
3953 95        sub     l
3954 0602      ld      b,02h
3956 9b        sbc     a,e
3957 0602      ld      b,02h
3959 12        ld      (de),a
395a 00        nop     
395b 02        ld      (bc),a
395c 0f        rrca    
395d 1600      ld      d,00h
395f 9b        sbc     a,e
3960 0e02      ld      c,02h
3962 9b        sbc     a,e
3963 0e02      ld      c,02h
3965 04        inc     b
3966 93        sub     e
3967 04        inc     b
3968 00        nop     
3969 80        add     a,b
396a 04        inc     b
396b 00        nop     
396c 93        sub     e
396d 04        inc     b
396e 00        nop     
396f 80        add     a,b
3970 04        inc     b
3971 00        nop     
3972 9b        sbc     a,e
3973 04        inc     b
3974 00        nop     
3975 80        add     a,b
3976 04        inc     b
3977 00        nop     
3978 9b        sbc     a,e
3979 04        inc     b
397a 00        nop     
397b 80        add     a,b
397c 04        inc     b
397d 00        nop     
397e 9a        sbc     a,d
397f 04        inc     b
3980 00        nop     
3981 80        add     a,b
3982 04        inc     b
3983 00        nop     
3984 9a        sbc     a,d
3985 04        inc     b
3986 00        nop     
3987 80        add     a,b
3988 04        inc     b
3989 00        nop     
398a 96        sub     (hl)
398b 04        inc     b
398c 00        nop     
398d 80        add     a,b
398e 04        inc     b
398f 00        nop     
3990 96        sub     (hl)
3991 04        inc     b
3992 00        nop     
3993 80        add     a,b
3994 04        inc     b
3995 00        nop     
3996 93        sub     e
3997 04        inc     b
3998 00        nop     
3999 80        add     a,b
399a 04        inc     b
399b 00        nop     
399c 93        sub     e
399d 04        inc     b
399e 00        nop     
399f 80        add     a,b
39a0 04        inc     b
39a1 00        nop     
39a2 95        sub     l
39a3 04        inc     b
39a4 00        nop     
39a5 80        add     a,b
39a6 04        inc     b
39a7 00        nop     
39a8 95        sub     l
39a9 04        inc     b
39aa 00        nop     
39ab 80        add     a,b
39ac 04        inc     b
39ad 00        nop     
39ae 96        sub     (hl)
39af 04        inc     b
39b0 00        nop     
39b1 80        add     a,b
39b2 04        inc     b
39b3 00        nop     
39b4 96        sub     (hl)
39b5 04        inc     b
39b6 00        nop     
39b7 80        add     a,b
39b8 04        inc     b
39b9 00        nop     
39ba 91        sub     c
39bb 04        inc     b
39bc 00        nop     
39bd 80        add     a,b
39be 04        inc     b
39bf 00        nop     
39c0 91        sub     c
39c1 04        inc     b
39c2 00        nop     
39c3 80        add     a,b
39c4 04        inc     b
39c5 00        nop     
39c6 04        inc     b
39c7 80        add     a,b
39c8 08        ex      af,af'
39c9 08        ex      af,af'
39ca 04        inc     b
39cb 09        add     hl,bc
39cc 00        nop     
39cd 96        sub     (hl)
39ce 08        ex      af,af'
39cf 08        ex      af,af'
39d0 0c        inc     c
39d1 09        add     hl,bc
39d2 03        inc     bc
39d3 93        sub     e
39d4 0c        inc     c
39d5 08        ex      af,af'
39d6 07        rlca    
39d7 09        add     hl,bc
39d8 0f        rrca    
39d9 93        sub     e
39da 04        inc     b
39db 08        ex      af,af'
39dc 0c        inc     c
39dd 09        add     hl,bc
39de 03        inc     bc
39df 96        sub     (hl)
39e0 04        inc     b
39e1 08        ex      af,af'
39e2 04        inc     b
39e3 09        add     hl,bc
39e4 00        nop     
39e5 93        sub     e
39e6 08        ex      af,af'
39e7 08        ex      af,af'
39e8 07        rlca    
39e9 09        add     hl,bc
39ea 0f        rrca    
39eb 96        sub     (hl)
39ec 04        inc     b
39ed 08        ex      af,af'
39ee 0c        inc     c
39ef 09        add     hl,bc
39f0 03        inc     bc
39f1 9b        sbc     a,e
39f2 04        inc     b
39f3 08        ex      af,af'
39f4 04        inc     b
39f5 09        add     hl,bc
39f6 00        nop     
39f7 96        sub     (hl)
39f8 04        inc     b
39f9 08        ex      af,af'
39fa 0c        inc     c
39fb 09        add     hl,bc
39fc 03        inc     bc
39fd 9a        sbc     a,d
39fe 04        inc     b
39ff 08        ex      af,af'
3a00 07        rlca    
3a01 09        add     hl,bc
3a02 0f        rrca    
3a03 9b        sbc     a,e
3a04 08        ex      af,af'
3a05 9a        sbc     a,d
3a06 04        inc     b
3a07 08        ex      af,af'
3a08 04        inc     b
3a09 09        add     hl,bc
3a0a 00        nop     
3a0b 9b        sbc     a,e
3a0c 08        ex      af,af'
3a0d 08        ex      af,af'
3a0e 0c        inc     c
3a0f 09        add     hl,bc
3a10 03        inc     bc
3a11 9b        sbc     a,e
3a12 0c        inc     c
3a13 08        ex      af,af'
3a14 07        rlca    
3a15 09        add     hl,bc
3a16 0f        rrca    
3a17 9b        sbc     a,e
3a18 04        inc     b
3a19 08        ex      af,af'
3a1a 0c        inc     c
3a1b 09        add     hl,bc
3a1c 03        inc     bc
3a1d 95        sub     l
3a1e 08        ex      af,af'
3a1f 08        ex      af,af'
3a20 04        inc     b
3a21 09        add     hl,bc
3a22 00        nop     
3a23 9b        sbc     a,e
3a24 04        inc     b
3a25 08        ex      af,af'
3a26 07        rlca    
3a27 09        add     hl,bc
3a28 0f        rrca    
3a29 95        sub     l
3a2a 04        inc     b
3a2b 08        ex      af,af'
3a2c 0c        inc     c
3a2d 09        add     hl,bc
3a2e 03        inc     bc
3a2f 96        sub     (hl)
3a30 08        ex      af,af'
3a31 08        ex      af,af'
3a32 04        inc     b
3a33 09        add     hl,bc
3a34 00        nop     
3a35 95        sub     l
3a36 04        inc     b
3a37 08        ex      af,af'
3a38 07        rlca    
3a39 09        add     hl,bc
3a3a 0f        rrca    
3a3b 96        sub     (hl)
3a3c 04        inc     b
3a3d 04        inc     b
3a3e 1880      jr      39c0h
3a40 1000      djnz    3a42h
3a42 80        add     a,b
3a43 80        add     a,b
3a44 80        add     a,b
3a45 80        add     a,b
3a46 80        add     a,b
3a47 00        nop     
3a48 02        ld      (bc),a
3a49 3000      jr      nc,3a4bh
3a4b 0c        inc     c
3a4c 2007      jr      nz,3a55h
3a4e ff        rst     38h
3a4f ff        rst     38h
3a50 0100ff    ld      bc,0ff00h
3a53 ef        rst     28h
3a54 00        nop     
3a55 09        add     hl,bc
3a56 0e08      ld      c,08h
3a58 09        add     hl,bc
3a59 80        add     a,b
3a5a 0a        ld      a,(bc)
3a5b 00        nop     
3a5c 03        inc     bc
3a5d 017c38    ld      bc,387ch
3a60 9b        sbc     a,e
3a61 1e04      ld      e,04h
3a63 0b        dec     bc
3a64 1b        dec     de
3a65 02        ld      (bc),a
3a66 34        inc     (hl)
3a67 00        nop     
3a68 0c        inc     c
3a69 24        inc     h
3a6a 0a        ld      a,(bc)
3a6b 05        dec     b
3a6c 02        ld      (bc),a
3a6d 08        ex      af,af'
3a6e 1607      ld      d,07h
3a70 ff        rst     38h
3a71 ff        rst     38h
3a72 ff        rst     38h
3a73 00        nop     
3a74 ff        rst     38h
3a75 ef        rst     28h
3a76 00        nop     
3a77 09        add     hl,bc
3a78 02        ld      (bc),a
3a79 08        ex      af,af'
3a7a 05        dec     b
3a7b 03        inc     bc
3a7c 014338    ld      bc,3843h
3a7f 02        ld      (bc),a
3a80 3000      jr      nc,3a82h
3a82 0c        inc     c
3a83 2007      jr      nz,3a8ch
3a85 ff        rst     38h
3a86 ff        rst     38h
3a87 0100ff    ld      bc,0ff00h
3a8a ef        rst     28h
3a8b 00        nop     
3a8c 09        add     hl,bc
3a8d 0e08      ld      c,08h
3a8f 09        add     hl,bc
3a90 03        inc     bc
3a91 01cf37    ld      bc,37cfh
3a94 02        ld      (bc),a
3a95 34        inc     (hl)
3a96 00        nop     
3a97 0c        inc     c
3a98 24        inc     h
3a99 0a        ld      a,(bc)
3a9a 05        dec     b
3a9b 02        ld      (bc),a
3a9c 08        ex      af,af'
3a9d 1607      ld      d,07h
3a9f ff        rst     38h
3aa0 ff        rst     38h
3aa1 ff        rst     38h
3aa2 00        nop     
3aa3 ff        rst     38h
3aa4 ef        rst     28h
3aa5 00        nop     
3aa6 09        add     hl,bc
3aa7 02        ld      (bc),a
3aa8 08        ex      af,af'
3aa9 05        dec     b
3aaa 03        inc     bc
3aab 019c37    ld      bc,379ch
3aae 02        ld      (bc),a
3aaf 69        ld      l,c
3ab0 00        nop     
3ab1 0c        inc     c
3ab2 0f        rrca    
3ab3 09        add     hl,bc
3ab4 0e08      ld      c,08h
3ab6 08        ex      af,af'
3ab7 07        rlca    
3ab8 ff        rst     38h
3ab9 ff        rst     38h
3aba 88        adc     a,b
3abb 00        nop     
3abc 80        add     a,b
3abd 78        ld      a,b
3abe 00        nop     
3abf 03        inc     bc
3ac0 015c37    ld      bc,375ch
3ac3 80        add     a,b
3ac4 80        add     a,b
3ac5 80        add     a,b
3ac6 80        add     a,b
3ac7 40        ld      b,b
3ac8 40        ld      b,b
3ac9 02        ld      (bc),a
3aca 3000      jr      nc,3acch
3acc 0c        inc     c
3acd 2007      jr      nz,3ad6h
3acf ff        rst     38h
3ad0 ff        rst     38h
3ad1 0100ff    ld      bc,0ff00h
3ad4 ef        rst     28h
3ad5 00        nop     
3ad6 09        add     hl,bc
3ad7 0e08      ld      c,08h
3ad9 09        add     hl,bc
3ada 0b        dec     bc
3adb 03        inc     bc
3adc 01e338    ld      bc,38e3h
3adf 03        inc     bc
3ae0 017138    ld      bc,3871h
3ae3 0b        dec     bc
3ae4 1b        dec     de
3ae5 01653a    ld      bc,3a65h
3ae8 1880      jr      3a6ah
3aea 1000      djnz    3aech
3aec 80        add     a,b
3aed 80        add     a,b
3aee 80        add     a,b
3aef 80        add     a,b
3af0 80        add     a,b
3af1 00        nop     
3af2 02        ld      (bc),a
3af3 3000      jr      nc,3af5h
3af5 0c        inc     c
3af6 2007      jr      nz,3affh
3af8 ff        rst     38h
3af9 ff        rst     38h
3afa 0100ff    ld      bc,0ff00h
3afd ef        rst     28h
3afe 00        nop     
3aff 09        add     hl,bc
3b00 00        nop     
3b01 08        ex      af,af'
3b02 05        dec     b
3b03 80        add     a,b
3b04 1600      ld      d,00h
3b06 03        inc     bc
3b07 017c38    ld      bc,387ch
3b0a 9b        sbc     a,e
3b0b 1e04      ld      e,04h
3b0d 0b        dec     bc
3b0e 1b        dec     de
3b0f 02        ld      (bc),a
3b10 34        inc     (hl)
3b11 00        nop     
3b12 0c        inc     c
3b13 24        inc     h
3b14 0a        ld      a,(bc)
3b15 05        dec     b
3b16 02        ld      (bc),a
3b17 08        ex      af,af'
3b18 1607      ld      d,07h
3b1a ff        rst     38h
3b1b ff        rst     38h
3b1c ff        rst     38h
3b1d 00        nop     
3b1e ff        rst     38h
3b1f ef        rst     28h
3b20 00        nop     
3b21 09        add     hl,bc
3b22 0f        rrca    
3b23 08        ex      af,af'
3b24 03        inc     bc
3b25 03        inc     bc
3b26 014338    ld      bc,3843h
3b29 02        ld      (bc),a
3b2a 3000      jr      nc,3b2ch
3b2c 0c        inc     c
3b2d 2007      jr      nz,3b36h
3b2f ff        rst     38h
3b30 ff        rst     38h
3b31 0100ff    ld      bc,0ff00h
3b34 ef        rst     28h
3b35 00        nop     
3b36 09        add     hl,bc
3b37 00        nop     
3b38 08        ex      af,af'
3b39 05        dec     b
3b3a 03        inc     bc
3b3b 01cf37    ld      bc,37cfh
3b3e 02        ld      (bc),a
3b3f 34        inc     (hl)
3b40 00        nop     
3b41 0c        inc     c
3b42 24        inc     h
3b43 0a        ld      a,(bc)
3b44 05        dec     b
3b45 02        ld      (bc),a
3b46 08        ex      af,af'
3b47 1607      ld      d,07h
3b49 ff        rst     38h
3b4a ff        rst     38h
3b4b ff        rst     38h
3b4c 00        nop     
3b4d ff        rst     38h
3b4e ef        rst     28h
3b4f 00        nop     
3b50 09        add     hl,bc
3b51 0f        rrca    
3b52 08        ex      af,af'
3b53 03        inc     bc
3b54 03        inc     bc
3b55 019c37    ld      bc,379ch
3b58 02        ld      (bc),a
3b59 69        ld      l,c
3b5a 00        nop     
3b5b 0c        inc     c
3b5c 0f        rrca    
3b5d 09        add     hl,bc
3b5e 00        nop     
3b5f 08        ex      af,af'
3b60 05        dec     b
3b61 07        rlca    
3b62 ff        rst     38h
3b63 ff        rst     38h
3b64 88        adc     a,b
3b65 00        nop     
3b66 80        add     a,b
3b67 78        ld      a,b
3b68 00        nop     
3b69 03        inc     bc
3b6a 015c37    ld      bc,375ch
3b6d 80        add     a,b
3b6e 80        add     a,b
3b6f 80        add     a,b
3b70 80        add     a,b
3b71 40        ld      b,b
3b72 40        ld      b,b
3b73 02        ld      (bc),a
3b74 3000      jr      nc,3b76h
3b76 0c        inc     c
3b77 2007      jr      nz,3b80h
3b79 ff        rst     38h
3b7a ff        rst     38h
3b7b 0100ff    ld      bc,0ff00h
3b7e ef        rst     28h
3b7f 00        nop     
3b80 09        add     hl,bc
3b81 00        nop     
3b82 08        ex      af,af'
3b83 05        dec     b
3b84 0b        dec     bc
3b85 03        inc     bc
3b86 01e338    ld      bc,38e3h
3b89 03        inc     bc
3b8a 017138    ld      bc,3871h
3b8d 0b        dec     bc
3b8e 1b        dec     de
3b8f 010f3b    ld      bc,3b0fh
3b92 00        nop     
3b93 00        nop     
3b94 1880      jr      3b16h
3b96 08        ex      af,af'
3b97 08        ex      af,af'
3b98 03        inc     bc
3b99 01853d    ld      bc,3d85h
3b9c 03        inc     bc
3b9d 03        inc     bc
3b9e 1d        dec     e
3b9f 3c        inc     a
3ba0 03        inc     bc
3ba1 01143c    ld      bc,3c14h
3ba4 03        inc     bc
3ba5 02        ld      (bc),a
3ba6 1d        dec     e
3ba7 3c        inc     a
3ba8 03        inc     bc
3ba9 02        ld      (bc),a
3baa 14        inc     d
3bab 3c        inc     a
3bac 03        inc     bc
3bad 02        ld      (bc),a
3bae 0b        dec     bc
3baf 3c        inc     a
3bb0 03        inc     bc
3bb1 02        ld      (bc),a
3bb2 02        ld      (bc),a
3bb3 3c        inc     a
3bb4 03        inc     bc
3bb5 04        inc     b
3bb6 bb        cp      e
3bb7 3b        dec     sp
3bb8 019c3b    ld      bc,3b9ch
3bbb 02        ld      (bc),a
3bbc 93        sub     e
3bbd 00        nop     
3bbe 0c        inc     c
3bbf 24        inc     h
3bc0 08        ex      af,af'
3bc1 0f        rrca    
3bc2 07        rlca    
3bc3 ff        rst     38h
3bc4 ff        rst     38h
3bc5 0100ff    ld      bc,0ff00h
3bc8 00        nop     
3bc9 110908    ld      de,0809h
3bcc 8d        adc     a,l
3bcd 0c        inc     c
3bce 04        inc     b
3bcf 8d        adc     a,l
3bd0 0602      ld      b,02h
3bd2 8d        adc     a,l
3bd3 0602      ld      b,02h
3bd5 02        ld      (bc),a
3bd6 1e00      ld      e,00h
3bd8 0c        inc     c
3bd9 24        inc     h
3bda 08        ex      af,af'
3bdb 0f        rrca    
3bdc 07        rlca    
3bdd ff        rst     38h
3bde ff        rst     38h
3bdf 00        nop     
3be0 00        nop     
3be1 ff        rst     38h
3be2 00        nop     
3be3 010909    ld      bc,0909h
3be6 8e        adc     a,(hl)
3be7 1000      djnz    3be9h
3be9 02        ld      (bc),a
3bea 93        sub     e
3beb 00        nop     
3bec 0c        inc     c
3bed 24        inc     h
3bee 08        ex      af,af'
3bef 0f        rrca    
3bf0 07        rlca    
3bf1 ff        rst     38h
3bf2 ff        rst     38h
3bf3 0100ff    ld      bc,0ff00h
3bf6 00        nop     
3bf7 110908    ld      de,0809h
3bfa 88        adc     a,b
3bfb 0c        inc     c
3bfc 04        inc     b
3bfd 03        inc     bc
3bfe 01563d    ld      bc,3d56h
3c01 04        inc     b
3c02 03        inc     bc
3c03 03        inc     bc
3c04 56        ld      d,(hl)
3c05 3d        dec     a
3c06 03        inc     bc
3c07 01f13c    ld      bc,3cf1h
3c0a 04        inc     b
3c0b 03        inc     bc
3c0c 07        rlca    
3c0d 56        ld      d,(hl)
3c0e 3d        dec     a
3c0f 03        inc     bc
3c10 01f13c    ld      bc,3cf1h
3c13 04        inc     b
3c14 03        inc     bc
3c15 03        inc     bc
3c16 6e        ld      l,(hl)
3c17 3c        inc     a
3c18 03        inc     bc
3c19 012e3c    ld      bc,3c2eh
3c1c 04        inc     b
3c1d 03        inc     bc
3c1e 01563d    ld      bc,3d56h
3c21 03        inc     bc
3c22 01f13c    ld      bc,3cf1h
3c25 03        inc     bc
3c26 01563d    ld      bc,3d56h
3c29 03        inc     bc
3c2a 01a03c    ld      bc,3ca0h
3c2d 04        inc     b
3c2e 02        ld      (bc),a
3c2f 93        sub     e
3c30 00        nop     
3c31 0c        inc     c
3c32 24        inc     h
3c33 08        ex      af,af'
3c34 0f        rrca    
3c35 07        rlca    
3c36 ff        rst     38h
3c37 ff        rst     38h
3c38 0100ff    ld      bc,0ff00h
3c3b 00        nop     
3c3c 110908    ld      de,0809h
3c3f 8d        adc     a,l
3c40 0c        inc     c
3c41 04        inc     b
3c42 02        ld      (bc),a
3c43 1e00      ld      e,00h
3c45 0c        inc     c
3c46 24        inc     h
3c47 08        ex      af,af'
3c48 0f        rrca    
3c49 07        rlca    
3c4a ff        rst     38h
3c4b ff        rst     38h
3c4c 00        nop     
3c4d 00        nop     
3c4e ff        rst     38h
3c4f 00        nop     
3c50 010909    ld      bc,0909h
3c53 8e        adc     a,(hl)
3c54 0f        rrca    
3c55 018f0f    ld      bc,0f8fh
3c58 010293    ld      bc,9302h
3c5b 00        nop     
3c5c 0c        inc     c
3c5d 24        inc     h
3c5e 08        ex      af,af'
3c5f 0f        rrca    
3c60 07        rlca    
3c61 ff        rst     38h
3c62 ff        rst     38h
3c63 0100ff    ld      bc,0ff00h
3c66 00        nop     
3c67 110908    ld      de,0809h
3c6a 8c        adc     a,h
3c6b 0c        inc     c
3c6c 04        inc     b
3c6d 04        inc     b
3c6e 02        ld      (bc),a
3c6f 93        sub     e
3c70 00        nop     
3c71 0c        inc     c
3c72 24        inc     h
3c73 08        ex      af,af'
3c74 0f        rrca    
3c75 07        rlca    
3c76 ff        rst     38h
3c77 ff        rst     38h
3c78 0100ff    ld      bc,0ff00h
3c7b 00        nop     
3c7c 110908    ld      de,0809h
3c7f 8d        adc     a,l
3c80 07        rlca    
3c81 018d07    ld      bc,078dh
3c84 018d07    ld      bc,078dh
3c87 018d07    ld      bc,078dh
3c8a 01021e    ld      bc,1e02h
3c8d 00        nop     
3c8e 0c        inc     c
3c8f 24        inc     h
3c90 08        ex      af,af'
3c91 0f        rrca    
3c92 07        rlca    
3c93 ff        rst     38h
3c94 ff        rst     38h
3c95 00        nop     
3c96 00        nop     
3c97 ff        rst     38h
3c98 00        nop     
3c99 010909    ld      bc,0909h
3c9c 8d        adc     a,l
3c9d 1f        rra     
3c9e 010402    ld      bc,0204h
3ca1 93        sub     e
3ca2 00        nop     
3ca3 0c        inc     c
3ca4 24        inc     h
3ca5 08        ex      af,af'
3ca6 0f        rrca    
3ca7 07        rlca    
3ca8 ff        rst     38h
3ca9 ff        rst     38h
3caa 0100ff    ld      bc,0ff00h
3cad 00        nop     
3cae 110908    ld      de,0809h
3cb1 8d        adc     a,l
3cb2 08        ex      af,af'
3cb3 00        nop     
3cb4 02        ld      (bc),a
3cb5 1e00      ld      e,00h
3cb7 0c        inc     c
3cb8 24        inc     h
3cb9 08        ex      af,af'
3cba 0f        rrca    
3cbb 07        rlca    
3cbc ff        rst     38h
3cbd ff        rst     38h
3cbe 00        nop     
3cbf 00        nop     
3cc0 ff        rst     38h
3cc1 00        nop     
3cc2 010909    ld      bc,0909h
3cc5 8e        adc     a,(hl)
3cc6 0f        rrca    
3cc7 010293    ld      bc,9302h
3cca 00        nop     
3ccb 0c        inc     c
3ccc 24        inc     h
3ccd 08        ex      af,af'
3cce 0f        rrca    
3ccf 07        rlca    
3cd0 ff        rst     38h
3cd1 ff        rst     38h
3cd2 0100ff    ld      bc,0ff00h
3cd5 00        nop     
3cd6 110908    ld      de,0809h
3cd9 8d        adc     a,l
3cda 08        ex      af,af'
3cdb 00        nop     
3cdc 02        ld      (bc),a
3cdd 1e00      ld      e,00h
3cdf 0c        inc     c
3ce0 24        inc     h
3ce1 08        ex      af,af'
3ce2 0f        rrca    
3ce3 07        rlca    
3ce4 ff        rst     38h
3ce5 ff        rst     38h
3ce6 00        nop     
3ce7 00        nop     
3ce8 ff        rst     38h
3ce9 00        nop     
3cea 010909    ld      bc,0909h
3ced 8e        adc     a,(hl)
3cee 1808      jr      3cf8h
3cf0 04        inc     b
3cf1 02        ld      (bc),a
3cf2 93        sub     e
3cf3 00        nop     
3cf4 0c        inc     c
3cf5 24        inc     h
3cf6 08        ex      af,af'
3cf7 0f        rrca    
3cf8 07        rlca    
3cf9 ff        rst     38h
3cfa ff        rst     38h
3cfb 0100ff    ld      bc,0ff00h
3cfe 00        nop     
3cff 110908    ld      de,0809h
3d02 8d        adc     a,l
3d03 08        ex      af,af'
3d04 00        nop     
3d05 02        ld      (bc),a
3d06 1e00      ld      e,00h
3d08 0c        inc     c
3d09 24        inc     h
3d0a 08        ex      af,af'
3d0b 0f        rrca    
3d0c 07        rlca    
3d0d ff        rst     38h
3d0e ff        rst     38h
3d0f 00        nop     
3d10 00        nop     
3d11 ff        rst     38h
3d12 00        nop     
3d13 010909    ld      bc,0909h
3d16 8e        adc     a,(hl)
3d17 0f        rrca    
3d18 010293    ld      bc,9302h
3d1b 00        nop     
3d1c 0c        inc     c
3d1d 24        inc     h
3d1e 08        ex      af,af'
3d1f 0f        rrca    
3d20 07        rlca    
3d21 ff        rst     38h
3d22 ff        rst     38h
3d23 0100ff    ld      bc,0ff00h
3d26 00        nop     
3d27 110908    ld      de,0809h
3d2a 8d        adc     a,l
3d2b 08        ex      af,af'
3d2c 00        nop     
3d2d 02        ld      (bc),a
3d2e 1e00      ld      e,00h
3d30 0c        inc     c
3d31 24        inc     h
3d32 08        ex      af,af'
3d33 0f        rrca    
3d34 07        rlca    
3d35 ff        rst     38h
3d36 ff        rst     38h
3d37 00        nop     
3d38 00        nop     
3d39 ff        rst     38h
3d3a 00        nop     
3d3b 010909    ld      bc,0909h
3d3e 8e        adc     a,(hl)
3d3f 1000      djnz    3d41h
3d41 02        ld      (bc),a
3d42 93        sub     e
3d43 00        nop     
3d44 0c        inc     c
3d45 24        inc     h
3d46 08        ex      af,af'
3d47 0f        rrca    
3d48 07        rlca    
3d49 ff        rst     38h
3d4a ff        rst     38h
3d4b 0100ff    ld      bc,0ff00h
3d4e 00        nop     
3d4f 110908    ld      de,0809h
3d52 8d        adc     a,l
3d53 08        ex      af,af'
3d54 08        ex      af,af'
3d55 04        inc     b
3d56 02        ld      (bc),a
3d57 93        sub     e
3d58 00        nop     
3d59 0c        inc     c
3d5a 24        inc     h
3d5b 08        ex      af,af'
3d5c 0f        rrca    
3d5d 07        rlca    
3d5e ff        rst     38h
3d5f ff        rst     38h
3d60 0100ff    ld      bc,0ff00h
3d63 00        nop     
3d64 110908    ld      de,0809h
3d67 8d        adc     a,l
3d68 0c        inc     c
3d69 04        inc     b
3d6a 8d        adc     a,l
3d6b 0602      ld      b,02h
3d6d 8d        adc     a,l
3d6e 0602      ld      b,02h
3d70 02        ld      (bc),a
3d71 1e00      ld      e,00h
3d73 0c        inc     c
3d74 24        inc     h
3d75 08        ex      af,af'
3d76 0f        rrca    
3d77 07        rlca    
3d78 ff        rst     38h
3d79 ff        rst     38h
3d7a 00        nop     
3d7b 00        nop     
3d7c ff        rst     38h
3d7d 00        nop     
3d7e 010909    ld      bc,0909h
3d81 8e        adc     a,(hl)
3d82 1808      jr      3d8ch
3d84 04        inc     b
3d85 80        add     a,b
3d86 0c        inc     c
3d87 00        nop     
3d88 04        inc     b
3d89 1880      jr      3d0bh
3d8b 08        ex      af,af'
3d8c 08        ex      af,af'
3d8d 0c        inc     c
3d8e 1802      jr      3d92h
3d90 5e        ld      e,(hl)
3d91 00        nop     
3d92 07        rlca    
3d93 ff        rst     38h
3d94 ff        rst     38h
3d95 2000      jr      nz,3d97h
3d97 e0        ret     po

3d98 e0        ret     po

3d99 00        nop     
3d9a 03        inc     bc
3d9b 011d3e    ld      bc,3e1dh
3d9e 03        inc     bc
3d9f 03        inc     bc
3da0 dc3d03    call    c,033dh
3da3 01ca3d    ld      bc,3dcah
3da6 03        inc     bc
3da7 02        ld      (bc),a
3da8 dc3d03    call    c,033dh
3dab 02        ld      (bc),a
3dac ca3d80    jp      z,803dh
3daf 80        add     a,b
3db0 80        add     a,b
3db1 80        add     a,b
3db2 80        add     a,b
3db3 80        add     a,b
3db4 80        add     a,b
3db5 80        add     a,b
3db6 80        add     a,b
3db7 80        add     a,b
3db8 80        add     a,b
3db9 80        add     a,b
3dba 80        add     a,b
3dbb 80        add     a,b
3dbc 80        add     a,b
3dbd 80        add     a,b
3dbe 80        add     a,b
3dbf 80        add     a,b
3dc0 80        add     a,b
3dc1 80        add     a,b
3dc2 80        add     a,b
3dc3 80        add     a,b
3dc4 80        add     a,b
3dc5 74        ld      (hl),h
3dc6 018d3d    ld      bc,3d8dh
3dc9 00        nop     
3dca 03        inc     bc
3dcb 03        inc     bc
3dcc f23d03    jp      p,033dh
3dcf 03        inc     bc
3dd0 e5        push    hl
3dd1 3d        dec     a
3dd2 08        ex      af,af'
3dd3 0a        ld      a,(bc)
3dd4 90        sub     b
3dd5 03        inc     bc
3dd6 010301    ld      bc,0103h
3dd9 1d        dec     e
3dda 3e04      ld      a,04h
3ddc 03        inc     bc
3ddd 07        rlca    
3dde 103e      djnz    3e1eh
3de0 03        inc     bc
3de1 01043e    ld      bc,3e04h
3de4 04        inc     b
3de5 09        add     hl,bc
3de6 02        ld      (bc),a
3de7 08        ex      af,af'
3de8 09        add     hl,bc
3de9 91        sub     c
3dea 0602      ld      b,02h
3dec 08        ex      af,af'
3ded 08        ex      af,af'
3dee 90        sub     b
3def 04        inc     b
3df0 04        inc     b
3df1 04        inc     b
3df2 08        ex      af,af'
3df3 0b        dec     bc
3df4 92        sub     d
3df5 0f        rrca    
3df6 01080a    ld      bc,0a08h
3df9 91        sub     c
3dfa 07        rlca    
3dfb 019207    ld      bc,0792h
3dfe 15        dec     d
3dff 03        inc     bc
3e00 011d3e    ld      bc,3e1dh
3e03 04        inc     b
3e04 09        add     hl,bc
3e05 02        ld      (bc),a
3e06 08        ex      af,af'
3e07 09        add     hl,bc
3e08 91        sub     c
3e09 0c        inc     c
3e0a 08        ex      af,af'
3e0b 03        inc     bc
3e0c 011d3e    ld      bc,3e1dh
3e0f 04        inc     b
3e10 09        add     hl,bc
3e11 02        ld      (bc),a
3e12 08        ex      af,af'
3e13 09        add     hl,bc
3e14 91        sub     c
3e15 0c        inc     c
3e16 04        inc     b
3e17 08        ex      af,af'
3e18 08        ex      af,af'
3e19 90        sub     b
3e1a 04        inc     b
3e1b 0c        inc     c
3e1c 04        inc     b
3e1d 08        ex      af,af'
3e1e 0b        dec     bc
3e1f 09        add     hl,bc
3e20 0a        ld      a,(bc)
3e21 95        sub     l
3e22 03        inc     bc
3e23 010904    ld      bc,0409h
3e26 94        sub     h
3e27 03        inc     bc
3e28 019603    ld      bc,0396h
3e2b 010418    ld      bc,1804h
3e2e 80        add     a,b
3e2f 08        ex      af,af'
3e30 08        ex      af,af'
3e31 03        inc     bc
3e32 01853d    ld      bc,3d85h
3e35 03        inc     bc
3e36 03        inc     bc
3e37 bc        cp      h
3e38 3f        ccf     
3e39 03        inc     bc
3e3a 03        inc     bc
3e3b 93        sub     e
3e3c 3f        ccf     
3e3d 80        add     a,b
3e3e 40        ld      b,b
3e3f 00        nop     
3e40 03        inc     bc
3e41 02        ld      (bc),a
3e42 bc        cp      h
3e43 3f        ccf     
3e44 03        inc     bc
3e45 03        inc     bc
3e46 93        sub     e
3e47 3f        ccf     
3e48 80        add     a,b
3e49 40        ld      b,b
3e4a 00        nop     
3e4b 03        inc     bc
3e4c 03        inc     bc
3e4d 93        sub     e
3e4e 3f        ccf     
3e4f 80        add     a,b
3e50 40        ld      b,b
3e51 00        nop     
3e52 03        inc     bc
3e53 02        ld      (bc),a
3e54 07        rlca    
3e55 3f        ccf     
3e56 03        inc     bc
3e57 02        ld      (bc),a
3e58 b2        or      d
3e59 3e03      ld      a,03h
3e5b 04        inc     b
3e5c 61        ld      h,c
3e5d 3e01      ld      a,01h
3e5f 35        dec     (hl)
3e60 3e0c      ld      a,0ch
3e62 1802      jr      3e66h
3e64 0600      ld      b,00h
3e66 08        ex      af,af'
3e67 0a        ld      a,(bc)
3e68 09        add     hl,bc
3e69 0107ff    ld      bc,0ff07h
3e6c ff        rst     38h
3e6d 3000      jr      nc,3e6fh
3e6f d0        ret     nc

3e70 0d        dec     c
3e71 00        nop     
3e72 9a        sbc     a,d
3e73 2000      jr      nz,3e75h
3e75 02        ld      (bc),a
3e76 3800      jr      c,3e78h
3e78 0c        inc     c
3e79 1809      jr      3e84h
3e7b 0a        ld      a,(bc)
3e7c 08        ex      af,af'
3e7d 07        rlca    
3e7e 07        rlca    
3e7f ff        rst     38h
3e80 ff        rst     38h
3e81 5f        ld      e,a
3e82 00        nop     
3e83 d0        ret     nc

3e84 a0        and     b
3e85 019710    ld      bc,1097h
3e88 00        nop     
3e89 0c        inc     c
3e8a 1c        inc     e
3e8b 02        ld      (bc),a
3e8c 0600      ld      b,00h
3e8e 08        ex      af,af'
3e8f 0b        dec     bc
3e90 09        add     hl,bc
3e91 0e07      ld      c,07h
3e93 ff        rst     38h
3e94 ff        rst     38h
3e95 3000      jr      nc,3e97h
3e97 d0        ret     nc

3e98 0d        dec     c
3e99 00        nop     
3e9a 9a        sbc     a,d
3e9b 3000      jr      nc,3e9dh
3e9d 02        ld      (bc),a
3e9e 3800      jr      c,3ea0h
3ea0 0c        inc     c
3ea1 1809      jr      3each
3ea3 0a        ld      a,(bc)
3ea4 08        ex      af,af'
3ea5 07        rlca    
3ea6 07        rlca    
3ea7 ff        rst     38h
3ea8 ff        rst     38h
3ea9 5f        ld      e,a
3eaa 00        nop     
3eab d0        ret     nc

3eac a0        and     b
3ead 019910    ld      bc,1099h
3eb0 1004      djnz    3eb6h
3eb2 0c        inc     c
3eb3 1802      jr      3eb7h
3eb5 0600      ld      b,00h
3eb7 08        ex      af,af'
3eb8 0a        ld      a,(bc)
3eb9 09        add     hl,bc
3eba 0107ff    ld      bc,0ff07h
3ebd ff        rst     38h
3ebe 3000      jr      nc,3ec0h
3ec0 d0        ret     nc

3ec1 0d        dec     c
3ec2 00        nop     
3ec3 9a        sbc     a,d
3ec4 2000      jr      nz,3ec6h
3ec6 02        ld      (bc),a
3ec7 3800      jr      c,3ec9h
3ec9 0c        inc     c
3eca 1809      jr      3ed5h
3ecc 0a        ld      a,(bc)
3ecd 08        ex      af,af'
3ece 07        rlca    
3ecf 07        rlca    
3ed0 ff        rst     38h
3ed1 ff        rst     38h
3ed2 5f        ld      e,a
3ed3 00        nop     
3ed4 d0        ret     nc

3ed5 a0        and     b
3ed6 019710    ld      bc,1097h
3ed9 100c      djnz    3ee7h
3edb 1c        inc     e
3edc 02        ld      (bc),a
3edd 0600      ld      b,00h
3edf 08        ex      af,af'
3ee0 0b        dec     bc
3ee1 09        add     hl,bc
3ee2 0e07      ld      c,07h
3ee4 ff        rst     38h
3ee5 ff        rst     38h
3ee6 3000      jr      nc,3ee8h
3ee8 d0        ret     nc

3ee9 0d        dec     c
3eea 00        nop     
3eeb 9a        sbc     a,d
3eec 2000      jr      nz,3eeeh
3eee 02        ld      (bc),a
3eef 3800      jr      c,3ef1h
3ef1 0c        inc     c
3ef2 1809      jr      3efdh
3ef4 0a        ld      a,(bc)
3ef5 08        ex      af,af'
3ef6 07        rlca    
3ef7 07        rlca    
3ef8 ff        rst     38h
3ef9 ff        rst     38h
3efa 5f        ld      e,a
3efb 00        nop     
3efc d0        ret     nc

3efd a0        and     b
3efe 019710    ld      bc,1097h
3f01 1003      djnz    3f06h
3f03 01383f    ld      bc,3f38h
3f06 04        inc     b
3f07 0c        inc     c
3f08 1802      jr      3f0ch
3f0a 0600      ld      b,00h
3f0c 08        ex      af,af'
3f0d 0a        ld      a,(bc)
3f0e 09        add     hl,bc
3f0f 0107ff    ld      bc,0ff07h
3f12 ff        rst     38h
3f13 3000      jr      nc,3f15h
3f15 d0        ret     nc

3f16 0d        dec     c
3f17 00        nop     
3f18 9a        sbc     a,d
3f19 2000      jr      nz,3f1bh
3f1b 02        ld      (bc),a
3f1c 3800      jr      c,3f1eh
3f1e 0c        inc     c
3f1f 1809      jr      3f2ah
3f21 0a        ld      a,(bc)
3f22 08        ex      af,af'
3f23 07        rlca    
3f24 07        rlca    
3f25 ff        rst     38h
3f26 ff        rst     38h
3f27 5f        ld      e,a
3f28 00        nop     
3f29 d0        ret     nc

3f2a a0        and     b
3f2b 019710    ld      bc,1097h
3f2e 1003      djnz    3f33h
3f30 05        dec     b
3f31 8c        adc     a,h
3f32 3f        ccf     
3f33 03        inc     bc
3f34 01383f    ld      bc,3f38h
3f37 04        inc     b
3f38 0c        inc     c
3f39 1802      jr      3f3dh
3f3b 0600      ld      b,00h
3f3d 08        ex      af,af'
3f3e 0a        ld      a,(bc)
3f3f 09        add     hl,bc
3f40 0107ff    ld      bc,0ff07h
3f43 ff        rst     38h
3f44 3000      jr      nc,3f46h
3f46 d0        ret     nc

3f47 0d        dec     c
3f48 00        nop     
3f49 9a        sbc     a,d
3f4a 2000      jr      nz,3f4ch
3f4c 02        ld      (bc),a
3f4d 3800      jr      c,3f4fh
3f4f 0c        inc     c
3f50 1809      jr      3f5bh
3f52 0a        ld      a,(bc)
3f53 08        ex      af,af'
3f54 07        rlca    
3f55 07        rlca    
3f56 ff        rst     38h
3f57 ff        rst     38h
3f58 5f        ld      e,a
3f59 00        nop     
3f5a d0        ret     nc

3f5b a0        and     b
3f5c 019910    ld      bc,1099h
3f5f 1095      djnz    3ef6h
3f61 08        ex      af,af'
3f62 00        nop     
3f63 0c        inc     c
3f64 1e02      ld      e,02h
3f66 0600      ld      b,00h
3f68 08        ex      af,af'
3f69 09        add     hl,bc
3f6a 09        add     hl,bc
3f6b 05        dec     b
3f6c 07        rlca    
3f6d ff        rst     38h
3f6e ff        rst     38h
3f6f 40        ld      b,b
3f70 00        nop     
3f71 c0        ret     nz

3f72 c0        ret     nz

3f73 00        nop     
3f74 9a        sbc     a,d
3f75 1800      jr      3f77h
3f77 0c        inc     c
3f78 1c        inc     e
3f79 02        ld      (bc),a
3f7a 0600      ld      b,00h
3f7c 08        ex      af,af'
3f7d 0b        dec     bc
3f7e 09        add     hl,bc
3f7f 0e07      ld      c,07h
3f81 ff        rst     38h
3f82 ff        rst     38h
3f83 3000      jr      nc,3f85h
3f85 d0        ret     nc

3f86 0d        dec     c
3f87 00        nop     
3f88 9a        sbc     a,d
3f89 2000      jr      nz,3f8bh
3f8b 04        inc     b
3f8c 99        sbc     a,c
3f8d 1010      djnz    3f9fh
3f8f 97        sub     a
3f90 1010      djnz    3fa2h
3f92 04        inc     b
3f93 0c        inc     c
3f94 1e02      ld      e,02h
3f96 0600      ld      b,00h
3f98 08        ex      af,af'
3f99 09        add     hl,bc
3f9a 09        add     hl,bc
3f9b 05        dec     b
3f9c 07        rlca    
3f9d ff        rst     38h
3f9e ff        rst     38h
3f9f 40        ld      b,b
3fa0 00        nop     
3fa1 c0        ret     nz

3fa2 c0        ret     nz

3fa3 00        nop     
3fa4 9a        sbc     a,d
3fa5 2000      jr      nz,3fa7h
3fa7 0c        inc     c
3fa8 1c        inc     e
3fa9 02        ld      (bc),a
3faa 0600      ld      b,00h
3fac 08        ex      af,af'
3fad 0b        dec     bc
3fae 09        add     hl,bc
3faf 0e07      ld      c,07h
3fb1 ff        rst     38h
3fb2 ff        rst     38h
3fb3 3000      jr      nc,3fb5h
3fb5 d0        ret     nc

3fb6 0d        dec     c
3fb7 00        nop     
3fb8 9b        sbc     a,e
3fb9 2000      jr      nz,3fbbh
3fbb 04        inc     b
3fbc 0c        inc     c
3fbd 1802      jr      3fc1h
3fbf 0600      ld      b,00h
3fc1 08        ex      af,af'
3fc2 0a        ld      a,(bc)
3fc3 09        add     hl,bc
3fc4 0107ff    ld      bc,0ff07h
3fc7 ff        rst     38h
3fc8 3000      jr      nc,3fcah
3fca d0        ret     nc

3fcb 0d        dec     c
3fcc 00        nop     
3fcd 9a        sbc     a,d
3fce 2000      jr      nz,3fd0h
3fd0 02        ld      (bc),a
3fd1 3800      jr      c,3fd3h
3fd3 0c        inc     c
3fd4 1809      jr      3fdfh
3fd6 0a        ld      a,(bc)
3fd7 08        ex      af,af'
3fd8 07        rlca    
3fd9 07        rlca    
3fda ff        rst     38h
3fdb ff        rst     38h
3fdc 5f        ld      e,a
3fdd 00        nop     
3fde d0        ret     nc

3fdf a0        and     b
3fe0 019910    ld      bc,1099h
3fe3 1097      djnz    3f7ch
3fe5 08        ex      af,af'
3fe6 00        nop     
3fe7 0c        inc     c
3fe8 1e02      ld      e,02h
3fea 0600      ld      b,00h
3fec 08        ex      af,af'
3fed 09        add     hl,bc
3fee 09        add     hl,bc
3fef 05        dec     b
3ff0 07        rlca    
3ff1 ff        rst     38h
3ff2 ff        rst     38h
3ff3 40        ld      b,b
3ff4 00        nop     
3ff5 c0        ret     nz

3ff6 c0        ret     nz

3ff7 00        nop     
3ff8 9a        sbc     a,d
3ff9 1800      jr      3ffbh
3ffb 0c        inc     c
3ffc 2002      jr      nz,4000h
3ffe 0600      ld      b,00h
4000 08        ex      af,af'
4001 09        add     hl,bc
4002 09        add     hl,bc
4003 0a        ld      a,(bc)
4004 07        rlca    
4005 ff        rst     38h
4006 ff        rst     38h
4007 40        ld      b,b
4008 00        nop     
4009 c0        ret     nz

400a c0        ret     nz

400b 00        nop     
400c 9a        sbc     a,d
400d 1000      djnz    400fh
400f 98        sbc     a,b
4010 1000      djnz    4012h
4012 0c        inc     c
4013 1802      jr      4017h
4015 0600      ld      b,00h
4017 08        ex      af,af'
4018 0a        ld      a,(bc)
4019 09        add     hl,bc
401a 0107ff    ld      bc,0ff07h
401d ff        rst     38h
401e 3000      jr      nc,4020h
4020 d0        ret     nc

4021 0d        dec     c
4022 00        nop     
4023 9a        sbc     a,d
4024 2000      jr      nz,4026h
4026 02        ld      (bc),a
4027 3800      jr      c,4029h
4029 0c        inc     c
402a 1809      jr      4035h
402c 0a        ld      a,(bc)
402d 08        ex      af,af'
402e 07        rlca    
402f 07        rlca    
4030 ff        rst     38h
4031 ff        rst     38h
4032 5f        ld      e,a
4033 00        nop     
4034 d0        ret     nc

4035 a0        and     b
4036 019910    ld      bc,1099h
4039 1098      djnz    3fd3h
403b 08        ex      af,af'
403c 00        nop     
403d 0c        inc     c
403e 1e02      ld      e,02h
4040 0600      ld      b,00h
4042 08        ex      af,af'
4043 09        add     hl,bc
4044 09        add     hl,bc
4045 05        dec     b
4046 07        rlca    
4047 ff        rst     38h
4048 ff        rst     38h
4049 40        ld      b,b
404a 00        nop     
404b c0        ret     nz

404c c0        ret     nz

404d 00        nop     
404e 9a        sbc     a,d
404f 1800      jr      4051h
4051 0c        inc     c
4052 1c        inc     e
4053 02        ld      (bc),a
4054 0600      ld      b,00h
4056 08        ex      af,af'
4057 0b        dec     bc
4058 09        add     hl,bc
4059 0e07      ld      c,07h
405b ff        rst     38h
405c ff        rst     38h
405d 3000      jr      nc,405fh
405f d0        ret     nc

4060 0d        dec     c
4061 00        nop     
4062 9a        sbc     a,d
4063 2000      jr      nz,4065h
4065 04        inc     b
4066 1880      jr      3fe8h
4068 08        ex      af,af'
4069 08        ex      af,af'
406a 03        inc     bc
406b 01853d    ld      bc,3d85h
406e 0c        inc     c
406f 2c        inc     l
4070 02        ld      (bc),a
4071 2d        dec     l
4072 00        nop     
4073 07        rlca    
4074 ff        rst     38h
4075 ff        rst     38h
4076 0100ff    ld      bc,0ff00h
4079 00        nop     
407a 110908    ld      de,0809h
407d 03        inc     bc
407e 03        inc     bc
407f a8        xor     b
4080 41        ld      b,c
4081 03        inc     bc
4082 019741    ld      bc,4197h
4085 03        inc     bc
4086 02        ld      (bc),a
4087 a8        xor     b
4088 41        ld      b,c
4089 03        inc     bc
408a 02        ld      (bc),a
408b 97        sub     a
408c 41        ld      b,c
408d 03        inc     bc
408e 02        ld      (bc),a
408f 7e        ld      a,(hl)
4090 41        ld      b,c
4091 03        inc     bc
4092 02        ld      (bc),a
4093 57        ld      d,a
4094 41        ld      b,c
4095 03        inc     bc
4096 02        ld      (bc),a
4097 9c        sbc     a,h
4098 40        ld      b,b
4099 017d40    ld      bc,407dh
409c 08        ex      af,af'
409d 0f        rrca    
409e 07        rlca    
409f ff        rst     38h
40a0 ff        rst     38h
40a1 5f        ld      e,a
40a2 015055    ld      bc,5550h
40a5 05        dec     b
40a6 86        add     a,(hl)
40a7 0c        inc     c
40a8 04        inc     b
40a9 08        ex      af,af'
40aa 0c        inc     c
40ab 07        rlca    
40ac ff        rst     38h
40ad ff        rst     38h
40ae ff        rst     38h
40af 014044    ld      bc,4440h
40b2 04        inc     b
40b3 86        add     a,(hl)
40b4 07        rlca    
40b5 018607    ld      bc,0786h
40b8 01080f    ld      bc,0f08h
40bb 07        rlca    
40bc ff        rst     38h
40bd ff        rst     38h
40be 5f        ld      e,a
40bf 015055    ld      bc,5550h
40c2 05        dec     b
40c3 86        add     a,(hl)
40c4 0c        inc     c
40c5 04        inc     b
40c6 87        add     a,a
40c7 0c        inc     c
40c8 04        inc     b
40c9 87        add     a,a
40ca 0c        inc     c
40cb 04        inc     b
40cc 08        ex      af,af'
40cd 0c        inc     c
40ce 07        rlca    
40cf ff        rst     38h
40d0 ff        rst     38h
40d1 ff        rst     38h
40d2 014044    ld      bc,4440h
40d5 04        inc     b
40d6 87        add     a,a
40d7 07        rlca    
40d8 018707    ld      bc,0787h
40db 01080f    ld      bc,0f08h
40de 07        rlca    
40df ff        rst     38h
40e0 ff        rst     38h
40e1 5f        ld      e,a
40e2 015055    ld      bc,5550h
40e5 05        dec     b
40e6 87        add     a,a
40e7 0c        inc     c
40e8 04        inc     b
40e9 08        ex      af,af'
40ea 0c        inc     c
40eb 07        rlca    
40ec ff        rst     38h
40ed ff        rst     38h
40ee ff        rst     38h
40ef 014044    ld      bc,4440h
40f2 04        inc     b
40f3 87        add     a,a
40f4 07        rlca    
40f5 018707    ld      bc,0787h
40f8 01080f    ld      bc,0f08h
40fb 07        rlca    
40fc ff        rst     38h
40fd ff        rst     38h
40fe 5f        ld      e,a
40ff 015055    ld      bc,5550h
4102 05        dec     b
4103 8c        adc     a,h
4104 0c        inc     c
4105 04        inc     b
4106 08        ex      af,af'
4107 0c        inc     c
4108 07        rlca    
4109 ff        rst     38h
410a ff        rst     38h
410b ff        rst     38h
410c 014044    ld      bc,4440h
410f 04        inc     b
4110 8c        adc     a,h
4111 07        rlca    
4112 018c07    ld      bc,078ch
4115 01080f    ld      bc,0f08h
4118 07        rlca    
4119 ff        rst     38h
411a ff        rst     38h
411b 5f        ld      e,a
411c 015055    ld      bc,5550h
411f 05        dec     b
4120 8c        adc     a,h
4121 0c        inc     c
4122 04        inc     b
4123 8b        adc     a,e
4124 0c        inc     c
4125 04        inc     b
4126 8b        adc     a,e
4127 0c        inc     c
4128 04        inc     b
4129 08        ex      af,af'
412a 0c        inc     c
412b 07        rlca    
412c ff        rst     38h
412d ff        rst     38h
412e ff        rst     38h
412f 014044    ld      bc,4440h
4132 04        inc     b
4133 8b        adc     a,e
4134 07        rlca    
4135 018b07    ld      bc,078bh
4138 01080f    ld      bc,0f08h
413b 07        rlca    
413c ff        rst     38h
413d ff        rst     38h
413e 5f        ld      e,a
413f 015055    ld      bc,5550h
4142 05        dec     b
4143 8b        adc     a,e
4144 0c        inc     c
4145 04        inc     b
4146 08        ex      af,af'
4147 0c        inc     c
4148 07        rlca    
4149 ff        rst     38h
414a ff        rst     38h
414b ff        rst     38h
414c 014044    ld      bc,4440h
414f 04        inc     b
4150 8b        adc     a,e
4151 07        rlca    
4152 018b07    ld      bc,078bh
4155 01040d    ld      bc,0d04h
4158 010302    ld      bc,0203h
415b 3842      jr      c,419fh
415d 0d        dec     c
415e fe03      cp      03h
4160 02        ld      (bc),a
4161 3842      jr      c,41a5h
4163 0d        dec     c
4164 010302    ld      bc,0203h
4167 3842      jr      c,41abh
4169 03        inc     bc
416a 011742    ld      bc,4217h
416d 08        ex      af,af'
416e 0f        rrca    
416f 07        rlca    
4170 ff        rst     38h
4171 ff        rst     38h
4172 5f        ld      e,a
4173 015055    ld      bc,5550h
4176 05        dec     b
4177 88        adc     a,b
4178 0f        rrca    
4179 01870f    ld      bc,0f87h
417c 010403    ld      bc,0304h
417f 0e38      ld      c,38h
4181 42        ld      b,d
4182 03        inc     bc
4183 011742    ld      bc,4217h
4186 08        ex      af,af'
4187 0f        rrca    
4188 07        rlca    
4189 ff        rst     38h
418a ff        rst     38h
418b 5f        ld      e,a
418c 015055    ld      bc,5550h
418f 05        dec     b
4190 90        sub     b
4191 0f        rrca    
4192 018f0f    ld      bc,0f8fh
4195 010403    ld      bc,0304h
4198 03        inc     bc
4199 e9        jp      (hl)
419a 41        ld      b,c
419b 88        adc     a,b
419c 0f        rrca    
419d 01870f    ld      bc,0f87h
41a0 01880f    ld      bc,0f88h
41a3 01890f    ld      bc,0f89h
41a6 010403    ld      bc,0304h
41a9 02        ld      (bc),a
41aa 3842      jr      c,41eeh
41ac 03        inc     bc
41ad 011742    ld      bc,4217h
41b0 08        ex      af,af'
41b1 0f        rrca    
41b2 07        rlca    
41b3 ff        rst     38h
41b4 ff        rst     38h
41b5 5f        ld      e,a
41b6 015055    ld      bc,5550h
41b9 05        dec     b
41ba 90        sub     b
41bb 0f        rrca    
41bc 018f0f    ld      bc,0f8fh
41bf 010302    ld      bc,0203h
41c2 3842      jr      c,4206h
41c4 03        inc     bc
41c5 011742    ld      bc,4217h
41c8 08        ex      af,af'
41c9 0f        rrca    
41ca 07        rlca    
41cb ff        rst     38h
41cc ff        rst     38h
41cd 5f        ld      e,a
41ce 015055    ld      bc,5550h
41d1 05        dec     b
41d2 89        adc     a,c
41d3 14        inc     d
41d4 00        nop     
41d5 08        ex      af,af'
41d6 0a        ld      a,(bc)
41d7 07        rlca    
41d8 ff        rst     38h
41d9 ff        rst     38h
41da 24        inc     h
41db 03        inc     bc
41dc 50        ld      d,b
41dd 00        nop     
41de 0a        ld      a,(bc)
41df 94        sub     h
41e0 03        inc     bc
41e1 019503    ld      bc,0395h
41e4 019603    ld      bc,0396h
41e7 010408    ld      bc,0804h
41ea 0f        rrca    
41eb 07        rlca    
41ec ff        rst     38h
41ed ff        rst     38h
41ee 5f        ld      e,a
41ef 015055    ld      bc,5550h
41f2 05        dec     b
41f3 88        adc     a,b
41f4 07        rlca    
41f5 01080c    ld      bc,0c08h
41f8 07        rlca    
41f9 ff        rst     38h
41fa ff        rst     38h
41fb ff        rst     38h
41fc 014044    ld      bc,4440h
41ff 04        inc     b
4200 88        adc     a,b
4201 07        rlca    
4202 018807    ld      bc,0788h
4205 018807    ld      bc,0788h
4208 01080f    ld      bc,0f08h
420b 07        rlca    
420c ff        rst     38h
420d ff        rst     38h
420e 5f        ld      e,a
420f 015055    ld      bc,5550h
4212 05        dec     b
4213 87        add     a,a
4214 1f        rra     
4215 010408    ld      bc,0804h
4218 0f        rrca    
4219 07        rlca    
421a ff        rst     38h
421b ff        rst     38h
421c 5f        ld      e,a
421d 015055    ld      bc,5550h
4220 05        dec     b
4221 8a        adc     a,d
4222 07        rlca    
4223 01080c    ld      bc,0c08h
4226 07        rlca    
4227 ff        rst     38h
4228 ff        rst     38h
4229 ff        rst     38h
422a 014044    ld      bc,4440h
422d 04        inc     b
422e 8a        adc     a,d
422f 07        rlca    
4230 018a07    ld      bc,078ah
4233 018a07    ld      bc,078ah
4236 010408    ld      bc,0804h
4239 0f        rrca    
423a 07        rlca    
423b ff        rst     38h
423c ff        rst     38h
423d 5f        ld      e,a
423e 015055    ld      bc,5550h
4241 05        dec     b
4242 8a        adc     a,d
4243 0c        inc     c
4244 04        inc     b
4245 08        ex      af,af'
4246 0c        inc     c
4247 07        rlca    
4248 ff        rst     38h
4249 ff        rst     38h
424a ff        rst     38h
424b 014044    ld      bc,4440h
424e 04        inc     b
424f 8a        adc     a,d
4250 07        rlca    
4251 018a07    ld      bc,078ah
4254 010418    ld      bc,1804h
4257 80        add     a,b
4258 08        ex      af,af'
4259 08        ex      af,af'
425a 03        inc     bc
425b 01853d    ld      bc,3d85h
425e 80        add     a,b
425f 80        add     a,b
4260 5a        ld      e,d
4261 02        ld      (bc),a
4262 50        ld      d,b
4263 00        nop     
4264 0c        inc     c
4265 1807      jr      426eh
4267 ff        rst     38h
4268 ff        rst     38h
4269 0100ff    ld      bc,0ff00h
426c fe01      cp      01h
426e 09        add     hl,bc
426f 0b        dec     bc
4270 08        ex      af,af'
4271 0b        dec     bc
4272 03        inc     bc
4273 010043    ld      bc,4300h
4276 99        sbc     a,c
4277 02        ld      (bc),a
4278 00        nop     
4279 9a        sbc     a,d
427a 02        ld      (bc),a
427b 00        nop     
427c 9b        sbc     a,e
427d 02        ld      (bc),a
427e 00        nop     
427f 9c        sbc     a,h
4280 02        ld      (bc),a
4281 00        nop     
4282 08        ex      af,af'
4283 07        rlca    
4284 03        inc     bc
4285 02        ld      (bc),a
4286 ed42      sbc     hl,bc
4288 03        inc     bc
4289 01de42    ld      bc,42deh
428c 03        inc     bc
428d 02        ld      (bc),a
428e ed42      sbc     hl,bc
4290 03        inc     bc
4291 02        ld      (bc),a
4292 de42      sbc     a,42h
4294 03        inc     bc
4295 02        ld      (bc),a
4296 c0        ret     nz

4297 42        ld      b,d
4298 03        inc     bc
4299 02        ld      (bc),a
429a b0        or      b
429b 42        ld      b,d
429c 03        inc     bc
429d 02        ld      (bc),a
429e a3        and     e
429f 42        ld      b,d
42a0 015e42    ld      bc,425eh
42a3 9e        sbc     a,(hl)
42a4 2808      jr      z,42aeh
42a6 9f        sbc     a,a
42a7 48        ld      c,b
42a8 08        ex      af,af'
42a9 9f        sbc     a,a
42aa 2808      jr      z,42b4h
42ac 9e        sbc     a,(hl)
42ad 48        ld      c,b
42ae 08        ex      af,af'
42af 04        inc     b
42b0 9e        sbc     a,(hl)
42b1 3010      jr      nc,42c3h
42b3 9b        sbc     a,e
42b4 3010      jr      nc,42c6h
42b6 9d        sbc     a,l
42b7 60        ld      h,b
42b8 00        nop     
42b9 9b        sbc     a,e
42ba 1000      djnz    42bch
42bc 99        sbc     a,c
42bd 1000      djnz    42bfh
42bf 04        inc     b
42c0 08        ex      af,af'
42c1 07        rlca    
42c2 9d        sbc     a,l
42c3 2010      jr      nz,42d5h
42c5 9d        sbc     a,l
42c6 40        ld      b,b
42c7 109b      djnz    4264h
42c9 2010      jr      nz,42dbh
42cb 9b        sbc     a,e
42cc 40        ld      b,b
42cd 1099      djnz    4268h
42cf 2010      jr      nz,42e1h
42d1 9b        sbc     a,e
42d2 40        ld      b,b
42d3 109d      djnz    4272h
42d5 60        ld      h,b
42d6 00        nop     
42d7 9c        sbc     a,h
42d8 1000      djnz    42dah
42da 9b        sbc     a,e
42db 1000      djnz    42ddh
42dd 04        inc     b
42de 03        inc     bc
42df 03        inc     bc
42e0 e642      and     42h
42e2 9b        sbc     a,e
42e3 40        ld      b,b
42e4 00        nop     
42e5 04        inc     b
42e6 9b        sbc     a,e
42e7 08        ex      af,af'
42e8 189b      jr      4285h
42ea 1e02      ld      e,02h
42ec 04        inc     b
42ed 9d        sbc     a,l
42ee 60        ld      h,b
42ef 00        nop     
42f0 9c        sbc     a,h
42f1 1000      djnz    42f3h
42f3 9b        sbc     a,e
42f4 1000      djnz    42f6h
42f6 9d        sbc     a,l
42f7 5c        ld      e,h
42f8 04        inc     b
42f9 9d        sbc     a,l
42fa 1000      djnz    42fch
42fc 9e        sbc     a,(hl)
42fd 1000      djnz    42ffh
42ff 04        inc     b
4300 8a        adc     a,d
4301 02        ld      (bc),a
4302 00        nop     
4303 8b        adc     a,e
4304 02        ld      (bc),a
4305 00        nop     
4306 8c        adc     a,h
4307 02        ld      (bc),a
4308 00        nop     
4309 8d        adc     a,l
430a 02        ld      (bc),a
430b 00        nop     
430c 8e        adc     a,(hl)
430d 02        ld      (bc),a
430e 00        nop     
430f 8f        adc     a,a
4310 02        ld      (bc),a
4311 00        nop     
4312 90        sub     b
4313 02        ld      (bc),a
4314 00        nop     
4315 91        sub     c
4316 02        ld      (bc),a
4317 00        nop     
4318 92        sub     d
4319 02        ld      (bc),a
431a 00        nop     
431b 93        sub     e
431c 02        ld      (bc),a
431d 00        nop     
431e 94        sub     h
431f 02        ld      (bc),a
4320 00        nop     
4321 98        sbc     a,b
4322 02        ld      (bc),a
4323 00        nop     
4324 96        sub     (hl)
4325 02        ld      (bc),a
4326 00        nop     
4327 97        sub     a
4328 02        ld      (bc),a
4329 00        nop     
432a 98        sbc     a,b
432b 02        ld      (bc),a
432c 00        nop     
432d 04        inc     b
432e 1880      jr      42b0h
4330 08        ex      af,af'
4331 08        ex      af,af'
4332 03        inc     bc
4333 01853d    ld      bc,3d85h
4336 02        ld      (bc),a
4337 50        ld      d,b
4338 00        nop     
4339 0c        inc     c
433a 1807      jr      4343h
433c ff        rst     38h
433d ff        rst     38h
433e 0100ff    ld      bc,0ff00h
4341 fe01      cp      01h
4343 09        add     hl,bc
4344 0f        rrca    
4345 08        ex      af,af'
4346 05        dec     b
4347 80        add     a,b
4348 80        add     a,b
4349 61        ld      h,c
434a 03        inc     bc
434b 010043    ld      bc,4300h
434e 99        sbc     a,c
434f 010008    ld      bc,0800h
4352 0609      ld      b,09h
4354 0b        dec     bc
4355 03        inc     bc
4356 02        ld      (bc),a
4357 c1        pop     bc
4358 43        ld      b,e
4359 03        inc     bc
435a 01ac43    ld      bc,43ach
435d 03        inc     bc
435e 02        ld      (bc),a
435f c1        pop     bc
4360 43        ld      b,e
4361 03        inc     bc
4362 02        ld      (bc),a
4363 ac        xor     h
4364 43        ld      b,e
4365 03        inc     bc
4366 02        ld      (bc),a
4367 91        sub     c
4368 43        ld      b,e
4369 03        inc     bc
436a 02        ld      (bc),a
436b 81        add     a,c
436c 43        ld      b,e
436d 03        inc     bc
436e 02        ld      (bc),a
436f 74        ld      (hl),h
4370 43        ld      b,e
4371 013643    ld      bc,4336h
4374 99        sbc     a,c
4375 2808      jr      z,437fh
4377 99        sbc     a,c
4378 48        ld      c,b
4379 08        ex      af,af'
437a 9b        sbc     a,e
437b 2808      jr      z,4385h
437d 9b        sbc     a,e
437e 48        ld      c,b
437f 08        ex      af,af'
4380 04        inc     b
4381 9b        sbc     a,e
4382 3010      jr      nc,4394h
4384 98        sbc     a,b
4385 3010      jr      nc,4397h
4387 99        sbc     a,c
4388 60        ld      h,b
4389 00        nop     
438a 98        sbc     a,b
438b 1000      djnz    438dh
438d 96        sub     (hl)
438e 1000      djnz    4390h
4390 04        inc     b
4391 08        ex      af,af'
4392 07        rlca    
4393 99        sbc     a,c
4394 2010      jr      nz,43a6h
4396 98        sbc     a,b
4397 40        ld      b,b
4398 1098      djnz    4332h
439a 2010      jr      nz,43ach
439c 96        sub     (hl)
439d 40        ld      b,b
439e 1096      djnz    4336h
43a0 2010      jr      nz,43b2h
43a2 98        sbc     a,b
43a3 40        ld      b,b
43a4 1099      djnz    433fh
43a6 60        ld      h,b
43a7 00        nop     
43a8 99        sbc     a,c
43a9 2000      jr      nz,43abh
43ab 04        inc     b
43ac 03        inc     bc
43ad 03        inc     bc
43ae ba        cp      d
43af 43        ld      b,e
43b0 98        sbc     a,b
43b1 1000      djnz    43b3h
43b3 97        sub     a
43b4 1000      djnz    43b6h
43b6 98        sbc     a,b
43b7 2000      jr      nz,43b9h
43b9 04        inc     b
43ba 98        sbc     a,b
43bb 08        ex      af,af'
43bc 1897      jr      4355h
43be 1e02      ld      e,02h
43c0 04        inc     b
43c1 99        sbc     a,c
43c2 60        ld      h,b
43c3 00        nop     
43c4 99        sbc     a,c
43c5 2000      jr      nz,43c7h
43c7 99        sbc     a,c
43c8 5c        ld      e,h
43c9 04        inc     b
43ca 98        sbc     a,b
43cb 2000      jr      nz,43cdh
43cd 04        inc     b
43ce 1880      jr      4350h
43d0 08        ex      af,af'
43d1 08        ex      af,af'
43d2 03        inc     bc
43d3 01853d    ld      bc,3d85h
43d6 80        add     a,b
43d7 80        add     a,b
43d8 80        add     a,b
43d9 02        ld      (bc),a
43da 50        ld      d,b
43db 00        nop     
43dc 0c        inc     c
43dd 1807      jr      43e6h
43df ff        rst     38h
43e0 ff        rst     38h
43e1 0100ff    ld      bc,0ff00h
43e4 fe01      cp      01h
43e6 09        add     hl,bc
43e7 0b        dec     bc
43e8 08        ex      af,af'
43e9 0603      ld      b,03h
43eb 02        ld      (bc),a
43ec 56        ld      d,(hl)
43ed 44        ld      b,h
43ee 03        inc     bc
43ef 013e44    ld      bc,443eh
43f2 03        inc     bc
43f3 02        ld      (bc),a
43f4 56        ld      d,(hl)
43f5 44        ld      b,h
43f6 03        inc     bc
43f7 02        ld      (bc),a
43f8 3e44      ld      a,44h
43fa 03        inc     bc
43fb 02        ld      (bc),a
43fc 2644      ld      h,44h
43fe 03        inc     bc
43ff 02        ld      (bc),a
4400 1644      ld      d,44h
4402 03        inc     bc
4403 02        ld      (bc),a
4404 09        add     hl,bc
4405 44        ld      b,h
4406 01d643    ld      bc,43d6h
4409 96        sub     (hl)
440a 2808      jr      z,4414h
440c 96        sub     (hl)
440d 48        ld      c,b
440e 08        ex      af,af'
440f 98        sbc     a,b
4410 2808      jr      z,441ah
4412 97        sub     a
4413 48        ld      c,b
4414 08        ex      af,af'
4415 04        inc     b
4416 97        sub     a
4417 3010      jr      nc,4429h
4419 95        sub     l
441a 3010      jr      nc,442ch
441c 96        sub     (hl)
441d 60        ld      h,b
441e 00        nop     
441f 94        sub     h
4420 1000      djnz    4422h
4422 93        sub     e
4423 1000      djnz    4425h
4425 04        inc     b
4426 08        ex      af,af'
4427 08        ex      af,af'
4428 96        sub     (hl)
4429 2010      jr      nz,443bh
442b 95        sub     l
442c 40        ld      b,b
442d 1094      djnz    43c3h
442f 2010      jr      nz,4441h
4431 93        sub     e
4432 40        ld      b,b
4433 1092      djnz    43c7h
4435 2010      jr      nz,4447h
4437 94        sub     h
4438 40        ld      b,b
4439 1096      djnz    43d1h
443b 80        add     a,b
443c 00        nop     
443d 04        inc     b
443e 03        inc     bc
443f 03        inc     bc
4440 4f        ld      c,a
4441 44        ld      b,h
4442 94        sub     h
4443 1000      djnz    4445h
4445 93        sub     e
4446 1000      djnz    4448h
4448 94        sub     h
4449 1000      djnz    444bh
444b 95        sub     l
444c 1000      djnz    444eh
444e 04        inc     b
444f 94        sub     h
4450 08        ex      af,af'
4451 1893      jr      43e6h
4453 1e02      ld      e,02h
4455 04        inc     b
4456 96        sub     (hl)
4457 80        add     a,b
4458 00        nop     
4459 96        sub     (hl)
445a 5c        ld      e,h
445b 04        inc     b
445c 94        sub     h
445d 2000      jr      nz,445fh
445f 04        inc     b
4460 1880      jr      43e2h
4462 08        ex      af,af'
4463 08        ex      af,af'
4464 03        inc     bc
4465 01853d    ld      bc,3d85h
4468 03        inc     bc
4469 04        inc     b
446a 8c        adc     a,h
446b 49        ld      c,c
446c 0c        inc     c
446d 24        inc     h
446e 02        ld      (bc),a
446f 65        ld      h,l
4470 00        nop     
4471 07        rlca    
4472 71        ld      (hl),c
4473 1c        inc     e
4474 0100ff    ld      bc,0ff00h
4477 3a0303    ld      a,(0303h)
447a 02        ld      (bc),a
447b 88        adc     a,b
447c 44        ld      b,h
447d 03        inc     bc
447e 02        ld      (bc),a
447f 8c        adc     a,h
4480 49        ld      c,c
4481 03        inc     bc
4482 08        ex      af,af'
4483 8c        adc     a,h
4484 49        ld      c,c
4485 016844    ld      bc,4468h
4488 09        add     hl,bc
4489 03        inc     bc
448a 08        ex      af,af'
448b 09        add     hl,bc
448c 07        rlca    
448d 55        ld      d,l
448e 55        ld      d,l
448f 99        sbc     a,c
4490 09        add     hl,bc
4491 a0        and     b
4492 0a        ld      a,(bc)
4493 00        nop     
4494 9d        sbc     a,l
4495 04        inc     b
4496 0c        inc     c
4497 a5        and     l
4498 04        inc     b
4499 04        inc     b
449a 09        add     hl,bc
449b 0f        rrca    
449c 08        ex      af,af'
449d 07        rlca    
449e 07        rlca    
449f 55        ld      d,l
44a0 55        ld      d,l
44a1 cc0c80    call    z,800ch
44a4 08        ex      af,af'
44a5 00        nop     
44a6 9d        sbc     a,l
44a7 04        inc     b
44a8 04        inc     b
44a9 09        add     hl,bc
44aa 03        inc     bc
44ab 08        ex      af,af'
44ac 09        add     hl,bc
44ad 07        rlca    
44ae 55        ld      d,l
44af 55        ld      d,l
44b0 99        sbc     a,c
44b1 09        add     hl,bc
44b2 a0        and     b
44b3 0a        ld      a,(bc)
44b4 00        nop     
44b5 a4        and     h
44b6 04        inc     b
44b7 04        inc     b
44b8 09        add     hl,bc
44b9 0f        rrca    
44ba 08        ex      af,af'
44bb 07        rlca    
44bc 07        rlca    
44bd 55        ld      d,l
44be 55        ld      d,l
44bf cc0c80    call    z,800ch
44c2 08        ex      af,af'
44c3 00        nop     
44c4 a5        and     l
44c5 04        inc     b
44c6 04        inc     b
44c7 09        add     hl,bc
44c8 03        inc     bc
44c9 08        ex      af,af'
44ca 09        add     hl,bc
44cb 07        rlca    
44cc 55        ld      d,l
44cd 55        ld      d,l
44ce 99        sbc     a,c
44cf 09        add     hl,bc
44d0 a0        and     b
44d1 0a        ld      a,(bc)
44d2 00        nop     
44d3 a5        and     l
44d4 04        inc     b
44d5 04        inc     b
44d6 09        add     hl,bc
44d7 0f        rrca    
44d8 08        ex      af,af'
44d9 07        rlca    
44da 07        rlca    
44db 55        ld      d,l
44dc 55        ld      d,l
44dd cc0c80    call    z,800ch
44e0 08        ex      af,af'
44e1 00        nop     
44e2 a4        and     h
44e3 04        inc     b
44e4 04        inc     b
44e5 09        add     hl,bc
44e6 03        inc     bc
44e7 08        ex      af,af'
44e8 09        add     hl,bc
44e9 07        rlca    
44ea 55        ld      d,l
44eb 55        ld      d,l
44ec 99        sbc     a,c
44ed 09        add     hl,bc
44ee a0        and     b
44ef 0a        ld      a,(bc)
44f0 00        nop     
44f1 a2        and     d
44f2 04        inc     b
44f3 04        inc     b
44f4 09        add     hl,bc
44f5 0f        rrca    
44f6 08        ex      af,af'
44f7 07        rlca    
44f8 07        rlca    
44f9 55        ld      d,l
44fa 55        ld      d,l
44fb cc0c80    call    z,800ch
44fe 08        ex      af,af'
44ff 00        nop     
4500 a5        and     l
4501 04        inc     b
4502 04        inc     b
4503 09        add     hl,bc
4504 03        inc     bc
4505 08        ex      af,af'
4506 09        add     hl,bc
4507 07        rlca    
4508 55        ld      d,l
4509 55        ld      d,l
450a 99        sbc     a,c
450b 09        add     hl,bc
450c a0        and     b
450d 0a        ld      a,(bc)
450e 00        nop     
450f 9d        sbc     a,l
4510 04        inc     b
4511 04        inc     b
4512 09        add     hl,bc
4513 0f        rrca    
4514 08        ex      af,af'
4515 07        rlca    
4516 07        rlca    
4517 55        ld      d,l
4518 55        ld      d,l
4519 cc0c80    call    z,800ch
451c 08        ex      af,af'
451d 00        nop     
451e a2        and     d
451f 04        inc     b
4520 04        inc     b
4521 09        add     hl,bc
4522 03        inc     bc
4523 08        ex      af,af'
4524 09        add     hl,bc
4525 07        rlca    
4526 55        ld      d,l
4527 55        ld      d,l
4528 99        sbc     a,c
4529 09        add     hl,bc
452a a0        and     b
452b 0a        ld      a,(bc)
452c 00        nop     
452d 9b        sbc     a,e
452e 04        inc     b
452f 04        inc     b
4530 09        add     hl,bc
4531 0f        rrca    
4532 08        ex      af,af'
4533 07        rlca    
4534 07        rlca    
4535 55        ld      d,l
4536 55        ld      d,l
4537 cc0c80    call    z,800ch
453a 08        ex      af,af'
453b 00        nop     
453c 9d        sbc     a,l
453d 04        inc     b
453e 04        inc     b
453f 09        add     hl,bc
4540 03        inc     bc
4541 08        ex      af,af'
4542 09        add     hl,bc
4543 07        rlca    
4544 55        ld      d,l
4545 55        ld      d,l
4546 99        sbc     a,c
4547 09        add     hl,bc
4548 a0        and     b
4549 0a        ld      a,(bc)
454a 00        nop     
454b 9c        sbc     a,h
454c 04        inc     b
454d 04        inc     b
454e 09        add     hl,bc
454f 0f        rrca    
4550 08        ex      af,af'
4551 07        rlca    
4552 07        rlca    
4553 55        ld      d,l
4554 55        ld      d,l
4555 cc0c80    call    z,800ch
4558 08        ex      af,af'
4559 00        nop     
455a 9b        sbc     a,e
455b 04        inc     b
455c 04        inc     b
455d 09        add     hl,bc
455e 03        inc     bc
455f 08        ex      af,af'
4560 09        add     hl,bc
4561 07        rlca    
4562 55        ld      d,l
4563 55        ld      d,l
4564 99        sbc     a,c
4565 09        add     hl,bc
4566 a0        and     b
4567 0a        ld      a,(bc)
4568 00        nop     
4569 9d        sbc     a,l
456a 04        inc     b
456b 04        inc     b
456c 09        add     hl,bc
456d 0f        rrca    
456e 08        ex      af,af'
456f 07        rlca    
4570 07        rlca    
4571 55        ld      d,l
4572 55        ld      d,l
4573 cc0c80    call    z,800ch
4576 08        ex      af,af'
4577 00        nop     
4578 9c        sbc     a,h
4579 04        inc     b
457a 04        inc     b
457b 09        add     hl,bc
457c 03        inc     bc
457d 08        ex      af,af'
457e 09        add     hl,bc
457f 07        rlca    
4580 55        ld      d,l
4581 55        ld      d,l
4582 99        sbc     a,c
4583 09        add     hl,bc
4584 a0        and     b
4585 0a        ld      a,(bc)
4586 00        nop     
4587 a5        and     l
4588 04        inc     b
4589 04        inc     b
458a 09        add     hl,bc
458b 0f        rrca    
458c 08        ex      af,af'
458d 07        rlca    
458e 07        rlca    
458f 55        ld      d,l
4590 55        ld      d,l
4591 cc0c80    call    z,800ch
4594 08        ex      af,af'
4595 00        nop     
4596 9d        sbc     a,l
4597 04        inc     b
4598 04        inc     b
4599 09        add     hl,bc
459a 03        inc     bc
459b 08        ex      af,af'
459c 09        add     hl,bc
459d 07        rlca    
459e 55        ld      d,l
459f 55        ld      d,l
45a0 99        sbc     a,c
45a1 09        add     hl,bc
45a2 a0        and     b
45a3 0a        ld      a,(bc)
45a4 00        nop     
45a5 a4        and     h
45a6 04        inc     b
45a7 04        inc     b
45a8 09        add     hl,bc
45a9 0f        rrca    
45aa 08        ex      af,af'
45ab 07        rlca    
45ac 07        rlca    
45ad 55        ld      d,l
45ae 55        ld      d,l
45af cc0c80    call    z,800ch
45b2 08        ex      af,af'
45b3 00        nop     
45b4 a5        and     l
45b5 04        inc     b
45b6 04        inc     b
45b7 09        add     hl,bc
45b8 03        inc     bc
45b9 08        ex      af,af'
45ba 09        add     hl,bc
45bb 07        rlca    
45bc 55        ld      d,l
45bd 55        ld      d,l
45be 99        sbc     a,c
45bf 09        add     hl,bc
45c0 a0        and     b
45c1 0a        ld      a,(bc)
45c2 00        nop     
45c3 a5        and     l
45c4 04        inc     b
45c5 04        inc     b
45c6 09        add     hl,bc
45c7 0f        rrca    
45c8 08        ex      af,af'
45c9 07        rlca    
45ca 07        rlca    
45cb 55        ld      d,l
45cc 55        ld      d,l
45cd cc0c80    call    z,800ch
45d0 08        ex      af,af'
45d1 00        nop     
45d2 a4        and     h
45d3 04        inc     b
45d4 04        inc     b
45d5 09        add     hl,bc
45d6 03        inc     bc
45d7 08        ex      af,af'
45d8 09        add     hl,bc
45d9 07        rlca    
45da 55        ld      d,l
45db 55        ld      d,l
45dc 99        sbc     a,c
45dd 09        add     hl,bc
45de a0        and     b
45df 0a        ld      a,(bc)
45e0 00        nop     
45e1 a7        and     a
45e2 04        inc     b
45e3 04        inc     b
45e4 09        add     hl,bc
45e5 0f        rrca    
45e6 08        ex      af,af'
45e7 07        rlca    
45e8 07        rlca    
45e9 55        ld      d,l
45ea 55        ld      d,l
45eb cc0c80    call    z,800ch
45ee 08        ex      af,af'
45ef 00        nop     
45f0 a5        and     l
45f1 04        inc     b
45f2 04        inc     b
45f3 09        add     hl,bc
45f4 03        inc     bc
45f5 08        ex      af,af'
45f6 09        add     hl,bc
45f7 07        rlca    
45f8 55        ld      d,l
45f9 55        ld      d,l
45fa 99        sbc     a,c
45fb 09        add     hl,bc
45fc a0        and     b
45fd 0a        ld      a,(bc)
45fe 00        nop     
45ff a5        and     l
4600 04        inc     b
4601 04        inc     b
4602 09        add     hl,bc
4603 0f        rrca    
4604 08        ex      af,af'
4605 07        rlca    
4606 07        rlca    
4607 55        ld      d,l
4608 55        ld      d,l
4609 cc0c80    call    z,800ch
460c 08        ex      af,af'
460d 00        nop     
460e a7        and     a
460f 04        inc     b
4610 04        inc     b
4611 09        add     hl,bc
4612 03        inc     bc
4613 08        ex      af,af'
4614 09        add     hl,bc
4615 07        rlca    
4616 55        ld      d,l
4617 55        ld      d,l
4618 99        sbc     a,c
4619 09        add     hl,bc
461a a0        and     b
461b 0a        ld      a,(bc)
461c 00        nop     
461d a4        and     h
461e 04        inc     b
461f 04        inc     b
4620 09        add     hl,bc
4621 0f        rrca    
4622 08        ex      af,af'
4623 07        rlca    
4624 07        rlca    
4625 55        ld      d,l
4626 55        ld      d,l
4627 cc0c80    call    z,800ch
462a 08        ex      af,af'
462b 00        nop     
462c a5        and     l
462d 04        inc     b
462e 04        inc     b
462f 09        add     hl,bc
4630 03        inc     bc
4631 08        ex      af,af'
4632 09        add     hl,bc
4633 07        rlca    
4634 55        ld      d,l
4635 55        ld      d,l
4636 99        sbc     a,c
4637 09        add     hl,bc
4638 a0        and     b
4639 0a        ld      a,(bc)
463a 00        nop     
463b a5        and     l
463c 04        inc     b
463d 04        inc     b
463e 09        add     hl,bc
463f 0f        rrca    
4640 08        ex      af,af'
4641 07        rlca    
4642 07        rlca    
4643 55        ld      d,l
4644 55        ld      d,l
4645 cc0c80    call    z,800ch
4648 08        ex      af,af'
4649 00        nop     
464a a4        and     h
464b 04        inc     b
464c 04        inc     b
464d 04        inc     b
464e 1880      jr      45d0h
4650 08        ex      af,af'
4651 08        ex      af,af'
4652 03        inc     bc
4653 01853d    ld      bc,3d85h
4656 09        add     hl,bc
4657 0a        ld      a,(bc)
4658 02        ld      (bc),a
4659 2c        inc     l
465a 00        nop     
465b 0c        inc     c
465c 1808      jr      4666h
465e 0c        inc     c
465f 07        rlca    
4660 ff        rst     38h
4661 ff        rst     38h
4662 3f        ccf     
4663 00        nop     
4664 e0        ret     po

4665 73        ld      (hl),e
4666 00        nop     
4667 96        sub     (hl)
4668 80        add     a,b
4669 80        add     a,b
466a 03        inc     bc
466b 02        ld      (bc),a
466c a5        and     l
466d 47        ld      b,a
466e 03        inc     bc
466f 01f146    ld      bc,46f1h
4672 03        inc     bc
4673 02        ld      (bc),a
4674 a5        and     l
4675 47        ld      b,a
4676 03        inc     bc
4677 02        ld      (bc),a
4678 f1        pop     af
4679 46        ld      b,(hl)
467a 03        inc     bc
467b 02        ld      (bc),a
467c ce46      adc     a,46h
467e 03        inc     bc
467f 02        ld      (bc),a
4680 96        sub     (hl)
4681 46        ld      b,(hl)
4682 03        inc     bc
4683 02        ld      (bc),a
4684 89        adc     a,c
4685 46        ld      b,(hl)
4686 015646    ld      bc,4656h
4689 92        sub     d
468a 2808      jr      z,4694h
468c 93        sub     e
468d 48        ld      c,b
468e 08        ex      af,af'
468f 98        sbc     a,b
4690 2808      jr      z,469ah
4692 97        sub     a
4693 48        ld      c,b
4694 08        ex      af,af'
4695 04        inc     b
4696 02        ld      (bc),a
4697 2c        inc     l
4698 00        nop     
4699 0c        inc     c
469a 1808      jr      46a4h
469c 0c        inc     c
469d 07        rlca    
469e ff        rst     38h
469f ff        rst     38h
46a0 3f        ccf     
46a1 00        nop     
46a2 e0        ret     po

46a3 73        ld      (hl),e
46a4 00        nop     
46a5 97        sub     a
46a6 3808      jr      c,46b0h
46a8 95        sub     l
46a9 3808      jr      c,46b3h
46ab 02        ld      (bc),a
46ac 7c        ld      a,h
46ad 00        nop     
46ae 0c        inc     c
46af 1f        rra     
46b0 03        inc     bc
46b1 02        ld      (bc),a
46b2 0e48      ld      c,48h
46b4 03        inc     bc
46b5 01e347    ld      bc,47e3h
46b8 02        ld      (bc),a
46b9 2c        inc     l
46ba 00        nop     
46bb 0c        inc     c
46bc 1808      jr      46c6h
46be 0c        inc     c
46bf 07        rlca    
46c0 ff        rst     38h
46c1 ff        rst     38h
46c2 3f        ccf     
46c3 00        nop     
46c4 e0        ret     po

46c5 73        ld      (hl),e
46c6 00        nop     
46c7 94        sub     h
46c8 08        ex      af,af'
46c9 08        ex      af,af'
46ca 93        sub     e
46cb 08        ex      af,af'
46cc 08        ex      af,af'
46cd 04        inc     b
46ce 02        ld      (bc),a
46cf 7c        ld      a,h
46d0 00        nop     
46d1 0c        inc     c
46d2 1f        rra     
46d3 03        inc     bc
46d4 0c        inc     c
46d5 0e48      ld      c,48h
46d7 03        inc     bc
46d8 01d547    ld      bc,47d5h
46db 02        ld      (bc),a
46dc 2c        inc     l
46dd 00        nop     
46de 0c        inc     c
46df 1808      jr      46e9h
46e1 0c        inc     c
46e2 07        rlca    
46e3 ff        rst     38h
46e4 ff        rst     38h
46e5 3f        ccf     
46e6 00        nop     
46e7 e0        ret     po

46e8 73        ld      (hl),e
46e9 00        nop     
46ea 9c        sbc     a,h
46eb 08        ex      af,af'
46ec 08        ex      af,af'
46ed 9b        sbc     a,e
46ee 08        ex      af,af'
46ef 08        ex      af,af'
46f0 04        inc     b
46f1 03        inc     bc
46f2 03        inc     bc
46f3 63        ld      h,e
46f4 47        ld      b,a
46f5 02        ld      (bc),a
46f6 7c        ld      a,h
46f7 00        nop     
46f8 0c        inc     c
46f9 1f        rra     
46fa 08        ex      af,af'
46fb 0e07      ld      c,07h
46fd ff        rst     38h
46fe ff        rst     38h
46ff 1100ff    ld      de,0ff00h
4702 00        nop     
4703 019407    ld      bc,0794h
4706 01080c    ld      bc,0c08h
4709 07        rlca    
470a ff        rst     38h
470b ff        rst     38h
470c 2202e0    ld      (0e002h),hl
470f e0        ret     po

4710 00        nop     
4711 94        sub     h
4712 07        rlca    
4713 01080e    ld      bc,0e08h
4716 07        rlca    
4717 ff        rst     38h
4718 ff        rst     38h
4719 1100ff    ld      de,0ff00h
471c 00        nop     
471d 019307    ld      bc,0793h
4720 01080c    ld      bc,0c08h
4723 07        rlca    
4724 ff        rst     38h
4725 ff        rst     38h
4726 2202e0    ld      (0e002h),hl
4729 e0        ret     po

472a 00        nop     
472b 93        sub     e
472c 07        rlca    
472d 01080e    ld      bc,0e08h
4730 07        rlca    
4731 ff        rst     38h
4732 ff        rst     38h
4733 1100ff    ld      de,0ff00h
4736 00        nop     
4737 019407    ld      bc,0794h
473a 01080c    ld      bc,0c08h
473d 07        rlca    
473e ff        rst     38h
473f ff        rst     38h
4740 2202e0    ld      (0e002h),hl
4743 e0        ret     po

4744 00        nop     
4745 94        sub     h
4746 07        rlca    
4747 01080e    ld      bc,0e08h
474a 07        rlca    
474b ff        rst     38h
474c ff        rst     38h
474d 1100ff    ld      de,0ff00h
4750 00        nop     
4751 019507    ld      bc,0795h
4754 01080c    ld      bc,0c08h
4757 07        rlca    
4758 ff        rst     38h
4759 ff        rst     38h
475a 2202e0    ld      (0e002h),hl
475d e0        ret     po

475e 00        nop     
475f 95        sub     l
4760 07        rlca    
4761 010402    ld      bc,0204h
4764 7c        ld      a,h
4765 00        nop     
4766 0c        inc     c
4767 1f        rra     
4768 08        ex      af,af'
4769 0e07      ld      c,07h
476b ff        rst     38h
476c ff        rst     38h
476d 1100ff    ld      de,0ff00h
4770 00        nop     
4771 019407    ld      bc,0794h
4774 01080c    ld      bc,0c08h
4777 07        rlca    
4778 ff        rst     38h
4779 ff        rst     38h
477a 2202e0    ld      (0e002h),hl
477d e0        ret     po

477e 00        nop     
477f 94        sub     h
4780 07        rlca    
4781 01080e    ld      bc,0e08h
4784 07        rlca    
4785 ff        rst     38h
4786 ff        rst     38h
4787 1100ff    ld      de,0ff00h
478a 00        nop     
478b 019407    ld      bc,0794h
478e 019407    ld      bc,0794h
4791 01022c    ld      bc,2c02h
4794 00        nop     
4795 0c        inc     c
4796 1808      jr      47a0h
4798 0c        inc     c
4799 07        rlca    
479a ff        rst     38h
479b ff        rst     38h
479c 3f        ccf     
479d 00        nop     
479e e0        ret     po

479f 73        ld      (hl),e
47a0 00        nop     
47a1 93        sub     e
47a2 1010      djnz    47b4h
47a4 04        inc     b
47a5 03        inc     bc
47a6 01d547    ld      bc,47d5h
47a9 02        ld      (bc),a
47aa 2c        inc     l
47ab 00        nop     
47ac 0c        inc     c
47ad 1808      jr      47b7h
47af 0c        inc     c
47b0 07        rlca    
47b1 ff        rst     38h
47b2 ff        rst     38h
47b3 3f        ccf     
47b4 00        nop     
47b5 e0        ret     po

47b6 73        ld      (hl),e
47b7 00        nop     
47b8 9c        sbc     a,h
47b9 08        ex      af,af'
47ba 08        ex      af,af'
47bb 9b        sbc     a,e
47bc 08        ex      af,af'
47bd 08        ex      af,af'
47be 03        inc     bc
47bf 01d547    ld      bc,47d5h
47c2 02        ld      (bc),a
47c3 2c        inc     l
47c4 00        nop     
47c5 0c        inc     c
47c6 1808      jr      47d0h
47c8 0c        inc     c
47c9 07        rlca    
47ca ff        rst     38h
47cb ff        rst     38h
47cc 3f        ccf     
47cd 00        nop     
47ce e0        ret     po

47cf 73        ld      (hl),e
47d0 00        nop     
47d1 95        sub     l
47d2 1808      jr      47dch
47d4 04        inc     b
47d5 02        ld      (bc),a
47d6 7c        ld      a,h
47d7 00        nop     
47d8 0c        inc     c
47d9 1f        rra     
47da 03        inc     bc
47db 02        ld      (bc),a
47dc 0e48      ld      c,48h
47de 03        inc     bc
47df 01e347    ld      bc,47e3h
47e2 04        inc     b
47e3 08        ex      af,af'
47e4 0e07      ld      c,07h
47e6 ff        rst     38h
47e7 ff        rst     38h
47e8 1100ff    ld      de,0ff00h
47eb 00        nop     
47ec 019607    ld      bc,0796h
47ef 01080c    ld      bc,0c08h
47f2 07        rlca    
47f3 ff        rst     38h
47f4 ff        rst     38h
47f5 2202e0    ld      (0e002h),hl
47f8 e0        ret     po

47f9 00        nop     
47fa 96        sub     (hl)
47fb 07        rlca    
47fc 01080e    ld      bc,0e08h
47ff 07        rlca    
4800 ff        rst     38h
4801 ff        rst     38h
4802 1100ff    ld      de,0ff00h
4805 00        nop     
4806 019607    ld      bc,0796h
4809 019607    ld      bc,0796h
480c 010408    ld      bc,0804h
480f 0e07      ld      c,07h
4811 ff        rst     38h
4812 ff        rst     38h
4813 1100ff    ld      de,0ff00h
4816 00        nop     
4817 019608    ld      bc,0896h
481a 08        ex      af,af'
481b 08        ex      af,af'
481c 0c        inc     c
481d 07        rlca    
481e ff        rst     38h
481f ff        rst     38h
4820 2202e0    ld      (0e002h),hl
4823 e0        ret     po

4824 00        nop     
4825 96        sub     (hl)
4826 07        rlca    
4827 019607    ld      bc,0796h
482a 010418    ld      bc,1804h
482d 80        add     a,b
482e 08        ex      af,af'
482f 08        ex      af,af'
4830 03        inc     bc
4831 01853d    ld      bc,3d85h
4834 80        add     a,b
4835 80        add     a,b
4836 80        add     a,b
4837 80        add     a,b
4838 80        add     a,b
4839 80        add     a,b
483a 80        add     a,b
483b 80        add     a,b
483c 80        add     a,b
483d 80        add     a,b
483e 80        add     a,b
483f 80        add     a,b
4840 80        add     a,b
4841 80        add     a,b
4842 80        add     a,b
4843 80        add     a,b
4844 80        add     a,b
4845 80        add     a,b
4846 80        add     a,b
4847 80        add     a,b
4848 80        add     a,b
4849 80        add     a,b
484a 80        add     a,b
484b 80        add     a,b
484c 80        add     a,b
484d 80        add     a,b
484e 80        add     a,b
484f 80        add     a,b
4850 80        add     a,b
4851 00        nop     
4852 02        ld      (bc),a
4853 69        ld      l,c
4854 00        nop     
4855 0c        inc     c
4856 1809      jr      4861h
4858 08        ex      af,af'
4859 08        ex      af,af'
485a 0c        inc     c
485b 07        rlca    
485c ff        rst     38h
485d ff        rst     38h
485e 88        adc     a,b
485f 00        nop     
4860 80        add     a,b
4861 78        ld      a,b
4862 00        nop     
4863 80        add     a,b
4864 1000      djnz    4866h
4866 9c        sbc     a,h
4867 04        inc     b
4868 0c        inc     c
4869 9c        sbc     a,h
486a 04        inc     b
486b 0c        inc     c
486c 13        inc     de
486d 58        ld      e,b
486e 02        ld      (bc),a
486f 6f        ld      l,a
4870 02        ld      (bc),a
4871 00        nop     
4872 9c        sbc     a,h
4873 08        ex      af,af'
4874 48        ld      c,b
4875 1b        dec     de
4876 80        add     a,b
4877 80        add     a,b
4878 80        add     a,b
4879 80        add     a,b
487a 80        add     a,b
487b 00        nop     
487c 80        add     a,b
487d 1000      djnz    487fh
487f 9c        sbc     a,h
4880 04        inc     b
4881 0c        inc     c
4882 9c        sbc     a,h
4883 04        inc     b
4884 0c        inc     c
4885 9c        sbc     a,h
4886 04        inc     b
4887 0c        inc     c
4888 13        inc     de
4889 58        ld      e,b
488a 02        ld      (bc),a
488b 6f        ld      l,a
488c 02        ld      (bc),a
488d 00        nop     
488e 9e        sbc     a,(hl)
488f 08        ex      af,af'
4890 3880      jr      c,4812h
4892 80        add     a,b
4893 80        add     a,b
4894 80        add     a,b
4895 80        add     a,b
4896 80        add     a,b
4897 80        add     a,b
4898 80        add     a,b
4899 80        add     a,b
489a 80        add     a,b
489b 80        add     a,b
489c 80        add     a,b
489d 013448    ld      bc,4834h
48a0 1880      jr      4822h
48a2 08        ex      af,af'
48a3 08        ex      af,af'
48a4 03        inc     bc
48a5 01853d    ld      bc,3d85h
48a8 80        add     a,b
48a9 80        add     a,b
48aa 80        add     a,b
48ab 80        add     a,b
48ac 80        add     a,b
48ad 80        add     a,b
48ae 80        add     a,b
48af 80        add     a,b
48b0 80        add     a,b
48b1 80        add     a,b
48b2 80        add     a,b
48b3 80        add     a,b
48b4 80        add     a,b
48b5 80        add     a,b
48b6 80        add     a,b
48b7 80        add     a,b
48b8 80        add     a,b
48b9 80        add     a,b
48ba 80        add     a,b
48bb 80        add     a,b
48bc 80        add     a,b
48bd 80        add     a,b
48be 80        add     a,b
48bf 80        add     a,b
48c0 80        add     a,b
48c1 80        add     a,b
48c2 80        add     a,b
48c3 80        add     a,b
48c4 80        add     a,b
48c5 00        nop     
48c6 02        ld      (bc),a
48c7 69        ld      l,c
48c8 00        nop     
48c9 0c        inc     c
48ca 1809      jr      48d5h
48cc 02        ld      (bc),a
48cd 08        ex      af,af'
48ce 08        ex      af,af'
48cf 07        rlca    
48d0 ff        rst     38h
48d1 ff        rst     38h
48d2 88        adc     a,b
48d3 00        nop     
48d4 80        add     a,b
48d5 78        ld      a,b
48d6 00        nop     
48d7 80        add     a,b
48d8 0a        ld      a,(bc)
48d9 00        nop     
48da 80        add     a,b
48db 1000      djnz    48ddh
48dd 9c        sbc     a,h
48de 04        inc     b
48df 0c        inc     c
48e0 9c        sbc     a,h
48e1 04        inc     b
48e2 0c        inc     c
48e3 13        inc     de
48e4 58        ld      e,b
48e5 02        ld      (bc),a
48e6 6f        ld      l,a
48e7 02        ld      (bc),a
48e8 00        nop     
48e9 9c        sbc     a,h
48ea 08        ex      af,af'
48eb 48        ld      c,b
48ec 80        add     a,b
48ed 80        add     a,b
48ee 80        add     a,b
48ef 80        add     a,b
48f0 80        add     a,b
48f1 00        nop     
48f2 80        add     a,b
48f3 1000      djnz    48f5h
48f5 9c        sbc     a,h
48f6 04        inc     b
48f7 0c        inc     c
48f8 9c        sbc     a,h
48f9 04        inc     b
48fa 0c        inc     c
48fb 9c        sbc     a,h
48fc 04        inc     b
48fd 0c        inc     c
48fe 13        inc     de
48ff 58        ld      e,b
4900 02        ld      (bc),a
4901 6f        ld      l,a
4902 02        ld      (bc),a
4903 00        nop     
4904 9e        sbc     a,(hl)
4905 08        ex      af,af'
4906 3880      jr      c,4888h
4908 76        halt    
4909 80        add     a,b
490a 80        add     a,b
490b 80        add     a,b
490c 80        add     a,b
490d 80        add     a,b
490e 80        add     a,b
490f 80        add     a,b
4910 80        add     a,b
4911 80        add     a,b
4912 80        add     a,b
4913 01a848    ld      bc,48a8h
4916 1880      jr      4898h
4918 08        ex      af,af'
4919 08        ex      af,af'
491a 03        inc     bc
491b 01853d    ld      bc,3d85h
491e 80        add     a,b
491f 80        add     a,b
4920 80        add     a,b
4921 80        add     a,b
4922 80        add     a,b
4923 80        add     a,b
4924 80        add     a,b
4925 80        add     a,b
4926 80        add     a,b
4927 80        add     a,b
4928 80        add     a,b
4929 80        add     a,b
492a 80        add     a,b
492b 80        add     a,b
492c 80        add     a,b
492d 80        add     a,b
492e 80        add     a,b
492f 80        add     a,b
4930 80        add     a,b
4931 80        add     a,b
4932 80        add     a,b
4933 80        add     a,b
4934 80        add     a,b
4935 80        add     a,b
4936 80        add     a,b
4937 80        add     a,b
4938 80        add     a,b
4939 80        add     a,b
493a 80        add     a,b
493b 00        nop     
493c 02        ld      (bc),a
493d 69        ld      l,c
493e 00        nop     
493f 0c        inc     c
4940 1809      jr      494bh
4942 0f        rrca    
4943 08        ex      af,af'
4944 05        dec     b
4945 07        rlca    
4946 ff        rst     38h
4947 ff        rst     38h
4948 88        adc     a,b
4949 00        nop     
494a 80        add     a,b
494b 78        ld      a,b
494c 00        nop     
494d 80        add     a,b
494e 15        dec     d
494f 00        nop     
4950 80        add     a,b
4951 1000      djnz    4953h
4953 9c        sbc     a,h
4954 04        inc     b
4955 0c        inc     c
4956 9c        sbc     a,h
4957 04        inc     b
4958 0c        inc     c
4959 13        inc     de
495a 58        ld      e,b
495b 02        ld      (bc),a
495c 6f        ld      l,a
495d 02        ld      (bc),a
495e 00        nop     
495f 9c        sbc     a,h
4960 08        ex      af,af'
4961 48        ld      c,b
4962 80        add     a,b
4963 80        add     a,b
4964 80        add     a,b
4965 80        add     a,b
4966 80        add     a,b
4967 00        nop     
4968 80        add     a,b
4969 1000      djnz    496bh
496b 9c        sbc     a,h
496c 04        inc     b
496d 0c        inc     c
496e 9c        sbc     a,h
496f 04        inc     b
4970 0c        inc     c
4971 9c        sbc     a,h
4972 04        inc     b
4973 0c        inc     c
4974 13        inc     de
4975 58        ld      e,b
4976 02        ld      (bc),a
4977 6f        ld      l,a
4978 02        ld      (bc),a
4979 00        nop     
497a 9e        sbc     a,(hl)
497b 08        ex      af,af'
497c 3880      jr      c,48feh
497e 6b        ld      l,e
497f 80        add     a,b
4980 80        add     a,b
4981 80        add     a,b
4982 80        add     a,b
4983 80        add     a,b
4984 80        add     a,b
4985 80        add     a,b
4986 80        add     a,b
4987 80        add     a,b
4988 80        add     a,b
4989 011e49    ld      bc,491eh
498c 80        add     a,b
498d 80        add     a,b
498e 80        add     a,b
498f 04        inc     b
4990 1802      jr      4994h
4992 2f        cpl     
4993 00        nop     
4994 0c        inc     c
4995 1607      ld      d,07h
4997 ff        rst     38h
4998 ff        rst     38h
4999 63        ld      h,e
499a 00        nop     
499b 80        add     a,b
499c 88        adc     a,b
499d 08        ex      af,af'
499e 08        ex      af,af'
499f 0e09      ld      c,09h
49a1 09        add     hl,bc
49a2 99        sbc     a,c
49a3 07        rlca    
49a4 019b07    ld      bc,079bh
49a7 019907    ld      bc,0799h
49aa 010301    ld      bc,0103h
49ad 59        ld      e,c
49ae 4b        ld      c,e
49af 03        inc     bc
49b0 01134b    ld      bc,4b13h
49b3 02        ld      (bc),a
49b4 2a000c    ld      hl,(0c00h)
49b7 1807      jr      49c0h
49b9 ff        rst     38h
49ba ff        rst     38h
49bb 40        ld      b,b
49bc 00        nop     
49bd c0        ret     nz

49be 33        inc     sp
49bf 01080c    ld      bc,0c08h
49c2 09        add     hl,bc
49c3 09        add     hl,bc
49c4 03        inc     bc
49c5 01a34a    ld      bc,4aa3h
49c8 08        ex      af,af'
49c9 0e09      ld      c,09h
49cb 0a        ld      a,(bc)
49cc 03        inc     bc
49cd 01d349    ld      bc,49d3h
49d0 019149    ld      bc,4991h
49d3 a0        and     b
49d4 04        inc     b
49d5 02        ld      (bc),a
49d6 9c        sbc     a,h
49d7 04        inc     b
49d8 02        ld      (bc),a
49d9 97        sub     a
49da 04        inc     b
49db 02        ld      (bc),a
49dc 94        sub     h
49dd 04        inc     b
49de 02        ld      (bc),a
49df a0        and     b
49e0 04        inc     b
49e1 02        ld      (bc),a
49e2 9c        sbc     a,h
49e3 04        inc     b
49e4 02        ld      (bc),a
49e5 97        sub     a
49e6 04        inc     b
49e7 02        ld      (bc),a
49e8 94        sub     h
49e9 04        inc     b
49ea 02        ld      (bc),a
49eb a0        and     b
49ec 04        inc     b
49ed 02        ld      (bc),a
49ee 9c        sbc     a,h
49ef 04        inc     b
49f0 02        ld      (bc),a
49f1 97        sub     a
49f2 04        inc     b
49f3 02        ld      (bc),a
49f4 94        sub     h
49f5 04        inc     b
49f6 02        ld      (bc),a
49f7 9e        sbc     a,(hl)
49f8 04        inc     b
49f9 02        ld      (bc),a
49fa 9b        sbc     a,e
49fb 04        inc     b
49fc 02        ld      (bc),a
49fd 97        sub     a
49fe 04        inc     b
49ff 02        ld      (bc),a
4a00 92        sub     d
4a01 04        inc     b
4a02 02        ld      (bc),a
4a03 9e        sbc     a,(hl)
4a04 04        inc     b
4a05 02        ld      (bc),a
4a06 99        sbc     a,c
4a07 04        inc     b
4a08 02        ld      (bc),a
4a09 96        sub     (hl)
4a0a 04        inc     b
4a0b 02        ld      (bc),a
4a0c 92        sub     d
4a0d 04        inc     b
4a0e 02        ld      (bc),a
4a0f 9e        sbc     a,(hl)
4a10 04        inc     b
4a11 02        ld      (bc),a
4a12 99        sbc     a,c
4a13 04        inc     b
4a14 02        ld      (bc),a
4a15 96        sub     (hl)
4a16 04        inc     b
4a17 02        ld      (bc),a
4a18 92        sub     d
4a19 04        inc     b
4a1a 02        ld      (bc),a
4a1b 9e        sbc     a,(hl)
4a1c 04        inc     b
4a1d 02        ld      (bc),a
4a1e 99        sbc     a,c
4a1f 04        inc     b
4a20 02        ld      (bc),a
4a21 96        sub     (hl)
4a22 04        inc     b
4a23 02        ld      (bc),a
4a24 92        sub     d
4a25 04        inc     b
4a26 02        ld      (bc),a
4a27 9e        sbc     a,(hl)
4a28 04        inc     b
4a29 02        ld      (bc),a
4a2a 99        sbc     a,c
4a2b 04        inc     b
4a2c 02        ld      (bc),a
4a2d 96        sub     (hl)
4a2e 04        inc     b
4a2f 02        ld      (bc),a
4a30 92        sub     d
4a31 04        inc     b
4a32 02        ld      (bc),a
4a33 9c        sbc     a,h
4a34 0602      ld      b,02h
4a36 9c        sbc     a,h
4a37 0602      ld      b,02h
4a39 9e        sbc     a,(hl)
4a3a 0602      ld      b,02h
4a3c 9e        sbc     a,(hl)
4a3d 0602      ld      b,02h
4a3f a0        and     b
4a40 0602      ld      b,02h
4a42 a0        and     b
4a43 0602      ld      b,02h
4a45 9b        sbc     a,e
4a46 0602      ld      b,02h
4a48 9b        sbc     a,e
4a49 0602      ld      b,02h
4a4b 99        sbc     a,c
4a4c 0602      ld      b,02h
4a4e 99        sbc     a,c
4a4f 0602      ld      b,02h
4a51 97        sub     a
4a52 0602      ld      b,02h
4a54 97        sub     a
4a55 0602      ld      b,02h
4a57 9e        sbc     a,(hl)
4a58 04        inc     b
4a59 02        ld      (bc),a
4a5a 99        sbc     a,c
4a5b 04        inc     b
4a5c 02        ld      (bc),a
4a5d 96        sub     (hl)
4a5e 04        inc     b
4a5f 02        ld      (bc),a
4a60 92        sub     d
4a61 04        inc     b
4a62 02        ld      (bc),a
4a63 9e        sbc     a,(hl)
4a64 04        inc     b
4a65 02        ld      (bc),a
4a66 99        sbc     a,c
4a67 04        inc     b
4a68 02        ld      (bc),a
4a69 96        sub     (hl)
4a6a 04        inc     b
4a6b 02        ld      (bc),a
4a6c 92        sub     d
4a6d 04        inc     b
4a6e 02        ld      (bc),a
4a6f 9e        sbc     a,(hl)
4a70 04        inc     b
4a71 02        ld      (bc),a
4a72 99        sbc     a,c
4a73 04        inc     b
4a74 02        ld      (bc),a
4a75 96        sub     (hl)
4a76 04        inc     b
4a77 02        ld      (bc),a
4a78 92        sub     d
4a79 04        inc     b
4a7a 02        ld      (bc),a
4a7b 9e        sbc     a,(hl)
4a7c 04        inc     b
4a7d 02        ld      (bc),a
4a7e 99        sbc     a,c
4a7f 04        inc     b
4a80 02        ld      (bc),a
4a81 96        sub     (hl)
4a82 04        inc     b
4a83 02        ld      (bc),a
4a84 92        sub     d
4a85 04        inc     b
4a86 02        ld      (bc),a
4a87 a0        and     b
4a88 04        inc     b
4a89 02        ld      (bc),a
4a8a 9b        sbc     a,e
4a8b 04        inc     b
4a8c 02        ld      (bc),a
4a8d 98        sbc     a,b
4a8e 04        inc     b
4a8f 02        ld      (bc),a
4a90 94        sub     h
4a91 04        inc     b
4a92 02        ld      (bc),a
4a93 a0        and     b
4a94 04        inc     b
4a95 02        ld      (bc),a
4a96 9b        sbc     a,e
4a97 04        inc     b
4a98 02        ld      (bc),a
4a99 98        sbc     a,b
4a9a 04        inc     b
4a9b 02        ld      (bc),a
4a9c 94        sub     h
4a9d 04        inc     b
4a9e 02        ld      (bc),a
4a9f a0        and     b
4aa0 14        inc     d
4aa1 04        inc     b
4aa2 04        inc     b
4aa3 9b        sbc     a,e
4aa4 14        inc     d
4aa5 04        inc     b
4aa6 a0        and     b
4aa7 14        inc     d
4aa8 04        inc     b
4aa9 9e        sbc     a,(hl)
4aaa 14        inc     d
4aab 04        inc     b
4aac 9b        sbc     a,e
4aad 08        ex      af,af'
4aae 04        inc     b
4aaf 9c        sbc     a,h
4ab0 08        ex      af,af'
4ab1 04        inc     b
4ab2 9e        sbc     a,(hl)
4ab3 180c      jr      4ac1h
4ab5 a0        and     b
4ab6 08        ex      af,af'
4ab7 04        inc     b
4ab8 9e        sbc     a,(hl)
4ab9 2004      jr      nz,4abfh
4abb 99        sbc     a,c
4abc 04        inc     b
4abd 02        ld      (bc),a
4abe 9b        sbc     a,e
4abf 04        inc     b
4ac0 02        ld      (bc),a
4ac1 9c        sbc     a,h
4ac2 14        inc     d
4ac3 04        inc     b
4ac4 9b        sbc     a,e
4ac5 14        inc     d
4ac6 04        inc     b
4ac7 99        sbc     a,c
4ac8 14        inc     d
4ac9 04        inc     b
4aca 97        sub     a
4acb 14        inc     d
4acc 04        inc     b
4acd 9b        sbc     a,e
4ace 2004      jr      nz,4ad4h
4ad0 9c        sbc     a,h
4ad1 04        inc     b
4ad2 02        ld      (bc),a
4ad3 9b        sbc     a,e
4ad4 04        inc     b
4ad5 02        ld      (bc),a
4ad6 99        sbc     a,c
4ad7 2010      jr      nz,4ae9h
4ad9 94        sub     h
4ada 14        inc     d
4adb 04        inc     b
4adc 96        sub     (hl)
4add 14        inc     d
4ade 04        inc     b
4adf 97        sub     a
4ae0 14        inc     d
4ae1 04        inc     b
4ae2 9e        sbc     a,(hl)
4ae3 14        inc     d
4ae4 04        inc     b
4ae5 99        sbc     a,c
4ae6 180c      jr      4af4h
4ae8 9b        sbc     a,e
4ae9 08        ex      af,af'
4aea 04        inc     b
4aeb 99        sbc     a,c
4aec 2004      jr      nz,4af2h
4aee 99        sbc     a,c
4aef 04        inc     b
4af0 02        ld      (bc),a
4af1 9b        sbc     a,e
4af2 04        inc     b
4af3 02        ld      (bc),a
4af4 9c        sbc     a,h
4af5 0c        inc     c
4af6 04        inc     b
4af7 9e        sbc     a,(hl)
4af8 0c        inc     c
4af9 04        inc     b
4afa a0        and     b
4afb 0c        inc     c
4afc 04        inc     b
4afd 9b        sbc     a,e
4afe 14        inc     d
4aff 04        inc     b
4b00 99        sbc     a,c
4b01 08        ex      af,af'
4b02 04        inc     b
4b03 97        sub     a
4b04 08        ex      af,af'
4b05 04        inc     b
4b06 9b        sbc     a,e
4b07 2004      jr      nz,4b0dh
4b09 9c        sbc     a,h
4b0a 04        inc     b
4b0b 02        ld      (bc),a
4b0c 9b        sbc     a,e
4b0d 04        inc     b
4b0e 02        ld      (bc),a
4b0f 99        sbc     a,c
4b10 2010      jr      nz,4b22h
4b12 04        inc     b
4b13 9e        sbc     a,(hl)
4b14 0c        inc     c
4b15 0c        inc     c
4b16 9d        sbc     a,l
4b17 0c        inc     c
4b18 0c        inc     c
4b19 99        sbc     a,c
4b1a 2007      jr      nz,4b23h
4b1c 99        sbc     a,c
4b1d 03        inc     bc
4b1e 00        nop     
4b1f 9b        sbc     a,e
4b20 03        inc     bc
4b21 00        nop     
4b22 99        sbc     a,c
4b23 03        inc     bc
4b24 00        nop     
4b25 a2        and     d
4b26 1008      djnz    4b30h
4b28 a0        and     b
4b29 0c        inc     c
4b2a 0c        inc     c
4b2b a0        and     b
4b2c 2007      jr      nz,4b35h
4b2e 99        sbc     a,c
4b2f 03        inc     bc
4b30 00        nop     
4b31 9b        sbc     a,e
4b32 03        inc     bc
4b33 00        nop     
4b34 9d        sbc     a,l
4b35 03        inc     bc
4b36 00        nop     
4b37 9e        sbc     a,(hl)
4b38 1e06      ld      e,06h
4b3a a0        and     b
4b3b 04        inc     b
4b3c 02        ld      (bc),a
4b3d a2        and     d
4b3e 04        inc     b
4b3f 02        ld      (bc),a
4b40 9d        sbc     a,l
4b41 0e02      ld      c,02h
4b43 9b        sbc     a,e
4b44 0e02      ld      c,02h
4b46 99        sbc     a,c
4b47 0e02      ld      c,02h
4b49 99        sbc     a,c
4b4a 50        ld      d,b
4b4b 04        inc     b
4b4c 9b        sbc     a,e
4b4d 04        inc     b
4b4e 02        ld      (bc),a
4b4f 9d        sbc     a,l
4b50 04        inc     b
4b51 02        ld      (bc),a
4b52 9b        sbc     a,e
4b53 2e02      ld      l,02h
4b55 80        add     a,b
4b56 1818      jr      4b70h
4b58 04        inc     b
4b59 a0        and     b
4b5a 1800      jr      4b5ch
4b5c 80        add     a,b
4b5d 0c        inc     c
4b5e 00        nop     
4b5f 9d        sbc     a,l
4b60 05        dec     b
4b61 01a005    ld      bc,05a0h
4b64 01a520    ld      bc,20a5h
4b67 00        nop     
4b68 80        add     a,b
4b69 1000      djnz    4b6bh
4b6b 9d        sbc     a,l
4b6c 2004      jr      nz,4b72h
4b6e 9e        sbc     a,(hl)
4b6f 0600      ld      b,00h
4b71 a0        and     b
4b72 0600      ld      b,00h
4b74 99        sbc     a,c
4b75 1602      ld      d,02h
4b77 9b        sbc     a,e
4b78 1602      ld      d,02h
4b7a 9e        sbc     a,(hl)
4b7b 1008      djnz    4b85h
4b7d 9d        sbc     a,l
4b7e 1008      djnz    4b88h
4b80 99        sbc     a,c
4b81 1602      ld      d,02h
4b83 99        sbc     a,c
4b84 07        rlca    
4b85 019b07    ld      bc,079bh
4b88 019d07    ld      bc,079dh
4b8b 019920    ld      bc,2099h
4b8e 04        inc     b
4b8f 9b        sbc     a,e
4b90 05        dec     b
4b91 019d06    ld      bc,069dh
4b94 00        nop     
4b95 9b        sbc     a,e
4b96 1602      ld      d,02h
4b98 99        sbc     a,c
4b99 07        rlca    
4b9a 019b07    ld      bc,079bh
4b9d 019907    ld      bc,0799h
4ba0 01a018    ld      bc,18a0h
4ba3 00        nop     
4ba4 80        add     a,b
4ba5 0c        inc     c
4ba6 00        nop     
4ba7 9d        sbc     a,l
4ba8 05        dec     b
4ba9 01a005    ld      bc,05a0h
4bac 01a520    ld      bc,20a5h
4baf 00        nop     
4bb0 80        add     a,b
4bb1 1000      djnz    4bb3h
4bb3 9d        sbc     a,l
4bb4 2004      jr      nz,4bbah
4bb6 9e        sbc     a,(hl)
4bb7 0600      ld      b,00h
4bb9 a0        and     b
4bba 0600      ld      b,00h
4bbc 99        sbc     a,c
4bbd 1611      ld      d,11h
4bbf 99        sbc     a,c
4bc0 03        inc     bc
4bc1 00        nop     
4bc2 9b        sbc     a,e
4bc3 03        inc     bc
4bc4 00        nop     
4bc5 9d        sbc     a,l
4bc6 03        inc     bc
4bc7 00        nop     
4bc8 9e        sbc     a,(hl)
4bc9 0c        inc     c
4bca 0c        inc     c
4bcb 9d        sbc     a,l
4bcc 0c        inc     c
4bcd 0c        inc     c
4bce 99        sbc     a,c
4bcf 1602      ld      d,02h
4bd1 99        sbc     a,c
4bd2 0602      ld      b,02h
4bd4 9b        sbc     a,e
4bd5 0602      ld      b,02h
4bd7 9d        sbc     a,l
4bd8 0602      ld      b,02h
4bda 99        sbc     a,c
4bdb 180c      jr      4be9h
4bdd 9b        sbc     a,e
4bde 05        dec     b
4bdf 019d05    ld      bc,059dh
4be2 019b16    ld      bc,169bh
4be5 119903    ld      de,0399h
4be8 00        nop     
4be9 9b        sbc     a,e
4bea 03        inc     bc
4beb 00        nop     
4bec 9d        sbc     a,l
4bed 03        inc     bc
4bee 00        nop     
4bef 04        inc     b
4bf0 1880      jr      4b72h
4bf2 1800      jr      4bf4h
4bf4 02        ld      (bc),a
4bf5 2600      ld      h,00h
4bf7 0c        inc     c
4bf8 1807      jr      4c01h
4bfa ff        rst     38h
4bfb ff        rst     38h
4bfc e7        rst     20h
4bfd 00        nop     
4bfe a0        and     b
4bff 5a        ld      e,d
4c00 02        ld      (bc),a
4c01 08        ex      af,af'
4c02 0c        inc     c
4c03 03        inc     bc
4c04 01fb4c    ld      bc,4cfbh
4c07 03        inc     bc
4c08 01cd4c    ld      bc,4ccdh
4c0b 07        rlca    
4c0c ff        rst     38h
4c0d ff        rst     38h
4c0e 1101a0    ld      de,0a001h
4c11 db02      in      a,(02h)
4c13 08        ex      af,af'
4c14 0a        ld      a,(bc)
4c15 03        inc     bc
4c16 02        ld      (bc),a
4c17 84        add     a,h
4c18 4c        ld      c,h
4c19 02        ld      (bc),a
4c1a 2600      ld      h,00h
4c1c 0c        inc     c
4c1d 1807      jr      4c26h
4c1f ff        rst     38h
4c20 ff        rst     38h
4c21 e7        rst     20h
4c22 00        nop     
4c23 a0        and     b
4c24 5a        ld      e,d
4c25 02        ld      (bc),a
4c26 08        ex      af,af'
4c27 0c        inc     c
4c28 03        inc     bc
4c29 012f4c    ld      bc,4c2fh
4c2c 01034c    ld      bc,4c03h
4c2f 9c        sbc     a,h
4c30 14        inc     d
4c31 04        inc     b
4c32 9c        sbc     a,h
4c33 14        inc     d
4c34 04        inc     b
4c35 9c        sbc     a,h
4c36 14        inc     d
4c37 04        inc     b
4c38 9b        sbc     a,e
4c39 0602      ld      b,02h
4c3b 9c        sbc     a,h
4c3c 0602      ld      b,02h
4c3e 9b        sbc     a,e
4c3f 0602      ld      b,02h
4c41 99        sbc     a,c
4c42 08        ex      af,af'
4c43 04        inc     b
4c44 96        sub     (hl)
4c45 50        ld      d,b
4c46 04        inc     b
4c47 9c        sbc     a,h
4c48 0c        inc     c
4c49 04        inc     b
4c4a 9e        sbc     a,(hl)
4c4b 0c        inc     c
4c4c 04        inc     b
4c4d a0        and     b
4c4e 0c        inc     c
4c4f 04        inc     b
4c50 9b        sbc     a,e
4c51 0c        inc     c
4c52 04        inc     b
4c53 99        sbc     a,c
4c54 0c        inc     c
4c55 04        inc     b
4c56 97        sub     a
4c57 0c        inc     c
4c58 04        inc     b
4c59 99        sbc     a,c
4c5a 08        ex      af,af'
4c5b 04        inc     b
4c5c 99        sbc     a,c
4c5d 04        inc     b
4c5e 02        ld      (bc),a
4c5f 99        sbc     a,c
4c60 04        inc     b
4c61 02        ld      (bc),a
4c62 99        sbc     a,c
4c63 180c      jr      4c71h
4c65 99        sbc     a,c
4c66 04        inc     b
4c67 02        ld      (bc),a
4c68 99        sbc     a,c
4c69 04        inc     b
4c6a 02        ld      (bc),a
4c6b 99        sbc     a,c
4c6c 08        ex      af,af'
4c6d 04        inc     b
4c6e 99        sbc     a,c
4c6f 08        ex      af,af'
4c70 04        inc     b
4c71 9b        sbc     a,e
4c72 08        ex      af,af'
4c73 04        inc     b
4c74 9b        sbc     a,e
4c75 04        inc     b
4c76 02        ld      (bc),a
4c77 9b        sbc     a,e
4c78 04        inc     b
4c79 02        ld      (bc),a
4c7a 9b        sbc     a,e
4c7b 08        ex      af,af'
4c7c 04        inc     b
4c7d 9b        sbc     a,e
4c7e 08        ex      af,af'
4c7f 04        inc     b
4c80 9b        sbc     a,e
4c81 1818      jr      4c9bh
4c83 04        inc     b
4c84 9e        sbc     a,(hl)
4c85 0606      ld      b,06h
4c87 9e        sbc     a,(hl)
4c88 08        ex      af,af'
4c89 109e      djnz    4c29h
4c8b 08        ex      af,af'
4c8c 109e      djnz    4c2ch
4c8e 0606      ld      b,06h
4c90 9e        sbc     a,(hl)
4c91 08        ex      af,af'
4c92 04        inc     b
4c93 9e        sbc     a,(hl)
4c94 0606      ld      b,06h
4c96 9e        sbc     a,(hl)
4c97 0606      ld      b,06h
4c99 9e        sbc     a,(hl)
4c9a 08        ex      af,af'
4c9b 109e      djnz    4c3bh
4c9d 08        ex      af,af'
4c9e 109e      djnz    4c3eh
4ca0 0606      ld      b,06h
4ca2 9e        sbc     a,(hl)
4ca3 08        ex      af,af'
4ca4 04        inc     b
4ca5 9e        sbc     a,(hl)
4ca6 0606      ld      b,06h
4ca8 9c        sbc     a,h
4ca9 0606      ld      b,06h
4cab 9c        sbc     a,h
4cac 08        ex      af,af'
4cad 109c      djnz    4c4bh
4caf 08        ex      af,af'
4cb0 109c      djnz    4c4eh
4cb2 0606      ld      b,06h
4cb4 9b        sbc     a,e
4cb5 08        ex      af,af'
4cb6 04        inc     b
4cb7 9b        sbc     a,e
4cb8 0606      ld      b,06h
4cba 99        sbc     a,c
4cbb 0606      ld      b,06h
4cbd 99        sbc     a,c
4cbe 08        ex      af,af'
4cbf 1099      djnz    4c5ah
4cc1 08        ex      af,af'
4cc2 1099      djnz    4c5dh
4cc4 0606      ld      b,06h
4cc6 99        sbc     a,c
4cc7 08        ex      af,af'
4cc8 04        inc     b
4cc9 99        sbc     a,c
4cca 0606      ld      b,06h
4ccc 04        inc     b
4ccd 9e        sbc     a,(hl)
4cce 08        ex      af,af'
4ccf 109d      djnz    4c6eh
4cd1 08        ex      af,af'
4cd2 1099      djnz    4c6dh
4cd4 08        ex      af,af'
4cd5 1099      djnz    4c70h
4cd7 1602      ld      d,02h
4cd9 9e        sbc     a,(hl)
4cda 08        ex      af,af'
4cdb 109d      djnz    4c7ah
4cdd 08        ex      af,af'
4cde 1099      djnz    4c79h
4ce0 08        ex      af,af'
4ce1 109b      djnz    4c7eh
4ce3 1602      ld      d,02h
4ce5 9e        sbc     a,(hl)
4ce6 1602      ld      d,02h
4ce8 9d        sbc     a,l
4ce9 1602      ld      d,02h
4ceb 99        sbc     a,c
4cec 2e02      ld      l,02h
4cee 99        sbc     a,c
4cef 2e02      ld      l,02h
4cf1 99        sbc     a,c
4cf2 2e02      ld      l,02h
4cf4 99        sbc     a,c
4cf5 2e02      ld      l,02h
4cf7 9b        sbc     a,e
4cf8 2e02      ld      l,02h
4cfa 04        inc     b
4cfb 80        add     a,b
4cfc 1800      jr      4cfeh
4cfe 9b        sbc     a,e
4cff 1818      jr      4d19h
4d01 9d        sbc     a,l
4d02 1800      jr      4d04h
4d04 99        sbc     a,c
4d05 1008      djnz    4d0fh
4d07 99        sbc     a,c
4d08 1008      djnz    4d12h
4d0a 99        sbc     a,c
4d0b 1008      djnz    4d15h
4d0d 9b        sbc     a,e
4d0e 1008      djnz    4d18h
4d10 9e        sbc     a,(hl)
4d11 1008      djnz    4d1bh
4d13 9d        sbc     a,l
4d14 1008      djnz    4d1eh
4d16 99        sbc     a,c
4d17 1818      jr      4d31h
4d19 99        sbc     a,c
4d1a 1008      djnz    4d24h
4d1c 99        sbc     a,c
4d1d 1008      djnz    4d27h
4d1f 9b        sbc     a,e
4d20 1818      jr      4d3ah
4d22 80        add     a,b
4d23 0c        inc     c
4d24 00        nop     
4d25 9d        sbc     a,l
4d26 0c        inc     c
4d27 00        nop     
4d28 9e        sbc     a,(hl)
4d29 0c        inc     c
4d2a 00        nop     
4d2b 9d        sbc     a,l
4d2c 0c        inc     c
4d2d 0c        inc     c
4d2e 9d        sbc     a,l
4d2f 0c        inc     c
4d30 00        nop     
4d31 9b        sbc     a,e
4d32 0c        inc     c
4d33 00        nop     
4d34 99        sbc     a,c
4d35 0c        inc     c
4d36 00        nop     
4d37 99        sbc     a,c
4d38 1008      djnz    4d42h
4d3a 99        sbc     a,c
4d3b 1008      djnz    4d45h
4d3d 99        sbc     a,c
4d3e 1008      djnz    4d48h
4d40 9b        sbc     a,e
4d41 1008      djnz    4d4bh
4d43 9e        sbc     a,(hl)
4d44 08        ex      af,af'
4d45 109d      djnz    4ce4h
4d47 08        ex      af,af'
4d48 1099      djnz    4ce3h
4d4a 1602      ld      d,02h
4d4c 99        sbc     a,c
4d4d 1602      ld      d,02h
4d4f 99        sbc     a,c
4d50 14        inc     d
4d51 04        inc     b
4d52 99        sbc     a,c
4d53 14        inc     d
4d54 04        inc     b
4d55 9b        sbc     a,e
4d56 2010      jr      nz,4d68h
4d58 04        inc     b
4d59 1880      jr      4cdbh
4d5b 1800      jr      4d5dh
4d5d 02        ld      (bc),a
4d5e 2600      ld      h,00h
4d60 0c        inc     c
4d61 1807      jr      4d6ah
4d63 ff        rst     38h
4d64 ff        rst     38h
4d65 e7        rst     20h
4d66 00        nop     
4d67 a0        and     b
4d68 5a        ld      e,d
4d69 02        ld      (bc),a
4d6a 08        ex      af,af'
4d6b 0c        inc     c
4d6c 09        add     hl,bc
4d6d 0a        ld      a,(bc)
4d6e 03        inc     bc
4d6f 01664e    ld      bc,4e66h
4d72 03        inc     bc
4d73 01384e    ld      bc,4e38h
4d76 07        rlca    
4d77 ff        rst     38h
4d78 ff        rst     38h
4d79 1101a0    ld      de,0a001h
4d7c db02      in      a,(02h)
4d7e 08        ex      af,af'
4d7f 0a        ld      a,(bc)
4d80 03        inc     bc
4d81 02        ld      (bc),a
4d82 ef        rst     28h
4d83 4d        ld      c,l
4d84 02        ld      (bc),a
4d85 2600      ld      h,00h
4d87 0c        inc     c
4d88 1807      jr      4d91h
4d8a ff        rst     38h
4d8b ff        rst     38h
4d8c e7        rst     20h
4d8d 00        nop     
4d8e a0        and     b
4d8f 5a        ld      e,d
4d90 02        ld      (bc),a
4d91 08        ex      af,af'
4d92 0c        inc     c
4d93 03        inc     bc
4d94 019a4d    ld      bc,4d9ah
4d97 016e4d    ld      bc,4d6eh
4d9a 99        sbc     a,c
4d9b 14        inc     d
4d9c 04        inc     b
4d9d 99        sbc     a,c
4d9e 14        inc     d
4d9f 04        inc     b
4da0 99        sbc     a,c
4da1 14        inc     d
4da2 04        inc     b
4da3 97        sub     a
4da4 0602      ld      b,02h
4da6 97        sub     a
4da7 0602      ld      b,02h
4da9 97        sub     a
4daa 0602      ld      b,02h
4dac 96        sub     (hl)
4dad 08        ex      af,af'
4dae 04        inc     b
4daf 92        sub     d
4db0 50        ld      d,b
4db1 04        inc     b
4db2 99        sbc     a,c
4db3 0c        inc     c
4db4 04        inc     b
4db5 9b        sbc     a,e
4db6 0c        inc     c
4db7 04        inc     b
4db8 9c        sbc     a,h
4db9 0c        inc     c
4dba 04        inc     b
4dbb 97        sub     a
4dbc 0c        inc     c
4dbd 04        inc     b
4dbe 96        sub     (hl)
4dbf 0c        inc     c
4dc0 04        inc     b
4dc1 94        sub     h
4dc2 0c        inc     c
4dc3 04        inc     b
4dc4 96        sub     (hl)
4dc5 08        ex      af,af'
4dc6 04        inc     b
4dc7 96        sub     (hl)
4dc8 04        inc     b
4dc9 02        ld      (bc),a
4dca 96        sub     (hl)
4dcb 04        inc     b
4dcc 02        ld      (bc),a
4dcd 96        sub     (hl)
4dce 180c      jr      4ddch
4dd0 96        sub     (hl)
4dd1 04        inc     b
4dd2 02        ld      (bc),a
4dd3 96        sub     (hl)
4dd4 04        inc     b
4dd5 02        ld      (bc),a
4dd6 96        sub     (hl)
4dd7 08        ex      af,af'
4dd8 04        inc     b
4dd9 96        sub     (hl)
4dda 08        ex      af,af'
4ddb 04        inc     b
4ddc 98        sbc     a,b
4ddd 08        ex      af,af'
4dde 04        inc     b
4ddf 98        sbc     a,b
4de0 04        inc     b
4de1 02        ld      (bc),a
4de2 98        sbc     a,b
4de3 04        inc     b
4de4 02        ld      (bc),a
4de5 98        sbc     a,b
4de6 08        ex      af,af'
4de7 04        inc     b
4de8 98        sbc     a,b
4de9 08        ex      af,af'
4dea 04        inc     b
4deb 98        sbc     a,b
4dec 1818      jr      4e06h
4dee 04        inc     b
4def 9b        sbc     a,e
4df0 0606      ld      b,06h
4df2 9b        sbc     a,e
4df3 08        ex      af,af'
4df4 109b      djnz    4d91h
4df6 08        ex      af,af'
4df7 109b      djnz    4d94h
4df9 0606      ld      b,06h
4dfb 9b        sbc     a,e
4dfc 08        ex      af,af'
4dfd 04        inc     b
4dfe 9b        sbc     a,e
4dff 0606      ld      b,06h
4e01 99        sbc     a,c
4e02 0606      ld      b,06h
4e04 99        sbc     a,c
4e05 08        ex      af,af'
4e06 1099      djnz    4da1h
4e08 08        ex      af,af'
4e09 1099      djnz    4da4h
4e0b 0606      ld      b,06h
4e0d 99        sbc     a,c
4e0e 08        ex      af,af'
4e0f 04        inc     b
4e10 99        sbc     a,c
4e11 0606      ld      b,06h
4e13 99        sbc     a,c
4e14 0606      ld      b,06h
4e16 99        sbc     a,c
4e17 08        ex      af,af'
4e18 1099      djnz    4db3h
4e1a 08        ex      af,af'
4e1b 1099      djnz    4db6h
4e1d 0606      ld      b,06h
4e1f 97        sub     a
4e20 08        ex      af,af'
4e21 04        inc     b
4e22 97        sub     a
4e23 0606      ld      b,06h
4e25 96        sub     (hl)
4e26 0606      ld      b,06h
4e28 96        sub     (hl)
4e29 08        ex      af,af'
4e2a 1096      djnz    4dc2h
4e2c 08        ex      af,af'
4e2d 1096      djnz    4dc5h
4e2f 0606      ld      b,06h
4e31 96        sub     (hl)
4e32 08        ex      af,af'
4e33 04        inc     b
4e34 96        sub     (hl)
4e35 0606      ld      b,06h
4e37 04        inc     b
4e38 99        sbc     a,c
4e39 08        ex      af,af'
4e3a 1099      djnz    4dd5h
4e3c 08        ex      af,af'
4e3d 1096      djnz    4dd5h
4e3f 08        ex      af,af'
4e40 1096      djnz    4dd8h
4e42 1602      ld      d,02h
4e44 99        sbc     a,c
4e45 08        ex      af,af'
4e46 1099      djnz    4de1h
4e48 08        ex      af,af'
4e49 1096      djnz    4de1h
4e4b 08        ex      af,af'
4e4c 1098      djnz    4de6h
4e4e 1602      ld      d,02h
4e50 99        sbc     a,c
4e51 1602      ld      d,02h
4e53 99        sbc     a,c
4e54 1602      ld      d,02h
4e56 96        sub     (hl)
4e57 2e02      ld      l,02h
4e59 96        sub     (hl)
4e5a 2e02      ld      l,02h
4e5c 96        sub     (hl)
4e5d 2e02      ld      l,02h
4e5f 96        sub     (hl)
4e60 2e02      ld      l,02h
4e62 98        sbc     a,b
4e63 2e02      ld      l,02h
4e65 04        inc     b
4e66 80        add     a,b
4e67 1800      jr      4e69h
4e69 99        sbc     a,c
4e6a 0a        ld      a,(bc)
4e6b 02        ld      (bc),a
4e6c 98        sbc     a,b
4e6d 0c        inc     c
4e6e 1899      jr      4e09h
4e70 1800      jr      4e72h
4e72 96        sub     (hl)
4e73 1008      djnz    4e7dh
4e75 96        sub     (hl)
4e76 1008      djnz    4e80h
4e78 96        sub     (hl)
4e79 1008      djnz    4e83h
4e7b 98        sbc     a,b
4e7c 1008      djnz    4e86h
4e7e 9b        sbc     a,e
4e7f 1008      djnz    4e89h
4e81 99        sbc     a,c
4e82 1008      djnz    4e8ch
4e84 96        sub     (hl)
4e85 1818      jr      4e9fh
4e87 96        sub     (hl)
4e88 1008      djnz    4e92h
4e8a 96        sub     (hl)
4e8b 1008      djnz    4e95h
4e8d 98        sbc     a,b
4e8e 1818      jr      4ea8h
4e90 80        add     a,b
4e91 0c        inc     c
4e92 00        nop     
4e93 99        sbc     a,c
4e94 0c        inc     c
4e95 00        nop     
4e96 9b        sbc     a,e
4e97 0c        inc     c
4e98 00        nop     
4e99 99        sbc     a,c
4e9a 0c        inc     c
4e9b 0c        inc     c
4e9c 99        sbc     a,c
4e9d 0c        inc     c
4e9e 00        nop     
4e9f 98        sbc     a,b
4ea0 0c        inc     c
4ea1 00        nop     
4ea2 96        sub     (hl)
4ea3 0c        inc     c
4ea4 00        nop     
4ea5 96        sub     (hl)
4ea6 1008      djnz    4eb0h
4ea8 96        sub     (hl)
4ea9 1008      djnz    4eb3h
4eab 96        sub     (hl)
4eac 1008      djnz    4eb6h
4eae 98        sbc     a,b
4eaf 1008      djnz    4eb9h
4eb1 9b        sbc     a,e
4eb2 08        ex      af,af'
4eb3 1099      djnz    4e4eh
4eb5 08        ex      af,af'
4eb6 1096      djnz    4e4eh
4eb8 1602      ld      d,02h
4eba 96        sub     (hl)
4ebb 1602      ld      d,02h
4ebd 96        sub     (hl)
4ebe 14        inc     d
4ebf 04        inc     b
4ec0 96        sub     (hl)
4ec1 14        inc     d
4ec2 04        inc     b
4ec3 98        sbc     a,b
4ec4 2010      jr      nz,4ed6h
4ec6 04        inc     b
4ec7 1880      jr      4e49h
4ec9 1800      jr      4ecbh
4ecb 02        ld      (bc),a
4ecc 2600      ld      h,00h
4ece 0c        inc     c
4ecf 1807      jr      4ed8h
4ed1 ff        rst     38h
4ed2 ff        rst     38h
4ed3 e7        rst     20h
4ed4 00        nop     
4ed5 a0        and     b
4ed6 5a        ld      e,d
4ed7 02        ld      (bc),a
4ed8 08        ex      af,af'
4ed9 0c        inc     c
4eda 09        add     hl,bc
4edb 0f        rrca    
4edc 03        inc     bc
4edd 01d44f    ld      bc,4fd4h
4ee0 03        inc     bc
4ee1 01a64f    ld      bc,4fa6h
4ee4 07        rlca    
4ee5 ff        rst     38h
4ee6 ff        rst     38h
4ee7 1101a0    ld      de,0a001h
4eea db02      in      a,(02h)
4eec 08        ex      af,af'
4eed 0a        ld      a,(bc)
4eee 03        inc     bc
4eef 02        ld      (bc),a
4ef0 5d        ld      e,l
4ef1 4f        ld      c,a
4ef2 02        ld      (bc),a
4ef3 2600      ld      h,00h
4ef5 0c        inc     c
4ef6 1807      jr      4effh
4ef8 ff        rst     38h
4ef9 ff        rst     38h
4efa e7        rst     20h
4efb 00        nop     
4efc a0        and     b
4efd 5a        ld      e,d
4efe 02        ld      (bc),a
4eff 08        ex      af,af'
4f00 0c        inc     c
4f01 03        inc     bc
4f02 01084f    ld      bc,4f08h
4f05 01dc4e    ld      bc,4edch
4f08 94        sub     h
4f09 14        inc     d
4f0a 04        inc     b
4f0b 94        sub     h
4f0c 14        inc     d
4f0d 04        inc     b
4f0e 94        sub     h
4f0f 14        inc     d
4f10 04        inc     b
4f11 92        sub     d
4f12 0602      ld      b,02h
4f14 92        sub     d
4f15 0602      ld      b,02h
4f17 92        sub     d
4f18 0602      ld      b,02h
4f1a 92        sub     d
4f1b 08        ex      af,af'
4f1c 04        inc     b
4f1d 8d        adc     a,l
4f1e 50        ld      d,b
4f1f 04        inc     b
4f20 94        sub     h
4f21 0c        inc     c
4f22 04        inc     b
4f23 94        sub     h
4f24 0c        inc     c
4f25 04        inc     b
4f26 97        sub     a
4f27 0c        inc     c
4f28 04        inc     b
4f29 92        sub     d
4f2a 0c        inc     c
4f2b 04        inc     b
4f2c 92        sub     d
4f2d 0c        inc     c
4f2e 04        inc     b
4f2f 92        sub     d
4f30 0c        inc     c
4f31 04        inc     b
4f32 92        sub     d
4f33 08        ex      af,af'
4f34 04        inc     b
4f35 92        sub     d
4f36 04        inc     b
4f37 02        ld      (bc),a
4f38 92        sub     d
4f39 04        inc     b
4f3a 02        ld      (bc),a
4f3b 9e        sbc     a,(hl)
4f3c 180c      jr      4f4ah
4f3e 92        sub     d
4f3f 04        inc     b
4f40 02        ld      (bc),a
4f41 92        sub     d
4f42 04        inc     b
4f43 02        ld      (bc),a
4f44 9e        sbc     a,(hl)
4f45 08        ex      af,af'
4f46 04        inc     b
4f47 92        sub     d
4f48 08        ex      af,af'
4f49 04        inc     b
4f4a 94        sub     h
4f4b 08        ex      af,af'
4f4c 04        inc     b
4f4d 94        sub     h
4f4e 04        inc     b
4f4f 02        ld      (bc),a
4f50 94        sub     h
4f51 04        inc     b
4f52 02        ld      (bc),a
4f53 a0        and     b
4f54 08        ex      af,af'
4f55 04        inc     b
4f56 a0        and     b
4f57 08        ex      af,af'
4f58 04        inc     b
4f59 a0        and     b
4f5a 1818      jr      4f74h
4f5c 04        inc     b
4f5d 97        sub     a
4f5e 0606      ld      b,06h
4f60 97        sub     a
4f61 08        ex      af,af'
4f62 1097      djnz    4efbh
4f64 08        ex      af,af'
4f65 1097      djnz    4efeh
4f67 0606      ld      b,06h
4f69 97        sub     a
4f6a 08        ex      af,af'
4f6b 04        inc     b
4f6c 97        sub     a
4f6d 0606      ld      b,06h
4f6f 96        sub     (hl)
4f70 0606      ld      b,06h
4f72 96        sub     (hl)
4f73 08        ex      af,af'
4f74 1096      djnz    4f0ch
4f76 08        ex      af,af'
4f77 1096      djnz    4f0fh
4f79 0606      ld      b,06h
4f7b 96        sub     (hl)
4f7c 08        ex      af,af'
4f7d 04        inc     b
4f7e 96        sub     (hl)
4f7f 0606      ld      b,06h
4f81 94        sub     h
4f82 0606      ld      b,06h
4f84 94        sub     h
4f85 08        ex      af,af'
4f86 1094      djnz    4f1ch
4f88 08        ex      af,af'
4f89 1094      djnz    4f1fh
4f8b 0606      ld      b,06h
4f8d 92        sub     d
4f8e 08        ex      af,af'
4f8f 04        inc     b
4f90 92        sub     d
4f91 0606      ld      b,06h
4f93 94        sub     h
4f94 0606      ld      b,06h
4f96 94        sub     h
4f97 08        ex      af,af'
4f98 1094      djnz    4f2eh
4f9a 08        ex      af,af'
4f9b 1094      djnz    4f31h
4f9d 0606      ld      b,06h
4f9f 92        sub     d
4fa0 08        ex      af,af'
4fa1 04        inc     b
4fa2 92        sub     d
4fa3 0606      ld      b,06h
4fa5 04        inc     b
4fa6 96        sub     (hl)
4fa7 08        ex      af,af'
4fa8 1094      djnz    4f3eh
4faa 08        ex      af,af'
4fab 1092      djnz    4f3fh
4fad 08        ex      af,af'
4fae 1092      djnz    4f42h
4fb0 1602      ld      d,02h
4fb2 96        sub     (hl)
4fb3 08        ex      af,af'
4fb4 1094      djnz    4f4ah
4fb6 08        ex      af,af'
4fb7 1092      djnz    4f4bh
4fb9 08        ex      af,af'
4fba 1094      djnz    4f50h
4fbc 1602      ld      d,02h
4fbe 96        sub     (hl)
4fbf 1602      ld      d,02h
4fc1 94        sub     h
4fc2 1602      ld      d,02h
4fc4 92        sub     d
4fc5 2e02      ld      l,02h
4fc7 92        sub     d
4fc8 2e02      ld      l,02h
4fca 92        sub     d
4fcb 2e02      ld      l,02h
4fcd 92        sub     d
4fce 2e02      ld      l,02h
4fd0 94        sub     h
4fd1 2e02      ld      l,02h
4fd3 04        inc     b
4fd4 80        add     a,b
4fd5 1800      jr      4fd7h
4fd7 94        sub     h
4fd8 1818      jr      4ff2h
4fda 94        sub     h
4fdb 1800      jr      4fddh
4fdd 92        sub     d
4fde 1008      djnz    4fe8h
4fe0 92        sub     d
4fe1 1008      djnz    4febh
4fe3 92        sub     d
4fe4 1008      djnz    4feeh
4fe6 94        sub     h
4fe7 1008      djnz    4ff1h
4fe9 96        sub     (hl)
4fea 1008      djnz    4ff4h
4fec 94        sub     h
4fed 1008      djnz    4ff7h
4fef 92        sub     d
4ff0 1818      jr      500ah
4ff2 92        sub     d
4ff3 1008      djnz    4ffdh
4ff5 92        sub     d
4ff6 1008      djnz    5000h
4ff8 94        sub     h
4ff9 1818      jr      5013h
4ffb 80        add     a,b
4ffc 0c        inc     c
4ffd 00        nop     
4ffe 94        sub     h
4fff 0c        inc     c
5000 00        nop     
5001 94        sub     h
5002 0c        inc     c
5003 00        nop     
5004 94        sub     h
5005 0c        inc     c
5006 0c        inc     c
5007 94        sub     h
5008 0c        inc     c
5009 00        nop     
500a 94        sub     h
500b 0c        inc     c
500c 00        nop     
500d 91        sub     c
500e 0c        inc     c
500f 00        nop     
5010 92        sub     d
5011 1008      djnz    501bh
5013 92        sub     d
5014 1008      djnz    501eh
5016 92        sub     d
5017 1008      djnz    5021h
5019 94        sub     h
501a 1008      djnz    5024h
501c 96        sub     (hl)
501d 08        ex      af,af'
501e 1094      djnz    4fb4h
5020 08        ex      af,af'
5021 1092      djnz    4fb5h
5023 1602      ld      d,02h
5025 92        sub     d
5026 1602      ld      d,02h
5028 92        sub     d
5029 14        inc     d
502a 04        inc     b
502b 92        sub     d
502c 14        inc     d
502d 04        inc     b
502e 94        sub     h
502f 2010      jr      nz,5041h
5031 04        inc     b
5032 1802      jr      5036h
5034 1e00      ld      e,00h
5036 0c        inc     c
5037 1c        inc     e
5038 09        add     hl,bc
5039 09        add     hl,bc
503a 07        rlca    
503b ff        rst     38h
503c ff        rst     38h
503d 4c        ld      c,h
503e 02        ld      (bc),a
503f 010001    ld      bc,0100h
5042 08        ex      af,af'
5043 0a        ld      a,(bc)
5044 99        sbc     a,c
5045 08        ex      af,af'
5046 00        nop     
5047 99        sbc     a,c
5048 08        ex      af,af'
5049 00        nop     
504a 99        sbc     a,c
504b 04        inc     b
504c 00        nop     
504d 99        sbc     a,c
504e 04        inc     b
504f 00        nop     
5050 03        inc     bc
5051 01e352    ld      bc,52e3h
5054 03        inc     bc
5055 01ab51    ld      bc,51abh
5058 02        ld      (bc),a
5059 94        sub     h
505a 00        nop     
505b 0c        inc     c
505c 1807      jr      5065h
505e ff        rst     38h
505f ff        rst     38h
5060 0100ff    ld      bc,0ff00h
5063 00        nop     
5064 0f        rrca    
5065 03        inc     bc
5066 08        ex      af,af'
5067 50        ld      d,b
5068 51        ld      d,c
5069 03        inc     bc
506a 017050    ld      bc,5070h
506d 013350    ld      bc,5033h
5070 0c        inc     c
5071 1802      jr      5075h
5073 0600      ld      b,00h
5075 08        ex      af,af'
5076 0f        rrca    
5077 09        add     hl,bc
5078 04        inc     b
5079 07        rlca    
507a ff        rst     38h
507b ff        rst     38h
507c ff        rst     38h
507d 02        ld      (bc),a
507e 1080      djnz    5000h
5080 00        nop     
5081 99        sbc     a,c
5082 0c        inc     c
5083 03        inc     bc
5084 02        ld      (bc),a
5085 1e00      ld      e,00h
5087 0c        inc     c
5088 1c        inc     e
5089 09        add     hl,bc
508a 09        add     hl,bc
508b 07        rlca    
508c ff        rst     38h
508d ff        rst     38h
508e 4c        ld      c,h
508f 02        ld      (bc),a
5090 010001    ld      bc,0100h
5093 03        inc     bc
5094 01d454    ld      bc,54d4h
5097 08        ex      af,af'
5098 0e99      ld      c,99h
509a 0c        inc     c
509b 03        inc     bc
509c 03        inc     bc
509d 01d454    ld      bc,54d4h
50a0 08        ex      af,af'
50a1 0e99      ld      c,99h
50a3 0c        inc     c
50a4 03        inc     bc
50a5 03        inc     bc
50a6 01d454    ld      bc,54d4h
50a9 08        ex      af,af'
50aa 0e99      ld      c,99h
50ac 0602      ld      b,02h
50ae 98        sbc     a,b
50af 0602      ld      b,02h
50b1 9a        sbc     a,d
50b2 0602      ld      b,02h
50b4 99        sbc     a,c
50b5 08        ex      af,af'
50b6 04        inc     b
50b7 0c        inc     c
50b8 1802      jr      50bch
50ba 0600      ld      b,00h
50bc 08        ex      af,af'
50bd 0f        rrca    
50be 09        add     hl,bc
50bf 04        inc     b
50c0 07        rlca    
50c1 ff        rst     38h
50c2 ff        rst     38h
50c3 ff        rst     38h
50c4 02        ld      (bc),a
50c5 1080      djnz    5047h
50c7 00        nop     
50c8 99        sbc     a,c
50c9 40        ld      b,b
50ca 0b        dec     bc
50cb 02        ld      (bc),a
50cc 1e00      ld      e,00h
50ce 0c        inc     c
50cf 1c        inc     e
50d0 09        add     hl,bc
50d1 09        add     hl,bc
50d2 07        rlca    
50d3 ff        rst     38h
50d4 ff        rst     38h
50d5 4c        ld      c,h
50d6 02        ld      (bc),a
50d7 010001    ld      bc,0100h
50da 03        inc     bc
50db 01d454    ld      bc,54d4h
50de 08        ex      af,af'
50df 0e99      ld      c,99h
50e1 0c        inc     c
50e2 04        inc     b
50e3 98        sbc     a,b
50e4 0c        inc     c
50e5 04        inc     b
50e6 9a        sbc     a,d
50e7 0c        inc     c
50e8 04        inc     b
50e9 99        sbc     a,c
50ea 0c        inc     c
50eb 04        inc     b
50ec 98        sbc     a,b
50ed 0c        inc     c
50ee 04        inc     b
50ef 9a        sbc     a,d
50f0 0c        inc     c
50f1 04        inc     b
50f2 99        sbc     a,c
50f3 08        ex      af,af'
50f4 04        inc     b
50f5 99        sbc     a,c
50f6 04        inc     b
50f7 02        ld      (bc),a
50f8 98        sbc     a,b
50f9 04        inc     b
50fa 02        ld      (bc),a
50fb 0c        inc     c
50fc 1802      jr      5100h
50fe 0600      ld      b,00h
5100 08        ex      af,af'
5101 0f        rrca    
5102 09        add     hl,bc
5103 04        inc     b
5104 07        rlca    
5105 ff        rst     38h
5106 ff        rst     38h
5107 ff        rst     38h
5108 02        ld      (bc),a
5109 1080      djnz    508bh
510b 00        nop     
510c 99        sbc     a,c
510d 2004      jr      nz,5113h
510f 02        ld      (bc),a
5110 1e00      ld      e,00h
5112 0c        inc     c
5113 1c        inc     e
5114 09        add     hl,bc
5115 09        add     hl,bc
5116 07        rlca    
5117 ff        rst     38h
5118 ff        rst     38h
5119 4c        ld      c,h
511a 02        ld      (bc),a
511b 010001    ld      bc,0100h
511e 08        ex      af,af'
511f 0e99      ld      c,99h
5121 04        inc     b
5122 02        ld      (bc),a
5123 98        sbc     a,b
5124 04        inc     b
5125 02        ld      (bc),a
5126 9a        sbc     a,d
5127 08        ex      af,af'
5128 04        inc     b
5129 99        sbc     a,c
512a 08        ex      af,af'
512b 04        inc     b
512c 99        sbc     a,c
512d 08        ex      af,af'
512e 04        inc     b
512f 99        sbc     a,c
5130 04        inc     b
5131 02        ld      (bc),a
5132 98        sbc     a,b
5133 04        inc     b
5134 02        ld      (bc),a
5135 99        sbc     a,c
5136 08        ex      af,af'
5137 04        inc     b
5138 99        sbc     a,c
5139 08        ex      af,af'
513a 04        inc     b
513b 0c        inc     c
513c 1802      jr      5140h
513e 0600      ld      b,00h
5140 08        ex      af,af'
5141 0f        rrca    
5142 09        add     hl,bc
5143 04        inc     b
5144 07        rlca    
5145 ff        rst     38h
5146 ff        rst     38h
5147 ff        rst     38h
5148 02        ld      (bc),a
5149 1080      djnz    50cbh
514b 00        nop     
514c 99        sbc     a,c
514d 1008      djnz    5157h
514f 04        inc     b
5150 80        add     a,b
5151 0c        inc     c
5152 0c        inc     c
5153 08        ex      af,af'
5154 0c        inc     c
5155 09        add     hl,bc
5156 0a        ld      a,(bc)
5157 99        sbc     a,c
5158 05        dec     b
5159 010808    ld      bc,0808h
515c 09        add     hl,bc
515d 02        ld      (bc),a
515e 99        sbc     a,c
515f 05        dec     b
5160 010805    ld      bc,0508h
5163 09        add     hl,bc
5164 0e99      ld      c,99h
5166 05        dec     b
5167 010803    ld      bc,0308h
516a 09        add     hl,bc
516b 00        nop     
516c 99        sbc     a,c
516d 05        dec     b
516e 018006    ld      bc,0680h
5171 0608      ld      b,08h
5173 02        ld      (bc),a
5174 09        add     hl,bc
5175 02        ld      (bc),a
5176 99        sbc     a,c
5177 03        inc     bc
5178 00        nop     
5179 08        ex      af,af'
517a 03        inc     bc
517b 09        add     hl,bc
517c 03        inc     bc
517d 99        sbc     a,c
517e 03        inc     bc
517f 00        nop     
5180 08        ex      af,af'
5181 05        dec     b
5182 09        add     hl,bc
5183 04        inc     b
5184 99        sbc     a,c
5185 03        inc     bc
5186 00        nop     
5187 08        ex      af,af'
5188 07        rlca    
5189 09        add     hl,bc
518a 05        dec     b
518b 99        sbc     a,c
518c 03        inc     bc
518d 00        nop     
518e 08        ex      af,af'
518f 0c        inc     c
5190 09        add     hl,bc
5191 0a        ld      a,(bc)
5192 99        sbc     a,c
5193 05        dec     b
5194 010808    ld      bc,0808h
5197 09        add     hl,bc
5198 02        ld      (bc),a
5199 99        sbc     a,c
519a 05        dec     b
519b 010805    ld      bc,0508h
519e 09        add     hl,bc
519f 0e99      ld      c,99h
51a1 05        dec     b
51a2 010803    ld      bc,0308h
51a5 09        add     hl,bc
51a6 00        nop     
51a7 99        sbc     a,c
51a8 05        dec     b
51a9 010408    ld      bc,0804h
51ac 0e98      ld      c,98h
51ae 02        ld      (bc),a
51af 00        nop     
51b0 99        sbc     a,c
51b1 09        add     hl,bc
51b2 010c18    ld      bc,180ch
51b5 02        ld      (bc),a
51b6 0600      ld      b,00h
51b8 08        ex      af,af'
51b9 0f        rrca    
51ba 09        add     hl,bc
51bb 04        inc     b
51bc 07        rlca    
51bd ff        rst     38h
51be ff        rst     38h
51bf ff        rst     38h
51c0 02        ld      (bc),a
51c1 1080      djnz    5143h
51c3 00        nop     
51c4 99        sbc     a,c
51c5 0c        inc     c
51c6 00        nop     
51c7 02        ld      (bc),a
51c8 1e00      ld      e,00h
51ca 0c        inc     c
51cb 1c        inc     e
51cc 09        add     hl,bc
51cd 09        add     hl,bc
51ce 07        rlca    
51cf ff        rst     38h
51d0 ff        rst     38h
51d1 4c        ld      c,h
51d2 02        ld      (bc),a
51d3 010001    ld      bc,0100h
51d6 08        ex      af,af'
51d7 0e98      ld      c,98h
51d9 02        ld      (bc),a
51da 00        nop     
51db 99        sbc     a,c
51dc 09        add     hl,bc
51dd 010c18    ld      bc,180ch
51e0 02        ld      (bc),a
51e1 0600      ld      b,00h
51e3 08        ex      af,af'
51e4 0f        rrca    
51e5 09        add     hl,bc
51e6 04        inc     b
51e7 07        rlca    
51e8 ff        rst     38h
51e9 ff        rst     38h
51ea ff        rst     38h
51eb 02        ld      (bc),a
51ec 1080      djnz    516eh
51ee 00        nop     
51ef 99        sbc     a,c
51f0 0c        inc     c
51f1 00        nop     
51f2 02        ld      (bc),a
51f3 1e00      ld      e,00h
51f5 0c        inc     c
51f6 1c        inc     e
51f7 09        add     hl,bc
51f8 09        add     hl,bc
51f9 07        rlca    
51fa ff        rst     38h
51fb ff        rst     38h
51fc 4c        ld      c,h
51fd 02        ld      (bc),a
51fe 010001    ld      bc,0100h
5201 08        ex      af,af'
5202 0e98      ld      c,98h
5204 02        ld      (bc),a
5205 00        nop     
5206 99        sbc     a,c
5207 09        add     hl,bc
5208 019804    ld      bc,0498h
520b 02        ld      (bc),a
520c 99        sbc     a,c
520d 04        inc     b
520e 02        ld      (bc),a
520f 99        sbc     a,c
5210 0c        inc     c
5211 03        inc     bc
5212 03        inc     bc
5213 01d454    ld      bc,54d4h
5216 08        ex      af,af'
5217 0e98      ld      c,98h
5219 02        ld      (bc),a
521a 00        nop     
521b 99        sbc     a,c
521c 09        add     hl,bc
521d 010c18    ld      bc,180ch
5220 02        ld      (bc),a
5221 0600      ld      b,00h
5223 08        ex      af,af'
5224 0f        rrca    
5225 09        add     hl,bc
5226 04        inc     b
5227 07        rlca    
5228 ff        rst     38h
5229 ff        rst     38h
522a ff        rst     38h
522b 02        ld      (bc),a
522c 1080      djnz    51aeh
522e 00        nop     
522f 99        sbc     a,c
5230 0c        inc     c
5231 00        nop     
5232 02        ld      (bc),a
5233 1e00      ld      e,00h
5235 0c        inc     c
5236 1c        inc     e
5237 09        add     hl,bc
5238 09        add     hl,bc
5239 07        rlca    
523a ff        rst     38h
523b ff        rst     38h
523c 4c        ld      c,h
523d 02        ld      (bc),a
523e 010001    ld      bc,0100h
5241 08        ex      af,af'
5242 0e98      ld      c,98h
5244 02        ld      (bc),a
5245 00        nop     
5246 99        sbc     a,c
5247 09        add     hl,bc
5248 010c18    ld      bc,180ch
524b 02        ld      (bc),a
524c 0600      ld      b,00h
524e 08        ex      af,af'
524f 0f        rrca    
5250 09        add     hl,bc
5251 04        inc     b
5252 07        rlca    
5253 ff        rst     38h
5254 ff        rst     38h
5255 ff        rst     38h
5256 02        ld      (bc),a
5257 1080      djnz    51d9h
5259 00        nop     
525a 99        sbc     a,c
525b 0c        inc     c
525c 00        nop     
525d 02        ld      (bc),a
525e 1e00      ld      e,00h
5260 0c        inc     c
5261 1c        inc     e
5262 09        add     hl,bc
5263 09        add     hl,bc
5264 07        rlca    
5265 ff        rst     38h
5266 ff        rst     38h
5267 4c        ld      c,h
5268 02        ld      (bc),a
5269 010001    ld      bc,0100h
526c 08        ex      af,af'
526d 0e98      ld      c,98h
526f 02        ld      (bc),a
5270 00        nop     
5271 99        sbc     a,c
5272 09        add     hl,bc
5273 019804    ld      bc,0498h
5276 02        ld      (bc),a
5277 99        sbc     a,c
5278 04        inc     b
5279 02        ld      (bc),a
527a 0c        inc     c
527b 1802      jr      527fh
527d 0600      ld      b,00h
527f 08        ex      af,af'
5280 0f        rrca    
5281 09        add     hl,bc
5282 04        inc     b
5283 07        rlca    
5284 ff        rst     38h
5285 ff        rst     38h
5286 ff        rst     38h
5287 02        ld      (bc),a
5288 1080      djnz    520ah
528a 00        nop     
528b 99        sbc     a,c
528c 0c        inc     c
528d 03        inc     bc
528e 02        ld      (bc),a
528f 1e00      ld      e,00h
5291 0c        inc     c
5292 1c        inc     e
5293 09        add     hl,bc
5294 09        add     hl,bc
5295 07        rlca    
5296 ff        rst     38h
5297 ff        rst     38h
5298 4c        ld      c,h
5299 02        ld      (bc),a
529a 010001    ld      bc,0100h
529d 03        inc     bc
529e 01d454    ld      bc,54d4h
52a1 08        ex      af,af'
52a2 0e99      ld      c,99h
52a4 0c        inc     c
52a5 00        nop     
52a6 99        sbc     a,c
52a7 0c        inc     c
52a8 0c        inc     c
52a9 98        sbc     a,b
52aa 0c        inc     c
52ab 0c        inc     c
52ac 98        sbc     a,b
52ad 04        inc     b
52ae 02        ld      (bc),a
52af 99        sbc     a,c
52b0 04        inc     b
52b1 02        ld      (bc),a
52b2 99        sbc     a,c
52b3 0c        inc     c
52b4 1898      jr      524eh
52b6 04        inc     b
52b7 02        ld      (bc),a
52b8 99        sbc     a,c
52b9 04        inc     b
52ba 02        ld      (bc),a
52bb 99        sbc     a,c
52bc 0c        inc     c
52bd 00        nop     
52be 99        sbc     a,c
52bf 0c        inc     c
52c0 0c        inc     c
52c1 98        sbc     a,b
52c2 04        inc     b
52c3 02        ld      (bc),a
52c4 99        sbc     a,c
52c5 04        inc     b
52c6 02        ld      (bc),a
52c7 99        sbc     a,c
52c8 180c      jr      52d6h
52ca 98        sbc     a,b
52cb 04        inc     b
52cc 02        ld      (bc),a
52cd 99        sbc     a,c
52ce 04        inc     b
52cf 02        ld      (bc),a
52d0 98        sbc     a,b
52d1 0c        inc     c
52d2 00        nop     
52d3 99        sbc     a,c
52d4 0c        inc     c
52d5 00        nop     
52d6 99        sbc     a,c
52d7 0f        rrca    
52d8 00        nop     
52d9 03        inc     bc
52da 01d454    ld      bc,54d4h
52dd 08        ex      af,af'
52de 0e99      ld      c,99h
52e0 0c        inc     c
52e1 0c        inc     c
52e2 04        inc     b
52e3 02        ld      (bc),a
52e4 1e00      ld      e,00h
52e6 0c        inc     c
52e7 1c        inc     e
52e8 09        add     hl,bc
52e9 09        add     hl,bc
52ea 07        rlca    
52eb ff        rst     38h
52ec ff        rst     38h
52ed 4c        ld      c,h
52ee 02        ld      (bc),a
52ef 010001    ld      bc,0100h
52f2 08        ex      af,af'
52f3 0c        inc     c
52f4 99        sbc     a,c
52f5 1800      jr      52f7h
52f7 0c        inc     c
52f8 1802      jr      52fch
52fa 0600      ld      b,00h
52fc 08        ex      af,af'
52fd 0f        rrca    
52fe 09        add     hl,bc
52ff 04        inc     b
5300 07        rlca    
5301 ff        rst     38h
5302 ff        rst     38h
5303 ff        rst     38h
5304 02        ld      (bc),a
5305 1080      djnz    5287h
5307 00        nop     
5308 99        sbc     a,c
5309 0f        rrca    
530a 00        nop     
530b 02        ld      (bc),a
530c 1e00      ld      e,00h
530e 0c        inc     c
530f 1c        inc     e
5310 09        add     hl,bc
5311 09        add     hl,bc
5312 07        rlca    
5313 ff        rst     38h
5314 ff        rst     38h
5315 4c        ld      c,h
5316 02        ld      (bc),a
5317 010001    ld      bc,0100h
531a 08        ex      af,af'
531b 08        ex      af,af'
531c 98        sbc     a,b
531d 03        inc     bc
531e 00        nop     
531f 08        ex      af,af'
5320 07        rlca    
5321 99        sbc     a,c
5322 03        inc     bc
5323 00        nop     
5324 08        ex      af,af'
5325 08        ex      af,af'
5326 9a        sbc     a,d
5327 03        inc     bc
5328 00        nop     
5329 08        ex      af,af'
532a 0c        inc     c
532b 99        sbc     a,c
532c 1800      jr      532eh
532e 0c        inc     c
532f 1802      jr      5333h
5331 0600      ld      b,00h
5333 08        ex      af,af'
5334 0f        rrca    
5335 09        add     hl,bc
5336 04        inc     b
5337 07        rlca    
5338 ff        rst     38h
5339 ff        rst     38h
533a ff        rst     38h
533b 02        ld      (bc),a
533c 1080      djnz    52beh
533e 00        nop     
533f 99        sbc     a,c
5340 180c      jr      534eh
5342 02        ld      (bc),a
5343 1e00      ld      e,00h
5345 0c        inc     c
5346 1c        inc     e
5347 09        add     hl,bc
5348 09        add     hl,bc
5349 07        rlca    
534a ff        rst     38h
534b ff        rst     38h
534c 4c        ld      c,h
534d 02        ld      (bc),a
534e 010001    ld      bc,0100h
5351 08        ex      af,af'
5352 0c        inc     c
5353 99        sbc     a,c
5354 0c        inc     c
5355 00        nop     
5356 98        sbc     a,b
5357 0c        inc     c
5358 00        nop     
5359 99        sbc     a,c
535a 0c        inc     c
535b 0c        inc     c
535c 99        sbc     a,c
535d 0c        inc     c
535e 00        nop     
535f 99        sbc     a,c
5360 0600      ld      b,00h
5362 98        sbc     a,b
5363 0600      ld      b,00h
5365 99        sbc     a,c
5366 0c        inc     c
5367 00        nop     
5368 80        add     a,b
5369 0c        inc     c
536a 00        nop     
536b 98        sbc     a,b
536c 0c        inc     c
536d 0c        inc     c
536e 98        sbc     a,b
536f 0c        inc     c
5370 0c        inc     c
5371 98        sbc     a,b
5372 0c        inc     c
5373 00        nop     
5374 99        sbc     a,c
5375 07        rlca    
5376 019807    ld      bc,0798h
5379 019907    ld      bc,0799h
537c 0d        dec     c
537d 99        sbc     a,c
537e 0c        inc     c
537f 00        nop     
5380 99        sbc     a,c
5381 0c        inc     c
5382 00        nop     
5383 98        sbc     a,b
5384 0600      ld      b,00h
5386 99        sbc     a,c
5387 0600      ld      b,00h
5389 99        sbc     a,c
538a 0f        rrca    
538b 00        nop     
538c 08        ex      af,af'
538d 08        ex      af,af'
538e 98        sbc     a,b
538f 03        inc     bc
5390 00        nop     
5391 08        ex      af,af'
5392 07        rlca    
5393 99        sbc     a,c
5394 03        inc     bc
5395 00        nop     
5396 08        ex      af,af'
5397 08        ex      af,af'
5398 9a        sbc     a,d
5399 03        inc     bc
539a 00        nop     
539b 08        ex      af,af'
539c 0c        inc     c
539d 99        sbc     a,c
539e 07        rlca    
539f 019707    ld      bc,0797h
53a2 019807    ld      bc,0798h
53a5 01080c    ld      bc,0c08h
53a8 99        sbc     a,c
53a9 1800      jr      53abh
53ab 0c        inc     c
53ac 1802      jr      53b0h
53ae 0600      ld      b,00h
53b0 08        ex      af,af'
53b1 0f        rrca    
53b2 09        add     hl,bc
53b3 04        inc     b
53b4 07        rlca    
53b5 ff        rst     38h
53b6 ff        rst     38h
53b7 ff        rst     38h
53b8 02        ld      (bc),a
53b9 1080      djnz    533bh
53bb 00        nop     
53bc 99        sbc     a,c
53bd 0f        rrca    
53be 00        nop     
53bf 02        ld      (bc),a
53c0 1e00      ld      e,00h
53c2 0c        inc     c
53c3 1c        inc     e
53c4 09        add     hl,bc
53c5 09        add     hl,bc
53c6 07        rlca    
53c7 ff        rst     38h
53c8 ff        rst     38h
53c9 4c        ld      c,h
53ca 02        ld      (bc),a
53cb 010001    ld      bc,0100h
53ce 08        ex      af,af'
53cf 08        ex      af,af'
53d0 98        sbc     a,b
53d1 03        inc     bc
53d2 00        nop     
53d3 08        ex      af,af'
53d4 07        rlca    
53d5 99        sbc     a,c
53d6 03        inc     bc
53d7 00        nop     
53d8 08        ex      af,af'
53d9 08        ex      af,af'
53da 9a        sbc     a,d
53db 03        inc     bc
53dc 00        nop     
53dd 08        ex      af,af'
53de 0c        inc     c
53df 99        sbc     a,c
53e0 1800      jr      53e2h
53e2 0c        inc     c
53e3 1802      jr      53e7h
53e5 0600      ld      b,00h
53e7 08        ex      af,af'
53e8 0f        rrca    
53e9 09        add     hl,bc
53ea 04        inc     b
53eb 07        rlca    
53ec ff        rst     38h
53ed ff        rst     38h
53ee ff        rst     38h
53ef 02        ld      (bc),a
53f0 1080      djnz    5372h
53f2 00        nop     
53f3 99        sbc     a,c
53f4 180c      jr      5402h
53f6 02        ld      (bc),a
53f7 1e00      ld      e,00h
53f9 0c        inc     c
53fa 1c        inc     e
53fb 09        add     hl,bc
53fc 09        add     hl,bc
53fd 07        rlca    
53fe ff        rst     38h
53ff ff        rst     38h
5400 4c        ld      c,h
5401 02        ld      (bc),a
5402 010001    ld      bc,0100h
5405 08        ex      af,af'
5406 0c        inc     c
5407 99        sbc     a,c
5408 0c        inc     c
5409 00        nop     
540a 98        sbc     a,b
540b 0c        inc     c
540c 00        nop     
540d 99        sbc     a,c
540e 0c        inc     c
540f 0c        inc     c
5410 99        sbc     a,c
5411 0c        inc     c
5412 00        nop     
5413 99        sbc     a,c
5414 0600      ld      b,00h
5416 98        sbc     a,b
5417 0603      ld      b,03h
5419 97        sub     a
541a 03        inc     bc
541b 00        nop     
541c 98        sbc     a,b
541d 03        inc     bc
541e 00        nop     
541f 99        sbc     a,c
5420 03        inc     bc
5421 00        nop     
5422 08        ex      af,af'
5423 0e98      ld      c,98h
5425 02        ld      (bc),a
5426 00        nop     
5427 99        sbc     a,c
5428 09        add     hl,bc
5429 010c18    ld      bc,180ch
542c 02        ld      (bc),a
542d 0600      ld      b,00h
542f 08        ex      af,af'
5430 0f        rrca    
5431 09        add     hl,bc
5432 04        inc     b
5433 07        rlca    
5434 ff        rst     38h
5435 ff        rst     38h
5436 ff        rst     38h
5437 02        ld      (bc),a
5438 1080      djnz    53bah
543a 00        nop     
543b 99        sbc     a,c
543c 0c        inc     c
543d 00        nop     
543e 02        ld      (bc),a
543f 1e00      ld      e,00h
5441 0c        inc     c
5442 1c        inc     e
5443 09        add     hl,bc
5444 09        add     hl,bc
5445 07        rlca    
5446 ff        rst     38h
5447 ff        rst     38h
5448 4c        ld      c,h
5449 02        ld      (bc),a
544a 010001    ld      bc,0100h
544d 08        ex      af,af'
544e 0e98      ld      c,98h
5450 02        ld      (bc),a
5451 00        nop     
5452 99        sbc     a,c
5453 09        add     hl,bc
5454 010c18    ld      bc,180ch
5457 02        ld      (bc),a
5458 0600      ld      b,00h
545a 08        ex      af,af'
545b 0f        rrca    
545c 09        add     hl,bc
545d 04        inc     b
545e 07        rlca    
545f ff        rst     38h
5460 ff        rst     38h
5461 ff        rst     38h
5462 02        ld      (bc),a
5463 1080      djnz    53e5h
5465 00        nop     
5466 99        sbc     a,c
5467 0c        inc     c
5468 0c        inc     c
5469 02        ld      (bc),a
546a 1e00      ld      e,00h
546c 0c        inc     c
546d 1c        inc     e
546e 09        add     hl,bc
546f 09        add     hl,bc
5470 07        rlca    
5471 ff        rst     38h
5472 ff        rst     38h
5473 4c        ld      c,h
5474 02        ld      (bc),a
5475 010001    ld      bc,0100h
5478 08        ex      af,af'
5479 0e98      ld      c,98h
547b 04        inc     b
547c 02        ld      (bc),a
547d 99        sbc     a,c
547e 04        inc     b
547f 02        ld      (bc),a
5480 99        sbc     a,c
5481 0c        inc     c
5482 0c        inc     c
5483 80        add     a,b
5484 0c        inc     c
5485 00        nop     
5486 99        sbc     a,c
5487 04        inc     b
5488 02        ld      (bc),a
5489 99        sbc     a,c
548a 04        inc     b
548b 02        ld      (bc),a
548c 98        sbc     a,b
548d 0a        ld      a,(bc)
548e 02        ld      (bc),a
548f 99        sbc     a,c
5490 03        inc     bc
5491 00        nop     
5492 08        ex      af,af'
5493 08        ex      af,af'
5494 98        sbc     a,b
5495 03        inc     bc
5496 00        nop     
5497 08        ex      af,af'
5498 07        rlca    
5499 99        sbc     a,c
549a 03        inc     bc
549b 00        nop     
549c 08        ex      af,af'
549d 08        ex      af,af'
549e 9a        sbc     a,d
549f 03        inc     bc
54a0 00        nop     
54a1 08        ex      af,af'
54a2 0c        inc     c
54a3 99        sbc     a,c
54a4 0c        inc     c
54a5 00        nop     
54a6 99        sbc     a,c
54a7 04        inc     b
54a8 02        ld      (bc),a
54a9 99        sbc     a,c
54aa 04        inc     b
54ab 02        ld      (bc),a
54ac 0c        inc     c
54ad 1802      jr      54b1h
54af 0600      ld      b,00h
54b1 08        ex      af,af'
54b2 0f        rrca    
54b3 09        add     hl,bc
54b4 04        inc     b
54b5 07        rlca    
54b6 ff        rst     38h
54b7 ff        rst     38h
54b8 ff        rst     38h
54b9 02        ld      (bc),a
54ba 1080      djnz    543ch
54bc 00        nop     
54bd 99        sbc     a,c
54be 0c        inc     c
54bf 03        inc     bc
54c0 02        ld      (bc),a
54c1 1e00      ld      e,00h
54c3 0c        inc     c
54c4 1c        inc     e
54c5 09        add     hl,bc
54c6 09        add     hl,bc
54c7 07        rlca    
54c8 ff        rst     38h
54c9 ff        rst     38h
54ca 4c        ld      c,h
54cb 02        ld      (bc),a
54cc 010001    ld      bc,0100h
54cf 03        inc     bc
54d0 01d454    ld      bc,54d4h
54d3 04        inc     b
54d4 08        ex      af,af'
54d5 08        ex      af,af'
54d6 98        sbc     a,b
54d7 03        inc     bc
54d8 00        nop     
54d9 08        ex      af,af'
54da 07        rlca    
54db 99        sbc     a,c
54dc 03        inc     bc
54dd 00        nop     
54de 08        ex      af,af'
54df 08        ex      af,af'
54e0 9a        sbc     a,d
54e1 03        inc     bc
54e2 00        nop     
54e3 04        inc     b
54e4 1880      jr      5466h
54e6 1800      jr      54e8h
54e8 02        ld      (bc),a
54e9 45        ld      b,l
54ea 00        nop     
54eb 0c        inc     c
54ec 24        inc     h
54ed 07        rlca    
54ee ff        rst     38h
54ef ff        rst     38h
54f0 0100ff    ld      bc,0ff00h
54f3 00        nop     
54f4 010907    ld      bc,0709h
54f7 08        ex      af,af'
54f8 0f        rrca    
54f9 03        inc     bc
54fa 019257    ld      bc,5792h
54fd 03        inc     bc
54fe 01c456    ld      bc,56c4h
5501 02        ld      (bc),a
5502 34        inc     (hl)
5503 00        nop     
5504 0c        inc     c
5505 1807      jr      550eh
5507 ff        rst     38h
5508 ff        rst     38h
5509 37        scf     
550a 01a000    ld      bc,00a0h
550d 04        inc     b
550e 08        ex      af,af'
550f 08        ex      af,af'
5510 09        add     hl,bc
5511 04        inc     b
5512 03        inc     bc
5513 010056    ld      bc,5600h
5516 02        ld      (bc),a
5517 84        add     a,h
5518 00        nop     
5519 0c        inc     c
551a 1807      jr      5523h
551c ff        rst     38h
551d ff        rst     38h
551e 66        ld      h,(hl)
551f 00        nop     
5520 e0        ret     po

5521 00        nop     
5522 04        inc     b
5523 08        ex      af,af'
5524 0b        dec     bc
5525 03        inc     bc
5526 01cf55    ld      bc,55cfh
5529 02        ld      (bc),a
552a 45        ld      b,l
552b 00        nop     
552c 0c        inc     c
552d 24        inc     h
552e 07        rlca    
552f ff        rst     38h
5530 ff        rst     38h
5531 0100ff    ld      bc,0ff00h
5534 00        nop     
5535 010907    ld      bc,0709h
5538 03        inc     bc
5539 013f55    ld      bc,553fh
553c 01f954    ld      bc,54f9h
553f 08        ex      af,af'
5540 0f        rrca    
5541 8d        adc     a,l
5542 1818      jr      555ch
5544 08        ex      af,af'
5545 08        ex      af,af'
5546 8d        adc     a,l
5547 04        inc     b
5548 00        nop     
5549 8d        adc     a,l
554a 04        inc     b
554b 00        nop     
554c 8d        adc     a,l
554d 04        inc     b
554e 00        nop     
554f 08        ex      af,af'
5550 0a        ld      a,(bc)
5551 8d        adc     a,l
5552 04        inc     b
5553 00        nop     
5554 8d        adc     a,l
5555 04        inc     b
5556 00        nop     
5557 8d        adc     a,l
5558 04        inc     b
5559 00        nop     
555a 08        ex      af,af'
555b 0f        rrca    
555c 8f        adc     a,a
555d 0602      ld      b,02h
555f 8f        adc     a,a
5560 0602      ld      b,02h
5562 8f        adc     a,a
5563 0602      ld      b,02h
5565 8a        adc     a,d
5566 08        ex      af,af'
5567 04        inc     b
5568 86        add     a,(hl)
5569 300c      jr      nc,5577h
556b 08        ex      af,af'
556c 08        ex      af,af'
556d 86        add     a,(hl)
556e 04        inc     b
556f 00        nop     
5570 86        add     a,(hl)
5571 04        inc     b
5572 00        nop     
5573 86        add     a,(hl)
5574 04        inc     b
5575 00        nop     
5576 08        ex      af,af'
5577 0a        ld      a,(bc)
5578 86        add     a,(hl)
5579 04        inc     b
557a 00        nop     
557b 86        add     a,(hl)
557c 04        inc     b
557d 00        nop     
557e 86        add     a,(hl)
557f 04        inc     b
5580 00        nop     
5581 08        ex      af,af'
5582 0e8d      ld      c,8dh
5584 0c        inc     c
5585 04        inc     b
5586 8d        adc     a,l
5587 0c        inc     c
5588 04        inc     b
5589 8d        adc     a,l
558a 0c        inc     c
558b 04        inc     b
558c 8f        adc     a,a
558d 0c        inc     c
558e 04        inc     b
558f 8f        adc     a,a
5590 0c        inc     c
5591 04        inc     b
5592 8f        adc     a,a
5593 0c        inc     c
5594 04        inc     b
5595 08        ex      af,af'
5596 0f        rrca    
5597 88        adc     a,b
5598 08        ex      af,af'
5599 04        inc     b
559a 88        adc     a,b
559b 04        inc     b
559c 02        ld      (bc),a
559d 88        adc     a,b
559e 04        inc     b
559f 02        ld      (bc),a
55a0 88        adc     a,b
55a1 0c        inc     c
55a2 0c        inc     c
55a3 08        ex      af,af'
55a4 08        ex      af,af'
55a5 88        adc     a,b
55a6 04        inc     b
55a7 00        nop     
55a8 88        adc     a,b
55a9 04        inc     b
55aa 00        nop     
55ab 88        adc     a,b
55ac 04        inc     b
55ad 00        nop     
55ae 08        ex      af,af'
55af 0f        rrca    
55b0 88        adc     a,b
55b1 04        inc     b
55b2 02        ld      (bc),a
55b3 88        adc     a,b
55b4 04        inc     b
55b5 02        ld      (bc),a
55b6 88        adc     a,b
55b7 08        ex      af,af'
55b8 04        inc     b
55b9 88        adc     a,b
55ba 08        ex      af,af'
55bb 04        inc     b
55bc 88        adc     a,b
55bd 08        ex      af,af'
55be 04        inc     b
55bf 88        adc     a,b
55c0 04        inc     b
55c1 02        ld      (bc),a
55c2 88        adc     a,b
55c3 04        inc     b
55c4 02        ld      (bc),a
55c5 88        adc     a,b
55c6 08        ex      af,af'
55c7 04        inc     b
55c8 88        adc     a,b
55c9 08        ex      af,af'
55ca 04        inc     b
55cb 88        adc     a,b
55cc 1818      jr      55e6h
55ce 04        inc     b
55cf 86        add     a,(hl)
55d0 04        inc     b
55d1 00        nop     
55d2 88        adc     a,b
55d3 04        inc     b
55d4 00        nop     
55d5 8a        adc     a,d
55d6 04        inc     b
55d7 00        nop     
55d8 8d        adc     a,l
55d9 04        inc     b
55da 00        nop     
55db 92        sub     d
55dc 04        inc     b
55dd 00        nop     
55de 94        sub     h
55df 04        inc     b
55e0 00        nop     
55e1 96        sub     (hl)
55e2 04        inc     b
55e3 00        nop     
55e4 99        sbc     a,c
55e5 04        inc     b
55e6 00        nop     
55e7 9e        sbc     a,(hl)
55e8 04        inc     b
55e9 00        nop     
55ea a0        and     b
55eb 04        inc     b
55ec 00        nop     
55ed a2        and     d
55ee 04        inc     b
55ef 00        nop     
55f0 a5        and     l
55f1 04        inc     b
55f2 00        nop     
55f3 aa        xor     d
55f4 04        inc     b
55f5 00        nop     
55f6 ac        xor     h
55f7 04        inc     b
55f8 00        nop     
55f9 ae        xor     (hl)
55fa 04        inc     b
55fb 00        nop     
55fc b1        or      c
55fd 04        inc     b
55fe 00        nop     
55ff 04        inc     b
5600 80        add     a,b
5601 0c        inc     c
5602 00        nop     
5603 a0        and     b
5604 08        ex      af,af'
5605 04        inc     b
5606 a3        and     e
5607 08        ex      af,af'
5608 04        inc     b
5609 a2        and     d
560a 0c        inc     c
560b 0c        inc     c
560c a2        and     d
560d 03        inc     bc
560e 03        inc     bc
560f a3        and     e
5610 04        inc     b
5611 02        ld      (bc),a
5612 a2        and     d
5613 08        ex      af,af'
5614 04        inc     b
5615 9e        sbc     a,(hl)
5616 08        ex      af,af'
5617 04        inc     b
5618 80        add     a,b
5619 0c        inc     c
561a 00        nop     
561b a2        and     d
561c 04        inc     b
561d 02        ld      (bc),a
561e a3        and     e
561f 04        inc     b
5620 02        ld      (bc),a
5621 a5        and     l
5622 0c        inc     c
5623 0c        inc     c
5624 80        add     a,b
5625 0c        inc     c
5626 00        nop     
5627 a7        and     a
5628 04        inc     b
5629 02        ld      (bc),a
562a a8        xor     b
562b 04        inc     b
562c 02        ld      (bc),a
562d aa        xor     d
562e 0c        inc     c
562f 0c        inc     c
5630 80        add     a,b
5631 0c        inc     c
5632 00        nop     
5633 a5        and     l
5634 04        inc     b
5635 02        ld      (bc),a
5636 a8        xor     b
5637 04        inc     b
5638 02        ld      (bc),a
5639 a7        and     a
563a 0c        inc     c
563b 0c        inc     c
563c 80        add     a,b
563d 0c        inc     c
563e 00        nop     
563f a2        and     d
5640 04        inc     b
5641 02        ld      (bc),a
5642 a5        and     l
5643 04        inc     b
5644 02        ld      (bc),a
5645 a3        and     e
5646 0c        inc     c
5647 0c        inc     c
5648 80        add     a,b
5649 0c        inc     c
564a 00        nop     
564b 9e        sbc     a,(hl)
564c 04        inc     b
564d 02        ld      (bc),a
564e a0        and     b
564f 04        inc     b
5650 02        ld      (bc),a
5651 9e        sbc     a,(hl)
5652 0606      ld      b,06h
5654 a0        and     b
5655 0606      ld      b,06h
5657 a3        and     e
5658 04        inc     b
5659 02        ld      (bc),a
565a a2        and     d
565b 04        inc     b
565c 02        ld      (bc),a
565d a0        and     b
565e 04        inc     b
565f 02        ld      (bc),a
5660 a2        and     d
5661 04        inc     b
5662 02        ld      (bc),a
5663 9e        sbc     a,(hl)
5664 0c        inc     c
5665 0c        inc     c
5666 80        add     a,b
5667 0600      ld      b,00h
5669 a3        and     e
566a 04        inc     b
566b 02        ld      (bc),a
566c a7        and     a
566d 04        inc     b
566e 02        ld      (bc),a
566f aa        xor     d
5670 04        inc     b
5671 02        ld      (bc),a
5672 a5        and     l
5673 0c        inc     c
5674 0c        inc     c
5675 80        add     a,b
5676 0600      ld      b,00h
5678 af        xor     a
5679 04        inc     b
567a 02        ld      (bc),a
567b ae        xor     (hl)
567c 04        inc     b
567d 02        ld      (bc),a
567e af        xor     a
567f 04        inc     b
5680 02        ld      (bc),a
5681 ae        xor     (hl)
5682 0606      ld      b,06h
5684 aa        xor     d
5685 0606      ld      b,06h
5687 80        add     a,b
5688 0c        inc     c
5689 00        nop     
568a a2        and     d
568b 04        inc     b
568c 02        ld      (bc),a
568d a3        and     e
568e 04        inc     b
568f 02        ld      (bc),a
5690 a5        and     l
5691 0c        inc     c
5692 0c        inc     c
5693 80        add     a,b
5694 0c        inc     c
5695 00        nop     
5696 a7        and     a
5697 04        inc     b
5698 02        ld      (bc),a
5699 a8        xor     b
569a 04        inc     b
569b 02        ld      (bc),a
569c aa        xor     d
569d 0c        inc     c
569e 0c        inc     c
569f 80        add     a,b
56a0 0c        inc     c
56a1 00        nop     
56a2 a5        and     l
56a3 04        inc     b
56a4 02        ld      (bc),a
56a5 a8        xor     b
56a6 04        inc     b
56a7 02        ld      (bc),a
56a8 a7        and     a
56a9 0c        inc     c
56aa 0c        inc     c
56ab 80        add     a,b
56ac 0c        inc     c
56ad 00        nop     
56ae a2        and     d
56af 04        inc     b
56b0 02        ld      (bc),a
56b1 a5        and     l
56b2 04        inc     b
56b3 02        ld      (bc),a
56b4 a3        and     e
56b5 0c        inc     c
56b6 0c        inc     c
56b7 80        add     a,b
56b8 0c        inc     c
56b9 00        nop     
56ba 9e        sbc     a,(hl)
56bb 04        inc     b
56bc 02        ld      (bc),a
56bd a0        and     b
56be 04        inc     b
56bf 02        ld      (bc),a
56c0 9e        sbc     a,(hl)
56c1 0602      ld      b,02h
56c3 04        inc     b
56c4 08        ex      af,af'
56c5 0e80      ld      c,80h
56c7 0c        inc     c
56c8 00        nop     
56c9 8f        adc     a,a
56ca 0c        inc     c
56cb 0c        inc     c
56cc 91        sub     c
56cd 0c        inc     c
56ce 0c        inc     c
56cf 08        ex      af,af'
56d0 0a        ld      a,(bc)
56d1 92        sub     d
56d2 04        inc     b
56d3 02        ld      (bc),a
56d4 92        sub     d
56d5 04        inc     b
56d6 02        ld      (bc),a
56d7 08        ex      af,af'
56d8 0e94      ld      c,94h
56da 0c        inc     c
56db 0c        inc     c
56dc 08        ex      af,af'
56dd 0e80      ld      c,80h
56df 0c        inc     c
56e0 00        nop     
56e1 8f        adc     a,a
56e2 0c        inc     c
56e3 0c        inc     c
56e4 91        sub     c
56e5 0c        inc     c
56e6 0c        inc     c
56e7 08        ex      af,af'
56e8 0a        ld      a,(bc)
56e9 94        sub     h
56ea 04        inc     b
56eb 02        ld      (bc),a
56ec 94        sub     h
56ed 04        inc     b
56ee 02        ld      (bc),a
56ef 08        ex      af,af'
56f0 0e94      ld      c,94h
56f2 0c        inc     c
56f3 0c        inc     c
56f4 08        ex      af,af'
56f5 0a        ld      a,(bc)
56f6 8f        adc     a,a
56f7 0c        inc     c
56f8 0c        inc     c
56f9 91        sub     c
56fa 0c        inc     c
56fb 0c        inc     c
56fc 92        sub     d
56fd 0c        inc     c
56fe 0c        inc     c
56ff 92        sub     d
5700 0c        inc     c
5701 0c        inc     c
5702 08        ex      af,af'
5703 04        inc     b
5704 94        sub     h
5705 04        inc     b
5706 00        nop     
5707 94        sub     h
5708 04        inc     b
5709 00        nop     
570a 94        sub     h
570b 04        inc     b
570c 00        nop     
570d 94        sub     h
570e 04        inc     b
570f 00        nop     
5710 94        sub     h
5711 04        inc     b
5712 00        nop     
5713 94        sub     h
5714 04        inc     b
5715 00        nop     
5716 08        ex      af,af'
5717 05        dec     b
5718 94        sub     h
5719 04        inc     b
571a 00        nop     
571b 94        sub     h
571c 04        inc     b
571d 00        nop     
571e 94        sub     h
571f 04        inc     b
5720 00        nop     
5721 94        sub     h
5722 04        inc     b
5723 00        nop     
5724 94        sub     h
5725 04        inc     b
5726 00        nop     
5727 94        sub     h
5728 04        inc     b
5729 00        nop     
572a 08        ex      af,af'
572b 0694      ld      b,94h
572d 04        inc     b
572e 00        nop     
572f 94        sub     h
5730 04        inc     b
5731 00        nop     
5732 94        sub     h
5733 04        inc     b
5734 00        nop     
5735 94        sub     h
5736 04        inc     b
5737 00        nop     
5738 94        sub     h
5739 04        inc     b
573a 00        nop     
573b 94        sub     h
573c 04        inc     b
573d 00        nop     
573e 08        ex      af,af'
573f 07        rlca    
5740 94        sub     h
5741 04        inc     b
5742 00        nop     
5743 94        sub     h
5744 04        inc     b
5745 00        nop     
5746 94        sub     h
5747 04        inc     b
5748 00        nop     
5749 94        sub     h
574a 04        inc     b
574b 00        nop     
574c 94        sub     h
574d 04        inc     b
574e 00        nop     
574f 94        sub     h
5750 04        inc     b
5751 00        nop     
5752 08        ex      af,af'
5753 08        ex      af,af'
5754 94        sub     h
5755 04        inc     b
5756 00        nop     
5757 94        sub     h
5758 04        inc     b
5759 00        nop     
575a 94        sub     h
575b 04        inc     b
575c 00        nop     
575d 94        sub     h
575e 04        inc     b
575f 00        nop     
5760 94        sub     h
5761 04        inc     b
5762 00        nop     
5763 94        sub     h
5764 04        inc     b
5765 00        nop     
5766 94        sub     h
5767 04        inc     b
5768 00        nop     
5769 94        sub     h
576a 04        inc     b
576b 00        nop     
576c 94        sub     h
576d 04        inc     b
576e 00        nop     
576f 94        sub     h
5770 04        inc     b
5771 00        nop     
5772 94        sub     h
5773 04        inc     b
5774 00        nop     
5775 94        sub     h
5776 04        inc     b
5777 00        nop     
5778 08        ex      af,af'
5779 0a        ld      a,(bc)
577a 94        sub     h
577b 04        inc     b
577c 00        nop     
577d 94        sub     h
577e 04        inc     b
577f 00        nop     
5780 94        sub     h
5781 04        inc     b
5782 00        nop     
5783 94        sub     h
5784 04        inc     b
5785 00        nop     
5786 94        sub     h
5787 04        inc     b
5788 00        nop     
5789 94        sub     h
578a 04        inc     b
578b 00        nop     
578c 08        ex      af,af'
578d 0e94      ld      c,94h
578f 08        ex      af,af'
5790 1004      djnz    5796h
5792 80        add     a,b
5793 1800      jr      5795h
5795 99        sbc     a,c
5796 1818      jr      57b0h
5798 96        sub     (hl)
5799 1800      jr      579bh
579b 92        sub     d
579c 0c        inc     c
579d 00        nop     
579e 1802      jr      57a2h
57a0 75        ld      (hl),l
57a1 00        nop     
57a2 0c        inc     c
57a3 1807      jr      57ach
57a5 ff        rst     38h
57a6 ff        rst     38h
57a7 0100ff    ld      bc,0ff00h
57aa 00        nop     
57ab ff        rst     38h
57ac 08        ex      af,af'
57ad 0a        ld      a,(bc)
57ae 09        add     hl,bc
57af 04        inc     b
57b0 a2        and     d
57b1 0c        inc     c
57b2 00        nop     
57b3 a0        and     b
57b4 0600      ld      b,00h
57b6 08        ex      af,af'
57b7 05        dec     b
57b8 09        add     hl,bc
57b9 0f        rrca    
57ba a2        and     d
57bb 0600      ld      b,00h
57bd 08        ex      af,af'
57be 0a        ld      a,(bc)
57bf 09        add     hl,bc
57c0 04        inc     b
57c1 a2        and     d
57c2 0600      ld      b,00h
57c4 08        ex      af,af'
57c5 05        dec     b
57c6 09        add     hl,bc
57c7 0f        rrca    
57c8 a0        and     b
57c9 0606      ld      b,06h
57cb a2        and     d
57cc 0600      ld      b,00h
57ce 08        ex      af,af'
57cf 0a        ld      a,(bc)
57d0 09        add     hl,bc
57d1 04        inc     b
57d2 99        sbc     a,c
57d3 0c        inc     c
57d4 00        nop     
57d5 99        sbc     a,c
57d6 0600      ld      b,00h
57d8 08        ex      af,af'
57d9 05        dec     b
57da 09        add     hl,bc
57db 0f        rrca    
57dc 99        sbc     a,c
57dd 0600      ld      b,00h
57df 08        ex      af,af'
57e0 0a        ld      a,(bc)
57e1 09        add     hl,bc
57e2 04        inc     b
57e3 9b        sbc     a,e
57e4 0600      ld      b,00h
57e6 08        ex      af,af'
57e7 05        dec     b
57e8 09        add     hl,bc
57e9 0f        rrca    
57ea 99        sbc     a,c
57eb 0600      ld      b,00h
57ed 80        add     a,b
57ee 0600      ld      b,00h
57f0 9b        sbc     a,e
57f1 0600      ld      b,00h
57f3 80        add     a,b
57f4 60        ld      h,b
57f5 00        nop     
57f6 80        add     a,b
57f7 54        ld      d,h
57f8 00        nop     
57f9 02        ld      (bc),a
57fa 45        ld      b,l
57fb 00        nop     
57fc 0c        inc     c
57fd 24        inc     h
57fe 07        rlca    
57ff ff        rst     38h
5800 ff        rst     38h
5801 0100ff    ld      bc,0ff00h
5804 00        nop     
5805 010907    ld      bc,0709h
5808 08        ex      af,af'
5809 0f        rrca    
580a 80        add     a,b
580b 0c        inc     c
580c 0c        inc     c
580d 99        sbc     a,c
580e 1818      jr      5828h
5810 96        sub     (hl)
5811 1800      jr      5813h
5813 92        sub     d
5814 0c        inc     c
5815 00        nop     
5816 1802      jr      581ah
5818 75        ld      (hl),l
5819 00        nop     
581a 0c        inc     c
581b 1807      jr      5824h
581d ff        rst     38h
581e ff        rst     38h
581f 0100ff    ld      bc,0ff00h
5822 00        nop     
5823 ff        rst     38h
5824 08        ex      af,af'
5825 0a        ld      a,(bc)
5826 09        add     hl,bc
5827 04        inc     b
5828 a2        and     d
5829 0c        inc     c
582a 00        nop     
582b a0        and     b
582c 0600      ld      b,00h
582e 08        ex      af,af'
582f 05        dec     b
5830 09        add     hl,bc
5831 0f        rrca    
5832 a2        and     d
5833 0600      ld      b,00h
5835 08        ex      af,af'
5836 0a        ld      a,(bc)
5837 09        add     hl,bc
5838 04        inc     b
5839 a2        and     d
583a 0600      ld      b,00h
583c 08        ex      af,af'
583d 05        dec     b
583e 09        add     hl,bc
583f 0f        rrca    
5840 a0        and     b
5841 0600      ld      b,00h
5843 08        ex      af,af'
5844 0a        ld      a,(bc)
5845 09        add     hl,bc
5846 04        inc     b
5847 9d        sbc     a,l
5848 0600      ld      b,00h
584a 08        ex      af,af'
584b 05        dec     b
584c 09        add     hl,bc
584d 0f        rrca    
584e a2        and     d
584f 0600      ld      b,00h
5851 08        ex      af,af'
5852 0a        ld      a,(bc)
5853 09        add     hl,bc
5854 04        inc     b
5855 9b        sbc     a,e
5856 0600      ld      b,00h
5858 08        ex      af,af'
5859 05        dec     b
585a 09        add     hl,bc
585b 0f        rrca    
585c 9d        sbc     a,l
585d 0600      ld      b,00h
585f 08        ex      af,af'
5860 0a        ld      a,(bc)
5861 09        add     hl,bc
5862 04        inc     b
5863 99        sbc     a,c
5864 0600      ld      b,00h
5866 08        ex      af,af'
5867 05        dec     b
5868 09        add     hl,bc
5869 0f        rrca    
586a 9b        sbc     a,e
586b 0606      ld      b,06h
586d 99        sbc     a,c
586e 0600      ld      b,00h
5870 02        ld      (bc),a
5871 45        ld      b,l
5872 00        nop     
5873 0c        inc     c
5874 24        inc     h
5875 07        rlca    
5876 ff        rst     38h
5877 ff        rst     38h
5878 0100ff    ld      bc,0ff00h
587b 00        nop     
587c 010907    ld      bc,0709h
587f 08        ex      af,af'
5880 0f        rrca    
5881 80        add     a,b
5882 0c        inc     c
5883 00        nop     
5884 8f        adc     a,a
5885 0c        inc     c
5886 0c        inc     c
5887 91        sub     c
5888 0c        inc     c
5889 0c        inc     c
588a 08        ex      af,af'
588b 0c        inc     c
588c 92        sub     d
588d 05        dec     b
588e 019205    ld      bc,0592h
5891 01080f    ld      bc,0f08h
5894 92        sub     d
5895 0c        inc     c
5896 0c        inc     c
5897 80        add     a,b
5898 0c        inc     c
5899 00        nop     
589a 08        ex      af,af'
589b 0a        ld      a,(bc)
589c 94        sub     h
589d 04        inc     b
589e 02        ld      (bc),a
589f 94        sub     h
58a0 04        inc     b
58a1 02        ld      (bc),a
58a2 08        ex      af,af'
58a3 0c        inc     c
58a4 94        sub     h
58a5 0a        ld      a,(bc)
58a6 02        ld      (bc),a
58a7 94        sub     h
58a8 0a        ld      a,(bc)
58a9 02        ld      (bc),a
58aa 80        add     a,b
58ab 0c        inc     c
58ac 00        nop     
58ad 08        ex      af,af'
58ae 0a        ld      a,(bc)
58af 94        sub     h
58b0 04        inc     b
58b1 02        ld      (bc),a
58b2 94        sub     h
58b3 04        inc     b
58b4 02        ld      (bc),a
58b5 08        ex      af,af'
58b6 0c        inc     c
58b7 94        sub     h
58b8 0c        inc     c
58b9 0c        inc     c
58ba 04        inc     b
58bb 1802      jr      58bfh
58bd 90        sub     b
58be 00        nop     
58bf 0c        inc     c
58c0 24        inc     h
58c1 07        rlca    
58c2 ff        rst     38h
58c3 ff        rst     38h
58c4 ff        rst     38h
58c5 00        nop     
58c6 ff        rst     38h
58c7 55        ld      d,l
58c8 1c        inc     e
58c9 08        ex      af,af'
58ca 0f        rrca    
58cb 09        add     hl,bc
58cc 08        ex      af,af'
58cd 80        add     a,b
58ce 1800      jr      58d0h
58d0 03        inc     bc
58d1 01c859    ld      bc,59c8h
58d4 03        inc     bc
58d5 017f59    ld      bc,597fh
58d8 08        ex      af,af'
58d9 0e03      ld      c,03h
58db 02        ld      (bc),a
58dc 3659      ld      (hl),59h
58de 08        ex      af,af'
58df 0f        rrca    
58e0 03        inc     bc
58e1 01e758    ld      bc,58e7h
58e4 01d058    ld      bc,58d0h
58e7 8d        adc     a,l
58e8 40        ld      b,b
58e9 08        ex      af,af'
58ea 8f        adc     a,a
58eb 0602      ld      b,02h
58ed 8f        adc     a,a
58ee 0602      ld      b,02h
58f0 8f        adc     a,a
58f1 0602      ld      b,02h
58f3 8a        adc     a,d
58f4 08        ex      af,af'
58f5 04        inc     b
58f6 86        add     a,(hl)
58f7 50        ld      d,b
58f8 04        inc     b
58f9 8d        adc     a,l
58fa 0c        inc     c
58fb 04        inc     b
58fc 8d        adc     a,l
58fd 0c        inc     c
58fe 04        inc     b
58ff 8d        adc     a,l
5900 0c        inc     c
5901 04        inc     b
5902 8f        adc     a,a
5903 0c        inc     c
5904 04        inc     b
5905 8f        adc     a,a
5906 0c        inc     c
5907 04        inc     b
5908 8f        adc     a,a
5909 0c        inc     c
590a 04        inc     b
590b 88        adc     a,b
590c 08        ex      af,af'
590d 04        inc     b
590e 88        adc     a,b
590f 04        inc     b
5910 02        ld      (bc),a
5911 88        adc     a,b
5912 04        inc     b
5913 02        ld      (bc),a
5914 88        adc     a,b
5915 180c      jr      5923h
5917 88        adc     a,b
5918 04        inc     b
5919 02        ld      (bc),a
591a 88        adc     a,b
591b 04        inc     b
591c 02        ld      (bc),a
591d 88        adc     a,b
591e 08        ex      af,af'
591f 04        inc     b
5920 88        adc     a,b
5921 08        ex      af,af'
5922 04        inc     b
5923 88        adc     a,b
5924 08        ex      af,af'
5925 04        inc     b
5926 88        adc     a,b
5927 04        inc     b
5928 02        ld      (bc),a
5929 88        adc     a,b
592a 04        inc     b
592b 02        ld      (bc),a
592c 88        adc     a,b
592d 08        ex      af,af'
592e 04        inc     b
592f 88        adc     a,b
5930 08        ex      af,af'
5931 04        inc     b
5932 88        adc     a,b
5933 1818      jr      594dh
5935 04        inc     b
5936 84        add     a,h
5937 0a        ld      a,(bc)
5938 02        ld      (bc),a
5939 84        add     a,h
593a 0c        inc     c
593b 0c        inc     c
593c 84        add     a,h
593d 0c        inc     c
593e 0c        inc     c
593f 84        add     a,h
5940 0606      ld      b,06h
5942 84        add     a,h
5943 0a        ld      a,(bc)
5944 02        ld      (bc),a
5945 84        add     a,h
5946 0606      ld      b,06h
5948 8a        adc     a,d
5949 0a        ld      a,(bc)
594a 02        ld      (bc),a
594b 8a        adc     a,d
594c 0c        inc     c
594d 0c        inc     c
594e 8a        adc     a,d
594f 0c        inc     c
5950 0c        inc     c
5951 8a        adc     a,d
5952 0606      ld      b,06h
5954 8a        adc     a,d
5955 0a        ld      a,(bc)
5956 02        ld      (bc),a
5957 8a        adc     a,d
5958 0606      ld      b,06h
595a 8d        adc     a,l
595b 0a        ld      a,(bc)
595c 02        ld      (bc),a
595d 8d        adc     a,l
595e 0c        inc     c
595f 0c        inc     c
5960 8d        adc     a,l
5961 0c        inc     c
5962 0c        inc     c
5963 8d        adc     a,l
5964 0606      ld      b,06h
5966 8b        adc     a,e
5967 0a        ld      a,(bc)
5968 02        ld      (bc),a
5969 8b        adc     a,e
596a 0606      ld      b,06h
596c 86        add     a,(hl)
596d 0a        ld      a,(bc)
596e 02        ld      (bc),a
596f 86        add     a,(hl)
5970 0c        inc     c
5971 0c        inc     c
5972 86        add     a,(hl)
5973 0c        inc     c
5974 0c        inc     c
5975 86        add     a,(hl)
5976 0606      ld      b,06h
5978 86        add     a,(hl)
5979 0a        ld      a,(bc)
597a 02        ld      (bc),a
597b 86        add     a,(hl)
597c 0606      ld      b,06h
597e 04        inc     b
597f 80        add     a,b
5980 0c        inc     c
5981 00        nop     
5982 83        add     a,e
5983 0c        inc     c
5984 0c        inc     c
5985 85        add     a,l
5986 0c        inc     c
5987 0c        inc     c
5988 86        add     a,(hl)
5989 04        inc     b
598a 02        ld      (bc),a
598b 86        add     a,(hl)
598c 04        inc     b
598d 02        ld      (bc),a
598e 88        adc     a,b
598f 0c        inc     c
5990 0c        inc     c
5991 80        add     a,b
5992 0c        inc     c
5993 00        nop     
5994 83        add     a,e
5995 0c        inc     c
5996 0c        inc     c
5997 85        add     a,l
5998 0c        inc     c
5999 0c        inc     c
599a 88        adc     a,b
599b 04        inc     b
599c 02        ld      (bc),a
599d 88        adc     a,b
599e 04        inc     b
599f 02        ld      (bc),a
59a0 88        adc     a,b
59a1 0c        inc     c
59a2 0c        inc     c
59a3 83        add     a,e
59a4 0c        inc     c
59a5 0c        inc     c
59a6 85        add     a,l
59a7 0c        inc     c
59a8 0c        inc     c
59a9 86        add     a,(hl)
59aa 0c        inc     c
59ab 0c        inc     c
59ac 86        add     a,(hl)
59ad 0c        inc     c
59ae 0c        inc     c
59af 88        adc     a,b
59b0 0c        inc     c
59b1 0c        inc     c
59b2 88        adc     a,b
59b3 0c        inc     c
59b4 0c        inc     c
59b5 88        adc     a,b
59b6 0c        inc     c
59b7 0c        inc     c
59b8 88        adc     a,b
59b9 0c        inc     c
59ba 0c        inc     c
59bb 88        adc     a,b
59bc 0c        inc     c
59bd 0c        inc     c
59be 88        adc     a,b
59bf 0c        inc     c
59c0 0c        inc     c
59c1 88        adc     a,b
59c2 0c        inc     c
59c3 0c        inc     c
59c4 88        adc     a,b
59c5 0c        inc     c
59c6 0c        inc     c
59c7 04        inc     b
59c8 80        add     a,b
59c9 1800      jr      59cbh
59cb 8d        adc     a,l
59cc 1800      jr      59ceh
59ce 80        add     a,b
59cf 1800      jr      59d1h
59d1 8a        adc     a,d
59d2 1800      jr      59d4h
59d4 86        add     a,(hl)
59d5 0c        inc     c
59d6 0c        inc     c
59d7 88        adc     a,b
59d8 0c        inc     c
59d9 0c        inc     c
59da 8a        adc     a,d
59db 0c        inc     c
59dc 0c        inc     c
59dd 8c        adc     a,h
59de 0c        inc     c
59df 0c        inc     c
59e0 83        add     a,e
59e1 0c        inc     c
59e2 0c        inc     c
59e3 85        add     a,l
59e4 0c        inc     c
59e5 0c        inc     c
59e6 86        add     a,(hl)
59e7 0c        inc     c
59e8 0c        inc     c
59e9 86        add     a,(hl)
59ea 0c        inc     c
59eb 0c        inc     c
59ec 88        adc     a,b
59ed 0c        inc     c
59ee 0c        inc     c
59ef 88        adc     a,b
59f0 0c        inc     c
59f1 0c        inc     c
59f2 88        adc     a,b
59f3 1818      jr      5a0dh
59f5 80        add     a,b
59f6 1800      jr      59f8h
59f8 8d        adc     a,l
59f9 1800      jr      59fbh
59fb 80        add     a,b
59fc 1800      jr      59feh
59fe 8a        adc     a,d
59ff 1800      jr      5a01h
5a01 86        add     a,(hl)
5a02 0c        inc     c
5a03 0c        inc     c
5a04 88        adc     a,b
5a05 0c        inc     c
5a06 0c        inc     c
5a07 8a        adc     a,d
5a08 0c        inc     c
5a09 0c        inc     c
5a0a 8c        adc     a,h
5a0b 0c        inc     c
5a0c 1883      jr      5991h
5a0e 0c        inc     c
5a0f 0c        inc     c
5a10 85        add     a,l
5a11 0c        inc     c
5a12 0c        inc     c
5a13 86        add     a,(hl)
5a14 05        dec     b
5a15 018605    ld      bc,0586h
5a18 01860c    ld      bc,0c86h
5a1b 0c        inc     c
5a1c 88        adc     a,b
5a1d 0c        inc     c
5a1e 0c        inc     c
5a1f 88        adc     a,b
5a20 0a        ld      a,(bc)
5a21 02        ld      (bc),a
5a22 88        adc     a,b
5a23 0a        ld      a,(bc)
5a24 02        ld      (bc),a
5a25 88        adc     a,b
5a26 0c        inc     c
5a27 0c        inc     c
5a28 88        adc     a,b
5a29 0c        inc     c
5a2a 0c        inc     c
5a2b 04        inc     b
5a2c 1880      jr      59aeh
5a2e 1800      jr      5a30h
5a30 02        ld      (bc),a
5a31 1f        rra     
5a32 00        nop     
5a33 0c        inc     c
5a34 1803      jr      5a39h
5a36 018b5b    ld      bc,5b8bh
5a39 03        inc     bc
5a3a 01ae5a    ld      bc,5aaeh
5a3d 80        add     a,b
5a3e c0        ret     nz

5a3f c0        ret     nz

5a40 80        add     a,b
5a41 c0        ret     nz

5a42 c0        ret     nz

5a43 07        rlca    
5a44 ff        rst     38h
5a45 ff        rst     38h
5a46 84        add     a,h
5a47 00        nop     
5a48 f0        ret     p

5a49 49        ld      c,c
5a4a 04        inc     b
5a4b 09        add     hl,bc
5a4c 04        inc     b
5a4d 08        ex      af,af'
5a4e 0e03      ld      c,03h
5a50 01565a    ld      bc,5a56h
5a53 012d5a    ld      bc,5a2dh
5a56 9c        sbc     a,h
5a57 40        ld      b,b
5a58 08        ex      af,af'
5a59 9b        sbc     a,e
5a5a 0602      ld      b,02h
5a5c 9c        sbc     a,h
5a5d 0602      ld      b,02h
5a5f 9b        sbc     a,e
5a60 0602      ld      b,02h
5a62 99        sbc     a,c
5a63 08        ex      af,af'
5a64 04        inc     b
5a65 96        sub     (hl)
5a66 40        ld      b,b
5a67 0b        dec     bc
5a68 99        sbc     a,c
5a69 03        inc     bc
5a6a 00        nop     
5a6b 9a        sbc     a,d
5a6c 03        inc     bc
5a6d 00        nop     
5a6e 9b        sbc     a,e
5a6f 03        inc     bc
5a70 00        nop     
5a71 9c        sbc     a,h
5a72 0c        inc     c
5a73 04        inc     b
5a74 9e        sbc     a,(hl)
5a75 0c        inc     c
5a76 04        inc     b
5a77 a0        and     b
5a78 0c        inc     c
5a79 04        inc     b
5a7a 9b        sbc     a,e
5a7b 0c        inc     c
5a7c 04        inc     b
5a7d 99        sbc     a,c
5a7e 0c        inc     c
5a7f 04        inc     b
5a80 97        sub     a
5a81 0c        inc     c
5a82 04        inc     b
5a83 99        sbc     a,c
5a84 08        ex      af,af'
5a85 04        inc     b
5a86 99        sbc     a,c
5a87 04        inc     b
5a88 02        ld      (bc),a
5a89 99        sbc     a,c
5a8a 04        inc     b
5a8b 02        ld      (bc),a
5a8c 9e        sbc     a,(hl)
5a8d 2004      jr      nz,5a93h
5a8f 99        sbc     a,c
5a90 04        inc     b
5a91 02        ld      (bc),a
5a92 99        sbc     a,c
5a93 04        inc     b
5a94 02        ld      (bc),a
5a95 9e        sbc     a,(hl)
5a96 08        ex      af,af'
5a97 04        inc     b
5a98 99        sbc     a,c
5a99 08        ex      af,af'
5a9a 04        inc     b
5a9b 9b        sbc     a,e
5a9c 08        ex      af,af'
5a9d 04        inc     b
5a9e 9b        sbc     a,e
5a9f 04        inc     b
5aa0 02        ld      (bc),a
5aa1 9b        sbc     a,e
5aa2 04        inc     b
5aa3 02        ld      (bc),a
5aa4 a0        and     b
5aa5 0a        ld      a,(bc)
5aa6 02        ld      (bc),a
5aa7 a0        and     b
5aa8 0a        ld      a,(bc)
5aa9 02        ld      (bc),a
5aaa a0        and     b
5aab 14        inc     d
5aac 04        inc     b
5aad 04        inc     b
5aae 08        ex      af,af'
5aaf 0c        inc     c
5ab0 07        rlca    
5ab1 ff        rst     38h
5ab2 ff        rst     38h
5ab3 84        add     a,h
5ab4 00        nop     
5ab5 f0        ret     p

5ab6 49        ld      c,c
5ab7 04        inc     b
5ab8 80        add     a,b
5ab9 0c        inc     c
5aba 00        nop     
5abb 9e        sbc     a,(hl)
5abc 08        ex      af,af'
5abd 109d      djnz    5a5ch
5abf 0a        ld      a,(bc)
5ac0 0e07      ld      c,07h
5ac2 ff        rst     38h
5ac3 ff        rst     38h
5ac4 84        add     a,h
5ac5 00        nop     
5ac6 f0        ret     p

5ac7 00        nop     
5ac8 1e99      ld      e,99h
5aca 04        inc     b
5acb 02        ld      (bc),a
5acc 99        sbc     a,c
5acd 04        inc     b
5ace 02        ld      (bc),a
5acf 07        rlca    
5ad0 ff        rst     38h
5ad1 ff        rst     38h
5ad2 84        add     a,h
5ad3 00        nop     
5ad4 f0        ret     p

5ad5 49        ld      c,c
5ad6 04        inc     b
5ad7 99        sbc     a,c
5ad8 08        ex      af,af'
5ad9 1007      djnz    5ae2h
5adb ff        rst     38h
5adc ff        rst     38h
5add 84        add     a,h
5ade 00        nop     
5adf f0        ret     p

5ae0 49        ld      c,c
5ae1 04        inc     b
5ae2 80        add     a,b
5ae3 0c        inc     c
5ae4 00        nop     
5ae5 9e        sbc     a,(hl)
5ae6 08        ex      af,af'
5ae7 109d      djnz    5a86h
5ae9 0a        ld      a,(bc)
5aea 0e07      ld      c,07h
5aec ff        rst     38h
5aed ff        rst     38h
5aee 84        add     a,h
5aef 00        nop     
5af0 f0        ret     p

5af1 00        nop     
5af2 1e99      ld      e,99h
5af4 04        inc     b
5af5 02        ld      (bc),a
5af6 99        sbc     a,c
5af7 04        inc     b
5af8 02        ld      (bc),a
5af9 07        rlca    
5afa ff        rst     38h
5afb ff        rst     38h
5afc 84        add     a,h
5afd 00        nop     
5afe f0        ret     p

5aff 49        ld      c,c
5b00 04        inc     b
5b01 9b        sbc     a,e
5b02 08        ex      af,af'
5b03 1007      djnz    5b0ch
5b05 ff        rst     38h
5b06 ff        rst     38h
5b07 84        add     a,h
5b08 00        nop     
5b09 f0        ret     p

5b0a 49        ld      c,c
5b0b 04        inc     b
5b0c 80        add     a,b
5b0d 0c        inc     c
5b0e 00        nop     
5b0f 9e        sbc     a,(hl)
5b10 08        ex      af,af'
5b11 109d      djnz    5ab0h
5b13 0a        ld      a,(bc)
5b14 0e07      ld      c,07h
5b16 ff        rst     38h
5b17 ff        rst     38h
5b18 84        add     a,h
5b19 00        nop     
5b1a f0        ret     p

5b1b 00        nop     
5b1c 1e99      ld      e,99h
5b1e 04        inc     b
5b1f 02        ld      (bc),a
5b20 99        sbc     a,c
5b21 04        inc     b
5b22 02        ld      (bc),a
5b23 07        rlca    
5b24 ff        rst     38h
5b25 ff        rst     38h
5b26 84        add     a,h
5b27 00        nop     
5b28 f0        ret     p

5b29 49        ld      c,c
5b2a 04        inc     b
5b2b 99        sbc     a,c
5b2c 08        ex      af,af'
5b2d 1c        inc     e
5b2e 07        rlca    
5b2f ff        rst     38h
5b30 ff        rst     38h
5b31 84        add     a,h
5b32 00        nop     
5b33 f0        ret     p

5b34 00        nop     
5b35 1e99      ld      e,99h
5b37 04        inc     b
5b38 02        ld      (bc),a
5b39 99        sbc     a,c
5b3a 04        inc     b
5b3b 02        ld      (bc),a
5b3c 07        rlca    
5b3d ff        rst     38h
5b3e ff        rst     38h
5b3f 84        add     a,h
5b40 00        nop     
5b41 f0        ret     p

5b42 49        ld      c,c
5b43 04        inc     b
5b44 99        sbc     a,c
5b45 08        ex      af,af'
5b46 04        inc     b
5b47 99        sbc     a,c
5b48 08        ex      af,af'
5b49 1007      djnz    5b52h
5b4b ff        rst     38h
5b4c ff        rst     38h
5b4d 84        add     a,h
5b4e 00        nop     
5b4f f0        ret     p

5b50 00        nop     
5b51 1e99      ld      e,99h
5b53 04        inc     b
5b54 02        ld      (bc),a
5b55 99        sbc     a,c
5b56 04        inc     b
5b57 02        ld      (bc),a
5b58 07        rlca    
5b59 ff        rst     38h
5b5a ff        rst     38h
5b5b 84        add     a,h
5b5c 00        nop     
5b5d f0        ret     p

5b5e 49        ld      c,c
5b5f 04        inc     b
5b60 99        sbc     a,c
5b61 0c        inc     c
5b62 1807      jr      5b6bh
5b64 ff        rst     38h
5b65 ff        rst     38h
5b66 84        add     a,h
5b67 00        nop     
5b68 f0        ret     p

5b69 00        nop     
5b6a 1e99      ld      e,99h
5b6c 04        inc     b
5b6d 02        ld      (bc),a
5b6e 99        sbc     a,c
5b6f 04        inc     b
5b70 02        ld      (bc),a
5b71 07        rlca    
5b72 ff        rst     38h
5b73 ff        rst     38h
5b74 84        add     a,h
5b75 00        nop     
5b76 f0        ret     p

5b77 49        ld      c,c
5b78 04        inc     b
5b79 99        sbc     a,c
5b7a 08        ex      af,af'
5b7b 04        inc     b
5b7c 99        sbc     a,c
5b7d 08        ex      af,af'
5b7e 04        inc     b
5b7f 07        rlca    
5b80 ff        rst     38h
5b81 ff        rst     38h
5b82 84        add     a,h
5b83 00        nop     
5b84 f0        ret     p

5b85 49        ld      c,c
5b86 04        inc     b
5b87 9b        sbc     a,e
5b88 0c        inc     c
5b89 24        inc     h
5b8a 04        inc     b
5b8b 07        rlca    
5b8c ff        rst     38h
5b8d ff        rst     38h
5b8e 84        add     a,h
5b8f 00        nop     
5b90 f0        ret     p

5b91 49        ld      c,c
5b92 04        inc     b
5b93 08        ex      af,af'
5b94 0e09      ld      c,09h
5b96 05        dec     b
5b97 80        add     a,b
5b98 1800      jr      5b9ah
5b9a a0        and     b
5b9b 08        ex      af,af'
5b9c 28a0      jr      z,5b3eh
5b9e 0a        ld      a,(bc)
5b9f 0e07      ld      c,07h
5ba1 ff        rst     38h
5ba2 ff        rst     38h
5ba3 84        add     a,h
5ba4 00        nop     
5ba5 f0        ret     p

5ba6 00        nop     
5ba7 1e08      ld      e,08h
5ba9 0c        inc     c
5baa 80        add     a,b
5bab 60        ld      h,b
5bac 0c        inc     c
5bad 9e        sbc     a,(hl)
5bae 04        inc     b
5baf 14        inc     d
5bb0 9d        sbc     a,l
5bb1 04        inc     b
5bb2 14        inc     d
5bb3 99        sbc     a,c
5bb4 04        inc     b
5bb5 08        ex      af,af'
5bb6 07        rlca    
5bb7 ff        rst     38h
5bb8 ff        rst     38h
5bb9 84        add     a,h
5bba 00        nop     
5bbb f0        ret     p

5bbc 49        ld      c,c
5bbd 04        inc     b
5bbe 99        sbc     a,c
5bbf 03        inc     bc
5bc0 05        dec     b
5bc1 9b        sbc     a,e
5bc2 03        inc     bc
5bc3 05        dec     b
5bc4 9d        sbc     a,l
5bc5 03        inc     bc
5bc6 05        dec     b
5bc7 07        rlca    
5bc8 ff        rst     38h
5bc9 ff        rst     38h
5bca 84        add     a,h
5bcb 00        nop     
5bcc f0        ret     p

5bcd 00        nop     
5bce 1e80      ld      e,80h
5bd0 0c        inc     c
5bd1 00        nop     
5bd2 9e        sbc     a,(hl)
5bd3 04        inc     b
5bd4 02        ld      (bc),a
5bd5 9e        sbc     a,(hl)
5bd6 04        inc     b
5bd7 02        ld      (bc),a
5bd8 07        rlca    
5bd9 ff        rst     38h
5bda ff        rst     38h
5bdb 84        add     a,h
5bdc 00        nop     
5bdd f0        ret     p

5bde 49        ld      c,c
5bdf 04        inc     b
5be0 9e        sbc     a,(hl)
5be1 08        ex      af,af'
5be2 04        inc     b
5be3 07        rlca    
5be4 ff        rst     38h
5be5 ff        rst     38h
5be6 84        add     a,h
5be7 00        nop     
5be8 f0        ret     p

5be9 00        nop     
5bea 1e9e      ld      e,9eh
5bec 04        inc     b
5bed 02        ld      (bc),a
5bee 9e        sbc     a,(hl)
5bef 04        inc     b
5bf0 02        ld      (bc),a
5bf1 07        rlca    
5bf2 ff        rst     38h
5bf3 ff        rst     38h
5bf4 84        add     a,h
5bf5 00        nop     
5bf6 f0        ret     p

5bf7 49        ld      c,c
5bf8 04        inc     b
5bf9 a0        and     b
5bfa 08        ex      af,af'
5bfb 2807      jr      z,5c04h
5bfd ff        rst     38h
5bfe ff        rst     38h
5bff 84        add     a,h
5c00 00        nop     
5c01 f0        ret     p

5c02 49        ld      c,c
5c03 04        inc     b
5c04 08        ex      af,af'
5c05 0e80      ld      c,80h
5c07 1800      jr      5c09h
5c09 a0        and     b
5c0a 08        ex      af,af'
5c0b 28a0      jr      z,5badh
5c0d 0a        ld      a,(bc)
5c0e 0e08      ld      c,08h
5c10 0d        dec     c
5c11 80        add     a,b
5c12 60        ld      h,b
5c13 0c        inc     c
5c14 9e        sbc     a,(hl)
5c15 08        ex      af,af'
5c16 109d      djnz    5bb5h
5c18 08        ex      af,af'
5c19 1007      djnz    5c22h
5c1b ff        rst     38h
5c1c ff        rst     38h
5c1d 84        add     a,h
5c1e 00        nop     
5c1f f0        ret     p

5c20 00        nop     
5c21 1e99      ld      e,99h
5c23 04        inc     b
5c24 02        ld      (bc),a
5c25 99        sbc     a,c
5c26 04        inc     b
5c27 02        ld      (bc),a
5c28 07        rlca    
5c29 ff        rst     38h
5c2a ff        rst     38h
5c2b 84        add     a,h
5c2c 00        nop     
5c2d f0        ret     p

5c2e 49        ld      c,c
5c2f 04        inc     b
5c30 99        sbc     a,c
5c31 08        ex      af,af'
5c32 1007      djnz    5c3bh
5c34 ff        rst     38h
5c35 ff        rst     38h
5c36 84        add     a,h
5c37 00        nop     
5c38 f0        ret     p

5c39 00        nop     
5c3a 1e80      ld      e,80h
5c3c 0c        inc     c
5c3d 00        nop     
5c3e 99        sbc     a,c
5c3f 04        inc     b
5c40 02        ld      (bc),a
5c41 99        sbc     a,c
5c42 04        inc     b
5c43 02        ld      (bc),a
5c44 07        rlca    
5c45 ff        rst     38h
5c46 ff        rst     38h
5c47 84        add     a,h
5c48 00        nop     
5c49 f0        ret     p

5c4a 49        ld      c,c
5c4b 04        inc     b
5c4c 9e        sbc     a,(hl)
5c4d 0606      ld      b,06h
5c4f 9e        sbc     a,(hl)
5c50 0606      ld      b,06h
5c52 07        rlca    
5c53 ff        rst     38h
5c54 ff        rst     38h
5c55 84        add     a,h
5c56 00        nop     
5c57 f0        ret     p

5c58 00        nop     
5c59 1e80      ld      e,80h
5c5b 0c        inc     c
5c5c 00        nop     
5c5d 9b        sbc     a,e
5c5e 04        inc     b
5c5f 02        ld      (bc),a
5c60 9b        sbc     a,e
5c61 04        inc     b
5c62 02        ld      (bc),a
5c63 07        rlca    
5c64 ff        rst     38h
5c65 ff        rst     38h
5c66 84        add     a,h
5c67 00        nop     
5c68 f0        ret     p

5c69 49        ld      c,c
5c6a 04        inc     b
5c6b a0        and     b
5c6c 08        ex      af,af'
5c6d 1004      djnz    5c73h
5c6f 1880      jr      5bf1h
5c71 0a        ld      a,(bc)
5c72 00        nop     
5c73 02        ld      (bc),a
5c74 2f        cpl     
5c75 00        nop     
5c76 0c        inc     c
5c77 1607      ld      d,07h
5c79 ff        rst     38h
5c7a ff        rst     38h
5c7b 63        ld      h,e
5c7c 00        nop     
5c7d 80        add     a,b
5c7e 88        adc     a,b
5c7f 08        ex      af,af'
5c80 08        ex      af,af'
5c81 07        rlca    
5c82 09        add     hl,bc
5c83 019907    ld      bc,0799h
5c86 019b07    ld      bc,079bh
5c89 019907    ld      bc,0799h
5c8c 010301    ld      bc,0103h
5c8f 59        ld      e,c
5c90 4b        ld      c,e
5c91 03        inc     bc
5c92 01134b    ld      bc,4b13h
5c95 02        ld      (bc),a
5c96 2a000c    ld      hl,(0c00h)
5c99 1807      jr      5ca2h
5c9b ff        rst     38h
5c9c ff        rst     38h
5c9d 40        ld      b,b
5c9e 00        nop     
5c9f c0        ret     nz

5ca0 33        inc     sp
5ca1 010806    ld      bc,0608h
5ca4 09        add     hl,bc
5ca5 010301    ld      bc,0103h
5ca8 a3        and     e
5ca9 4a        ld      c,d
5caa 08        ex      af,af'
5cab 0a        ld      a,(bc)
5cac 09        add     hl,bc
5cad 010301    ld      bc,0103h
5cb0 d349      out     (49h),a
5cb2 01735c    ld      bc,5c73h
5cb5 1880      jr      5c37h
5cb7 1800      jr      5cb9h
5cb9 02        ld      (bc),a
5cba 1f        rra     
5cbb 00        nop     
5cbc 0c        inc     c
5cbd 1803      jr      5cc2h
5cbf 01c25d    ld      bc,5dc2h
5cc2 03        inc     bc
5cc3 01e35c    ld      bc,5ce3h
5cc6 80        add     a,b
5cc7 c0        ret     nz

5cc8 c0        ret     nz

5cc9 80        add     a,b
5cca c0        ret     nz

5ccb c0        ret     nz

5ccc 07        rlca    
5ccd ff        rst     38h
5cce ff        rst     38h
5ccf 84        add     a,h
5cd0 00        nop     
5cd1 f0        ret     p

5cd2 49        ld      c,c
5cd3 04        inc     b
5cd4 08        ex      af,af'
5cd5 0e09      ld      c,09h
5cd7 02        ld      (bc),a
5cd8 0d        dec     c
5cd9 f40301    call    p,0103h
5cdc 56        ld      d,(hl)
5cdd 5a        ld      e,d
5cde 0d        dec     c
5cdf 0c        inc     c
5ce0 01b65c    ld      bc,5cb6h
5ce3 07        rlca    
5ce4 ff        rst     38h
5ce5 ff        rst     38h
5ce6 84        add     a,h
5ce7 00        nop     
5ce8 f0        ret     p

5ce9 49        ld      c,c
5cea 04        inc     b
5ceb 08        ex      af,af'
5cec 0c        inc     c
5ced 80        add     a,b
5cee 0c        inc     c
5cef 00        nop     
5cf0 99        sbc     a,c
5cf1 08        ex      af,af'
5cf2 1099      djnz    5c8dh
5cf4 0a        ld      a,(bc)
5cf5 0e07      ld      c,07h
5cf7 ff        rst     38h
5cf8 ff        rst     38h
5cf9 84        add     a,h
5cfa 00        nop     
5cfb f0        ret     p

5cfc 00        nop     
5cfd 1e96      ld      e,96h
5cff 04        inc     b
5d00 02        ld      (bc),a
5d01 96        sub     (hl)
5d02 04        inc     b
5d03 02        ld      (bc),a
5d04 07        rlca    
5d05 ff        rst     38h
5d06 ff        rst     38h
5d07 84        add     a,h
5d08 00        nop     
5d09 f0        ret     p

5d0a 49        ld      c,c
5d0b 04        inc     b
5d0c 96        sub     (hl)
5d0d 08        ex      af,af'
5d0e 1007      djnz    5d17h
5d10 ff        rst     38h
5d11 ff        rst     38h
5d12 84        add     a,h
5d13 00        nop     
5d14 f0        ret     p

5d15 49        ld      c,c
5d16 04        inc     b
5d17 08        ex      af,af'
5d18 0c        inc     c
5d19 80        add     a,b
5d1a 0c        inc     c
5d1b 00        nop     
5d1c 99        sbc     a,c
5d1d 08        ex      af,af'
5d1e 1099      djnz    5cb9h
5d20 0a        ld      a,(bc)
5d21 0e07      ld      c,07h
5d23 ff        rst     38h
5d24 ff        rst     38h
5d25 84        add     a,h
5d26 00        nop     
5d27 f0        ret     p

5d28 00        nop     
5d29 1e96      ld      e,96h
5d2b 04        inc     b
5d2c 02        ld      (bc),a
5d2d 96        sub     (hl)
5d2e 04        inc     b
5d2f 02        ld      (bc),a
5d30 07        rlca    
5d31 ff        rst     38h
5d32 ff        rst     38h
5d33 84        add     a,h
5d34 00        nop     
5d35 f0        ret     p

5d36 49        ld      c,c
5d37 04        inc     b
5d38 98        sbc     a,b
5d39 08        ex      af,af'
5d3a 1007      djnz    5d43h
5d3c ff        rst     38h
5d3d ff        rst     38h
5d3e 84        add     a,h
5d3f 00        nop     
5d40 f0        ret     p

5d41 49        ld      c,c
5d42 04        inc     b
5d43 80        add     a,b
5d44 0c        inc     c
5d45 00        nop     
5d46 99        sbc     a,c
5d47 08        ex      af,af'
5d48 1099      djnz    5ce3h
5d4a 0a        ld      a,(bc)
5d4b 0e07      ld      c,07h
5d4d ff        rst     38h
5d4e ff        rst     38h
5d4f 84        add     a,h
5d50 00        nop     
5d51 f0        ret     p

5d52 00        nop     
5d53 1e96      ld      e,96h
5d55 04        inc     b
5d56 02        ld      (bc),a
5d57 96        sub     (hl)
5d58 04        inc     b
5d59 02        ld      (bc),a
5d5a 07        rlca    
5d5b ff        rst     38h
5d5c ff        rst     38h
5d5d 84        add     a,h
5d5e 00        nop     
5d5f f0        ret     p

5d60 49        ld      c,c
5d61 04        inc     b
5d62 96        sub     (hl)
5d63 08        ex      af,af'
5d64 1c        inc     e
5d65 07        rlca    
5d66 ff        rst     38h
5d67 ff        rst     38h
5d68 84        add     a,h
5d69 00        nop     
5d6a f0        ret     p

5d6b 00        nop     
5d6c 1e96      ld      e,96h
5d6e 04        inc     b
5d6f 02        ld      (bc),a
5d70 96        sub     (hl)
5d71 04        inc     b
5d72 02        ld      (bc),a
5d73 07        rlca    
5d74 ff        rst     38h
5d75 ff        rst     38h
5d76 84        add     a,h
5d77 00        nop     
5d78 f0        ret     p

5d79 49        ld      c,c
5d7a 04        inc     b
5d7b 96        sub     (hl)
5d7c 08        ex      af,af'
5d7d 04        inc     b
5d7e 96        sub     (hl)
5d7f 08        ex      af,af'
5d80 1007      djnz    5d89h
5d82 ff        rst     38h
5d83 ff        rst     38h
5d84 84        add     a,h
5d85 00        nop     
5d86 f0        ret     p

5d87 00        nop     
5d88 1e96      ld      e,96h
5d8a 04        inc     b
5d8b 02        ld      (bc),a
5d8c 96        sub     (hl)
5d8d 04        inc     b
5d8e 02        ld      (bc),a
5d8f 07        rlca    
5d90 ff        rst     38h
5d91 ff        rst     38h
5d92 84        add     a,h
5d93 00        nop     
5d94 f0        ret     p

5d95 49        ld      c,c
5d96 04        inc     b
5d97 96        sub     (hl)
5d98 0c        inc     c
5d99 1807      jr      5da2h
5d9b ff        rst     38h
5d9c ff        rst     38h
5d9d 84        add     a,h
5d9e 00        nop     
5d9f f0        ret     p

5da0 00        nop     
5da1 1e96      ld      e,96h
5da3 04        inc     b
5da4 02        ld      (bc),a
5da5 96        sub     (hl)
5da6 04        inc     b
5da7 02        ld      (bc),a
5da8 07        rlca    
5da9 ff        rst     38h
5daa ff        rst     38h
5dab 84        add     a,h
5dac 00        nop     
5dad f0        ret     p

5dae 49        ld      c,c
5daf 04        inc     b
5db0 96        sub     (hl)
5db1 08        ex      af,af'
5db2 04        inc     b
5db3 96        sub     (hl)
5db4 08        ex      af,af'
5db5 04        inc     b
5db6 07        rlca    
5db7 ff        rst     38h
5db8 ff        rst     38h
5db9 84        add     a,h
5dba 00        nop     
5dbb f0        ret     p

5dbc 49        ld      c,c
5dbd 04        inc     b
5dbe 98        sbc     a,b
5dbf 0c        inc     c
5dc0 24        inc     h
5dc1 04        inc     b
5dc2 07        rlca    
5dc3 ff        rst     38h
5dc4 ff        rst     38h
5dc5 84        add     a,h
5dc6 00        nop     
5dc7 f0        ret     p

5dc8 49        ld      c,c
5dc9 04        inc     b
5dca 08        ex      af,af'
5dcb 0e09      ld      c,09h
5dcd 03        inc     bc
5dce 80        add     a,b
5dcf 1800      jr      5dd1h
5dd1 9b        sbc     a,e
5dd2 08        ex      af,af'
5dd3 289d      jr      z,5d72h
5dd5 0a        ld      a,(bc)
5dd6 0e07      ld      c,07h
5dd8 ff        rst     38h
5dd9 ff        rst     38h
5dda 84        add     a,h
5ddb 00        nop     
5ddc f0        ret     p

5ddd 00        nop     
5dde 1e08      ld      e,08h
5de0 0c        inc     c
5de1 80        add     a,b
5de2 60        ld      h,b
5de3 0c        inc     c
5de4 9b        sbc     a,e
5de5 04        inc     b
5de6 14        inc     d
5de7 99        sbc     a,c
5de8 04        inc     b
5de9 14        inc     d
5dea 96        sub     (hl)
5deb 04        inc     b
5dec 08        ex      af,af'
5ded 07        rlca    
5dee ff        rst     38h
5def ff        rst     38h
5df0 84        add     a,h
5df1 00        nop     
5df2 f0        ret     p

5df3 49        ld      c,c
5df4 04        inc     b
5df5 96        sub     (hl)
5df6 03        inc     bc
5df7 05        dec     b
5df8 96        sub     (hl)
5df9 03        inc     bc
5dfa 05        dec     b
5dfb 96        sub     (hl)
5dfc 03        inc     bc
5dfd 05        dec     b
5dfe 07        rlca    
5dff ff        rst     38h
5e00 ff        rst     38h
5e01 84        add     a,h
5e02 00        nop     
5e03 f0        ret     p

5e04 00        nop     
5e05 1e80      ld      e,80h
5e07 0c        inc     c
5e08 00        nop     
5e09 99        sbc     a,c
5e0a 04        inc     b
5e0b 02        ld      (bc),a
5e0c 99        sbc     a,c
5e0d 04        inc     b
5e0e 02        ld      (bc),a
5e0f 07        rlca    
5e10 ff        rst     38h
5e11 ff        rst     38h
5e12 84        add     a,h
5e13 00        nop     
5e14 f0        ret     p

5e15 49        ld      c,c
5e16 04        inc     b
5e17 99        sbc     a,c
5e18 08        ex      af,af'
5e19 04        inc     b
5e1a 07        rlca    
5e1b ff        rst     38h
5e1c ff        rst     38h
5e1d 84        add     a,h
5e1e 00        nop     
5e1f f0        ret     p

5e20 00        nop     
5e21 1e99      ld      e,99h
5e23 04        inc     b
5e24 02        ld      (bc),a
5e25 99        sbc     a,c
5e26 04        inc     b
5e27 02        ld      (bc),a
5e28 07        rlca    
5e29 ff        rst     38h
5e2a ff        rst     38h
5e2b 84        add     a,h
5e2c 00        nop     
5e2d f0        ret     p

5e2e 49        ld      c,c
5e2f 04        inc     b
5e30 9b        sbc     a,e
5e31 08        ex      af,af'
5e32 2807      jr      z,5e3bh
5e34 ff        rst     38h
5e35 ff        rst     38h
5e36 84        add     a,h
5e37 00        nop     
5e38 f0        ret     p

5e39 49        ld      c,c
5e3a 04        inc     b
5e3b 08        ex      af,af'
5e3c 0e80      ld      c,80h
5e3e 1800      jr      5e40h
5e40 9b        sbc     a,e
5e41 08        ex      af,af'
5e42 289d      jr      z,5de1h
5e44 0a        ld      a,(bc)
5e45 0e08      ld      c,08h
5e47 0d        dec     c
5e48 80        add     a,b
5e49 60        ld      h,b
5e4a 0c        inc     c
5e4b 9b        sbc     a,e
5e4c 08        ex      af,af'
5e4d 1099      djnz    5de8h
5e4f 08        ex      af,af'
5e50 1007      djnz    5e59h
5e52 ff        rst     38h
5e53 ff        rst     38h
5e54 84        add     a,h
5e55 00        nop     
5e56 f0        ret     p

5e57 00        nop     
5e58 1e96      ld      e,96h
5e5a 04        inc     b
5e5b 02        ld      (bc),a
5e5c 96        sub     (hl)
5e5d 04        inc     b
5e5e 02        ld      (bc),a
5e5f 07        rlca    
5e60 ff        rst     38h
5e61 ff        rst     38h
5e62 84        add     a,h
5e63 00        nop     
5e64 f0        ret     p

5e65 49        ld      c,c
5e66 04        inc     b
5e67 96        sub     (hl)
5e68 08        ex      af,af'
5e69 1007      djnz    5e72h
5e6b ff        rst     38h
5e6c ff        rst     38h
5e6d 84        add     a,h
5e6e 00        nop     
5e6f f0        ret     p

5e70 00        nop     
5e71 1e80      ld      e,80h
5e73 0c        inc     c
5e74 00        nop     
5e75 96        sub     (hl)
5e76 04        inc     b
5e77 02        ld      (bc),a
5e78 96        sub     (hl)
5e79 04        inc     b
5e7a 02        ld      (bc),a
5e7b 07        rlca    
5e7c ff        rst     38h
5e7d ff        rst     38h
5e7e 84        add     a,h
5e7f 00        nop     
5e80 f0        ret     p

5e81 49        ld      c,c
5e82 04        inc     b
5e83 99        sbc     a,c
5e84 0606      ld      b,06h
5e86 99        sbc     a,c
5e87 0606      ld      b,06h
5e89 07        rlca    
5e8a ff        rst     38h
5e8b ff        rst     38h
5e8c 84        add     a,h
5e8d 00        nop     
5e8e f0        ret     p

5e8f 00        nop     
5e90 1e80      ld      e,80h
5e92 0c        inc     c
5e93 00        nop     
5e94 99        sbc     a,c
5e95 04        inc     b
5e96 02        ld      (bc),a
5e97 99        sbc     a,c
5e98 04        inc     b
5e99 02        ld      (bc),a
5e9a 07        rlca    
5e9b ff        rst     38h
5e9c ff        rst     38h
5e9d 84        add     a,h
5e9e 00        nop     
5e9f f0        ret     p

5ea0 49        ld      c,c
5ea1 04        inc     b
5ea2 9b        sbc     a,e
5ea3 08        ex      af,af'
5ea4 1004      djnz    5eaah
5ea6 1880      jr      5e28h
5ea8 1800      jr      5eaah
5eaa 02        ld      (bc),a
5eab 1f        rra     
5eac 00        nop     
5ead 0c        inc     c
5eae 1803      jr      5eb3h
5eb0 01b35f    ld      bc,5fb3h
5eb3 03        inc     bc
5eb4 01d45e    ld      bc,5ed4h
5eb7 80        add     a,b
5eb8 c0        ret     nz

5eb9 c0        ret     nz

5eba 80        add     a,b
5ebb c0        ret     nz

5ebc c0        ret     nz

5ebd 80        add     a,b
5ebe 1000      djnz    5ec0h
5ec0 07        rlca    
5ec1 ff        rst     38h
5ec2 ff        rst     38h
5ec3 84        add     a,h
5ec4 00        nop     
5ec5 f0        ret     p

5ec6 49        ld      c,c
5ec7 04        inc     b
5ec8 08        ex      af,af'
5ec9 07        rlca    
5eca 09        add     hl,bc
5ecb 0c        inc     c
5ecc 03        inc     bc
5ecd 01565a    ld      bc,5a56h
5ed0 80        add     a,b
5ed1 08        ex      af,af'
5ed2 00        nop     
5ed3 00        nop     
5ed4 07        rlca    
5ed5 ff        rst     38h
5ed6 ff        rst     38h
5ed7 84        add     a,h
5ed8 00        nop     
5ed9 f0        ret     p

5eda 49        ld      c,c
5edb 04        inc     b
5edc 08        ex      af,af'
5edd 0c        inc     c
5ede 80        add     a,b
5edf 0c        inc     c
5ee0 00        nop     
5ee1 96        sub     (hl)
5ee2 08        ex      af,af'
5ee3 1094      djnz    5e79h
5ee5 0a        ld      a,(bc)
5ee6 0e07      ld      c,07h
5ee8 ff        rst     38h
5ee9 ff        rst     38h
5eea 84        add     a,h
5eeb 00        nop     
5eec f0        ret     p

5eed 00        nop     
5eee 1e92      ld      e,92h
5ef0 04        inc     b
5ef1 02        ld      (bc),a
5ef2 92        sub     d
5ef3 04        inc     b
5ef4 02        ld      (bc),a
5ef5 07        rlca    
5ef6 ff        rst     38h
5ef7 ff        rst     38h
5ef8 84        add     a,h
5ef9 00        nop     
5efa f0        ret     p

5efb 49        ld      c,c
5efc 04        inc     b
5efd 92        sub     d
5efe 08        ex      af,af'
5eff 1007      djnz    5f08h
5f01 ff        rst     38h
5f02 ff        rst     38h
5f03 84        add     a,h
5f04 00        nop     
5f05 f0        ret     p

5f06 49        ld      c,c
5f07 04        inc     b
5f08 08        ex      af,af'
5f09 0c        inc     c
5f0a 80        add     a,b
5f0b 0c        inc     c
5f0c 00        nop     
5f0d 96        sub     (hl)
5f0e 08        ex      af,af'
5f0f 1094      djnz    5ea5h
5f11 0a        ld      a,(bc)
5f12 0e07      ld      c,07h
5f14 ff        rst     38h
5f15 ff        rst     38h
5f16 84        add     a,h
5f17 00        nop     
5f18 f0        ret     p

5f19 00        nop     
5f1a 1e92      ld      e,92h
5f1c 04        inc     b
5f1d 02        ld      (bc),a
5f1e 92        sub     d
5f1f 04        inc     b
5f20 02        ld      (bc),a
5f21 07        rlca    
5f22 ff        rst     38h
5f23 ff        rst     38h
5f24 84        add     a,h
5f25 00        nop     
5f26 f0        ret     p

5f27 49        ld      c,c
5f28 04        inc     b
5f29 94        sub     h
5f2a 08        ex      af,af'
5f2b 1007      djnz    5f34h
5f2d ff        rst     38h
5f2e ff        rst     38h
5f2f 84        add     a,h
5f30 00        nop     
5f31 f0        ret     p

5f32 49        ld      c,c
5f33 04        inc     b
5f34 80        add     a,b
5f35 0c        inc     c
5f36 00        nop     
5f37 96        sub     (hl)
5f38 08        ex      af,af'
5f39 1094      djnz    5ecfh
5f3b 0a        ld      a,(bc)
5f3c 0e07      ld      c,07h
5f3e ff        rst     38h
5f3f ff        rst     38h
5f40 84        add     a,h
5f41 00        nop     
5f42 f0        ret     p

5f43 00        nop     
5f44 1e92      ld      e,92h
5f46 04        inc     b
5f47 02        ld      (bc),a
5f48 92        sub     d
5f49 04        inc     b
5f4a 02        ld      (bc),a
5f4b 07        rlca    
5f4c ff        rst     38h
5f4d ff        rst     38h
5f4e 84        add     a,h
5f4f 00        nop     
5f50 f0        ret     p

5f51 49        ld      c,c
5f52 04        inc     b
5f53 92        sub     d
5f54 08        ex      af,af'
5f55 1c        inc     e
5f56 07        rlca    
5f57 ff        rst     38h
5f58 ff        rst     38h
5f59 84        add     a,h
5f5a 00        nop     
5f5b f0        ret     p

5f5c 00        nop     
5f5d 1e92      ld      e,92h
5f5f 04        inc     b
5f60 02        ld      (bc),a
5f61 92        sub     d
5f62 04        inc     b
5f63 02        ld      (bc),a
5f64 07        rlca    
5f65 ff        rst     38h
5f66 ff        rst     38h
5f67 84        add     a,h
5f68 00        nop     
5f69 f0        ret     p

5f6a 49        ld      c,c
5f6b 04        inc     b
5f6c 92        sub     d
5f6d 08        ex      af,af'
5f6e 04        inc     b
5f6f 92        sub     d
5f70 08        ex      af,af'
5f71 1007      djnz    5f7ah
5f73 ff        rst     38h
5f74 ff        rst     38h
5f75 84        add     a,h
5f76 00        nop     
5f77 f0        ret     p

5f78 00        nop     
5f79 1e92      ld      e,92h
5f7b 04        inc     b
5f7c 02        ld      (bc),a
5f7d 92        sub     d
5f7e 04        inc     b
5f7f 02        ld      (bc),a
5f80 07        rlca    
5f81 ff        rst     38h
5f82 ff        rst     38h
5f83 84        add     a,h
5f84 00        nop     
5f85 f0        ret     p

5f86 49        ld      c,c
5f87 04        inc     b
5f88 92        sub     d
5f89 0c        inc     c
5f8a 1807      jr      5f93h
5f8c ff        rst     38h
5f8d ff        rst     38h
5f8e 84        add     a,h
5f8f 00        nop     
5f90 f0        ret     p

5f91 00        nop     
5f92 1e92      ld      e,92h
5f94 04        inc     b
5f95 02        ld      (bc),a
5f96 92        sub     d
5f97 04        inc     b
5f98 02        ld      (bc),a
5f99 07        rlca    
5f9a ff        rst     38h
5f9b ff        rst     38h
5f9c 84        add     a,h
5f9d 00        nop     
5f9e f0        ret     p

5f9f 49        ld      c,c
5fa0 04        inc     b
5fa1 92        sub     d
5fa2 08        ex      af,af'
5fa3 04        inc     b
5fa4 92        sub     d
5fa5 08        ex      af,af'
5fa6 04        inc     b
5fa7 07        rlca    
5fa8 ff        rst     38h
5fa9 ff        rst     38h
5faa 84        add     a,h
5fab 00        nop     
5fac f0        ret     p

5fad 49        ld      c,c
5fae 04        inc     b
5faf 94        sub     h
5fb0 0c        inc     c
5fb1 24        inc     h
5fb2 04        inc     b
5fb3 07        rlca    
5fb4 ff        rst     38h
5fb5 ff        rst     38h
5fb6 84        add     a,h
5fb7 00        nop     
5fb8 f0        ret     p

5fb9 49        ld      c,c
5fba 04        inc     b
5fbb 08        ex      af,af'
5fbc 0e09      ld      c,09h
5fbe 018018    ld      bc,1880h
5fc1 00        nop     
5fc2 99        sbc     a,c
5fc3 08        ex      af,af'
5fc4 2899      jr      z,5f5fh
5fc6 0a        ld      a,(bc)
5fc7 0e07      ld      c,07h
5fc9 ff        rst     38h
5fca ff        rst     38h
5fcb 84        add     a,h
5fcc 00        nop     
5fcd f0        ret     p

5fce 00        nop     
5fcf 1e08      ld      e,08h
5fd1 0c        inc     c
5fd2 80        add     a,b
5fd3 60        ld      h,b
5fd4 0c        inc     c
5fd5 96        sub     (hl)
5fd6 04        inc     b
5fd7 14        inc     d
5fd8 94        sub     h
5fd9 04        inc     b
5fda 14        inc     d
5fdb 92        sub     d
5fdc 04        inc     b
5fdd 08        ex      af,af'
5fde 07        rlca    
5fdf ff        rst     38h
5fe0 ff        rst     38h
5fe1 84        add     a,h
5fe2 00        nop     
5fe3 f0        ret     p

5fe4 49        ld      c,c
5fe5 04        inc     b
5fe6 92        sub     d
5fe7 03        inc     bc
5fe8 05        dec     b
5fe9 92        sub     d
5fea 03        inc     bc
5feb 05        dec     b
5fec 92        sub     d
5fed 03        inc     bc
5fee 05        dec     b
5fef 07        rlca    
5ff0 ff        rst     38h
5ff1 ff        rst     38h
5ff2 84        add     a,h
5ff3 00        nop     
5ff4 f0        ret     p

5ff5 00        nop     
5ff6 1e80      ld      e,80h
5ff8 0c        inc     c
5ff9 00        nop     
5ffa 96        sub     (hl)
5ffb 04        inc     b
5ffc 02        ld      (bc),a
5ffd 96        sub     (hl)
5ffe 04        inc     b
5fff 02        ld      (bc),a
6000 07        rlca    
6001 ff        rst     38h
6002 ff        rst     38h
6003 84        add     a,h
6004 00        nop     
6005 f0        ret     p

6006 49        ld      c,c
6007 04        inc     b
6008 96        sub     (hl)
6009 08        ex      af,af'
600a 04        inc     b
600b 07        rlca    
600c ff        rst     38h
600d ff        rst     38h
600e 84        add     a,h
600f 00        nop     
6010 f0        ret     p

6011 00        nop     
6012 1e96      ld      e,96h
6014 04        inc     b
6015 02        ld      (bc),a
6016 96        sub     (hl)
6017 04        inc     b
6018 02        ld      (bc),a
6019 07        rlca    
601a ff        rst     38h
601b ff        rst     38h
601c 84        add     a,h
601d 00        nop     
601e f0        ret     p

601f 49        ld      c,c
6020 04        inc     b
6021 98        sbc     a,b
6022 08        ex      af,af'
6023 2807      jr      z,602ch
6025 ff        rst     38h
6026 ff        rst     38h
6027 84        add     a,h
6028 00        nop     
6029 f0        ret     p

602a 49        ld      c,c
602b 04        inc     b
602c 08        ex      af,af'
602d 0e80      ld      c,80h
602f 1800      jr      6031h
6031 99        sbc     a,c
6032 08        ex      af,af'
6033 2899      jr      z,5fceh
6035 0a        ld      a,(bc)
6036 0e08      ld      c,08h
6038 0d        dec     c
6039 80        add     a,b
603a 60        ld      h,b
603b 0c        inc     c
603c 96        sub     (hl)
603d 08        ex      af,af'
603e 1094      djnz    5fd4h
6040 08        ex      af,af'
6041 1007      djnz    604ah
6043 ff        rst     38h
6044 ff        rst     38h
6045 84        add     a,h
6046 00        nop     
6047 f0        ret     p

6048 00        nop     
6049 1e92      ld      e,92h
604b 04        inc     b
604c 02        ld      (bc),a
604d 92        sub     d
604e 04        inc     b
604f 02        ld      (bc),a
6050 07        rlca    
6051 ff        rst     38h
6052 ff        rst     38h
6053 84        add     a,h
6054 00        nop     
6055 f0        ret     p

6056 49        ld      c,c
6057 04        inc     b
6058 92        sub     d
6059 08        ex      af,af'
605a 1007      djnz    6063h
605c ff        rst     38h
605d ff        rst     38h
605e 84        add     a,h
605f 00        nop     
6060 f0        ret     p

6061 00        nop     
6062 1e80      ld      e,80h
6064 0c        inc     c
6065 00        nop     
6066 94        sub     h
6067 04        inc     b
6068 02        ld      (bc),a
6069 94        sub     h
606a 04        inc     b
606b 02        ld      (bc),a
606c 07        rlca    
606d ff        rst     38h
606e ff        rst     38h
606f 84        add     a,h
6070 00        nop     
6071 f0        ret     p

6072 49        ld      c,c
6073 04        inc     b
6074 96        sub     (hl)
6075 0606      ld      b,06h
6077 96        sub     (hl)
6078 0606      ld      b,06h
607a 07        rlca    
607b ff        rst     38h
607c ff        rst     38h
607d 84        add     a,h
607e 00        nop     
607f f0        ret     p

6080 00        nop     
6081 1e80      ld      e,80h
6083 0c        inc     c
6084 00        nop     
6085 94        sub     h
6086 04        inc     b
6087 02        ld      (bc),a
6088 94        sub     h
6089 04        inc     b
608a 02        ld      (bc),a
608b 07        rlca    
608c ff        rst     38h
608d ff        rst     38h
608e 84        add     a,h
608f 00        nop     
6090 f0        ret     p

6091 49        ld      c,c
6092 04        inc     b
6093 98        sbc     a,b
6094 08        ex      af,af'
6095 1004      djnz    609bh
6097 1880      jr      6019h
6099 1800      jr      609bh
609b 80        add     a,b
609c 1000      djnz    609eh
609e 80        add     a,b
609f c0        ret     nz

60a0 c0        ret     nz

60a1 80        add     a,b
60a2 c0        ret     nz

60a3 c0        ret     nz

60a4 80        add     a,b
60a5 c0        ret     nz

60a6 c0        ret     nz

60a7 80        add     a,b
60a8 60        ld      h,b
60a9 00        nop     
60aa 02        ld      (bc),a
60ab 34        inc     (hl)
60ac 00        nop     
60ad 0c        inc     c
60ae 1807      jr      60b7h
60b0 ff        rst     38h
60b1 ff        rst     38h
60b2 37        scf     
60b3 01a000    ld      bc,00a0h
60b6 04        inc     b
60b7 08        ex      af,af'
60b8 05        dec     b
60b9 09        add     hl,bc
60ba 0c        inc     c
60bb 03        inc     bc
60bc 010056    ld      bc,5600h
60bf 02        ld      (bc),a
60c0 84        add     a,h
60c1 00        nop     
60c2 0c        inc     c
60c3 1807      jr      60cch
60c5 ff        rst     38h
60c6 ff        rst     38h
60c7 66        ld      h,(hl)
60c8 00        nop     
60c9 e0        ret     po

60ca 00        nop     
60cb 04        inc     b
60cc 08        ex      af,af'
60cd 0603      ld      b,03h
60cf 01cf55    ld      bc,55cfh
60d2 02        ld      (bc),a
60d3 1f        rra     
60d4 00        nop     
60d5 0c        inc     c
60d6 1807      jr      60dfh
60d8 ff        rst     38h
60d9 ff        rst     38h
60da 84        add     a,h
60db 00        nop     
60dc f0        ret     p

60dd 49        ld      c,c
60de 04        inc     b
60df 08        ex      af,af'
60e0 07        rlca    
60e1 09        add     hl,bc
60e2 0e0d      ld      c,0dh
60e4 f40301    call    p,0103h
60e7 56        ld      d,(hl)
60e8 5a        ld      e,d
60e9 0d        dec     c
60ea 0c        inc     c
60eb 80        add     a,b
60ec 1800      jr      60eeh
60ee 019e60    ld      bc,609eh
60f1 1802      jr      60f5h
60f3 93        sub     e
60f4 00        nop     
60f5 0c        inc     c
60f6 24        inc     h
60f7 08        ex      af,af'
60f8 0f        rrca    
60f9 07        rlca    
60fa ff        rst     38h
60fb ff        rst     38h
60fc 0100ff    ld      bc,0ff00h
60ff 00        nop     
6100 110908    ld      de,0809h
6103 8d        adc     a,l
6104 03        inc     bc
6105 018b03    ld      bc,038bh
6108 01021e    ld      bc,1e02h
610b 00        nop     
610c 0c        inc     c
610d 24        inc     h
610e 1c        inc     e
610f 1608      ld      d,08h
6111 0f        rrca    
6112 07        rlca    
6113 ff        rst     38h
6114 ff        rst     38h
6115 1000      djnz    6117h
6117 f0        ret     p

6118 a0        and     b
6119 00        nop     
611a 09        add     hl,bc
611b 09        add     hl,bc
611c 8e        adc     a,(hl)
611d 02        ld      (bc),a
611e 00        nop     
611f 8d        adc     a,l
6120 1600      ld      d,00h
6122 02        ld      (bc),a
6123 93        sub     e
6124 00        nop     
6125 0c        inc     c
6126 24        inc     h
6127 08        ex      af,af'
6128 0f        rrca    
6129 07        rlca    
612a ff        rst     38h
612b ff        rst     38h
612c 0100ff    ld      bc,0ff00h
612f 00        nop     
6130 110908    ld      de,0809h
6133 8d        adc     a,l
6134 0e02      ld      c,02h
6136 8d        adc     a,l
6137 0602      ld      b,02h
6139 02        ld      (bc),a
613a 1e00      ld      e,00h
613c 0c        inc     c
613d 24        inc     h
613e 1c        inc     e
613f 1608      ld      d,08h
6141 0f        rrca    
6142 07        rlca    
6143 ff        rst     38h
6144 ff        rst     38h
6145 1000      djnz    6147h
6147 f0        ret     p

6148 a0        and     b
6149 00        nop     
614a 09        add     hl,bc
614b 09        add     hl,bc
614c 8d        adc     a,l
614d 08        ex      af,af'
614e 00        nop     
614f 02        ld      (bc),a
6150 93        sub     e
6151 00        nop     
6152 0c        inc     c
6153 24        inc     h
6154 08        ex      af,af'
6155 0f        rrca    
6156 07        rlca    
6157 ff        rst     38h
6158 ff        rst     38h
6159 0100ff    ld      bc,0ff00h
615c 00        nop     
615d 110908    ld      de,0809h
6160 8d        adc     a,l
6161 03        inc     bc
6162 018b03    ld      bc,038bh
6165 01021e    ld      bc,1e02h
6168 00        nop     
6169 0c        inc     c
616a 24        inc     h
616b 1c        inc     e
616c 1608      ld      d,08h
616e 0f        rrca    
616f 07        rlca    
6170 ff        rst     38h
6171 ff        rst     38h
6172 1000      djnz    6174h
6174 f0        ret     p

6175 a0        and     b
6176 00        nop     
6177 09        add     hl,bc
6178 09        add     hl,bc
6179 8e        adc     a,(hl)
617a 02        ld      (bc),a
617b 00        nop     
617c 8d        adc     a,l
617d 1600      ld      d,00h
617f 02        ld      (bc),a
6180 93        sub     e
6181 00        nop     
6182 0c        inc     c
6183 24        inc     h
6184 08        ex      af,af'
6185 0f        rrca    
6186 07        rlca    
6187 ff        rst     38h
6188 ff        rst     38h
6189 0100ff    ld      bc,0ff00h
618c 00        nop     
618d 110908    ld      de,0809h
6190 8d        adc     a,l
6191 0e02      ld      c,02h
6193 8d        adc     a,l
6194 0602      ld      b,02h
6196 02        ld      (bc),a
6197 1e00      ld      e,00h
6199 0c        inc     c
619a 24        inc     h
619b 1c        inc     e
619c 1608      ld      d,08h
619e 0f        rrca    
619f 07        rlca    
61a0 ff        rst     38h
61a1 ff        rst     38h
61a2 1000      djnz    61a4h
61a4 f0        ret     p

61a5 a0        and     b
61a6 00        nop     
61a7 09        add     hl,bc
61a8 09        add     hl,bc
61a9 8d        adc     a,l
61aa 1000      djnz    61ach
61ac 8e        adc     a,(hl)
61ad 2020      jr      nz,61cfh
61af 00        nop     
61b0 1880      jr      6132h
61b2 08        ex      af,af'
61b3 00        nop     
61b4 80        add     a,b
61b5 08        ex      af,af'
61b6 00        nop     
61b7 0c        inc     c
61b8 1802      jr      61bch
61ba 5e        ld      e,(hl)
61bb 00        nop     
61bc 07        rlca    
61bd ff        rst     38h
61be ff        rst     38h
61bf 2000      jr      nz,61c1h
61c1 e0        ret     po

61c2 e0        ret     po

61c3 00        nop     
61c4 08        ex      af,af'
61c5 0e09      ld      c,09h
61c7 0c        inc     c
61c8 99        sbc     a,c
61c9 08        ex      af,af'
61ca 00        nop     
61cb 09        add     hl,bc
61cc 09        add     hl,bc
61cd 96        sub     (hl)
61ce 08        ex      af,af'
61cf 00        nop     
61d0 0c        inc     c
61d1 1802      jr      61d5h
61d3 0600      ld      b,00h
61d5 08        ex      af,af'
61d6 0a        ld      a,(bc)
61d7 09        add     hl,bc
61d8 0107ff    ld      bc,0ff07h
61db ff        rst     38h
61dc 3000      jr      nc,61deh
61de d0        ret     nc

61df 0d        dec     c
61e0 00        nop     
61e1 99        sbc     a,c
61e2 1008      djnz    61ech
61e4 0c        inc     c
61e5 1c        inc     e
61e6 02        ld      (bc),a
61e7 0600      ld      b,00h
61e9 08        ex      af,af'
61ea 0b        dec     bc
61eb 09        add     hl,bc
61ec 0e07      ld      c,07h
61ee ff        rst     38h
61ef ff        rst     38h
61f0 3000      jr      nc,61f2h
61f2 d0        ret     nc

61f3 0d        dec     c
61f4 00        nop     
61f5 99        sbc     a,c
61f6 1008      djnz    6200h
61f8 0c        inc     c
61f9 1802      jr      61fdh
61fb 5e        ld      e,(hl)
61fc 00        nop     
61fd 07        rlca    
61fe ff        rst     38h
61ff ff        rst     38h
6200 2000      jr      nz,6202h
6202 e0        ret     po

6203 e0        ret     po

6204 00        nop     
6205 08        ex      af,af'
6206 0e09      ld      c,09h
6208 0c        inc     c
6209 99        sbc     a,c
620a 08        ex      af,af'
620b 00        nop     
620c 09        add     hl,bc
620d 09        add     hl,bc
620e 96        sub     (hl)
620f 08        ex      af,af'
6210 00        nop     
6211 0c        inc     c
6212 1c        inc     e
6213 02        ld      (bc),a
6214 0600      ld      b,00h
6216 08        ex      af,af'
6217 0b        dec     bc
6218 09        add     hl,bc
6219 0e07      ld      c,07h
621b ff        rst     38h
621c ff        rst     38h
621d 3000      jr      nc,621fh
621f d0        ret     nc

6220 0d        dec     c
6221 00        nop     
6222 99        sbc     a,c
6223 1008      djnz    622dh
6225 0c        inc     c
6226 1802      jr      622ah
6228 0600      ld      b,00h
622a 08        ex      af,af'
622b 0a        ld      a,(bc)
622c 09        add     hl,bc
622d 0107ff    ld      bc,0ff07h
6230 ff        rst     38h
6231 3000      jr      nc,6233h
6233 d0        ret     nc

6234 0d        dec     c
6235 00        nop     
6236 99        sbc     a,c
6237 0e02      ld      c,02h
6239 0c        inc     c
623a 1c        inc     e
623b 02        ld      (bc),a
623c 0600      ld      b,00h
623e 08        ex      af,af'
623f 0b        dec     bc
6240 09        add     hl,bc
6241 0e07      ld      c,07h
6243 ff        rst     38h
6244 ff        rst     38h
6245 3000      jr      nc,6247h
6247 d0        ret     nc

6248 0d        dec     c
6249 00        nop     
624a 99        sbc     a,c
624b 2020      jr      nz,626dh
624d 00        nop     
624e 1802      jr      6252h
6250 1f        rra     
6251 00        nop     
6252 0c        inc     c
6253 1808      jr      625dh
6255 0e09      ld      c,09h
6257 02        ld      (bc),a
6258 07        rlca    
6259 ff        rst     38h
625a ff        rst     38h
625b 0100ff    ld      bc,0ff00h
625e 00        nop     
625f 11a003    ld      de,03a0h
6262 01a103    ld      bc,03a1h
6265 01a208    ld      bc,08a2h
6268 00        nop     
6269 a0        and     b
626a 08        ex      af,af'
626b 00        nop     
626c 9d        sbc     a,l
626d 08        ex      af,af'
626e 00        nop     
626f a0        and     b
6270 0e02      ld      c,02h
6272 9d        sbc     a,l
6273 08        ex      af,af'
6274 00        nop     
6275 9b        sbc     a,e
6276 08        ex      af,af'
6277 00        nop     
6278 9b        sbc     a,e
6279 03        inc     bc
627a 019c03    ld      bc,039ch
627d 019d08    ld      bc,089dh
6280 00        nop     
6281 9b        sbc     a,e
6282 08        ex      af,af'
6283 00        nop     
6284 99        sbc     a,c
6285 08        ex      af,af'
6286 00        nop     
6287 9b        sbc     a,e
6288 0e02      ld      c,02h
628a 9d        sbc     a,l
628b 08        ex      af,af'
628c 00        nop     
628d a0        and     b
628e 0c        inc     c
628f 00        nop     
6290 a0        and     b
6291 02        ld      (bc),a
6292 00        nop     
6293 a1        and     c
6294 02        ld      (bc),a
6295 00        nop     
6296 07        rlca    
6297 ff        rst     38h
6298 ff        rst     38h
6299 7f        ld      a,a
629a 00        nop     
629b e0        ret     po

629c 91        sub     c
629d 01134d    ld      bc,4d13h
62a0 167f      ld      d,7fh
62a2 59        ld      e,c
62a3 00        nop     
62a4 a2        and     d
62a5 1030      djnz    62d7h
62a7 00        nop     
62a8 1802      jr      62ach
62aa 1f        rra     
62ab 00        nop     
62ac 0c        inc     c
62ad 0c        inc     c
62ae 08        ex      af,af'
62af 08        ex      af,af'
62b0 09        add     hl,bc
62b1 04        inc     b
62b2 07        rlca    
62b3 ff        rst     38h
62b4 ff        rst     38h
62b5 0100ff    ld      bc,0ff00h
62b8 00        nop     
62b9 11a003    ld      de,03a0h
62bc 01a103    ld      bc,03a1h
62bf 01a208    ld      bc,08a2h
62c2 00        nop     
62c3 a0        and     b
62c4 08        ex      af,af'
62c5 00        nop     
62c6 9d        sbc     a,l
62c7 08        ex      af,af'
62c8 00        nop     
62c9 a0        and     b
62ca 0e02      ld      c,02h
62cc 9d        sbc     a,l
62cd 08        ex      af,af'
62ce 00        nop     
62cf 9b        sbc     a,e
62d0 08        ex      af,af'
62d1 00        nop     
62d2 9b        sbc     a,e
62d3 03        inc     bc
62d4 019c03    ld      bc,039ch
62d7 019d08    ld      bc,089dh
62da 00        nop     
62db 9b        sbc     a,e
62dc 08        ex      af,af'
62dd 00        nop     
62de 99        sbc     a,c
62df 08        ex      af,af'
62e0 00        nop     
62e1 9b        sbc     a,e
62e2 0e02      ld      c,02h
62e4 9d        sbc     a,l
62e5 08        ex      af,af'
62e6 00        nop     
62e7 a0        and     b
62e8 0c        inc     c
62e9 00        nop     
62ea a0        and     b
62eb 02        ld      (bc),a
62ec 00        nop     
62ed a1        and     c
62ee 02        ld      (bc),a
62ef 00        nop     
62f0 07        rlca    
62f1 ff        rst     38h
62f2 ff        rst     38h
62f3 7f        ld      a,a
62f4 00        nop     
62f5 e0        ret     po

62f6 91        sub     c
62f7 01134d    ld      bc,4d13h
62fa 117f4d    ld      de,4d7fh
62fd 00        nop     
62fe a2        and     d
62ff 1030      djnz    6331h
6301 00        nop     
6302 1802      jr      6306h
6304 90        sub     b
6305 00        nop     
6306 0c        inc     c
6307 24        inc     h
6308 07        rlca    
6309 ff        rst     38h
630a ff        rst     38h
630b ff        rst     38h
630c 00        nop     
630d ff        rst     38h
630e 55        ld      d,l
630f 1c        inc     e
6310 08        ex      af,af'
6311 0f        rrca    
6312 09        add     hl,bc
6313 08        ex      af,af'
6314 07        rlca    
6315 ff        rst     38h
6316 ff        rst     38h
6317 ae        xor     (hl)
6318 00        nop     
6319 e0        ret     po

631a ee0e      xor     0eh
631c 88        adc     a,b
631d 03        inc     bc
631e 018903    ld      bc,0389h
6321 018a07    ld      bc,078ah
6324 018a07    ld      bc,078ah
6327 018a07    ld      bc,078ah
632a 018520    ld      bc,2085h
632d 08        ex      af,af'
632e 86        add     a,(hl)
632f 07        rlca    
6330 018607    ld      bc,0786h
6333 018607    ld      bc,0786h
6336 018820    ld      bc,2088h
6339 08        ex      af,af'
633a 8a        adc     a,d
633b 08        ex      af,af'
633c 08        ex      af,af'
633d 08        ex      af,af'
633e 08        ex      af,af'
633f 09        add     hl,bc
6340 05        dec     b
6341 8a        adc     a,d
6342 08        ex      af,af'
6343 08        ex      af,af'
6344 08        ex      af,af'
6345 05        dec     b
6346 09        add     hl,bc
6347 0b        dec     bc
6348 8a        adc     a,d
6349 08        ex      af,af'
634a 08        ex      af,af'
634b 08        ex      af,af'
634c 03        inc     bc
634d 09        add     hl,bc
634e 03        inc     bc
634f 8a        adc     a,d
6350 08        ex      af,af'
6351 08        ex      af,af'
6352 08        ex      af,af'
6353 02        ld      (bc),a
6354 09        add     hl,bc
6355 0d        dec     c
6356 8a        adc     a,d
6357 08        ex      af,af'
6358 08        ex      af,af'
6359 08        ex      af,af'
635a 010900    ld      bc,0009h
635d 8a        adc     a,d
635e 08        ex      af,af'
635f 08        ex      af,af'
6360 00        nop     
6361 1802      jr      6365h
6363 65        ld      h,l
6364 00        nop     
6365 0c        inc     c
6366 1807      jr      636fh
6368 ff        rst     38h
6369 ff        rst     38h
636a 5b        ld      e,e
636b 00        nop     
636c e0        ret     po

636d 00        nop     
636e 0e08      ld      c,08h
6370 0b        dec     bc
6371 09        add     hl,bc
6372 0a        ld      a,(bc)
6373 80        add     a,b
6374 08        ex      af,af'
6375 00        nop     
6376 a2        and     d
6377 1602      ld      d,02h
6379 a4        and     h
637a 2602      ld      h,02h
637c a5        and     l
637d 1602      ld      d,02h
637f a7        and     a
6380 2602      ld      h,02h
6382 a2        and     d
6383 08        ex      af,af'
6384 08        ex      af,af'
6385 08        ex      af,af'
6386 07        rlca    
6387 09        add     hl,bc
6388 05        dec     b
6389 a2        and     d
638a 08        ex      af,af'
638b 08        ex      af,af'
638c 08        ex      af,af'
638d 05        dec     b
638e 09        add     hl,bc
638f 0c        inc     c
6390 a2        and     d
6391 08        ex      af,af'
6392 08        ex      af,af'
6393 08        ex      af,af'
6394 03        inc     bc
6395 09        add     hl,bc
6396 02        ld      (bc),a
6397 a2        and     d
6398 08        ex      af,af'
6399 08        ex      af,af'
639a 08        ex      af,af'
639b 02        ld      (bc),a
639c 09        add     hl,bc
639d 0ea2      ld      c,0a2h
639f 08        ex      af,af'
63a0 08        ex      af,af'
63a1 08        ex      af,af'
63a2 010900    ld      bc,0009h
63a5 a2        and     d
63a6 08        ex      af,af'
63a7 08        ex      af,af'
63a8 00        nop     
63a9 1802      jr      63adh
63ab 65        ld      h,l
63ac 00        nop     
63ad 0c        inc     c
63ae 1807      jr      63b7h
63b0 ff        rst     38h
63b1 ff        rst     38h
63b2 5b        ld      e,e
63b3 00        nop     
63b4 e0        ret     po

63b5 00        nop     
63b6 0e08      ld      c,08h
63b8 0b        dec     bc
63b9 09        add     hl,bc
63ba 0a        ld      a,(bc)
63bb 80        add     a,b
63bc 08        ex      af,af'
63bd 00        nop     
63be 9d        sbc     a,l
63bf 1602      ld      d,02h
63c1 a0        and     b
63c2 2602      ld      h,02h
63c4 a2        and     d
63c5 1602      ld      d,02h
63c7 a4        and     h
63c8 2602      ld      h,02h
63ca 9d        sbc     a,l
63cb 08        ex      af,af'
63cc 08        ex      af,af'
63cd 08        ex      af,af'
63ce 07        rlca    
63cf 09        add     hl,bc
63d0 05        dec     b
63d1 9d        sbc     a,l
63d2 08        ex      af,af'
63d3 08        ex      af,af'
63d4 08        ex      af,af'
63d5 05        dec     b
63d6 09        add     hl,bc
63d7 0c        inc     c
63d8 9d        sbc     a,l
63d9 08        ex      af,af'
63da 08        ex      af,af'
63db 08        ex      af,af'
63dc 03        inc     bc
63dd 09        add     hl,bc
63de 02        ld      (bc),a
63df 9d        sbc     a,l
63e0 08        ex      af,af'
63e1 08        ex      af,af'
63e2 08        ex      af,af'
63e3 02        ld      (bc),a
63e4 09        add     hl,bc
63e5 0e9d      ld      c,9dh
63e7 08        ex      af,af'
63e8 08        ex      af,af'
63e9 08        ex      af,af'
63ea 010900    ld      bc,0009h
63ed 9d        sbc     a,l
63ee 08        ex      af,af'
63ef 08        ex      af,af'
63f0 00        nop     
63f1 1802      jr      63f5h
63f3 65        ld      h,l
63f4 00        nop     
63f5 0c        inc     c
63f6 1807      jr      63ffh
63f8 ff        rst     38h
63f9 ff        rst     38h
63fa 5b        ld      e,e
63fb 00        nop     
63fc e0        ret     po

63fd 00        nop     
63fe 0e08      ld      c,08h
6400 0b        dec     bc
6401 09        add     hl,bc
6402 0a        ld      a,(bc)
6403 80        add     a,b
6404 08        ex      af,af'
6405 00        nop     
6406 99        sbc     a,c
6407 1602      ld      d,02h
6409 9b        sbc     a,e
640a 2602      ld      h,02h
640c 9d        sbc     a,l
640d 1602      ld      d,02h
640f a0        and     b
6410 2602      ld      h,02h
6412 99        sbc     a,c
6413 08        ex      af,af'
6414 08        ex      af,af'
6415 08        ex      af,af'
6416 07        rlca    
6417 09        add     hl,bc
6418 05        dec     b
6419 99        sbc     a,c
641a 08        ex      af,af'
641b 08        ex      af,af'
641c 08        ex      af,af'
641d 05        dec     b
641e 09        add     hl,bc
641f 0c        inc     c
6420 99        sbc     a,c
6421 08        ex      af,af'
6422 08        ex      af,af'
6423 08        ex      af,af'
6424 03        inc     bc
6425 09        add     hl,bc
6426 02        ld      (bc),a
6427 99        sbc     a,c
6428 08        ex      af,af'
6429 08        ex      af,af'
642a 08        ex      af,af'
642b 02        ld      (bc),a
642c 09        add     hl,bc
642d 0e99      ld      c,99h
642f 08        ex      af,af'
6430 08        ex      af,af'
6431 08        ex      af,af'
6432 010900    ld      bc,0009h
6435 99        sbc     a,c
6436 08        ex      af,af'
6437 08        ex      af,af'
6438 00        nop     
6439 1802      jr      643dh
643b 2c        inc     l
643c 00        nop     
643d 0c        inc     c
643e 1808      jr      6448h
6440 0e07      ld      c,07h
6442 ff        rst     38h
6443 ff        rst     38h
6444 2202e0    ld      (0e002h),hl
6447 39        add     hl,sp
6448 07        rlca    
6449 08        ex      af,af'
644a 0e09      ld      c,09h
644c 0c        inc     c
644d 80        add     a,b
644e 08        ex      af,af'
644f 00        nop     
6450 96        sub     (hl)
6451 1602      ld      d,02h
6453 91        sub     c
6454 2602      ld      h,02h
6456 92        sub     d
6457 1602      ld      d,02h
6459 94        sub     h
645a 2602      ld      h,02h
645c 07        rlca    
645d ff        rst     38h
645e ff        rst     38h
645f ae        xor     (hl)
6460 00        nop     
6461 e0        ret     po

6462 d20096    jp      nc,9600h
6465 1050      djnz    64b7h
6467 00        nop     
6468 1802      jr      646ch
646a 4f        ld      c,a
646b 00        nop     
646c 0c        inc     c
646d 0c        inc     c
646e 08        ex      af,af'
646f 0b        dec     bc
6470 09        add     hl,bc
6471 0a        ld      a,(bc)
6472 07        rlca    
6473 72        ld      (hl),d
6474 05        dec     b
6475 24        inc     h
6476 00        nop     
6477 e0        ret     po

6478 d20080    jp      nc,8000h
647b 08        ex      af,af'
647c 00        nop     
647d 80        add     a,b
647e 80        add     a,b
647f 00        nop     
6480 a2        and     d
6481 2050      jr      nz,64d3h
6483 00        nop     
6484 1802      jr      6488h
6486 1f        rra     
6487 00        nop     
6488 0c        inc     c
6489 1808      jr      6493h
648b 08        ex      af,af'
648c 09        add     hl,bc
648d 0b        dec     bc
648e 07        rlca    
648f ff        rst     38h
6490 ff        rst     38h
6491 0100ff    ld      bc,0ff00h
6494 00        nop     
6495 11800c    ld      de,0c80h
6498 00        nop     
6499 a0        and     b
649a 03        inc     bc
649b 01a103    ld      bc,03a1h
649e 01a208    ld      bc,08a2h
64a1 00        nop     
64a2 a0        and     b
64a3 08        ex      af,af'
64a4 00        nop     
64a5 9d        sbc     a,l
64a6 08        ex      af,af'
64a7 00        nop     
64a8 a0        and     b
64a9 0e02      ld      c,02h
64ab 9d        sbc     a,l
64ac 08        ex      af,af'
64ad 00        nop     
64ae 9b        sbc     a,e
64af 08        ex      af,af'
64b0 00        nop     
64b1 9b        sbc     a,e
64b2 03        inc     bc
64b3 019c03    ld      bc,039ch
64b6 019d08    ld      bc,089dh
64b9 00        nop     
64ba 9b        sbc     a,e
64bb 08        ex      af,af'
64bc 00        nop     
64bd 99        sbc     a,c
64be 08        ex      af,af'
64bf 00        nop     
64c0 9b        sbc     a,e
64c1 0e02      ld      c,02h
64c3 9d        sbc     a,l
64c4 08        ex      af,af'
64c5 00        nop     
64c6 a0        and     b
64c7 0c        inc     c
64c8 00        nop     
64c9 a0        and     b
64ca 02        ld      (bc),a
64cb 00        nop     
64cc a1        and     c
64cd 02        ld      (bc),a
64ce 00        nop     
64cf 07        rlca    
64d0 ff        rst     38h
64d1 ff        rst     38h
64d2 7f        ld      a,a
64d3 00        nop     
64d4 e0        ret     po

64d5 91        sub     c
64d6 01134d    ld      bc,4d13h
64d9 167f      ld      d,7fh
64db 59        ld      e,c
64dc 00        nop     
64dd a2        and     d
64de 1030      djnz    6510h
64e0 00        nop     
64e1 1802      jr      64e5h
64e3 1f        rra     
64e4 00        nop     
64e5 0c        inc     c
64e6 0c        inc     c
64e7 08        ex      af,af'
64e8 05        dec     b
64e9 09        add     hl,bc
64ea 0d        dec     c
64eb 07        rlca    
64ec ff        rst     38h
64ed ff        rst     38h
64ee 0100ff    ld      bc,0ff00h
64f1 00        nop     
64f2 11800b    ld      de,0b80h
64f5 00        nop     
64f6 a0        and     b
64f7 03        inc     bc
64f8 01a103    ld      bc,03a1h
64fb 01a208    ld      bc,08a2h
64fe 00        nop     
64ff a0        and     b
6500 08        ex      af,af'
6501 00        nop     
6502 9d        sbc     a,l
6503 08        ex      af,af'
6504 00        nop     
6505 a0        and     b
6506 0e02      ld      c,02h
6508 9d        sbc     a,l
6509 08        ex      af,af'
650a 00        nop     
650b 9b        sbc     a,e
650c 08        ex      af,af'
650d 00        nop     
650e 9b        sbc     a,e
650f 03        inc     bc
6510 019c03    ld      bc,039ch
6513 019d08    ld      bc,089dh
6516 00        nop     
6517 9b        sbc     a,e
6518 08        ex      af,af'
6519 00        nop     
651a 99        sbc     a,c
651b 08        ex      af,af'
651c 00        nop     
651d 9b        sbc     a,e
651e 0e02      ld      c,02h
6520 9d        sbc     a,l
6521 08        ex      af,af'
6522 00        nop     
6523 a0        and     b
6524 0c        inc     c
6525 00        nop     
6526 a0        and     b
6527 02        ld      (bc),a
6528 00        nop     
6529 a1        and     c
652a 02        ld      (bc),a
652b 00        nop     
652c 07        rlca    
652d ff        rst     38h
652e ff        rst     38h
652f 7f        ld      a,a
6530 00        nop     
6531 e0        ret     po

6532 91        sub     c
6533 01134d    ld      bc,4d13h
6536 117f4d    ld      de,4d7fh
6539 00        nop     
653a a2        and     d
653b 1030      djnz    656dh
653d 00        nop     
653e 5c        ld      e,h
653f 7d        ld      a,l
6540 00        nop     
6541 00        nop     
6542 3c        inc     a
6543 7d        ld      a,l
6544 00        nop     
6545 00        nop     
6546 00        nop     
6547 00        nop     
6548 e1        pop     hl
6549 eb        ex      de,hl
654a 5d        ld      e,l
654b 7d        ld      a,l
654c b3        or      e
654d 98        sbc     a,b
654e 00        nop     
654f 00        nop     
6550 00        nop     
6551 00        nop     
6552 cf        rst     08h
6553 ff        rst     38h
6554 e2ebaf    jp      po,0afebh
6557 ff        rst     38h
6558 00        nop     
6559 00        nop     
655a 00        nop     
655b 00        nop     
655c 66        ld      h,(hl)
655d 7b        ld      a,e
655e 00        nop     
655f 00        nop     
6560 46        ld      b,(hl)
6561 7b        ld      a,e
6562 010000    ld      bc,0000h
6565 00        nop     
6566 45        ld      b,l
6567 f7        rst     30h
6568 67        ld      h,a
6569 7b        ld      a,e
656a 25        dec     h
656b f7        rst     30h
656c 010000    ld      bc,0000h
656f 00        nop     
6570 b6        or      (hl)
6571 ff        rst     38h
6572 46        ld      b,(hl)
6573 f7        rst     30h
6574 96        sub     (hl)
6575 ff        rst     38h
6576 010000    ld      bc,0000h
6579 00        nop     
657a 4e        ld      c,(hl)
657b 7b        ld      a,e
657c 00        nop     
657d 00        nop     
657e 2e7b      ld      l,7bh
6580 02        ld      (bc),a
6581 00        nop     
6582 00        nop     
6583 00        nop     
6584 dcf34f    call    c,4ff3h
6587 7b        ld      a,e
6588 bc        cp      h
6589 f3        di      
658a 02        ld      (bc),a
658b 00        nop     
658c 00        nop     
658d 00        nop     
658e 14        inc     d
658f fedd      cp      0ddh
6591 f3        di      
6592 f4fd02    call    p,02fdh
6595 00        nop     
6596 00        nop     
6597 00        nop     
6598 17        rla     
6599 75        ld      (hl),l
659a 00        nop     
659b 00        nop     
659c f7        rst     30h
659d 74        ld      (hl),h
659e 03        inc     bc
659f 00        nop     
65a0 00        nop     
65a1 00        nop     
65a2 17        rla     
65a3 d0        ret     nc

65a4 1875      jr      661bh
65a6 f7        rst     30h
65a7 cf        rst     08h
65a8 03        inc     bc
65a9 00        nop     
65aa 00        nop     
65ab 00        nop     
65ac 58        ld      e,b
65ad ed18      db      0edh, 18h        ; Undocumented 8 T-State NOP
65af d0        ret     nc

65b0 38ed      jr      c,659fh
65b2 03        inc     bc
65b3 00        nop     
65b4 00        nop     
65b5 00        nop     
65b6 f2ff59    jp      p,59ffh
65b9 edd2      db      0edh, 0d2h       ; Undocumented 8 T-State NOP
65bb ff        rst     38h
65bc 03        inc     bc
65bd 00        nop     
65be 00        nop     
65bf 00        nop     
65c0 3d        dec     a
65c1 6f        ld      l,a
65c2 00        nop     
65c3 00        nop     
65c4 1d        dec     e
65c5 6f        ld      l,a
65c6 04        inc     b
65c7 00        nop     
65c8 00        nop     
65c9 00        nop     
65ca 52        ld      d,d
65cb ed3e      db      0edh, 3eh        ; Undocumented 8 T-State NOP
65cd 6f        ld      l,a
65ce 32ed04    ld      (04edh),a
65d1 00        nop     
65d2 00        nop     
65d3 00        nop     
65d4 be        cp      (hl)
65d5 fe53      cp      53h
65d7 ed9e      db      0edh, 9eh        ; Undocumented 8 T-State NOP
65d9 fe04      cp      04h
65db 00        nop     
65dc 00        nop     
65dd 00        nop     
65de 79        ld      a,c
65df 75        ld      (hl),l
65e0 00        nop     
65e1 00        nop     
65e2 59        ld      e,c
65e3 75        ld      (hl),l
65e4 05        dec     b
65e5 00        nop     
65e6 00        nop     
65e7 00        nop     
65e8 04        inc     b
65e9 e3        ex      (sp),hl
65ea 7a        ld      a,d
65eb 75        ld      (hl),l
65ec fd92      sub     d
65ee 05        dec     b
65ef 00        nop     
65f0 00        nop     
65f1 00        nop     
65f2 55        ld      d,l
65f3 fd05      dec     b
65f5 e3        ex      (sp),hl
65f6 35        dec     (hl)
65f7 fd05      dec     b
65f9 00        nop     
65fa 00        nop     
65fb 00        nop     
65fc 85        add     a,l
65fd 6c        ld      l,h
65fe 00        nop     
65ff 00        nop     
6600 65        ld      h,l
6601 00        nop     
6602 0600      ld      b,00h
6604 00        nop     
6605 00        nop     
6606 d2d786    jp      nc,86d7h
6609 6c        ld      l,h
660a b2        or      d
660b d7        rst     10h
660c 0600      ld      b,00h
660e 00        nop     
660f 00        nop     
6610 f4ffd3    call    p,0d3ffh
6613 d7        rst     10h
6614 d4ff06    call    nc,06ffh
6617 00        nop     
6618 00        nop     
6619 00        nop     
661a 41        ld      b,c
661b 6b        ld      l,e
661c 00        nop     
661d 00        nop     
661e 216b07    ld      hl,076bh
6621 00        nop     
6622 00        nop     
6623 00        nop     
6624 67        ld      h,a
6625 d642      sub     42h
6627 6b        ld      l,e
6628 47        ld      b,a
6629 d607      sub     07h
662b 00        nop     
662c 00        nop     
662d 00        nop     
662e bf        cp      a
662f fe68      cp      68h
6631 d69f      sub     9fh
6633 fe07      cp      07h
6635 00        nop     
6636 00        nop     
6637 00        nop     
6638 da6a00    jp      c,006ah
663b 00        nop     
663c 76        halt    
663d 3c        inc     a
663e 08        ex      af,af'
663f 00        nop     
6640 00        nop     
6641 00        nop     
6642 8a        adc     a,d
6643 d5        push    de
6644 db6a      in      a,(6ah)
6646 ab        xor     e
6647 89        adc     a,c
6648 08        ex      af,af'
6649 00        nop     
664a 00        nop     
664b 00        nop     
664c e2ff8b    jp      po,8bffh
664f d5        push    de
6650 c2ff08    jp      nz,08ffh
6653 00        nop     
6654 00        nop     
6655 00        nop     
6656 de69      sbc     a,69h
6658 00        nop     
6659 00        nop     
665a be        cp      (hl)
665b 69        ld      l,c
665c 09        add     hl,bc
665d 00        nop     
665e 00        nop     
665f 00        nop     
6660 dad1df    jp      c,0dfd1h
6663 69        ld      l,c
6664 ba        cp      d
6665 d1        pop     de
6666 09        add     hl,bc
6667 00        nop     
6668 00        nop     
6669 00        nop     
666a 87        add     a,a
666b fddbd1    in      a,(0d1h)
666e 67        ld      h,a
666f fd09      add     iy,bc
6671 00        nop     
6672 00        nop     
6673 00        nop     
6674 62        ld      h,d
6675 67        ld      h,a
6676 00        nop     
6677 00        nop     
6678 c4300a    call    nz,0a30h
667b 00        nop     
667c 00        nop     
667d 00        nop     
667e 79        ld      a,c
667f ce63      adc     a,63h
6681 67        ld      h,a
6682 59        ld      e,c
6683 ce0a      adc     a,0ah
6685 00        nop     
6686 00        nop     
6687 00        nop     
6688 40        ld      b,b
6689 ff        rst     38h
668a 7a        ld      a,d
668b ce20      adc     a,20h
668d ff        rst     38h
668e 0a        ld      a,(bc)
668f 00        nop     
6690 00        nop     
6691 00        nop     
6692 0d        dec     c
6693 61        ld      h,c
6694 00        nop     
6695 00        nop     
6696 ed60      in      h,(c)
6698 0b        dec     bc
6699 00        nop     
669a 00        nop     
669b 00        nop     
669c 14        inc     d
669d c20e61    jp      nz,610eh
66a0 f4c10b    call    p,0bc1h
66a3 00        nop     
66a4 00        nop     
66a5 00        nop     
66a6 f7        rst     30h
66a7 ff        rst     38h
66a8 15        dec     d
66a9 c2d7ff    jp      nz,0ffd7h
66ac 0b        dec     bc
66ad 00        nop     
66ae 00        nop     
66af 00        nop     
66b0 fd5e00    ld      e,(iy+00h)
66b3 00        nop     
66b4 5d        ld      e,l
66b5 54        ld      d,h
66b6 0c        inc     c
66b7 00        nop     
66b8 00        nop     
66b9 00        nop     
66ba fb        ei      
66bb ba        cp      d
66bc fe5e      cp      5eh
66be e7        rst     20h
66bf 75        ld      (hl),l
66c0 0c        inc     c
66c1 00        nop     
66c2 00        nop     
66c3 00        nop     
66c4 2f        cpl     
66c5 ff        rst     38h
66c6 fcba0f    call    m,0fbah
66c9 ff        rst     38h
66ca 0c        inc     c
66cb 00        nop     
66cc 00        nop     
66cd 00        nop     
66ce e8        ret     pe

66cf 5a        ld      e,d
66d0 00        nop     
66d1 00        nop     
66d2 c8        ret     z

66d3 5a        ld      e,d
66d4 0d        dec     c
66d5 00        nop     
66d6 00        nop     
66d7 00        nop     
66d8 bc        cp      h
66d9 b5        or      l
66da e9        jp      (hl)
66db 5a        ld      e,d
66dc 9c        sbc     a,h
66dd b5        or      l
66de 0d        dec     c
66df 00        nop     
66e0 00        nop     
66e1 00        nop     
66e2 f6fa      or      0fah
66e4 bd        cp      l
66e5 b5        or      l
66e6 25        dec     h
66e7 cc0d00    call    z,000dh
66ea 00        nop     
66eb 00        nop     
66ec 9a        sbc     a,d
66ed 5a        ld      e,d
66ee 00        nop     
66ef 00        nop     
66f0 3a000e    ld      a,(0e00h)
66f3 00        nop     
66f4 00        nop     
66f5 00        nop     
66f6 f7        rst     30h
66f7 b2        or      d
66f8 9b        sbc     a,e
66f9 5a        ld      e,d
66fa 1e98      ld      e,98h
66fc 0e00      ld      c,00h
66fe 00        nop     
66ff 00        nop     
6700 f2fff8    jp      p,0f8ffh
6703 b2        or      d
6704 d5        push    de
6705 fd0e00    ld      c,00h
6708 00        nop     
6709 00        nop     
670a 0e55      ld      c,55h
670c 00        nop     
670d 00        nop     
670e 113c0f    ld      de,0f3ch
6711 00        nop     
6712 00        nop     
6713 00        nop     
6714 b5        or      l
6715 a4        and     h
6716 0f        rrca    
6717 55        ld      d,l
6718 fb        ei      
6719 85        add     a,l
671a 0f        rrca    
671b 00        nop     
671c 00        nop     
671d 00        nop     
671e 1ef6      ld      e,0f6h
6720 b6        or      (hl)
6721 a4        and     h
6722 f4c70f    call    p,0fc7h
6725 00        nop     
6726 00        nop     
6727 00        nop     
6728 a7        and     a
6729 ff        rst     38h
672a 1f        rra     
672b f687      or      87h
672d ff        rst     38h
672e 0f        rrca    
672f 00        nop     
6730 00        nop     
6731 00        nop     
6732 304e      jr      nc,6782h
6734 00        nop     
6735 00        nop     
6736 dc4c10    call    c,104ch
6739 00        nop     
673a 00        nop     
673b 00        nop     
673c 47        ld      b,a
673d 9b        sbc     a,e
673e 314e27    ld      sp,274eh
6741 9b        sbc     a,e
6742 1000      djnz    6744h
6744 00        nop     
6745 00        nop     
6746 a3        and     e
6747 e648      and     48h
6749 9b        sbc     a,e
674a 4d        ld      c,l
674b ba        cp      d
674c 1000      djnz    674eh
674e 00        nop     
674f 00        nop     
6750 c5        push    bc
6751 ff        rst     38h
6752 a4        and     h
6753 e6a5      and     0a5h
6755 ff        rst     38h
6756 1000      djnz    6758h
6758 00        nop     
6759 00        nop     
675a 2d        dec     l
675b 44        ld      b,h
675c 00        nop     
675d 00        nop     
675e 0d        dec     c
675f 44        ld      b,h
6760 110000    ld      de,0000h
6763 00        nop     
6764 f5        push    af
6765 87        add     a,a
6766 2e44      ld      l,44h
6768 d5        push    de
6769 87        add     a,a
676a 110000    ld      de,0000h
676d 00        nop     
676e 12        ld      (de),a
676f caf687    jp      z,87f6h
6772 f2c911    jp      p,11c9h
6775 00        nop     
6776 00        nop     
6777 00        nop     
6778 39        add     hl,sp
6779 ff        rst     38h
677a 13        inc     de
677b ca19ff    jp      z,0ff19h
677e 110000    ld      de,0000h
6781 00        nop     
6782 de40      sbc     a,40h
6784 00        nop     
6785 00        nop     
6786 be        cp      (hl)
6787 40        ld      b,b
6788 12        ld      (de),a
6789 00        nop     
678a 00        nop     
678b 00        nop     
678c 60        ld      h,b
678d 81        add     a,c
678e df        rst     18h
678f 40        ld      b,b
6790 f8        ret     m

6791 65        ld      h,l
6792 12        ld      (de),a
6793 00        nop     
6794 00        nop     
6795 00        nop     
6796 b7        or      a
6797 c0        ret     nz

6798 61        ld      h,c
6799 81        add     a,c
679a 60        ld      h,b
679b 81        add     a,c
679c 12        ld      (de),a
679d 00        nop     
679e 00        nop     
679f 00        nop     
67a0 c4ffb8    call    nz,0b8ffh
67a3 c0        ret     nz

67a4 a4        and     h
67a5 ff        rst     38h
67a6 12        ld      (de),a
67a7 00        nop     
67a8 00        nop     
67a9 00        nop     
67aa 97        sub     a
67ab 3e00      ld      a,00h
67ad 00        nop     
67ae 77        ld      (hl),a
67af 3e13      ld      a,13h
67b1 00        nop     
67b2 00        nop     
67b3 00        nop     
67b4 2b        dec     hl
67b5 7d        ld      a,l
67b6 98        sbc     a,b
67b7 3e0b      ld      a,0bh
67b9 7d        ld      a,l
67ba 13        inc     de
67bb 00        nop     
67bc 00        nop     
67bd 00        nop     
67be e5        push    hl
67bf ba        cp      d
67c0 2c        inc     l
67c1 7d        ld      a,l
67c2 c5        push    bc
67c3 ba        cp      d
67c4 13        inc     de
67c5 00        nop     
67c6 00        nop     
67c7 00        nop     
67c8 9d        sbc     a,l
67c9 f6e6      or      0e6h
67cb ba        cp      d
67cc 17        rla     
67cd bb        cp      e
67ce 13        inc     de
67cf 00        nop     
67d0 00        nop     
67d1 00        nop     
67d2 bd        cp      l
67d3 fe9e      cp      9eh
67d5 f69d      or      9dh
67d7 fe13      cp      13h
67d9 00        nop     
67da 00        nop     
67db 00        nop     
67dc 34        inc     (hl)
67dd 3b        dec     sp
67de 00        nop     
67df 00        nop     
67e0 14        inc     d
67e1 3b        dec     sp
67e2 14        inc     d
67e3 00        nop     
67e4 00        nop     
67e5 00        nop     
67e6 3875      jr      c,685dh
67e8 35        dec     (hl)
67e9 3b        dec     sp
67ea 1875      jr      6861h
67ec 14        inc     d
67ed 00        nop     
67ee 00        nop     
67ef 00        nop     
67f0 f3        di      
67f1 ad        xor     l
67f2 39        add     hl,sp
67f3 75        ld      (hl),l
67f4 d3ad      out     (0adh),a
67f6 14        inc     d
67f7 00        nop     
67f8 00        nop     
67f9 00        nop     
67fa 44        ld      b,h
67fb e6f4      and     0f4h
67fd ad        xor     l
67fe 24        inc     h
67ff e614      and     14h
6801 00        nop     
6802 00        nop     
6803 00        nop     
6804 eeff      xor     0ffh
6806 45        ld      b,l
6807 e6ce      and     0ceh
6809 ff        rst     38h
680a 14        inc     d
680b 00        nop     
680c 00        nop     
680d 00        nop     
680e e43700    call    po,0037h
6811 00        nop     
6812 03        inc     bc
6813 011500    ld      bc,0015h
6816 00        nop     
6817 00        nop     
6818 09        add     hl,bc
6819 6c        ld      l,h
681a e5        push    hl
681b 37        scf     
681c e9        jp      (hl)
681d 6b        ld      l,e
681e 15        dec     d
681f 00        nop     
6820 00        nop     
6821 00        nop     
6822 29        add     hl,hl
6823 a0        and     b
6824 0a        ld      a,(bc)
6825 6c        ld      l,h
6826 09        add     hl,bc
6827 a0        and     b
6828 15        dec     d
6829 00        nop     
682a 00        nop     
682b 00        nop     
682c 0a        ld      a,(bc)
682d d42aa0    call    nc,0a02ah
6830 ead315    jp      pe,15d3h
6833 00        nop     
6834 00        nop     
6835 00        nop     
6836 feff      cp      0ffh
6838 0b        dec     bc
6839 d4deff    call    nc,0ffdeh
683c 15        dec     d
683d 00        nop     
683e 00        nop     
683f 00        nop     
6840 87        add     a,a
6841 33        inc     sp
6842 00        nop     
6843 00        nop     
6844 67        ld      h,a
6845 33        inc     sp
6846 1600      ld      d,00h
6848 00        nop     
6849 00        nop     
684a 4e        ld      c,(hl)
684b 66        ld      h,(hl)
684c 88        adc     a,b
684d 33        inc     sp
684e 2e66      ld      l,66h
6850 1600      ld      d,00h
6852 00        nop     
6853 00        nop     
6854 90        sub     b
6855 98        sbc     a,b
6856 4f        ld      c,a
6857 66        ld      h,(hl)
6858 4e        ld      c,(hl)
6859 80        add     a,b
685a 1600      ld      d,00h
685c 00        nop     
685d 00        nop     
685e 1a        ld      a,(de)
685f c9        ret     

6860 91        sub     c
6861 98        sbc     a,b
6862 c3aa16    jp      16aah
6865 00        nop     
6866 00        nop     
6867 00        nop     
6868 c1        pop     bc
6869 f8        ret     m

686a 1b        dec     de
686b c9        ret     

686c a1        and     c
686d f8        ret     m

686e 1600      ld      d,00h
6870 00        nop     
6871 00        nop     
6872 99        sbc     a,c
6873 2f        cpl     
6874 00        nop     
6875 00        nop     
6876 79        ld      a,c
6877 2f        cpl     
6878 17        rla     
6879 00        nop     
687a 00        nop     
687b 00        nop     
687c 165e      ld      d,5eh
687e 9a        sbc     a,d
687f 2f        cpl     
6880 f65d      or      5dh
6882 17        rla     
6883 00        nop     
6884 00        nop     
6885 00        nop     
6886 c28b17    jp      nz,178bh
6889 5e        ld      e,(hl)
688a a2        and     d
688b 8b        adc     a,e
688c 17        rla     
688d 00        nop     
688e 00        nop     
688f 00        nop     
6890 6d        ld      l,l
6891 b8        cp      b
6892 c38b4d    jp      4d8bh
6895 b8        cp      b
6896 17        rla     
6897 00        nop     
6898 00        nop     
6899 00        nop     
689a b8        cp      b
689b e46eb8    call    po,0b86eh
689e cdb817    call    17b8h
68a1 00        nop     
68a2 00        nop     
68a3 00        nop     
68a4 f5        push    af
68a5 ff        rst     38h
68a6 b9        cp      c
68a7 e47cf0    call    po,0f07ch
68aa 17        rla     
68ab 00        nop     
68ac 00        nop     
68ad 00        nop     
68ae 64        ld      h,h
68af 2c        inc     l
68b0 00        nop     
68b1 00        nop     
68b2 44        ld      b,h
68b3 2c        inc     l
68b4 1800      jr      68b6h
68b6 00        nop     
68b7 00        nop     
68b8 5b        ld      e,e
68b9 58        ld      e,b
68ba 65        ld      h,l
68bb 2c        inc     l
68bc 3b        dec     sp
68bd 58        ld      e,b
68be 1800      jr      68c0h
68c0 00        nop     
68c1 00        nop     
68c2 61        ld      h,c
68c3 83        add     a,e
68c4 5c        ld      e,h
68c5 58        ld      e,b
68c6 41        ld      b,c
68c7 83        add     a,e
68c8 1800      jr      68cah
68ca 00        nop     
68cb 00        nop     
68cc 29        add     hl,hl
68cd ae        xor     (hl)
68ce 62        ld      h,d
68cf 83        add     a,e
68d0 09        add     hl,bc
68d1 ae        xor     (hl)
68d2 1800      jr      68d4h
68d4 00        nop     
68d5 00        nop     
68d6 cad82a    jp      z,2ad8h
68d9 ae        xor     (hl)
68da aa        xor     d
68db d8        ret     c

68dc 1800      jr      68deh
68de 00        nop     
68df 00        nop     
68e0 c3ffcb    jp      0cbffh
68e3 d8        ret     c

68e4 a3        and     e
68e5 ff        rst     38h
68e6 1800      jr      68e8h
68e8 00        nop     
68e9 00        nop     
68ea fb        ei      
68eb 29        add     hl,hl
68ec 00        nop     
68ed 00        nop     
68ee db29      in      a,(29h)
68f0 19        add     hl,de
68f1 00        nop     
68f2 00        nop     
68f3 00        nop     
68f4 97        sub     a
68f5 53        ld      d,e
68f6 fc2977    call    m,7729h
68f9 53        ld      d,e
68fa 19        add     hl,de
68fb 00        nop     
68fc 00        nop     
68fd 00        nop     
68fe ec7b98    call    pe,987bh
6901 53        ld      d,e
6902 cc7b19    call    z,197bh
6905 00        nop     
6906 00        nop     
6907 00        nop     
6908 faa3ed    jp      m,0eda3h
690b 7b        ld      a,e
690c daa319    jp      c,19a3h
690f 00        nop     
6910 00        nop     
6911 00        nop     
6912 eccbfb    call    pe,0fbcbh
6915 a3        and     e
6916 cccb19    call    z,19cbh
6919 00        nop     
691a 00        nop     
691b 00        nop     
691c c8        ret     z

691d f2edcb    jp      p,0cbedh
6920 a8        xor     b
6921 f21900    jp      p,0019h
6924 00        nop     
6925 00        nop     
6926 ba        cp      d
6927 ff        rst     38h
6928 c9        ret     

6929 f29aff    jp      p,0ff9ah
692c 19        add     hl,de
692d 00        nop     
692e 00        nop     
692f 00        nop     
6930 35        dec     (hl)
6931 2600      ld      h,00h
6933 00        nop     
6934 ff        rst     38h
6935 ff        rst     38h
6936 1a        ld      a,(de)
6937 00        nop     
6938 00        nop     
6939 00        nop     
693a 2e4c      ld      l,4ch
693c 3626      ld      (hl),26h
693e 0e4c      ld      c,4ch
6940 1a        ld      a,(de)
6941 00        nop     
6942 00        nop     
6943 00        nop     
6944 1c        inc     e
6945 72        ld      (hl),d
6946 2f        cpl     
6947 4c        ld      c,h
6948 fc711a    call    m,1a71h
694b 00        nop     
694c 00        nop     
694d 00        nop     
694e ec971d    call    pe,1d97h
6951 72        ld      (hl),d
6952 cc971a    call    z,1a97h
6955 00        nop     
6956 00        nop     
6957 00        nop     
6958 55        ld      d,l
6959 bd        cp      l
695a ed97      db      0edh, 97h        ; Undocumented 8 T-State NOP
695c a8        xor     b
695d ad        xor     l
695e 1a        ld      a,(de)
695f 00        nop     
6960 00        nop     
6961 00        nop     
6962 eee1      xor     0e1h
6964 56        ld      d,(hl)
6965 bd        cp      l
6966 cee1      adc     a,0e1h
6968 1a        ld      a,(de)
6969 00        nop     
696a 00        nop     
696b 00        nop     
696c 2affef    ld      hl,(0efffh)
696f e1        pop     hl
6970 0a        ld      a,(bc)
6971 ff        rst     38h
6972 1a        ld      a,(de)
6973 00        nop     
6974 00        nop     
6975 00        nop     
6976 6e        ld      l,(hl)
6977 24        inc     h
6978 00        nop     
6979 00        nop     
697a 4e        ld      c,(hl)
697b 24        inc     h
697c 1b        dec     de
697d 00        nop     
697e 00        nop     
697f 00        nop     
6980 60        ld      h,b
6981 47        ld      b,a
6982 6f        ld      l,a
6983 24        inc     h
6984 40        ld      b,b
6985 47        ld      b,a
6986 1b        dec     de
6987 00        nop     
6988 00        nop     
6989 00        nop     
698a 3868      jr      c,69f4h
698c 61        ld      h,c
698d 47        ld      b,a
698e 1868      jr      69f8h
6990 1b        dec     de
6991 00        nop     
6992 00        nop     
6993 00        nop     
6994 2a8b39    ld      hl,(398bh)
6997 68        ld      l,b
6998 0a        ld      a,(bc)
6999 8b        adc     a,e
699a 1b        dec     de
699b 00        nop     
699c 00        nop     
699d 00        nop     
699e 91        sub     c
699f ad        xor     l
69a0 2b        dec     hl
69a1 8b        adc     a,e
69a2 71        ld      (hl),c
69a3 ad        xor     l
69a4 1b        dec     de
69a5 00        nop     
69a6 00        nop     
69a7 00        nop     
69a8 5f        ld      e,a
69a9 cf        rst     08h
69aa 92        sub     d
69ab ad        xor     l
69ac 5f        ld      e,a
69ad ce1b      adc     a,1bh
69af 00        nop     
69b0 00        nop     
69b1 00        nop     
69b2 5c        ld      e,h
69b3 f0        ret     p

69b4 60        ld      h,b
69b5 cf        rst     08h
69b6 3c        inc     a
69b7 f0        ret     p

69b8 1b        dec     de
69b9 00        nop     
69ba 00        nop     
69bb 00        nop     
69bc be        cp      (hl)
69bd fe5d      cp      5dh
69bf f0        ret     p

69c0 9e        sbc     a,(hl)
69c1 fe1b      cp      1bh
69c3 00        nop     
69c4 00        nop     
69c5 00        nop     
69c6 cf        rst     08h
69c7 2000      jr      nz,69c9h
69c9 00        nop     
69ca af        xor     a
69cb 201c      jr      nz,69e9h
69cd 00        nop     
69ce 00        nop     
69cf 00        nop     
69d0 46        ld      b,(hl)
69d1 40        ld      b,b
69d2 d0        ret     nc

69d3 2026      jr      nz,69fbh
69d5 40        ld      b,b
69d6 1c        inc     e
69d7 00        nop     
69d8 00        nop     
69d9 00        nop     
69da 5d        ld      e,l
69db 5e        ld      e,(hl)
69dc 47        ld      b,a
69dd 40        ld      b,b
69de 3d        dec     a
69df 5e        ld      e,(hl)
69e0 1c        inc     e
69e1 00        nop     
69e2 00        nop     
69e3 00        nop     
69e4 0f        rrca    
69e5 7b        ld      a,e
69e6 5e        ld      e,(hl)
69e7 5e        ld      e,(hl)
69e8 65        ld      h,l
69e9 79        ld      a,c
69ea 1c        inc     e
69eb 00        nop     
69ec 00        nop     
69ed 00        nop     
69ee 87        add     a,a
69ef 97        sub     a
69f0 107b      djnz    6a6dh
69f2 67        ld      h,a
69f3 97        sub     a
69f4 1c        inc     e
69f5 00        nop     
69f6 00        nop     
69f7 00        nop     
69f8 d6b3      sub     0b3h
69fa 88        adc     a,b
69fb 97        sub     a
69fc b6        or      (hl)
69fd b3        or      e
69fe 1c        inc     e
69ff 00        nop     
6a00 00        nop     
6a01 00        nop     
6a02 12        ld      (de),a
6a03 d0        ret     nc

6a04 d7        rst     10h
6a05 b3        or      e
6a06 f2cf1c    jp      p,1ccfh
6a09 00        nop     
6a0a 00        nop     
6a0b 00        nop     
6a0c 23        inc     hl
6a0d ec13d0    call    pe,0d013h
6a10 03        inc     bc
6a11 ec1c00    call    pe,001ch
6a14 00        nop     
6a15 00        nop     
6a16 49        ld      c,c
6a17 ff        rst     38h
6a18 24        inc     h
6a19 ec29ff    call    pe,0ff29h
6a1c 1c        inc     e
6a1d 00        nop     
6a1e 00        nop     
6a1f 00        nop     
6a20 d9        exx     
6a21 1b        dec     de
6a22 00        nop     
6a23 00        nop     
6a24 b9        cp      c
6a25 1b        dec     de
6a26 1d        dec     e
6a27 00        nop     
6a28 00        nop     
6a29 00        nop     
6a2a 3a37da    ld      a,(0da37h)
6a2d 1b        dec     de
6a2e 1a        ld      a,(de)
6a2f 37        scf     
6a30 1d        dec     e
6a31 00        nop     
6a32 00        nop     
6a33 00        nop     
6a34 a3        and     e
6a35 51        ld      d,c
6a36 3b        dec     sp
6a37 37        scf     
6a38 af        xor     a
6a39 3b        dec     sp
6a3a 1d        dec     e
6a3b 00        nop     
6a3c 00        nop     
6a3d 00        nop     
6a3e 14        inc     d
6a3f 6c        ld      l,h
6a40 a4        and     h
6a41 51        ld      d,c
6a42 f46b1d    call    p,1d6bh
6a45 00        nop     
6a46 00        nop     
6a47 00        nop     
6a48 7c        ld      a,h
6a49 86        add     a,(hl)
6a4a 15        dec     d
6a4b 6c        ld      l,h
6a4c 5c        ld      e,h
6a4d 86        add     a,(hl)
6a4e 1d        dec     e
6a4f 00        nop     
6a50 00        nop     
6a51 00        nop     
6a52 7b        ld      a,e
6a53 a0        and     b
6a54 7d        ld      a,l
6a55 86        add     a,(hl)
6a56 5b        ld      e,e
6a57 a0        and     b
6a58 1d        dec     e
6a59 00        nop     
6a5a 00        nop     
6a5b 00        nop     
6a5c 3d        dec     a
6a5d ba        cp      d
6a5e 7c        ld      a,h
6a5f a0        and     b
6a60 1d        dec     e
6a61 ba        cp      d
6a62 1d        dec     e
6a63 00        nop     
6a64 00        nop     
6a65 00        nop     
6a66 b6        or      (hl)
6a67 d23eba    jp      nc,0ba3eh
6a6a b6        or      (hl)
6a6b d1        pop     de
6a6c 1d        dec     e
6a6d 00        nop     
6a6e 00        nop     
6a6f 00        nop     
6a70 2c        inc     l
6a71 eb        ex      de,hl
6a72 b7        or      a
6a73 d20ceb    jp      nc,0eb0ch
6a76 1d        dec     e
6a77 00        nop     
6a78 00        nop     
6a79 00        nop     
6a7a e1        pop     hl
6a7b ff        rst     38h
6a7c 2d        dec     l
6a7d eb        ex      de,hl
6a7e c1        pop     bc
6a7f ff        rst     38h
6a80 1d        dec     e
6a81 00        nop     
6a82 00        nop     
6a83 00        nop     
6a84 61        ld      h,c
6a85 1800      jr      6a87h
6a87 00        nop     
6a88 41        ld      b,c
6a89 181e      jr      6aa9h
6a8b 00        nop     
6a8c 00        nop     
6a8d 00        nop     
6a8e c0        ret     nz

6a8f 3062      jr      nc,6af3h
6a91 18a0      jr      6a33h
6a93 301e      jr      nc,6ab3h
6a95 00        nop     
6a96 00        nop     
6a97 00        nop     
6a98 be        cp      (hl)
6a99 48        ld      c,b
6a9a c1        pop     bc
6a9b 309e      jr      nc,6a3bh
6a9d 48        ld      c,b
6a9e 1e00      ld      e,00h
6aa0 00        nop     
6aa1 00        nop     
6aa2 a1        and     c
6aa3 60        ld      h,b
6aa4 bf        cp      a
6aa5 48        ld      c,b
6aa6 81        add     a,c
6aa7 60        ld      h,b
6aa8 1e00      ld      e,00h
6aaa 00        nop     
6aab 00        nop     
6aac 15        dec     d
6aad 77        ld      (hl),a
6aae a2        and     d
6aaf 60        ld      h,b
6ab0 f5        push    af
6ab1 76        halt    
6ab2 1e00      ld      e,00h
6ab4 00        nop     
6ab5 00        nop     
6ab6 12        ld      (de),a
6ab7 8d        adc     a,l
6ab8 1677      ld      d,77h
6aba cf        rst     08h
6abb 8b        adc     a,e
6abc 1e00      ld      e,00h
6abe 00        nop     
6abf 00        nop     
6ac0 c7        rst     00h
6ac1 a2        and     d
6ac2 13        inc     de
6ac3 8d        adc     a,l
6ac4 a7        and     a
6ac5 a2        and     d
6ac6 1e00      ld      e,00h
6ac8 00        nop     
6ac9 00        nop     
6aca 2eb7      ld      l,0b7h
6acc c8        ret     z

6acd a2        and     d
6ace 0eb7      ld      c,0b7h
6ad0 1e00      ld      e,00h
6ad2 00        nop     
6ad3 00        nop     
6ad4 8a        adc     a,d
6ad5 cb2f      sra     a
6ad7 b7        or      a
6ad8 6a        ld      l,d
6ad9 cb1e      rr      (hl)
6adb 00        nop     
6adc 00        nop     
6add 00        nop     
6ade c5        push    bc
6adf df        rst     18h
6ae0 8b        adc     a,e
6ae1 cb70      bit     6,b
6ae3 de1e      sbc     a,1eh
6ae5 00        nop     
6ae6 00        nop     
6ae7 00        nop     
6ae8 bf        cp      a
6ae9 f2c6df    jp      p,0dfc6h
6aec 9f        sbc     a,a
6aed f21e00    jp      p,001eh
6af0 00        nop     
6af1 00        nop     
6af2 72        ld      (hl),d
6af3 ff        rst     38h
6af4 c0        ret     nz

6af5 f252ff    jp      p,0ff52h
6af8 1e00      ld      e,00h
6afa 00        nop     
6afb 00        nop     
6afc 4b        ld      c,e
6afd 1000      djnz    6affh
6aff 00        nop     
6b00 2b        dec     hl
6b01 101f      djnz    6b22h
6b03 00        nop     
6b04 00        nop     
6b05 00        nop     
6b06 7f        ld      a,a
6b07 204c      jr      nz,6b55h
6b09 105f      djnz    6b6ah
6b0b 201f      jr      nz,6b2ch
6b0d 00        nop     
6b0e 00        nop     
6b0f 00        nop     
6b10 323080    ld      (8030h),a
6b13 2012      jr      nz,6b27h
6b15 301f      jr      nc,6b36h
6b17 00        nop     
6b18 00        nop     
6b19 00        nop     
6b1a da3f33    jp      c,333fh
6b1d 30ba      jr      nc,6ad9h
6b1f 3f        ccf     
6b20 1f        rra     
6b21 00        nop     
6b22 00        nop     
6b23 00        nop     
6b24 25        dec     h
6b25 4c        ld      c,h
6b26 db3f      in      a,(3fh)
6b28 05        dec     b
6b29 4c        ld      c,h
6b2a 1f        rra     
6b2b 00        nop     
6b2c 00        nop     
6b2d 00        nop     
6b2e 00        nop     
6b2f 00        nop     
6b30 35        dec     (hl)
6b31 2600      ld      h,00h
6b33 00        nop     
6b34 ff        rst     38h
6b35 ff        rst     38h
6b36 1a        ld      a,(de)
6b37 00        nop     
6b38 00        nop     
6b39 00        nop     
6b3a 2e4c      ld      l,4ch
6b3c 3626      ld      (hl),26h
6b3e 0e4c      ld      c,4ch
6b40 1a        ld      a,(de)
6b41 00        nop     
6b42 00        nop     
6b43 00        nop     
6b44 1c        inc     e
6b45 72        ld      (hl),d
6b46 2f        cpl     
6b47 4c        ld      c,h
6b48 fc711a    call    m,1a71h
6b4b 00        nop     
6b4c 00        nop     
6b4d 00        nop     
6b4e ec971d    call    pe,1d97h
6b51 72        ld      (hl),d
6b52 cc971a    call    z,1a97h
6b55 00        nop     
6b56 00        nop     
6b57 00        nop     
6b58 55        ld      d,l
6b59 bd        cp      l
6b5a ed97      db      0edh, 97h        ; Undocumented 8 T-State NOP
6b5c a8        xor     b
6b5d ad        xor     l
6b5e 1a        ld      a,(de)
6b5f 00        nop     
6b60 00        nop     
6b61 00        nop     
6b62 eee1      xor     0e1h
6b64 56        ld      d,(hl)
6b65 bd        cp      l
6b66 cee1      adc     a,0e1h
6b68 1a        ld      a,(de)
6b69 00        nop     
6b6a 00        nop     
6b6b 00        nop     
6b6c 2affef    ld      hl,(0efffh)
6b6f e1        pop     hl
6b70 0a        ld      a,(bc)
6b71 ff        rst     38h
6b72 1a        ld      a,(de)
6b73 00        nop     
6b74 00        nop     
6b75 00        nop     
6b76 6e        ld      l,(hl)
6b77 24        inc     h
6b78 00        nop     
6b79 00        nop     
6b7a 4e        ld      c,(hl)
6b7b 24        inc     h
6b7c 1b        dec     de
6b7d 00        nop     
6b7e 00        nop     
6b7f 00        nop     
6b80 60        ld      h,b
6b81 47        ld      b,a
6b82 6f        ld      l,a
6b83 24        inc     h
6b84 40        ld      b,b
6b85 47        ld      b,a
6b86 1b        dec     de
6b87 00        nop     
6b88 00        nop     
6b89 00        nop     
6b8a 3868      jr      c,6bf4h
6b8c 61        ld      h,c
6b8d 47        ld      b,a
6b8e 1868      jr      6bf8h
6b90 1b        dec     de
6b91 00        nop     
6b92 00        nop     
6b93 00        nop     
6b94 2a8b39    ld      hl,(398bh)
6b97 68        ld      l,b
6b98 0a        ld      a,(bc)
6b99 8b        adc     a,e
6b9a 1b        dec     de
6b9b 00        nop     
6b9c 00        nop     
6b9d 00        nop     
6b9e 91        sub     c
6b9f ad        xor     l
6ba0 2b        dec     hl
6ba1 8b        adc     a,e
6ba2 71        ld      (hl),c
6ba3 ad        xor     l
6ba4 1b        dec     de
6ba5 00        nop     
6ba6 00        nop     
6ba7 00        nop     
6ba8 5f        ld      e,a
6ba9 cf        rst     08h
6baa 92        sub     d
6bab ad        xor     l
6bac 5f        ld      e,a
6bad ce1b      adc     a,1bh
6baf 00        nop     
6bb0 00        nop     
6bb1 00        nop     
6bb2 5c        ld      e,h
6bb3 f0        ret     p

6bb4 60        ld      h,b
6bb5 cf        rst     08h
6bb6 3c        inc     a
6bb7 f0        ret     p

6bb8 1b        dec     de
6bb9 00        nop     
6bba 00        nop     
6bbb 00        nop     
6bbc be        cp      (hl)
6bbd fe5d      cp      5dh
6bbf f0        ret     p

6bc0 9e        sbc     a,(hl)
6bc1 fe1b      cp      1bh
6bc3 00        nop     
6bc4 00        nop     
6bc5 00        nop     
6bc6 cf        rst     08h
6bc7 2000      jr      nz,6bc9h
6bc9 00        nop     
6bca af        xor     a
6bcb 201c      jr      nz,6be9h
6bcd 00        nop     
6bce 00        nop     
6bcf 00        nop     
6bd0 46        ld      b,(hl)
6bd1 40        ld      b,b
6bd2 d0        ret     nc

6bd3 2026      jr      nz,6bfbh
6bd5 40        ld      b,b
6bd6 1c        inc     e
6bd7 00        nop     
6bd8 00        nop     
6bd9 00        nop     
6bda 5d        ld      e,l
6bdb 5e        ld      e,(hl)
6bdc 47        ld      b,a
6bdd 40        ld      b,b
6bde 3d        dec     a
6bdf 5e        ld      e,(hl)
6be0 1c        inc     e
6be1 00        nop     
6be2 00        nop     
6be3 00        nop     
6be4 0f        rrca    
6be5 7b        ld      a,e
6be6 5e        ld      e,(hl)
6be7 5e        ld      e,(hl)
6be8 65        ld      h,l
6be9 79        ld      a,c
6bea 1c        inc     e
6beb 00        nop     
6bec 00        nop     
6bed 00        nop     
6bee 87        add     a,a
6bef 97        sub     a
6bf0 107b      djnz    6c6dh
6bf2 67        ld      h,a
6bf3 97        sub     a
6bf4 1c        inc     e
6bf5 00        nop     
6bf6 00        nop     
6bf7 00        nop     
6bf8 d6b3      sub     0b3h
6bfa 88        adc     a,b
6bfb 97        sub     a
6bfc b6        or      (hl)
6bfd b3        or      e
6bfe 1c        inc     e
6bff 00        nop     
6c00 00        nop     
6c01 00        nop     
6c02 00        nop     
6c03 03        inc     bc
6c04 1014      djnz    6c1ah
6c06 0c        inc     c
6c07 04        inc     b
6c08 43        ld      b,e
6c09 4e        ld      c,(hl)
6c0a 55        ld      d,l
6c0b 4d        ld      c,l
6c0c 09        add     hl,bc
6c0d 00        nop     
6c0e 00        nop     
6c0f 00        nop     
6c10 00        nop     
6c11 1027      djnz    6c3ah
6c13 0c        inc     c
6c14 0a        ld      a,(bc)
6c15 43        ld      b,e
6c16 52        ld      d,d
6c17 4c        ld      c,h
6c18 42        ld      b,d
6c19 55        ld      d,l
6c1a 46        ld      b,(hl)
6c1b 46        ld      b,(hl)
6c1c 5f        ld      e,a
6c1d 4c        ld      c,h
6c1e 47        ld      b,a
6c1f 03        inc     bc
6c20 00        nop     
6c21 00        nop     
6c22 00        nop     
6c23 99        sbc     a,c
6c24 1039      djnz    6c5fh
6c26 0c        inc     c
6c27 09        add     hl,bc
6c28 50        ld      d,b
6c29 41        ld      b,c
6c2a 4e        ld      c,(hl)
6c2b 4e        ld      c,(hl)
6c2c 5f        ld      e,a
6c2d 48        ld      c,b
6c2e 45        ld      b,l
6c2f 4c        ld      c,h
6c30 44        ld      b,h
6c31 a3        and     e
6c32 00        nop     
6c33 00        nop     
6c34 00        nop     
6c35 4f        ld      c,a
6c36 104d      djnz    6c85h
6c38 0c        inc     c
6c39 0b        dec     bc
6c3a 50        ld      d,b
6c3b 4c        ld      c,h
6c3c 49        ld      c,c
6c3d 54        ld      d,h
6c3e 44        ld      b,h
6c3f 4f        ld      c,a
6c40 4f        ld      c,a
6c41 52        ld      d,d
6c42 5f        ld      e,a
6c43 49        ld      c,c
6c44 44        ld      b,h
6c45 a1        and     c
6c46 00        nop     
6c47 00        nop     
6c48 00        nop     
6c49 52        ld      d,d
6c4a 105c      djnz    6ca8h
6c4c 0c        inc     c
6c4d 0657      ld      b,57h
6c4f 41        ld      b,c
6c50 54        ld      d,h
6c51 5f        ld      e,a
6c52 49        ld      c,c
6c53 44        ld      b,h
6c54 a0        and     b
6c55 00        nop     
6c56 00        nop     
6c57 00        nop     
6c58 0b        dec     bc
6c59 106e      djnz    6cc9h
6c5b 0c        inc     c
6c5c 09        add     hl,bc
6c5d 50        ld      d,b
6c5e 49        ld      c,c
6c5f 54        ld      d,h
6c60 54        ld      d,h
6c61 4c        ld      c,h
6c62 45        ld      b,l
6c63 5f        ld      e,a
6c64 49        ld      c,c
6c65 44        ld      b,h
6c66 9a        sbc     a,d
6c67 00        nop     
6c68 00        nop     
6c69 00        nop     
6c6a 47        ld      b,a
6c6b 1081      djnz    6beeh
6c6d 0c        inc     c
6c6e 0a        ld      a,(bc)
6c6f 50        ld      d,b
6c70 45        ld      b,l
6c71 43        ld      b,e
6c72 53        ld      d,e
6c73 48        ld      c,b
6c74 4f        ld      c,a
6c75 54        ld      d,h
6c76 5f        ld      e,a
6c77 49        ld      c,c
6c78 44        ld      b,h
6c79 97        sub     a
6c7a 00        nop     
6c7b 00        nop     
6c7c 00        nop     
6c7d 43        ld      b,e
6c7e 1094      djnz    6c14h
6c80 0c        inc     c
6c81 0a        ld      a,(bc)
6c82 45        ld      b,l
6c83 54        ld      d,h
6c84 46        ld      b,(hl)
6c85 4f        ld      c,a
6c86 52        ld      d,d
6c87 43        ld      b,e
6c88 45        ld      b,l
6c89 5f        ld      e,a
6c8a 49        ld      c,c
6c8b 44        ld      b,h
6c8c 92        sub     d
6c8d 00        nop     
6c8e 00        nop     
6c8f 00        nop     
6c90 4c        ld      c,h
6c91 10a8      djnz    6c3bh
6c93 0c        inc     c
6c94 0b        dec     bc
6c95 4e        ld      c,(hl)
6c96 4f        ld      c,a
6c97 57        ld      d,a
6c98 53        ld      d,e
6c99 50        ld      d,b
6c9a 49        ld      c,c
6c9b 4b        ld      c,e
6c9c 45        ld      b,l
6c9d 5f        ld      e,a
6c9e 49        ld      c,c
6c9f 44        ld      b,h
6ca0 91        sub     c
6ca1 00        nop     
6ca2 00        nop     
6ca3 00        nop     
6ca4 4c        ld      c,h
6ca5 10bb      djnz    6c62h
6ca7 0c        inc     c
6ca8 0a        ld      a,(bc)
6ca9 4e        ld      c,(hl)
6caa 4f        ld      c,a
6cab 57        ld      d,a
6cac 53        ld      d,e
6cad 43        ld      b,e
6cae 52        ld      d,d
6caf 4c        ld      c,h
6cb0 5f        ld      e,a
6cb1 49        ld      c,c
6cb2 44        ld      b,h
6cb3 90        sub     b
6cb4 00        nop     
6cb5 00        nop     
6cb6 00        nop     
6cb7 4f        ld      c,a
6cb8 10d1      djnz    6c8bh
6cba 0c        inc     c
6cbb 0d        dec     c
6cbc 4e        ld      c,(hl)
6cbd 4f        ld      c,a
6cbe 57        ld      d,a
6cbf 58        ld      e,b
6cc0 50        ld      d,b
6cc1 4c        ld      c,h
6cc2 42        ld      b,d
6cc3 41        ld      b,c
6cc4 4c        ld      c,h
6cc5 4c        ld      c,h
6cc6 5f        ld      e,a
6cc7 49        ld      c,c
6cc8 44        ld      b,h
6cc9 8f        adc     a,a
6cca 00        nop     
6ccb 00        nop     
6ccc 00        nop     
6ccd 49        ld      c,c
6cce 10e5      djnz    6cb5h
6cd0 0c        inc     c
6cd1 0b        dec     bc
6cd2 4e        ld      c,(hl)
6cd3 4f        ld      c,a
6cd4 57        ld      d,a
6cd5 42        ld      b,d
6cd6 41        ld      b,c
6cd7 4c        ld      c,h
6cd8 4c        ld      c,h
6cd9 325f49    ld      (495fh),a
6cdc 44        ld      b,h
6cdd 8e        adc     a,(hl)
6cde 00        nop     
6cdf 00        nop     
6ce0 00        nop     
6ce1 52        ld      d,d
6ce2 10f8      djnz    6cdch
6ce4 0c        inc     c
6ce5 0a        ld      a,(bc)
6ce6 4e        ld      c,(hl)
6ce7 4f        ld      c,a
6ce8 57        ld      d,a
6ce9 4d        ld      c,l
6cea 41        ld      b,c
6ceb 4e        ld      c,(hl)
6cec 325f49    ld      (495fh),a
6cef 44        ld      b,h
6cf0 7c        ld      a,h
6cf1 00        nop     
6cf2 00        nop     
6cf3 00        nop     
6cf4 00        nop     
6cf5 1009      djnz    6d00h
6cf7 0d        dec     c
6cf8 08        ex      af,af'
6cf9 54        ld      d,h
6cfa 49        ld      c,c
6cfb 43        ld      b,e
6cfc 4b        ld      c,e
6cfd 59        ld      e,c
6cfe 5f        ld      e,a
6cff 49        ld      c,c
6d00 44        ld      b,h
6d01 74        ld      (hl),h
6d02 00        nop     
6d03 00        nop     
6d04 00        nop     
6d05 15        dec     d
6d06 101e      djnz    6d26h
6d08 0d        dec     c
6d09 0c        inc     c
6d0a 50        ld      d,b
6d0b 52        ld      d,d
6d0c 45        ld      b,l
6d0d 41        ld      b,c
6d0e 44        ld      b,h
6d0f 53        ld      d,e
6d10 48        ld      c,b
6d11 4f        ld      c,a
6d12 54        ld      d,h
6d13 5f        ld      e,a
6d14 49        ld      c,c
6d15 44        ld      b,h
6d16 68        ld      l,b
6d17 00        nop     
6d18 00        nop     
6d19 00        nop     
6d1a 00        nop     
6d1b 1030      djnz    6d4dh
6d1d 0d        dec     c
6d1e 09        add     hl,bc
6d1f 43        ld      b,e
6d20 52        ld      d,d
6d21 4c        ld      c,h
6d22 4f        ld      c,a
6d23 46        ld      b,(hl)
6d24 46        ld      b,(hl)
6d25 5f        ld      e,a
6d26 49        ld      c,c
6d27 44        ld      b,h
6d28 62        ld      h,d
6d29 00        nop     
6d2a 00        nop     
6d2b 00        nop     
6d2c 00        nop     
6d2d 1044      djnz    6d73h
6d2f 0d        dec     c
6d30 0b        dec     bc
6d31 4c        ld      c,h
6d32 41        ld      b,c
6d33 55        ld      d,l
6d34 47        ld      b,a
6d35 48        ld      c,b
6d36 54        ld      d,h
6d37 45        ld      b,l
6d38 52        ld      d,d
6d39 5f        ld      e,a
6d3a 49        ld      c,c
6d3b 44        ld      b,h
6d3c 5e        ld      e,(hl)
6d3d 00        nop     
6d3e 00        nop     
6d3f 00        nop     
6d40 49        ld      c,c
6d41 1057      djnz    6d9ah
6d43 0d        dec     c
6d44 0a        ld      a,(bc)
6d45 48        ld      c,b
6d46 49        ld      c,c
6d47 50        ld      d,b
6d48 46        ld      b,(hl)
6d49 49        ld      c,c
6d4a 52        ld      d,d
6d4b 45        ld      b,l
6d4c 5f        ld      e,a
6d4d 49        ld      c,c
6d4e 44        ld      b,h
6d4f 5a        ld      e,d
6d50 00        nop     
6d51 00        nop     
6d52 00        nop     
6d53 54        ld      d,h
6d54 106a      djnz    6dc0h
6d56 0d        dec     c
6d57 0a        ld      a,(bc)
6d58 48        ld      c,b
6d59 49        ld      c,c
6d5a 50        ld      d,b
6d5b 50        ld      d,b
6d5c 41        ld      b,c
6d5d 52        ld      d,d
6d5e 54        ld      d,h
6d5f 5f        ld      e,a
6d60 49        ld      c,c
6d61 44        ld      b,h
6d62 54        ld      d,h
6d63 00        nop     
6d64 00        nop     
6d65 00        nop     
6d66 00        nop     
6d67 1080      djnz    6ce9h
6d69 0d        dec     c
6d6a 0d        dec     c
6d6b 4b        ld      c,e
6d6c 45        ld      b,l
6d6d 4c        ld      c,h
6d6e 4d        ld      c,l
6d6f 49        ld      c,c
6d70 53        ld      d,e
6d71 53        ld      d,e
6d72 49        ld      c,c
6d73 4c        ld      c,h
6d74 45        ld      b,l
6d75 5f        ld      e,a
6d76 49        ld      c,c
6d77 44        ld      b,h
6d78 52        ld      d,d
6d79 00        nop     
6d7a 00        nop     
6d7b 00        nop     
6d7c 52        ld      d,d
6d7d 1092      djnz    6d11h
6d7f 0d        dec     c
6d80 09        add     hl,bc
6d81 4b        ld      c,e
6d82 45        ld      b,l
6d83 4c        ld      c,h
6d84 52        ld      d,d
6d85 41        ld      b,c
6d86 54        ld      d,h
6d87 5f        ld      e,a
6d88 49        ld      c,c
6d89 44        ld      b,h
6d8a 4f        ld      c,a
6d8b 00        nop     
6d8c 00        nop     
6d8d 00        nop     
6d8e 45        ld      b,l
6d8f 10a3      djnz    6d34h
6d91 0d        dec     c
6d92 08        ex      af,af'
6d93 50        ld      d,b
6d94 48        ld      c,b
6d95 47        ld      b,a
6d96 55        ld      d,l
6d97 4e        ld      c,(hl)
6d98 5f        ld      e,a
6d99 49        ld      c,c
6d9a 44        ld      b,h
6d9b 4d        ld      c,l
6d9c 00        nop     
6d9d 00        nop     
6d9e 00        nop     
6d9f 15        dec     d
6da0 10b4      djnz    6d56h
6da2 0d        dec     c
6da3 08        ex      af,af'
6da4 41        ld      b,c
6da5 4e        ld      c,(hl)
6da6 49        ld      c,c
6da7 4d        ld      c,l
6da8 325f49    ld      (495fh),a
6dab 44        ld      b,h
6dac 48        ld      c,b
6dad 00        nop     
6dae 00        nop     
6daf 00        nop     
6db0 00        nop     
6db1 10c7      djnz    6d7ah
6db3 0d        dec     c
6db4 0a        ld      a,(bc)
6db5 48        ld      c,b
6db6 49        ld      c,c
6db7 50        ld      d,b
6db8 43        ld      b,e
6db9 54        ld      d,h
6dba 52        ld      d,d
6dbb 4c        ld      c,h
6dbc 5f        ld      e,a
6dbd 49        ld      c,c
6dbe 44        ld      b,h
6dbf 45        ld      b,l
6dc0 00        nop     
6dc1 00        nop     
6dc2 00        nop     
6dc3 49        ld      c,c
6dc4 10d7      djnz    6d9dh
6dc6 0d        dec     c
6dc7 07        rlca    
6dc8 41        ld      b,c
6dc9 4e        ld      c,(hl)
6dca 54        ld      d,h
6dcb 41        ld      b,c
6dcc 5f        ld      e,a
6dcd 49        ld      c,c
6dce 44        ld      b,h
6dcf 44        ld      b,h
6dd0 00        nop     
6dd1 00        nop     
6dd2 00        nop     
6dd3 3610      ld      (hl),10h
6dd5 e60d      and     0dh
6dd7 0648      ld      b,48h
6dd9 49        ld      c,c
6dda 50        ld      d,b
6ddb 5f        ld      e,a
6ddc 49        ld      c,c
6ddd 44        ld      b,h
6dde 2e00      ld      l,00h
6de0 00        nop     
6de1 00        nop     
6de2 00        nop     
6de3 10f9      djnz    6ddeh
6de5 0d        dec     c
6de6 0a        ld      a,(bc)
6de7 4e        ld      c,(hl)
6de8 4f        ld      c,a
6de9 57        ld      d,a
6dea 42        ld      b,d
6deb 41        ld      b,c
6dec 4c        ld      c,h
6ded 4c        ld      c,h
6dee 5f        ld      e,a
6def 49        ld      c,c
6df0 44        ld      b,h
6df1 2c        inc     l
6df2 00        nop     
6df3 00        nop     
6df4 00        nop     
6df5 23        inc     hl
6df6 100b      djnz    6e03h
6df8 0e09      ld      c,09h
6dfa 4e        ld      c,(hl)
6dfb 4f        ld      c,a
6dfc 57        ld      d,a
6dfd 4d        ld      c,l
6dfe 41        ld      b,c
6dff 4e        ld      c,(hl)
6e00 5f        ld      e,a
6e01 49        ld      c,c
6e02 44        ld      b,h
6e03 2b        dec     hl
6e04 00        nop     
6e05 00        nop     
6e06 00        nop     
6e07 0a        ld      a,(bc)
6e08 101a      djnz    6e24h
6e0a 0e06      ld      c,06h
6e0c 49        ld      c,c
6e0d 43        ld      b,e
6e0e 4b        ld      c,e
6e0f 5f        ld      e,a
6e10 49        ld      c,c
6e11 44        ld      b,h
6e12 2800      jr      z,6e14h
6e14 00        nop     
6e15 00        nop     
6e16 00        nop     
6e17 102f      djnz    6e48h
6e19 0e0c      ld      c,0ch
6e1b 50        ld      d,b
6e1c 49        ld      c,c
6e1d 4b        ld      c,e
6e1e 45        ld      b,l
6e1f 53        ld      d,e
6e20 4e        ld      c,(hl)
6e21 41        ld      b,c
6e22 4b        ld      c,e
6e23 45        ld      b,l
6e24 5f        ld      e,a
6e25 49        ld      c,c
6e26 44        ld      b,h
6e27 1600      ld      d,00h
6e29 00        nop     
6e2a 00        nop     
6e2b 00        nop     
6e2c 1042      djnz    6e70h
6e2e 0e0a      ld      c,0ah
6e30 54        ld      d,h
6e31 45        ld      b,l
6e32 41        ld      b,c
6e33 4d        ld      c,l
6e34 56        ld      d,(hl)
6e35 41        ld      b,c
6e36 4c        ld      c,h
6e37 5f        ld      e,a
6e38 49        ld      c,c
6e39 44        ld      b,h
6e3a 13        inc     de
6e3b 00        nop     
6e3c 00        nop     
6e3d 00        nop     
6e3e 4c        ld      c,h
6e3f 1054      djnz    6e95h
6e41 0e09      ld      c,09h
6e43 41        ld      b,c
6e44 57        ld      d,a
6e45 44        ld      b,h
6e46 4f        ld      c,a
6e47 4f        ld      c,a
6e48 52        ld      d,d
6e49 5f        ld      e,a
6e4a 49        ld      c,c
6e4b 44        ld      b,h
6e4c 12        ld      (de),a
6e4d 00        nop     
6e4e 00        nop     
6e4f 00        nop     
6e50 00        nop     
6e51 1063      djnz    6eb6h
6e53 0e06      ld      c,06h
6e55 4c        ld      c,h
6e56 49        ld      c,c
6e57 54        ld      d,h
6e58 5f        ld      e,a
6e59 49        ld      c,c
6e5a 44        ld      b,h
6e5b 0c        inc     c
6e5c 00        nop     
6e5d 00        nop     
6e5e 00        nop     
6e5f 1010      djnz    6e71h
6e61 78        ld      a,b
6e62 0e0c      ld      c,0ch
6e64 43        ld      b,e
6e65 55        ld      d,l
6e66 5a        ld      e,d
6e67 5a        ld      e,d
6e68 5f        ld      e,a
6e69 48        ld      c,b
6e6a 45        ld      b,l
6e6b 41        ld      b,c
6e6c 44        ld      b,h
6e6d 5f        ld      e,a
6e6e 49        ld      c,c
6e6f 44        ld      b,h
6e70 0b        dec     bc
6e71 00        nop     
6e72 00        nop     
6e73 00        nop     
6e74 4b        ld      c,e
6e75 1088      djnz    6dffh
6e77 0e07      ld      c,07h
6e79 43        ld      b,e
6e7a 55        ld      d,l
6e7b 5a        ld      e,d
6e7c 5a        ld      e,d
6e7d 5f        ld      e,a
6e7e 49        ld      c,c
6e7f 44        ld      b,h
6e80 07        rlca    
6e81 00        nop     
6e82 00        nop     
6e83 00        nop     
6e84 0a        ld      a,(bc)
6e85 1098      djnz    6e1fh
6e87 0e07      ld      c,07h
6e89 4d        ld      c,l
6e8a 4f        ld      c,a
6e8b 4b        ld      c,e
6e8c 45        ld      b,l
6e8d 5f        ld      e,a
6e8e 49        ld      c,c
6e8f 44        ld      b,h
6e90 00        nop     
6e91 00        nop     
6e92 00        nop     
6e93 00        nop     
6e94 45        ld      b,l
6e95 10b0      djnz    6e47h
6e97 0e0f      ld      c,0fh
6e99 45        ld      b,l
6e9a 51        ld      d,c
6e9b 5f        ld      e,a
6e9c 53        ld      d,e
6e9d 4e        ld      c,(hl)
6e9e 4f        ld      c,a
6e9f 57        ld      d,a
6ea0 4d        ld      c,l
6ea1 41        ld      b,c
6ea2 4e        ld      c,(hl)
6ea3 5f        ld      e,a
6ea4 4e        ld      c,(hl)
6ea5 49        ld      c,c
6ea6 43        ld      b,e
6ea7 45        ld      b,l
6ea8 07        rlca    
6ea9 00        nop     
6eaa 00        nop     
6eab 00        nop     
6eac 02        ld      (bc),a
6ead 10c7      djnz    6e76h
6eaf 0e0e      ld      c,0eh
6eb1 45        ld      b,l
6eb2 51        ld      d,c
6eb3 5f        ld      e,a
6eb4 52        ld      d,d
6eb5 4f        ld      c,a
6eb6 42        ld      b,d
6eb7 52        ld      d,d
6eb8 41        ld      b,c
6eb9 54        ld      d,h
6eba 5f        ld      e,a
6ebb 48        ld      c,b
6ebc 45        ld      b,l
6ebd 41        ld      b,c
6ebe 44        ld      b,h
6ebf 0600      ld      b,00h
6ec1 00        nop     
6ec2 00        nop     
6ec3 00        nop     
6ec4 10dc      djnz    6ea2h
6ec6 0e0c      ld      c,0ch
6ec8 45        ld      b,l
6ec9 51        ld      d,c
6eca 5f        ld      e,a
6ecb 52        ld      d,d
6ecc 4f        ld      c,a
6ecd 43        ld      b,e
6ece 4b        ld      c,e
6ecf 53        ld      d,e
6ed0 54        ld      d,h
6ed1 41        ld      b,c
6ed2 52        ld      d,d
6ed3 320500    ld      (0005h),a
6ed6 00        nop     
6ed7 00        nop     
6ed8 49        ld      c,c
6ed9 10f2      djnz    6ecdh
6edb 0e0d      ld      c,0dh
6edd 45        ld      b,l
6ede 51        ld      d,c
6edf 5f        ld      e,a
6ee0 52        ld      d,d
6ee1 4f        ld      c,a
6ee2 42        ld      b,d
6ee3 52        ld      d,d
6ee4 41        ld      b,c
6ee5 54        ld      d,h
6ee6 5f        ld      e,a
6ee7 41        ld      b,c
6ee8 52        ld      d,d
6ee9 4d        ld      c,l
6eea 04        inc     b
6eeb 00        nop     
6eec 00        nop     
6eed 00        nop     
6eee 48        ld      c,b
6eef 1006      djnz    6ef7h
6ef1 0f        rrca    
6ef2 0b        dec     bc
6ef3 45        ld      b,l
6ef4 51        ld      d,c
6ef5 5f        ld      e,a
6ef6 52        ld      d,d
6ef7 4f        ld      c,a
6ef8 43        ld      b,e
6ef9 4b        ld      c,e
6efa 53        ld      d,e
6efb 54        ld      d,h
6efc 41        ld      b,c
6efd 52        ld      d,d
6efe 03        inc     bc
6eff 00        nop     
6f00 00        nop     
6f01 00        nop     
6f02 53        ld      d,e
6f03 1018      djnz    6f1dh
6f05 0f        rrca    
6f06 09        add     hl,bc
6f07 45        ld      b,l
6f08 51        ld      d,c
6f09 5f        ld      e,a
6f0a 54        ld      d,h
6f0b 52        ld      d,d
6f0c 41        ld      b,c
6f0d 53        ld      d,e
6f0e 48        ld      c,b
6f0f 320200    ld      (0002h),a
6f12 00        nop     
6f13 00        nop     
6f14 4f        ld      c,a
6f15 102a      djnz    6f41h
6f17 0f        rrca    
6f18 09        add     hl,bc
6f19 45        ld      b,l
6f1a 51        ld      d,c
6f1b 5f        ld      e,a
6f1c 54        ld      d,h
6f1d 52        ld      d,d
6f1e 41        ld      b,c
6f1f 53        ld      d,e
6f20 48        ld      c,b
6f21 310100    ld      sp,0001h
6f24 00        nop     
6f25 00        nop     
6f26 45        ld      b,l
6f27 103c      djnz    6f65h
6f29 0f        rrca    
6f2a 09        add     hl,bc
6f2b 45        ld      b,l
6f2c 51        ld      d,c
6f2d 5f        ld      e,a
6f2e 54        ld      d,h
6f2f 52        ld      d,d
6f30 41        ld      b,c
6f31 53        ld      d,e
6f32 48        ld      c,b
6f33 3000      jr      nc,6f35h
6f35 00        nop     
6f36 00        nop     
6f37 00        nop     
6f38 09        add     hl,bc
6f39 1053      djnz    6f8eh
6f3b 0f        rrca    
6f3c 0e45      ld      c,45h
6f3e 51        ld      d,c
6f3f 5f        ld      e,a
6f40 52        ld      d,d
6f41 4f        ld      c,a
6f42 42        ld      b,d
6f43 52        ld      d,d
6f44 41        ld      b,c
6f45 54        ld      d,h
6f46 5f        ld      e,a
6f47 46        ld      b,(hl)
6f48 4f        ld      c,a
6f49 4f        ld      c,a
6f4a 54        ld      d,h
6f4b 010000    ld      bc,0000h
6f4e 00        nop     
6f4f 54        ld      d,h
6f50 106c      djnz    6fbeh
6f52 0f        rrca    
6f53 1045      djnz    6f9ah
6f55 51        ld      d,c
6f56 5f        ld      e,a
6f57 52        ld      d,d
6f58 4f        ld      c,a
6f59 42        ld      b,d
6f5a 52        ld      d,d
6f5b 41        ld      b,c
6f5c 54        ld      d,h
6f5d 5f        ld      e,a
6f5e 4e        ld      c,(hl)
6f5f 46        ld      b,(hl)
6f60 57        ld      d,a
6f61 41        ld      b,c
6f62 4c        ld      c,h
6f63 4b        ld      c,e
6f64 00        nop     
6f65 00        nop     
6f66 00        nop     
6f67 00        nop     
6f68 00        nop     
6f69 1083      djnz    6eeeh
6f6b 0f        rrca    
6f6c 0e45      ld      c,45h
6f6e 51        ld      d,c
6f6f 5f        ld      e,a
6f70 52        ld      d,d
6f71 4f        ld      c,a
6f72 42        ld      b,d
6f73 52        ld      d,d
6f74 41        ld      b,c
6f75 54        ld      d,h
6f76 5f        ld      e,a
6f77 57        ld      d,a
6f78 41        ld      b,c
6f79 4c        ld      c,h
6f7a 4b        ld      c,e
6f7b 00        nop     
6f7c 00        nop     
6f7d 00        nop     
6f7e 00        nop     
6f7f 00        nop     
6f80 1093      djnz    6f15h
6f82 0f        rrca    
6f83 07        rlca    
6f84 45        ld      b,l
6f85 51        ld      d,c
6f86 5f        ld      e,a
6f87 4c        ld      c,h
6f88 49        ld      c,c
6f89 46        ld      b,(hl)
6f8a 54        ld      d,h
6f8b 00        nop     
6f8c 00        nop     
6f8d 00        nop     
6f8e 00        nop     
6f8f 54        ld      d,h
6f90 10a9      djnz    6f3bh
6f92 0f        rrca    
6f93 0d        dec     c
6f94 45        ld      b,l
6f95 51        ld      d,c
6f96 5f        ld      e,a
6f97 46        ld      b,(hl)
6f98 49        ld      c,c
6f99 52        ld      d,d
6f9a 41        ld      b,c
6f9b 54        ld      d,h
6f9c 5f        ld      e,a
6f9d 57        ld      d,a
6f9e 41        ld      b,c
6f9f 4c        ld      c,h
6fa0 4b        ld      c,e
6fa1 04        inc     b
6fa2 00        nop     
6fa3 00        nop     
6fa4 00        nop     
6fa5 42        ld      b,d
6fa6 10c1      djnz    6f69h
6fa8 0f        rrca    
6fa9 0f        rrca    
6faa 45        ld      b,l
6fab 51        ld      d,c
6fac 5f        ld      e,a
6fad 42        ld      b,d
6fae 49        ld      c,c
6faf 47        ld      b,a
6fb0 54        ld      d,h
6fb1 4f        ld      c,a
6fb2 4f        ld      c,a
6fb3 4c        ld      c,h
6fb4 5f        ld      e,a
6fb5 4e        ld      c,(hl)
6fb6 4f        ld      c,a
6fb7 52        ld      d,d
6fb8 4d        ld      c,l
6fb9 03        inc     bc
6fba 00        nop     
6fbb 00        nop     
6fbc 00        nop     
6fbd 54        ld      d,h
6fbe 10d9      djnz    6f99h
6fc0 0f        rrca    
6fc1 0f        rrca    
6fc2 45        ld      b,l
6fc3 51        ld      d,c
6fc4 5f        ld      e,a
6fc5 42        ld      b,d
6fc6 49        ld      c,c
6fc7 47        ld      b,a
6fc8 54        ld      d,h
6fc9 4f        ld      c,a
6fca 4f        ld      c,a
6fcb 4c        ld      c,h
6fcc 5f        ld      e,a
6fcd 53        ld      d,e
6fce 50        ld      d,b
6fcf 49        ld      c,c
6fd0 4e        ld      c,(hl)
6fd1 02        ld      (bc),a
6fd2 00        nop     
6fd3 00        nop     
6fd4 00        nop     
6fd5 00        nop     
6fd6 10ef      djnz    6fc7h
6fd8 0f        rrca    
6fd9 0d        dec     c
6fda 45        ld      b,l
6fdb 51        ld      d,c
6fdc 5f        ld      e,a
6fdd 53        ld      d,e
6fde 50        ld      d,b
6fdf 41        ld      b,c
6fe0 4e        ld      c,(hl)
6fe1 4e        ld      c,(hl)
6fe2 5f        ld      e,a
6fe3 4e        ld      c,(hl)
6fe4 4f        ld      c,a
6fe5 52        ld      d,d
6fe6 4d        ld      c,l
6fe7 010000    ld      bc,0000h
6fea 00        nop     
6feb 4d        ld      c,l
6fec 1005      djnz    6ff3h
6fee 100d      djnz    6ffdh
6ff0 45        ld      b,l
6ff1 51        ld      d,c
6ff2 5f        ld      e,a
6ff3 53        ld      d,e
6ff4 50        ld      d,b
6ff5 41        ld      b,c
6ff6 4e        ld      c,(hl)
6ff7 4e        ld      c,(hl)
6ff8 5f        ld      e,a
6ff9 53        ld      d,e
6ffa 50        ld      d,b
6ffb 49        ld      c,c
6ffc 4e        ld      c,(hl)
6ffd 00        nop     
6ffe 00        nop     
6fff 00        nop     
7000 00        nop     
7001 50        ld      d,b
7002 101c      djnz    7020h
7004 100e      djnz    7014h
7006 45        ld      b,l
7007 51        ld      d,c
7008 5f        ld      e,a
7009 4c        ld      c,h
700a 41        ld      b,c
700b 5a        ld      e,d
700c 47        ld      b,a
700d 55        ld      d,l
700e 4e        ld      c,(hl)
700f 5f        ld      e,a
7010 4e        ld      c,(hl)
7011 4f        ld      c,a
7012 52        ld      d,d
7013 4d        ld      c,l
7014 00        nop     
7015 00        nop     
7016 00        nop     
7017 00        nop     
7018 52        ld      d,d
7019 1030      djnz    704bh
701b 100b      djnz    7028h
701d 45        ld      b,l
701e 51        ld      d,c
701f 5f        ld      e,a
7020 52        ld      d,d
7021 41        ld      b,c
7022 54        ld      d,h
7023 5f        ld      e,a
7024 57        ld      d,a
7025 41        ld      b,c
7026 4c        ld      c,h
7027 4b        ld      c,e
7028 010000    ld      bc,0000h
702b 00        nop     
702c 53        ld      d,e
702d 1048      djnz    7077h
702f 100f      djnz    7040h
7031 45        ld      b,l
7032 51        ld      d,c
7033 5f        ld      e,a
7034 53        ld      d,e
7035 41        ld      b,c
7036 57        ld      d,a
7037 44        ld      b,h
7038 4f        ld      c,a
7039 4f        ld      c,a
703a 52        ld      d,d
703b 5f        ld      e,a
703c 4f        ld      c,a
703d 50        ld      d,b
703e 45        ld      b,l
703f 4e        ld      c,(hl)
7040 00        nop     
7041 00        nop     
7042 00        nop     
7043 00        nop     
7044 4f        ld      c,a
7045 105d      djnz    70a4h
7047 100c      djnz    7055h
7049 45        ld      b,l
704a 51        ld      d,c
704b 5f        ld      e,a
704c 53        ld      d,e
704d 4c        ld      c,h
704e 49        ld      c,c
704f 54        ld      d,h
7050 5f        ld      e,a
7051 4f        ld      c,a
7052 50        ld      d,b
7053 45        ld      b,l
7054 4e        ld      c,(hl)
7055 04        inc     b
7056 00        nop     
7057 00        nop     
7058 00        nop     
7059 4c        ld      c,h
705a 106f      djnz    70cbh
705c 1009      djnz    7067h
705e 45        ld      b,l
705f 51        ld      d,c
7060 5f        ld      e,a
7061 52        ld      d,d
7062 49        ld      c,c
7063 50        ld      d,b
7064 50        ld      d,b
7065 4c        ld      c,h
7066 45        ld      b,l
7067 03        inc     bc
7068 00        nop     
7069 00        nop     
706a 00        nop     
706b 4f        ld      c,a
706c 1084      djnz    6ff2h
706e 100c      djnz    707ch
7070 45        ld      b,l
7071 51        ld      d,c
7072 5f        ld      e,a
7073 4c        ld      c,h
7074 41        ld      b,c
7075 5a        ld      e,d
7076 45        ld      b,l
7077 52        ld      d,d
7078 5f        ld      e,a
7079 323235    ld      (3532h),a
707c 02        ld      (bc),a
707d 00        nop     
707e 00        nop     
707f 00        nop     
7080 4c        ld      c,h
7081 109b      djnz    701eh
7083 100e      djnz    7093h
7085 45        ld      b,l
7086 51        ld      d,c
7087 5f        ld      e,a
7088 4c        ld      c,h
7089 41        ld      b,c
708a 5a        ld      e,d
708b 45        ld      b,l
708c 52        ld      d,d
708d 5f        ld      e,a
708e 44        ld      b,h
708f 49        ld      c,c
7090 41        ld      b,c
7091 47        ld      b,a
7092 310100    ld      sp,0001h
7095 00        nop     
7096 00        nop     
7097 50        ld      d,b
7098 10b1      djnz    704bh
709a 100d      djnz    70a9h
709c 45        ld      b,l
709d 51        ld      d,c
709e 5f        ld      e,a
709f 4c        ld      c,h
70a0 41        ld      b,c
70a1 5a        ld      e,d
70a2 45        ld      b,l
70a3 52        ld      d,d
70a4 5f        ld      e,a
70a5 53        ld      d,e
70a6 49        ld      c,c
70a7 44        ld      b,h
70a8 45        ld      b,l
70a9 00        nop     
70aa 00        nop     
70ab 00        nop     
70ac 00        nop     
70ad 3210c7    ld      (0c710h),a
70b0 100d      djnz    70bfh
70b2 45        ld      b,l
70b3 51        ld      d,c
70b4 5f        ld      e,a
70b5 4c        ld      c,h
70b6 41        ld      b,c
70b7 5a        ld      e,d
70b8 45        ld      b,l
70b9 52        ld      d,d
70ba 5f        ld      e,a
70bb 44        ld      b,h
70bc 49        ld      c,c
70bd 41        ld      b,c
70be 47        ld      b,a
70bf 110000    ld      de,0000h
70c2 00        nop     
70c3 41        ld      b,c
70c4 10dc      djnz    70a2h
70c6 100c      djnz    70d4h
70c8 45        ld      b,l
70c9 51        ld      d,c
70ca 5f        ld      e,a
70cb 42        ld      b,d
70cc 55        ld      d,l
70cd 52        ld      d,d
70ce 4e        ld      c,(hl)
70cf 54        ld      d,h
70d0 47        ld      b,a
70d1 55        ld      d,l
70d2 4e        ld      c,(hl)
70d3 4e        ld      c,(hl)
70d4 010000    ld      bc,0000h
70d7 00        nop     
70d8 53        ld      d,e
70d9 10f3      djnz    70ceh
70db 100e      djnz    70ebh
70dd 45        ld      b,l
70de 51        ld      d,c
70df 5f        ld      e,a
70e0 47        ld      b,a
70e1 55        ld      d,l
70e2 4e        ld      c,(hl)
70e3 4e        ld      c,(hl)
70e4 45        ld      b,l
70e5 52        ld      d,d
70e6 5f        ld      e,a
70e7 54        ld      d,h
70e8 55        ld      d,l
70e9 52        ld      d,d
70ea 4e        ld      c,(hl)
70eb 00        nop     
70ec 00        nop     
70ed 00        nop     
70ee 00        nop     
70ef 49        ld      c,c
70f0 100a      djnz    70fch
70f2 110e45    ld      de,450eh
70f5 51        ld      d,c
70f6 5f        ld      e,a
70f7 47        ld      b,a
70f8 55        ld      d,l
70f9 4e        ld      c,(hl)
70fa 4e        ld      c,(hl)
70fb 45        ld      b,l
70fc 52        ld      d,d
70fd 5f        ld      e,a
70fe 46        ld      b,(hl)
70ff 49        ld      c,c
7100 52        ld      d,d
7101 45        ld      b,l
7102 3f        ccf     
7103 00        nop     
7104 00        nop     
7105 00        nop     
7106 4e        ld      c,(hl)
7107 1020      djnz    7129h
7109 110d45    ld      de,450dh
710c 51        ld      d,c
710d 5f        ld      e,a
710e 5a        ld      e,d
710f 49        ld      c,c
7110 54        ld      d,h
7111 42        ld      b,d
7112 4f        ld      c,a
7113 4f        ld      c,a
7114 53        ld      d,e
7115 57        ld      d,a
7116 49        ld      c,c
7117 5a        ld      e,d
7118 3e00      ld      a,00h
711a 00        nop     
711b 00        nop     
711c 52        ld      d,d
711d 1036      djnz    7155h
711f 110d45    ld      de,450dh
7122 51        ld      d,c
7123 5f        ld      e,a
7124 52        ld      d,d
7125 41        ld      b,c
7126 53        ld      d,e
7127 42        ld      b,d
7128 4f        ld      c,a
7129 4f        ld      c,a
712a 53        ld      d,e
712b 57        ld      d,a
712c 49        ld      c,c
712d 5a        ld      e,d
712e 3d        dec     a
712f 00        nop     
7130 00        nop     
7131 00        nop     
7132 49        ld      c,c
7133 104c      djnz    7181h
7135 110d45    ld      de,450dh
7138 51        ld      d,c
7139 5f        ld      e,a
713a 50        ld      d,b
713b 49        ld      c,c
713c 4d        ld      c,l
713d 42        ld      b,d
713e 4f        ld      c,a
713f 4f        ld      c,a
7140 53        ld      d,e
7141 57        ld      d,a
7142 49        ld      c,c
7143 5a        ld      e,d
7144 3c        inc     a
7145 00        nop     
7146 00        nop     
7147 00        nop     
7148 57        ld      d,a
7149 1060      djnz    71abh
714b 110b45    ld      de,450bh
714e 51        ld      d,c
714f 5f        ld      e,a
7150 42        ld      b,d
7151 49        ld      c,c
7152 47        ld      b,a
7153 53        ld      d,e
7154 50        ld      d,b
7155 4c        ld      c,h
7156 41        ld      b,c
7157 54        ld      d,h
7158 39        add     hl,sp
7159 00        nop     
715a 00        nop     
715b 00        nop     
715c 4f        ld      c,a
715d 1075      djnz    71d4h
715f 110c45    ld      de,450ch
7162 51        ld      d,c
7163 5f        ld      e,a
7164 54        ld      d,h
7165 4f        ld      c,a
7166 50        ld      d,b
7167 48        ld      c,b
7168 41        ld      b,c
7169 4e        ld      c,(hl)
716a 47        ld      b,a
716b 41        ld      b,c
716c 52        ld      d,d
716d 3800      jr      c,716fh
716f 00        nop     
7170 00        nop     
7171 4f        ld      c,a
7172 108a      djnz    70feh
7174 110c45    ld      de,450ch
7177 51        ld      d,c
7178 5f        ld      e,a
7179 54        ld      d,h
717a 4f        ld      c,a
717b 50        ld      d,b
717c 46        ld      b,(hl)
717d 55        ld      d,l
717e 4e        ld      c,(hl)
717f 4e        ld      c,(hl)
7180 45        ld      b,l
7181 4c        ld      c,h
7182 35        dec     (hl)
7183 00        nop     
7184 00        nop     
7185 00        nop     
7186 53        ld      d,e
7187 109e      djnz    7127h
7189 110b45    ld      de,450bh
718c 51        ld      d,c
718d 5f        ld      e,a
718e 53        ld      d,e
718f 4d        ld      c,l
7190 4c        ld      c,h
7191 46        ld      b,(hl)
7192 49        ld      c,c
7193 43        ld      b,e
7194 4c        ld      c,h
7195 44        ld      b,h
7196 34        inc     (hl)
7197 00        nop     
7198 00        nop     
7199 00        nop     
719a 48        ld      c,b
719b 10b2      djnz    714fh
719d 110b45    ld      de,450bh
71a0 51        ld      d,c
71a1 5f        ld      e,a
71a2 42        ld      b,d
71a3 49        ld      c,c
71a4 47        ld      b,a
71a5 46        ld      b,(hl)
71a6 49        ld      c,c
71a7 43        ld      b,e
71a8 4c        ld      c,h
71a9 44        ld      b,h
71aa 33        inc     sp
71ab 00        nop     
71ac 00        nop     
71ad 00        nop     
71ae 50        ld      d,b
71af 10c5      djnz    7176h
71b1 110a45    ld      de,450ah
71b4 51        ld      d,c
71b5 5f        ld      e,a
71b6 53        ld      d,e
71b7 51        ld      d,c
71b8 46        ld      b,(hl)
71b9 4c        ld      c,h
71ba 41        ld      b,c
71bb 53        ld      d,e
71bc 48        ld      c,b
71bd 320000    ld      (0000h),a
71c0 00        nop     
71c1 53        ld      d,e
71c2 10d5      djnz    7199h
71c4 110745    ld      de,4507h
71c7 51        ld      d,c
71c8 5f        ld      e,a
71c9 48        ld      c,b
71ca 41        ld      b,c
71cb 5a        ld      e,d
71cc 45        ld      b,l
71cd 310000    ld      sp,0000h
71d0 00        nop     
71d1 0b        dec     bc
71d2 10e5      djnz    71b9h
71d4 110745    ld      de,4507h
71d7 51        ld      d,c
71d8 5f        ld      e,a
71d9 46        ld      b,(hl)
71da 4f        ld      c,a
71db 41        ld      b,c
71dc 4d        ld      c,l
71dd 3000      jr      nc,71dfh
71df 00        nop     
71e0 00        nop     
71e1 54        ld      d,h
71e2 10fa      djnz    71deh
71e4 110c45    ld      de,450ch
71e7 51        ld      d,c
71e8 5f        ld      e,a
71e9 41        ld      b,c
71ea 49        ld      c,c
71eb 52        ld      d,d
71ec 42        ld      b,d
71ed 55        ld      d,l
71ee 42        ld      b,d
71ef 42        ld      b,d
71f0 4c        ld      c,h
71f1 45        ld      b,l
71f2 2f        cpl     
71f3 00        nop     
71f4 00        nop     
71f5 00        nop     
71f6 a7        and     a
71f7 100b      djnz    7204h
71f9 12        ld      (de),a
71fa 08        ex      af,af'
71fb 45        ld      b,l
71fc 51        ld      d,c
71fd 5f        ld      e,a
71fe 57        ld      d,a
71ff 41        ld      b,c
7200 54        ld      d,h
7201 45        ld      b,l
7202 52        ld      d,d
7203 2e00      ld      l,00h
7205 00        nop     
7206 00        nop     
7207 0c        inc     c
7208 1024      djnz    722eh
720a 12        ld      (de),a
720b 1045      djnz    7252h
720d 51        ld      d,c
720e 5f        ld      e,a
720f 45        ld      b,l
7210 59        ld      e,c
7211 45        ld      b,l
7212 57        ld      d,a
7213 4f        ld      c,a
7214 52        ld      d,d
7215 4d        ld      c,l
7216 315f42    ld      sp,425fh
7219 41        ld      b,c
721a 53        ld      d,e
721b 45        ld      b,l
721c 2d        dec     l
721d 00        nop     
721e 00        nop     
721f 00        nop     
7220 55        ld      d,l
7221 103d      djnz    7260h
7223 12        ld      (de),a
7224 1045      djnz    726bh
7226 51        ld      d,c
7227 5f        ld      e,a
7228 45        ld      b,l
7229 59        ld      e,c
722a 45        ld      b,l
722b 57        ld      d,a
722c 4f        ld      c,a
722d 52        ld      d,d
722e 4d        ld      c,l
722f 305f      jr      nc,7290h
7231 42        ld      b,d
7232 41        ld      b,c
7233 53        ld      d,e
7234 45        ld      b,l
7235 2c        inc     l
7236 00        nop     
7237 00        nop     
7238 00        nop     
7239 00        nop     
723a 104d      djnz    7289h
723c 12        ld      (de),a
723d 07        rlca    
723e 45        ld      b,l
723f 51        ld      d,c
7240 5f        ld      e,a
7241 4c        ld      c,h
7242 45        ld      b,l
7243 47        ld      b,a
7244 53        ld      d,e
7245 2b        dec     hl
7246 00        nop     
7247 00        nop     
7248 00        nop     
7249 31105f    ld      sp,5f10h
724c 12        ld      (de),a
724d 09        add     hl,bc
724e 45        ld      b,l
724f 51        ld      d,c
7250 5f        ld      e,a
7251 49        ld      c,c
7252 43        ld      b,e
7253 49        ld      c,c
7254 43        ld      b,e
7255 4c        ld      c,h
7256 45        ld      b,l
7257 2a0000    ld      hl,(0000h)
725a 00        nop     
725b 45        ld      b,l
725c 1073      djnz    72d1h
725e 12        ld      (de),a
725f 0b        dec     bc
7260 45        ld      b,l
7261 51        ld      d,c
7262 5f        ld      e,a
7263 53        ld      d,e
7264 4e        ld      c,(hl)
7265 4f        ld      c,a
7266 57        ld      d,a
7267 44        ld      b,h
7268 55        ld      d,l
7269 53        ld      d,e
726a 54        ld      d,h
726b 29        add     hl,hl
726c 00        nop     
726d 00        nop     
726e 00        nop     
726f 0d        dec     c
7270 1089      djnz    71fbh
7272 12        ld      (de),a
7273 0d        dec     c
7274 45        ld      b,l
7275 51        ld      d,c
7276 5f        ld      e,a
7277 42        ld      b,d
7278 41        ld      b,c
7279 52        ld      d,d
727a 52        ld      d,d
727b 49        ld      c,c
727c 45        ld      b,l
727d 52        ld      d,d
727e 42        ld      b,d
727f 49        ld      c,c
7280 54        ld      d,h
7281 2800      jr      z,7283h
7283 00        nop     
7284 00        nop     
7285 43        ld      b,e
7286 10a0      djnz    7228h
7288 12        ld      (de),a
7289 0e45      ld      c,45h
728b 51        ld      d,c
728c 5f        ld      e,a
728d 49        ld      c,c
728e 43        ld      b,e
728f 45        ld      b,l
7290 42        ld      b,d
7291 41        ld      b,c
7292 52        ld      d,d
7293 52        ld      d,d
7294 49        ld      c,c
7295 45        ld      b,l
7296 52        ld      d,d
7297 33        inc     sp
7298 27        daa     
7299 00        nop     
729a 00        nop     
729b 00        nop     
729c 53        ld      d,e
729d 10b7      djnz    7256h
729f 12        ld      (de),a
72a0 0e45      ld      c,45h
72a2 51        ld      d,c
72a3 5f        ld      e,a
72a4 49        ld      c,c
72a5 43        ld      b,e
72a6 45        ld      b,l
72a7 42        ld      b,d
72a8 41        ld      b,c
72a9 52        ld      d,d
72aa 52        ld      d,d
72ab 49        ld      c,c
72ac 45        ld      b,l
72ad 52        ld      d,d
72ae 322600    ld      (0026h),a
72b1 00        nop     
72b2 00        nop     
72b3 54        ld      d,h
72b4 10ce      djnz    7284h
72b6 12        ld      (de),a
72b7 0e45      ld      c,45h
72b9 51        ld      d,c
72ba 5f        ld      e,a
72bb 49        ld      c,c
72bc 43        ld      b,e
72bd 45        ld      b,l
72be 42        ld      b,d
72bf 41        ld      b,c
72c0 52        ld      d,d
72c1 52        ld      d,d
72c2 49        ld      c,c
72c3 45        ld      b,l
72c4 52        ld      d,d
72c5 312500    ld      sp,0025h
72c8 00        nop     
72c9 00        nop     
72ca 33        inc     sp
72cb 10e5      djnz    72b2h
72cd 12        ld      (de),a
72ce 0e45      ld      c,45h
72d0 51        ld      d,c
72d1 5f        ld      e,a
72d2 49        ld      c,c
72d3 43        ld      b,e
72d4 45        ld      b,l
72d5 42        ld      b,d
72d6 41        ld      b,c
72d7 52        ld      d,d
72d8 52        ld      d,d
72d9 49        ld      c,c
72da 45        ld      b,l
72db 52        ld      d,d
72dc 3024      jr      nc,7302h
72de 00        nop     
72df 00        nop     
72e0 00        nop     
72e1 3210f9    ld      (0f910h),a
72e4 12        ld      (de),a
72e5 0b        dec     bc
72e6 45        ld      b,l
72e7 51        ld      d,c
72e8 5f        ld      e,a
72e9 52        ld      d,d
72ea 4f        ld      c,a
72eb 54        ld      d,h
72ec 47        ld      b,a
72ed 4c        ld      c,h
72ee 49        ld      c,c
72ef 4e        ld      c,(hl)
72f0 54        ld      d,h
72f1 23        inc     hl
72f2 00        nop     
72f3 00        nop     
72f4 00        nop     
72f5 49        ld      c,c
72f6 100c      djnz    7304h
72f8 13        inc     de
72f9 0a        ld      a,(bc)
72fa 45        ld      b,l
72fb 51        ld      d,c
72fc 5f        ld      e,a
72fd 53        ld      d,e
72fe 54        ld      d,h
72ff 47        ld      b,a
7300 4c        ld      c,h
7301 49        ld      c,c
7302 4e        ld      c,(hl)
7303 54        ld      d,h
7304 220000    ld      (0000h),hl
7307 00        nop     
7308 42        ld      b,d
7309 1022      djnz    732dh
730b 13        inc     de
730c 0d        dec     c
730d 45        ld      b,l
730e 51        ld      d,c
730f 5f        ld      e,a
7310 43        ld      b,e
7311 41        ld      b,c
7312 52        ld      d,d
7313 52        ld      d,d
7314 4f        ld      c,a
7315 54        ld      d,h
7316 5f        ld      e,a
7317 54        ld      d,h
7318 4f        ld      c,a
7319 50        ld      d,b
731a 210000    ld      hl,0000h
731d 00        nop     
731e 54        ld      d,h
731f 1038      djnz    7359h
7321 13        inc     de
7322 0d        dec     c
7323 45        ld      b,l
7324 51        ld      d,c
7325 5f        ld      e,a
7326 46        ld      b,(hl)
7327 49        ld      c,c
7328 53        ld      d,e
7329 48        ld      c,b
732a 5f        ld      e,a
732b 42        ld      b,d
732c 4f        ld      c,a
732d 4e        ld      c,(hl)
732e 45        ld      b,l
732f 53        ld      d,e
7330 2000      jr      nz,7332h
7332 00        nop     
7333 00        nop     
7334 49        ld      c,c
7335 1051      djnz    7388h
7337 13        inc     de
7338 1045      djnz    737fh
733a 51        ld      d,c
733b 5f        ld      e,a
733c 43        ld      b,e
733d 48        ld      c,b
733e 49        ld      c,c
733f 43        ld      b,e
7340 4b        ld      c,e
7341 45        ld      b,l
7342 4e        ld      c,(hl)
7343 5f        ld      e,a
7344 42        ld      b,d
7345 4f        ld      c,a
7346 4e        ld      c,(hl)
7347 45        ld      b,l
7348 53        ld      d,e
7349 1f        rra     
734a 00        nop     
734b 00        nop     
734c 00        nop     
734d 211063    ld      hl,6310h
7350 13        inc     de
7351 09        add     hl,bc
7352 45        ld      b,l
7353 51        ld      d,c
7354 5f        ld      e,a
7355 4d        ld      c,l
7356 45        ld      b,l
7357 44        ld      b,h
7358 42        ld      b,d
7359 55        ld      d,l
735a 42        ld      b,d
735b 1e00      ld      e,00h
735d 00        nop     
735e 00        nop     
735f 4f        ld      c,a
7360 1075      djnz    73d7h
7362 13        inc     de
7363 09        add     hl,bc
7364 45        ld      b,l
7365 51        ld      d,c
7366 5f        ld      e,a
7367 53        ld      d,e
7368 4d        ld      c,l
7369 4c        ld      c,h
736a 42        ld      b,d
736b 55        ld      d,l
736c 42        ld      b,d
736d 1d        dec     e
736e 00        nop     
736f 00        nop     
7370 00        nop     
7371 49        ld      c,c
7372 1087      djnz    72fbh
7374 13        inc     de
7375 09        add     hl,bc
7376 45        ld      b,l
7377 51        ld      d,c
7378 5f        ld      e,a
7379 43        ld      b,e
737a 41        ld      b,c
737b 52        ld      d,d
737c 52        ld      d,d
737d 4f        ld      c,a
737e 54        ld      d,h
737f 1c        inc     e
7380 00        nop     
7381 00        nop     
7382 00        nop     
7383 0e10      ld      c,10h
7385 9c        sbc     a,h
7386 13        inc     de
7387 0c        inc     c
7388 45        ld      b,l
7389 51        ld      d,c
738a 5f        ld      e,a
738b 46        ld      b,(hl)
738c 49        ld      c,c
738d 53        ld      d,e
738e 48        ld      c,b
738f 5f        ld      e,a
7390 4d        ld      c,l
7391 45        ld      b,l
7392 41        ld      b,c
7393 54        ld      d,h
7394 1b        dec     de
7395 00        nop     
7396 00        nop     
7397 00        nop     
7398 51        ld      d,c
7399 10b4      djnz    734fh
739b 13        inc     de
739c 0f        rrca    
739d 45        ld      b,l
739e 51        ld      d,c
739f 5f        ld      e,a
73a0 43        ld      b,e
73a1 48        ld      c,b
73a2 49        ld      c,c
73a3 43        ld      b,e
73a4 4b        ld      c,e
73a5 45        ld      b,l
73a6 4e        ld      c,(hl)
73a7 5f        ld      e,a
73a8 4d        ld      c,l
73a9 45        ld      b,l
73aa 41        ld      b,c
73ab 54        ld      d,h
73ac 1a        ld      a,(de)
73ad 00        nop     
73ae 00        nop     
73af 00        nop     
73b0 4f        ld      c,a
73b1 10c5      djnz    7378h
73b3 13        inc     de
73b4 08        ex      af,af'
73b5 45        ld      b,l
73b6 51        ld      d,c
73b7 5f        ld      e,a
73b8 53        ld      d,e
73b9 50        ld      d,b
73ba 55        ld      d,l
73bb 52        ld      d,d
73bc 54        ld      d,h
73bd 19        add     hl,de
73be 00        nop     
73bf 00        nop     
73c0 00        nop     
73c1 48        ld      c,b
73c2 10da      djnz    739eh
73c4 13        inc     de
73c5 0c        inc     c
73c6 45        ld      b,l
73c7 51        ld      d,c
73c8 5f        ld      e,a
73c9 53        ld      d,e
73ca 4e        ld      c,(hl)
73cb 41        ld      b,c
73cc 4b        ld      c,e
73cd 45        ld      b,l
73ce 48        ld      c,b
73cf 45        ld      b,l
73d0 41        ld      b,c
73d1 44        ld      b,h
73d2 1800      jr      73d4h
73d4 00        nop     
73d5 00        nop     
73d6 43        ld      b,e
73d7 10f0      djnz    73c9h
73d9 13        inc     de
73da 0d        dec     c
73db 45        ld      b,l
73dc 51        ld      d,c
73dd 5f        ld      e,a
73de 53        ld      d,e
73df 4e        ld      c,(hl)
73e0 41        ld      b,c
73e1 4b        ld      c,e
73e2 45        ld      b,l
73e3 43        ld      b,e
73e4 48        ld      c,b
73e5 4f        ld      c,a
73e6 4d        ld      c,l
73e7 50        ld      d,b
73e8 17        rla     
73e9 00        nop     
73ea 00        nop     
73eb 00        nop     
73ec 50        ld      d,b
73ed 1005      djnz    73f4h
73ef 14        inc     d
73f0 0c        inc     c
73f1 45        ld      b,l
73f2 51        ld      d,c
73f3 5f        ld      e,a
73f4 53        ld      d,e
73f5 4e        ld      c,(hl)
73f6 41        ld      b,c
73f7 4b        ld      c,e
73f8 45        ld      b,l
73f9 48        ld      c,b
73fa 4f        ld      c,a
73fb 4c        ld      c,h
73fc 45        ld      b,l
73fd 1600      ld      d,00h
73ff 00        nop     
7400 00        nop     
7401 48        ld      c,b
7402 1016      djnz    741ah
7404 14        inc     d
7405 08        ex      af,af'
7406 45        ld      b,l
7407 51        ld      d,c
7408 5f        ld      e,a
7409 53        ld      d,e
740a 50        ld      d,b
740b 4c        ld      c,h
740c 41        ld      b,c
740d 54        ld      d,h
740e 15        dec     d
740f 00        nop     
7410 00        nop     
7411 00        nop     
7412 4e        ld      c,(hl)
7413 102b      djnz    7440h
7415 14        inc     d
7416 0c        inc     c
7417 45        ld      b,l
7418 51        ld      d,c
7419 5f        ld      e,a
741a 53        ld      d,e
741b 4c        ld      c,h
741c 49        ld      c,c
741d 4d        ld      c,l
741e 45        ld      b,l
741f 50        ld      d,b
7420 4c        ld      c,h
7421 41        ld      b,c
7422 54        ld      d,h
7423 14        inc     d
7424 00        nop     
7425 00        nop     
7426 00        nop     
7427 53        ld      d,e
7428 1040      djnz    746ah
742a 14        inc     d
742b 0c        inc     c
742c 45        ld      b,l
742d 51        ld      d,c
742e 5f        ld      e,a
742f 50        ld      d,b
7430 52        ld      d,d
7431 4f        ld      c,a
7432 50        ld      d,b
7433 45        ld      b,l
7434 4c        ld      c,h
7435 4c        ld      c,h
7436 45        ld      b,l
7437 52        ld      d,d
7438 1000      djnz    743ah
743a 00        nop     
743b 00        nop     
743c 53        ld      d,e
743d 1055      djnz    7494h
743f 14        inc     d
7440 0c        inc     c
7441 45        ld      b,l
7442 51        ld      d,c
7443 5f        ld      e,a
7444 46        ld      b,(hl)
7445 4c        ld      c,h
7446 52        ld      d,d
7447 46        ld      b,(hl)
7448 49        ld      c,c
7449 5a        ld      e,d
744a 5a        ld      e,d
744b 4c        ld      c,h
744c 45        ld      b,l
744d 0f        rrca    
744e 00        nop     
744f 00        nop     
7450 00        nop     
7451 45        ld      b,l
7452 106a      djnz    74beh
7454 14        inc     d
7455 0c        inc     c
7456 45        ld      b,l
7457 51        ld      d,c
7458 5f        ld      e,a
7459 4d        ld      c,l
745a 45        ld      b,l
745b 47        ld      b,a
745c 41        ld      b,c
745d 46        ld      b,(hl)
745e 4c        ld      c,h
745f 41        ld      b,c
7460 53        ld      d,e
7461 48        ld      c,b
7462 0e00      ld      c,00h
7464 00        nop     
7465 00        nop     
7466 45        ld      b,l
7467 1080      djnz    73e9h
7469 14        inc     d
746a 0d        dec     c
746b 45        ld      b,l
746c 51        ld      d,c
746d 5f        ld      e,a
746e 52        ld      d,d
746f 4f        ld      c,a
7470 42        ld      b,d
7471 53        ld      d,e
7472 50        ld      d,b
7473 41        ld      b,c
7474 52        ld      d,d
7475 4b        ld      c,e
7476 52        ld      d,d
7477 48        ld      c,b
7478 0d        dec     c
7479 00        nop     
747a 00        nop     
747b 00        nop     
747c 5a        ld      e,d
747d 1096      djnz    7415h
747f 14        inc     d
7480 0d        dec     c
7481 45        ld      b,l
7482 51        ld      d,c
7483 5f        ld      e,a
7484 52        ld      d,d
7485 4f        ld      c,a
7486 42        ld      b,d
7487 53        ld      d,e
7488 50        ld      d,b
7489 41        ld      b,c
748a 52        ld      d,d
748b 4b        ld      c,e
748c 4c        ld      c,h
748d 48        ld      c,b
748e 0c        inc     c
748f 00        nop     
7490 00        nop     
7491 00        nop     
7492 41        ld      b,c
7493 10ac      djnz    7441h
7495 14        inc     d
7496 0d        dec     c
7497 45        ld      b,l
7498 51        ld      d,c
7499 5f        ld      e,a
749a 42        ld      b,d
749b 4f        ld      c,a
749c 4f        ld      c,a
749d 53        ld      d,e
749e 54        ld      d,h
749f 45        ld      b,l
74a0 52        ld      d,d
74a1 4f        ld      c,a
74a2 46        ld      b,(hl)
74a3 46        ld      b,(hl)
74a4 0b        dec     bc
74a5 00        nop     
74a6 00        nop     
74a7 00        nop     
74a8 4b        ld      c,e
74a9 10c4      djnz    746fh
74ab 14        inc     d
74ac 0f        rrca    
74ad 45        ld      b,l
74ae 51        ld      d,c
74af 5f        ld      e,a
74b0 42        ld      b,d
74b1 55        ld      d,l
74b2 52        ld      d,d
74b3 4e        ld      c,(hl)
74b4 55        ld      d,l
74b5 50        ld      d,b
74b6 5f        ld      e,a
74b7 46        ld      b,(hl)
74b8 4c        ld      c,h
74b9 41        ld      b,c
74ba 4d        ld      c,l
74bb 45        ld      b,l
74bc 0a        ld      a,(bc)
74bd 00        nop     
74be 00        nop     
74bf 00        nop     
74c0 48        ld      c,b
74c1 10d9      djnz    749ch
74c3 14        inc     d
74c4 0c        inc     c
74c5 45        ld      b,l
74c6 51        ld      d,c
74c7 5f        ld      e,a
74c8 42        ld      b,d
74c9 4f        ld      c,a
74ca 4f        ld      c,a
74cb 53        ld      d,e
74cc 54        ld      d,h
74cd 45        ld      b,l
74ce 52        ld      d,d
74cf 4f        ld      c,a
74d0 4e        ld      c,(hl)
74d1 09        add     hl,bc
74d2 00        nop     
74d3 00        nop     
74d4 00        nop     
74d5 46        ld      b,(hl)
74d6 10eb      djnz    74c3h
74d8 14        inc     d
74d9 09        add     hl,bc
74da 45        ld      b,l
74db 51        ld      d,c
74dc 5f        ld      e,a
74dd 54        ld      d,h
74de 57        ld      d,a
74df 45        ld      b,l
74e0 45        ld      b,l
74e1 54        ld      d,h
74e2 59        ld      e,c
74e3 08        ex      af,af'
74e4 00        nop     
74e5 00        nop     
74e6 00        nop     
74e7 55        ld      d,l
74e8 10fe      djnz    74e8h
74ea 14        inc     d
74eb 0a        ld      a,(bc)
74ec 45        ld      b,l
74ed 51        ld      d,c
74ee 5f        ld      e,a
74ef 46        ld      b,(hl)
74f0 41        ld      b,c
74f1 53        ld      d,e
74f2 50        ld      d,b
74f3 41        ld      b,c
74f4 52        ld      d,d
74f5 4b        ld      c,e
74f6 07        rlca    
74f7 00        nop     
74f8 00        nop     
74f9 00        nop     
74fa 5f        ld      e,a
74fb 1014      djnz    7511h
74fd 15        dec     d
74fe 0d        dec     c
74ff 45        ld      b,l
7500 51        ld      d,c
7501 5f        ld      e,a
7502 42        ld      b,d
7503 49        ld      c,c
7504 47        ld      b,a
7505 48        ld      c,b
7506 4f        ld      c,a
7507 52        ld      d,d
7508 5a        ld      e,d
7509 43        ld      b,e
750a 4f        ld      c,a
750b 47        ld      b,a
750c 0600      ld      b,00h
750e 00        nop     
750f 00        nop     
7510 54        ld      d,h
7511 1029      djnz    753ch
7513 15        dec     d
7514 0c        inc     c
7515 45        ld      b,l
7516 51        ld      d,c
7517 5f        ld      e,a
7518 55        ld      d,l
7519 50        ld      d,b
751a 57        ld      d,a
751b 41        ld      b,c
751c 52        ld      d,d
751d 44        ld      b,h
751e 43        ld      b,e
751f 4f        ld      c,a
7520 47        ld      b,a
7521 05        dec     b
7522 00        nop     
7523 00        nop     
7524 00        nop     
7525 50        ld      d,b
7526 103d      djnz    7565h
7528 15        dec     d
7529 0b        dec     bc
752a 45        ld      b,l
752b 51        ld      d,c
752c 5f        ld      e,a
752d 42        ld      b,d
752e 49        ld      c,c
752f 47        ld      b,a
7530 42        ld      b,d
7531 4c        ld      c,h
7532 41        ld      b,c
7533 44        ld      b,h
7534 45        ld      b,l
7535 04        inc     b
7536 00        nop     
7537 00        nop     
7538 00        nop     
7539 4f        ld      c,a
753a 1051      djnz    758dh
753c 15        dec     d
753d 0b        dec     bc
753e 45        ld      b,l
753f 51        ld      d,c
7540 5f        ld      e,a
7541 47        ld      b,a
7542 55        ld      d,l
7543 4e        ld      c,(hl)
7544 53        ld      d,e
7545 50        ld      d,b
7546 41        ld      b,c
7547 52        ld      d,d
7548 4b        ld      c,e
7549 03        inc     bc
754a 00        nop     
754b 00        nop     
754c 00        nop     
754d 57        ld      d,a
754e 1068      djnz    75b8h
7550 15        dec     d
7551 0e45      ld      c,45h
7553 51        ld      d,c
7554 5f        ld      e,a
7555 4d        ld      c,l
7556 49        ld      c,c
7557 4e        ld      c,(hl)
7558 49        ld      c,c
7559 46        ld      b,(hl)
755a 4c        ld      c,h
755b 53        ld      d,e
755c 4d        ld      c,l
755d 4f        ld      c,a
755e 4b        ld      c,e
755f 45        ld      b,l
7560 02        ld      (bc),a
7561 00        nop     
7562 00        nop     
7563 00        nop     
7564 4c        ld      c,h
7565 107e      djnz    75e5h
7567 15        dec     d
7568 0d        dec     c
7569 45        ld      b,l
756a 51        ld      d,c
756b 5f        ld      e,a
756c 4d        ld      c,l
756d 49        ld      c,c
756e 4e        ld      c,(hl)
756f 49        ld      c,c
7570 32464c    ld      (4c46h),a
7573 41        ld      b,c
7574 53        ld      d,e
7575 48        ld      c,b
7576 010000    ld      bc,0000h
7579 00        nop     
757a 52        ld      d,d
757b 1093      djnz    7510h
757d 15        dec     d
757e 0c        inc     c
757f 45        ld      b,l
7580 51        ld      d,c
7581 5f        ld      e,a
7582 4d        ld      c,l
7583 49        ld      c,c
7584 4e        ld      c,(hl)
7585 49        ld      c,c
7586 46        ld      b,(hl)
7587 4c        ld      c,h
7588 41        ld      b,c
7589 53        ld      d,e
758a 48        ld      c,b
758b 00        nop     
758c 00        nop     
758d 00        nop     
758e 00        nop     
758f 4d        ld      c,l
7590 10a4      djnz    7536h
7592 15        dec     d
7593 08        ex      af,af'
7594 45        ld      b,l
7595 51        ld      d,c
7596 5f        ld      e,a
7597 46        ld      b,(hl)
7598 4c        ld      c,h
7599 41        ld      b,c
759a 53        ld      d,e
759b 48        ld      c,b
759c 08        ex      af,af'
759d 00        nop     
759e 00        nop     
759f 00        nop     
75a0 49        ld      c,c
75a1 10b7      djnz    755ah
75a3 15        dec     d
75a4 0a        ld      a,(bc)
75a5 45        ld      b,l
75a6 51        ld      d,c
75a7 5f        ld      e,a
75a8 53        ld      d,e
75a9 54        ld      d,h
75aa 41        ld      b,c
75ab 52        ld      d,d
75ac 58        ld      e,b
75ad 50        ld      d,b
75ae 4c        ld      c,h
75af 07        rlca    
75b0 00        nop     
75b1 00        nop     
75b2 00        nop     
75b3 51        ld      d,c
75b4 10cb      djnz    7581h
75b6 15        dec     d
75b7 0b        dec     bc
75b8 45        ld      b,l
75b9 51        ld      d,c
75ba 5f        ld      e,a
75bb 4b        ld      c,e
75bc 42        ld      b,d
75bd 32534d    ld      (4d53h),a
75c0 4f        ld      c,a
75c1 4b        ld      c,e
75c2 45        ld      b,l
75c3 0600      ld      b,00h
75c5 00        nop     
75c6 00        nop     
75c7 45        ld      b,l
75c8 10db      djnz    75a5h
75ca 15        dec     d
75cb 07        rlca    
75cc 45        ld      b,l
75cd 51        ld      d,c
75ce 5f        ld      e,a
75cf 46        ld      b,(hl)
75d0 49        ld      c,c
75d1 52        ld      d,d
75d2 45        ld      b,l
75d3 05        dec     b
75d4 00        nop     
75d5 00        nop     
75d6 00        nop     
75d7 0a        ld      a,(bc)
75d8 10ee      djnz    75c8h
75da 15        dec     d
75db 0a        ld      a,(bc)
75dc 45        ld      b,l
75dd 51        ld      d,c
75de 5f        ld      e,a
75df 4b        ld      c,e
75e0 42        ld      b,d
75e1 53        ld      d,e
75e2 4d        ld      c,l
75e3 4f        ld      c,a
75e4 4b        ld      c,e
75e5 45        ld      b,l
75e6 04        inc     b
75e7 00        nop     
75e8 00        nop     
75e9 00        nop     
75ea 0b        dec     bc
75eb 1002      djnz    75efh
75ed 160b      ld      d,0bh
75ef 45        ld      b,l
75f0 51        ld      d,c
75f1 5f        ld      e,a
75f2 53        ld      d,e
75f3 54        ld      d,h
75f4 45        ld      b,l
75f5 41        ld      b,c
75f6 4d        ld      c,l
75f7 56        ld      d,(hl)
75f8 41        ld      b,c
75f9 4c        ld      c,h
75fa 03        inc     bc
75fb 00        nop     
75fc 00        nop     
75fd 00        nop     
75fe 07        rlca    
75ff 1013      djnz    7614h
7601 1608      ld      d,08h
7603 45        ld      b,l
7604 51        ld      d,c
7605 5f        ld      e,a
7606 43        ld      b,e
7607 4c        ld      c,h
7608 4f        ld      c,a
7609 55        ld      d,l
760a 44        ld      b,h
760b 02        ld      (bc),a
760c 00        nop     
760d 00        nop     
760e 00        nop     
760f 45        ld      b,l
7610 1023      djnz    7635h
7612 1607      ld      d,07h
7614 45        ld      b,l
7615 51        ld      d,c
7616 5f        ld      e,a
7617 47        ld      b,a
7618 55        ld      d,l
7619 53        ld      d,e
761a 48        ld      c,b
761b 010000    ld      bc,0000h
761e 00        nop     
761f d41035    call    nc,3510h
7622 1609      ld      d,09h
7624 45        ld      b,l
7625 51        ld      d,c
7626 5f        ld      e,a
7627 53        ld      d,e
7628 4d        ld      c,l
7629 4f        ld      c,a
762a 4b        ld      c,e
762b 45        ld      b,l
762c 320000    ld      (0000h),a
762f 00        nop     
7630 00        nop     
7631 1010      djnz    7643h
7633 46        ld      b,(hl)
7634 1608      ld      d,08h
7636 45        ld      b,l
7637 51        ld      d,c
7638 5f        ld      e,a
7639 53        ld      d,e
763a 4d        ld      c,l
763b 4f        ld      c,a
763c 4b        ld      c,e
763d 45        ld      b,l
763e 0600      ld      b,00h
7640 00        nop     
7641 00        nop     
7642 011057    ld      bc,5710h
7645 1608      ld      d,08h
7647 43        ld      b,e
7648 4f        ld      c,a
7649 52        ld      d,d
764a 45        ld      b,l
764b 5f        ld      e,a
764c 4c        ld      c,h
764d 45        ld      b,l
764e 4e        ld      c,(hl)
764f 1a        ld      a,(de)
7650 00        nop     
7651 00        nop     
7652 00        nop     
7653 00        nop     
7654 1066      djnz    76bch
7656 1606      ld      d,06h
7658 43        ld      b,e
7659 42        ld      b,d
765a 44        ld      b,h
765b 5f        ld      e,a
765c 44        ld      b,h
765d 59        ld      e,c
765e e0        ret     po

765f 00        nop     
7660 00        nop     
7661 00        nop     
7662 00        nop     
7663 1078      djnz    76ddh
7665 1609      ld      d,09h
7667 43        ld      b,e
7668 42        ld      b,d
7669 44        ld      b,h
766a 5f        ld      e,a
766b 59        ld      e,c
766c 52        ld      d,d
766d 45        ld      b,l
766e 41        ld      b,c
766f 4c        ld      c,h
7670 05        dec     b
7671 00        nop     
7672 00        nop     
7673 00        nop     
7674 00        nop     
7675 108d      djnz    7604h
7677 160c      ld      d,0ch
7679 43        ld      b,e
767a 42        ld      b,d
767b 44        ld      b,h
767c 5f        ld      e,a
767d 59        ld      e,c
767e 56        ld      d,(hl)
767f 49        ld      c,c
7680 52        ld      d,d
7681 54        ld      d,h
7682 55        ld      d,l
7683 41        ld      b,c
7684 4c        ld      c,h
7685 88        adc     a,b
7686 00        nop     
7687 00        nop     
7688 00        nop     
7689 58        ld      e,b
768a 109d      djnz    7629h
768c 1607      ld      d,07h
768e 4d        ld      c,l
768f 4f        ld      c,a
7690 4b        ld      c,e
7691 45        ld      b,l
7692 4c        ld      c,h
7693 49        ld      c,c
7694 4d        ld      c,l
7695 05        dec     b
7696 00        nop     
7697 00        nop     
7698 00        nop     
7699 54        ld      d,h
769a 10ac      djnz    7648h
769c 1606      ld      d,06h
769e 50        ld      d,b
769f 45        ld      b,l
76a0 45        ld      b,l
76a1 44        ld      b,h
76a2 5f        ld      e,a
76a3 42        ld      b,d
76a4 0b        dec     bc
76a5 00        nop     
76a6 00        nop     
76a7 00        nop     
76a8 76        halt    
76a9 10be      djnz    7669h
76ab 1609      ld      d,09h
76ad 43        ld      b,e
76ae 52        ld      d,d
76af 45        ld      b,l
76b0 41        ld      b,c
76b1 4d        ld      c,l
76b2 45        ld      b,l
76b3 44        ld      b,h
76b4 5f        ld      e,a
76b5 42        ld      b,d
76b6 0a        ld      a,(bc)
76b7 00        nop     
76b8 00        nop     
76b9 00        nop     
76ba 1010      djnz    76cch
76bc cf        rst     08h
76bd 1608      ld      d,08h
76bf 41        ld      b,c
76c0 59        ld      e,c
76c1 4e        ld      c,(hl)
76c2 41        ld      b,c
76c3 4d        ld      c,l
76c4 45        ld      b,l
76c5 5f        ld      e,a
76c6 42        ld      b,d
76c7 02        ld      (bc),a
76c8 00        nop     
76c9 00        nop     
76ca 00        nop     
76cb 1010      djnz    76ddh
76cd e1        pop     hl
76ce 1609      ld      d,09h
76d0 41        ld      b,c
76d1 46        ld      b,(hl)
76d2 45        ld      b,l
76d3 5f        ld      e,a
76d4 52        ld      d,d
76d5 45        ld      b,l
76d6 53        ld      d,e
76d7 5f        ld      e,a
76d8 42        ld      b,d
76d9 f0        ret     p

76da 04        inc     b
76db 00        nop     
76dc 00        nop     
76dd 50        ld      d,b
76de 10f2      djnz    76d2h
76e0 1608      ld      d,08h
76e2 50        ld      d,b
76e3 45        ld      b,l
76e4 43        ld      b,e
76e5 4d        ld      c,l
76e6 4f        ld      c,a
76e7 56        ld      d,(hl)
76e8 45        ld      b,l
76e9 53        ld      d,e
76ea a0        and     b
76eb 04        inc     b
76ec 00        nop     
76ed 00        nop     
76ee 4c        ld      c,h
76ef 10ff      djnz    76f0h
76f1 1604      ld      d,04h
76f3 43        ld      b,e
76f4 41        ld      b,c
76f5 43        ld      b,e
76f6 54        ld      d,h
76f7 80        add     a,b
76f8 04        inc     b
76f9 00        nop     
76fa 00        nop     
76fb b0        or      b
76fc 1011      djnz    770fh
76fe 17        rla     
76ff 09        add     hl,bc
7700 43        ld      b,e
7701 42        ld      b,d
7702 44        ld      b,h
7703 5f        ld      e,a
7704 46        ld      b,(hl)
7705 4c        ld      c,h
7706 41        ld      b,c
7707 47        ld      b,a
7708 53        ld      d,e
7709 3004      jr      nc,770fh
770b 00        nop     
770c 00        nop     
770d 04        inc     b
770e 101e      djnz    772eh
7710 17        rla     
7711 04        inc     b
7712 43        ld      b,e
7713 4f        ld      c,a
7714 52        ld      d,d
7715 45        ld      b,l
7716 40        ld      b,b
7717 02        ld      (bc),a
7718 00        nop     
7719 00        nop     
771a 1010      djnz    772ch
771c 2f        cpl     
771d 17        rla     
771e 08        ex      af,af'
771f 50        ld      d,b
7720 45        ld      b,l
7721 43        ld      b,e
7722 54        ld      d,h
7723 49        ld      c,c
7724 4d        ld      c,l
7725 45        ld      b,l
7726 52        ld      d,d
7727 3002      jr      nc,772bh
7729 00        nop     
772a 00        nop     
772b 1010      djnz    773dh
772d 42        ld      b,d
772e 17        rla     
772f 0a        ld      a,(bc)
7730 41        ld      b,c
7731 46        ld      b,(hl)
7732 45        ld      b,l
7733 5f        ld      e,a
7734 4c        ld      c,h
7735 49        ld      c,c
7736 4e        ld      c,(hl)
7737 45        ld      b,l
7738 53        ld      d,e
7739 5a        ld      e,d
773a 2002      jr      nz,773eh
773c 00        nop     
773d 00        nop     
773e 0610      ld      b,10h
7740 56        ld      d,(hl)
7741 17        rla     
7742 0b        dec     bc
7743 41        ld      b,c
7744 46        ld      b,(hl)
7745 45        ld      b,l
7746 5f        ld      e,a
7747 4c        ld      c,h
7748 49        ld      c,c
7749 4e        ld      c,(hl)
774a 45        ld      b,l
774b 4e        ld      c,(hl)
774c 55        ld      d,l
774d 4d        ld      c,l
774e f0        ret     p

774f 00        nop     
7750 00        nop     
7751 00        nop     
7752 00        nop     
7753 106a      djnz    77bfh
7755 17        rla     
7756 0b        dec     bc
7757 41        ld      b,c
7758 46        ld      b,(hl)
7759 45        ld      b,l
775a 5f        ld      e,a
775b 4f        ld      c,a
775c 42        ld      b,d
775d 4a        ld      c,d
775e 46        ld      b,(hl)
775f 4c        ld      c,h
7760 41        ld      b,c
7761 47        ld      b,a
7762 b0        or      b
7763 00        nop     
7764 00        nop     
7765 00        nop     
7766 0b        dec     bc
7767 107b      djnz    77e4h
7769 17        rla     
776a 08        ex      af,af'
776b 41        ld      b,c
776c 46        ld      b,(hl)
776d 45        ld      b,l
776e 5f        ld      e,a
776f 5a        ld      e,d
7770 50        ld      d,b
7771 53        ld      d,e
7772 4e        ld      c,(hl)
7773 90        sub     b
7774 00        nop     
7775 00        nop     
7776 00        nop     
7777 1010      djnz    7789h
7779 8c        adc     a,h
777a 17        rla     
777b 08        ex      af,af'
777c 41        ld      b,c
777d 46        ld      b,(hl)
777e 45        ld      b,l
777f 5f        ld      e,a
7780 58        ld      e,b
7781 50        ld      d,b
7782 53        ld      d,e
7783 4e        ld      c,(hl)
7784 70        ld      (hl),b
7785 00        nop     
7786 00        nop     
7787 00        nop     
7788 19        add     hl,de
7789 109d      djnz    7728h
778b 17        rla     
778c 08        ex      af,af'
778d 41        ld      b,c
778e 46        ld      b,(hl)
778f 45        ld      b,l
7790 5f        ld      e,a
7791 59        ld      e,c
7792 50        ld      d,b
7793 53        ld      d,e
7794 4e        ld      c,(hl)
7795 3000      jr      nc,7797h
7797 00        nop     
7798 00        nop     
7799 5f        ld      e,a
779a 10ac      djnz    7748h
779c 17        rla     
779d 0645      ld      b,45h
779f 51        ld      d,c
77a0 5f        ld      e,a
77a1 53        ld      d,e
77a2 45        ld      b,l
77a3 51        ld      d,c
77a4 2000      jr      nz,77a6h
77a6 00        nop     
77a7 00        nop     
77a8 4d        ld      c,l
77a9 10ba      djnz    7765h
77ab 17        rla     
77ac 05        dec     b
77ad 54        ld      d,h
77ae 52        ld      d,d
77af 4f        ld      c,a
77b0 42        ld      b,d
77b1 45        ld      b,l
77b2 010000    ld      bc,0000h
77b5 00        nop     
77b6 25        dec     h
77b7 10cb      djnz    7784h
77b9 17        rla     
77ba 08        ex      af,af'
77bb 4e        ld      c,(hl)
77bc 44        ld      b,h
77bd 4d        ld      c,l
77be 4f        ld      c,a
77bf 44        ld      b,h
77c0 45        ld      b,l
77c1 5f        ld      e,a
77c2 42        ld      b,d
77c3 04        inc     b
77c4 00        nop     
77c5 00        nop     
77c6 00        nop     
77c7 1010      djnz    77d9h
77c9 de17      sbc     a,17h
77cb 0a        ld      a,(bc)
77cc 43        ld      b,e
77cd 52        ld      d,d
77ce 4f        ld      c,a
77cf 4c        ld      c,h
77d0 4c        ld      c,h
77d1 5f        ld      e,a
77d2 53        ld      d,e
77d3 54        ld      d,h
77d4 4f        ld      c,a
77d5 50        ld      d,b
77d6 08        ex      af,af'
77d7 00        nop     
77d8 00        nop     
77d9 00        nop     
77da 0110f0    ld      bc,0f010h
77dd 17        rla     
77de 09        add     hl,bc
77df 43        ld      b,e
77e0 4e        ld      c,(hl)
77e1 5f        ld      e,a
77e2 53        ld      d,e
77e3 43        ld      b,e
77e4 42        ld      b,d
77e5 44        ld      b,h
77e6 5f        ld      e,a
77e7 42        ld      b,d
77e8 07        rlca    
77e9 00        nop     
77ea 00        nop     
77eb 00        nop     
77ec 02        ld      (bc),a
77ed 1003      djnz    77f2h
77ef 180a      jr      77fbh
77f1 43        ld      b,e
77f2 4e        ld      c,(hl)
77f3 5f        ld      e,a
77f4 49        ld      c,c
77f5 4e        ld      c,(hl)
77f6 54        ld      d,h
77f7 52        ld      d,d
77f8 4f        ld      c,a
77f9 5f        ld      e,a
77fa 42        ld      b,d
77fb 05        dec     b
77fc 00        nop     
77fd 00        nop     
77fe 00        nop     
77ff 09        add     hl,bc
7800 1018      djnz    781ah
7802 180c      jr      7810h
7804 43        ld      b,e
7805 37        scf     
7806 5f        ld      e,a
7807 42        ld      b,d
7808 4f        ld      c,a
7809 54        ld      d,h
780a 52        ld      d,d
780b 41        ld      b,c
780c 49        ld      c,c
780d 4c        ld      c,h
780e 5f        ld      e,a
780f 42        ld      b,d
7810 04        inc     b
7811 00        nop     
7812 00        nop     
7813 00        nop     
7814 5f        ld      e,a
7815 102d      djnz    7844h
7817 180c      jr      7825h
7819 43        ld      b,e
781a 37        scf     
781b 5f        ld      e,a
781c 54        ld      d,h
781d 4f        ld      c,a
781e 50        ld      d,b
781f 52        ld      d,d
7820 41        ld      b,c
7821 49        ld      c,c
7822 4c        ld      c,h
7823 5f        ld      e,a
7824 42        ld      b,d
7825 03        inc     bc
7826 00        nop     
7827 00        nop     
7828 00        nop     
7829 45        ld      b,l
782a 103f      djnz    786bh
782c 1809      jr      7837h
782e 43        ld      b,e
782f 315f53    ld      sp,535fh
7832 49        ld      c,c
7833 43        ld      b,e
7834 4b        ld      c,e
7835 5f        ld      e,a
7836 42        ld      b,d
7837 02        ld      (bc),a
7838 00        nop     
7839 00        nop     
783a 00        nop     
783b 4f        ld      c,a
783c 1052      djnz    7890h
783e 180a      jr      784ah
7840 43        ld      b,e
7841 4e        ld      c,(hl)
7842 5f        ld      e,a
7843 53        ld      d,e
7844 4c        ld      c,h
7845 4f        ld      c,a
7846 50        ld      d,b
7847 45        ld      b,l
7848 5f        ld      e,a
7849 42        ld      b,d
784a 010000    ld      bc,0000h
784d 00        nop     
784e 5f        ld      e,a
784f 1065      djnz    78b6h
7851 180a      jr      785dh
7853 43        ld      b,e
7854 4e        ld      c,(hl)
7855 5f        ld      e,a
7856 59        ld      e,c
7857 57        ld      d,a
7858 52        ld      d,d
7859 41        ld      b,c
785a 50        ld      d,b
785b 5f        ld      e,a
785c 42        ld      b,d
785d 00        nop     
785e 00        nop     
785f 00        nop     
7860 00        nop     
7861 43        ld      b,e
7862 1078      djnz    78dch
7864 180a      jr      7870h
7866 43        ld      b,e
7867 4e        ld      c,(hl)
7868 5f        ld      e,a
7869 58        ld      e,b
786a 57        ld      d,a
786b 52        ld      d,d
786c 41        ld      b,c
786d 50        ld      d,b
786e 5f        ld      e,a
786f 42        ld      b,d
7870 05        dec     b
7871 00        nop     
7872 00        nop     
7873 00        nop     
7874 43        ld      b,e
7875 108b      djnz    7802h
7877 180a      jr      7883h
7879 43        ld      b,e
787a 41        ld      b,c
787b 43        ld      b,e
787c 54        ld      d,h
787d 4c        ld      c,h
787e 4f        ld      c,a
787f 43        ld      b,e
7880 4b        ld      c,e
7881 5f        ld      e,a
7882 42        ld      b,d
7883 02        ld      (bc),a
7884 00        nop     
7885 00        nop     
7886 00        nop     
7887 4c        ld      c,h
7888 109d      djnz    7827h
788a 1809      jr      7895h
788c 43        ld      b,e
788d 42        ld      b,d
788e 44        ld      b,h
788f 5f        ld      e,a
7890 54        ld      d,h
7891 47        ld      b,a
7892 4c        ld      c,h
7893 5f        ld      e,a
7894 42        ld      b,d
7895 00        nop     
7896 00        nop     
7897 00        nop     
7898 00        nop     
7899 35        dec     (hl)
789a 10b1      djnz    784dh
789c 180b      jr      78a9h
789e 55        ld      d,l
789f 42        ld      b,d
78a0 4e        ld      c,(hl)
78a1 4f        ld      c,a
78a2 50        ld      d,b
78a3 4f        ld      c,a
78a4 57        ld      d,a
78a5 45        ld      b,l
78a6 52        ld      d,d
78a7 5f        ld      e,a
78a8 42        ld      b,d
78a9 00        nop     
78aa 00        nop     
78ab 00        nop     
78ac 00        nop     
78ad 51        ld      d,c
78ae 10c1      djnz    7871h
78b0 1807      jr      78b9h
78b2 48        ld      c,b
78b3 41        ld      b,c
78b4 44        ld      b,h
78b5 4f        ld      c,a
78b6 57        ld      d,a
78b7 5f        ld      e,a
78b8 42        ld      b,d
78b9 07        rlca    
78ba 00        nop     
78bb 00        nop     
78bc 00        nop     
78bd 00        nop     
78be 10d1      djnz    7891h
78c0 1807      jr      78c9h
78c2 51        ld      d,c
78c3 55        ld      d,l
78c4 41        ld      b,c
78c5 53        ld      d,e
78c6 48        ld      c,b
78c7 5f        ld      e,a
78c8 42        ld      b,d
78c9 04        inc     b
78ca 00        nop     
78cb 00        nop     
78cc 00        nop     
78cd 13        inc     de
78ce 10e2      djnz    78b2h
78d0 1808      jr      78dah
78d2 54        ld      d,h
78d3 55        ld      d,l
78d4 4e        ld      c,(hl)
78d5 41        ld      b,c
78d6 54        ld      d,h
78d7 54        ld      d,h
78d8 5f        ld      e,a
78d9 42        ld      b,d
78da 2003      jr      nz,78dfh
78dc 00        nop     
78dd 00        nop     
78de 4d        ld      c,l
78df 10ee      djnz    78cfh
78e1 1803      jr      78e6h
78e3 49        ld      c,c
78e4 5a        ld      e,d
78e5 45        ld      b,l
78e6 f0        ret     p

78e7 02        ld      (bc),a
78e8 00        nop     
78e9 00        nop     
78ea 3d        dec     a
78eb 10fb      djnz    78e8h
78ed 1804      jr      78f3h
78ef 48        ld      c,b
78f0 41        ld      b,c
78f1 4b        ld      c,e
78f2 45        ld      b,l
78f3 e0        ret     po

78f4 02        ld      (bc),a
78f5 00        nop     
78f6 00        nop     
78f7 1010      djnz    7909h
78f9 0b        dec     bc
78fa 19        add     hl,de
78fb 07        rlca    
78fc 4c        ld      c,h
78fd 4f        ld      c,a
78fe 50        ld      d,b
78ff 45        ld      b,l
7900 56        ld      d,(hl)
7901 45        ld      b,l
7902 4c        ld      c,h
7903 b0        or      b
7904 02        ld      (bc),a
7905 00        nop     
7906 00        nop     
7907 07        rlca    
7908 101a      djnz    7924h
790a 19        add     hl,de
790b 0654      ld      b,54h
790d 4f        ld      c,a
790e 50        ld      d,b
790f 43        ld      b,e
7910 54        ld      d,h
7911 52        ld      d,d
7912 70        ld      (hl),b
7913 010000    ld      bc,0000h
7916 1010      djnz    7928h
7918 2619      ld      h,19h
791a 03        inc     bc
791b 54        ld      d,h
791c 55        ld      d,l
791d 4e        ld      c,(hl)
791e 40        ld      b,b
791f 010000    ld      bc,0000h
7922 00        nop     
7923 1035      djnz    795ah
7925 19        add     hl,de
7926 0650      ld      b,50h
7928 45        ld      b,l
7929 43        ld      b,e
792a 49        ld      c,c
792b 41        ld      b,c
792c 4c        ld      c,h
792d 1000      djnz    792fh
792f 00        nop     
7930 00        nop     
7931 00        nop     
7932 1042      djnz    7976h
7934 19        add     hl,de
7935 04        inc     b
7936 50        ld      d,b
7937 41        ld      b,c
7938 52        ld      d,d
7939 45        ld      b,l
793a 0600      ld      b,00h
793c 00        nop     
793d 00        nop     
793e 14        inc     d
793f 1053      djnz    7994h
7941 19        add     hl,de
7942 08        ex      af,af'
7943 50        ld      d,b
7944 45        ld      b,l
7945 43        ld      b,e
7946 49        ld      c,c
7947 41        ld      b,c
7948 4c        ld      c,h
7949 5f        ld      e,a
794a 42        ld      b,d
794b 07        rlca    
794c 00        nop     
794d 00        nop     
794e 00        nop     
794f 0610      ld      b,10h
7951 62        ld      h,d
7952 19        add     hl,de
7953 0654      ld      b,54h
7955 41        ld      b,c
7956 52        ld      d,d
7957 54        ld      d,h
7958 5f        ld      e,a
7959 42        ld      b,d
795a c0        ret     nz

795b 00        nop     
795c 00        nop     
795d 00        nop     
795e 0a        ld      a,(bc)
795f 14        inc     d
7960 72        ld      (hl),d
7961 19        add     hl,de
7962 07        rlca    
7963 48        ld      c,b
7964 4f        ld      c,a
7965 57        ld      d,a
7966 59        ld      e,c
7967 50        ld      d,b
7968 4f        ld      c,a
7969 53        ld      d,e
796a 00        nop     
796b 00        nop     
796c 00        nop     
796d 00        nop     
796e 221482    ld      (8214h),hl
7971 19        add     hl,de
7972 07        rlca    
7973 48        ld      c,b
7974 4f        ld      c,a
7975 57        ld      d,a
7976 58        ld      e,b
7977 50        ld      d,b
7978 4f        ld      c,a
7979 53        ld      d,e
797a 03        inc     bc
797b 00        nop     
797c 00        nop     
797d 00        nop     
797e 6c        ld      l,h
797f 1093      djnz    7914h
7981 19        add     hl,de
7982 08        ex      af,af'
7983 45        ld      b,l
7984 52        ld      d,d
7985 56        ld      d,(hl)
7986 49        ld      c,c
7987 43        ld      b,e
7988 45        ld      b,l
7989 5f        ld      e,a
798a 42        ld      b,d
798b 04        inc     b
798c 00        nop     
798d 00        nop     
798e 00        nop     
798f 44        ld      b,h
7990 10a7      djnz    7939h
7992 19        add     hl,de
7993 0b        dec     bc
7994 48        ld      c,b
7995 41        ld      b,c
7996 44        ld      b,h
7997 4f        ld      c,a
7998 57        ld      d,a
7999 4d        ld      c,l
799a 4f        ld      c,a
799b 44        ld      b,h
799c 45        ld      b,l
799d 5f        ld      e,a
799e 42        ld      b,d
799f 03        inc     bc
79a0 00        nop     
79a1 00        nop     
79a2 00        nop     
79a3 00        nop     
79a4 10ba      djnz    7960h
79a6 19        add     hl,de
79a7 0a        ld      a,(bc)
79a8 4e        ld      c,(hl)
79a9 44        ld      b,h
79aa 5f        ld      e,a
79ab 52        ld      d,d
79ac 45        ld      b,l
79ad 53        ld      d,e
79ae 45        ld      b,l
79af 54        ld      d,h
79b0 5f        ld      e,a
79b1 42        ld      b,d
79b2 80        add     a,b
79b3 03        inc     bc
79b4 00        nop     
79b5 2032      jr      nz,79e9h
79b7 10c7      djnz    7980h
79b9 19        add     hl,de
79ba 04        inc     b
79bb 4e        ld      c,(hl)
79bc 44        ld      b,h
79bd 52        ld      d,d
79be 44        ld      b,h
79bf 80        add     a,b
79c0 03        inc     bc
79c1 00        nop     
79c2 2032      jr      nz,79f6h
79c4 10d4      djnz    799ah
79c6 19        add     hl,de
79c7 04        inc     b
79c8 4e        ld      c,(hl)
79c9 44        ld      b,h
79ca 57        ld      d,a
79cb 52        ld      d,d
79cc 00        nop     
79cd 02        ld      (bc),a
79ce 00        nop     
79cf 2032      jr      nz,7a03h
79d1 10e3      djnz    79b6h
79d3 19        add     hl,de
79d4 064e      ld      b,4eh
79d6 44        ld      b,h
79d7 46        ld      b,(hl)
79d8 4c        ld      c,h
79d9 47        ld      b,a
79da 53        ld      d,e
79db 1003      djnz    79e0h
79dd 00        nop     
79de c0        ret     nz

79df 5f        ld      e,a
79e0 10f2      djnz    79d4h
79e2 19        add     hl,de
79e3 0645      ld      b,45h
79e5 54        ld      d,h
79e6 48        ld      c,b
79e7 43        ld      b,e
79e8 4e        ld      c,(hl)
79e9 54        ld      d,h
79ea 00        nop     
79eb 03        inc     bc
79ec 00        nop     
79ed c0        ret     nz

79ee 53        ld      d,e
79ef 1001      djnz    79f2h
79f1 1a        ld      a,(de)
79f2 0645      ld      b,45h
79f4 54        ld      d,h
79f5 56        ld      d,(hl)
79f6 43        ld      b,e
79f7 4e        ld      c,(hl)
79f8 54        ld      d,h
79f9 c0        ret     nz

79fa 02        ld      (bc),a
79fb 00        nop     
79fc c0        ret     nz

79fd 43        ld      b,e
79fe 100f      djnz    7a0fh
7a00 1a        ld      a,(de)
7a01 05        dec     b
7a02 43        ld      b,e
7a03 4f        ld      c,a
7a04 55        ld      d,l
7a05 4e        ld      c,(hl)
7a06 54        ld      d,h
7a07 00        nop     
7a08 00        nop     
7a09 00        nop     
7a0a 2059      jr      nz,7a65h
7a0c 101d      djnz    7a2bh
7a0e 1a        ld      a,(de)
7a0f 05        dec     b
7a10 46        ld      b,(hl)
7a11 52        ld      d,d
7a12 41        ld      b,c
7a13 43        ld      b,e
7a14 54        ld      d,h
7a15 00        nop     
7a16 00        nop     
7a17 00        nop     
7a18 00        nop     
7a19 54        ld      d,h
7a1a 1000      djnz    7a1ch
7a1c 00        nop     
7a1d 05        dec     b
7a1e 54        ld      d,h
7a1f 45        ld      b,l
7a20 56        ld      d,(hl)
7a21 45        ld      b,l
7a22 50        ld      d,b
7a23 70        ld      (hl),b
7a24 86        add     a,(hl)
7a25 fdff      rst     38h
7a27 011039    ld      bc,3910h
7a2a 1a        ld      a,(de)
7a2b 05        dec     b
7a2c 54        ld      d,h
7a2d 44        ld      b,h
7a2e 41        ld      b,c
7a2f 54        ld      d,h
7a30 41        ld      b,c
7a31 14        inc     d
7a32 00        nop     
7a33 00        nop     
7a34 00        nop     
7a35 00        nop     
7a36 1044      djnz    7a7ch
7a38 1a        ld      a,(de)
7a39 02        ld      (bc),a
7a3a 52        ld      d,d
7a3b 58        ld      e,b
7a3c 2c        inc     l
7a3d 00        nop     
7a3e 00        nop     
7a3f 00        nop     
7a40 00        nop     
7a41 104f      djnz    7a92h
7a43 1a        ld      a,(de)
7a44 02        ld      (bc),a
7a45 52        ld      d,d
7a46 59        ld      e,c
7a47 d0        ret     nc

7a48 84        add     a,h
7a49 fdff      rst     38h
7a4b 011061    ld      bc,6110h
7a4e 1a        ld      a,(de)
7a4f 09        add     hl,bc
7a50 41        ld      b,c
7a51 4d        ld      c,l
7a52 52        ld      d,d
7a53 4f        ld      c,a
7a54 4d        ld      c,l
7a55 5f        ld      e,a
7a56 53        ld      d,e
7a57 43        ld      b,e
7a58 52        ld      d,d
7a59 c0        ret     nz

7a5a 82        add     a,d
7a5b fdff      rst     38h
7a5d 011073    ld      bc,7310h
7a60 1a        ld      a,(de)
7a61 09        add     hl,bc
7a62 41        ld      b,c
7a63 4d        ld      c,l
7a64 52        ld      d,d
7a65 4f        ld      c,a
7a66 4d        ld      c,l
7a67 5f        ld      e,a
7a68 4d        ld      c,l
7a69 45        ld      b,l
7a6a 4e        ld      c,(hl)
7a6b 60        ld      h,b
7a6c 09        add     hl,bc
7a6d 53        ld      d,e
7a6e 53        ld      d,e
7a6f 00        nop     
7a70 02        ld      (bc),a
7a71 8b        adc     a,e
7a72 1a        ld      a,(de)
7a73 0f        rrca    
7a74 45        ld      b,l
7a75 53        ld      d,e
7a76 45        ld      b,l
7a77 54        ld      d,h
7a78 5f        ld      e,a
7a79 54        ld      d,h
7a7a 4f        ld      c,a
7a7b 5f        ld      e,a
7a7c 46        ld      b,(hl)
7a7d 41        ld      b,c
7a7e 43        ld      b,e
7a7f 54        ld      d,h
7a80 4f        ld      c,a
7a81 52        ld      d,d
7a82 59        ld      e,c
7a83 d0        ret     nc

7a84 4d        ld      c,l
7a85 fdff      rst     38h
7a87 01109d    ld      bc,9d10h
7a8a 1a        ld      a,(de)
7a8b 09        add     hl,bc
7a8c 45        ld      b,l
7a8d 54        ld      d,h
7a8e 53        ld      d,e
7a8f 45        ld      b,l
7a90 54        ld      d,h
7a91 5f        ld      e,a
7a92 54        ld      d,h
7a93 58        ld      e,b
7a94 54        ld      d,h
7a95 40        ld      b,b
7a96 4c        ld      c,h
7a97 fdff      rst     38h
7a99 0110b0    ld      bc,0b010h
7a9c 1a        ld      a,(de)
7a9d 0a        ld      a,(bc)
7a9e 52        ld      d,d
7a9f 5f        ld      e,a
7aa0 4d        ld      c,l
7aa1 53        ld      d,e
7aa2 47        ld      b,a
7aa3 35        dec     (hl)
7aa4 5f        ld      e,a
7aa5 54        ld      d,h
7aa6 58        ld      e,b
7aa7 54        ld      d,h
7aa8 b0        or      b
7aa9 4b        ld      c,e
7aaa fdff      rst     38h
7aac 0110c3    ld      bc,0c310h
7aaf 1a        ld      a,(de)
7ab0 0a        ld      a,(bc)
7ab1 52        ld      d,d
7ab2 5f        ld      e,a
7ab3 4d        ld      c,l
7ab4 53        ld      d,e
7ab5 47        ld      b,a
7ab6 34        inc     (hl)
7ab7 5f        ld      e,a
7ab8 54        ld      d,h
7ab9 58        ld      e,b
7aba 54        ld      d,h
7abb 104b      djnz    7b08h
7abd fdff      rst     38h
7abf 0110d6    ld      bc,0d610h
7ac2 1a        ld      a,(de)
7ac3 0a        ld      a,(bc)
7ac4 52        ld      d,d
7ac5 5f        ld      e,a
7ac6 4d        ld      c,l
7ac7 53        ld      d,e
7ac8 47        ld      b,a
7ac9 33        inc     sp
7aca 5f        ld      e,a
7acb 54        ld      d,h
7acc 58        ld      e,b
7acd 54        ld      d,h
7ace b0        or      b
7acf 4a        ld      c,d
7ad0 fdff      rst     38h
7ad2 0110e9    ld      bc,0e910h
7ad5 1a        ld      a,(de)
7ad6 0a        ld      a,(bc)
7ad7 52        ld      d,d
7ad8 5f        ld      e,a
7ad9 4d        ld      c,l
7ada 53        ld      d,e
7adb 47        ld      b,a
7adc 325f54    ld      (545fh),a
7adf 58        ld      e,b
7ae0 54        ld      d,h
7ae1 40        ld      b,b
7ae2 4a        ld      c,d
7ae3 fdff      rst     38h
7ae5 0110fc    ld      bc,0fc10h
7ae8 1a        ld      a,(de)
7ae9 0a        ld      a,(bc)
7aea 52        ld      d,d
7aeb 5f        ld      e,a
7aec 4d        ld      c,l
7aed 53        ld      d,e
7aee 47        ld      b,a
7aef 315f54    ld      sp,545fh
7af2 58        ld      e,b
7af3 54        ld      d,h
7af4 e0        ret     po

7af5 49        ld      c,c
7af6 fdff      rst     38h
7af8 01100f    ld      bc,0f10h
7afb 1b        dec     de
7afc 0a        ld      a,(bc)
7afd 52        ld      d,d
7afe 5f        ld      e,a
7aff 4d        ld      c,l
7b00 53        ld      d,e
7b01 47        ld      b,a
7b02 305f      jr      nc,7b63h
7b04 54        ld      d,h
7b05 58        ld      e,b
7b06 54        ld      d,h
7b07 00        nop     
7b08 2efd      ld      l,0fdh
7b0a ff        rst     38h
7b0b 011020    ld      bc,2010h
7b0e 1b        dec     de
7b0f 08        ex      af,af'
7b10 49        ld      c,c
7b11 47        ld      b,a
7b12 48        ld      c,b
7b13 54        ld      d,h
7b14 5f        ld      e,a
7b15 54        ld      d,h
7b16 58        ld      e,b
7b17 54        ld      d,h
7b18 50        ld      d,b
7b19 45        ld      b,l
7b1a fdff      rst     38h
7b1c 011033    ld      bc,3310h
7b1f 1b        dec     de
7b20 0a        ld      a,(bc)
7b21 45        ld      b,l
7b22 54        ld      d,h
7b23 44        ld      b,h
7b24 49        ld      c,c
7b25 41        ld      b,c
7b26 47        ld      b,a
7b27 5f        ld      e,a
7b28 54        ld      d,h
7b29 58        ld      e,b
7b2a 54        ld      d,h
7b2b 40        ld      b,b
7b2c 50        ld      d,b
7b2d fdff      rst     38h
7b2f 011044    ld      bc,4410h
7b32 1b        dec     de
7b33 08        ex      af,af'
7b34 45        ld      b,l
7b35 53        ld      d,e
7b36 45        ld      b,l
7b37 54        ld      d,h
7b38 5f        ld      e,a
7b39 54        ld      d,h
7b3a 58        ld      e,b
7b3b 54        ld      d,h
7b3c c0        ret     nz

7b3d 15        dec     d
7b3e fdff      rst     38h
7b40 011055    ld      bc,5510h
7b43 1b        dec     de
7b44 08        ex      af,af'
7b45 45        ld      b,l
7b46 53        ld      d,e
7b47 45        ld      b,l
7b48 54        ld      d,h
7b49 5f        ld      e,a
7b4a 4d        ld      c,l
7b4b 45        ld      b,l
7b4c 4e        ld      c,(hl)
7b4d c0        ret     nz

7b4e 2afdff    ld      hl,(0fffdh)
7b51 011068    ld      bc,6810h
7b54 1b        dec     de
7b55 0a        ld      a,(bc)
7b56 45        ld      b,l
7b57 54        ld      d,h
7b58 53        ld      d,e
7b59 54        ld      d,h
7b5a 41        ld      b,c
7b5b 54        ld      d,h
7b5c 5f        ld      e,a
7b5d 54        ld      d,h
7b5e 58        ld      e,b
7b5f 54        ld      d,h
7b60 1049      djnz    7babh
7b62 fdff      rst     38h
7b64 01107a    ld      bc,7a10h
7b67 1b        dec     de
7b68 09        add     hl,bc
7b69 41        ld      b,c
7b6a 4d        ld      c,l
7b6b 52        ld      d,d
7b6c 4f        ld      c,a
7b6d 4d        ld      c,l
7b6e 5f        ld      e,a
7b6f 54        ld      d,h
7b70 58        ld      e,b
7b71 54        ld      d,h
7b72 50        ld      d,b
7b73 82        add     a,d
7b74 ecff00    call    pe,00ffh
7b77 108d      djnz    7b06h
7b79 1b        dec     de
7b7a 0a        ld      a,(bc)
7b7b 41        ld      b,c
7b7c 4d        ld      c,l
7b7d 52        ld      d,d
7b7e 4f        ld      c,a
7b7f 4d        ld      c,l
7b80 5f        ld      e,a
7b81 54        ld      d,h
7b82 45        ld      b,l
7b83 53        ld      d,e
7b84 54        ld      d,h
7b85 a0        and     b
7b86 23        inc     hl
7b87 fdff      rst     38h
7b89 0110a0    ld      bc,0a010h
7b8c 1b        dec     de
7b8d 0a        ld      a,(bc)
7b8e 45        ld      b,l
7b8f 54        ld      d,h
7b90 4d        ld      c,l
7b91 41        ld      b,c
7b92 49        ld      c,c
7b93 4e        ld      c,(hl)
7b94 5f        ld      e,a
7b95 54        ld      d,h
7b96 58        ld      e,b
7b97 54        ld      d,h
7b98 c0        ret     nz

7b99 1b        dec     de
7b9a fdff      rst     38h
7b9c 0110b2    ld      bc,0b210h
7b9f 1b        dec     de
7ba0 09        add     hl,bc
7ba1 45        ld      b,l
7ba2 53        ld      d,e
7ba3 47        ld      b,a
7ba4 41        ld      b,c
7ba5 4d        ld      c,l
7ba6 5f        ld      e,a
7ba7 54        ld      d,h
7ba8 58        ld      e,b
7ba9 54        ld      d,h
7baa 210050    ld      hl,5000h
7bad 5f        ld      e,a
7bae 00        nop     
7baf 02        ld      (bc),a
7bb0 c9        ret     

7bb1 1b        dec     de
7bb2 0e4a      ld      c,4ah
7bb4 57        ld      d,a
7bb5 52        ld      d,d
7bb6 49        ld      c,c
7bb7 54        ld      d,h
7bb8 45        ld      b,l
7bb9 5f        ld      e,a
7bba 44        ld      b,h
7bbb 45        ld      b,l
7bbc 43        ld      b,e
7bbd 49        ld      c,c
7bbe 4d        ld      c,l
7bbf 41        ld      b,c
7bc0 4c        ld      c,h
7bc1 1d        dec     e
7bc2 00        nop     
7bc3 54        ld      d,h
7bc4 310002    ld      sp,0200h
7bc7 d61b      sub     1bh
7bc9 04        inc     b
7bca 45        ld      b,l
7bcb 53        ld      d,e
7bcc 45        ld      b,l
7bcd 54        ld      d,h
7bce 1c        inc     e
7bcf 00        nop     
7bd0 5f        ld      e,a
7bd1 5a        ld      e,d
7bd2 00        nop     
7bd3 02        ld      (bc),a
7bd4 e3        ex      (sp),hl
7bd5 1b        dec     de
7bd6 04        inc     b
7bd7 5f        ld      e,a
7bd8 4d        ld      c,l
7bd9 55        ld      d,l
7bda 58        ld      e,b
7bdb a6        and     (hl)
7bdc 00        nop     
7bdd 00        nop     
7bde 00        nop     
7bdf 54        ld      d,h
7be0 10f7      djnz    7bd9h
7be2 1b        dec     de
7be3 0b        dec     bc
7be4 4f        ld      c,a
7be5 42        ld      b,d
7be6 53        ld      d,e
7be7 50        ld      d,b
7be8 41        ld      b,c
7be9 52        ld      d,d
7bea 4b        ld      c,e
7beb 53        ld      d,e
7bec 5f        ld      e,a
7bed 49        ld      c,c
7bee 44        ld      b,h
7bef a5        and     l
7bf0 00        nop     
7bf1 00        nop     
7bf2 00        nop     
7bf3 54        ld      d,h
7bf4 1009      djnz    7bffh
7bf6 1c        inc     e
7bf7 09        add     hl,bc
7bf8 49        ld      c,c
7bf9 50        ld      d,b
7bfa 50        ld      d,b
7bfb 4c        ld      c,h
7bfc 45        ld      b,l
7bfd 325f49    ld      (495fh),a
7c00 44        ld      b,h
7c01 a4        and     h
7c02 00        nop     
7c03 00        nop     
7c04 00        nop     
7c05 47        ld      b,a
7c06 101b      djnz    7c23h
7c08 1c        inc     e
7c09 09        add     hl,bc
7c0a 4f        ld      c,a
7c0b 42        ld      b,d
7c0c 52        ld      d,d
7c0d 41        ld      b,c
7c0e 54        ld      d,h
7c0f 325f49    ld      (495fh),a
7c12 44        ld      b,h
7c13 9e        sbc     a,(hl)
7c14 00        nop     
7c15 00        nop     
7c16 00        nop     
7c17 1010      djnz    7c29h
7c19 2c        inc     l
7c1a 1c        inc     e
7c1b 08        ex      af,af'
7c1c 4d        ld      c,l
7c1d 48        ld      c,b
7c1e 41        ld      b,c
7c1f 4e        ld      c,(hl)
7c20 44        ld      b,h
7c21 5f        ld      e,a
7c22 49        ld      c,c
7c23 44        ld      b,h
7c24 9c        sbc     a,h
7c25 00        nop     
7c26 00        nop     
7c27 00        nop     
7c28 41        ld      b,c
7c29 103e      djnz    7c69h
7c2b 1c        inc     e
7c2c 09        add     hl,bc
7c2d 41        ld      b,c
7c2e 54        ld      d,h
7c2f 48        ld      c,b
7c30 45        ld      b,l
7c31 41        ld      b,c
7c32 44        ld      b,h
7c33 5f        ld      e,a
7c34 49        ld      c,c
7c35 44        ld      b,h
7c36 93        sub     e
7c37 00        nop     
7c38 00        nop     
7c39 00        nop     
7c3a 47        ld      b,a
7c3b 1051      djnz    7c8eh
7c3d 1c        inc     e
7c3e 0a        ld      a,(bc)
7c3f 55        ld      d,l
7c40 44        ld      b,h
7c41 4f        ld      c,a
7c42 4c        ld      c,h
7c43 50        ld      d,b
7c44 48        ld      c,b
7c45 325f49    ld      (495fh),a
7c48 44        ld      b,h
7c49 8d        adc     a,l
7c4a 00        nop     
7c4b 00        nop     
7c4c 00        nop     
7c4d 4c        ld      c,h
7c4e 1065      djnz    7cb5h
7c50 1c        inc     e
7c51 0b        dec     bc
7c52 45        ld      b,l
7c53 41        ld      b,c
7c54 4c        ld      c,h
7c55 53        ld      d,e
7c56 41        ld      b,c
7c57 4e        ld      c,(hl)
7c58 54        ld      d,h
7c59 41        ld      b,c
7c5a 5f        ld      e,a
7c5b 49        ld      c,c
7c5c 44        ld      b,h
7c5d 77        ld      (hl),a
7c5e 00        nop     
7c5f 00        nop     
7c60 00        nop     
7c61 41        ld      b,c
7c62 1074      djnz    7cd8h
7c64 1c        inc     e
7c65 0641      ld      b,41h
7c67 49        ld      c,c
7c68 4c        ld      c,h
7c69 5f        ld      e,a
7c6a 49        ld      c,c
7c6b 44        ld      b,h
7c6c 66        ld      h,(hl)
7c6d 00        nop     
7c6e 00        nop     
7c6f 00        nop     
7c70 00        nop     
7c71 1083      djnz    7bf6h
7c73 1c        inc     e
7c74 0641      ld      b,41h
7c76 54        ld      d,h
7c77 325f49    ld      (495fh),a
7c7a 44        ld      b,h
7c7b 5f        ld      e,a
7c7c 00        nop     
7c7d 00        nop     
7c7e 00        nop     
7c7f 00        nop     
7c80 1093      djnz    7c15h
7c82 1c        inc     e
7c83 07        rlca    
7c84 53        ld      d,e
7c85 42        ld      b,d
7c86 49        ld      c,c
7c87 54        ld      d,h
7c88 5f        ld      e,a
7c89 49        ld      c,c
7c8a 44        ld      b,h
7c8b 5d        ld      e,l
7c8c 00        nop     
7c8d 00        nop     
7c8e 00        nop     
7c8f 00        nop     
7c90 10a6      djnz    7c38h
7c92 1c        inc     e
7c93 0a        ld      a,(bc)
7c94 41        ld      b,c
7c95 54        ld      d,h
7c96 46        ld      b,(hl)
7c97 4c        ld      c,h
7c98 59        ld      e,c
7c99 49        ld      c,c
7c9a 4e        ld      c,(hl)
7c9b 5f        ld      e,a
7c9c 49        ld      c,c
7c9d 44        ld      b,h
7c9e 5b        ld      e,e
7c9f 00        nop     
7ca0 00        nop     
7ca1 00        nop     
7ca2 48        ld      c,b
7ca3 10ba      djnz    7c5fh
7ca5 1c        inc     e
7ca6 0b        dec     bc
7ca7 53        ld      d,e
7ca8 48        ld      c,b
7ca9 49        ld      c,c
7caa 50        ld      d,b
7cab 43        ld      b,e
7cac 54        ld      d,h
7cad 52        ld      d,d
7cae 4c        ld      c,h
7caf 5f        ld      e,a
7cb0 49        ld      c,c
7cb1 44        ld      b,h
7cb2 50        ld      d,b
7cb3 00        nop     
7cb4 00        nop     
7cb5 00        nop     
7cb6 09        add     hl,bc
7cb7 10ce      djnz    7c87h
7cb9 1c        inc     e
7cba 0b        dec     bc
7cbb 4f        ld      c,a
7cbc 42        ld      b,d
7cbd 57        ld      d,a
7cbe 41        ld      b,c
7cbf 4c        ld      c,h
7cc0 4b        ld      c,e
7cc1 45        ld      b,l
7cc2 52        ld      d,d
7cc3 5f        ld      e,a
7cc4 49        ld      c,c
7cc5 44        ld      b,h
7cc6 40        ld      b,b
7cc7 00        nop     
7cc8 00        nop     
7cc9 00        nop     
7cca 3610      ld      (hl),10h
7ccc e21c0b    jp      po,0b1ch
7ccf 4b        ld      c,e
7cd0 45        ld      b,l
7cd1 54        ld      d,h
7cd2 53        ld      d,e
7cd3 4d        ld      c,l
7cd4 4f        ld      c,a
7cd5 4b        ld      c,e
7cd6 45        ld      b,l
7cd7 5f        ld      e,a
7cd8 49        ld      c,c
7cd9 44        ld      b,h
7cda 3f        ccf     
7cdb 00        nop     
7cdc 00        nop     
7cdd 00        nop     
7cde 48        ld      c,b
7cdf 10f3      djnz    7cd4h
7ce1 1c        inc     e
7ce2 08        ex      af,af'
7ce3 4f        ld      c,a
7ce4 43        ld      b,e
7ce5 4b        ld      c,e
7ce6 45        ld      b,l
7ce7 54        ld      d,h
7ce8 5f        ld      e,a
7ce9 49        ld      c,c
7cea 44        ld      b,h
7ceb 3000      jr      nc,7cedh
7ced 00        nop     
7cee 00        nop     
7cef 00        nop     
7cf0 1005      djnz    7cf7h
7cf2 1d        dec     e
7cf3 09        add     hl,bc
7cf4 55        ld      d,l
7cf5 44        ld      b,h
7cf6 4f        ld      c,a
7cf7 4c        ld      c,h
7cf8 50        ld      d,b
7cf9 48        ld      c,b
7cfa 5f        ld      e,a
7cfb 49        ld      c,c
7cfc 44        ld      b,h
7cfd 1c        inc     e
7cfe 00        nop     
7cff 00        nop     
7d00 00        nop     
7d01 4e        ld      c,(hl)
7d02 1014      djnz    7d18h
7d04 1d        dec     e
7d05 064f      ld      b,4fh
7d07 43        ld      b,e
7d08 4b        ld      c,e
7d09 5f        ld      e,a
7d0a 49        ld      c,c
7d0b 44        ld      b,h
7d0c 1a        ld      a,(de)
7d0d 00        nop     
7d0e 00        nop     
7d0f 00        nop     
7d10 1010      djnz    7d22h
7d12 25        dec     h
7d13 1d        dec     e
7d14 08        ex      af,af'
7d15 4f        ld      c,a
7d16 42        ld      b,d
7d17 52        ld      d,d
7d18 41        ld      b,c
7d19 54        ld      d,h
7d1a 5f        ld      e,a
7d1b 49        ld      c,c
7d1c 44        ld      b,h
7d1d 14        inc     d
7d1e 00        nop     
7d1f 00        nop     
7d20 00        nop     
7d21 2010      jr      nz,7d33h
7d23 33        inc     sp
7d24 1d        dec     e
7d25 05        dec     b
7d26 41        ld      b,c
7d27 54        ld      d,h
7d28 5f        ld      e,a
7d29 49        ld      c,c
7d2a 44        ld      b,h
7d2b 0d        dec     c
7d2c 00        nop     
7d2d 00        nop     
7d2e 00        nop     
7d2f 1010      djnz    7d41h
7d31 44        ld      b,h
7d32 1d        dec     e
7d33 08        ex      af,af'
7d34 45        ld      b,l
7d35 44        ld      b,h
7d36 55        ld      d,l
7d37 43        ld      b,e
7d38 45        ld      b,l
7d39 5f        ld      e,a
7d3a 49        ld      c,c
7d3b 44        ld      b,h
7d3c 05        dec     b
7d3d 00        nop     
7d3e 00        nop     
7d3f 00        nop     
7d40 00        nop     
7d41 1053      djnz    7d96h
7d43 1d        dec     e
7d44 0641      ld      b,41h
7d46 53        ld      d,e
7d47 48        ld      c,b
7d48 5f        ld      e,a
7d49 49        ld      c,c
7d4a 44        ld      b,h
7d4b 2000      jr      nz,7d4dh
7d4d 00        nop     
7d4e 00        nop     
7d4f 46        ld      b,(hl)
7d50 1062      djnz    7db4h
7d52 1d        dec     e
7d53 0648      ld      b,48h
7d55 5f        ld      e,a
7d56 45        ld      b,l
7d57 44        ld      b,h
7d58 47        ld      b,a
7d59 45        ld      b,l
7d5a 010000    ld      bc,0000h
7d5d 00        nop     
7d5e 1010      djnz    7d70h
7d60 6f        ld      l,a
7d61 1d        dec     e
7d62 04        inc     b
7d63 55        ld      d,l
7d64 4e        ld      c,(hl)
7d65 5f        ld      e,a
7d66 42        ld      b,d
7d67 05        dec     b
7d68 00        nop     
7d69 00        nop     
7d6a 00        nop     
7d6b 02        ld      (bc),a
7d6c 1085      djnz    7cf3h
7d6e 1d        dec     e
7d6f 0d        dec     c
7d70 45        ld      b,l
7d71 46        ld      b,(hl)
7d72 52        ld      d,d
7d73 5f        ld      e,a
7d74 46        ld      b,(hl)
7d75 4c        ld      c,h
7d76 41        ld      b,c
7d77 53        ld      d,e
7d78 48        ld      c,b
7d79 53        ld      d,e
7d7a 50        ld      d,b
7d7b 45        ld      b,l
7d7c 43        ld      b,e
7d7d 04        inc     b
7d7e 00        nop     
7d7f 00        nop     
7d80 00        nop     
7d81 59        ld      e,c
7d82 1099      djnz    7d1dh
7d84 1d        dec     e
7d85 0b        dec     bc
7d86 45        ld      b,l
7d87 46        ld      b,(hl)
7d88 52        ld      d,d
7d89 5f        ld      e,a
7d8a 53        ld      d,e
7d8b 50        ld      d,b
7d8c 45        ld      b,l
7d8d 43        ld      b,e
7d8e 49        ld      c,c
7d8f 41        ld      b,c
7d90 4c        ld      c,h
7d91 03        inc     bc
7d92 00        nop     
7d93 00        nop     
7d94 00        nop     
7d95 49        ld      c,c
7d96 10aa      djnz    7d42h
7d98 1d        dec     e
7d99 08        ex      af,af'
7d9a 45        ld      b,l
7d9b 46        ld      b,(hl)
7d9c 52        ld      d,d
7d9d 5f        ld      e,a
7d9e 42        ld      b,d
7d9f 41        ld      b,c
7da0 43        ld      b,e
7da1 4b        ld      c,e
7da2 02        ld      (bc),a
7da3 00        nop     
7da4 00        nop     
7da5 00        nop     
7da6 5f        ld      e,a
7da7 10be      djnz    7d67h
7da9 1d        dec     e
7daa 0b        dec     bc
7dab 45        ld      b,l
7dac 46        ld      b,(hl)
7dad 52        ld      d,d
7dae 5f        ld      e,a
7daf 42        ld      b,d
7db0 41        ld      b,c
7db1 52        ld      d,d
7db2 42        ld      b,d
7db3 4c        ld      c,h
7db4 4b        ld      c,e
7db5 53        ld      d,e
7db6 010000    ld      bc,0000h
7db9 00        nop     
7dba 46        ld      b,(hl)
7dbb 10d0      djnz    7d8dh
7dbd 1d        dec     e
7dbe 09        add     hl,bc
7dbf 45        ld      b,l
7dc0 46        ld      b,(hl)
7dc1 52        ld      d,d
7dc2 5f        ld      e,a
7dc3 4c        ld      c,h
7dc4 49        ld      c,c
7dc5 56        ld      d,(hl)
7dc6 45        ld      b,l
7dc7 53        ld      d,e
7dc8 00        nop     
7dc9 00        nop     
7dca 00        nop     
7dcb 00        nop     
7dcc 08        ex      af,af'
7dcd 10e1      djnz    7db0h
7dcf 1d        dec     e
7dd0 08        ex      af,af'
7dd1 45        ld      b,l
7dd2 46        ld      b,(hl)
7dd3 52        ld      d,d
7dd4 5f        ld      e,a
7dd5 53        ld      d,e
7dd6 43        ld      b,e
7dd7 48        ld      c,b
7dd8 44        ld      b,h
7dd9 a0        and     b
7dda 02        ld      (bc),a
7ddb 00        nop     
7ddc 00        nop     
7ddd 02        ld      (bc),a
7dde 10f3      djnz    7dd3h
7de0 1d        dec     e
7de1 09        add     hl,bc
7de2 4f        ld      c,a
7de3 4c        ld      c,h
7de4 4c        ld      c,h
7de5 41        ld      b,c
7de6 43        ld      b,e
7de7 54        ld      d,h
7de8 55        ld      d,l
7de9 41        ld      b,c
7dea 4c        ld      c,h
7deb 90        sub     b
7dec 02        ld      (bc),a
7ded 00        nop     
7dee 00        nop     
7def 00        nop     
7df0 1003      djnz    7df5h
7df2 1e07      ld      e,07h
7df4 4f        ld      c,a
7df5 4c        ld      c,h
7df6 4c        ld      c,h
7df7 50        ld      d,b
7df8 4f        ld      c,a
7df9 53        ld      d,e
7dfa 53        ld      d,e
7dfb 60        ld      h,b
7dfc 00        nop     
7dfd 00        nop     
7dfe 00        nop     
7dff 4d        ld      c,l
7e00 54        ld      d,h
7e01 4f        ld      c,a
7e02 41        ld      b,c
7e03 44        ld      b,h
7e04 2020      jr      nz,7e26h
7e06 2020      jr      nz,7e28h
7e08 52        ld      d,d
7e09 45        ld      b,l
7e0a 4c        ld      c,h
7e0b 2000      jr      nz,7e0dh
7e0d 00        nop     
7e0e 00        nop     
7e0f 00        nop     
7e10 00        nop     
7e11 00        nop     
7e12 00        nop     
7e13 00        nop     
7e14 00        nop     
7e15 00        nop     
7e16 67        ld      h,a
7e17 8a        adc     a,d
7e18 91        sub     c
7e19 1b        dec     de
7e1a 13        inc     de
7e1b 50        ld      d,b
7e1c 67        ld      h,a
7e1d b3        or      e
7e1e 00        nop     
7e1f 00        nop     
7e20 54        ld      d,h
7e21 4f        ld      c,a
7e22 41        ld      b,c
7e23 44        ld      b,h
7e24 2020      jr      nz,7e46h
7e26 2020      jr      nz,7e48h
7e28 58        ld      e,b
7e29 52        ld      d,d
7e2a 46        ld      b,(hl)
7e2b 2000      jr      nz,7e2dh
7e2d 00        nop     
7e2e 00        nop     
7e2f 00        nop     
7e30 00        nop     
7e31 00        nop     
7e32 00        nop     
7e33 00        nop     
7e34 00        nop     
7e35 00        nop     
7e36 67        ld      h,a
7e37 8a        adc     a,d
7e38 91        sub     c
7e39 1b        dec     de
7e3a 00        nop     
7e3b 50        ld      d,b
7e3c 1f        rra     
7e3d 1b        dec     de
7e3e 00        nop     
7e3f 00        nop     
7e40 54        ld      d,h
7e41 4f        ld      c,a
7e42 41        ld      b,c
7e43 44        ld      b,h
7e44 2020      jr      nz,7e66h
7e46 2020      jr      nz,7e68h
7e48 53        ld      d,e
7e49 59        ld      e,c
7e4a 4d        ld      c,l
7e4b 2000      jr      nz,7e4dh
7e4d 00        nop     
7e4e 00        nop     
7e4f 00        nop     
7e50 00        nop     
7e51 00        nop     
7e52 00        nop     
7e53 00        nop     
7e54 00        nop     
7e55 00        nop     
7e56 67        ld      h,a
7e57 8a        adc     a,d
7e58 91        sub     c
7e59 1b        dec     de
7e5a 0650      ld      b,50h
7e5c ff        rst     38h
7e5d 82        add     a,d
7e5e 00        nop     
7e5f 00        nop     
7e60 54        ld      d,h
7e61 4f        ld      c,a
7e62 41        ld      b,c
7e63 44        ld      b,h
7e64 2020      jr      nz,7e86h
7e66 2020      jr      nz,7e88h
7e68 24        inc     h
7e69 59        ld      e,c
7e6a 4d        ld      c,l
7e6b 2000      jr      nz,7e6dh
7e6d 00        nop     
7e6e 00        nop     
7e6f 00        nop     
7e70 00        nop     
7e71 00        nop     
7e72 00        nop     
7e73 00        nop     
7e74 00        nop     
7e75 00        nop     
7e76 9b        sbc     a,e
7e77 8a        adc     a,d
7e78 91        sub     c
7e79 1b        dec     de
7e7a 4e        ld      c,(hl)
7e7b 57        ld      d,a
7e7c 00        nop     
7e7d 83        add     a,e
7e7e 00        nop     
7e7f 00        nop     
7e80 54        ld      d,h
7e81 4f        ld      c,a
7e82 41        ld      b,c
7e83 44        ld      b,h
7e84 48        ld      c,b
7e85 49        ld      c,c
7e86 54        ld      d,h
7e87 2052      jr      nz,7edbh
7e89 45        ld      b,l
7e8a 4c        ld      c,h
7e8b 2000      jr      nz,7e8dh
7e8d 00        nop     
7e8e 00        nop     
7e8f 00        nop     
7e90 00        nop     
7e91 00        nop     
7e92 00        nop     
7e93 00        nop     
7e94 00        nop     
7e95 00        nop     
7e96 69        ld      l,c
7e97 8a        adc     a,d
7e98 91        sub     c
7e99 1b        dec     de
7e9a 0f        rrca    
7e9b 51        ld      d,c
7e9c f3        di      
7e9d 3000      jr      nc,7e9fh
7e9f 00        nop     
7ea0 54        ld      d,h
7ea1 4f        ld      c,a
7ea2 41        ld      b,c
7ea3 44        ld      b,h
7ea4 48        ld      c,b
7ea5 49        ld      c,c
7ea6 54        ld      d,h
7ea7 2058      jr      nz,7f01h
7ea9 52        ld      d,d
7eaa 46        ld      b,(hl)
7eab 2000      jr      nz,7eadh
7ead 00        nop     
7eae 00        nop     
7eaf 00        nop     
7eb0 00        nop     
7eb1 00        nop     
7eb2 00        nop     
7eb3 00        nop     
7eb4 00        nop     
7eb5 00        nop     
7eb6 68        ld      l,b
7eb7 8a        adc     a,d
7eb8 91        sub     c
7eb9 1b        dec     de
7eba 08        ex      af,af'
7ebb 51        ld      d,c
7ebc fa0500    jp      m,0005h
7ebf 00        nop     
7ec0 54        ld      d,h
7ec1 4f        ld      c,a
7ec2 41        ld      b,c
7ec3 44        ld      b,h
7ec4 48        ld      c,b
7ec5 49        ld      c,c
7ec6 54        ld      d,h
7ec7 2053      jr      nz,7f1ch
7ec9 59        ld      e,c
7eca 4d        ld      c,l
7ecb 2000      jr      nz,7ecdh
7ecd 00        nop     
7ece 00        nop     
7ecf 00        nop     
7ed0 00        nop     
7ed1 00        nop     
7ed2 00        nop     
7ed3 00        nop     
7ed4 00        nop     
7ed5 00        nop     
7ed6 69        ld      l,c
7ed7 8a        adc     a,d
7ed8 91        sub     c
7ed9 1b        dec     de
7eda 09        add     hl,bc
7edb 51        ld      d,c
7edc 44        ld      b,h
7edd 5c        ld      e,h
7ede 00        nop     
7edf 00        nop     
7ee0 54        ld      d,h
7ee1 4f        ld      c,a
7ee2 41        ld      b,c
7ee3 44        ld      b,h
7ee4 48        ld      c,b
7ee5 49        ld      c,c
7ee6 54        ld      d,h
7ee7 2024      jr      nz,7f0dh
7ee9 59        ld      e,c
7eea 4d        ld      c,l
7eeb 2000      jr      nz,7eedh
7eed 00        nop     
7eee 00        nop     
7eef 00        nop     
7ef0 00        nop     
7ef1 00        nop     
7ef2 00        nop     
7ef3 00        nop     
7ef4 00        nop     
7ef5 00        nop     
7ef6 69        ld      l,c
7ef7 8a        adc     a,d
7ef8 91        sub     c
7ef9 1b        dec     de
7efa 14        inc     d
7efb 51        ld      d,c
7efc 50        ld      d,b
7efd 5c        ld      e,h
7efe 00        nop     
7eff 00        nop     
7f00 53        ld      d,e
7f01 50        ld      d,b
7f02 52        ld      d,d
7f03 49        ld      c,c
7f04 4e        ld      c,(hl)
7f05 54        ld      d,h
7f06 322052    ld      (5220h),a
7f09 45        ld      b,l
7f0a 4c        ld      c,h
7f0b 2000      jr      nz,7f0dh
7f0d 00        nop     
7f0e 00        nop     
7f0f 00        nop     
7f10 00        nop     
7f11 00        nop     
7f12 00        nop     
7f13 00        nop     
7f14 00        nop     
7f15 00        nop     
7f16 6a        ld      l,d
7f17 8a        adc     a,d
7f18 91        sub     c
7f19 1b        dec     de
7f1a 71        ld      (hl),c
7f1b 51        ld      d,c
7f1c e0        ret     po

7f1d 2800      jr      z,7f1fh
7f1f 00        nop     
7f20 53        ld      d,e
7f21 50        ld      d,b
7f22 52        ld      d,d
7f23 49        ld      c,c
7f24 4e        ld      c,(hl)
7f25 54        ld      d,h
7f26 322058    ld      (5820h),a
7f29 52        ld      d,d
7f2a 46        ld      b,(hl)
7f2b 2000      jr      nz,7f2dh
7f2d 00        nop     
7f2e 00        nop     
7f2f 00        nop     
7f30 00        nop     
7f31 00        nop     
7f32 00        nop     
7f33 00        nop     
7f34 00        nop     
7f35 00        nop     
7f36 6a        ld      l,d
7f37 8a        adc     a,d
7f38 91        sub     c
7f39 1b        dec     de
7f3a 1a        ld      a,(de)
7f3b 51        ld      d,c
7f3c 34        inc     (hl)
7f3d 09        add     hl,bc
7f3e 00        nop     
7f3f 00        nop     
7f40 53        ld      d,e
7f41 50        ld      d,b
7f42 52        ld      d,d
7f43 49        ld      c,c
7f44 4e        ld      c,(hl)
7f45 54        ld      d,h
7f46 322053    ld      (5320h),a
7f49 59        ld      e,c
7f4a 4d        ld      c,l
7f4b 2000      jr      nz,7f4dh
7f4d 00        nop     
7f4e 00        nop     
7f4f 00        nop     
7f50 00        nop     
7f51 00        nop     
7f52 00        nop     
7f53 00        nop     
7f54 00        nop     
7f55 00        nop     
7f56 6a        ld      l,d
7f57 8a        adc     a,d
7f58 91        sub     c
7f59 1b        dec     de
7f5a 1b        dec     de
7f5b 51        ld      d,c
7f5c 5d        ld      e,l
7f5d 4f        ld      c,a
7f5e 00        nop     
7f5f 00        nop     
7f60 53        ld      d,e
7f61 50        ld      d,b
7f62 52        ld      d,d
7f63 49        ld      c,c
7f64 4e        ld      c,(hl)
7f65 54        ld      d,h
7f66 322024    ld      (2420h),a
7f69 59        ld      e,c
7f6a 4d        ld      c,l
7f6b 2000      jr      nz,7f6dh
7f6d 00        nop     
7f6e 00        nop     
7f6f 00        nop     
7f70 00        nop     
7f71 00        nop     
7f72 00        nop     
7f73 00        nop     
7f74 00        nop     
7f75 00        nop     
7f76 6a        ld      l,d
7f77 8a        adc     a,d
7f78 91        sub     c
7f79 1b        dec     de
7f7a 75        ld      (hl),l
7f7b 51        ld      d,c
7f7c 60        ld      h,b
7f7d 4f        ld      c,a
7f7e 00        nop     
7f7f 00        nop     
7f80 47        ld      b,a
7f81 41        ld      b,c
7f82 4d        ld      c,l
7f83 45        ld      b,l
7f84 2020      jr      nz,7fa6h
7f86 2020      jr      nz,7fa8h
7f88 52        ld      d,d
7f89 45        ld      b,l
7f8a 4c        ld      c,h
7f8b 2000      jr      nz,7f8dh
7f8d 00        nop     
7f8e 00        nop     
7f8f 00        nop     
7f90 00        nop     
7f91 00        nop     
7f92 00        nop     
7f93 00        nop     
7f94 00        nop     
7f95 00        nop     
7f96 6c        ld      l,h
7f97 8a        adc     a,d
7f98 91        sub     c
7f99 1b        dec     de
7f9a 87        add     a,a
7f9b 51        ld      d,c
7f9c 2d        dec     l
7f9d b2        or      d
7f9e 00        nop     
7f9f 00        nop     
7fa0 47        ld      b,a
7fa1 41        ld      b,c
7fa2 4d        ld      c,l
7fa3 45        ld      b,l
7fa4 2020      jr      nz,7fc6h
7fa6 2020      jr      nz,7fc8h
7fa8 58        ld      e,b
7fa9 52        ld      d,d
7faa 46        ld      b,(hl)
7fab 2000      jr      nz,7fadh
7fad 00        nop     
7fae 00        nop     
7faf 00        nop     
7fb0 00        nop     
7fb1 00        nop     
7fb2 00        nop     
7fb3 00        nop     
7fb4 00        nop     
7fb5 00        nop     
7fb6 6c        ld      l,h
7fb7 8a        adc     a,d
7fb8 91        sub     c
7fb9 1b        dec     de
7fba 7a        ld      a,d
7fbb 51        ld      d,c
7fbc a8        xor     b
7fbd 1600      ld      d,00h
7fbf 00        nop     
7fc0 47        ld      b,a
7fc1 41        ld      b,c
7fc2 4d        ld      c,l
7fc3 45        ld      b,l
7fc4 2020      jr      nz,7fe6h
7fc6 2020      jr      nz,7fe8h
7fc8 53        ld      d,e
7fc9 59        ld      e,c
7fca 4d        ld      c,l
7fcb 2000      jr      nz,7fcdh
7fcd 00        nop     
7fce 00        nop     
7fcf 00        nop     
7fd0 00        nop     
7fd1 00        nop     
7fd2 00        nop     
7fd3 00        nop     
7fd4 00        nop     
7fd5 00        nop     
7fd6 6c        ld      l,h
7fd7 8a        adc     a,d
7fd8 91        sub     c
7fd9 1b        dec     de
7fda 7c        ld      a,h
7fdb 51        ld      d,c
7fdc 53        ld      d,e
7fdd a0        and     b
7fde 00        nop     
7fdf 00        nop     
7fe0 47        ld      b,a
7fe1 41        ld      b,c
7fe2 4d        ld      c,l
7fe3 45        ld      b,l
7fe4 2020      jr      nz,8006h
7fe6 2020      jr      nz,8008h
7fe8 24        inc     h
7fe9 59        ld      e,c
7fea 4d        ld      c,l
7feb 2000      jr      nz,7fedh
7fed 00        nop     
7fee 00        nop     
7fef 00        nop     
7ff0 00        nop     
7ff1 00        nop     
7ff2 00        nop     
7ff3 00        nop     
7ff4 00        nop     
7ff5 00        nop     
7ff6 6d        ld      l,l
7ff7 8a        adc     a,d
7ff8 91        sub     c
7ff9 1b        dec     de
7ffa 96        sub     (hl)
7ffb 51        ld      d,c
7ffc 60        ld      h,b
7ffd a0        and     b
7ffe 00        nop     
7fff 00        nop     
