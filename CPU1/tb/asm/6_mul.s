.text
.globl main
main:
    li t0, 7
    li t1, 9
    mul a0, t0, t1    # a0 = 63
    li t2, 3
    div t3, a0, t2    # t3 = 21
    rem t4, a0, t2    # t4 = 0
    add a0, t3, t4    # a0 = 21
finish:
    bne a0, zero, finish   # wait forever, expect a0 = 21
    