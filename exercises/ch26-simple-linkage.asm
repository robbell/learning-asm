        .text
        .globl  main

main:
        jal     pread           # read first integer
        nop                     #
        move    $s0, $v0        # save it in $s0

        jal     pread           # read second integer
        nop                     #
        move    $s1, $v0        # save it in $s1

        jal     pread           # read third integer
        nop                     #
        move    $s2, $v0        # save it in $s2

        addu    $s0, $s0, $s1   # compute the sum
        addu    $s3, $s0, $s2   # result in $s3

        li      $v0, 4          # print a heading
        la      $a0, heading
        syscall

        move    $a0, $s3        # move sum into parameter
        li      $v0, 1          # print the sum
        syscall

        li      $v0, 10         # exit
        syscall

        .data
heading:
        .asciiz "The sum is: "


# pread -- prompt for and read an integer
#
# on entry:
#    $ra -- return address
#
# on exit:
#    $v0 -- the integer

pread:
        la      $a0, prompt         # print string
        li      $v0, 4              # service 4
        syscall

        li      $v0, 5              # read int into $v0
        syscall                     # service 5

        jr      $ra

    # return

        nop                         # branch delay slot

        .data
prompt:
        .asciiz "Enter an integer"
