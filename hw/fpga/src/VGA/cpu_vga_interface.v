module cpu_vga_interface#(
parameter DATA_WIDTH = 16,
parameter ADDRESS_WIDTH = 16,
parameter INFER = 0

)
(
	input rst, px_rst,
	input clk,px_clk,
	input [ADDRESS_WIDTH-1:0] cpu_addr,
	input [DATA_WIDTH-1:0] cpu_din,
	input io_wr,
	input screenbegin,
	input v_sync,
	input [8:0] sprite_addr,

	output [DATA_WIDTH-1:0] reg_data,
	output loading_loc,
	output reg [5:0] en,
	output reg clr_sem
);

	wire [8:0] addr_b;
	reg [3:0] cnt;
	wire wren_a;
	reg pulseGenS, sclr,c_en;
	reg clr_sem_slow;
	reg [1:0] state_reg;
	reg addr_sel;
	reg shft_en;

localparam IDLE = 2'h0;
localparam LOAD = 2'h1;
localparam CLR_SEM = 2'h2;

assign addr_b = addr_sel ? sprite_addr : {5'h1F,cnt};
assign loading_loc = ~addr_sel;

always @(posedge px_clk) begin
	if(px_rst) begin
		 state_reg <= IDLE; en <= 0;
	end else
	//state machine
		case(state_reg)
			IDLE : begin
				if(screenbegin) state_reg <= LOAD;
				else state_reg <= IDLE;
			end
			LOAD : begin
						if(en[5]) state_reg <= CLR_SEM;
						else state_reg <= LOAD;
					end
			CLR_SEM : state_reg <= IDLE;
			default : state_reg <= IDLE;
		endcase
	//cntr
	if(c_en) cnt <= (cnt + 4'b1);
	else cnt <= 4'b0;

	//enable shft reg
	if(shft_en) begin
		if(~(|en)) en[0] <= 1'b1;
		else en[0] <= 1'b0;
		en[5:1] <= en[4:0];
	end
	
end

always @(posedge clk) begin
	if(rst) begin
		clr_sem <= 1'b0;
		//clr_sem_slow <= 1'b0;
	end else begin
		if(pulseGenS) clr_sem <= 1'b0;
		else clr_sem <= clr_sem_slow;
	end
end

always @(*) begin
	//state machine logic
	addr_sel = 0;
	case(state_reg)
			IDLE : begin
				if(screenbegin) {shft_en,sclr,c_en} = {1'b0,1'b0, 1'b0};
				else {shft_en,sclr,c_en,addr_sel} = {1'b0,1'b0, 1'b0,1'b1}; 
			end
			LOAD :   	begin
								if(en[5]|en[4]) c_en = 1'b0;
								else c_en = 1'b1;
								{shft_en,sclr} = {1'b1,1'b0};
							end
			CLR_SEM : {shft_en,sclr,c_en} = {1'b0,1'b1, 1'b0};
			default : {shft_en,sclr,c_en} = {1'b0,1'b0, 1'b0};
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
//	.cpu_din(cpu_din),
	.cpu_addr(cpu_addr),
	.io_wr(io_wr),
//	.rst(rst),
//	.clk(clk),
	//.px_clk(px_clk),
	//outputs
	//.io_dout(sprite_din),
	.we_mem(wren_a)
);

sram #(
	.WIDTH(16),
   .DEPTH(512),
   .INFER(INFER),
   .TYPE("true_dual_port")
)
tdp_ram512x16 (
		.addr_a(cpu_addr[ADDRESS_WIDTH-8:0]),
		.addr_b(addr_b),	
		.clk_a(clk),
		.clk_b(px_clk),
		.wdata_a(cpu_din),
		.wdata_b(),
		.write_en_a(wren_a),
		.write_en_b(),
		.rdata_a(),
		.rdata_b(reg_data)
	);


endmodule
