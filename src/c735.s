;*************************************************************************
;*									 *
;*	 OSWORD 9  - READ A PIXEL					 *
;*	 =POINT(X,Y)							 *
;*									 *
;*************************************************************************
;on entry  &EF=A=9
;	   &F0=X=low byte of parameter block address
;	   &F1=Y=high byte of parameter block address
;	PARAMETER BLOCK
;	0,1=X coordinate
;	2,3=Y coordinate
;on exit, result in BLOCK+4
;     =&FF if point was of screen or logical colour of point if on screen

			.org	$c735

_OSWORD_9:		ldy	#$03				; Y=3 to point to hi byte of Y coordinate
_BC737:			lda	(OSW_X),Y			; get it
			sta	VDU_BITMAP_READ,Y		; store it
			dey					; point to next byte
			bpl	_BC737				; transfer till Y=&FF lo byte of X coordinate in &328
			lda	#$28				; 
			jsr	_LD839				; check window boundaries
			ldy	#$04				; Y=4
			bne	_BC750				; jump to C750


;*************************************************************************
;*									 *
;*	 OSWORD 11 - READ PALLETTE					 *
;*									 *
;*************************************************************************
;on entry  &EF=A=11
;	   &F0=X=low byte of parameter block address
;	   &F1=Y=high byte of parameter block address
;	PARAMETER BLOCK
;	0=logical colour to read
;on exit, result in BLOCK
;	0=logical colour
;	1=physical colour
;	2=red colour component	\
;	3=green colour component } when set using analogue colours
;	4=blue colour component /

_OSWORD_11:		and	VDU_COL_MASK			; number of logical colours less 1
			tax					; put it in X
			lda	VDU_PALETTE,X			; colour pallette
_BC74F:			iny					; increment Y to point to byte 1

_BC750:			sta	(OSW_X),Y			; store data
			lda	#$00				; issue 0s
			cpy	#$04				; to next bytes until Y=4
			bne	_BC74F				; 

_BC758:			rts					; and exit


;*************************************************************************
;*									 *
;*	 VDU 12 - CLEAR TEXT SCREEN					 *
;*	 CLS								 *
;*									 *
;*************************************************************************

_VDU_12:		jsr	_LC588				; A=0 if text cursor A=&20 if graphics cursor
			bne	_BC7BD				; if graphics cursor &C7BD
			lda	VDU_STATUS			; VDU status byte
			and	#$08				; check if software scrolling (text window set)
			bne	_BC767				; if so C767
			jmp	_LCBC1				; initialise screen display and home cursor

_BC767:			ldx	VDU_T_WIN_T			; top of text window
_BC76A:			stx	VDU_T_CURS_Y			; current text line
			jsr	_LCEAC				; clear a line

			ldx	VDU_T_CURS_Y			; current text line
			cpx	VDU_T_WIN_B			; bottom margin
			inx					; X=X+1
			bcc	_BC76A				; if X at compare is less than bottom margin clear next


;*************************************************************************
;*									 *
;*	 VDU 30 - HOME CURSOR						 *
;*									 *
;*************************************************************************

_VDU_30:		jsr	_LC588				; A=0 if text cursor A=&20 if graphics cursor
			beq	_BC781				; if text cursor C781
			jmp	_LCFA6				; home graphic cursor if graphic
_BC781:			sta	VDU_QUEUE_8			; store 0 in last two parameters
			sta	VDU_QUEUE_7			; 


;*************************************************************************
;*									 *
;*	 VDU 31 - POSITION TEXT CURSOR					 *
;*	 TAB(X,Y)							 *
;*									 *
;*	 2 parameters							 *
;*									 *
;*************************************************************************
;0322 = supplied X coordinate
;0323 = supplied Y coordinate

_VDU_31:		jsr	_LC588				; A=0 if text cursor A=&20 if graphics cursor
			bne	_BC758				; exit
			jsr	_LC7A8				; exchange text column/line with workspace 0328/9
			clc					; clear carry
			lda	VDU_QUEUE_7			; get X coordinate
			adc	VDU_T_WIN_L			; add to text window left
			sta	VDU_T_CURS_X			; store as text column
			lda	VDU_QUEUE_8			; get Y coordinate
			clc					; 
			adc	VDU_T_WIN_T			; add top of text window
			sta	VDU_T_CURS_Y			; current text line
			jsr	_LCEE8				; set up screen address
			bcc	_BC732				; set cursor position if C=0 (point on screen)
_LC7A8:			ldx	#$18				; else point to workspace
			ldy	#$28				; and line/column to restore old values
			jmp	_LCDDE				; exchange &300/1+X with &300/1+Y


;*************************************************************************
;*									 *
;*	 VDU 13 - CARRIAGE RETURN					 *
;*									 *
;*************************************************************************

_VDU_13:		jsr	_LC588				; A=0 if text cursor A=&20 if graphics cursor
			beq	_BC7B7				; if text C7B7
			jmp	_LCFAD				; else set graphics cursor to left hand columm

_BC7B7:			jsr	_LCE6E				; set text column to left hand column
			jmp	_LC6AF				; set up cursor and display address

_BC7BD:			jsr	_LCFA6				; home graphic cursor


;*************************************************************************
;*									 *
;*	 VDU 16 - CLEAR GRAPHICS SCREEN					 *
;*	 CLG								 *
;*									 *
;*************************************************************************

_VDU_16:		lda	VDU_PIX_BYTE			; pixels per byte
			beq	_BC7F8				; if 0 current mode has no graphics so exit
			ldx	VDU_G_BG			; Background graphics colour
			ldy	VDU_P_BG			; background graphics plot mode (GCOL n)
			jsr	_LD0B3				; set graphics byte mask in &D4/5
			ldx	#$00				; graphics window
			ldy	#$28				; workspace
			jsr	_LD47C				; set(300/7+Y) from (300/7+X)
			sec					; set carry
			lda	VDU_G_WIN_T			; graphics window top lo.
			sbc	VDU_G_WIN_B			; graphics window bottom lo
			tay					; Y=difference
			iny					; increment
			sty	VDU_WORKSPACE			; and store in workspace (this is line count)
_BC7E1:			ldx	#$2c				; 
			ldy	#$28				; 
			jsr	_VDU_G_CLR_LINE			; clear line
			lda	VDU_BITMAP_RD_6			; decrement window height in pixels
			bne	_BC7F0				; 
			dec	VDU_BITMAP_RD_7			; 
_BC7F0:			dec	VDU_BITMAP_RD_6			; 
			dec	VDU_WORKSPACE			; decrement line count
			bne	_BC7E1				; if <>0 then do it again
_BC7F8:			rts					; exit


;*************************************************************************
;*									 *
;*	 VDU 17 - DEFINE TEXT COLOUR					 *
;*	 COLOUR n							 *
;*									 *
;*	 1 parameter							 *
;*									 *
;*************************************************************************
;parameter in &0323

_VDU_17:		ldy	#$00				; Y=0
			beq	_BC7FF				; jump to C7FF


;*************************************************************************
;*									 *
;*	 VDU 18 - DEFINE GRAPHICS COLOUR				 *
;*	 GCOL k,c							 *
;*									 *
;*	 2 parameters							 *
;*									 *
;*************************************************************************
;parameters in 323,322

_VDU_18:		ldy	#$02				; Y=2

_BC7FF:			lda	VDU_QUEUE_8			; get last parameter
			bpl	_BC805				; if +ve it's foreground colour so C805
			iny					; else Y=Y+1
