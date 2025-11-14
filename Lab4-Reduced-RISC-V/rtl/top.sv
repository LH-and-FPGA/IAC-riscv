module top #(
    parameter DATA_WIDTH = 32,
    parameter REG_NUM = 32,
    parameter ADDR_WIDTH = $clog2(REG_NUM)
) (
    input   logic clk,
    input   logic rst,
    input   logic en,
    output  logic [DATA_WIDTH-1:0] a0    
);
    // assign a0 = 32'd5;
    logic                   alu_src;
    logic                   reg_write;
    logic                   zero;
    logic                   branch;
    logic [3:0]             alu_ctrl;
    logic [DATA_WIDTH-1:0]  ins;
    logic [DATA_WIDTH-1:0]  pc;
    logic [ADDR_WIDTH-1:0]  rd;
    logic [ADDR_WIDTH-1:0]  rs1;
    logic [ADDR_WIDTH-1:0]  rs2;
    logic [DATA_WIDTH-1:0]  imm32;
    logic [DATA_WIDTH-1:0]  alu_out;
    logic [DATA_WIDTH-1:0]  op1;
    logic [DATA_WIDTH-1:0]  op2;
    logic [DATA_WIDTH-1:0]  alu_operand_b;
    
    instr_mem INSTR_MEM(
        .clk(clk),
        .addr(pc),
        .instr(ins)
    );

    controlpath CONTROLPATH(
        .ins(ins),
        .alu_ctrl(alu_ctrl),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),
        .imm32(imm32),
        .branch(branch)
    );

    assign alu_operand_b = alu_src ? imm32 : op2;

    alu ALU(
        .alu_ctrl(alu_ctrl),
        .a(op1),
        .b(alu_operand_b),
        .alu_out(alu_out),
        .zero_flag(zero)
    );

    pc_top PC_TOP(
        .en(en),
        .clk(clk),
        .rst(rst),
        .pc_src(branch & zero), // only set pc_src when opcode is 7'b1100011 and zero flag is set
        .imm(imm32),
        .pc(pc)
    );

    regfile REGFILE(
        .clk(clk),
        .rst(rst),
        .we(reg_write),
        .w_addr(rd),
        .r_addr1(rs1),
        .r_addr2(rs2),
        .w_data(alu_out),
        .r_data1(op1),
        .r_data2(op2),
        .a0(a0)
    );

endmodule
