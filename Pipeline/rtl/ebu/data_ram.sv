module data_ram #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10
) (
    input   logic                    clk,
    input   logic                    rst,
    input   logic                    ram_req_valid,
    output  logic                    ram_req_ready,
    input   logic                    ram_req_we,       // 0 = load, 1 = store
    input   logic [ADDR_WIDTH-1:0]   ram_req_addr,
    input   logic [DATA_WIDTH-1:0]   ram_req_wdata,
    input   logic [DATA_WIDTH/8-1:0] ram_req_be, // byte enable
    output  logic                    ram_resp_valid,
    output  logic [DATA_WIDTH-1:0]   ram_resp_rdata,
    output  logic                    ram_resp_error
);

logic [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH-1:0];

assign ram_req_ready = 1'b1;

always_ff @(posedge clk) begin
    if (rst) begin
        ram_resp_valid <= 1'b0;
        ram_resp_error <= 1'b0;
        ram_resp_rdata <= '0;
    end else begin
        ram_resp_valid <= 1'b0;
        ram_resp_error <= 1'b0;

        if (ram_req_valid) begin
            if (ram_req_we) begin
                // Write operation
                for (int i = 0; i < DATA_WIDTH/8; i++) begin
                    if (ram_req_be[i]) begin
                        ram[ram_req_addr][i*8 +: 8] <= ram_req_wdata[i*8 +: 8];
                    end
                end
                ram_resp_valid <= 1'b1;
            end else begin
                // Read operation
                ram_resp_rdata <= ram[ram_req_addr];
                ram_resp_valid <= 1'b1;
                
            end
        end
    end
end

endmodule
