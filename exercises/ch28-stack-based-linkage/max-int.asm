## maxInt -- compute the maximum of two integer arguments
##
## Input:
## $a0 -- a signed integer
## $a1 -- a signed integer
##
## Returns:
## $v0 -- maximum

         .text
         .globl maxInt

maxInt:
          # body
          move   $v0, $a0           # max = $a0
          bgt    $a0, $a1, endif    # if $a1 > $a0  
          nop
          move   $v0, $a1           # max = $a1
endif:                              # endif 
          # epilog
          jr    $ra
          nop
