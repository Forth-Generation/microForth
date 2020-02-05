module UART_TrROM_top#(                                                                              
   parameter WIDTH = 8                                                        
)
(
   input wire 		  CLOCK,
   input wire [3:0] 	  addr,
  //input wire 		  wr_en,
  //input wire [9:0] 	  wr_bitMask, 

   output reg [WIDTH-1:0] data_out
);
   reg [6:0] 		  start;
   reg [WIDTH-1:0] 	  cnt_reg;
   reg [9:0] 		  bitMask; 		  
	  
   
   assign cnt_reg  = {{(WIDTH-8){1'b0}},8'd168};
   assign bitMask = 10'h3df;
   
  
   always @(posedge CLOCK) begin
      //if(wr_en) bitMask <= wr_bitMask;
      data_out = (cnt_reg+{{(WIDTH-1){1'b0}},bitMask[addr]});
   end

endmodule


