module adder_inc4 #(
    parameter DATA_WIDTH = 32
)(
    input   logic en,
    input   logic [DATA_WIDTH-1:0]  in,
    output  logic [DATA_WIDTH-1:0]  out
);

assign out = en ? in + DATA_WIDTH'd4 : in;

endmodule
