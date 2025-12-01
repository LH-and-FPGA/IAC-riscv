module extend #(
    parameter DATA_WIDTH = 32
) (
    input  logic [31:0]      instr,   
    output logic [DATA_WIDTH-1:0] imm
);

    always_comb begin
        case (instr[6:0])    
            // I-type
            7'b0010011, 7'b0000011, 7'b1100111: 
                imm = {{(DATA_WIDTH-12){instr[31]}}, instr[31:20]};
            // S-type
            7'b0100011:
                imm = {{(DATA_WIDTH-12){instr[31]}}, instr[31:25], instr[11:7]};

            // B
            7'b1100011:
                imm = {{(DATA_WIDTH-13){instr[31]}}, instr[31], instr[7],
                       instr[30:25], instr[11:8], 1'b0};

            // U
            7'b0110111, 7'b0010111: 
                imm = {{(DATA_WIDTH-32){instr[31]}}, instr[31:12], 12'b0};
       
            // J
            7'b1101111:
                imm = {{(DATA_WIDTH-20){instr[31]}}, instr[19:12], instr[20],
                       instr[30:21], 1'b0};

            default:
                imm = {DATA_WIDTH{1'b0}};

        endcase
    end

endmodule

