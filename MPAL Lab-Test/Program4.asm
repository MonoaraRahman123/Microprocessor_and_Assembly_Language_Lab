INCLUDE 'EMU8086.INC'

.MODEL SMALL
.STACK 100H

.DATA

.CODE

MAIN PROC

    ; Initialize AX = 0
    MOV AX, 0

    ; Initialize counter = 5
    MOV CX, 5

L1:
    ; AX = AX + CX
    ; 5 + 4 + 3 + 2 + 1 = 15
    ADD AX, CX

    ; Repeat until CX = 0
    LOOP L1

    ; Print message
    PRINT "FINAL AX = "

    ; AX contains 15 (000FH)
    ; Display AX in hexadecimal

    MOV BX, AX
    MOV CX, 4

L2:
    ROL BX, 4
    MOV DL, BL
    AND DL, 0FH

    CMP DL, 09H
    JBE DIGIT

    ADD DL, 07H

DIGIT:
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    LOOP L2

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN