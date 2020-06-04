## maxExp -- compute the maximum of three expressions
##
## Input:
## $a0 -- a signed integer, x
## $a1 -- a signed integer, y
##
## Returns:
## $v0 -- the maximum of x*x,  x*y, or 5*y
##
## Registers:
## $s0 --  x*x
## $s1 --  x*y
## $s2 --  5*y

         .text
         .globl maxExp

maxExp:
         # prolog
         sub     $sp, $sp, 4        # push the return address
         sw      $ra, ($sp)

         sub     $sp, $sp, 4        # push $s0
         sw      $s0, ($sp)

         sub     $sp, $sp, 4        # push $s1
         sw      $s1, ($sp)

         sub     $sp, $sp, 4        # push $s2
         sw      $s2, ($sp)

         # body
         mul     $s0, $a0, $a0      # x*x
         mul     $s1, $a0, $a1      # x*y
         li      $t0, 5
         mul     $s2, $t0, $a1      # 5*y
         
         # subroutine maxInt call
         move    $a0, $s0           # compute max of x*x
         move    $a1, $s1           # and x*y
         jal     maxInt             # max returned in $v0
         nop
         # subroutine maxInt return

         # subroutine maxInt call
         move    $a0, $v0           # compute max of
         move    $a1, $s2           # current max, and 5*y 
         jal     maxInt             # total max will be in $v0
         nop
         # subroutine maxInt return

         # epilog
         lw      $s2, ($sp)         # pop $s2
         add     $sp, $sp, 4

         lw      $s1, ($sp)         # pop $s1
         add     $sp, $sp, 4

         lw      $s0, ($sp)         # pop $s0
         add     $sp, $sp, 4

         lw      $ra, ($sp)         # pop return address
         add     $sp, $sp, 4

         jr      $ra                # return to caller
         nop
