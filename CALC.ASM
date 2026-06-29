.model small
.stack 100h
;-----------------------------------------------------------------------------
;CONSTANTS
;----------------------------------------------------------------------------
FRAME_LEFT   EQU 11
FRAME_RIGHT  EQU 68
FRAME_TOP    EQU 4
FRAME_BOTTOM EQU 20
FRAME_WIDTH  EQU 56

TITLE_ROW    EQU 5
TITLE_COL    EQU 32

DISP_LEFT    EQU 13
DISP_RIGHT   EQU 66
DISP_TOP     EQU 7
DISP_BOTTOM  EQU 9
DISP_WIDTH   EQU 52

;-----------------------------------------------------------------------------
;DATA VARIABLES
;----------------------------------------------------------------------------
.DATA
        ;MSG             DB 'Calculator starting. . . ',13,10,'$'

        ;MSG_TOP         DB 'TOP LEFT$'
        ;MSG_MIDDLE      DB 'MIDDLE$'
        ;MSG_BOTTOM      DB 'NEAR BOTTOM$'

        ;MSG_NUMS        DB '7 8 9 / 4 5 6 * $'

        MSG_TITLE        DB '8086 CALCULATOR$'
        MSG_INITIAL_VAL  DB '0.00$'

        ;ROW 11
        LBL_HEX          DB '[HEX]$'
        LBL_BIN          DB '[BIN]$'
        LBL_DEC          DB '[DEC]$'
        LBL_FRC          DB '[FRC]$'
        LBL_MS           DB '[MS ]$'
        LBL_MR           DB '[MR ]$'
        LBL_MC           DB '[MC ]$'

        ;ROW 13
        LBL_7            DB '[ 7 ]$'
        LBL_8            DB '[ 8 ]$'
        LBL_9            DB '[ 9 ]$'
        LBL_DIV          DB '[ / ]$'
        LBL_MOD          DB '[MOD]$'
        LBL_POW          DB '[POW]$'
        LBL_CLR          DB '[CLR]$'

        ;ROW 15
        LBL_4            DB '[ 4 ]$'
        LBL_5            DB '[ 5 ]$'
        LBL_6            DB '[ 6 ]$'
        LBL_MUL          DB '[ * ]$'
        LBL_SQR          DB '[SQR]$'
        LBL_ABS          DB '[ABS]$'
        LBL_CE           DB '[CE ]$'

        ;ROW 17
        LBL_1            DB '[ 1 ]$'
        LBL_2            DB '[ 2 ]$'
        LBL_3            DB '[ 3 ]$'
        LBL_SUB          DB '[ - ]$'
        LBL_NEG          DB '[NEG]$'
        LBL_DEL          DB '[DEL]$'
        LBL_PCT          DB '[ % ]$'

        ;ROW 19
        LBL_SIGN         DB '[+/-]$'
        LBL_0            DB '[ 0 ]$'
        LBL_00           DB '[00 ]$'
        LBL_DOT          DB '[ . ]$'
        LBL_ADD          DB '[ + ]$'
        LBL_EQ           DB '[     =     ]$'
       
        MSG_UP           DB 'UP $'
        MSG_DN           DB 'DN $'
        MSG_LT           DB 'LT $'
        MSG_RT           DB 'RT $'
        

;-----------------------------------------------------------------------------
;CODE SEGMENT
;----------------------------------------------------------------------------
.code

;-----------------------------------------------------------------------------
;SCREEN ROUTINES
;----------------------------------------------------------------------------

ResetDOS PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX

        ;SET SCREEN TO DEFAULT
        MOV AH, 06H
        MOV AL, 00H
        MOV BH, 07H
        MOV CX, 0000H
        MOV DX, 184FH
        INT 10H

        ;CURSOR TO 0,0
        MOV AH, 02H
        MOV BH, 00H
        MOV DH, 00H
        MOV DL, 00H
        INT 10H

        ;RESTORE BLINKING
        MOV AX, 1003H
        MOV BL, 01H
        INT 10H

        POP DX
        POP CX
        POP BX
        POP  AX
        RET
ResetDOS ENDP

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

PrintCharAttr PROC
        ;AL <- ASCII CHARACTER
        ;BL <- COLOUR ATTRIBUTE
        ;CX <- REPEAT COUNT
        PUSH AX
        PUSH BX
        PUSH CX

        MOV AH, 09H
        MOV BH, 00H
        INT 10H

        POP CX
        POP BX
        POP AX
        RET
PrintCharAttr ENDP

PrintStringAttr PROC
        ;SI <- POINTER TO STRING
        ;BL <- COLOUR ATTRIBUTE
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI

PrintStringLoop:
        MOV AL, [SI]
        CMP AL, '$'
        JE PrintStringEnd

        INC SI

        MOV CX, 1
        CALL PrintCharAttr

        ;GET CURSUR POSITION
        MOV AH, 03H
        MOV BH, 00H
        INT 10H

        INC DL
        CALL SetCursor

        JMP PrintStringLoop
PrintStringEnd:
        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
PrintStringAttr ENDP

DrawFrame PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX

        ; TOP BORDER
        MOV DH, FRAME_TOP
        MOV DL, FRAME_LEFT
        CALL SetCursor

        MOV AL, 201 ; DOUBLE LINE TOP LEFT CORNER
        MOV BL, 8BH
        MOV CX, 1
        CALL PrintCharAttr

        INC DL
        CALL SetCursor
        MOV AL, 205 ; DOUBLE LINE HORIZONTAL
        MOV CX, FRAME_WIDTH
        CALL PrintCharAttr

        MOV DL, FRAME_RIGHT
        CALL SetCursor
        MOV AL, 187 ; DOUBLE LINE TOP RIGHT CORNER
        MOV CX, 1
        CALL PrintCharAttr

        ; SIDE BORDERS
        MOV DH, FRAME_TOP+1
DrawSideLoop:
        CMP DH, FRAME_BOTTOM
        JGE DrawBottomBorder

        MOV DL, FRAME_LEFT
        CALL SetCursor
        MOV AL, 186 ;   DOUBLE LINE VERTICAL
        MOV CX, 1
        CALL PrintCharAttr

        MOV DL, FRAME_RIGHT
        CALL SetCursor
        MOV AL, 186 ;   DOUBLE LINE VERTICAL
        MOV CX, 1
        CALL PrintCharAttr

        INC DH
        JMP DrawSideLoop
DrawBottomBorder:
        ; BOTTOM BORDER
        MOV DH, FRAME_BOTTOM
        MOV DL, FRAME_LEFT
        CALL SetCursor

        MOV AL, 200 ; DOUBLE LINE BOTTOM LEFT CORNER
        MOV BL, 8BH
        MOV CX, 1
        CALL PrintCharAttr

        INC DL
        CALL SetCursor
        MOV AL, 205 ; DOUBLE LINE HORIZONTAL
        MOV CX, FRAME_WIDTH
        CALL PrintCharAttr

        MOV DL, FRAME_RIGHT
        CALL SetCursor
        MOV AL, 188 ; DOUBLE LINE BOTTOM RIGHT CORNER
        MOV CX, 1
        CALL PrintCharAttr

        POP DX
        POP CX
        POP BX
        POP AX
        RET
DrawFrame ENDP

DrawTitle PROC
        PUSH AX
        PUSH BX
        PUSH DX
        PUSH SI

        MOV DH, TITLE_ROW
        MOV DL, TITLE_COL
        CALL SetCursor

        LEA SI, MSG_TITLE
        MOV BL, 8BH
        CALL PrintStringAttr

        POP SI
        POP DX
        POP BX
        POP AX
        RET
DrawTitle ENDP


