;Create an assembly code script that outputs the multiplication table for a specified number. 

.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter a number (1-9): $'
    MSG2 DB 13,10,'Multiplication Table:',13,10,'$'

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; -------------------------
    ; Display input message
    ; -------------------------
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    ; -------------------------
    ; Take input
    ; -------------------------
    MOV AH, 01H
    INT 21H

    SUB AL, '0'
    MOV BL, AL              ; BL = entered number

    ; -------------------------
    ; Display table heading
    ; -------------------------
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    ; Counter = 1
    MOV BH, 1

TABLE_LOOP:

    ; -------------------------
    ; Calculate number * counter
    ; -------------------------
    MOV AL, BL
    MUL BH                  ; AX = AL * BH

    ; Save result
    MOV CL, AL              ; CL = result (0-90)

    ; -------------------------
    ; Print entered number
    ; -------------------------
    MOV DL, BL
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    ; Print " x "
    MOV DL, ' '
    INT 21H

    MOV DL, 'x'
    INT 21H

    MOV DL, ' '
    INT 21H

    ; -------------------------
    ; Print multiplier
    ; -------------------------
    MOV DL, BH
    ADD DL, '0'
    INT 21H

    ; Print " = "
    MOV DL, ' '
    INT 21H

    MOV DL, '='
    INT 21H

    MOV DL, ' '
    INT 21H

    ; -------------------------
    ; Print result
    ; -------------------------
    MOV AL, CL
    MOV AH, 0

    MOV DL, 10
    DIV DL                  ; AL = tens, AH = ones

    ; Check if tens digit is zero
    CMP AL, 0
    JE PRINT_ONES

    ; Print tens digit
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H

PRINT_ONES:

    ; Print ones digit
    MOV DL, AH
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    ; -------------------------
    ; New line
    ; -------------------------
    MOV DL, 13
    MOV AH, 02H
    INT 21H

    MOV DL, 10
    INT 21H

    ; -------------------------
    ; Increase counter
    ; -------------------------
    INC BH

    ; Continue until 10
    CMP BH, 11
    JNE TABLE_LOOP

    ; -------------------------
    ; Exit program
    ; -------------------------
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN