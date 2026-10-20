// SQ_REG: route the serial-port read through the M10K output register (one
// more clock of read latency, no logic cost). Foreground banks use it;
// background stores keep the unregistered output.
module VRAM_MEM_64Kx8 #(parameter ADDR_WIDTH = 16, parameter SQ_REG = 0, parameter QA_REG = 0, parameter SERIAL_WRITE_DECODE = 0, parameter LANE_WREN_PRE = 0, parameter QSEL_EN = 0, parameter SERIAL_SEGMENT_PRE = 0) (
	input          CLK,
	
	input  [ADDR_WIDTH-1: 1] ADDR,
	input  [15: 0] DATA,
	input          WREN,
	input  [ 1: 0] BE,
	output [15: 0] Q,
	
	input  [ADDR_WIDTH-1: 3] SADDR,
	input  [63: 0] SDATA,
	input          SWREN,
	output [63: 0] SQ,
	input [ADDR_WIDTH-1:3] SADDR_W,
	// LANE_WREN_PRE: per-byte-lane write enables already combined with WREN/BE.
	input [ 1: 0] WREN_LANE,
	// QSEL_EN: this bank is read-selected one clock later when QGATE_D is high;
	// Q is zero otherwise, so a parent merges banks with a plain OR.
	input         QGATE_D,
	input [3:0]   SWREN_SEGMENT
);

	// The 64 Kbyte background stores and 16 Kbyte foreground banks are split along each byte
	// into 5-, 2- and 1-bit RAMs. The 5-bit RAMs use the 10-bit M10K family
	// (2Kx5 / 512x20) and pack 64 blocks into 56; contents, addresses, enables,
	// latency and port behavior are unchanged. Each 16 Kbyte bank needs fourteen
	// blocks instead of sixteen. Smaller stores retain the single RAM.
	generate if (ADDR_WIDTH == 16 || ADDR_WIDTH == 14) begin : sliced
		genvar b, s;
		for (b = 0; b < 2; b = b + 1) begin : lane
			for (s = 0; s < 3; s = s + 1) begin : part
				localparam integer O = b*8 + (s == 0 ? 0 : s == 1 ? 5 : 7);
				localparam integer K = (s == 0 ? 5 : s == 1 ? 2 : 1);
				wire [4*K-1:0] qb;
				VRAM_MEM_SLICE #(.AW(ADDR_WIDTH), .K(K), .MAX_DEPTH(K == 5 ? 2048 : 0), .SQ_REG(SQ_REG), .QA_REG(QA_REG), .SERIAL_WRITE_DECODE(SERIAL_WRITE_DECODE), .QSEL_EN(QSEL_EN), .SERIAL_SEGMENT_PRE(SERIAL_SEGMENT_PRE)) ram (
					.QGATE_D(QGATE_D), .CLK(CLK), .ADDR(ADDR), .DATA(DATA[O +: K]), .WREN(LANE_WREN_PRE ? WREN_LANE[b] : (WREN & BE[b])), .Q(Q[O +: K]),
					.SADDR(SADDR), .SDATA({SDATA[48+O +: K], SDATA[32+O +: K], SDATA[16+O +: K], SDATA[O +: K]}),
					.SWREN(SWREN), .SWREN_SEGMENT(SWREN_SEGMENT), .SQ(qb), .SADDR_W(SADDR_W));
				assign SQ[O +: K]    = qb[0 +: K];
				assign SQ[16+O +: K] = qb[K +: K];
				assign SQ[32+O +: K] = qb[2*K +: K];
				assign SQ[48+O +: K] = qb[3*K +: K];
			end
		end
	end else begin : whole
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
			altsyncram_component.numwords_a = 1 << (ADDR_WIDTH-1),
			altsyncram_component.numwords_b = 1 << (ADDR_WIDTH-3),
			altsyncram_component.operation_mode = "BIDIR_DUAL_PORT",
			altsyncram_component.outdata_aclr_a = "NONE",
			altsyncram_component.outdata_aclr_b = "NONE",
			altsyncram_component.outdata_reg_a = QA_REG ? "CLOCK0" : "UNREGISTERED",
			altsyncram_component.outdata_reg_b = SQ_REG ? "CLOCK0" : "UNREGISTERED",
			altsyncram_component.power_up_uninitialized = "FALSE",
			altsyncram_component.read_during_write_mode_mixed_ports = "DONT_CARE",
			altsyncram_component.read_during_write_mode_port_a = "NEW_DATA_NO_NBE_READ",
			altsyncram_component.read_during_write_mode_port_b = "NEW_DATA_NO_NBE_READ",
			altsyncram_component.widthad_a = ADDR_WIDTH-1,
			altsyncram_component.widthad_b = ADDR_WIDTH-3,
			altsyncram_component.width_a = 16,
			altsyncram_component.width_b = 64,
			altsyncram_component.width_byteena_a = 2,
			altsyncram_component.width_byteena_b = 1,
			altsyncram_component.wrcontrol_wraddress_reg_b = "CLOCK0";

		assign Q = sub_wire0;
		assign SQ = sub_wire1;
	end endgenerate

