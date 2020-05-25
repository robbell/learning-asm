## Program to add two integers using Load Address

        .text
        .globl  main

main:
        la    $t0, val2     # put a 32-bit address into $t0
                            # translates into lui and ori instructions

        lw    $t1, 0($t0)   # load value 2
        lw    $t2, 4($t0)   # load value 3
        sll   $0, $0, 0     # load delay slot
        addu  $t1, $t1, $t2 # calc. sum

        .data
val0:   .word   0 
val1:   .word   1 
val2:   .word   2 
val3:   .word   3 
val4:   .word   4 
val5:   .word   5 