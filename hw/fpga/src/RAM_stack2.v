module RAM_stack2 #( 
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
   wire  [ADDR_WIDTH-1:0]                wr_addr_sig;
   wire  [ADDR_WIDTH-1:0] 		 rd_addr;
   wire  [WIDTH-1:0] 			 rdata_a;
 
   wire  		 rd_add_enable;
   wire      		 wr_add_enable;
   
   wire 		 pop_to_push; 		 
   wire 		 push;
   wire [ADDR_WIDTH-1:0] push_to_pop; 		 
   wire [WIDTH-1:0] 	 RAM_dout;
   
   reg [1:0] 		 delta_br;
   reg [ADDR_WIDTH-1:0]  stack_wr_addr_reg;
   reg [ADDR_WIDTH-1:0]  stack_rd_addr_reg;
   
   
   
   // Logic   
   assign wr_add_enable = (|stack_wr_addr_reg || !delta_br[1]) ? 1'b1 : 1'b0;
   assign rd_add_enable = ((|stack_rd_addr_reg || !delta_br[1])&& !(pop_to_push)) ? (|stack_wr_addr_reg) : 1'b0;
   assign wr_addr = wr_add_enable ? ({ {(ADDR_WIDTH-2){delta_br[1]}} ,delta_br} + stack_wr_addr_reg) : stack_wr_addr_reg;
   assign rd_addr = rd_add_enable ? ({ {(ADDR_WIDTH-2){delta_br[1]}} ,delta_br} + stack_rd_addr_reg + push_to_pop) : stack_rd_addr_reg;
   assign push = ((delta_br == 2'b01));
   assign push_to_pop = ((delta_br[1] == 1'b0) && (delta[1] ==1'b1 )&&(|stack_rd_addr_reg)) ? {(ADDR_WIDTH){1'b1}} : {ADDR_WIDTH{1'b0}};
   assign pop_to_push = (delta_br[1] == 1'b1)&&(delta[1] == 1'b0);
   assign rd = push ? rdata_a : RAM_dout;
 
   //Registers
   always @(posedge clk) begin
      delta_br <= delta;
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
			  .rdata_a            (  rdata_a            ),  //

			  .clk_b              ( clk                 ),  
			  .addr_b             ( rd_addr             ),  //rd addr
			  .rdata_b            ( RAM_dout            )   //dout
			  );
		   
endmodule
