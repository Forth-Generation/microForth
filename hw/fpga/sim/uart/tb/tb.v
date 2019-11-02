//
//----------------------------------------------------------------------
`timescale 1ns/1ps

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
wire        rst;

wire        uart_rxd;
wire        uart_rx_rd;
wire        uart_rx_clr_ovrflw;
wire  [7:0] uart_rx_rdata;
wire        uart_rx_sfe;
wire        uart_rx_d_valid;
wire        uart_rx_overflow;
wire        uart_txd;
wire  [7:0] uart_tx_wdata;
wire        uart_tx_wr;
wire        uart_tx_tbr_valid;

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

`endif

//----------------------------------------------------------------------
// Instantiate DUTs
//----------------------------------------------------------------------

// recieve uart
UART_Rcvr_top uart_rcvr_top (
  .CLOCK              ( clk                 ),
  .reset              ( rst                 ),
  .Rx_raw             ( uart_rxd            ),
  .Rd_en              ( uart_rx_rd          ),
  .clr_ovrflw         ( uart_rx_clr_ovrflw  ),
  .out                ( uart_rx_rdata       ),
  .SFE                ( uart_rx_sfe         ),
  .d_valid            ( uart_rx_d_valid     ),
  .overflow           ( uart_rx_overflow    )
);

// transmit uart
UART_Tr_top uart_tr_top (
  .clk                ( clk                 ),
  .reset              ( rst                 ),
  .Tx                 ( uart_txd            ),
  .Data_in            ( uart_tx_wdata       ),
  .TBR_en             ( uart_tx_wr          ),
  .TBR_Valid          ( uart_tx_tbr_valid   )
);



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
//  rst_n = 0;

//  #101;
//  rst_n = 1;

//  #100_0000;
end

endmodule
