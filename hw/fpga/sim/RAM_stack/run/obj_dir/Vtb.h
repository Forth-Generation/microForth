// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary design header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef _Vtb_H_
#define _Vtb_H_

#include "verilated_heavy.h"
#include "Vtb__Dpi.h"

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
    // Anonymous structures to workaround compiler member-count bugs
    struct {
	// Begin mtask footprint  all: 
	VL_SIG8(tb__DOT__rst_n,0,0);
	VL_SIG8(tb__DOT__top__DOT__rst,0,0);
	VL_SIG8(tb__DOT__clk_16,0,0);
	VL_SIG8(tb__DOT__gpio,7,0);
	VL_SIG8(tb__DOT__top__DOT__j1_io_rd,0,0);
	VL_SIG8(tb__DOT__top__DOT__j1_io_wr,0,0);
	VL_SIG8(tb__DOT__top__DOT__uart_rx_rd,0,0);
	VL_SIG8(tb__DOT__top__DOT__uart_rx_clr_ovrflw,0,0);
	VL_SIG8(tb__DOT__top__DOT__uart_rx_rdata,7,0);
	VL_SIG8(tb__DOT__top__DOT__uart_rx_d_valid,0,0);
	VL_SIG8(tb__DOT__top__DOT__uart_rx_overflow,0,0);
	VL_SIG8(tb__DOT__top__DOT__uart_tx_wr,0,0);
	VL_SIG8(tb__DOT__top__DOT__uart_tx_tbr_valid,0,0);
	VL_SIG8(tb__DOT__top__DOT__rst_n_1,0,0);
	VL_SIG8(tb__DOT__top__DOT__rst_n_2,0,0);
	VL_SIG8(tb__DOT__top__DOT__rst_count,5,0);
	VL_SIG8(tb__DOT__top__DOT__gpio_out,7,0);
	VL_SIG8(tb__DOT__top__DOT__gpio_oe,7,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__dsp,3,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__dspN,3,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__dstkW,0,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__rstkW,0,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__reboot,0,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__dspI,1,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__rspI,1,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__is_alu,0,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__wr_addr,3,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__wr_addr_sig,3,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__rd_addr,3,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__delta_br,1,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__stack_wr_addr_reg,3,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__stack_rd_addr_reg,3,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__dble_push_buf,0,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_addr_a,3,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__wr_addr,4,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__wr_addr_sig,4,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__rd_addr,4,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__delta_br,1,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__stack_wr_addr_reg,4,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__stack_rd_addr_reg,4,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__dble_push_buf,0,0);
	VL_SIG8(tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_addr_a,4,0);
	VL_SIG8(tb__DOT__top__DOT__csr1__DOT__led,0,0);
	VL_SIG8(tb__DOT__top__DOT__uart_rcvr_top__DOT__f_edge,0,0);
	VL_SIG8(tb__DOT__top__DOT__uart_rcvr_top__DOT__Rx_in,0,0);
	VL_SIG8(tb__DOT__top__DOT__uart_rcvr_top__DOT__CO,0,0);
	VL_SIG8(tb__DOT__top__DOT__uart_rcvr_top__DOT__load_value,7,0);
	VL_SIG8(tb__DOT__top__DOT__uart_rcvr_top__DOT__Rx_register__DOT__Rx_intermediate,0,0);
	VL_SIG8(tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__state_reg,3,0);
	VL_SIG8(tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__Out,7,0);
	VL_SIG8(tb__DOT__top__DOT__uart_rcvr_top__DOT__Counter__DOT__count,7,0);
	VL_SIG8(tb__DOT__top__DOT__uart_rcvr_top__DOT__Shft_reg__DOT__shft_reg,7,0);
	VL_SIG8(tb__DOT__top__DOT__uart_rcvr_top__DOT__Shft_reg__DOT__buffer_reg,7,0);
	VL_SIG8(tb__DOT__top__DOT__uart_tr_top__DOT__CO,0,0);
	VL_SIG8(tb__DOT__top__DOT__uart_tr_top__DOT__Counter_Val,7,0);
	VL_SIG8(tb__DOT__top__DOT__uart_tr_top__DOT__ROMaddr,3,0);
	VL_SIG8(tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__state,3,0);
	VL_SIG8(tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__out,4,0);
	VL_SIG8(tb__DOT__top__DOT__uart_tr_top__DOT__Out_Reg__DOT__TBR,7,0);
	VL_SIG8(tb__DOT__top__DOT__uart_tr_top__DOT__Cntr__DOT__count,7,0);
	VL_SIG16(tb__DOT__top__DOT__j1_prb__DOT__st0,15,0);
	VL_SIG16(tb__DOT__top__DOT__j1_prb__DOT__st0N,15,0);
	VL_SIG16(tb__DOT__top__DOT__j1_prb__DOT__pc,12,0);
	VL_SIG16(tb__DOT__top__DOT__j1_prb__DOT__pcN,12,0);
    };
    struct {
	VL_SIG16(tb__DOT__top__DOT__j1_prb__DOT__rstkD,15,0);
	VL_SIG16(tb__DOT__top__DOT__j1_prb__DOT__st1,15,0);
	VL_SIG16(tb__DOT__top__DOT__j1_prb__DOT__rst0,15,0);
	VL_SIG16(tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__lst_wd,15,0);
	VL_SIG16(tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_rdata_b,15,0);
	VL_SIG16(tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__lst_wd,15,0);
	VL_SIG16(tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_rdata_b,15,0);
	VL_SIG16(tb__DOT__top__DOT__sram__DOT__ram_addr_a,12,0);
	VL_SIG16(tb__DOT__top__DOT__sram__DOT__ram_rdata_b,15,0);
	VL_SIG16(tb__DOT__top__DOT__uart_tr_top__DOT__Out_Reg__DOT__TSR,9,0);
	VL_SIG(tb__DOT__i,31,0);
	VL_SIG(tb__DOT__j,31,0);
	VL_SIG(tb__DOT__k,31,0);
	VL_SIG(tb__DOT__top__DOT__j1_prb__DOT__minus,16,0);
	VL_SIG64(tb__DOT__top__DOT__count,32,0);
	VL_SIG16(tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_array[15],15,0);
	VL_SIG16(tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[17],15,0);
	VL_SIG16(tb__DOT__top__DOT__sram__DOT__ram_array[8192],15,0);
	VL_SIG8(tb__DOT__top__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[10],7,0);
	VL_SIG8(tb__DOT__top__DOT__uart_tr_top__DOT__ROM__DOT__mem[10],7,0);
    };
    
    // LOCAL VARIABLES
    // Internals; generally not touched by application code
    // Begin mtask footprint  all: 
    VL_SIG8(tb__DOT__top__DOT__gpio__out__out0,7,0);
    VL_SIG8(tb__DOT__top__DOT__gpio__out__out1,7,0);
    VL_SIG8(tb__DOT__top__DOT__gpio__out__out2,7,0);
    VL_SIG8(tb__DOT__top__DOT__gpio__out__out3,7,0);
    VL_SIG8(tb__DOT__top__DOT__gpio__out__out4,7,0);
    VL_SIG8(tb__DOT__top__DOT__gpio__out__out5,7,0);
    VL_SIG8(tb__DOT__top__DOT__gpio__out__out6,7,0);
    VL_SIG8(tb__DOT__top__DOT__gpio__out__out7,7,0);
    VL_SIG8(__VinpClk__TOP__tb__DOT__rst_n,0,0);
    VL_SIG8(__VinpClk__TOP__tb__DOT__top__DOT__rst,0,0);
    VL_SIG8(__Vclklast__TOP____VinpClk__TOP__tb__DOT__rst_n,0,0);
    VL_SIG8(__Vclklast__TOP__verilator_clk,0,0);
    VL_SIG8(__Vclklast__TOP____VinpClk__TOP__tb__DOT__top__DOT__rst,0,0);
    VL_SIG8(__Vchglast__TOP__tb__DOT__rst_n,0,0);
    VL_SIG8(__Vchglast__TOP__tb__DOT__top__DOT__rst,0,0);
    VL_SIG16(tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT____Vlvbound1,15,0);
    VL_SIG16(tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT____Vlvbound1,15,0);
    VL_SIG(__Vm_traceActivity,31,0);
    VL_SIG8(__Vtablechg1[256],1,0);
    VL_SIG8(__Vtablechg2[128],2,0);
    static VL_ST_SIG8(__Vtable1_tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__state_reg[256],3,0);
    static VL_ST_SIG8(__Vtable1_tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__Out[256],7,0);
    static VL_ST_SIG8(__Vtable2_tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__state[128],3,0);
    static VL_ST_SIG8(__Vtable2_tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__out[128],4,0);
    static VL_ST_SIG8(__Vtable2_tb__DOT__top__DOT__uart_tr_top__DOT__ROMaddr[128],3,0);
    
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
  public:
    static void _combo__TOP__10(Vtb__Syms* __restrict vlSymsp);
    static void _combo__TOP__6(Vtb__Syms* __restrict vlSymsp);
  private:
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
    static void _sequent__TOP__3(Vtb__Syms* __restrict vlSymsp);
    static void _sequent__TOP__4(Vtb__Syms* __restrict vlSymsp);
    static void _sequent__TOP__7(Vtb__Syms* __restrict vlSymsp);
    static void _sequent__TOP__8(Vtb__Syms* __restrict vlSymsp);
    static void _sequent__TOP__9(Vtb__Syms* __restrict vlSymsp);
    static void _settle__TOP__5(Vtb__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void traceChgThis(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__10(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__11(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__12(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__13(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__14(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__2(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__3(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__4(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__5(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__6(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__7(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__8(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__9(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceFullThis(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) VL_ATTR_COLD;
    static void traceFullThis__1(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) VL_ATTR_COLD;
    static void traceInitThis(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) VL_ATTR_COLD;
    static void traceInitThis__1(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) VL_ATTR_COLD;
    static void traceInit(VerilatedVcd* vcdp, void* userthis, uint32_t code);
    static void traceFull(VerilatedVcd* vcdp, void* userthis, uint32_t code);
    static void traceChg(VerilatedVcd* vcdp, void* userthis, uint32_t code);
} VL_ATTR_ALIGNED(128);

#endif // guard
