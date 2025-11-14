#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#include <iomanip>
#include <iostream>

static constexpr vluint64_t MAX_SIM_CYC = 2000;

int main(int argc, char **argv) {
    VerilatedContext context;
    context.commandArgs(argc, argv);

    Vtop top{&context};

#if VM_TRACE
    context.traceEverOn(true);
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top.trace(tfp, 99);
    tfp->open("top_tb.vcd");
#endif

    vluint64_t sim_time = 0;
    auto tick = [&](bool clk_level) {
        top.clk = clk_level;
        top.eval();
#if VM_TRACE
        tfp->dump(sim_time);
#endif
        ++sim_time;
    };

    top.rst = 1;
    top.en = 0;

    while (!context.gotFinish() && (sim_time < MAX_SIM_CYC * 2)) {
        if (sim_time == 4) {
            top.rst = 0;
        }
        if (sim_time == 6) {
            top.en = 1;
        }

        tick(false);
        tick(true);
    }

    std::cout << "Simulation finished after " << sim_time / 2 << " cycles. "
              << "a0 = 0x" << std::hex << std::setw(8) << std::setfill('0')
              << top.a0 << std::dec << std::endl;

#if VM_TRACE
    tfp->close();
    delete tfp;
#endif

    return 0;
}
