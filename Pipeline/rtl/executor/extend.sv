module extend #(
    parameter DATA_WIDTH = 32
)(
    input  logic [31:7] InstrD,     
    input  logic [2:0]  ImmSrcD,    
    output logic [DATA_WIDTH-1:0] ImmExtD 
);

    always_comb begin
        case (ImmSrcD)
            // I-type: imm[11:0] = inst[31:20]
            3'b000: ImmExtD = {{(DATA_WIDTH-12){InstrD[31]}}, InstrD[31:20]};

            // S-type: imm[11:0] = inst[31:25] inst[11:7]
            3'b001: ImmExtD = {{(DATA_WIDTH-12){InstrD[31]}}, InstrD[31:25], InstrD[11:7]};

            // B-type: imm = inst[31], inst[7], inst[30:25], inst[11:8], 0
            3'b010: ImmExtD = {{(DATA_WIDTH-12){InstrD[31]}},
                               InstrD[7],
                               InstrD[30:25],
                               InstrD[11:8],
                               1'b0};

            // J-type (JAL): imm = inst[31], inst[19:12], inst[20], inst[30:21], 0
            3'b011: ImmExtD = {{(DATA_WIDTH-20){InstrD[31]}},
                               InstrD[19:12],
                               InstrD[20],
                               InstrD[30:21],
                               1'b0};

            // U-type: LUI/AUIPC
            3'b100: ImmExtD = {InstrD[31:12], 12'b0};

            default: ImmExtD = {DATA_WIDTH{1'b0}}; 
        endcase
    end

endmodule
