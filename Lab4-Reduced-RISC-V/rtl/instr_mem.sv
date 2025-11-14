module instr_mem #(
    parameter DATA_WIDTH = 32,
    parameter ADDRESS_WIDTH = 32,
    parameter ROM_SIZE = 1024
) (
    input   logic clk,
    input   logic [ADDRESS_WIDTH-1:0] addr,
    output  logic [DATA_WIDTH-1:0] instr
);

logic [7:0] rom_array [ROM_SIZE-1:0];

initial begin
    $readmemh("instr.mem", rom_array);
end

always_ff @(posedge clk) begin
    instr <= {rom_array[addr+3], rom_array[addr+2], rom_array[addr+1], rom_array[addr]};
end

endmodule
