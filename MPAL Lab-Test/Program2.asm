.MODEL SMALL
.STACK 100H

.DATA
    SOURCE DB 'HELLO'
    DEST   DB 5 DUP(?)

    MSG DB 'Original String: $'
    MSG2 DB 0DH, 0AH, 'Reversed String: $'

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX

    ; Print Original String
    MOV AH, 09H
    LEA DX, MSG
    INT 21H

    MOV CX, 5
    LEA SI, SOURCE

PRINT1:
    MOV DL, [SI]
    MOV AH, 02H
    INT 21H
    INC SI
    LOOP PRINT1

    ; Initialize registers for reversing
    LEA SI, SOURCE + 4
    LEA DI, DEST
    MOV CX, 5

REVERSE:
    STD                 ; Set direction flag = 1
    LODSB               ; AL = [SI], SI = SI - 1

    CLD                 ; Set direction flag = 0
    STOSB               ; [DI] = AL, DI = DI + 1

    LOOP REVERSE

    ; Print Reversed String
    MOV AH, 09H
    LEA DX, MSG2
    INT 21H

    LEA SI, DEST
    MOV CX, 5

PRINT2:
    MOV DL, [SI]
    MOV AH, 02H
    INT 21H

    INC SI
    LOOP PRINT2

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN