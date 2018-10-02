;BBC Operation System OS 1.20		VDU Main Routines

;**************************************************************************
;**************************************************************************
;**                                                                      **
;**      OSWRCH  MAIN ROUTINE  entry from E0C5                           **
;**                                                                      **
;**      output a byte via the VDU stream                                **
;**                                                                      **
;**************************************************************************
;**************************************************************************
;This routine takes up over 40% of the operating system ROM
;Entry points are variable, as are the results achieved.
;Tracing any particular path is relatively easy but generalising for
;commenting is not. For clarity comments will not be as detailed as
;for later parts of the Operating System.

.org		$c4c0

		ldx	$026A		; get number of items in VDU queue
		bne	$C512		; if parameters needed then C512
		bit	$D0		; else check status byte
		bvc	$C4D8		; if cursor editing enabled two cursors exist
		jsr	$C568		; swap values
		jsr	$CD6A		; then set up write cursor
		bmi	$C4D8		; if display disabled C4D8
		cmp	#$0D		; else if character in A=RETURN teminate edit
		bne	$C4D8		; else C4D8

		jsr	$D918		; terminate edit

		cmp	#$7F		; is character DELETE ?
		beq	$C4ED		; if so C4ED

		cmp	#$20		; is it less than space? (i.e. VDU control code)
		bcc	$C4EF		; if so C4EF
		bit	$D0		; else check VDU byte ahain
		bmi	$C4EA		; if screen disabled C4EA
		jsr	$CFB7		; else display a character
		jsr	$C664		; and cursor right
		jmp	$C55E		; 

;********* read link addresses and number of parameters *****************

		lda	#$20		; to replace delete character

;********* read link addresses and number of parameters *****************

		tay			; Y=A
		lda	$C333,Y		; get lo byte of link address
		sta	$035D		; store it in jump vector
		lda	$C354,Y		; get hi byte
		bmi	$C545		; if negative (as it will be if a direct address)
					; there are no parameters needed
					; so C545
		tax			; else X=A
		ora	#$F0		; set up negated parameter count
		sta	$026A		; store it as number of items in VDU queue
		txa			; get back A
		lsr			; A=A/16
		lsr			; 
		lsr			; 
		lsr			; 
		clc			; clear carry
		adc	#$C3		; add &C3 to get hi byte of link address
		sta	$035E		; 
		bit	$D0		; check if cursor editing enabled
		bvs	$C52F		; if so re-exchange pointers
		clc			; clear carry
		rts			; and exit

;return with carry clear indicates that printer action not required.
;
;********** parameters are outstanding ***********************************
; ### X=&26A = 2 complement of number of parameters X=&FF for 1, FE for 2 etc.

		sta	$0224,X		; store parameter in queue
		inx			; increment X
		stx	$026A		; store it as VDU queue
		bne	$C532		; if not 0 C532 as more parameters are needed
		bit	$D0		; get VDU status byte
		bmi	$C534		; if screen disabled C534
		bvs	$C526		; else if cursor editing C526
		jsr	$CCF5		; execute required function
		clc			; clear carry
		rts			; and exit
;
		jsr	$C568		; swap values of cursors
		jsr	$CD6A		; set up write cursor
		jsr	$CCF5		; execute required function
		jsr	$C565		; re-exchange pointers

		clc			; carry clear
		rts			; exit

;*************************************************************************
;*                                                                       *
;*       VDU 1 - SEND NEXT CHARACTER TO PRINTER                          *
;*                                                                       *
;*       1 parameter required                                            *
;*                                                                       *
;*************************************************************************
;
		ldy	$035E		; if upper byte of link address not &C5
		cpy	#$C5		; printer is not interested
		bne	$C532		; so C532
		tax			; else X=A
		lda	$D0		; A=VDU status byte
		lsr			; get bit 0 into carry
		bcc	$C511		; if printer not enabled exit
		txa			; restore A
		jmp	$E11E		; else send byte in A (next byte) to printer

