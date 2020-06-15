          .globl   main
          .text
main:                                 # object1.print(); 
          la       $a0,object1        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method
                                      # object1.cancel();
          la       $a0,object1        #   get address of first object
          lw       $t0,4($a0)         #   get address of cancel method
          jalr     $t0                #   call the method
                                      # object1.print();
          la       $a0,object1        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method
                                      # object2.print();         
          la       $a0,object2        #   get address of second object
          lw       $t0,0($a0)         #   get address of object's method
          jalr     $t0                #   call the object's method
          
          li      $v0,10              # return to OS
          syscall

# Objects constructed in static memory.
# The implementation of an object consists of the data for each object
# and a jump table of entry points common to all objects
# of this type.

          .data
object1:
          .word    print                    # Jump Table
          .word    cancel
          .asciiz  "Hello World\n"          # This object's data

object2:
          .word    print                    # Jump Table
          .word    cancel
          .asciiz  "Silly Example\n"        # This object's data

# print() method
# Parameter: $a0 == address of the object
          .text         
print:
          li       $v0,4                   # print string service
          addiu    $a0,$a0,8               # address of object's string
          syscall                          # 
          jr       $ra
          
# cancel() method
# Parameter: $a0 == address of the object
# 
# Registers:
# $t0 == address of the char in the string
# $t1 == char from the string
# $t2 == 'x'

          .text         
cancel:
          addiu    $t0,$a0,8       # the string starts 8 bytes
                                   # from the start of the object
          li       $t2,'x'         # replacement character                             
          lb       $t1,0($t0)      # get first ch of string
loop:     beqz     $t1,done        # while ( ch != '\0' )
          sb       $t2,0($t0)      #   replace ch with 'x'
          addiu    $t0,$t0,1       #
          lb       $t1,0($t0)      #   get next ch
          b        loop            # end while     
done:
          jr       $ra             # return to caller