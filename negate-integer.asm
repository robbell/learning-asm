## Program to negate a two's complement integer

        .text
        .globl  main

main:
        ori      $7, $0, 146 # Put +146 into $7
        ori      $8, $0,  82 # Put 82 into $8
        nor      $8, $8,  $0 # Reflect
        ori      $9, $0,   1 # Load 1 into a register
        addu     $8, $8,  $9 # Add 1: $8 = -82
        addu    $10, $7,  $8 # (+146) + (-82)

## End of file