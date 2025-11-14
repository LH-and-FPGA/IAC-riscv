module controlpath #(
    parameter DATA_WIDTH = 32,
    parameter REG_NUM = 32,
    parameter ADDR_WIDTH = $clog2(REG_NUM) // for regfile
) (
    input logic [DATA_WIDTH-1:0] ins,
    output logic [ADDR_WIDTH-1:0] reg_write,
    output logic [9:0] alu_ctrl,
    output logic alu_src,
    
);
    
endmodule