_BC805:			and	VDU_COL_MASK			; number of logical colours less 1
			sta	VDU_TMP1			; store it
			lda	VDU_COL_MASK			; number of logical colours less 1
			beq	_BC82B				; if none exit
			and	#$07				; else limit to an available colour and clear M
			clc					; clear carry
			adc	VDU_TMP1			; Add last parameter to get pointer to table
			tax					; pointer into X

			lda	_LC423,X			; get plot options from table
			sta	VDU_T_FG,Y			; colour Y=0=text fgnd 1= text bkgnd 2=graphics fg etc
			cpy	#$02				; If Y>1
			bcs	_BC82C				; then its graphics so C82C else
			lda	VDU_T_FG			; foreground text colour
			eor	#$ff				; invert
			sta	VDU_T_EOR_MASK			; text colour byte to be orred or EORed into memory
			eor	VDU_T_BG			; background text colour
			sta	VDU_T_OR_MASK			; text colour byte to be orred or EORed into memory
_BC82B:			rts					; and exit

_BC82C:			lda	VDU_QUEUE_7			; get first parameter
			sta	VDU_G_FG,Y			; text colour Y=0=foreground 1=background etc.
			rts					; exit

_BC833:			lda	#$20				; 
			sta	VDU_T_BG			; background text colour
			rts					; 


;*************************************************************************
;*									 *
;*	 VDU 20 - RESTORE DEFAULT COLOURS				 *
;*									 *
;*************************************************************************

_VDU_20:		ldx	#$05				; X=5

			lda	#$00				; A=0
_BC83D:			sta	VDU_T_FG,X			; zero all colours
			dex					; 
			bpl	_BC83D				; until X=&FF
			ldx	VDU_COL_MASK			; number of logical colours less 1
			beq	_BC833				; if none its MODE 7 so C833
			lda	#$ff				; A=&FF
			cpx	#$0f				; if not mode 2 (16 colours)
			bne	_BC850				; goto C850

			lda	#$3f				; else A=&3F
_BC850:			sta	VDU_T_FG			; foreground text colour
			sta	VDU_G_FG			; foreground graphics colour
			eor	#$ff				; invert A
			sta	VDU_T_OR_MASK			; text colour byte to be orred or EORed into memory
			sta	VDU_T_EOR_MASK			; text colour byte to be orred or EORed into memory
			stx	VDU_QUEUE_4			; set first parameter of 5
			cpx	#$03				; if there are 4 colours
			beq	_BC874				; goto C874
			bcc	_BC885				; if less there are 2 colours goto C885
								; else there are 16 colours
			stx	VDU_QUEUE_5			; set second parameter
_BC868:			jsr	_VDU_19				; do VDU 19 etc
			dec	VDU_QUEUE_5			; decrement first parameter
			dec	VDU_QUEUE_4			; and last parameter
			bpl	_BC868				; 
			rts					; 

;********* 4 colour mode *************************************************

_BC874:			ldx	#$07				; X=7
			stx	VDU_QUEUE_5			; set first parameter
_BC879:			jsr	_VDU_19				; and do VDU 19
			lsr	VDU_QUEUE_5			; 
			dec	VDU_QUEUE_4			; 
			bpl	_BC879				; 
			rts					; exit

;********* 2 colour mode ************************************************

_BC885:			ldx	#$07				; X=7
			jsr	_LC88F				; execute VDU 19
			ldx	#$00				; X=0
			stx	VDU_QUEUE_4			; store it as
_LC88F:			stx	VDU_QUEUE_5			; both parameters


;*************************************************************************
;*									 *
;*	 VDU 19 - DEFINE COLOURS					 *
;*	[COLOUR l,p]							 *
;*	[COLOUR l,r,g,b]						 *
;*									 *
;*	 5 parameters							 *
;*									 *
;*************************************************************************
;&31F=first parameter logical colour
;&320=second physical colour

_VDU_19:		php					; push processor flags
			sei					; disable interrupts
			lda	VDU_QUEUE_4			; get first parameter and
			and	VDU_COL_MASK			; number of logical colours less 1
			tax					; toi make legal  X=A
			lda	VDU_QUEUE_5			; A=second parameter
