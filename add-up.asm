## Program to add two plus three

        .text
        .globl  main

main:
        ori     $8, $0, 0x2       # Put two's comp. two into register 8
        ori     $9, $0, 0x3       # Put two's comp. three into register 9
        addu    $10, $8, $9       # Add register 8 and 9, put result in 10

## End of file
