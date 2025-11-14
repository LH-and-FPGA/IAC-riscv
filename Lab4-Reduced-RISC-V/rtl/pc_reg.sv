module pc_reg #(
    parameter DATA_WIDTH = 32
) (
    input   logic en,
    input   logic clk,
    input   logic rst,
    input   logic [DATA_WIDTH-1:0] next_pc,
    output  logic [DATA_WIDTH-1:0] pc,
);

always_ff @(posedge clk)
    if (rst)        pc <= '0;
    else if (en)    pc <= next_pc;

endmodule
