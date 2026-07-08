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
        
        MSG_ERR_DIGITS   DB 'MAX 8 DIGITS ALLOWED$'
        MSG_ERR_DECIMAL  DB 'ONLY ONE . ALLOWED$'
        MSG_ERR_PLACES   DB 'MAX 2 DEC PLACES$'
        MSG_ERR_OVERFLOW DB 'ERROR: OVERFLOW$'
        MSG_ERR_DIVZERO  DB 'ERROR: DIV BY ZERO$'
        MSG_ERR_NOREPEAT DB 'ERROR: NO REPEATED SPECIAL OPERATOR$'

        MSG_HINT_KEYS    DB 'Press [H] Help         Press [ESC] to Exit$'
        MSG_HINT_ERR     DB 'Press [CLR] Continue   [0-9] New Number$'

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


        current_input_low   DW 0       ; LOWER 16 BITS
        current_input_high  DW 0       ; UPPER 16 BITS
        input_active        DB 0       ; TYPING -> 1, DISPLAYING -> 0
        input_negative      DB 0       ; NEGATIVE -> 1, POSITIVE -> 0
        decimal_entered     DB 0       ; DECIMAL -> 1, OTHERWISE ->0
        decimal_count       DB 0       ; DIGITS AFTER DECIMAL
        digit_count         DB 0       ; DIGITS BEFORE DECIMAL

        display_buffer      DB 16 DUP('$')

        mod_temp_low        DW 0
        mod_temp_high       DW 0
        error_flag          DB 0       ; OVERFLOW/DIV-BY-ZERO ERROR FLAG -> 1
        accumulator_low     DW 0       ; LOWER 16 BIT OF ACCUMULATOR 
        accumulator_high    DW 0       ; UPPER 16 BIT OF ACCUMULATOR
        pending_operator    DW 0       ; BUTTON ID OF PENDING OPERATION
        last_operator       DW 0       ; BUTTON ID OF LAST OPERATION
        last_operand_low    DW 0       ; LOWER 16 BIT OF LAST OPERAND
        last_operand_high   DW 0       ; UPPER 16 BIT OF LAST OPERAND

        temp_x_low          DW 0       ; FOR MULTIPLY AND DIVIDE     
        temp_x_high         DW 0       ; FOR MULTIPLY AND DIVIDE
        temp_y_low          DW 0       ; FOR MULTIPLY AND DIVIDE
        temp_y_high         DW 0       ; FOR MULTIPLY AND DIVIDE

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
        ;BL <- COLOR ATTRIBUTE
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
        ;BL <- COLOR ATTRIBUTE
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

        ;GET CURSOR POSITION
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

DrawHintLine PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI

        MOV DH, 21
        MOV DL, FRAME_LEFT
        CALL SetCursor
        MOV AL, ' '
        MOV BL, 80H
        MOV CX, 58
        CALL PrintCharAttr

        MOV DH, 22
        MOV DL, FRAME_LEFT
        CALL SetCursor
        MOV AL, ' '
        MOV BL, 80H
        MOV CX, 58
        CALL PrintCharAttr

        CMP error_flag, 0
        JE  HintNormal

        MOV DH, 21
        MOV DL, FRAME_LEFT
        CALL SetCursor
        LEA SI, MSG_HINT_ERR
        MOV BL, 8CH             
        CALL PrintStringAttr

        MOV DH, 22
        MOV DL, FRAME_LEFT
        CALL SetCursor
        LEA SI, MSG_HINT_KEYS
        MOV BL, 87H            
        CALL PrintStringAttr
        JMP HintDone
HintNormal:
        
        MOV DH, 21
        MOV DL, FRAME_LEFT
        CALL SetCursor
        LEA SI, MSG_HINT_KEYS
        MOV BL, 87H             
        CALL PrintStringAttr
HintDone:
        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
DrawHintLine ENDP

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

        CALL DrawOperatorIndicator

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

        CALL DrawHintLine
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

        ;READ COLOR FROM TABLE
        MOV BL, [SI+6]

        ;IF SELECTED 
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
        CMP selected_button, BTN_00
        JNE CheckCLRBtn
        
        MOV AL, '0'
        CALL AddDigit
        MOV AL, '0'
        CALL AddDigit
        JMP ActDone
CheckCLRBtn:
        CMP selected_button, BTN_CLR
        JNE CheckCEBtn
        CALL ClearAll
        JMP ActDone
CheckCEBtn:                         
        CMP selected_button, BTN_CE
        JNE CheckSignBtn              
        CALL ClearEntry
        JMP ActDone
CheckSignBtn:
        CMP selected_button, BTN_SIGN
        JNE NotSignBtn
        
        CALL ToggleSign     
        JMP ActDone
NotSignBtn:
        CMP selected_button, BTN_DEL
        JNE NotDelBtn
        CALL DeleteDigit
        JMP ActDone
NotDelBtn:
        CMP selected_button, BTN_NEG
        JNE NotNEGBtn
        CALL ProcessNEG
        JMP ActDone
NotNEGBtn:
        CMP selected_button, BTN_ABS
        JNE NotABSBtn
        CALL ProcessABS
        JMP ActDone
NotABSBtn:
        CMP selected_button, BTN_PCT
        JNE NotPCTBtn
        CALL ProcessPCT
        JMP ActDone
NotPCTBtn:
        CMP selected_button, BTN_ADD
        JE OpBtn
        CMP selected_button, BTN_SUB
        JE OpBtn
        CMP selected_button, BTN_EQ
        JE EqBtn
        CMP selected_button, BTN_MUL
        JE OpBtn
        CMP selected_button, BTN_DIV
        JE OpBtn
        CMP selected_button, BTN_MOD
        JE OpBtn
        JMP ProceedToLabelCheck
OpBtn:
        MOV AX, selected_button
        CALL ProcessOperator
        JMP ActDone
EqBtn:
        CALL ProcessEquals
        JMP ActDone
ProceedToLabelCheck:
        MOV SI, [SI+4]
        MOV AL, [SI+2]

        CMP AL, '.'
        JNE NotDotBtn
        CALL AddDecimalPoint
        JMP ActDone
NotDotBtn:
        CMP AL, '0'
        JB ActDone
        CMP AL, '9'
        JA ActDone

        CALL AddDigit
ActDone:
        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        RET 
ActivateSelectedButton ENDP

HandleNormalChar PROC

        CMP AL, 08H         ; BACK SPACE
        JNE NotBackspace
        CALL DeleteDigit
        RET
NotBackspace:
        CMP AL, '+'
        JNE NotPlusKey
        MOV AX, BTN_ADD
        CALL ProcessOperator
        RET
NotPlusKey:
        CMP AL, '-'
        JNE NotMinusKey
        MOV AX, BTN_SUB
        CALL ProcessOperator
        RET
NotMinusKey:
        CMP AL, '*'
        JNE NotMulKey
        MOV AX, BTN_MUL
        CALL ProcessOperator
        RET
NotMulKey:
        CMP AL, '/'
        JNE NotDivKey
        MOV AX, BTN_DIV
        CALL ProcessOperator
NotDivKey:
        CMP AL, '='
        JNE NotEqualKey
        CALL ProcessEquals
        RET
NotEqualKey:
        CMP AL, '.'
        JNE NotDotKey
        CALL AddDecimalPoint
        RET
NotDotKey:        
        CMP AL, '0'
        JB CheckEnter
        CMP AL, '9'
        JA CheckEnter
        CALL AddDigit       
        RET 
CheckEnter:
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

        ;HANDLE '='
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
AddDigit PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI

        CMP error_flag, 0
        JE  AddDigit_NoError
        PUSH AX             
        CALL ClearAll
        POP AX 
AddDigit_NoError:
        SUB AL, '0'
        MOV AH, 0
        PUSH AX

        CMP input_active, 0
        JNE DigitActive

        MOV current_input_low, 0
        MOV current_input_high, 0
        MOV input_negative, 0
        MOV decimal_entered, 0
        MOV decimal_count, 0
        MOV digit_count, 0
        MOV input_active, 1
DigitActive:
        CMP decimal_entered, 0
        JNE AddFractionalDigit

        CMP digit_count, 8
        JB AllowIntDigit
        POP CX             
        LEA SI, MSG_ERR_DIGITS
        CALL ShowTempError  
        JMP AddDigitDone
AllowIntDigit:
        LEA SI, current_input_low
        CALL Mul32By10
        
        POP CX                 ; CX = numeric digit value (0..9)
        MOV AX, CX
        MOV CX, 100
        MUL CX                 ; DX:AX = digit * 100
        
        ADD current_input_low, AX
        ADC current_input_high, DX
        INC digit_count
        JMP AddDigitDone
AddFractionalDigit:

        CMP decimal_count, 2
        JB ProcessFractional
        
        POP CX              
        LEA SI, MSG_ERR_PLACES
        CALL ShowTempError
        JMP AddDigitDone
ProcessFractional:
        POP CX              
        CMP decimal_count, 0
        JNE SecondDecimalPlace

        ; FIRST DECIMAL IS MULTIPLY BY 10
        MOV AX, CX
        MOV CX, 10
        MUL CX              
        
        ADD current_input_low, AX
        ADC current_input_high, 0
        MOV decimal_count, 1
        JMP AddDigitDone
SecondDecimalPlace:
        ; SECOND DECIMAL AS IT IS
        ADD current_input_low, CX
        ADC current_input_high, 0
        MOV decimal_count, 2
        JMP AddDigitDone
AddDigitDone:
        CALL UpdateDisplay
        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
AddDigit ENDP


AddDecimalPoint PROC
        PUSH AX
        PUSH SI

        CMP error_flag, 0
        JE  AddDecimal_NoError
        CALL ClearAll
AddDecimal_NoError:
        CMP input_active, 0
        JNE DecimalActive

        MOV current_input_low, 0
        MOV current_input_high, 0
        MOV input_negative, 0
        MOV decimal_entered, 1
        MOV decimal_count, 0
        MOV digit_count, 0
        MOV input_active, 1
        CALL UpdateDisplay
        JMP DecDone
DecimalActive:
        CMP decimal_entered, 1
        JNE SetDecimal
        
        LEA SI, MSG_ERR_DECIMAL
        CALL ShowTempError
        JMP DecDone