DrawDisplay PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI

        ; TOP BORDER
        MOV DH, DISP_TOP
        MOV DL, DISP_LEFT
        CALL SetCursor

        MOV AL, 218 ;SINGLE LINE TOP LEFT CORNER
        MOV BL, 8BH
        MOV CX, 1
        CALL PrintCharAttr

        INC DL
        CALL SetCursor
        MOV AL, 196 ; SINGLE LINE HORIZONTAL
        MOV CX, DISP_WIDTH
        CALL PrintCharAttr

        MOV DL, DISP_RIGHT
        CALL SetCursor
        MOV AL, 191 ; SINGLE LINE TOP RIGHT CORNER
        MOV CX, 1
        CALL PrintCharAttr

        ; SIDE BORDERS
        MOV DH, DISP_TOP+1

        MOV DL, DISP_LEFT
        CALL SetCursor
        MOV AL, 179 ;   SINGLE LINE VERTICAL
        MOV CX, 1
        CALL PrintCharAttr

        MOV DL, DISP_RIGHT
        CALL SetCursor
        MOV AL, 179 ;   SINGLE LINE VERTICAL
        MOV CX, 1
        CALL PrintCharAttr

        ; BOTTOM BORDER
        MOV DH, DISP_BOTTOM
        MOV DL, DISP_LEFT
        CALL SetCursor

        MOV AL, 192 ; SINGLE LINE BOTTOM LEFT CORNER
        MOV BL, 8BH
        MOV CX, 1
        CALL PrintCharAttr

        INC DL
        CALL SetCursor
        MOV AL, 196 ; SINGLE LINE HORIZONTAL
        MOV CX, DISP_WIDTH
        CALL PrintCharAttr

        MOV DL, DISP_RIGHT
        CALL SetCursor
        MOV AL, 217 ; SINGLE LINE BOTTOM RIGHT CORNER
        MOV CX, 1
        CALL PrintCharAttr

        ;INITIAL DISPLAY
        MOV DH, DISP_TOP+1
        MOV DL, DISP_RIGHT-5
        CALL SetCursor
        LEA SI, MSG_INITIAL_VAL
        MOV BL, 8FH
        CALL PrintStringAttr

        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
DrawDisplay ENDP

