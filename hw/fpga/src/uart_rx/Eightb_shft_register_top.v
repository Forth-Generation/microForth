module Eightb_shft_register_top (

   input  wire       reset,
   input  wire       Rx,
   input  wire       load_buffer,
   input  wire       shift,
   input  wire       Rd_en,
   input  wire       clr_ovrflw,
   input  wire       CLOCK,
   
   output reg  [7:0] rx_data_out,
   output reg        d_valid,
   output reg        overflow
);


   reg    [7:0] buffer_reg;
   
   always @(posedge CLOCK or posedge reset)
     begin
	if(reset)begin         //Clear Registers on reset
	  buffer_reg <= 8'b0;
	  rx_data_out <= 8'b0;
	end
	else
	  begin
	     if(shift) begin
          buffer_reg <= {Rx,buffer_reg[7:1]};   //Shift Rx data into buffer reg
	       end	 
	     if(load_buffer && Rd_en) begin
          rx_data_out <= buffer_reg;	  
	     end
	  end	
     end // always @ (posedge CLOCK or posedge reset)
   
always @(posedge CLOCK or posedge reset)begin //Data Valid and Overflow Flags

      if(reset)begin
	 d_valid <= 1'b0;
	 overflow <= 1'b0;
      end else begin 
	   if(Rd_en)  d_valid <= 1'b0;
	   else if(load_buffer) d_valid <= 1'b1;
      
	   if(clr_ovrflw) overflow <= 1'b0;
	   else if(load_buffer && d_valid) overflow <= 1'b1;
  
      end
   end
   
endmodule // Eightb_shft_register
