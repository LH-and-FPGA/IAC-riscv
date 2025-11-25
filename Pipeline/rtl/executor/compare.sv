module compare #(
    parameter DATA_WIDTH = 32
) (
    input   logic [DATA_WIDTH-1:0]  a,
    input   logic [DATA_WIDTH-1:0]  b,
    input  logic             sgnd, // 1 for signed compare, 0 for unsigned
    output logic [1:0]       flags // flags = {eq, lt}
);
    logic eq;
    logic lt;
    logic [WIDTH-1:0] af, bf;

    
    assign af = {a[WIDTH-1] ^ sgnd, a[WIDTH-2:0]};
    assign bf = {b[WIDTH-1] ^ sgnd, b[WIDTH-2:0]};


    assign eq = (a == b);
    assign lt = (af < bf);
    assign flags = {eq, lt};
endmodule