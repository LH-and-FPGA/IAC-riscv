module lsu_top (
    // Control signals
    input  logic        mem_read, // load
    input  logic        mem_write, // store

    input  logic        fp_load, // floating-point load
    input  logic        fp_store, // floating-point store

    input  logic [2:0]  funct3, // from instruction

    // Address / data inputs
    input  logic [31:0] addr, // effective address
    input  logic [31:0] store_data, // data to store for integer store
    input  logic [31:0] fp_store_data, // data to store for floating-point store
    input  logic [31:0] d_rdata, // data read from data cache/memory

    // Request interface outputs
    output logic        d_req, // data request
    output logic        d_we, // data write enable
    output logic [31:0] d_addr, // data address
    output logic [3:0]  d_wstrb, // data write strobe (1 bit per byte on byte enable)
    output logic [31:0] d_wdata, // data write data

    // Load result
    output logic [31:0] load_data // loaded data
);
    logic [1:0] byte_offset;

    assign byte_offset = addr[1:0];
    assign d_req      = mem_read | mem_write | fp_load | fp_store;
    assign d_we       = mem_write | fp_store;
    assign d_addr     = addr;

    // Store path
    lsu_store u_lsu_store (
        .mem_write    (mem_write),
        .fp_store     (fp_store),
        .funct3       (funct3),
        .byte_offset  (byte_offset),
        .store_data   (store_data),
        .fp_store_data(fp_store_data),
        .d_wstrb      (d_wstrb),
        .d_wdata      (d_wdata)
    );

    // Load path
    lsu_load u_lsu_load (
        .funct3     (funct3),
        .byte_offset(byte_offset),
        .d_rdata    (d_rdata),
        .load_data  (load_data)
    );
endmodule
