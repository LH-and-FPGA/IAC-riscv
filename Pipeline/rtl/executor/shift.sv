module shifter #(
    parameter DATA_WIDTH = 32
)(
    input  logic [DATA_WIDTH-1:0] A,      
    input  logic [4:0]      Amt,    // shift amount
    input  logic            Right,  // 1 shift right, 0 shift left
    input  logic            Arith,  // 1 arithmetic shift right, 0 logical
    output logic [DATA_WIDTH-1:0] Y       
);

    always_comb begin
        if (!Right) begin
            // SLL / SLLI
            Y = A << Amt;
        end else begin
            if (Arith)
                // SRA / SRAI
                Y = $signed(A) >>> Amt;
            else
                // SRL / SRLI
                Y = A >> Amt;
        end
    end

endmodule
