module cput_vga_interface#(
parameter DATA_WIDTH = 16,
parameter ADDRESS_WIDTH = 16

)
(
	input rst, px_rst,
	input clk,px_clk,
	input [ADDRESS_WIDTH-1:0] cpu_addr,
	input [DATA_WIDTH-1:0] cpu_din,
	input io_wr,
	input screenbegin,
	input v_sync,

	output [DATA_WIDTH-1:0] reg_data,
	output [3:0] en;
	output reg clr_sem
);

	wire [4:0] addr_b;
	wire [3:0] cnt;
	wire wren_a;
	wire pulseGenS, sclr,c_en;
	reg clr_sem_slow;

	reg [2:0] state_reg;

	parameter IDLE = 3'h0;
	parameter LOAD0 = 3'h1;
	parameter LOAD1 = 3'h2;
	parameter LOAD2 = 3'h3;
	parameter CLR_SEM = 3'h4;

always @(posedge px_clk) begin
	if(px_rst) begin
		
	end else
	//state machine
		case(state_reg)
			IDLE : begin
				if(screenbegin) state_reg <= LOAD0;
				else state_reg <= IDLE;
			end
			LOAD0 : state_reg <= LOAD1;
			LOAD1 : state_reg <= LOAD2;
			LOAD2 : state_reg <= CLR_SEM;
			CLR_SEM : state_reg <= IDLE;
			default : state_reg <= IDLE;
		endcase
	//cntr
	if(c_en) cnt <= (cnt + 4'b1);
	else cnt <= 4'b0;

	

end

always @(posedge clk) begin
	if(rst) begin
		clr_sem <= 1'b0;
	end else begin
		if(pulseGenS) clr_sem <= 1'b0;
		else clr_sem <= clr_sem_slow;
	end
end

always @(*) begin
	//state machine logic
	case(state_reg)
			IDLE : begin
				if(screenbegin) {en,sclr,c_en} = {4'b0001,1'b0, 1'b0};
				else {en,sclr,c_en} = {4'b0000,1'b0, 1'b0}; 
			end
			LOAD0 : {en,sclr,c_en} = {4'b0010,1'b0, 1'b1};
			LOAD1 : {en,sclr,c_en} = {4'b0100,1'b0, 1'b1};
			LOAD2 : {en,sclr,c_en} = {4'b1000,1'b0, 1'b1};
			CLR_SEM : {en,sclr,c_en} = {4'b0000,1'b1, 1'b0};
			default : {en,sclr,c_en} = {4'b0000,1'b0, 1'b0};
	endcase
		
	//latches
	if(v_sync) begin
		clr_sem_slow = 1'b0;
	end else begin
		if(sclr) clr_sem_slow = 1'b1;
	end

	if(screenbegin) begin
		pulseGenS = 1'b0;
	end else begin
		if(clr_sem) pulseGenS = 1;
	end
		
end


IOFunctionDecodeWriteBlock IO_Decode_Blk1(
	//inputs
	.cpu_din(cpu_din),
	.cpu_addr(cpu_addr),
	.io_wr(io_wr),
	.rst(rst),
	.clk(clk),
	//.px_clk(px_clk),
	//outputs
	//.io_dout(sprite_din),
	.we(wren_a)
);


tdp_ram512x16_Pong ram(

	.address_a([ADDRESS_WIDTH-12:0]cpu_addr),
	.address_b(addr_b),	
	.clock_a(clk),
	.clock_b(px_clk),
	.data_a(cpu_din),
	.data_b(),
	.wren_a(wren_a),	
);


endmodule
