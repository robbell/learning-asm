## Program to calculate 5 * x - 74 the standard way
##
## Register Use:
##  $8   x
##  $9   result

        .text
        .globl  main

main:
        ori      $8, $0, 12  # put x into $8
        ori      $9, $0, 5   # put 5 into $9

        mult     $9, $8      # multiply register 8 (12) x register 9 (5)
        mflo     $9          # move the low order bits into register 9
        addiu    $9, $9, -74 # deduct 74 in place

## End of file
