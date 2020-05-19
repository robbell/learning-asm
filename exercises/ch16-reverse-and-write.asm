## Copy $9 to memory in big-endian order
##
## Register Use:
## $8  --- first byte of the tape buffer
## $9  --- 4-byte integer

        .text
        .globl  main

main: 
        lui  $9, 0x1234     # put data in $9
        ori  $9, 0x5678     #

        lui  $8, 0x1000     # $8 is base register
        sb   $9, 3($8)      # least significant byte

        srl  $9, $9, 8      # move next byte to low order
        sb   $9, 2($8)      # bits 8-15 

        srl  $9, $9, 8      # move next byte to low order
        sb   $9, 1($8)      # bits 16-23 

        srl  $9, $9, 8      # move next byte to low order
        sb   $9, 0($8)      # most significant byte

      .data
tape:                       # base register points here
      .space 1024           # tape buffer (1K bytes)

## End of file