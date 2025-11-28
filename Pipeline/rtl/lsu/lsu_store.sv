module lsu_store (
    input  logic        mem_write,
    input  logic        fp_store,

    input  logic [2:0]  funct3,

    input  logic [1:0]  byte_offset,

    input  logic [31:0] store_data,
    input  logic [31:0] fp_store_data,
    
    output logic [3:0]  d_wstrb,
    output logic [31:0] d_wdata
);

always_comb begin
    d_wstrb = 4'b0000;
    d_wdata = 32'b0;
    if (mem_write || fp_store) begin
        unique case (funct3)
            3'b000: begin // SB
                d_wstrb = 4'b0001 << byte_offset;
                d_wdata = {4{fp_store ? fp_store_data[7:0] : store_data[7:0]}} << (8 * byte_offset);
            end
            3'b001: begin // SH
                d_wstrb = 4'b0011 << {byte_offset[1], 1'b0};
                d_wdata = {2{fp_store ? fp_store_data[15:0] : store_data[15:0]}} << (8 * {byte_offset[1], 1'b0});
            end
            default: begin // SW
                d_wstrb = 4'b1111;
                d_wdata = fp_store ? fp_store_data : store_data;
            end
        endcase
    end
end

endmodule
