module UART_TrFSM_top(
   input  wire       clk, 
   input  wire       reset,
   input  wire       TBR_Valid,
   input  wire       CO,
   output wire       Clear_Valid,
   output wire       Shift,
   output wire       LoadSR,
   output wire       SetSR,
   output wire       LoadCounter,
   output reg  [3:0] ROMaddr
);

   parameter RST = 4'b0000;
   parameter IDLE = 4'b0001;
   parameter START = 4'b0010;
   parameter D0 = 4'b0011;
   parameter D1 = 4'b0100;
   parameter D2 = 4'b0101;
   parameter D3 = 4'b0110;
   parameter D4 = 4'b0111;
   parameter D5 = 4'b1000;
   parameter D6 = 4'b1001;
   parameter D7 = 4'b1010;
   parameter STOP = 4'b1011;   

   reg [3:0] 	state;
   reg [4:0] 	out;
 
   assign {Clear_Valid,Shift,LoadSR,SetSR,LoadCounter} = out;
   
   
  always@ (posedge clk or posedge reset) begin
     if(reset)begin
	state   <= RST;
        out     <= 5'b00000;
        ROMaddr <= 4'b0000;
     end
     else
	case(state)
	  RST : begin
	      if(reset)begin
	       {state,out,ROMaddr} <= {RST,5'b10010,4'd0};
	      end else begin
		 {state,out,ROMaddr} <= {IDLE,5'b00010,4'd0};
	      end
	   end
	  
	  IDLE : begin
	     if(TBR_Valid) begin
		{state,out,ROMaddr} <= {START,5'b10101,4'd1};
	     end else begin
		{state,out,ROMaddr} <= {IDLE,5'b00010,4'd0};
	     end
	  end
	  START : begin
	     if(CO) begin
	       {state,out,ROMaddr} <= {D0,5'b01001,4'd2};
	     end else begin
		{state,out,ROMaddr} <= {START,5'b00000,4'd1};
	     end
	  end
	  D0 : begin
	     if(CO) begin
		{state,out,ROMaddr} <= {D1,5'b01001,4'd3};
	     end else begin
		{state,out,ROMaddr} <= {D0,5'b00000,4'd2};
	     end
	  end
	  D1 : begin
	     if(CO) begin
		{state,out,ROMaddr} <= {D2,5'b01001,4'd4};
             end else begin
                {state,out,ROMaddr} <= {D1,5'b00000,4'd3};
             end
          end
	  D2 : begin
	     if(CO) begin
                {state,out,ROMaddr} <= {D3,5'b01001,4'd5};
             end else begin
                {state,out,ROMaddr} <= {D2,5'b00000,4'd4};
             end
          end
	  D3 : begin
	     if(CO) begin
                {state,out,ROMaddr} <= {D4,5'b01001,4'd6};
             end else begin
                {state,out,ROMaddr} <= {D3,5'b00000,4'd5};
             end
          end
	  D4 : begin
	     if(CO) begin
                {state,out,ROMaddr} <= {D5,5'b01001,4'd7};
             end else begin
                {state,out,ROMaddr} <= {D4,5'b00000,4'd6};
             end
          end
	  D5 : begin
	     if(CO) begin
                {state,out,ROMaddr} <= {D6,5'b01001,4'd8};
             end else begin
                {state,out,ROMaddr} <= {D5,5'b00000,4'd7};
             end
          end
	  D6 : begin
	     if(CO) begin
                {state,out,ROMaddr} <= {D7,5'b01001,4'd9};
             end else begin
                {state,out,ROMaddr} <= {D6,5'b00000,4'd8};
             end
          end
	  D7 : begin
	     if(CO) begin
                {state,out,ROMaddr} <= {STOP,5'b01001,4'd0};
             end else begin
                {state,out,ROMaddr} <= {D7,5'b00000,4'd9};
             end
          end
	    STOP : begin
             if(CO) begin
                {state,out,ROMaddr} <= {IDLE,5'b00001,4'd0};
             end else begin
                {state,out,ROMaddr} <= {STOP,5'b00000,4'd0};
             end
            end

	  default : state <= RST;
	  
	endcase
  end // always
   

  endmodule // UART_TrFSM_top
