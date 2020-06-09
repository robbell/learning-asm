## Print out a 32 bit pattern, first as a float,
## then as an integer.

        .text
        .globl  main

main:
        l.s     $f12,val        # use the float as an argument - $f12 is the equivalent to $v0 for floar syscalls
        li      $v0,2           # code 2 == print float
        syscall                 # (correct)

        li      $v0,4           # print
        la      $a0,lfeed       # line separator
        syscall

        lw      $a0,val         # use the float as a int
        li      $v0,1           # code 2 == print int
        syscall                 # (mistake)

        li      $v0,10          # code 10 == exit
        syscall                 # Return to OS.
                
        .data
val :   .float  -8.32           # floating point data
lfeed:  .asciiz "\n"
