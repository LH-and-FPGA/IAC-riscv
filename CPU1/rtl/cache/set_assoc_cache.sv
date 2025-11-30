/* verilator lint_off UNOPTFLAT */
// Set-associative cache with writeback and round-robin replacement.
module set_assoc_cache #(
    parameter LINE_BYTES = 64,
    parameter SETS       = 32,
    parameter WAYS       = 4,
    parameter READ_ONLY  = 0
) (
    input  logic                     clk,
    input  logic                     rst,
    input  logic                     req,
    input  logic                     we,
    input  logic [3:0]               wstrb,
    input  logic [31:0]              addr,
    input  logic [31:0]              wdata,
    output logic [31:0]              rdata,
    output logic                     ready,
    output logic                     miss,
    // Bus interface (one line transfer)
    output logic                     bus_req,
    output logic                     bus_we,
    output logic [31:0]              bus_addr,
    output logic [LINE_BYTES*8-1:0]  bus_wline,
    output logic [LINE_BYTES-1:0]    bus_wmask,
    input  logic [LINE_BYTES*8-1:0]  bus_rline,
    input  logic                     bus_ready
);
    localparam LINE_BITS   = LINE_BYTES*8;
    localparam OFFSET_BITS = $clog2(LINE_BYTES);
    localparam INDEX_BITS  = $clog2(SETS);
    localparam TAG_BITS    = 32 - OFFSET_BITS - INDEX_BITS;
    localparam WAY_BITS    = (WAYS == 1) ? 1 : $clog2(WAYS);

    // Decode address
    logic [OFFSET_BITS-1:0] offset;
    logic [INDEX_BITS-1:0]  index;
    logic [TAG_BITS-1:0]    tag;
    cache_addr_decode #(.LINE_BYTES(LINE_BYTES), .SETS(SETS)) decode (
        .addr,
        .offset,
        .index,
        .tag
    );

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
                .set_idx(index),
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

    // LRU / victim select
    logic [WAY_BITS-1:0] hit_way, victim_way;
    logic hit;
    integer wi;
    always_comb begin
        hit = 1'b0;
        hit_way = '0;
        for (wi = 0; wi < WAYS; wi = wi + 1) begin
            if (valid_out[wi] && tag_out[wi] == tag) begin
                hit = 1'b1;
                hit_way = wi[WAY_BITS-1:0];
            end
        end
    end

    cache_lru #(.WAYS(WAYS), .SETS(SETS)) lru (
        .clk,
        .rst,
        .set_idx(index),
        .update(req),
        .hit_way(hit ? hit_way : victim_way),
        .victim_way(victim_way)
    );

    // Read data selection
    logic [LINE_BITS-1:0] selected_line;
    logic [LINE_BITS-1:0] updated_line;
    integer b;

    /* verilator lint_off UNUSED */
    function automatic [LINE_BITS-1:0] apply_write(
        input [LINE_BITS-1:0] line_in,
        input [31:0]          data_in,
        input [3:0]           strb,
        input [OFFSET_BITS-1:0] off
    );
        automatic logic [LINE_BITS-1:0] tmp;
        automatic int byte_base;
        begin
            tmp = line_in;
            byte_base = int'({off[OFFSET_BITS-1:2], 2'b00});
            for (b = 0; b < 4; b = b + 1)
                if (strb[b])
                    tmp[(byte_base + b)*8 +: 8] = data_in[8*b +: 8];
            apply_write = tmp;
        end
    endfunction
    /* verilator lint_on UNUSED */

    logic [LINE_BITS-1:0] miss_line;
    logic miss_int;
    always_comb begin
        selected_line = hit ? line_out[hit_way] : line_out[victim_way];
        updated_line  = selected_line;
        if (we && !READ_ONLY)
            updated_line = apply_write(selected_line, wdata, wstrb, offset);
        miss_line = (we && !READ_ONLY) ? apply_write(bus_rline, wdata, wstrb, offset) : bus_rline;
    end

    logic [OFFSET_BITS-1:2] word_idx;
    logic [LINE_BITS-1:0]   rline_sel;
    assign word_idx = offset[OFFSET_BITS-1:2];
    assign rline_sel = hit ? updated_line : miss_line;
    assign rdata = rline_sel[word_idx*32 +: 32];

    // Write enables default 0
    generate
        for (w = 0; w < WAYS; w = w + 1) begin : wen
            assign write_en[w] = (req && hit && we && !READ_ONLY && (hit_way == w)) ||
                                 (req && !hit && (victim_way == w));
        end
    endgenerate

    // Combinational write inputs
    always_comb begin
        for (wi = 0; wi < WAYS; wi = wi + 1) begin
            write_line[wi] = line_out[wi];
            write_tag[wi]  = tag_out[wi];
            write_val[wi]  = valid_out[wi];
            write_dir[wi]  = dirty_out[wi];
        end
        if (req && hit && !READ_ONLY && we) begin
            write_line[hit_way] = updated_line;
            write_tag[hit_way]  = tag;
            write_val[hit_way]  = 1'b1;
            write_dir[hit_way]  = 1'b1;
        end else if (req && !hit) begin
            write_line[victim_way] = miss_line;
            write_tag[victim_way]  = tag;
            write_val[victim_way]  = 1'b1;
            write_dir[victim_way]  = we && !READ_ONLY;
        end
    end

    // Bus controls for writeback of dirty victim
    assign miss_int = req && !hit;
    assign bus_we    = miss_int && valid_out[victim_way] && dirty_out[victim_way] && !READ_ONLY;
    assign bus_req   = bus_we | miss_int; // request on miss (and writeback if dirty)
    assign bus_addr  = bus_we ? {tag_out[victim_way], index, {OFFSET_BITS{1'b0}}} :
                       {addr[31:OFFSET_BITS], {OFFSET_BITS{1'b0}}};
    assign bus_wline = line_out[victim_way];
    assign bus_wmask = {LINE_BYTES{1'b1}};

    assign ready = ~miss_int | bus_ready;
    assign miss  = miss_int;
endmodule
/* verilator lint_on UNOPTFLAT */
