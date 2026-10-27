;Write an assembly code to divide the unsigned value in BX by 8.
ORG 100H

.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter a number: $'
    MSG2 DB 13,10,'Result = $'

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; Display message
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    ; Take single digit input
    MOV AH, 01H
    INT 21H

    ; Convert ASCII to number
    SUB AL, '0'
    MOV AH, 00H

    ; Store value in BX
    MOV BX, AX

    ; Divide BX by 8
    SHR BX, 3

    ; Display result message
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    ; Convert result to ASCII
    MOV AX, BX
    ADD AL, '0'

    ; Display result
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN