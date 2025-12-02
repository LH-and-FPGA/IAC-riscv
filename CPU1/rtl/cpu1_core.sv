module cpu1_core (
    input  logic        clk,
    input  logic        rst,
    input  logic        trigger,  // reserved for future use / debugging
    // Instruction cache interface
    output logic [31:0] i_addr,
    input  logic [31:0] i_rdata,
    // Data cache interface
    output logic        d_req,
    output logic        d_we,
    output logic [3:0]  d_wstrb,
    output logic [31:0] d_addr,
    output logic [31:0] d_wdata,
    input  logic [31:0] d_rdata,
    // Observability
    output logic [31:0] a0
);
    // Result selectors
    localparam RES_ALU = 2'b00;
    localparam RES_MEM = 2'b01;
    localparam RES_PC4 = 2'b10;
    localparam RES_IMM = 2'b11;

    // Pipeline control structure
    typedef struct packed {
        logic        regWrite;
        logic        memRead;
        logic        memWrite;
        logic [1:0]  resultSrc;
        logic        aluSrc;
        logic        aluSrcA_PC;
        logic        branch;
        logic        jump;
        logic        jalr;
        logic [4:0]  aluControl;
        logic [2:0]  funct3;
        logic        useFPU;
        logic        fprWrite;
        logic        fpuToInt;
        logic [4:0]  fpuOp;
        logic        fpLoad;
        logic        fpStore;
        logic        useFpRs1;
        logic        useFpRs2;
        logic        useMulDiv;
    } ctrl_t;

    logic unused_trigger;

    // IF stage
    logic [31:0] pcF, pcNext, pcPlus4F;
    logic [31:0] inc_pc_4_d_unused;
    logic        stallF, stallD, flushD;
    assign unused_trigger = trigger;

    // ID stage
    logic [31:0] pcD, instrD, immD;
    logic [4:0]  rs1D, rs2D, rdD;
    ctrl_t       ctrlD;
    logic [31:0] rs1ValRegD, rs2ValRegD;
    logic [31:0] rs1ValD, rs2ValD;
    logic [31:0] fpRs1ValD, fpRs2ValD;

    // EX stage
    logic [31:0] pcE, immE;
    logic [4:0]  rs1E, rs2E, rdE;
    ctrl_t       ctrlE;
    logic [31:0] rs1ValE, rs2ValE;
    logic [31:0] fpRs1ValE, fpRs2ValE;
    logic [31:0] srcARegE, srcBRegE;
    logic [31:0] aluSrcA, aluSrcB;
    logic [31:0] aluResultE;
    logic [31:0] pcPlus4E;
    logic [31:0] branchTargetE, jalrTargetE;
    logic        takeBranchE;
    logic [1:0]  forwardA, forwardB;
    logic        cmp_eq, cmp_lt, cmp_ltu;
    logic [31:0] fpuFpResE, fpuIntResE;
    logic        fpuWriteFpE, fpuWriteIntE;

    // MEM stage
    logic [31:0] pcPlus4M, immM;
    logic [4:0]  rdM;
    ctrl_t       ctrlM;
    logic [31:0] aluResultM;
    logic [31:0] storeDataM, fpStoreDataM;
    logic [31:0] fpuFpResM, fpuIntResM;
    logic [31:0] loadDataM;

    // WB stage
    logic [31:0] pcPlus4W, immW;
    logic [4:0]  rdW;
    /* verilator lint_off UNUSED */
    ctrl_t       ctrlW;
    /* verilator lint_on UNUSED */
    logic [31:0] aluResultW;
    logic [31:0] loadDataW;
    logic [31:0] fpuFpResW, fpuIntResW;
    logic [31:0] resultW;

    logic unused_ifu_pc;
    assign unused_ifu_pc = |pcF;
    // Register files
    regfile xregs (
        .clk,
        .rst,
        .we(ctrlW.regWrite || ctrlW.fpuToInt),
        .waddr(rdW),
        .wdata(ctrlW.fpuToInt ? fpuIntResW : resultW),
        .raddr1(rs1D),
        .raddr2(rs2D),
        .rdata1(rs1ValRegD),
        .rdata2(rs2ValRegD),
        .a0_out(a0)
    );

    fregfile fregs (
        .clk,
        .rst,
        .we(ctrlW.fprWrite),
        .waddr(rdW),
        .wdata(ctrlW.fpLoad ? loadDataW : fpuFpResW),
        .raddr1(rs1D),
        .raddr2(rs2D),
        .rdata1(fpRs1ValD),
        .rdata2(fpRs2ValD)
    );

    // FPU
    fpu_simple fpu (
        .op(ctrlE.fpuOp),
        .fp_a(fpRs1ValE),
        .fp_b(fpRs2ValE),
        .int_a(srcARegE),
        .fp_result(fpuFpResE),
        .int_result(fpuIntResE),
        .write_fp(fpuWriteFpE),
        .write_int(fpuWriteIntE)
    );
    logic unused_fpu_write;
    assign unused_fpu_write = fpuWriteFpE | fpuWriteIntE;

    // IFU instance (wrapped with pc_reg/pc_mux/pc_adder_inc4)
    ifu_top ifu_i (
        .clk,
        .rst,
        .StallF(stallF),
        .StallD(stallD),
        .FlushD(flushD),
        .pc_next_override(pcNext),
        .instrF_in(i_rdata),
        .pc_f(pcF),
        .inc_pc_4_f(pcPlus4F),
        .pc_d(pcD),
        .inc_pc_4_d(inc_pc_4_d_unused),
        .instr_d(instrD),
        .i_addr(i_addr)
    );

    // Immediate generation
    function automatic [31:0] immGen(input logic [31:0] instr);
        logic [31:0] imm;
        begin
            case (instr[6:0])
                7'b0010011, 7'b0000011, 7'b1100111: // I-type
                    imm = {{20{instr[31]}}, instr[31:20]};
                7'b0100011: // S-type
                    imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};
                7'b1100011: // B-type
                    imm = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
                7'b0110111, 7'b0010111: // U-type
                    imm = {instr[31:12], 12'b0};
                7'b1101111: // J-type
                    imm = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
                default:
                    imm = 32'b0;
            endcase
            immGen = imm;
        end
    endfunction

    // Decode stage
    assign rs1D    = instrD[19:15];
    assign rs2D    = instrD[24:20];
    assign rdD     = instrD[11:7];
    assign immD    = immGen(instrD);

    // Simple bypass from writeback stage into decode to cover read-after-write in the same cycle
    always_comb begin
        rs1ValD = rs1ValRegD;
        rs2ValD = rs2ValRegD;
        if (ctrlW.regWrite && (rdW != 5'd0) && (rdW == rs1D))
            rs1ValD = ctrlW.fpuToInt ? fpuIntResW : resultW;
        if (ctrlW.regWrite && (rdW != 5'd0) && (rdW == rs2D))
            rs2ValD = ctrlW.fpuToInt ? fpuIntResW : resultW;
    end

    // Decoder drives ctrlD signals
    decoder dec_i (
        .instr(instrD),
        .regWrite(ctrlD.regWrite),
        .memRead(ctrlD.memRead),
        .memWrite(ctrlD.memWrite),
        .resultSrc(ctrlD.resultSrc),
        .aluSrc(ctrlD.aluSrc),
        .aluSrcA_PC(ctrlD.aluSrcA_PC),
        .branch(ctrlD.branch),
        .jump(ctrlD.jump),
        .jalr(ctrlD.jalr),
        .aluControl(ctrlD.aluControl),
        .funct3_out(ctrlD.funct3),
        .useFPU(ctrlD.useFPU),
        .fprWrite(ctrlD.fprWrite),
        .fpuToInt(ctrlD.fpuToInt),
        .fpuOp(ctrlD.fpuOp),
        .fpLoad(ctrlD.fpLoad),
        .fpStore(ctrlD.fpStore),
        .useFpRs1(ctrlD.useFpRs1),
        .useFpRs2(ctrlD.useFpRs2),
        .useMulDiv(ctrlD.useMulDiv)
    );

    // ID/EX pipeline registers
    always_ff @(posedge clk) begin
        if (rst) begin
            pcE         <= 32'b0;
            immE        <= 32'b0;
            rs1E        <= 5'b0;
            rs2E        <= 5'b0;
            rdE         <= 5'b0;
            ctrlE       <= '0;
            rs1ValE     <= 32'b0;
            rs2ValE     <= 32'b0;
            fpRs1ValE   <= 32'b0;
            fpRs2ValE   <= 32'b0;
        end else if (flushD) begin
            ctrlE   <= '0;
            rs1E    <= 5'b0;
            rs2E    <= 5'b0;
            rdE     <= 5'b0;
            immE    <= 32'b0;
            pcE     <= 32'b0;
            rs1ValE   <= 32'b0;
            rs2ValE   <= 32'b0;
            fpRs1ValE <= 32'b0;
            fpRs2ValE <= 32'b0;
        end else if (!stallD) begin
            pcE       <= pcD;
            immE      <= immD;
            rs1E      <= rs1D;
            rs2E      <= rs2D;
            rdE       <= rdD;
            ctrlE     <= ctrlD;
            rs1ValE   <= rs1ValD;
            rs2ValE   <= rs2ValD;
            fpRs1ValE <= fpRs1ValD;
            fpRs2ValE <= fpRs2ValD;
        end else begin
            // Insert a bubble on load-use hazards
            ctrlE       <= '0;
            rs1E        <= 5'b0;
            rs2E        <= 5'b0;
            rdE         <= 5'b0;
            immE        <= 32'b0;
            rs1ValE     <= 32'b0;
            rs2ValE     <= 32'b0;
            fpRs1ValE   <= 32'b0;
            fpRs2ValE   <= 32'b0;
        end
    end

    // Forwarding logic
    logic [31:0] forwardDataM, forwardDataW;
    always_comb begin
        forwardDataM = aluResultM;
        case (ctrlM.resultSrc)
            RES_ALU: forwardDataM = aluResultM;
            RES_MEM: forwardDataM = loadDataM;
            RES_PC4: forwardDataM = pcPlus4M;
            RES_IMM: forwardDataM = immM;
            default: forwardDataM = aluResultM;
        endcase
        forwardDataW = resultW;
    end

    always_comb begin
        case (forwardA)
            2'b10: srcARegE = forwardDataM;
            2'b01: srcARegE = forwardDataW;
            default: srcARegE = rs1ValE;
        endcase

        case (forwardB)
            2'b10: srcBRegE = forwardDataM;
            2'b01: srcBRegE = forwardDataW;
            default: srcBRegE = rs2ValE;
        endcase
    end

    // ALU operand selection
    assign aluSrcA   = ctrlE.aluSrcA_PC ? pcE : srcARegE;
    assign aluSrcB   = ctrlE.aluSrc     ? immE : srcBRegE;
    assign pcPlus4E  = pcE + 32'd4;
    assign branchTargetE = pcE + immE;
    assign jalrTargetE   = (srcARegE + immE) & ~32'b1;

    alu alu_i (
        .a(aluSrcA),
        .b(aluSrcB),
        .op(ctrlE.aluControl),
        .result(aluResultE),
        .cmp_eq,
        .cmp_lt,
        .cmp_ltu
    );

    // Branch decision
    always_comb begin
        takeBranchE = 1'b0;
        if (ctrlE.branch) begin
            unique case (ctrlE.funct3)
                3'b000: takeBranchE = cmp_eq;        // BEQ
                3'b001: takeBranchE = ~cmp_eq;       // BNE
                3'b100: takeBranchE = cmp_lt;        // BLT
                3'b101: takeBranchE = ~cmp_lt;       // BGE
                3'b110: takeBranchE = cmp_ltu;       // BLTU
                3'b111: takeBranchE = ~cmp_ltu;      // BGEU
                default: takeBranchE = 1'b0;
            endcase
        end
    end

    // Hazard unit: forwarding and load-use stall/flush
    hazard_unit hazards(
        .ctrlE_memRead(ctrlE.memRead),
        .ctrlE_regWrite(ctrlE.regWrite),
        .ctrlE_jump(ctrlE.jump),
        .ctrlE_jalr(ctrlE.jalr),
        .rdE,
        .rs1D,
        .rs2D,
        .takeBranchE,
        .ctrlM_regWrite(ctrlM.regWrite),
        .rdM,
        .ctrlW_regWrite(ctrlW.regWrite),
        .rdW,
        .rs1E,
        .rs2E,
        .forwardA,
        .forwardB,
        .stallF,
        .stallD,
        .flushD
    );
    // Next PC
    always_comb begin
        pcNext = pcPlus4F;
        if (takeBranchE) pcNext = branchTargetE;
        else if (ctrlE.jump) pcNext = branchTargetE;
        else if (ctrlE.jalr) pcNext = jalrTargetE;
    end

    // EX/MEM pipeline
    always_ff @(posedge clk) begin
        if (rst) begin
            ctrlM       <= '0;
            rdM         <= 5'b0;
            pcPlus4M    <= 32'b0;
            aluResultM  <= 32'b0;
            storeDataM  <= 32'b0;
            fpStoreDataM<= 32'b0;
            immM        <= 32'b0;
            fpuFpResM   <= 32'b0;
            fpuIntResM  <= 32'b0;
        end else begin
            ctrlM       <= ctrlE;
            rdM         <= rdE;
            pcPlus4M    <= pcPlus4E;
            aluResultM  <= aluResultE;
            storeDataM  <= srcBRegE;
            fpStoreDataM<= fpRs2ValE;
            immM        <= immE;
            fpuFpResM   <= fpuFpResE;
            fpuIntResM  <= fpuIntResE;
        end
    end

    // LSU
    lsu lsu_i (
        .memRead(ctrlM.memRead),
        .memWrite(ctrlM.memWrite),
        .fpLoad(ctrlM.fpLoad),
        .fpStore(ctrlM.fpStore),
        .funct3(ctrlM.funct3),
        .addr(aluResultM),
        .storeData(storeDataM),
        .fpStoreData(fpStoreDataM),
        .d_rdata,
        .d_req,
        .d_we,
        .d_wstrb,
        .d_addr,
        .d_wdata,
        .loadData(loadDataM)
    );

    // MEM/WB pipeline
    always_ff @(posedge clk) begin
        if (rst) begin
            ctrlW      <= '0;
            rdW        <= 5'b0;
            pcPlus4W   <= 32'b0;
            aluResultW <= 32'b0;
            loadDataW  <= 32'b0;
            immW       <= 32'b0;
            fpuFpResW  <= 32'b0;
            fpuIntResW <= 32'b0;
        end else begin
            ctrlW      <= ctrlM;
            rdW        <= rdM;
            pcPlus4W   <= pcPlus4M;
            aluResultW <= aluResultM;
            loadDataW  <= loadDataM;
            immW       <= immM;
            fpuFpResW  <= fpuFpResM;
            fpuIntResW <= fpuIntResM;
        end
    end

    logic unused_ctrlW_bits;
    assign unused_ctrlW_bits = ctrlW.branch | ctrlW.jump | ctrlW.jalr | ctrlW.memWrite |
                               ctrlW.memRead | ctrlW.useFPU | ctrlW.fpStore |
                               ctrlW.useMulDiv | ctrlW.useFpRs1 | ctrlW.useFpRs2 |
                               ctrlW.aluSrcA_PC | ctrlW.aluSrc | ctrlW.resultSrc[1] |
                               ctrlW.fprWrite | ctrlW.fpLoad |
                               ctrlW.fpuOp[0] | ctrlW.fpuOp[1] | ctrlW.fpuOp[2] |
                               ctrlW.fpuOp[3] | ctrlW.fpuOp[4] |
                               ctrlW.funct3[0] | ctrlW.funct3[1] | ctrlW.funct3[2];

    // Writeback select
    always_comb begin
        unique case (ctrlW.resultSrc)
            RES_ALU: resultW = aluResultW;
            RES_MEM: resultW = loadDataW;
            RES_PC4: resultW = pcPlus4W;
            RES_IMM: resultW = immW;
            default: resultW = aluResultW;
        endcase
    end

endmodule
