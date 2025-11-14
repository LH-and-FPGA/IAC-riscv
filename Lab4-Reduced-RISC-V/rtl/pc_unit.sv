module pc_top #(
    DATA_WIDTH = 32
)(
    input logic en,
    input logic clk,
    input logic rst,
    input logic pc_src,
    input logic imm,
    output logic [DATA_WIDTH-1:0] pc,
)

logic [DATA_WIDTH-1:0] branch_pc;
logic [DATA_WIDTH-1:0] next_pc
logic [DATA_WIDTH-1:0] prev_pc;
logic [DATA_WIDTH-1:0] next_pc;

pc_reg #(.DATA_WIDTH(DATA_WIDTH)) u_pc_reg (
    .en(en),
    .clk(clk),
    .rst(rst),
    .next_pc(next_pc),
    .pc(prev_pc),
);

pc_mux #(.DATA_WIDTH(DATA_WIDTH)) u_pc_mux (
    .pc_src(pc_src),
    .branch_pc(branch_pc),
    .inc_pc (inc_pc),
    .next_pc (next_pc)
);

adder_branch #(.DATA_WIDTH(DATA_WIDTH)) u_adder_branch (
    .en(en),
    .pc(prev_pc)
);

adder_inc4 #(.DATA_WIDTH(DATA_WIDTH)) u_adder_inc (
    .en(en),
    .in(prev_pc),
    .out(inc_pc)
);

endmodule
