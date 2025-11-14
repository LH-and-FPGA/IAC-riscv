#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

static constexpr vluint64_t MAX_SIM_CYC = 2000;

int main(int argc, char **argv) {
    int simcyc;     // simulation clock count
    int tick;       // each clk cycle has two ticks for two edges

    Verilated::commandArgs(argc, argv);
    // enable tracing before module construction so Verilator registers signals
    Verilated::traceEverOn(true);
    // init top verilog instance
    Vtop *top = new Vtop;
    // init trace dump
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("top_tb.vcd");

    top->clk = 0;
    top->rst = 0;
    top->en = 1;

    for (simcyc = 0; simcyc < MAX_SIM_CYC; simcyc++)
    {
        // dump variables into VCD file and toggle clock
        for (tick = 0; tick < 2; tick++)
        {
            tfp->dump(2 * simcyc + tick);
            top->clk = !top->clk;
            top->eval();
        }
    }
    tfp->close();
    exit(0);
}
