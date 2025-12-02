.text
.globl main
main:
    li t0, 0x00010000      # base
    li t1, 0               # offset
    li t2, 5               # iterations (5 dirty lines in same set)
store_loop:
    add t3, t0, t1         # addr = base + offset
    addi t4, t2, -4        # value unique per line
    sb t4, 0(t3)           # dirty write
    addi t1, t1, 1024
    addi t1, t1, 1024      # next tag same index (32 sets * 64 bytes)
    addi t2, t2, -1
    bne t2, zero, store_loop

    # Read back first line after evictions to ensure writeback
    li t1, 0
    add t3, t0, t1
    lbu a0, 0(t3)          # expect 1
finish:
    bne a0, zero, finish
    