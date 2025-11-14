module pc_mux #(
    parameter DATA_WIDTH = 32
)(
    input   logic pc_src,
    input   logic [DATA_WIDTH-1:0] branch_pc,
    input   logic [DATA_WIDTH-1:0] inc_pc,
    output  logic [DATA_WIDTH-1:0] next_pc,
);

assign next_pc = pc_src?branch_pc:inc_pc

endmodule
