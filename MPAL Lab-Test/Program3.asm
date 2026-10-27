.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Effective Address = $'
    MSG2 DB 0DH,0AH,'Physical Address = $'
    MSG3 DB 0DH,0AH,'Memory Value = $'
    MSG4 DB 0DH,0AH,'Final AX = $'

    EA DW ?
    PA1 DW ?
    RESULT DW ?
    MEMVAL DW ?

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; Initialize segment and registers
    MOV AX, 2000H
    MOV ES, AX
    MOV BX, 0100H
    MOV SI, 0020H

    ; Store given memory value
    MOV WORD PTR ES:[BX+SI], 1234H

    ; Calculate EA
    MOV AX, BX
    ADD AX, SI
    MOV EA, AX

    ; Calculate Physical Address
    ; PA = DS * 10H + EA
    ; 20000H + 0120H = 20120H

    MOV AX, 0120H
    MOV PA1, AX

    ; Read memory value
    MOV AX, ES:[BX+SI]
    MOV MEMVAL, AX

    ; Add 0010H
    ADD AX, 0010H
    MOV RESULT, AX

    ; Print EA
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    MOV AX, EA
    CALL PRINT_HEX

    ; Print Physical Address
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    MOV DL, '2'
    MOV AH, 02H
    INT 21H

    MOV AX, PA1
    CALL PRINT_HEX

    ; Print Memory Value
    LEA DX, MSG3
    MOV AH, 09H
    INT 21H

    MOV AX, MEMVAL
    CALL PRINT_HEX

    ; Print Final AX
    LEA DX, MSG4
    MOV AH, 09H
    INT 21H

    MOV AX, RESULT
    CALL PRINT_HEX

    MOV AH, 4CH
    INT 21H

MAIN ENDP


;--------------------------------
; PRINT 16-BIT HEX VALUE
;--------------------------------

PRINT_HEX PROC

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV BX, AX
    MOV CH, 4
    MOV CL, 12

L1:
    MOV AX, BX
    SHR AX, CL
    AND AL, 0FH

    CMP AL, 09H
    JBE DIGIT

    ADD AL, 37H
    JMP DISPLAY

DIGIT:
    ADD AL, 30H

DISPLAY:
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    SUB CL, 4
    DEC CH
    JNZ L1

    POP DX
    POP CX
    POP BX
    POP AX

    RET

PRINT_HEX ENDP

END MAIN