SetDecimal:
        MOV decimal_entered, 1
DecDone:
        POP SI
        POP AX
        RET
AddDecimalPoint ENDP

ToggleSign PROC
        PUSH AX
        
        CMP input_active, 1
        JE ToggleActiveInput

        ; NUMBER IN MEMORY
        LEA SI, current_input_low
        CALL Neg32
        JMP ToggleDone
ToggleActiveInput:
        MOV AX, current_input_low
        OR AX, current_input_high
        JZ ToggleDone

        ; NUMBER IN INPUT
        XOR input_negative, 1
ToggleDone:
        CALL UpdateDisplay  
        POP AX
        RET
ToggleSign ENDP

DeleteDigit PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI
        PUSH DI

        CMP input_active, 1
        JE StartDel
        JMP DelDone
StartDel:
        CMP decimal_entered, 1
        JNE DeleteIntegerDigit

        CMP decimal_count, 2
        JE DelHundredths
        CMP decimal_count, 1
        JE DelTenths

        MOV decimal_entered, 0
        JMP DelDone
DelHundredths:
        LEA SI, current_input_low
        CALL Div32By10
        CALL Mul32By10
        MOV decimal_count, 1
        JMP DelDone
DelTenths:
        LEA SI, current_input_low
        CALL Div32By100
        CALL Mul32By100
        MOV decimal_entered, 0
        MOV decimal_count, 0
        JMP DelDone
DeleteIntegerDigit:
        CMP digit_count, 0
        JE DelDone

        LEA SI, current_input_low
        CALL Div32By1000
        CALL Mul32By100
        DEC digit_count

        MOV AX, current_input_low
        OR AX, current_input_high
        JNZ DelDone
        MOV input_negative, 0   
DelDone:
        CALL UpdateDisplay
        POP DI
        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
DeleteDigit ENDP

ClearEntry PROC

        MOV current_input_low, 0
        MOV current_input_high, 0
        MOV input_active, 0
        MOV input_negative, 0
        MOV decimal_entered, 0
        MOV decimal_count, 0
        MOV digit_count, 0
        
        CALL UpdateDisplay  
        RET
ClearEntry ENDP

ClearAll PROC
        CALL ClearEntry  

        MOV accumulator_low, 0
        MOV accumulator_high, 0
        MOV pending_operator, 0
        MOV last_operator, 0
        MOV last_operand_low, 0
        MOV last_operand_high, 0
        MOV error_flag, 0

        CALL UpdateDisplay
        
        RET
ClearAll ENDP

ShowTempError PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI
        
        ;CLEAR DISPLAY
        MOV DH, 8
        MOV DL, 45
        CALL SetCursor
        MOV AL, ' '
        MOV BL, 8FH
        MOV CX, 21
        CALL PrintCharAttr
        
        ;PRINT ERROR
        MOV DH, 8
        MOV DL, 45
        CALL SetCursor
        MOV BL, 8CH         
        CALL PrintStringAttr
        
        ; 1 SECOND DELAY
        MOV CX, 000FH       
        MOV DX, 4240H       
        MOV AH, 86H
        INT 15H

        ; RESTORE DISPLAY
        CALL UpdateDisplay
        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
ShowTempError ENDP

;----------------------------------------------------------------------------
;MATH ROUTINES
;----------------------------------------------------------------------------

Clear32 PROC
        ;CLEAR 32 BIT AT DS:SI
        PUSH AX
        MOV AX, 0
        MOV [SI], AX
        MOV [SI+2], AX
        POP AX
        RET
Clear32 ENDP

Copy32 PROC
        ;32 BITS DS:SI -> DS:DI
        PUSH AX
        MOV AX, [SI]
        MOV [DI], AX
        MOV AX, [SI+2]
        MOV [DI+2], AX
        POP AX
        RET
Copy32 ENDP

Cmp32 PROC
        ; COMPARE 32 BIT VARIABLE AT [SI] TO VARIABLE AT [DI]
        ; SET FLAGS SO CONDITIONAL JUMP WORKS
        MOV AX, [SI+2]
        CMP AX, [DI+2]
        JNE Cmp32_Done
        
        MOV AX, [SI]
        CMP AX, [DI]
        JE Cmp32_Done         ; EQUAL
        JA Cmp32_Greater
        
        ; LESS
        MOV AL, 80H
        OR AL, AL
        RET
Cmp32_Greater:
        ; HIGH
        MOV AL, 01H
        OR AL, AL
Cmp32_Done:
        RET
Cmp32 ENDP

Add32 PROC
        ; [SI] = [SI] + [DI]
        ; error_flag -> 1 WHEN OVERFLOW
        PUSH AX
        PUSH DX
        
        MOV AX, [SI]
        ADD AX, [DI]
        MOV DX, [SI+2]
        ADC DX, [DI+2]
        
        JO Add32_Overflow
        
        MOV [SI], AX
        MOV [SI+2], DX
        JMP Add32_Done       
Add32_Overflow:
        MOV error_flag, 1
Add32_Done:
        POP DX
        POP AX
        RET
Add32 ENDP

Sub32 PROC
        ; [SI] = [SI] - [DI]
        ; error_flag = 1 WHEN OVERFLOW
        PUSH AX
        PUSH DX
        
        MOV AX, [SI]
        SUB AX, [DI]
        MOV DX, [SI+2]
        SBB DX, [DI+2]
        
        JO Sub32_Overflow
        
        MOV [SI], AX
        MOV [SI+2], DX
        JMP Sub32_Done        
Sub32_Overflow:
        MOV error_flag, 1
Sub32_Done:
        POP DX
        POP AX
        RET
Sub32 ENDP

Neg32 PROC
        PUSH AX
        
        NOT WORD PTR [SI]
        NOT WORD PTR [SI+2]
        
        ADD WORD PTR [SI], 1
        ADC WORD PTR [SI+2], 0
        
        JO Neg32_Overflow
        JMP Neg32_Done  
Neg32_Overflow:
        MOV error_flag, 1
Neg32_Done:
        POP AX
        RET
Neg32 ENDP

Abs32 PROC 
        TEST WORD PTR [SI+2], 8000H  
        JZ Abs32_Done
        CALL Neg32
Abs32_Done:
        RET
Abs32 ENDP

Mul32ByCX PROC
        ; [SI] = [SI] * CX 
        ; [SI] BOTH + AND -
        PUSH AX
        PUSH DX
        PUSH BX
        
        MOV BX, CX            
        
        MOV CL, 0             
        TEST WORD PTR [SI+2], 8000H
        JZ MulCX_Unsigned
        MOV CL, 1
        CALL Neg32
MulCX_Unsigned:
        PUSH CX               
        
        MOV AX, [SI]
        MUL BX                
        MOV [SI], AX         
        PUSH DX              
        
        MOV AX, [SI+2]
        MUL BX               

        POP BX                
        ADD AX, BX
        ADC DX, 0
        
        CMP DX, 0
        JNE MulCX_Overflow
        TEST AX, 8000H
        JNZ MulCX_Overflow
        
        MOV [SI+2], AX
        
        ; Restore sign
        POP CX                
        CMP CL, 1
        JNE MulCX_Done
        CALL Neg32
        JMP MulCX_Done       
MulCX_Overflow:
        POP CX                
        MOV error_flag, 1
MulCX_Done:
        POP BX
        POP DX
        POP AX
        RET
Mul32ByCX ENDP

Div32ByCX PROC
        ; [SI] = [SI] / CX
        ; [SI] BOTH + AND -
        PUSH AX
        PUSH DX
        PUSH BX
        PUSH CX              
        
        MOV CL, 0             
        TEST WORD PTR [SI+2], 8000H
        JZ DivCX_Unsigned
        MOV CL, 1
        CALL Neg32
DivCX_Unsigned:
        POP BX               
        PUSH CX              
        
        MOV AX, [SI+2]
        XOR DX, DX
        DIV BX                
        PUSH AX               
        
        MOV AX, [SI]          
        DIV BX                
        MOV [SI], AX          
        POP AX                
        MOV [SI+2], AX        

        POP CX              
        CMP CL, 1
        JNE DivCX_Done
        CALL Neg32
DivCX_Done:
        POP BX
        POP DX
        POP AX
        RET
Div32ByCX ENDP

Mul32x32 PROC
        PUSH BP 

        MOV BP, SP
        SUB SP, 8               ; 4 16BIT VARIABLE FOR MULTIPLY

        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI
        PUSH DI 

        MOV AX, [SI+2]
        XOR AX, [DI+2]
        PUSH AX                 ; STORE FOR SIGN AT BIT 15

        MOV AX, [SI]
        MOV temp_x_low, AX
        MOV AX, [SI+2]
        MOV temp_x_high, AX
        MOV AX, [DI]
        MOV temp_y_low, AX
        MOV AX, [DI+2]
        MOV temp_y_high, AX

        ; MAKE POSITIVE
        LEA SI, temp_x_low
        CALL Abs32
        LEA SI, temp_y_low
        CALL Abs32

        XOR AX, AX
        MOV [BP-2], AX
        MOV [BP-4], AX
        MOV [BP-6], AX
        MOV [BP-8], AX

        ; MULTIPLY
        ; P1 XL * YL
        MOV AX, temp_x_low
        MUL temp_y_low
        MOV [BP-2], AX
        MOV [BP-4], DX

        ; P2 XH * YL
        MOV AX, temp_x_high
        MUL temp_y_low
        ADD [BP-4], AX
        ADC DX, 0
        MOV [BP-6], DX
        ADC BYTE PTR [BP-8], 0

        ; P2 XL * YH
        MOV AX, temp_x_low
        MUL temp_y_high
        ADD [BP-4], AX
        ADC DX, 0
        MOV [BP-6], DX
        ADC BYTE PTR [BP-8], 0

        ; P3 XH * XH
        MOV AX, temp_x_high
        MUL temp_y_high
        ADD [BP-6], AX
        ADC [BP-8], DX


        ; DIVIDE BY 100 FOR DECIMAL PART
        MOV CX, 100

        XOR DX, DX
        MOV AX, [BP-8]
        DIV CX
        MOV [BP-8], AX

        MOV AX, [BP-6]
        DIV CX
        MOV [BP-6], AX

        MOV AX, [BP-4]
        DIV CX
        MOV [BP-4], AX

        MOV AX, [BP-2]
        DIV CX
        MOV [BP-2], AX

        ;OVERFLOW CHECK
        CMP WORD PTR [BP-8], 0
        JNE Mul_Overflow
        CMP WORD PTR [BP-6], 0
        JNE Mul_Overflow
        TEST WORD PTR [BP-4], 8000H
        JNZ Mul_Overflow
        JMP Mul_NoOverflow
