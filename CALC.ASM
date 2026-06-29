.model small
.stack 100h
;-----------------------------------------------------------------------------
;CONSTANTS
;----------------------------------------------------------------------------
FRAME_LEFT    EQU 11
FRAME_RIGHT   EQU 68
FRAME_TOP     EQU 4
FRAME_BOTTOM  EQU 20
FRAME_WIDTH   EQU 56

TITLE_ROW     EQU 5
TITLE_COL     EQU 32
               
DISP_LEFT     EQU 13
DISP_RIGHT    EQU 66
DISP_TOP      EQU 7
DISP_BOTTOM   EQU 9
DISP_WIDTH    EQU 52
              
;ROW 11       
BTN_HEX       EQU 0000H
BTN_BIN       EQU 0001H
BTN_DEC       EQU 0002H
BTN_FRC       EQU 0003H
BTN_MS        EQU 0004H
BTN_MR        EQU 0005H
BTN_MC        EQU 0006H
              
;ROW 13       
BTN_7         EQU 0100H
BTN_8         EQU 0101H
BTN_9         EQU 0102H
BTN_DIV       EQU 0103H
BTN_MOD       EQU 0104H
BTN_POW       EQU 0105H
BTN_CLR       EQU 0106H
              
;ROW 15       
BTN_4         EQU 0200H
BTN_5         EQU 0201H
BTN_6         EQU 0202H
BTN_MUL       EQU 0203H
BTN_SQR       EQU 0204H
BTN_ABS       EQU 0205H
BTN_CE        EQU 0206H

;ROW 17       
BTN_1         EQU 0300H
BTN_2         EQU 0301H
BTN_3         EQU 0302H
BTN_SUB       EQU 0303H
BTN_NEG       EQU 0304H
BTN_DEL       EQU 0305H
BTN_PCT       EQU 0306H

;ROW 19
BTN_00        EQU 0400H
BTN_0         EQU 0401H
BTN_DOT       EQU 0402H
BTN_SIGN      EQU 0403H
BTN_ADD       EQU 0404H
BTN_EQ        EQU 0405H

TOTAL_BUTTONS EQU 34


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

        selected_button  DW BTN_1

        ;BUTTON METADATA TABLE - 7 bytes per entry: ID[2], Row[1], Col[1], Lbl[2], Color[1]
        BTN_TABLE LABEL BYTE

        ;ROW 11

        DW BTN_HEX  
        DB 11, 13  
        DW OFFSET LBL_HEX  
        DB 8BH

        DW BTN_BIN  
        DB 11, 21  
        DW OFFSET LBL_BIN  
        DB 8BH

        DW BTN_DEC  
        DB 11, 29  
        DW OFFSET LBL_DEC  
        DB 8BH

        DW BTN_FRC  
        DB 11, 37  
        DW OFFSET LBL_FRC  
        DB 8BH

        DW BTN_MS   
        DB 11, 45  
        DW OFFSET LBL_MS   
        DB 8BH

        DW BTN_MR   
        DB 11, 53  
        DW OFFSET LBL_MR   
        DB 8BH

        DW BTN_MC   
        DB 11, 61  
        DW OFFSET LBL_MC   
        DB 8BH


        ;ROW 13 

        DW BTN_7    
        DB 13, 13  
        DW OFFSET LBL_7    
        DB 8FH

        DW BTN_8    
        DB 13, 21  
        DW OFFSET LBL_8    
        DB 8FH

        DW BTN_9    
        DB 13, 29  
        DW OFFSET LBL_9    
        DB 8FH

        DW BTN_DIV  
        DB 13, 37  
        DW OFFSET LBL_DIV  
        DB 8BH

        DW BTN_MOD  
        DB 13, 45  
        DW OFFSET LBL_MOD  
        DB 8BH

        DW BTN_POW  
        DB 13, 53  
        DW OFFSET LBL_POW  
        DB 8BH

        DW BTN_CLR  
        DB 13, 61  
        DW OFFSET LBL_CLR  
        DB 8BH

        
        ; ROW 15

        DW BTN_4    
        DB 15, 13  
        DW OFFSET LBL_4    
        DB 8FH

        DW BTN_5    
        DB 15, 21  
        DW OFFSET LBL_5    
        DB 8FH

        DW BTN_6    
        DB 15, 29  
        DW OFFSET LBL_6    
        DB 8FH

        DW BTN_MUL  
        DB 15, 37  
        DW OFFSET LBL_MUL  
        DB 8BH

        DW BTN_SQR  
        DB 15, 45  
        DW OFFSET LBL_SQR  
        DB 8BH

        DW BTN_ABS  
        DB 15, 53  
        DW OFFSET LBL_ABS  
        DB 8BH

        DW BTN_CE   
        DB 15, 61  
        DW OFFSET LBL_CE   
        DB 8BH

        
        ;ROW 17
        
        DW BTN_1    
        DB 17, 13  
        DW OFFSET LBL_1    
        DB 8FH

        DW BTN_2    
        DB 17, 21  
        DW OFFSET LBL_2    
        DB 8FH

        DW BTN_3    
        DB 17, 29  
        DW OFFSET LBL_3    
        DB 8FH

        DW BTN_SUB  
        DB 17, 37  
        DW OFFSET LBL_SUB  
        DB 8BH

        DW BTN_NEG  
        DB 17, 45  
        DW OFFSET LBL_NEG  
        DB 8BH

        DW BTN_DEL  
        DB 17, 53  
        DW OFFSET LBL_DEL  
        DB 8BH

        DW BTN_PCT  
        DB 17, 61  
        DW OFFSET LBL_PCT  
        DB 8BH

        
        ; ROW19
        
        DW BTN_00   
        DB 19, 13  
        DW OFFSET LBL_00   
        DB 8FH

        DW BTN_0    
        DB 19, 21  
        DW OFFSET LBL_0    
        DB 8FH

        DW BTN_DOT  
        DB 19, 29  
        DW OFFSET LBL_DOT  
        DB 8FH

        DW BTN_SIGN 
        DB 19, 37  
        DW OFFSET LBL_SIGN 
        DB 8BH

        DW BTN_ADD  
        DB 19, 45  
        DW OFFSET LBL_ADD  
        DB 8BH

        DW BTN_EQ   
        DB 19, 53  
        DW OFFSET LBL_EQ   
        DB 8BH  

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

DrawButton PROC
        PUSH AX
        PUSH BX
        PUSH DX
        PUSH SI

        ; READ ROW AND COL NUMBER FROM TABLE
        MOV DH, [SI+2]
        MOV DL, [SI+3]
        CALL SetCursor

        ;READ COLOUR FROM TABLE
        MOV BL, [SI+6]

        ;IF SELETCED 
        MOV AX, [SI]
        CMP AX, selected_button
        JNE NotSelected
        MOV BL, 30H

NotSelected:
        ;READ LABEL
        MOV SI, [SI+4]
        CALL PrintStringAttr

        POP SI
        POP DX
        POP BX
        POP AX
        RET
DrawButton ENDP

DrawButtons PROC
        PUSH CX
        PUSH SI

        LEA SI, BTN_TABLE
        MOV CX, TOTAL_BUTTONS

DrawButtonsLoop:
        CALL DrawButton
        ADD SI, 7
        LOOP DrawButtonsLoop

        POP SI
        POP CX
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

ActivateSelectedButton PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI

        LEA SI, BTN_TABLE
        MOV CX, TOTAL_BUTTONS
FindBtnLoop:
        MOV AX, [SI]         
        CMP AX, selected_button
        JE FoundBtn
        ADD SI, 7             
        LOOP FindBtnLoop
        JMP ActDone

FoundBtn:

        MOV DH, 6
        MOV DL, 13
        CALL SetCursor
        MOV SI, [SI+4]
        MOV BL, 8FH         
        CALL PrintStringAttr

ActDone:
        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        RET 
ActivateSelectedButton ENDP

HandleNormalChar PROC
        CMP AL, 0DH 
        JNE SkipActivate
        CALL ActivateSelectedButton
SkipActivate:
        RET

HandleNormalChar ENDP

HandleExtendedChar PROC
        PUSH AX
        PUSH BX
        PUSH DX
        PUSH SI

        CMP AH, 48H   ;UP
        JE NavUp
        CMP AH, 50H   ;DOWN
        JE NavDown
        CMP AH, 4BH   ;LEFT
        JE NavLeft
        CMP AH, 4DH   ;RIGHT
        JE NavRight
        
        JMP NavDone

NavDown:
        MOV AX, selected_button
        CMP AH, 4
        JE NavDone
        INC AH

        ;HANLDE '='
        CMP AH, 4
        JNE UpdateSelection
        CMP AL, 6
        JNE UpdateSelection
        MOV AL, 5
        JMP UpdateSelection

NavUp:
        MOV AX, selected_button
        CMP AH, 0
        JE NavDone
        DEC AH
        JMP UpdateSelection

NavLeft:
        MOV AX, selected_button
        CMP AL, 0
        JE NavDone
        DEC AL
        JMP UpdateSelection

NavRight:
        MOV AX, selected_button
        CMP AH, 4
        JE Row4
        CMP AL, 6
        JE NavDone
        INC AL
        JMP UpdateSelection

Row4:
        CMP AL, 5
        JE NavDone
        INC AL

UpdateSelection:
        MOV selected_button, AX
        CALL DrawButtons

NavDone:
        POP SI
        POP DX
        POP BX
        POP AX
        RET
HandleExtendedChar ENDP

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
        JE IsExtended
        CMP AL, 0E0H
        JE IsExtended

        CALL HandleNormalChar
        JMP MainLoop

IsExtended:
        CALL HandleExtendedChar
        JMP MainLoop

Exit:
        CALL ResetDos

        ;EXIT TO DOS
        MOV AH, 4CH
        MOV AL, 00H
        INT 21H 
MAIN ENDP

END MAIN


