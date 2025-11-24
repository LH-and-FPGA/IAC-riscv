module pc_adder_inc4 #(
    parameter DATA_WIDTH = 32
)(
    input   logic [DATA_WIDTH-1:0]  in,
    output  logic [DATA_WIDTH-1:0]  out
);

assign out = in + 'd4;

endmodule
