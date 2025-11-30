module regfile #(
    parameter DATA_WIDTH = 32,
    parameter REG_NUM = 32,
    parameter ADDR_WIDTH = $clog2(REG_NUM)
) (
    input   logic                   clk,
    input   logic                   rst,
    input   logic                   we,         // write enable
    input   logic [ADDR_WIDTH-1:0]  w_addr,     // rd
    input   logic [ADDR_WIDTH-1:0]  r_addr1,    // rs
    input   logic [ADDR_WIDTH-1:0]  r_addr2,    // rs
    input   logic [DATA_WIDTH-1:0]  w_data,
    output  logic [DATA_WIDTH-1:0]  r_data1,
    output  logic [DATA_WIDTH-1:0]  r_data2,
    output  logic [DATA_WIDTH-1:0]  a0          // For testing, we directly output the result
);
    // REGfile itself
    logic [DATA_WIDTH-1:0] regs [0:REG_NUM-1];

    // sync read
    always_ff @(posedge clk) begin
        if (rst) begin
            for (int i = 0; i < REG_NUM; i++)
                regs[i] <= '0; // all zero
        end else begin
            if (we && (w_addr != '0)) begin
                regs[w_addr] <= w_data;
            end
            regs[0] <= '0;
        end
    end

    // async read, all comb
    always_comb begin
        r_data1 = (r_addr1 == '0) ? '0 : regs[r_addr1];
        r_data2 = (r_addr2 == '0) ? '0 : regs[r_addr2];
        a0      = regs[10];
    end

endmodule
