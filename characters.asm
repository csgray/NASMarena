; characters.asm
; Corey S. Gray
; Project for CS 301
;
; Character structures for "adventure.asm" 

STRUC Character     ; uninitialized structure definition
.armor:     RESD 1  ; int - number to beat to harm
.health:    RESD 1  ; int - health points
.attack:    RESD 1  ; int - bonus to attack
.damage:    RESD 1  ; int - damage done
.flavor_l:  RESD 1  ; int - length of flavor text
.flavor:    RESB 42  ; string - attack flavor text
.size:              ; total memory consumed by struc
ENDSTRUC

SEGMENT .data

barbarian:  ISTRUC Character    ; declares a "barbarian" character
AT Character.armor, DD 15
AT Character.health, DD 15
AT Character.attack, DD 3
AT Character.damage, DD 22
AT Character.flavor_l, DD 41
AT Character.flavor, DB "You attack with your large bastard sword!",0xa
IEND