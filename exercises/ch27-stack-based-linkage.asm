subB:
         sub    $sp,$sp,4    # push $ra
         sw     $ra,($sp)

         . . . .

         jal    subC         # call subC
         nop

         . . . .

         lw     $ra,($sp)    # pop return address
         add    $sp,$sp,4
         jr     $ra          # return to caller
         nop

# subC expects to use $s0 and $s1
# subC does not call another subroutine
#
subC:
         sub    $sp,$sp,4    # push $s0
         sw     $s0,($sp)

         sub    $sp,$sp,4    # push $s1
         sw     $s1,($sp)

         . . . .             # statements using $s0 and $s1

         lw     $s1, ($sp)   # pop $s1
         add    $sp,$sp,4

         lw     $s0, ($sp)   # pop $s0
         add    $sp,$sp,4

         jr     $ra          # return to caller
         nop
