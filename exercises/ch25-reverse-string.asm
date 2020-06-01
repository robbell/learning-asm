# Reverse a string

        .text
        .globl  main
main:
        # input the string into a buffer
        li      $v0, 8          # service code
        la      $a0, str        # address of buffer
        li      $a1, 128        # buffer length
        syscall

        # initialize the stack:
        li      $t0, 0          # push a null
        subu    $sp, $sp, 4     # onto the stack
        sw      $t0, ($sp)      # to signal its bottom

        li      $t1, 0          # index of first char in str buffer

        # push each character onto the stack
pushl:
        lbu     $t0, str($t1)   # get current char into
                                # a full word

        beqz    $t0, stend      # null byte: end of string

        subu    $sp, $sp, 4     # push the full word
        sw      $t0, ($sp)      # holding the char

        addu    $t1, 1          # inc the index
        j       pushl           # loop

        # pop chars from stack back into the buffer
stend:
        li      $t1, 0          # index of first byte of str buffer
popl:
        lw      $t0, ($sp)      # pop a char off the stack
        addu    $sp, $sp, 4

        beqz    $t0, done       # null means empty stack

        sb      $t0, str($t1)   # store at string[$t1]

        addu    $t1, 1          # inc the index
        j       popl            # loop

        # print the reversed string
done:
        li      $v0, 4          # service code
        la      $a1, str        # address of string
        syscall

        li      $v0, 10         # exit
        syscall

        .data
str:    .space  128     # character buffer