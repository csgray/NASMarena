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

; compareQuit
; Does string comparison to see if the user entered "quit"
; then exits the program if they did.
compareQuit:
    mov esi, inp        ; User input
    mov edi, quit       ; Comparison string ("quit")
    mov ecx, quit_l     ; Length of comparison string
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz exit          ; Jump when ecx is 0 (strings match)
    ret

; exit
; Uses Linux system calls to properly terminate the program.
exit:
    mov rax, 60         ; system call number (sys_exit)
    syscall

; compareBarbarian
; Does string comparison to see if the user entered "barb".
compareBarbarian:
    mov esi, inp        ; User input
    mov edi, barb       ; Comparison string ("barb")
    mov ecx, 5          ; Length of comparison string + 1
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz selectBarb    ; Jump when ecx is 0 (strings match)
    ret

selectBarb:
    mov r8, barbarian
    jmp selectMonster

; compareBard
; Does string comparison to see if the user entered "bard".
compareBard:
    mov esi, inp        ; User input
    mov edi, bard_s     ; Comparison string ("bard")
    mov ecx, 5          ; Length of comparison string + 1
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz selectBard    ; Jump when ecx is 0 (strings match)
    ret

selectBard:
    mov r8, bard
    jmp selectMonster

; compareCleric
; Does string comparison to see if the user entered "cler".
compareCleric:
    mov esi, inp        ; User input
    mov edi, cler       ; Comparison string ("cler")
    mov ecx, 5          ; Length of comparison string + 1
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz selectCleric  ; Jump when ecx is 0 (strings match)
    ret

selectCleric:
    mov r8, cleric
    jmp selectMonster

; compareDruid
; Does string comparison to see if the user entered "drui".
compareDruid:
    mov esi, inp        ; User input
    mov edi, drui       ; Comparison string ("drui")
    mov ecx, 5          ; Length of comparison string + 1
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz selectDruid   ; Jump when ecx is 0 (strings match)
    ret

selectDruid:
    mov r8, druid
    jmp selectMonster

; compareGoblin
; Does string comparison to see if the user entered "gob".
compareGoblin:
    mov esi, inp        ; User input
    mov edi, gob       ; Comparison string ("gob")
    mov ecx, 4          ; Length of comparison string + 1
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz selectGoblin  ; Jump when ecx is 0 (strings match)
    ret

selectGoblin:
    mov r9, goblin
    jmp combat

; compareOrc
; Does string comparison to see if the user entered "orc".
compareOrc:
    mov esi, inp        ; User input
    mov edi, orc_s      ; Comparison string ("orc")
    mov ecx, 4          ; Length of comparison string + 1
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz selectOrc     ; Jump when ecx is 0 (strings match)
    ret

selectOrc:
    mov r9, orc
    jmp combat

; compareTroll
; Does string comparison to see if the user entered "tro".
compareTroll:
    mov esi, inp        ; User input
    mov edi, tro        ; Comparison string ("tro")
    mov ecx, 4          ; Length of comparison string + 1
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz selectTroll  ; Jump when ecx is 0 (strings match)
    ret

selectTroll:
    mov r9, troll
    jmp combat

; compareAttack
; Does string comparison to see if the user entered "attack".
compareAttack:
    mov esi, inp        ; User input
    mov edi, att        ; Comparison string ("attack")
    mov ecx, attlen     ; Length of comparison string
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz attack        ; Jump when ecx is 0 (strings match)
    ret

attack:
    mov rsi, r8
    add rsi, Character.flavor
    mov rdx, [r8 + Character.flavor_l]
    call write
    call monAttack
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
    call monAttack
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
    jmp _start

; monAttack
; Prints the selectMonster's attack message
monAttack:
    mov rsi, r9
    add rsi, Character.flavor
    mov rdx, [r9 + Character.flavor_l]
    call write
    ret