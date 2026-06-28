.model small
.stack 100h
;-----------------------------------------------------------------------------
;CONSTANTS
;----------------------------------------------------------------------------


;-----------------------------------------------------------------------------
;DATA VARIABLES
;----------------------------------------------------------------------------
.DATA
         ;MSG DB 'Calculator starting. . . ',13,10,'$'
         MSG_TOP DB 'TOP LEFT$'
         MSG_MIDDLE DB 'MIDDLE$'
         MSG_BOTTOM DB 'NEAR BOTTOM$'

;-----------------------------------------------------------------------------
;CODE SEGMENT
;----------------------------------------------------------------------------
.code

;-----------------------------------------------------------------------------
;SCREEN ROUTINES
;----------------------------------------------------------------------------

ClearScreen PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX

        ;CLEAR SCREEN USING BIOS SCROLL
        MOV AH, 06H
        MOV AL, 00H
        MOV BH, 80H
        MOV CX, 0000H
        MOV DX, 184FH
        INT 10H

        ;MOV CURSOR TO 0,0
        MOV AH, 02H
        MOV BH, 00H
        MOV DH, 00H
        MOV DL, 00H
        INT 10H

        POP DX
        POP CX
        POP BX
        POP AX
        RET
ClearScreen ENDP

SetCursor PROC
        ;ROW(0-24)    ->DH
        ;COLUMN(0-19) ->DL
        PUSH AX
        PUSH BX

        MOV AH, 02H
        MOV BH, 00H
        INT 10H

        POP BX
        POP AX
        RET
SetCursor ENDP



;----------------------------------------------------------------------------
;KEYBOARD ROUTINES
;----------------------------------------------------------------------------


;----------------------------------------------------------------------------
;INPUT ROUTINES
;----------------------------------------------------------------------------


;----------------------------------------------------------------------------
;MATH ROUTINES
;----------------------------------------------------------------------------


;----------------------------------------------------------------------------
;FORMATTING ROUTINES
;----------------------------------------------------------------------------


;----------------------------------------------------------------------------
;CALCULATOR LOGIC
;----------------------------------------------------------------------------

;----------------------------------------------------------------------------
;ENTRY POINT
;----------------------------------------------------------------------------
MAIN PROC
        MOV AX, @DATA
        MOV DS, AX

        ;DISABLE BLINKING
        MOV AX, 1003H
        MOV BL, 00H
        INT 10H

        ;CLEAR SCREEN TO DARKGRAY
        CALL ClearScreen

        ;PRINT MESSAGE
        ;MOV AH, 09H
        ;LEA DX, MSG
        ;INT 21H

        ;TEST : TOP
        MOV DH, 0
        MOV DL, 0
        CALL SetCursor
        MOV AH, 09H
        LEA DX, MSG_TOP
        INT 21H

        ;TEST : MIDDLE
        MOV DH, 12
        MOV DL, 30
        CALL SetCursor
        MOV AH, 09H
        LEA DX, MSG_MIDDLE
        INT 21H

        ;TEST : BOTTOM
        MOV DH, 23
        MOV DL, 65
        CALL SetCursor
        MOV AH, 09H
        LEA DX, MSG_BOTTOM
        INT 21H




        ;WAIT FOR KEYPRESS
        MOV AH, 00H
        INT 16H

        ;EXIT TO DOS
        MOV AH, 4CH
        MOV AL, 00H
        INT 21H
MAIN ENDP

END MAIN


