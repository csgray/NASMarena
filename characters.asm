; characters.asm
; Corey S. Gray
; Project for CS 301
;
; Character structures for "adventure.asm" 

STRUC Character     ; uninitialized structure definition
.init:      RESD 1  ; int - initiative modifier
.armor:     RESD 1  ; int - number to beat to harm
.health:    RESD 1  ; int - health points
.attack:    RESD 1  ; int - bonus to attack
.mindamage: RESD 1  ; int - minimum rolled damage
.maxdamage: RESD 1  ; int - maximum rolled damage
.bonus:     RESD 1  ; int - bonus damage
.flavor_l:  RESQ 1  ; size_t - length of flavor text
.flavor:    RESB 45 ; string - attack flavor text, needs to be as large as longest string
.size:              ; total memory consumed by struc
ENDSTRUC

SECTION .data
; Character select strings
barb DB "barb"
bard_s DB "bard"
cler DB "cler"
drui DB "drui"
figh DB "figh"
pala DB "pala"
rang DB "rang"
rogu DB "rogu"
sorc DB "sorc"
wiza DB "wiza"

barbarian:  ISTRUC Character    ; declares a "barbarian" character
AT Character.init, DD 1
AT Character.armor, DD 15
AT Character.health, DD 15
AT Character.attack, DD 3
AT Character.mindamage, DD 2
AT Character.maxdamage, DD 16
AT Character.bonus, DD 6
AT Character.flavor_l, DQ 42
AT Character.flavor, DB "You attack with your large bastard sword!",0xa
IEND

bard:  ISTRUC Character         ; declares a "bard" character
AT Character.init, DD 2
AT Character.armor, DD 15
AT Character.health, DD 10
AT Character.attack, DD 3
AT Character.mindamage, DD 1
AT Character.maxdamage, DD 4
AT Character.bonus, DD -1
AT Character.flavor_l, DQ 34
AT Character.flavor, DB "You attack with your short sword!",0xa
IEND

cleric:  ISTRUC Character       ; declares a "cleric" character
AT Character.init, DD 0
AT Character.armor, DD 16
AT Character.health, DD 13
AT Character.attack, DD 2
AT Character.mindamage, DD 1
AT Character.maxdamage, DD 6
AT Character.bonus, DD 2
AT Character.flavor_l, DQ 31
AT Character.flavor, DB "You attack with your scimitar!",0xa
IEND

druid:  ISTRUC Character        ; declares a "druid" character
AT Character.init, DD 1
AT Character.armor, DD 14
AT Character.health, DD 11
AT Character.attack, DD -1
AT Character.mindamage, DD 1
AT Character.maxdamage, DD 4
AT Character.bonus, DD -2
AT Character.flavor_l, DQ 29
AT Character.flavor, DB "You attack with your sickle!",0xa
IEND

fighter:  ISTRUC Character      ; declares a "fighter" character
AT Character.init, DD 2
AT Character.armor, DD 17
AT Character.health, DD 16
AT Character.attack, DD 5
AT Character.mindamage, DD 1
AT Character.maxdamage, DD 8
AT Character.bonus, DD 3
AT Character.flavor_l, DQ 33
AT Character.flavor, DB "You attack with your long sword!",0xa
IEND

paladain:  ISTRUC Character     ; declares a "paladin" character
AT Character.init, DD 0
AT Character.armor, DD 17
AT Character.health, DD 13
AT Character.attack, DD 5
AT Character.mindamage, DD 1
AT Character.maxdamage, DD 8
AT Character.bonus, DD 3
AT Character.flavor_l, DQ 33
AT Character.flavor, DB "You attack with your long sword!",0xa
IEND

ranger:  ISTRUC Character    ; declares a "ranger" character
AT Character.init, DD 3
AT Character.armor, DD 16
AT Character.health, DD 12
AT Character.attack, DD 3
AT Character.mindamage, DD 1
AT Character.maxdamage, DD 8
AT Character.bonus, DD 2
AT Character.flavor_l, DQ 32
AT Character.flavor, DB "You attack with your battleaxe!",0xa
IEND

rogue:  ISTRUC Character    ; declares a "rogue" character
AT Character.init, DD 4
AT Character.armor, DD 17
AT Character.health, DD 10
AT Character.attack, DD 4
AT Character.mindamage, DD 1
AT Character.maxdamage, DD 6
AT Character.bonus, DD 2
AT Character.flavor_l, DQ 29
AT Character.flavor, DB "You attack with your rapier!",0xa
IEND

sorcerer:  ISTRUC Character    ; declares a "sorcerer" character
AT Character.init, DD 2
AT Character.armor, DD 17
AT Character.health, DD 8
AT Character.attack, DD 0
AT Character.mindamage, DD 1
AT Character.maxdamage, DD 6
AT Character.bonus, DD 0
AT Character.flavor_l, DQ 35
AT Character.flavor, DB "You attack with your quarterstaff!",0xa
IEND

wizard:  ISTRUC Character       ; declares a "wizard" character
AT Character.init, DD 2
AT Character.armor, DD 16
AT Character.health, DD 8
AT Character.attack, DD 1
AT Character.mindamage, DD 1
AT Character.maxdamage, DD 6
AT Character.bonus, DD 0
AT Character.flavor_l, DQ 38
AT Character.flavor, DB "You attack with your masterwork cane!",0xa
IEND