;*********** if explicit link address found, no parameters ***************

		sta	$035E		; upper byte of link address
		tya			; restore A
		cmp	#$08		; is it 7 or less?
		bcc	$C553		; if so C553
		eor	#$FF		; invert it
		cmp	#$F2		; c is set if A >&0D
		eor	#$FF		; re invert

		bit	$D0		; VDU status byte
		bmi	$C580		; if display disabled C580
		php			; push processor flags
		jsr	$CCF5		; execute required function
		plp			; get back flags
		bcc	$C561		; if carry clear (from C54B/F)

;**************** main exit routine **************************************

		lda	$D0		; VDU status byte
		lsr			; Carry is set if printer is enabled
		bit	$D0		; VDU status byte
		bvc	$C511		; if no cursor editing  C511 to exit

;***************** cursor editing routines *******************************

		jsr	$CD7A		; restore normal write cursor

		php			; save flags and
		pha			; A
		ldx	#$18		; X=&18
		ldy	#$64		; Y=&64
		jsr	$CDDE		; exchange &300/1+X with &300/1+Y
		jsr	$CF06		; set up display address
		jsr	$CA02		; set cursor position
		lda	$D0		; VDU status byte
		eor	#$02		; invert bit 1 to allow or bar scrolling
		sta	$D0		; VDU status byte
		pla			; restore flags and A
		plp			; 
		rts			; and exit
;
		eor	#$06		; if A<>6
		bne	$C58C		; return via C58C
		lda	#$7F		; A=&7F
		bcc	$C5A8		; and goto C5A8 ALWAYS!!

;******************* check text cursor in use ***************************

		lda	$D0		; VDU status byte
		and	#$20		; set A from bit 5 of status byte
		rts			; and exit

; ### A=0 if text cursor, &20 if graphics

;*************************************************************************
;*                                                                       *
;*       VDU 14 - SET PAGED MODE                                         *
;*                                                                       *
;*************************************************************************
;
		ldy	#$00		; Y=0
		sty	$0269		; paged mode counter
		lda	#$04		; A=04
		bne	$C59D		; jump to C59D

;*************************************************************************
;*                                                                       *
;*       VDU 2  - PRINTER ON (START PRINT JOB)                           *
;*                                                                       *
;*************************************************************************

		jsr	$E1A2		; select printer buffer and output character
		lda	#$94		; A=&94
					; when inverted at C59B this becomes =&01

;*************************************************************************
;*                                                                       *
;*       VDU 21 - DISABLE DISPLAY                                        *
;*                                                                       *
;*************************************************************************

		eor	#$95		; if A=&15 A now =&80: if A=&94 A now =1

		ora	$D0		; VDU status byte set bit 0 or bit 7
		bne	$C5AA		; branch forward to store



;*************************************************************************
;*                                                                       *
;*       VDU 3  - PRINTER OFF (END PRINT JOB)                            *
;*                                                                       *
;*************************************************************************

		jsr	$E1A2		; select printer buffer and output character
		lda	#$0A		; A=10 to clear status bits below...

;*************************************************************************
;*                                                                       *
;*       VDU 15 - PAGED MODE OFF                                         *
;*                                                                       *
;*************************************************************************
; A=&F or &A

		eor	#$F4		; convert to &FB or &FE
		and	$D0		; VDU status byte clear bit 0 or bit 2 of status
		sta	$D0		; VDU status byte
		rts			; exit

;*************************************************************************
;*                                                                       *
;*       VDU 4  - OUTPUT AT TEXT CURSOR                                  *
;*                                                                       *
;*************************************************************************
;
		lda	$0361		; pixels per byte
		beq	$C5AC		; if no graphics in current mode C5AC
		jsr	$C951		; set CRT controller for text cursor
		lda	#$DF		; this to clear bit 5 of status byte
		bne	$C5A8		; via C5A8 exit

;*************************************************************************
;*                                                                       *
;*       VDU 5  - OUTPUT AT GRAPHICS CURSOR                              *
;*                                                                       *
;*************************************************************************

		lda	$0361		; pixels per byte
		beq	$C5AC		; if none this is text mode so exit
		lda	#$20		; set up graphics cursor
		jsr	$C954		; via C954
		bne	$C59D		; set bit 5 via exit C59D

;*************************************************************************
;*                                                                       *
;*       VDU 8  - CURSOR LEFT                                            *
;*                                                                       *
;*************************************************************************

		jsr	$C588		; A=0 if text cursor A=&20 if graphics cursor
		bne	$C61F		; move cursor left 8 pixels if graphics
		dec	$0318		; else decrement text column
		ldx	$0318		; store new text column
		cpx	$0308		; if it is less than text window left
		bmi	$C5EE		; do wraparound  cursor to rt of screen 1 line up
		lda	$034A		; text cursor 6845 address
		sec			; subtract
		sbc	$034F		; bytes per character
		tax			; put in X
		lda	$034B		; get text cursor 6845 address
		sbc	#$00		; subtract 0
		cmp	$034E		; compare with hi byte of screen RAM address
		bcs	$C5EA		; if = or greater
		adc	$0354		; add screen RAM size hi byte to wrap around
		tay			; Y=A
		jmp	$C9F6		; Y hi and X lo byte of cursor position

;***************** execute wraparound left-up*****************************

		lda	$030A		; text window right
		sta	$0318		; text column

;*************** cursor up ***********************************************

		dec	$0269		; paged mode counter
		bpl	$C5FC		; if still greater than 0 skip next instruction
		inc	$0269		; paged mode counter to restore X=0
		ldx	$0319		; current text line
		cpx	$030B		; top of text window
		beq	$C60A		; if its at top of window C60A
		dec	$0319		; else decrement current text line
		jmp	$C6AF		; and carry on moving cursor

;******** cursor at top of window ****************************************

		clc			; clear carry
		jsr	$CD3F		; check for window violatations
		lda	#$08		; A=8 to check for software scrolling
		bit	$D0		; compare against VDU status byte
		bne	$C619		; if not enabled C619
		jsr	$C994		; set screen start register and adjust RAM
		bne	$C61C		; jump C61C

		jsr	$CDA4		; soft scroll 1 line
		jmp	$C6AC		; and exit

;**********cursor left and down with graphics cursor in use **************

		ldx	#$00		; X=0 to select horizontal parameters

;********** cursor down with graphics in use *****************************
;X=2 for vertical or 0 for horizontal

		stx	$DB		; store X
		jsr	$D10D		; check for window violations
		ldx	$DB		; restore X
		sec			; set carry
		lda	$0324,X		; current graphics cursor X>1=vertical
		sbc	#$08		; subtract 8 to move back 1 character
		sta	$0324,X		; store in current graphics cursor X>1=verticaal
		bcs	$C636		; if carry set skip next
		dec	$0325,X		; current graphics cursor hi -1
		lda	$DA		; &DA=0 if no violation else 1 if vert violation
					; 2 if horizontal violation
		bne	$C658		; if violation C658
		jsr	$D10D		; check for window violations
		beq	$C658		; if none C658

		ldx	$DB		; else get back X
		lda	$0304,X		; graphics window rt X=0 top X=2
		cpx	#$01		; is X=0
		bcs	$C64A		; if not C64A
		sbc	#$06		; else subtract 7

		sta	$0324,X		; current graphics cursor X>1=vertical
		lda	$0305,X		; graphics window hi rt X=0 top X=2
		sbc	#$00		; subtract carry
		sta	$0325,X		; current graphics cursor X<2=horizontal else vertical
		txa			; A=X
		beq	$C660		; cursor up
		jmp	$D1B8		; set up external coordinates for graphics

;*************************************************************************
;*                                                                       *
;*       VDU 11 - CURSOR UP                                              *
;*                                                                       *
;*************************************************************************

		jsr	$C588		; A=0 if text cursor A=&20 if graphics cursor
		beq	$C5F4		; if text cursor then C5F4
		ldx	#$02		; else X=2
		bne	$C6B6		; goto C6B6

;*************************************************************************
;*                                                                       *
;*       VDU 9  - CURSOR RIGHT                                           *
;*                                                                       *
;*************************************************************************

		lda	$D0		; VDU status byte
		and	#$20		; check bit 5
		bne	$C6B4		; if set then graphics cursor in use so C6B4
		ldx	$0318		; text column
		cpx	$030A		; text window right
		bcs	$C684		; if X exceeds window right then C684
		inc	$0318		; text column
		lda	$034A		; text cursor 6845 address
		adc	$034F		; add bytes per character
		tax			; X=A
		lda	$034B		; text cursor 6845 address
		adc	#$00		; add carry if set
		jmp	$C9F6		; use X and Y to set new cursor address

