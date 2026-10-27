;Read a character.If it's "y" or "Y",display it otherwise, terminate the program (use OR conditions).
.MODEL SMALL
.STACK 100H
.DATA
.CODE
MAIN PROC
;read a character
    MOV AH,1    ;Prepare to read
    INT 21H     ;char in AL
;if (Character = 'y') or (character = 'Y')
    CMP AL,'y'  ;char = 'y'?
    JE THEN     ;yes, go to display it
    CMP AL,'Y'  ;char = 'Y'?
    JE THEN
    JMP ELSE_   ;no, terminate  
THEN:
    MOV AH,2    ;prepare to display
    MOV DL,AL   ;get char
    INT 21H     ;display it
    JMP ELSE_IF  ;and exit
ELSE_:
    MOV AH,4CH
    INT 21H     ;DOS exit
ELSE_IF:
MAIN ENDP
END MAIN