Mul_Overflow:
        MOV error_flag, 1
        POP AX
        JMP MulDone
Mul_NoOverflow:
        POP AX                
        TEST AX, 8000H
        JZ Mul_StoreResult

        NOT WORD PTR [BP-2]
        NOT WORD PTR [BP-4]
        ADD WORD PTR [BP-2], 1
        ADC WORD PTR [BP-4], 0
Mul_StoreResult:
        LEA SI, accumulator_low
        MOV AX, [BP-2]
        MOV [SI], AX
        MOV AX, [BP-4]
        MOV [SI+2], AX
MulDone:
        POP DI
        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        MOV SP, BP
        POP BP
        RET
Mul32x32 ENDP

Div32x32 PROC
        ; SI -> DIVIDEND
        ; DI -> DIVISOR
        PUSH BP
        MOV BP, SP
        SUB SP, 12              ; [BP-2 ]=D0  [BP-4 ]=D1  [BP-6 ]=D2  [BP-8 ]=D3
                                ; [BP-10]=R_L [BP-12]=R_H
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI
        PUSH DI

        MOV AX, [DI]
        OR AX, [DI+2]
        JNZ DivNoZero
        MOV error_flag, 2
        JMP DivDone
DivNoZero:
        MOV AX, [SI+2]
        XOR AX, [DI+2]
        PUSH AX                 ; BIT 15 = RESULT SIGN

        MOV AX, [SI]
        MOV temp_x_low, AX
        MOV AX, [SI+2]
        MOV temp_x_high, AX
        MOV AX, [DI]
        MOV temp_y_low, AX
        MOV AX, [DI+2]
        MOV temp_y_high, AX
        LEA SI, temp_x_low
        CALL Abs32
        LEA SI, temp_y_low
        CALL Abs32

        ; MUL DIVIDEND BY 100
        MOV CX, 100

        MOV AX, temp_x_low
        MUL CX
        MOV [BP-2], AX
        MOV [BP-4], DX

        MOV AX, temp_x_high
        MUL CX
        ADD [BP-4], AX
        ADC DX, 0
        MOV [BP-6], DX
        
        MOV WORD PTR [BP-8], 0

        XOR AX, AX
        MOV [BP-10], AX         ; R_L = 0
        MOV [BP-12], AX         ; R_H = 0

        MOV CX, 64
DivLoop:
        ; SHIFT LEFT 1
        SHL WORD PTR [BP-2], 1
        RCL WORD PTR [BP-4], 1
        RCL WORD PTR [BP-6], 1
        RCL WORD PTR [BP-8], 1
        
        RCL WORD PTR [BP-10], 1
        RCL WORD PTR [BP-12], 1
        
        ; CMP REMINDER AND DIVISOR
        MOV AX, [BP-12]
        CMP AX, temp_y_high
        JA  Div_DoSub
        JB  Div_Skip
        MOV AX, [BP-10]
        CMP AX, temp_y_low
        JB  Div_Skip
Div_DoSub:
        MOV AX, [BP-10]
        SUB AX, temp_y_low
        MOV [BP-10], AX
        MOV AX, [BP-12]
        SBB AX, temp_y_high
        MOV [BP-12], AX

        OR  WORD PTR [BP-2], 1
Div_Skip:
        LOOP DivLoop

        ;BUFFER OVERFLOW CHECK
        CMP WORD PTR [BP-8], 0
        JNE Div_Overflow
        CMP WORD PTR [BP-6], 0
        JNE Div_Overflow
        TEST WORD PTR [BP-4], 8000H
        JNZ Div_Overflow
        JMP Div_NoOverflow
Div_Overflow:
        MOV error_flag, 1
        POP AX
        JMP DivDone
Div_NoOverflow:
        POP AX
        TEST AX, 8000H
        JZ DivStoreResult

        NOT WORD PTR [BP-2]
        NOT WORD PTR [BP-4]
        ADD WORD PTR [BP-2], 1
        ADC WORD PTR [BP-4], 0
DivStoreResult:
        LEA SI, accumulator_low
        MOV AX, [BP-2]
        MOV [SI], AX
        MOV AX, [BP-4]
        MOV [SI+2], AX
DivDone:
        POP DI
        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        MOV SP, BP
        POP BP
        RET
Div32x32 ENDP

Mod32x32 PROC
        PUSH AX
        PUSH SI
        PUSH DI

        LEA SI, accumulator_low
        LEA DI, mod_temp_low
        CALL Copy32

        LEA SI, accumulator_low
        LEA DI, current_input_low
        CALL Div32x32
        CMP error_flag, 0
        JNE Mod32Done

        LEA SI, accumulator_low
        CALL Div32By100
        CALL Mul32By100

        LEA SI, accumulator_low
        LEA DI, current_input_low
        CALL Mul32x32
        CMP error_flag, 0
        JNE Mod32Done

        LEA SI, mod_temp_low
        LEA DI, accumulator_low
        CALL Sub32
        CMP error_flag, 0
        JNE Mod32Done

        LEA SI, mod_temp_low
        LEA DI, accumulator_low
        CALL Copy32

