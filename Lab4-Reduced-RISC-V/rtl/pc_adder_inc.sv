module adder_inc4 #(
    parameter DATA_WIDTH = 32
)(
    input   logic en,
    input   logic [DATA_WIDTH-1:0]  in,
    output  logic [DATA_WIDTH-1:0]  out
);

if (en) assign out = in + 4;

endmodule
