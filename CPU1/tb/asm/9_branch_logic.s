.text
.globl main
main:
    li t0, -5              # 0xFFFFFFFB
    li t1, 4

    slt t2, t0, t1         # signed comparison -> 1
    sltu t3, t0, t1        # unsigned comparison -> 0
    li  s1, 3
    sll t4, t1, s1         # 32
    li  s2, 2
    sra t5, t0, s2         # -2
    li  s3, 1
    srl t6, t0, s3         # 0x7FFFFFFD

    or  s0, t4, t2         # 33
    add a0, s0, t3         # 33

    beq  t2, zero, fail    # should not branch
    blt  t1, t0, fail      # should not branch
    bge  t0, t1, fail      # should not branch
    bltu t0, t1, fail      # should not branch
    bgeu t0, t1, pass      # should branch

fail:
    li a0, 0xDEADBEEF
    j finish

pass:
    xor a0, a0, t5         # 0xFFFFFFDF
    add a0, a0, t6         # 0x7FFFFFDC

finish:
    bne a0, zero, finish   # loop forever with final result
    