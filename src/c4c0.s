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

_LC4C0:		ldx	$026a		; get number of items in VDU queue
		bne	_BC512		; if parameters needed then C512
		bit	$D0		; else check status byte
		bvc	_BC4D8		; if cursor editing enabled two cursors exist
		jsr	_LC568		; swap values
		jsr	_LCD6A		; then set up write cursor
		bmi	_BC4D8		; if display disabled C4D8
		cmp	#$0D		; else if character in A=RETURN teminate edit
		bne	_BC4D8		; else C4D8

		jsr	_LD918		; terminate edit

_BC4D8:		cmp	#$7F		; is character DELETE ?
		beq	_BC4ED		; if so C4ED

		cmp	#$20		; is it less than space? (i.e. VDU control code)
		bcc	_BC4EF		; if so C4EF
		bit	$D0		; else check VDU byte ahain
		bmi	_BC4EA		; if screen disabled C4EA
		jsr	_LCFB7		; else display a character
		jsr	_LC664		; and cursor right
_BC4EA:		jmp	_LC55E		; 

;********* read link addresses and number of parameters *****************

_BC4ED:		lda	#$20		; to replace delete character

;********* read link addresses and number of parameters *****************

_BC4EF:		tay			; Y=A
		lda	_LC333,Y		; get lo byte of link address
		sta	$035d		; store it in jump vector
		lda	_LC354,Y		; get hi byte
		bmi	_BC545		; if negative (as it will be if a direct address)
					; there are no parameters needed
					; so C545
		tax			; else X=A
		ora	#$F0		; set up negated parameter count
		sta	$026a		; store it as number of items in VDU queue
		txa			; get back A
		lsr			; A=A/16
		lsr			; 
		lsr			; 
		lsr			; 
		clc			; clear carry
		adc	#$C3		; add &C3 to get hi byte of link address
		sta	$035e		; 
		bit	$D0		; check if cursor editing enabled
		bvs	_BC52F		; if so re-exchange pointers
		clc			; clear carry
_BC511:		rts			; and exit

;return with carry clear indicates that printer action not required.
;
;********** parameters are outstanding ***********************************
; ### X=&26A = 2 complement of number of parameters X=&FF for 1, FE for 2 etc.

_BC512:		sta	$0224,X		; store parameter in queue
		inx			; increment X
		stx	$026a		; store it as VDU queue
		bne	_BC532		; if not 0 C532 as more parameters are needed
		bit	$D0		; get VDU status byte
		bmi	_BC534		; if screen disabled C534
		bvs	_BC526		; else if cursor editing C526
		jsr	_LCCF5		; execute required function
		clc			; clear carry
		rts			; and exit
;
_BC526:		jsr	_LC568		; swap values of cursors
		jsr	_LCD6A		; set up write cursor
		jsr	_LCCF5		; execute required function
_BC52F:		jsr	_LC565		; re-exchange pointers

_BC532:		clc			; carry clear
		rts			; exit

;*************************************************************************
;*                                                                       *
;*       VDU 1 - SEND NEXT CHARACTER TO PRINTER                          *
;*                                                                       *
;*       1 parameter required                                            *
;*                                                                       *
;*************************************************************************
;
_BC534:		ldy	$035e		; if upper byte of link address not &C5
		cpy	#$C5		; printer is not interested
		bne	_BC532		; so C532
		tax			; else X=A
		lda	$D0		; A=VDU status byte
		lsr			; get bit 0 into carry
		bcc	_BC511		; if printer not enabled exit
		txa			; restore A
		jmp	_LE11E		; else send byte in A (next byte) to printer

;*********** if explicit link address found, no parameters ***************

_BC545:		sta	$035e		; upper byte of link address
		tya			; restore A
		cmp	#$08		; is it 7 or less?
		bcc	_BC553		; if so C553
		eor	#$FF		; invert it
		cmp	#$F2		; c is set if A >&0D
		eor	#$FF		; re invert

_BC553:		bit	$D0		; VDU status byte
		bmi	_BC580		; if display disabled C580
		php			; push processor flags
		jsr	_LCCF5		; execute required function
		plp			; get back flags
		bcc	_BC561		; if carry clear (from C54B/F)

;**************** main exit routine **************************************

_LC55E:		lda	$D0		; VDU status byte
		lsr			; Carry is set if printer is enabled
_BC561:		bit	$D0		; VDU status byte
		bvc	_BC511		; if no cursor editing  C511 to exit

;***************** cursor editing routines *******************************

_LC565:		jsr	_LCD7A		; restore normal write cursor

_LC568:		php			; save flags and
		pha			; A
		ldx	#$18		; X=&18
		ldy	#$64		; Y=&64
		jsr	_LCDDE		; exchange &300/1+X with &300/1+Y
		jsr	_LCF06		; set up display address
		jsr	_LCA02		; set cursor position
		lda	$D0		; VDU status byte
		eor	#$02		; invert bit 1 to allow or bar scrolling
		sta	$D0		; VDU status byte
		pla			; restore flags and A
		plp			; 
		rts			; and exit
;
_BC580:		eor	#$06		; if A<>6
		bne	_BC58C		; return via C58C
		lda	#$7F		; A=&7F
		bcc	_BC5A8		; and goto C5A8 ALWAYS!!

;******************* check text cursor in use ***************************

_LC588:		lda	$D0		; VDU status byte
		and	#$20		; set A from bit 5 of status byte
_BC58C:		rts			; and exit

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
		bne	_BC59D		; jump to C59D

;*************************************************************************
;*                                                                       *
;*       VDU 2  - PRINTER ON (START PRINT JOB)                           *
;*                                                                       *
;*************************************************************************

		jsr	_LE1A2		; select printer buffer and output character
		lda	#$94		; A=&94
					; when inverted at C59B this becomes =&01

;*************************************************************************
;*                                                                       *
;*       VDU 21 - DISABLE DISPLAY                                        *
;*                                                                       *
;*************************************************************************

		eor	#$95		; if A=&15 A now =&80: if A=&94 A now =1

_BC59D:		ora	$D0		; VDU status byte set bit 0 or bit 7
		bne	_BC5AA		; branch forward to store



;*************************************************************************
;*                                                                       *
;*       VDU 3  - PRINTER OFF (END PRINT JOB)                            *
;*                                                                       *
;*************************************************************************

		jsr	_LE1A2		; select printer buffer and output character
		lda	#$0A		; A=10 to clear status bits below...

;*************************************************************************
;*                                                                       *
;*       VDU 15 - PAGED MODE OFF                                         *
;*                                                                       *
;*************************************************************************
; A=&F or &A

		eor	#$F4		; convert to &FB or &FE
_BC5A8:		and	$D0		; VDU status byte clear bit 0 or bit 2 of status
_BC5AA:		sta	$D0		; VDU status byte
_BC5AC:		rts			; exit

;*************************************************************************
;*                                                                       *
;*       VDU 4  - OUTPUT AT TEXT CURSOR                                  *
;*                                                                       *
;*************************************************************************
;
		lda	$0361		; pixels per byte
		beq	_BC5AC		; if no graphics in current mode C5AC
		jsr	_LC951		; set CRT controller for text cursor
		lda	#$DF		; this to clear bit 5 of status byte
		bne	_BC5A8		; via C5A8 exit

;*************************************************************************
;*                                                                       *
;*       VDU 5  - OUTPUT AT GRAPHICS CURSOR                              *
;*                                                                       *
;*************************************************************************

		lda	$0361		; pixels per byte
		beq	_BC5AC		; if none this is text mode so exit
		lda	#$20		; set up graphics cursor
		jsr	_LC954		; via C954
		bne	_BC59D		; set bit 5 via exit C59D

;*************************************************************************
;*                                                                       *
;*       VDU 8  - CURSOR LEFT                                            *
;*                                                                       *
;*************************************************************************

