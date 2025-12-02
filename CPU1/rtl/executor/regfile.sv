module regfile #(
    parameter DATA_WIDTH = 32
)(
    input  logic             clk,
    input  logic             rst, 
    input  logic             we,          
    input  logic [4:0]       raddr1,      
    input  logic [4:0]       raddr2,      
    input  logic [4:0]       waddr,       
    input  logic [DATA_WIDTH-1:0]  wdata,       
    output logic [DATA_WIDTH-1:0]  rdata1,      
    output logic [DATA_WIDTH-1:0]  rdata2,
    output logic [DATA_WIDTH-1:0]  a0_out    
);

    logic [DATA_WIDTH-1:0] rf [31:0];

    always_ff @(posedge clk) begin
        if(rst) begin
            integer i;
            for (i = 0; i < 32; i++)begin
                 rf[i] <= '0;
            end
        end 
        else if(we && (waddr != 5'd0)) begin
            rf[waddr] <= wdata;
        end
    end

    assign rdata1 = (raddr1 == 5'd0) ? '0 : rf[raddr1];
    assign rdata2 = (raddr2 == 5'd0) ? '0 : rf[raddr2];
    assign a0_out  = rf[5'd10]; 

endmodule
