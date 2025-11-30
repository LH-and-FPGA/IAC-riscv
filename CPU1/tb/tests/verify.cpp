#include <cstdlib>
#include <utility>

#include "cpu_testbench.h"

#define CYCLES 10000

TEST_F(CpuTestbench, TestAddiBne)
{
    setupTest("1_addi_bne");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 254);
}

TEST_F(CpuTestbench, TestLiAdd)
{
    setupTest("2_li_add");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 1000);
}

TEST_F(CpuTestbench, TestLbuSb)
{
    setupTest("3_lbu_sb");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 300);
}

TEST_F(CpuTestbench, TestJalRet)
{
    setupTest("4_jal_ret");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 53);
}

TEST_F(CpuTestbench, TestPdf)
{
    setupTest("5_pdf");
    setData("reference/gaussian.mem");
    initSimulation();
    runSimulation(CYCLES * 100);
    EXPECT_EQ(top_->a0, 15363);
}

TEST_F(CpuTestbench, TestPdfDataChecksum)
{
    setupTest("5_pdf_data_checksum");
    setData("reference/gaussian.mem");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 11903);
}

TEST_F(CpuTestbench, TestPdfDataChecksumLarge)
{
    setupTest("5_pdf_data_checksum_15363");
    setData("reference/gaussian.mem");
    initSimulation();
    runSimulation(CYCLES * 200);
    EXPECT_EQ(top_->a0, 1519108);
}

TEST_F(CpuTestbench, TestPdfCount107)
{
    setupTest("5_pdf_count_107");
    setData("reference/gaussian.mem");
    initSimulation();
    runSimulation(CYCLES * 200);
    EXPECT_EQ(top_->a0, 200);
}

TEST_F(CpuTestbench, TestPdfInitClearsBins)
{
    setupTest("5_pdf_init_clear");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 0);
}

TEST_F(CpuTestbench, TestPdfBuildHitsMaxCount)
{
    setupTest("5_pdf_build_maxcount");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 200);
}

// TEST_F(CpuTestbench, TestPdfHitCount)
// {
//     setupTest("5_pdf_hit_count");
//     setData("reference/gaussian.mem");
//     initSimulation();
//     runSimulation(CYCLES * 200);
//     EXPECT_EQ(top_->a0, 15363);
// }

// TEST_F(CpuTestbench, TestPdfHitInfo)
// {
//     setupTest("5_pdf_hit_info");
//     setData("reference/gaussian.mem");
//     initSimulation();
//     runSimulation(CYCLES * 200);
//     // High 16 bits = bin index, low 16 bits = iteration count
//     EXPECT_EQ(top_->a0, (107u << 16) | 15363u);
// }

TEST_F(CpuTestbench, TestPdfSumMatchesIterations)
{
    setupTest("5_pdf_sum_vs_iterations");
    setData("reference/gaussian.mem");
    initSimulation();
    runSimulation(CYCLES * 100);
    EXPECT_EQ(top_->a0, 0);
}

TEST_F(CpuTestbench, TestPdfDisplayIncludesLastBin)
{
    setupTest("5_pdf_display_last_bin");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 7);
}

TEST_F(CpuTestbench, TestMulDiv)
{
    setupTest("6_mul");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 21);
}

TEST_F(CpuTestbench, TestCacheStress)
{
    setupTest("7_cache_stress");
    initSimulation();
    runSimulation(CYCLES * 5);
    EXPECT_EQ(top_->a0, 1);
}

TEST_F(CpuTestbench, TestLoadStore)
{
    setupTest("8_load_store");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 0x00C07F0F);
}

TEST_F(CpuTestbench, TestBranchLogic)
{
    setupTest("9_branch_logic");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 0x7FFFFFDC);
}

TEST_F(CpuTestbench, TestLoop255)
{
    setupTest("test_loop_255");
    initSimulation();
    runSimulation(CYCLES);
    // s1 应该 == 255（循环执行 255 次），a0 = s1
    EXPECT_EQ(top_->a0, 255);
}

TEST_F(CpuTestbench, TestLoop100)
{
    setupTest("test_loop_100");
    initSimulation();
    runSimulation(CYCLES);
    // 循环退出时 t0 应该 == 100，a0 = t0
    EXPECT_EQ(top_->a0, 100);
}

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    auto res = RUN_ALL_TESTS();
    return res;
}