_LC5C5:		jsr	_LC588		; A=0 if text cursor A=&20 if graphics cursor
		bne	_BC61F		; move cursor left 8 pixels if graphics
		dec	$0318		; else decrement text column
		ldx	$0318		; store new text column
		cpx	$0308		; if it is less than text window left
		bmi	_BC5EE		; do wraparound  cursor to rt of screen 1 line up
		lda	$034a		; text cursor 6845 address
		sec			; subtract
		sbc	$034f		; bytes per character
		tax			; put in X
		lda	$034b		; get text cursor 6845 address
		sbc	#$00		; subtract 0
		cmp	$034e		; compare with hi byte of screen RAM address
		bcs	_BC5EA		; if = or greater
		adc	$0354		; add screen RAM size hi byte to wrap around
_BC5EA:		tay			; Y=A
		jmp	_LC9F6		; Y hi and X lo byte of cursor position

;***************** execute wraparound left-up*****************************

_BC5EE:		lda	$030a		; text window right
		sta	$0318		; text column

;*************** cursor up ***********************************************

_BC5F4:		dec	$0269		; paged mode counter
		bpl	_BC5FC		; if still greater than 0 skip next instruction
		inc	$0269		; paged mode counter to restore X=0
_BC5FC:		ldx	$0319		; current text line
		cpx	$030b		; top of text window
		beq	_BC60A		; if its at top of window C60A
		dec	$0319		; else decrement current text line
		jmp	_LC6AF		; and carry on moving cursor

;******** cursor at top of window ****************************************

_BC60A:		clc			; clear carry
		jsr	_LCD3F		; check for window violatations
		lda	#$08		; A=8 to check for software scrolling
		bit	$D0		; compare against VDU status byte
		bne	_BC619		; if not enabled C619
		jsr	_LC994		; set screen start register and adjust RAM
		bne	_BC61C		; jump C61C

_BC619:		jsr	_LCDA4		; soft scroll 1 line
_BC61C:		jmp	_LC6AC		; and exit

;**********cursor left and down with graphics cursor in use **************

_BC61F:		ldx	#$00		; X=0 to select horizontal parameters

;********** cursor down with graphics in use *****************************
;X=2 for vertical or 0 for horizontal

_LC621:		stx	$DB		; store X
		jsr	_LD10D		; check for window violations
		ldx	$DB		; restore X
		sec			; set carry
		lda	$0324,X		; current graphics cursor X>1=vertical
		sbc	#$08		; subtract 8 to move back 1 character
		sta	$0324,X		; store in current graphics cursor X>1=verticaal
		bcs	_BC636		; if carry set skip next
		dec	$0325,X		; current graphics cursor hi -1
_BC636:		lda	$DA		; &DA=0 if no violation else 1 if vert violation
					; 2 if horizontal violation
		bne	_BC658		; if violation C658
		jsr	_LD10D		; check for window violations
		beq	_BC658		; if none C658

		ldx	$DB		; else get back X
		lda	$0304,X		; graphics window rt X=0 top X=2
		cpx	#$01		; is X=0
		bcs	_BC64A		; if not C64A
		sbc	#$06		; else subtract 7

_BC64A:		sta	$0324,X		; current graphics cursor X>1=vertical
		lda	$0305,X		; graphics window hi rt X=0 top X=2
		sbc	#$00		; subtract carry
		sta	$0325,X		; current graphics cursor X<2=horizontal else vertical
		txa			; A=X
		beq	_BC660		; cursor up
_BC658:		jmp	_LD1B8		; set up external coordinates for graphics

;*************************************************************************
;*                                                                       *
;*       VDU 11 - CURSOR UP                                              *
;*                                                                       *
;*************************************************************************

		jsr	_LC588		; A=0 if text cursor A=&20 if graphics cursor
		beq	_BC5F4		; if text cursor then C5F4
_BC660:		ldx	#$02		; else X=2
		bne	_BC6B6		; goto C6B6

;*************************************************************************
;*                                                                       *
;*       VDU 9  - CURSOR RIGHT                                           *
;*                                                                       *
;*************************************************************************

_LC664:		lda	$D0		; VDU status byte
		and	#$20		; check bit 5
		bne	_BC6B4		; if set then graphics cursor in use so C6B4
		ldx	$0318		; text column
		cpx	$030a		; text window right
		bcs	_BC684		; if X exceeds window right then C684
		inc	$0318		; text column
		lda	$034a		; text cursor 6845 address
		adc	$034f		; add bytes per character
		tax			; X=A
		lda	$034b		; text cursor 6845 address
		adc	#$00		; add carry if set
		jmp	_LC9F6		; use X and Y to set new cursor address

;********: text cursor down and right *************************************

_BC684:		lda	$0308		; text window left
		sta	$0318		; text column

;********: text cursor down *************************************

_BC68A:		clc			; clear carry
		jsr	_LCAE3		; check bottom margin, X=line count
		ldx	$0319		; current text line
		cpx	$0309		; bottom margin
		bcs	_BC69B		; if X=>current bottom margin C69B
		inc	$0319		; else increment current text line
		bcc	_LC6AF		; 
_BC69B:		jsr	_LCD3F		; check for window violations
		lda	#$08		; check bit 3
		bit	$D0		; VDU status byte
		bne	_BC6A9		; if software scrolling enabled C6A9
		jsr	_LC9A4		; perform hardware scroll
		bne	_LC6AC		; 
_BC6A9:		jsr	_LCDFF		; execute upward scroll
_LC6AC:		jsr	_LCEAC		; clear a line

_LC6AF:		jsr	_LCF06		; set up display address
		bcc	_BC732		; 

;*********** graphic cursor right ****************************************

_BC6B4:		ldx	#$00		; 

;************** graphic cursor up  (X=2) **********************************

_BC6B6:		stx	$DB		; store X
		jsr	_LD10D		; check for window violations
		ldx	$DB		; get back X
		clc			; clear carry
		lda	$0324,X		; current graphics cursor X>1=vertical
		adc	#$08		; Add 8 pixels
		sta	$0324,X		; current graphics cursor X>1=vertical
		bcc	_BC6CB		; 
		inc	$0325,X		; current graphics cursor X<2=horizontal else vertical
_BC6CB:		lda	$DA		; A=0 no window violations 1 or 2 indicates violation
		bne	_BC658		; if outside window C658
		jsr	_LD10D		; check for window violations
		beq	_BC658		; if no violations C658

		ldx	$DB		; get back X
		lda	$0300,X		; graphics window X<2 =left else bottom
		cpx	#$01		; If X=0
		bcc	_BC6DF		; C6DF
		adc	#$06		; else add 7
_BC6DF:		sta	$0324,X		; current graphics cursor X>1=vertical
		lda	$0301,X		; graphics window hi X<2 =left else bottom
		adc	#$00		; add anny carry
		sta	$0325,X		; current graphics cursor X<2=horizontal else vertical
		txa			; A=X
		beq	_BC6F5		; if X=0 C6F5 cursor down
		jmp	_LD1B8		; set up external coordinates for graphics

;*************************************************************************
;*                                                                       *
;*       VDU 10  - CURSOR DOWN                                           *
;*                                                                       *
;*************************************************************************

		jsr	_LC588		; A=0 if text cursor A=&20 if graphics cursor
		beq	_BC68A		; if text cursor back to C68A
_BC6F5:		ldx	#$02		; else X=2 to indicate vertical movement
		jmp	_LC621		; move graphics cursor down

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
		bcc	_BC758		; if bottom margin exceeds top return
		cmp	_LC3E7,X		; text window bottom margin maximum
		beq	_BC70C		; if equal then its OK
		bcs	_BC758		; else exit

_BC70C:		lda	$0322		; get right margin
		tay			; put it in Y
		cmp	_LC3EF,X		; text window right hand margin maximum
		beq	_BC717		; if equal then OK
		bcs	_BC758		; if greater than maximum exit

_BC717:		sec			; set carry to subtract
		sbc	$0320		; left margin
		bmi	_BC758		; if left greater than right exit
		tay			; else A=Y (window width)
		jsr	_LCA88		; calculate number of bytes in a line
		lda	#$08		; A=8 to set bit  of &D0
		jsr	_BC59D		; indicating that text window is defined
		ldx	#$20		; point to parameters
		ldy	#$08		; point to text window margins
		jsr	_LD48A		; (&300/3+Y)=(&300/3+X)
		jsr	_LCEE8		; set up screen address
		bcs	_BC779		; home cursor within window
_BC732:		jmp	_LCA02		; set cursor position


