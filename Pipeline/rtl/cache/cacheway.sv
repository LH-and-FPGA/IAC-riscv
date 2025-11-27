module cache_way #(
    parameter int DATA_WIDTH            = 32,
    parameter int PHYSICAL_ADDR_WIDTH   = 34,
    parameter int N_WAYS                = 4,
    parameter int N_BYTES               = 64, // bytes per cache line
    parameter int N_SETS                = 32,
    parameter int OFFSET_LEN            = $clog2(N_BYTES),
    parameter int SET_LEN               = $clog2(N_SETS),
    parameter int TAG_LEN               = PHYSICAL_ADDR_WIDTH - OFFSET_LEN - SET_LEN,
    parameter int BUS_WIDTH             = N_BYTES * 8, // must equal cache line width
    parameter int LINE_WIDTH            = N_BYTES * 8,
    parameter int CACHE_TYPE            = 0  // 0 means D cache, 1 means I cache (read-only)
) (
    input logic clk,
    input logic rst,
    input logic en,
    input logic [ADDR_WIDTH-1:0] physical_addr,
    input logic [SET_LEN-1:0] cache_data_set_addr,
    input logic [SET_LEN-1:0] cache_tag_set_addr,
    input logic [LINE_WIDTH-1:0] input_data, // an entire line
    input logic set_valid,
    input  logic set_valid,
    input  logic clear_valid,
    input  logic set_dirty,
    input  logic clear_dirty,

);
    
endmodule