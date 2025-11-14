module controlpath #(
    parameter DATA_WIDTH = 32,
    parameter REG_NUM = 32,
    parameter ADDR_WIDTH = $clog2(REG_NUM)      // for regfile
) (
    input   logic [DATA_WIDTH-1:0]  ins,
    input   logic                   zero,       // for bne
    output  logic [ADDR_WIDTH-1:0]  reg_write,
    output  logic [2:0]             alu_funct3,
    output  logic [6:0]             alu_funct7,
    output  logic                   alu_src,
    output  logic                   pc_src,
    output  logic [ADDR_WIDTH-1:0]  rs1,
    output  logic [ADDR_WIDTH-1:0]  rs2,
    output  loigc [DATA_WIDTH-1:0]  imm32,
);
    logic [6:0]     opcode;
    logic [4:0]     rd;
    logic [2:0]     funct3;
    logic [4:0]     rs1;
    logic [4:0]     rs2;
    logic [6:0]     funct7;

    insdecode Insdecode(
        .ins(ins),
        .opcode(opcode),
        .rd(rd),
        .funct3(alu_funct3),
        .rs1(rs1),
        .rs2(rs2),
        .funct7(alu_funct7),
        .imm32(imm32)
    )


    
endmodule