;Construct an assembly language to print all uppercase letters with a space before each letter. 

.MODEL SMALL
.STACK 100H

.DATA
    MSG DB 'Uppercase Letters:', 13, 10, '$'

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; Display message
    LEA DX, MSG
    MOV AH, 09H
    INT 21H

    ; Start from 'A'
    MOV BL, 'A'

PRINT_LETTER:

    ; Print a space
    MOV DL, ' '
    MOV AH, 02H
    INT 21H

    ; Print uppercase letter
    MOV DL, BL
    MOV AH, 02H
    INT 21H

    ; Move to next letter
    INC BL

    ; Check whether Z has been printed
    CMP BL, 'Z' + 1
    JNE PRINT_LETTER

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN