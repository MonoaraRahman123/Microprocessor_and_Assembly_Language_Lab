+;Recursion implementation using assembly language.
.MODEL SMALL
.STACK 100H

.DATA

    MSG1 DB 13,10,'Enter a number (0-8): $'
    MSG2 DB 13,10,'Factorial = $'

    NUM DW ?

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; -------------------------
    ; Input number
    ; -------------------------

    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    CALL READ_NUM
    MOV NUM, AX


    ; -------------------------
    ; Call recursive factorial
    ; -------------------------

    MOV AX, NUM
    CALL FACTORIAL

    ; AX = factorial result


    ; -------------------------
    ; Display result
    ; -------------------------

    LEA DX, MSG2
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
; RECURSIVE FACTORIAL
; =================================
; n! = n * (n-1)!
; 0! = 1
; 1! = 1
; =================================

FACTORIAL PROC

    ; Base case
    CMP AX, 1
    JBE BASE_CASE

    ; Save n
    PUSH AX

    ; Calculate factorial(n-1)
    DEC AX
    CALL FACTORIAL

    ; Restore n
    POP BX

    ; AX = factorial(n-1)
    ; BX = n
    ; AX = AX * BX

    MUL BX

    RET


BASE_CASE:

    MOV AX, 1
    RET

FACTORIAL ENDP


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
; PRINT NUMBER
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


DISPLAY:

    POP DX

    ADD DL, '0'

    MOV AH, 02H
    INT 21H

    LOOP DISPLAY


PRINT_DONE:

    POP DX
    POP CX
    POP BX

    RET

PRINT_NUM ENDP

END MAIN
