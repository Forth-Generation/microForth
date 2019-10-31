module UART_TrRegister_top(
   input wire        clk,
   input wire        reset,
   input wire  [7:0] Data_in,
   input wire        TBR_en,
   input wire        Clear_Valid,
   input wire        Shift,
   input wire        Set,
   input wire        Load,
          
   output reg        TBR_Valid,
   output wire       Tx
);
   
   reg [7:0]   TBR;
   reg [9:0]   TSR;

   assign Tx = Set ? 1'b1 : TSR[0];
   
always @(posedge clk or posedge reset)begin
   if(reset)begin
      {TBR,TSR} <= {8'b0,10'h3ff};
      TBR_Valid <= 1'b0;
   end
   else
     begin
       if(TBR_en)begin
          TBR <= Data_in;
       end
       if(Load)begin
          TSR <= {1'b1,TBR,1'b0};     
       end
       if(Shift) begin
          TSR[8:0] <= TSR[9:1];
          TSR[9] <= 1;
       end
       if(Clear_Valid)  TBR_Valid <= 1'b0;
       else             TBR_Valid <= TBR_en;
     end
   
end
	       
endmodule
   
