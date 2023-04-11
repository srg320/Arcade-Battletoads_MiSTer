module ddram
(
	output         DDRAM_CLK,
	input          DDRAM_BUSY,
	output [ 7: 0] DDRAM_BURSTCNT,
	output [28: 0] DDRAM_ADDR,
	input  [63: 0] DDRAM_DOUT,
	input          DDRAM_DOUT_READY,
	output         DDRAM_RD,
	output [63: 0] DDRAM_DIN,
	output [ 7: 0] DDRAM_BE,
	output         DDRAM_WE,
	
	input          clk,
	input          rst,
	
	input  [27: 1] io_addr,
	output [31: 0] io_dout,
	input  [31: 0] io_din,
	input          io_rd,
	input  [ 3: 0] io_we,
	output         io_busy,

	input          sclk,
	input  [27: 1] addr,
	output [31: 0] dout,
	input  [31: 0] din,
	input          rd,
	input  [ 3: 0] we,
	input  [ 1: 0] cache,
	output         busy,
	
	input  [27: 1] baddr,
	input  [63: 0] bin,
	output [63: 0] bout,
	input          bwr,
	input          brd,
	output [ 9: 3] ba,
	output         bte,
	
	output [31: 0] dbg_din
);

	reg  [ 27:  1] ram_address;
	reg  [ 63:  0] ram_din;
	reg  [  7:  0] ram_ba;
	reg  [  7:  0] ram_burst;
	reg            ram_read = 0;
	reg            ram_write = 0;
	
	reg            burst_read_busy = 0;
	reg            burst_write_busy = 0;
	reg            read_busy = 0;
	reg            write_pend = 0;
	reg            write_busy = 0;
	reg            io_read_busy = 0;
	reg            io_write_busy = 0;

	reg  [ 27:  1] burst_addr;
	reg  [ 27:  1] write_addr;
	reg  [ 31:  0] write_data;
	reg  [  3:  0] write_be;
	reg  [ 27:  1] read_addr[4] = '{4{'1}};
	reg  [  1:  0] read_cache;
	reg  [ 31:  0] rbuf[4][4] = '{4{ '{4{'1}} }};
	reg  [ 27:  1] io_write_addr;
	reg  [ 31:  0] io_write_data;
	reg  [  3:  0] io_write_be;
	reg  [ 27:  1] io_read_addr;
	reg  [ 31:  0] io_rbuf;

	reg  [  2:  0] state = 0;

	always @(posedge clk) begin
		bit old_io_rd, old_io_we;
		bit old_brd, old_bwr, old_rd, old_we;
		bit write_prepend;
		bit [6:0] rpos;
		
		old_bwr <= bwr;
		old_brd <= brd;
		old_rd <= rd;
		old_we <= |we;
		if (rst) begin
			burst_write_busy <= 0;
		end else if (bwr && !old_bwr) begin
			burst_addr <= baddr;
			burst_write_busy <= 1;
		end
		if (rst) begin
			burst_read_busy <= 0;
		end else if (brd && !old_brd) begin
			burst_addr <= baddr;
			burst_read_busy <= 1;
		end
		
		if (rst) begin
			read_addr <= '{4{'1}};
			read_busy <= 0;
		end else if (rd && !old_rd) begin
			read_addr[cache] <= addr;
			read_cache <= cache;
			if (read_addr[cache][27:4] != addr[27:4]) begin
				read_busy <= 1;
			end
		end
		
		if (rst) begin
			write_prepend <= 0;
			write_busy <= 0;
		end else if (|we && !old_we) begin
			write_prepend <= 1;
			write_busy <= |state;
		end
		
		if (rst) begin
			write_pend <= 0;
		end else if (write_prepend && sclk) begin
			write_prepend <= 0;
			if (read_addr[cache][27:4] == addr[27:4]) begin
				if (we[3]) rbuf[cache][addr[3:2]][31:24] <= din[31:24];
				if (we[2]) rbuf[cache][addr[3:2]][23:16] <= din[23:16];
				if (we[1]) rbuf[cache][addr[3:2]][15: 8] <= din[15: 8];
				if (we[0]) rbuf[cache][addr[3:2]][ 7: 0] <= din[ 7: 0];
			end else begin
				read_addr[cache] <= '1;
			end
			write_addr <= addr;
			write_data <= din;
			write_be <= we;
			write_pend <= 1;
			if (addr == 27'h4001EA)
				dbg_din <= din;
		end
		
		old_io_rd <= io_rd;
		old_io_we <= |io_we;
		if (io_rd && !old_io_rd) begin
			io_read_addr <= io_addr;
			io_read_busy <= 1;
		end
		if (|io_we && !old_io_we) begin
			io_write_addr <= io_addr;
			io_write_data <= io_din;
			io_write_be <= io_we;
			io_write_busy <= 1;
		end
		
		bte <= 0;
		if(!DDRAM_BUSY) begin
			ram_write <= 0;
			ram_read  <= 0;
			case (state)
				0: begin
					if (burst_write_busy) begin 
//						ram_address <= {burst_addr[27:3],2'b00};
//						ram_din		<= bin;
						ram_ba      <= 8'hFF;
//						ram_write 	<= 1;
						ram_burst   <= 1;
						rpos <= '0;
						state       <= 3'h1;
					end
					else if (burst_read_busy) begin 
						ram_address <= {burst_addr[27:3],2'b00};
						ram_ba      <= 8'hFF;
						ram_read 	<= 1;
						ram_burst   <= 128;
						rpos <= '0;
						state       <= 3'h2;
					end
					else if (write_pend) begin 
						write_pend <= 0;
						write_busy <= 0;
						ram_address <= {write_addr[27:3],2'b00};
						ram_din		<= {2{write_data}};
						ram_ba      <= !write_addr[2] ? {write_be,4'b0000} : {4'b0000,write_be};
						ram_write 	<= 1;
						ram_burst   <= 1;
						state       <= 3'h3;
					end
					else if (read_busy) begin 
						ram_address <= {read_addr[read_cache][27:4],3'b000};
						ram_ba      <= 8'hFF;
						ram_read    <= 1;
						ram_burst   <= 2;
						rpos <= '0;
						state       <= 3'h4;
					end
					else if (io_write_busy) begin 
						ram_address <= {io_write_addr[27:3],2'b00};
						ram_din		<= {2{io_write_data}};
						ram_ba      <= !io_write_addr[2] ? {io_write_be,4'b0000} : {4'b0000,io_write_be};
						ram_write 	<= 1;
						ram_burst   <= 1;
						state       <= 3'h5;
					end
					else if (io_read_busy) begin 
						ram_address <= {io_read_addr[27:3],2'b00};
						ram_ba      <= 8'hFF;
						ram_read    <= 1;
						ram_burst   <= 1;
						rpos <= '0;
						state       <= 3'h6;
					end
				end
				
				1: begin
					ram_address <= {burst_addr[27:3],2'b00};
					ram_din		<= bin;
					ram_write 	<= 1;
					ba <= rpos;
					bte <= 1;
					rpos <= rpos + 7'd1;
					state <= 7;
					if (rpos == 7'd127) begin
						burst_write_busy <= 0;
						state <= 0;
					end
				end
				
				7: begin
					burst_addr <= burst_addr + 27'd4;
					state <= 1;
				end
				
				2: if (DDRAM_DOUT_READY) begin
					bout <= DDRAM_DOUT;
					ba <= rpos;
					bte <= 1;
					rpos <= rpos + 7'd1;
					if (rpos == 7'd127) begin
						burst_read_busy <= 0;
						state <= 0;
					end
				end
				
				3: begin
					state <= 0;
				end
				
				4: if (DDRAM_DOUT_READY) begin
					{rbuf[read_cache][rpos],rbuf[read_cache][rpos+1]} <= DDRAM_DOUT;
					rpos <= rpos + 7'd2;
					if (rpos == 7'd2) begin
						read_busy <= 0;
						state <= 0;
					end
				end
				
				5: begin
					io_write_busy <= 0;
					state <= 0;
				end
				
				6: if (DDRAM_DOUT_READY) begin
					io_rbuf <= !io_write_addr[2] ? DDRAM_DOUT[63:32] : DDRAM_DOUT[31:0];
					io_read_busy <= 0;
					state <= 0;
				end
			endcase
		end
	end

	assign dout = rbuf[read_cache][read_addr[read_cache][3:2]];
	assign busy = burst_read_busy | burst_write_busy | write_busy | read_busy;
	
	assign io_dout = io_rbuf;
	assign io_busy = io_read_busy | io_write_busy;
	
	assign DDRAM_CLK      = clk;
	assign DDRAM_BURSTCNT = ram_burst;
	assign DDRAM_BE       = ram_ba;
	assign DDRAM_ADDR     = {4'b0011, ram_address[27:3]}; // RAM at 0x30000000
	assign DDRAM_RD       = ram_read;
	assign DDRAM_DIN      = ram_din;
	assign DDRAM_WE       = ram_write;

endmodule
