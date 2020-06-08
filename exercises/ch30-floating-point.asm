## Program to represent 1.0
        .text
        .globl  main
main:
        .data
val:    .float    1.0 # 0x3F800000 or 0|01111111|00000000000000000000000
                      #               ^    ^                  ^
                      #             sign exponent          mantissa
## End of file