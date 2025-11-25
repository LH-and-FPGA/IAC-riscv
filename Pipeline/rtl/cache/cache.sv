/*
Cache design:
- Based on the diagram on lecture, 4 way is what we should try
- Based on the diagram, we should try 64 bytes per block
- we should use 32 sets as we are designing 32 bits processer,
- In term of physical memory location, as we are using byte addressing, so the length 
  in general is 32 bits + 2 bits = 34 bits
- we will use PIPT L1 idea

Cache parameters calculation:
- offset_len = log2(64) = 6 bits
- set_len = log2(64) = 6 bits
- tag_len = 34 - 6 - 6 = 22 bits
- we have 64 valid bits
- we have 64 dirty bits
*/

module cache #(
    DATA_WIDTH            = 32,
    PHYSICAL_ADDR_WIDTH   = 34,
    N_WAYS                = 4,
    N_BYTES               = 64,
    N_SETS                = 32,
    OFFSET_LEN            = 6,
    SET_LEN               = 6,
    TAG_LEN               = 22,
    BUS_WIDTH             = 32, // we should assign this value if we want to move to fpag
    CACHE_TYPE            = 0, // 0 means D cache, 1 means I cache
) (
    // general signals
    input logic clk,
    input logic reset,
    input logic stall_stage,
    input logic flush_stage,
    input logic flush_cache, // move dirty data back to memory
    input logic invalidate_cache, // invalidate all cache content, set vaild bits to 0

    // interface with CPU
    input logic [1:0] cache_rw, // 00: read, 01: write
    input logic [PHYSICAL_ADDR_WIDTH-1:0] physical_addr,
    input logic [DATA_WIDTH-1:0] write_data,
    input logic [DATA_WIDTH/8-1:0] byte_mask,

    // Output to CPU
    output logic [DATA_WIDTH-1:0] read_data, // data read from cache to CPU
    output logic cache_miss, // signal to indicate cache miss, sorry for that
    output logic cache_hit, // signal to indicate cache hit, congrats

    output logic cache_committed, // leave me alone, stall signal to CPU, as cache is busy due to bus operation
    output logic cache_stall, // leave me alone, signal to CPU to indicate cache is busy due to flush or invalidate operation

    // Bus interface
    input logic bus_done, // signal from bus to indicate bus operation is done
    input logic [BUS_WIDTH-1:0] bus_fetch_buffer,
    output logic [1:0] bus_rw_require,
    output logic [PHYSICAL_ADDR_WIDTH-1:0] bus_addr
);
    
endmodule