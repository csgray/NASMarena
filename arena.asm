; arena.asm
; Corey S. Gray
; Project for CS 301
;
; This is the start of a text-based arena game written in assembly.
; Character selection, monster selection, and user input are done through string
; comparison. Character and monster details are structs. Input and output are
; done with raw Linux system calls.
;
; TODO: Integer output, string concatenation, random number generator, combat engine.
;
; Code is broken into multiple files for easier managemnet:
;   arena.asm: Use this file to update the game loop, prompts, and command strings.
;   subroutines.asm: Contains subroutines called by adventure.asm
;   characters.asm: Defines the Character struct, holds the character structs, and
;       lists the character selection strings.
;   bestiary.asm: Holds the monster structs (which use the Character struct) and
;       lists the monster selection strings.
;   title.asm: Holds tile screen ASCII art. Because why not?
;
; Assemble: nasm -f elf64 arena.asm
; Link: ld -m elf_x86_64 arena.o -s -o arena
; Run: ./arena

%INCLUDE "subroutines.asm"  ; separate file for subroutines
%INCLUDE "characters.asm"   ; character structs
%INCLUDE "bestiary.asm"     ; monster structs
%INCLUDE "title.asm"        ; title page

SECTION .bss                ; uninitialized variables (buffers)
    input RESB 10;
    input_l EQU $-input

SECTION .data               ; initialized variables 
    ; Output strings
    select DB "Choose your character ('barbarian', 'bard', 'cleric', 'druid') or 'quit':",0xa
    select_l EQU $-select
    monster DB "Choose your opponent ('goblin', 'orc', or 'troll'):",0xa
    monster_l EQU $-monster
    commands DB "Enter your input ('attack', 'defend', or 'flee'):",0xa  ; string with new line
    commands_l EQU $-commands
    defOut DB "You defend!",0xa
    defOut_l EQU $-defOut
    runOut DB "Coward!",0xa
    runOut_l EQU $-runOut
    
    ; User commands
    quit DB "quit"
    quit_l EQU $-quit
    att DB "attack"
    att_l EQU $-att
    def DB "defend"
    def_l EQU $-def
    run DB "flee"
    run_l EQU $-run

SECTION .text               ; program code
GLOBAL _start

; _start
; Program entry point. Outputs the tile screen.
_start:
    mov rsi, title
    mov rdx, title_l
    call write

; selectCharacter
; Prompts the user to select a character by entering a string which it saves to "input"
; then it compares the input string to the character strings to find the selection.
; The selected character is loaded to r8. 
selectCharacter:
    mov rsi, select
    mov rdx, select_l
    call write
    call read
    
    call compareQuit
    call compareBarbarian
    call compareBard
    call compareCleric
    call compareDruid
    ;call compareFighter    (structs are in place but comparison subroutines are not)
    ;call comparePaladin
    ;call compareRanger
    ;call compareRogue
    ;call compareSorcerer
    ;call compareWizard
    jmp selectCharacter     ; Back to character prompt if invalid input

; selectMonster
; Prompts the user to select a monster by entering a string which it saves to "input"
; then it compares the input string to the monster strings to find the selection.
; The selected monster is loaded to r9.
selectMonster:
    mov rsi, monster
    mov rdx, monster_l
    call write
    call read

    call compareGoblin
    call compareOrc
    call compareTroll
    jmp selectMonster       ; Back to monster prompt if invalid input

; initiative
; Combat starts by comparing the initiative scores of the character and monster.
; Whoever has the highest score goes first, and characters win ties.
initiative:
    mov rdi, [r8 + Character.init]
    mov rsi, [r9 + Character.init]
    cmp rdi, rsi        
    jl monsterInit          ; Monster wins initiative if PC's init is lower

; combat
; Start of the combat loop which currently runs until the user enters "flee".
; Prompts the user to choose an action by entering a string which the program
; saves to input then it compares the input string to the command strings.
combat:    
    mov rsi, commands       ; Prompts user to "attack", "defend", or "flee"
    mov rdx, commands_l     ; Length of string
    call write
    call read
   
    call compareAttack      ; Checks if user attacks
    call compareDefend      ; Checks if user defends
    call compareFlee        ; Checks if user flees
    jmp combat              ; Back to combat prompt if invalid input 

; monsterInit
; Entry point into the combat loop if the monster wins initiative.
; Outputs the monster's attack then returns to the start of the combat loop.
monsterInit:
    call monAttack
    jmp combat              ; Back to start of combat loop
