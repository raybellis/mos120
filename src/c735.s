;*************************************************************************
;*                                                                       *
;*       OSWORD 9  - READ A PIXEL                                        *
;*       =POINT(X,Y)                                                     *
;*                                                                       *
;*************************************************************************
;on entry  &EF=A=9
;   	   &F0=X=low byte of parameter block address
;   	   &F1=Y=high byte of parameter block address
;   	PARAMETER BLOCK
;       0,1=X coordinate
;       2,3=Y coordinate
;on exit, result in BLOCK+4
;     =&FF if point was of screen or logical colour of point if on screen
;
.org		$c735

		ldy	#$03		; Y=3 to point to hi byte of Y coordinate
		lda	($F0),Y		; get it
		sta	$0328,Y		; store it
		dey			; point to next byte
		bpl	$C737		; transfer till Y=&FF lo byte of X coordinate in &328
		lda	#$28		; 
		jsr	$D839		; check window boundaries
		ldy	#$04		; Y=4
		bne	$C750		; jump to C750


;*************************************************************************
;*                                                                       *
;*       OSWORD 11 - READ PALLETTE                                       *
;*                                                                       *
;*************************************************************************
;on entry  &EF=A=11
;   	   &F0=X=low byte of parameter block address
;   	   &F1=Y=high byte of parameter block address
;   	PARAMETER BLOCK
;       0=logical colour to read
;on exit, result in BLOCK
;       0=logical colour
;       1=physical colour
;       2=red colour component  \
;       3=green colour component } when set using analogue colours
;       4=blue colour component /

		and	$0360		; number of logical colours less 1
		tax			; put it in X
		lda	$036F,X		; colour pallette
		iny			; increment Y to point to byte 1

		sta	($F0),Y		; store data
		lda	#$00		; issue 0s
		cpy	#$04		; to next bytes until Y=4
		bne	$C74F		; 

		rts			; and exit


;*************************************************************************
;*                                                                       *
;*       VDU 12 - CLEAR TEXT SCREEN                                      *
;*       CLS                                                             *
;*                                                                       *
;*************************************************************************
;
		jsr	$C588		; A=0 if text cursor A=&20 if graphics cursor
		bne	$C7BD		; if graphics cursor &C7BD
		lda	$D0		; VDU status byte
		and	#$08		; check if software scrolling (text window set)
		bne	$C767		; if so C767
		jmp	$CBC1		; initialise screen display and home cursor

		ldx	$030B		; top of text window
		stx	$0319		; current text line
		jsr	$CEAC		; clear a line

		ldx	$0319		; current text line
		cpx	$0309		; bottom margin
		inx			; X=X+1
		bcc	$C76A		; if X at compare is less than bottom margin clear next


;*************************************************************************
;*                                                                       *
;*       VDU 30 - HOME CURSOR                                            *
;*                                                                       *
;*************************************************************************

		jsr	$C588		; A=0 if text cursor A=&20 if graphics cursor
		beq	$C781		; if text cursor C781
		jmp	$CFA6		; home graphic cursor if graphic
		sta	$0323		; store 0 in last two parameters
		sta	$0322		; 


;*************************************************************************
;*                                                                       *
;*       VDU 31 - POSITION TEXT CURSOR                                   *
;*       TAB(X,Y)                                                        *
;*                                                                       *
;*       2 parameters                                                    *
;*                                                                       *
;*************************************************************************
;0322 = supplied X coordinate
;0323 = supplied Y coordinate

		jsr	$C588		; A=0 if text cursor A=&20 if graphics cursor
		bne	$C758		; exit
		jsr	$C7A8		; exchange text column/line with workspace 0328/9
		clc			; clear carry
		lda	$0322		; get X coordinate
		adc	$0308		; add to text window left
		sta	$0318		; store as text column
		lda	$0323		; get Y coordinate
		clc			; 
		adc	$030B		; add top of text window
		sta	$0319		; current text line
		jsr	$CEE8		; set up screen address
		bcc	$C732		; set cursor position if C=0 (point on screen)
		ldx	#$18		; else point to workspace
		ldy	#$28		; and line/column to restore old values
		jmp	$CDDE		; exchange &300/1+X with &300/1+Y


