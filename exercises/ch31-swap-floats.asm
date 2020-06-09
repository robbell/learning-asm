## Exchange the values in valA and valB

        .text
        .globl  main

main:
        l.s     $f0,valA        # $f0  <-- valA
        l.s     $f1,valB        # $f1  <-- valB
        s.s     $f0,valB        # $f0  --> valB
        s.s     $f1,valA        # $f1  --> valA

        li      $v0,10          # code 10 == exit
        syscall                 # Return to OS.
                
        .data
valA:   .float  8.32            # 32 bit floating point value
valB:   .float  -0.6234e4       # 32 bit floating point value
                                # small 'e' only