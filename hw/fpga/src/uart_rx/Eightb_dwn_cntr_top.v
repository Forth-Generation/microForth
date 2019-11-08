module Eightb_dwn_cntr_top (
   input  wire       load,
   input  wire [7:0] load_value,
   input  wire       reset,       
   input  wire       CLOCK,

   output reg        CO
);

//
   reg [7:0]   count;
 	          
   always @(posedge CLOCK or posedge reset)
     begin
	if(reset) begin
	  count <= 8'b0;
	end
	else begin
	   
	   if(count == 8'b1)begin
	      CO <= 1; 
	   end
	   else begin
               CO <= 0; 
	   end
	   if(load) begin
	     count <=load_value;
	     CO <= 0;
	   end
	   
	   else if(count != 8'b0) begin
	      count <= count - 8'd1;
	   end
	end
     end
   
   
   
endmodule
