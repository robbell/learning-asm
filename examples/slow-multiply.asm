## Program to calculate 5 * x - 74 the long way
##
## Register Use:
##  $8   x
##  $9   result

        .text
        .globl  main

main:
        ori      $8, $0, 12  # put x into $8
        sll      $9, $8, 2   # $9 <—— 4x
        addu     $9, $9, $8  # $9 = 5x
        addiu    $9, $9, -74 # = 5x - 74

## End of file
