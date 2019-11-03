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

  parameter ADDR_WIDTH = $clog2(DEPTH)
) (

  input  wire                   clk,
  input  wire                   rst,

  input  wire  [ADDR_WIDTH-1:0] addr_a,
  input  wire       [WIDTH-1:0] wdata_a,
  input  wire                   write_en_a,
  output wire       [WIDTH-1:0] rdata_a,

  input  wire  [ADDR_WIDTH-1:0] addr_b,
  output wire       [WIDTH-1:0] rdata_b

);

//-----------------------------------------------------------------------------
// Internal signals
//-----------------------------------------------------------------------------

reg        [WIDTH-1:0] ram_array [0:DEPTH-1];

reg   [ADDR_WIDTH-1:0] ram_addr_a;
reg   [ADDR_WIDTH-1:0] ram_addr_b;


generate

//-----------------------------------------------------------------------------
// Instantiate megafunction
//-----------------------------------------------------------------------------

if ((INFER == 0) && (DEPTH == 8192) && (WIDTH == 16))
begin
  sdpram_8kx16 sdpram_8kx161 (
    .rd_aclr    ( rst        ),

    .wrclock    ( clk        ),
    .wrclocken  ( 1'b1       ),
    .wren       ( write_en_a ),
    .wraddress  ( addr_a     ),
    .data       ( rdata_a    ),

    .rdclock    ( clk        ),
    .rdclocken  ( 1'b1       ),
    .rdaddress  ( addr_b     ),
    .q          ( rdata_b    )
  );

end

//-----------------------------------------------------------------------------
// Infer RAM
//-----------------------------------------------------------------------------

if (INFER == 1)
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

  always @ (posedge clk or posedge rst)
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
  //-----------------------------------------------------------------------------

  assign rdata_b = ram_array[ram_addr_b];

  always @ (posedge clk or posedge rst)
    if (rst)
      ram_addr_b <= {ADDR_WIDTH{1'b0}};
    else
      ram_addr_b <= addr_b;
end

endgenerate

endmodule
