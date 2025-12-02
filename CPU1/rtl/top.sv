module top (
    input  logic        clk,
    input  logic        rst,
    input  logic        trigger,
    output logic [31:0] a0
);
    // Instruction side wires
    logic [31:0] i_addr;
    logic [31:0] i_rdata;
    logic        i_ready;

    // Data side wires
    logic        d_req;
    logic        d_we;
    logic [3:0]  d_wstrb;
    logic [31:0] d_addr;
    logic [31:0] d_wdata;
    logic [31:0] d_rdata;
    logic        d_ready;
    logic        unused_ready;

    cache_system caches (
        .clk,
        .rst,
        .i_addr,
        .i_rdata,
        .i_ready,
        .d_req,
        .d_we,
        .d_wstrb,
        .d_addr,
        .d_wdata,
        .d_rdata,
        .d_ready
    );

    assign unused_ready = i_ready & d_ready;

    cpu1_core core (
        .clk,
        .rst,
        .trigger,
        .i_addr,
        .i_rdata,
        .d_req,
        .d_we,
        .d_wstrb,
        .d_addr,
        .d_wdata,
        .d_rdata,
        .a0
    );
endmodule
