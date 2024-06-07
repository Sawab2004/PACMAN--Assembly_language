INCLUDE Irvine32.inc
includelib Winmm.lib   
includelib Shell32.lib

; Constants for PlaySound function
SND_SYNC        equ 0
SND_ASYNC       equ 1
SND_NODEFAULT   equ 2
SND_LOOP        equ 8
SND_NOSTOP      equ 16


; Function prototype for Sleep
Sleep PROTO,
    dwMilliseconds:DWORD

PlaySound PROTO,
        pszSound:PTR BYTE, 
        hmod:DWORD, 
        fdwSound:DWORD

        SEE_MASK_INVOKEIDLIST equ 0x0000000C
SW_SHOWNORMAL equ 1

; Function prototype for ShellExecute
ShellExecuteA PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
.data

    deviceConnect BYTE "DeviceConnect",0
    file BYTE "Pac-Man intro music.wav",0
    file2 BYTE "1.wav",0
    filename1 db "pacman.bmp", 0
    read_buffer_size equ 8000
    write_buffer_size equ 8000

    buffer_read db read_buffer_size dup(?)
    buffer_write db write_buffer_size dup(?)

    ;file
        fileName db "score.txt",0
        playName db "PlayerName123", 0  ; Example player name
        pNLength equ $ - playName
        fileHandle dd ?

        bytesRead dd ?
        bytesWritten dd ?

        bufferSize equ 7000
        buffer db bufferSize dup(0)

        level db 1

      ;pic
           imageFileName db "pacman.jpg", 0
           videofilename db "video.mp4",0

ground BYTE " --------------------------------------------------------------------------------------",0
ground1 BYTE "|",0
ground2 BYTE "|",0


wallChar BYTE "/////",0
wallPositionsX db 7
wallPositionsX1 db 20
wallPositionsX2 db 35
wallPositionsY db 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25
numWalls DWORD 20
wallPositionsY2 db 5, 6, 7, 8, 9, 10, 11, 12
numWalls2 DWORD 11
wallPositionsX3 db 35,38,41,44,47
wallPositionsY3 db 13
wallPositionsY4 db 14
numWalls3 DWORD 5
wallPositionsX5 db 50
wallPositionsY5 db 13,14,15,16,17,18,19,20,21,22,23
wallPositionsX6 db 35,38,41,44,47
wallPositionsY6 db 23
wallPositionsY7 db 24
wallPositionsX7 db 62,65,68,71,74,77
wallPositionsX8 db 7,31,55,59,63,67,69,71
wallsPos db 7,10,7,11,7,12,7,13,7,14,7,15,7,16,7,17,7,18,7,19,7,20,7,21,7,22,7,23,7,24,7,25
wallPositionsY9 db 5,6,7,8,9,10,11,12,13,14,23,24
wallPositionsY10 db 5,6,13,14,15,16,17,18,19,20,21,22,23,24


count dd 32
isPaused BYTE 0

pacmanname1 byte  " ________  ________  ________  _____ ______   ________  ________",0     
pacmanname2 byte  "|\   __  \|\   __  \|\   ____\|\   _ \  _   \|\   __  \|\   ___  \",0    
pacmanname3 byte  "\ \  \|\  \ \  \|\  \ \  \___|\ \  \\\__\ \  \ \  \|\  \ \  \\ \  \",0   
pacmanname4 byte  " \ \   ____\ \   __  \ \  \    \ \  \\|__| \  \ \   __  \ \  \\ \  \",0  
pacmanname5 byte  "  \ \  \___|\ \  \ \  \ \  \____\ \  \    \ \  \ \  \ \  \ \  \\ \  \ ",0
pacmanname51 byte "   \ \__\    \ \__\ \__\ \_______\ \__\    \ \__\ \__\ \__\ \__\\ \__\",0
pacmanname52 byte "    \|__|     \|__|\|__|\|_______|\|__|     \|__|\|__|\|__|\|__| \|__|",0
pacmanname6 byte 0ah,"                                      ++++++++++",0    
pacmanname7 byte 0ah,"                                    ++++++++++++++",0  
pacmanname8 byte 0ah,"                                   ++++++++++++++ ",0 
pacmanname9 byte 0ah,"                                 ++++++++++++          ..      ..      ..",0 
pacmanname10 byte 0ah,"                               ++++++++++             ....    ....    ....",0 
pacmanname11 byte 0ah,"                                ++++++++++++           ..      ..      ..",0 
pacmanname12 byte 0ah,"                                  ++++++++++++++ ",0 
pacmanname13 byte 0ah,"                                   ++++++++++++++ ",0  
pacmanname14 byte 0ah,"                                     +++++++++++",0   
pacmanname15 byte " Press s to start ",0
pacmanname17 byte " ______________ ",0
pacmanname16 byte "|    PAC-MAN   |",0

level1print byte "- LEVEL 1 -",0
level2print byte "- LEVEL 2 -",0
level3print byte "- LEVEL 3 -",0

level1text byte "level 1",0
level2text byte "level 2",0
level3text byte "level 3",0
leveltext byte ?

temp byte ?

powerchar1 byte "0",0
wallchar1 byte "/",0
obstaclechar byte "*",0
coinchar2 byte ".",0
spacechar1 byte " ",0
coinchar1 byte ". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ",0ah,"  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ",0ah,"  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ",0ah,"  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ",0ah,"  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ",0
strScore BYTE "Score: ",0

;coin coordinates
    coinline1 db 2,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline2 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline3 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline4 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline5 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline6 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline7 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline8 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline9 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline10 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline11 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline12 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline13 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline14 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline15 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline16 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline17 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline18 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline19 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline20 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline21 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline22 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline23 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline24 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coinline25 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84


    coin1line1 db 2,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line2 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line3 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line4 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line5 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line6 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line7 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line8 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line9 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line10 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line11 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line12 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line13 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line14 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line15 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line16 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line17 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line18 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line19 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line20 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line21 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line22 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line23 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line24 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin1line25 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84

    coin2line1 db 2,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line2 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line3 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line4 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line5 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line6 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line7 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line8 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line9 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line10 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line11 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line12 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line13 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line14 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line15 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line16 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line17 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line18 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line19 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line20 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line21 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line22 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line23 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line24 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
    coin2line25 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,57,58,60,62,64,66,68,70,72,74,76,78,80,82,84
;powers    
    power1 byte 1
    power2 byte 1
    power3 byte 1
    power4 byte 1

;savedata
    newline db 0ah            


score dd 0
score1 dd 0
lives byte 3
livesprint BYTE "Lives: ",0
scorestring1 dd 1 dup(?) 
scorestring2 dd 1 dup(?)
scorestring3 dd 1 dup(?)
scorestring4 dd 1 dup(?)
    ;player coordinates
        xPos db 2
        yPos db 10

    ;ghost coordinates
        xPosghost db 2
        yPosghost db 2

        xPosghosttarget db 12
        yPosghosttarget db 12

        randomghostmov dd ?
        xPosghost2 byte 82
        yPosghost2 byte 2

        xPosghost3 byte 2
        yPosghost3 byte 25

        randomghostmov2 byte 0
        randomghostmov3 byte 1


    ;ghost???

xCoinPos BYTE ?
yCoinPos BYTE ?

xFruitPos BYTE 65
yFruitPos BYTE 19


inputChar BYTE ?

;menu 
    menuborder1 byte  " __  __                 ___       _   _      ",0ah,0
    menuText11 BYTE   "|  \/  |___ _ _ _  _   / _ \ _ __| |_(_)___ _ _  ___", 0ah,0
    menuText12 BYTE   "| |\/| / -_| ' | || | | (_) | '_ |  _| / _ | ' \(_-<", 0ah,0
    menuText13 BYTE   "|_|  |_\___|_||_\_,_|  \___/| .__/\__|_\___|_||_/__/",0ah,0
    menuborder2 byte  "                            |_|                    ",0ah,0
    menuText1 BYTE "1. New Game", 0ah,0
    menuText2 BYTE "2. Instructions", 0ah,0
    menuText3 BYTE "3. High Scores", 0ah,0
    menuText4 BYTE "x. Exit", 0
;enter your name
        name11 byte " ___     _                                  ",0
        name12 byte "| __|_ _| |_ ___ _ _   _ _  __ _ _ __  ___",0
        name13 byte "| _|| ' |  _/ -_| '_| | ' \/ _` | '  \/ -_) ",0
        name14 byte "|___|_||_\__\___|_|   |_||_\__,_|_|_|_\___)",0

    
name3 byte "cddd"
name2 byte 50 dup (?)
name2length dd ?
nameborder1 byte "_____________________________________________",0
collision db 0
;game test
    pausegametext1 byte "GAME PAUSED",0

    gameendtext2 byte "\'o'/",0

    ;game lost
        gamelost1 db "  ___    __ ________  ___  ___    ___       ________  ________  _________    ",0        
        gamelost2 db " |\  \  / /|\   __  \|\  \|\  \  |\  \     |\   __  \|\   ____\|\___   ___\ ",0        
        gamelost3 db " \ \  \/ / \ \  \|\  \ \  \\\  \ \ \  \    \ \  \|\  \ \  \___|\|___ \  \_|     ",0     
        gamelost4 db "  \ \   / / \ \  \\\  \ \  \\\  \ \ \  \    \ \  \\\  \ \_____  \   \ \  \       ",0  
        gamelost5 db "   \/  / /   \ \  \\\  \ \  \\\  \ \ \  \____\ \  \\\  \|____|\  \   \ \  \       ",0
        gamelost6 db " __/  / /     \ \_______\ \_______\ \ \_______\ \_______\____\_\  \   \ \__\    ",0
        gamelost7 db "|\___/ /       \|_______|\|_______|  \|_______|\|_______|\_________\   \|__| ",0
        gamelost8 db "\____|/                                                  \|_________|         ",0 
        
    ;game end
        gameend1 db "  ___    ___ ________  ___  ___    __       ____  ________  _________  ",0        
        gameend2 db " |\  \  /  /|\   __  \|\  \|\  \  |\  \     |\  \|\   __  \|\   ___  \",0        
        gameend3 db " \ \  \/  / \ \  \|\  \ \  \\\  \ \ \  \    \ \  \ \  \|\  \ \  \\ \  \    ",0     
        gameend4 db "  \ \    / / \ \  \\\  \ \  \\\  \ \ \  \  __\ \  \ \  \\\  \ \  \\ \  \     ",0  
        gameend5 db "   \/   / /   \ \  \\\  \ \  \\\  \ \ \  \|\__\_\  \ \  \\\  \ \  \\ \  \      ",0
        gameend6 db " __/   / /     \ \_______\ \_______\ \ \____________\ \_______\ \__\\ \__\    ",0
        gameend7 db "|\____/ /       \|_______|\|_______|  \|____________|\|_______|\|__| \|__|    ",0
        gameend8 db "\_____|/",0
        

;intruction
    instruction111 byte " ___         _               _   _ ",0ah,0
    instruction112 byte "|_ _|_ _  __| |_ _ _ _  _ __| |_(_)___ _ _  ___",0ah,0
    instruction113 byte " | || ' \(_-|  _| '_| || / _|  _| / _ | ' \(_-<",0
    instruction114 byte "|___|_||_/__/\__|_|  \_,_\__|\__|_\___|_||_/__/ ",0
    instruction2 byte "Press 'w' to move up",0
    instruction3 byte "Press 's' to move down",0
    instruction4 byte "Press 'a' to move left",0
    instruction5 byte "Press 'd' to move right",0
    instruction6 byte "Press 'p' to pause the game",0
    instruction7 byte "Press 'r' to resume the game",0
    instruction8 byte "1 coin = 1 point",0
    instruction9 byte "1 Powerup = 4 points",0
    instruction10 byte "1 Fruit = 5 points ",0
    instruction11 byte "Press 'b' to go back to menu page",0


spacechar2 byte "    ",0

level3wall3char byte "//",0
level3wallline3 byte 6,8,10,12,14,16,17,18,20,24,26,27,29,31,33,35,37,39,41,46,48,50,52,54,56,58,60,62,64,66,67,72,74,76,78,79
level3wallline6 byte 6,8,10,12,14,16,17,18,20,24,27,29,30,31,33,35,37,39,41,43,45,47,49,51,52,54,56,58,60,62,64,67,72,74,76,78,79
level3wallline7 byte 44
level3wallline8 byte 2,4,6,8,10,12,14,16,17,18,20,24,26,27,29,31,33,35,37,52,54,56,58,60,62,64,66,67,72,74,76,78,80,82,84
level3wallline9 byte 2,4,6,8,10,12,14,16,17,18,20,24,26,64,66,67,72,74,76,78,80,82,84
level3wallline11 byte 24,26,64,66
level3wallline12 byte 24,26,34,36,38,40,41,43,45,47,49,51,53,64,66,67

level3leftwallcollision1 byte 22,41

yPos1 byte ?

    ;highscore
        highscore11 byte " _  _ _      _      ___                ",0ah,0
        highscore1 byte  "| || (_)__ _| |_   / __|__ ___ _ _ ___ ",0ah,0
        highscore2 byte  "| __ | / _` | ' \  \__ / _/ _ | '_/ -_)",0ah,0
        highscore3 byte  "|_||_|_\__, |_||_| |___\__\___|_| \___|",0ah,0
        highscore4 byte  "       |___/   ",0ah,0

.code
;=======================Draw Power for level1==========================;
    DrawPower1 PROC
        mov eax,green
        call SetTextColor
        mov dh,3
        mov dl,4
        call Gotoxy
        mov edx,offset powerchar1
        call WriteString
        mov dh,3
        mov dl,82
        call Gotoxy
        mov edx,offset powerchar1
        call WriteString
        mov dh,25
        mov dl,4
        call Gotoxy
        mov edx,offset powerchar1
        call WriteString
        mov dh,25
        mov dl,82
        call Gotoxy
        mov edx,offset powerchar1
        call WriteString
        ret
    DrawPower1 ENDP
;=======================Draw Coins for level1==========================;
    DrawCoins1 PROC
        mov eax,yellow
        call SetTextColor
        mov dh,2
        mov dl,2
        call Gotoxy
        mov edx,offset coinchar1
        call WriteString
        mov dh,6
        mov dl,2
        call Gotoxy
        mov edx,offset coinchar1
        call WriteString
        mov dh,10
        mov dl,2
        call Gotoxy
        mov edx,offset coinchar1
        call WriteString
        mov dh,14
        mov dl,2
        call Gotoxy
        mov edx,offset coinchar1
        call WriteString
        mov dh,18
        mov dl,2
        call Gotoxy
        mov edx,offset coinchar1
        call WriteString
        mov dh,22
        mov dl,2
        call Gotoxy
        mov edx,offset coinchar1
        call WriteString

        ret
    DrawCoins1 ENDP
;=======================High Score==========================;
    HighScorePage PROC
        call clrscr
        ; draw ground at (0,29):
        mov eax,magenta ;(black * 16)
        call SetTextColor
        mov dl,0
        mov dh,27
        call Gotoxy
        mov edx,OFFSET ground
        call WriteString
        mov dl,0
        mov dh,1
        call Gotoxy
        mov edx,OFFSET ground
        call WriteString

        call SetTextColor
        mov ecx,25
        mov dh,2
        mov temp,dh
        l1:
            mov dh,temp
            mov dl,1
            call Gotoxy
            mov edx,OFFSET ground1
            call WriteString
            inc temp
            loop l1

             mov ecx,25
             mov dh,2
             mov temp,dh
        l2:
            mov dh,temp
            mov dl,86
            call Gotoxy
            mov edx,OFFSET ground2
            call WriteString
            inc temp
            loop l2
        mov eax,lightmagenta
        call SetTextColor
        mov dh,3
        mov dl,28
        call Gotoxy
        mov edx, OFFSET highscore11
        call WriteString

        mov eax,lightmagenta ;(black * 16)
        call SetTextColor
        mov dh,4
        mov dl,28
        call Gotoxy
        mov edx, OFFSET highscore1
        call WriteString
        mov dh,5
        mov dl,28
        call Gotoxy
        mov edx, OFFSET highscore2
        call WriteString
        mov eax,magenta
        call SetTextColor
        mov dh,6
        mov dl,28
        call Gotoxy
        mov edx, OFFSET highscore3
        call WriteString
        mov dh,7
        mov dl,28
        call Gotoxy
        mov edx, OFFSET highscore4
        call WriteString
        
        mov eax,gray
        call SetTextColor
        
        mov edx,offset fileName
        call OpenInputFile
        mov fileHandle,eax
        ;Read From file
            mov edx,offset buffer
            mov ecx,bufferSize
            call ReadFromFile
            mov eax,fileHandle
            call closefile
        mov dh,10
        mov dl,3
        call Gotoxy
        mov edx,offset buffer
        call WriteString


        mov dh,15
        mov dl,30
        call Gotoxy
        mov edx,offset instruction11
        call WriteString

        
        loophighscore:
        call ReadChar
        mov inputChar, al

        cmp inputChar, "b"
        je return
        jmp loophighscore
        return:
            call clrscr
            ret
    HighScorePage ENDP
;=======================Instructions==========================;
    InstructionsPage PROC
        call clrscr
        mov eax,yellow
        call SetTextColor
        mov dh,3
        mov dl,28
        call Gotoxy
        mov edx, OFFSET instruction111
        call WriteString
        mov dh,4
        mov dl,28
        call Gotoxy
        mov edx, OFFSET instruction112
        call WriteString
        mov dh,5
        mov dl,28
        call Gotoxy
        mov edx, OFFSET instruction113
        call WriteString
        mov dh,6
        mov dl,28
        call Gotoxy
        mov edx, OFFSET instruction114
        call WriteString
        mov eax,magenta 
        call SetTextColor
        mov dh,2
        mov dl,28
        call Gotoxy
        mov edx, OFFSET nameborder1
        call WriteString
        mov dh,7
        mov dl,28
        call Gotoxy
        mov edx, OFFSET nameborder1
        call WriteString
        mov eax,yellow 
        call SetTextColor
        mov dh,10
        mov dl,20
        call Gotoxy
        mov edx, OFFSET instruction2
        call WriteString
        mov dh,11
        mov dl,20
        call Gotoxy
        mov edx, OFFSET instruction3
        call WriteString
        mov dh,12
        mov dl,20
        call Gotoxy
        mov edx, OFFSET instruction4
        call WriteString
        mov dh,13
        mov dl,20
        call Gotoxy
        mov edx, OFFSET instruction5
        call WriteString
        mov dh,14
        mov dl,20
        call Gotoxy
        mov edx, OFFSET instruction6
        call WriteString
        mov dh,15
        mov dl,20
        call Gotoxy
        mov edx, OFFSET instruction7
        call WriteString
        mov dh,11
        mov dl,55
        call Gotoxy
        mov edx, OFFSET instruction8
        call WriteString
        mov dh,12
        mov dl,55
        call Gotoxy
        mov edx, OFFSET instruction9
        call WriteString
        mov dh,13
        mov dl,55
        call Gotoxy
        mov edx, OFFSET instruction10
        call WriteString
        mov dh,19
        mov dl,30
        call Gotoxy
        mov edx, OFFSET instruction11
        call WriteString
        mov dh,25
        mov dl,30
        call Gotoxy
        mov edx, OFFSET newline
        call WriteString

        call ReadChar
        mov inputChar, al

        cmp inputChar, "b"
        je return
        return:
            ret
    InstructionsPage ENDP
;=======================Menu==========================;
ShowMenu PROC
    call clrscr
        ; draw ground at (0,29):
        mov eax,blue ;(black * 16)
        call SetTextColor
        mov dl,0
        mov dh,27
        call Gotoxy
        mov edx,OFFSET ground
        call WriteString
        mov dl,0
        mov dh,1
        call Gotoxy
        mov edx,OFFSET ground
        call WriteString

        call SetTextColor
        mov ecx,25
        mov dh,2
        mov temp,dh
        l1:
            mov dh,temp
            mov dl,1
            call Gotoxy
            mov edx,OFFSET ground1
            call WriteString
            inc temp
            loop l1

             mov ecx,25
             mov dh,2
             mov temp,dh
        l2:
            mov dh,temp
            mov dl,86
            call Gotoxy
            mov edx,OFFSET ground2
            call WriteString
            inc temp
            loop l2
    mov eax,lightred 
    call SetTextColor
    menupage:
     mov dl,22
    mov dh,4
    call Gotoxy
    mov edx, OFFSET menuborder1
    call WriteString

    mov dl,22
    mov dh,5
    call Gotoxy
    mov edx, OFFSET menuText11
    call WriteString

    mov dl,22
    mov dh,6
    call Gotoxy
    mov edx, OFFSET menuText12
    call WriteString

    mov dl,22
    mov dh,7
    call Gotoxy
    mov edx, OFFSET menuText13
    call WriteString

        mov dl,21
        mov dh,8
        call Gotoxy
         mov edx, OFFSET menuborder2
        call WriteString


    mov eax,lightcyan 
    call SetTextColor
    mov dl,30
    mov dh,11
    call Gotoxy
    mov edx, OFFSET menuText1
    call WriteString

    mov dl,30
    mov dh,12
    call Gotoxy
    mov edx, OFFSET menuText2
    call WriteString

    mov dl,30
    mov dh,13
    call Gotoxy
    mov edx, OFFSET menuText3
    call WriteString

    mov dl,30
    mov dh,14
    call Gotoxy
    mov edx, OFFSET menuText4
    call WriteString

    call ReadChar
    mov inputChar, al

    cmp inputChar, "1"
    je option1
    cmp inputChar, "2"
    je option2
    cmp inputChar, "3"
    je option3
    cmp inputChar, "x"
    je exit1
    jmp invalidInput

    exit1:
     int 10h
    option1:
        call clrscr
        jmp exitMenu 
    option2:
        call InstructionsPage
        jmp ShowMenu
    option3:
        call clrscr
        call HighScorePage
        jmp ShowMenu 
    invalidInput:
    jmp ShowMenu 

    exitMenu:
         ret
ShowMenu ENDP

;=======================Walls Collision==========================;

    WallCollision PROC
        mov yPos1,4
        movzx ebx, yPos
        cmp bl, yPos1
        jne CoinsAbsence1
        sub ebx, 1
        mov eax, ebx
        xor ebx, ebx
        mov bx, 81
        mul bx
        mov ebx, eax
        movzx eax, xPos
        add ebx, eax
        add esi, ebx
        cmp byte ptr [esi],'.'
        jne CoinsAbsence1
        add score,1
        mov byte ptr [esi], -1
        inc yPos1
        CoinsAbsence1:
            
       ret
    WallCollision ENDP
;=======================Clear screen==========================;

    ClearScreen PROC
       call clrscr
       ret
    ClearScreen ENDP
;=======================Draw Walls for level1==========================;

    DrawWalls PROC
        mov eax, blue ; Set text color for walls
        call SetTextColor
        mov esi, 0 ; Use ESI to index wall positions
        drawWallLoop:
            mov dl,7
            mov dh,[wallPositionsY + esi]

            call Gotoxy
            mov edx, OFFSET wallChar
            call WriteString

            inc esi

            cmp esi, numWalls
            jl drawWallLoop

        mov esi, 0 ; Use ESI to index wall positions
        drawWallLoop1:
            mov dl,wallPositionsX1
            mov dh,[wallPositionsY + esi]

            call Gotoxy
            mov edx, OFFSET wallChar
            call WriteString

            inc esi
                
           cmp esi, numWalls
           jl drawWallLoop1

        mov esi, 0 ; Use ESI to index wall positions
        drawWallLoop2:
           mov dl,wallPositionsX2
           mov dh,[wallPositionsY2 + esi]

           call Gotoxy
            mov edx, OFFSET wallChar
            call WriteString

           inc esi

            cmp esi, numWalls2
            jl drawWallLoop2

        mov esi, 0 
        drawWallLoop3:
            mov dl, [wallPositionsX3 + esi]
            mov dh, [wallPositionsY3]
    
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString

        inc esi

        cmp esi, numWalls3
        jl drawWallLoop3

        mov esi,0
        drawWallLoop4:
        mov dl, [wallPositionsX3 + esi]
        mov dh, [wallPositionsY4]
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop4

        mov esi,0
        inc numWalls2
        drawWallLoop5:
        mov dl,wallPositionsX5
        mov dh,[wallPositionsY5 + esi]
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi,numWalls2
        jl drawWallLoop5

        
        mov esi, 0 
        drawWallLoop6:
        mov dl, [wallPositionsX6 + esi]
        mov dh, [wallPositionsY6]

        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString

        inc esi

        cmp esi, numWalls3
        jl drawWallLoop6

        mov esi,0
        drawWallLoop7:
        mov dl, [wallPositionsX6 + esi]
        mov dh, [wallPositionsY7]
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop7

        mov esi, 0 ; Use ESI to index wall positions
        drawWallLoop8:
        mov dl, [wallPositionsX6 + esi]
        mov dh, 5

        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString

        inc esi

        cmp esi, numWalls3
        jl drawWallLoop8

        mov esi,0
        drawWallLoop9:
        mov dl, [wallPositionsX6 + esi]
        mov dh,6
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop9


         mov esi, 0 ; Use ESI to index wall positions
           drawWallLoop10:
               mov dl,77
               mov dh,[wallPositionsY + esi]
               call Gotoxy
               mov edx, OFFSET wallChar
               call WriteString
                   inc esi
            cmp esi, numWalls
                jl drawWallLoop10

        mov esi, 0 
        drawWallLoop11:
        mov dl,62
        mov dh,[wallPositionsY + esi]
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls
        jl drawWallLoop11

        mov esi, 0 ; Use ESI to index wall positions
        drawWallLoop12:
        mov dl, [wallPositionsX7 + esi]
        mov dh, 5

        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop12

        mov esi,0
        drawWallLoop13:
        mov dl, [wallPositionsX7 + esi]
        mov dh,6
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop13


        mov esi, 0 
        drawWallLoop14:
        mov dl, [wallPositionsX7 + esi]
        mov dh, 23

        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop14

        mov esi,0
        drawWallLoop15:
        mov dl, [wallPositionsX7 + esi]
        mov dh,24
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop15

        mov esi, 0 ; Use ESI to index wall positions
        drawWallLoop16:
        mov dl, [wallPositionsX7 + esi]
        mov dh, 14

        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop16

        mov esi,0
        drawWallLoop17:
        mov dl, [wallPositionsX7 + esi]
        mov dh,13
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop17
            ret
    DrawWalls ENDP
;=======================Draw Walls for level2==========================;

    DrawWalls2 PROC
        mov eax, blue ; Set text color for walls
        call SetTextColor
        mov esi, 0 ; Use ESI to index wall positions
        mov numWalls,11
        drawWallLoop:
            mov al,[wallPositionsY + esi]
            dec al
            mov dl,6
            mov dh,al
            call Gotoxy
            mov edx, OFFSET wallChar
            call WriteString
            inc esi
            cmp esi,11
            jl drawWallLoop
        
        mov esi, 0 
        drawWallLoop1:
            mov al,[wallPositionsY + esi]
            dec al
            mov dl,wallPositionsX1
            mov dh,al
            call Gotoxy
            mov edx, OFFSET wallChar
            call WriteString
            inc esi
            cmp esi, numWalls
            jl drawWallLoop1

        

        mov esi, 0 ; Use ESI to index wall positions
      
        drawWallLoop2:
            mov al,[wallPositionsY2 + esi]
            inc al
           mov dl,wallPositionsX2
           mov dh,al

           call Gotoxy
            mov edx, OFFSET wallChar
            call WriteString

           inc esi

            cmp esi, 7
            jl drawWallLoop2

        
        mov esi,1
      
        drawWallLoop5:
            mov al,[wallPositionsY5 + esi]
            add al,1
            mov dl,wallPositionsX5
            mov dh,al
            call Gotoxy
            mov edx, OFFSET wallChar
            call WriteString
            inc esi
            cmp esi,numWalls2
            jl drawWallLoop5
        
            
        mov esi,1
        sub wallPositionsX5,15
        drawWallLoop51:
            mov al,[wallPositionsY5 + esi]
            add al,1
            mov dl,wallPositionsX5
            mov dh,al
            call Gotoxy
            mov edx, OFFSET wallChar
            call WriteString
            inc esi
            cmp esi,11
            jl drawWallLoop51

        mov esi, 0 
        drawWallLoop6:
            mov al ,[wallPositionsX6 + esi]
            add al,3
            mov dl, al
            mov dh, [wallPositionsY6]

            call Gotoxy
            mov edx, OFFSET wallChar
            call WriteString

            inc esi

            cmp esi, numWalls3
            jl drawWallLoop6

        mov esi,0
        drawWallLoop7:
        mov al ,[wallPositionsX6 + esi]
            add al,3
            mov dl, al
        mov dh, [wallPositionsY7]
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop7

        mov esi, 0 
        drawWallLoop8:
        mov al ,[wallPositionsX6 + esi]
            add al,3
            mov dl, al
        mov dh, 6

        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString

        inc esi

        cmp esi, numWalls3
        jl drawWallLoop8
        
        mov esi,0
        drawWallLoop9:
        mov al ,[wallPositionsX6 + esi]
            add al,3
            mov dl, al
        mov dh,6
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop9

        
        dec numWalls
         mov esi, 0 ; Use ESI to index wall positions
           drawWallLoop10:
               mov dl,78
               mov dh,[wallPositionsY + esi]
               call Gotoxy
               mov edx, OFFSET wallChar
               call WriteString
                   inc esi
            cmp esi, numWalls
                jl drawWallLoop10

        
        mov esi, 0 
        drawWall1Loop8:
        mov al,[wallPositionsX6 + esi]
        sub al,28
        mov dl,al
        mov dh,18

        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString

        inc esi

        cmp esi, numWalls3
        jl drawWall1Loop8

        mov esi,0
        drawWall1Loop9:
        mov al,[wallPositionsX6 + esi]
        sub al,28
        mov dl,al
        mov dh,17
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWall1Loop9

        
        dec numWalls
         mov esi, 0 ; Use ESI to index wall positions
           drawWall1Loop10:
                mov al, [wallPositionsY + esi]
                add al,12
               mov dl,6
               mov dh,al
               call Gotoxy
               mov edx, OFFSET wallChar
               call WriteString
                   inc esi
            cmp esi, numWalls
                jl drawWall1Loop10

         mov esi,0
        drawWall1Loop91:
        mov al,[wallPositionsX6 + esi]
        sub al,28
        mov dl,al
        mov dh,24
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWall1Loop91

        
         mov esi,0
        drawWall1Loop92:
        mov al,[wallPositionsX6 + esi]
        sub al,28
        mov dl,al
        mov dh,25
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWall1Loop92

        

        mov esi, 0 ; Use ESI to index wall positions
           drawWall1Loop11:
                mov al, [wallPositionsY + esi]
                add al,12
               mov dl,20
               mov dh,al
               call Gotoxy
               mov edx, OFFSET wallChar
               call WriteString
                   inc esi
            cmp esi, numWalls
                jl drawWall1Loop11

        
        mov esi, 0 
        drawWallLoop11:
        mov dl,62
        mov dh,[wallPositionsY + esi]
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls
        jl drawWallLoop11

        
        mov esi, 0 ; Use ESI to index wall positions
        drawWallLoop12:
        mov dl, [wallPositionsX7 + esi]
        mov dh, 5

        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop12

        
        mov esi,0
        drawWallLoop13:
        mov dl, [wallPositionsX7 + esi]
        mov dh,6
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop13

        
        mov esi, 0 
        inc numWalls3
        drawWallLoop14:
        mov dl, [wallPositionsX7 + esi]
        mov dh, 25

        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop14

        mov esi,0
        drawWallLoop15:
        mov dl, [wallPositionsX7 + esi]
        mov dh,24
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop15

        mov esi, 0 
        drawWallLoop141:
        mov dl, [wallPositionsX7 + esi]
        mov dh, 21

        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop141

        mov esi,0
        drawWallLoop151:
        mov dl, [wallPositionsX7 + esi]
        mov dh,20
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop151
        
        mov esi, 0 ; Use ESI to index wall positions
        drawWallLoop16:
        mov dl, [wallPositionsX7 + esi]
        mov dh, 14

        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop16

        mov esi,0
        drawWallLoop17:
        mov dl, [wallPositionsX7 + esi]
        mov dh,13
        call Gotoxy
        mov edx, OFFSET wallChar
        call WriteString
        inc esi
        cmp esi, numWalls3
        jl drawWallLoop17
            ret
    DrawWalls2 ENDP
