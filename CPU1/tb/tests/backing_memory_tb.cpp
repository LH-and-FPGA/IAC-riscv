#include "Vdut.h"
#include "gtest/gtest.h"
#include "verilated.h"

#include <array>
#include <cstdint>
#include <fstream>
#include <iomanip>

namespace {

constexpr size_t kLineBytes = 64;
constexpr size_t kLineWords = (kLineBytes * 8 + 31) / 32;
constexpr uint32_t kDataBase = 0x00010000u;

std::array<uint8_t, kLineBytes> wideToBytes(const VlWide<kLineWords> &wide)
{
    std::array<uint8_t, kLineBytes> bytes{};
    for (size_t word = 0; word < kLineWords; ++word)
    {
        uint32_t value = wide[word];
        for (size_t byte = 0; byte < 4 && (word * 4 + byte) < kLineBytes; ++byte)
        {
            bytes[word * 4 + byte] = static_cast<uint8_t>((value >> (8 * byte)) & 0xFFu);
        }
    }
    return bytes;
}

bool writeHexFile(const std::string &path, const std::array<uint8_t, kLineBytes> &image)
{
    std::ofstream hex(path, std::ios::trunc);
    if (!hex.is_open())
    {
        return false;
    }

    hex << std::hex << std::nouppercase;
    for (auto byte : image)
    {
        hex << std::setw(2) << std::setfill('0') << static_cast<unsigned>(byte) << "\n";
    }

    return true;
}

} // namespace

class BackingMemoryTest : public ::testing::Test
{
public:
    BackingMemoryTest()
    {
        for (size_t i = 0; i < kLineBytes; ++i)
        {
            program_image[i] = static_cast<uint8_t>(i & 0xFFu);
            data_image[i] = static_cast<uint8_t>((0xA0u + i) & 0xFFu);
        }
    }

protected:
    void SetUp() override
    {
        ASSERT_TRUE(writeHexFile("program.hex", program_image));
        ASSERT_TRUE(writeHexFile("data.hex", data_image));

        context = new VerilatedContext;
        dut = new Vdut{context};

        dut->clk = 0;
        dut->rd0_req = 0;
        dut->rd0_addr = 0;
        dut->wr0_req = 0;
        dut->wr0_addr = 0;
        VL_ZERO_W(kLineWords, dut->wr0_line);
        dut->wr0_mask = 0;
        dut->rd1_req = 0;
        dut->rd1_addr = 0;
        dut->wr1_req = 0;
        dut->wr1_addr = 0;
        VL_ZERO_W(kLineWords, dut->wr1_line);
        dut->wr1_mask = 0;

        // Run initial blocks so memory loads the hex images
        dut->eval();
    }

    void TearDown() override
    {
        dut->final();
        delete dut;
        delete context;
    }

    void tick()
    {
        dut->clk = 0;
        dut->eval();
        dut->clk = 1;
        dut->eval();
    }

    std::array<uint8_t, kLineBytes> readPort0(uint32_t addr)
    {
        dut->rd0_req = 1;
        dut->rd0_addr = addr;
        dut->eval();
        auto bytes = wideToBytes(dut->rd0_line);
        dut->rd0_req = 0;
        return bytes;
    }

    std::array<uint8_t, kLineBytes> readPort1(uint32_t addr)
    {
        dut->rd1_req = 1;
        dut->rd1_addr = addr;
        dut->eval();
        auto bytes = wideToBytes(dut->rd1_line);
        dut->rd1_req = 0;
        return bytes;
    }

    Vdut *dut = nullptr;
    VerilatedContext *context = nullptr;
    std::array<uint8_t, kLineBytes> program_image{};
    std::array<uint8_t, kLineBytes> data_image{};
};

TEST_F(BackingMemoryTest, LoadsProgramHexOnPort0)
{
    auto line = readPort0(0x00000010u);
    EXPECT_EQ(line[0], program_image[0]);
    EXPECT_EQ(line[1], program_image[1]);
    EXPECT_EQ(line[15], program_image[15]);
    EXPECT_EQ(line[63], program_image[63]);
    EXPECT_EQ(dut->rd0_ready, 1);
}

TEST_F(BackingMemoryTest, DataRegionStartsAtDataBase)
{
    auto line = readPort1(kDataBase + 0x20u);
    EXPECT_EQ(line[0], data_image[0]);
    EXPECT_EQ(line[8], data_image[8]);
    EXPECT_EQ(line[32], data_image[32]);
    EXPECT_EQ(line[63], data_image[63]);
    EXPECT_EQ(dut->rd1_ready, 1);
}

TEST_F(BackingMemoryTest, MaskedWritesUpdateOnlyTargetBytes)
{
    auto before = readPort0(0x00000000u);
    EXPECT_EQ(before[4], program_image[4]);

    VL_ZERO_W(kLineWords, dut->wr1_line);
    dut->wr1_line[0] = 0x44332211u;
    dut->wr1_mask = 0x0Fu; // enable first four bytes only
    dut->wr1_addr = 0x00000000u;
    dut->wr1_req = 1;
    tick();
    dut->wr1_req = 0;

    auto after = readPort0(0x00000000u);
    EXPECT_EQ(after[0], 0x11u);
    EXPECT_EQ(after[1], 0x22u);
    EXPECT_EQ(after[2], 0x33u);
    EXPECT_EQ(after[3], 0x44u);
    EXPECT_EQ(after[4], program_image[4]); // untouched byte outside mask
}

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
