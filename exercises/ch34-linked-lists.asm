## Hard-coded linked list
##
          .text
          .globl main
          
main:
          la     $s0,head       # get pointer to head
          
loop:     beqz   $s0,done       # while not null
          lw     $a0,0($s0)     #   get the data 
          li     $v0,1          #   print it
          syscall               #
          la     $a0,sep        #   print separator
          li     $v0,4
          syscall
          lw     $s0,4($s0)     #   get next
          b      loop
          
done:     la     $a0,linef      # print end of line
          li     $v0,4
          syscall               # print ending message
          la     $a0,endmess
          li     $v0,4
          syscall
          
          li     $v0,10         # return to OS
          syscall   
           
          .data

head:
elmnt01:  .word  1
          .word  elmnt02

elmnt02:  .word  2
          .word elmnt03 

elmnt03:  .word  3
          .word elmnt04 

elmnt04:  .word  5
          .word  elmnt05
          
elmnt05:  .word  7
          .word  0

sep:      .asciiz "  "
linef:    .asciiz "\n"
endmess:  .asciiz "done\n"