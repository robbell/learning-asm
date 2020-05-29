main:
        li    $v1, 0            # zero the sum
loop:
        . . . .                  # prompt the user for input

        li    $v0, 5            # read the integer
        syscall                 # into $v0

        beq $v0, -999, done     # while ( $v0 != -999 )

        blt $v0, -32, out       # less than -32

        bgt $v0, 32, out        # greater than 32

        addu  $v1, $v1, $v0     # if in range add
                                # else skip

out:    b     loop

done:   . . . .                 # write out result