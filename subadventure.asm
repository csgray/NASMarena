; subadventure.asm
; Corey S. Gray
; Project for CS 301
;
; Defines subroutines for "adventure.asm" 

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
    mov rsi, attOut
    mov rdx, attOutLen
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