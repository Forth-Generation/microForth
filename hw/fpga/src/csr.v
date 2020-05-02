//-----------------------------------------------------------------------------
//
// File:        csr.v
// Author:      Mark Sapper
// Description: Control/status registers and address decode
//
//-----------------------------------------------------------------------------

module csr (

  input  wire         clk,
  input  wire         rst,

  // processor core
  input  wire  [15:0] j1_mem_addr,    // address
  input  wire  [15:0] j1_dout,        // write data

  input  wire         j1_io_wr,       // i/o write enable

  input  wire         j1_io_rd,       // i/o read enable
  output reg   [15:0] j1_io_din,      // i/o read data

  // transmit uart
  output wire         uart_tx_wr,
  output wire   [7:0] uart_tx_wdata,
  input  wire         uart_tx_tbr_valid,

  // receive uart
  output wire         uart_rx_rd,
  input  wire   [7:0] uart_rx_rdata,
  input  wire         uart_rx_d_valid,
  input  wire         uart_rx_overflow,
  output reg          uart_rx_clr_ovrflw,

  // gpio
  input  wire   [7:0] gpio_in,
  output reg    [7:0] gpio_out,
  output reg    [7:0] gpio_oe,

  // vga sem
  input  wire 			 clr_sem,
  output reg          vga_sem,
  
  //Paddle states
  input wire			paddle_left_up,
  input wire			paddle_left_down,
  input wire			paddle_right_up,
  input wire 			paddle_right_down
);

`include "memory_map.vh"

//-----------------------------------------------------------------------------
// Internal signals
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// Combinatorial read/write strobe decodes
//-----------------------------------------------------------------------------

assign uart_tx_wr = (j1_io_wr && (j1_mem_addr == CSR_UART_TX_DATA));
assign uart_rx_rd = (j1_io_rd && (j1_mem_addr == CSR_UART_RX_DATA));

// pass write data to the tx uart
assign uart_tx_wdata = j1_dout[7:0];

//-----------------------------------------------------------------------------
// Control registers
//-----------------------------------------------------------------------------

always @ (posedge clk or posedge rst) begin
  if (rst)
    begin
      gpio_out           <= 8'h00;
      gpio_oe            <= 8'h00;
      vga_sem                <= 1'b0;
      uart_rx_clr_ovrflw <= 1'b0;
    end
  else
    begin
	 if(clr_sem) begin
		vga_sem <= 1'b0;
	 end
      if (j1_io_wr)
        case (j1_mem_addr)
          CSR_UART_RX_OVERFLOW : uart_rx_clr_ovrflw <= j1_dout[0];

          CSR_GPIO_OUT         : gpio_out           <= j1_dout[7:0];
          CSR_GPIO_OE          : gpio_oe            <= j1_dout[7:0];
          CSR_VGA_SEM              : vga_sem                <= j1_dout[0];

          default              : begin end
        endcase

      else
        // autoclear the overflow clear bit
        uart_rx_clr_ovrflw <= 1'b0;
    end
end

//-----------------------------------------------------------------------------
// Status (readback) registers
// This is a combinatorial decode/mux
//-----------------------------------------------------------------------------

always @ ( * )
  if (j1_io_rd)
    case (j1_mem_addr)
      CSR_UART_TX_TBR_VALID  : j1_io_din = { 15'd0 , uart_tx_tbr_valid };

      CSR_UART_RX_DATA       : j1_io_din = {  8'd0 , uart_rx_rdata     };
      CSR_UART_RX_DATA_VALID : j1_io_din = { 15'd0 , uart_rx_d_valid   };
      CSR_UART_RX_OVERFLOW   : j1_io_din = { 15'd0 , uart_rx_overflow  };

      CSR_GPIO_IN            : j1_io_din = {  8'd0 , gpio_in  };
      CSR_GPIO_OUT           : j1_io_din = {  8'd0 , gpio_out };
      CSR_GPIO_OE            : j1_io_din = {  8'd0 , gpio_oe  };

      CSR_VGA_SEM                : j1_io_din = { 15'd0 , vga_sem  };
		
		CSR_PADDLE_STATUS					: j1_io_din = {12'd0, paddle_right_down, paddle_right_up, paddle_left_down, paddle_left_up};

      default                : j1_io_din = 16'hbada;  // undefined read returns bad a
    endcase

  else
    j1_io_din = 16'hdead;


endmodule
