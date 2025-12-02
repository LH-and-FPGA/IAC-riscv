module fpu_wrapper (
    input  logic        clk,
    input  logic        rst,
    input  logic [4:0]  op,
    input  logic [31:0] fp_a,
    input  logic [31:0] fp_b,
    input  logic [31:0] int_a,
    output logic [31:0] fp_result,
    output logic [31:0] int_result,
    output logic        write_fp,
    output logic        write_int
);
    fpu_simple fpu_u (
        .op,
        .fp_a,
        .fp_b,
        .int_a,
        .fp_result,
        .int_result,
        .write_fp,
        .write_int
    );
    logic unused;
    assign unused = clk ^ rst;
endmodule
