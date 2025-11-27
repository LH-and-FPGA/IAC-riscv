// Address decoder for set-associative caches.

module cache_addr_decode #(
    parameter LINE_BYTES    = 64,
    parameter SETS          = 32
) (
    input   logic [31:0]                                    addr,
    output  logic [$clog2(LINE_BYTES)-1:0]                  offset,
    output  logic [$clog2(SETS)-1:0]                        index,
    output  logic [31-$clog2(LINE_BYTES)-$clog2(SETS):0]    tag
);
    localparam OFFSET_BITS  = $clog2(LINE_BYTES);
    localparam INDEX_BITS   = $clog2(SETS);

    assign offset = addr[OFFSET_BITS-1:0];
    assign index  = addr[OFFSET_BITS +: INDEX_BITS];
    assign tag    = addr[31:OFFSET_BITS+INDEX_BITS];
endmodule
