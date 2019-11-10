// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef _Vtb__Syms_H_
#define _Vtb__Syms_H_

#include "verilated_heavy.h"

// INCLUDE MODULE CLASSES
#include "Vtb.h"

// DPI TYPES for DPI Export callbacks (Internal use)

// SYMS CLASS
class Vtb__Syms : public VerilatedSyms {
  public:
    
    // LOCAL STATE
    const char* __Vm_namep;
    bool __Vm_activity;  ///< Used by trace routines to determine change occurred
    bool __Vm_didInit;
    
    // SUBCELL STATE
    Vtb*                           TOPp;
    
    // SCOPE NAMES
    VerilatedScope __Vscope_tb__top__j1_prb;
    VerilatedScope __Vscope_tb__top__j1_prb__dstack;
    VerilatedScope __Vscope_tb__top__j1_prb__rstack;
    
    // CREATORS
    Vtb__Syms(Vtb* topp, const char* namep);
    ~Vtb__Syms() {}
    
    // METHODS
    inline const char* name() { return __Vm_namep; }
    inline bool getClearActivity() { bool r=__Vm_activity; __Vm_activity=false; return r; }
    
} VL_ATTR_ALIGNED(64);

#endif  // guard
