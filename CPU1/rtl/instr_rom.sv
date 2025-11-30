module instr_rom #(
    parameter ADDR_WIDTH = 32,
    parameter ROM_SIZE = 1024
) (
    input   logic [ADDR_WIDTH-1:0]  addr,
    output  logic [31:0]            instr
);

localparam BYTE_WIDTH = 8;

logic [BYTE_WIDTH-1:0] rom_array [ROM_SIZE-1:0];

initial begin
    $readmemh("instr.mem", rom_array);
end

always_comb begin
    instr = 
    {
        rom_array[addr],
        rom_array[addr+1],
        rom_array[addr+2],
        rom_array[addr+3]
    };
end

// always_comb begin
//     logic [31:0] word;
//     // Assuming little-endian byte order
//     word = 
//     { 
//         rom_array[addr+3],
//         rom_array[addr+2],
//         rom_array[addr+1],
//         rom_array[addr+0] 
//     };
//     instr = word;
// end

endmodule
