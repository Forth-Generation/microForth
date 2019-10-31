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

//-----------------------------------------------------------------------------
// Initialize memory
//-----------------------------------------------------------------------------

`ifdef SIMULATION
initial
  begin
    $readmemh("sram.dat", ram_array);
  end
`endif

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


endmodule
