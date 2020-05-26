# Convert ounces to pounds and ounces

        .text
        .globl  main

main:   li      $v0, 4       # print prompt
        la      $a0, prompt  #
        syscall

        li      $v0, 5       # read in integer ounces
        syscall

        li      $t1, 16      # 16 oz. per pound
        divu    $v0, $t1     # lo = pound; hi = oz.

        mflo    $a0
        li      $v0, 1       # print integer
        syscall              # pounds (uses $a0)

        li      $v0, 4       # print string 
        la      $a0, pout    # "pounds"
        syscall

        mfhi    $a0          
        li      $v0, 1       # print integer
        syscall              # ounces (uses $a0)

        li      $v0, 4       # print string
        la      $a0, ozout   # "ounces"
        syscall

        li      $v0, 10      # exit
        syscall

        .data
prompt: .asciiz "Enter ounces: "
pout:   .asciiz " Pounds\n"
ozout:  .asciiz " Ounces\n"
