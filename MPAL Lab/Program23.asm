;Write an assembly program to input two signed integers, divide them using IDIV with proper sign extention, and display the quotient and remainder.
.MODEL SMALL
.STACK 100H

.DATA

    MSG1 DB 13,10,'Enter first signed number (-9 to 9): $'
    MSG2 DB 13,10,'Enter second signed number (-9 to 9): $'
    MSG3 DB 13,10,'Quotient = $'
    MSG4 DB 13,10,'Remainder = $'

    NUM1 DW ?
    NUM2 DW ?
    QUOT DW ?
    REM  DW ?

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; -------------------------
    ; Input first signed number
    ; -------------------------

    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    CALL READ_SIGNED
    MOV NUM1, AX


    ; -------------------------
    ; Input second signed number
    ; -------------------------

    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    CALL READ_SIGNED
    MOV NUM2, AX


    ; -------------------------
    ; Signed division
    ; -------------------------

    MOV AX, NUM1
    CWD
    ; Sign extend AX into DX:AX

    IDIV NUM2
    ; DX:AX / NUM2
    ; AX = quotient
    ; DX = remainder

    MOV QUOT, AX
    MOV REM, DX


    ; -------------------------
    ; Display quotient
    ; -------------------------

    LEA DX, MSG3
    MOV AH, 09H
    INT 21H

    MOV AX, QUOT
    CALL PRINT_SIGNED


    ; -------------------------
    ; Display remainder
    ; -------------------------

    LEA DX, MSG4
    MOV AH, 09H
    INT 21H

    MOV AX, REM
    CALL PRINT_SIGNED


    ; -------------------------
    ; Exit
    ; -------------------------

    MOV AX, 4C00H
    INT 21H

MAIN ENDP


; =================================
; READ SIGNED NUMBER
; =================================

READ_SIGNED PROC

    MOV AH, 01H
    INT 21H

    CMP AL, '-'
    JE NEGATIVE

    ; Positive number
    SUB AL, '0'
    MOV AH, 0
    RET

NEGATIVE:

    MOV AH, 01H
    INT 21H

    SUB AL, '0'
    MOV AH, 0

    NEG AX

    RET

READ_SIGNED ENDP


; =================================
; PRINT SIGNED NUMBER
; =================================

PRINT_SIGNED PROC

    CMP AX, 0
    JGE POSITIVE

    ; Print minus sign
    PUSH AX

    MOV DL, '-'
    MOV AH, 02H
    INT 21H

    POP AX
    NEG AX

POSITIVE:

    MOV BX, 10
    MOV CX, 0

    CMP AX, 0
    JNE CONVERT

    ; Print zero
    MOV DL, '0'
    MOV AH, 02H
    INT 21H
    RET


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

PRINT_SIGNED ENDP

END MAIN