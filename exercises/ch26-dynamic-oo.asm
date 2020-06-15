          .globl   main
          .text
main:                                 # object1 = new object(); 
          li       $v0,9              #   allocate 32 bytes
          li       $a0,32             #  
          syscall                     #   $v0 = address
          sw       $v0,object1        #
          
          la       $t0,print          #   initialize jump table
          sw       $t0,0($v0)         #   
          la       $t0,read           #
          sw       $t0,4($v0)         #
          
                                      # object1.read();
          lw       $a0,object1        #   get address of object1
          lw       $t0,4($a0)         #   get address of read method
          jalr     $t0                #   call the method
          
                                      # object1.print();
          lw       $a0,object1        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method
          
          li      $v0,10              # return to OS
          syscall

          .data
object1:  .word    0
object2:  .word    0

# print() method
# Parameter: $a0 == address of the object
          .text         
print:
          li       $v0,4              # print string service
          addiu    $a0,$a0,8          # address of object's string
          syscall                     # 
          jr       $ra
          
# read() method
# Parameter: $a0 == address of the object
# 
          .text         
read:
          move     $s1,$a0            # save object's address
          li       $v0,4              # print string service
          la       $a0,prompt         # address of object's string
          syscall                     # 
          
          addiu    $a0,$s1,8          # $a0 = address of buffer
                                      #       in object
          li       $a1,24             # $a1 = size of buffer
          li       $v0,8              # read string service
          syscall 
 
          jr       $ra                # return to caller

          .data
prompt:   .asciiz  "enter data > "