// Simple dual-port backing memory that supplies full cache lines and
// initializes contents from program/data hex files.
module backing_memory #(
    parameter LINE_BYTES = 64,
    parameter MEM_BYTES  = 1<<20,
    parameter DATA_BASE  = 32'h00010000,
    parameter PROG_HEX   = "program.hex",
    parameter DATA_HEX   = "data.hex"
) (
    input  logic                    clk,
    // Port 0 (typically L2 I-side)
    input  logic                    rd0_req,
    input  logic [31:0]             rd0_addr,
    output logic [LINE_BYTES*8-1:0] rd0_line,
    output logic                    rd0_ready,
    input  logic                    wr0_req,
    input  logic [31:0]             wr0_addr,
    input  logic [LINE_BYTES*8-1:0] wr0_line,
    input  logic [LINE_BYTES-1:0]   wr0_mask,
    output logic                    wr0_ready,
    // Port 1 (typically L2 D-side)
    input  logic                    rd1_req,
    input  logic [31:0]             rd1_addr,
    output logic [LINE_BYTES*8-1:0] rd1_line,
    output logic                    rd1_ready,
    input  logic                    wr1_req,
    input  logic [31:0]             wr1_addr,
    input  logic [LINE_BYTES*8-1:0] wr1_line,
    input  logic [LINE_BYTES-1:0]   wr1_mask,
    output logic                    wr1_ready
);
    localparam LINE_BITS   = LINE_BYTES*8;
    localparam OFFSET_BITS = $clog2(LINE_BYTES);

    logic [7:0] main_mem [0:MEM_BYTES-1];
    integer i;
    initial begin
        for (i = 0; i < MEM_BYTES; i = i + 1)
            main_mem[i] = 8'h00;
        $readmemh(PROG_HEX, main_mem);
        $readmemh(DATA_HEX, main_mem, DATA_BASE);
    end

    function automatic [LINE_BITS-1:0] mem_read_line(input logic [31:0] base);
        integer b;
        begin
            for (b = 0; b < LINE_BYTES; b = b + 1) begin
                if (base + b < MEM_BYTES)
                    mem_read_line[b*8 +: 8] = main_mem[base + b];
                else
                    mem_read_line[b*8 +: 8] = 8'h00;
            end
        end
    endfunction

    task automatic mem_write_line(
        input logic [31:0]             base,
        input logic [LINE_BITS-1:0]    line,
        input logic [LINE_BYTES-1:0]   mask
    );
        integer b;
        begin
            for (b = 0; b < LINE_BYTES; b = b + 1)
                if (mask[b] && (base + b < MEM_BYTES))
                    main_mem[base + b] <= line[b*8 +: 8];
        end
    endtask

    // Combinational readouts
    assign rd0_line  = rd0_req ? mem_read_line({rd0_addr[31:OFFSET_BITS], {OFFSET_BITS{1'b0}}}) : '0;
    assign rd1_line  = rd1_req ? mem_read_line({rd1_addr[31:OFFSET_BITS], {OFFSET_BITS{1'b0}}}) : '0;
    assign rd0_ready = 1'b1;
    assign rd1_ready = 1'b1;
    assign wr0_ready = 1'b1;
    assign wr1_ready = 1'b1;

    // Writes
    always_ff @(posedge clk) begin
        if (wr0_req)
            mem_write_line({wr0_addr[31:OFFSET_BITS], {OFFSET_BITS{1'b0}}}, wr0_line, wr0_mask);
        if (wr1_req)
            mem_write_line({wr1_addr[31:OFFSET_BITS], {OFFSET_BITS{1'b0}}}, wr1_line, wr1_mask);
    end
endmodule