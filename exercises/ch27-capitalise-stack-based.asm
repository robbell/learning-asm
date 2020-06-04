# This program uses stack-based linkage.  SPIM Settings: allow pseudoinstructions,
# disable delayed branches and disable delayed load, load trap file.
#
         .text
         .globl  main

main:
         sub     $sp,$sp,4        # push the return address
         sw      $ra,($sp)
         
         la      $a0,mainPr       # prompt the user
         li      $v0,4            # service 4
         syscall

         jal     doLines          # process lines of input
         
         lw      $ra,($sp)        # pop return address
         add     $sp,$sp,4
         
         jr      $ra              # return to OS 

         .data
mainPr:  .ascii  "Type each line of text followed by ENTER.\n"
         .asciiz "Type Q at the start of a line to finish.\n"
         
# doLines -- read in and process each line of user input
#
# on entry:
#    $a0 -- address of the prompt text
#
# on exit:
#    no return values

         .text
         .globl  doLines
doLines:   
         sub     $sp,$sp,4        # push the return address
         sw      $ra,($sp)
 
loop:                             # get a line
         la      $a0,line         # argument: address of buffer
         li      $a1,132          # argument: length of buffer
         jal     getLine          # get line from user
         
         la      $a0,line         # if "Q"
         jal     testEnd          # return to caller
         beqz    $v0,endloop          

                                  # convert to capitals
         la      $a0,line         # argument: address of buffer
         la      $a1,132          # argument: length of buffer
         jal     convert
         
         la      $a0,outline      # print out the result
         li      $v0,4
         syscall
         
         b       loop             # continue with next line
         
endloop:          
         lw      $ra,($sp)        # pop return address
         add     $sp,$sp,4         
         jr      $ra              # return to caller 

         .data
outline: .ascii  ":"              # padding so output lines up with input
line:    .space  132              # input buffer
         
# getLine -- read in a line of user input
#
# on entry:
#    $a0 -- address of input buffer
#    $a1 -- length of buffer
#
# on exit:
#    no return values

         .text
         .globl  getLine
getLine:   
         move    $t0,$a0          # save buffer address          
         la      $a0,prompt       # prompt the user
         li      $v0,4            # service 4
         syscall

         move    $a0,$t0          # restore buffer address
         li      $v0,8            # service 8
         syscall                  # read in a line to the buffer
         
         jr      $ra              # return to caller 

         .data
prompt:
         .asciiz ">"
              
# testEnd -- check if a line is 'Q'
#
# on entry:
#    $a0 -- address of input buffer
#
# on exit:
#    $v0 -- 0 if line is equal to Q, 1 if not

         .text
         .globl  testEnd
testEnd:   
         li      $v0,1            # assume not equal
         
         lbu     $t0,0($a0)       # get first char of line
         li      $t1,'Q'          # get 'Q'
         bne     $t0,$t1,endT     # if not equal, end the test
         
         lbu     $t0,1($a0)       # get second char of line
         li      $t1,'\n'         # it should be CR
         bne     $t0,$t1,endT     # if not equal, end the test
          
         li      $v0,0            # 'Q' has been found

endT:                       
         jr      $ra              # return to caller        
         
# convert -- convert a line to all capitals
#
# on entry:
#    $a0 -- address of input buffer
#    $a1 -- length of input buffer
#
# register use:
#    $s0 -- pointer into character buffer
#
# on exit:
#    no return values

         .text
         .globl  convert
convert:   
         sub     $sp,$sp,4        # push the return address
         sw      $ra,($sp)
         sub     $sp,$sp,4        # push $s0
         sw      $s0,($sp)

                                  # for ( p=buffer; *p!=0; p++ )
         move    $s0,$a0          # p=buffer

cloop:   lbu     $a0,($s0)        # get a char from the string
         beqz    $a0,endC         # exit if null byte
                                  # argument a0: char to convert
         jal     conChar          # convert character
         sb      $v0,($s0)        # put converted char into string                 
         addu    $s0,$s0,1        # p++
         b       cloop         
 
endC:   
         lw      $s0,($sp)        # pop $s0 
         add     $sp,$sp,4                                    
         lw      $ra,($sp)        # pop return address
         add     $sp,$sp,4         
         jr      $ra              # return to caller 
       
# conChar -- convert a character to a capital
#
# on entry:
#    $a0 -- character
#
# on exit:
#    $v0 -- converted character

         .text
         .globl  conChar
conChar:   
         move    $v0,$a0          # assume ch will not change
                                  # is ch in 'a' .. 'z' &
         li      $t0,'a'          # ch < 'a' ?
         blt     $a0,$t0,outc    
         li      $t0,'z'          # 'z' < ch ?
         blt     $t0,$a0,outc                     
         sub     $v0,$a0,32       # convert ch to upper case

outc:    jr      $ra              # return to caller 
