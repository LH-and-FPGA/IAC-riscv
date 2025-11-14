module instr_mem #(
    parameter DATA_WIDTH = 32,
    parameter ADDRESS_WIDTH = 32,
    parameter ROM_SIZE = 1024
) (
    input   logic clk,
    input   logic [ADDRESS_WIDTH-1:0] addr,
    output  logic [DATA_WIDTH-1:0] instr
);

localparam int ROM_ADDR_WIDTH = $clog2(ROM_SIZE);
logic [DATA_WIDTH-1:0] rom_array [ROM_SIZE-1:0];

initial begin
    $readmemh("rtl/instr.mem", rom_array);
end

always_ff @(posedge clk) begin
    instr <= rom_array[addr[ROM_ADDR_WIDTH+1:2]];
end

endmodule
