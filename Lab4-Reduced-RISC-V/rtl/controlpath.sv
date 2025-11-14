module controlpath #(
    parameter DATA_WIDTH = 32,
    parameter REG_NUM = 32,
    parameter ADDR_WIDTH = $clog2(REG_NUM)      // for regfile
) (
    input   logic [DATA_WIDTH-1:0]  ins,
    output  logic                   alu_src,    // imm (==1) or from reg (==0)
    output  logic [3:0]             alu_ctrl,   // for our ALU
    output  logic [ADDR_WIDTH-1:0]  reg_write,
    output  logic [ADDR_WIDTH-1:0]  rs1,
    output  logic [ADDR_WIDTH-1:0]  rs2,
    output  loigc [DATA_WIDTH-1:0]  imm32,
);
    logic [6:0] opcode;
    logic [2:0] alu_funct3;
    logic [6:0] alu_funct7;

    insdecode INSDECODE(
        .ins(ins),
        .opcode(opcode),
        .rd(rd),
        .funct3(alu_funct3),
        .rs1(rs1),
        .rs2(rs2),
        .funct7(alu_funct7),
        .imm32(imm32)
    );

    alu_decoder ALU_DECODER(
        .funct3(alu_funct3),
        .funct7(alu_funct7),
        .opcode(opcode),
        .alu_ctrl(alu_ctrl),
        .alu_src(alu_src)
    );

endmodule
