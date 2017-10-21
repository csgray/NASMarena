; subroutines.asm
; Corey S. Gray
; Project for CS 301
;
; Defines subroutines for "arena.asm" 

SECTION .text
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
    mov rsi, input      ; input buffer
    mov rdx, input_l    ; length of input
    syscall
    ret 

; compareQuit
; Does string comparison to see if the user entered "quit"
; then exits the program if they did.
compareQuit:
    mov esi, input      ; User input
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
; Does string comparison to see if the user entered "barb"
; then loads the "barbarian" struct if they did.
compareBarbarian:
    mov esi, input      ; User input
    mov edi, barb       ; Comparison string ("barb")
    mov ecx, 5          ; Length of comparison string + 1
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz selectBarb    ; Jump when ecx is 0 (strings match)
    ret

; selectBarb
; Loads the "barbarian" struct into r8 to be used by other subroutines
; then advances the program to monster selection.
selectBarb:
    mov r8, barbarian
    jmp selectMonster

; compareBard
; Does string comparison to see if the user entered "bard"
; then loads the "bard" struct if they did.
compareBard:
    mov esi, input      ; User input
    mov edi, bard_s     ; Comparison string ("bard")
    mov ecx, 5          ; Length of comparison string + 1
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz selectBard    ; Jump when ecx is 0 (strings match)
    ret

; selectBard
; Loads the "bard" struct into r8 to be used by other subroutines
; then advances the program to monster selection.
selectBard:
    mov r8, bard
    jmp selectMonster

; compareCleric
; Does string comparison to see if the user entered "cler"
; then loads the "cleric" struct if they did.
compareCleric:
    mov esi, input      ; User input
    mov edi, cler       ; Comparison string ("cler")
    mov ecx, 5          ; Length of comparison string + 1
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz selectCleric  ; Jump when ecx is 0 (strings match)
    ret

; selectCleric
; Loads the "cleric" struct into r8 to be used by other subroutines
; then advances the program to monster selection.
selectCleric:
    mov r8, cleric
    jmp selectMonster

; compareDruid
; Does string comparison to see if the user entered "drui"
; then loads the "druid" struct if they did.
compareDruid:
    mov esi, input      ; User input
    mov edi, drui       ; Comparison string ("drui")
    mov ecx, 5          ; Length of comparison string + 1
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz selectDruid   ; Jump when ecx is 0 (strings match)
    ret

; selectDruid
; Loads the "druid" struct into r8 to be used by other subroutines
; then advances the program to monster selection.
selectDruid:
    mov r8, druid
    jmp selectMonster

; compareGoblin
; Does string comparison to see if the user entered "gob"
; then loads the "goblin" struct if they did.
compareGoblin:
    mov esi, input      ; User input
    mov edi, gob        ; Comparison string ("gob")
    mov ecx, 4          ; Length of comparison string + 1
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz selectGoblin  ; Jump when ecx is 0 (strings match)
    ret

; selectGoblin
; Loads the "goblin" struct into r9 to be used by other subroutines
; then starts combat by jumping to initiative.
selectGoblin:
    mov r9, goblin
    jmp initiative

; compareOrc
; Does string comparison to see if the user entered "orc"
; then loads the "orc" struct if they did.
compareOrc:
    mov esi, input      ; User input
    mov edi, orc_s      ; Comparison string ("orc")
    mov ecx, 4          ; Length of comparison string + 1
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz selectOrc     ; Jump when ecx is 0 (strings match)
    ret

; selectOrc
; Loads the "orc" struct into r9 to be used by other subroutines
; then starts combat by jumping to initiative.
selectOrc:
    mov r9, orc
    jmp initiative

; compareTroll
; Does string comparison to see if the user entered "tro"
; then loads the "troll" struct if they did.
compareTroll:
    mov esi, input      ; User input
    mov edi, tro        ; Comparison string ("tro")
    mov ecx, 4          ; Length of comparison string + 1
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz selectTroll   ; Jump when ecx is 0 (strings match)
    ret

; selectTroll
; Loads the "troll" struct into r9 to be used by other subroutines
; then starts combat by jumping to initiative.
selectTroll:
    mov r9, troll
    jmp initiative

; compareAttack
; Does string comparison to see if the user entered "attack"
; then executes the attack subroutine if they did.
compareAttack:
    mov esi, input      ; User input
    mov edi, att        ; Comparison string ("attack")
    mov ecx, att_l     ; Length of comparison string
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz attack        ; Jump when ecx is 0 (strings match)
    ret

; attack
; Outputs the character-specific attack message.
attack:
    mov rsi, r8
    add rsi, Character.flavor
    mov rdx, [r8 + Character.flavor_l]
    call write
    ret

; compareDefend
; Does string comparison to see if the user entered "defend"
; then executes the defend subroutine if they did.
compareDefend:
    mov esi, input      ; User input (reload because cmpsb increments)
    mov edi, def        ; Comparison string ("defend")
    mov ecx, def_l      ; Length of comparison string
    repe cmpsb          ; Continue comparison if characters are equal
    jecxz defend        ; Jump when ecx is 0 (strings match)
    ret

; defend
; Outputs the defend message.
defend:
    mov rsi, defOut     ; output string
    mov rdx, defOut_l   ; length of string
    call write
    ret

; compareFlee
; Does string comparison to see if the user entered "flee"
; then executes the flee subroutine if they did.
compareFlee:
    mov esi, input      ; User input (reload because cmpsb increments)
    mov edi, run        ; Comparison string ("flee")
    mov ecx, run_l      ; Length of comparison string
    repe cmpsb          ; Continue comparison of characters are equal
    jecxz flee          ; Jump when ecx is 0 (strings match)
    ret

; flee
; Outputs the flee message then restarts the program.
flee:
    mov rsi, runOut     ; output string
    mov rdx, runOut_l   ; length of string
    call write
    jmp _start

; monAttack
; Outputs the monster-specific attack message
monAttack:
    mov rsi, r9
    add rsi, Character.flavor
    mov rdx, [r9 + Character.flavor_l]
    call write
    ret