;*************************************************************************
;*                                                                       *
;*       VDU 13 - CARRIAGE RETURN                                        *
;*                                                                       *
;*************************************************************************

		jsr	$C588		; A=0 if text cursor A=&20 if graphics cursor
		beq	$C7B7		; if text C7B7
		jmp	$CFAD		; else set graphics cursor to left hand columm

		jsr	$CE6E		; set text column to left hand column
		jmp	$C6AF		; set up cursor and display address

		jsr	$CFA6		; home graphic cursor


;*************************************************************************
;*                                                                       *
;*       VDU 16 - CLEAR GRAPHICS SCREEN                                  *
;*       CLG                                                             *
;*                                                                       *
;*************************************************************************

		lda	$0361		; pixels per byte
		beq	$C7F8		; if 0 current mode has no graphics so exit
		ldx	$035A		; Background graphics colour
		ldy	$035C		; background graphics plot mode (GCOL n)
		jsr	$D0B3		; set graphics byte mask in &D4/5
		ldx	#$00		; graphics window
		ldy	#$28		; workspace
		jsr	$D47C		; set(300/7+Y) from (300/7+X)
		sec			; set carry
		lda	$0306		; graphics window top lo.
		sbc	$0302		; graphics window bottom lo
		tay			; Y=difference
		iny			; increment
		sty	$0330		; and store in workspace (this is line count)
		ldx	#$2C		; 
		ldy	#$28		; 
		jsr	$D6A6		; clear line
		lda	$032E		; decrement window height in pixels
		bne	$C7F0		; 
		dec	$032F		; 
		dec	$032E		; 
		dec	$0330		; decrement line count
		bne	$C7E1		; if <>0 then do it again
		rts			; exit


;*************************************************************************
;*                                                                       *
;*       VDU 17 - DEFINE TEXT COLOUR                                     *
;*       COLOUR n                                                        *
;*                                                                       *
;*       1 parameter                                                     *
;*                                                                       *
;*************************************************************************
;parameter in &0323

		ldy	#$00		; Y=0
		beq	$C7FF		; jump to C7FF


;*************************************************************************
;*                                                                       *
;*       VDU 18 - DEFINE GRAPHICS COLOUR                                 *
;*       GCOL k,c                                                        *
;*                                                                       *
;*       2 parameters                                                    *
;*                                                                       *
;*************************************************************************
;parameters in 323,322

		ldy	#$02		; Y=2

		lda	$0323		; get last parameter
		bpl	$C805		; if +ve it's foreground colour so C805
		iny			; else Y=Y+1
		and	$0360		; number of logical colours less 1
		sta	$DA		; store it
		lda	$0360		; number of logical colours less 1
		beq	$C82B		; if none exit
		and	#$07		; else limit to an available colour and clear M
		clc			; clear carry
		adc	$DA		; Add last parameter to get pointer to table
		tax			; pointer into X

		lda	$C423,X		; get plot options from table
		sta	$0357,Y		; colour Y=0=text fgnd 1= text bkgnd 2=graphics fg etc
		cpy	#$02		; If Y>1
		bcs	$C82C		; then its graphics so C82C else
		lda	$0357		; foreground text colour
		eor	#$FF		; invert
		sta	$D3		; text colour byte to be orred or EORed into memory
		eor	$0358		; background text colour
		sta	$D2		; text colour byte to be orred or EORed into memory
		rts			; and exit
;
		lda	$0322		; get first parameter
		sta	$0359,Y		; text colour Y=0=foreground 1=background etc.
		rts			; exit
;
		lda	#$20		; 
		sta	$0358		; background text colour
		rts			; 


;*************************************************************************
;*                                                                       *
;*       VDU 20 - RESTORE DEFAULT COLOURS                                *
;*                                                                       *
;*************************************************************************
;
		ldx	#$05		; X=5

		lda	#$00		; A=0
		sta	$0357,X		; zero all colours
		dex			; 
		bpl	$C83D		; until X=&FF
		ldx	$0360		; number of logical colours less 1
		beq	$C833		; if none its MODE 7 so C833
		lda	#$FF		; A=&FF
		cpx	#$0F		; if not mode 2 (16 colours)
		bne	$C850		; goto C850

		lda	#$3F		; else A=&3F
		sta	$0357		; foreground text colour
		sta	$0359		; foreground graphics colour
		eor	#$FF		; invert A
		sta	$D2		; text colour byte to be orred or EORed into memory
		sta	$D3		; text colour byte to be orred or EORed into memory
		stx	$031F		; set first parameter of 5
		cpx	#$03		; if there are 4 colours
		beq	$C874		; goto C874
		bcc	$C885		; if less there are 2 colours goto C885
					; else there are 16 colours
		stx	$0320		; set second parameter
		jsr	$C892		; do VDU 19 etc
		dec	$0320		; decrement first parameter
		dec	$031F		; and last parameter
		bpl	$C868		; 
		rts			; 
;
;********* 4 colour mode *************************************************

		ldx	#$07		; X=7
		stx	$0320		; set first parameter
		jsr	$C892		; and do VDU 19
		lsr	$0320		; 
		dec	$031F		; 
		bpl	$C879		; 
		rts			; exit

;********* 2 colour mode ************************************************

		ldx	#$07		; X=7
		jsr	$C88F		; execute VDU 19
		ldx	#$00		; X=0
		stx	$031F		; store it as
		stx	$0320		; both parameters


;*************************************************************************
;*                                                                       *
;*       VDU 19 - DEFINE COLOURS                                         *
;*      [COLOUR l,p]                                                     *
;*      [COLOUR l,r,g,b]                                                 *
;*                                                                       *
;*       5 parameters                                                    *
;*                                                                       *
;*************************************************************************
;&31F=first parameter logical colour
;&320=second physical colour

		php			; push processor flags
		sei			; disable interrupts
		lda	$031F		; get first parameter and
		and	$0360		; number of logical colours less 1
		tax			; toi make legal  X=A
		lda	$0320		; A=second parameter
		and	#$0F		; make legal
		sta	$036F,X		; colour pallette
		tay			; Y=A
		lda	$0360		; number of logical colours less 1
		sta	$FA		; store it
		cmp	#$03		; is it 4 colour mode??
		php			; save flags
		txa			; A=X
		ror			; rotate A into &FA
		ror	$FA		; 
		bcs	$C8AD		; 
		asl	$FA		; 
		tya			; A=Y
		ora	$FA		; 
		tax			; 
		ldy	#$00		; Y=0
		plp			; check flags
		php			; 
		bne	$C8CC		; if A<>3 earlier C8CC
		and	#$60		; else A=&60 to test bits 5 and 6
		beq	$C8CB		; if not set C8CB
		cmp	#$60		; else if both set
		beq	$C8CB		; C8CB
		txa			; A=X
		eor	#$60		; invert
		bne	$C8CC		; and if not 0 C8CC

		txa			; X=A
		jsr	$EA11		; call Osbyte 155 pass data to pallette register
		tya			; 
		sec			; 
		adc	$0360		; number of logical colours less 1
		tay			; 
		txa			; 
		adc	#$10		; 
		tax			; 
		cpy	#$10		; if Y<16 do it again
		bcc	$C8BA		; 
		plp			; pull flags twice
		plp			; 
		rts			; and exit


;*************************************************************************
;*                                                                       *
;*       OSWORD 12 - WRITE PALLETTE                                      *
;*                                                                       *
;*************************************************************************
;on entry X=&F0:Y=&F1:YX points to parameter block
;byte 0 = logical colour;  byte 1 physical colour; bytes 2-4=0

		php			; push flags
		and	$0360		; and with number of logical colours less 1
		tax			; X=A
		iny			; Y=Y+1
		lda	($F0),Y		; get phsical colour
		jmp	$C89E		; do VDU19 with parameters in X and A


;*************************************************************************
;*                                                                       *
;*       VDU 22 - SELECT MODE                                            *
;*       MODE n                                                          *
;*                                                                       *
;*       1 parameter                                                     *
;*                                                                       *
;*************************************************************************
;parameter in &323

		lda	$0323		; get parameter
		jmp	$CB33		; goto CB33


;*************************************************************************
;*                                                                       *
;*       VDU 23 - DEFINE CHARACTERS                                      *
;*                                                                       *
;*       9 parameters                                                    *
;*                                                                       *
;*************************************************************************
;parameters are:-
;31B character to define
;31C to 323 definition

		lda	$031B		; get character to define
		cmp	#$20		; is it ' '
		bcc	$C93F		; if less then it is a control instruction, goto C93F
		pha			; else save parameter
		lsr			; A=A/32
		lsr			; 
		lsr			; 
		lsr			; 
		lsr			; 
		tax			; X=A
		lda	$C40D,X		; get font flag mask from table (A=&80/2^X)
		bit	$0367		; font flag
		bne	$C927		; and if A<>0 C927 storage area is established already
		ora	$0367		; or with font flag to set bit found to be 0
		sta	$0367		; font flag
		txa			; get back A
		and	#$03		; And 3 to clear all but bits 0 and 1
		clc			; clear carry
		adc	#$BF		; add &BF (A=&C0,&C1,&C2) to select a character page
		sta	$DF		; store it
		lda	$0367,X		; get font location byte (normally &0C)
		sta	$DD		; store it
		ldy	#$00		; Y=0 so (&DE) holds (&C000 -&C2FF)
		sty	$DC		; 
		sty	$DE		; 
		lda	($DE),Y		; transfer page to storage area
		sta	($DC),Y		; 
		dey			; 
		bne	$C920		; 

		pla			; get back A
		jsr	$D03E		; set up character definition pointers

		ldy	#$07		; Y=7
		lda	$031C,Y		; transfer definition parameters
		sta	($DE),Y		; to RAM definition
		dey			; 
		bpl	$C92D		; 
		rts			; and exit
;
		pla			; Pull A
		rts			; and exit


;************ VDU EXTENSION **********************************************

		lda	$031F		; A=fifth VDU parameter
		clc			; clear carry
		jmp	($0226)		; jump via VDUV vector

;********** VDU control commands *****************************************

		cmp	#$01		; is A=1
		bcc	$C958		; if less (0) then set CRT register directly

		bne	$C93C		; if not 1 jump to VDUV for VDU extension

;********** turn cursor on/off *******************************************

		jsr	$C588		; A=0 if text cursor, A=&20 if graphics cursor
		bne	$C937		; if graphics exit
		lda	#$20		; A=&20 - preload to turn cursor off
		ldy	$031C		; Y=second VDU parameter
		beq	$C954		; if 0, jump to C954 to turn cursor off
		lda	$035F		; get last setting of CRT controller register
					; for cursor on
		ldy	#$0A		; Y=10 - cursor control register number
		bne	$C985		; jump to C985, Y=register, Y=value

;********** set CRT controller *******************************************

		lda	$031D		; get third
		ldy	$031C		; and second parameter
		cpy	#$07		; is Y=7
		bcc	$C985		; if less C985
		bne	$C967		; else if >7 C967
		adc	$0290		; else ADD screen vertical display adjustment

		cpy	#$08		; If Y<>8
		bne	$C972		; C972
		ora	#$00		; if bit 7 set
		bmi	$C972		; C972
		eor	$0291		; else EOR with interlace toggle

		cpy	#$0A		; Y=10??
		bne	$C985		; if not C985
		sta	$035F		; last setting of CRT controller register
		tay			; Y=A
		lda	$D0		; VDU status byte
		and	#$20		; check bit 5 printing at graphics cursor??
		php			; push flags
		tya			; Y=A
		ldy	#$0A		; Y=10
		plp			; pull flags
		bne	$C98B		; if graphics in use then C98B


		sty	$FE00		; else set CRTC address register
		sta	$FE01		; and poke new value to register Y
		rts			; exit


