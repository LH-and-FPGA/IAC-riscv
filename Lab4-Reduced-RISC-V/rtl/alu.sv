module alu #(
    parameter DATA_WIDTH = 32
) (
    input   logic [DATA_WIDTH-1:0] a,
    input   logic [DATA_WIDTH-1:0] b,
    input   logic [6:0]            alu_ctrl,
    output  logic [DATA_WIDTH-1:0] alu_out,
    output logic                  zero_flag
);

    localparam ALU_ADD  = 7'b0000;
    localparam ALU_SUB  = 7'b0001;
    localparam ALU_AND  = 7'b0010;
    localparam ALU_OR   = 7'b0011;
    localparam ALU_XOR  = 7'b0100;
    localparam ALU_SLT  = 7'b0101; 
    localparam ALU_SLL  = 7'b0110; 
    localparam ALU_SRL  = 7'b0111; 
    localparam ALU_SRA  = 7'b1000; 

    always_comb begin
        case (alu_ctrl)
            ALU_ADD:  alu_out = a + b;
            ALU_SUB:  alu_out = a - b;
            ALU_AND:  alu_out = a & b;
            ALU_OR:   alu_out = a | b;
            ALU_XOR:  alu_out = a ^ b;
            ALU_SLT:  alu_out = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            ALU_SLL:  alu_out = a << b[4:0];
            ALU_SRL:  alu_out = a >> b[4:0];
            ALU_SRA:  alu_out = $signed(a) >>> b[4:0];
            default:  alu_out = '0;
        endcase
    end
    assign zero_flag = (alu_out == 0);

endmodule
