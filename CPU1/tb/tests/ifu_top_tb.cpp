#include "Vdut.h"
#include "gtest/gtest.h"
#include "verilated.h"

static void tick(Vdut *dut)
{
    dut->clk = !dut->clk;
    dut->eval();
    dut->clk = !dut->clk;
    dut->eval();
}

class IfuTopTest : public ::testing::Test
{
public:
    void SetUp() override
    {
        context = new VerilatedContext;
        dut = new Vdut{context};

        dut->clk = 0;
        dut->StallF = 0;
        dut->StallD = 0;
        dut->FlushD = 0;
        dut->branch = 0;
        dut->jump = 0;
        dut->jalr = 0;
        dut->branch_pc = 0;
        dut->jalr_pc = 0;
        dut->instr_in = 0;

        dut->rst = 1;
        tick(dut);  // synchronous reset
        dut->rst = 0;

    }

    void TearDown() override
    {
        dut->final();
        delete dut;
        delete context;
    }

protected:
    VerilatedContext *context;
    Vdut *dut;
};

TEST_F(IfuTopTest, ResetIsNop)
{
    constexpr uint32_t NOP = 0x00000013u;

    tick(dut); // normal operation (pc increments by 4)

    dut->rst = 1;
    tick(dut); // apply reset
    dut->rst = 0;

    EXPECT_EQ(dut->pc_f, 0u);
    EXPECT_EQ(dut->pc_d, 0u);
    EXPECT_EQ(dut->i_addr, 0u);
    EXPECT_EQ(dut->instr_d, NOP);
}

// LOOK AT THIS TEST CASE CAREFULLY - it checks the pipeline behavior over two ticks
TEST_F(IfuTopTest, InstructionMovesIntoDecodeStage)
{
    constexpr uint32_t fetched_instr = 0x0ff00313u;

    uint32_t old_pc_f = dut->pc_f;
    tick(dut); // first tick to fetch instruction into fetch stage    
    dut->instr_in = fetched_instr; // set instruction at fetch stage as i_addr is now pc_f

    EXPECT_EQ(dut->instr_d, 0); // instr at decode stage is still 0 (initial value)
    EXPECT_EQ(dut->pc_d, 0u); // pc_d is still 0
    EXPECT_EQ(dut->pc_f, old_pc_f + 4u); // pc_f incremented by 4
    EXPECT_EQ(dut->i_addr, dut->pc_f); // i_addr == pc_f
    
    tick(dut); // move instruction to decode stage
    EXPECT_EQ(dut->instr_d, fetched_instr); // instr at decode stage
    EXPECT_EQ(dut->pc_d, old_pc_f + 4u); // pc_d lags one stage behind fetch
    EXPECT_EQ(dut->pc_f, old_pc_f + 8u); // fetch has advanced another 4
    EXPECT_EQ(dut->i_addr, dut->pc_f); // i_addr == pc_f
}

TEST_F(IfuTopTest, FlushInsertsNopIntoDecode)
{
    constexpr uint32_t NOP = 0x00000013u;

    dut->instr_in = 0xDEADBEEFu;
    tick(dut); // standard operation
    ASSERT_NE(dut->instr_d, NOP); // sanity check before flush

    dut->FlushD = 1;
    tick(dut); // apply flush

    EXPECT_EQ(dut->instr_d, NOP); // instr_d is replaced with NOP on flush
    EXPECT_EQ(dut->pc_d, 0u); // pc_d is reset to 0 on flush

    dut->FlushD = 0;
}

TEST_F(IfuTopTest, StallDHoldsDecodeState)
{
    constexpr uint32_t first_instr = 0x0ff00313u;
    constexpr uint32_t second_instr = 0x00000513u;

    dut->instr_in = first_instr;
    tick(dut);
    uint32_t prev_pc_d = dut->pc_d;
    EXPECT_EQ(dut->instr_d, first_instr); // Standard

    dut->StallD = 1;
    dut->instr_in = second_instr; // new instruction at fetch stage
    tick(dut);
    dut->StallD = 0;

    EXPECT_EQ(dut->instr_d, first_instr); // instr_d remains the same as in first tick
    EXPECT_EQ(dut->pc_d, prev_pc_d); // pc_d remains the same as in first tick
}

TEST_F(IfuTopTest, StallFHoldsProgramCounter)
{
    // Redirect PC to 0x10 for a single cycle
    dut->branch_pc = 0x00000010u;
    dut->jump = 1;
    tick(dut);
    dut->jump = 0;
    uint32_t pc_before = dut->pc_f;

    dut->StallF = 1;
    dut->branch_pc = 0x00000014u; // would redirect if not stalled
    dut->jump = 1;
    tick(dut);
    dut->jump = 0;
    dut->StallF = 0;

    EXPECT_EQ(dut->pc_f, pc_before);
    EXPECT_EQ(dut->i_addr, pc_before);
}

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