;=======================Draw Walls for level3==========================;
    DrawWalls3 PROC
        ; draw ground at (0,29):
            ;draw top and bottom boundary
                mov eax,blue ;(black * 16)
                call SetTextColor
                mov dl,0
                mov dh,27
                call Gotoxy
                mov edx,OFFSET ground
                call WriteString
                mov dl,0
                mov dh,1
                call Gotoxy
                mov edx,OFFSET ground
                call WriteString
           
            ;draw left and right boundary
                mov ecx,11
                mov dh,2
                mov temp,dh
                l1:
                    mov dh,temp
                    mov dl,1
                    call Gotoxy
                    mov edx,OFFSET ground1
                    call WriteString
                    inc temp
                    loop l1

                mov ecx,13
                mov dh,14
                mov temp,dh
                l11:    
                    mov dh,temp
                    mov dl,1
                    call Gotoxy
                    mov edx,OFFSET ground1
                    call WriteString
                    inc temp
                    loop l11
                    
                 mov ecx,11
                 mov dh,2
                 mov temp,dh
                l2:
                    mov dh,temp
                    mov dl,86
                    call Gotoxy
                    mov edx,OFFSET ground2
                    call WriteString
                    inc temp
                    loop l2
            
                 mov ecx,13
                 mov dh,14
                 mov temp,dh
                l21:
                    mov dh,temp
                    mov dl,86
                    call Gotoxy
                    mov edx,OFFSET ground2
                    call WriteString
                    inc temp
                    loop l21


        ;line2 draw
            mov esi, 0 ; Use ESI to index wall positions
            drawWallLoop:
            mov al,[ level3wallline3+ esi]
            
            mov dl,al
            mov dh,3

            call Gotoxy
            mov edx, OFFSET level3wall3char
            call WriteString

            inc esi

            cmp esi,36
            jl drawWallLoop
        ;line3 draw
            mov esi, 0 ; Use ESI to index wall positions
            drawWallLoop1:
               mov al,[ level3wallline3+ esi]
                
                mov dl,al
                mov dh,4
                call Gotoxy
                mov edx, OFFSET level3wall3char
                call WriteString
                inc esi
                cmp esi,36
                jl drawWallLoop1
        ;line4 draw
            mov esi, 0 ; Use ESI to index wall positions
            drawWallLoop2:
               mov al,[ level3wallline3+ esi]
                
                mov dl,al
                mov dh,5
                call Gotoxy
                mov edx, OFFSET level3wall3char
                call WriteString
                inc esi
                cmp esi,36
                jl drawWallLoop2
        ;line6 draw
            mov esi, 0 ; Use ESI to index wall positions
            drawWallLoop6:
                mov al,[ level3wallline6+ esi]
            
                mov dl,al
                mov dh,7
                call Gotoxy
                mov edx, OFFSET level3wall3char
                call WriteString
                inc esi
                cmp esi,37
                jl drawWallLoop6
        ;line7 draw
            mov eax,magenta;(black * 16)
                call SetTextColor
            mov dl,level3wallline7
            mov dh,8
            call Gotoxy
            mov edx, OFFSET obstaclechar
            call WriteString
            mov eax,blue ;(black * 16)
                call SetTextColor
        ;line8 draw
            mov esi, 0 ; Use ESI to index wall positions
            drawWallLoop8:
               mov al,[ level3wallline8+ esi]
                mov dl,al
                mov dh,10
                call Gotoxy
                mov edx, OFFSET level3wall3char
                call WriteString
                inc esi
                cmp esi,45
                jl drawWallLoop8
        ;line10 draw
            mov esi, 0 ; Use ESI to index wall positions
            drawWallLoop10:
               mov al,[ level3wallline9+ esi]
                mov dl,al
                mov dh,11
                call Gotoxy
                mov edx, OFFSET level3wall3char
                call WriteString
                inc esi
                cmp esi,30
                jl drawWallLoop10   
        ;line11 draw
            mov esi, 0 ; Use ESI to index wall positions
            drawWallLoop11:
               mov al,[ level3wallline9+ esi]
                mov dl,al
                mov dh,12
                call Gotoxy
                mov edx, OFFSET level3wall3char
                call WriteString
                inc esi
                cmp esi,25
                jl drawWallLoop11  
        ;line13 draw
            mov esi, 0 ; Use ESI to index wall positions
            drawWallLoop13:
               mov al,[ level3wallline12+ esi]
                mov dl,al
                mov dh,13
                call Gotoxy
                mov edx, OFFSET level3wall3char
                call WriteString
                inc esi
                cmp esi,16
                jl drawWallLoop13      
        ;line14 draw
            mov esi, 0 ; Use ESI to index wall positions
            drawWallLoop14:
               mov al,[ level3wallline9+ esi]
                mov dl,al
                mov dh,14
                call Gotoxy
                mov edx, OFFSET level3wall3char
                call WriteString
                inc esi
                cmp esi,25
                jl drawWallLoop14
        ;line15 draw
            mov esi, 0 ; Use ESI to index wall positions
            drawWallLoop15:
               mov al,[ level3wallline9+ esi]
                mov dl,al
                mov dh,15
                call Gotoxy
                mov edx, OFFSET level3wall3char
                call WriteString
                inc esi
                cmp esi,25
                jl drawWallLoop15
        ;line16 draw
            mov esi, 0 ; Use ESI to index wall positions
            drawWallLoop16:
               mov al,[ level3wallline8+ esi]
                mov dl,al
                mov dh,16
                call Gotoxy
                mov edx, OFFSET level3wall3char
                call WriteString
                inc esi
                cmp esi,47
                jl drawWallLoop16
        ;line17 has no walls
        ;line18 draw
            mov esi, 6 ; Use ESI to index wall positions
            drawWallLoop18:
               mov al,[ level3wallline8+ esi]
                mov dl,al
                mov dh,18
                call Gotoxy
                mov edx, OFFSET level3wall3char
                call WriteString
                inc esi
                cmp esi,45
                jl drawWallLoop18
         ;line19&20draw
            mov eax,magenta ;(black * 16)
                call SetTextColor
            mov dl,level3wallline7
            mov dh,19
            call Gotoxy
            mov edx, OFFSET obstaclechar
            call WriteString
            mov dl,level3wallline7
            mov dh,20
            call Gotoxy
            mov edx, OFFSET obstaclechar
            call WriteString
            mov eax,blue ;(black * 16)
                call SetTextColor

         ;line21 draw 
            mov esi, 0 ; Use ESI to index wall positions
            drawWallLoop20:
                mov al,[ level3wallline6+ esi]
            
                mov dl,al
                mov dh,21
                call Gotoxy
                mov edx, OFFSET level3wall3char
                call WriteString
                inc esi
                cmp esi,37
                jl drawWallLoop20
        ;line22 draw
            mov esi, 0 ; Use ESI to index wall positions
            drawWallLoop22:
               mov al,[ level3wallline3+ esi]
                mov dl,al
                mov dh,22
                call Gotoxy
                mov edx, OFFSET level3wall3char
                call WriteString
                inc esi
                cmp esi,36
               jl drawWallLoop22
            mov esi, 0 ; Use ESI to index wall positions
            drawWallLoop23:
               mov al,[ level3wallline3+ esi]
                mov dl,al
                mov dh,23
                call Gotoxy
                mov edx, OFFSET level3wall3char
                call WriteString
                inc esi
                cmp esi,36
               jl drawWallLoop23
            mov esi, 0 ; Use ESI to index wall positions
            drawWallLoop24:
               mov al,[ level3wallline3+ esi]
                mov dl,al
                mov dh,24
                call Gotoxy
                mov edx, OFFSET level3wall3char
                call WriteString
                inc esi
                cmp esi,36
               jl drawWallLoop24

     ret
    DrawWalls3 ENDP
;;=======================Check Coin Collision==========================;

    CheckCoinCollision PROC
        mov ecx,0
            detectcollisionwithcoins:
                mov al,[coinline1+ecx]
                cmp xPos,al
                je increasescore
                cmp ecx,42
                je return
                inc ecx
                jmp detectcollisionwithcoins
                increasescore:
                    mov [coinline1+ecx],-1
                    inc score
       return:
            ret
    CheckCoinCollision ENDP
;=======================Enter Name Page==========================;
EnterName PROC
    ; draw ground at (0,29):
        mov eax,magenta ;(black * 16)
        call SetTextColor
        mov dl,0
        mov dh,27
        call Gotoxy
        mov edx,OFFSET ground
        call WriteString
        mov dl,0
        mov dh,1
        call Gotoxy
        mov edx,OFFSET ground
        call WriteString

        call SetTextColor
        mov ecx,25
        mov dh,2
        mov temp,dh
        l1:
            mov dh,temp
            mov dl,1
            call Gotoxy
            mov edx,OFFSET ground1
            call WriteString
            inc temp
            loop l1

             mov ecx,25
             mov dh,2
             mov temp,dh
        l2:
            mov dh,temp
            mov dl,86
            call Gotoxy
            mov edx,OFFSET ground2
            call WriteString
            inc temp
            loop l2
    mov eax,blue +(black*16)
    call SetTextColor
    mov dh,5
    mov dl,20
    call Gotoxy
    mov edx,offset nameborder1
    call WriteString
    mov eax,cyan +(black*16)
    call SetTextColor
    mov dh,6
    mov dl,20
    call Gotoxy
    mov edx,offset name11
    call WriteString
    mov dh,7
    mov dl,20
    call Gotoxy
    mov edx,offset name12
    call WriteString
    mov dh,8
    mov dl,20
    call Gotoxy
    mov edx,offset name13
    call WriteString
    mov dh,9
    mov dl,20
    call Gotoxy
    mov edx,offset name14
    call WriteString

    mov eax,blue +(black*16)
    call SetTextColor
    mov dh,10
    mov dl,20
    call Gotoxy
    mov edx,offset nameborder1
    call WriteString

   
    mov dh,12
    mov dl,30
    call Gotoxy
    mov edx,offset name2
    mov ecx,255
    call ReadString
    mov name2length,eax
    mov eax,black +(black*16)
    call SetTextColor

        

    ret
EnterName ENDP
;=======================Int to String=========================;
    IntToString PROC
            mov esi,3
            mov edx,0
            mov eax,score
            mov ecx,10
            div ecx
            add edx,30h
            mov scorestring4,edx
            dec esi
            mov edx,0
            mov ecx,10
            div ecx
            add edx,30h
            mov scorestring3,edx
            dec esi
            mov edx,0
            mov ecx,10
            div ecx
            add edx,30h
            mov scorestring2,edx
            dec esi
            mov edx,0
            mov ecx,10
            div ecx
            add edx,30h
            mov scorestring1,edx
           ret
    IntToString ENDP
;=======================Save data=========================;
    SaveData PROC
        ;convert score to string
        call IntToString
        inc name2length


        invoke CreateFileA, ADDR fileName, FILE_APPEND_DATA, FILE_SHARE_WRITE, 0, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
        mov fileHandle, eax  

        mov edx, OFFSET name2 
        mov ecx, name2length
        invoke WriteFile, fileHandle, edx, ecx, ADDR bytesWritten, NULL
        cmp level,1
        jne includelevel2
        mov edx,offset level1text 
        mov ecx, lengthof level1text 
        invoke WriteFile, fileHandle, edx, ecx, ADDR bytesWritten, NULL
        jmp includelevel
        includelevel2:
        cmp level,2
        jne includelevel3
        mov edx,offset level2text 
        mov ecx, lengthof level2text 
        invoke WriteFile, fileHandle, edx, ecx, ADDR bytesWritten, NULL
        jmp includelevel
        includelevel3:
        mov edx,offset level3text 
        mov ecx, lengthof level3text 
        invoke WriteFile, fileHandle, edx, ecx, ADDR bytesWritten, NULL
        
        includelevel:
        mov edx,offset scorestring1
        mov ecx, lengthof scorestring1
        invoke WriteFile, fileHandle, edx, ecx, ADDR bytesWritten, NULL
        mov edx,offset scorestring2 
        mov ecx, lengthof scorestring2 
        invoke WriteFile, fileHandle, edx, ecx, ADDR bytesWritten, NULL
        mov edx,offset scorestring3
        mov ecx, lengthof scorestring3 
        invoke WriteFile, fileHandle, edx, ecx, ADDR bytesWritten, NULL
        mov edx,offset scorestring4
        mov ecx, lengthof scorestring4
        invoke WriteFile, fileHandle, edx, ecx, ADDR bytesWritten, NULL
        invoke CloseHandle, fileHandle
        
           ret
    SaveData ENDP
;;=======================Game lost Page==========================;
    GameLost PROC
        call clrscr
        mov eax,brown ;(black * 16)
        call SetTextColor
        mov dh,19
        mov dl,30
        call Gotoxy
        mov edx,offset name2
        call WriteString
        
        cmp level,1
        jne printlevel2
        mov dh,20
        mov dl,30
        call Gotoxy
        mov edx,offset level1text
        call WriteString
        jmp print111
        printlevel2:
            cmp level,2
        jne printlevel3
        mov dh,20
        mov dl,30
        call Gotoxy
        mov edx,offset level2text
        call WriteString
        jmp print111
        printlevel3:
        mov dh,20
        mov dl,30
        call Gotoxy
        mov edx,offset level3text
        call WriteString
        jmp print111
        print111:
        mov dh,21
        mov dl,30
        call Gotoxy
        mov eax,score
            call WriteInt
         call SaveData
        ; draw ground at (0,29):
            mov eax,brown ;(black * 16)
            call SetTextColor
            mov dl,0
            mov dh,27
            call Gotoxy
            mov edx,OFFSET ground
            call WriteString
            mov dl,0
            mov dh,1
            call Gotoxy
            mov edx,OFFSET ground
            call WriteString

            call SetTextColor
            mov ecx,25
            mov dh,2
            mov temp,dh
            l1:
            mov dh,temp
            mov dl,1
            call Gotoxy
            mov edx,OFFSET ground1
            call WriteString
            inc temp
            loop l1

             mov ecx,25
             mov dh,2
             mov temp,dh
           l2:
            mov dh,temp
            mov dl,86
            call Gotoxy
            mov edx,OFFSET ground2
            call WriteString
            inc temp
            loop l2
    ;print you lost
        mov eax,red
        call SetTextColor
        mov dh,9
        mov dl,3
        call Gotoxy
        mov edx,offset gamelost1
        call WriteString

        mov dh,10
        mov dl,3
        call Gotoxy
        mov edx,offset gamelost2
        call WriteString

        mov dh,11
        mov dl,3
        call Gotoxy
        mov edx,offset gamelost3
        call WriteString

        mov dh,12
        mov dl,3
        call Gotoxy
        mov edx,offset gamelost4
        call WriteString

        mov dh,13
        mov dl,3
        call Gotoxy
        mov edx,offset gamelost5
        call WriteString
        
        mov dh,14
        mov dl,3
        call Gotoxy
        mov edx,offset gamelost6
        call WriteString
        mov dh,15
        mov dl,3
        call Gotoxy
        mov edx,offset gamelost7
        call WriteString
        mov dh,16
        mov dl,3
        call Gotoxy
        mov edx,offset gamelost8
        call WriteString

        

        exit
    GameLost ENDP
;;=======================Game won Page==========================;
    GameWon PROC
        call clrscr
        ; draw ground at (0,29):
        mov eax,blue ;(black * 16)
        call SetTextColor
        mov dl,0
        mov dh,27
        call Gotoxy
        mov edx,OFFSET ground
        call WriteString
        mov dl,0
        mov dh,1
        call Gotoxy
        mov edx,OFFSET ground
        call WriteString

        call SetTextColor
        mov ecx,25
        mov dh,2
        mov temp,dh
        l1:
            mov dh,temp
            mov dl,1
            call Gotoxy
            mov edx,OFFSET ground1
            call WriteString
            inc temp
            loop l1

             mov ecx,25
             mov dh,2
             mov temp,dh
        l2:
            mov dh,temp
            mov dl,86
            call Gotoxy
            mov edx,OFFSET ground2
            call WriteString
            inc temp
            loop l2
        mov eax,brown ;(black * 16)
        call SetTextColor
        mov dh,19
        mov dl,30
        call Gotoxy
        mov edx,offset name2
        call WriteString
        
        cmp level,1
        jne printlevel2
        mov dh,20
        mov dl,30
        call Gotoxy
        mov edx,offset level1text
        call WriteString
        jmp print111
        printlevel2:
            cmp level,2
        jne printlevel3
        mov dh,20
        mov dl,30
        call Gotoxy
        mov edx,offset level2text
        call WriteString
        jmp print111
        printlevel3:
        mov dh,20
        mov dl,30
        call Gotoxy
        mov edx,offset level3text
        call WriteString
        jmp print111
        print111:
        mov dh,21
        mov dl,30
        call Gotoxy
        mov eax,score
            call WriteInt
        call SaveData
        mov eax,green
        call SetTextColor
        mov dh,9
        mov dl,6
        call Gotoxy
        mov edx,offset gameend1
        call WriteString

        mov dh,10
        mov dl,6
        call Gotoxy
        mov edx,offset gameend2
        call WriteString

        mov dh,11
        mov dl,6
        call Gotoxy
        mov edx,offset gameend3
        call WriteString

        mov dh,12
        mov dl,6
        call Gotoxy
        mov edx,offset gameend4
        call WriteString

        mov dh,13
        mov dl,6
        call Gotoxy
        mov edx,offset gameend5
        call WriteString
        mov dh,14
        mov dl,6
        call Gotoxy
        mov edx,offset gameend6
        call WriteString
        mov dh,15
        mov dl,6
        call Gotoxy
        mov edx,offset gameend7
        call WriteString
        mov dh,16
        mov dl,6
        call Gotoxy
        mov edx,offset gameend8
        call WriteString
        exit
    GameWon ENDP
;=======================Pause Game Page==========================;
    PauseGame PROC
        mov eax,red
        call SetTextColor
        looppg:
            mov dh,19
            mov dl,97
            call Gotoxy
            mov edx,offset pausegametext1
            call WriteString
            mov dh,18
            mov dl,95
            call Gotoxy
            mov edx,offset pacmanname17
            call WriteString
            mov dh,20
            mov dl,95
            call Gotoxy
            mov edx,offset pacmanname17
            call WriteString
            call ReadChar
            mov inputChar,al

            cmp inputChar,"r"
            je return
            jmp looppg

        return:
            mov eax,black
            call SetTextColor
            mov dh,19
            mov dl,97
            call Gotoxy
            mov edx,offset pausegametext1
            call WriteString
            mov dh,18
            mov dl,95
            call Gotoxy
            mov edx,offset pacmanname17
            call WriteString
            mov dh,20
            mov dl,95
            call Gotoxy
            mov edx,offset pacmanname17
            call WriteString
            call ReadChar
            mov inputChar,al
            ret
    PauseGame ENDP
;=======================reset coin coordinates==========================;
    ResetCoinCoordinates PROC
                mov ecx,0
                coincoordinates:
                    mov al,[coinline25+ecx]
                    mov [coinline1+ecx],al
                    cmp ecx,42
                    je return
                    inc ecx
                jmp coincoordinates
        return:
            ret
    ResetCoinCoordinates ENDP
;=======================moving of ghost==========================;
    GhostMovement PROC
        moveUp:
            cmp yPosghost,2
            je moveDown
            call UpdateGhost
            dec yPosghost
            call DrawGhost
            jmp gameLoop

        moveDown:
            cmp yPosghost,26
            je moveUp
            call UpdateGhost
            inc yPosghost
            call DrawGhost
            jmp gameLoop

        moveLeft:
            cmp xPos,2
            je gameLoop
            mov esi,0
            checkcollisionleft:
                cmp xPosghost,12
                jne checkcollisionleft1
                    mov bl,[wallPositionsY+esi]
                    cmp yPosghost,bl
                    je gameLoop
                cmp esi,19
                je checkcollisionleft2
                inc esi
                jmp checkcollisionleft
            
            checkcollisionleft1:
                cmp xPosghost,25
                jne checkcollisionleft2
                    mov bl,[wallPositionsY+esi]
                    cmp yPosghost,bl
                    je gameLoop
                cmp esi,19
                je checkcollisionleft2
                inc esi
                jmp checkcollisionleft1

            checkcollisionleft2:
                cmp xPosghost,55
                jne checkcollisionleft3
                    mov bl,[wallPositionsY10+esi]
                    cmp yPosghost,bl
                    je gameLoop
                cmp esi,19
                je checkcollisionleft3
                inc esi
                jmp checkcollisionleft2
            checkcollisionleft3:
                cmp xPosghost,82
                jne movel
                    mov bl,[wallPositionsY+esi]
                    cmp yPosghost,bl
                    je gameLoop
                cmp esi,19
                je movel
                inc esi
                jmp checkcollisionleft3
            movel:
                call UpdateGhost
                dec xPosghost
                call DrawGhost
                jmp gameLoop

        moveRight:
            cmp xPosghost,85
            je gameLoop
            mov esi,0
            checkcollisionright:
                cmp xPosghost,6
                jne checkcollisionright1
                    mov bl,[wallPositionsY+esi]
                    cmp yPosghost,bl
                    je gameLoop
                cmp esi,19
                je checkcollisionright2
                inc esi
                jmp checkcollisionright
            
            checkcollisionright1:
                cmp xPosghost,19
                jne checkcollisionright2
                    mov bl,[wallPositionsY+esi]
                    cmp yPosghost,bl
                    je gameLoop
                cmp esi,19
                je checkcollisionright2
                inc esi
                jmp checkcollisionright1

            checkcollisionright2:
                    cmp xPosghost,34
                    jne checkcollisionright3
                    mov bl,[wallPositionsY9+esi]
                    cmp yPosghost,bl
                    je gameLoop
                    cmp esi,12
                    je checkcollisionright3
                    inc esi
                    jmp checkcollisionright2
                
            checkcollisionright3:
                cmp xPosghost,61
                jne checkcollisionright4
                    mov bl,[wallPositionsY+esi]
                    cmp yPosghost,bl
                    je gameLoop
                cmp esi,19
                je checkcollisionright4
                inc esi
                jmp checkcollisionright3

            checkcollisionright4:
                cmp xPosghost,49
                jne mover
                    mov bl,[wallPositionsY10+esi]
                    cmp yPosghost,bl
                    je gameLoop
                cmp esi,19
                je mover
                inc esi
                jmp checkcollisionright3
            mover:
            call UpdateGhost
            inc xPosghost
            call DrawGhost
            jmp gameLoop
        gameLoop:
            call UpdateGhost
            inc yPosghost
            call DrawGhost
            
        ret
    GhostMovement ENDP
;=======================level 1==========================;
Level1 PROC
    
    call DrawCoins1
    call DrawPower1
    call DrawWalls
    mov level,1
    ; draw ground at (0,29):
        mov eax,blue ;(black * 16)
        call SetTextColor
        mov dl,0
        mov dh,27
        call Gotoxy
        mov edx,OFFSET ground
        call WriteString
        mov dl,0
        mov dh,1
        call Gotoxy
        mov edx,OFFSET ground
        call WriteString

        call SetTextColor
        mov ecx,25
        mov dh,2
        mov temp,dh
        l1:
            mov dh,temp
            mov dl,1
            call Gotoxy
            mov edx,OFFSET ground1
            call WriteString
            inc temp
            loop l1

             mov ecx,25
             mov dh,2
             mov temp,dh
        l2:
            mov dh,temp
            mov dl,86
            call Gotoxy
            mov edx,OFFSET ground2
            call WriteString
            inc temp
            loop l2
    call DrawPlayer
    call DrawGhost

    call CreateRandomCoin
    call DrawCoin
    call Randomize

    pacman:
        mov eax,yellow
        call SetTextColor
        mov dh,5
        mov dl,95
        call Gotoxy
        mov edx,offset pacmanname16
        call WriteString

        mov dh,4
        mov dl,95
        call Gotoxy
        mov edx,offset pacmanname17
        call WriteString

        mov dh,6
        mov dl,95
        call Gotoxy
        mov edx,offset pacmanname17
        call WriteString
    
       levelprinting:
          mov eax,magenta ;(black * 16)
          call SetTextColor
          mov dh,8
          mov dl,97
          call Gotoxy
          mov edx,offset level1print
          call WriteString
        

       characterprinting:
          mov eax,lightcyan
          call SetTextColor
          mov dh,14
          mov dl,100
          call Gotoxy
          mov edx,offset gameendtext2
          call WriteString
    
    gameLoop:

        ;next level
                cmp score,50
                jle noend
                ret
                noend:

            ;endgame if lives=0
                cmp lives,0
                jne noendgame
                mov level,1
                call GameLost

                noendgame:

                ;ghost collision
            mov al,xPosghost
            cmp xPos,al
            jne noghost
            mov bl,yPosghost
            cmp yPos,bl
            jne noghost
            dec lives
            

            noghost:
                ;ghost
            ;call checkGhostCollision
            cmp randomghostmov, 0
            je moveGhostRight
            cmp randomghostmov, 1
            je moveGhostLeft
            cmp randomghostmov, 2
            je moveGhostUp
            cmp randomghostmov, 3
            je moveGhostDown
            jmp moveGhostDown
            moveGhostRight:
                cmp xPosghost,83
                jne mr
                mov randomghostmov,3
                jmp gameLoop
                mr:
                    call UpdateGhost
                    inc xPosghost
                    call DrawGhost
                   jmp endGhostMovement

          moveGhostLeft:
                cmp xPosghost,2
                jne ml
                mov randomghostmov,3
                jmp gameLoop
                ml:
                call UpdateGhost
                dec xPosghost
                call DrawGhost
                jmp endGhostMovement

        
           moveGhostUp:
                cmp yPosghost,2
                jne mu
                mov randomghostmov,0
                jmp gameLoop
                mu:
                call UpdateGhost
                dec yPosghost
                call DrawGhost

                jmp endGhostMovement
    
            moveGhostDown:
                cmp yPosghost,26
                jne md
                cmp xPosghost,2
                jne moveleft1
                mov randomghostmov,0
                jmp gameLoop
                moveleft1:
                mov randomghostmov,1
                jmp gameLoop

                md:
                call UpdateGhost
                inc yPosghost
                call DrawGhost
                jmp endGhostMovement

            endGhostMovement:
        
        ;collectpowerups
            cmp power1,1
            je check1
            jmp check2
            check1:
                cmp yPos,3
                jne check2
                cmp xPos,4
                jne check2
                add score,4
                mov power1,0
            check2:
                cmp power2,1
                jne check3
                cmp yPos,3
                jne check3
                cmp xPos,82
                jne check3
                add score,4
                mov power2,0
            check3:
                cmp power3,1
                jne check4
                cmp yPos,25
                jne check4
                cmp xPos,82
                jne check4
                add score,4
                mov power3,0
            check4:
                cmp power4,1
                jne checkend
                cmp yPos,25
                jne checkend
                cmp xPos,4
                jne checkend
                add score,4
                mov power4,0
            checkend:

        ;detect collision with coins and inc score
            cmp score,200
            je exitGame

            eatconsatline1:
                cmp yPos,2
                jne eatcoinsatline2
                call CheckCoinCollision
            

            eatcoinsatline2:
                cmp yPos,3
                jne eatcoinsatline3
                mov ecx,0
                detectcollisionwithcoins:
                    mov al,[coinline2+ecx]
                    cmp xPos,al
                    je increasescore
                    cmp ecx,42
                    je eatcoinsatline3
                    inc ecx
                    jmp detectcollisionwithcoins
                    increasescore:
                    mov [coinline2+ecx],-1
                    inc score
                

            eatcoinsatline3:
                cmp yPos,4
                jne eatcoinsatline4
                mov ecx,0
                detectcollisionwithcoins1:
                    mov al,[coinline3+ecx]
                    cmp xPos,al
                    je increasescore1
                    cmp ecx,42
                    je eatcoinsatline4
                    inc ecx
                    jmp detectcollisionwithcoins1
                    increasescore1:
                    mov [coinline3+ecx],-1
                    inc score

            eatcoinsatline4:
                cmp yPos,5
                jne eatcoinsatline5
                mov ecx,0
                detectcollisionwithcoins2:
                    mov al,[coinline4+ecx]
                    cmp xPos,al
                    je increasescore2
                    cmp ecx,42
                    je eatcoinsatline5
                    inc ecx
                    jmp detectcollisionwithcoins2
                    increasescore2:
                    mov [coinline4+ecx],-1
                    inc score


            eatcoinsatline5:
                cmp yPos,6
                jne eatcoinsatline6
                mov ecx,0
                detectcollisionwithcoins3:
                    mov al,[coinline5+ecx]
                    cmp xPos,al
                    je increasescore3
                    cmp ecx,42
                    je eatcoinsatline6
                    inc ecx
                    jmp detectcollisionwithcoins3
                    increasescore3:
                    mov [coinline5+ecx],-1
                    inc score

            eatcoinsatline6:
                cmp yPos,7
                jne eatcoinsatline7
                mov ecx,0
                detectcollisionwithcoins6:
                    mov al,[coinline6+ecx]
                    cmp xPos,al
                    je increasescore4
                    cmp ecx,42
                    je eatcoinsatline7
                    inc ecx
                    jmp detectcollisionwithcoins6
                    increasescore4:
                    mov [coinline6+ecx],-1
                    inc score

            eatcoinsatline7:
                cmp yPos,8
                jne eatcoinsatline8
                mov ecx,0
                detectcollisionwithcoins7:
                    mov al,[coinline7+ecx]
                    cmp xPos,al
                    je increasescore5
                    cmp ecx,42
                    je eatcoinsatline8
                    inc ecx
                    jmp detectcollisionwithcoins7
                    increasescore5:
                    mov [coinline7+ecx],-1
                    inc score

            eatcoinsatline8:
                cmp yPos,9
                jne eatcoinsatline9
                mov ecx,0
                detectcollisionwithcoins8:
                    mov al,[coinline8+ecx]
                    cmp xPos,al
                    je increasescore6
                    cmp ecx,42
                    je eatcoinsatline9
                    inc ecx
                    jmp detectcollisionwithcoins8
                    increasescore6:
                    mov [coinline8+ecx],-1
                    inc score

            eatcoinsatline9:
                cmp yPos,10
                jne eatcoinsatline10
                mov ecx,0
                detectcollisionwithcoins9:
                    mov al,[coinline9+ecx]
                    cmp xPos,al
                    je increasescore7
                    cmp ecx,42
                    je eatcoinsatline10
                    inc ecx
                    jmp detectcollisionwithcoins9
                    increasescore7:
                    mov [coinline9+ecx],-1
                    inc score

            eatcoinsatline10:
                cmp yPos,11
                jne eatcoinsatline11
                mov ecx,0
                detectcollisionwithcoins10:
                    mov al,[coinline10+ecx]
                    cmp xPos,al
                    je increasescore8
                    cmp ecx,42
                    je eatcoinsatline10
                    inc ecx
                    jmp detectcollisionwithcoins10
                    increasescore8:
                    mov [coinline10+ecx],-1
                    inc score

            eatcoinsatline11:
                cmp yPos,12
                jne eatcoinsatline12
                mov ecx,0
                detectcollisionwithcoins11:
                    mov al,[coinline11+ecx]
                    cmp xPos,al
                    je increasescore9
                    cmp ecx,42
                    je eatcoinsatline12
                    inc ecx
                    jmp detectcollisionwithcoins11
                    increasescore9:
                    mov [coinline11+ecx],-1
                    inc score

            eatcoinsatline12:
                cmp yPos,13
                jne eatcoinsatline13
                mov ecx,0
                detectcollisionwithcoins12:
                    mov al,[coinline12+ecx]
                    cmp xPos,al
                    je increasescore10
                    cmp ecx,42
                    je eatcoinsatline13
                    inc ecx
                    jmp detectcollisionwithcoins12
                    increasescore10:
                    mov [coinline12+ecx],-1
                    inc score

            eatcoinsatline13:
                cmp yPos,14
                jne eatcoinsatline14
                mov ecx,0
                detectcollisionwithcoins13:
                    mov al,[coinline13+ecx]
                    cmp xPos,al
                    je increasescore11
                    cmp ecx,42
                    je eatcoinsatline14
                    inc ecx
                    jmp detectcollisionwithcoins13
                    increasescore11:
                    mov [coinline13+ecx],-1
                    inc score

            eatcoinsatline14:
                cmp yPos,15
                jne eatcoinsatline15
                mov ecx,0
                detectcollisionwithcoins14:
                    mov al,[coinline14+ecx]
                    cmp xPos,al
                    je increasescore12
                    cmp ecx,42
                    je eatcoinsatline15
                    inc ecx
                    jmp detectcollisionwithcoins14
                    increasescore12:
                    mov [coinline14+ecx],-1
                    inc score

            eatcoinsatline15:
                cmp yPos,16
                jne eatcoinsatline16
                mov ecx,0
                detectcollisionwithcoins15:
                    mov al,[coinline15+ecx]
                    cmp xPos,al
                    je increasescore13
                    cmp ecx,42
                    je eatcoinsatline16
                    inc ecx
                    jmp detectcollisionwithcoins15
                    increasescore13:
                    mov [coinline15+ecx],-1
                    inc score

            eatcoinsatline16:
                cmp yPos,17
                jne eatcoinsatline17
                mov ecx,0
                detectcollisionwithcoins16:
                    mov al,[coinline16+ecx]
                    cmp xPos,al
                    je increasescore14
                    cmp ecx,42
                    je eatcoinsatline17
                    inc ecx
                    jmp detectcollisionwithcoins16
                    increasescore14:
                    mov [coinline16+ecx],-1
                    inc score

            eatcoinsatline17:
                cmp yPos,18
                jne eatcoinsatline18
                mov ecx,0
                detectcollisionwithcoins17:
                    mov al,[coinline17+ecx]
                    cmp xPos,al
                    je increasescore15
                    cmp ecx,42
                    je eatcoinsatline18
                    inc ecx
                    jmp detectcollisionwithcoins17
                    increasescore15:
                    mov [coinline17+ecx],-1
                    inc score


            eatcoinsatline18:
                cmp yPos,19
                jne eatcoinsatline19
                mov ecx,0
                detectcollisionwithcoins18:
                    mov al,[coinline18+ecx]
                    cmp xPos,al
                    je increasescore16
                    cmp ecx,42
                    je eatcoinsatline19
                    inc ecx
                    jmp detectcollisionwithcoins18
                    increasescore16:
                    mov [coinline18+ecx],-1
                    inc score

            eatcoinsatline19:
                cmp yPos,20
                jne eatcoinsatline20
                mov ecx,0
                detectcollisionwithcoins19:
                    mov al,[coinline19+ecx]
                    cmp xPos,al
                    je increasescore17
                    cmp ecx,42
                    je eatcoinsatline20
                    inc ecx
                    jmp detectcollisionwithcoins19
                    increasescore17:
                    mov [coinline19+ecx],-1
                    inc score


            eatcoinsatline20:
                cmp yPos,21
                jne eatcoinsatline21
                mov ecx,0
                detectcollisionwithcoins20:
                    mov al,[coinline20+ecx]
                    cmp xPos,al
                    je increasescore18
                    cmp ecx,42
                    je eatcoinsatline21
                    inc ecx
                    jmp detectcollisionwithcoins20
                    increasescore18:
                    mov [coinline20+ecx],-1
                    inc score

            eatcoinsatline21:
                cmp yPos,22
                jne eatcoinsatline22
                mov ecx,0
                detectcollisionwithcoins21:
                    mov al,[coinline21+ecx]
                    cmp xPos,al
                    je increasescore19
                    cmp ecx,42
                    je eatcoinsatline22
                    inc ecx
                    jmp detectcollisionwithcoins21
                    increasescore19:
                    mov [coinline21+ecx],-1
                    inc score

            eatcoinsatline22:
                cmp yPos,23
                jne eatcoinsatline23
                mov ecx,0
                detectcollisionwithcoins22:
                    mov al,[coinline22+ecx]
                    cmp xPos,al
                    je increasescore20
                    cmp ecx,42
                    je eatcoinsatline23
                    inc ecx
                    jmp detectcollisionwithcoins22
                    increasescore20:
                    mov [coinline22+ecx],-1
                    inc score

            eatcoinsatline23:
                cmp yPos,24
                jne eatcoinsatline24
                mov ecx,0
                detectcollisionwithcoins23:
                    mov al,[coinline23+ecx]
                    cmp xPos,al
                    je increasescore21
                    cmp ecx,42
                    je eatcoinsatline24
                    inc ecx
                    jmp detectcollisionwithcoins23
                    increasescore21:
                    mov [coinline23+ecx],-1
                    inc score

            eatcoinsatline24:
                cmp yPos,25
                jne nocoins
                mov ecx,0
                detectcollisionwithcoins24:
                    mov al,[coinline24+ecx]
                    cmp xPos,al
                    je increasescore22
                    cmp ecx,42
                    je nocoins
                    inc ecx
                    jmp detectcollisionwithcoins24
                    increasescore22:
                    mov [coinline24+ecx],-1
                    inc score
            

            nocoins:
        cmp score,50
        je DrawFruit1
        jmp notdrawfruit
        DrawFruit1:
            call DrawFruit
        notdrawfruit:
        
        gettingpoints5:
            mov bl,xPos
            cmp bl,xFruitPos
            jne notCollecting
            mov bl,yPos
            cmp bl,yFruitPos
            jne notCollecting
             ; player is intersecting coin:
            add score,10
            add score1,10
            mov xFruitPos,0
            mov yFruitPos,0
        
        notCollecting:

            mov eax,white (black * 16)
            call SetTextColor

        ; draw_score:
            mov eax,lightblue ;(black * 16)
            call SetTextColor
            mov dl,97
            mov dh,10
            call Gotoxy
            mov edx,OFFSET strScore
            call WriteString
            mov eax,score
            call WriteInt

        ;draw lives
           mov eax,green ;(black * 16)
           call SetTextColor
           mov dl,97
           mov dh,12
           call Gotoxy
           mov edx,OFFSET livesprint
           call WriteString
           mov al,lives
           call WriteInt

        
        onGround:

        ; get user key input:
            call ReadChar
            mov inputChar,al

        ; exit game if user types 'x':
            cmp inputChar,"x"
            je exitGame

            cmp inputChar,"w"
            je moveUp

            cmp inputChar,"s"
            je moveDown

            cmp inputChar,"a"
            je moveLeft

           cmp inputChar,"d"
            je moveRight

           cmp inputChar,"p"
            je pauseGame1
            jmp gameLoop



        pauseGame1:
            call PauseGame   ; Call your pause function

        moveUp:
            cmp yPos,2
            je gameLoop
                cmp yPos,25
                jne moveu
                mov al,7
                loopup1:
                    cmp xPos,al
                    je gameLoop
                    cmp al,11
                    je checkup1
                    inc al
                    jmp loopup1
                checkup1:
                    mov al,18
                    loopup2:
                        cmp xPos,al
                        je gameLoop
                        cmp al,24
                        je checkup2
                        inc al
                        jmp loopup2
                checkup2:
                    mov al,34
                    loopup3:
                        cmp xPos,al
                        je gameLoop
                        cmp al,55
                        je checkup3
                        inc al
                        jmp loopup3
                checkup3:
                    mov al,61
                    loopup4:
                        cmp xPos,al
                        je gameLoop
                        cmp al,81
                        je moveu
                        inc al
                        jmp loopup4

            moveu:
            call UpdatePlayer
            dec yPos
            call DrawPlayer
            jmp gameLoop

        moveDown:
            cmp yPos,26
            je gameLoop
                cmp yPos,4
                jne moved
                mov al,7
                loopdown1:
                    cmp xPos,al
                    je gameLoop
                    cmp al,11
                    je checkdown1
                    inc al
                    jmp loopdown1
                checkdown1:
                    mov al,18
                    loopdown2:
                        cmp xPos,al
                        je gameLoop
                        cmp al,24
                        je checkdown2
                        inc al
                        jmp loopdown2
                checkdown2:
                    mov al,34
                    loopdown3:
                        cmp xPos,al
                        je gameLoop
                        cmp al,55
                        je checkdown3
                        inc al
                        jmp loopdown3
                checkdown3:
                    mov al,61
                    loopdown4:
                        cmp xPos,al
                        je gameLoop
                        cmp al,81
                        je moved
                        inc al
                        jmp loopdown4

            moved:
            call UpdatePlayer
            inc yPos
            call DrawPlayer
            jmp gameLoop

        moveLeft:
            cmp xPos,2
            je gameLoop
            mov esi,0
            checkcollisionleft:
                cmp xPos,12
                jne checkcollisionleft1
                    mov bl,[wallPositionsY+esi]
                    cmp yPos,bl
                    je gameLoop
                cmp esi,19
                je checkcollisionleft2
                inc esi
                jmp checkcollisionleft
            
            checkcollisionleft1:
                cmp xPos,25
                jne checkcollisionleft2
                    mov bl,[wallPositionsY+esi]
                    cmp yPos,bl
                    je gameLoop
                cmp esi,19
                je checkcollisionleft2
                inc esi
                jmp checkcollisionleft1

            checkcollisionleft2:
                cmp xPos,55
                jne checkcollisionleft3
                    mov bl,[wallPositionsY10+esi]
                    cmp yPos,bl
                    je gameLoop
                cmp esi,19
                je checkcollisionleft3
                inc esi
                jmp checkcollisionleft2
            checkcollisionleft3:
                cmp xPos,82
                jne movel
                    mov bl,[wallPositionsY+esi]
                    cmp yPos,bl
                    je gameLoop
                cmp esi,19
                je movel
                inc esi
                jmp checkcollisionleft3
            movel:
                call UpdatePlayer
                dec xPos
                call DrawPlayer
                jmp gameLoop

        moveRight:
            cmp xPos,85
            je gameLoop
            mov esi,0
            checkcollisionright:
                cmp xPos,6
                jne checkcollisionright1
                    mov bl,[wallPositionsY+esi]
                    cmp yPos,bl
                    je gameLoop
                cmp esi,19
                je checkcollisionright2
                inc esi
                jmp checkcollisionright
            
            checkcollisionright1:
                cmp xPos,19
                jne checkcollisionright2
                    mov bl,[wallPositionsY+esi]
                    cmp yPos,bl
                    je gameLoop
                cmp esi,19
                je checkcollisionright2
                inc esi
                jmp checkcollisionright1

            checkcollisionright2:
                    cmp xPos,34
                    jne checkcollisionright3
                    mov bl,[wallPositionsY9+esi]
                    cmp yPos,bl
                    je gameLoop
                    cmp esi,12
                    je checkcollisionright3
                    inc esi
                    jmp checkcollisionright2
                
            checkcollisionright3:
                cmp xPos,61
                jne checkcollisionright4
                    mov bl,[wallPositionsY+esi]
                    cmp yPos,bl
                    je gameLoop
                cmp esi,19
                je checkcollisionright4
                inc esi
                jmp checkcollisionright3

            checkcollisionright4:
                cmp xPos,49
                jne mover
                    mov bl,[wallPositionsY10+esi]
                    cmp yPos,bl
                    je gameLoop
                cmp esi,19
                je mover
                inc esi
                jmp checkcollisionright3
            mover:
            call UpdatePlayer
            inc xPos
            call DrawPlayer
            jmp gameLoop

       

    jmp gameLoop

    exitGame:
        ret
