// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtb__Syms.h"


//======================

void Vtb::trace(VerilatedVcdC* tfp, int, int) {
    tfp->spTrace()->addCallback(&Vtb::traceInit, &Vtb::traceFull, &Vtb::traceChg, this);
}
void Vtb::traceInit(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->open()
    Vtb* t=(Vtb*)userthis;
    Vtb__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (!Verilated::calcUnusedSigs()) {
	VL_FATAL_MT(__FILE__,__LINE__,__FILE__,"Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vcdp->scopeEscape(' ');
    t->traceInitThis(vlSymsp, vcdp, code);
    vcdp->scopeEscape('.');
}
void Vtb::traceFull(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    Vtb* t=(Vtb*)userthis;
    Vtb__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    t->traceFullThis(vlSymsp, vcdp, code);
}

//======================


void Vtb::traceInitThis(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    vcdp->module(vlSymsp->name());  // Setup signal names
    // Body
    {
	vlTOPp->traceInitThis__1(vlSymsp, vcdp, code);
    }
}

void Vtb::traceFullThis(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vlTOPp->traceFullThis__1(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void Vtb::traceInitThis__1(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->declBit(c+53,"verilator_clk",-1);
	vcdp->declBit(c+54,"verilator_rst",-1);
	vcdp->declBit(c+53,"tb verilator_clk",-1);
	vcdp->declBit(c+54,"tb verilator_rst",-1);
	vcdp->declBus(c+55,"tb SIM_DELAY",-1,31,0);
	vcdp->declBus(c+56,"tb SOME_PARAM",-1,3,0);
	vcdp->declBus(c+57,"tb i",-1,31,0);
	vcdp->declBus(c+58,"tb j",-1,31,0);
	vcdp->declBus(c+59,"tb k",-1,31,0);
	vcdp->declBit(c+60,"tb clk_16",-1);
	vcdp->declBit(c+53,"tb clk",-1);
	vcdp->declBit(c+54,"tb rst",-1);
	vcdp->declBit(c+61,"tb uart_rxd",-1);
	vcdp->declBit(c+62,"tb uart_rx_rd",-1);
	vcdp->declBit(c+63,"tb uart_rx_clr_ovrflw",-1);
	vcdp->declBus(c+21,"tb uart_rx_rdata",-1,7,0);
	vcdp->declBit(c+31,"tb uart_rx_sfe",-1);
	vcdp->declBit(c+22,"tb uart_rx_d_valid",-1);
	vcdp->declBit(c+23,"tb uart_rx_overflow",-1);
	vcdp->declBit(c+28,"tb uart_txd",-1);
	vcdp->declBus(c+64,"tb uart_tx_wdata",-1,7,0);
	vcdp->declBit(c+65,"tb uart_tx_wr",-1);
	vcdp->declBit(c+32,"tb uart_tx_tbr_valid",-1);
	vcdp->declBit(c+53,"tb uart_rcvr_top CLOCK",-1);
	vcdp->declBit(c+54,"tb uart_rcvr_top reset",-1);
	vcdp->declBit(c+61,"tb uart_rcvr_top Rx_raw",-1);
	vcdp->declBit(c+62,"tb uart_rcvr_top Rd_en",-1);
	vcdp->declBit(c+63,"tb uart_rcvr_top clr_ovrflw",-1);
	vcdp->declBit(c+22,"tb uart_rcvr_top d_valid",-1);
	vcdp->declBit(c+23,"tb uart_rcvr_top overflow",-1);
	vcdp->declBus(c+21,"tb uart_rcvr_top rx_data_out",-1,7,0);
	vcdp->declBit(c+31,"tb uart_rcvr_top SFE",-1);
	vcdp->declBit(c+33,"tb uart_rcvr_top f_edge",-1);
	vcdp->declBit(c+34,"tb uart_rcvr_top Rx_in",-1);
	vcdp->declBit(c+35,"tb uart_rcvr_top CO",-1);
	vcdp->declBit(c+36,"tb uart_rcvr_top load_buffer",-1);
	vcdp->declBit(c+37,"tb uart_rcvr_top load_counter",-1);
	vcdp->declBus(c+38,"tb uart_rcvr_top ROM_addr",-1,3,0);
	vcdp->declBit(c+39,"tb uart_rcvr_top shift",-1);
	vcdp->declBus(c+29,"tb uart_rcvr_top load_value",-1,7,0);
	vcdp->declBit(c+53,"tb uart_rcvr_top Rx_register CLOCK",-1);
	vcdp->declBit(c+61,"tb uart_rcvr_top Rx_register Rx_raw",-1);
	vcdp->declBit(c+54,"tb uart_rcvr_top Rx_register reset",-1);
	vcdp->declBit(c+33,"tb uart_rcvr_top Rx_register f_edge",-1);
	vcdp->declBit(c+34,"tb uart_rcvr_top Rx_register Rx_out",-1);
	vcdp->declBit(c+40,"tb uart_rcvr_top Rx_register Rx_intermediate",-1);
	vcdp->declBit(c+53,"tb uart_rcvr_top FSM CLOCK",-1);
	vcdp->declBit(c+34,"tb uart_rcvr_top FSM Rx",-1);
	vcdp->declBit(c+35,"tb uart_rcvr_top FSM CO",-1);
	vcdp->declBit(c+33,"tb uart_rcvr_top FSM f_edge",-1);
	vcdp->declBit(c+54,"tb uart_rcvr_top FSM reset",-1);
	vcdp->declBit(c+37,"tb uart_rcvr_top FSM load_counter",-1);
	vcdp->declBit(c+36,"tb uart_rcvr_top FSM load_buffer",-1);
	vcdp->declBus(c+38,"tb uart_rcvr_top FSM ROM_addr",-1,3,0);
	vcdp->declBit(c+39,"tb uart_rcvr_top FSM shift",-1);
	vcdp->declBit(c+31,"tb uart_rcvr_top FSM SFE",-1);
	vcdp->declBus(c+41,"tb uart_rcvr_top FSM state_reg",-1,3,0);
	vcdp->declBus(c+42,"tb uart_rcvr_top FSM Out",-1,7,0);
	vcdp->declBus(c+66,"tb uart_rcvr_top FSM RST",-1,3,0);
	vcdp->declBus(c+67,"tb uart_rcvr_top FSM IDLE",-1,3,0);
	vcdp->declBus(c+68,"tb uart_rcvr_top FSM START",-1,3,0);
	vcdp->declBus(c+69,"tb uart_rcvr_top FSM D0",-1,3,0);
	vcdp->declBus(c+70,"tb uart_rcvr_top FSM D1",-1,3,0);
	vcdp->declBus(c+71,"tb uart_rcvr_top FSM D2",-1,3,0);
	vcdp->declBus(c+72,"tb uart_rcvr_top FSM D3",-1,3,0);
	vcdp->declBus(c+73,"tb uart_rcvr_top FSM D4",-1,3,0);
	vcdp->declBus(c+74,"tb uart_rcvr_top FSM D5",-1,3,0);
	vcdp->declBus(c+75,"tb uart_rcvr_top FSM D6",-1,3,0);
	vcdp->declBus(c+76,"tb uart_rcvr_top FSM D7",-1,3,0);
	vcdp->declBus(c+56,"tb uart_rcvr_top FSM STOP",-1,3,0);
	vcdp->declBit(c+37,"tb uart_rcvr_top Counter load",-1);
	vcdp->declBus(c+29,"tb uart_rcvr_top Counter load_value",-1,7,0);
	vcdp->declBit(c+54,"tb uart_rcvr_top Counter reset",-1);
	vcdp->declBit(c+53,"tb uart_rcvr_top Counter CLOCK",-1);
	vcdp->declBit(c+35,"tb uart_rcvr_top Counter CO",-1);
	vcdp->declBus(c+24,"tb uart_rcvr_top Counter count",-1,7,0);
	vcdp->declBit(c+53,"tb uart_rcvr_top ROM CLOCK",-1);
	vcdp->declBus(c+38,"tb uart_rcvr_top ROM addr",-1,3,0);
	vcdp->declBus(c+29,"tb uart_rcvr_top ROM data_out",-1,7,0);
	{int i; for (i=0; i<10; i++) {
		vcdp->declBus(c+1+i*1,"tb uart_rcvr_top ROM mem",(i+0),7,0);}}
	vcdp->declBit(c+54,"tb uart_rcvr_top Shft_reg reset",-1);
	vcdp->declBit(c+34,"tb uart_rcvr_top Shft_reg Rx",-1);
	vcdp->declBit(c+36,"tb uart_rcvr_top Shft_reg load_buffer",-1);
	vcdp->declBit(c+39,"tb uart_rcvr_top Shft_reg shift",-1);
	vcdp->declBit(c+62,"tb uart_rcvr_top Shft_reg Rd_en",-1);
	vcdp->declBit(c+63,"tb uart_rcvr_top Shft_reg clr_ovrflw",-1);
	vcdp->declBit(c+53,"tb uart_rcvr_top Shft_reg CLOCK",-1);
	vcdp->declBus(c+21,"tb uart_rcvr_top Shft_reg rx_data_out",-1,7,0);
	vcdp->declBit(c+22,"tb uart_rcvr_top Shft_reg d_valid",-1);
	vcdp->declBit(c+23,"tb uart_rcvr_top Shft_reg overflow",-1);
	vcdp->declBus(c+25,"tb uart_rcvr_top Shft_reg buffer_reg",-1,7,0);
	vcdp->declBit(c+53,"tb uart_tr_top clk",-1);
	vcdp->declBit(c+54,"tb uart_tr_top reset",-1);
	vcdp->declBus(c+64,"tb uart_tr_top Data_in",-1,7,0);
	vcdp->declBit(c+65,"tb uart_tr_top TBR_en",-1);
	vcdp->declBit(c+32,"tb uart_tr_top TBR_Valid",-1);
	vcdp->declBit(c+28,"tb uart_tr_top Tx",-1);
	vcdp->declBit(c+43,"tb uart_tr_top CO",-1);
	vcdp->declBit(c+44,"tb uart_tr_top Clear_Valid",-1);
	vcdp->declBit(c+45,"tb uart_tr_top Shift",-1);
	vcdp->declBit(c+46,"tb uart_tr_top SetSR",-1);
	vcdp->declBit(c+47,"tb uart_tr_top LoadSR",-1);
	vcdp->declBit(c+48,"tb uart_tr_top LC",-1);
	vcdp->declBus(c+30,"tb uart_tr_top Counter_Val",-1,7,0);
	vcdp->declBus(c+49,"tb uart_tr_top ROMaddr",-1,3,0);
	vcdp->declBit(c+53,"tb uart_tr_top FSM1 clk",-1);
	vcdp->declBit(c+54,"tb uart_tr_top FSM1 reset",-1);
	vcdp->declBit(c+32,"tb uart_tr_top FSM1 TBR_Valid",-1);
	vcdp->declBit(c+43,"tb uart_tr_top FSM1 CO",-1);
	vcdp->declBit(c+44,"tb uart_tr_top FSM1 Clear_Valid",-1);
	vcdp->declBit(c+45,"tb uart_tr_top FSM1 Shift",-1);
	vcdp->declBit(c+47,"tb uart_tr_top FSM1 LoadSR",-1);
	vcdp->declBit(c+46,"tb uart_tr_top FSM1 SetSR",-1);
	vcdp->declBit(c+48,"tb uart_tr_top FSM1 LoadCounter",-1);
	vcdp->declBus(c+49,"tb uart_tr_top FSM1 ROMaddr",-1,3,0);
	vcdp->declBus(c+66,"tb uart_tr_top FSM1 RST",-1,3,0);
	vcdp->declBus(c+67,"tb uart_tr_top FSM1 IDLE",-1,3,0);
	vcdp->declBus(c+68,"tb uart_tr_top FSM1 START",-1,3,0);
	vcdp->declBus(c+69,"tb uart_tr_top FSM1 D0",-1,3,0);
	vcdp->declBus(c+70,"tb uart_tr_top FSM1 D1",-1,3,0);
	vcdp->declBus(c+71,"tb uart_tr_top FSM1 D2",-1,3,0);
	vcdp->declBus(c+72,"tb uart_tr_top FSM1 D3",-1,3,0);
	vcdp->declBus(c+73,"tb uart_tr_top FSM1 D4",-1,3,0);
	vcdp->declBus(c+74,"tb uart_tr_top FSM1 D5",-1,3,0);
	vcdp->declBus(c+75,"tb uart_tr_top FSM1 D6",-1,3,0);
	vcdp->declBus(c+76,"tb uart_tr_top FSM1 D7",-1,3,0);
	vcdp->declBus(c+56,"tb uart_tr_top FSM1 STOP",-1,3,0);
	vcdp->declBus(c+50,"tb uart_tr_top FSM1 state",-1,3,0);
	vcdp->declBus(c+51,"tb uart_tr_top FSM1 out",-1,4,0);
	vcdp->declBit(c+53,"tb uart_tr_top Out_Reg clk",-1);
	vcdp->declBit(c+54,"tb uart_tr_top Out_Reg reset",-1);
	vcdp->declBus(c+64,"tb uart_tr_top Out_Reg Data_in",-1,7,0);
	vcdp->declBit(c+65,"tb uart_tr_top Out_Reg TBR_en",-1);
	vcdp->declBit(c+44,"tb uart_tr_top Out_Reg Clear_Valid",-1);
	vcdp->declBit(c+45,"tb uart_tr_top Out_Reg Shift",-1);
	vcdp->declBit(c+46,"tb uart_tr_top Out_Reg Set",-1);
	vcdp->declBit(c+47,"tb uart_tr_top Out_Reg Load",-1);
	vcdp->declBit(c+32,"tb uart_tr_top Out_Reg TBR_Valid",-1);
	vcdp->declBit(c+28,"tb uart_tr_top Out_Reg Tx",-1);
	vcdp->declBus(c+26,"tb uart_tr_top Out_Reg TBR",-1,7,0);
	vcdp->declBus(c+27,"tb uart_tr_top Out_Reg TSR",-1,9,0);
	vcdp->declBit(c+53,"tb uart_tr_top ROM CLOCK",-1);
	vcdp->declBus(c+49,"tb uart_tr_top ROM addr",-1,3,0);
	vcdp->declBus(c+30,"tb uart_tr_top ROM data_out",-1,7,0);
	{int i; for (i=0; i<10; i++) {
		vcdp->declBus(c+11+i*1,"tb uart_tr_top ROM mem",(i+0),7,0);}}
	vcdp->declBit(c+48,"tb uart_tr_top Cntr load",-1);
	vcdp->declBus(c+30,"tb uart_tr_top Cntr load_value",-1,7,0);
	vcdp->declBit(c+54,"tb uart_tr_top Cntr reset",-1);
	vcdp->declBit(c+53,"tb uart_tr_top Cntr CLOCK",-1);
	vcdp->declBit(c+43,"tb uart_tr_top Cntr CO",-1);
	vcdp->declBus(c+52,"tb uart_tr_top Cntr count",-1,7,0);
    }
}

void Vtb::traceFullThis__1(Vtb__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vtb* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->fullBus(c+1,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[0]),8);
	vcdp->fullBus(c+2,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[1]),8);
	vcdp->fullBus(c+3,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[2]),8);
	vcdp->fullBus(c+4,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[3]),8);
	vcdp->fullBus(c+5,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[4]),8);
	vcdp->fullBus(c+6,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[5]),8);
	vcdp->fullBus(c+7,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[6]),8);
	vcdp->fullBus(c+8,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[7]),8);
	vcdp->fullBus(c+9,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[8]),8);
	vcdp->fullBus(c+10,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__ROM__DOT__mem[9]),8);
	vcdp->fullBus(c+11,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[0]),8);
	vcdp->fullBus(c+12,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[1]),8);
	vcdp->fullBus(c+13,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[2]),8);
	vcdp->fullBus(c+14,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[3]),8);
	vcdp->fullBus(c+15,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[4]),8);
	vcdp->fullBus(c+16,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[5]),8);
	vcdp->fullBus(c+17,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[6]),8);
	vcdp->fullBus(c+18,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[7]),8);
	vcdp->fullBus(c+19,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[8]),8);
	vcdp->fullBus(c+20,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROM__DOT__mem[9]),8);
	vcdp->fullBus(c+21,(vlTOPp->tb__DOT__uart_rx_rdata),8);
	vcdp->fullBit(c+22,(vlTOPp->tb__DOT__uart_rx_d_valid));
	vcdp->fullBit(c+23,(vlTOPp->tb__DOT__uart_rx_overflow));
	vcdp->fullBus(c+24,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__Counter__DOT__count),8);
	vcdp->fullBus(c+25,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__Shft_reg__DOT__buffer_reg),8);
	vcdp->fullBus(c+26,(vlTOPp->tb__DOT__uart_tr_top__DOT__Out_Reg__DOT__TBR),8);
	vcdp->fullBus(c+27,(vlTOPp->tb__DOT__uart_tr_top__DOT__Out_Reg__DOT__TSR),10);
	vcdp->fullBit(c+28,((1U & (((IData)(vlTOPp->tb__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				    >> 1U) | (IData)(vlTOPp->tb__DOT__uart_tr_top__DOT__Out_Reg__DOT__TSR)))));
	vcdp->fullBus(c+29,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__load_value),8);
	vcdp->fullBus(c+30,(vlTOPp->tb__DOT__uart_tr_top__DOT__Counter_Val),8);
	vcdp->fullBit(c+31,((1U & ((IData)(vlTOPp->tb__DOT__uart_rcvr_top__DOT__FSM__DOT__Out) 
				   >> 6U))));
	vcdp->fullBit(c+32,(vlTOPp->tb__DOT__uart_tx_tbr_valid));
	vcdp->fullBit(c+33,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__f_edge));
	vcdp->fullBit(c+34,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__Rx_in));
	vcdp->fullBit(c+35,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__CO));
	vcdp->fullBit(c+36,((1U & ((IData)(vlTOPp->tb__DOT__uart_rcvr_top__DOT__FSM__DOT__Out) 
				   >> 7U))));
	vcdp->fullBit(c+37,((1U & ((IData)(vlTOPp->tb__DOT__uart_rcvr_top__DOT__FSM__DOT__Out) 
				   >> 4U))));
	vcdp->fullBus(c+38,((0xfU & (IData)(vlTOPp->tb__DOT__uart_rcvr_top__DOT__FSM__DOT__Out))),4);
	vcdp->fullBit(c+39,((1U & ((IData)(vlTOPp->tb__DOT__uart_rcvr_top__DOT__FSM__DOT__Out) 
				   >> 5U))));
	vcdp->fullBit(c+40,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__Rx_register__DOT__Rx_intermediate));
	vcdp->fullBus(c+41,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__FSM__DOT__state_reg),4);
	vcdp->fullBus(c+42,(vlTOPp->tb__DOT__uart_rcvr_top__DOT__FSM__DOT__Out),8);
	vcdp->fullBit(c+43,(vlTOPp->tb__DOT__uart_tr_top__DOT__CO));
	vcdp->fullBit(c+44,((1U & ((IData)(vlTOPp->tb__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				   >> 4U))));
	vcdp->fullBit(c+45,((1U & ((IData)(vlTOPp->tb__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				   >> 3U))));
	vcdp->fullBit(c+46,((1U & ((IData)(vlTOPp->tb__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				   >> 1U))));
	vcdp->fullBit(c+47,((1U & ((IData)(vlTOPp->tb__DOT__uart_tr_top__DOT__FSM1__DOT__out) 
				   >> 2U))));
	vcdp->fullBit(c+48,((1U & (IData)(vlTOPp->tb__DOT__uart_tr_top__DOT__FSM1__DOT__out))));
	vcdp->fullBus(c+49,(vlTOPp->tb__DOT__uart_tr_top__DOT__ROMaddr),4);
	vcdp->fullBus(c+50,(vlTOPp->tb__DOT__uart_tr_top__DOT__FSM1__DOT__state),4);
	vcdp->fullBus(c+51,(vlTOPp->tb__DOT__uart_tr_top__DOT__FSM1__DOT__out),5);
	vcdp->fullBus(c+52,(vlTOPp->tb__DOT__uart_tr_top__DOT__Cntr__DOT__count),8);
	vcdp->fullBit(c+53,(vlTOPp->verilator_clk));
	vcdp->fullBit(c+54,(vlTOPp->verilator_rst));
	vcdp->fullBus(c+55,(1U),32);
	vcdp->fullBus(c+56,(0xbU),4);
	vcdp->fullBus(c+57,(vlTOPp->tb__DOT__i),32);
	vcdp->fullBus(c+58,(vlTOPp->tb__DOT__j),32);
	vcdp->fullBus(c+59,(vlTOPp->tb__DOT__k),32);
	vcdp->fullBit(c+60,(vlTOPp->tb__DOT__clk_16));
	vcdp->fullBit(c+61,(vlTOPp->tb__DOT__uart_rxd));
	vcdp->fullBit(c+62,(vlTOPp->tb__DOT__uart_rx_rd));
	vcdp->fullBit(c+63,(vlTOPp->tb__DOT__uart_rx_clr_ovrflw));
	vcdp->fullBus(c+64,(vlTOPp->tb__DOT__uart_tx_wdata),8);
	vcdp->fullBit(c+65,(vlTOPp->tb__DOT__uart_tx_wr));
	vcdp->fullBus(c+66,(0U),4);
	vcdp->fullBus(c+67,(1U),4);
	vcdp->fullBus(c+68,(2U),4);
	vcdp->fullBus(c+69,(3U),4);
	vcdp->fullBus(c+70,(4U),4);
	vcdp->fullBus(c+71,(5U),4);
	vcdp->fullBus(c+72,(6U),4);
	vcdp->fullBus(c+73,(7U),4);
	vcdp->fullBus(c+74,(8U),4);
	vcdp->fullBus(c+75,(9U),4);
	vcdp->fullBus(c+76,(0xaU),4);
    }
}
