;Write an assembly code to rotate the contents of BX 4 positions left.
.MODEL SMALL
.STACK 100H

.DATA

MSG1 DB 'Enter a 4-digit HEX number: $'
MSG2 DB 13,10,'After ROL BX,4 = $'

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; Display input message
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    ; -------------------------
    ; Read first HEX digit
    ; -------------------------
    MOV AH, 01H
    INT 21H
    CALL HEX

    MOV CL, 4
    SHL AL, CL
    MOV BL, AL

    ; -------------------------
    ; Read second HEX digit
    ; -------------------------
    MOV AH, 01H
    INT 21H
    CALL HEX

    OR BL, AL

    ; -------------------------
    ; Read third HEX digit
    ; -------------------------
    MOV AH, 01H
    INT 21H
    CALL HEX

    MOV CL, 4
    SHL AL, CL
    MOV BH, AL

    ; -------------------------
    ; Read fourth HEX digit
    ; -------------------------
    MOV AH, 01H
    INT 21H
    CALL HEX

    OR BH, AL

    ; BX now contains input

    ; Rotate BX left 4 positions
    ROL BX, 4

    ; -------------------------
    ; Display result message
    ; -------------------------
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    ; -------------------------
    ; Print first HEX digit
    ; -------------------------
    MOV AX, BX
    MOV CL, 12
    SHR AX, CL
    AND AL, 0FH
    MOV DL, AL
    CALL PRINT_HEX

    ; -------------------------
    ; Print second HEX digit
    ; -------------------------
    MOV AX, BX
    MOV CL, 8
    SHR AX, CL
    AND AL, 0FH
    MOV DL, AL
    CALL PRINT_HEX

    ; -------------------------
    ; Print third HEX digit
    ; -------------------------
    MOV AX, BX
    MOV CL, 4
    SHR AX, CL
    AND AL, 0FH
    MOV DL, AL
    CALL PRINT_HEX

    ; -------------------------
    ; Print fourth HEX digit
    ; -------------------------
    MOV AX, BX
    AND AL, 0FH
    MOV DL, AL
    CALL PRINT_HEX

    ; Exit
    MOV AH, 4CH
    INT 21H


; =================================
; Convert HEX character to number
; =================================
HEX PROC

    CMP AL, '9'
    JBE NUMBER

    SUB AL, 'A'
    ADD AL, 10
    RET

NUMBER:
    SUB AL, '0'
    RET

HEX ENDP


; =================================
; Print HEX digit
; DL = value from 0 to 15
; =================================
PRINT_HEX PROC

    CMP DL, 9
    JBE DIGIT

    ADD DL, 'A' - 10
    JMP PRINT

DIGIT:
    ADD DL, '0'

PRINT:
    MOV AH, 02H
    INT 21H
    RET

PRINT_HEX ENDP

MAIN ENDP

END MAIN