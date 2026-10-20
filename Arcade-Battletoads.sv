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
	`include "sys/emu_ports.vh"
);

	assign ADC_BUS  = 'Z;

	assign AUDIO_S   = 1;
	assign AUDIO_MIX = status[20:19];

	assign LED_USER  = rom_download | ioctl_wait;
	assign LED_DISK  = 0;
	assign LED_POWER = 0;
	assign BUTTONS   = 2'b00;
	assign VGA_SCALER= 0;
	assign VGA_DISABLE = 0;
	assign HDMI_BLACKOUT = 0;
	assign HDMI_BOB_DEINT = 0;
	assign HDMI_FREEZE = 0;
	assign USER_OUT = '1;
	assign {UART_RTS,UART_TXD,UART_DTR} = 0;
	assign {SD_SCK, SD_MOSI, SD_CS} = 'Z;
	
//	assign {SDRAM_DQ, SDRAM_CLK, SDRAM_CKE,SDRAM_A,SDRAM_BA,SDRAM_DQML,SDRAM_DQMH,SDRAM_nCS,SDRAM_nCAS,SDRAM_nRAS,SDRAM_nWE} = 'Z;

	///////////////////////  CLOCK/RESET  ///////////////////////////////////
	wire clk_sys, clk_mem, clk_sdram_sample, locked;

	pll pll
	(
		.refclk(CLK_50M),
		.rst(0),
		.outclk_0(clk_sys),
		.outclk_1(clk_mem),
		.outclk_2(clk_sdram_sample),
		.locked(locked)
	);

	assign CLK_VIDEO = clk_sys;
	
	wire direct_video;
	// HDMI rotation (framebuffer tap) was removed to free routing room.
	wire rotate_90 = 1'b0;
	// Aspect ratio: Original 4:3, Full Screen, or the MiSTer ARC1/ARC2 presets.
	wire [1:0] ar       = status[122:121];
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
		.ARX((!ar) ? 12'd4 : {10'd0, ar - 2'd1}),
		.ARY((!ar) ? 12'd3 : 12'd0),
		.CROP_SIZE((en216p & vcrop_en) ? 10'd216 : 10'd0),
		.CROP_OFF(voff),
		.SCALE(direct_video ? 3'd0 : status[42:40])
	);

	// The foreground clear runs on clk_mem; synchronize its one-shot completion
	// into clk_sys before it joins the system-wide reset.
	reg [1:0] fg_ddr_ready_sys = 2'b00;
	always @(posedge clk_sys) fg_ddr_ready_sys <= {fg_ddr_ready_sys[0], fg_ddr_ready};
	// Registered: the loader/HPS decode otherwise reaches the CPU clock enables
	// and every reset input combinationally. Reset asserts one clock later.
	reg reset = 1'b1;
	always @(posedge clk_sys) reset <= RESET | buttons[1] | status[0] | rom_download | ~rom_ready |
	             ~fg_ddr_ready_sys[1] | ~locked | (reset & sdr_busy);
	// Same-SYS-edge reset domains: each captures the original D, not the old reset Q.
	(* preserve, dont_merge *) reg reset_bt = 1'b1;
	(* preserve, dont_merge *) reg reset_phase = 1'b1;
	(* preserve, dont_merge *) reg reset_ddr = 1'b1;
	(* preserve, dont_merge *) reg reset_video = 1'b1;
	always @(posedge clk_sys) reset_bt <= RESET | buttons[1] | status[0] | rom_download | ~rom_ready |
	             ~fg_ddr_ready_sys[1] | ~locked | (reset & sdr_busy);
	always @(posedge clk_sys) reset_phase <= RESET | buttons[1] | status[0] | rom_download | ~rom_ready |
	             ~fg_ddr_ready_sys[1] | ~locked | (reset & sdr_busy);
	always @(posedge clk_sys) reset_ddr <= RESET | buttons[1] | status[0] | rom_download | ~rom_ready |
	             ~fg_ddr_ready_sys[1] | ~locked | (reset & sdr_busy);
	always @(posedge clk_sys) reset_video <= RESET | buttons[1] | status[0] | rom_download | ~rom_ready |
	             ~fg_ddr_ready_sys[1] | ~locked | (reset & sdr_busy);
	// Memory-clock copies of the reset and loader status used by the DDR
	// controller and the foreground clear; the 160 MHz logic no longer takes
	// the 80 MHz registers directly. Each changes one memory clock later.
	reg reset_mem = 1'b1;
	reg fg_ddr_clear_init_n = 1'b0;
	// The HPS DDR command slice drops commands while in reset yet reports
	// not-busy, so it must stay live during ROM download and the foreground
	// clear: reset it only until the PLL locks.
	reg reset_ddr_port = 1'b1;
	always @(posedge clk_mem) begin
		reset_ddr_port <= ~locked;
		reset_mem <= reset_ddr;
		fg_ddr_clear_init_n <= locked && rom_ready && !rom_download;
	end

	////////////////////////////  HPS I/O  //////////////////////////////////

	// Status bits: 0 reset; 9-11 scandoubler fx; 19-20 stereo mix; 32 service;
	// 40-42 scaling; 43 OSD pause; 44 NVRAM autosave off; 54 CRT adjust;
	// 55-56 CRT H-size; 60-66 CRT H-position; 67-71 CRT V-shift; 121-122 aspect.

	`include "build_id.v"
	// CRT Adjust OSD ranges (H-Size is a literal 0/-1/-2 list; see bt_crt_adjust).
	localparam integer CRT_HSIZE_MIN=-2, CRT_HSIZE_MAX=0;
	localparam integer CRT_HPOS_MIN=-16, CRT_HPOS_MAX=15, CRT_VPOS_MIN=-16, CRT_VPOS_MAX=15;
	`include "rtl/bt_crt_menu.vh"
	// Layout follows HeavyUnit: Video Settings / Game Settings pages, DIP
	// Switches, Reset. CRT Adjust items need CRT Adjust available (no
	// scandoubler) and On.
	parameter CONF_STR = {
		"Battletoads;;",
		"P1,Video Settings;",
		"P1O[122:121],Aspect ratio,Original,Full Screen,[ARC1],[ARC2];",
		"H0P1O[42:40],Scaling,Normal,V-Integer,HV-Integer-,HV-Integer+,HV-Integer;",
		"P1O[11:9],Scandoubler Fx,None,2x,CRT 25%,CRT 50%,CRT 75%;",
		"H3P1-;",
		"H3P1O[54],CRT Adjust,Off,On;",
		"H3H4P1O[56:55],CRT H-Size,0,-1,-2;",
		"H3H4P1O[66:60],CRT H-Position,",CRT_HPOS_OPTIONS,";",
		"H3H4P1O[71:67],CRT V-Shift,",CRT_VPOS_OPTIONS,";",
		"P2,Game Settings;",
		"P2O[20:19],Stereo Mix,None,25%,50%,100%;",
		"P2O[43],OSD Pause,Off,On;",
		"P2O[44],Autosave NVRAM,On,Off;",
		"P2-;",
		"P2T[32],Service Menu;",
		"-;",
		"DIP;",
		"-;",
		"R[0],Reset;",
		"J1,Attack,Jump,Coin,Start,Service Menu,Pause;",
		"V,v",`BUILD_DATE
	};

	wire  [1:0] buttons;
	wire [127:0] status;
	wire crt_available;
	wire [15:0] status_menumask = {11'd0, !status[54], !crt_available, 2'd0, direct_video};
	wire        forced_scandoubler;
	reg  [31:0] sd_lba;
	reg         sd_rd = 0;
	reg         sd_wr = 0;
	wire        sd_ack;
	wire [12:0] sd_buff_addr;
	wire [15:0] sd_buff_dout;
	wire [15:0] sd_buff_din;
	wire        sd_buff_wr;
	wire        img_mounted;
	wire        img_readonly;
	wire [63:0] img_size;
	wire        ioctl_download;
	wire [26:0] ioctl_addr;
	wire [15:0] ioctl_dout;
	wire        ioctl_wr;
	wire [15:0] ioctl_index;
	wire        ioctl_wait;
	wire        ioctl_upload;
	wire        nvram_upload_req, nvram_pause;
	wire [15:0] nvram_ioctl_din;

	wire [31:0] joy0,joy1,joy2,joy3,joy4,joy5;
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
		.direct_video(direct_video),
		.new_vmode(1'b0),

		.joystick_l_analog_0({joy0_y, joy0_x}),
		.joystick_l_analog_1({joy1_y, joy1_x}),
		.joystick_0(joy0),
		.joystick_1(joy1),
		.joystick_2(joy2),
		.joystick_3(joy3),
		.joystick_4(joy4),
		.joystick_5(joy5),
		.ps2_mouse(ps2_mouse),
		.ps2_key(ps2_key),

		.status(status),
		.status_menumask(status_menumask),
		.status_in({status[127:5],1'b0,status[3:0]}),
		.status_set(rom_download),

		.ioctl_addr(ioctl_addr),
		.ioctl_dout(ioctl_dout),
		.ioctl_wr(ioctl_wr),
		.ioctl_download(ioctl_download),
		.ioctl_index(ioctl_index),
		.ioctl_wait(ioctl_wait),
		.ioctl_upload(ioctl_upload),
		.ioctl_upload_req(nvram_upload_req),
		.ioctl_upload_index(8'd4),
		.ioctl_din(nvram_ioctl_din),

		.sd_lba('{32'd0}),
		.sd_blk_cnt('{6'd0}),
		.sd_rd(sd_rd),
		.sd_wr(sd_wr),
		.sd_ack(sd_ack),
		.sd_buff_addr(sd_buff_addr),
		.sd_buff_dout(sd_buff_dout),
		.sd_buff_din('{16'd0}),
		.sd_buff_wr(sd_buff_wr),

		.img_mounted(img_mounted),
		.img_readonly(img_readonly),
		.img_size(img_size),

		.RTC(RTC),

		.gamma_bus(gamma_bus)
	);


	wire rom_download;
	wire rom_ready;
	wire [27:1] rom_ddr_addr;
	wire [3:0] rom_ddr_we;
	wire [24:0] rom_sample_addr;
	wire rom_sample_we;
	wire [14:0] rom_audio_addr;
	wire rom_audio_we;
	wire [15:0] rom_data;
	reg [7:0] dips_sw1 = 8'hf0; // SW1 bit 3 low enables the three-player cabinet.
	always @(posedge clk_sys) begin
		if (ioctl_wr && ioctl_index == 16'd254 && ioctl_addr == 0)
			dips_sw1 <= ioctl_dout[7:0];
	end
	bt_rom_loader rom_loader
	(
		.clk(clk_sys),
		.ioctl_download(ioctl_download), .ioctl_index(ioctl_index),
		.ioctl_addr(ioctl_addr), .ioctl_dout(ioctl_dout), .ioctl_wr(ioctl_wr),
		.ioctl_wait(ioctl_wait), .ddr_busy(ddr_io_busy), .sdr_busy(sdr_busy),
		.downloading(rom_download), .ready(rom_ready),
		.ddr_addr(rom_ddr_addr), .ddr_we(rom_ddr_we),
		.sample_addr(rom_sample_addr), .sample_we(rom_sample_we),
		.audio_addr(rom_audio_addr), .audio_we(rom_audio_we), .data(rom_data)
	);


	////////////////////////////  SYSTEM  ///////////////////////////////////
	wire [7:0] P1 = {~joy0[7],~joy0[6],~joy0[5],~joy0[4],~joy0[1],~joy0[2],~joy0[0],~joy0[3]};
	wire [7:0] P2 = {~joy1[7],~joy1[6],~joy1[5],~joy1[4],~joy1[1],~joy1[2],~joy1[0],~joy1[3]};
	wire [7:0] P3 = {~joy2[7],~joy2[6],~joy2[5],~joy2[4],~joy2[1],~joy2[2],~joy2[0],~joy2[3]};
	
	wire CE_F, CE_R, VCE_R;
	bt_clock_enables clock_enables(.clk(clk_sys), .reset(reset_phase),
		.ce_f(CE_F), .ce_r(CE_R), .vce(VCE_R));
	reg user_pause = 0, old_pause = 0;
	wire pause_button = joy0[9] | joy1[9] | joy2[9];
	always @(posedge clk_sys) begin
		old_pause <= pause_button;
		if (reset_phase) user_pause <= 0;
		else if (pause_button && !old_pause) user_pause <= ~user_pause;
	end
	// Register the NVRAM/loader request before the CPU phase gate.
	// The gate completes the current R edge; NVRAM requests its upload only
	// after the gate acknowledges that the CPU has halted. Opening the OSD
	// does not pause the game; only the NVRAM save capture halts briefly.
	// OSD Pause (default Off) halts the game while the OSD is open.
	reg osd_pause = 0;
	reg pause_cpu = 0;
	always @(posedge clk_sys) begin
		osd_pause <= OSD_STATUS & status[43];
		pause_cpu <= user_pause | nvram_pause | osd_pause;
	end
	wire CE_F_CPU, CE_R_CPU, cpu_pause_halted;
	wire cpu_pause_ready;
	bt_pause_bridge #(.DISPLAY_SERVICE_PAUSE(1)) cpu_pause_bridge(
	    .clk(clk_sys), .reset(reset_phase), .pause_req(pause_cpu),
	    .raw_ce_f(CE_F), .raw_ce_r(CE_R),
	    .ce_f(CE_F_CPU), .ce_r(CE_R_CPU), .halted(cpu_pause_halted),
	    .pause_ready(cpu_pause_ready));
	
	wire SCLKX2;
	CEGen SCLK_CEGen
	(
		.CLK(clk_sys),
		.RST_N(1/*RST_N*/),
		.IN_CLK(80000000),
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
	wire BT_EWE_ANY;
	bit         BT_ERD;
	bit         BT_ERAM;
	bit         BT_EROM;
	bit         BT_EFG;
	bit         BT_EFG_RDY;
	bit         BT_ENVRAM;
	wire [7:0]  BT_NVRAM_DATA;
	wire        BT_NVRAM_WE;
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

	wire [4:0][22:0] bt_eaddr_candidates;
	wire [4:0] bt_eaddr_select;
	wire bt_fast_we, bt_fast_done;
	wire [27:1] bt_fast_addr;
	wire [63:0] bt_fast_data;
	BT #(.DISPLAY_SERVICE_PAUSE(1), .FG_FAST(1)) BT
	(
		.CLK(clk_sys),
		.CLK2X(clk_mem),
		.RST_N(~reset_bt),
		.EN(DBG_EN),
		
		.SERVICE(~(status[32] | joy0[8] | joy1[8] | joy2[8])),
		
		.CE_F(CE_F_CPU),
		.CE_R(CE_R_CPU),
		.PAUSE_REQUEST(pause_cpu), .CPU_HALTED(cpu_pause_halted),
		.RAW_CE_F(CE_F), .RAW_CE_R(CE_R), .PAUSE_READY(cpu_pause_ready),
		.EFAST_WE(bt_fast_we), .EFAST_ADDR(bt_fast_addr), .EFAST_DATA(bt_fast_data), .EFAST_DONE(bt_fast_done),
		.VCE_R(VCE_R),
		.SCE_F(SCE_F),
		.SCE_R(SCE_R),
		
		.EADDR(BT_EADDR),
		.EADDR_CANDIDATES(bt_eaddr_candidates),.EADDR_SELECT(bt_eaddr_select),
		.NVRAM_ADDR(BT_NVRAM_ADDR),
		.EDATA(BT_EDATA),
		.EDATA_CANDIDATES(bt_edata_candidates), .EDATA_SELECT(bt_edata_select),
		.EWE(BT_EWE),
		.EWE_ANY(BT_EWE_ANY),
		.ERD(BT_ERD),
		.EQ(BT_EQ),
	.NVRAM_Q({24'd0,nvram_q}),
		.FG_DDR_Q(ddr_do),
		.ERAM(BT_ERAM),
		.EROM(BT_EROM),
		.EFG(BT_EFG),
		.EFG_RDY(BT_EFG_RDY),
		.ENVRAM(BT_ENVRAM),
		.NVRAM_DATA(BT_NVRAM_DATA),
		.NVRAM_WE(BT_NVRAM_WE),
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
		.AUDIO_ROM_A(rom_audio_addr),
		.AUDIO_ROM_D(rom_data),
		.AUDIO_ROM_WR(rom_audio_we),
		
		.SW1(dips_sw1),
		.P1(P1),
		.P2(P2),
		.P3(P3),
		
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
	

	// DDR bank mapping retains the original RAM/FG/NVRAM/sprite/ROM priority.
	// Decode each constant address bit directly instead of cascading muxes.
	// BEGIN DDR_BANK_MAP
	wire ddr_bank_fg = !BT_ERAM && BT_EFG;
	wire ddr_bank_nv = !BT_ERAM && !BT_EFG && BT_ENVRAM;
	wire ddr_bank_sp = !BT_ERAM && !BT_EFG && !BT_ENVRAM && BT_ESPR;
	wire ddr_bank_rom = !BT_ERAM && !BT_EFG && !BT_ENVRAM && !BT_ESPR && BT_EROM;
	wire ddr_bank_valid = BT_ERAM || BT_EFG || BT_ENVRAM || BT_ESPR || BT_EROM;
	wire [27:0] ddr_addr = {2'b0,ddr_bank_fg,ddr_bank_nv|ddr_bank_sp,
	                       BT_ERAM|ddr_bank_sp,BT_EADDR[22:21]&{2{ddr_bank_rom}},
	                       BT_EADDR[20:0]&{21{ddr_bank_valid}}};
	// END DDR_BANK_MAP
	
	// Foreground upper halves occupy 0x32000000..0x320fffff in physical DDR.
	wire ddr_wren = BT_ERAM || BT_ESPR || BT_EFG;
	wire ddr_rden = BT_ERAM || BT_ESPR || BT_EROM || BT_EFG;
	wire [7:0] nvram_q;
	wire [12:0] BT_NVRAM_ADDR;
	wire nvram_ready;
	bt_nvram nvram (
		.clk(clk_sys), .new_game(rom_download), .osd_open(OSD_STATUS & ~status[44]),
		.cpu_addr(BT_NVRAM_ADDR), .cpu_data(BT_NVRAM_DATA),
		.cpu_we(BT_NVRAM_WE && CE_R_CPU), .cpu_halted(cpu_pause_halted),
		.cpu_q(nvram_q), .cpu_ready(nvram_ready), .ioctl_download(ioctl_download),
		.ioctl_upload(ioctl_upload), .ioctl_wr(ioctl_wr),
		.ioctl_index(ioctl_index), .ioctl_addr(ioctl_addr),
		.ioctl_dout(ioctl_dout), .ioctl_din(nvram_ioctl_din),
		.upload_req(nvram_upload_req), .pause_cpu(nvram_pause)
	);
	wire mem_ddr_busy, mem_ddr_rd, mem_ddr_we;
	// Register the HPS read data next to the HPS port; the DDR controller's
	// capture registers are placed far from it. One clock of read latency.
	reg [63:0] ddr_dout_r;
	reg        ddr_dout_ready_r = 0;
	always @(posedge clk_mem) begin
		ddr_dout_r <= DDRAM_DOUT;
		ddr_dout_ready_r <= DDRAM_DOUT_READY;
	end
	wire [7:0] mem_ddr_burst, mem_ddr_be;
	wire [28:0] mem_ddr_addr;
	wire [63:0] mem_ddr_data;
	assign DDRAM_CLK = clk_mem;
	
	
	wire [31: 0] ddr_io_do;
	wire         ddr_io_busy;
	wire         fg_ddr_ready;
	wire [27:1]  fg_ddr_clear_addr;
	wire [3:0]   fg_ddr_clear_we;
	reg          fg_ddr_clear_active = 1'b0;
	always @(posedge clk_mem) fg_ddr_clear_active <= rom_ready && !rom_download && !fg_ddr_ready;
	bt_fg_ddr_clear foreground_clear (
		.clk(clk_mem), .init_n(fg_ddr_clear_init_n),
		.io_busy(ddr_io_busy), .io_addr(fg_ddr_clear_addr),
		.io_we(fg_ddr_clear_we), .ready(fg_ddr_ready)
	);
	wire [3:0][31:0] bt_edata_candidates;
	wire [3:0] bt_edata_select;
	wire [31: 0] ddr_do;
	wire         ddr_busy;
	wire [17: 0] ddr_baddr;
	wire         ddr_bwr;
	wire         ddr_brd;
	wire [ 9: 3] ddr_ba;
	wire [63: 0] ddr_bin;
	wire [63: 0] ddr_bout;
	wire         ddr_bte;
	wire [3:0][23:0] ddr_tag_keys;
	wire [3:0] ddr_tag_hit;
	wire [2:0] ddr_read_hit_part;
	bt_ddr_tag_compare tag_compare(.clk(clk_mem),.tags(ddr_tag_keys),.addresses(bt_eaddr_candidates),
		.select_address(bt_eaddr_select),.eram(BT_ERAM),.efg(BT_EFG),
		.envram(BT_ENVRAM),.espr(BT_ESPR),.erom(BT_EROM),.hit(ddr_tag_hit),.hit_part(ddr_read_hit_part));
	// Decode each source's word before the late graphics/CPU address mux.
	// Invalid address classes preserve the original forced-zero address.
	wire [3:0] ddr_read_word;
	genvar request_word_index, address_index;
	generate for (request_word_index=0; request_word_index<4; request_word_index=request_word_index+1) begin : ddr_words
		wire [4:0] word_matches;
		for (address_index=0; address_index<5; address_index=address_index+1) begin : addresses
			assign word_matches[address_index] = bt_eaddr_select[address_index] &&
				bt_eaddr_candidates[address_index][3:2] == request_word_index;
		end
		assign ddr_read_word[request_word_index] = (ddr_bank_valid && |word_matches) ||
			(!ddr_bank_valid && request_word_index == 0);
	end endgenerate
	ddram #(.USE_PREDECODED_TAGS(1), .USE_PREDECODED_WORD(0), .USE_PREDECODED_WE(1), .USE_PREDECODED_MISS(1), .USE_PARALLEL_DIN(1), .FG_FAST(1)) ddram
	(
		.*,
		.DDRAM_CLK(), .DDRAM_BUSY(mem_ddr_busy),
		.DDRAM_DOUT(ddr_dout_r), .DDRAM_DOUT_READY(ddr_dout_ready_r),
		.DDRAM_BURSTCNT(mem_ddr_burst), .DDRAM_ADDR(mem_ddr_addr),
		.DDRAM_DIN(mem_ddr_data), .DDRAM_BE(mem_ddr_be),
		.DDRAM_RD(mem_ddr_rd), .DDRAM_WE(mem_ddr_we),
		.clk(clk_mem),
		.rst(reset_mem),

		//ROM,NVRAM
		.io_addr(fg_ddr_clear_active ? fg_ddr_clear_addr : rom_ddr_addr),
		.io_din (fg_ddr_clear_active ? 32'd0 : {2{rom_data}}),
		.io_we  (fg_ddr_clear_active ? fg_ddr_clear_we : rom_ddr_we),
		.io_rd  (1'b0),
		.io_dout(ddr_io_do),
		.io_busy(ddr_io_busy),
		// Foreground write-transfer beats use the io path only after the
		// power-up foreground clear has released it.
		.fg_we(bt_fast_we && !fg_ddr_clear_active), .fg_addr(bt_fast_addr), .fg_din(bt_fast_data), .fg_done(bt_fast_done),
		
		.sclk(CE_R),
		.addr(ddr_addr[27:1]),
		.din (BT_EDATA),
		.parallel_din(bt_edata_candidates), .parallel_din_sel(bt_edata_select),
		.we  (BT_EWE & {4{ddr_wren}}),
		.rd  (BT_ERD & ddr_rden),
		.dout(ddr_do),
		.cache(ddr_addr[24:23]),
		.external_tag_hit(ddr_tag_hit),.external_read_hit_part(ddr_read_hit_part),
		.external_read_word(ddr_read_word),
		.external_we_any(BT_EWE_ANY && ddr_wren),.tag_keys(ddr_tag_keys),
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
						BT_ENVRAM ? {24'd0,nvram_q} :
						BT_ESPR ? ddr_do :
						ddr_do;
	// Sprite and foreground-hole DDR traffic use SRDY directly; the CPU bus
	// ready depends only on the CPU's own address class.
	assign BT_ERDY = BT_ERAM ? ~ddr_busy :
	                 BT_EFG_RDY ? ~ddr_busy :
	                 BT_EROM ? ~ddr_busy  :
	                 BT_ENVRAM ? nvram_ready :
	                 BT_ESPR ? ~ddr_busy : 
						  1'b1;
	
	wire sdr_busy;
	sdram #(.CONTROLLED_REFRESH(1)) sdram
	(
		.*,
		.init(~locked),
		.clk(clk_sys), // 80 MHz: two-cycle tRCD is 25 ns.
		.sample_clk(clk_sdram_sample),
		.refresh_slot(reset_bt | rom_download | ~rom_ready | SCE_R),
		
		.addr((rom_download | ioctl_wait | ~rom_ready) ? rom_sample_addr : {4'b0000, BSMT_ROM_A}),
		.din(rom_data),
		.dout(BSMT_ROM_DI),
		.rd(rom_ready & ~rom_download & ~reset_bt & BSMT_ROM_RD),
		.wr(rom_sample_we),
		.word(rom_download | ioctl_wait | ~rom_ready),
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
	reg VIDEO_CE;
	// TMS blanking changes at VCE_R. Sample the corresponding palette pixel
	// one system clock later, with its new blanking tags, at the mixer input.
	always @(posedge CLK_VIDEO) begin
		DCLK_OLD <= DCLK;
		VIDEO_CE <= DCLK & ~DCLK_OLD;
	end

	// CRT Adjust sits ahead of the mixer and is only offered without the
	// scandoubler. Settings are registered; Off passes the native signals.
	wire scandoubler_on = scale || forced_scandoubler;
	assign crt_available = !scandoubler_on;
	reg       crt_available_r = 1'b0, crt_enable_r = 1'b0;
	reg [1:0] crt_hsize_r = 2'd0;
	reg signed [6:0] crt_hpos_r = 7'sd0;
	reg signed [4:0] crt_vpos_r = 5'sd0;
	always @(posedge CLK_VIDEO) begin
		crt_available_r <= !scandoubler_on;
		crt_enable_r <= status[54];
		crt_hsize_r <= status[56:55];
		crt_hpos_r <= 7'(crt_menu_decode(int'(status[66:60]),CRT_HPOS_MIN,CRT_HPOS_MAX,7));
		crt_vpos_r <= 5'(crt_menu_decode(int'(status[71:67]),CRT_VPOS_MIN,CRT_VPOS_MAX,5));
	end
	wire       crt_ce;
	wire [7:0] crt_r, crt_g, crt_b;
	wire       crt_hs, crt_vs, crt_hb, crt_vb;
	bt_crt_adjust crt_adjust_path (
		.clk(CLK_VIDEO), .available(crt_available_r), .enable(crt_enable_r),
		.hsize_sel(crt_hsize_r), .hposition(crt_hpos_r), .vposition(crt_vpos_r),
		.ce_in(VIDEO_CE), .r_in(R), .g_in(G), .b_in(B),
		.hs_in(~HS_N), .vs_in(~VS_N), .hb_in(~HBL_N), .vb_in(~VBL_N),
		.ce_out(crt_ce), .r_out(crt_r), .g_out(crt_g), .b_out(crt_b),
		.hs_out(crt_hs), .vs_out(crt_vs), .hb_out(crt_hb), .vb_out(crt_vb)
	);

	bt_video_mixer #(.LINE_LENGTH(512+8), .HALF_DEPTH(0), .GAMMA(1)) video_mixer
	(
		.*,

		.ce_pix(crt_ce),

		.scandoubler(~INTERLACE && (scale || forced_scandoubler)),
		.hq2x(1'b0),  // Ordinary 2x line repeat with native 24-bit pixel buffers.
		.freeze_sync(),

		.VGA_DE(vga_de),
		.R(crt_r),
		.G(crt_g),
		.B(crt_b),

		// Positive pulses.
		.HSync(crt_hs),
		.VSync(crt_vs),
		.HBlank(crt_hb),
		.VBlank(crt_vb)
	);

	// No framebuffer tap: the HPS framebuffer interface stays idle.
	assign FB_EN = 1'b0;
	assign FB_FORMAT = 5'd0;
	assign FB_WIDTH = 12'd0;
	assign FB_HEIGHT = 12'd0;
	assign FB_BASE = 32'd0;
	assign FB_STRIDE = 14'd0;
	assign FB_FORCE_BLANK = 1'b0;
	wire [28:0] rot_addr = 29'd0;
	wire [63:0] rot_data = 64'd0;
	wire [7:0] rot_be = 8'd0;
	wire rot_we = 1'b0;
	bt_video_ddr video_ddr (
		.reset(reset_ddr_port), .video_clk(clk_sys), .mem_clk(clk_mem),
		.rot_we(rot_we), .rot_addr(rot_addr), .rot_data(rot_data), .rot_be(rot_be),
		.mem_burst(mem_ddr_burst), .mem_addr(mem_ddr_addr),
		.mem_data(mem_ddr_data), .mem_be(mem_ddr_be),
		.mem_we(mem_ddr_we), .mem_rd(mem_ddr_rd), .ddr_busy(DDRAM_BUSY),
		.mem_busy(mem_ddr_busy), .ddr_burst(DDRAM_BURSTCNT),
		.ddr_addr(DDRAM_ADDR), .ddr_data(DDRAM_DIN), .ddr_be(DDRAM_BE),
		.ddr_we(DDRAM_WE), .ddr_rd(DDRAM_RD)
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
