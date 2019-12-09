module RAM_stack #( 
		 parameter WIDTH = 16,
		 parameter DEPTH = 512,
		 parameter ADDR_WIDTH = $clog2(DEPTH)
) (
  input wire clk,
  output wire [WIDTH-1:0] rd,
  input wire we,
  input wire [1:0] delta,
  input wire [WIDTH-1:0] wd);

   //Internal Signals
   wire  [ADDR_WIDTH-1:0] 		 wr_addr;
   wire  [ADDR_WIDTH-1:0] 		 rd_addr;
   wire  		 rd_add_enable;
   wire      		 wr_add_enable;
  
   reg [ADDR_WIDTH-1:0]  stack_wr_addr_reg;
   reg [ADDR_WIDTH-1:0]  stack_rd_addr_reg;

   assign wr_add_enable = (|stack_wr_addr_reg || !delta[1]) ? 1'b1 : 1'b0;
   assign rd_add_enable = (|stack_rd_addr_reg || !delta[1]) ? (|stack_wr_addr_reg) : 1'b0;
   assign wr_addr = wr_add_enable ? ({ {(ADDR_WIDTH-2){delta[1]}} ,delta} + stack_wr_addr_reg) : stack_wr_addr_reg;
   assign rd_addr = rd_add_enable ? ({ {(ADDR_WIDTH-2){delta[1]}} ,delta} + stack_rd_addr_reg) : stack_rd_addr_reg;
    
   //Registers
   always @(posedge clk) begin
      stack_wr_addr_reg <= wr_addr;
      stack_rd_addr_reg <= rd_addr;
   end
   
   //Instantiate SRAM
   FIFOsram #(
	  .WIDTH         ( WIDTH          ),
	  .DEPTH         ( DEPTH          ),
	  .INFER         ( 1              )
	  ) StackRAM     (
			  .rst                ( 1'b0                ),
			  
			  .clk_a              ( clk                 ),
			  .addr_a             ( wr_addr             ),  //wr addr
			  .wdata_a            (  wd                 ),  //din
			  .write_en_a         (  we                 ),  //wr
			  .rdata_a            (                     ),  //

			  .clk_b              ( clk                 ),  
			  .addr_b             ( rd_addr             ),  //rd addr
			  .rdata_b            ( rd                  )   //dout
			  );
		   
endmodule
