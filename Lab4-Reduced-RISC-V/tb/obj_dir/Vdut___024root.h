// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vdut.h for the primary calling header

#ifndef VERILATED_VDUT___024ROOT_H_
#define VERILATED_VDUT___024ROOT_H_  // guard

#include "verilated.h"

class Vdut__Syms;

class Vdut___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_IN8(rst,0,0);
    VL_IN8(en,0,0);
    CData/*3:0*/ top__DOT__alu_ctrl;
    CData/*4:0*/ top__DOT__rd;
    CData/*4:0*/ top__DOT__rs1;
    CData/*4:0*/ top__DOT__rs2;
    CData/*6:0*/ top__DOT__CONTROLPATH__DOT__opcode;
    CData/*2:0*/ top__DOT__CONTROLPATH__DOT__alu_funct3;
    CData/*6:0*/ top__DOT__CONTROLPATH__DOT__alu_funct7;
    CData/*0:0*/ __Vclklast__TOP__clk;
    VL_OUT(a0,31,0);
    IData/*31:0*/ top__DOT__ins;
    IData/*31:0*/ top__DOT__imm32;
    IData/*31:0*/ top__DOT__alu_out;
    IData/*31:0*/ top__DOT__op1;
    IData/*31:0*/ top__DOT__alu_operand_b;
    IData/*31:0*/ top__DOT__PC_TOP__DOT__branch_pc;
    IData/*31:0*/ top__DOT__PC_TOP__DOT__inc_pc;
    IData/*31:0*/ top__DOT__PC_TOP__DOT__prev_pc;
    IData/*31:0*/ top__DOT__REGFILE__DOT__unnamedblk1__DOT__i;
    VlUnpacked<IData/*31:0*/, 1024> top__DOT__INSTR_MEM__DOT__rom_array;
    VlUnpacked<IData/*31:0*/, 32> top__DOT__REGFILE__DOT__regs;
    VlUnpacked<CData/*0:0*/, 2> __Vm_traceActivity;

    // INTERNAL VARIABLES
    Vdut__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vdut___024root(Vdut__Syms* symsp, const char* name);
    ~Vdut___024root();
    VL_UNCOPYABLE(Vdut___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
