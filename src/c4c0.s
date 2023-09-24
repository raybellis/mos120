; BBC Operation System OS 1.20		VDU Main Routines

;**************************************************************************
;**************************************************************************
;**									 **
;**	 OSWRCH	 MAIN ROUTINE  entry from E0C5				 **
;**									 **
;**	 output a byte via the VDU stream				 **
;**									 **
;**************************************************************************
;**************************************************************************
;This routine takes up over 40% of the operating system ROM
;Entry points are variable, as are the results achieved.
;Tracing any particular path is relatively easy but generalising for
;commenting is not. For clarity comments will not be as detailed as
;for later parts of the Operating System.

			.org	$c4c0

_VDUCHR:		ldx	OSB_VDU_QSIZE			; get number of items in VDU queue
			bne	_BC512				; if parameters needed then C512
			bit	VDU_STATUS			; else check status byte
			bvc	__vdu_check_delete		; if cursor editing enabled two cursors exist
			jsr	_LC568				; swap values
			jsr	_LCD6A				; then set up write cursor
			bmi	__vdu_check_delete		; if display disabled C4D8
			cmp	#$0d				; else if character in A=RETURN teminate edit
			bne	__vdu_check_delete		; else C4D8

			jsr	_LD918				; terminate edit

__vdu_check_delete:	cmp	#$7f				; is character DELETE ?
			beq	_BC4ED				; if so C4ED

			cmp	#$20				; is it less than space? (i.e. VDU control code)
			bcc	_BC4EF				; if so C4EF
			bit	VDU_STATUS			; else check VDU byte ahain
			bmi	_BC4EA				; if screen disabled C4EA
			jsr	_VDU_OUT_CHAR			; else display a character
			jsr	_VDU_9				; and cursor right
_BC4EA:			jmp	_LC55E				; 

;********* read link addresses and number of parameters *****************

_BC4ED:			lda	#$20				; to replace delete character

;********* read link addresses and number of parameters *****************

_BC4EF:			tay					; Y=A
			lda	_VDU_TABLE_LO,Y			; get lo byte of link address
			sta	VDU_JUMPVEC			; store it in jump vector
			lda	_VDU_TABLE_HI,Y			; get hi byte
			bmi	_BC545				; if negative (as it will be if a direct address)
								; there are no parameters needed
								; so C545
			tax					; else X=A
			ora	#$f0				; set up negated parameter count
			sta	OSB_VDU_QSIZE			; store it as number of items in VDU queue
			txa					; get back A
			lsr					; A=A/16
			lsr					; 
			lsr					; 
			lsr					; 
			clc					; clear carry
			adc	#$c3				; add &C3 to get hi byte of link address
			sta	VDU_JUMPVEC_HI			; 
			bit	VDU_STATUS			; check if cursor editing enabled
			bvs	_BC52F				; if so re-exchange pointers
			clc					; clear carry
_VDU_0_6_27:		rts					; and exit

;return with carry clear indicates that printer action not required.

;********** parameters are outstanding ***********************************
; X=&26A = 2 complement of number of parameters X=&FF for 1, FE for 2 etc.

_BC512:			sta	VDU_QUEUE_8 - 255,X		; store parameter in queue
			inx					; increment X
			stx	OSB_VDU_QSIZE			; store it as VDU queue
			bne	_BC532				; if not 0 C532 as more parameters are needed
			bit	VDU_STATUS			; get VDU status byte
			bmi	_BC534				; if screen disabled C534
			bvs	_BC526				; else if cursor editing C526
			jsr	_VDU_JUMP			; execute required function
			clc					; clear carry
			rts					; and exit

_BC526:			jsr	_LC568				; swap values of cursors
			jsr	_LCD6A				; set up write cursor
			jsr	_VDU_JUMP			; execute required function
_BC52F:			jsr	_LC565				; re-exchange pointers

_BC532:			clc					; carry clear
			rts					; exit

;*************************************************************************
;*									 *
;*	 VDU 1 - SEND NEXT CHARACTER TO PRINTER				 *
;*									 *
;*	 1 parameter required						 *
;*									 *
;*************************************************************************

_BC534:			ldy	VDU_JUMPVEC_HI			; if upper byte of link address not &C5
			cpy	#$c5				; printer is not interested
			bne	_BC532				; so C532
_VDU_1:			tax					; else X=A
			lda	VDU_STATUS			; A=VDU status byte
			lsr					; get bit 0 into carry
			bcc	_VDU_0_6_27			; if printer not enabled exit
			txa					; restore A
			jmp	_PRINTER_OUT_ALWAYS		; else send byte in A (next byte) to printer

;*********** if explicit link address found, no parameters ***************

_BC545:			sta	VDU_JUMPVEC_HI			; upper byte of link address
			tya					; restore A
			cmp	#$08				; is it 7 or less?
			bcc	_BC553				; if so C553
			eor	#$ff				; invert it
			cmp	#$f2				; c is set if A >&0D
			eor	#$ff				; re invert

_BC553:			bit	VDU_STATUS			; VDU status byte
			bmi	_BC580				; if display disabled C580
			php					; push processor flags
			jsr	_VDU_JUMP			; execute required function
			plp					; get back flags
			bcc	_BC561				; if carry clear (from C54B/F)

;**************** main exit routine **************************************

_LC55E:			lda	VDU_STATUS			; VDU status byte
			lsr					; Carry is set if printer is enabled
_BC561:			bit	VDU_STATUS			; VDU status byte
			bvc	_VDU_0_6_27			; if no cursor editing	C511 to exit

;***************** cursor editing routines *******************************

_LC565:			jsr	_LCD7A				; restore normal write cursor

_LC568:			php					; save flags and
			pha					; A
			ldx	#$18				; X=&18
			ldy	#$64				; Y=&64
			jsr	_LCDDE				; exchange &300/1+X with &300/1+Y
			jsr	_LCF06				; set up display address
			jsr	_LCA02				; set cursor position
			lda	VDU_STATUS			; VDU status byte
			eor	#$02				; invert bit 1 to allow or bar scrolling
			sta	VDU_STATUS			; VDU status byte
			pla					; restore flags and A
			plp					; 
			rts					; and exit

_BC580:			eor	#$06				; if A<>6
			bne	_BC58C				; return via C58C
			lda	#$7f				; A=&7F
			bcc	_LC5A8				; and goto C5A8 ALWAYS!!

;******************* check text cursor in use ***************************

_LC588:			lda	VDU_STATUS			; VDU status byte
			and	#$20				; set A from bit 5 of status byte
_BC58C:			rts					; and exit

; A=0 if text cursor, &20 if graphics

;*************************************************************************
;*									 *
;*	 VDU 14 - SET PAGED MODE					 *
;*									 *
;*************************************************************************

_VDU_14:		ldy	#$00				; Y=0
			sty	OSB_HALT_LINES			; paged mode counter
			lda	#$04				; A=04
			bne	_LC59D				; jump to C59D

;*************************************************************************
;*									 *
;*	 VDU 2	- PRINTER ON (START PRINT JOB)				 *
;*									 *
;*************************************************************************

_VDU_2:			jsr	_LE1A2				; select printer buffer and output character
			lda	#$94				; A=&94
								; when inverted at C59B this becomes =&01

;*************************************************************************
;*									 *
;*	 VDU 21 - DISABLE DISPLAY					 *
;*									 *
;*************************************************************************

_VDU_21:		eor	#$95				; if A=&15 A now =&80: if A=&94 A now =1

_LC59D:			ora	VDU_STATUS			; VDU status byte set bit 0 or bit 7
			bne	_BC5AA				; branch forward to store



;*************************************************************************
;*									 *
;*	 VDU 3	- PRINTER OFF (END PRINT JOB)				 *
;*									 *
;*************************************************************************

_VDU_3:			jsr	_LE1A2				; select printer buffer and output character
			lda	#$0a				; A=10 to clear status bits below...

;*************************************************************************
;*									 *
;*	 VDU 15 - PAGED MODE OFF					 *
;*									 *
;*************************************************************************
; A=&F or &A

_VDU_15:		eor	#$f4				; convert to &FB or &FE
_LC5A8:			and	VDU_STATUS			; VDU status byte clear bit 0 or bit 2 of status
_BC5AA:			sta	VDU_STATUS			; VDU status byte
_BC5AC:			rts					; exit

;*************************************************************************
;*									 *
;*	 VDU 4	- OUTPUT AT TEXT CURSOR					 *
;*									 *
;*************************************************************************

_VDU_4:			lda	VDU_PIX_BYTE			; pixels per byte
			beq	_BC5AC				; if no graphics in current mode C5AC
			jsr	_LC951				; set CRT controller for text cursor
			lda	#$df				; this to clear bit 5 of status byte
			bne	_LC5A8				; via C5A8 exit

;*************************************************************************
;*									 *
;*	 VDU 5	- OUTPUT AT GRAPHICS CURSOR				 *
;*									 *
;*************************************************************************

_VDU_5:			lda	VDU_PIX_BYTE			; pixels per byte
			beq	_BC5AC				; if none this is text mode so exit
			lda	#$20				; set up graphics cursor
			jsr	_LC954				; via C954
			bne	_LC59D				; set bit 5 via exit C59D

;*************************************************************************
;*									 *
;*	 VDU 8	- CURSOR LEFT						 *
;*									 *
;*************************************************************************

_VDU_8:			jsr	_LC588				; A=0 if text cursor A=&20 if graphics cursor
			bne	_BC61F				; move cursor left 8 pixels if graphics
			dec	VDU_T_CURS_X			; else decrement text column
			ldx	VDU_T_CURS_X			; store new text column
			cpx	VDU_T_WIN_L			; if it is less than text window left
			bmi	__curs_t_wrap_left		; do wraparound	 cursor to rt of screen 1 line up
			lda	VDU_CRTC_CUR			; text cursor 6845 address
			sec					; subtract
			sbc	VDU_BPC				; bytes per character
			tax					; put in X
			lda	VDU_CRTC_CUR_HI			; get text cursor 6845 address
			sbc	#$00				; subtract 0
			cmp	VDU_PAGE			; compare with hi byte of screen RAM address
			bcs	__curs_t_wrap_top		; if = or greater
			adc	VDU_MEM_PAGES			; add screen RAM size hi byte to wrap around
__curs_t_wrap_top:	tay					; Y=A
			jmp	_LC9F6				; Y hi and X lo byte of cursor position

;***************** execute wraparound left-up*****************************

__curs_t_wrap_left:	lda	VDU_T_WIN_R			; text window right
			sta	VDU_T_CURS_X			; text column

;*************** cursor up ***********************************************

_BC5F4:			dec	OSB_HALT_LINES			; paged mode counter
			bpl	_BC5FC				; if still greater than 0 skip next instruction
			inc	OSB_HALT_LINES			; paged mode counter to restore X=0
_BC5FC:			ldx	VDU_T_CURS_Y			; current text line
			cpx	VDU_T_WIN_T			; top of text window
			beq	_BC60A				; if its at top of window C60A
			dec	VDU_T_CURS_Y			; else decrement current text line
			jmp	_LC6AF				; and carry on moving cursor

;******** cursor at top of window ****************************************

_BC60A:			clc					; clear carry
			jsr	_LCD3F				; check for window violatations
			lda	#$08				; A=8 to check for software scrolling
			bit	VDU_STATUS			; compare against VDU status byte
			bne	_BC619				; if not enabled C619
			jsr	_LC994				; set screen start register and adjust RAM
			bne	_BC61C				; jump C61C

_BC619:			jsr	_LCDA4				; soft scroll 1 line
_BC61C:			jmp	_LC6AC				; and exit

;**********cursor left and down with graphics cursor in use **************

_BC61F:			ldx	#$00				; X=0 to select horizontal parameters

;********** cursor down with graphics in use *****************************
;X=2 for vertical or 0 for horizontal

_LC621:			stx	VDU_TMP2			; store X
			jsr	_LD10D				; check for window violations
			ldx	VDU_TMP2			; restore X
			sec					; set carry
			lda	VDU_G_CURS_H,X			; current graphics cursor X>1=vertical
			sbc	#$08				; subtract 8 to move back 1 character
			sta	VDU_G_CURS_H,X			; store in current graphics cursor X>1=verticaal
			bcs	_BC636				; if carry set skip next
			dec	VDU_G_CURS_H_HI,X		; current graphics cursor hi -1
_BC636:			lda	VDU_TMP1			; &DA=0 if no violation else 1 if vert violation
								; 2 if horizontal violation
			bne	_BC658				; if violation C658
			jsr	_LD10D				; check for window violations
			beq	_BC658				; if none C658

			ldx	VDU_TMP2			; else get back X
			lda	VDU_G_WIN_R,X			; graphics window rt X=0 top X=2
			cpx	#$01				; is X=0
			bcs	_BC64A				; if not C64A
			sbc	#$06				; else subtract 7

_BC64A:			sta	VDU_G_CURS_H,X			; current graphics cursor X>1=vertical
			lda	VDU_G_WIN_R_HI,X		; graphics window hi rt X=0 top X=2
			sbc	#$00				; subtract carry
			sta	VDU_G_CURS_H_HI,X		; current graphics cursor X<2=horizontal else vertical
			txa					; A=X
			beq	_BC660				; cursor up
_BC658:			jmp	_LD1B8				; set up external coordinates for graphics

;*************************************************************************
;*									 *
;*	 VDU 11 - CURSOR UP						 *
;*									 *
;*************************************************************************

_VDU_11:		jsr	_LC588				; A=0 if text cursor A=&20 if graphics cursor
			beq	_BC5F4				; if text cursor then C5F4
_BC660:			ldx	#$02				; else X=2
			bne	_BC6B6				; goto C6B6

;*************************************************************************
;*									 *
;*	 VDU 9	- CURSOR RIGHT						 *
;*									 *
;*************************************************************************

_VDU_9:			lda	VDU_STATUS			; VDU status byte
			and	#$20				; check bit 5
			bne	_BC6B4				; if set then graphics cursor in use so C6B4
			ldx	VDU_T_CURS_X			; text column
			cpx	VDU_T_WIN_R			; text window right
			bcs	_BC684				; if X exceeds window right then C684
			inc	VDU_T_CURS_X			; text column
			lda	VDU_CRTC_CUR			; text cursor 6845 address
			adc	VDU_BPC				; add bytes per character
			tax					; X=A
			lda	VDU_CRTC_CUR_HI			; text cursor 6845 address
			adc	#$00				; add carry if set
			jmp	_LC9F6				; use X and Y to set new cursor address

;********: text cursor down and right *************************************

_BC684:			lda	VDU_T_WIN_L			; text window left
			sta	VDU_T_CURS_X			; text column

;********: text cursor down *************************************

_BC68A:			clc					; clear carry
			jsr	_LCAE3				; check bottom margin, X=line count
			ldx	VDU_T_CURS_Y			; current text line
			cpx	VDU_T_WIN_B			; bottom margin
			bcs	_BC69B				; if X=>current bottom margin C69B
			inc	VDU_T_CURS_Y			; else increment current text line
			bcc	_LC6AF				; 
_BC69B:			jsr	_LCD3F				; check for window violations
			lda	#$08				; check bit 3
			bit	VDU_STATUS			; VDU status byte
			bne	_BC6A9				; if software scrolling enabled C6A9
			jsr	_LC9A4				; perform hardware scroll
			bne	_LC6AC				; 
_BC6A9:			jsr	_LCDFF				; execute upward scroll
_LC6AC:			jsr	_LCEAC				; clear a line

_LC6AF:			jsr	_LCF06				; set up display address
			bcc	_BC732				; 

;*********** graphic cursor right ****************************************

_BC6B4:			ldx	#$00				; 

;************** graphic cursor up  (X=2) **********************************

_BC6B6:			stx	VDU_TMP2			; store X
			jsr	_LD10D				; check for window violations
			ldx	VDU_TMP2			; get back X
			clc					; clear carry
			lda	VDU_G_CURS_H,X			; current graphics cursor X>1=vertical
			adc	#$08				; Add 8 pixels
			sta	VDU_G_CURS_H,X			; current graphics cursor X>1=vertical
			bcc	_BC6CB				; 
			inc	VDU_G_CURS_H_HI,X		; current graphics cursor X<2=horizontal else vertical
_BC6CB:			lda	VDU_TMP1			; A=0 no window violations 1 or 2 indicates violation
			bne	_BC658				; if outside window C658
			jsr	_LD10D				; check for window violations
			beq	_BC658				; if no violations C658

			ldx	VDU_TMP2			; get back X
			lda	VDU_G_WIN_L,X			; graphics window X<2 =left else bottom
			cpx	#$01				; If X=0
			bcc	_BC6DF				; C6DF
			adc	#$06				; else add 7
_BC6DF:			sta	VDU_G_CURS_H,X			; current graphics cursor X>1=vertical
			lda	VDU_G_WIN_L_HI,X		; graphics window hi X<2 =left else bottom
			adc	#$00				; add anny carry
			sta	VDU_G_CURS_H_HI,X		; current graphics cursor X<2=horizontal else vertical
			txa					; A=X
			beq	_BC6F5				; if X=0 C6F5 cursor down
			jmp	_LD1B8				; set up external coordinates for graphics

;*************************************************************************
;*									 *
;*	 VDU 10	 - CURSOR DOWN						 *
;*									 *
;*************************************************************************

_VDU_10:		jsr	_LC588				; A=0 if text cursor A=&20 if graphics cursor
			beq	_BC68A				; if text cursor back to C68A
_BC6F5:			ldx	#$02				; else X=2 to indicate vertical movement
			jmp	_LC621				; move graphics cursor down

;*************************************************************************
;*									 *
;*	 VDU 28 - DEFINE TEXT WINDOW					 *
;*									 *
;*	 4 parameters							 *
;*									 *
;*************************************************************************
;parameters are set up thus
;0320  P1 left margin
;0321  P2 bottom margin
;0322  P3 right margin
;0323  P4 top margin
;Note that last parameter is always in 0323

_VDU_28:		ldx	VDU_MODE			; screen mode
			lda	VDU_QUEUE_6			; get bottom margin
			cmp	VDU_QUEUE_8			; compare with top margin
			bcc	_BC758				; if bottom margin exceeds top return
			cmp	_TEXT_ROW_TABLE,X		; text window bottom margin maximum
			beq	_BC70C				; if equal then its OK
			bcs	_BC758				; else exit

_BC70C:			lda	VDU_QUEUE_7			; get right margin
			tay					; put it in Y
			cmp	_TEXT_COL_TABLE,X		; text window right hand margin maximum
			beq	_BC717				; if equal then OK
			bcs	_BC758				; if greater than maximum exit

_BC717:			sec					; set carry to subtract
			sbc	VDU_QUEUE_5			; left margin
			bmi	_BC758				; if left greater than right exit
			tay					; else A=Y (window width)
			jsr	_LCA88				; calculate number of bytes in a line
			lda	#$08				; A=8 to set bit  of &D0
			jsr	_LC59D				; indicating that text window is defined
			ldx	#$20				; point to parameters
			ldy	#$08				; point to text window margins
			jsr	_LD48A				; (&300/3+Y)=(&300/3+X)
			jsr	_LCEE8				; set up screen address
			bcs	_VDU_30				; home cursor within window
_BC732:			jmp	_LCA02				; set cursor position


