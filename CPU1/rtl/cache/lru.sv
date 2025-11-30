// Simple round-robin replacement (acts like LRU for single access stream).
module cache_lru #(
    parameter WAYS = 4,
    parameter SETS = 32
) (
    input  logic                        clk,
    input  logic                        rst,
    input  logic [$clog2(SETS)-1:0]     set_idx,
    input  logic                        update,
    input  logic [$clog2(WAYS)-1:0]     hit_way,
    output logic [$clog2(WAYS)-1:0]     victim_way
);
    logic [$clog2(WAYS)-1:0] ptr[SETS-1:0];
    integer i;

    always_ff @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < SETS; i = i + 1)
                ptr[i] <= '0;
        end else if (update) begin
            ptr[set_idx] <= hit_way + 1'b1;
        end
    end

    assign victim_way = ptr[set_idx];
endmodule
