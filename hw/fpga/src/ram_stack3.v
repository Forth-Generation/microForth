//-----------------------------------------------------------------------------
//
// File:        ram_stack3.v
// Author:      Mark Sapper
// Description: ram based stack
//
//-----------------------------------------------------------------------------

module ram_stack3 #( 
  parameter WIDTH = 16,
  parameter DEPTH = 512,
  parameter INFER = 0
) (
  input  wire             clk,
  input  wire             rst,

  input  wire             we,
  input  wire       [1:0] delta,

  input  wire [WIDTH-1:0] wd,

  output wire [WIDTH-1:0] rd
);

localparam ADDR_WIDTH = $clog2(DEPTH);

//-----------------------------------------------------------------------------
// Internal signals
//-----------------------------------------------------------------------------

wire      [WIDTH-1:0] ram_rdata;
wire      [WIDTH-1:0] ram_wdata;
wire                  ram_write;

reg  [ADDR_WIDTH-1:0] next_ram_addr;
reg  [ADDR_WIDTH-1:0] shadow_ram_addr;

wire [ADDR_WIDTH-1:0] one = 'd1;

wire                  push;
wire                  pop;

//-----------------------------------------------------------------------------
// Decode push and pop operations from inputs
//-----------------------------------------------------------------------------

assign push =  we & (delta == 2'b01);
assign pop  = ~we & (delta == 2'b11);

//-----------------------------------------------------------------------------
// RAM address counter
// The actual RAM address register is internal to the RAM megafunction
// so we calculate the next address and keep a shadow copy
//-----------------------------------------------------------------------------

// address increments on push, decrements on pop, else holds
always @ ( * )
  if (push)
    next_ram_addr <= shadow_ram_addr + one;

  else if (pop)
    next_ram_addr <= shadow_ram_addr - one;

  else
    next_ram_addr <= shadow_ram_addr;

// shadow register
always @ (posedge clk or posedge rst)
  if (rst)
    shadow_ram_addr <= 'd0;
  else
    shadow_ram_addr <= next_ram_addr;

//-----------------------------------------------------------------------------
// SRAM
//-----------------------------------------------------------------------------

assign ram_wdata = wd;
//assign ram_write = push;
assign ram_write = we;              // Allows 'swap' to overwrite 'st1' without pushing (delta = 0)

assign rd = ram_rdata;

sram #(
  .WIDTH                  ( WIDTH         ),
  .DEPTH                  ( DEPTH         ),
  .INFER                  ( INFER         ),
  .TYPE                   ( "single_port" )

) sram (
  .rst                    ( rst           ),
  .clk_a                  ( clk           ),
  .addr_a                 ( next_ram_addr ),
  .wdata_a                ( ram_wdata     ),
  .write_en_a             ( ram_write     ),
  .rdata_a                ( ram_rdata     )
);


endmodule

