module UART_Tr_top(
   input  wire       clk,
   input  wire       reset,
   input  wire [7:0] Data_in,
   input  wire       TBR_en,
   
   output wire       TBR_Valid,
   output wire       Tx
);

   wire   CO;
   wire   Clear_Valid;
   wire   Shift;
   wire   SetSR;
   wire   LoadSR;
   wire   LC;
   wire [7:0]   Counter_Val;
   wire [3:0]   ROMaddr;
   
   
UART_TrFSM_top FSM1 (//in
		     .clk (clk),
		     .reset (reset),
		     .TBR_Valid (TBR_Valid),
		     .CO (CO),
		     //out
		     .Clear_Valid (Clear_Valid),
		     .Shift (Shift),
		     .LoadSR (LoadSR),
		     .SetSR (SetSR),
		     .LoadCounter (LC),
		     .ROMaddr (ROMaddr));

UART_TrRegister_top Out_Reg (//in
			     .clk (clk),
			     .reset (reset),
			     .Data_in (Data_in),
			     .TBR_en (TBR_en),
			     .Clear_Valid (Clear_Valid),
			     .Shift (Shift),
			     .Set (SetSR),
			     .Load (LoadSR),
			     //out
			     .TBR_Valid (TBR_Valid),
			     .Tx (Tx));

UART_TrROM_top ROM(//in
		   .CLOCK (clk),
		   .addr (ROMaddr),
		   //out
		   .data_out (Counter_Val));

Eightb_dwn_cntr_top Cntr(//in
			 .CLOCK (clk),
			 .reset (reset),
			 .load (LC),
			 .load_value (Counter_Val),
			 //out
			 .CO (CO));
   
   
endmodule
   
   
   
   
