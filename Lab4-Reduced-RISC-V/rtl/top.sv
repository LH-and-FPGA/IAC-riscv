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
    logic [DATA_WIDTH-1:0] ins;
    logic [DATA_WIDTH-1:0] pc;
    logic alu_src;
    logic reg_write;
    logic zero;
    logic [3:0] alu_ctrl;
    logic [ADDR_WIDTH-1:0]  rs1;
    logic [ADDR_WIDTH-1:0]  rs2;
    logic [DATA_WIDTH-1:0]  imm32;
    logic [DATA_WIDTH-1:0]  alu_out;
    logic [DATA_WIDTH-1:0]  op1;
    logic [DATA_WIDTH-1:0]  op2;
    
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
        .rs1(rs1),
        .rs2(rs2),
        .imm32(imm32)
    );

    alu ALU(
        .alu_ctrl(alu_ctrl),
        .a(op1),
        .b(op2),
        .alu_out(alu_out),
        .zero_flag(zero)
    );

    pc_top PC_TOP(
        .en(en),
        .clk(clk),
        .rst(rst),
        .pc_src(!zero),
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
        .r_addr1(op1),
        .r_addr2(op2),
        .a0(a0)
    );

endmodule
