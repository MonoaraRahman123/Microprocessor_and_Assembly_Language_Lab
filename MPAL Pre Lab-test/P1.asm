;Create an assembly code to perform the addition of two single-digit inputs and display the result.  

.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter first digit: $'
    MSG2 DB 13,10,'Enter second digit: $'
    MSG3 DB 13,10,'Sum = $'

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; Display first message
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    ; Take first digit
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BL, AL

    ; Display second message
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    ; Take second digit
    MOV AH, 01H
    INT 21H
    SUB AL, '0'

    ; Add two digits
    ADD AL, BL

    ; Convert result to ASCII
    ADD AL, '0'
    MOV BL, AL

    ; Display result message
    LEA DX, MSG3
    MOV AH, 09H
    INT 21H

    ; Display result
    MOV DL, BL
    MOV AH, 02H
    INT 21H

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN