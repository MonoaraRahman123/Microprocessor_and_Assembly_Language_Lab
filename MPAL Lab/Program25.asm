
;Write an assembly program to concatenate two strings and display the combined string.
.MODEL SMALL
.STACK 100H

.DATA

    MSG1 DB 13,10,'Enter first string: $'
    MSG2 DB 13,10,'Enter second string: $'
    MSG3 DB 13,10,'Combined string: $'

    STR1 DB 50 DUP('$')
    STR2 DB 50 DUP('$')

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; -------------------------
    ; Input first string
    ; -------------------------

    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    LEA SI, STR1

INPUT1:

    MOV AH, 01H
    INT 21H

    CMP AL, 13
    JE END_INPUT1

    MOV [SI], AL
    INC SI

    JMP INPUT1

END_INPUT1:

    MOV BYTE PTR [SI], '$'


    ; -------------------------
    ; Input second string
    ; -------------------------

    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    LEA SI, STR2

INPUT2:

    MOV AH, 01H
    INT 21H

    CMP AL, 13
    JE END_INPUT2

    MOV [SI], AL
    INC SI

    JMP INPUT2

END_INPUT2:

    MOV BYTE PTR [SI], '$'


    ; -------------------------
    ; Find end of STR1
    ; -------------------------

    LEA SI, STR1

FIND_END:

    CMP BYTE PTR [SI], '$'
    JE APPEND

    INC SI
    JMP FIND_END


    ; -------------------------
    ; Append STR2 to STR1
    ; -------------------------

APPEND:

    LEA DI, STR2

COPY:

    MOV AL, [DI]

    CMP AL, '$'
    JE DONE

    MOV [SI], AL

    INC SI
    INC DI

    JMP COPY


DONE:

    MOV BYTE PTR [SI], '$'


    ; -------------------------
    ; Display combined string
    ; -------------------------

    LEA DX, MSG3
    MOV AH, 09H
    INT 21H

    LEA DX, STR1
    MOV AH, 09H
    INT 21H


    ; -------------------------
    ; Exit
    ; -------------------------

    MOV AX, 4C00H
    INT 21H

MAIN ENDP

END MAIN
