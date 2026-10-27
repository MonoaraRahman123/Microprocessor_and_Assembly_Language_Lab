;Write an assembly program to find the GCD of two positive integers using repeated division and remainder operations.
.MODEL SMALL
.STACK 100H

.DATA

    MSG1 DB 13,10,'Enter first positive integer: $'
    MSG2 DB 13,10,'Enter second positive integer: $'
    MSG3 DB 13,10,'GCD = $'

    NUM1 DW ?
    NUM2 DW ?

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

    CALL READ_NUM
    MOV NUM1, AX


    ; -------------------------
    ; Input second number
    ; -------------------------

    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    CALL READ_NUM
    MOV NUM2, AX


    ; -------------------------
    ; GCD calculation
    ; -------------------------

    MOV AX, NUM1
    MOV BX, NUM2

GCD_LOOP:

    MOV DX, 0
    DIV BX

    ; DX = remainder

    CMP DX, 0
    JE GCD_FOUND

    MOV AX, BX
    MOV BX, DX

    JMP GCD_LOOP


GCD_FOUND:

    ; BX contains GCD
    MOV AX, BX

    ; -------------------------
    ; Display GCD
    ; -------------------------

    LEA DX, MSG3
    MOV AH, 09H
    INT 21H

    CALL PRINT_NUM


    ; -------------------------
    ; Exit
    ; -------------------------

    MOV AX, 4C00H
    INT 21H

MAIN ENDP


; =================================
; READ POSITIVE INTEGER
; =================================

READ_NUM PROC

    PUSH BX
    PUSH CX
    PUSH DX

    MOV BX, 10
    MOV CX, 0

READ_LOOP:

    MOV AH, 01H
    INT 21H

    CMP AL, 13
    JE READ_DONE

    SUB AL, '0'
    MOV AH, 0

    PUSH AX

    MOV AX, CX
    MUL BX

    MOV CX, AX

    POP AX

    ADD CX, AX

    JMP READ_LOOP


READ_DONE:

    MOV AX, CX

    POP DX
    POP CX
    POP BX

    RET

READ_NUM ENDP


; =================================
; PRINT POSITIVE INTEGER
; =================================

PRINT_NUM PROC

    PUSH BX
    PUSH CX
    PUSH DX

    MOV BX, 10
    MOV CX, 0

    CMP AX, 0
    JNE CONVERT

    MOV DL, '0'
    MOV AH, 02H
    INT 21H

    JMP PRINT_DONE


CONVERT:

    MOV DX, 0
    DIV BX

    PUSH DX
    INC CX

    CMP AX, 0
    JNE CONVERT


PRINT_DIGITS:

    POP DX

    ADD DL, '0'

    MOV AH, 02H
    INT 21H

    LOOP PRINT_DIGITS

                                  
                                  
PRINT_DONE:

    POP DX
    POP CX
    POP BX

    RET

PRINT_NUM ENDP

END MAIN
