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
; Monster select strings
gob DB "gob"
orc_s DB "orc"
tro DB "tro"

goblin:  ISTRUC Character   ; declares a "goblin" character
AT Character.init, DD 6
AT Character.armor, DD 16
AT Character.health, DD 6
AT Character.attack, DD 1
AT Character.mindamage, DD 1
AT Character.maxdamage, DD 4
AT Character.bonus, DD 0
AT Character.flavor_l, DQ 45
AT Character.flavor, DB "The goblin attacks you with its short sword!",0xa
IEND

orc:  ISTRUC Character      ; declares a "orc" character
AT Character.init, DD 0
AT Character.armor, DD 13
AT Character.health, DD 6
AT Character.attack, DD 4
AT Character.mindamage, DD 2
AT Character.maxdamage, DD 8
AT Character.bonus, DD 4
AT Character.flavor_l, DQ 39
AT Character.flavor, DB "The orc attacks you with its falchion!",0xa
IEND

troll:  ISTRUC Character    ; declares a "troll" character
AT Character.init, DD 2
AT Character.armor, DD 16
AT Character.health, DD 63
AT Character.attack, DD 8
AT Character.mindamage, DD 1
AT Character.maxdamage, DD 8
AT Character.bonus, DD 5
AT Character.flavor_l, DQ 21
AT Character.flavor, DB "The troll bites you!",0xa
IEND