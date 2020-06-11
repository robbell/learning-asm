# Allocate memory for a struct and then initialize it.
# Allocate memory for a second struct and copy data
# from the first into it. Print both structs

        .text
        .globl  main

main:    
        # create the first struct 
        li      $v0,9             # allocate memory
        li      $a0,12            # 12 bytes
        syscall                   # $v0 <-- address
        move    $s1,$v0           # $s1 first struct
 
        # initialize the first struct       
        li      $t0,34            # store 34
        sw      $t0,0($s1)        # in age
        lw      $t0,pay           # store 24000
        sw      $t0,4($s1)        # in pay
        li      $t0,12            # store 12
        sw      $t0,8($s1)        # in class

        # create the second struct 
        li      $v0,9             # allocate memory
        li      $a0,12            # 12 bytes
        syscall                   # $v0 <-- address
        move    $s2,$v0           # $s2 second struct
           
        # copy data from first struct to second     
        lw      $t0,0($s1)        # copy age from first
        sw      $t0,0($s2)        # to second struct
        lw      $t0,4($s1)        # copy pay from first
        sw      $t0,4($s2)        # to second struct
        lw      $t0,8($s1)        # copy class from first
        sw      $t0,8($s2)        # to second struct
           
        # write out the first struct    
        move    $a0,$s1
        jal     PStruct
           
        # write out the second struct    
        move    $a0,$s2
        jal     PStruct
        
        li      $v0,10            # return to OS
        syscall       

        .data
pay:    .word   24000             # rate of pay, in static memory

        .text
# Subroutine PStruct: print a struct
#
# Registers: $a0 --- address of the struct
#            $ra --- return address
PStruct:
        sub     $sp,$sp,4         # push $s0
        sw      $s0,($sp)         # onto the stack
        
        move    $s0,$a0           # safe copy of struct address
        
        la      $a0,agest         # print "age:"
        li      $v0,4
        syscall
        lw      $a0,0($s0)        # print age
        li      $v0,1
        syscall

        la      $a0,payst         # print " pay: "
        li      $v0,4
        syscall
        lw      $a0,4($s0)        # print pay
        li      $v0,1
        syscall

        la      $a0,classt         # print " class: "
        li      $v0,4
        syscall
        lw      $a0,8($s0)        # print class
        li      $v0,1
        syscall

        la      $a0,lf            # end the line
        li      $v0,4
        syscall

        add     $sp,$sp,4         # restore $s0 of caller 
        lw      $s0,($sp)
        jr      $ra               # return to caller        

        .data
agest:  .asciiz "age:   "
payst:  .asciiz "  pay:   "
classt: .asciiz "  class: "
lf:     .asciiz "\n"

## end of file