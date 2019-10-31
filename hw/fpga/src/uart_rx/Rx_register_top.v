module Rx_register_top (
   input  wire CLOCK,
   input  wire Rx_raw,
   input  wire reset,
   output reg  f_edge,
   output reg  Rx_out
);   
   
   reg  Rx_intermediate;

   always @(posedge CLOCK or posedge reset)
     begin
        if(reset)
          begin
            Rx_intermediate <= 1'b0;
            Rx_out <= 1'b0;
            f_edge <= 1'b0;
         end
        else
          begin
             Rx_intermediate <= Rx_raw;
             Rx_out <= Rx_intermediate;
             f_edge <= (~Rx_intermediate) & Rx_out;
          end
     end

endmodule     
