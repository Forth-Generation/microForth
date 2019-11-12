module stack2 #( 
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
   wire [ADDR_WIDTH-1:0] 		 wr_addr;
   wire [ADDR_WIDTH-1:0] 		 rd_addr;
   wire 		 rd_add_enable;
   wire                  wr_add_enable;
   wire 		 stack_wr_addr_notZero; 		 
 
   reg [ADDR_WIDTH-1:0]  stack_wr_addr_reg;
   reg [ADDR_WIDTH-1:0]  stack_rd_addr_reg;

   //Add Enable Logic   
   if(wr_addr != 0 || delta[1] == 0)begin
      assign wr_add_enable = 1'b1;
   end else begin
      assign wr_add_enable = 1'b0;
   end

   assign stack_wr_addr_notZero = stack_wr_addr_reg ? 1'b0 : 1'b1;
   if(rd_addr != 0 || delta[1] == 0)begin
      assign rd_add_enable = stack_wr_addr_notZero;
   end else begin
      assign rd_add_enable = 1'b0;
   end

   //Adders
   if(wr_add_enable) begin
      assign wr_addr = delta + stack_wr_addr_reg;
   end
   if(rd_add_enable) begin
      assign rd_addr = delta + stack_rd_addr_reg;
   end
   
   //Registers
   always(@posedge clk)begin
      stack_wr_addr_reg <= wr_addr;
      stack_rd_addr_reg <= rd_addr;
   end
   
   //Instantiate SRAM
   sram #(
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
