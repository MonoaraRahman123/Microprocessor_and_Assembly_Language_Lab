;Create an assembly program to check if a given number or word is a palindrome and display the result. 

.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter a 4-digit number: $'
    MSG2 DB 13,10,'Palindrome$'
    MSG3 DB 13,10,'Not Palindrome$'

    NUM DB 4 DUP(?)

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; -------------------------
    ; Display input message
    ; -------------------------
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    ; -------------------------
    ; Read 4 digits
    ; -------------------------
    LEA SI, NUM
    MOV CX, 4

INPUT_LOOP:
    MOV AH, 01H
    INT 21H

    MOV [SI], AL
    INC SI

    LOOP INPUT_LOOP

    ; -------------------------
    ; Compare first and last
    ; Compare second and third
    ; -------------------------

    MOV AL, NUM[0]
    CMP AL, NUM[3]
    JNE NOT_PALINDROME

    MOV AL, NUM[1]
    CMP AL, NUM[2]
    JNE NOT_PALINDROME

    ; -------------------------
    ; It is a palindrome
    ; -------------------------
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H
    JMP EXIT

NOT_PALINDROME:

    ; -------------------------
    ; It is not a palindrome
    ; -------------------------
    LEA DX, MSG3
    MOV AH, 09H
    INT 21H

EXIT:

    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN