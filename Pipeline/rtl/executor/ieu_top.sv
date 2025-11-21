
module ieu #(
    parameter DATA_WIDTH = 32
) (
    input   logic                     clk,
    input   logic                     rst,
    
    // ID/EX inputs
    input  logic [DATA_WIDTH-1:0] InstrD,         
    input  logic [DATA_WIDTH-1:0] PCE,                    
    input  logic [DATA_WIDTH-1:0] PCLinkE,  
    input  logic [DATA_WIDTH-1:0] Rs1E,
    input  logic [DATA_WIDTH-1:0] Rs2E,                  // Write data from WB stage
  
    // Hazard unit signals
    input  logic              StallD, StallE, StallM, StallW,  // Stall signals from hazard unit
    input  logic              FlushD, FlushE, FlushM, FlushW,

    //IFU
    output logic              PCSrcE,   
    output logic [DATA_WIDTH-1:0] IEUAdrE, 

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
    logic [2:0] ResultSrcW;

    controller ctrl (
        .InstrD,
        .ImmSrcD,
        .ALUCtrlE,
        .ALUSrcAE, .ALUSrcBE,
        .BranchE, .JumpE,
        .MemRWE, .MemRWM,
        .Funct3M,
        .StructuralStallD
    );

    datapath dp (
        .clk, .rst,
        .InstrD,
        .ImmSrcD,
        .ALUCtrlE,
        .ALUSrcAE, .ALUSrcBE,
        .BranchE, .JumpE,
        .PCE, .PCLinkE,
        .Rs1E, .Rs2E,
        .IEUAdrE, .PCSrcE,
        .RdE, .RdM, .RdW,
        .MemRWE, .MemRWM,
        .WriteDataM
    );
endmodule
