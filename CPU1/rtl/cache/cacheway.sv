// Single way storage for a set-associative cache (data, tag, valid, dirty).
module cacheway #(
    parameter LINE_BYTES = 64,
    parameter SETS       = 32,
    parameter TAG_BITS   = 21  // 32 - log2(LINE_BYTES) - log2(SETS)
) (
    input  logic                        clk,
    input  logic                        rst,
    input  logic [$clog2(SETS)-1:0]     set_idx,
    input  logic                        write_en,
    input  logic [LINE_BYTES*8-1:0]     line_in,
    input  logic [TAG_BITS-1:0]         tag_in,
    input  logic                        valid_in,
    input  logic                        dirty_in,
    output logic [LINE_BYTES*8-1:0]     line_out,
    output logic [TAG_BITS-1:0]         tag_out,
    output logic                        valid_out,
    output logic                        dirty_out
);
    localparam LINE_BITS = LINE_BYTES*8;

    logic [LINE_BITS-1:0] lines [SETS-1:0];
    logic [TAG_BITS-1:0]  tags  [SETS-1:0];
    logic                 valids[SETS-1:0];
    logic                 dirty [SETS-1:0];

    integer i;
    always_ff @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < SETS; i = i + 1) begin
                lines[i]  <= '0;
                tags[i]   <= '0;
                valids[i] <= 1'b0;
                dirty[i]  <= 1'b0;
            end
        end else if (write_en) begin
            lines[set_idx]  <= line_in;
            tags[set_idx]   <= tag_in;
            valids[set_idx] <= valid_in;
            dirty[set_idx]  <= dirty_in;
        end
    end

    assign line_out  = lines[set_idx];
    assign tag_out   = tags[set_idx];
    assign valid_out = valids[set_idx];
    assign dirty_out = dirty[set_idx];
endmodule
