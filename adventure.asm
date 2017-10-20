; adventure.asm
; Corey S. Gray
; Project for CS 301
;
; This is the start of a text-based adventure game written in assembly.
; There is a program loop which makes function calls to prompt the user for input,
; process that input through string comparison, and respond accordingly. Input, output,
; and exiting are done through raw Linux system calls. 
;
; Subroutines are written in a separate file to make the code more manageable.
; Use this file to update the game loop and ouput strings.
;
; Assemble: nasm -f elf64 adventure.asm
; Link: ld -m elf_x86_64 adventure.o -s -o adventure
; Run: ./adventure

%INCLUDE "subadventure.asm" ; separate file for subroutines
%INCLUDE "characters.asm"   ; character structs
%INCLUDE "bestiary.asm"     ; monster structs

section .bss            ; uninitialized variables (buffers)
    inp resb 10;
    inpLen equ $ - inp

section .data           ; initialized variables 
    ; Output strings
    select db "Choose your character ('barbarian', 'bard', 'cleric', 'druid') or",0xa,"enter 'quit' to do just that:",0xa
    select_l EQU $ - select
    monster DB "Choose your opponent ('goblin', 'orc', or 'troll'):",0xa
    monster_l EQU $-monster
    commands db "Enter your input ('attack', 'defend', or 'flee'):",0xa  ; string with new line
    commands_l equ $ - commands
    defOut db "You defend!",0xa
    defOutLen equ $ - defOut
    runOut db "Coward!",0xa
    runOutLen equ $ - runOut
    
    ; User commands
    quit DB "quit"
    quit_l EQU $-quit
    att db "attack"
    attlen equ $ - att
    def db "defend"
    deflen equ $ - def
    run db "flee"
    runlen equ $ - run

section .text           ; program code
global _start

_start:
    mov rsi, select
    mov rdx, select_l
    call write
    call read
    
    call compareQuit
    call compareBarbarian
    call compareBard
    call compareCleric
    call compareDruid
    ;call compareFighter
    ;call comparePaladin
    ;call compareRanger
    ;call compareRogue
    ;call compareSorcerer
    ;call compareWizard
    jmp _start          ; Back to _start if invalid input

selectMonster:
    mov rsi, monster
    mov rdx, monster_l
    call write
    call read

    call compareGoblin
    call compareOrc
    call compareTroll
    jmp selectMonster   ; Back to monster prompt if invalid input

combat:    
    mov rsi, commands   ; Prompts user to "attack", "defend", or "flee"
    mov rdx, commands_l ; Length of string
    call write
    call read
   
    call compareAttack  ; Checks if user attacks
    call compareDefend  ; Checks if user defends
    call compareFlee    ; Checks if user flees 

    jmp combat          ; Back to start of combat loop
