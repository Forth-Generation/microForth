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
	if (VL_UNLIKELY((1U & (vlTOPp->__Vm_traceActivity 
			       | (vlTOPp->__Vm_traceActivity 
				  >> 1U))))) {
	    vlTOPp->traceChgThis__3(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((1U & ((vlTOPp->__Vm_traceActivity 
				| (vlTOPp->__Vm_traceActivity 
				   >> 1U)) | (vlTOPp->__Vm_traceActivity 
					      >> 2U))))) {
	    vlTOPp->traceChgThis__4(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((1U & (vlTOPp->__Vm_traceActivity 
			       | (vlTOPp->__Vm_traceActivity 
				  >> 2U))))) {
	    vlTOPp->traceChgThis__5(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((1U & ((vlTOPp->__Vm_traceActivity 
				| (vlTOPp->__Vm_traceActivity 
				   >> 2U)) | (vlTOPp->__Vm_traceActivity 
					      >> 4U))))) {
	    vlTOPp->traceChgThis__6(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((1U & ((vlTOPp->__Vm_traceActivity 
				| (vlTOPp->__Vm_traceActivity 
				   >> 3U)) | (vlTOPp->__Vm_traceActivity 
					      >> 4U))))) {
	    vlTOPp->traceChgThis__7(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((1U & (vlTOPp->__Vm_traceActivity 
			       | (vlTOPp->__Vm_traceActivity 
				  >> 4U))))) {
	    vlTOPp->traceChgThis__8(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((1U & (vlTOPp->__Vm_traceActivity 
			       | (vlTOPp->__Vm_traceActivity 
				  >> 6U))))) {
	    vlTOPp->traceChgThis__9(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((2U & vlTOPp->__Vm_traceActivity))) {
	    vlTOPp->traceChgThis__10(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((4U & vlTOPp->__Vm_traceActivity))) {
	    vlTOPp->traceChgThis__11(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((8U & vlTOPp->__Vm_traceActivity))) {
	    vlTOPp->traceChgThis__12(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((0x10U & vlTOPp->__Vm_traceActivity))) {
	    vlTOPp->traceChgThis__13(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((0x20U & vlTOPp->__Vm_traceActivity))) {
	    vlTOPp->traceChgThis__14(vlSymsp, vcdp, code);
	}
	vlTOPp->traceChgThis__15(vlSymsp, vcdp, code);
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
	vcdp->chgBus(c+1,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[0]),8);
	vcdp->chgBus(c+2,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[1]),8);
	vcdp->chgBus(c+3,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[2]),8);
	vcdp->chgBus(c+4,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[3]),8);
	vcdp->chgBus(c+5,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[4]),8);
	vcdp->chgBus(c+6,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[5]),8);
	vcdp->chgBus(c+7,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[6]),8);
	vcdp->chgBus(c+8,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[7]),8);
	vcdp->chgBus(c+9,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[8]),8);
	vcdp->chgBus(c+10,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[9]),8);
	vcdp->chgBus(c+11,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__ROM__DOT__mem[0]),8);
	vcdp->chgBus(c+12,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__ROM__DOT__mem[1]),8);
	vcdp->chgBus(c+13,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__ROM__DOT__mem[2]),8);
	vcdp->chgBus(c+14,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__ROM__DOT__mem[3]),8);
	vcdp->chgBus(c+15,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__ROM__DOT__mem[4]),8);
	vcdp->chgBus(c+16,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__ROM__DOT__mem[5]),8);
	vcdp->chgBus(c+17,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__ROM__DOT__mem[6]),8);
	vcdp->chgBus(c+18,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__ROM__DOT__mem[7]),8);
	vcdp->chgBus(c+19,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__ROM__DOT__mem[8]),8);
	vcdp->chgBus(c+20,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__ROM__DOT__mem[9]),8);
    }
}

void Vtb::traceChgThis__3(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus(c+21,(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_array
			   [vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_addr_a]),16);
    }
}

void Vtb::traceChgThis__4(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Variables
    // Begin mtask footprint  all: 
    VL_SIGW(__Vtemp44,287,0,9);
    // Body
    {
	vcdp->chgBit(c+22,((((~ (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__reboot)) 
			     & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__is_alu)) 
			    & (3U == (7U & ((IData)(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_rdata_b) 
					    >> 4U))))));
	__Vtemp44[0U] = ((2U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rspI))
			  ? ((vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[1U] 
			      << 0x10U) | (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[0U] 
					   >> 0x10U))
			  : ((0xffff0000U & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[0U] 
					     << 0x10U)) 
			     | (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__head)));
	__Vtemp44[1U] = ((2U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rspI))
			  ? ((vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[2U] 
			      << 0x10U) | (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[1U] 
					   >> 0x10U))
			  : ((0xffffU & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[0U] 
					 >> 0x10U)) 
			     | (0xffff0000U & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[1U] 
					       << 0x10U))));
	__Vtemp44[2U] = ((2U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rspI))
			  ? ((vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[3U] 
			      << 0x10U) | (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[2U] 
					   >> 0x10U))
			  : ((0xffffU & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[1U] 
					 >> 0x10U)) 
			     | (0xffff0000U & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[2U] 
					       << 0x10U))));
	__Vtemp44[3U] = ((2U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rspI))
			  ? ((vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[4U] 
			      << 0x10U) | (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[3U] 
					   >> 0x10U))
			  : ((0xffffU & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[2U] 
					 >> 0x10U)) 
			     | (0xffff0000U & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[3U] 
					       << 0x10U))));
	__Vtemp44[4U] = ((2U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rspI))
			  ? ((vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[5U] 
			      << 0x10U) | (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[4U] 
					   >> 0x10U))
			  : ((0xffffU & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[3U] 
					 >> 0x10U)) 
			     | (0xffff0000U & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[4U] 
					       << 0x10U))));
	__Vtemp44[5U] = ((2U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rspI))
			  ? ((vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[6U] 
			      << 0x10U) | (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[5U] 
					   >> 0x10U))
			  : ((0xffffU & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[4U] 
					 >> 0x10U)) 
			     | (0xffff0000U & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[5U] 
					       << 0x10U))));
	__Vtemp44[6U] = ((2U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rspI))
			  ? ((vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[7U] 
			      << 0x10U) | (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[6U] 
					   >> 0x10U))
			  : ((0xffffU & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[5U] 
					 >> 0x10U)) 
			     | (0xffff0000U & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[6U] 
					       << 0x10U))));
	__Vtemp44[7U] = ((2U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rspI))
			  ? ((vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[8U] 
			      << 0x10U) | (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[7U] 
					   >> 0x10U))
			  : ((0xffffU & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[6U] 
					 >> 0x10U)) 
			     | (0xffff0000U & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[7U] 
					       << 0x10U))));
	__Vtemp44[8U] = ((2U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rspI))
			  ? 0x55aaU : (0xffffU & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[7U] 
						  >> 0x10U)));
	vcdp->chgArray(c+23,(__Vtemp44),272);
    }
}

void Vtb::traceChgThis__5(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus(c+32,(vlTOPp->tb__DOT__gpio),8);
	vcdp->chgBit(c+33,(vlTOPp->tb__DOT__top__DOT__j1_io_rd));
	vcdp->chgBit(c+34,(vlTOPp->tb__DOT__top__DOT__j1_io_wr));
	vcdp->chgBit(c+35,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstkW));
	vcdp->chgBit(c+36,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__reboot));
	vcdp->chgBus(c+37,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rspI),2);
	vcdp->chgBit(c+38,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__is_alu));
	vcdp->chgBit(c+39,((1U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rspI))));
    }
}

void Vtb::traceChgThis__6(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus(c+40,(((IData)(vlTOPp->tb__DOT__top__DOT__j1_io_rd)
			     ? (((((((((1U == (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0)) 
				       | (0x10U == (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0))) 
				      | (0x11U == (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0))) 
				     | (0x21U == (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0))) 
				    | (0x31U == (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0))) 
				   | (0x30U == (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0))) 
				  | (0x32U == (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0))) 
				 | (0x33U == (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0)))
				 ? ((1U == (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0))
				     ? (IData)(vlTOPp->tb__DOT__top__DOT__uart_tx_tbr_valid)
				     : ((0x10U == (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0))
					 ? (IData)(vlTOPp->tb__DOT__top__DOT__uart_rx_rdata)
					 : ((0x11U 
					     == (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0))
					     ? (IData)(vlTOPp->tb__DOT__top__DOT__uart_rx_d_valid)
					     : ((0x21U 
						 == (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0))
						 ? (IData)(vlTOPp->tb__DOT__top__DOT__uart_rx_overflow)
						 : 
						((0x31U 
						  == (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0))
						  ? (IData)(vlTOPp->tb__DOT__gpio)
						  : 
						 ((0x30U 
						   == (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0))
						   ? (IData)(vlTOPp->tb__DOT__top__DOT__gpio_out)
						   : 
						  ((0x32U 
						    == (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0))
						    ? (IData)(vlTOPp->tb__DOT__top__DOT__gpio_oe)
						    : (IData)(vlTOPp->tb__DOT__top__DOT__csr1__DOT__led))))))))
				 : 0xbadaU) : 0xdeadU)),16);
    }
}

void Vtb::traceChgThis__7(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Variables
    // Begin mtask footprint  all: 
    VL_SIGW(__Vtemp50,255,0,8);
    // Body
    {
	vcdp->chgBit(c+41,((1U & ((0x8000U & ((IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0) 
					      ^ (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__head)))
				   ? ((IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__head) 
				      >> 0xfU) : (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__minus 
						  >> 0x10U)))));
	vcdp->chgBus(c+42,((0xffffU & ((IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstkW)
				        ? (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0)
				        : vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[0U]))),16);
	__Vtemp50[0U] = ((2U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dspI))
			  ? ((vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[1U] 
			      << 0x10U) | (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[0U] 
					   >> 0x10U))
			  : ((0xffff0000U & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[0U] 
					     << 0x10U)) 
			     | (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__head)));
	__Vtemp50[1U] = ((2U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dspI))
			  ? ((vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[2U] 
			      << 0x10U) | (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[1U] 
					   >> 0x10U))
			  : ((0xffffU & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[0U] 
					 >> 0x10U)) 
			     | (0xffff0000U & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[1U] 
					       << 0x10U))));
	__Vtemp50[2U] = ((2U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dspI))
			  ? ((vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[3U] 
			      << 0x10U) | (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[2U] 
					   >> 0x10U))
			  : ((0xffffU & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[1U] 
					 >> 0x10U)) 
			     | (0xffff0000U & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[2U] 
					       << 0x10U))));
	__Vtemp50[3U] = ((2U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dspI))
			  ? ((vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[4U] 
			      << 0x10U) | (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[3U] 
					   >> 0x10U))
			  : ((0xffffU & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[2U] 
					 >> 0x10U)) 
			     | (0xffff0000U & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[3U] 
					       << 0x10U))));
	__Vtemp50[4U] = ((2U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dspI))
			  ? ((vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[5U] 
			      << 0x10U) | (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[4U] 
					   >> 0x10U))
			  : ((0xffffU & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[3U] 
					 >> 0x10U)) 
			     | (0xffff0000U & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[4U] 
					       << 0x10U))));
	__Vtemp50[5U] = ((2U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dspI))
			  ? ((vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[6U] 
			      << 0x10U) | (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[5U] 
					   >> 0x10U))
			  : ((0xffffU & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[4U] 
					 >> 0x10U)) 
			     | (0xffff0000U & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[5U] 
					       << 0x10U))));
	__Vtemp50[6U] = ((2U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dspI))
			  ? ((vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[7U] 
			      << 0x10U) | (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[6U] 
					   >> 0x10U))
			  : ((0xffffU & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[5U] 
					 >> 0x10U)) 
			     | (0xffff0000U & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[6U] 
					       << 0x10U))));
	__Vtemp50[7U] = ((2U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dspI))
			  ? 0x55aaU : (0xffffU & (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail[6U] 
						  >> 0x10U)));
	vcdp->chgArray(c+43,(__Vtemp50),240);
    }
}

void Vtb::traceChgThis__8(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus(c+51,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__pcN),13);
	vcdp->chgBus(c+52,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dspN),4);
	vcdp->chgBus(c+53,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0N),16);
	vcdp->chgBit(c+54,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstkW));
	vcdp->chgBus(c+55,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dspI),2);
	vcdp->chgBus(c+56,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__minus),17);
	vcdp->chgBit(c+57,((1U & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dspI))));
    }
}

void Vtb::traceChgThis__9(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit(c+58,(vlTOPp->tb__DOT__rst_n));
    }
}

void Vtb::traceChgThis__10(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus(c+59,(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_rdata_b),16);
	vcdp->chgBus(c+60,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__head),16);
	vcdp->chgBit(c+61,((1U == (7U & ((IData)(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_rdata_b) 
					 >> 4U)))));
	vcdp->chgBit(c+62,((2U == (7U & ((IData)(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_rdata_b) 
					 >> 4U)))));
	vcdp->chgBit(c+63,((3U == (7U & ((IData)(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_rdata_b) 
					 >> 4U)))));
	vcdp->chgBit(c+64,((4U == (7U & ((IData)(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_rdata_b) 
					 >> 4U)))));
	vcdp->chgBit(c+65,((5U == (7U & ((IData)(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_rdata_b) 
					 >> 4U)))));
	vcdp->chgArray(c+66,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail),272);
	vcdp->chgBus(c+75,(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_addr_a),13);
	vcdp->chgBus(c+76,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__load_value),8);
	vcdp->chgBus(c+77,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__Counter_Val),8);
    }
}

void Vtb::traceChgThis__11(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit(c+78,((1U & (((IData)(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				   >> 1U) | (IData)(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__Out_Reg__DOT__TSR)))));
	vcdp->chgBit(c+79,((1U & (IData)(vlTOPp->tb__DOT__top__DOT__gpio_out))));
	vcdp->chgBit(c+80,(vlTOPp->tb__DOT__top__DOT__uart_rx_clr_ovrflw));
	vcdp->chgBus(c+81,(vlTOPp->tb__DOT__top__DOT__uart_rx_rdata),8);
	vcdp->chgBit(c+82,((1U & ((IData)(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__Out) 
				  >> 6U))));
	vcdp->chgBit(c+83,(vlTOPp->tb__DOT__top__DOT__uart_rx_d_valid));
	vcdp->chgBit(c+84,(vlTOPp->tb__DOT__top__DOT__uart_rx_overflow));
	vcdp->chgBit(c+85,(vlTOPp->tb__DOT__top__DOT__uart_tx_tbr_valid));
	vcdp->chgBus(c+86,(vlTOPp->tb__DOT__top__DOT__gpio_out),8);
	vcdp->chgBus(c+87,(vlTOPp->tb__DOT__top__DOT__gpio_oe),8);
	vcdp->chgQuad(c+88,(vlTOPp->tb__DOT__top__DOT__count),33);
	vcdp->chgBus(c+90,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dsp),4);
	vcdp->chgBit(c+91,(vlTOPp->tb__DOT__top__DOT__csr1__DOT__led));
	vcdp->chgBit(c+92,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__f_edge));
	vcdp->chgBit(c+93,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__Rx_in));
	vcdp->chgBit(c+94,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__CO));
	vcdp->chgBit(c+95,((1U & ((IData)(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__Out) 
				  >> 7U))));
	vcdp->chgBit(c+96,((1U & ((IData)(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__Out) 
				  >> 4U))));
	vcdp->chgBus(c+97,((0xfU & (IData)(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__Out))),4);
	vcdp->chgBit(c+98,((1U & ((IData)(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__Out) 
				  >> 5U))));
	vcdp->chgBit(c+99,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__Rx_register__DOT__Rx_intermediate));
	vcdp->chgBus(c+100,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__state_reg),4);
	vcdp->chgBus(c+101,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__Out),8);
	vcdp->chgBus(c+102,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__Counter__DOT__count),8);
	vcdp->chgBus(c+103,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__Shft_reg__DOT__buffer_reg),8);
	vcdp->chgBit(c+104,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__CO));
	vcdp->chgBit(c+105,((1U & ((IData)(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				   >> 4U))));
	vcdp->chgBit(c+106,((1U & ((IData)(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				   >> 3U))));
	vcdp->chgBit(c+107,((1U & ((IData)(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				   >> 1U))));
	vcdp->chgBit(c+108,((1U & ((IData)(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				   >> 2U))));
	vcdp->chgBit(c+109,((1U & (IData)(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__out))));
	vcdp->chgBus(c+110,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__ROMaddr),4);
	vcdp->chgBus(c+111,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__state),4);
	vcdp->chgBus(c+112,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__out),5);
	vcdp->chgBus(c+113,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__Out_Reg__DOT__TBR),8);
	vcdp->chgBus(c+114,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__Out_Reg__DOT__TSR),10);
	vcdp->chgBus(c+115,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__Cntr__DOT__count),8);
    }
}

void Vtb::traceChgThis__12(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus(c+116,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__head),16);
	vcdp->chgBus(c+117,((0xffU & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__head))),8);
	vcdp->chgArray(c+118,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__tail),240);
    }
}

void Vtb::traceChgThis__13(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus(c+126,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0),16);
	vcdp->chgBus(c+127,((0x1fffU & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0))),13);
    }
}

void Vtb::traceChgThis__14(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit(c+128,(vlTOPp->tb__DOT__top__DOT__rst));
	vcdp->chgBit(c+129,(vlTOPp->tb__DOT__top__DOT__rst_n_1));
	vcdp->chgBit(c+130,(vlTOPp->tb__DOT__top__DOT__rst_n_2));
	vcdp->chgBus(c+131,(vlTOPp->tb__DOT__top__DOT__rst_count),6);
	vcdp->chgBit(c+132,((1U & (~ (IData)(vlTOPp->tb__DOT__top__DOT__rst)))));
    }
}

void Vtb::traceChgThis__15(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit(c+133,(vlTOPp->verilator_clk));
	vcdp->chgBit(c+134,(vlTOPp->verilator_rst));
	vcdp->chgBus(c+135,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__pc),13);
	vcdp->chgBus(c+136,((0x1fffU & ((IData)(1U) 
					+ (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__pc)))),13);
	vcdp->chgBus(c+137,(((0x2000U & (IData)(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_rdata_b))
			      ? (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0)
			      : (0x3ffeU & (((IData)(1U) 
					     + (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__pc)) 
					    << 1U)))),16);
	vcdp->chgBus(c+138,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__depth),32);
	vcdp->chgBus(c+139,((0xffffU & ((IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstkW)
					 ? ((0x2000U 
					     & (IData)(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_rdata_b))
					     ? (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0)
					     : (0x3ffeU 
						& (((IData)(1U) 
						    + (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__pc)) 
						   << 1U)))
					 : vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__tail[0U]))),16);
	vcdp->chgBus(c+140,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__depth),32);
    }
}
