;Write an assembly program to input five numbers, display them in original and reverse order using the stack, and calculate their sum and average.
.MODEL SMALL
.STACK 100H

.DATA

    MSG1 DB 13,10,'Enter 5 numbers: $'
    MSG2 DB 13,10,'Original Order: $'
    MSG3 DB 13,10,'Reverse Order: $'
    MSG4 DB 13,10,'Sum = $'
    MSG5 DB 13,10,'Average = $'

    SUM DW 0
    AVG DW 0

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; Display input message
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    ; -------------------------
    ; INPUT 5 NUMBERS
    ; -------------------------

    MOV CX, 5

INPUT:
    MOV AH, 01H
    INT 21H

    SUB AL, '0'
    MOV AH, 0

    ; Add number to sum
    ADD SUM, AX

    ; Push number into stack
    PUSH AX

    MOV DL, ' '
    MOV AH, 02H
    INT 21H

    LOOP INPUT

    ; -------------------------
    ; ORIGINAL ORDER
    ; -------------------------

    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    ; Stack currently:
    ; Top = 5th number
    ; Bottom = 1st number
    ;
    ; To display original order,
    ; we pop into memory first.

    POP AX
    MOV [NUM5], AX

    POP AX
    MOV [NUM4], AX

    POP AX
    MOV [NUM3], AX

    POP AX
    MOV [NUM2], AX

    POP AX
    MOV [NUM1], AX

    MOV CX, 5

    MOV SI, OFFSET NUM1

PRINT_ORIGINAL:

    MOV AX, [SI]
    ADD AL, '0'
    MOV DL, AL

    MOV AH, 02H
    INT 21H

    MOV DL, ' '
    MOV AH, 02H
    INT 21H

    ADD SI, 2

    LOOP PRINT_ORIGINAL


    ; -------------------------
    ; PUSH NUMBERS AGAIN
    ; -------------------------

    PUSH NUM1
    PUSH NUM2
    PUSH NUM3
    PUSH NUM4
    PUSH NUM5

    ; -------------------------
    ; REVERSE ORDER
    ; -------------------------

    LEA DX, MSG3
    MOV AH, 09H
    INT 21H

    MOV CX, 5

PRINT_REVERSE:

    POP AX

    ADD AL, '0'
    MOV DL, AL

    MOV AH, 02H
    INT 21H

    MOV DL, ' '
    MOV AH, 02H
    INT 21H

    LOOP PRINT_REVERSE


    ; -------------------------
    ; DISPLAY SUM
    ; -------------------------

    LEA DX, MSG4
    MOV AH, 09H
    INT 21H

    MOV AX, SUM
    CALL PRINT_NUM


    ; -------------------------
    ; CALCULATE AVERAGE
    ; -------------------------

    MOV AX, SUM
    MOV DX, 0
    MOV BX, 5
    DIV BX

    MOV AVG, AX

    LEA DX, MSG5
    MOV AH, 09H
    INT 21H

    MOV AX, AVG
    CALL PRINT_NUM


    ; -------------------------
    ; EXIT
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


NUM1 DW ?
NUM2 DW ?
NUM3 DW ?
NUM4 DW ?
NUM5 DW ?

END MAIN