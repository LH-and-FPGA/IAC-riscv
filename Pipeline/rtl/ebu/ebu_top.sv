module ebu_top #(
  parameter int DATA_WIDTH = 32,
  parameter int ADDR_WIDTH = 10
) (
    input  logic                    clk,
    input  logic                    rst,

    // // IFU side (instruction fetch)
    // CAN BE EXPANDED IF WE HAVE TIME

    // LSU side (loads/stores)
    input  logic                    ls_req_valid,
    output logic                    ls_req_ready,
    input  logic                    ls_req_we,       // 0 = load, 1 = store
    input  logic [ADDR_WIDTH-1:0]   ls_req_addr,
    input  logic [DATA_WIDTH-1:0]   ls_req_wdata,
    input  logic [DATA_WIDTH/8-1:0] ls_req_be,
    output logic                    ls_resp_valid,
    output logic [DATA_WIDTH-1:0]   ls_resp_rdata,
    output logic                    ls_resp_error

    // Single memory / bus side
    // CAN BE EXPANDED IF WE HAVE TIME
);

// When LSU provides byte addresses, drop the lower 2 bits to index the
// word-wide RAM.
localparam int RAM_ADDR_WIDTH = (ADDR_WIDTH > 2) ? ADDR_WIDTH-2 : 1;

// Assume always hit RAM for now
wire hit_ram  = 1'b1;
wire hit_uart = 1'b0;

// ----- RAM interface -----
logic                    ram_req_valid;
logic                    ram_req_we; // 0 = load, 1 = store
logic [RAM_ADDR_WIDTH-1:0] ram_req_addr; // word address
logic [DATA_WIDTH-1:0]   ram_req_wdata; // data to write
logic [DATA_WIDTH/8-1:0] ram_req_be; // byte enable
logic                    ram_req_ready; // ready to accept request
logic                    ram_resp_valid; // data there？
logic [DATA_WIDTH-1:0]   ram_resp_rdata; // data read
logic                    ram_resp_error;

// UART interface
// TODO: define UART signals

// Demux LSU request to RAM or UART
assign ram_req_valid  = ls_req_valid & hit_ram;
assign ram_req_we     = ls_req_we;
assign ram_req_addr   = ls_req_addr[ADDR_WIDTH-1:2];
assign ram_req_wdata  = ls_req_wdata;
assign ram_req_be     = ls_req_be;

// For now: always ready (single-cycle devices).
// If you later add wait states, you can make this smarter.
assign ls_req_ready = ram_req_ready;

data_ram #(
    .DATA_WIDTH (DATA_WIDTH),
    .ADDR_WIDTH (RAM_ADDR_WIDTH)
    ) u_data_ram (
    .clk,
    .rst,
    .ram_req_valid,
    .ram_req_ready,
    .ram_req_we,
    .ram_req_addr,
    .ram_req_wdata,
    .ram_req_be,
    .ram_resp_valid,
    .ram_resp_rdata,
    .ram_resp_error
);

// Demux response back to LSU
always_comb begin
    ls_resp_valid = 1'b0;
    ls_resp_rdata = '0;
    ls_resp_error = 1'b0;

    if (hit_ram) begin
        ls_resp_valid = ram_resp_valid;
        ls_resp_rdata = ram_resp_rdata;
        ls_resp_error = ram_resp_error;
    end else if (ls_req_valid) begin
        // bad address
        ls_resp_valid = 1'b1;
        ls_resp_error = 1'b1;
    end
end

endmodule
