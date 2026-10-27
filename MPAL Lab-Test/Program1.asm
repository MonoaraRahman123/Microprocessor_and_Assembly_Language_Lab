.MODEL SMALL
.STACK 100H

.DATA
    ARRAY DB 12H, 45H, 23H, 67H, 34H
    MAX   DB ?

    MSG DB 'Maximum = $'

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    LEA BX, ARRAY
    MOV AL, [BX]
    INC BX

    MOV CX, 4

NEXT:
    CMP AL, [BX]
    JAE SKIP

    MOV AL, [BX]

SKIP:
    INC BX
    LOOP NEXT

    MOV MAX, AL

    ; Print message
    MOV AH, 09H
    LEA DX, MSG
    INT 21H

    ; Print maximum in hexadecimal
    MOV AL, MAX
    CALL PRINT_HEX

    ; Print H
    MOV AH, 02H
    MOV DL, 'H'
    INT 21H

    ; New line
    MOV AH, 02H
    MOV DL, 0DH
    INT 21H

    MOV DL, 0AH
    INT 21H

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP


;--------------------------------
; Procedure to print AL in HEX
;--------------------------------

PRINT_HEX PROC

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV BL, AL

    ; Print upper 4 bits
    MOV CL, 4
    SHR AL, CL
    CALL PRINT_DIGIT

    ; Print lower 4 bits
    MOV AL, BL
    AND AL, 0FH
    CALL PRINT_DIGIT

    POP DX
    POP CX
    POP BX
    POP AX

    RET

PRINT_HEX ENDP


;--------------------------------
; Convert hexadecimal digit to ASCII
;--------------------------------

PRINT_DIGIT PROC

    CMP AL, 09H
    JBE NUMBER

    ADD AL, 37H
    JMP DISPLAY

NUMBER:
    ADD AL, 30H

DISPLAY:
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    RET

PRINT_DIGIT ENDP

END MAIN