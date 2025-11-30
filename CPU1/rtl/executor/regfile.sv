module regfile #(
    parameter DATA_WIDTH = 32
)(
    input  logic             clk,
    // input  logic             reset, 
    input  logic             we,          
    input  logic [4:0]       raddr1,      
    input  logic [4:0]       raddr2,      
    input  logic [4:0]       waddr,       
    input  logic [DATA_WIDTH-1:0]  wdata,       
    output logic [DATA_WIDTH-1:0]  rdata1,      
    output logic [DATA_WIDTH-1:0]  rdata2       
);

    logic [DATA_WIDTH-1:0] rf [31:0];

    // WRITE (posedge clk)
    always_ff @(posedge clk) begin
        if (we && (waddr != 0))
            rf[waddr] <= wdata;
    end

    // READ
    assign rdata1 = (raddr1 == 0) ? 0 : rf[raddr1];
    assign rdata2 = (raddr2 == 0) ? 0 : rf[raddr2];

endmodule