;********: text cursor down and right *************************************

		lda	$0308		; text window left
		sta	$0318		; text column

;********: text cursor down *************************************

		clc			; clear carry
		jsr	$CAE3		; check bottom margin, X=line count
		ldx	$0319		; current text line
		cpx	$0309		; bottom margin
		bcs	$C69B		; if X=>current bottom margin C69B
		inc	$0319		; else increment current text line
		bcc	$C6AF		; 
		jsr	$CD3F		; check for window violations
		lda	#$08		; check bit 3
		bit	$D0		; VDU status byte
		bne	$C6A9		; if software scrolling enabled C6A9
		jsr	$C9A4		; perform hardware scroll
		bne	$C6AC		; 
		jsr	$CDFF		; execute upward scroll
		jsr	$CEAC		; clear a line

		jsr	$CF06		; set up display address
		bcc	$C732		; 

;*********** graphic cursor right ****************************************

		ldx	#$00		; 

;************** graphic cursor up  (X=2) **********************************

		stx	$DB		; store X
		jsr	$D10D		; check for window violations
		ldx	$DB		; get back X
		clc			; clear carry
		lda	$0324,X		; current graphics cursor X>1=vertical
		adc	#$08		; Add 8 pixels
		sta	$0324,X		; current graphics cursor X>1=vertical
		bcc	$C6CB		; 
		inc	$0325,X		; current graphics cursor X<2=horizontal else vertical
		lda	$DA		; A=0 no window violations 1 or 2 indicates violation
		bne	$C658		; if outside window C658
		jsr	$D10D		; check for window violations
		beq	$C658		; if no violations C658

		ldx	$DB		; get back X
		lda	$0300,X		; graphics window X<2 =left else bottom
		cpx	#$01		; If X=0
		bcc	$C6DF		; C6DF
		adc	#$06		; else add 7
		sta	$0324,X		; current graphics cursor X>1=vertical
		lda	$0301,X		; graphics window hi X<2 =left else bottom
		adc	#$00		; add anny carry
		sta	$0325,X		; current graphics cursor X<2=horizontal else vertical
		txa			; A=X
		beq	$C6F5		; if X=0 C6F5 cursor down
		jmp	$D1B8		; set up external coordinates for graphics

;*************************************************************************
;*                                                                       *
;*       VDU 10  - CURSOR DOWN                                           *
;*                                                                       *
;*************************************************************************

		jsr	$C588		; A=0 if text cursor A=&20 if graphics cursor
		beq	$C68A		; if text cursor back to C68A
		ldx	#$02		; else X=2 to indicate vertical movement
		jmp	$C621		; move graphics cursor down

;*************************************************************************
;*                                                                       *
;*       VDU 28 - DEFINE TEXT WINDOW                                     *
;*                                                                       *
;*       4 parameters                                                    *
;*                                                                       *
;*************************************************************************
;parameters are set up thus
;0320  P1 left margin
;0321  P2 bottom margin
;0322  P3 right margin
;0323  P4 top margin
;Note that last parameter is always in 0323

		ldx	$0355		; screen mode
		lda	$0321		; get bottom margin
		cmp	$0323		; compare with top margin
		bcc	$C758		; if bottom margin exceeds top return
		cmp	$C3E7,X		; text window bottom margin maximum
		beq	$C70C		; if equal then its OK
		bcs	$C758		; else exit

		lda	$0322		; get right margin
		tay			; put it in Y
		cmp	$c3ef,X		; text window right hand margin maximum
		beq	$C717		; if equal then OK
		bcs	$C758		; if greater than maximum exit

		sec			; set carry to subtract
		sbc	$0320		; left margin
		bmi	$C758		; if left greater than right exit
		tay			; else A=Y (window width)
		jsr	$CA88		; calculate number of bytes in a line
		lda	#$08		; A=8 to set bit  of &D0
		jsr	$C59D		; indicating that text window is defined
		ldx	#$20		; point to parameters
		ldy	#$08		; point to text window margins
		jsr	$D48A		; (&300/3+Y)=(&300/3+X)
		jsr	$CEE8		; set up screen address
		bcs	$C779		; home cursor within window
		jmp	$CA02		; set cursor position