Level1 ENDP
;=======================Ghost moevment for level 2==========================;
    GhostMovement2 PROC
        ; Generate a random number from 1 to 4
        gameLoop:
            mov eax,3
            call RandomRange
            mov ebx, eax
            inc ebx
            mov randomghostmov,ebx
            ; Check the random number and move the ghost accordingly
            cmp ebx, 0
            je moveGhostRight
            cmp ebx, 1
            je moveGhostLeft
            cmp ebx, 2
            je moveGhostUp
            cmp ebx, 3
            je moveGhostDown
            jmp gameLoop

        moveGhostRight:
            jmp endGhostMovement

        moveGhostLeft:
            jmp endGhostMovement

        
        moveGhostUp:
        comment @
        moveUp:
            cmp yPosghost,2
            jne endGhostMovement
                checku1:
                    cmp yPosghost,15
                    jne checku2
                    mov al,5
                    moveuploop:
                        cmp xPosghost,al
                        je gameLoop
                        cmp al,10
                        je checku2
                        inc al
                        jmp moveuploop

                checku2:
                    cmp yPosghost,26
                    jne checku3
                    mov al,5
                    moveuploop2:
                        cmp xPosghost,al
                        je gameLoop
                        cmp al,24
                        je checku3
                        inc al
                        jmp moveuploop2

                checku3:
                    cmp yPosghost,15
                    jne checku4
                    mov al,19
                    moveuploop3:
                        cmp xPosghost,al
                        je gameLoop
                        cmp al,24
                        je checku4
                        inc al
                        jmp moveuploop3

                checku4:
                    cmp yPosghost,25
                    jne checku5
                    mov al,35
                    moveuploop4:
                        cmp xPosghost,al
                        je gameLoop
                        cmp al,56
                        je checku5
                        inc al
                        jmp moveuploop4

                checku5:
                    cmp yPosghost,16
                    jne checku6
                    mov al,35
                    moveuploop5:
                        cmp xPosghost,al
                        je gameLoop
                        cmp al,39
                        je checku6
                        inc al
                        jmp moveuploop5
                checku6:
                    cmp yPosghost,7
                    jne checku7
                    mov al,35
                    moveuploop6:
                        cmp xPosghost,al
                        je gameLoop
                        cmp al,56
                        je checku7
                        inc al
                        jmp moveuploop6
                checku7:
                    cmp yPosghost,15
                    jne checku8
                    mov al,62
                    moveuploop7:
                        cmp xPosghost,al
                        je gameLoop
                        cmp al,82
                        je checku8
                        inc al
                        jmp moveuploop7
                checku8:
                    cmp yPosghost,26
                    jne checku9
                    mov al,62
                    moveuploop8:
                        cmp xPosghost,al
                        je gameLoop
                        cmp al,82
                        je checku9
                        inc al
                        jmp moveuploop8

                checku9:
                    cmp yPosghost,23
                    jne moveu
                    mov al,62
                    moveuploop9:
                        cmp xPosghost,al
                        je gameLoop
                        cmp al,82
                        je moveu
                        inc al
                        jmp moveuploop9

            moveu:
            call UpdateGhost
            dec yPosghost
            call DrawGhost
         @
        jmp endGhostMovement
    
        moveGhostDown:
            jmp endGhostMovement

        endGhostMovement:
            ret

    GhostMovement2 ENDP
