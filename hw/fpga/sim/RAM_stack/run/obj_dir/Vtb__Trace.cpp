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
	if (VL_UNLIKELY((1U & ((vlTOPp->__Vm_traceActivity 
				| (vlTOPp->__Vm_traceActivity 
				   >> 1U)) | (vlTOPp->__Vm_traceActivity 
					      >> 3U))))) {
	    vlTOPp->traceChgThis__5(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((1U & (vlTOPp->__Vm_traceActivity 
			       | (vlTOPp->__Vm_traceActivity 
				  >> 2U))))) {
	    vlTOPp->traceChgThis__6(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((1U & (((vlTOPp->__Vm_traceActivity 
				 | (vlTOPp->__Vm_traceActivity 
				    >> 2U)) | (vlTOPp->__Vm_traceActivity 
					       >> 4U)) 
			       | (vlTOPp->__Vm_traceActivity 
				  >> 6U))))) {
	    vlTOPp->traceChgThis__7(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((1U & (vlTOPp->__Vm_traceActivity 
			       | (vlTOPp->__Vm_traceActivity 
				  >> 3U))))) {
	    vlTOPp->traceChgThis__8(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((1U & (vlTOPp->__Vm_traceActivity 
			       | (vlTOPp->__Vm_traceActivity 
				  >> 4U))))) {
	    vlTOPp->traceChgThis__9(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((1U & (vlTOPp->__Vm_traceActivity 
			       | (vlTOPp->__Vm_traceActivity 
				  >> 6U))))) {
	    vlTOPp->traceChgThis__10(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((2U & vlTOPp->__Vm_traceActivity))) {
	    vlTOPp->traceChgThis__11(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((4U & vlTOPp->__Vm_traceActivity))) {
	    vlTOPp->traceChgThis__12(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((0x20U & vlTOPp->__Vm_traceActivity))) {
	    vlTOPp->traceChgThis__13(vlSymsp, vcdp, code);
	}
	vlTOPp->traceChgThis__14(vlSymsp, vcdp, code);
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
	vcdp->chgBus(c+21,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rst0),16);
	vcdp->chgBus(c+22,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__wr_addr),4);
	vcdp->chgBus(c+23,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__wr_addr),5);
	vcdp->chgBus(c+24,(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_array
			   [vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_addr_a]),16);
    }
}

void Vtb::traceChgThis__4(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit(c+25,((((~ (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__reboot)) 
			     & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__is_alu)) 
			    & (3U == (7U & ((IData)(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_rdata_b) 
					    >> 4U))))));
    }
}

void Vtb::traceChgThis__5(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus(c+26,(((1U & (((IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dspI) 
				    >> 1U) & (~ ((IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__delta_br) 
						 >> 1U))))
			     ? 0xfU : 0U)),4);
	vcdp->chgBus(c+27,(((1U & (((IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rspI) 
				    >> 1U) & (~ ((IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__delta_br) 
						 >> 1U))))
			     ? 0x1fU : 0U)),5);
    }
}

void Vtb::traceChgThis__6(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus(c+28,(vlTOPp->tb__DOT__gpio),8);
	vcdp->chgBit(c+29,(vlTOPp->tb__DOT__top__DOT__j1_io_rd));
	vcdp->chgBit(c+30,(vlTOPp->tb__DOT__top__DOT__j1_io_wr));
	vcdp->chgBus(c+31,(((IData)(vlTOPp->tb__DOT__top__DOT__j1_io_rd)
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
	vcdp->chgBus(c+32,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__pcN),13);
	vcdp->chgBit(c+33,(vlTOPp->tb__DOT__top__DOT__uart_rx_rd));
	vcdp->chgBit(c+34,(vlTOPp->tb__DOT__top__DOT__uart_tx_wr));
	vcdp->chgBus(c+35,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstkD),16);
	vcdp->chgBit(c+36,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__reboot));
	vcdp->chgBit(c+37,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__is_alu));
    }
}

void Vtb::traceChgThis__7(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit(c+38,((1U & ((0x8000U & ((IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0) 
					      ^ (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st1)))
				   ? ((IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st1) 
				      >> 0xfU) : (vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__minus 
						  >> 0x10U)))));
    }
}

void Vtb::traceChgThis__8(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit(c+39,(vlTOPp->tb__DOT__rst_n));
	vcdp->chgBus(c+40,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dspN),4);
	vcdp->chgBit(c+41,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstkW));
	vcdp->chgBit(c+42,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstkW));
	vcdp->chgBus(c+43,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dspI),2);
	vcdp->chgBus(c+44,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rspI),2);
	vcdp->chgBus(c+45,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__rd_addr),4);
	vcdp->chgBus(c+46,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__rd_addr),5);
    }
}

void Vtb::traceChgThis__9(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus(c+47,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st1),16);
	vcdp->chgBus(c+48,((0xffU & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st1))),8);
    }
}

void Vtb::traceChgThis__10(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus(c+49,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0N),16);
	vcdp->chgBus(c+50,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__minus),17);
    }
}

