#include "Vdut.h"
#include "gtest/gtest.h"
#include "verilated.h"

class LsuTopTest : public ::testing::Test
{
public:
    void SetUp() override
    {
        context = new VerilatedContext;
        dut = new Vdut{context};

        // Default all inputs
        dut->mem_read      = 0;
        dut->mem_write     = 0;
        dut->fp_load       = 0;
        dut->fp_store      = 0;
        dut->funct3        = 0;
        dut->addr          = 0;
        dut->store_data    = 0;
        dut->fp_store_data = 0;
        dut->d_rdata       = 0;
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

TEST_F(LsuTopTest, StoreWordFormatsBusCorrectly)
{
    dut->mem_write  = 1;
    dut->funct3     = 0b010;           // SW
    dut->addr       = 0x00010004u;
    dut->store_data = 0xDEADBEEFu; // DEADBEEF!!

    dut->eval();

    EXPECT_EQ(dut->d_req, 1);
    EXPECT_EQ(dut->d_we, 1);
    EXPECT_EQ(dut->d_addr, 0x00010004u);
    EXPECT_EQ(dut->d_wstrb, 0xFu);    // all bytes enabled
    EXPECT_EQ(dut->d_wdata, 0xDEADBEEFu);
}

TEST_F(LsuTopTest, StoreByteUsesCorrectLaneAndData)
{
    dut->mem_write  = 1;
    dut->funct3     = 0b000;           // SB
    dut->addr       = 0x00000001u;     // byte offset 1
    dut->store_data = 0x000000AAu;

    dut->eval();

    EXPECT_EQ(dut->d_req, 1);
    EXPECT_EQ(dut->d_we, 1);
    EXPECT_EQ(dut->d_wstrb, 0x2u);    // lane 1 only [0010]

    // Only the targeted byte lane must carry 0xAA
    uint32_t shifted = dut->d_wdata >> 8; // offset 1 -> shift by 8
    EXPECT_EQ(shifted & 0xFFu, 0xAAu); // shifted & 0xFFu extracts byte lane 1 then compares
}

TEST_F(LsuTopTest, LoadByteSignExtendsCorrectly)
{
    dut->mem_read = 1;
    dut->funct3   = 0b000;             // LB
    dut->addr     = 0x00000002u;       // offset 2
    dut->d_rdata  = 0x807F0000u;      // byte2 = 0x7F, byte3 = 0x80

    dut->eval();

    // Offset 2 -> selects byte2 = 0x7F, sign-extended
    EXPECT_EQ(dut->load_data, 0x0000007Fu);

    // Now choose offset 3, which picks 0x80 and sign-extends to negative
    dut->addr = 0x00000003u;
    dut->eval();
    EXPECT_EQ(dut->load_data, 0xFFFFFF80u);
}

TEST_F(LsuTopTest, LoadHalfUnsignedZeroExtends)
{
    dut->mem_read = 1;
    dut->funct3   = 0b101;             // LHU
    dut->addr     = 0x00000000u;       // offset 0 -> low halfword
    dut->d_rdata  = 0xABCD8001u;       // low half = 0x8001, high half = 0xABCD

    dut->eval();
    EXPECT_EQ(dut->load_data, 0x00008001u);

    // offset 2 -> high halfword (0xABCD), zero-extended
    dut->addr = 0x00000002u;
    dut->eval();
    EXPECT_EQ(dut->load_data, 0x0000ABCDu);
}

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
