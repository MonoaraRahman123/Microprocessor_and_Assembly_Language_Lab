;Write an assembly code that compares three values and identifies the highest.

.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter first value: $'
    MSG2 DB 13,10,'Enter second value: $'
    MSG3 DB 13,10,'Enter third value: $'
    MSG4 DB 13,10,'Highest value = $'

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; -------------------------
    ; Input first value
    ; -------------------------
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BL, AL          ; BL = first value

    ; -------------------------
    ; Input second value
    ; -------------------------
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BH, AL          ; BH = second value

    ; -------------------------
    ; Compare first and second
    ; -------------------------
    CMP BL, BH
    JAE FIRST_HIGH

    MOV BL, BH          ; BL = second value

FIRST_HIGH:

    ; -------------------------
    ; Input third value
    ; -------------------------
    LEA DX, MSG3
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'

    ; -------------------------
    ; Compare current highest with third
    ; -------------------------
    CMP BL, AL
    JAE DISPLAY

    MOV BL, AL

DISPLAY:

    ; -------------------------
    ; Display highest value
    ; -------------------------
    LEA DX, MSG4
    MOV AH, 09H
    INT 21H

    ADD BL, '0'
    MOV DL, BL
    MOV AH, 02H
    INT 21H

    ; -------------------------
    ; Exit program
    ; -------------------------
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN