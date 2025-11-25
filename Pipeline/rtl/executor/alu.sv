module alu #(
    parameter DATA_WIDTH = 32
) (
    input   logic [3:0]             alu_ctrl,
    input   logic [DATA_WIDTH-1:0]  a,
    input   logic [DATA_WIDTH-1:0]  b,
    output  logic [DATA_WIDTH-1:0]  alu_out,
    // output  logic                   zero_flag
);
    always_comb begin
        case (alu_ctrl)
            4'b0000:  alu_out = a + b;
            4'b0001:  alu_out = a - b;
            4'b0010:  alu_out = a & b;
            4'b0011:  alu_out = a | b;
            4'b0100:  alu_out = a ^ b;
            4'b0101:  alu_out = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            4'b0110:  alu_out = a << b[4:0];
            4'b0111:  alu_out = a >> b[4:0];
            4'b1000:  alu_out = $signed(a) >>> b[4:0];
            default:  alu_out = '0;
        endcase
    end
    // assign zero_flag = (alu_out == 0);

endmodule
