INCLUDE 'EMU8086.INC'

.MODEL SMALL
.STACK 100H

.DATA
    N DW 4

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; AX = 1
    MOV AX, 1

    ; CX = N
    MOV CX, N

L1:
    ; AX = AX * CX
    MUL CX

    ; CX = CX - 1
    LOOP L1

    ; AX = 24

    PRINT "FACTORIAL = "

    ; Convert AX to decimal and print
    MOV BX, 10
    MOV CX, 0

L2:
    MOV DX, 0
    DIV BX

    PUSH DX
    INC CX

    CMP AX, 0
    JNE L2

L3:
    POP DX

    ADD DL, '0'

    MOV AH, 02H
    INT 21H

    LOOP L3

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN