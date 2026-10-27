;Write an assembly program to input two unsigned numbers, multiply them using MUL, and display the product.
.MODEL SMALL
.STACK 100H

.DATA

    MSG1 DB 13,10,'Enter first number: $'
    MSG2 DB 13,10,'Enter second number: $'
    MSG3 DB 13,10,'Product = $'

    NUM1 DB ?
    NUM2 DB ?

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
    MOV NUM1, AL


    ; -------------------------
    ; Input second number
    ; -------------------------

    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    SUB AL, '0'
    MOV NUM2, AL


    ; -------------------------
    ; Multiply using MUL
    ; -------------------------

    MOV AL, NUM1
    MOV BL, NUM2

    MUL BL
    ; AL * BL = AX


    ; Save product
    MOV BX, AX


    ; -------------------------
    ; Display product message
    ; -------------------------

    LEA DX, MSG3
    MOV AH, 09H
    INT 21H


    ; Restore product
    MOV AX, BX

    ; Display product
    CALL PRINT_NUM


    ; -------------------------
    ; Exit
    ; -------------------------

    MOV AX, 4C00H
    INT 21H

MAIN ENDP


; =================================
; PRINT NUMBER PROCEDURE
; =================================

PRINT_NUM PROC

    MOV BX, 10
    MOV CX, 0

CONVERT:

    MOV DX, 0
    DIV BX

    PUSH DX
    INC CX

    CMP AX, 0
    JNE CONVERT


DISPLAY:

    POP DX
    ADD DL, '0'

    MOV AH, 02H
    INT 21H

    LOOP DISPLAY

    RET

PRINT_NUM ENDP

END MAIN