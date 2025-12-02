module alu #(
    parameter DATA_WIDTH = 32
) (
    input  logic [4:0]             op,
    input  logic [DATA_WIDTH-1:0]  a,
    input  logic [DATA_WIDTH-1:0]  b,
    output logic [DATA_WIDTH-1:0]  result,
    output logic                   cmp_eq,
    output logic                   cmp_lt,
    output logic                   cmp_ltu
);
    assign cmp_eq  = (a == b);
    assign cmp_lt  = ($signed(a) < $signed(b)); 
    assign cmp_ltu = ($unsigned(a) < $unsigned(b));

    typedef enum logic [4:0] {
        ADD    = 5'd0,   
        SUB    = 5'd1,   
        AND    = 5'd2,   
        OR     = 5'd3,   
        XOR    = 5'd4,   

        SLT    = 5'd5,   
        SLTU    = 5'd6,   
        SLL    = 5'd7,   
        SRL    = 5'd8, 
        SRA   = 5'd9,  

        MUX_A = 5'd10,
        MUX_B = 5'd11,

        MUL    = 5'd12,
        MULH   = 5'd13,
        MULHSU = 5'd14,
        MULHU  = 5'd15,
        DIV    = 5'd16,
        DIVU   = 5'd17,
        REM    = 5'd18,
        REMU   = 5'd19 
    } alu_ops_t;

    logic [63:0] mult_s;
    logic [63:0] mult_s_u;
    logic [63:0] mult_u;
    logic [31:0] div_res;
    logic [31:0] rem_res;
    logic [31:0] divu_res;
    logic [31:0] remu_res;
    logic        mul_overflow;

    always_comb begin
        unique case (op)
            ADD:    result = a + b;
            SUB:    result = a - b;
            AND:    result = a & b;
            OR:     result = a | b;
            XOR:    result = a ^ b;
            SLT:    result = {31'b0, ($signed(a) < $signed(b))};
            SLTU:   result = {31'b0, ($unsigned(a) < $unsigned(b))};
            SLL:    result = a << b[4:0];
            SRL:    result = a >> b[4:0];
            SRA:    result = $signed(a) >>> b[4:0];
            MUX_A:  result = a;
            MUX_B:  result = b;
            MUL:    result = '0;
            MULH:   result = '0;
            MULHSU: result = '0;
            MULHU:  result = '0;
            DIV:    result = '0;
            DIVU:   result = '0;
            REM:    result = '0;
            REMU:   result = '0;
            default:    result = 32'b0;
        endcase
    end

endmodule
