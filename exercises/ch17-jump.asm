## loop using jump to main 
##
      .text
      .globl  main

main: 
      sll    $0, $0, 0 #no-ops
      sll    $0, $0, 0 #
      sll    $0, $0, 0 #
      sll    $0, $0, 0 #
      j      main      # jump to main symbolic address
      addiu  $8, $8, 1 # branch delay
      
## End of file
