module compare #(
    parameter DATA_WIDTH = 32
) (
    input  logic [DATA_WIDTH-1:0] a,
    input  logic [DATA_WIDTH-1:0] b,
    output logic                  eq,
    output logic                  lt,
    output logic                  ltu
);
    assign eq  = (a == b);
    assign lt  = ($signed(a) < $signed(b));
    assign ltu = (a < b);
endmodule