void Vtb::traceChgThis__11(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus(c+51,(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_rdata_b),16);
	vcdp->chgBit(c+52,((1U == (7U & ((IData)(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_rdata_b) 
					 >> 4U)))));
	vcdp->chgBit(c+53,((2U == (7U & ((IData)(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_rdata_b) 
					 >> 4U)))));
	vcdp->chgBit(c+54,((3U == (7U & ((IData)(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_rdata_b) 
					 >> 4U)))));
	vcdp->chgBit(c+55,((4U == (7U & ((IData)(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_rdata_b) 
					 >> 4U)))));
	vcdp->chgBit(c+56,((5U == (7U & ((IData)(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_rdata_b) 
					 >> 4U)))));
	vcdp->chgBus(c+57,(((0xeU >= (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_addr_a))
			     ? vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_array
			    [vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_addr_a]
			     : 0U)),16);
	vcdp->chgBit(c+58,((((0U != (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__stack_rd_addr_reg)) 
			     | (~ ((IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__delta_br) 
				   >> 1U))) & (0U != (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__stack_wr_addr_reg)))));
	vcdp->chgBit(c+59,((1U & ((0U != (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__stack_wr_addr_reg)) 
				  | (~ ((IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__delta_br) 
					>> 1U))))));
	vcdp->chgBit(c+60,((1U == (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__delta_br))));
	vcdp->chgBus(c+61,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_rdata_b),16);
	vcdp->chgBus(c+62,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__delta_br),2);
	vcdp->chgBus(c+63,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__stack_wr_addr_reg),4);
	vcdp->chgBus(c+64,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__stack_rd_addr_reg),4);
	vcdp->chgBus(c+65,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__lst_wd),16);
	vcdp->chgBit(c+66,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__dble_push_buf));
	vcdp->chgBus(c+67,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_array[0]),16);
	vcdp->chgBus(c+68,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_array[1]),16);
	vcdp->chgBus(c+69,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_array[2]),16);
	vcdp->chgBus(c+70,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_array[3]),16);
	vcdp->chgBus(c+71,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_array[4]),16);
	vcdp->chgBus(c+72,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_array[5]),16);
	vcdp->chgBus(c+73,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_array[6]),16);
	vcdp->chgBus(c+74,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_array[7]),16);
	vcdp->chgBus(c+75,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_array[8]),16);
	vcdp->chgBus(c+76,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_array[9]),16);
	vcdp->chgBus(c+77,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_array[10]),16);
	vcdp->chgBus(c+78,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_array[11]),16);
	vcdp->chgBus(c+79,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_array[12]),16);
	vcdp->chgBus(c+80,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_array[13]),16);
	vcdp->chgBus(c+81,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_array[14]),16);
	vcdp->chgBus(c+82,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dstack__DOT__StackRAM__DOT__ram_addr_a),4);
	vcdp->chgBus(c+83,(((0x10U >= (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_addr_a))
			     ? vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array
			    [vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_addr_a]
			     : 0U)),16);
	vcdp->chgBit(c+84,((((0U != (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__stack_rd_addr_reg)) 
			     | (~ ((IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__delta_br) 
				   >> 1U))) & (0U != (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__stack_wr_addr_reg)))));
	vcdp->chgBit(c+85,((1U & ((0U != (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__stack_wr_addr_reg)) 
				  | (~ ((IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__delta_br) 
					>> 1U))))));
	vcdp->chgBit(c+86,((1U == (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__delta_br))));
	vcdp->chgBus(c+87,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_rdata_b),16);
	vcdp->chgBus(c+88,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__delta_br),2);
	vcdp->chgBus(c+89,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__stack_wr_addr_reg),5);
	vcdp->chgBus(c+90,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__stack_rd_addr_reg),5);
	vcdp->chgBus(c+91,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__lst_wd),16);
	vcdp->chgBit(c+92,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__dble_push_buf));
	vcdp->chgBus(c+93,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[0]),16);
	vcdp->chgBus(c+94,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[1]),16);
	vcdp->chgBus(c+95,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[2]),16);
	vcdp->chgBus(c+96,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[3]),16);
	vcdp->chgBus(c+97,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[4]),16);
	vcdp->chgBus(c+98,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[5]),16);
	vcdp->chgBus(c+99,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[6]),16);
	vcdp->chgBus(c+100,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[7]),16);
	vcdp->chgBus(c+101,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[8]),16);
	vcdp->chgBus(c+102,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[9]),16);
	vcdp->chgBus(c+103,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[10]),16);
	vcdp->chgBus(c+104,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[11]),16);
	vcdp->chgBus(c+105,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[12]),16);
	vcdp->chgBus(c+106,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[13]),16);
	vcdp->chgBus(c+107,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[14]),16);
	vcdp->chgBus(c+108,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[15]),16);
	vcdp->chgBus(c+109,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_array[16]),16);
	vcdp->chgBus(c+110,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__rstack__DOT__StackRAM__DOT__ram_addr_a),5);
	vcdp->chgBus(c+111,(vlTOPp->tb__DOT__top__DOT__sram__DOT__ram_addr_a),13);
	vcdp->chgBus(c+112,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__load_value),8);
	vcdp->chgBus(c+113,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__Counter_Val),8);
    }
}

void Vtb::traceChgThis__12(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit(c+114,((1U & (((IData)(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				    >> 1U) | (IData)(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__Out_Reg__DOT__TSR)))));
	vcdp->chgBit(c+115,((1U & (IData)(vlTOPp->tb__DOT__top__DOT__gpio_out))));
	vcdp->chgBus(c+116,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0),16);
	vcdp->chgBit(c+117,(vlTOPp->tb__DOT__top__DOT__uart_rx_clr_ovrflw));
	vcdp->chgBus(c+118,(vlTOPp->tb__DOT__top__DOT__uart_rx_rdata),8);
	vcdp->chgBit(c+119,((1U & ((IData)(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__Out) 
				   >> 6U))));
	vcdp->chgBit(c+120,(vlTOPp->tb__DOT__top__DOT__uart_rx_d_valid));
	vcdp->chgBit(c+121,(vlTOPp->tb__DOT__top__DOT__uart_rx_overflow));
	vcdp->chgBit(c+122,(vlTOPp->tb__DOT__top__DOT__uart_tx_tbr_valid));
	vcdp->chgBus(c+123,(vlTOPp->tb__DOT__top__DOT__gpio_out),8);
	vcdp->chgBus(c+124,(vlTOPp->tb__DOT__top__DOT__gpio_oe),8);
	vcdp->chgQuad(c+125,(vlTOPp->tb__DOT__top__DOT__count),33);
	vcdp->chgBus(c+127,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__dsp),4);
	vcdp->chgBus(c+128,((0x1fffU & (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__st0))),13);
	vcdp->chgBit(c+129,(vlTOPp->tb__DOT__top__DOT__csr1__DOT__led));
	vcdp->chgBit(c+130,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__f_edge));
	vcdp->chgBit(c+131,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__Rx_in));
	vcdp->chgBit(c+132,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__CO));
	vcdp->chgBit(c+133,((1U & ((IData)(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__Out) 
				   >> 7U))));
	vcdp->chgBit(c+134,((1U & ((IData)(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__Out) 
				   >> 4U))));
	vcdp->chgBus(c+135,((0xfU & (IData)(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__Out))),4);
	vcdp->chgBit(c+136,((1U & ((IData)(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__Out) 
				   >> 5U))));
	vcdp->chgBit(c+137,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__Rx_register__DOT__Rx_intermediate));
	vcdp->chgBus(c+138,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__state_reg),4);
	vcdp->chgBus(c+139,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__FSM__DOT__Out),8);
	vcdp->chgBus(c+140,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__Counter__DOT__count),8);
	vcdp->chgBus(c+141,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__Shft_reg__DOT__shft_reg),8);
	vcdp->chgBus(c+142,(vlTOPp->tb__DOT__top__DOT__uart_rcvr_top__DOT__Shft_reg__DOT__buffer_reg),8);
	vcdp->chgBit(c+143,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__CO));
	vcdp->chgBit(c+144,((1U & ((IData)(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				   >> 4U))));
	vcdp->chgBit(c+145,((1U & ((IData)(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				   >> 3U))));
	vcdp->chgBit(c+146,((1U & ((IData)(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				   >> 1U))));
	vcdp->chgBit(c+147,((1U & ((IData)(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				   >> 2U))));
	vcdp->chgBit(c+148,((1U & (IData)(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__out))));
	vcdp->chgBus(c+149,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__ROMaddr),4);
	vcdp->chgBus(c+150,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__state),4);
	vcdp->chgBus(c+151,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__FSM1__DOT__out),5);
	vcdp->chgBus(c+152,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__Out_Reg__DOT__TBR),8);
	vcdp->chgBus(c+153,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__Out_Reg__DOT__TSR),10);
	vcdp->chgBus(c+154,(vlTOPp->tb__DOT__top__DOT__uart_tr_top__DOT__Cntr__DOT__count),8);
    }
}

void Vtb::traceChgThis__13(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit(c+155,(vlTOPp->tb__DOT__top__DOT__rst));
	vcdp->chgBit(c+156,(vlTOPp->tb__DOT__top__DOT__rst_n_1));
	vcdp->chgBit(c+157,(vlTOPp->tb__DOT__top__DOT__rst_n_2));
	vcdp->chgBus(c+158,(vlTOPp->tb__DOT__top__DOT__rst_count),6);
	vcdp->chgBit(c+159,((1U & (~ (IData)(vlTOPp->tb__DOT__top__DOT__rst)))));
    }
}

void Vtb::traceChgThis__14(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit(c+160,(vlTOPp->verilator_clk));
	vcdp->chgBit(c+161,(vlTOPp->verilator_rst));
	vcdp->chgBus(c+162,(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__pc),13);
	vcdp->chgBus(c+163,((0x1fffU & ((IData)(1U) 
					+ (IData)(vlTOPp->tb__DOT__top__DOT__j1_prb__DOT__pc)))),13);
    }
}
