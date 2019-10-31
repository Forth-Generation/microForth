#include "Vtb.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char** argv, char** env) {

  vluint64_t main_time = 0;

  // Initialize verilators variables
  Verilated::commandArgs(argc, argv);

  // Create an instance of the dut
  Vtb* top = new Vtb;

  // Dump waveform
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp =  new VerilatedVcdC;
  top->trace(tfp, 99); // Trace 99 levels of hierarchy
  tfp->open("wave.vcd");

  while (!Verilated::gotFinish()) {
    main_time += 1;
    top->verilator_clk = 1;
    top->eval();
    top->verilator_clk = 0;
    top->eval();
    tfp->dump(main_time);
  }

  tfp->close();
  delete top;

  exit(0);
}
