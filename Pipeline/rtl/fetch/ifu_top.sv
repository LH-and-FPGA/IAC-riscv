module ifu_top #(
  parameter int DATA_WIDTH = 32
)(
    input  logic                    clk,
    input  logic                    rst,

    input  logic [DATA_WIDTH-1:0]   instr_in,

    // Pipeline / hazard control
    input  logic                    StallF,
    input  logic                    StallD,
    input  logic                    FlushD,
    input  logic                    FlushE,

    // Redirect from execute (branch / jump)
    input  logic                    branch,
    input  logic                    jump,
    input  logic                    jalr,

    input  logic [DATA_WIDTH-1:0]   branch_pc,
    input  logic [DATA_WIDTH-1:0]   jalr_pc,

    // Outputs to the rest of the pipeline
    output logic [DATA_WIDTH-1:0]   pc_f, // Testing purpose
    output logic [DATA_WIDTH-1:0]   inc_pc_4_f,
    output logic [DATA_WIDTH-1:0]   pc_d,

    output logic [31:0]             instr_d,
    output logic [31:0]             i_addr
);

localparam NOP = 32'h00000013; // ADDI x0, x0, 0

// Internal fetch stage signals
logic [DATA_WIDTH-1:0] pc_next;
logic [DATA_WIDTH-1:0] pc_cur;
logic [DATA_WIDTH-1:0] inc_pc_4_cur;

// Program counter register
pc_reg #(.DATA_WIDTH(DATA_WIDTH)) u_pc_reg (
  .en      (~StallF),
  .clk     (clk),
  .rst     (rst),
  .next_pc (pc_next),
  .pc      (pc_cur)
);

pc_adder_inc4 #(.DATA_WIDTH(DATA_WIDTH)) u_adder_inc (
  .in  (pc_cur),
  .out (inc_pc_4_cur)
);

// Next PC logic
always_comb begin
  pc_next = inc_pc_4_cur; // Default: PC + 4
  if (branch)     pc_next = branch_pc;
  else if (jump)  pc_next = branch_pc;
  else if (jalr)  pc_next = jalr_pc;
end

// Fetch stage outputs
assign pc_f       = pc_cur;
assign inc_pc_4_f = inc_pc_4_cur;
assign i_addr     = pc_cur;

// IF/ID pipeline register
always_ff @(posedge clk) begin
  if (rst || FlushD) begin
    pc_d         <= '0;
    instr_d      <= NOP;
  end else if (!StallD) begin
    pc_d         <= pc_cur;
    instr_d      <= instr_in;
  end
end

endmodule
