.MODEL SMALL
.STACK 100H

.DATA
    ARRAY DB 02H, 05H, 08H, 03H, 06H, 01H
    TOTAL DW 0000H

    MSG DB 'Sum = $'

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    MOV SI, OFFSET ARRAY
    MOV CX, 06H
    MOV BX, 0000H

L1:
    MOV AL, [SI]

    ; Check whether number is even
    TEST AL, 01H
    JNZ SKIP

    ; Add even number to BX
    XOR AH, AH
    ADD BX, AX

SKIP:
    INC SI
    LOOP L1

    MOV TOTAL, BX

    ; Display message
    LEA DX, MSG
    MOV AH, 09H
    INT 21H

    ; Print hexadecimal result
    MOV AX, TOTAL
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

L2:
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

    LOOP L2

    POP DX
    POP CX
    POP BX
    POP AX

    RET

PRINT_HEX ENDP

END MAIN