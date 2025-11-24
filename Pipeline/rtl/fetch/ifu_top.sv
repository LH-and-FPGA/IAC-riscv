module ifu_top #(
  parameter int DATA_WIDTH = 32,
  parameter int ADDR_WIDTH = 10
)(
    input  logic                    clk,
    input  logic                    rst,

    // Pipeline / hazard control
    input  logic                    StallF,
    input  logic                    StallD,
    // input  logic                    StallE,
    // input  logic                    FlushM,
    // input  logic                    FlushW,
    input  logic                    FlushD,
    input  logic                    FlushE,
    // input  logic                    FlushM,
    // input  logic                    FlushW,
    output logic                    InstrValidD,

    // Redirect from execute (branch / jump / return)
    input  logic                    pc_src,
    input  logic [DATA_WIDTH-1:0]   branch_pc,

    // Interface to centralised bus / I-cache / memory
    output logic                    if_req_valid,
    input  logic                    if_req_ready,
    output logic [ADDR_WIDTH-1:0]   if_req_addr,
    input  logic                    if_resp_valid,
    input  logic [31:0]             if_resp_instr,
    input  logic                    if_resp_error,

    // Outputs to the rest of the pipeline
    output logic [DATA_WIDTH-1:0]   pc_f,
    output logic [DATA_WIDTH-1:0]   inc_pc_4_f,
    output logic [DATA_WIDTH-1:0]   pc_d,
    output logic [DATA_WIDTH-1:0]   inc_pc_4_d,
    output logic [31:0]             instr_d
);

// Internal fetch stage signals
logic [DATA_WIDTH-1:0] pc_next;
logic [DATA_WIDTH-1:0] pc_cur;
logic [DATA_WIDTH-1:0] inc_pc_4_cur;
logic if_fire;

// Program counter register
pc_reg #(.DATA_WIDTH(DATA_WIDTH)) u_pc_reg (
  .en      (if_fire && ~StallF),
  .clk     (clk),
  .rst     (rst),
  .next_pc (pc_next),
  .pc      (pc_cur)
);

pc_adder_inc4 #(.DATA_WIDTH(DATA_WIDTH)) u_adder_inc (
  .in  (pc_cur),
  .out (inc_pc_4_cur)
);

pc_mux #(.DATA_WIDTH(DATA_WIDTH)) u_pc_mux (
  .pc_src    (pc_src),
  .branch_pc (branch_pc),
  .inc_pc    (inc_pc_4_cur),
  .next_pc   (pc_next)
);

// Simple request interface
assign if_req_valid = ~rst & ~StallF;
assign if_req_addr  = pc_cur;

// Fetch stage outputs
assign pc_f       = pc_cur;
assign inc_pc_4_f = inc_pc_4_cur;

// Handshake signal
assign if_fire = if_req_valid & if_req_ready;

// IF/ID pipeline register
always_ff @(posedge clk) begin
  if (rst || FlushD) begin
    pc_d         <= '0;
    inc_pc_4_d   <= '0;
    instr_d      <= '0;
    InstrValidD  <= 1'b0;
  end else if (!StallD && if_resp_valid) begin
    pc_d         <= pc_cur;
    inc_pc_4_d   <= inc_pc_4_cur;
    instr_d      <= if_resp_instr;
    InstrValidD  <= ~if_resp_error;
  end else if (FlushE) begin
    InstrValidD  <= 1'b0;
  end
end

endmodule
