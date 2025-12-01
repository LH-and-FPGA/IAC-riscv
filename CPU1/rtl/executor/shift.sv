module shifter #(
    parameter DATA_WIDTH = 32
)(
    input  logic [DATA_WIDTH-1:0] a,      
    input  logic [4:0]            Amt,    
    input  logic [1:0]            dir,     // 0=left,1=right logical,2=right arithmetic
    output logic [DATA_WIDTH-1:0] y      
);

    always_comb begin
        case (dir)
            2'd0: y = a << Amt;
            2'd1: y = a >> Amt;
            default: y = $signed(a) >>> Amt;
        endcase
    end

endmodule
