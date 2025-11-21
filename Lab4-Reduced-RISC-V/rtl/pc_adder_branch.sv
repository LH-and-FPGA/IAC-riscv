module pc_adder_branch #(
    parameter DATA_WIDTH = 32
)(
    input   logic en,
    input   logic [DATA_WIDTH-1:0]  pc,
    input   logic [DATA_WIDTH-1:0]  imm,
    output  logic [DATA_WIDTH-1:0]  pc_branch
);

assign pc_branch = en ? pc + imm : pc;

endmodule
