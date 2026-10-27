;Develop an assembly language pattern program to generate a left-justified inverted triangle using *.

.MODEL SMALL
.STACK 100H

.DATA
    MSG DB 'Enter number of rows: $'

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; Display message
    LEA DX, MSG
    MOV AH, 09H
    INT 21H

    ; Take number of rows
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BL, AL          ; BL = number of rows

    ; New line
    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    INT 21H

    ; Outer loop
    MOV CL, BL

OUTER_LOOP:

    ; Number of stars = CL
    MOV CH, 0
    MOV BH, CL

INNER_LOOP:

    CMP BH, 0
    JE NEXT_ROW

    ; Print '*'
    MOV DL, '*'
    MOV AH, 02H
    INT 21H

    DEC BH
    JMP INNER_LOOP

NEXT_ROW:

    ; New line
    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    INT 21H

    DEC CL
    CMP CL, 0
    JNE OUTER_LOOP

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN