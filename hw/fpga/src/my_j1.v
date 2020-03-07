//`default_nettype none
`define WIDTH 16

module my_j1 #(
  parameter WIDTH = 16

) (
  input wire 		  clk,
  input wire 		  resetq,

  output wire 		  io_rd,
  output wire 		  io_wr,
  output wire [15:0] 	  mem_addr, // DATA write/read address (prb)
  output wire 		  mem_wr,
  output wire [WIDTH-1:0] dout, // write DATA (prb)

  input wire [WIDTH-1:0]  io_din,

  output wire [12:0] 	  code_addr, // next Instruction (prb)
  input wire [15:0]       rmem_data,    //read data from memory port a(jmt)
  input wire [17:0] 	  insn);        // current instruction word (prb)

  reg [3:0] dsp, dspN;             // data stack pointer
  reg [WIDTH-1:0] st0, st0N;       // top of data stack
  reg dstkW;                       // data stack write

  reg [12:0] pc /* verilator public_flat */, pcN;           // program counter
  wire [12:0] pc_plus_1 = pc + 13'd1;
  wire [13:0] relative_addr;       //jmt -- relative address calc uses signed numbers
  reg rstkW;                       // return stack write
  wire [WIDTH-1:0] rstkD;          // return stack write value
  reg reboot = 1;

  assign mem_addr = st0[15:0];     // DATA (prb)
  assign code_addr = pcN;          // next Instruction (prb)

  // The D and R stacks
  wire [WIDTH-1:0] st1, rst0;      // st1 is N data out (prb)
  reg [1:0] dspI, rspI;            // stack pointer increment values (prb)
  ram_stack3 #(.WIDTH(WIDTH), .DEPTH(512), .INFER(1)) dstack(.clk(clk), .rst(~resetq), .rd(st1),  .we(dstkW), .wd(st0),   .delta(dspI));
  ram_stack3 #(.WIDTH(WIDTH), .DEPTH(512), .INFER(1)) rstack(.clk(clk), .rst(~resetq), .rd(rst0), .we(rstkW), .wd(rstkD), .delta(rspI));

  wire [16:0] minus = {1'b1, ~st0} + st1 + {{WIDTH-1{1'b0}}, 1'b1};
  wire signedless = st0[15] ^ st1[15] ? st1[15] : minus[16];

  always @*
  begin
    // Compute the new value of st0
    casez (insn[17:8])
      10'b10_???_?????: st0N = rmem_data;     // fetch(jmt)
      10'b00_???_?????: st0N = insn[15:0];    // immediate literal
      10'b01_000_?????,                                 // jump
      10'b01_100_?????: st0N = st0;                     // relative jump(jmt)
      10'b01_010_?????,                                 // call
      10'b01_110_?????: st0N = st0;                     // relative call(jmt)
      10'b01_001_?????,                                 // conditonal jump
      10'b01_101_?????: st0N = st1;                     // relative conditional jump(jmt)
      10'b01_011_?0000: st0N = st0;                     // ALU operations...
      10'b01_011_?0001: st0N = st1;
      10'b01_011_?0010: st0N = st0 + st1;
      10'b01_011_?0011: st0N = st0 & st1;
      10'b01_011_?0100: st0N = st0 | st1;
      10'b01_011_?0101: st0N = st0 ^ st1;
      10'b01_011_?0110: st0N = ~st0;

      10'b01_011_?0111: st0N = {WIDTH{(minus == 0)}};                //  =
      10'b01_011_?1000: st0N = {WIDTH{(signedless)}};                //  <

      10'b01_011_?1001: st0N = {st0[WIDTH - 1], st0[WIDTH - 1:1]};
      10'b01_011_?1010: st0N = {st0[WIDTH - 2:0], 1'b0};
      10'b01_011_?1011: st0N = rst0;
      10'b01_011_?1100: st0N = minus[15:0];
      10'b01_011_?1101: st0N = io_din;
      10'b01_011_?1110: st0N = {{(WIDTH - 4){1'b0}}, dsp};
      10'b01_011_?1111: st0N = {WIDTH{(minus[16])}};                 // u<
      default: st0N = {WIDTH{1'bx}};
    endcase
  end

  wire func_T_N =   (insn[6:4] == 1);
  wire func_T_R =   (insn[6:4] == 2);
  wire func_write = (insn[6:4] == 3);
  wire func_iow =   (insn[6:4] == 4);
  wire func_ior =   (insn[6:4] == 5);

  wire is_alu = (insn[17:13] == 5'b01011);
  assign mem_wr = !reboot & is_alu & func_write;
  assign dout = st1;
  assign io_wr = !reboot & is_alu & func_iow;
  assign io_rd = !reboot & is_alu & func_ior;

  assign rstkD = (insn[13] == 1'b0) ? {{(WIDTH - 14){1'b0}}, pc_plus_1, 1'b0} : st0;
  assign relative_addr = {1'b0,pc} + {insn[12],insn[12:0]}; //relative branch address(jmt)
                                                            // relative offset is signed
   
  always @*
  begin
        // determine data stack write and incr/decr value (prb)
    casez ({insn[17:13],resetq})                      // Added reset to case(jmt)
    6'b00_???_1,
    6'b10_???_1:   {dstkW, dspI} = {1'b1,      2'b01};        // push fetch/immediate literal on Dstack (prb)
    6'b01_001_1:   {dstkW, dspI} = {1'b0,      2'b11};        // conditional jump pop Dstack (prb)
    6'b01_011_1:   {dstkW, dspI} = {func_T_N,  {insn[1:0]}};  // alu function, write Dstack if func_T_N (prb)
    default:    {dstkW, dspI} = {1'b0,      2'b00};
    endcase
    dspN = dsp + {dspI[1], dspI[1], dspI};

        // determine return stack write and incr/decr value (prb)
    casez ({insn[17:13], resetq})                   //Added reset to case (jmt)
   // 5'b1_???_1:   {rstkW, rspI} = {1'b0,      2'b11};        // "fetch" return - pop Rstack (prb)
    6'b01_010_1:   {rstkW, rspI} = {1'b1,      2'b01};        // call or fetch - push Rstack (prb)
    6'b01_011_1:   {rstkW, rspI} = {func_T_R,  insn[3:2]};    // alu (prb)
    default:    {rstkW, rspI} = {1'b0,      2'b00};
    endcase

        // calculate next PC address
    casez ({reboot, insn[17:13], insn[7], |st0})      
    8'b1_??_???_?_?:   pcN = 0;            // Reset - clear PC
    
    8'b0_01_000_?_?,                       // jump absolute (prb)
    8'b0_01_010_?_?,                       // call absolute (prb)
    8'b0_01_001_?_0:   pcN = insn[12:0];   // conditional branch if st0==0 (prb)

    8'b0_01_100_?_?,                       // jump relative (jmt)
    8'b0_01_110_?_?,                       // call relative (jmt)
    8'b0_01_101_?_0:   pcN = relative_addr[12:0];   // conditional branch if st0==0 (jmt) 
      
   // 7'b0_1_???_?_?,                       // "fetch" return (prb)
    8'b0_01_011_1_?:   pcN = rst0[13:1];   // return (prb)
    
    default:          pcN = pc_plus_1;
    endcase
  end

  always @(negedge resetq or posedge clk)
  begin
    if (!resetq) begin
      reboot <= 1'b1;
      { pc, dsp, st0} <= 0;
    end else begin
      reboot <= 0;
      { pc, dsp, st0} <= { pcN, dspN, st0N };
    end
  end

endmodule
