;Write an assembly code to reverse a number using the stack with PUSH and POP instructions.

.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter a number: $'
    MSG2 DB 13,10,'Reversed number: $'

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; Display input message
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    ; Read first digit
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV AH, 0
    PUSH AX

    ; Read second digit
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV AH, 0
    PUSH AX

    ; Read third digit
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV AH, 0
    PUSH AX

    ; Read fourth digit
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV AH, 0
    PUSH AX

    ; Display reversed message
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    ; POP and display fourth digit
    POP AX
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    ; POP and display third digit
    POP AX
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    ; POP and display second digit
    POP AX
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    ; POP and display first digit
    POP AX
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN