;Give me assembly language code where included the operation of ADD,SUB,INC,DEC and NEG. 

.MODEL SMALL
.STACK 100H

.DATA
    MSG1   DB 'Enter first number: $'
    MSG2   DB 13,10,'Enter second number: $'

    ADDMSG DB 13,10,'ADD = $'
    SUBMSG DB 13,10,'SUB = $'
    INCMSG DB 13,10,'INC = $'
    DECMSG DB 13,10,'DEC = $'
    NEGMSG DB 13,10,'NEG = $'

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; =========================
    ; INPUT FIRST NUMBER
    ; =========================
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    SUB AL, '0'
    MOV BL, AL


    ; =========================
    ; INPUT SECOND NUMBER
    ; =========================
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    SUB AL, '0'
    MOV BH, AL


    ; =========================
    ; ADD
    ; First + Second
    ; =========================
    LEA DX, ADDMSG
    MOV AH, 09H
    INT 21H

    MOV AL, BL
    ADD AL, BH

    ADD AL, '0'
    MOV DL, AL

    MOV AH, 02H
    INT 21H


    ; =========================
    ; SUB
    ; First - Second
    ; =========================
    LEA DX, SUBMSG
    MOV AH, 09H
    INT 21H

    MOV AL, BL
    SUB AL, BH

    ; Check if result is negative
    JNS SUB_POSITIVE

    ; Print minus sign
    MOV DL, '-'
    MOV AH, 02H
    INT 21H

    ; Convert negative value to positive
    NEG AL

SUB_POSITIVE:

    ADD AL, '0'
    MOV DL, AL

    MOV AH, 02H
    INT 21H


    ; =========================
    ; INC
    ; First + 1
    ; =========================
    LEA DX, INCMSG
    MOV AH, 09H
    INT 21H

    MOV AL, BL

    INC AL

    ADD AL, '0'
    MOV DL, AL

    MOV AH, 02H
    INT 21H


    ; =========================
    ; DEC
    ; First - 1
    ; =========================
    LEA DX, DECMSG
    MOV AH, 09H
    INT 21H

    MOV AL, BL

    DEC AL

    ADD AL, '0'
    MOV DL, AL

    MOV AH, 02H
    INT 21H


    ; =========================
    ; NEG
    ; -First
    ; =========================
    LEA DX, NEGMSG
    MOV AH, 09H
    INT 21H

    ; Copy first number
    MOV AL, BL

    ; Perform NEG operation
    NEG AL

    ; Print minus sign
    MOV DL, '-'
    MOV AH, 02H
    INT 21H

    ; Convert negative value
    ; back to positive magnitude
    NEG AL

    ; Convert number to ASCII
    ADD AL, '0'

    ; Print number
    MOV DL, AL
    MOV AH, 02H
    INT 21H


    ; =========================
    ; EXIT
    ; =========================
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN