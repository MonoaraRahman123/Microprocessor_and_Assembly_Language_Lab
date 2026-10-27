 ;Write an assembly program that reverses all 8 bits of AL.
.MODEL SMALL
.STACK 100H

.DATA

MSG1 DB 'Enter 8-bit binary number: $'
MSG2 DB 13,10,'Reverse = $'

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; Display message
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    ; Read 8-bit binary number
    MOV BL, 0
    MOV CX, 8

INPUT:
    MOV AH, 01H
    INT 21H

    SUB AL, '0'

    SHL BL, 1
    OR BL, AL

    LOOP INPUT

    ; AL contains input
    MOV AL, BL

    ; Reverse 8 bits
    MOV BL, 0
    MOV CX, 8

REVERSE:
    SHR AL, 1
    RCL BL, 1
    LOOP REVERSE

    ; Display message
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    ; Print reversed binary
    MOV AL, BL
    MOV CX, 8

PRINT:
    SHL AL, 1

    JC ONE

    MOV DL, '0'
    JMP DISPLAY

ONE:
    MOV DL, '1'

DISPLAY:
    MOV AH, 02H
    INT 21H

    LOOP PRINT

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN