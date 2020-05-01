//-----------------------------------------------------------------------------
//
// File:        top.v
// Author:      Mark Sapper, Peter Baran, Jess Totorica, Kyle Hartman
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
  output wire  [3:0] VGA_B,
  
  input wire			paddle_left_up,
  input wire			paddle_left_down,
  input wire			paddle_right_up,
  input wire			paddle_right_down
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
wire             [11:0] h_addrN               /*synthesis keep*/;
wire             [10:0] v_addrN               /*synthesis keep*/;
//wire						screenend				 /*synthesis keep*/;
wire							screenbegin				 /*synthesis keep*/;
wire							linebegin					/*synthesis keep*/;
wire							onSreen					/*synthesis keep*/;
wire				  [15:0]	sprite_din				 /*synthesis keep*/;
genvar                  g;
//Pong Ball
wire					[5:0] pong_data_en				/*synthesis keep*/;

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
  .INFER              ( 1                   ),
  .INITIALIZE			 ( 1						  )
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
  .vga_sem                ( ),  //Use this signal for the semaphore
  .clr_sem					(clr_sem),
  .paddle_left_up		 (~paddle_left_up),
  .paddle_left_down	 (~paddle_left_down),
  .paddle_right_up	 (~paddle_right_up),
  .paddle_right_down  (~paddle_right_down),
  .gpio_in            ( gpio_in             ),
  .gpio_out           ( gpio_out            ),
  .gpio_oe            ( gpio_oe             )
);
//   
//
//   
//// recieve uart
//UART_Rcvr_top uart_rcvr_top (
//  .CLOCK              ( clk                 ),
//  .reset              ( rst                 ),
//  .Rx_raw             ( uart_rxd            ),
//  .Rd_en              ( uart_rx_rd          ),
//  .clr_ovrflw         ( uart_rx_clr_ovrflw  ),
//  .rx_data_out        ( uart_rx_rdata       ),
//  .SFE                ( uart_rx_sfe         ),
//  .d_valid            ( uart_rx_d_valid     ),
//  .overflow           ( uart_rx_overflow    )
//);
//
//
//// transmit uart
//UART_Tr_top uart_tr_top (
//  .clk                ( clk                 ),
//  .reset              ( rst                 ),
//  .Tx                 ( uart_txd            ),
//  .Data_in            ( uart_tx_wdata       ),
//  .TBR_en             ( uart_tx_wr          ),
//  .TBR_Valid          ( uart_tx_tbr_valid   )
//);

//VGA interface
`ifdef SIM
  reg px_clk;
  initial px_clk  = 1;
  always #3.5 px_clk = ~px_clk;
`else
	wire px_clk;
	Pixel_clock pixel_clock (
		.inclk0 	   (clk),
		.areset		   (rst),
		.c0   	  	   (px_clk),
		.locked        (locked)
	);
