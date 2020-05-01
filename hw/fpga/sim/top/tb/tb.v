`default_nettype wire

//
//----------------------------------------------------------------------
`timescale 1ns/1ps

`define SIM 1

module tb (
  input wire verilator_clk,
  input wire verilator_rst
);

localparam SIM_DELAY = 1;

localparam SOME_PARAM = 4'd11;

// `include "memory_map.vh"

//----------------------------------------------------------------------
// Declare signals
//----------------------------------------------------------------------

integer             i,j,k;

reg         clk_16;
// dut inputs
wire        clk;
wire        rst_n;
wire        uart_rxd;
// dut outputs
wire        uart_txd;
wire  [7:0] gpio;
wire        led;
reg   [7:0] gpio_drive;

reg         tb_rst;

assign uart_rxd = uart_txd;
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
// Task to load an array from a file
//----------------------------------------------------------------------

reg [31:0] array [0:1024];

task automatic array_load;
  input   [8*80:0] filename;  // 80 char max

  integer          filehandle = 0;
  integer          wordcount  = 0;
  integer          scancount  = 1;
  reg       [31:0] writedata;
  reg     [8*80:0] tempstring;
  reg       [31:0] selword;

  begin
    // open the input file
    filehandle = $fopen(filename, "r");

    if (filehandle == 0)
      begin
        $display("%12.3f Cannot open file in %m: %s", $time, filename);
        $stop;
      end

    while (! $feof(filehandle))
      begin
        // get a line from the input file
        scancount = $fgets(tempstring, filehandle);

        // extract hex data
        scancount = $sscanf(tempstring, "%x", writedata);

        // write data to ram
        if (scancount == 1)
          begin
            array[wordcount] = writedata;
            wordcount = wordcount + 1;
          end
      end

      $display("%12.3f Loaded %d bytes from file: %s", $time, wordcount*4, filename);

      $fclose(filehandle);
  end
endtask

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
  assign rst_n = ~verilator_rst;
`else
  assign rst_n = ~tb_rst;
`endif

//----------------------------------------------------------------------
// Instantiate DUTs
//----------------------------------------------------------------------

top #(
  .PARAM1                 ( 1        )
) top (
  .clk                    ( clk      ),
  .rst_n                  ( rst_n    ),
  .uart_rxd               ( uart_rxd ),
  .uart_txd               ( uart_txd ),
  .gpio                   ( gpio     ),
  .led                    ( led      ),
  .paddle_left_up	  (0),
  .paddle_left_down	  (1),
  .paddle_right_up        (1),
  .paddle_right_down      (1)
);

//----------------------------------------------------------------------
// Connect tb drive signals to 3 state ios
//----------------------------------------------------------------------

assign gpio = gpio_drive;

//----------------------------------------------------------------------
// Initialize
//----------------------------------------------------------------------

initial
begin
  $display("initializing...");

  gpio_drive = 8'bzzzzzzzz;
end

//----------------------------------------------------------------------
// Main
//----------------------------------------------------------------------

initial
begin
  tb_rst = 1;

  #101;
  tb_rst = 0;

  #100_0000;
end

endmodule
