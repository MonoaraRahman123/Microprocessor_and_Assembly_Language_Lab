;Write a program to replace the number in AX by its absolute value (use branching structure).

.MODEL SMALL
.STACK 100H

.CODE

MAIN PROC
    
    MOV AX,-25  ;Example input
    
    CMP AX,0        ;Compare AX with 0
    JGE POSITIVE    ;If AX>=0,jump to POSITIVE
    
    NEG AX          ;If AX<0,AX=-AX

POSITIVE:                          

    MOV AH,4CH      ;Exit to DOS
    INT 21H
    
MAIN ENDP
    END MAIN