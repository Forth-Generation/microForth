//-----------------------------------------------------------------------------
//
// File:        top.v
// Author:      Mark Sapper
// Description: Forth FPGA top level
//
//-----------------------------------------------------------------------------

module top #(
  parameter PARAM1 = 0
) (

  input  wire        clk,
  input  wire        rst_n,

  input  wire        uart_rxd,
  output wire        uart_txd,

  inout  wire  [7:0] gpio,
  output wire        led
);

localparam DATA_WIDTH = 16;

//-----------------------------------------------------------------------------
// Internal signals
//-----------------------------------------------------------------------------

wire                    j1_io_rd;
wire                    j1_io_wr;
wire            [15:0]  j1_mem_addr;
wire                    j1_mem_wr;
wire  [DATA_WIDTH-1:0]  j1_dout;
wire  [DATA_WIDTH-1:0]  j1_io_din;
wire            [12:0]  j1_code_addr;
wire            [15:0]  j1_insn;

wire                    uart_rx_rd;
wire                    uart_rx_clr_ovrflw;
wire             [7:0]  uart_rx_rdata;
wire                    uart_rx_sfe;
wire                    uart_rx_d_valid;
wire                    uart_rx_overflow;

wire             [7:0]  uart_tx_wdata;
wire                    uart_tx_wr;
wire                    uart_tx_tbr_valid;

reg                     rst;
reg              [1:0]  rst_sync;

wire             [7:0]  gpio_in;
wire             [7:0]  gpio_out;
wire             [7:0]  gpio_oe;

genvar                  g;

//-----------------------------------------------------------------------------
// LED blinker
//-----------------------------------------------------------------------------

reg [32:0] count;

//assign led = count[23];
assign led = gpio_out[0];

always @ (posedge clk or posedge rst)
  if (rst)
    count <= 'd0;
  else
    count <= count + 'd1;

//-----------------------------------------------------------------------------
// Connect three state gpio pins
//-----------------------------------------------------------------------------

generate for ( g=0 ; g<=7 ; g=g+1 )
  begin : gpios
    assign gpio[g] = gpio_oe[g] ? gpio_out[g] : 1'bz;
  end
endgenerate

assign gpio_in = gpio;

//-----------------------------------------------------------------------------
// Reset - async assert, sync deassert
//-----------------------------------------------------------------------------

always @ (posedge clk or negedge rst_n)
  if (!rst_n)
    begin
      rst      <= 1'b1;
      rst_sync <= 2'b11;
    end
  else
    begin
      rst_sync[1] <= 1'b0;
      rst_sync[0] <= rst_sync[1];
      rst         <= rst_sync[0];
    end

//-----------------------------------------------------------------------------
// Instantiate submodules
//-----------------------------------------------------------------------------

// processor
j1_prb j1_prb (
  .clk                ( clk                 ),
  .resetq             ( ~rst                ),

  .io_wr              ( j1_io_wr            ), // io write enable
  .io_rd              ( j1_io_rd            ), // io read enable
  .io_din             ( j1_io_din           ), // io read data

  .dout               ( j1_dout             ), // port a write data 
  .mem_addr           ( j1_mem_addr         ), // port a address
  .mem_wr             ( j1_mem_wr           ), // port a write enable

  .code_addr          ( j1_code_addr        ), // port b address
  .insn               ( j1_insn             )  // port b read data - from instruction memory
);

// instruction/data ram
sram #(
  .WIDTH              ( DATA_WIDTH          ),
  .DEPTH              ( 8192                )
) sram     (
  .clk                ( clk                 ),
  .rst                ( rst                 ),

  .addr_a             ( j1_mem_addr[12:0]   ),
  .wdata_a            ( j1_dout             ),
  .write_en_a         ( j1_mem_wr           ),
  .rdata_a            (                     ),

  .addr_b             ( j1_code_addr        ),
  .rdata_b            ( j1_insn             )
);

// control/status registers
csr csr1 (
  .clk                ( clk                 ),
  .rst                ( rst                 ),
  .j1_mem_addr        ( j1_mem_addr         ),
  .j1_dout            ( j1_dout             ),
  .j1_io_wr           ( j1_io_wr            ),
  .j1_io_rd           ( j1_io_rd            ),
  .j1_io_din          ( j1_io_din           ),
  .uart_tx_wr         ( uart_tx_wr          ),
  .uart_tx_wdata      ( uart_tx_wdata       ),
  .uart_tx_tbr_valid  ( uart_tx_tbr_valid   ),
  .uart_rx_rd         ( uart_rx_rd          ),
  .uart_rx_rdata      ( uart_rx_rdata       ),
  .uart_rx_d_valid    ( uart_rx_d_valid     ),
  .uart_rx_overflow   ( uart_rx_overflow    ),
  .uart_rx_clr_ovrflw ( uart_rx_clr_ovrflw  ),
  .led                ( ), // led           ),
  .gpio_in            ( gpio_in             ),
  .gpio_out           ( gpio_out            ),
  .gpio_oe            ( gpio_oe             )
);

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


endmodule
