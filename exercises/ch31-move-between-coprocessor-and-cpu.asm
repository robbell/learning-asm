## Move data between the coprocessor and the CPU

        .text
        .globl main

main:   
        li      $t0,1           # $t0 <-- 1
                                # (move to the coprocessor)
        mtc1    $t0,$f0         # $f0 <-- $t0 (no change)
        
        li.s    $f1,1.0         # $f1 <-- 1.0
                                # (move from the coprocessor)
        mfc1    $t1,$f1         # $t1 <-- $f1 (also no change)
        
        li      $v0,10          # exit
        syscall
