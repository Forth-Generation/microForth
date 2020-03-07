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
  output wire        led,
  
  output wire			VGA_HS,
  output wire			VGA_VS,
  output wire  [3:0] VGA_R,
  output wire  [3:0] VGA_G,
  output wire  [3:0] VGA_B
);

localparam DATA_WIDTH = 16;
localparam ADDRESS_WIDTH = 16;
localparam INSN_WIDTH = 18;

//-----------------------------------------------------------------------------
// Internal signals
//-----------------------------------------------------------------------------

wire                    j1_io_rd            /*synthesis keep*/ ;
wire                    j1_io_wr            /*synthesis keep*/ ;
wire  [ADDRESS_WIDTH - 1 :0]  j1_mem_addr         /*synthesis keep*/ ;
wire                    j1_mem_wr           /*synthesis keep*/ ;
wire  [DATA_WIDTH-1:0]  j1_dout             /*synthesis keep*/ ;
wire  [DATA_WIDTH-1:0]  j1_io_din           /*synthesis keep*/ ;
wire            [12:0]  j1_code_addr        /*synthesis keep*/ ;
wire  [INSN_WIDTH-1:0]  j1_insn             /*synthesis keep*/ ;
wire  [INSN_WIDTH-1:0]  j1_rdata	    /*synthesis keep*/ ;

wire                    uart_rx_rd          /*synthesis keep*/ ;
wire                    uart_rx_clr_ovrflw  /*synthesis keep*/ ;
wire             [7:0]  uart_rx_rdata       /*synthesis keep*/ ;
wire                    uart_rx_sfe         /*synthesis keep*/ ;
wire                    uart_rx_d_valid     /*synthesis keep*/ ;
wire                    uart_rx_overflow    /*synthesis keep*/ ;

wire             [7:0]  uart_tx_wdata       /*synthesis keep*/ ;
wire                    uart_tx_wr          /*synthesis keep*/ ;
wire                    uart_tx_tbr_valid   /*synthesis keep*/ ;

reg                     rst                 /*synthesis keep*/ ;
reg                     rst_n_1             /*synthesis keep*/ ;
reg                     rst_n_2             /*synthesis keep*/ ;
reg              [5:0]  rst_count           /*synthesis keep*/ ;

wire             [7:0]  gpio_in             /*synthesis keep*/ ;
wire             [7:0]  gpio_out            /*synthesis keep*/ ;
wire             [7:0]  gpio_oe             /*synthesis keep*/ ;

//wire 							px_clk					/*synthesis keep*/;
wire							locked 					/*synthesis keep*/;

wire             [11:0] h_addr               /*synthesis keep*/;
wire             [10:0] v_addr               /*synthesis keep*/;
//wire						screenend				 /*synthesis keep*/;
wire							screenbegin				 /*synthesis keep*/;
wire				  [15:0]	sprite_din				 /*synthesis keep*/;
genvar                  g;
//Pong Ball
wire							ball_xloc_wr				/*synthesis keep*/;
wire 							ball_yloc_wr				/*synthesis keep*/;


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
      rst       <= 1'b1;
      rst_n_1   <= 1'b0;
      rst_n_2   <= 1'b0;
      rst_count <= 6'b111111;
    end
  else
    begin
      rst_n_1 <= rst_n;
      rst_n_2 <= rst_n_1;

      if (!rst_n_2)
        begin
          rst       <= 1'b1;
          rst_count <= 6'b111111;
        end
      else if (rst_count != 6'd0)
        begin
          rst       <= 1'b1;
          rst_count <= rst_count - 6'd1;
        end
      else
        begin
          rst       <= 1'b0;
        end
    end

//-----------------------------------------------------------------------------
// Instantiate submodules
//-----------------------------------------------------------------------------

// processor
my_j1 # (
	.WIDTH				 (DATA_WIDTH				)
) j1 (
  .clk                ( clk                 ),
  .resetq             ( ~rst                ),

  .io_wr              ( j1_io_wr            ), // io write enable
  .io_rd              ( j1_io_rd            ), // io read enable
  .io_din             ( j1_io_din           ), // io read data

  .dout               ( j1_dout             ), // port a write data 
  .mem_addr           ( j1_mem_addr         ), // port a address
  .mem_wr             ( j1_mem_wr           ), // port a write enable 
  .rmem_data	      ( j1_rdata[15:0]      ), // port a read data

  .code_addr          ( j1_code_addr        ), // port b address
  .insn               ( j1_insn             )  // port b read data - from instruction memory
);

