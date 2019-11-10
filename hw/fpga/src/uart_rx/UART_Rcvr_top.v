module UART_Rcvr_top (
  
   input  wire       CLOCK,
   input  wire       reset,
   input  wire       Rx_raw,
   input  wire       Rd_en,
   input  wire       clr_ovrflw,
         
   output wire       d_valid,
   output wire       overflow,
   output wire [7:0] rx_data_out,
   output wire       SFE
);
   

   wire 	f_edge;
   wire         Rx_in;
   wire 	CO;
   wire 	load_buffer; 	
   wire         load_counter;
   wire [3:0] 	ROM_addr;
   wire 	shift;
   wire [7:0] 	load_value;
   
  

   
Rx_register_top Rx_register ( //IN
			      .CLOCK (CLOCK),
			      .Rx_raw (Rx_raw),
			      .reset (reset),
			      //OUT
			      .f_edge (f_edge),
			      .Rx_out (Rx_in)
			      );
   
UART_FSM_top FSM ( //IN
		   .CLOCK (CLOCK),
		   .Rx (Rx_in),
		   .CO (CO),
		   .f_edge (f_edge),
		   .reset (reset),
		   //OUT
		   .load_buffer (load_buffer),
		   .load_counter (load_counter),
		   .ROM_addr (ROM_addr),
		   .shift (shift),
		   .SFE (SFE)
		   );
	  
Eightb_dwn_cntr_top Counter ( //IN
			       .load (load_counter),
			       .load_value (load_value),
			       .reset (reset),
			       .CLOCK (CLOCK),
			       //OUT
			       .CO (CO)
			       );

ROM_FourByEight_top ROM( //IN
			 .CLOCK (CLOCK),
			 .addr (ROM_addr),
			 //OUT
			 .data_out (load_value)
			 );
   
Eightb_shft_register_top Shft_reg ( //IN
				    .CLOCK (CLOCK),
 				    .reset (reset),
				    .Rx (Rx_in),
				    .load_buffer (load_buffer),
				    .shift (shift),
				    .Rd_en (Rd_en),
				    .clr_ovrflw (clr_ovrflw),
				    //OUT
				    .rx_data_out (rx_data_out),
				    .d_valid (d_valid),
				    .overflow (overflow)
				    );
   

    
endmodule // UART_Rcver
