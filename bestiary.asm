; bestiary.asm
; Corey S. Gray
; Project for CS 301
;
; Monster structures for "adventure.asm" 

STRUC Monster       ; uninitialized structure definition
.armor:     RESD 1  ; int - number to beat to harm
.health:    RESD 1  ; int - health points
.attack:    RESD 1  ; int - bonus to attack
.damage:    RESD 1  ; int - damage done
.size:              ; total memory consumed by struc
ENDSTRUC

SEGMENT .data

goblin:  ISTRUC Character    ; declares a "goblin" monster
AT Character.armor, DD 16
AT Character.health, DD 6
AT Character.attack, DD 1
AT Character.damage, DD 4
IEND