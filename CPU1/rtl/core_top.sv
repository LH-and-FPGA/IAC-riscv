module core_top #(
    parameter DATA_WIDTH = 32,
    parameter REG_NUM = 32,
    parameter ADDR_WIDTH = $clog2(REG_NUM)
) (
    input   logic clk,
    input   logic rst,
    input   logic en,
    output  logic [DATA_WIDTH-1:0] a0
);
    logic                   alu_src;
    logic                   reg_write;
    logic                   zero;
    logic                   branch;
    logic [3:0]             alu_ctrl;
    logic [DATA_WIDTH-1:0]  imm32;
    logic [DATA_WIDTH-1:0]  alu_out;
    logic [DATA_WIDTH-1:0]  op1;
    logic [DATA_WIDTH-1:0]  op2;
    logic [DATA_WIDTH-1:0]  alu_operand_b;
    logic [ADDR_WIDTH-1:0]  rd;
    logic [ADDR_WIDTH-1:0]  rs1;
    logic [ADDR_WIDTH-1:0]  rs2;

    // Fetch interface
    logic                   StallF;
    logic                   StallD;
    logic                   FlushD;
    logic                   FlushE;
    logic                   InstrValidD;
    logic [DATA_WIDTH-1:0]  branch_pc;
    logic [DATA_WIDTH-1:0]  pc_f;
    logic [DATA_WIDTH-1:0]  inc_pc_4_f;
    logic [DATA_WIDTH-1:0]  pc_d;
    logic [DATA_WIDTH-1:0]  inc_pc_4_d;
    logic [31:0]            instr_d;
    logic                   if_req_valid;
    logic                   if_req_ready;
    logic [ADDR_WIDTH-1:0] if_req_addr;
    logic                   if_resp_valid;
    logic [31:0]            if_resp_instr;
    logic                   if_resp_error;

    assign StallF = ~en; // hold PC when core is disabled
    assign StallD = ~en;
    assign FlushD = branch & ~zero;
    assign FlushE = 1'b0;

    assign branch_pc    = pc_d + imm32;
    assign alu_operand_b = alu_src ? imm32 : op2;

    controlpath CONTROLPATH(
        .ins(instr_d),
        .alu_ctrl(alu_ctrl),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),
        .imm32(imm32),
        .branch(branch)
    );

    alu #(
        .DATA_WIDTH(DATA_WIDTH)
    ) ALU (
        .alu_ctrl(alu_ctrl),
        .a(op1),
        .b(alu_operand_b),
        .alu_out(alu_out),
        .zero_flag(zero)
    );

    regfile #(
        .DATA_WIDTH(DATA_WIDTH),
        .REG_NUM(REG_NUM),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) REGFILE (
        .clk(clk),
        .rst(rst),
        .we(reg_write & InstrValidD & en),
        .w_addr(rd),
        .r_addr1(rs1),
        .r_addr2(rs2),
        .w_data(alu_out),
        .r_data1(op1),
        .r_data2(op2),
        .a0(a0)
    );

    ifu_top #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) IFU (
        .clk,
        .rst,
        .StallF,
        .StallD,
        .FlushD,
        .FlushE,
        .InstrValidD,
        .pc_src(branch & !zero),
        .branch_pc,
        .if_req_valid,
        .if_req_ready,
        .if_req_addr,
        .if_resp_valid,
        .if_resp_instr,
        .if_resp_error,
        .pc_f,
        .inc_pc_4_f,
        .pc_d,
        .inc_pc_4_d,
        .instr_d
    );

    instr_rom #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .ROM_SIZE(1024)
    ) INSTR_ROM (
        .addr(if_req_addr),
        .instr(if_resp_instr)
    );

    assign if_req_ready  = 1'b1;
    assign if_resp_valid = if_req_valid;
    assign if_resp_error = 1'b0;

    // LSU → EBU (IDLE)
    logic ls_req_valid = 1'b0;
    logic ls_req_we    = 1'b0;
    logic [ADDR_WIDTH-1:0] ls_req_addr  = '0;
    logic [DATA_WIDTH-1:0]   ls_req_wdata = '0;
    logic [DATA_WIDTH/8-1:0] ls_req_be    = '0;
    logic ls_req_ready, ls_resp_valid, ls_resp_error;
    logic [DATA_WIDTH-1:0] ls_resp_rdata;

    ebu_top #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) EBU (
        .clk,
        .rst,
        .ls_req_valid,
        .ls_req_ready,
        .ls_req_we,
        .ls_req_addr,
        .ls_req_wdata,
        .ls_req_be,
        .ls_resp_valid,
        .ls_resp_rdata,
        .ls_resp_error
    );

endmodule
