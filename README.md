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

### Use `ori` to load a register with a negative integer

`ori` (bitwise or immediate) will accept a 16 bit constant and load it into a 32 bit register. The binary representation will be zero padded to fill 32 bits, so can't be a two's complement negative integer at loading time.

To use `ori` to load a negative 16 bit integer into a 32 bit register:

1. Use `ori` to load the **positive** version of the integer into a register:

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

### -U suffix for MIPS `add` and `mult` operations

There is a -u variant for both the `add` and `mult` MIPS operations but they both have different meanings:

* `add` and `addu` both perform the same operation, add, but the -u suffix means don't trap the overflow

* `mult` and `multu` perform different operation: `mult` is for use with two's complement operands; `multu` is for use with unsigned operands. The same is true for `div` and `divu` operations.

### MIPS units

| Name     | Bytes | Bits |
|----------|-------|------|
| word     | 4     | 32   |
| halfword | 2     | 16   |

### `j` (jump) address calculation

```
# jump instruction
0000 1010 1100 0101 0001 0100 0110 0010
^-----^^------------------------------^
op-code          26 bit target
```

After excluding the op-code, a `j` instruction only has 26 spare bits in which to define the jump destination address. In order to calculate the 32 bit jump location two transformations happen:

1. The 26 bits are word aligned by shifting the 26 bits **left** two places (inserting 00 into the low-order bits):

    ```
    10 1100 0101 0001 0100 0110 0010 00
    ^------------------------------^ ^^
              26 bit target          WA
    ```

1. The four high-order bits from the PC for the original jump instruction are prepended:

    ```
    01 0110 1100 0101 0001 0100 0110 0010 00
    ^---^^------------------------------^ ^^
     PC            26 bit target          WA
    ```
