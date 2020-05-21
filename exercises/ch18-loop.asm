# Assembly loop

init:   ori    $8, $0, 0        # count = 0
        ori    $10, $0, 0       # total = 0

test:   sltiu  $9, $8, 10       # count < 10
        beq    $9, $0, endLp    # end loop if $9 = 1
        sll    $0, $0, 0        # branch delay

        addu   $10, $10, $8     # sum integers

        addiu  $8, $8, 1        # count++
        j      test
        sll    $0, $0, 0        # branch delay

endLp:  sll    $0, $0, 0        # branch target