module IOFunctionDecodeWriteBlock #(
	parameter DATA_WIDTH = 16,
	parameter ADDRESS_WIDTH = 16,
	parameter BLOCK_SIZE = 4,
	parameter IO_BASE_ADDR = 9'h1F0,
	parameter IO_BASE_MASK = 16'hFFFF << BLOCK_SIZE
) (
	input wire [DATA_WIDTH - 1:0] cpu_din,
	input wire [ADDRESS_WIDTH - 1:0] cpu_addr,
	
	input wire io_wr,
	input wire rst,
	
	input wire clk,
	input wire px_clk,
	
	output reg [DATA_WIDTH - 1:0] io_dout,
	output reg we_0,
	output reg we_1,
	output we_mem
);



wire io_block_decode;
wire io_decode_en;

reg [BLOCK_SIZE - 1:0] io_addr;
reg delayed_strobe;
reg [2:0] sync_reg;

assign io_block_decode = ((cpu_addr & IO_BASE_MASK) == IO_BASE_ADDR) ? io_wr : 0;
assign io_decode_en = ~sync_reg[2] & sync_reg[1];

assign we_mem = io_block_decode;

//Not being used in current design
always @(posedge clk) begin
	
	if(rst) begin
		io_addr <= {BLOCK_SIZE{1'b0}}; delayed_strobe <= 0;
	end else begin
	
		if(io_block_decode) begin
			io_dout <= cpu_din;
			io_addr <= cpu_addr[BLOCK_SIZE - 1:0];
		end
		
		delayed_strobe <= io_block_decode;
	end
end

//Not being used in current design
always @(posedge px_clk) begin
    if(rst) begin
		we_0 <= 0; we_1 <= 0; sync_reg <= 3'b0;
	 end
	 else begin
		sync_reg[0] <= delayed_strobe;
		sync_reg[2:1] <= sync_reg[1:0];
		
		we_0 <= io_decode_en & (io_addr == {BLOCK_SIZE{1'b0}});
		we_1 <= io_decode_en & (io_addr == {{(BLOCK_SIZE-1){1'b0}},1'b1});
		end
end

endmodule