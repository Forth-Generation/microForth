//-----------------------------------------------------------------------------
//
// File:        memory_map.vh
// Author:      Mark Sapper
// Description: Memory map definitions
//
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// Transmit UART
//-----------------------------------------------------------------------------

localparam CSR_UART_TX_DATA         = 16'h0000;   // transmit data

localparam CSR_UART_TX_TBR_VALID    = 16'h0001;   // tbr valid status

//-----------------------------------------------------------------------------
// Receive UART
//-----------------------------------------------------------------------------

localparam CSR_UART_RX_DATA         = 16'h0010;   // received data

localparam CSR_UART_RX_DATA_VALID   = 16'h0011;   // receive data valid

localparam CSR_UART_RX_OVERFLOW     = 16'h0021;   // receive buffer overflow
                                              //   write 1 to clear

//-----------------------------------------------------------------------------
// GPIOs
//-----------------------------------------------------------------------------

localparam CSR_GPIO_OUT             = 16'h0030;   // 8 GPIO outputs

localparam CSR_GPIO_IN              = 16'h0031;   // GPIO input

localparam CSR_GPIO_OE              = 16'h0032;   // GPIO output enables



//-----------------------------------------------------------------------------
// VGA SEM
//-----------------------------------------------------------------------------

localparam CSR_VGA_SEM                  = 16'h0033;   // 1 bit VGA Semaphore. Cleared internally, set in software


//-----------------------------------------------------------------------------
// Paddles
//-----------------------------------------------------------------------------

localparam CSR_PADDLE_STATUS		=16'h0040;	
