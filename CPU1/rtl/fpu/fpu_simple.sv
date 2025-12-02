/* verilator lint_off SHORTREAL */
/* verilator lint_off WIDTH */
module fpu_simple (
    input  logic [4:0]  op,
    input  logic [31:0] fp_a,
    input  logic [31:0] fp_b,
    input  logic [31:0] int_a,
    output logic [31:0] fp_result,
    output logic [31:0] int_result,
    output logic        write_fp,
    output logic        write_int
);
    localparam FPU_ADD      = 5'd0;
    localparam FPU_SUB      = 5'd1;
    localparam FPU_MUL      = 5'd2;
    localparam FPU_DIV      = 5'd3;
    localparam FPU_SGNJ     = 5'd4;
    localparam FPU_SGNJN    = 5'd5;
    localparam FPU_SGNJX    = 5'd6;
    localparam FPU_CVT_S_W  = 5'd7;
    localparam FPU_CVT_W_S  = 5'd8;
    localparam FPU_MV_X_W   = 5'd9;
    localparam FPU_MV_W_X   = 5'd10;
    localparam FPU_MIN      = 5'd11;
    localparam FPU_MAX      = 5'd12;
    localparam FPU_EQ       = 5'd13;
    localparam FPU_LT       = 5'd14;
    localparam FPU_LE       = 5'd15;

    always_comb begin
        write_fp    = 1'b0;
        write_int   = 1'b0;
        fp_result   = 32'b0;
        int_result  = 32'b0;

        unique case (op)
            FPU_ADD: begin
                fp_result = fp_a + fp_b;
                write_fp = 1'b1;
            end
            FPU_SUB: begin
                fp_result = fp_a - fp_b;
                write_fp = 1'b1;
            end
            FPU_MUL: begin
                fp_result = fp_a * fp_b;
                write_fp = 1'b1;
            end
            FPU_DIV: begin
                fp_result = (fp_b == 0) ? 32'hFFFF_FFFF : fp_a / fp_b;
                write_fp = 1'b1;
            end
            FPU_SGNJ: begin
                fp_result = {fp_b[31], fp_a[30:0]};
                write_fp = 1'b1;
            end
            FPU_SGNJN: begin
                fp_result = {~fp_b[31], fp_a[30:0]};
                write_fp = 1'b1;
            end
            FPU_SGNJX: begin
                fp_result = {fp_a[31] ^ fp_b[31], fp_a[30:0]};
                write_fp = 1'b1;
            end
            FPU_CVT_S_W: begin
                fp_result = int_a;
                write_fp = 1'b1;
            end
            FPU_CVT_W_S: begin
                int_result = fp_a;
                write_int = 1'b1;
            end
            FPU_MV_X_W: begin
                int_result = fp_a;
                write_int = 1'b1;
            end
            FPU_MV_W_X: begin
                fp_result = int_a;
                write_fp = 1'b1;
            end
            FPU_MIN: begin
                fp_result = ($signed(fp_a) <= $signed(fp_b)) ? fp_a : fp_b;
                write_fp = 1'b1;
            end
            FPU_MAX: begin
                fp_result = ($signed(fp_a) >= $signed(fp_b)) ? fp_a : fp_b;
                write_fp = 1'b1;
            end
            FPU_EQ: begin
                int_result = {31'b0, (fp_a == fp_b)};
                write_int = 1'b1;
            end
            FPU_LT: begin
                int_result = {31'b0, ($signed(fp_a) < $signed(fp_b))};
                write_int = 1'b1;
            end
            FPU_LE: begin
                int_result = {31'b0, ($signed(fp_a) <= $signed(fp_b))};
                write_int = 1'b1;
            end
            default: begin
                // no-op
            end
        endcase
    end
endmodule
/* verilator lint_on WIDTH */
/* verilator lint_on SHORTREAL */

// Just hold a place for fpu later
