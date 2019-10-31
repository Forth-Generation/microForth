module UART_FSM_top (
   input  wire       CLOCK,
   input  wire       Rx,
   input  wire       CO,
   input  wire       f_edge,
   input  wire       reset,
   output wire       load_counter,
   output wire       load_buffer,
   
   output wire [3:0] ROM_addr,
   output wire       shift,
   output wire       SFE   
);
   
   reg  [3:0] state_reg;
   reg [7:0] Out;
   
   //State Machine Parameters
   parameter RST = 4'b0000;
   parameter IDLE = 4'b0001;
   parameter START = 4'b0010;
   parameter D0 = 4'b0011;
   parameter D1 = 4'b0100;
   parameter D2 = 4'b0101;
   parameter D3	= 4'b0110;
   parameter D4	= 4'b0111;
   parameter D5	= 4'b1000;
   parameter D6 = 4'b1001;
   parameter D7 = 4'b1010;
   parameter STOP = 4'b1011;

   
   assign ROM_addr = Out[3:0];
   assign load_counter = Out[4];
   assign shift = Out[5];
   assign SFE = Out[6];
   assign load_buffer =	Out[7];
   
//FSM   
always @(posedge CLOCK or posedge reset)
  begin
     if(reset)
       state_reg <= RST;
     else
       case (state_reg)
	 RST :
	   begin
	      Out <= 8'h00;
	      if(Rx)         
		state_reg <= IDLE;
	   end
	 
	 IDLE :
	   begin
	   if(f_edge)
	     begin
		state_reg <= START; 
		Out <= 8'h10;
	     end
	   else       Out <= 8'h00;	      
	   end
	 
	 START :
	   begin
	      if(CO)
		begin
		   if(Rx)
		     begin
			state_reg <= RST; //Bad start bit, Reset
			Out <=8'h00;
		     end
		   else       
		     begin
			state_reg <= D0;  //Good start bit, go to D0
 			Out <= 8'h11;     // and load counter w/ addr 1
		     end
		end // if (CO)
	      else     Out <= 8'h01; //No Carryout signal, remain in start
	   end

	 D0 :
	   begin
	   if(CO)
	     begin
		state_reg <= D1;
		Out <= 8'h32;  //Shift in Rx, Load counter w/ 2	 
	     end 
	   else
	     begin
		state_reg <= D0; //wait for middle of bit D0
		Out <= 8'h02; 
	     end
	   end // case: D0
	 
	 D1 :
	   begin
           if(CO)
	     begin
		state_reg <= D2;
		Out <= 8'h33;
	     end
	   else
	     begin
		state_reg <= D1;
		Out <=8'h03;
	     end
	   end // case: D1
	 
	  D2 :
           begin
              if(CO)
		begin
                   state_reg <= D3;
                   Out <= 8'h34;
		end
              else
		begin
	           state_reg <= D2;
                   Out <=8'h04;
		end
           end // case: D2
	 
	 D3 :
           begin
              if(CO)
                begin
                   state_reg <= D4;
                   Out <= 8'h35;
                end
              else
                begin
                   state_reg <= D3;
                   Out <=8'h05;
                end
           end // case: D3    
	 
	 D4 :
           begin
              if(CO)
                begin
                   state_reg <= D5;
                   Out <= 8'h36;
                end
              else
                begin
                   state_reg <= D4;
                   Out <=8'h06;
                end
           end // case: D4
	 
	 D5 :
           begin
              if(CO)
                begin
                   state_reg <= D6;
                   Out <= 8'h37;
                end
              else
                begin
                   state_reg <= D5;
                   Out <=8'h07;
                end
           end // case: D5

	 D6 :
           begin
              if(CO)
                begin
                   state_reg <= D7;
                   Out <= 8'h38;
                end
              else
                begin
                   state_reg <= D6;
                   Out <=8'h08;
                end
           end // case: D6

	 D7 :
           begin
              if(CO)
                begin
                   state_reg <= STOP;
                   Out <= 8'h39;
                end
              else
                begin
                   state_reg <= D7;
                   Out <=8'h09;
                end
           end

	 STOP :
	   begin
	      if(CO)
		begin
		   if(Rx)
		     begin
			state_reg <= IDLE;
			Out <= 8'h80;
		     end
		   else
		     begin
			state_reg <= RST;
			Out <= 8'h40;
		     end
		     
		end // if (CO)
	      else   Out <= 8'h00;
	   end // case: STOP
	 
	 default : state_reg <= RST;
	 
       endcase 
  end 
   
endmodule // UART_FSM

   