;*************************************************************************
;*                                                                       *
;*       VDU 25 - PLOT                                                   *
;*       PLOT k,x,y                                                      *
;*       DRAW x,y                                                        *
;*       MOVE x,y                                                        *
;*       PLOT x,y                                                        *
;*       5 parameters                                                    *
;*                                                                       *
;*************************************************************************
;
		ldx	$0361		; pixels per byte
		beq	$C938		; if no graphics available go to VDU Extension
		jmp	$D060		; else enter Plot routine at D060

;********** adjust screen RAM addresses **********************************

		ldx	$0350		; window area start address lo
		lda	$0351		; window area start address hi
		jsr	$CCF8		; subtract bytes per character row from this
		bcs	$C9B3		; if no wraparound needed C9B3

		adc	$0354		; screen RAM size hi byte to wrap around
		bcc	$C9B3		; 

		ldx	$0350		; window area start address lo
		lda	$0351		; window area start address hi
		jsr	$CAD4		; add bytes per char. row
		bpl	$C9B3		; 

		sec			; wrap around i other direction
		sbc	$0354		; screen RAM size hi byte
		sta	$0351		; window area start address hi
		stx	$0350		; window area start address lo
		ldy	#$0C		; Y=12
		bne	$CA0E		; jump to CA0E


;*************************************************************************
;*                                                                       *
;*       VDU 26 - SET DEFAULT WINDOWS                                    *
;*                                                                       *
;*************************************************************************

		lda	#$00		; A=0
		ldx	#$2C		; X=&2C

		sta	$0300,X		; clear all windows
		dex			; 
		bpl	$C9C1		; until X=&FF

		ldx	$0355		; screen mode
		ldy	$c3ef,X		; text window right hand margin maximum
		sty	$030A		; text window right
		jsr	$CA88		; calculate number of bytes in a line
		ldy	$C3E7,X		; text window bottom margin maximum
		sty	$0309		; bottom margin
		ldy	#$03		; Y=3
		sty	$0323		; set as last parameter
		iny			; increment Y
		sty	$0321		; set parameters
		dec	$0322		; 
		dec	$0320		; 
		jsr	$CA39		; and do VDU 24
		lda	#$F7		; 
		jsr	$C5A8		; clear bit 3 of &D0
		ldx	$0350		; window area start address lo
		lda	$0351		; window area start address hi
		stx	$034A		; text cursor 6845 address
		sta	$034B		; text cursor 6845 address
		bpl	$CA02		; set cursor position
		sec			; 
		sbc	$0354		; screen RAM size hi byte

;**************** set cursor position ************************************

		stx	$D8		; set &D8/9 from X/A
		sta	$D9		; 
		ldx	$034A		; text cursor 6845 address
		lda	$034B		; text cursor 6845 address
		ldy	#$0E		; Y=15
		pha			; Push A
		lda	$0355		; screen mode
		cmp	#$07		; is it mode 7?
		pla			; get back A
		bcs	$CA27		; if mode 7 selected CA27
		stx	$DA		; else store X
		lsr			; divide X/A by 8
		ror	$DA		; 
		lsr			; 
		ror	$DA		; 
		lsr			; 
		ror	$DA		; 
		ldx	$DA		; 
		jmp	$CA2B		; goto CA2B

		sbc	#$74		; mode 7 subtract &74
		eor	#$20		; EOR with &20
		sty	$FE00		; write to CRTC address file register
		sta	$FE01		; and to relevant address (register 14)
		iny			; Increment Y
		sty	$FE00		; write to CRTC address file register
		stx	$FE01		; and to relevant address (register 15)
		rts			; and RETURN

