module insdecode #(
    parameter DATA_WIDTH = 32,
    parameter REG_NUM = 32,
    parameter ADDR_WIDTH = $clog2(REG_NUM) // for regfile
) (
    input   logic [DATA_WIDTH-1:0]  ins,
    output  logic [6:0]             opcode,
    output  logic [ADDR_WIDTH-1:0]  rd,
    output  logic [2:0]             funct3,
    output  logic [ADDR_WIDTH-1:0]  rs1,
    output  logic [ADDR_WIDTH-1:0]  rs2,
    output  logic [6:0]             funct7,
    output  logic [31:0]            imm32
);
    localparam [6:0] OPC_R = 7'b0110011;
    localparam [6:0] OPC_I = 7'b0010011;
    localparam [6:0] OPC_S = 7'b0100011;
    localparam [6:0] OPC_B = 7'b1100011;
    localparam [6:0] OPC_J = 7'b1101111;
    localparam [6:0] OPC_U = 7'b0110111;

    always_comb begin
        opcode  = ins[6:0];
        rd      = '0;
        funct3  = '0;
        rs1     = '0;
        rs2     = '0;
        funct7  = '0;
        imm32   = '0;
        case (opcode)
            OPC_R: begin
                rd      = ins[11:7];
                funct3  = ins[14:12];
                rs1     = ins[19:15];
                rs2     = ins[24:20];
                funct7  = ins[31:25];
            end

            OPC_I: begin
                rd      = ins[11:7];
                funct3  = ins[14:12];
                rs1     = ins[19:15];
                imm32   = {{20{ins[31]}}, ins[31:20]};
            end

            OPC_S: begin
                funct3  = ins[14:12];
                rs1     = ins[19:15];
                rs2     = ins[24:20];
                imm32   = {{20{ins[31]}}, ins[31:25], ins[11:7]};
            end

            OPC_B: begin
                funct3  = ins[14:12];
                rs1     = ins[19:15];
                rs2     = ins[24:20];
                imm32   = {{19{ins[31]}}, ins[31], ins[7], ins[30:25], ins[11:8], 1'b0};
            end

            OPC_J: begin
                rd      = ins[11:7];
                imm32   = {{11{ins[31]}}, ins[31], ins[19:12], ins[20], ins[30:21], 1'b0};
            end

            OPC_U: begin
                rd      = ins[11:7];
                imm32   = {ins[31:12], {12{1'b0}}};
            end
            
            default: begin
            end
        endcase
    end
    
endmodule