`endif

reg px_rst;
reg px_rst_sreg;

always @(posedge px_clk) begin
	px_rst_sreg <= rst;
	px_rst <= px_rst_sreg;
end

vga_sync_gen #(
	.HS_FP_WIDTH	(48),
	.HS_WIDTH		(112),
	.H_BP_WIDTH		(248),
	.HA_WIDTH		(1280),
	
	.VS_FP_WIDTH	(1),
	.VS_WIDTH		(3),
	.V_BP_WIDTH 	(38),
	.VA_WIDTH		(1024)
	/*.HS_FP_WIDTH	(16),
	.HS_WIDTH		(144),
	.H_BP_WIDTH		(248),
	.HA_WIDTH		(1280),
	
	.VS_FP_WIDTH	(2),
	.VS_WIDTH		(3),
	.V_BP_WIDTH 	(38),
	.VA_WIDTH		(1024)*/
	/*.HS_FP_WIDTH	(5),
	.HS_WIDTH		(10),
	.H_BP_WIDTH		(5),
	.HA_WIDTH		(32),
	
	.VS_FP_WIDTH	(1),
	.VS_WIDTH		(2),
	.V_BP_WIDTH 	(1),
	.VA_WIDTH		(32)*/
) display (
	.px_clk			(px_clk),
	.rst 				(px_rst),
	.hsync			(VGA_HS),
	.vsync			(VGA_VS),
	.h_addrN			(h_addrN),
	.v_addrN			(v_addrN),
	.h_addr			(h_addr),
	.v_addr			(v_addr),
	.linebegin		(linebegin),
	.onScreen		(onScreen),
	.screenbegin   (screenbegin) //route to csr block to generate 1 16MHz wide clock pulse to clear semaphore
);

wire sprite_on, sprite_on_pLeft, sprite_on_pRight, sprite_on_sLeft, sprite_on_sRight;
wire[8:0] sprite_addr_0, sprite_addr_1, sprite_addr_2, sprite_addr_3, sprite_addr_4;
wire[8:0] sprite_addr;
wire load_loc_done;
wire [4:0] load_en;
wire img_load_done;


PongSprite #(
	.SPRITE_MEM_LOC(9'h0a0),
	.SCALE(2)
	) ball 	(

	.px_clk			(px_clk),
	.rst				(px_rst),
	.data_in			(sprite_din),
	.x_loc_en		(pong_data_en[0]),
	.y_loc_en		(pong_data_en[1]),
	.linebegin	( img_load_done), 
	.h_addr			(h_addrN),
	.v_addr			(v_addrN),
	.sprite_on		(sprite_on),
	.mem_addr		(sprite_addr_0),
	.line_en       (load_en[0])
);

PongSprite #(
	.SPRITE_MEM_LOC(9'h0b0),
	.XLOC_INITIAL (30),
	.YLOC_INITIAL (0),
	.SCALE 		  (8)
	) paddle_left 	(

	.px_clk			(px_clk),
	.rst				(px_rst),
	.data_in			(sprite_din),
	.x_loc_en		(0),
	.y_loc_en		(pong_data_en[2]),
	.linebegin	( img_load_done), 
	.h_addr			(h_addrN),
	.v_addr			(v_addrN),
	.sprite_on		(sprite_on_pLeft),
	.mem_addr		(sprite_addr_1),
	.line_en(load_en[1])
);

PongSprite #(

	.SPRITE_MEM_LOC(9'h0c0),
	.XLOC_INITIAL	(1125),
	.YLOC_INITIAL  (300),
	.SCALE 		  (8)
	) paddle_right 	(

	.px_clk			(px_clk),
	.rst				(px_rst),
	.data_in			(sprite_din),
	.x_loc_en		(0),
	.y_loc_en		(pong_data_en[3]),
	.linebegin	( img_load_done), 
	.h_addr			(h_addrN),
	.v_addr			(v_addrN),
	.sprite_on		(sprite_on_pRight),
	.mem_addr		(sprite_addr_2),
	.line_en(load_en[2])
);

PongSprite #(
	.SPRITE_MEM_LOC(9'h050),
	.XLOC_INITIAL	(60),
	.YLOC_INITIAL  (930),
	.SCALE			(4)
	) score_left 	(

	.px_clk			(px_clk),
	.rst				(px_rst),
	.data_in			(sprite_din),
	.x_loc_en		(0),
	.y_loc_en		(0),
	.linebegin	( img_load_done), 
	.h_addr			(h_addrN),
	.v_addr			(v_addrN),
	.sprite_on		(sprite_on_sLeft),
	.mem_addr		(sprite_addr_3),
	.line_en       (load_en[3]),
	.mem_addr_wren (pong_data_en[4])
);

PongSprite #(
	.SPRITE_MEM_LOC(9'h030),
	.XLOC_INITIAL	(1135),
	.YLOC_INITIAL  (930),
	.SCALE         (4)
	) score_right 	(

	.px_clk			(px_clk),
	.rst				(px_rst),
	.data_in			(sprite_din),
	.x_loc_en		(0),
	.y_loc_en		(0),
	.linebegin	( img_load_done), 
	.h_addr			(h_addrN),
	.v_addr			(v_addrN),
	.sprite_on		(sprite_on_sRight),
	.mem_addr		(sprite_addr_4),
	.line_en       (load_en[4]),
	.mem_addr_wren (pong_data_en[5])
);

cpu_vga_interface #(
	.INFER(INFER)
)
interface (
	.rst				(rst),
	.px_rst			(px_rst),
	.clk				(clk),
	.px_clk			(px_clk),
	.cpu_addr		(j1_mem_addr),
	.cpu_din			(j1_dout),
	.io_wr			(j1_io_wr),
	.screenbegin	(screenbegin),
	.v_sync			(~VGA_VS),
	.reg_data		(sprite_din),
	.en				(pong_data_en),
	.sprite_addr	(sprite_addr),
	.loading_loc  (loading_loc),
	.clr_sem			(clr_sem)
);

load_sprite_image image_loader(
		.clk(px_clk),
		.rst(px_rst),
		.loading_loc(loading_loc),
		.linebegin(linebegin),
		.mem_addr_0(sprite_addr_0),
		.mem_addr_1(sprite_addr_1),
		.mem_addr_2(sprite_addr_2),
		.mem_addr_3(sprite_addr_3),
		.mem_addr_4(sprite_addr_4),
		
		.mem_addr_out(sprite_addr),
		.load_en(load_en),
		.img_load_done (img_load_done)
		
);
//wire paddle_test;
//wire paddle_test2;
//wire paddle_test3;
//wire paddle_test4;
//PaddleControl paddle1(
//	.clk(clk),
//	.paddle_left_up(~paddle_left_up),
//	.paddle_left_down(~paddle_left_down),
//	.paddle_right_up(~paddle_right_up),
//	.paddle_right_down(~paddle_right_down),
//	.paddle_test(paddle_test),
//	.paddle_test2(paddle_test2),
//	.paddle_test3(paddle_test3),
//	.paddle_test4(paddle_test4)
//);


//assign VGA_B = (paddle_test|paddle_test4) & onScreen ? 4'b1111 : 4'b0000;
//assign VGA_G = paddle_test2 & onScreen ? 4'b1111 : 4'b0000;
//assign VGA_R = paddle_test3 & onScreen ? 4'b1111 : 4'b0000;
//assign VGA_G = onScreen ? 4'b1111 : 4'b0000;
//assign VGA_R = onScreen ? 4'b1111 : 4'b0000;


	assign VGA_B = ((sprite_on_pRight|sprite_on|sprite_on_pLeft|sprite_on_sLeft|sprite_on_sRight) & onScreen) ? 4'b1111 : 4'b0000;
	assign VGA_G = ((sprite_on_pRight|sprite_on|sprite_on_pLeft|sprite_on_sLeft|sprite_on_sRight) & onScreen) ? 4'b1111 : 4'b0000;
	assign VGA_R = ((sprite_on_pRight|sprite_on|sprite_on_pLeft|sprite_on_sLeft|sprite_on_sRight) & onScreen) ? 4'b1111 : 4'b0000;

//	wire sq_a;
//	
//    assign sq_a = ((h_addr > 30) & (v_addr >  0) & (h_addr < 1280) & (v_addr < 1024)) ? 1 : 0;
//	 
//	 assign VGA_R[3] = sq_a;
//	 assign VGA_G[3] = sq_a;
//	 assign VGA_B[3] = sq_a;

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
