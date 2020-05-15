# Learning ASM

Working through the MIPS ASM tutorial from https://chortle.ccsu.edu/AssemblyTutorial/.

## Notes

### Two's complement

#### Understanding

Minus one added to plus one gives zero. So if a particular bit pattern results in the pattern that represents zero when added to one, it can represent minus one.

```
 11111 111  
  0000 0001 =  1 base 10 
- 1111 1111 = -1 base 10  
  ---------   --
  1111 1111 =  0 base 10
```

#### Construction

1. Start with an N-bit representation of an integer:

    ```
    0011 1001
    ```
1. Reflect each bit:

    ```
    1100 0110
    ```

1. Add one:

    ```
    1100 0111
    ```

#### Use ORI to load a register with a negative integer

ORI (bitwise or immediate) will accept a 16 bit constant and load it into a 32 bit register. The binary representation will be zero padded to fill 32 bits, so can't be a two's complement negative integer at loading time.

To use ORI to load a negative 16 bit integer into a 32 bit register:

1. Use ORI to load the **positive** version of the integer into a register:

    ```
    ori $8, $0, 82
    ```
1. Reflect each bit using NOR:

    ```
    nor $8, $8, $0
    ```

1. Then add one:

    ```
    ori $9, $0, 1  # load 1 into a register
    addu $8, $8, $9 # add 1
    ```

### Binary addition overflow conditions

* **Unsigned binary** - the result is correct if the carry out of the high order column is zero

* **Two's complement** - the result is correct if the *carry into* the high order column is the same as the *carry out* of column. See [chapter 8](https://chortle.ccsu.edu/AssemblyTutorial/Chapter-08/ass08_23.html).