DrawButtons PROC
        PUSH AX
        PUSH BX
        PUSH DX
        PUSH SI

        ; ROW 11
        MOV DH, 11

        MOV DL, 13
        CALL SetCursor
        LEA SI, LBL_HEX
        MOV BL, 8BH
        CALL PrintStringAttr

        MOV DL, 21
        CALL SetCursor
        LEA SI, LBL_BIN
        MOV BL, 8BH
        CALL PrintStringAttr

        MOV DL, 29
        CALL SetCursor
        LEA SI, LBL_DEC
        MOV BL, 8BH
        CALL PrintStringAttr

        MOV DL, 37
        CALL SetCursor
        LEA SI, LBL_FRC
        MOV BL, 8BH
        CALL PrintStringAttr

        MOV DL, 45
        CALL SetCursor
        LEA SI, LBL_MS
        MOV BL, 8BH
        CALL PrintStringAttr

        MOV DL, 53
        CALL SetCursor
        LEA SI, LBL_MR
        MOV BL, 8BH
        CALL PrintStringAttr

        MOV DL, 61
        CALL SetCursor
        LEA SI, LBL_MC
        MOV BL, 8BH
        CALL PrintStringAttr

        ; ROW 13
        MOV DH, 13

        MOV DL, 13
        CALL SetCursor
        LEA SI, LBL_7
        MOV BL, 8FH
        CALL PrintStringAttr

        MOV DL, 21
        CALL SetCursor
        LEA SI, LBL_8
        MOV BL, 8FH
        CALL PrintStringAttr

        MOV DL, 29
        CALL SetCursor
        LEA SI, LBL_9
        MOV BL, 8FH
        CALL PrintStringAttr

        MOV DL, 37
        CALL SetCursor
        LEA SI, LBL_DIV
        MOV BL, 8BH
        CALL PrintStringAttr

        MOV DL, 45
        CALL SetCursor
        LEA SI, LBL_MOD
        MOV BL, 8BH
        CALL PrintStringAttr

        MOV DL, 53
        CALL SetCursor
        LEA SI, LBL_POW
        MOV BL, 8BH
        CALL PrintStringAttr

        MOV DL, 61
        CALL SetCursor
        LEA SI, LBL_CLR
        MOV BL, 8BH
        CALL PrintStringAttr

        ; ROW 15
        MOV DH, 15

        MOV DL, 13
        CALL SetCursor
        LEA SI, LBL_4
        MOV BL, 8FH
        CALL PrintStringAttr

        MOV DL, 21
        CALL SetCursor
        LEA SI, LBL_5
        MOV BL, 8FH
        CALL PrintStringAttr

        MOV DL, 29
        CALL SetCursor
        LEA SI, LBL_6
        MOV BL, 8FH
        CALL PrintStringAttr

        MOV DL, 37
        CALL SetCursor
        LEA SI, LBL_MUL
        MOV BL, 8BH
        CALL PrintStringAttr

        MOV DL, 45
        CALL SetCursor
        LEA SI, LBL_SQR
        MOV BL, 8BH
        CALL PrintStringAttr

        MOV DL, 53
        CALL SetCursor
        LEA SI, LBL_ABS
        MOV BL, 8BH
        CALL PrintStringAttr

        MOV DL, 61
        CALL SetCursor
        LEA SI, LBL_CE
        MOV BL, 8BH
        CALL PrintStringAttr

        ; ROW 17
        MOV DH, 17

        MOV DL, 13
        CALL SetCursor
        LEA SI, LBL_1
        MOV BL, 8FH
        CALL PrintStringAttr

        MOV DL, 21
        CALL SetCursor
        LEA SI, LBL_2
        MOV BL, 8FH
        CALL PrintStringAttr

        MOV DL, 29
        CALL SetCursor
        LEA SI, LBL_3
        MOV BL, 8FH
        CALL PrintStringAttr

        MOV DL, 37
        CALL SetCursor
        LEA SI, LBL_SUB
        MOV BL, 8BH
        CALL PrintStringAttr

        MOV DL, 45
        CALL SetCursor
        LEA SI, LBL_NEG
        MOV BL, 8BH
        CALL PrintStringAttr

        MOV DL, 53
        CALL SetCursor
        LEA SI, LBL_DEL
        MOV BL, 8BH
        CALL PrintStringAttr

        MOV DL, 61
        CALL SetCursor
        LEA SI, LBL_PCT
        MOV BL, 8BH
        CALL PrintStringAttr
        
        ; ROW 19
        MOV DH, 19

        MOV DL, 13
        CALL SetCursor
        LEA SI, LBL_00
        MOV BL, 8FH
        CALL PrintStringAttr

        MOV DL, 21
        CALL SetCursor
        LEA SI, LBL_0
        MOV BL, 8FH
        CALL PrintStringAttr

        MOV DL, 29
        CALL SetCursor
        LEA SI, LBL_DOT
        MOV BL, 8FH
        CALL PrintStringAttr

        MOV DL, 37
        CALL SetCursor
        LEA SI, LBL_SIGN
        MOV BL, 8BH
        CALL PrintStringAttr

        MOV DL, 45
        CALL SetCursor
        LEA SI, LBL_ADD
        MOV BL, 8BH
        CALL PrintStringAttr

        MOV DL, 53
        CALL SetCursor
        LEA SI, LBL_EQ
        MOV BL, 8BH
        CALL PrintStringAttr

        POP SI
        POP DX
        POP BX
        POP AX
        RET
DrawButtons ENDP
       
;----------------------------------------------------------------------------
;KEYBOARD ROUTINES
;----------------------------------------------------------------------------
ReadKeY PROC
        ;AL <- ASCII CHARACTER
        ;AH <- KEYBOARD SCAN CODE

        MOV AH, 00H
        INT 16H
        RET
