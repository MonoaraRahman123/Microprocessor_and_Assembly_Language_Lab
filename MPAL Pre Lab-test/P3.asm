;Write an assembly program to multiply two numbers and present the result as a two-digit number.

.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter first number: $'
    MSG2 DB 13,10,'Enter second number: $'
    MSG3 DB 13,10,'Result = $'

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; Input first number
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BL, AL

    ; Input second number
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'

    ; Multiply
    MUL BL              ; AX = AL * BL

    ; Save result
    MOV BL, 10
    DIV BL              ; AL = quotient (tens), AH = remainder (ones)

    MOV BH, AH          ; Save ones digit

    ; Display result message
    LEA DX, MSG3
    MOV AH, 09H
    INT 21H

    ; Display tens digit
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    ; Display ones digit
    MOV DL, BH
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN