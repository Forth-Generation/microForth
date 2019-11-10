// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtb__Syms.h"


//======================

void Vtb::traceChg(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    Vtb* t=(Vtb*)userthis;
    Vtb__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (vlSymsp->getClearActivity()) {
	t->traceChgThis(vlSymsp, vcdp, code);
    }
}

//======================


void Vtb::traceChgThis(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	if (VL_UNLIKELY((1U & vlTOPp->__Vm_traceActivity))) {
	    vlTOPp->traceChgThis__2(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((2U & vlTOPp->__Vm_traceActivity))) {
	    vlTOPp->traceChgThis__3(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((1U & ((vlTOPp->__Vm_traceActivity 
				>> 1U) | (vlTOPp->__Vm_traceActivity 
					  >> 3U))))) {
	    vlTOPp->traceChgThis__4(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((4U & vlTOPp->__Vm_traceActivity))) {
	    vlTOPp->traceChgThis__5(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((8U & vlTOPp->__Vm_traceActivity))) {
	    vlTOPp->traceChgThis__6(vlSymsp, vcdp, code);
	}
	vlTOPp->traceChgThis__7(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void Vtb::traceChgThis__2(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus(c+1,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[0]),8);
	vcdp->chgBus(c+2,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[1]),8);
	vcdp->chgBus(c+3,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[2]),8);
	vcdp->chgBus(c+4,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[3]),8);
	vcdp->chgBus(c+5,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[4]),8);
	vcdp->chgBus(c+6,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[5]),8);
	vcdp->chgBus(c+7,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[6]),8);
	vcdp->chgBus(c+8,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[7]),8);
	vcdp->chgBus(c+9,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[8]),8);
	vcdp->chgBus(c+10,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[9]),8);
	vcdp->chgBus(c+11,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[0]),8);
	vcdp->chgBus(c+12,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[1]),8);
	vcdp->chgBus(c+13,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[2]),8);
	vcdp->chgBus(c+14,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[3]),8);
	vcdp->chgBus(c+15,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[4]),8);
	vcdp->chgBus(c+16,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[5]),8);
	vcdp->chgBus(c+17,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[6]),8);
	vcdp->chgBus(c+18,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[7]),8);
	vcdp->chgBus(c+19,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[8]),8);
	vcdp->chgBus(c+20,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[9]),8);
    }
}

void Vtb::traceChgThis__3(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus(c+21,(vlTOPp->tb__DOT__uart_rx_rdata),8);
	vcdp->chgBit(c+22,(vlTOPp->tb__DOT__uart_rx_d_valid));
	vcdp->chgBit(c+23,(vlTOPp->tb__DOT__uart_rx_overflow));
	vcdp->chgBus(c+24,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__Counter__DOT__count),8);
	vcdp->chgBus(c+25,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__Shft_reg__DOT__buffer_reg),8);
	vcdp->chgBus(c+26,(vlTOPp->tb__DOT__uart_tr_top__DOT__Out_Reg__DOT__TBR),8);
	vcdp->chgBus(c+27,(vlTOPp->tb__DOT__uart_tr_top__DOT__Out_Reg__DOT__TSR),10);
    }
}

void Vtb::traceChgThis__4(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit(c+28,((1U & (((IData)(vlTOPp->tb__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				   >> 1U) | (IData)(vlTOPp->tb__DOT__uart_tr_top__DOT__Out_Reg__DOT__TSR)))));
    }
}

void Vtb::traceChgThis__5(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus(c+29,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__load_value),8);
	vcdp->chgBus(c+30,(vlTOPp->tb__DOT__uart_tr_top__DOT__Counter_Val),8);
    }
}

void Vtb::traceChgThis__6(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit(c+31,((1U & ((IData)(vlTOPp->tb__DOT__uart_rcvr_top__DOT__FSM__DOT__Out) 
				  >> 6U))));
	vcdp->chgBit(c+32,(vlTOPp->tb__DOT__uart_tx_tbr_valid));
	vcdp->chgBit(c+33,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__f_edge));
	vcdp->chgBit(c+34,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__Rx_in));
	vcdp->chgBit(c+35,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__CO));
	vcdp->chgBit(c+36,((1U & ((IData)(vlTOPp->tb__DOT__uart_rcvr_top__DOT__FSM__DOT__Out) 
				  >> 7U))));
	vcdp->chgBit(c+37,((1U & ((IData)(vlTOPp->tb__DOT__uart_rcvr_top__DOT__FSM__DOT__Out) 
				  >> 4U))));
	vcdp->chgBus(c+38,((0xfU & (IData)(vlTOPp->tb__DOT__uart_rcvr_top__DOT__FSM__DOT__Out))),4);
	vcdp->chgBit(c+39,((1U & ((IData)(vlTOPp->tb__DOT__uart_rcvr_top__DOT__FSM__DOT__Out) 
				  >> 5U))));
	vcdp->chgBit(c+40,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__Rx_register__DOT__Rx_intermediate));
	vcdp->chgBus(c+41,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__FSM__DOT__state_reg),4);
	vcdp->chgBus(c+42,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__FSM__DOT__Out),8);
	vcdp->chgBit(c+43,(vlTOPp->tb__DOT__uart_tr_top__DOT__CO));
	vcdp->chgBit(c+44,((1U & ((IData)(vlTOPp->tb__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				  >> 4U))));
	vcdp->chgBit(c+45,((1U & ((IData)(vlTOPp->tb__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				  >> 3U))));
	vcdp->chgBit(c+46,((1U & ((IData)(vlTOPp->tb__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				  >> 1U))));
	vcdp->chgBit(c+47,((1U & ((IData)(vlTOPp->tb__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				  >> 2U))));
	vcdp->chgBit(c+48,((1U & (IData)(vlTOPp->tb__DOT__uart_tr_top__DOT__FSM1__DOT__out))));
	vcdp->chgBus(c+49,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROMaddr),4);
	vcdp->chgBus(c+50,(vlTOPp->tb__DOT__uart_tr_top__DOT__FSM1__DOT__state),4);
	vcdp->chgBus(c+51,(vlTOPp->tb__DOT__uart_tr_top__DOT__FSM1__DOT__out),5);
	vcdp->chgBus(c+52,(vlTOPp->tb__DOT__uart_tr_top__DOT__Cntr__DOT__count),8);
    }
}

void Vtb::traceChgThis__7(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit(c+53,(vlTOPp->verilator_clk));
	vcdp->chgBit(c+54,(vlTOPp->verilator_rst));
    }
}
