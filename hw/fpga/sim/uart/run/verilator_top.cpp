#include "Vtb.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char** argv, char** env) {

  float main_time = 0;

  // Initialize verilators variables
  Verilated::commandArgs(argc, argv);

  // Create an instance of the dut
  Vtb* top = new Vtb;

  // Dump waveform
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp =  new VerilatedVcdC;
  top->trace(tfp, 99); // Trace 99 levels of hierarchy
  tfp->open("wave.vcd");

  top->verilator_clk = 1;
  top->verilator_rst = 1;

  while (main_time < 100000 && !Verilated::gotFinish()) {
    top->verilator_clk = ~top->verilator_clk;
    top->eval();
    tfp->dump(main_time);
    top->verilator_rst = 0;
    main_time += 31.25;
  }

  tfp->close();
  delete top;

  exit(0);
}
