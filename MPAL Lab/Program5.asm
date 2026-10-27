;Write a program to calculate the sum of two numbers.
.MODEL SMALL
.STACK 100H
.DATA
A DW 2
B DW 5
SUM DW ?
.CODE
MAIN PROC
    ;initialize DS
        MOV AX,@DATA
        MOV DS,AX
    ;dd the numbers
        MOV AX,A     ;AX has A
        ADD AX,B     ;AX has A+B
        MOV SUM,AX   ;SUM = A+B
    ;exit to DOS
        MOV AX,4C00H
        INT 21H
    MAIN ENDP
        END MAIN