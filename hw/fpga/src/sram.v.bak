//-----------------------------------------------------------------------------
//
// File:        sram.v
// Author:      Mark Sapper
// Description: Synthesizable SRAM model
//
//-----------------------------------------------------------------------------

module sram #(
  parameter WIDTH = 32,
  parameter DEPTH = 256,
  parameter INFER = 0,
  parameter TYPE  = "dual_port",     // simple dual port (default)
  //                "single_port"    // single port
  //                "true_dual_port" // true dual port (inference not supported yet)

  parameter ADDR_WIDTH = $clog2(DEPTH)
) (

  input  wire                   rst,

  input  wire                   clk_a,
  input  wire  [ADDR_WIDTH-1:0] addr_a,
  input  wire       [WIDTH-1:0] wdata_a,
  input  wire                   write_en_a,
  output wire       [WIDTH-1:0] rdata_a,

  input  wire                   clk_b,
  input  wire  [ADDR_WIDTH-1:0] addr_b,
  input  wire  [WIDTH-1:0]      wdata_b,
  input  wire                   write_en_b,
  output wire       [WIDTH-1:0] rdata_b

);

//-----------------------------------------------------------------------------
// Internal signals
//-----------------------------------------------------------------------------

reg        [WIDTH-1:0] ram_array [0:DEPTH-1];

reg   [ADDR_WIDTH-1:0] ram_addr_a;
reg        [WIDTH-1:0] ram_rdata_b;


generate

//-----------------------------------------------------------------------------
// Instantiate a matching megafunction
//-----------------------------------------------------------------------------

if (INFER == 0) 
  begin

    // simple dual port
    if ((TYPE == "dual_port") && (DEPTH == 8192) && (WIDTH == 16))
      begin
        sdpram_8kx16 sdpram_8kx16 (
          .rd_aclr    ( rst        ),

          .wrclock    ( clk_a      ),
          .wrclocken  ( 1'b1       ),
          .wren       ( write_en_a ),
          .wraddress  ( addr_a     ),
          .data       ( wdata_a    ),

          .rdclock    ( clk_b      ),
          .rdclocken  ( 1'b1       ),
          .rdaddress  ( addr_b     ),
          .q          ( rdata_b    )
        );
      end

    // true dual port
    else if ((TYPE == "true_dual_port") && (DEPTH == 8192) && (WIDTH == 18))
      begin
	tdpram_8kx18	tdpram_8kx18_inst (
		.address_a ( addr_a ),
		.address_b ( addr_b ),
		.clock ( clk ),
		.data_a ( wdata_a ),
		.data_b ( wdata_b ),
		.wren_a ( write_en_a ),
		.wren_b ( write_en_b ),
		.q_a ( rdata_a ),
		.q_b ( rdata_b )
	);	
      end

    // single port
    else if ((TYPE == "single_port") && (DEPTH == 512) && (WIDTH == 16))
      begin
        ram_512x16 ram_512x16 (
          .clock      ( clk_a      ),
          .wren       ( write_en_a ),
          .address    ( addr_a     ),
          .data       ( wdata_a    ),
          .q          ( rdata_a    )
        );

        assign rdata_b = 'd0;
      end


    else
      initial 
        begin
          $display("Unable to instantiate %s RAM: %0dx%0d, no match found", TYPE, DEPTH, WIDTH);
          $stop;
        end
  end

//-----------------------------------------------------------------------------
// Infer RAM
//-----------------------------------------------------------------------------

else if (INFER == 1)
  begin
    //-----------------------------------------------------------------------------
    // Initialize memory
    //-----------------------------------------------------------------------------

    initial
      begin
        $readmemh("sram.dat", ram_array);
      end

    //-----------------------------------------------------------------------------
    // Port a - read and write
    //-----------------------------------------------------------------------------

    assign rdata_a = ram_array[ram_addr_a];

    always @ (posedge clk_a or posedge rst)
      if (rst)
        ram_addr_a <= {ADDR_WIDTH{1'b0}};
      else
        begin
          ram_addr_a <= addr_a;

          if (write_en_a)
            ram_array[addr_a] <= wdata_a;
        end

    //-----------------------------------------------------------------------------
    // Port b - read only
    // Register data instead of address to emulate write->read delay of real ram
    //-----------------------------------------------------------------------------

    assign rdata_b = ram_rdata_b;

    always @ (posedge clk_b or posedge rst)
      if (rst)
        ram_rdata_b <= ram_array['d0];
      else
        ram_rdata_b <= ram_array[addr_b];
  end

endgenerate

endmodule
