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
   reg  [ADDR_WIDTH-1:0] 		 wr_addr;
   reg  [ADDR_WIDTH-1:0] 		 rd_addr;
   reg  		 rd_add_enable;
   reg       		 wr_add_enable;
   reg  		 stack_wr_addr_notZero;
  
   reg [ADDR_WIDTH-1:0]  stack_wr_addr_reg;
   reg [ADDR_WIDTH-1:0]  stack_rd_addr_reg;

  always @*
    begin
     //Add Enable Logic   
     if( |stack_wr_addr_reg || delta[1] == 0) begin
        wr_add_enable = 1'b1;
     end else begin
        wr_add_enable = 1'b0;
     end

     stack_wr_addr_notZero = |stack_wr_addr_reg;

     if( |stack_rd_addr_reg || delta[1] == 1'b0) begin
        rd_add_enable = stack_wr_addr_notZero;
     end else begin
        rd_add_enable = 1'b0;
     end

     //Adders
     if(wr_add_enable) begin
        wr_addr = {  {(ADDR_WIDTH-2){delta[1]}} ,delta} + stack_wr_addr_reg;
     end

      if(rd_add_enable) begin
          rd_addr = {  {(ADDR_WIDTH-2){delta[1]}} ,delta} + stack_rd_addr_reg;
      end
   end
   
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
