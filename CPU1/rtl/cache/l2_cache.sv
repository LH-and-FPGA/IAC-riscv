module l2_cache #(
    parameter LINE_BYTES = 64,
    parameter SETS       = 64,
    parameter WAYS       = 8
) (
    input  logic                    clk,
    input  logic                    rst,
    // Line request from upper level (L1 miss)
    input  logic                    upper_req,
    input  logic [31:0]             upper_addr,
    output logic [LINE_BYTES*8-1:0] upper_rline,
    output logic                    upper_ready,
    output logic                    upper_miss,
    // Dirty line writeback from upper level
    input  logic                    upper_wb_req,
    input  logic [31:0]             upper_wb_addr,
    input  logic [LINE_BYTES*8-1:0] upper_wb_line,
    input  logic [LINE_BYTES-1:0]   upper_wb_mask,
    // Backing memory read channel
    output logic                    mem_rd_req,
    output logic [31:0]             mem_rd_addr,
    input  logic [LINE_BYTES*8-1:0] mem_rd_line,
    input  logic                    mem_rd_ready,
    // Backing memory write channel
    output logic                    mem_wr_req,
    output logic [31:0]             mem_wr_addr,
    output logic [LINE_BYTES*8-1:0] mem_wr_line,
    output logic [LINE_BYTES-1:0]   mem_wr_mask,
    input  logic                    mem_wr_ready
);
    localparam LINE_BITS   = LINE_BYTES*8;
    localparam OFFSET_BITS = $clog2(LINE_BYTES);
    localparam INDEX_BITS  = $clog2(SETS);
    localparam TAG_BITS    = 32 - OFFSET_BITS - INDEX_BITS;
    localparam WAY_BITS    = (WAYS == 1) ? 1 : $clog2(WAYS);

    // Address decode for fill address and writeback address
    logic [OFFSET_BITS-1:0] fill_offset, wb_offset;
    logic [INDEX_BITS-1:0]  fill_index, wb_index;
    logic [TAG_BITS-1:0]    fill_tag, wb_tag;
    cache_addr_decode #(.LINE_BYTES(LINE_BYTES), .SETS(SETS)) fill_dec (
        .addr(upper_addr),
        .offset(fill_offset),
        .index(fill_index),
        .tag(fill_tag)
    );
    cache_addr_decode #(.LINE_BYTES(LINE_BYTES), .SETS(SETS)) wb_dec (
        .addr(upper_wb_addr),
        .offset(wb_offset),
        .index(wb_index),
        .tag(wb_tag)
    );

    logic [INDEX_BITS-1:0] active_index;
    assign active_index = upper_req ? fill_index :
                          (upper_wb_req ? wb_index : '0);

    // Ways
    logic [LINE_BITS-1:0] line_out   [WAYS-1:0];
    logic [TAG_BITS-1:0]  tag_out    [WAYS-1:0];
    logic                 valid_out  [WAYS-1:0];
    logic                 dirty_out  [WAYS-1:0];
    logic [LINE_BITS-1:0] write_line [WAYS-1:0];
    logic [TAG_BITS-1:0]  write_tag  [WAYS-1:0];
    logic                 write_val  [WAYS-1:0];
    logic                 write_dir  [WAYS-1:0];
    logic                 write_en   [WAYS-1:0];

    genvar w;
    generate
        for (w = 0; w < WAYS; w = w + 1) begin : ways
            cacheway #(.LINE_BYTES(LINE_BYTES), .SETS(SETS), .TAG_BITS(TAG_BITS)) way (
                .clk, .rst,
                .set_idx(active_index),
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

    // Hit detection for fill and writeback
    logic [WAY_BITS-1:0] fill_hit_way, wb_hit_way;
    logic [WAY_BITS-1:0] victim_way;
    logic fill_hit, wb_hit;
    integer wi;
    always_comb begin
        fill_hit = 1'b0;
        wb_hit   = 1'b0;
        fill_hit_way = '0;
        wb_hit_way   = '0;
        for (wi = 0; wi < WAYS; wi = wi + 1) begin
            if (upper_req && valid_out[wi] && (tag_out[wi] == fill_tag)) begin
                fill_hit = 1'b1;
                fill_hit_way = wi[WAY_BITS-1:0];
            end
            if (upper_wb_req && valid_out[wi] && (tag_out[wi] == wb_tag)) begin
                wb_hit = 1'b1;
                wb_hit_way = wi[WAY_BITS-1:0];
            end
        end
    end

    cache_lru #(.WAYS(WAYS), .SETS(SETS)) lru (
        .clk,
        .rst,
        .set_idx(active_index),
        .update(upper_req | upper_wb_req),
        .hit_way(fill_hit ? fill_hit_way : (wb_hit ? wb_hit_way : victim_way)),
        .victim_way(victim_way)
    );

    // Combinational fill path
    logic [LINE_BITS-1:0] selected_fill_line;
    logic [LINE_BITS-1:0] updated_wb_line;
    integer b;

    function automatic [LINE_BITS-1:0] apply_wmask(
        input [LINE_BITS-1:0] base,
        input [LINE_BITS-1:0] new_line,
        input [LINE_BYTES-1:0] mask
    );
        automatic logic [LINE_BITS-1:0] tmp;
        begin
            tmp = base;
            for (b = 0; b < LINE_BYTES; b = b + 1)
                if (mask[b])
                    tmp[b*8 +: 8] = new_line[b*8 +: 8];
            apply_wmask = tmp;
        end
    endfunction

    always_comb begin
        selected_fill_line = upper_req ?
                             (fill_hit ? line_out[fill_hit_way] : mem_rd_line) :
                             {LINE_BITS{1'b0}};
        updated_wb_line    = upper_wb_mask == {LINE_BYTES{1'b1}} ?
                             upper_wb_line :
                             apply_wmask(line_out[wb_hit_way], upper_wb_line, upper_wb_mask);
    end

    assign upper_rline = selected_fill_line;

    assign upper_miss  = upper_req && !fill_hit;
    assign upper_ready = ~upper_miss | mem_rd_ready;

    assign mem_rd_req  = upper_miss;
    assign mem_rd_addr = upper_addr;

    assign mem_wr_req  = upper_wb_req;
    assign mem_wr_addr = upper_wb_addr;
    assign mem_wr_line = upper_wb_line;
    assign mem_wr_mask = upper_wb_mask;
    /* verilator lint_off UNUSED */
    logic unused_mem_wr_ready;
    assign unused_mem_wr_ready = mem_wr_ready;
    /* verilator lint_on UNUSED */

    // Combine updates from fill and potential writeback hit
    always_comb begin
        for (wi = 0; wi < WAYS; wi = wi + 1) begin
            write_line[wi] = line_out[wi];
            write_tag[wi]  = tag_out[wi];
            write_val[wi]  = valid_out[wi];
            write_dir[wi]  = 1'b0;
            write_en[wi]   = 1'b0;
        end

        if (upper_req && !fill_hit) begin
            write_line[victim_way] = mem_rd_line;
            write_tag[victim_way]  = fill_tag;
            write_val[victim_way]  = 1'b1;
            write_en[victim_way]   = 1'b1;
        end

        // Update cached copy on writeback hit to avoid stale data
        if (upper_wb_req && wb_hit) begin
            write_line[wb_hit_way] = updated_wb_line;
            write_tag[wb_hit_way]  = wb_tag;
            write_val[wb_hit_way]  = 1'b1;
            write_en[wb_hit_way]   = 1'b1;
        end
    end
endmodule
