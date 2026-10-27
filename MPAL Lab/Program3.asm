;Input two numbers and print them in Assembly language

.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter first number: $'
    MSG2 DB 13,10,'Enter second number: $'
    OUT1 DB 13,10,'First number = $'
    OUT2 DB 13,10,'Second number = $'

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; -------------------------
    ; Input first number
    ; -------------------------
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    SUB AL, '0'
    MOV BL, AL

    ; -------------------------
    ; Input second number
    ; -------------------------                                
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    SUB AL, '0'
    MOV BH, AL

    ; -------------------------
    ; Print first number
    ; -------------------------
    LEA DX, OUT1
    MOV AH, 09H
    INT 21H

    MOV DL, BL
    ADD DL, '0'

    MOV AH, 02H
    INT 21H

    ; -------------------------
    ; Print second number
    ; -------------------------
    LEA DX, OUT2
    MOV AH, 09H
    INT 21H

    MOV DL, BH
    ADD DL, '0'

    MOV AH, 02H
    INT 21H

    ; -------------------------
    ; Exit
    ; -------------------------
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN