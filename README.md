# NASM Arena
### Pick a character, pick a monster, and duke it out in your terminal.

Written for CS301 Assembly Language Programming, NASM Arena is an exercise in making a complete program using nothing but pure x86_64 assembly. No C functions allowed. Input and output are done utilizing raw Linux system calls.

Currently, you can select your character, select your monster, and start combat with an initiative check. You can attack to see that each monster and character uses a different weapon. Defend doesn't do anything and flee returns you to the main menu.

## Getting Started
Run the following commands in your terminal in the directory containing the files to assemble, link, and run the program:  
nasm -f elf64 arena.asm  
ld -m elf_x86_64 arena.o -s -o arena  
./arena

Or do it all in one shot:  
nasm -f elf64 arena.asm && ld -m elf_x86_64 arena.o -s -o arena && ./arena

Then follow the on-screen prompts.

## Files
* arena.asm: Contains the game loop, prompts, and command strings.
* subroutines.asm: Contains the subroutines called by adventure.asm
* characters.asm: Defines the Character struct, holds the character structs, and lists the character selection strings.
* bestiary.asm: Holds the monster structs (which use the Character struct) and lists the monster selection strings.
* title.asm: Holds tile screen ASCII art. Because why not?

## Features
- [x] string output using raw Linux system calls
- [x] string input using raw Linux system calls
- [x] user commands through string comparison
- [x] character structs
- [x] monster structs
- [x] customized output based on user selections
- [ ] integer output
- [ ] string concatenation (combining string and integer output)
- [ ] random number generator
- [ ] combat engine
