## Program to negate a two's complement integer

        .text
        .globl  main

main:
        ori      $7,  $0, 146 # Put +146 into $7
        ori      $8,  $0,  82 # Put 82 into $8
        nor      $8,  $8,  $0 # Reflect

# Using addu
        ori      $9,  $0,   1 # Load 1 into a register
        addu     $10, $8,  $9 # Add 1: $8 = -82

# Using addiu
        addiu    $10, $8,   1 # Add 1: $8 = -82

# Total
        addu     $11, $7,  $10 # (+146) + (-82)

## End of file