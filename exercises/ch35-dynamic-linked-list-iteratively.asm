# Dynamic linked list iteratively

        .text
        .globl  main

main:    
        # create the linked list
        
        # $s1 --- current node in creation loop
        # $s2 --- loop counter
        
        # create the first node 
        li      $v0,9             # allocate memory
        li      $a0,8             # 8 bytes
        syscall                   # $v0 <-- address
        move    $s1,$v0           # $s1 = &(first node)
        
        # copy the pointer to first
        sw      $s1,first
        
        # initialize the first node
        li      $t0,1             # store 1
        sw      $t0,0($s1)        # at displacement 0

        # create the remaining nodes in a counting loop
        li      $s2,2             # counter = 2
        li      $s3,8             # upper limit
        
loop:   bgtu    $s2,$s3,done      # while (counter <= limit )
        
        # create a node 
        li      $v0,9             # allocate memory
        li      $a0,8             # 8 bytes
        syscall                   # $v0 <-- address
        
        # link this node to the previous
                                  # $s1 = &(previous node)
        sw      $v0,4($s1)        # copy address of the new node
                                  # into the previous node
        
        # make the new node the current node
        move    $s1,$v0
        
        # initialize the node
        sw      $s2,0($s1)        # at displacement 0

        addi    $s2,$s2,1         # counter++
        b       loop
        
done:
        # end the list
        sw      $0,4($s1)         # put null in the link field
                                  # of the current node, which
                                  # is the last node.
        
        # print out the list
        # $s0 --- current node in print loop
                                          
        lw     $s0,first          # get a pointer to the first node
lp:     beqz   $s0,endlp          # while the pointer is not null
        lw     $a0,0($s0)         #   get the data of this node
        li     $v0,1              #   print it
        syscall                   #
        la     $a0,sep            #   print separator
        li     $v0,4              #
        syscall                   #
        
        lw     $s0,4($s0)         #   get the pointer to the next node
        b      lp
          
endlp:   
        li      $v0,10            # return to OS
        syscall       

       .data
first: .word   0
sep:   .asciiz "  "
