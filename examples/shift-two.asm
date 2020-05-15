## Program to logical shift left a pattern

        .text
        .globl  main

main:
        ori      $8, $0, 0x6F       # Put bit pattern into register $8
        sll      $9, $8, 2          # Shift left logical by two

## End of file
