module VRAM_MEM_64Kx8 (
	input          CLK,
	
	input  [15: 1] ADDR,
	input  [15: 0] DATA,
	input          WREN,
	input  [ 1: 0] BE,
	output [15: 0] Q,
	
	input  [15: 3] SADDR,
	input  [63: 0] SDATA,
	input          SWREN,
	output [63: 0] SQ
);

	wire [15:0] sub_wire0;
	wire [63:0] sub_wire1;

	altsyncram	altsyncram_component (
				.byteena_a (BE),
				.clock0 (CLK),
				.wren_a (WREN),
				.address_b (SADDR),
				.data_b (SDATA),
				.wren_b (SWREN),
				.address_a (ADDR),
				.data_a (DATA),
				.q_a (sub_wire0),
				.q_b (sub_wire1),
				.aclr0 (1'b0),
				.aclr1 (1'b0),
				.addressstall_a (1'b0),
				.addressstall_b (1'b0),
				.byteena_b (1'b1),
				.clock1 (1'b1),
				.clocken0 (1'b1),
				.clocken1 (1'b1),
				.clocken2 (1'b1),
				.clocken3 (1'b1),
				.eccstatus (),
				.rden_a (1'b1),
				.rden_b (1'b1));
	defparam
		altsyncram_component.address_reg_b = "CLOCK0",
		altsyncram_component.byte_size = 8,
		altsyncram_component.clock_enable_input_a = "BYPASS",
		altsyncram_component.clock_enable_input_b = "BYPASS",
		altsyncram_component.clock_enable_output_a = "BYPASS",
		altsyncram_component.clock_enable_output_b = "BYPASS",
		altsyncram_component.indata_reg_b = "CLOCK0",
		altsyncram_component.intended_device_family = "Cyclone V",
		altsyncram_component.lpm_type = "altsyncram",
		altsyncram_component.numwords_a = 32768,
		altsyncram_component.numwords_b = 8192,
		altsyncram_component.operation_mode = "BIDIR_DUAL_PORT",
		altsyncram_component.outdata_aclr_a = "NONE",
		altsyncram_component.outdata_aclr_b = "NONE",
		altsyncram_component.outdata_reg_a = "UNREGISTERED",
		altsyncram_component.outdata_reg_b = "UNREGISTERED",
		altsyncram_component.power_up_uninitialized = "FALSE",
		altsyncram_component.read_during_write_mode_mixed_ports = "DONT_CARE",
		altsyncram_component.read_during_write_mode_port_a = "NEW_DATA_NO_NBE_READ",
		altsyncram_component.read_during_write_mode_port_b = "NEW_DATA_NO_NBE_READ",
		altsyncram_component.widthad_a = 15,
		altsyncram_component.widthad_b = 13,
		altsyncram_component.width_a = 16,
		altsyncram_component.width_b = 64,
		altsyncram_component.width_byteena_a = 2,
		altsyncram_component.width_byteena_b = 1,
		altsyncram_component.wrcontrol_wraddress_reg_b = "CLOCK0";

	assign Q = sub_wire0;
	assign SQ = sub_wire1;

endmodule


module VRAM_SHIFTREG 
#( parameter addr_width = 8 )
(
	input                    CLK,
	input  [addr_width-1: 3] WADDR,
	input  [          63: 0] DATA,
	input  [           7: 0] WREN,
	input  [addr_width-1: 3] RADDR,
	output [          63: 0] Q
);

	wire [63:0] sub_wire0;
		
	altdpram	altdpram_component (
				.data (DATA),
				.inclock (CLK),
				.outclock (CLK),
				.rdaddress (RADDR),
				.wraddress (WADDR),
				.wren (|WREN),
				.q (sub_wire0),
				.aclr (1'b0),
				.byteena (WREN),
				.inclocken (1'b1),
				.outclocken (1'b1),
				.rdaddressstall (1'b0),
				.rden (1'b1),
//				.sclr (1'b0),
				.wraddressstall (1'b0));
	defparam
		altdpram_component.indata_aclr = "OFF",
		altdpram_component.indata_reg = "INCLOCK",
		altdpram_component.intended_device_family = "Cyclone V",
		altdpram_component.lpm_type = "altdpram",
		altdpram_component.outdata_aclr = "OFF",
		altdpram_component.outdata_reg = "UNREGISTERED",
		altdpram_component.ram_block_type = "MLAB",
		altdpram_component.rdaddress_aclr = "OFF",
		altdpram_component.rdaddress_reg = "UNREGISTERED",
		altdpram_component.rdcontrol_aclr = "OFF",
		altdpram_component.rdcontrol_reg = "UNREGISTERED",
		altdpram_component.read_during_write_mode_mixed_ports = "CONSTRAINED_DONT_CARE",
		altdpram_component.width = 64,
		altdpram_component.widthad = addr_width-3,
		altdpram_component.byte_size = 8,
		altdpram_component.width_byteena = 8,
		altdpram_component.wraddress_aclr = "OFF",
		altdpram_component.wraddress_reg = "INCLOCK",
		altdpram_component.wrcontrol_aclr = "OFF",
		altdpram_component.wrcontrol_reg = "INCLOCK";
		
	assign Q = sub_wire0;

endmodule


