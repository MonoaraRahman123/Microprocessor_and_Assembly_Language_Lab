;Convert an ASCII digit into its numerical value
.MODEL SMALL
.STACK 100H
.DATA
    MSG1  DB 'Enter a digit (0-9): $'
    MSG2  DB 0DH, 0AH, 'Numerical value: $'
    VALUE DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H             ; read ASCII digit into AL
    INT 21H

    SUB AL, 30H             ; '0'-'9' (30H-39H) -> 0-9
    MOV VALUE, AL           ; numerical value stored in memory

    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    MOV DL, VALUE           ; convert back to ASCII only for display
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN