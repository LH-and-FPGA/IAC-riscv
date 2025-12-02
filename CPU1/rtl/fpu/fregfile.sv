module fregfile (
    input  logic        clk,
    input  logic        rst,
    input  logic        we,
    input  logic [4:0]  waddr,
    input  logic [31:0] wdata,
    input  logic [4:0]  raddr1,
    input  logic [4:0]  raddr2,
    output logic [31:0] rdata1,
    output logic [31:0] rdata2
);
    logic [31:0] regs[31:0];

    integer i;
    always_ff @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1) begin
                regs[i] <= 32'b0;
            end
        end else if (we) begin
            regs[waddr] <= wdata;
        end
    end

    always_comb begin
        rdata1 = regs[raddr1];
        rdata2 = regs[raddr2];
    end
endmodule
