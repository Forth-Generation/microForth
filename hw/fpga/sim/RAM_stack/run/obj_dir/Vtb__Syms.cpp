// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vtb__Syms.h"
#include "Vtb.h"

// FUNCTIONS
Vtb__Syms::Vtb__Syms(Vtb* topp, const char* namep)
	// Setup locals
	: __Vm_namep(namep)
	, __Vm_activity(false)
	, __Vm_didInit(false)
	// Setup submodule names
{
    // Pointer to top level
    TOPp = topp;
    // Setup each module's pointers to their submodules
    // Setup each module's pointer back to symbol table (for public functions)
    TOPp->__Vconfigure(this, true);
    // Setup scope names
    __Vscope_tb__top__j1_prb.configure(this,name(),"tb.top.j1_prb");
    // Setup export functions
    for (int __Vfinal=0; __Vfinal<2; __Vfinal++) {
	__Vscope_tb__top__j1_prb.varInsert(__Vfinal,"pc", &(TOPp->tb__DOT__top__DOT__j1_prb__DOT__pc), VLVT_UINT16,VLVD_NODIR|VLVF_PUB_RW,1 ,12,0);
    }
}
