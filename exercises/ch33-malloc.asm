# malloc()
#
# Allocate one block of memory, put an integer into it,
# print out the integer.

        .text
        .globl  main

main:     
        li      $v0,9             # (1) Allocate a block of memory
        li      $a0,4             # 4 bytes long
        syscall                   # $v0 <-- address
        move    $s0,$v0           # (2) Make a safe copy
        
        li      $t0,77            # (3) Store value 77
        sw      $t0,0($s0)        # into the block
        
        lw      $a0,0($s0)        # (4) Load from the block
        li      $v0,1             # into $a0. 
        syscall                   # (5) Print the integer

        li      $v0,10            # Return to OS
        syscall       

## end of file