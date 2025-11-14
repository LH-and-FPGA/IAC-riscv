// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vdut__Syms.h"


VL_ATTR_COLD void Vdut___024root__trace_init_sub__TOP__0(Vdut___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+52,"clk", false,-1);
    tracep->declBit(c+53,"rst", false,-1);
    tracep->declBit(c+54,"en", false,-1);
    tracep->declBus(c+55,"a0", false,-1, 31,0);
    tracep->pushNamePrefix("top ");
    tracep->declBus(c+59,"DATA_WIDTH", false,-1, 31,0);
    tracep->declBus(c+59,"REG_NUM", false,-1, 31,0);
    tracep->declBus(c+60,"ADDR_WIDTH", false,-1, 31,0);
    tracep->declBit(c+52,"clk", false,-1);
    tracep->declBit(c+53,"rst", false,-1);
    tracep->declBit(c+54,"en", false,-1);
    tracep->declBus(c+55,"a0", false,-1, 31,0);
    tracep->declBit(c+1,"alu_src", false,-1);
    tracep->declBit(c+2,"reg_write", false,-1);
    tracep->declBit(c+3,"zero", false,-1);
    tracep->declBus(c+4,"alu_ctrl", false,-1, 3,0);
    tracep->declBus(c+5,"ins", false,-1, 31,0);
    tracep->declBus(c+6,"pc", false,-1, 31,0);
    tracep->declBus(c+7,"rd", false,-1, 4,0);
    tracep->declBus(c+8,"rs1", false,-1, 4,0);
    tracep->declBus(c+9,"rs2", false,-1, 4,0);
    tracep->declBus(c+10,"imm32", false,-1, 31,0);
    tracep->declBus(c+11,"alu_out", false,-1, 31,0);
    tracep->declBus(c+12,"op1", false,-1, 31,0);
    tracep->declBus(c+13,"op2", false,-1, 31,0);
    tracep->declBus(c+14,"alu_operand_b", false,-1, 31,0);
    tracep->pushNamePrefix("ALU ");
    tracep->declBus(c+59,"DATA_WIDTH", false,-1, 31,0);
    tracep->declBus(c+4,"alu_ctrl", false,-1, 3,0);
    tracep->declBus(c+12,"a", false,-1, 31,0);
    tracep->declBus(c+14,"b", false,-1, 31,0);
    tracep->declBus(c+11,"alu_out", false,-1, 31,0);
    tracep->declBit(c+3,"zero_flag", false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("CONTROLPATH ");
    tracep->declBus(c+59,"DATA_WIDTH", false,-1, 31,0);
    tracep->declBus(c+59,"REG_NUM", false,-1, 31,0);
    tracep->declBus(c+60,"ADDR_WIDTH", false,-1, 31,0);
    tracep->declBus(c+5,"ins", false,-1, 31,0);
    tracep->declBit(c+1,"alu_src", false,-1);
    tracep->declBit(c+2,"reg_write", false,-1);
    tracep->declBus(c+4,"alu_ctrl", false,-1, 3,0);
    tracep->declBus(c+7,"rd", false,-1, 4,0);
    tracep->declBus(c+8,"rs1", false,-1, 4,0);
    tracep->declBus(c+9,"rs2", false,-1, 4,0);
    tracep->declBus(c+10,"imm32", false,-1, 31,0);
    tracep->declBus(c+15,"opcode", false,-1, 6,0);
    tracep->declBus(c+16,"alu_funct3", false,-1, 2,0);
    tracep->declBus(c+17,"alu_funct7", false,-1, 6,0);
    tracep->pushNamePrefix("ALU_DECODER ");
    tracep->declBus(c+16,"funct3", false,-1, 2,0);
    tracep->declBus(c+17,"funct7", false,-1, 6,0);
    tracep->declBus(c+15,"opcode", false,-1, 6,0);
    tracep->declBus(c+4,"alu_ctrl", false,-1, 3,0);
    tracep->declBit(c+1,"alu_src", false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("INSDECODE ");
    tracep->declBus(c+59,"DATA_WIDTH", false,-1, 31,0);
    tracep->declBus(c+59,"REG_NUM", false,-1, 31,0);
    tracep->declBus(c+60,"ADDR_WIDTH", false,-1, 31,0);
    tracep->declBus(c+5,"ins", false,-1, 31,0);
    tracep->declBus(c+15,"opcode", false,-1, 6,0);
    tracep->declBus(c+7,"rd", false,-1, 4,0);
    tracep->declBus(c+16,"funct3", false,-1, 2,0);
    tracep->declBus(c+8,"rs1", false,-1, 4,0);
    tracep->declBus(c+9,"rs2", false,-1, 4,0);
    tracep->declBus(c+17,"funct7", false,-1, 6,0);
    tracep->declBus(c+10,"imm32", false,-1, 31,0);
    tracep->declBus(c+61,"OPC_R", false,-1, 6,0);
    tracep->declBus(c+62,"OPC_I", false,-1, 6,0);
    tracep->declBus(c+63,"OPC_S", false,-1, 6,0);
    tracep->declBus(c+64,"OPC_B", false,-1, 6,0);
    tracep->declBus(c+65,"OPC_J", false,-1, 6,0);
    tracep->declBus(c+66,"OPC_U", false,-1, 6,0);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("INSTR_MEM ");
    tracep->declBus(c+59,"DATA_WIDTH", false,-1, 31,0);
    tracep->declBus(c+59,"ADDRESS_WIDTH", false,-1, 31,0);
    tracep->declBus(c+67,"ROM_SIZE", false,-1, 31,0);
    tracep->declBit(c+52,"clk", false,-1);
    tracep->declBus(c+6,"addr", false,-1, 31,0);
    tracep->declBus(c+5,"instr", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("PC_TOP ");
    tracep->declBus(c+59,"DATA_WIDTH", false,-1, 31,0);
    tracep->declBit(c+54,"en", false,-1);
    tracep->declBit(c+52,"clk", false,-1);
    tracep->declBit(c+53,"rst", false,-1);
    tracep->declBit(c+18,"pc_src", false,-1);
    tracep->declBus(c+10,"imm", false,-1, 31,0);
    tracep->declBus(c+6,"pc", false,-1, 31,0);
    tracep->declBus(c+56,"branch_pc", false,-1, 31,0);
    tracep->declBus(c+57,"inc_pc", false,-1, 31,0);
    tracep->declBus(c+6,"prev_pc", false,-1, 31,0);
    tracep->declBus(c+58,"next_pc", false,-1, 31,0);
    tracep->pushNamePrefix("u_adder_branch ");
    tracep->declBus(c+59,"DATA_WIDTH", false,-1, 31,0);
    tracep->declBit(c+54,"en", false,-1);
    tracep->declBus(c+6,"pc", false,-1, 31,0);
    tracep->declBus(c+10,"imm", false,-1, 31,0);
    tracep->declBus(c+56,"pc_branch", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("u_adder_inc ");
    tracep->declBus(c+59,"DATA_WIDTH", false,-1, 31,0);
    tracep->declBit(c+54,"en", false,-1);
    tracep->declBus(c+6,"in", false,-1, 31,0);
    tracep->declBus(c+57,"out", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("u_pc_mux ");
    tracep->declBus(c+59,"DATA_WIDTH", false,-1, 31,0);
    tracep->declBit(c+18,"pc_src", false,-1);
    tracep->declBus(c+56,"branch_pc", false,-1, 31,0);
    tracep->declBus(c+57,"inc_pc", false,-1, 31,0);
    tracep->declBus(c+58,"next_pc", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("u_pc_reg ");
    tracep->declBus(c+59,"DATA_WIDTH", false,-1, 31,0);
    tracep->declBit(c+54,"en", false,-1);
    tracep->declBit(c+52,"clk", false,-1);
    tracep->declBit(c+53,"rst", false,-1);
    tracep->declBus(c+58,"next_pc", false,-1, 31,0);
    tracep->declBus(c+6,"pc", false,-1, 31,0);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("REGFILE ");
    tracep->declBus(c+59,"DATA_WIDTH", false,-1, 31,0);
    tracep->declBus(c+59,"REG_NUM", false,-1, 31,0);
    tracep->declBus(c+60,"ADDR_WIDTH", false,-1, 31,0);
    tracep->declBit(c+52,"clk", false,-1);
    tracep->declBit(c+53,"rst", false,-1);
    tracep->declBit(c+2,"we", false,-1);
    tracep->declBus(c+7,"w_addr", false,-1, 4,0);
    tracep->declBus(c+8,"r_addr1", false,-1, 4,0);
    tracep->declBus(c+9,"r_addr2", false,-1, 4,0);
    tracep->declBus(c+11,"w_data", false,-1, 31,0);
    tracep->declBus(c+12,"r_data1", false,-1, 31,0);
    tracep->declBus(c+13,"r_data2", false,-1, 31,0);
    tracep->declBus(c+55,"a0", false,-1, 31,0);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+19+i*1,"regs", true,(i+0), 31,0);
    }
    tracep->pushNamePrefix("unnamedblk1 ");
    tracep->declBus(c+51,"i", false,-1, 31,0);
    tracep->popNamePrefix(3);
}

VL_ATTR_COLD void Vdut___024root__trace_init_top(Vdut___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_init_top\n"); );
    // Body
    Vdut___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vdut___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vdut___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vdut___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void Vdut___024root__trace_register(Vdut___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&Vdut___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&Vdut___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&Vdut___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vdut___024root__trace_full_sub_0(Vdut___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vdut___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_full_top_0\n"); );
    // Init
    Vdut___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vdut___024root*>(voidSelf);
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vdut___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vdut___024root__trace_full_sub_0(Vdut___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_full_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullBit(oldp+1,((0x33U != (IData)(vlSelf->top__DOT__CONTROLPATH__DOT__opcode))));
    bufp->fullBit(oldp+2,((0U != (IData)(vlSelf->top__DOT__rd))));
    bufp->fullBit(oldp+3,((0U == vlSelf->top__DOT__alu_out)));
    bufp->fullCData(oldp+4,(vlSelf->top__DOT__alu_ctrl),4);
    bufp->fullIData(oldp+5,(vlSelf->top__DOT__ins),32);
    bufp->fullIData(oldp+6,(vlSelf->top__DOT__PC_TOP__DOT__prev_pc),32);
    bufp->fullCData(oldp+7,(vlSelf->top__DOT__rd),5);
    bufp->fullCData(oldp+8,(vlSelf->top__DOT__rs1),5);
    bufp->fullCData(oldp+9,(vlSelf->top__DOT__rs2),5);
    bufp->fullIData(oldp+10,(vlSelf->top__DOT__imm32),32);
    bufp->fullIData(oldp+11,(vlSelf->top__DOT__alu_out),32);
    bufp->fullIData(oldp+12,(vlSelf->top__DOT__op1),32);
    bufp->fullIData(oldp+13,(((0U == (IData)(vlSelf->top__DOT__rs2))
                               ? 0U : vlSelf->top__DOT__REGFILE__DOT__regs
                              [vlSelf->top__DOT__rs2])),32);
    bufp->fullIData(oldp+14,(vlSelf->top__DOT__alu_operand_b),32);
    bufp->fullCData(oldp+15,(vlSelf->top__DOT__CONTROLPATH__DOT__opcode),7);
    bufp->fullCData(oldp+16,(vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct3),3);
    bufp->fullCData(oldp+17,(vlSelf->top__DOT__CONTROLPATH__DOT__alu_funct7),7);
    bufp->fullBit(oldp+18,((0U != vlSelf->top__DOT__alu_out)));
    bufp->fullIData(oldp+19,(vlSelf->top__DOT__REGFILE__DOT__regs[0]),32);
    bufp->fullIData(oldp+20,(vlSelf->top__DOT__REGFILE__DOT__regs[1]),32);
    bufp->fullIData(oldp+21,(vlSelf->top__DOT__REGFILE__DOT__regs[2]),32);
    bufp->fullIData(oldp+22,(vlSelf->top__DOT__REGFILE__DOT__regs[3]),32);
    bufp->fullIData(oldp+23,(vlSelf->top__DOT__REGFILE__DOT__regs[4]),32);
    bufp->fullIData(oldp+24,(vlSelf->top__DOT__REGFILE__DOT__regs[5]),32);
    bufp->fullIData(oldp+25,(vlSelf->top__DOT__REGFILE__DOT__regs[6]),32);
    bufp->fullIData(oldp+26,(vlSelf->top__DOT__REGFILE__DOT__regs[7]),32);
    bufp->fullIData(oldp+27,(vlSelf->top__DOT__REGFILE__DOT__regs[8]),32);
    bufp->fullIData(oldp+28,(vlSelf->top__DOT__REGFILE__DOT__regs[9]),32);
    bufp->fullIData(oldp+29,(vlSelf->top__DOT__REGFILE__DOT__regs[10]),32);
    bufp->fullIData(oldp+30,(vlSelf->top__DOT__REGFILE__DOT__regs[11]),32);
    bufp->fullIData(oldp+31,(vlSelf->top__DOT__REGFILE__DOT__regs[12]),32);
    bufp->fullIData(oldp+32,(vlSelf->top__DOT__REGFILE__DOT__regs[13]),32);
    bufp->fullIData(oldp+33,(vlSelf->top__DOT__REGFILE__DOT__regs[14]),32);
    bufp->fullIData(oldp+34,(vlSelf->top__DOT__REGFILE__DOT__regs[15]),32);
    bufp->fullIData(oldp+35,(vlSelf->top__DOT__REGFILE__DOT__regs[16]),32);
    bufp->fullIData(oldp+36,(vlSelf->top__DOT__REGFILE__DOT__regs[17]),32);
    bufp->fullIData(oldp+37,(vlSelf->top__DOT__REGFILE__DOT__regs[18]),32);
    bufp->fullIData(oldp+38,(vlSelf->top__DOT__REGFILE__DOT__regs[19]),32);
    bufp->fullIData(oldp+39,(vlSelf->top__DOT__REGFILE__DOT__regs[20]),32);
    bufp->fullIData(oldp+40,(vlSelf->top__DOT__REGFILE__DOT__regs[21]),32);
    bufp->fullIData(oldp+41,(vlSelf->top__DOT__REGFILE__DOT__regs[22]),32);
    bufp->fullIData(oldp+42,(vlSelf->top__DOT__REGFILE__DOT__regs[23]),32);
    bufp->fullIData(oldp+43,(vlSelf->top__DOT__REGFILE__DOT__regs[24]),32);
    bufp->fullIData(oldp+44,(vlSelf->top__DOT__REGFILE__DOT__regs[25]),32);
    bufp->fullIData(oldp+45,(vlSelf->top__DOT__REGFILE__DOT__regs[26]),32);
    bufp->fullIData(oldp+46,(vlSelf->top__DOT__REGFILE__DOT__regs[27]),32);
    bufp->fullIData(oldp+47,(vlSelf->top__DOT__REGFILE__DOT__regs[28]),32);
    bufp->fullIData(oldp+48,(vlSelf->top__DOT__REGFILE__DOT__regs[29]),32);
    bufp->fullIData(oldp+49,(vlSelf->top__DOT__REGFILE__DOT__regs[30]),32);
    bufp->fullIData(oldp+50,(vlSelf->top__DOT__REGFILE__DOT__regs[31]),32);
    bufp->fullIData(oldp+51,(vlSelf->top__DOT__REGFILE__DOT__unnamedblk1__DOT__i),32);
    bufp->fullBit(oldp+52,(vlSelf->clk));
    bufp->fullBit(oldp+53,(vlSelf->rst));
    bufp->fullBit(oldp+54,(vlSelf->en));
    bufp->fullIData(oldp+55,(vlSelf->a0),32);
    bufp->fullIData(oldp+56,(((IData)(vlSelf->en) ? 
                              (vlSelf->top__DOT__PC_TOP__DOT__prev_pc 
                               + vlSelf->top__DOT__imm32)
                               : vlSelf->top__DOT__PC_TOP__DOT__prev_pc)),32);
    bufp->fullIData(oldp+57,(((IData)(vlSelf->en) ? 
                              ((IData)(4U) + vlSelf->top__DOT__PC_TOP__DOT__prev_pc)
                               : vlSelf->top__DOT__PC_TOP__DOT__prev_pc)),32);
    bufp->fullIData(oldp+58,(((0U != vlSelf->top__DOT__alu_out)
                               ? ((IData)(vlSelf->en)
                                   ? (vlSelf->top__DOT__PC_TOP__DOT__prev_pc 
                                      + vlSelf->top__DOT__imm32)
                                   : vlSelf->top__DOT__PC_TOP__DOT__prev_pc)
                               : ((IData)(vlSelf->en)
                                   ? ((IData)(4U) + vlSelf->top__DOT__PC_TOP__DOT__prev_pc)
                                   : vlSelf->top__DOT__PC_TOP__DOT__prev_pc))),32);
    bufp->fullIData(oldp+59,(0x20U),32);
    bufp->fullIData(oldp+60,(5U),32);
    bufp->fullCData(oldp+61,(0x33U),7);
    bufp->fullCData(oldp+62,(0x13U),7);
    bufp->fullCData(oldp+63,(0x23U),7);
    bufp->fullCData(oldp+64,(0x63U),7);
    bufp->fullCData(oldp+65,(0x6fU),7);
    bufp->fullCData(oldp+66,(0x37U),7);
    bufp->fullIData(oldp+67,(0x400U),32);
}
