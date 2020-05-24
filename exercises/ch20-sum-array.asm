## Sum all integers, the positive integers,
## and the negative integers in an array.

## Registers:
##  $8 -- count
##  $9 -- pointer to the array entry
## $10 -- current array entry
## $11 -- sum of all integers
## $12 -- sum of negative integers
## $13 -- sum of positive integers
## $14 -- pos. or neg. flag
## $15 -- SIZE of the array

         .text
         .globl  main

# Initialize
main:
        ori   $8, $0, 0     # count = 0
        ori   $11, $0, 0    # sum = 0
        ori   $12, $0, 0    # neg = 0
        ori   $13, $0, 0    # pos = 0

        lui   $9, 0x1000    # point at SIZE
        lw    $15, 0($9)    # get SIZE

        addiu $9, $9, 4     # point to first entry

# while  count < SIZE do
loop:
        beq   $8, $15, done
        sll   $0, $0,0      # branch delay

# get entry, add to sum
        lw    $10, 0($9)    # get entry
        sll   $0, $0, 0     # load delay
        addu  $11, $11, $10 # add to sum

#  test neg. or pos.
        slti  $14, $10, 0x0 # set flag if entry is neg
         
        bne   $14, $0, neg  # branch if negative
        sll   $0, $0, 0     # branch delay

        addu  $13, $13, $10 # positive: add to PLUS
        j     ifend
        sll   $0, $0, 0     #  branch delay

neg:
        addu  $12, $12, $10 #  negative: add to NEG


ifend:
        addiu $8, $8, 1     # count++
        addiu $9, $9, 4     # point at next entry

        j     loop
        sll   $0, $0, 0       # branch delay

done:   
        sll   $0, $0, 0        #  target for branch

        .data
size:   .word  4
array:  .word  1, 2, -2, -1
