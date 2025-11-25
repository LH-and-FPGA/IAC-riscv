/*
Cache design:
- Based on the diagram on lecture, 4 way is what we should try
- Based on the diagram, we should try 64 bytes per block
- we should use 32 sets as we are designing 32 bits processer,
- In term of physical memory location, as we are using byte addressing, so the length
  in general is 32 bits + 2 bits = 34 bits

Cache parameters calculation:
- offset_len = log2(64) = 6 bits
- set_len = log2(64) = 6 bits
- tag_len = 34 - 6 - 6 = 22 bits
- we have 64 valid bits
- we have 64 dirty bits
*/

module cache #(
    DATA_WIDTH  = 32,
    N_WAYS      = 4,
    N_BYTES     = 64,
    N_SETS      = 32,
    OFFSET_LEN  = 6,
    SET_LEN     = 6,
    TAG_LEN     = 22
) (
    input logic clk,
    input logic reset,
    input logic stall,
    input logic flush,
    input logic 
);
    
endmodule