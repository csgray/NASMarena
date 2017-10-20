; bestiary.asm
; Corey S. Gray
; Project for CS 301
;
; Monster structures for "adventure.asm" 

; Uses the Charcter struc defined in "charcters.asm"
; STRUC Character     ; uninitialized structure definition
; .init:      RESD 1  ; int - initiative modifier
; .armor:     RESD 1  ; int - number to beat to harm
; .health:    RESD 1  ; int - health points
; .attack:    RESD 1  ; int - bonus to attack
; .mindamage: RESD 1  ; int - minimum rolled damage
; .maxdamage: RESD 1  ; int - maximum rolled damage
; .bonus:     RESD 1  ; int - bonus damage
; .flavor_l:  RESQ 1  ; size_t - length of flavor text
; .flavor:    RESB 42 ; string - attack flavor text, needs to be as large as longest string
; .size:              ; total memory consumed by struc
; ENDSTRUC

SECTION .data

goblin:  ISTRUC Character    ; declares a "goblin" monster
AT Character.armor, DD 16
AT Character.health, DD 6
AT Character.attack, DD 1
AT Character.damage, DD 4
IEND