;=======================level 2==========================;
Level2 PROC
    mov xPos,50
    mov yPos,2
    mov xPosghost,2
    mov yPosghost,2
    mov level,2
    call DrawCoins1
    call DrawPower1
    call DrawWalls2
    
    ; draw ground at (0,29):
        mov eax,blue ;(black * 16)
        call SetTextColor
        mov dl,0
        mov dh,27
        call Gotoxy
        mov edx,OFFSET ground
        call WriteString
        mov dl,0
        mov dh,1
        call Gotoxy
        mov edx,OFFSET ground
        call WriteString

        call SetTextColor
        mov ecx,25
        mov dh,2
        mov temp,dh
        l1:
            mov dh,temp
            mov dl,1
            call Gotoxy
            mov edx,OFFSET ground1
            call WriteString
            inc temp
            loop l1

             mov ecx,25
             mov dh,2
             mov temp,dh
        l2:
            mov dh,temp
            mov dl,86
            call Gotoxy
            mov edx,OFFSET ground2
            call WriteString
            inc temp
            loop l2
    call DrawPlayer
    call DrawGhost
    pacman:
        mov eax,yellow
        call SetTextColor
        mov dh,5
        mov dl,95
        call Gotoxy
        mov edx,offset pacmanname16
        call WriteString

        mov dh,4
        mov dl,95
        call Gotoxy
        mov edx,offset pacmanname17
        call WriteString

        mov dh,6
        mov dl,95
        call Gotoxy
        mov edx,offset pacmanname17
        call WriteString
    
       levelprinting:
          mov eax,magenta ;(black * 16)
          call SetTextColor
          mov dh,8
          mov dl,97
          call Gotoxy
          mov edx,offset level2print
          call WriteString

       characterprinting:
          mov eax,lightcyan
          call SetTextColor
          mov dh,14
          mov dl,100
          call Gotoxy
          mov edx,offset gameendtext2
          call WriteString
      portalprinting:
            mov eax,brown +(brown*16) 
            call SetTextColor
            mov dh,13
            mov dl,1
            call Gotoxy
            mov al," "
            call WriteChar
            mov dh,2
            mov dl,85
            call Gotoxy
            mov al," "
            call WriteChar

        call UpdateGhost
                    inc xPosghost
                    call DrawGhost
 
        mov randomghostmov,2
    gameLoop:

            ;next level
                cmp score,100
                jne nonext
                call clrscr
                call level3
                nonext:
            ;ghost collision
                mov al,xPosghost
                cmp xPos,al
                jne noghost
                mov bl,yPosghost
                cmp yPos,bl
                jne noghost
                dec lives
            

                noghost:
           
        ;ghost
            cmp randomghostmov, 0
            je moveGhostRight
            cmp randomghostmov, 1
            je moveGhostLeft
            cmp randomghostmov, 2
            je moveGhostUp
            cmp randomghostmov, 3
            je moveGhostDown
            jmp moveGhostDown

            moveGhostRight:
                     cmp yPosghost,2
                     jne checkgr1
                     cmp xPosghost,12
                     jne checkgr1
                     mov randomghostmov,3
                     jmp gameLoop
                 checkgr1:
                    cmp yPosghost,16
                    jne checkgr2
                    cmp xPosghost,31
                    jne checkgr2
                    mov randomghostmov,2
                    jmp gameLoop
                 checkgr2:
                    cmp xPosghost,83
                    jne mr
                    mov randomghostmov,2
                    jmp gameLoop
                 mr:
                    call UpdateGhost
                    inc xPosghost
                    call DrawGhost
                    jmp endGhostMovement

          moveGhostLeft:
                checkgl:
                    cmp yPosghost,26
                    jne checkgl1
                    cmp xPosghost,31
                    jne checkgl1
                    mov randomghostmov,2
                    jmp gameLoop
                checkgl1:
                    cmp yPosghost,2
                    jne checkgl2
                    cmp xPosghost,12
                    jne checkgl2
                    mov randomghostmov,3
                    jmp gameLoop
                checkgl2:
                    cmp xPosghost,2
                    jne checkgl3
                    mov randomghostmov,4
                    jmp gameLoop
                checkgl3:
                    cmp yPosghost,16
                    jne checkgl4
                    mov randomghostmov,2
                    jmp gameLoop
                checkgl4:
                    cmp yPosghost,25
                    jne checkgl5
                    cmp xPosghost,56
                    je ml
                    mov randomghostmov,3
                    jmp gameLoop
                    
                checkgl5:
                    cmp xPosghost,56
                    jne ml
                    mov randomghostmov,3
                    jmp gameLoop
                    
                ml:
                    call UpdateGhost
                    dec xPosghost
                    call DrawGhost
                    jmp endGhostMovement

        
           moveGhostUp:
                checkgu:
                    cmp yPosghost,16
                    jne checkgu1
                    cmp xPosghost,56
                    jne checkgu1
                    jmp mu
                checkgu1:
                    cmp yPosghost,15
                    jne checkgu2
                    mov randomghostmov,1
                    jmp gameLoop
                checkgu2:
                    cmp yPosghost,2
                    jne mu
                    mov randomghostmov,4
                    jmp gameLoop
                mu:
                    call UpdateGhost
                    dec yPosghost
                    call DrawGhost

                jmp endGhostMovement
    
            moveGhostDown:
                checkgd1:
                    cmp yPosghost,16
                    jne checkgd2
                    cmp xPosghost,12
                    jne checkgd2
                    mov randomghostmov,0
                    jmp gameLoop
                checkgd2:
                    cmp yPosghost,26
                    jne checkgd3
                    cmp xPosghost,2
                    jne checkgd3
                    mov randomghostmov,0
                    jmp gameLoop
                checkgd3:
                    cmp yPosghost,26
                    jne checkgd4
                    cmp xPosghost,31
                    jne checkgd4
                    mov randomghostmov,2
                    jmp gameLoop
                checkgd4:
                    cmp yPosghost,26
                    jne checkgd5
                    mov randomghostmov,0
                    jmp gameLoop

                checkgd5:
                    cmp yPosghost,25
                    jne checkgd6
                    cmp xPosghost,56
                    jne checkgd6
                    mov randomghostmov,1
                    jmp gameLoop
                checkgd6:

                md:
                call UpdateGhost
                inc yPosghost
                call DrawGhost
                jmp endGhostMovement

            endGhostMovement:
            

         ;teleportation
            cmp yPos,13
            jne notransportation
            cmp xPos,2
            jne notransportation
            call UpdatePlayer
            mov eax,black 
            call SetTextColor
            mov dh,13
            mov dl,2
            call Gotoxy
            mov al," "
            call WriteChar
            mov xPos,84
            mov yPos,2
            call DrawPlayer
            jmp notransportation1
            notransportation:
                cmp yPos,2
                jne notransportation1
                cmp xPos,85
                jne notransportation1
                call UpdatePlayer
                mov eax,black 
                call SetTextColor
                mov dh,13
                mov dl,85
                call Gotoxy
                mov al," "
                call WriteChar
                mov xPos,2
                mov yPos,13
                call DrawPlayer
            notransportation1:
      
        ;collectpowerups
            cmp power1,1
            je checkp1
            jmp checkp2
            checkp1:
                cmp yPos,3
                jne checkp2
                cmp xPos,4
                jne checkp2
                add score,3
                mov power1,0
            checkp2:
                cmp power2,1
                jne checkp3
                cmp yPos,3
                jne checkp3
                cmp xPos,82
                jne checkp3
                add score,3
                mov power2,0
            checkp3:
                cmp power3,1
                jne checkp4
                cmp yPos,25
                jne checkp4
                cmp xPos,82
                jne checkp4
                add score,3
                mov power3,0
            checkp4:
                cmp power4,1
                jne checkend
                cmp yPos,25
                jne checkend
                cmp xPos,4
                jne checkend
                add score,3
                mov power4,0
            checkend:
         
        ;detect collision with coins and inc score
            
            eatconsatline1:
                cmp yPos,2
                jne eatcoinsatline2
                call CheckCoinCollision
            

            eatcoinsatline2:
                cmp yPos,3
                jne eatcoinsatline3
                mov ecx,0
                detectcollisionwithcoins:
                    mov al,[coin1line2+ecx]
                    cmp xPos,al
                    je increasescore
                    cmp ecx,42
                    je eatcoinsatline3
                    inc ecx
                    jmp detectcollisionwithcoins
                    increasescore:
                    mov [coin1line2+ecx],-1
                    inc score
                    inc score1
                

            eatcoinsatline3:
                cmp yPos,4
                jne eatcoinsatline4
                mov ecx,0
                detectcollisionwithcoins1:
                    mov al,[coin1line3+ecx]
                    cmp xPos,al
                    je increasescore1
                    cmp ecx,42
                    je eatcoinsatline4
                    inc ecx
                    jmp detectcollisionwithcoins1
                    increasescore1:
                    mov [coin1line3+ecx],-1
                    inc score
                    inc score1
            eatcoinsatline4:
                cmp yPos,5
                jne eatcoinsatline5
                mov ecx,0
                detectcollisionwithcoins2:
                    mov al,[coin1line4+ecx]
                    cmp xPos,al
                    je increasescore2
                    cmp ecx,42
                    je eatcoinsatline5
                    inc ecx
                    jmp detectcollisionwithcoins2
                    increasescore2:
                    mov [coin1line4+ecx],-1
                    inc score
                    inc score1
            eatcoinsatline5:
                cmp yPos,6
                jne eatcoinsatline6
                mov ecx,0
                detectcollisionwithcoins3:
                    mov al,[coin1line5+ecx]
                    cmp xPos,al
                    je increasescore3
                    cmp ecx,42
                    je eatcoinsatline6
                    inc ecx
                    jmp detectcollisionwithcoins3
                    increasescore3:
                    mov [coin1line5+ecx],-1
                    inc score
                    inc score1
            eatcoinsatline6:
                cmp yPos,7
                jne eatcoinsatline7
                mov ecx,0
                detectcollisionwithcoins6:
                    mov al,[coin1line6+ecx]
                    cmp xPos,al
                    je increasescore4
                    cmp ecx,42
                    je eatcoinsatline7
                    inc ecx
                    jmp detectcollisionwithcoins6
                    increasescore4:
                    mov [coin1line6+ecx],-1
                    inc score
                    inc score1
            eatcoinsatline7:
                cmp yPos,8
                jne eatcoinsatline8
                mov ecx,0
                detectcollisionwithcoins7:
                    mov al,[coin1line7+ecx]
                    cmp xPos,al
                    je increasescore5
                    cmp ecx,42
                    je eatcoinsatline8
                    inc ecx
                    jmp detectcollisionwithcoins7
                    increasescore5:
                    mov [coin1line7+ecx],-1
                    inc score
                    inc score1
            eatcoinsatline8:
                cmp yPos,9
                jne eatcoinsatline9
                mov ecx,0
                detectcollisionwithcoins8:
                    mov al,[coin1line8+ecx]
                    cmp xPos,al
                    je increasescore6
                    cmp ecx,42
                    je eatcoinsatline9
                    inc ecx
                    jmp detectcollisionwithcoins8
                    increasescore6:
                    mov [coin1line8+ecx],-1
                    inc score
                    inc score1
            eatcoinsatline9:
                cmp yPos,10
                jne eatcoinsatline10
                mov ecx,0
                detectcollisionwithcoins9:
                    mov al,[coin1line9+ecx]
                    cmp xPos,al
                    je increasescore7
                    cmp ecx,42
                    jge eatcoinsatline10
                    inc ecx
                    jmp detectcollisionwithcoins9
                    increasescore7:
                    mov [coin1line9+ecx],-1
                    inc score
                    inc score1
            eatcoinsatline10:
                cmp yPos,11
                jne eatcoinsatline11
                mov ecx,0
                detectcollisionwithcoins10:
                    mov al,[coin1line10+ecx]
                    cmp xPos,al
                    je increasescore8
                    cmp ecx,42
                    je eatcoinsatline10
                    inc ecx
                    jmp detectcollisionwithcoins10
                    increasescore8:
                    mov [coin1line10+ecx],-1
                    inc score
                    inc score1

            eatcoinsatline11:
                cmp yPos,12
                jne eatcoinsatline12
                mov ecx,0
                detectcollisionwithcoins11:
                    mov al,[coin1line11+ecx]
                    cmp xPos,al
                    je increasescore9
                    cmp ecx,42
                    je eatcoinsatline12
                    inc ecx
                    jmp detectcollisionwithcoins11
                    increasescore9:
                    mov [coin1line11+ecx],-5
                    inc score
                    inc score1

            eatcoinsatline12:
                cmp yPos,13
                jne eatcoinsatline13
                mov ecx,0
                detectcollisionwithcoins12:
                    mov al,[coin1line12+ecx]
                    cmp xPos,al
                    je increasescore10
                    cmp ecx,42
                    je eatcoinsatline13
                    inc ecx
                    jmp detectcollisionwithcoins12
                    increasescore10:
                    mov [coin1line12+ecx],-1
                    inc score
                    inc score1

            eatcoinsatline13:
                cmp yPos,14
                jne eatcoinsatline14
                mov ecx,0
                detectcollisionwithcoins13:
                    mov al,[coin1line13+ecx]
                    cmp xPos,al
                    je increasescore11
                    cmp ecx,42
                    je eatcoinsatline14
                    inc ecx
                    jmp detectcollisionwithcoins13
                    increasescore11:
                    mov [coin1line13+ecx],-1
                    inc score
                    inc score1

            eatcoinsatline14:
                cmp yPos,15
                jne eatcoinsatline15
                mov ecx,0
                detectcollisionwithcoins14:
                    mov al,[coin1line14+ecx]
                    cmp xPos,al
                    je increasescore12
                    cmp ecx,42
                    je eatcoinsatline15
                    inc ecx
                    jmp detectcollisionwithcoins14
                    increasescore12:
                    mov [coin1line14+ecx],-1
                    inc score
                    inc score1

            eatcoinsatline15:
                cmp yPos,16
                jne eatcoinsatline16
                mov ecx,0
                detectcollisionwithcoins15:
                    mov al,[coin1line15+ecx]
                    cmp xPos,al
                    je increasescore13
                    cmp ecx,42
                    je eatcoinsatline16
                    inc ecx
                    jmp detectcollisionwithcoins15
                    increasescore13:
                    mov [coin1line15+ecx],-1
                    inc score
                    inc score1

            eatcoinsatline16:
                cmp yPos,17
                jne eatcoinsatline17
                mov ecx,0
                detectcollisionwithcoins16:
                    mov al,[coin1line16+ecx]
                    cmp xPos,al
                    je increasescore14
                    cmp ecx,42
                    je eatcoinsatline17
                    inc ecx
                    jmp detectcollisionwithcoins16
                    increasescore14:
                    mov [coin1line16+ecx],-1
                    inc score
                    inc score1

            eatcoinsatline17:
                cmp yPos,18
                jne eatcoinsatline18
                mov ecx,0
                detectcollisionwithcoins17:
                    mov al,[coin1line17+ecx]
                    cmp xPos,al
                    je increasescore15
                    cmp ecx,42
                    je eatcoinsatline18
                    inc ecx
                    jmp detectcollisionwithcoins17
                    increasescore15:
                    mov [coin1line17+ecx],-1
                    inc score
                    inc score1


            eatcoinsatline18:
                cmp yPos,19
                jne eatcoinsatline19
                mov ecx,0
                detectcollisionwithcoins18:
                    mov al,[coin1line18+ecx]
                    cmp xPos,al
                    je increasescore16
                    cmp ecx,42
                    je eatcoinsatline19
                    inc ecx
                    jmp detectcollisionwithcoins18
                    increasescore16:
                    mov [coin1line18+ecx],-1
                    inc score
                    inc score1

            eatcoinsatline19:
                cmp yPos,20
                jne eatcoinsatline20
                mov ecx,0
                detectcollisionwithcoins19:
                    mov al,[coin1line19+ecx]
                    cmp xPos,al
                    je increasescore17
                    cmp ecx,42
                    je eatcoinsatline20
                    inc ecx
                    jmp detectcollisionwithcoins19
                    increasescore17:
                    mov [coin1line19+ecx],-1
                    inc score
                    inc score1


            eatcoinsatline20:
                cmp yPos,21
                jne eatcoinsatline21
                mov ecx,0
                detectcollisionwithcoins20:
                    mov al,[coin1line20+ecx]
                    cmp xPos,al
                    je increasescore18
                    cmp ecx,42
                    je eatcoinsatline21
                    inc ecx
                    jmp detectcollisionwithcoins20
                    increasescore18:
                    mov [coin1line20+ecx],-1
                    inc score
                    inc score1

            eatcoinsatline21:
                cmp yPos,22
                jne eatcoinsatline22
                mov ecx,0
                detectcollisionwithcoins21:
                    mov al,[coin1line21+ecx]
                    cmp xPos,al
                    je increasescore19
                    cmp ecx,42
                    je eatcoinsatline22
                    inc ecx
                    jmp detectcollisionwithcoins21
                    increasescore19:
                    mov [coin1line21+ecx],-1
                    inc score
                    inc score1

            eatcoinsatline22:
                cmp yPos,23
                jne eatcoinsatline23
                mov ecx,0
                detectcollisionwithcoins22:
                    mov al,[coin1line22+ecx]
                    cmp xPos,al
                    je increasescore20
                    cmp ecx,42
                    je eatcoinsatline23
                    inc ecx
                    jmp detectcollisionwithcoins22
                    increasescore20:
                    mov [coin1line22+ecx],-1
                    inc score
                    inc score1

            eatcoinsatline23:
                cmp yPos,24
                jne eatcoinsatline24
                mov ecx,0
                detectcollisionwithcoins23:
                    mov al,[coin1line23+ecx]
                    cmp xPos,al
                    je increasescore21
                    cmp ecx,42
                    je eatcoinsatline24
                    inc ecx
                    jmp detectcollisionwithcoins23
                    increasescore21:
                    mov [coin1line23+ecx],-1
                    inc score
                    inc score1

            eatcoinsatline24:
                cmp yPos,25
                jne eatcoinsatline25
                mov ecx,0
                detectcollisionwithcoins24:
                    mov al,[coin1line24+ecx]
                    cmp xPos,al
                    je increasescore22
                    cmp ecx,42
                    je eatcoinsatline25
                    inc ecx
                    jmp detectcollisionwithcoins24
                    increasescore22:
                    mov [coin1line24+ecx],-1
                    inc score
                    inc score1
            eatcoinsatline25:
                cmp yPos,25
                jne nocoins
                mov ecx,0
                detectcollisionwithcoins25:
                    mov al,[coin1line25+ecx]
                    cmp xPos,al
                    je increasescore23
                    cmp ecx,42
                    je nocoins
                    inc ecx
                    jmp detectcollisionwithcoins25
                    increasescore23:
                    mov [coin1line25+ecx],-1
                    inc score
                    inc score1
            

            nocoins:
            cmp score1,5
        
        je DrawFruit1
        jmp notdrawfruit
        DrawFruit1:
            call DrawFruit
        notdrawfruit:
        ; getting points:
            mov bl,xPos
            cmp bl,xCoinPos
            jne gettingpoints5
            mov bl,yPos
            cmp bl,yCoinPos
            jne gettingpoints5
        ; player is intersecting coin:
            add score,10
            add score1,10
        
      
        gettingpoints5:
            mov bl,xPos
            cmp bl,xFruitPos
            jne notCollecting
            mov bl,yPos
            cmp bl,yFruitPos
            jne notCollecting
             ; player is intersecting coin:
            add score,10
            mov score1,0
            mov xFruitPos,0
            mov yFruitPos,0
        
        notCollecting:

            mov eax,white (black * 16)
            call SetTextColor

        ; draw_score:
            mov eax,lightblue ;(black * 16)
            call SetTextColor
            mov dl,97
            mov dh,10
            call Gotoxy
            mov edx,OFFSET strScore
            call WriteString
            mov eax,score
            call WriteInt

        ;draw lives
           mov eax,green ;(black * 16)
           call SetTextColor
           mov dl,97
           mov dh,12
           call Gotoxy
           mov edx,OFFSET livesprint
           call WriteString
           mov al,lives
           call WriteInt

        
        onGround:

        ; get user key input:
            call ReadChar
            mov inputChar,al

        ; exit game if user types 'x':
            cmp inputChar,"x"
            je exitGame

            cmp inputChar,"w"
            je moveUp

            cmp inputChar,"s"
            je moveDown

            cmp inputChar,"a"
            je moveLeft

            cmp inputChar,"d"
            je moveRight

            cmp inputChar,"p"
            je pauseGame1
            jmp gameLoop



        pauseGame1:
            call PauseGame   ; Call your pause function

        moveUp:
            cmp yPos,2
            je gameLoop
                checku1:
                    cmp yPos,15
                    jne checku2
                    mov al,5
                    moveuploop:
                        cmp xPos,al
                        je gameLoop
                        cmp al,10
                        je checku2
                        inc al
                        jmp moveuploop

                checku2:
                    cmp yPos,26
                    jne checku3
                    mov al,5
                    moveuploop2:
                        cmp xPos,al
                        je gameLoop
                        cmp al,24
                        je checku3
                        inc al
                        jmp moveuploop2

                checku3:
                    cmp yPos,15
                    jne checku4
                    mov al,19
                    moveuploop3:
                        cmp xPos,al
                        je gameLoop
                        cmp al,24
                        je checku4
                        inc al
                        jmp moveuploop3

                checku4:
                    cmp yPos,25
                    jne checku5
                    mov al,35
                    moveuploop4:
                        cmp xPos,al
                        je gameLoop
                        cmp al,56
                        je checku5
                        inc al
                        jmp moveuploop4

                checku5:
                    cmp yPos,16
                    jne checku6
                    mov al,35
                    moveuploop5:
                        cmp xPos,al
                        je gameLoop
                        cmp al,39
                        je checku6
                        inc al
                        jmp moveuploop5
                checku6:
                    cmp yPos,7
                    jne checku7
                    mov al,35
                    moveuploop6:
                        cmp xPos,al
                        je gameLoop
                        cmp al,56
                        je checku7
                        inc al
                        jmp moveuploop6
                checku7:
                    cmp yPos,15
                    jne checku8
                    mov al,62
                    moveuploop7:
                        cmp xPos,al
                        je gameLoop
                        cmp al,82
                        je checku8
                        inc al
                        jmp moveuploop7
                checku8:
                    cmp yPos,26
                    jne checku9
                    mov al,62
                    moveuploop8:
                        cmp xPos,al
                        je gameLoop
                        cmp al,82
                        je checku9
                        inc al
                        jmp moveuploop8

                checku9:
                    cmp yPos,23
                    jne moveu
                    mov al,62
                    moveuploop9:
                        cmp xPos,al
                        je gameLoop
                        cmp al,82
                        je moveu
                        inc al
                        jmp moveuploop9

            moveu:
            call UpdatePlayer
            dec yPos
            call DrawGhost
            call DrawPlayer
            jmp gameLoop

        moveDown:
            cmp yPos,26
            je gameLoop
                checkd1:
                    cmp yPos,3
                    jne checkd2
                    mov al,5
                    movedownloop:
                        cmp xPos,al
                        je gameLoop
                        cmp al,10
                        je checkd2
                        inc al
                        jmp movedownloop

                checkd2:
                    cmp yPos,16
                    jne checkd3
                    mov al,5
                    movedownloop2:
                        cmp xPos,al
                        je gameLoop
                        cmp al,24
                        je checkd3
                        inc al
                        jmp movedownloop2

                checkd3:
                    cmp yPos,5
                    jne checkd4
                    mov al,19
                    movedownloop3:
                        cmp xPos,al
                        je gameLoop
                        cmp al,24
                        je checkd4
                        inc al
                        jmp movedownloop3

                checkd4:
                    cmp yPos,22
                    jne checkd5
                    mov al,35
                    movedownloop4:
                        cmp xPos,al
                        je gameLoop
                        cmp al,56
                        je checkd5
                        inc al
                        jmp movedownloop4

                checkd5:
                    cmp yPos,21
                    jne checkd6
                    mov al,35
                    movedownloop5:
                        cmp xPos,al
                        je gameLoop
                        cmp al,39
                        je checkd6
                        inc al
                        jmp movedownloop5
                checkd6:
                    cmp yPos,4
                    jne checkd7
                    mov al,35
                    movedownloop6:
                        cmp xPos,al
                        je gameLoop
                        cmp al,55
                        je checkd7
                        inc al
                        jmp movedownloop6
                checkd7:
                    cmp yPos,5
                    jne checkd8
                    mov al,62
                    movedownloop7:
                        cmp xPos,al
                        je gameLoop
                        cmp al,82
                        je checkd8
                        inc al
                        jmp movedownloop7
                checkd8:
                    cmp yPos,23
                    jne checkd9
                    mov al,62
                    movedownloop8:
                        cmp xPos,al
                        je gameLoop
                        cmp al,82
                        je checkd9
                        inc al
                        jmp movedownloop8

                checkd9:
                    cmp yPos,19
                    jne moved
                    mov al,62
                    movedownloop9:
                        cmp xPos,al
                        je gameLoop
                        cmp al,82
                        je moved
                        inc al
                        jmp movedownloop9
            
            moved:
            call UpdatePlayer
            inc yPos
            call DrawPlayer
            jmp gameLoop

        moveLeft:
            cmp xPos,2
            je gameLoop
               checkl1:
                    cmp xPos,12
                    jne checkl3
                    mov al,4
                    moverightloop:
                        cmp yPos,al
                        je gameLoop
                        cmp al,14
                        je checkl2
                        inc al
                        jmp moverightloop

               checkl2:
                    cmp xPos,12
                    jne checkl3
                    mov al,17
                    moveleftloop1:
                        cmp yPos,al
                        je gameLoop
                        cmp al,25
                        je checkl3
                        inc al
                        jmp moveleftloop1

                checkl3:
                    cmp xPos,25
                    jne checkl4
                    mov al,4
                    moveleftloop3:
                        cmp yPos,al
                        je gameLoop
                        cmp al,14
                        je checkl4
                        inc al
                        jmp moveleftloop3
                
                checkl4:
                    cmp xPos,40
                    jne checkl5
                    mov al,6
                    moveleftloop4:
                        cmp yPos,al
                        je gameLoop
                        cmp al,12
                        je checkl5
                        inc al
                        jmp moveleftloop4
                    
               
                checkl5:
                    cmp xPos,40
                    jne checkl6
                    mov al,15
                    moveleftloop5:
                        cmp yPos,al
                        je checkl6
                        cmp al,24
                        je movel
                        inc al
                        jmp moveleftloop5
                
                checkl6:
                    cmp xPos,61
                    jne checkl7
                    mov al,12
                    cmp yPos,al
                    je gameLoop
                        

                checkl7:
                    cmp xPos,61
                    jne checkl8
                    mov al,15
                    moveleftloop7:
                        cmp yPos,al
                        je gameLoop
                        cmp al,24
                        je checkl8
                        inc al
                        jmp moveleftloop7

                

                checkl8:
                    cmp xPos,83
                    jne checkl9
                    mov al,5
                    moveleftloop8:
                        cmp yPos,al
                        je gameLoop
                        cmp al,14
                        je checkl9
                        inc al
                        jmp moveleftloop8
                
                checkl9:
                    cmp xPos,83
                    jne checkl10
                    mov al,24
                    moveleftloop9:
                        cmp yPos,al
                        je gameLoop
                        cmp al,25
                        je checkl9
                        inc al
                        jmp moveleftloop9

                checkl10:
                    cmp xPos,83
                    jne movel
                    mov al,20
                    moveleftloop10:
                        cmp yPos,al
                        je gameLoop
                        cmp al,22
                        je movel
                        inc al
                        jmp moveleftloop10                    

                  
            movel:
                call UpdatePlayer
                dec xPos
                call DrawPlayer
                jmp gameLoop

        moveRight:
               cmp xPos,85
               je gameLoop
               checkr1:
                    cmp xPos,4
                    jne checkr3
                    mov al,4
                    moverightloop11:
                        cmp yPos,al
                        je gameLoop
                        cmp al,14
                        je checkr2
                        inc al
                        jmp moverightloop11

               checkr2:
                    cmp xPos,4
                    jne checkr3
                    mov al,17
                    moverightloop1:
                        cmp yPos,al
                        je gameLoop
                        cmp al,25
                        je checkr3
                        inc al
                        jmp moverightloop1

                checkr3:
                    cmp xPos,18
                    jne checkr4
                    mov al,4
                    moverightloop3:
                        cmp yPos,al
                        je gameLoop
                        cmp al,14
                        je checkr4
                        inc al
                        jmp moverightloop3
                
                checkr4:
                    cmp xPos,34
                    jne checkr5
                    mov al,6
                    moverightloop4:
                        cmp yPos,al
                        je gameLoop
                        cmp al,12
                        je checkr5
                        inc al
                        jmp moverightloop4
                    
               
                checkr5:
                    cmp xPos,34
                    jne checkr6
                    mov al,15
                    moverightloop5:
                        cmp yPos,al
                        je gameLoop
                        cmp al,24
                        je checkr6
                        inc al
                        jmp moverightloop5

                checkr6:
                    cmp xPos,34
                    jne checkr7
                    mov al,15
                    moverightloop6:
                        cmp yPos,al
                        je gameLoop
                        cmp al,22
                        je checkr7
                        inc al
                        jmp moverightloop6

                checkr7:
                    cmp xPos,61
                    jne checkr8
                    mov al,5
                    moverightloop7:
                        cmp yPos,al
                        je gameLoop
                        cmp al,14
                        je checkr8
                        inc al
                        jmp moverightloop7

                checkr8:
                    cmp xPos,61
                    jne checkr9
                    mov al,20
                    moverightloop8:
                        cmp yPos,al
                        je gameLoop
                        cmp al,22
                        je checkr9
                        inc al
                        jmp moverightloop8
                
                checkr9:
                    cmp xPos,61
                    jne mover
                    mov al,24
                    moverightloop9:
                        cmp yPos,al
                        je gameLoop
                        cmp al,25
                        je mover
                        inc al
                        jmp moverightloop9
            mover:
            call UpdatePlayer
            inc xPos
            call DrawPlayer
            jmp gameLoop
        skip:

    jmp gameLoop

    exitGame:
    ret
