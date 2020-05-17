## Program to assemble the instruction ori  $8, $9, 0x004A

        .text
        .globl  main

main:
        or    $25, $0, $0        # Clear $25
        ori   $11, $0, 0xD       # Opcode
        ori   $12, $0, 0x9       # Operand $s
        ori   $13, $0, 0x8       # Dest. $d
        ori   $14, $0, 0x004A    # Immediate operand
        
        sll   $11, $11, 26       # Shift opcode into position
        or    $25, $25, $11      # Or it into the instruction
        
        sll   $12, $12, 21       # Shift operand $s into position
        or    $25, $25, $12      # Or it into the instruction
        
        sll   $13, $13, 16       # Shift dest $d into position
        or    $25, $25, $13      # Or it into the instruction
        
        or    $25, $25, $14      # Or const into the instruction
        
        ori   $8, $9, 0x004A     # The actual assembler
                                 # should create the same machine
                                 # instruction as we now have in $25
                                 # (3528004a)

## End of file
