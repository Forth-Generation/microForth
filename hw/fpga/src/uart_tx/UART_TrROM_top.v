module UART_TrROM_top (
   input  wire       CLOCK,
   input  wire [3:0] addr,

   output reg  [7:0] data_out
);

  wire [7:0] 	mem[0:9];

  assign mem[0] = 8'd10;
  assign mem[1] = 8'd10;
  assign mem[2] = 8'd10;
  assign mem[3] = 8'd10;
  assign mem[4] = 8'd10;
  assign mem[5] = 8'd10;
  assign mem[6] = 8'd10;
  assign mem[7] = 8'd10;
  assign mem[8] = 8'd10;
  assign mem[9] = 8'd10;
   
   
   always @(posedge CLOCK) begin
      data_out = mem[addr];
   end
   
endmodule // ROM_FourByEight
