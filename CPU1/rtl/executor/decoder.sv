module decoder (
    input  logic [31:0] instr,
    output logic        regWrite,
    output logic        memRead,
    output logic        memWrite,
    output logic [1:0]  resultSrc,
    output logic        aluSrc,
    output logic        aluSrcA_PC,
    output logic        branch,
    output logic        jump,
    output logic        jalr,
    output logic [4:0]  aluControl,
    output logic [2:0]  funct3_out,
    // not used now
    output logic        useFPU,      
    output logic        fprWrite,    
    output logic        fpuToInt,    
    output logic [4:0]  fpuOp,       
    output logic        fpLoad,      
    output logic        fpStore,     
    output logic        useFpRs1,    
    output logic        useFpRs2,    
    output logic        useMulDiv
);

    localparam ADD    = 5'd0;
    localparam SUB    = 5'd1;
    localparam AND    = 5'd2;
    localparam OR     = 5'd3;
    localparam XOR    = 5'd4;
    localparam SLT    = 5'd5;
    localparam SLTU   = 5'd6;
    localparam SLL    = 5'd7;
    localparam SRL    = 5'd8;
    localparam SRA    = 5'd9;

    localparam MUL    = 5'd12;
    localparam MULH   = 5'd13;
    localparam MULHSU = 5'd14;
    localparam MULHU  = 5'd15;
    localparam DIV    = 5'd16;
    localparam DIVU   = 5'd17;
    localparam REM    = 5'd18;
    localparam REMU   = 5'd19;

    logic[6:0] opcode = instr[6:0];
    logic[2:0] funct3 = instr[14:12];
    logic[6:0] funct7 = instr[31:25];

    assign funct3_out = funct3;

    always_comb begin
        regWrite   = 1'b0;
        memRead    = 1'b0;
        memWrite   = 1'b0;
        resultSrc  = 2'b00;
        aluSrc     = 1'b0;
        aluSrcA_PC = 1'b0;
        branch     = 1'b0;
        jump       = 1'b0;
        jalr       = 1'b0;
        aluControl = ALU_ADD;
        useFPU     = 1'b0;
        fprWrite   = 1'b0;
        fpuToInt   = 1'b0;
        fpuOp      = FPU_ADD;
        fpLoad     = 1'b0;
        fpStore    = 1'b0;
        useFpRs1   = 1'b0;
        useFpRs2   = 1'b0;
        useMulDiv  = 1'b0;

        unique case(opcode)
        // R
        7'b0110011: begin
            regWrite = 1'b1;
            aluSrc   = 1'b0;
            case({funct7,funct3})
                {7'b0000000,3'b000}: aluControl = ADD;
                {7'b0100000,3'b000}: aluControl = SUB;
                {7'b0000000,3'b111}: aluControl = AND;
                {7'b0000000,3'b110}: aluControl = OR;
                {7'b0000000,3'b100}: aluControl = XOR;
                {7'b0000000,3'b010}: aluControl = SLT;
                {7'b0000000,3'b011}: aluControl = SLTU;
                {7'b0000000,3'b001}: aluControl = SLL;
                {7'b0000000,3'b101}: aluControl = SRL;
                {7'b0100000,3'b101}: aluControl = SRA;

                // M-extension
                // ...
                default: aluControl = ALU_ADD;
            endcase
        end

        // I
        7'b0010011: begin
            regWrite = 1'b1;
            aluSrc   = 1'b1;
            case(funct3)
                3'b000: aluControl = ADD;
                3'b010: aluControl = SLT;
                3'b011: aluControl = SLTU;
                3'b100: aluControl = XOR;
                3'b110: aluControl = OR;
                3'b111: aluControl = AND;
                3'b001: aluControl = SLL;
                3'b101: aluControl = funct7[5] ? SRA : SRL;

                default: aluControl = ADD;
            endcase
        end

        7'b0110111: begin // LUI
                regWrite  = 1'b1;
                resultSrc = 2'b11;
                aluSrc    = 1'b1;
            end
            7'b0010111: begin // AUIPC
                regWrite   = 1'b1;
                resultSrc  = 2'b00;
                aluSrc     = 1'b1;
                aluSrcA_PC = 1'b1;
            end
            7'b0000011: begin // Loads
                regWrite   = 1'b1;
                memRead    = 1'b1;
                resultSrc  = 2'b01;
                aluSrc     = 1'b1;
                aluControl = ALU_ADD;
            end
            7'b0100011: begin // Stores
                memWrite   = 1'b1;
                aluSrc     = 1'b1;
                aluControl = ALU_ADD;
            end
            7'b1100011: begin // Branches
                branch     = 1'b1;
                aluControl = ALU_SUB;
            end
            7'b1101111: begin // JAL
                jump       = 1'b1;
                regWrite   = 1'b1;
                resultSrc  = 2'b10;
                aluSrc     = 1'b1;
            end
            7'b1100111: begin // JALR
                jalr       = 1'b1;
                regWrite   = 1'b1;
                resultSrc  = 2'b10;
                aluSrc     = 1'b1;
                aluControl = ALU_ADD;
            end
            default: ; // do nothing
        endcase
    end
endmodule

