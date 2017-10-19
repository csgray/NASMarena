; adventure.asm
; Corey S. Gray
; Project for CS 301
;
; This is the start of a text-based adventure game written in assembly.
; There is a program loop which makes function calls to prompt the user for input,
; process that input through string comparison, and respond accordingly. Input, output,
; and exiting are done through raw Linux system calls. 
;
; I want to add stats in .data for the player and monsters then make the game commands
; do something appropriate like deal damage. That includes adding a random number generator
; for more interesting combat. I also want to replace redundant code (the system calls)
; with functions that take parameters.
;
; Assemble: nasm -f elf64 adventure.asm
; Link: ld -m elf_x86_64 adventure.o -s -o adventure
; Run: ./adventure

section .bss            ; uninitialized variables (buffers)
    inp resb 10;
    inpLen equ $ - inp

section .data           ; initialized variables 
    ; Output strings
    pro db "Enter your input ('attack', 'defend', or 'flee'):",0xa  ; string with new line
    proLen equ $ - pro
    attOut db "You attack!",0xa
    attOutLen equ $ - attOut
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

; write
; Uses Linux system calls to output to Terminal.
; Requires two parameters moved into the following registries:
;   rsi - the message to write
;   rdx - the length of the message
write:
    mov rax, 1          ; system call number (sys_write)
    mov rdi, 1          ; file descriptor (standard output)
    syscall
    ret

; read
; Uses Linux system calls to reads user input from the Terminal.
; Saves response to "inp" buffer.
read:
    mov rax, 0          ; system call number (sys_read)
    mov rdi, 0          ; file descriptor (standard input)
    mov rsi, inp        ; input buffer
    mov rdx, inpLen     ; length of input
    syscall
    ret 

; exit
; Uses Linux system calls to properly terminate the program.
exit:
    mov rax, 60         ; system call number (sys_exit)
    syscall

; compareAttack
; Does string comparison to see if the user entered "attack".
compareAttack:
    mov esi, inp        ; User input
    mov edi, att        ; Comparison string ("attack")
    mov ecx, attlen     ; Length of comparison string
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz attack        ; Jump when ecx is 0 (strings match)
    ret

; attack
; Prints appropriate message if the user attacks.
attack:
    mov rsi, attOut     ; output string
    mov rdx, attOutLen  ; length of string
    call write
    ret

; compareDefend
; Does string comparison to see if the user entered "defend"
compareDefend:
    mov esi, inp        ; User input (reload because cmpsb increments)
    mov edi, def        ; Comparison string ("defend")
    mov ecx, deflen     ; Length of comparison string
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz defend        ; Jump when ecx is 0 (strings match)
    ret

; defend
; Prints appropriate message if the user defends.
defend:
    mov rsi, defOut     ; output string
    mov rdx, defOutLen  ; length of string
    call write
    ret

; compareFlee
; Does string comparison to see if the user entered "flee"
compareFlee:
    mov esi, inp        ; User input (reload because cmpsb increments)
    mov edi, run        ; Comparison string ("flee")
    mov ecx, runlen     ; Length of comparison string
    repe cmpsb          ; Continue comparison of characters are equal
    jecxz flee          ; Jump when ecx is 0 (strings match)
    ret

; flee
; Prints appropriate message if the user flees and exits the program.
flee:
    mov rsi, runOut     ; output string
    mov rdx, runOutLen  ; length of string
    call write
    call exit
