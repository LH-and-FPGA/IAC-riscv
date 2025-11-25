module datapath #(
    parameter DATA_WIDTH = 32
)(
    input  logic                     clk,
    input  logic                     rst,

    // Decode stage
    input  logic [2:0]               ImmSrcD,
    input  logic [31:0]              InstrD,
    input  logic [4:0]               Rs1D,
    input  logic [4:0]               Rs2D,
    input  logic [4:0]               Rs2E,

    input  logic [4:0]               RdW,
    // Execute stage control
    input  logic [3:0]               ALUCtrlE, 
    input  logic                     ALUSrcAE,
    input  logic                     ALUSrcBE,
    input  logic                     BranchSignedE,
    input  logic                     JumpE,
    input  logic                     ALUResultSrcE,

    input  logic [DATA_WIDTH-1:0]    PCE,
    input  logic [DATA_WIDTH-1:0]    PCLinkE,

    // Forwarding control
    input  logic [1:0]               ForwardAE,
    input  logic [1:0]               ForwardBE,

    // Stall / Flush
    input  logic                     StallE,
    input  logic                     StallM,
    input  logic                     StallW,
    input  logic                     FlushE,
    input  logic                     FlushM,
    input  logic                     FlushW,

    // ALU outputs to IEU
    output logic [DATA_WIDTH-1:0]    IEUAdrE,
    output logic [1:0]               FlagsE,         // {eq, lt}
    output logic [DATA_WIDTH-1:0]    ForwardedSrcAE,
    output logic [DATA_WIDTH-1:0]    ForwardedSrcBE,

    // Memory stage output
    output logic [DATA_WIDTH-1:0]    WriteDataM,

    // Writeback stage
    input  logic [DATA_WIDTH-1:0]    ReadDataW,
    input  logic                     RegWriteW,
    output logic [DATA_WIDTH-1:0]    ResultW
);

    logic [DATA_WIDTH-1:0] R1D, R2D;
    logic [DATA_WIDTH-1:0] ImmExtD;

    regfile rf(
        .clk(clk),
        .we(RegWriteW),
        .raddr1(Rs1D),
        .raddr2(Rs2D),
        .waddr(RdW),
        .wdata(ResultW),
        .rdata1(R1D),
        .rdata2(R2D)
    );

    extend imm_ext(
        .InstrD(InstrD[31:7]),
        .ImmSrcD(ImmSrcD),
        .ImmExtD(ImmExtD)
    );


    logic [DATA_WIDTH-1:0] R1E, R2E, ImmExtE;

    flopenrc #(DATA_WIDTH) R1Ereg   (clk, rst, FlushE, ~StallE, R1D,     R1E);
    flopenrc #(DATA_WIDTH) R2Ereg   (clk, rst, FlushE, ~StallE, R2D,     R2E);
    flopenrc #(DATA_WIDTH) ImmEreg  (clk, rst, FlushE, ~StallE, ImmExtD, ImmExtE);

    // Forwarding
    logic [DATA_WIDTH-1:0] IEUResultM;

    mux3 #(DATA_WIDTH) fwdA(R1E, ResultW, IEUResultM, ForwardAE, ForwardedSrcAE);
    mux3 #(DATA_WIDTH) fwdB(R2E, ResultW, IEUResultM, ForwardBE, ForwardedSrcBE);

    comparator #(DATA_WIDTH) cmp(
        .a(ForwardedSrcAE),
        .b(ForwardedSrcBE),
        .sgnd(BranchSignedE),
        .flags(FlagsE)
    );

    // ALU Sources
    logic [DATA_WIDTH-1:0] SrcAE, SrcBE;

    mux2 #(DATA_WIDTH) muxA(ForwardedSrcAE, PCE,      ALUSrcAE, SrcAE);
    mux2 #(DATA_WIDTH) muxB(ForwardedSrcBE, ImmExtE,  ALUSrcBE, SrcBE);

    // ALU
    logic [DATA_WIDTH-1:0] ALUResultE;
    logic [DATA_WIDTH-1:0] AltResultE;

    alu ALU(
        .alu_ctrl(ALUCtrlE),
        .a(SrcAE),
        .b(SrcBE),
        .alu_out(ALUResultE)
    );

    assign AltResultE = JumpE ? PCLinkE : ImmExtE;

    // ALUResultSrcE = 0 → ALU，=1 → Jump/Branch
    mux2 #(DATA_WIDTH) res_mux(
        ALUResultE,
        AltResultE,
        ALUResultSrcE,
        IEUAdrE
    );

    // E → M pipeline

    flopenrc #(DATA_WIDTH) IEUResMreg(clk, rst, FlushM, ~StallM, IEUAdrE,       IEUResultM);
    flopenrc #(DATA_WIDTH) WDMreg    (clk, rst, FlushM, ~StallM, ForwardedSrcBE, WriteDataM);

    // M → W pipeline

    flopenrc #(DATA_WIDTH) Wreg(clk, rst, FlushW, ~StallW, IEUResultM, ResultW);

endmodule
