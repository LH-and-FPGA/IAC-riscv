module alu_decoder #(
    parameter DATA_WIDTH = 32
) (
    input   logic [2:0] funct3,
    input   logic [6:0] funct7,
    input   logic  b5,
    output logic [3:0]  alu_ctrl
);
always_comb begin
        case (funct3)
            3'b000: alu_ctrl = (funct7 == 7'b0000000) ? 4'b0000 : 4'b0001; // ADD or SUB
            3'b111: alu_ctrl = 4'b0010; // AND
            3'b110: alu_ctrl = 4'b0011; // OR
            3'b100: alu_ctrl = 4'b0100; // XOR
            3'b010: alu_ctrl = 4'b0101; // SLT
            3'b001: alu_ctrl = 4'b0110; // SLL
            3'b101: alu_ctrl = (funct7 == 7'b0000000) ? 4'b0111 : 4'b1000; // SRL or SRA
            default: alu_ctrl = 4'b1111; // NOP or undefined
        endcase
    end

    
endmodule
