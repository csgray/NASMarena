; title.asm
; Corey S. Gray
; Project for CS 301
;
; Title page for "adventure.asm" 

SECTION .data
title DB " _        _______  _______  _______    _______  _______  _______  _        _______ ",0xa,\
         "( (    /|(  ___  )(  ____ \(       )  (  ___  )(  ____ )(  ____ \( (    /|(  ___  )",0xa,\
         "|  \  ( || (   ) || (    \/| () () |  | (   ) || (    )|| (    \/|  \  ( || (   ) |",0xa,\
         "|   \ | || (___) || (_____ | || || |  | (___) || (____)|| (__    |   \ | || (___) |",0xa,\
         "| (\ \) ||  ___  |(_____  )| |(_)| |  |  ___  ||     __)|  __)   | (\ \) ||  ___  |",0xa,\
         "| | \   || (   ) |      ) || |   | |  | (   ) || (\ (   | (      | | \   || (   ) |",0xa,\
         "| )  \  || )   ( |/\____) || )   ( |  | )   ( || ) \ \__| (____/\| )  \  || )   ( |",0xa,\
         "|/    )_)|/     \|\_______)|/     \|  |/     \||/   \__/(_______/|/    )_)|/     \|",0xa,\
         "                      a little game by C. S. Gray for CS 301                       ",0xa,0xa
title_l EQU $-title