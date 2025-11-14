module adder_branch #(
    parameter DATA_WIDTH = 32
)(
    input   logic en
    input   logic [DATA_WIDTH-1:0]  pc,
    input   logic [DATA_WIDTH-1:0]  imm,
    output  logic [DATA_WIDTH-1:0]  pc_branch
);

if (en) assign pc_branch = pc + imm;

endmodule
