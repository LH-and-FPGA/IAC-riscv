module datapath (
    input  logic         clk,
    input  logic         rst,

    // instruction + control
    input  logic [31:0]  instr,
    input  logic         regWrite,
    input  logic         memRead,
    input  logic         memWrite,
    input  logic [1:0]   resultSrc,
    input  logic         aluSrc,
    input  logic         aluSrcA_PC,
    input  logic         branch,
    input  logic         jump,
    input  logic         jalr,
    input  logic [4:0]   aluControl,

    // memory IO
    input  logic [31:0]  mem_rdata,
    output logic [31:0]  mem_addr,
    output logic [31:0]  mem_wdata,

    // PC output
    output logic [31:0]  pc
);

    logic [31:0] pcNext;
    logic [31:0] pcPlus4;
    logic [31:0] pcBranch;
    assign pcPlus4 = pc + 32'd4;

    always_ff @(posedge clk or posedge rst) begin
        if(rst) pc <= 32'h0;
        else    pc <= pcNext;
    end

    logic [31:0] rd1, rd2, immExt;

    regfile RF (
        .clk(clk),
        .we(regWrite),
        .rs1(instr[19:15]),
        .rs2(instr[24:20]),
        .rd(instr[11:7]),
        .wd(wbData),
        .rd1(rd1),
        .rd2(rd2)
    );

    extend IMMGEN(
        .instr(instr),
        .immExt(immExt)
    );


    logic [31:0] srcA = aluSrcA_PC ? pc : rd1;
    logic [31:0] srcB = aluSrc ? immExt : rd2;


    logic [31:0] aluResult;
    logic        cmpOut;

    alu ALU(
        .a(srcA),
        .b(srcB),
        .aluControl(aluControl),
        .result(aluResult)
    );

    compare CMP(
        .funct3(instr[14:12]),
        .rs1(rd1),
        .rs2(rd2),
        .taken(cmpOut)
    );


    assign mem_addr  = aluResult;
    assign mem_wdata = rd2;


    logic [31:0] wbData;
    always_comb begin
        case(resultSrc)
            2'b00: wbData = aluResult;
            2'b01: wbData = mem_rdata;
            2'b10: wbData = pcPlus4;
            default: wbData = aluResult;
        endcase
    end


    logic branchTaken = branch & cmpOut;

    always_comb begin
        if (jalr)          pcNext = aluResult & ~32'b1;    // (rs1+imm) & ~1
        else if (jump)     pcNext = pc + immExt;
        else if (branchTaken) pcNext = pc + immExt;
        else               pcNext = pcPlus4;
    end

endmodule

