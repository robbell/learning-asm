# String formatting example

        .text
        .globl  main

main:   
        # get patron name
        li      $v0, 4           # print prompt
        la      $a0, prompt      #
        syscall

        li      $v0, 8           # code 8 == read string
        la      $a0, name        # $a0 == address of buffer
        li      $a1, 24          # $a1 == buffer length
        syscall                  # Invoke the operating system.

        # print the letter
        li      $v0, 4           # print greeting and newly filled 'name'
        la      $a0, letter      # space, until \0 is reached
        syscall
        
        li      $v0, 4           # print body
        la      $a0, body        #
        syscall

        li      $v0, 10          # exit
        syscall

        .data
prompt: .asciiz "enter name, followed by comma-enter: "
letter: .ascii  "\n\nDear "
name:   .space  24               # The input from the user is 
                                 # written directly to this location

body:   .ascii  "\nYour library books are way\n"
        .ascii  "overdue. Please return them\n"
        .ascii  "before we give your name\n"
        .asciiz "to the enforcement squad.\n\n"