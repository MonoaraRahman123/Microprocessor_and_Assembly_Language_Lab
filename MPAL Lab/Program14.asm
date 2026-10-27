;Write a program to invert all bits of a 16-bit number stored in memory.
.MODEL SMALL
.STACK 100H
.DATA
    MSG1   DB 'Enter 16-bit number (4 hex digits): $'
    MSG2   DB 0DH, 0AH, 'Inverted number: $'
    NUM    DW ?             ; original number in memory
    RESULT DW ?             ; inverted number in memory

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    MOV DH, 4               ; read 4 hex digits
    XOR BX, BX
READ_LOOP:
    MOV AH, 01H
    INT 21H
    CMP AL, '9'
    JBE IS_DIGIT
    AND AL, 0DFH            ; make A-F uppercase
    SUB AL, 7               ; 'A' (41H) -> 3AH
IS_DIGIT:
    SUB AL, 30H
    MOV CL, 4
    SHL BX, CL              ; make room for next hex digit
    OR  BL, AL
    DEC DH
    JNZ READ_LOOP

    MOV NUM, BX             ; store original number in memory
    NOT BX                  ; invert all 16 bits
    MOV RESULT, BX          ; store inverted number in memory

    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    MOV BX, RESULT
    MOV DH, 4               ; print 4 hex digits
SHOW_LOOP:
    MOV CL, 4
    ROL BX, CL
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 9
    JBE PRINT_IT
    ADD DL, 7
PRINT_IT:
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    DEC DH
    JNZ SHOW_LOOP

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN