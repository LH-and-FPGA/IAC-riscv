
module ieu #(
    parameter DATA_WIDTH = 32
) (
    input   logic                     clk,
    input   logic                     rst,
    
    input  logic [DATA_WIDTH-1:0] InstrD,         
    input  logic [DATA_WIDTH-1:0] PCE,                    
    input  logic [DATA_WIDTH-1:0] PCLinkE,
  
    // Hazard unit signals
    input  logic              StallD, StallE, StallM, StallW,  // Stall signals from hazard unit
    input  logic              FlushD, FlushE, FlushM, FlushW,

    //IFU                   
    output logic              PCSrcE,  
    output logic [DATA_WIDTH-1:0]    IEUAdrE,   // Memory address 

    // LSU
    output logic [1:0]        MemRWE,                          // Read/write control goes to LSU
    output logic [1:0]        MemRWM, 
    output logic [DATA_WIDTH-1:0] WriteDataM,                      // Write data to LSU
    output logic [2:0]        Funct3M,   

    // Register destinations
    output logic [4:0]        RdE,   
    output logic [4:0]        RdM,  
    output logic [4:0]        RdW, 

    // hazard signal
    output logic              StructuralStallD
);
    logic [2:0] ImmSrcD;
    logic [3:0] ALUCtrlE;
    logic       ALUSrcAE, ALUSrcBE;
    logic       BranchE, JumpE;
    logic       BranchSignedE;
    logic       ALUResultSrcE;

    logic [1:0] ForwardAE, ForwardBE;
    logic [4:0] Rs1D, Rs2D, Rs2E;
    logic [1:0] FlagsE;
    // datapath outputs
    logic [DATA_WIDTH-1:0] ForwardedSrcAE, ForwardedSrcBE;

    logic [DATA_WIDTH-1:0] ReadDataW;
    logic                  RegWriteW;
    logic [2:0]            ResultSrcW;


    controller ctrl (
        .InstrD, .ImmSrcD,
        .ALUCtrlE, .ALUSrcAE, .ALUSrcBE,
        .BranchE, .JumpE, .BranchSignedE,
        .ALUResultSrcE,
        .Rs1D, .Rs2D, .Rs2E,
        .ForwardAE, .ForwardBE,

        .Funct3M,
        .MemRWE, .MemRWM,

        .RdE, .RdM, .RdW,
        .ResultSrcW,
        .StructuralStallD,
        .FlagsE,
        .PCSrcE
    );

    datapath dp (
        .clk, .rst,
        .ImmSrcD, .InstrD, .Rs1D, .Rs2D, .Rs2E,
        .ALUCtrlE, .ALUSrcAE, .ALUSrcBE,
        .BranchSignedE, .JumpE, .ALUResultSrcE,

        .PCE, .PCLinkE,
        .ForwardAE, .ForwardBE,

        .StallE, .StallM, .StallW,
        .FlushE, .FlushM, .FlushW,

        .IEUAdrE,
        .FlagsE,
        .ForwardedSrcAE, .ForwardedSrcBE,

        .RdW,

        .WriteDataM,

        .ReadDataW,
        .RegWriteW,
        .ResultW()
    );
endmodule