Mod32Done:
        POP DI
        POP SI
        POP AX
        RET
Mod32x32 ENDP

Mul32By2 PROC
        MOV CX, 2
        CALL Mul32ByCX
        RET
Mul32By2 ENDP
Mul32By10 PROC
        MOV CX, 10
        CALL Mul32ByCX
        RET
Mul32By10 ENDP
Mul32By16 PROC
        MOV CX, 16
        CALL Mul32ByCX
        RET
Mul32By16 ENDP
Mul32By100 PROC
        MOV CX, 100
        CALL Mul32ByCX
        RET
Mul32By100 ENDP
Div32By10 PROC
        MOV CX, 10
        CALL Div32ByCX
        RET
Div32By10 ENDP
Div32By100 PROC
        MOV CX, 100
        CALL Div32ByCX
        RET
Div32By100 ENDP
Div32By1000 PROC
        MOV CX, 1000
        CALL Div32ByCX
        RET
Div32By1000 ENDP

;----------------------------------------------------------------------------
;FORMATTING ROUTINES
;----------------------------------------------------------------------------
UpdateDisplay PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI
        PUSH DI

        CALL DrawOperatorIndicator

        ; ERRORS
        CMP error_flag, 0
        JE UpDateDisplayNormal

        MOV DH, 8
        MOV DL, 30
        CALL SetCursor
        MOV AL, ' '
        MOV BL, 8FH
        MOV CX, 36
        CALL PrintCharAttr

        CMP error_flag, 2
        JE  UpdDisp_IsDivZero
        CMP error_flag, 3
        JE RepeatedOperator
        LEA SI, MSG_ERR_OVERFLOW
        JMP UpdDisp_PrintErr
UpdDisp_IsDivZero:
        LEA SI, MSG_ERR_DIVZERO
        JMP UpdDisp_PrintErr
RepeatedOperator:
        LEA SI, MSG_ERR_NOREPEAT
UpdDisp_PrintErr:
        PUSH SI
        XOR CX, CX
UpdDisp_ErrLen:
        CMP BYTE PTR [SI], '$'
        JE  UpdDisp_ErrLenDone
        INC SI
        INC CX
        JMP UpdDisp_ErrLen
        UpdDisp_ErrLenDone:
        POP SI
        MOV DL, 66
        SUB DL, CL
        MOV DH, 8
        CALL SetCursor
        MOV BL, 8CH
        CALL PrintStringAttr
        JMP UpdDisp_Exit

UpDateDisplayNormal:
        MOV AX, current_input_low
        MOV DX, current_input_high

        XOR CL, CL
        CMP input_active, 0
        JE CheckSignedResult

        CMP input_negative, 1
        JNE DoUnsignedDiv
        MOV CL, 1
        JMP DoUnsignedDiv
CheckSignedResult:
        
        TEST DX, 8000H
        JZ DoUnsignedDiv
        MOV CL, 1
        
        NOT AX
        NOT DX
        ADD AX, 1
        ADC DX, 0
DoUnsignedDiv:
        PUSH CX                  ; SAVE SIGN FLAG
        ; DIVIDE BY 100
        MOV DI, AX               ; SAVE LOW
        MOV AX, DX
        XOR DX, DX
        MOV CX, 100
        DIV CX
        MOV SI, AX                ; SI -> QUOTIENT HIGH 

        MOV AX, DI
        DIV CX                    ; AX -> QUOTIENT LOW
        PUSH DX                   ; FRACTIONAL PART 
        
        ;CONVERT INTO ASCII
        LEA DI, display_buffer
        ADD DI, 15                ; START FROM RIGHT SIDE
        MOV BYTE PTR [DI], '$'
        DEC DI

        CMP SI, 0
        JNE ConvertLoop
        CMP AX, 0
        JNE ConvertLoop
        MOV BYTE PTR [DI], '0'
        DEC DI
        JMP FormatFraction
ConvertLoop:
        PUSH AX
        MOV AX, SI
        XOR DX, DX
        MOV CX, 10
        DIV CX
        MOV SI, AX                 ; SI -> NEW HIGH QUOTIENT
        POP AX
        DIV CX                     ; AX -> NEW QUOTIENT LOW , DX -> UNIT

        ADD DL, '0'
        MOV [DI], DL
        DEC DI

        CMP SI, 0
        JNE ConvertLoop
        CMP AX, 0
        JNE ConvertLoop
FormatFraction:
        INC DI
        POP DX                    ; RESTORE REMAINDER 
        POP CX                    ; RESTORE SIGN FLAG 

        LEA BX, display_buffer

        CMP CL, 1
        JNE CopyIntLoop
        MOV BYTE PTR [BX], '-'
        INC BX
CopyIntLoop:
        MOV AL, [DI]
        MOV [BX], AL
        INC DI
        INC BX
        CMP BYTE PTR [DI], '$'
        JNE CopyIntLoop

        MOV BYTE PTR [BX], '.'
        INC BX

        MOV AX, DX
        MOV CL, 10
        DIV CL
        ADD AL, '0'
        ADD AH, '0'
        MOV [BX], AL
        MOV [BX+1], AH
        MOV BYTE PTR [BX+2], '$'

        ; CLEAR DISPLAY
        MOV DH, 8
        MOV DL, 30
        CALL SetCursor
        MOV AL, ' '
        MOV BL, 8FH
        MOV CX, 36
        CALL PrintCharAttr

        ; CALCULATE LENGTH TO DISPLAY
        LEA SI, display_buffer
        XOR CX, CX
LenLoop:
        CMP BYTE PTR [SI], '$'
        JE LenDone
        INC CX
        INC SI
        JMP LenLoop
LenDone:

        ; TO RIGHT ALIGN
        MOV DL, 66
        SUB DL, CL
        MOV DH, 8
        CALL SetCursor
        
        LEA SI, display_buffer
        MOV BL, 8FH
        CALL PrintStringAttr
UpdDisp_Exit:
        Call DrawHintLine
        POP DI
        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        RET
UpdateDisplay ENDP


;----------------------------------------------------------------------------
;CALCULATOR LOGIC
;----------------------------------------------------------------------------

DrawOperatorIndicator PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI

        MOV DH, 8
        MOV DL, 15
        CALL SetCursor

        MOV BL, 8BH 
        CMP pending_operator, 0
        JE ClearOpInd

        CMP pending_operator, BTN_ADD
        JE PrintAddInd
        CMP pending_operator, BTN_SUB
        JE PrintSubInd
        CMP pending_operator, BTN_MUL
        JE PrintMulInd
        CMP pending_operator, BTN_DIV
        JE PrintDivInd
        CMP pending_operator, BTN_MOD
        JE PrintMODInd
        JMP OpIndDone
ClearOpInd:
        MOV AL, ' '
        MOV CX, 3
        CALL PrintCharAttr
        JMP OpIndDone
PrintAddInd:
        MOV AL, '+'
        MOV CX, 1
        CALL PrintCharAttr
        INC DL
        CALL SetCursor
        MOV AL, ' '
        MOV CX, 2
        CALL PrintCharAttr
        JMP OpIndDone
PrintSubInd:
        MOV AL, '-'
        MOV CX, 1
        CALL PrintCharAttr
        INC DL
        CALL SetCursor
        MOV AL, ' '
        MOV CX, 2
        CALL PrintCharAttr
        JMP OpIndDone
PrintMulInd:
        MOV AL, '*'
        MOV CX, 1
        CALL PrintCharAttr
        INC DL
        CALL SetCursor
        MOV AL, ' ' 
        MOV CX, 2
        CALL PrintCharAttr
        JMP OpIndDone
PrintDivInd:
        MOV AL, '/'
        MOV CX, 1
        CALL PrintCharAttr
        INC DL
        CALL SetCursor
        MOV AL, ' ' 
        MOV CX, 2
        CALL PrintCharAttr
        JMP OpIndDone
PrintMODInd:
        MOV AL, 'M'
        MOV CX, 1
        CALL PrintCharAttr
        INC DL
        CALL SetCursor
        MOV AL, 'O'
        CALL PrintCharAttr
        INC DL 
        CALL SetCursor
        MOV AL, 'D'
        CALL PrintCharAttr
        JMP OpIndDone
OpIndDone:
        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        RET 
DrawOperatorIndicator ENDP

ApplyOperator PROC
        PUSH AX
        PUSH SI
        PUSH DI

        CMP error_flag, 0
        JNE ApplyOpDone

        CMP pending_operator, 0
        JE ApplyOpDone

        CMP pending_operator, BTN_ADD
        JE DoAdd
        CMP pending_operator, BTN_SUB
        JE DoSub
        CMP pending_operator, BTN_MUL
        JE DoMul
        CMP pending_operator, BTN_DIV
        JE DoDiv
        CMP pending_operator, BTN_MOD
        JE DoMod
        JMP ApplyOpDone
DoAdd:
        LEA SI, accumulator_low
        LEA DI, current_input_low
        CALL Add32
        JMP ApplyOpDone
DoSub:
        LEA SI, accumulator_low
        LEA DI, current_input_low
        CALL Sub32
        JMP ApplyOpDone
DoMul:
        LEA SI, accumulator_low
        LEA DI, current_input_low
        CALL Mul32x32
        JMP ApplyOpDone
DoDiv:
        LEA SI, accumulator_low
        LEA DI, current_input_low
        CALL Div32x32
        JMP ApplyOpDone
DoMod:
        LEA SI, accumulator_low
        LEA DI, current_input_low
        CALL Mod32x32
        JMP ApplyOpDone
ApplyOpDone:
        POP DI
        POP SI
        POP AX
        RET
ApplyOperator ENDP

ProcessOperator PROC
        PUSH AX
        PUSH BX
        PUSH SI
        PUSH DI

        MOV BX, AX

        CMP error_flag, 0
        JNE ProcOpDone

        CMP input_active, 1
        JNE SetNewPendingOp

        CMP input_negative, 1
        JNE NoNegateInput
        LEA SI, current_input_low
        CALL Neg32
        MOV input_negative, 0
NoNegateInput:
        CMP pending_operator, 0
        JE FirstOperand

        CALL ApplyOperator
        JMP CopyToInput
FirstOperand:
        LEA SI, current_input_low
        LEA DI, accumulator_low
        CALL Copy32
CopyToInput:
        LEA SI, accumulator_low
        LEA DI, current_input_low
        CALL Copy32
        MOV input_active, 0
SetNewPendingOp:
        MOV pending_operator, BX
        CALL UpdateDisplay
ProcOpDone:
        POP DI
        POP SI
        POP BX
        POP AX
        RET
ProcessOperator ENDP

ProcessNEG PROC
        PUSH AX
        PUSH SI
        PUSH DI

        CMP error_flag, 0
        JNE ProcessNEGDone

        CMP input_active, 1
        JNE DoNegateInactive

        XOR input_negative, 1
        JMP CheckAccumulatorCopy
DoNegateInactive:
        LEA SI, current_input_low
        CALL Neg32
CheckAccumulatorCopy:
        CMP pending_operator, 0
        JNE UpdateDisplayAfterNeg
        
        LEA SI, current_input_low
        LEA DI, accumulator_low
        CALL Copy32

        CMP input_active, 1
        JNE UpdateDisplayAfterNeg
        CMP input_negative, 1
        JNE UpdateDisplayAfterNeg
        LEA SI, accumulator_low
        CALL Neg32

UpdateDisplayAfterNeg:
        CALL UpdateDisplay
ProcessNEGDone:
        POP DI
        POP SI
        POP AX
        RET
ProcessNEG ENDP

ProcessABS PROC
        PUSH AX
        PUSH SI
        PUSH DI

        CMP error_flag, 0
        JNE ProcessABSDone

        CMP input_active, 1
        JNE DoAbsInactive

        MOV input_negative, 0
        JMP CheckAccumulatorCopy2
DoAbsInactive:
        LEA SI, current_input_low
        CALL Abs32
CheckAccumulatorCopy2:
        CMP pending_operator, 0
        JNE UpdateDisplayAfterAbs
        
        LEA SI, current_input_low
        LEA DI, accumulator_low
        CALL Copy32
UpdateDisplayAfterAbs:
        CALL UpdateDisplay
ProcessABSDone:
        POP DI
        POP SI
        POP AX
        RET
ProcessABS ENDP

ProcessPCT PROC
        PUSH AX
        PUSH SI
        PUSH DI
   
        CMP error_flag, 0
        JNE PCTDone

        CMP input_active, 0
        JNE PctCommitSign
        MOV input_active, 1
PctCommitSign:
        CMP input_negative, 1
        JNE PctCheckMode
        LEA SI, current_input_low
        CALL Neg32
        MOV input_negative, 0
PctCheckMode:
        CMP pending_operator, BTN_ADD
        JE PctAdditive
        CMP pending_operator, BTN_SUB
        JE PctAdditive

        LEA SI, current_input_low
        CALL Div32By100
        JMP PCTDone
PctAdditive:
        LEA SI, accumulator_low
        LEA DI, mod_temp_low
        CALL Copy32

        LEA SI, accumulator_low
        LEA DI, current_input_low
        CALL Mul32x32
        CMP error_flag, 0
        JNE PCTDone

        LEA SI, accumulator_low
        CALL Div32By100

        LEA SI, accumulator_low
        LEA DI, current_input_low
        CALL Copy32

        LEA SI, mod_temp_low
        LEA DI, accumulator_low
        CALL Copy32
PCTDone:
        CALL UpdateDisplay
        POP DI
        POP SI
        POP AX
        RET
ProcessPCT ENDP


ProcessEquals PROC
        PUSH AX
        PUSH BX
        PUSH SI
        PUSH DI

        CMP error_flag, 0
        JNE ProcEqDone

        CMP input_active, 1
        JE CommitAndApply

        CMP last_operator, 0
        JE ProcEqDone

        ;REPEAT EQUAL
        CMP last_operator, BTN_MOD
        JNE NoRepeatErr
        MOV error_flag, 3
        JMP ProcEqDone
NoRepeatErr:
        LEA SI, last_operand_low
        LEA DI, current_input_low
        CALL Copy32
        MOV AX, last_operator
        MOV pending_operator, AX
        CALL ApplyOperator

        MOV pending_operator, 0
        JMP UpdateAfterEq
CommitAndApply:
        CMP input_negative, 1
        JNE NoNegateInputEq
        LEA SI, current_input_low
        CALL Neg32
        MOV input_negative, 0
NoNegateInputEq:
        
        LEA SI, current_input_low
        LEA DI, last_operand_low
        CALL Copy32
        
        MOV AX, pending_operator
        MOV last_operator, AX
        CALL ApplyOperator
        MOV pending_operator, 0
UpdateAfterEq:
        LEA SI, accumulator_low
        LEA DI, current_input_low
        CALL Copy32
        
ProcEqDone:
        MOV input_active, 0
        CALL UpdateDisplay
        POP DI
        POP SI
        POP BX
        POP AX
        RET
ProcessEquals ENDP

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

        ;CLEAR SCREEN TO DARK GRAY
        CALL ClearScreen

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
