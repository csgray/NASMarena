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
    pro db "Enter your input ('attack', 'defend', or 'flee'):",0xa  ; string with new line
    proLen equ $ - pro
    attOut db "You attack!",0xa
    attOutLen equ $ - attOut
    damOut DB " damage!",0xa
    dam_l EQU $ - damOut
    defOut db "You defend!",0xa
    defOutLen equ $ - defOut
    runOut db "Coward!",0xa
    runOutLen equ $ - runOut
    
    ; User commands
    att db "attack"
    attlen equ $ - att
    def db "defend"
    deflen equ $ - def
    run db "flee"
    runlen equ $ - run

section .text           ; program code
global _start

_start:
    mov rsi, pro        ; Prompts user to "attack", "defend", or "flee"
    mov rdx, proLen     ; length of string
    call write
    call read
   
    call compareAttack  ; Checks if user attacks
    call compareDefend  ; Checks if user defends
    call compareFlee    ; Checks if user flees 

    jmp _start          ; Back to start of program loop
