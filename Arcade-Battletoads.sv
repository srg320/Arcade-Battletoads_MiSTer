//============================================================================
//  SNES for MiSTer
//  Copyright (C) 2017-2019 Srg320
//  Copyright (C) 2018-2019 Sorgelig
//
//  This program is free software; you can redistribute it and/or modify it
//  under the terms of the GNU General Public License as published by the Free
//  Software Foundation; either version 2 of the License, or (at your option)
//  any later version.
//
//  This program is distributed in the hope that it will be useful, but WITHOUT
//  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
//  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
//  more details.
//
//  You should have received a copy of the GNU General Public License along
//  with this program; if not, write to the Free Software Foundation, Inc.,
//  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
//============================================================================ 

module emu
(
	//Master input clock
	input         CLK_50M,

	//Async reset from top-level module.
	//Can be used as initial reset.
	input         RESET,

	//Must be passed to hps_io module
	inout  [48:0] HPS_BUS,

	//Base video clock. Usually equals to CLK_SYS.
	output        CLK_VIDEO,

	//Multiple resolutions are supported using different CE_PIXEL rates.
	//Must be based on CLK_VIDEO
	output        CE_PIXEL,

	//Video aspect ratio for HDMI. Most retro systems have ratio 4:3.
	//if VIDEO_ARX[12] or VIDEO_ARY[12] is set then [11:0] contains scaled size instead of aspect ratio.
	output [12:0] VIDEO_ARX,
	output [12:0] VIDEO_ARY,

	output  [7:0] VGA_R,
	output  [7:0] VGA_G,
	output  [7:0] VGA_B,
	output        VGA_HS,
	output        VGA_VS,
	output        VGA_DE,    // = ~(VBlank | HBlank)
	output        VGA_F1,
	output [1:0]  VGA_SL,
	output        VGA_SCALER, // Force VGA scaler

	input  [11:0] HDMI_WIDTH,
	input  [11:0] HDMI_HEIGHT,
	output        HDMI_FREEZE,

`ifdef MISTER_FB
	// Use framebuffer in DDRAM (USE_FB=1 in qsf)
	// FB_FORMAT:
	//    [2:0] : 011=8bpp(palette) 100=16bpp 101=24bpp 110=32bpp
	//    [3]   : 0=16bits 565 1=16bits 1555
	//    [4]   : 0=RGB  1=BGR (for 16/24/32 modes)
	//
	// FB_STRIDE either 0 (rounded to 256 bytes) or multiple of pixel size (in bytes)
	output        FB_EN,
	output  [4:0] FB_FORMAT,
	output [11:0] FB_WIDTH,
	output [11:0] FB_HEIGHT,
	output [31:0] FB_BASE,
	output [13:0] FB_STRIDE,
	input         FB_VBL,
	input         FB_LL,
	output        FB_FORCE_BLANK,

`ifdef MISTER_FB_PALETTE
	// Palette control for 8bit modes.
	// Ignored for other video modes.
	output        FB_PAL_CLK,
	output  [7:0] FB_PAL_ADDR,
	output [23:0] FB_PAL_DOUT,
	input  [23:0] FB_PAL_DIN,
	output        FB_PAL_WR,
`endif
`endif

	output        LED_USER,  // 1 - ON, 0 - OFF.

	// b[1]: 0 - LED status is system status OR'd with b[0]
	//       1 - LED status is controled solely by b[0]
	// hint: supply 2'b00 to let the system control the LED.
	output  [1:0] LED_POWER,
	output  [1:0] LED_DISK,

	// I/O board button press simulation (active high)
	// b[1]: user button
	// b[0]: osd button
	output  [1:0] BUTTONS,

	input         CLK_AUDIO, // 24.576 MHz
	output [15:0] AUDIO_L,
	output [15:0] AUDIO_R,
	output        AUDIO_S,   // 1 - signed audio samples, 0 - unsigned
	output  [1:0] AUDIO_MIX, // 0 - no mix, 1 - 25%, 2 - 50%, 3 - 100% (mono)

	//ADC
	inout   [3:0] ADC_BUS,

	//SD-SPI
	output        SD_SCK,
	output        SD_MOSI,
	input         SD_MISO,
	output        SD_CS,
	input         SD_CD,

	//High latency DDR3 RAM interface
	//Use for non-critical time purposes
	output        DDRAM_CLK,
	input         DDRAM_BUSY,
	output  [7:0] DDRAM_BURSTCNT,
	output [28:0] DDRAM_ADDR,
	input  [63:0] DDRAM_DOUT,
	input         DDRAM_DOUT_READY,
	output        DDRAM_RD,
	output [63:0] DDRAM_DIN,
	output  [7:0] DDRAM_BE,
	output        DDRAM_WE,

	//SDRAM interface with lower latency
	output        SDRAM_CLK,
	output        SDRAM_CKE,
	output [12:0] SDRAM_A,
	output  [1:0] SDRAM_BA,
	inout  [15:0] SDRAM_DQ,
	output        SDRAM_DQML,
	output        SDRAM_DQMH,
	output        SDRAM_nCS,
	output        SDRAM_nCAS,
	output        SDRAM_nRAS,
	output        SDRAM_nWE,

`ifdef MISTER_DUAL_SDRAM
	//Secondary SDRAM
	//Set all output SDRAM_* signals to Z ASAP if SDRAM2_EN is 0
	input         SDRAM2_EN,
	output        SDRAM2_CLK,
	output [12:0] SDRAM2_A,
	output  [1:0] SDRAM2_BA,
	inout  [15:0] SDRAM2_DQ,
	output        SDRAM2_nCS,
	output        SDRAM2_nCAS,
	output        SDRAM2_nRAS,
	output        SDRAM2_nWE,
`endif

	input         UART_CTS,
	output        UART_RTS,
	input         UART_RXD,
	output        UART_TXD,
	output        UART_DTR,
	input         UART_DSR,

	// Open-drain User port.
	// 0 - D+/RX
	// 1 - D-/TX
	// 2..6 - USR2..USR6
	// Set USER_OUT to 1 to read from USER_IN.
	input   [6:0] USER_IN,
	output  [6:0] USER_OUT,

	input         OSD_STATUS
);

	assign ADC_BUS  = 'Z;

	assign AUDIO_S   = 1;
	assign AUDIO_MIX = status[20:19];

	assign LED_USER  = rom0_download | rom1_download | srom_download;
	assign LED_DISK  = 0;
	assign LED_POWER = 0;
	assign BUTTONS   = osd_btn;
	assign VGA_SCALER= 0;
	assign HDMI_FREEZE = 0;
	assign USER_OUT = 'Z;
	assign {UART_RTS,UART_TXD,UART_DTR} = 'Z;
	assign {SD_SCK, SD_MOSI, SD_CS} = 'Z;
	
//	assign {SDRAM_DQ, SDRAM_CLK, SDRAM_CKE,SDRAM_A,SDRAM_BA,SDRAM_DQML,SDRAM_DQMH,SDRAM_nCS,SDRAM_nCAS,SDRAM_nRAS,SDRAM_nWE} = 'Z;

	///////////////////////  CLOCK/RESET  ///////////////////////////////////
	wire clk_sys, clk_mem, locked;

	pll pll
	(
		.refclk(CLK_50M),
		.rst(0),
		.outclk_0(clk_sys),
		.outclk_1(clk_mem),
		.locked(locked)
	);

	assign CLK_VIDEO = clk_sys;
	
	wire [1:0] ar       = '0;//status[33:32];
	wire       vcrop_en = 0;//status[39];
	wire [3:0] vcopt    = '0;//status[38:35];
	reg        en216p;
	reg  [4:0] voff;
	always @(posedge CLK_VIDEO) begin
		en216p <= ((HDMI_WIDTH == 1920) && (HDMI_HEIGHT == 1080) && !forced_scandoubler && !scale);
		voff <= (vcopt < 6) ? {vcopt,1'b0} : ({vcopt,1'b0} - 5'd24);
	end

	wire vga_de;
	video_freak video_freak
	(
		.*,
		.VGA_DE_IN(vga_de),
		.ARX(12'd64),
		.ARY(12'd49),
		.CROP_SIZE((en216p & vcrop_en) ? 10'd216 : 10'd0),
		.CROP_OFF(voff),
		.SCALE(status[41:40])
	);

	wire reset = RESET | buttons[1] | status[0] | ~&load_done;

	////////////////////////////  HPS I/O  //////////////////////////////////

	// Status Bit Map:
	// 0         1         2         3          4         5         6
	// 01234567890123456789012345678901 23456789012345678901234567890123
	// 0123456789ABCDEFGHIJKLMNOPQRSTUV 0123456789ABCDEFGHIJKLMNOPQRSTUV
	// X        XXX       XX            X       XX    

	`include "build_id.v"
	parameter CONF_STR = {
		"Battletoads;;",
		"FS0,BIN,Load btc0-p0;",
		"FS1,BIN,Load btc0-p1;",
		"FS2,BIN,Load btc0-s;",
		"-;",
		"o0,Service button,No,Yes;",
		"-;",
		"P1,Audio & Video;",
		"P1-;",
		"P1O9B,Scandoubler Fx,None,HQ2x,CRT 25%,CRT 50%,CRT 75%;",
		"P1-;",
		"P1o89,Scale,Normal,V-Integer,Narrower HV-Integer,Wider HV-Integer;",
		"P1-;",
		"P1OJK,Stereo Mix,None,25%,50%,100%;", 

		"P2,Input Options;",

		"-;",
		"R0,Reset;",
		"J1,B1,B2,C,Start;",
		"V,v",`BUILD_DATE
	};

	wire  [1:0] buttons;
	wire [63:0] status;
	wire [15:0] status_menumask = {en216p, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1};
	wire        forced_scandoubler;
	reg  [31:0] sd_lba;
	reg         sd_rd = 0;
	reg         sd_wr = 0;
	wire        sd_ack;
	wire  [7:0] sd_buff_addr;
	wire [15:0] sd_buff_dout;
	wire [15:0] sd_buff_din;
	wire        sd_buff_wr;
	wire        img_mounted;
	wire        img_readonly;
	wire [63:0] img_size;
	wire        ioctl_download;
	wire [24:0] ioctl_addr;
	wire [15:0] ioctl_dout;
	wire        ioctl_wr;
	wire  [7:0] ioctl_index;
	wire        ioctl_wait;

	wire [11:0] joy0,joy1,joy2,joy3,joy4;
	wire [24:0] ps2_mouse;
	wire [10:0] ps2_key;

	wire  [7:0] joy0_x,joy0_y,joy1_x,joy1_y;

	wire [64:0] RTC;

	wire [21:0] gamma_bus;

	hps_io #(.CONF_STR(CONF_STR), .WIDE(1)) hps_io
	(
		.clk_sys(clk_sys),
		.HPS_BUS(HPS_BUS),

		.buttons(buttons),
		.forced_scandoubler(forced_scandoubler),
		.new_vmode(new_vmode),

		.joystick_l_analog_0({joy0_y, joy0_x}),
		.joystick_l_analog_1({joy1_y, joy1_x}),
		.joystick_0(joy0),
		.joystick_1(joy1),
		.joystick_2(joy2),
		.joystick_3(joy3),
		.joystick_4(joy4),
		.ps2_mouse(ps2_mouse),
		.ps2_key(ps2_key),

		.status(status),
		.status_menumask(status_menumask),
		.status_in({status[63:5],1'b0,status[3:0]}),
		.status_set(rom0_download),

		.ioctl_addr(ioctl_addr),
		.ioctl_dout(ioctl_dout),
		.ioctl_wr(ioctl_wr),
		.ioctl_download(ioctl_download),
		.ioctl_index(ioctl_index),
		.ioctl_wait(ioctl_wait),

		.sd_lba('{sd_lba}),
		.sd_rd(sd_rd),
		.sd_wr(sd_wr),
		.sd_ack(sd_ack),
		.sd_buff_addr(sd_buff_addr),
		.sd_buff_dout(sd_buff_dout),
		.sd_buff_din('{sd_buff_din}),
		.sd_buff_wr(sd_buff_wr),

		.img_mounted(img_mounted),
		.img_readonly(img_readonly),
		.img_size(img_size),

		.RTC(RTC),

		.gamma_bus(gamma_bus)
	);


//	wire code_index = &ioctl_index;
//	wire code_download = ioctl_download & code_index;
	wire rom0_download = ioctl_download & ioctl_index[5:0] == 6'h00;
	wire rom1_download = ioctl_download & ioctl_index[5:0] == 6'h01;
	wire srom_download = ioctl_download & ioctl_index[5:0] == 6'h02;


	//////////////////////////  ROM DETECT  /////////////////////////////////

	reg        PAL;


	reg osd_btn = 0;
//	always @(posedge clk_sys) begin
//		integer timeout = 0;
//		reg     has_bootrom = 0;
//		reg     last_rst = 0;
//
//		if (RESET) last_rst <= 0;
//		if (status[0]) last_rst <= 1;
//
//		if (rom_download & ioctl_wr & status[0]) has_bootrom <= 1;
//
//		if(last_rst & ~status[0]) begin
//			osd_btn <= 0;
//			if(timeout < 24000000) begin
//				timeout <= timeout + 1;
//				osd_btn <= ~has_bootrom;
//			end
//		end
//	end
	


	////////////////////////////  SYSTEM  ///////////////////////////////////
	wire [7:0] P1 = {~joy0[7],~joy0[6],~joy0[5],~joy0[4],~joy0[1],~joy0[2],~joy0[0],~joy0[3]};
	
	bit CE_F,CE_R;
	always @(posedge clk_sys or posedge reset) begin
		if (reset) begin
			CE_F <= 0;
			CE_R <= 0;
		end
		else begin
			CE_F <= ~CE_F;
			CE_R <= CE_F;
		end
	end
	
	wire VCLKX2;
	CEGen VCLK_CEGen
	(
		.CLK(clk_sys),
		.RST_N(1/*RST_N*/),
		.IN_CLK(64000000),
		.OUT_CLK(10000000*2),
		.CE(VCLKX2)
	);
	
	bit VCE_DIV;
	always @(posedge clk_sys or posedge reset) begin
		if (reset) begin
			VCE_DIV <= 0;
		end
		else if (VCLKX2) begin
			VCE_DIV <= ~VCE_DIV;
		end
	end
	wire VCE_R = VCLKX2 & VCE_DIV;
	
	wire SCLKX2;
	CEGen SCLK_CEGen
	(
		.CLK(clk_sys),
		.RST_N(1/*RST_N*/),
		.IN_CLK(64000000),
		.OUT_CLK(6000000*2),
		.CE(SCLKX2)
	);
	bit SCE_DIV;
	always @(posedge clk_sys or posedge reset) begin
		if (reset) begin
			SCE_DIV <= 0;
		end
		else if (SCLKX2) begin
			SCE_DIV <= ~SCE_DIV;
		end
	end
	wire SCE_F = SCLKX2 & ~SCE_DIV;
	wire SCE_R = SCLKX2 &  SCE_DIV;

	bit [31: 0] BT_LA;
	bit [31: 0] BT_LDI;
	bit [31: 0] BT_LDO;
	bit         BT_RAS_N;
	bit [ 3: 0] BT_CAS_N;
	bit         BT_WE_N;
	bit         BT_QE_N;
	bit         BT_LRDY;
	
	bit [22: 0] BT_EADDR;
	bit [31: 0] BT_EDATA;
	bit [31: 0] BT_EQ;
	bit [ 3: 0] BT_EWE;
	bit         BT_ERD;
	bit         BT_ERAM;
	bit         BT_EROM;
	bit         BT_ENVRAM;
	bit         BT_ESPR;
	bit         BT_ERDY;
	
	bit [20: 0] BSMT_ROM_A;
	bit [ 7: 0] BSMT_ROM_DI;
	bit         BSMT_ROM_RD;

	bit [ 7: 0] R,G,B;
	bit         HS_N;
	bit         VS_N;
	bit         HBL_N;
	bit         VBL_N;

	BT BT
	(
		.CLK(clk_sys),
		.CLK2X(clk_mem),
		.RST_N(~reset),
		.EN(DBG_EN),
		
		.SERVICE(status[32]),
		
		.CE_F(CE_F),
		.CE_R(CE_R),
		.VCE_R(VCE_R),
		.SCE_F(SCE_F),
		.SCE_R(SCE_R),
		
		.EADDR(BT_EADDR),
		.EDATA(BT_EDATA),
		.EWE(BT_EWE),
		.ERD(BT_ERD),
		.EQ(BT_EQ),
		.ERAM(BT_ERAM),
		.EROM(BT_EROM),
		.ENVRAM(BT_ENVRAM),
		.ESPR(BT_ESPR),
		.ERDY(BT_ERDY),
		
		.ESADDR(ddr_baddr),
		.ESDATA(ddr_bin),
		.ESWR(ddr_bwr),
		.ESRD(ddr_brd),
		.ESQ(ddr_bout),
		.ESTE(ddr_bte),
		.SRDY(~ddr_busy),
		
		.BSMT_ROM_A(BSMT_ROM_A),
		.BSMT_ROM_DI(BSMT_ROM_DI),
		.BSMT_ROM_RD(BSMT_ROM_RD),
		
		.SW1(8'h7C),
		.P1(P1),
		.P2(8'hFF),
		.P3(8'hFF),
		
		.R(R),
		.G(G),
		.B(B),
		.HS_N(HS_N),
		.VS_N(VS_N),
		.HBL_N(HBL_N),
		.VBL_N(VBL_N),
		
		.SL(AUDIO_L),
		.SR(AUDIO_R),
		
		.BG_EN(DBG_BG_EN),
		.GRID_EN(DBG_GRID_EN)
	);



	////////////////////////////  MEMORY  ///////////////////////////////////
	wire sdr_busy0, sdr_busy1, sdr_busy2;
	wire [15:0] sdr_do0,sdr_do1,sdr_do2;
	
`ifdef SOUND_EN
	reg [2:0] load_done = 3'b000;
`else
	reg [2:0] load_done = 3'b100;
`endif

	always @(posedge clk_sys) begin
		reg old_ddr_busy, old_sdr_busy;
		reg rom0_dl_old, rom1_dl_old, srom_dl_old;
		
		if ((rom0_download || rom1_download || srom_download) && ioctl_wr) ioctl_wait <= 1;
		
		old_ddr_busy <= ddr_io_busy;
		if (~ddr_io_busy && old_ddr_busy) ioctl_wait <= 0;
		
		old_sdr_busy <= sdr_busy;
		if (~sdr_busy && old_sdr_busy) ioctl_wait <= 0;
		
		rom0_dl_old <= rom0_download; 
		rom1_dl_old <= rom1_download; 
		srom_dl_old <= srom_download;
		if (~rom0_download && rom0_dl_old) load_done[0] <= 1;
		if (~rom1_download && rom1_dl_old) load_done[1] <= 1;
		if (~srom_download && srom_dl_old) load_done[2] <= 1;
	end


	wire [27:0] ddr_addr = BT_ERAM   ? {7'b0000100,BT_EADDR[20:0]} :
	                       BT_ENVRAM ? {7'b0001000,BT_EADDR[20:0]} :
							     BT_ESPR   ? {7'b0001100,BT_EADDR[20:0]} :
							     BT_EROM   ? {5'b00000,  BT_EADDR[22:0]} :
							     28'h0000000;
	
	wire ddr_wren = BT_ERAM || BT_ENVRAM || BT_ESPR;
	wire ddr_rden = BT_ERAM || BT_ENVRAM || BT_ESPR || BT_EROM;
	
	
	wire [31: 0] ddr_io_do;
	wire         ddr_io_busy;
	wire [31: 0] ddr_do;
	wire         ddr_busy;
	wire [17: 0] ddr_baddr;
	wire         ddr_bwr;
	wire         ddr_brd;
	wire [ 9: 3] ddr_ba;
	wire [63: 0] ddr_bin;
	wire [63: 0] ddr_bout;
	wire         ddr_bte;
	ddram ddram
	(
		.*,
		.clk(clk_mem),
		.rst(reset),
	
		//ROM,NVRAM
		.io_addr({2'b00,ioctl_addr[24:1],1'b0}),
		.io_din ({2{ioctl_dout[15:8],ioctl_dout[7:0]}}),
		.io_we  ({{2{rom1_download&ioctl_wr}},{2{rom0_download&ioctl_wr}}}),
		.io_rd  (1'b0),
		.io_dout(ddr_io_do),
		.io_busy(ddr_io_busy),
		
		.sclk(CE_R),
		.addr(ddr_addr[27:1]),
		.din (BT_EDATA),
		.we  (BT_EWE & {4{ddr_wren}}),
		.rd  (BT_ERD & ddr_rden),
		.dout(ddr_do),
		.cache(ddr_addr[24:23]),
		.busy(ddr_busy),
		
		.baddr({7'b0001100,1'b0,ddr_baddr[17:9],2'b00,ddr_baddr[8:1]}),
		.bin(ddr_bin),
		.bout(ddr_bout),
		.bwr  (ddr_bwr),
		.brd  (ddr_brd),
		.ba(ddr_ba),
		.bte(ddr_bte),
		
		.dbg_din()
	);

	assign BT_EQ = BT_ERAM ? ddr_do : 
	               BT_EROM ? ddr_do : 
						BT_ENVRAM ? ddr_do :
						BT_ESPR ? ddr_do :
						ddr_do;
	assign BT_ERDY = BT_ERAM ? ~ddr_busy : 
	                 BT_EROM ? ~ddr_busy  :
	                 BT_ENVRAM ? ~ddr_busy : 
	                 BT_ESPR ? ~ddr_busy : 
						  1'b1;
	
	wire sdr_busy;
	sdram sdram
	(
		.*,
		.init(0), 
		.clk(clk_mem),
		
		.addr(srom_download ? ioctl_addr : BSMT_ROM_A),
		.din(srom_download ? ioctl_dout : '0),
		.dout(BSMT_ROM_DI),
		.rd(~srom_download & BSMT_ROM_RD),
		.wr(srom_download ? ioctl_wr : 1'b0),
		.word(srom_download),
		.busy(sdr_busy)
	);


	////////////////////////////  VIDEO  ////////////////////////////////////
	wire [2:0] scale = status[11:9];
	wire [2:0] sl = scale ? scale - 1'd1 : 3'd0;
	wire interlace = 0;

	wire FIELD = 0;
	wire INTERLACE = 0;
	assign VGA_SL = {~INTERLACE,~INTERLACE} & sl[1:0];
	assign VGA_F1 = FIELD & INTERLACE;

	wire DCLK = VCE_R;
	reg DCLK_OLD;
	always @(posedge CLK_VIDEO) DCLK_OLD <= DCLK;

	video_mixer #(.LINE_LENGTH(512+8), .HALF_DEPTH(0), .GAMMA(1)) video_mixer
	(
		.*,

		.ce_pix(DCLK & ~DCLK_OLD),

		.scandoubler(~INTERLACE && (scale || forced_scandoubler)),
		.hq2x(scale==1),
		.freeze_sync(),

		.VGA_DE(vga_de),
		.R(R),
		.G(G),
		.B(B),

		// Positive pulses.
		.HSync(~HS_N),
		.VSync(~VS_N),
		.HBlank(~HBL_N),
		.VBlank(~VBL_N)
	);


	//debug
	reg [2:0] DBG_BG_EN = '1;
	reg [2:0] DBG_GRID_EN = '0;
	reg       DBG_EN = 1;

`ifdef DEBUG
	wire       pressed = ps2_key[9];
	wire [8:0] code    = ps2_key[8:0];

	always @(posedge clk_sys) begin
		reg old_state = 0;

		old_state <= ps2_key[10];

		if((ps2_key[10] != old_state) && pressed) begin
			casex(code)
				'h005: begin DBG_BG_EN[0] <= ~DBG_BG_EN[0]; end // F1
				'h006: begin DBG_BG_EN[1] <= ~DBG_BG_EN[1]; end // F2
				'h004: begin DBG_BG_EN[2] <= ~DBG_BG_EN[2]; end // F3
				'h00C: begin DBG_GRID_EN[0] <= ~DBG_GRID_EN[0]; end // F4
				'h003: begin DBG_GRID_EN[1] <= ~DBG_GRID_EN[1]; end // F5
				'h177: begin DBG_EN   <= ~DBG_EN;   end // Pause
			endcase
		end
	end
`endif

endmodule
