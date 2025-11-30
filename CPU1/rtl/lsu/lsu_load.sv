module lsu_load (
    input  logic [2:0]  funct3,

    input  logic [1:0]  byte_offset,

    input  logic [31:0] d_rdata,
    
    output logic [31:0] load_data
);

always_comb begin
    logic [7:0]  byte_sel;
    logic [15:0] half_sel;

    case (byte_offset)
        2'b00: byte_sel = d_rdata[7:0];
        2'b01: byte_sel = d_rdata[15:8];
        2'b10: byte_sel = d_rdata[23:16];
        default: byte_sel = d_rdata[31:24];
    endcase

    half_sel = byte_offset[1] ? d_rdata[31:16] : d_rdata[15:0];

    case (funct3)
        3'b000: load_data = {{24{byte_sel[7]}}, byte_sel}; // LB
        3'b001: load_data = {{16{half_sel[15]}}, half_sel}; // LH
        3'b010: load_data = d_rdata; // LW
        3'b100: load_data = {24'b0, byte_sel}; // LBU
        3'b101: load_data = {16'b0, half_sel}; // LHU
        default: load_data = d_rdata;
    endcase
end

endmodule
