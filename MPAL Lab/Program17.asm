;Write an assembly code to multiply the unsigned value in AX by 2 using a shift instructions.
ORG 100H

.MODEL SMALL
.STACK 100H

.DATA

MSG1 DB 'Enter a number: $'
MSG2 DB 13,10,'Result = $'

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; Display message
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    ; Take input
    MOV AH, 01H
    INT 21H

    ; Convert ASCII to number
    SUB AL, '0'
    MOV AH, 00H

    ; Multiply AX by 2
    SHL AX, 1

    ; Save result
    MOV BX, AX

    ; Display result message
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    ; Convert result to decimal
    MOV AX, BX
    MOV BL, 10
    DIV BL

    ; Save remainder
    MOV BH, AH

    ; Check tens digit
    CMP AL, 0
    JE ONE_DIGIT

    ; Print tens digit
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H

ONE_DIGIT:

    ; Print ones digit
    MOV DL, BH
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN