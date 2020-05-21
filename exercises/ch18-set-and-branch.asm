## Check that   30 <= temp <= 55
## Set flag to 1 if in range,  to 0 if out of range
##
## Registers:
## $2 -- input temperature
## $3 -- in range / out of range indicator flag
## $8 -- scratch

      .text
      .globl  main

# Set range indicator to 1
main:   
        ori     $3, $0, 1    #  set to 1

# Test  30 <= temp <= 55
        sltiu   $8, $2, 56   # $8 = 1 if temp <= 55 (set on less than immediate unsigned)
        beq     $8, $0, out  # 0? out of range
        sll     $0, $0, 0    # branch delay

        sltiu   $8, $2, 30   # $8 = 1 if temp < 30
        beq     $8, $0, cont # 0? in range
        sll     $0, $0, 0    # branch delay

# Out of Range: clear range indicator to 0
out:
        ori     $3, $0, 0    # clear flag to 0

# Continue
cont:   
        sll     $0, $0, 0    # target for the jump
