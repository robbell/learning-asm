          .globl   main
          .text
main:                                 # object1.print();
          la       $a0,object1        #   get address of first object
          lw       $t0,0($a0)         #   get address of object's method
          jalr     $t0                #   call the object's method
                                      
                                      # object2.print();
          la       $a0,object2        #   get address of second object
          lw       $t0,0($a0)         #   get address of object's method
          jalr     $t0                #   call the object's method
          
          li      $v0,10              # return to OS
          syscall

# Objects constructed in static memory.  An object consists of the data 
# for each object and a jump table of entry points common to all objects
# of its type.
          .data
object1:
          .word    print                    # Jump Table
          .asciiz  "Hello World\n"          # This object's data

object2:
          .word    print                    # Jump Table
          .asciiz  "Silly Example\n"        # This object's data

# Single copy of the print method
# Parameter: $a0 == address of the object
          .text         
print:
          li       $v0,4                   # print string service
          addu     $a0,$a0,4               # address of object's string
          syscall                          # 
          jr       $ra