## Evaluate the polynomial ax2 + bx + c
##
        .text
        .globl  main

main:
        lw   $t3, x          # get x
        lw   $t0, a          # get a
        lw   $t1, bb         # get bb
        lw   $t2, c          # get c

        mult $t3, $t3        # x2
        mflo $t4             # $t4 = x2
        nop
        nop
        mult $t4, $t0        # low  = ax2
        mflo $t4             # $t4  = ax2
        nop
        nop

        mult $t1, $t3        # low  = bx
        mflo $t5             # $t5  = bx
        addu $t5, $t4, $t5   # $t5  = ax2 + bx

        addu $t5, $t5, $t2   # $t5 = ax2 + bx + c
        sw   $t5, value      # value = polynomial

        .data
x:      .word   4 
value:  .word   1 
a:      .word  20
bb:     .word  -2            # the SPIM assembler does not allow the label "b"
c:      .word   5