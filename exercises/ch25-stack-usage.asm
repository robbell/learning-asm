# Evaluate the expression ab - 12a + 18b - 7
#
# Settings: Load delays OFF; Branch delays OFF,
#           Trap file    ON; Pseudoinstructions ON   

        .globl  main

main:   
        lw      $t0,a          # get a
        lw      $t1,bb         # get b
        mul     $t0,$t0,$t1    # a*b
        subu    $sp,$sp,4      # push a*b onto stack
        sw      $t0,($sp)
        
        lw      $t0,a          # get a
        li      $t1,-12        # 
        mul     $t0,$t0,$t1    # -12a
        subu    $sp,$sp,4      # push -12a onto stack
        sw      $t0,($sp)
        
        lw      $t0,bb         # get b
        li      $t1,18         # 
        mul     $t0,$t0,$t1    # 18b
        subu    $sp,$sp,4      # push 18b onto stack
        sw      $t0,($sp)

        li      $t1,-7         # init sum to -7
        lw      $t0,($sp)      # pop 18b
        addu    $sp,$sp,4
        addu    $t1,$t1,$t0    # 18b -7
                
        lw      $t0,($sp)      # pop -12a
        addu    $sp,$sp,4
        addu    $t1,$t1,$t0    # -12a + 18b -7
                
        lw      $t0,($sp)      # pop ab
        addu    $sp,$sp,4
        addu    $t1,$t1,$t0    # ab - 12a + 18b -7
         
done:   li      $v0,1          # print sum
        move    $a0,$t1
        syscall
        li      $v0,10         # exit
        syscall   

        .data
a:      .word  0
bb:     .word  10