// infer memory for now because altera model is not supported by verilator
`ifdef SIMULATION
  localparam INFER = 1;
`else
  localparam INFER = 0;
`endif

// instruction/data ram
sram #(
  .WIDTH              ( INSN_WIDTH          ),
  .DEPTH              ( 8192                ),
  .INFER              ( 1                   )
) sram     (
  .rst                ( 1'b0                ),

  .clk_a              ( clk                 ),
  .addr_a             ( j1_mem_addr[12:0]   ),
  .wdata_a            ( {2'b0,j1_dout}      ),
  .write_en_a         ( j1_mem_wr           ),
  .rdata_a            ( j1_rdata            ),

  .clk_b              ( clk                 ),
  .addr_b             ( j1_code_addr        ),
  .wdata_b            ( {18{1'b0}}          ),
  .write_en_b         ( 1'b0		    ),
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
  .rx_data_out        ( uart_rx_rdata       ),
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

//VGA interface
`ifdef SIM
  reg px_clk;
  initial px_clk  = 1;
  always #3.5 px_clk = ~px_clk;
`else
	wire px_clk;
	pll_test pixel_clock (
		.inclk0 	   (clk),
		.areset		   (rst),
		.c0   	  	   (px_clk),
		.locked        (locked)
	);
`endif

vga_sync_gen #(
	.HS_FP_WIDTH	(16),
	.HS_WIDTH		(144),
	.H_BP_WIDTH		(248),
	.HA_WIDTH		(1280),
	
	.VS_FP_WIDTH	(2),
	.VS_WIDTH		(3),
	.V_BP_WIDTH 	(38),
	.VA_WIDTH		(1024)
) display (
	.px_clk			(px_clk),
	.rst 				(rst),
	.hsync			(VGA_HS),
	.vsync			(VGA_VS),
	.h_addr			(h_addr),
	.v_addr			(v_addr),
	.screenbegin   (screenbegin)
);

wire sprite_on;
/*reg [9:0] cnt;
always @(posedge px_clk) begin
	if(rst) cnt <= 10'b0;
	else begin
		if(screenbegin) cnt <= cnt+10'd2;
	end
end */

PongSprite #(
	.XSIZE			(50),
	.YSIZE			(50)
	) ball 	(

	.px_clk			(px_clk),
	.rst				(rst),
	.data_in			(sprite_din),
	.x_N_loc_en		(ball_xloc_wr),
	.y_N_loc_en		(ball_yloc_wr),
	.screenbegin	( screenbegin),
	.h_addr			({4'b0,h_addr}),
	.v_addr			({5'b0,v_addr}),
	.sprite_on		(sprite_on)
);

IOFunctionDecodeWriteBlock IO_Decode_Blk1(
	//inputs
	.cpu_din(j1_dout),
	.cpu_addr(j1_mem_addr),
	.io_wr(j1_io_wr),
	.rst(rst),
	.clk(clk),
	.px_clk(px_clk),
	//outputs
	.io_dout(sprite_din),
	.we_0(ball_xloc_wr),
	.we_1(ball_yloc_wr)
);


	//assign VGA_R = ((h_addr > 0) & (h_addr < 500) & (v_addr>0)&(v_addr < 1023) ) ? 4'hf : 4'h0;
	assign VGA_B = sprite_on ? 4'b1111 : 4'b0000;
	assign VGA_G = sprite_on ? 4'b1111 : 4'b0000;
	assign VGA_R = sprite_on ? 4'b1111 : 4'b0000;
	//assign VGA_G = 4'hf;//sprite_on ? 4'b1111 : 4'b1000;
/*
	wire sq_a, sq_b, sq_c, sq_d;
    assign sq_a = ((h_addr > 120) & (v_addr >  40) & (h_addr < 280) & (v_addr < 200)) ? 1 : 0;
    assign sq_b = ((h_addr > 200) & (v_addr > 120) & (h_addr < 360) & (v_addr < 280)) ? 1 : 0;
    assign sq_c = ((h_addr > 280) & (v_addr > 200) & (h_addr < 440) & (v_addr < 360)) ? 1 : 0;
    assign sq_d = ((h_addr > 1000) & (v_addr > 900) & (h_addr < 1279) & (v_addr < 1023)) ? 1 : 0;

    assign VGA_R[3] = sq_b;         // square b is red
    assign VGA_G[3] = sq_a | sq_d;  // squares a and d are green
    assign VGA_B[3] = sq_c;         // square c is blue
*/
endmodule
