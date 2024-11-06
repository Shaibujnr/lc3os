# Operating System For LC-3

This readme contains information about the LC3 OS as well as the target simulator and some tips and hints for me to quickly refer to
while hacking this thing together.

## Target
This OS will target PennSim's extended implementation of the LC3 ISA.

## Specification

This is going to be a very simple OS that does the following:

- Manages the CPU
- Manges memory
- Support executing some number of user programs; the number of user programs to be supported will be deteremined
- Provide system calls for user programs
- Support cooperative multi-tasking or perhaps pre-emptive multi tasking since PennSim's Simulator seem to support timer interrupt

User programs would be able to:
- Accept keyboard input
- Output to the monitor



# LC3

- 16 bits memory address with 16 bits addressability

## Memory Layout
- x0000 to x00FF is for trap vector table
- x0100 to x01FF is for interrupt vector table
- x0200 to x2FFF is memory of Os include Os stack

NOTE: x0000 to x2FFF is managed by OS therefore only programs running in prvileged mode can access these

- x3000 to xFDFF is for User program and these include the user stack
- xFE00 to xFFFF is for memory mapped IO. Keyboard and Monitor are mapped here


- xFE00 Keyboard status register (KBSR) The ready bit(bit[15])indicates if the keyboard has received a
new character.
- xFE02 Keyboard data register(KBDR) Bits[7:0] contain the last character typed on the keyboard.
- xFE04 Display status register(DSR) The ready bit(bit[15]) indicates if the display device is ready to
receive another character to print on the screen.
- xFE06 Display data register (DDR) A character written in bits[7:0] willbe displayed on the screen.
- xFFFC Processor Status Register (PSR) Contains privilege mode, priority level and condition codes of
the currently executing process.
- xFFFE Machinecontrol register(MCR) Bit[15] is the clock

x8002 is 1000 0000 0000 0010

## Quick Hints and References

### Call Return Mechanism
- The caller calls `JSR(R)` and what `JSR(R)` does is, it loads the PC with the starting address of the subroutine
to be called and also loads R7 with the return address (the address immediately after the JSR instruction)
- The subroutine called JMP R7 when it's done to return back to the caller

### Stack
- L6 -> Stack Pointer


### Interrupts and Traps
* Keyboard interrrupts at vector x80 - I/O interrupt => x0180
* Privilege mode exception - x00 => x0100 (Processor extends)
* Illegal Opcode - x01 => x0101 (Processor extends)
* ACV exception - x02 => x0102 (Processor extends)