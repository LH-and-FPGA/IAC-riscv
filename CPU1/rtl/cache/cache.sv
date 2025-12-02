// Shared set-associative cache core used by cache wrappers (L1/L2/L3).
module cache #(
    parameter LINE_BYTES = 64,
    parameter SETS       = 32,
    parameter WAYS       = 4,
    parameter LINE_BITS  = LINE_BYTES*8,
    parameter TAG_BITS   = 32 - $clog2(LINE_BYTES) - $clog2(SETS),
    parameter WAY_BITS   = (WAYS == 1) ? 1 : $clog2(WAYS)
) (
    input  logic                     clk,
    input  logic                     rst,
    input  logic [$clog2(SETS)-1:0]  set_idx,
    // Replacement state
    input  logic                     lru_update,
    input  logic [WAY_BITS-1:0]      lru_hit_way,
    output logic [WAY_BITS-1:0]      victim_way,
    // Storage write port (one set per cycle, per-way enables)
    input  logic [LINE_BITS-1:0]     write_line [WAYS-1:0],
    input  logic [TAG_BITS-1:0]      write_tag  [WAYS-1:0],
    input  logic                     write_val  [WAYS-1:0],
    input  logic                     write_dir  [WAYS-1:0],
    input  logic                     write_en   [WAYS-1:0],
    // Current set readback
    output logic [LINE_BITS-1:0]     line_out   [WAYS-1:0],
    output logic [TAG_BITS-1:0]      tag_out    [WAYS-1:0],
    output logic                     valid_out  [WAYS-1:0],
    output logic                     dirty_out  [WAYS-1:0]
);
    genvar w;
    generate
        for (w = 0; w < WAYS; w = w + 1) begin : ways
            cacheway #(.LINE_BYTES(LINE_BYTES), .SETS(SETS), .TAG_BITS(TAG_BITS)) way (
                .clk, .rst,
                .set_idx(set_idx),
                .write_en(write_en[w]),
                .line_in(write_line[w]),
                .tag_in(write_tag[w]),
                .valid_in(write_val[w]),
                .dirty_in(write_dir[w]),
                .line_out(line_out[w]),
                .tag_out(tag_out[w]),
                .valid_out(valid_out[w]),
                .dirty_out(dirty_out[w])
            );
        end
    endgenerate

    cache_lru #(.WAYS(WAYS), .SETS(SETS)) lru (
        .clk,
        .rst,
        .set_idx(set_idx),
        .update(lru_update),
        .hit_way(lru_hit_way),
        .victim_way(victim_way)
    );
endmodule
