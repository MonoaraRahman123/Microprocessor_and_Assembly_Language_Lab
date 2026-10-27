;Read a character, and it's an uppercase letter, display it (use AND conditions).

.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC 
;read a character
    MOV AH,1     ;prepare to read.
    INT 21H      ;char in AL
;if ('A' <= char) and (char <= 'Z')
    CMP AL,'A'   ;char>='A'?
    JNGE END_IF  ;no, exit
    CMP AL,'Z'   ;char<='Z'?
    JNLE END_IF  ;no, exit
;then display char
    MOV DL,AL    ;get char
    MOV AH,2     ;prepare to display
    INT 21H      ;display char
    
END_IF:

MAIN ENDP
    END MAIN