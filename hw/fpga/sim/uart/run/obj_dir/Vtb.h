// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary design header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef _Vtb_H_
#define _Vtb_H_

#include "verilated_heavy.h"

class Vtb__Syms;
class VerilatedVcd;

//----------

VL_MODULE(Vtb) {
  public:
    
    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    // Begin mtask footprint  all: 
    VL_IN8(verilator_clk,0,0);
    VL_IN8(verilator_rst,0,0);
    
    // LOCAL SIGNALS
    // Internals; generally not touched by application code
    // Begin mtask footprint  all: 
    VL_SIG8(tb__DOT__clk_16,0,0);
    VL_SIG8(tb__DOT__uart_rxd,0,0);
    VL_SIG8(tb__DOT__uart_rx_rd,0,0);
    VL_SIG8(tb__DOT__uart_rx_clr_ovrflw,0,0);
    VL_SIG8(tb__DOT__uart_rx_rdata,7,0);
    VL_SIG8(tb__DOT__uart_rx_d_valid,0,0);
    VL_SIG8(tb__DOT__uart_rx_overflow,0,0);
    VL_SIG8(tb__DOT__uart_tx_wdata,7,0);
    VL_SIG8(tb__DOT__uart_tx_wr,0,0);
    VL_SIG8(tb__DOT__uart_tx_tbr_valid,0,0);
    VL_SIG8(tb__DOT__uart_rcvr_top__DOT__f_edge,0,0);
    VL_SIG8(tb__DOT__uart_rcvr_top__DOT__Rx_in,0,0);
    VL_SIG8(tb__DOT__uart_rcvr_top__DOT__CO,0,0);
    VL_SIG8(tb__DOT__uart_rcvr_top__DOT__load_value,7,0);
    VL_SIG8(tb__DOT__uart_rcvr_top__DOT__Rx_register__DOT__Rx_intermediate,0,0);
    VL_SIG8(tb__DOT__uart_rcvr_top__DOT__FSM__DOT__state_reg,3,0);
    VL_SIG8(tb__DOT__uart_rcvr_top__DOT__FSM__DOT__Out,7,0);
    VL_SIG8(tb__DOT__uart_rcvr_top__DOT__Counter__DOT__count,7,0);
    VL_SIG8(tb__DOT__uart_rcvr_top__DOT__Shft_reg__DOT__buffer_reg,7,0);
    VL_SIG8(tb__DOT__uart_tr_top__DOT__CO,0,0);
    VL_SIG8(tb__DOT__uart_tr_top__DOT__Counter_Val,7,0);
    VL_SIG8(tb__DOT__uart_tr_top__DOT__ROMaddr,3,0);
    VL_SIG8(tb__DOT__uart_tr_top__DOT__FSM1__DOT__state,3,0);
    VL_SIG8(tb__DOT__uart_tr_top__DOT__FSM1__DOT__out,4,0);
    VL_SIG8(tb__DOT__uart_tr_top__DOT__Out_Reg__DOT__TBR,7,0);
    VL_SIG8(tb__DOT__uart_tr_top__DOT__Cntr__DOT__count,7,0);
    VL_SIG16(tb__DOT__uart_tr_top__DOT__Out_Reg__DOT__TSR,9,0);
    VL_SIG(tb__DOT__i,31,0);
    VL_SIG(tb__DOT__j,31,0);
    VL_SIG(tb__DOT__k,31,0);
    VL_SIG8(tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[10],7,0);
    VL_SIG8(tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[10],7,0);
    
    // LOCAL VARIABLES
    // Internals; generally not touched by application code
    // Begin mtask footprint  all: 
    VL_SIG8(__Vdly__tb__DOT__uart_rcvr_top__DOT__Rx_in,0,0);
    VL_SIG8(__Vdly__tb__DOT__uart_rcvr_top__DOT__CO,0,0);
    VL_SIG8(__Vdly__tb__DOT__uart_tr_top__DOT__FSM1__DOT__out,4,0);
    VL_SIG8(__Vdly__tb__DOT__uart_tr_top__DOT__Cntr__DOT__count,7,0);
    VL_SIG8(__Vclklast__TOP__verilator_clk,0,0);
    VL_SIG8(__Vclklast__TOP__verilator_rst,0,0);
    VL_SIG(__Vm_traceActivity,31,0);
    VL_SIG8(__Vtablechg1[256],1,0);
    VL_SIG8(__Vtablechg2[128],2,0);
    static VL_ST_SIG8(__Vtable1_tb__DOT__uart_rcvr_top__DOT__FSM__DOT__state_reg[256],3,0);
    static VL_ST_SIG8(__Vtable1_tb__DOT__uart_rcvr_top__DOT__FSM__DOT__Out[256],7,0);
    static VL_ST_SIG8(__Vtable2_tb__DOT__uart_tr_top__DOT__FSM1__DOT__state[128],3,0);
    static VL_ST_SIG8(__Vtable2_tb__DOT__uart_tr_top__DOT__FSM1__DOT__out[128],4,0);
    static VL_ST_SIG8(__Vtable2_tb__DOT__uart_tr_top__DOT__ROMaddr[128],3,0);
    
    // INTERNAL VARIABLES
    // Internals; generally not touched by application code
    Vtb__Syms* __VlSymsp;  // Symbol table
    
    // PARAMETERS
    // Parameters marked /*verilator public*/ for use by application code
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vtb);  ///< Copying not allowed
  public:
    /// Construct the model; called by application code
    /// The special name  may be used to make a wrapper with a
    /// single model invisible with respect to DPI scope names.
    Vtb(const char* name="TOP");
    /// Destroy the model; called (often implicitly) by application code
    ~Vtb();
    /// Trace signals in the model; called by application code
    void trace(VerilatedVcdC* tfp, int levels, int options=0);
    
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval();
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    
    // INTERNAL METHODS
  private:
    static void _eval_initial_loop(Vtb__Syms* __restrict vlSymsp);
  public:
    void __Vconfigure(Vtb__Syms* symsp, bool first);
  private:
    static QData _change_request(Vtb__Syms* __restrict vlSymsp);
    void _ctor_var_reset() VL_ATTR_COLD;
  public:
    static void _eval(Vtb__Syms* __restrict vlSymsp);
  private:
#ifdef VL_DEBUG
    void _eval_debug_assertions();
#endif // VL_DEBUG
  public:
    static void _eval_initial(Vtb__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _eval_settle(Vtb__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _initial__TOP__1(Vtb__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _sequent__TOP__2(Vtb__Syms* __restrict vlSymsp);
    static void _sequent__TOP__3(Vtb__Syms* __restrict vlSymsp);
    static void _sequent__TOP__5(Vtb__Syms* __restrict vlSymsp);
    static void _settle__TOP__4(Vtb__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void traceChgThis(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__2(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__3(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__4(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__5(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__6(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__7(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceFullThis(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) VL_ATTR_COLD;
    static void traceFullThis__1(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) VL_ATTR_COLD;
    static void traceInitThis(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) VL_ATTR_COLD;
    static void traceInitThis__1(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) VL_ATTR_COLD;
    static void traceInit(VerilatedVcd* vcdp, void* userthis, uint32_t code);
    static void traceFull(VerilatedVcd* vcdp, void* userthis, uint32_t code);
    static void traceChg(VerilatedVcd* vcdp, void* userthis, uint32_t code);
} VL_ATTR_ALIGNED(128);

#endif // guard
