## li pseudo instruction translated three ways

        .text
        .globl  main

main:
        li    $t0, 43         # ori $8, $0, 43

        li    $t1, -96        # lui $1, -1
                              # ori $9, $1, -96
        
        li    $t7, -16772555  # lui $1, -256
                              # ori $15, $1, 4661
        
        addu  $t0, $t0, $t1   # add the values
        addu  $t0, $t0, $t7   # leave result in $t0