Level2 ENDP
;=======================level 3==========================;

Level3 PROC
    mov xPosghost,2
    mov yPosghost,2
    mov level,3
    mov xPos,44
    mov yPos,6
    call clrscr
    call DrawCoins1
    call DrawPower1
    call DrawWalls3
    
    
    call DrawPlayer
    call DrawGhost
    call DrawGhost2
    call DrawGhost3

    call CreateRandomCoin
    call DrawCoin
    call Randomize

    pacman:
        mov eax,yellow
        call SetTextColor
        mov dh,5
        mov dl,95
        call Gotoxy
        mov edx,offset pacmanname16
        call WriteString

        mov dh,4
        mov dl,95
        call Gotoxy
        mov edx,offset pacmanname17
        call WriteString

        mov dh,6
        mov dl,95
        call Gotoxy
        mov edx,offset pacmanname17
        call WriteString
    
       levelprinting:
          mov eax,magenta ;(black * 16)
          call SetTextColor
          mov dh,8
          mov dl,97
          call Gotoxy
          mov edx,offset level3print
          call WriteString

       characterprinting:
          mov eax,lightcyan
          call SetTextColor
          mov dh,14
          mov dl,100
          call Gotoxy
          mov edx,offset gameendtext2
          call WriteString

          portalprinting:
            mov eax,brown +(brown*16) 
            call SetTextColor
            mov dh,13
            mov dl,1
            call Gotoxy
            mov al," "
            call WriteChar
            mov dh,13
            mov dl,86
            call Gotoxy
            mov al," "
            call WriteChar
        mov randomghostmov,0
        mov randomghostmov2,3
     gameLoop:
        ;game end
            cmp score,150
            jne nogamewon
            call GameWon
            nogamewon:
        ;lost game
            cmp lives,0
            jne livesnotlost
            call GameLost
            livesnotlost:
        ;ghost collision
                mov al,xPosghost
                cmp xPos,al
                jne noghost
                mov bl,yPosghost
                cmp yPos,bl
                jne noghost
                dec lives
            

                noghost:
           
        ;ghost1
                cmp randomghostmov, 0
                je moveGhostRight
                cmp randomghostmov, 1
                je moveGhostLeft
                cmp randomghostmov, 2
                je moveGhostUp
                cmp randomghostmov, 3
                je moveGhostDown
                jmp moveGhostDown

                moveGhostRight:
                    checkgr1:
                        cmp yPosghost,2
                        jne checkgr2
                        cmp xPosghost,22
                        jne checkgr2
                        mov randomghostmov,3
                        jmp gameLoop
                    checkgr2:
                        cmp yPosghost,9
                        jne checkgr3
                        cmp xPosghost,82
                        jne checkgr2
                        mov randomghostmov,2
                        jmp gameLoop
                     checkgr3:
                        cmp yPosghost,6
                        jne checkgr4
                        cmp xPosghost,82
                        jne checkgr4
                        mov randomghostmov,2
                        jmp gameLoop
                     checkgr4:
                     mr:
                        
                        call UpdateGhost
                        inc xPosghost
                        call DrawGhost
                        jmp endGhostMovement

                moveGhostLeft:
                    checkgl: 
                        cmp xPosghost,4 
                        jne checkgl1
                        cmp yPosghost,2
                        jne checkgl2
                        mov randomghostmov,3
                        jmp gameLoop
                    checkgl1:
                        cmp xPosghost,2 
                        jne checkgl2
                        mov randomghostmov,2
                        jmp gameLoop
                    checkgl2:
                        
                    checkgl3:
                    checkgl4:
                    checkgl5:
                    ml:
                        call UpdateGhost
                        dec xPosghost
                        call DrawGhost
                        jmp endGhostMovement

        
                moveGhostUp:
                    checkgu:
                        cmp xPosghost,2
                        jne checkgu1
                        cmp yPosghost,6
                        jne checkgu1
                        mov randomghostmov,0
                        jmp gameLoop
                    checkgu1:
                        cmp xPosghost,82
                        jne checkgu2
                        cmp yPosghost,2
                        jne checkgu2
                        mov randomghostmov,1
                        jmp gameLoop
                    checkgu2:
                    mu:
                        call UpdateGhost
                        dec yPosghost
                        call DrawGhost
                            
                        jmp endGhostMovement
    
                moveGhostDown:
                    checkgd1:
                        cmp yPosghost,9
                        jne checkgd2
                        cmp xPosghost,22
                        jne checkgd2
                        mov randomghostmov,1
                        jmp gameLoop

                    checkgd2:
                        cmp xPosghost,4
                        jne checkgd3
                        cmp yPosghost,5
                        jne checkgd3
                        mov randomghostmov,0
                    checkgd3:
                    checkgd4:
                        
                    checkgd5:
                    checkgd6:
                        
                    md:
                        call UpdateGhost
                        inc yPosghost
                        call DrawGhost
                        jmp endGhostMovement

                        endGhostMovement:

        ;ghost2

            gameLoop2:
                ;movement
                    cmp randomghostmov2, 0
                    je moveGhostRight2
                    cmp randomghostmov2, 1
                    je moveGhostLeft2
                    cmp randomghostmov2, 2
                    je moveGhostUp2
                    cmp randomghostmov2, 3
                    je moveGhostDown2
                    jmp moveGhostDown2

                moveGhostRight2:
                     checkgr12:
                        cmp yPosghost2,12
                        jne checkgr22
                        cmp xPosghost2,56
                        jne checkgr22
                        mov randomghostmov2,3
                        jmp gameLoop2
                     checkgr22:
                        cmp yPosghost2,19
                        jne checkgr32
                        cmp xPosghost2,70
                        jne checkgr32
                        mov randomghostmov2,2
                        jmp gameLoop2
                     checkgr32:
                        cmp yPosghost2,2
                        jne checkgr42
                        cmp xPosghost2,82
                        jne checkgr42
                        mov randomghostmov2,3
                        jmp gameLoop2
                     checkgr42:
                     mr2:
                        
                        call UpdateGhost2
                        inc xPosghost2
                        call DrawGhost2
                        jmp endGhostMovement2

                moveGhostLeft2:
                    check2gl:
                        cmp yPosghost2,8
                        jne checkgl12
                        cmp xPosghost2,45
                        jne checkgl12
                        mov randomghostmov2,3
                        jmp gameLoop2

                    checkgl12:
                        cmp yPosghost2,14
                        jne checkgl22
                        cmp xPosghost2,46
                        jne checkgl22
                        mov randomghostmov2,3
                        jmp gameLoop2
                    checkgl22:
                    checkgl32:
                    checkgl42:
                    checkgl52:
                    ml2:    
                        call UpdateGhost2
                        dec xPosghost2
                        call DrawGhost2
                        jmp endGhostMovement2

        
                moveGhostUp2:
                    checkgu12:
                        cmp xPosghost2,70
                        jne checkgu22
                        cmp yPosghost2,2
                        jne checkgu22
                        mov randomghostmov2,0
                        jmp gameLoop2
                    checkgu22:
                    mu2:
                        call UpdateGhost2
                        dec yPosghost2
                        call DrawGhost2

                        jmp endGhostMovement2
    
                moveGhostDown2:
                    checkgd12:
                        cmp xPosghost2,82
                        jne checkgd22
                        cmp yPosghost2,8
                        jne checkgd22
                        mov randomghostmov2,1
                        jmp gameLoop2
                    checkgd22:
                        cmp xPosghost2,45
                        jne checkgd32
                        cmp yPosghost2,12
                        jne checkgd32
                        mov randomghostmov2,0
                        jmp gameLoop2
                    checkgd32:
                        cmp xPosghost2,56
                        jne checkgd42
                        cmp yPosghost2,14
                        jne checkgd42
                        mov randomghostmov2,1
                        jmp gameLoop2
                    checkgd42:
                        cmp xPosghost2,46
                        jne checkgd52
                        cmp yPosghost2,19
                        jne checkgd52
                        mov randomghostmov2,0
                        jmp gameLoop2
                    checkgd52:
                    checkgd62:

                    md2:
                        call UpdateGhost2
                        inc yPosghost2
                        call DrawGhost2
                        jmp endGhostMovement2
                        
                       endGhostMovement2:
        ;obstacle
            ;if you come in contact with an obstacle u will loose ur live
                cmp yPos,8
                jne checkobstacle2
                cmp xPos,44
                jne checkobstacle2
                dec lives

                checkobstacle2:
                    cmp yPos,19
                    jne checkobstacle3
                    cmp xPos,44
                    jne checkobstacle3
                    dec lives
                checkobstacle3:
                    cmp yPos,20
                    jne noobstacle
                    cmp xPos,44
                    jne noobstacle
                    dec lives


                noobstacle:
        ;teleportation
            cmp yPos,13
            jne notransportation
            cmp xPos,2
            jne notransportation
            call UpdatePlayer
            mov eax,black 
            call SetTextColor
            mov dh,13
            mov dl,2
            call Gotoxy
            mov al," "
            call WriteChar
            mov xPos,84
            mov yPos,13
            call DrawPlayer
            notransportation:
                cmp yPos,13
                jne notransportation1
                cmp xPos,85
                jne notransportation1
                call UpdatePlayer
                mov eax,black 
                call SetTextColor
                mov dh,13
                mov dl,85
                call Gotoxy
                mov al," "
                call WriteChar
                mov xPos,2
                mov yPos,13
                call DrawPlayer
            notransportation1:

        ;collectpowerups
            cmp power1,1
            je check1
            jmp check2
            check1:
                cmp yPos,3
                jne check2
                cmp xPos,4
                jne check2
                add score,3
                mov power1,0
            check2:
                cmp power2,1
                jne check3
                cmp yPos,3
                jne check3
                cmp xPos,82
                jne check3
                add score,3
                mov power2,0
            check3:
                cmp power3,1
                jne check4
                cmp yPos,25
                jne check4
                cmp xPos,82
                jne check4
                add score,3
                mov power3,0
            check4:
                cmp power4,1
                jne checkend
                cmp yPos,25
                jne checkend
                cmp xPos,4
                jne checkend
                add score,3
                mov power4,0
            checkend:

        ;detect collision with coins and inc score
            
            eatconsatline1:
                cmp yPos,2
                jne eatcoinsatline2
                call CheckCoinCollision
            

            eatcoinsatline2:
                cmp yPos,3
                jne eatcoinsatline3
                mov ecx,0
                detectcollisionwithcoins:
                    mov al,[coinline2+ecx]
                    cmp xPos,al
                    je increasescore
                    cmp ecx,42
                    je eatcoinsatline3
                    inc ecx
                    jmp detectcollisionwithcoins
                    increasescore:
                    mov [coinline2+ecx],-1
                    inc score
                

            eatcoinsatline3:
                cmp yPos,4
                jne eatcoinsatline4
                mov ecx,0
                detectcollisionwithcoins1:
                    mov al,[coinline3+ecx]
                    cmp xPos,al
                    je increasescore1
                    cmp ecx,42
                    je eatcoinsatline4
                    inc ecx
                    jmp detectcollisionwithcoins1
                    increasescore1:
                    mov [coinline3+ecx],-1
                    inc score

            eatcoinsatline4:
                cmp yPos,5
                jne eatcoinsatline5
                mov ecx,0
                detectcollisionwithcoins2:
                    mov al,[coinline4+ecx]
                    cmp xPos,al
                    je increasescore2
                    cmp ecx,42
                    je eatcoinsatline5
                    inc ecx
                    jmp detectcollisionwithcoins2
                    increasescore2:
                    mov [coinline4+ecx],-1
                    inc score


            eatcoinsatline5:
                cmp yPos,6
                jne eatcoinsatline6
                mov ecx,0
                detectcollisionwithcoins3:
                    mov al,[coinline5+ecx]
                    cmp xPos,al
                    je increasescore3
                    cmp ecx,42
                    je eatcoinsatline6
                    inc ecx
                    jmp detectcollisionwithcoins3
                    increasescore3:
                    mov [coinline5+ecx],-1
                    inc score

            eatcoinsatline6:
                cmp yPos,7
                jne eatcoinsatline7
                mov ecx,0
                detectcollisionwithcoins6:
                    mov al,[coinline6+ecx]
                    cmp xPos,al
                    je increasescore4
                    cmp ecx,42
                    je eatcoinsatline7
                    inc ecx
                    jmp detectcollisionwithcoins6
                    increasescore4:
                    mov [coinline6+ecx],-1
                    inc score

            eatcoinsatline7:
                cmp yPos,8
                jne eatcoinsatline8
                mov ecx,0
                detectcollisionwithcoins7:
                    mov al,[coinline7+ecx]
                    cmp xPos,al
                    je increasescore5
                    cmp ecx,42
                    je eatcoinsatline8
                    inc ecx
                    jmp detectcollisionwithcoins7
                    increasescore5:
                    mov [coinline7+ecx],-1
                    inc score

            eatcoinsatline8:
                cmp yPos,9
                jne eatcoinsatline9
                mov ecx,0
                detectcollisionwithcoins8:
                    mov al,[coinline8+ecx]
                    cmp xPos,al
                    je increasescore6
                    cmp ecx,42
                    je eatcoinsatline9
                    inc ecx
                    jmp detectcollisionwithcoins8
                    increasescore6:
                    mov [coinline8+ecx],-1
                    inc score

            eatcoinsatline9:
                cmp yPos,10
                jne eatcoinsatline10
                mov ecx,0
                detectcollisionwithcoins9:
                    mov al,[coinline9+ecx]
                    cmp xPos,al
                    je increasescore7
                    cmp ecx,42
                    je eatcoinsatline10
                    inc ecx
                    jmp detectcollisionwithcoins9
                    increasescore7:
                    mov [coinline9+ecx],-1
                    inc score

            eatcoinsatline10:
                cmp yPos,11
                jne eatcoinsatline11
                mov ecx,0
                detectcollisionwithcoins10:
                    mov al,[coinline10+ecx]
                    cmp xPos,al
                    je increasescore8
                    cmp ecx,42
                    je eatcoinsatline10
                    inc ecx
                    jmp detectcollisionwithcoins10
                    increasescore8:
                    mov [coinline10+ecx],-1
                    inc score

            eatcoinsatline11:
                cmp yPos,12
                jne eatcoinsatline12
                mov ecx,0
                detectcollisionwithcoins11:
                    mov al,[coinline11+ecx]
                    cmp xPos,al
                    je increasescore9
                    cmp ecx,42
                    je eatcoinsatline12
                    inc ecx
                    jmp detectcollisionwithcoins11
                    increasescore9:
                    mov [coinline11+ecx],-1
                    inc score

            eatcoinsatline12:
                cmp yPos,13
                jne eatcoinsatline13
                mov ecx,0
                detectcollisionwithcoins12:
                    mov al,[coinline12+ecx]
                    cmp xPos,al
                    je increasescore10
                    cmp ecx,42
                    je eatcoinsatline13
                    inc ecx
                    jmp detectcollisionwithcoins12
                    increasescore10:
                    mov [coinline12+ecx],-1
                    inc score

            eatcoinsatline13:
                cmp yPos,14
                jne eatcoinsatline14
                mov ecx,0
                detectcollisionwithcoins13:
                    mov al,[coinline13+ecx]
                    cmp xPos,al
                    je increasescore11
                    cmp ecx,42
                    je eatcoinsatline14
                    inc ecx
                    jmp detectcollisionwithcoins13
                    increasescore11:
                    mov [coinline13+ecx],-1
                    inc score

            eatcoinsatline14:
                cmp yPos,15
                jne eatcoinsatline15
                mov ecx,0
                detectcollisionwithcoins14:
                    mov al,[coinline14+ecx]
                    cmp xPos,al
                    je increasescore12
                    cmp ecx,42
                    je eatcoinsatline15
                    inc ecx
                    jmp detectcollisionwithcoins14
                    increasescore12:
                    mov [coinline14+ecx],-1
                    inc score

            eatcoinsatline15:
                cmp yPos,16
                jne eatcoinsatline16
                mov ecx,0
                detectcollisionwithcoins15:
                    mov al,[coinline15+ecx]
                    cmp xPos,al
                    je increasescore13
                    cmp ecx,42
                    je eatcoinsatline16
                    inc ecx
                    jmp detectcollisionwithcoins15
                    increasescore13:
                    mov [coinline15+ecx],-1
                    inc score

            eatcoinsatline16:
                cmp yPos,17
                jne eatcoinsatline17
                mov ecx,0
                detectcollisionwithcoins16:
                    mov al,[coinline16+ecx]
                    cmp xPos,al
                    je increasescore14
                    cmp ecx,42
                    je eatcoinsatline17
                    inc ecx
                    jmp detectcollisionwithcoins16
                    increasescore14:
                    mov [coinline16+ecx],-1
                    inc score

            eatcoinsatline17:
                cmp yPos,18
                jne eatcoinsatline18
                mov ecx,0
                detectcollisionwithcoins17:
                    mov al,[coinline17+ecx]
                    cmp xPos,al
                    je increasescore15
                    cmp ecx,42
                    je eatcoinsatline18
                    inc ecx
                    jmp detectcollisionwithcoins17
                    increasescore15:
                    mov [coinline17+ecx],-1
                    inc score


            eatcoinsatline18:
                cmp yPos,19
                jne eatcoinsatline19
                mov ecx,0
                detectcollisionwithcoins18:
                    mov al,[coinline18+ecx]
                    cmp xPos,al
                    je increasescore16
                    cmp ecx,42
                    je eatcoinsatline19
                    inc ecx
                    jmp detectcollisionwithcoins18
                    increasescore16:
                    mov [coinline18+ecx],-1
                    inc score

            eatcoinsatline19:
                cmp yPos,20
                jne eatcoinsatline20
                mov ecx,0
                detectcollisionwithcoins19:
                    mov al,[coinline19+ecx]
                    cmp xPos,al
                    je increasescore17
                    cmp ecx,42
                    je eatcoinsatline20
                    inc ecx
                    jmp detectcollisionwithcoins19
                    increasescore17:
                    mov [coinline19+ecx],-1
                    inc score


            eatcoinsatline20:
                cmp yPos,21
                jne eatcoinsatline21
                mov ecx,0
                detectcollisionwithcoins20:
                    mov al,[coinline20+ecx]
                    cmp xPos,al
                    je increasescore18
                    cmp ecx,42
                    je eatcoinsatline21
                    inc ecx
                    jmp detectcollisionwithcoins20
                    increasescore18:
                    mov [coinline20+ecx],-1
                    inc score

            eatcoinsatline21:
                cmp yPos,22
                jne eatcoinsatline22
                mov ecx,0
                detectcollisionwithcoins21:
                    mov al,[coinline21+ecx]
                    cmp xPos,al
                    je increasescore19
                    cmp ecx,42
                    je eatcoinsatline22
                    inc ecx
                    jmp detectcollisionwithcoins21
                    increasescore19:
                    mov [coinline21+ecx],-1
                    inc score

            eatcoinsatline22:
                cmp yPos,23
                jne eatcoinsatline23
                mov ecx,0
                detectcollisionwithcoins22:
                    mov al,[coinline22+ecx]
                    cmp xPos,al
                    je increasescore20
                    cmp ecx,42
                    je eatcoinsatline23
                    inc ecx
                    jmp detectcollisionwithcoins22
                    increasescore20:
                    mov [coinline22+ecx],-1
                    inc score

            eatcoinsatline23:
                cmp yPos,24
                jne eatcoinsatline24
                mov ecx,0
                detectcollisionwithcoins23:
                    mov al,[coinline23+ecx]
                    cmp xPos,al
                    je increasescore21
                    cmp ecx,42
                    je eatcoinsatline24
                    inc ecx
                    jmp detectcollisionwithcoins23
                    increasescore21:
                    mov [coinline23+ecx],-1
                    inc score

            eatcoinsatline24:
                cmp yPos,25
                jne detectcollisionwithcoins25
                mov ecx,0
                detectcollisionwithcoins24:
                    mov al,[coinline24+ecx]
                    cmp xPos,al
                    je increasescore22
                    cmp ecx,42
                    je detectcollisionwithcoins25
                    inc ecx
                    jmp detectcollisionwithcoins24
                    increasescore22:
                    mov [coinline24+ecx],-1
                    inc score
            eatcoinsatline25:
                cmp yPos,25
                jne nocoins
                mov ecx,0
                detectcollisionwithcoins25:
                    mov al,[coinline25+ecx]
                    cmp xPos,al
                    je increasescore23
                    cmp ecx,42
                    je nocoins
                    inc ecx
                    jmp detectcollisionwithcoins25
                    increasescore23:
                    mov [coinline25+ecx],-1
                    inc score
            

            nocoins:
       

        notCollecting:


        ; draw_score:
            mov eax,lightblue ;(black * 16)
            call SetTextColor
            mov dl,97
            mov dh,10
            call Gotoxy
            mov edx,OFFSET strScore
            call WriteString
            mov eax,score
            call WriteInt

        ;draw lives
           mov eax,green ;(black * 16)
           call SetTextColor
           mov dl,97
           mov dh,12
           call Gotoxy
           mov edx,OFFSET livesprint
           call WriteString
           mov al,lives
           call WriteInt

        
        onGround:

        ; get user key input:
            call ReadChar
            mov inputChar,al

        ; exit game if user types 'x':
            cmp inputChar,"x"
            je exitGame

            cmp inputChar,"w"
            je moveUp

            cmp inputChar,"s"
            je moveDown

            cmp inputChar,"a"
            je moveLeft

            cmp inputChar,"d"
            je moveRight

            cmp inputChar,"p"
            je pauseGame1
            jmp gameLoop



        pauseGame1:
            call PauseGame   ; Call your pause function

        moveUp:
            cmp yPos,2
            je gameLoop
            checku1:
                cmp yPos,6
                jne checku2
                mov al,5
                loopchecku1:
                    cmp al,22
                    je nou1
                    cmp al,44
                    je nou1
                    cmp al,70
                    je nou1
                    cmp xPos,al
                    jne nou1
                    jmp gameLoop
                    nou1:
                        cmp al,82
                        je checku2
                        inc al
                        jmp loopchecku1
            checku2:
                cmp yPos,8
                jne checku3
                mov al,5
                loopchecku2:
                    cmp al,22
                    je nou2
                    cmp al,26
                    je nou2
                    cmp al,66
                    je nou2
                    cmp al,70
                    je nou2
                    cmp xPos,al
                    jne nou2
                    jmp gameLoop
                    nou2:
                        cmp al,82
                        je checku3
                        inc al
                        jmp loopchecku2

            checku3:
                cmp yPos,13
                jne checku4
                mov al,0
                loopchecku3:
                    cmp al,22
                    je nou3
                    cmp al,26
                    je nou31
                    cmp al,70
                    je nou3
                    cmp xPos,al
                    jne nou3
                    jmp gameLoop
                    nou3:
                        cmp al,86
                        je checku4
                        inc al
                        jmp loopchecku3
                    nou31:
                        add al,24
                        jmp loopchecku3
            checku4:
                cmp yPos,14
                jne checku55
                mov al,34
                loopchecku4:
                    cmp xPos,al
                    jne nou4
                    jmp gameLoop
                    nou4:
                        cmp al,55
                        je checku55
                        inc al
                        jmp loopchecku4
            checku55:
                cmp yPos,17
                jne checku5
                mov al,0
                loopchecku55:
                    cmp al,22
                    je nou55
                    cmp al,38
                    je nou55
                    cmp al,70
                    je nou55
                    cmp xPos,al
                    jne nou55
                    jmp gameLoop
                    nou55:
                        cmp al,52
                        je checku5
                        inc al
                        jmp loopchecku4
                        nou551:
                        add al,52
                        jmp loopchecku55
            checku5:
                cmp yPos,19
                jne checku6
                mov al,0
                loopchecku5:
                    cmp al,22
                    je nou5
                    cmp al,39
                    je nou51
                    cmp al,70
                    je nou5
                    cmp xPos,al
                    jne nou5
                    jmp gameLoop
                    nou5:
                        cmp al,52
                        je checku6
                        inc al
                        jmp loopchecku5
                    nou51:
                        add al,12
                        jmp loopchecku5
            checku6:
                cmp yPos,22
                jne checku7
                mov al,44
                cmp xPos,al
                jne checku6
                jmp gameLoop

            checku7:
                cmp yPos,25
                jne checku8
                mov al,5
                loopchecku7:
                    cmp al,22
                    je nou7
                    cmp al,44
                    je nou7
                    cmp al,70
                    je nou7
                    cmp xPos,al
                    jne nou7
                    jmp gameLoop
                    nou7:
                        cmp al,82
                        je checku8
                        inc al
                        jmp loopchecku7
            checku8:
            call UpdatePlayer
            dec yPos
            call DrawPlayer
            jmp gameLoop

        moveDown:
            cmp yPos,26
            je gameLoop
            checkd1:
                cmp yPos,2
                jne checkd2
                mov al,5
                loopcheckd1:
                    cmp al,22
                    je nod1
                    cmp al,44
                    je nod1
                    cmp al,70
                    je nod1
                    cmp xPos,al
                    jne nod1
                    jmp gameLoop
                    nod1:
                        cmp al,82
                        je checkd2
                        inc al
                        jmp loopcheckd1
            checkd2:
                cmp yPos,6
                jne checkd3
                mov al,5
                loopcheckd2:
                    cmp al,22
                    je nod2
                    cmp al,26
                    je nod2
                    cmp al,66
                    je nod2
                    cmp al,70
                    je nod2
                    cmp xPos,al
                    jne nod2
                    jmp gameLoop
                    nod2:
                        cmp al,82
                        je checkd3
                        inc al
                        jmp loopcheckd2
            checkd3:
                cmp yPos,9
                jne checkd4
                mov al,0
                loopcheckd3:
                    cmp al,22
                    je nod3
                    cmp al,39
                    je nod31
                    cmp al,70
                    je nod3
                    cmp xPos,al
                    jne nod3
                    jmp gameLoop
                    nod3:
                        cmp al,86
                        je checkd4
                        inc al
                        jmp loopcheckd3
                    nod31:
                        add al,12
                        jmp loopcheckd3
            checkd4:
                cmp yPos,12
                jne checkd5
                mov al,0
                loopcheckd4:
                    cmp al,22
                    je nod4
                    cmp al,28
                    je nod4
                    cmp al,30
                    je nod4
                    cmp al,32
                    je nod4
                    cmp al,58
                    je nod4
                    cmp al,60
                    je nod4
                    cmp al,62
                    je nod4
                    cmp al,70
                    je nod4
                    cmp xPos,al
                    jne nod4
                    jmp gameLoop
                    nod4:
                        cmp al,86
                        je checkd5
                        inc al
                        jmp loopcheckd4
            checkd5:
                cmp yPos,17
                jne checkd6
                mov al,0
                loopcheckd5:
                    cmp al,22
                    je nod5
                    cmp al,39
                    je nod51
                    cmp al,70
                    je nod5
                    cmp xPos,al
                    jne nod5
                    jmp gameLoop
                    nod5:
                        cmp al,86
                        je checkd6
                        inc al
                        jmp loopcheckd5
                    nod51:
                        add al,12
                        jmp loopcheckd5
            checkd6:
                cmp yPos,20
                jne checkd7
                mov al,5
                loopcheckd6:
                    cmp al,22
                    je nod6
                    cmp al,26
                    je nod6
                    cmp al,66
                    je nod6
                    cmp al,70
                    je nod6
                    cmp xPos,al
                    jne nod6
                    jmp gameLoop
                    nod6:
                        cmp al,82
                        je checkd7
                        inc al
                        jmp loopcheckd6
            checkd7:
            
            call UpdatePlayer
            inc yPos
            call DrawPlayer
            jmp gameLoop

        moveLeft:
            cmp xPos,2
            je gameLoop
            
            movel:
                call UpdatePlayer
                dec xPos
                call DrawPlayer
                jmp gameLoop

        moveRight:
               cmp xPos,85
               je gameLoop
            mov esi,0
            checkr1:

            checkr2:
            mover:
            call UpdatePlayer
            inc xPos
            call DrawPlayer
            jmp gameLoop
        skip:

    jmp gameLoop

    exitGame:
    ret
Level3 ENDP


;=======================Print Pac-man Name Page==========================;

PrintName PROC
    
    call clrscr
    mov eax,blue ;(black * 16)
    call SetTextColor
    mov dh,4
    mov dl,20
    call Gotoxy
    mov edx,offset pacmanname1
    call WriteString

    
    mov dh,5
    mov dl,20
    call Gotoxy
    mov edx,offset pacmanname2
    call WriteString

    
    mov dh,6
    mov dl,20
    call Gotoxy
    mov edx,offset pacmanname3
    call WriteString

    mov eax,lightblue ;(black * 16)
    call SetTextColor
    mov dh,7
    mov dl,20
    call Gotoxy
    mov edx,offset pacmanname4
    call WriteString

    
    mov dh,8
    mov dl,20
    call Gotoxy
    mov edx,offset pacmanname5
    call WriteString

    mov eax,lightcyan ;(white * 16)
    call SetTextColor
    mov dh,9
    mov dl,20
    call Gotoxy
    mov edx,offset pacmanname51
    call WriteString

    mov dh,10
    mov dl,20
    call Gotoxy
    mov edx,offset pacmanname52
    call WriteString

    mov eax,red ;(black * 16)
    call SetTextColor
    mov dh,11
    mov dl,0
    call Gotoxy
    mov edx,offset pacmanname6
    call WriteString

    mov dh,12
    mov dl,0
    call Gotoxy
    mov edx,offset pacmanname7
    call WriteString

    mov dh,13
    mov dl,0
    call Gotoxy
    mov edx,offset pacmanname8
    call WriteString

    mov dh,14
    mov dl,0
    call Gotoxy
    mov edx,offset pacmanname9
    call WriteString

    mov dh,15
    mov dl,0
    call Gotoxy
    mov edx,offset pacmanname10
    call WriteString

    mov dh,16
    mov dl,0
    call Gotoxy
    mov edx,offset pacmanname11
    call WriteString

    mov dh,17
    mov dl,0
    call Gotoxy
    mov edx,offset pacmanname12
    call WriteString

    mov dh,18
    mov dl,0
    call Gotoxy
    mov edx,offset pacmanname13
    call WriteString

    mov dh,19
    mov dl,0
    call Gotoxy
    mov edx,offset pacmanname14
    call WriteString

    mov eax,white +(green * 16)
    call SetTextColor
    mov dh,22
    mov dl,44
    call Gotoxy
    mov edx,offset pacmanname15
    call WriteString

    call delay

    ; Get user input:
    userinput:
    call ReadChar
    mov inputChar, al

    cmp inputChar, "s"
    jne userinput
    jmp exitPrintName

    exitPrintName:
    mov eax,white +(black * 16)
    call SetTextColor
    call clrscr
    call EnterName
    ret
PrintName ENDP

;=======================Main==========================;

main PROC
    INVOKE PlaySound, OFFSET file, NULL, SND_ASYNC or SND_LOOP
   
    INVOKE Sleep, 1000
     
    INVOKE PlaySound, NULL, NULL, SND_NOSTOP
    
    call PrintName
    call clrscr
    call ShowMenu
    INVOKE PlaySound, OFFSET file2, NULL, SND_ASYNC or SND_LOOP
   
    INVOKE Sleep, 1000
     
     INVOKE PlaySound, NULL, NULL, SND_NOSTOP
    invoke GetStdHandle, STD_OUTPUT_HANDLE

   call Level1
   call clrscr
    call Level2
    call clrscr
   call Level3 
  
    ret
main ENDP

;=======================Draw Player==========================;

DrawPlayer PROC
    ; draw player at (xPos,yPos):
    mov eax,brown +(black*16)
    call SetTextColor
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al,254
    call WriteChar
    ret
DrawPlayer ENDP

;=======================Update Player==========================;

    UpdatePlayer PROC
        mov dl,xPos
        mov dh,yPos
        call Gotoxy
        mov al," "
        call WriteChar
        ret
    UpdatePlayer ENDP
;=======================Update Ghost==========================;

    UpdateGhost PROC
        mov eax,green
        call SetTextColor
        mov al,xPosghost
        mov bl,2
        div bl
        cmp ah,0
        jne printspace
        mov dl,xPosghost
        mov dh,yPosghost
        call Gotoxy
        mov al,"."
        call WriteChar
        jmp end1
        printspace:
        mov dl,xPosghost
        mov dh,yPosghost
        call Gotoxy
        mov al," "
        call WriteChar
        end1:
        ret
    UpdateGhost ENDP

    UpdateGhost2 PROC
        mov eax,green
        call SetTextColor
        mov al,xPosghost2
        mov bl,2
        div bl
        cmp ah,0
        jne printspace
        mov dl,xPosghost2
        mov dh,yPosghost2
        call Gotoxy
        mov al,"."
        call WriteChar
        jmp end1
        printspace:
        mov dl,xPosghost2
        mov dh,yPosghost2
        call Gotoxy
        mov al," "
        call WriteChar
        end1:
        ret
    UpdateGhost2 ENDP

    UpdateGhost3 PROC
        mov eax,green
        call SetTextColor
        mov al,xPosghost3
        mov bl,2
        div bl
        cmp ah,0
        jne printspace
        mov dl,xPosghost3
        mov dh,yPosghost3
        call Gotoxy
        mov al,"."
        call WriteChar
        jmp end1
        printspace:
        mov dl,xPosghost3
        mov dh,yPosghost3
        call Gotoxy
        mov al," "
        call WriteChar
        end1:
        ret
    UpdateGhost3 ENDP
;=======================Draw Ghost==========================;
    DrawGhost PROC
    ; draw ghost at (xPos,yPos):
        mov eax,magenta 
        call SetTextColor
        mov dl,xPosghost
        mov dh,yPosghost
        call Gotoxy
        mov al,254
        call WriteChar

        ret
    DrawGhost ENDP

    DrawGhost2 PROC
    ; draw ghost at (xPos,yPos):
        mov eax,lightred 
        call SetTextColor
        mov dl,xPosghost2
        mov dh,yPosghost2
        call Gotoxy
        mov al,254
        call WriteChar

        ret
    DrawGhost2 ENDP

    DrawGhost3 PROC
    ; draw ghost at (xPos,yPos):
        mov eax,lightblue 
        call SetTextColor
        mov dl,xPosghost3
        mov dh,yPosghost3
        call Gotoxy
        mov al,254
        call WriteChar

        ret
    DrawGhost3 ENDP
;=======================Draw Fruit in level 2 Randomly==========================;

    DrawCoin PROC
        mov eax,red +(red*16) 
        call SetTextColor
        mov dl,xCoinPos
        mov dh,yCoinPos
        call Gotoxy
        mov al,"."
        call WriteChar
        ret
    DrawCoin ENDP

;=======================Draw Fruit==========================;

DrawFruit PROC
    mov xFruitPos,55
    mov yFruitPos,19
    mov eax,red +(red * 16)
    call SetTextColor
    mov dl,xFruitPos
    mov dh,yFruitPos
    call Gotoxy
    mov al,"0"
    call WriteChar
    ret
DrawFruit ENDP

;=======================Create Random Fruit==========================;

CreateRandomCoin PROC
    dec yCoinPos
    mov eax,70
    inc eax
    call RandomRange
    mov xCoinPos,al
    mov yCoinPos,26
        dec yCoinPos

    ret
CreateRandomCoin ENDP

END main
