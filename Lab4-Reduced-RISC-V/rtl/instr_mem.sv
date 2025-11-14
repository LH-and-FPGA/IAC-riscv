module instr_mem #(
    parameter DATA_WIDTH = 32,
    parameter ADDRESS_WIDTH = 2,
) (
    input   logic clk,
    input   logic [ADDR_WIDTH-1:0] addr,
    output  logic [DATA_WIDTH-1:0] instr,
);

logic [DATA_WIDTH-1:0] rom_array [2**ADDRESS_WIDTH-1:0];

initial begin
    $readmemh("sinerom.mem", rom_array);
end

always_ff @(posedge clk) begin
    instr <= rom_array[addr];
end

endmodule
