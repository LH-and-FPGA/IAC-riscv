.text
.globl main
main:
    li t0, 0x200          # base address
    li t1, -1
    sb t1, 0(t0)          # store 0xFF

    li t2, 0x7FFF
    sh t2, 2(t0)          # store halfword

    li t3, 0x00C0FFEE
    sw t3, 4(t0)          # store word

    lb t4, 0(t0)          # expect 0xFFFFFFFF
    lbu t5, 0(t0)         # expect 0x000000FF
    lh t6, 2(t0)          # expect 0x00007FFF
    lhu s0, 2(t0)         # expect 0x00007FFF
    lw s1, 4(t0)          # expect 0x00C0FFEE

    add a0, t5, t6        # a0 = 0x000080FE
    xor a0, a0, s1        # a0 = 0x00C07F10
    add a0, a0, t4        # a0 = 0x00C07F0F

finish:
    bne a0, zero, finish  # loop forever with final result in a0
    