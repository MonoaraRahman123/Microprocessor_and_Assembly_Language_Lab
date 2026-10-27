.MODEL SMALL
.STACK 100H

.DATA
    A DB 02H
    B DB 03H
    C DB 04H
    D DB 02H

    RESULT DW 0000H

    MSG DB 'Result = $'

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; Calculate A * B
    MOV AL, A
    MUL B

    ; AX = A * B

    ; Add C
    XOR BH, BH
    MOV BL, C
    ADD AX, BX

    ; AX = (A * B) + C

    ; Divide by D
    XOR DX, DX

    XOR BX, BX
    MOV BL, D

    DIV BX

    ; AX = Quotient
    ; DX = Remainder

    MOV RESULT, AX

    ; Display message
    LEA DX, MSG
    MOV AH, 09H
    INT 21H

    ; Display hexadecimal result
    MOV AX, RESULT
    CALL PRINT_HEX

    MOV AH, 4CH
    INT 21H

MAIN ENDP


;--------------------------------
; Print 16-bit hexadecimal number
;--------------------------------
PRINT_HEX PROC

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV BX, AX
    MOV CX, 04H

L1:
    ROL BX, 4

    MOV DL, BL
    AND DL, 0FH

    CMP DL, 09H
    JBE DIGIT

    ADD DL, 07H

DIGIT:
    ADD DL, '0'

    MOV AH, 02H
    INT 21H

    LOOP L1

    POP DX
    POP CX
    POP BX
    POP AX

    RET

PRINT_HEX ENDP

END MAIN
