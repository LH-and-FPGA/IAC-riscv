// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vdut.h for the primary calling header

#include "verilated.h"

#include "Vdut___024root.h"

VL_INLINE_OPT void Vdut___024root___sequent__TOP__0(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___sequent__TOP__0\n"); );
    // Body
    vlSelf->top__DOT__ins = vlSelf->top__DOT__INSTR_MEM__DOT__rom_array
        [(0x3ffU & vlSelf->top__DOT__PC_TOP__DOT__prev_pc)];
    if (vlSelf->rst) {
        vlSelf->top__DOT__PC_TOP__DOT__prev_pc = 0U;
    } else if (vlSelf->en) {
        vlSelf->top__DOT__PC_TOP__DOT__prev_pc = ((0U 
                                                   != vlSelf->top__DOT__alu_out)
                                                   ? vlSelf->top__DOT__PC_TOP__DOT__branch_pc
                                                   : vlSelf->top__DOT__PC_TOP__DOT__inc_pc);
    }
}

VL_INLINE_OPT void Vdut___024root___sequent__TOP__1(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___sequent__TOP__1\n"); );
    // Init
    CData/*0:0*/ __Vdlyvset__top__DOT__REGFILE__DOT__regs__v0;
    CData/*4:0*/ __Vdlyvdim0__top__DOT__REGFILE__DOT__regs__v32;
    IData/*31:0*/ __Vdlyvval__top__DOT__REGFILE__DOT__regs__v32;
    CData/*0:0*/ __Vdlyvset__top__DOT__REGFILE__DOT__regs__v32;
    CData/*0:0*/ __Vdlyvset__top__DOT__REGFILE__DOT__regs__v33;
    // Body
    __Vdlyvset__top__DOT__REGFILE__DOT__regs__v0 = 0U;
    __Vdlyvset__top__DOT__REGFILE__DOT__regs__v32 = 0U;
    __Vdlyvset__top__DOT__REGFILE__DOT__regs__v33 = 0U;
    if (vlSelf->rst) {
        vlSelf->top__DOT__REGFILE__DOT__unnamedblk1__DOT__i = 0x20U;
        __Vdlyvset__top__DOT__REGFILE__DOT__regs__v0 = 1U;
    } else {
        if (((0U != (IData)(vlSelf->top__DOT__rd)) 
             & (0U != (IData)(vlSelf->top__DOT__rd)))) {
            __Vdlyvval__top__DOT__REGFILE__DOT__regs__v32 
                = vlSelf->top__DOT__alu_out;
            __Vdlyvset__top__DOT__REGFILE__DOT__regs__v32 = 1U;
            __Vdlyvdim0__top__DOT__REGFILE__DOT__regs__v32 
                = vlSelf->top__DOT__rd;
        }
        __Vdlyvset__top__DOT__REGFILE__DOT__regs__v33 = 1U;
    }
    if (__Vdlyvset__top__DOT__REGFILE__DOT__regs__v0) {
        vlSelf->top__DOT__REGFILE__DOT__regs[0U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[1U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[2U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[3U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[4U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[5U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[6U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[7U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[8U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[9U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0xaU] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0xbU] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0xcU] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0xdU] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0xeU] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0xfU] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0x10U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0x11U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0x12U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0x13U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0x14U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0x15U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0x16U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0x17U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0x18U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0x19U] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0x1aU] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0x1bU] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0x1cU] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0x1dU] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0x1eU] = 0U;
        vlSelf->top__DOT__REGFILE__DOT__regs[0x1fU] = 0U;
    }
    if (__Vdlyvset__top__DOT__REGFILE__DOT__regs__v32) {
        vlSelf->top__DOT__REGFILE__DOT__regs[__Vdlyvdim0__top__DOT__REGFILE__DOT__regs__v32] 
            = __Vdlyvval__top__DOT__REGFILE__DOT__regs__v32;
    }
    if (__Vdlyvset__top__DOT__REGFILE__DOT__regs__v33) {
        vlSelf->top__DOT__REGFILE__DOT__regs[0U] = 0U;
    }
    vlSelf->a0 = vlSelf->top__DOT__REGFILE__DOT__regs
        [0xaU];
}

VL_INLINE_OPT void Vdut___024root___combo__TOP__0(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___combo__TOP__0\n"); );
    // Body
    vlSelf->top__DOT__PC_TOP__DOT__inc_pc = ((IData)(vlSelf->en)
                                              ? ((IData)(4U) 
                                                 + vlSelf->top__DOT__PC_TOP__DOT__prev_pc)
                                              : vlSelf->top__DOT__PC_TOP__DOT__prev_pc);
}

VL_INLINE_OPT void Vdut___024root___sequent__TOP__2(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___sequent__TOP__2\n"); );
    // Body
    vlSelf->top__DOT__CONTROLPATH__DOT__opcode = (0x7fU 
                                                  & vlSelf->top__DOT__ins);
    vlSelf->top__DOT__rd = 0U;
    vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct3 = 0U;
    vlSelf->top__DOT__rs1 = 0U;
    vlSelf->top__DOT__rs2 = 0U;
    vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct7 = 0U;
    vlSelf->top__DOT__imm32 = 0U;
    if ((0x40U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
        if ((0x20U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
            if ((1U & (~ ((IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode) 
                          >> 4U)))) {
                if ((8U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
                    if ((4U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
                        if ((2U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
                            if ((1U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
                                vlSelf->top__DOT__rd 
                                    = (0x1fU & (vlSelf->top__DOT__ins 
                                                >> 7U));
                                vlSelf->top__DOT__imm32 
                                    = (((- (IData)(
                                                   (vlSelf->top__DOT__ins 
                                                    >> 0x1fU))) 
                                        << 0x15U) | 
                                       ((0x100000U 
                                         & (vlSelf->top__DOT__ins 
                                            >> 0xbU)) 
                                        | ((0xff000U 
                                            & vlSelf->top__DOT__ins) 
                                           | ((0x800U 
                                               & (vlSelf->top__DOT__ins 
                                                  >> 9U)) 
                                              | (0x7feU 
                                                 & (vlSelf->top__DOT__ins 
                                                    >> 0x14U))))));
                            }
                        }
                    }
                } else if ((1U & (~ ((IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode) 
                                     >> 2U)))) {
                    if ((2U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
                        if ((1U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
                            vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct3 
                                = (7U & (vlSelf->top__DOT__ins 
                                         >> 0xcU));
                            vlSelf->top__DOT__rs1 = 
                                (0x1fU & (vlSelf->top__DOT__ins 
                                          >> 0xfU));
                            vlSelf->top__DOT__rs2 = 
                                (0x1fU & (vlSelf->top__DOT__ins 
                                          >> 0x14U));
                            vlSelf->top__DOT__imm32 
                                = (((- (IData)((vlSelf->top__DOT__ins 
                                                >> 0x1fU))) 
                                    << 0xdU) | ((0x1000U 
                                                 & (vlSelf->top__DOT__ins 
                                                    >> 0x13U)) 
                                                | ((0x800U 
                                                    & (vlSelf->top__DOT__ins 
                                                       << 4U)) 
                                                   | ((0x7e0U 
                                                       & (vlSelf->top__DOT__ins 
                                                          >> 0x14U)) 
                                                      | (0x1eU 
                                                         & (vlSelf->top__DOT__ins 
                                                            >> 7U))))));
                        }
                    }
                }
            }
        }
    } else if ((0x20U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
        if ((0x10U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
            if ((1U & (~ ((IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode) 
                          >> 3U)))) {
                if ((4U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
                    if ((2U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
                        if ((1U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
                            vlSelf->top__DOT__rd = 
                                (0x1fU & (vlSelf->top__DOT__ins 
                                          >> 7U));
                            vlSelf->top__DOT__imm32 
                                = (0xfffff000U & vlSelf->top__DOT__ins);
                        }
                    }
                } else if ((2U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
                    if ((1U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
                        vlSelf->top__DOT__rd = (0x1fU 
                                                & (vlSelf->top__DOT__ins 
                                                   >> 7U));
                        vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct3 
                            = (7U & (vlSelf->top__DOT__ins 
                                     >> 0xcU));
                        vlSelf->top__DOT__rs1 = (0x1fU 
                                                 & (vlSelf->top__DOT__ins 
                                                    >> 0xfU));
                        vlSelf->top__DOT__rs2 = (0x1fU 
                                                 & (vlSelf->top__DOT__ins 
                                                    >> 0x14U));
                        vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct7 
                            = (vlSelf->top__DOT__ins 
                               >> 0x19U);
                    }
                }
            }
        } else if ((1U & (~ ((IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode) 
                             >> 3U)))) {
            if ((1U & (~ ((IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode) 
                          >> 2U)))) {
                if ((2U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
                    if ((1U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
                        vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct3 
                            = (7U & (vlSelf->top__DOT__ins 
                                     >> 0xcU));
                        vlSelf->top__DOT__rs1 = (0x1fU 
                                                 & (vlSelf->top__DOT__ins 
                                                    >> 0xfU));
                        vlSelf->top__DOT__rs2 = (0x1fU 
                                                 & (vlSelf->top__DOT__ins 
                                                    >> 0x14U));
                        vlSelf->top__DOT__imm32 = (
                                                   ((- (IData)(
                                                               (vlSelf->top__DOT__ins 
                                                                >> 0x1fU))) 
                                                    << 0xcU) 
                                                   | ((0xfe0U 
                                                       & (vlSelf->top__DOT__ins 
                                                          >> 0x14U)) 
                                                      | (0x1fU 
                                                         & (vlSelf->top__DOT__ins 
                                                            >> 7U))));
                    }
                }
            }
        }
    } else if ((0x10U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
        if ((1U & (~ ((IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode) 
                      >> 3U)))) {
            if ((1U & (~ ((IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode) 
                          >> 2U)))) {
                if ((2U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
                    if ((1U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))) {
                        vlSelf->top__DOT__rd = (0x1fU 
                                                & (vlSelf->top__DOT__ins 
                                                   >> 7U));
                        vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct3 
                            = (7U & (vlSelf->top__DOT__ins 
                                     >> 0xcU));
                        vlSelf->top__DOT__rs1 = (0x1fU 
                                                 & (vlSelf->top__DOT__ins 
                                                    >> 0xfU));
                        vlSelf->top__DOT__imm32 = (
                                                   ((- (IData)(
                                                               (vlSelf->top__DOT__ins 
                                                                >> 0x1fU))) 
                                                    << 0xcU) 
                                                   | (vlSelf->top__DOT__ins 
                                                      >> 0x14U));
                    }
                }
            }
        }
    }
    vlSelf->top__DOT__alu_ctrl = ((4U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct3))
                                   ? ((2U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct3))
                                       ? ((1U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct3))
                                           ? 2U : 3U)
                                       : ((1U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct3))
                                           ? ((0U == (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct7))
                                               ? 7U
                                               : 8U)
                                           : 4U)) : 
                                  ((2U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct3))
                                    ? ((1U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct3))
                                        ? 0xfU : 5U)
                                    : ((1U & (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct3))
                                        ? 6U : ((0U 
                                                 == (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct7))
                                                 ? 0U
                                                 : 1U))));
}

VL_INLINE_OPT void Vdut___024root___sequent__TOP__3(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___sequent__TOP__3\n"); );
    // Body
    vlSelf->top__DOT__op1 = ((0U == (IData)(vlSelf->top__DOT__rs1))
                              ? 0U : vlSelf->top__DOT__REGFILE__DOT__regs
                             [vlSelf->top__DOT__rs1]);
    vlSelf->top__DOT__alu_operand_b = ((0x33U != (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))
                                        ? vlSelf->top__DOT__imm32
                                        : ((0U == (IData)(vlSelf->top__DOT__rs2))
                                            ? 0U : 
                                           vlSelf->top__DOT__REGFILE__DOT__regs
                                           [vlSelf->top__DOT__rs2]));
    vlSelf->top__DOT__alu_out = ((8U & (IData)(vlSelf->top__DOT__alu_ctrl))
                                  ? ((4U & (IData)(vlSelf->top__DOT__alu_ctrl))
                                      ? 0U : ((2U & (IData)(vlSelf->top__DOT__alu_ctrl))
                                               ? 0U
                                               : ((1U 
                                                   & (IData)(vlSelf->top__DOT__alu_ctrl))
                                                   ? 0U
                                                   : 
                                                  VL_SHIFTRS_III(32,32,5, vlSelf->top__DOT__op1, 
                                                                 (0x1fU 
                                                                  & vlSelf->top__DOT__alu_operand_b)))))
                                  : ((4U & (IData)(vlSelf->top__DOT__alu_ctrl))
                                      ? ((2U & (IData)(vlSelf->top__DOT__alu_ctrl))
                                          ? ((1U & (IData)(vlSelf->top__DOT__alu_ctrl))
                                              ? (vlSelf->top__DOT__op1 
                                                 >> 
                                                 (0x1fU 
                                                  & vlSelf->top__DOT__alu_operand_b))
                                              : (vlSelf->top__DOT__op1 
                                                 << 
                                                 (0x1fU 
                                                  & vlSelf->top__DOT__alu_operand_b)))
                                          : ((1U & (IData)(vlSelf->top__DOT__alu_ctrl))
                                              ? (VL_LTS_III(32, vlSelf->top__DOT__op1, vlSelf->top__DOT__alu_operand_b)
                                                  ? 1U
                                                  : 0U)
                                              : (vlSelf->top__DOT__op1 
                                                 ^ vlSelf->top__DOT__alu_operand_b)))
                                      : ((2U & (IData)(vlSelf->top__DOT__alu_ctrl))
                                          ? ((1U & (IData)(vlSelf->top__DOT__alu_ctrl))
                                              ? (vlSelf->top__DOT__op1 
                                                 | vlSelf->top__DOT__alu_operand_b)
                                              : (vlSelf->top__DOT__op1 
                                                 & vlSelf->top__DOT__alu_operand_b))
                                          : ((1U & (IData)(vlSelf->top__DOT__alu_ctrl))
                                              ? (vlSelf->top__DOT__op1 
                                                 - vlSelf->top__DOT__alu_operand_b)
                                              : (vlSelf->top__DOT__op1 
                                                 + vlSelf->top__DOT__alu_operand_b)))));
}

VL_INLINE_OPT void Vdut___024root___combo__TOP__1(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___combo__TOP__1\n"); );
    // Body
    vlSelf->top__DOT__PC_TOP__DOT__branch_pc = ((IData)(vlSelf->en)
                                                 ? 
                                                (vlSelf->top__DOT__PC_TOP__DOT__prev_pc 
                                                 + vlSelf->top__DOT__imm32)
                                                 : vlSelf->top__DOT__PC_TOP__DOT__prev_pc);
}

void Vdut___024root___eval(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___eval\n"); );
    // Body
    if (((IData)(vlSelf->clk) & (~ (IData)(vlSelf->__Vclklast__TOP__clk)))) {
        Vdut___024root___sequent__TOP__0(vlSelf);
    }
    if ((((IData)(vlSelf->clk) & (~ (IData)(vlSelf->__Vclklast__TOP__clk))) 
         | ((IData)(vlSelf->rst) & (~ (IData)(vlSelf->__Vclklast__TOP__rst))))) {
        Vdut___024root___sequent__TOP__1(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
    }
    Vdut___024root___combo__TOP__0(vlSelf);
    if (((IData)(vlSelf->clk) & (~ (IData)(vlSelf->__Vclklast__TOP__clk)))) {
        Vdut___024root___sequent__TOP__2(vlSelf);
        vlSelf->__Vm_traceActivity[2U] = 1U;
    }
    if ((((IData)(vlSelf->clk) & (~ (IData)(vlSelf->__Vclklast__TOP__clk))) 
         | ((IData)(vlSelf->rst) & (~ (IData)(vlSelf->__Vclklast__TOP__rst))))) {
        Vdut___024root___sequent__TOP__3(vlSelf);
        vlSelf->__Vm_traceActivity[3U] = 1U;
    }
    Vdut___024root___combo__TOP__1(vlSelf);
    // Final
    vlSelf->__Vclklast__TOP__clk = vlSelf->clk;
    vlSelf->__Vclklast__TOP__rst = vlSelf->rst;
}

#ifdef VL_DEBUG
void Vdut___024root___eval_debug_assertions(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((vlSelf->rst & 0xfeU))) {
        Verilated::overWidthError("rst");}
    if (VL_UNLIKELY((vlSelf->en & 0xfeU))) {
        Verilated::overWidthError("en");}
}
#endif  // VL_DEBUG
