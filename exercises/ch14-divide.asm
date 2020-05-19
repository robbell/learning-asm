## Program to calculate (y + x) / (y - x)
##
## Register Use:
## $8 x
## $9 y
## $10 x+y ; quotient
## $11 y-x ; remainder

 .text
 .globl main

main:
    ori $8, $0, 8 # put x into $8
    ori $9, $0, 36 # put y into $9

    addu $10, $9, $8 # $10 = (y + x)
    subu $11, $9, $8 # $11 = (y-x)

    div $10, $11 # hilo = (y + x) / (y - x)

    mflo $10 # $10 = quotient
    mfhi $11 # $11 = remainder

## End of file