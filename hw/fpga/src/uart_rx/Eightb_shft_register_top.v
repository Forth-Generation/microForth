module Eightb_shft_register_top (

   input  wire       reset,
   input  wire       Rx,
   input  wire       load_buffer,
   input  wire       shift,
   input  wire       Rd_en,
   input  wire       clr_ovrflw,
   input  wire       CLOCK,
   
   output reg  [7:0] out,
   output reg        d_valid,
   output reg        overflow
);


   reg    [7:0] out_1;
   
   always @(posedge CLOCK or posedge reset)
     begin
	if(reset)begin
	  out_1 <= 8'b0;
	  out <= 8'b0;
	end
	else
	  begin
	     if(shift) begin
		  out_1 <= {Rx,out_1[7:1]}; 
	       end	 
	     if(load_buffer && Rd_en) begin
		  out <= out_1;	  
	     end
	  end	
     end // always @ (posedge CLOCK or posedge reset)
   
always @(posedge CLOCK)begin //Data Valid and Overflow Flags

      if(Rd_en)  d_valid <= 1'b0;
      else if(load_buffer) d_valid <= 1'b1;
      
      if(clr_ovrflw) overflow <= 1'b0;
      else if(load_buffer && d_valid) overflow <= 1'b1;
  
   end
   
   
endmodule // Eightb_shft_register
