//-----------------------------------------------------------------------------
//
// File:        sram.v
// Author:      Mark Sapper
// Description: Synthesizable SRAM model
//
//-----------------------------------------------------------------------------

module FIFOsram #(
  parameter WIDTH = 32,
  parameter DEPTH = 256,
  parameter INFER = 0,

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
// Instantiate megafunction
//-----------------------------------------------------------------------------

if ((INFER == 0) && (DEPTH == 8192) && (WIDTH == 16))
  begin
    sdpram_8kx16 sdpram_8kx161 (
      .rd_aclr    ( rst        ),

      .wrclock    ( clk_a      ),
      .wrclocken  ( 1'b1       ),
      .wren       ( write_en_a ),
      .wraddress  ( addr_a     ),
      .data       ( rdata_a    ),

      .rdclock    ( clk_b      ),
      .rdclocken  ( 1'b1       ),
      .rdaddress  ( addr_b     ),
      .q          ( rdata_b    )
    );

  end

//-----------------------------------------------------------------------------
// Infer RAM
//-----------------------------------------------------------------------------

else if (INFER == 1)
  begin
    //-----------------------------------------------------------------------------
    // Initialize memory
    //-----------------------------------------------------------------------------
    /*integer ram_addr= DEPTH;
    while(ram_addr)
    begin
      ram_addr = ram_addr - 1;
      ram_array[ram_addr] = {WIDTH{1'b0}};
    end */
    
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
