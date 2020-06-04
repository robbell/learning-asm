## Driver --  main program for the application

         .text
         .globl main
 
main:
         sub     $sp, $sp, 4        # push the return address
         sw      $ra, ($sp)
         sub     $sp, $sp, 4        # push $s0
         sw      $s0, ($sp)
         
         la      $a0, xprompt       # prompt the user
         li      $v0, 4             # service 4
         syscall
         li      $v0, 5             # service 5 -- read int
         syscall                    # $v0 = integer
         move    $s0, $v0           # save x
         
         la      $a0, yprompt       # prompt the user
         li      $v0, 4             # service 4
         syscall
         li      $v0, 5             # service 5 -- read int
         syscall                    # $v0 = integer
         
                                    # prepare arguments
         move    $a0, $s0           # x         
         move    $a1, $v0           # y
         jal     maxExp             # maximum expression
         nop                        # returned in $v0
         move    $s0, $v0           # keep it safe

         la      $a0, rprompt       # output title
         li      $v0, 4             # service 4
         syscall

         move    $a0, $s0           # get maximum
         li      $v0, 1             # print it out
         syscall
                                                      
         lw      $ra, ($sp)         # pop $s0
         add     $s0, $sp, 4
         lw      $ra, ($sp)         # pop return address
         add     $sp, $sp, 4
         
         jr      $ra                # return to OS 
         nop
         
         .data
xprompt: .asciiz  "Enter a value for x --> "
yprompt: .asciiz  "Enter a value for y --> "
rprompt: .asciiz  "The maximum expression is: "