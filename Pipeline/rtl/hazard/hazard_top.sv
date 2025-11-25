module hazard_top #(
    DATA_WIDTH = 32,
    ADDR_WIDTH = 32
) (
    input logic bp_exe_wrong,
    input logic div_exe_stall,

    // control hazard
    input logic ifu_fetch_stall,
    input logic lsu_mem_stall,

    output logic StallF, StallD, StallE, StallM, StallW,
    output logic FlushD, FlushE, FlushM, FlushW
);
    
endmodule