endmodule


// One bit-slice of VRAM_MEM_64Kx8: port A is K bits wide, port B is the same
// K bits of four consecutive port-A words. MAX_DEPTH 2048 selects 2Kx5/512x20.
module VRAM_MEM_SLICE #(parameter AW = 16, parameter K = 5, parameter MAX_DEPTH = 0, parameter SQ_REG = 0, parameter QA_REG = 0, parameter SERIAL_WRITE_DECODE = 0, parameter QSEL_EN = 0, parameter SERIAL_SEGMENT_PRE = 0) (
	input            CLK,
	input            QGATE_D,
	input  [AW-1: 1] ADDR,
	input  [K-1: 0]  DATA,
	input            WREN,
	output [K-1: 0]  Q,
	input  [AW-1: 3] SADDR,
	input  [4*K-1:0] SDATA,
	input            SWREN,
	output [4*K-1:0] SQ,
	input [AW-1:3] SADDR_W,
	input [3:0]   SWREN_SEGMENT
);

    // AW14's 5-bit slice physically contains four 2048x5 primitives.
    // Decode writes from the write-only address, avoiding the read-source mux
    // in the RAM write-enable cone. Both ports retain the original latency.
    generate if (SERIAL_WRITE_DECODE && AW == 14 && K == 5) begin : explicit_write
        localparam A_BITS = 11;
        localparam B_BITS = A_BITS - 2;
        localparam SEGMENTS = 1 << (AW-1-A_BITS);
        wire [SEGMENTS*K-1:0] qa;
        wire [SEGMENTS*4*K-1:0] qb;
        reg [AW-2-A_BITS:0] a1=0, a2=0, b1=0, b2=0;
        always @(posedge CLK) begin
            a1 <= ADDR[AW-1:A_BITS+1];
            a2 <= a1;
            b1 <= SADDR[AW-1:B_BITS+3];
            b2 <= b1;
        end
        // QSEL_EN: bank gate and segment select folded into one registered
        // one-hot select per segment, so the read mux is a flat AND-OR.
        reg [SEGMENTS-1:0] qs=0;
        always @(posedge CLK)
            for (integer s=0; s<SEGMENTS; s=s+1) qs[s] <= QGATE_D && ADDR[AW-1:A_BITS+1] == s;
        wire [K-1:0] q_flat = (qa[0*K +: K] & {K{qs[0]}}) | (qa[1*K +: K] & {K{qs[1]}}) |
                              (qa[2*K +: K] & {K{qs[2]}}) | (qa[3*K +: K] & {K{qs[3]}});
        assign Q = QSEL_EN ? q_flat : qa[(QA_REG ? a2 : a1)*K +: K];
        assign SQ = qb[(SQ_REG ? b2 : b1)*4*K +: 4*K];
`ifndef SYNTHESIS
        always @(posedge CLK) if (SWREN)
            assert (SADDR_W[AW-1:B_BITS+3] === SADDR[AW-1:B_BITS+3])
                else $fatal(1,"Serial write segment address diverged");
`endif
        genvar segment;
        for (segment=0;segment<SEGMENTS;segment=segment+1) begin : part
	altsyncram	altsyncram_component (
				.clock0 (CLK),
				.address_a (ADDR[A_BITS:1]),
				.data_a (DATA),
				.wren_a (WREN && ADDR[AW-1:A_BITS+1] == segment),
				.q_a (qa[segment*K +: K]),
				.address_b (SADDR[B_BITS+2:3]),
				.data_b (SDATA),
				.wren_b (SERIAL_SEGMENT_PRE ? SWREN_SEGMENT[segment] : (SWREN && SADDR_W[AW-1:B_BITS+3] == segment)),
				.q_b (qb[segment*4*K +: 4*K]),
				.byteena_a (1'b1),
				.byteena_b (1'b1),
				.aclr0 (1'b0),
				.aclr1 (1'b0),
				.addressstall_a (1'b0),
				.addressstall_b (1'b0),
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
		altsyncram_component.clock_enable_input_a = "BYPASS",
		altsyncram_component.clock_enable_input_b = "BYPASS",
		altsyncram_component.clock_enable_output_a = "BYPASS",
		altsyncram_component.clock_enable_output_b = "BYPASS",
		altsyncram_component.indata_reg_b = "CLOCK0",
		altsyncram_component.intended_device_family = "Cyclone V",
		altsyncram_component.lpm_type = "altsyncram",
		altsyncram_component.maximum_depth = 1 << A_BITS,
		altsyncram_component.numwords_a = 1 << A_BITS,
		altsyncram_component.numwords_b = 1 << B_BITS,
		altsyncram_component.operation_mode = "BIDIR_DUAL_PORT",
		altsyncram_component.outdata_aclr_a = "NONE",
		altsyncram_component.outdata_aclr_b = "NONE",
		altsyncram_component.outdata_reg_a = QA_REG ? "CLOCK0" : "UNREGISTERED",
		altsyncram_component.outdata_reg_b = SQ_REG ? "CLOCK0" : "UNREGISTERED",
		altsyncram_component.power_up_uninitialized = "FALSE",
		altsyncram_component.ram_block_type = "M10K",
		altsyncram_component.read_during_write_mode_mixed_ports = "DONT_CARE",
		altsyncram_component.read_during_write_mode_port_a = "NEW_DATA_NO_NBE_READ",
		altsyncram_component.read_during_write_mode_port_b = "NEW_DATA_NO_NBE_READ",
		altsyncram_component.widthad_a = A_BITS,
		altsyncram_component.widthad_b = B_BITS,
		altsyncram_component.width_a = K,
		altsyncram_component.width_b = 4*K,
		altsyncram_component.wrcontrol_wraddress_reg_b = "CLOCK0";

        end
    end else begin : original_geometry
	reg qg=0;
	always @(posedge CLK) qg <= QGATE_D;
	wire [K-1:0] q_raw;
	assign Q = QSEL_EN ? (q_raw & {K{qg}}) : q_raw;
	altsyncram	altsyncram_component (
				.clock0 (CLK),
				.address_a (ADDR),
				.data_a (DATA),
				.wren_a (WREN),
				.q_a (q_raw),
				.address_b (SADDR),
				.data_b (SDATA),
				.wren_b (SWREN),
				.q_b (SQ),
				.byteena_a (1'b1),
				.byteena_b (1'b1),
				.aclr0 (1'b0),
				.aclr1 (1'b0),
				.addressstall_a (1'b0),
				.addressstall_b (1'b0),
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
		altsyncram_component.clock_enable_input_a = "BYPASS",
		altsyncram_component.clock_enable_input_b = "BYPASS",
		altsyncram_component.clock_enable_output_a = "BYPASS",
		altsyncram_component.clock_enable_output_b = "BYPASS",
		altsyncram_component.indata_reg_b = "CLOCK0",
		altsyncram_component.intended_device_family = "Cyclone V",
		altsyncram_component.lpm_type = "altsyncram",
		altsyncram_component.maximum_depth = MAX_DEPTH,
		altsyncram_component.numwords_a = 1 << (AW-1),
		altsyncram_component.numwords_b = 1 << (AW-3),
		altsyncram_component.operation_mode = "BIDIR_DUAL_PORT",
		altsyncram_component.outdata_aclr_a = "NONE",
		altsyncram_component.outdata_aclr_b = "NONE",
		altsyncram_component.outdata_reg_a = QA_REG ? "CLOCK0" : "UNREGISTERED",
		altsyncram_component.outdata_reg_b = SQ_REG ? "CLOCK0" : "UNREGISTERED",
		altsyncram_component.power_up_uninitialized = "FALSE",
		altsyncram_component.ram_block_type = "M10K",
		altsyncram_component.read_during_write_mode_mixed_ports = "DONT_CARE",
		altsyncram_component.read_during_write_mode_port_a = "NEW_DATA_NO_NBE_READ",
		altsyncram_component.read_during_write_mode_port_b = "NEW_DATA_NO_NBE_READ",
		altsyncram_component.widthad_a = AW-1,
		altsyncram_component.widthad_b = AW-3,
		altsyncram_component.width_a = K,
		altsyncram_component.width_b = 4*K,
		altsyncram_component.wrcontrol_wraddress_reg_b = "CLOCK0";

    end endgenerate
endmodule

// q_reg (synchronous read only): add the M10K output register, one more
// clock of read latency at no logic cost; ACLR clears that register.
module VRAM_SHIFTREG
#( parameter addr_width = 8, parameter sync_read = 0, parameter q_reg = 0 )
(
	input                    CLK,
	input                    ACLR,
	input  [addr_width-1: 3] WADDR,
	input  [          63: 0] DATA,
	input  [           7: 0] WREN,
	input  [addr_width-1: 3] RADDR,
	output [          63: 0] Q
);

	generate if (sync_read) begin : sync_read_ram
		// A registered mirror for the blitter. Keep the original asynchronous
		// port for serial transfers; same-clock collisions return the old word.
		// One byte-enabled 64-bit-wide M10K RAM: per-lane inference split this
		// into eight single-lane RAMs that each occupied whole blocks.
		wire [63:0] sub_wire1;
		altsyncram	altsyncram_component (
					.address_a (WADDR),
					.address_b (RADDR),
					.byteena_a (WREN),
					.clock0 (CLK),
					.data_a (DATA),
					.wren_a (|WREN),
					.q_b (sub_wire1),
					.aclr0 (q_reg ? ACLR : 1'b0),
					.aclr1 (1'b0),
					.addressstall_a (1'b0),
					.addressstall_b (1'b0),
					.byteena_b (1'b1),
					.clock1 (1'b1),
					.clocken0 (1'b1),
					.clocken1 (1'b1),
					.clocken2 (1'b1),
					.clocken3 (1'b1),
					.data_b ({64{1'b1}}),
					.eccstatus (),
					.q_a (),
					.rden_a (1'b1),
					.rden_b (1'b1),
					.wren_b (1'b0));
		defparam
			altsyncram_component.address_aclr_b = "NONE",
			altsyncram_component.address_reg_b = "CLOCK0",
			altsyncram_component.byte_size = 8,
			altsyncram_component.clock_enable_input_a = "BYPASS",
			altsyncram_component.clock_enable_input_b = "BYPASS",
			altsyncram_component.clock_enable_output_b = "BYPASS",
			altsyncram_component.intended_device_family = "Cyclone V",
			altsyncram_component.lpm_type = "altsyncram",
			altsyncram_component.numwords_a = 1 << (addr_width-3),
			altsyncram_component.numwords_b = 1 << (addr_width-3),
			altsyncram_component.operation_mode = "DUAL_PORT",
			altsyncram_component.outdata_aclr_b = q_reg ? "CLEAR0" : "NONE",
			altsyncram_component.outdata_reg_b = q_reg ? "CLOCK0" : "UNREGISTERED",
			altsyncram_component.power_up_uninitialized = "FALSE",
			altsyncram_component.ram_block_type = "M10K",
			altsyncram_component.read_during_write_mode_mixed_ports = "OLD_DATA",
			altsyncram_component.widthad_a = addr_width-3,
			altsyncram_component.widthad_b = addr_width-3,
			altsyncram_component.width_a = 64,
			altsyncram_component.width_b = 64,
			altsyncram_component.width_byteena_a = 8;
		assign Q = sub_wire1;
	end else begin : async_read_ram
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
	end endgenerate

endmodule