_LC89E:			and	#$0f				; make legal
			sta	VDU_PALETTE,X			; colour pallette
			tay					; Y=A
			lda	VDU_COL_MASK			; number of logical colours less 1
			sta	MOS_WS_0			; store it
			cmp	#$03				; is it 4 colour mode??
			php					; save flags
			txa					; A=X
_BC8AD:			ror					; rotate A into &FA
			ror	MOS_WS_0			; 
			bcs	_BC8AD				; 
			asl	MOS_WS_0			; 
			tya					; A=Y
			ora	MOS_WS_0			; 
			tax					; 
			ldy	#$00				; Y=0
_BC8BA:			plp					; check flags
			php					; 
			bne	_BC8CC				; if A<>3 earlier C8CC
			and	#$60				; else A=&60 to test bits 5 and 6
			beq	_BC8CB				; if not set C8CB
			cmp	#$60				; else if both set
			beq	_BC8CB				; C8CB
			txa					; A=X
			eor	#$60				; invert
			bne	_BC8CC				; and if not 0 C8CC

_BC8CB:			txa					; X=A
_BC8CC:			jsr	_LEA11				; call Osbyte 155 pass data to pallette register
			tya					; 
			sec					; 
			adc	VDU_COL_MASK			; number of logical colours less 1
			tay					; 
			txa					; 
			adc	#$10				; 
			tax					; 
			cpy	#$10				; if Y<16 do it again
			bcc	_BC8BA				; 
			plp					; pull flags twice
			plp					; 
			rts					; and exit


;*************************************************************************
;*									 *
;*	 OSWORD 12 - WRITE PALLETTE					 *
;*									 *
;*************************************************************************
;on entry X=&F0:Y=&F1:YX points to parameter block
;byte 0 = logical colour;  byte 1 physical colour; bytes 2-4=0

_OSWORD_12:		php					; push flags
			and	VDU_COL_MASK			; and with number of logical colours less 1
			tax					; X=A
			iny					; Y=Y+1
			lda	(OSW_X),Y			; get phsical colour
			jmp	_LC89E				; do VDU19 with parameters in X and A


;*************************************************************************
;*									 *
;*	 VDU 22 - SELECT MODE						 *
;*	 MODE n								 *
;*									 *
;*	 1 parameter							 *
;*									 *
;*************************************************************************
;parameter in &323

_VDU_22:		lda	VDU_QUEUE_8			; get parameter
			jmp	_LCB33				; goto CB33


;*************************************************************************
;*									 *
;*	 VDU 23 - DEFINE CHARACTERS					 *
;*									 *
;*	 9 parameters							 *
;*									 *
;*************************************************************************
;parameters are:-
;31B character to define
;31C to 323 definition

_VDU_23:		lda	VDU_QUEUE			; get character to define
			cmp	#$20				; is it ' '
			bcc	_VDU_23_CTRL			; if less then it is a control instruction, goto C93F
_VDU_23_DEFINE_CHAR:	pha					; else save parameter
			lsr					; A=A/32
			lsr					; 
			lsr					; 
			lsr					; 
			lsr					; 
			tax					; X=A
			lda	_LC40D,X			; get font flag mask from table (A=&80/2^X)
			bit	VDU_FONT_FLAGS			; font flag
			bne	_BC927				; and if A<>0 C927 storage area is established already
			ora	VDU_FONT_FLAGS			; or with font flag to set bit found to be 0
			sta	VDU_FONT_FLAGS			; font flag
			txa					; get back A
			and	#$03				; And 3 to clear all but bits 0 and 1
			clc					; clear carry
			adc	#$bf				; add &BF (A=&C0,&C1,&C2) to select a character page
			sta	VDU_TMP6			; store it
			lda	VDU_FONT_FLAGS,X		; get font location byte (normally &0C)
			sta	VDU_TMP4			; store it
			ldy	#$00				; Y=0 so (&DE) holds (&C000 -&C2FF)
			sty	VDU_TMP3			; 
			sty	VDU_TMP5			; 
_BC920:			lda	(VDU_TMP5),Y			; transfer page to storage area
			sta	(VDU_TMP3),Y			; 
			dey					; 
			bne	_BC920				; 

_BC927:			pla					; get back A
			jsr	_LD03E				; set up character definition pointers

			ldy	#$07				; Y=7
_BC92D:			lda	VDU_QUEUE_1,Y			; transfer definition parameters
			sta	(VDU_TMP5),Y			; to RAM definition
			dey					; 
			bpl	_BC92D				; 
			rts					; and exit

			pla					; Pull A
_BC937:			rts					; and exit


;************ VDU EXTENSION **********************************************

_LC938:			lda	VDU_QUEUE_4			; A=fifth VDU parameter
			clc					; clear carry
__vdu_23_vduv:		jmp	(VEC_VDUV)			; jump via VDUV vector

;********** VDU control commands *****************************************

_VDU_23_CTRL:		cmp	#$01				; is A=1
			bcc	_VDU_23_SET_CRTC		; if less (0) then set CRT register directly

			bne	__vdu_23_vduv			; if not 1 jump to VDUV for VDU extension

;********** turn cursor on/off *******************************************

			jsr	_LC588				; A=0 if text cursor, A=&20 if graphics cursor
			bne	_BC937				; if graphics exit
			lda	#$20				; A=&20 - preload to turn cursor off
			ldy	VDU_QUEUE_1			; Y=second VDU parameter
			beq	_LC954				; if 0, jump to C954 to turn cursor off
_LC951:			lda	VDU_CURS_PREV			; get last setting of CRT controller register
								; for cursor on
_LC954:			ldy	#$0a				; Y=10 - cursor control register number
			bne	_BC985				; jump to C985, Y=register, Y=value

;********** set CRT controller *******************************************

_VDU_23_SET_CRTC:	lda	VDU_QUEUE_2			; get third
			ldy	VDU_QUEUE_1			; and second parameter
_LC95E:			cpy	#$07				; is Y=7
			bcc	_BC985				; if less C985
			bne	_BC967				; else if >7 C967
			adc	VDU_ADJUST			; else ADD screen vertical display adjustment

_BC967:			cpy	#$08				; If Y<>8
			bne	_BC972				; C972
			ora	#$00				; if bit 7 set
			bmi	_BC972				; C972
			eor	VDU_INTERLACE			; else EOR with interlace toggle

_BC972:			cpy	#$0a				; Y=10??
			bne	_BC985				; if not C985
			sta	VDU_CURS_PREV			; last setting of CRT controller register
			tay					; Y=A
			lda	VDU_STATUS			; VDU status byte
			and	#$20				; check bit 5 printing at graphics cursor??
			php					; push flags
			tya					; Y=A
			ldy	#$0a				; Y=10
			plp					; pull flags
			bne	_BC98B				; if graphics in use then C98B


_BC985:			sty	CRTC_ADDRESS			; else set CRTC address register
			sta	CRTC_DATA			; and poke new value to register Y
_BC98B:			rts					; exit


;*************************************************************************
;*									 *
;*	 VDU 25 - PLOT							 *
;*	 PLOT k,x,y							 *
;*	 DRAW x,y							 *
;*	 MOVE x,y							 *
;*	 PLOT x,y							 *
;*	 5 parameters							 *
;*									 *
;*************************************************************************

_VDU_25:		ldx	VDU_PIX_BYTE			; pixels per byte
			beq	_LC938				; if no graphics available go to VDU Extension
			jmp	_LD060				; else enter Plot routine at D060

;********** adjust screen RAM addresses **********************************

_LC994:			ldx	VDU_MEM				; window area start address lo
			lda	VDU_MEM_HI			; window area start address hi
			jsr	_LCCF8				; subtract bytes per character row from this
			bcs	_BC9B3				; if no wraparound needed C9B3

			adc	VDU_MEM_PAGES			; screen RAM size hi byte to wrap around
			bcc	_BC9B3				; 

_LC9A4:			ldx	VDU_MEM				; window area start address lo
			lda	VDU_MEM_HI			; window area start address hi
			jsr	_LCAD4				; add bytes per char. row
			bpl	_BC9B3				; 

			sec					; wrap around i other direction
			sbc	VDU_MEM_PAGES			; screen RAM size hi byte
_BC9B3:			sta	VDU_MEM_HI			; window area start address hi
			stx	VDU_MEM				; window area start address lo
			ldy	#$0c				; Y=12
			bne	_BCA0E				; jump to CA0E


;*************************************************************************
;*									 *
;*	 VDU 26 - SET DEFAULT WINDOWS					 *
;*									 *
;*************************************************************************

_VDU_26:		lda	#$00				; A=0
			ldx	#$2c				; X=&2C

_BC9C1:			sta	VDU_G_WIN_L,X			; clear all windows
			dex					; 
			bpl	_BC9C1				; until X=&FF

			ldx	VDU_MODE			; screen mode
			ldy	_TEXT_COL_TABLE,X		; text window right hand margin maximum
			sty	VDU_T_WIN_R			; text window right
			jsr	_LCA88				; calculate number of bytes in a line
			ldy	_TEXT_ROW_TABLE,X		; text window bottom margin maximum
			sty	VDU_T_WIN_B			; bottom margin
			ldy	#$03				; Y=3
			sty	VDU_QUEUE_8			; set as last parameter
			iny					; increment Y
			sty	VDU_QUEUE_6			; set parameters
			dec	VDU_QUEUE_7			; 
			dec	VDU_QUEUE_5			; 
			jsr	_VDU_24				; and do VDU 24
			lda	#$f7				; 
			jsr	_LC5A8				; clear bit 3 of &D0
			ldx	VDU_MEM				; window area start address lo
			lda	VDU_MEM_HI			; window area start address hi
_LC9F6:			stx	VDU_CRTC_CUR			; text cursor 6845 address
			sta	VDU_CRTC_CUR_HI			; text cursor 6845 address
			bpl	_LCA02				; set cursor position
			sec					; 
			sbc	VDU_MEM_PAGES			; screen RAM size hi byte

;**************** set cursor position ************************************

_LCA02:			stx	VDU_TOP_SCAN			; set &D8/9 from X/A
			sta	VDU_TOP_SCAN_HI			; 
			ldx	VDU_CRTC_CUR			; text cursor 6845 address
			lda	VDU_CRTC_CUR_HI			; text cursor 6845 address
			ldy	#$0e				; Y=15
_BCA0E:			pha					; Push A
			lda	VDU_MODE			; screen mode
			cmp	#$07				; is it mode 7?
			pla					; get back A
			bcs	_BCA27				; if mode 7 selected CA27
			stx	VDU_TMP1			; else store X
			lsr					; divide X/A by 8
			ror	VDU_TMP1			; 
			lsr					; 
			ror	VDU_TMP1			; 
			lsr					; 
			ror	VDU_TMP1			; 
			ldx	VDU_TMP1			; 
			jmp	_LCA2B				; goto CA2B

_BCA27:			sbc	#$74				; mode 7 subtract &74
			eor	#$20				; EOR with &20
_LCA2B:			sty	CRTC_ADDRESS			; write to CRTC address file register
			sta	CRTC_DATA			; and to relevant address (register 14)
			iny					; Increment Y
			sty	CRTC_ADDRESS			; write to CRTC address file register
			stx	CRTC_DATA			; and to relevant address (register 15)
			rts					; and RETURN

