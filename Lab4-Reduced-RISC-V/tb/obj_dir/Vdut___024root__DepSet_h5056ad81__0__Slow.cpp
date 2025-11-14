// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vdut.h for the primary calling header

#include "verilated.h"

#include "Vdut___024root.h"

VL_ATTR_COLD void Vdut___024root___initial__TOP__0(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___initial__TOP__0\n"); );
    // Init
    VlWide<3>/*95:0*/ __Vtemp_h5d3392b8__0;
    // Body
    __Vtemp_h5d3392b8__0[0U] = 0x2e6d656dU;
    __Vtemp_h5d3392b8__0[1U] = 0x6e737472U;
    __Vtemp_h5d3392b8__0[2U] = 0x69U;
    VL_READMEM_N(true, 32, 1024, 0, VL_CVT_PACK_STR_NW(3, __Vtemp_h5d3392b8__0)
                 ,  &(vlSelf->top__DOT__INSTR_MEM__DOT__rom_array)
                 , 0, ~0ULL);
}

VL_ATTR_COLD void Vdut___024root___settle__TOP__0(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___settle__TOP__0\n"); );
    // Body
    vlSelf->a0 = vlSelf->top__DOT__REGFILE__DOT__regs
        [0xaU];
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
    if (vlSelf->en) {
        vlSelf->top__DOT__PC_TOP__DOT__inc_pc = ((IData)(4U) 
                                                 + vlSelf->top__DOT__PC_TOP__DOT__prev_pc);
        vlSelf->top__DOT__PC_TOP__DOT__branch_pc = 
            (vlSelf->top__DOT__PC_TOP__DOT__prev_pc 
             + vlSelf->top__DOT__imm32);
    } else {
        vlSelf->top__DOT__PC_TOP__DOT__inc_pc = vlSelf->top__DOT__PC_TOP__DOT__prev_pc;
        vlSelf->top__DOT__PC_TOP__DOT__branch_pc = vlSelf->top__DOT__PC_TOP__DOT__prev_pc;
    }
    vlSelf->top__DOT__op1 = ((0U == (IData)(vlSelf->top__DOT__rs1))
                              ? 0U : vlSelf->top__DOT__REGFILE__DOT__regs
                             [vlSelf->top__DOT__rs1]);
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

VL_ATTR_COLD void Vdut___024root___eval_initial(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___eval_initial\n"); );
    // Body
    vlSelf->__Vclklast__TOP__clk = vlSelf->clk;
    vlSelf->__Vclklast__TOP__rst = vlSelf->rst;
    Vdut___024root___initial__TOP__0(vlSelf);
}

VL_ATTR_COLD void Vdut___024root___eval_settle(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___eval_settle\n"); );
    // Body
    Vdut___024root___settle__TOP__0(vlSelf);
    vlSelf->__Vm_traceActivity[3U] = 1U;
    vlSelf->__Vm_traceActivity[2U] = 1U;
    vlSelf->__Vm_traceActivity[1U] = 1U;
    vlSelf->__Vm_traceActivity[0U] = 1U;
}

VL_ATTR_COLD void Vdut___024root___final(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___final\n"); );
}

VL_ATTR_COLD void Vdut___024root___ctor_var_reset(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->clk = VL_RAND_RESET_I(1);
    vlSelf->rst = VL_RAND_RESET_I(1);
    vlSelf->en = VL_RAND_RESET_I(1);
    vlSelf->a0 = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__alu_ctrl = VL_RAND_RESET_I(4);
    vlSelf->top__DOT__ins = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__rd = VL_RAND_RESET_I(5);
    vlSelf->top__DOT__rs1 = VL_RAND_RESET_I(5);
    vlSelf->top__DOT__rs2 = VL_RAND_RESET_I(5);
    vlSelf->top__DOT__imm32 = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__alu_out = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__op1 = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__alu_operand_b = VL_RAND_RESET_I(32);
    for (int __Vi0=0; __Vi0<1024; ++__Vi0) {
        vlSelf->top__DOT__INSTR_MEM__DOT__rom_array[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->top__DOT__CONTROLPATH__DOT__opcode = VL_RAND_RESET_I(7);
    vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct3 = VL_RAND_RESET_I(3);
    vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct7 = VL_RAND_RESET_I(7);
    vlSelf->top__DOT__PC_TOP__DOT__branch_pc = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__PC_TOP__DOT__inc_pc = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__PC_TOP__DOT__prev_pc = VL_RAND_RESET_I(32);
    for (int __Vi0=0; __Vi0<32; ++__Vi0) {
        vlSelf->top__DOT__REGFILE__DOT__regs[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->top__DOT__REGFILE__DOT__unnamedblk1__DOT__i = 0;
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = VL_RAND_RESET_I(1);
    }
}
