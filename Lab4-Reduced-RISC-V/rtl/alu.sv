module alu #(
    parameter DATA_WIDTH = 32
) (
    input   logic [DATA_WIDTH-1:0] a,
    input   logic [DATA_WIDTH-1:0] b,
    input   logic           alu_ctrl,
    output  logic [DATA_WIDTH-1:0] alu_out,
    output logic                  zero_flag
);
    always_comb begin
        case (alu_ctrl)
            4'b000:  alu_out = a + b;
            4'b001:  alu_out = a - b;
            4'b010:  alu_out = a & b;
            4'b011:   alu_out = a | b;
            4'b100:  alu_out = a ^ b;
            4'b101:  alu_out = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            4'b110:  alu_out = a << b[4:0];
            4'b111:  alu_out = a >> b[4:0];
            4'b1000:  alu_out = $signed(a) >>> b[4:0];
            default:  alu_out = '0;
        endcase
    end
    assign zero_flag = (alu_out == 0);

endmodule
