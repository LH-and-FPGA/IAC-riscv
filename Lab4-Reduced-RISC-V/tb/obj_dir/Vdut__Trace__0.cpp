// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vdut__Syms.h"


void Vdut___024root__trace_chg_sub_0(Vdut___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vdut___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_chg_top_0\n"); );
    // Init
    Vdut___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vdut___024root*>(voidSelf);
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vdut___024root__trace_chg_sub_0((&vlSymsp->TOP), bufp);
}

void Vdut___024root__trace_chg_sub_0(Vdut___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_chg_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[1U])) {
        bufp->chgBit(oldp+0,((0x33U != (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))));
        bufp->chgBit(oldp+1,((0U != (IData)(vlSelf->top__DOT__rd))));
        bufp->chgBit(oldp+2,((0U == vlSelf->top__DOT__alu_out)));
        bufp->chgCData(oldp+3,(vlSelf->top__DOT__alu_ctrl),4);
        bufp->chgIData(oldp+4,(vlSelf->top__DOT__ins),32);
        bufp->chgIData(oldp+5,(vlSelf->top__DOT__PC_TOP__DOT__prev_pc),32);
        bufp->chgCData(oldp+6,(vlSelf->top__DOT__rd),5);
        bufp->chgCData(oldp+7,(vlSelf->top__DOT__rs1),5);
        bufp->chgCData(oldp+8,(vlSelf->top__DOT__rs2),5);
        bufp->chgIData(oldp+9,(vlSelf->top__DOT__imm32),32);
        bufp->chgIData(oldp+10,(vlSelf->top__DOT__alu_out),32);
        bufp->chgIData(oldp+11,(vlSelf->top__DOT__op1),32);
        bufp->chgIData(oldp+12,(((0U == (IData)(vlSelf->top__DOT__rs2))
                                  ? 0U : vlSelf->top__DOT__REGFILE__DOT__regs
                                 [vlSelf->top__DOT__rs2])),32);
        bufp->chgIData(oldp+13,(vlSelf->top__DOT__alu_operand_b),32);
        bufp->chgCData(oldp+14,(vlSelf->top__DOT__CONTROLPATH__DOT__opcode),7);
        bufp->chgCData(oldp+15,(vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct3),3);
        bufp->chgCData(oldp+16,(vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct7),7);
        bufp->chgBit(oldp+17,((0U != vlSelf->top__DOT__alu_out)));
        bufp->chgIData(oldp+18,(vlSelf->top__DOT__REGFILE__DOT__regs[0]),32);
        bufp->chgIData(oldp+19,(vlSelf->top__DOT__REGFILE__DOT__regs[1]),32);
        bufp->chgIData(oldp+20,(vlSelf->top__DOT__REGFILE__DOT__regs[2]),32);
        bufp->chgIData(oldp+21,(vlSelf->top__DOT__REGFILE__DOT__regs[3]),32);
        bufp->chgIData(oldp+22,(vlSelf->top__DOT__REGFILE__DOT__regs[4]),32);
        bufp->chgIData(oldp+23,(vlSelf->top__DOT__REGFILE__DOT__regs[5]),32);
        bufp->chgIData(oldp+24,(vlSelf->top__DOT__REGFILE__DOT__regs[6]),32);
        bufp->chgIData(oldp+25,(vlSelf->top__DOT__REGFILE__DOT__regs[7]),32);
        bufp->chgIData(oldp+26,(vlSelf->top__DOT__REGFILE__DOT__regs[8]),32);
        bufp->chgIData(oldp+27,(vlSelf->top__DOT__REGFILE__DOT__regs[9]),32);
        bufp->chgIData(oldp+28,(vlSelf->top__DOT__REGFILE__DOT__regs[10]),32);
        bufp->chgIData(oldp+29,(vlSelf->top__DOT__REGFILE__DOT__regs[11]),32);
        bufp->chgIData(oldp+30,(vlSelf->top__DOT__REGFILE__DOT__regs[12]),32);
        bufp->chgIData(oldp+31,(vlSelf->top__DOT__REGFILE__DOT__regs[13]),32);
        bufp->chgIData(oldp+32,(vlSelf->top__DOT__REGFILE__DOT__regs[14]),32);
        bufp->chgIData(oldp+33,(vlSelf->top__DOT__REGFILE__DOT__regs[15]),32);
        bufp->chgIData(oldp+34,(vlSelf->top__DOT__REGFILE__DOT__regs[16]),32);
        bufp->chgIData(oldp+35,(vlSelf->top__DOT__REGFILE__DOT__regs[17]),32);
        bufp->chgIData(oldp+36,(vlSelf->top__DOT__REGFILE__DOT__regs[18]),32);
        bufp->chgIData(oldp+37,(vlSelf->top__DOT__REGFILE__DOT__regs[19]),32);
        bufp->chgIData(oldp+38,(vlSelf->top__DOT__REGFILE__DOT__regs[20]),32);
        bufp->chgIData(oldp+39,(vlSelf->top__DOT__REGFILE__DOT__regs[21]),32);
        bufp->chgIData(oldp+40,(vlSelf->top__DOT__REGFILE__DOT__regs[22]),32);
        bufp->chgIData(oldp+41,(vlSelf->top__DOT__REGFILE__DOT__regs[23]),32);
        bufp->chgIData(oldp+42,(vlSelf->top__DOT__REGFILE__DOT__regs[24]),32);
        bufp->chgIData(oldp+43,(vlSelf->top__DOT__REGFILE__DOT__regs[25]),32);
        bufp->chgIData(oldp+44,(vlSelf->top__DOT__REGFILE__DOT__regs[26]),32);
        bufp->chgIData(oldp+45,(vlSelf->top__DOT__REGFILE__DOT__regs[27]),32);
        bufp->chgIData(oldp+46,(vlSelf->top__DOT__REGFILE__DOT__regs[28]),32);
        bufp->chgIData(oldp+47,(vlSelf->top__DOT__REGFILE__DOT__regs[29]),32);
        bufp->chgIData(oldp+48,(vlSelf->top__DOT__REGFILE__DOT__regs[30]),32);
        bufp->chgIData(oldp+49,(vlSelf->top__DOT__REGFILE__DOT__regs[31]),32);
        bufp->chgIData(oldp+50,(vlSelf->top__DOT__REGFILE__DOT__unnamedblk1__DOT__i),32);
    }
    bufp->chgBit(oldp+51,(vlSelf->clk));
    bufp->chgBit(oldp+52,(vlSelf->rst));
    bufp->chgBit(oldp+53,(vlSelf->en));
    bufp->chgIData(oldp+54,(vlSelf->a0),32);
    bufp->chgIData(oldp+55,(((IData)(vlSelf->en) ? 
                             (vlSelf->top__DOT__PC_TOP__DOT__prev_pc 
                              + vlSelf->top__DOT__imm32)
                              : vlSelf->top__DOT__PC_TOP__DOT__prev_pc)),32);
    bufp->chgIData(oldp+56,(((IData)(vlSelf->en) ? 
                             ((IData)(4U) + vlSelf->top__DOT__PC_TOP__DOT__prev_pc)
                              : vlSelf->top__DOT__PC_TOP__DOT__prev_pc)),32);
    bufp->chgIData(oldp+57,(((0U != vlSelf->top__DOT__alu_out)
                              ? ((IData)(vlSelf->en)
                                  ? (vlSelf->top__DOT__PC_TOP__DOT__prev_pc 
                                     + vlSelf->top__DOT__imm32)
                                  : vlSelf->top__DOT__PC_TOP__DOT__prev_pc)
                              : ((IData)(vlSelf->en)
                                  ? ((IData)(4U) + vlSelf->top__DOT__PC_TOP__DOT__prev_pc)
                                  : vlSelf->top__DOT__PC_TOP__DOT__prev_pc))),32);
}

void Vdut___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_cleanup\n"); );
    // Init
    Vdut___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vdut___024root*>(voidSelf);
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
}
