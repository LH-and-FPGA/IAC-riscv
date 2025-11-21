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
logic [7:0] rom_byte [ROM_SIZE-1:0];

initial begin
    $readmemh("rtl/instr_byte.mem", rom_byte);
end

always_comb begin
    // instr <= rom_array[addr[ROM_ADDR_WIDTH+1:2]];
    logic [31:0] word;
    // 小端：最低地址是最低字节，但是目前实现是大端，之后改一下这个mem就可以
    word = { rom_byte[addr+0],
             rom_byte[addr+1],
             rom_byte[addr+2],
             rom_byte[addr+3] };
    instr = word;
end

endmodule
