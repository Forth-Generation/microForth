`default_nettype wire
`timescale 1ns/1ps

//----------------------------------------------------------------------

module tb (
  input wire verilator_clk,
  input wire verilator_rst
);

localparam SIM_DELAY = 1;

localparam WIDTH = 16;
localparam DEPTH = 512;

// `include "memory_map.vh"

//----------------------------------------------------------------------
// Declare signals
//----------------------------------------------------------------------

integer          i,j,k;

reg              clk_16;
reg              tb_rst;

// dut inputs
wire             clk;
wire             rst;
reg              we;
reg        [1:0] delta;
reg  [WIDTH-1:0] wd;

// dut outputs
wire [WIDTH-1:0] rd;
wire [WIDTH-1:0] ramstack_rd;


//----------------------------------------------------------------------
// Task to do something
//----------------------------------------------------------------------

/*
task some_task;
  input [31:0] one;
  input [31:0] two;
begin
  @(posedge clk);
  #(SIM_DELAY);

//sig1 <= one;

  @(posedge clk);
  #(SIM_DELAY);
 
//sig2 <= two;
end
endtask
*/

//----------------------------------------------------------------------
// Generate clocks
//----------------------------------------------------------------------

`ifdef VERILATOR
  assign clk = verilator_clk;
`else
  assign clk = clk_16;

  // 16 MHz
  initial clk_16  = 1;
  always #5 clk_16 = ~clk_16;

`endif

//----------------------------------------------------------------------
// Reset
//----------------------------------------------------------------------

`ifdef VERILATOR
  assign rst = verilator_rst;
`else
  assign rst = tb_rst;
`endif

//----------------------------------------------------------------------
// Instantiate DUTs
//----------------------------------------------------------------------

stack2 #(
  .WIDTH                  ( WIDTH ),
  .DEPTH                  ( DEPTH ) 
) stack2 (
  .clk                    ( clk   ),

  .we                     ( we    ),
  .delta                  ( delta ),
  .wd                     ( wd    ),

  .rd                     ( rd    )
);

ram_stack3 #(
  .WIDTH                  ( WIDTH ),
  .DEPTH                  ( DEPTH ),
  .INFER                  ( 0     ) 
) ram_stack3 (
  .clk                    ( clk   ),
  .rst                    ( rst   ),

  .we                     ( we    ),
  .delta                  ( delta ),
  .wd                     ( wd    ),

  .rd                     ( ramstack_rd )
);

//----------------------------------------------------------------------
// Generate random inputs
//----------------------------------------------------------------------

always @ (posedge clk or posedge rst)
  if (rst)
    begin
//    we    <= 0;
//    delta <= 0;
      wd    <= 1;
    end
  else
    begin

      if (we)
        wd <= wd + 1;

//    we    <= $urandom%2;
//    delta <= $urandom%4;

    end

//----------------------------------------------------------------------
// Initialize
//----------------------------------------------------------------------

initial
begin
  $display("initializing...");

end

//----------------------------------------------------------------------
// Main
//----------------------------------------------------------------------

initial
begin
  tb_rst = 1;
  we     = 0;
  delta  = 0;

  #101;
  tb_rst = 0;

  @(posedge clk) #SIM_DELAY;

  we    = 1;
  delta = 1; // push

  @(posedge clk) #SIM_DELAY;

  we    = 0;
  delta = 3; // pop

  @(posedge clk) #SIM_DELAY;

  we    = 0;
  delta = 0; // nop

  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;


  we    = 1;
  delta = 1; // push

  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;

  we    = 0;
  delta = 3; // pop

  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;

  we    = 0;
  delta = 0; // nop

  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;


  we    = 1;
  delta = 1; // push

  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;

  we    = 0;
  delta = 3; // pop

  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;

  we    = 0;
  delta = 0; // nop

  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;
  @(posedge clk) #SIM_DELAY;




  we    = 0;
  delta = 0;

  #100_0000;
end

endmodule
