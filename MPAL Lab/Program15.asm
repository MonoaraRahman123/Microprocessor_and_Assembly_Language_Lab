;Input a lowercase English letter and convert it into uppercase using a logic operation.
.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'Enter a lowercase letter: $'
    MSG2 DB 0DH, 0AH, 'Uppercase letter: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H             ; read a character into AL
    INT 21H

    AND AL, 11011111B       ; clear bit 5 (0DFH): 'a'(61H) -> 'A'(41H)
    MOV BL, AL

    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    MOV DL, BL              ; display converted letter
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN