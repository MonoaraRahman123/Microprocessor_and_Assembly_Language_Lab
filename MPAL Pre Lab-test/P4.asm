;Create an assembly code that prints the numbers 0 through 9 using only conditional jump instructions.

.MODEL SMALL
.STACK 100H

.DATA
    MSG DB 'Numbers from 0 to 9: $'

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; Display message
    LEA DX, MSG
    MOV AH, 09H
    INT 21H

    ; Start from 0
    MOV BL, 0

START:
    ; Check whether BL = 0
    CMP BL, 0
    JE PRINT0

    ; Check whether BL = 1
    CMP BL, 1
    JE PRINT1

    ; Check whether BL = 2
    CMP BL, 2
    JE PRINT2

    ; Check whether BL = 3
    CMP BL, 3
    JE PRINT3

    ; Check whether BL = 4
    CMP BL, 4
    JE PRINT4

    ; Check whether BL = 5
    CMP BL, 5
    JE PRINT5

    ; Check whether BL = 6
    CMP BL, 6
    JE PRINT6

    ; Check whether BL = 7
    CMP BL, 7
    JE PRINT7

    ; Check whether BL = 8
    CMP BL, 8
    JE PRINT8

    ; Check whether BL = 9
    CMP BL, 9
    JE PRINT9

    ; If BL = 10, exit
    CMP BL, 10
    JE EXIT

PRINT0:
    MOV DL, '0'
    JMP DISPLAY

PRINT1:
    MOV DL, '1'
    JMP DISPLAY

PRINT2:
    MOV DL, '2'
    JMP DISPLAY

PRINT3:
    MOV DL, '3'
    JMP DISPLAY

PRINT4:
    MOV DL, '4'
    JMP DISPLAY

PRINT5:
    MOV DL, '5'
    JMP DISPLAY

PRINT6:
    MOV DL, '6'
    JMP DISPLAY

PRINT7:
    MOV DL, '7'
    JMP DISPLAY

PRINT8:
    MOV DL, '8'
    JMP DISPLAY

PRINT9:
    MOV DL, '9'
    JMP DISPLAY

DISPLAY:
    MOV AH, 02H
    INT 21H

    ; Move to next number
    INC BL

    ; Conditional jump back to START
    CMP BL, 10
    JNE START

EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN