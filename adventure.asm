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
    call prompt         ; Prompts user to "attack", "defend", or "flee"
    call compareAttack  ; Checks if user attacks
    call compareDefend  ; Checks if user defends
    call compareFlee    ; Checks if user flees 

    jmp _start          ; Back to start of program loop

exit:
    mov rax, 60         ; system call number (sys_exit)
    syscall

prompt:
    mov rax, 1          ; system call number (sys_write)
    mov rdi, 1          ; file descriptor (standard output)
    mov rsi, pro        ; output string
    mov rdx, proLen     ; length of string
    syscall

    mov rax, 0          ; system call number (sys_read)
    mov rdi, 0          ; file descriptor (standard input)
    mov rsi, inp        ; input buffer
    mov rdx, inpLen     ; length of input
    syscall
    ret   

compareAttack:
    mov esi, inp        ; User input
    mov edi, att        ; Comparison string ("attack")
    mov ecx, attlen     ; Length of comparison string
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz attack        ; Jump when ecx is 0 (strings match)
    ret

attack:
    mov rax, 1          ; system call number (sys_write)
    mov rdi, 1          ; file descriptor (standard output)
    mov rsi, attOut     ; output string
    mov rdx, attOutLen  ; length of string
    syscall
    ret

compareDefend:
    mov esi, inp        ; User input (reload because cmpsb increments)
    mov edi, def        ; Comparison string ("defend")
    mov ecx, deflen     ; Length of comparison string
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz defend        ; Jump when ecx is 0 (strings match)
    ret

defend:
    mov rax, 1          ; system call number (sys_write)
    mov rdi, 1          ; file descriptor (standard output)
    mov rsi, defOut     ; output string
    mov rdx, defOutLen  ; length of string
    syscall
    ret

compareFlee:
    mov esi, inp        ; User input (reload because cmpsb increments)
    mov edi, run        ; Comparison string ("flee")
    mov ecx, runlen     ; Length of comparison string
    repe cmpsb          ; Continue comparison of characters are equal
    jecxz flee          ; Jump when ecx is 0 (strings match)
    ret

flee:
    mov rax, 1          ; system call number (sys_write)
    mov rdi, 1          ; file descriptor (standard output)
    mov rsi, runOut     ; output string
    mov rdx, runOutLen  ; length of string
    syscall
    call exit
