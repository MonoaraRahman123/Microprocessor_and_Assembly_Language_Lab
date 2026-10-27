;Develop an assembly language code to generate a traingle of asterisks aligned to the right.

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

    ; Row counter
    MOV CL, 1

ROW_LOOP:

    ; Calculate spaces = total rows - current row
    MOV AL, BL
    SUB AL, CL
    MOV BH, AL          ; BH = number of spaces

SPACE_LOOP:

    CMP BH, 0
    JE STAR_START

    ; Print space
    MOV DL, ' '
    MOV AH, 02H
    INT 21H

    DEC BH
    JMP SPACE_LOOP

STAR_START:

    ; Number of stars = current row
    MOV BH, CL

STAR_LOOP:

    CMP BH, 0
    JE NEXT_ROW

    ; Print *
    MOV DL, '*'
    MOV AH, 02H
    INT 21H

    DEC BH
    JMP STAR_LOOP

NEXT_ROW:

    ; New line
    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    INT 21H

    INC CL
    CMP CL, BL
    JBE ROW_LOOP

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN