// Simple hazard unit for forwarding, load-use stall, and flush generation.
/* verilator lint_off DECLFILENAME */
module hazard_unit (
    // Execute stage info
    input  logic        ctrlE_memRead,
    input  logic        ctrlE_regWrite,
    input  logic        ctrlE_jump,
    input  logic        ctrlE_jalr,
    input  logic [4:0]  rdE,
    input  logic [4:0]  rs1D,
    input  logic [4:0]  rs2D,
    input  logic        takeBranchE,
    // Memory/Writeback for forwarding
    input  logic        ctrlM_regWrite,
    input  logic [4:0]  rdM,
    input  logic        ctrlW_regWrite,
    input  logic [4:0]  rdW,
    input  logic [4:0]  rs1E,
    input  logic [4:0]  rs2E,
    output logic [1:0]  forwardA,
    output logic [1:0]  forwardB,
    output logic        stallF,
    output logic        stallD,
    output logic        flushD
);
    // Forwarding decisions
    always_comb begin
        forwardA = 2'b00;
        forwardB = 2'b00;
        if (ctrlM_regWrite && (rdM != 5'd0) && (rdM == rs1E)) forwardA = 2'b10;
        else if (ctrlW_regWrite && (rdW != 5'd0) && (rdW == rs1E)) forwardA = 2'b01;

        if (ctrlM_regWrite && (rdM != 5'd0) && (rdM == rs2E)) forwardB = 2'b10;
        else if (ctrlW_regWrite && (rdW != 5'd0) && (rdW == rs2E)) forwardB = 2'b01;
    end

    // Load-use hazard stall
    assign stallF = (ctrlE_memRead && ctrlE_regWrite &&
                    ((rdE != 5'd0) && ((rdE == rs1D) || (rdE == rs2D))));
    assign stallD = stallF;

    // Flush decode on branch/jump
    assign flushD = takeBranchE | ctrlE_jump | ctrlE_jalr;
endmodule
/* verilator lint_on DECLFILENAME */

// Simple floating-point register file. Mirrors integer regfile behavior but
// without the a0 observation port.
module fregfile #(
    parameter DATA_WIDTH = 32
)(
    input  logic                   clk,
    input  logic                   rst,
    input  logic                   we,
    input  logic [4:0]             raddr1,
    input  logic [4:0]             raddr2,
    input  logic [4:0]             waddr,
    input  logic [DATA_WIDTH-1:0]  wdata,
    output logic [DATA_WIDTH-1:0]  rdata1,
    output logic [DATA_WIDTH-1:0]  rdata2
);
    logic [DATA_WIDTH-1:0] rf [31:0];

    always_ff @(posedge clk) begin
        if (rst) begin
            integer i;
            for (i = 0; i < 32; i++) begin
                rf[i] <= '0;
            end
        end else if (we && (waddr != 5'd0)) begin
            rf[waddr] <= wdata;
        end
    end

    assign rdata1 = (raddr1 == 5'd0) ? '0 : rf[raddr1];
    assign rdata2 = (raddr2 == 5'd0) ? '0 : rf[raddr2];
endmodule