ReadKey ENDP

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
        ;MOV DH, 0
        ;MOV DL, 0
        ;CALL SetCursor
        ;MOV AH, 09H
        ;LEA DX, MSG_TOP
        ;INT 21H

        ;TEST : MIDDLE
        ;MOV DH, 12
        ;MOV DL, 30
        ;CALL SetCursor
        ;MOV AH, 09H
        ;LEA DX, MSG_MIDDLE
        ;INT 21H

        ;TEST : BOTTOM
        ;MOV DH, 23
        ;MOV DL, 65
        ;CALL SetCursor
        ;MOV AH, 09H
        ;LEA DX, MSG_BOTTOM
        ;INT 21H

        ;TEST : SINGLE RED 'X' GARKGRAY BACKGOUND
        ;MOV DH, 5
        ;MOV DL, 10
        ;CALL SetCursor
        
        ;MOV AL, 'X'
        ;MOV BL, 84H
        ;MOV CX, 1
        ;CALL PrintCharAttr

        ;TEST : REPEAT CYAN '@' 20 TIMES BLACK BACKGROUND
        ;MOV DH, 7
        ;MOV DL, 10
        ;CALL SetCursor

        ;MOV AL, '@'
        ;MOV BL, 0BH
        ;MOV CX, 20
        ;CALL PrintCharAttr

        ;TEST : CYAN TITLE DARKGRAY BACKGROUND
        ;MOV DH, 2
        ;MOV DL, 15
        ;CALL SetCursor
        ;LEA SI, MSG_TITLE
        ;MOV BL, 8BH
        ;CALL PrintStringAttr

        ;TEST : DUMMY BUTTON WHITE ON DARKGRAY
        ;MOV DH, 5
        ;MOV DL, 15
        ;CALL SetCursor
        ;LEA SI, MSG_NUMS
        ;MOV BL, 8FH
        ;CALL PrintStringAttr

        ;DRAW KEYBOARD
        CALL DrawFrame
        CALL DrawTitle
        CALL DrawDisplay
        CALL DrawButtons
MainLoop:
        CALL ReadKEY

        ; IF ESC EXIT
        CMP AL, 1BH
        JE Exit

        ; CHECK FOR SPECIAL KEY / EXTENDED
        CMP AL, 00H
        JE CheckSpecial
        CMP AL, 0E0H
        JE CheckSpecial

        ;PRINT CHARATER
        PUSH AX
        MOV DH, DISP_TOP-1
        MOV DL, DISP_RIGHT-30
        CALL SetCursor
        POP AX

        MOV BL, 8FH
        MOV CX, 1
        CALL PrintCharAttR

        JMP MainLoop

CheckSpecial:
        CMP AH, 48H   ;UP
        JE HandleUp
        CMP AH, 50H   ;DOWN
        JE HandleDown
        CMP AH, 4BH   ;LEFT
        JE HandleLeft
        CMP AH, 4DH   ;RIGHT
        JE HandleRight

        JMP MainLoop

HandleUp:
        MOV DH, DISP_TOP-1
        MOV DL, DISP_RIGHT-30
        CALL SetCursor
        LEA SI, MSG_UP
        MOV BL, 8BH
        CALL PrintStringAttr

        JMP MainLoop

HandleDown:
        MOV DH, DISP_TOP-1
        MOV DL, DISP_RIGHT-30
        CALL SetCursor
        LEA SI, MSG_DN
        MOV BL, 8BH
        CALL PrintStringAttr

        JMP MainLoop

Handleleft:
        MOV DH, DISP_TOP-1
        MOV DL, DISP_RIGHT-30
        CALL SetCursor
        LEA SI, MSG_LT
        MOV BL, 8BH
        CALL PrintStringAttr

        JMP MainLoop

HandleRight:
        MOV DH, DISP_TOP-1
        MOV DL, DISP_RIGHT-30
        CALL SetCursor
        LEA SI, MSG_RT
        MOV BL, 8BH
        CALL PrintStringAttr

        JMP MainLoop

Exit:
        CALL ResetDos

        ;EXIT TO DOS
        MOV AH, 4CH
        MOV AL, 00H
        INT 21H 
MAIN ENDP

END MAIN


