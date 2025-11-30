// Cache subsystem wrapper: L1 I/D (4-way, 32 sets, 64B) on top of an L2 cache
// layer and a shared backing memory.

module cache_system #(
    parameter LINE_BYTES = 64,
    parameter SETS       = 32,
    parameter WAYS       = 4,
    parameter L2_SETS    = 64,
    parameter L2_WAYS    = 8,
    parameter MEM_BYTES  = 1<<20,
    parameter DATA_BASE  = 32'h00010000,
    parameter PROG_HEX   = "program.hex",
    parameter DATA_HEX   = "data.hex"
) (
    input  logic        clk,
    input  logic        rst,
    // Instruction side
    input  logic [31:0] i_addr,
    output logic [31:0] i_rdata,
    output logic        i_ready,
    // Data side
    input  logic        d_req,
    input  logic        d_we,
    input  logic [3:0]  d_wstrb,
    input  logic [31:0] d_addr,
    input  logic [31:0] d_wdata,
    output logic [31:0] d_rdata,
    output logic        d_ready
);
    localparam LINE_BITS = LINE_BYTES*8;

    // L1 I$
    /* verilator lint_off UNUSED */
    logic                     l1i_bus_req, l1i_bus_we;
    logic [31:0]              l1i_bus_addr;
    logic [LINE_BITS-1:0]     l1i_bus_wline;
    logic [LINE_BYTES-1:0]    l1i_bus_wmask;
    logic                     l1i_miss_unused;
    /* verilator lint_on UNUSED */
    logic [LINE_BITS-1:0]     l1i_bus_rline;
    logic                     l1i_bus_ready;

    set_assoc_cache #(
        .LINE_BYTES(LINE_BYTES),
        .SETS(SETS),
        .WAYS(WAYS),
        .READ_ONLY(1)
    ) l1_icache (
        .clk,
        .rst,
        .req(1'b1),
        .we(1'b0),
        .wstrb(4'b0),
        .addr(i_addr),
        .wdata(32'b0),
        .rdata(i_rdata),
        .ready(i_ready),
        .miss(l1i_miss_unused),
        .bus_req(l1i_bus_req),
        .bus_we(l1i_bus_we),
        .bus_addr(l1i_bus_addr),
        .bus_wline(l1i_bus_wline),
        .bus_wmask(l1i_bus_wmask),
        .bus_rline(l1i_bus_rline),
        .bus_ready(l1i_bus_ready)
    );

    // L1 D$
    /* verilator lint_off UNUSED */
    logic                     l1d_bus_req;
    logic                     l1d_miss_unused;
    /* verilator lint_on UNUSED */
    logic                     l1d_bus_we;
    logic [31:0]              l1d_bus_addr;
    logic [LINE_BITS-1:0]     l1d_bus_wline, l1d_bus_rline;
    logic [LINE_BYTES-1:0]    l1d_bus_wmask;
    logic                     l1d_bus_ready;

    set_assoc_cache #(
        .LINE_BYTES(LINE_BYTES),
        .SETS(SETS),
        .WAYS(WAYS),
        .READ_ONLY(0)
    ) l1_dcache (
        .clk,
        .rst,
        .req(d_req),
        .we(d_we),
        .wstrb(d_wstrb),
        .addr(d_addr),
        .wdata(d_wdata),
        .rdata(d_rdata),
        .ready(d_ready),
        .miss(l1d_miss_unused),
        .bus_req(l1d_bus_req),
        .bus_we(l1d_bus_we),
        .bus_addr(l1d_bus_addr),
        .bus_wline(l1d_bus_wline),
        .bus_wmask(l1d_bus_wmask),
        .bus_rline(l1d_bus_rline),
        .bus_ready(l1d_bus_ready)
    );

    // L2 I$
    /* verilator lint_off UNUSED */
    logic l2i_miss_unused;
    /* verilator lint_on UNUSED */
    logic l2i_mem_rd_req, l2i_mem_wr_req;
    logic [31:0] l2i_mem_rd_addr, l2i_mem_wr_addr;
    logic [LINE_BITS-1:0] l2i_mem_rd_line, l2i_mem_wr_line;
    logic [LINE_BYTES-1:0] l2i_mem_wr_mask;
    logic l2i_mem_rd_ready, l2i_mem_wr_ready;

    l2_cache #(
        .LINE_BYTES(LINE_BYTES),
        .SETS(L2_SETS),
        .WAYS(L2_WAYS)
    ) l2_icache (
        .clk,
        .rst,
        .upper_req(l1i_bus_req),
        .upper_addr(i_addr),
        .upper_rline(l1i_bus_rline),
        .upper_ready(l1i_bus_ready),
        .upper_miss(l2i_miss_unused),
        .upper_wb_req(l1i_bus_we),
        .upper_wb_addr(l1i_bus_addr),
        .upper_wb_line(l1i_bus_wline),
        .upper_wb_mask(l1i_bus_wmask),
        .mem_rd_req(l2i_mem_rd_req),
        .mem_rd_addr(l2i_mem_rd_addr),
        .mem_rd_line(l2i_mem_rd_line),
        .mem_rd_ready(l2i_mem_rd_ready),
        .mem_wr_req(l2i_mem_wr_req),
        .mem_wr_addr(l2i_mem_wr_addr),
        .mem_wr_line(l2i_mem_wr_line),
        .mem_wr_mask(l2i_mem_wr_mask),
        .mem_wr_ready(l2i_mem_wr_ready)
    );

    // L2 D$
    /* verilator lint_off UNUSED */
    logic l2d_miss_unused;
    /* verilator lint_on UNUSED */
    logic l2d_mem_rd_req, l2d_mem_wr_req;
    logic [31:0] l2d_mem_rd_addr, l2d_mem_wr_addr;
    logic [LINE_BITS-1:0] l2d_mem_rd_line, l2d_mem_wr_line;
    logic [LINE_BYTES-1:0] l2d_mem_wr_mask;
    logic l2d_mem_rd_ready, l2d_mem_wr_ready;

    l2_cache #(
        .LINE_BYTES(LINE_BYTES),
        .SETS(L2_SETS),
        .WAYS(L2_WAYS)
    ) l2_dcache (
        .clk,
        .rst,
        .upper_req(l1d_bus_req),
        .upper_addr(d_addr),
        .upper_rline(l1d_bus_rline),
        .upper_ready(l1d_bus_ready),
        .upper_miss(l2d_miss_unused),
        .upper_wb_req(l1d_bus_we),
        .upper_wb_addr(l1d_bus_addr),
        .upper_wb_line(l1d_bus_wline),
        .upper_wb_mask(l1d_bus_wmask),
        .mem_rd_req(l2d_mem_rd_req),
        .mem_rd_addr(l2d_mem_rd_addr),
        .mem_rd_line(l2d_mem_rd_line),
        .mem_rd_ready(l2d_mem_rd_ready),
        .mem_wr_req(l2d_mem_wr_req),
        .mem_wr_addr(l2d_mem_wr_addr),
        .mem_wr_line(l2d_mem_wr_line),
        .mem_wr_mask(l2d_mem_wr_mask),
        .mem_wr_ready(l2d_mem_wr_ready)
    );

    // Shared backing memory providing full-line reads/writes
    backing_memory #(
        .LINE_BYTES(LINE_BYTES),
        .MEM_BYTES(MEM_BYTES),
        .DATA_BASE(DATA_BASE),
        .PROG_HEX(PROG_HEX),
        .DATA_HEX(DATA_HEX)
    ) backing_mem (
        .clk,
        .rd0_req(l2i_mem_rd_req),
        .rd0_addr(l2i_mem_rd_addr),
        .rd0_line(l2i_mem_rd_line),
        .rd0_ready(l2i_mem_rd_ready),
        .wr0_req(l2i_mem_wr_req),
        .wr0_addr(l2i_mem_wr_addr),
        .wr0_line(l2i_mem_wr_line),
        .wr0_mask(l2i_mem_wr_mask),
        .wr0_ready(l2i_mem_wr_ready),
        .rd1_req(l2d_mem_rd_req),
        .rd1_addr(l2d_mem_rd_addr),
        .rd1_line(l2d_mem_rd_line),
        .rd1_ready(l2d_mem_rd_ready),
        .wr1_req(l2d_mem_wr_req),
        .wr1_addr(l2d_mem_wr_addr),
        .wr1_line(l2d_mem_wr_line),
        .wr1_mask(l2d_mem_wr_mask),
        .wr1_ready(l2d_mem_wr_ready)
    );
endmodule
