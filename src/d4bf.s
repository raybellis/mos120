; OS SERIES IV
; GEOFF COX

;*************************************************************************
;*									 *
;*  LATERAL FILL ROUTINE						 *
;*									 *
;*************************************************************************

			.org	$d4bf

_LD4BF:			jsr	_LD4AA				; check current screen state
			and	VDU_G_PIX_MASK			; if A and &D1 <> 0 a plotted point has been found
			bne	_BD4B9				; so D4B9
			ldx	#$00				; X=0
			jsr	_LD592				; update pointers
			beq	_BD4FA				; if 0 then D4FA
			ldy	VDU_G_CURS_SCAN			; else Y=graphics scan line
			asl	VDU_G_PIX_MASK			; 
			bcs	_BD4D9				; if carry set D4D9
			jsr	_LD574				; else D574
			bcc	_BD4FA				; if carry clear D4FA
_BD4D9:			jsr	_LD3FD				; else D3FD to pick up colour multiplier
			lda	(VDU_G_MEM),Y			; get graphics cell line
			eor	VDU_G_BG			; EOR with background colour
			sta	VDU_TMP1			; and store
			bne	_BD4F7				; if not 0 D4F7
			sec					; else set carry
			txa					; A=X
			adc	VDU_PIX_BYTE			; add pixels/byte
			bcc	_BD4F0				; and if carry clear D4F0
			inc	VDU_TMP2			; else increment &DB
			bpl	_BD4F7				; and if +ve D4F7

_BD4F0:			tax					; else X=A
			jsr	_LD104				; display a pixel
			sec					; set carry
			bcs	_BD4D9				; goto D4D9

_BD4F7:			jsr	_LD574				; 
_BD4FA:			ldy	#$00				; Y=0
			jsr	_LD5AC				; 
			ldy	#$20				; 
			ldx	#$24				; 
			jsr	_LCDE6				; exchange 300/3 +Y with 300/3+X
_LD506:			jsr	_LD4AA				; check screen pixel
			ldx	#$04				; Y=5
			jsr	_LD592				; 
			txa					; A=x
			bne	_BD513				; if A<>0 d513
			dec	VDU_TMP2			; else	&DB=&dB-1

_BD513:			dex					; X=X-1
_BD514:			jsr	_LD54B				; 
			bcc	_BD540				; 
_BD519:			jsr	_LD3ED				; update pointers
			lda	(VDU_G_MEM),Y			; get byte from graphics line
			eor	VDU_G_BG			; EOR with background colour
			sta	VDU_TMP1			; and store it
			lda	VDU_TMP3			; 
			bne	_BD514				; If A-0 back to D514
			lda	VDU_TMP1			; else A=&DA
			bne	_BD53D				; if A<>d53D
			sec					; else set carry
			txa					; A=x
			adc	VDU_PIX_BYTE			; Add number of pixels/byte
			bcc	_BD536				; and if carry clear D536
			inc	VDU_TMP2			; else inc DB
			bpl	_BD53D				; and if +ve D53D
_BD536:			tax					; get back X
			jsr	_LD104				; display a point
			sec					; set carry
			bcs	_BD519				; goto D519

_BD53D:			jsr	_LD54B				; 
_BD540:			ldy	#$04				; 
			jsr	_LD5AC				; 

_LD545:			jsr	_LD0D9				; 
			jmp	_LD1B8				; scale pointers

_LD54B:			lda	VDU_G_PIX_MASK			; get byte mask
			pha					; save it
			clc					; clear carry
			bcc	_BD560				; 

_BD551:			pla					; get back A
			inx					; X=X+1
			bne	_BD559				; if not 0 D559
			inc	VDU_TMP2			; else inc &DB
			bpl	_BD56F				; if +ve D56F
_BD559:			lsr	VDU_G_PIX_MASK			; 
			bcs	_BD56F				; if Bit 7 D1 set D56F
			ora	VDU_G_PIX_MASK			; else or withA
			pha					; save result
_BD560:			lda	VDU_G_PIX_MASK			; A=&D1
			bit	VDU_TMP1			; test bits 6 and 7 of &DA
			php					; save flags
			pla					; get into A
			eor	VDU_TMP3			; EOR and DC
			pha					; save A
			plp					; 
			beq	_BD551				; 

			pla					; A=A EOR &D1 (byte mask)
			eor	VDU_G_PIX_MASK			; 
_BD56F:			sta	VDU_G_PIX_MASK			; store it
			jmp	_LD0F0				; and display a pixel

_LD574:			lda	#$00				; A=0
			clc					; Clear carry

			bcc	_BD583				; goto D583 if carry clear

_BD579:			inx					; X=X+1
			bne	_BD580				; If <>0 D580
			inc	VDU_TMP2			; else inc &DB
			bpl	_BD56F				; and if +ve d56F

_BD580:			asl					; A=A*2
			bcs	_BD58E				; if C set D58E
_BD583:			ora	VDU_G_PIX_MASK			; else A=A OR (&D1)
			bit	VDU_TMP1			; set V and M from &DA b6 b7
			beq	_BD579				; 
			eor	VDU_G_PIX_MASK			; A=AEOR &D1
			lsr					; /2
			bcc	_BD56F				; if carry clear D56F
_BD58E:			ror					; *2
			sec					; set carry
			bcs	_BD56F				; to D56F

_LD592:			lda	VDU_G_WIN_L,X			; Y/A=(&300/1 +X)-(&320/1)
			sec					; 
			sbc	VDU_QUEUE_5			; 
			tay					; 
			lda	VDU_G_WIN_L_HI,X		; 
			sbc	VDU_QUEUE_6			; 
			bmi	_BD5A5				; if result -ve D5A5
			jsr	_LD49B				; or negate Y/A
_BD5A5:			sta	VDU_TMP2			; store A
			tya					; A=Y
			tax					; X=A
			ora	VDU_TMP2			; 
			rts					; exit

_LD5AC:			sty	VDU_TMP1			; Y=&DA
			txa					; A=X
			tay					; Y=A
			lda	VDU_TMP2			; A=&DB
			bmi	_BD5B6				; if -ve D5B6
			lda	#$00				; A=0
_BD5B6:			ldx	VDU_TMP1			; X=&DA
			bne	_BD5BD				; if <>0 D5BD
			jsr	_LD49B				; negate
_BD5BD:			pha					; 
			clc					; 
			tya					; 
			adc	VDU_G_WIN_L,X			; Y/A+(&300/1 +X)=(&320/1)
			sta	VDU_QUEUE_5			; 
			pla					; 
			adc	VDU_G_WIN_L_HI,X		; 
			sta	VDU_QUEUE_6			; 
			rts					; return


;*************************************************************************
;*									 *
;*	 OSWORD 13 - READ LAST TWO GRAPHIC CURSOR POSITIONS		 *
;*									 *
;*************************************************************************
				;
_OSWORD_13:		lda	#$03				; A=3
			jsr	_LD5D5				; 
			lda	#$07				; A=7
_LD5D5:			pha					; Save A
			jsr	_LCDE2				; exchange last 2 graphics cursor coordinates with
								; current coordinates
			jsr	_LD1B8				; convert to external coordinates
			ldx	#$03				; X=3
			pla					; save A
			tay					; Y=A
_BD5E0:			lda	VDU_G_CUR_XX,X			; get graphics coordinate
			sta	(OSW_X),Y			; store it in OS buffer
			dey					; decrement Y and X
			dex					; 
			bpl	_BD5E0				; if +ve do it again
			rts					; then Exit


;*************************************************************************
;*									 *
;*	 PLOT Fill triangle routine					 *
;*									 *
;*************************************************************************

_LD5EA:			ldx	#$20				; X=&20
			ldy	#$3e				; Y=&3E
			jsr	_LD47C				; copy 300/7+X to 300/7+Y
								; this gets XY data parameters and current graphics
								; cursor position
			jsr	_LD632				; exchange 320/3 with 324/7 if 316/7=<322/3
			ldx	#$14				; X=&14
			ldy	#$24				; Y=&24
			jsr	_LD636				; 
			jsr	_LD632				; 

			ldx	#$20				; 
			ldy	#$2a				; 
			jsr	_LD411				; calculate 032A/B-(324/5-320/1)
			lda	VDU_BITMAP_RD_3			; and store
			sta	VDU_WORKSPACE+2			; result

			ldx	#$28				; set pointers
			jsr	_LD459				; 
			ldy	#$2e				; 

			jsr	_LD0DE				; copy 320/3 32/31
			jsr	_LCDE2				; exchange 314/7 with 324/7
			clc					; 
			jsr	_LD658				; execute fill routine

			jsr	_LCDE2				; 
			ldx	#$20				; 
			jsr	_LCDE4				; 
			sec					; 
			jsr	_LD658				; 

			ldx	#$3e				; ;X=&3E
			ldy	#$20				; ;Y=&20
			jsr	_LD47C				; ;copy 300/7+X to 300/7+Y
			jmp	_LD0D9				; ;this gets XY data parameters and current graphics
								; cursor position

_LD632:			ldx	#$20				; X=&20
			ldy	#$14				; Y=&14
_LD636:			lda	VDU_G_WIN_B,X			; 
			cmp	VDU_G_WIN_B,Y			; 
			lda	VDU_G_WIN_B_HI,X		; 
			sbc	VDU_G_WIN_B_HI,Y		; 
			bmi	_BD657				; if 302/3+Y>302/3+X return
			jmp	_LCDE6				; else swap 302/3+X with 302/3+Y


;*************************************************************************
;*									 *
;*	 OSBYTE 134 - READ CURSOR POSITION				 *
;*									 *
;*************************************************************************

_OSBYTE_134:		lda	VDU_T_CURS_X			; read current text cursor (X)
			sec					; set carry
			sbc	VDU_T_WIN_L			; subtract left hand column of current text window
			tax					; X=A
			lda	VDU_T_CURS_Y			; get current text cursor (Y)
			sec					; 
			sbc	VDU_T_WIN_T			; suptract top row of current window
			tay					; Y=A
_BD657:			rts					; and exit

				; PLOT routines continue
				; many of the following routines are just manipulations
				; only points of interest will be explained
_LD658:			php					; store flags
			ldx	#$20				; X=&20
			ldy	#$35				; Y=&35
			jsr	_LD411				; 335/6=(324/5+X-320/1)
			lda	VDU_WORKSPACE+6			; 
			sta	VDU_WORKSPACE+$D		; 
			ldx	#$33				; 
			jsr	_LD459				; set pointers

			ldy	#$39				; set 339/C=320/3
			jsr	_LD0DE				; 
			sec					; 
			lda	VDU_QUEUE_7			; 
			sbc	VDU_G_CURS_V			; 
			sta	VDU_QUEUE			; 
			lda	VDU_QUEUE_8			; 
			sbc	VDU_G_CURS_V_HI			; 
			sta	VDU_QUEUE_1			; 
			ora	VDU_QUEUE			; check VDU queque
			beq	_BD69F				; 

_BD688:			jsr	_LD6A2				; display a line
			ldx	#$33				; 
			jsr	_LD774				; update pointers
			ldx	#$28				; 
			jsr	_LD774				; and again!
			inc	VDU_QUEUE			; update VDU queque
			bne	_BD688				; and if not empty do it again
			inc	VDU_QUEUE_1			; else increment next byte
			bne	_BD688				; and do it again

_BD69F:			plp					; pull flags
			bcc	_BD657				; if carry clear exit
_LD6A2:			ldx	#$39				; 
			ldy	#$2e				; 
_VDU_G_CLR_LINE:	stx	VDU_TMP5			; 
			lda	VDU_G_WIN_L,X			; is 300/1+x<300/1+Y
			cmp	VDU_G_WIN_L,Y			; 
			lda	VDU_G_WIN_L_HI,X		; 
			sbc	VDU_G_WIN_L_HI,Y		; 
			bmi	_BD6BC				; if so D6BC
			tya					; else A=Y
			ldy	VDU_TMP5			; Y=&DE
			tax					; X=A
			stx	VDU_TMP5			; &DE=X
_BD6BC:			sty	VDU_TMP6			; &DF=Y
			lda	VDU_G_WIN_L,Y			; 
			pha					; 
			lda	VDU_G_WIN_L_HI,Y		; 
			pha					; 
			ldx	VDU_TMP6			; 
			jsr	_LD10F				; check for window violations
			beq	_BD6DA				; 
			cmp	#$02				; 
			bne	_LD70E				; 
			ldx	#$04				; 
			ldy	VDU_TMP6			; 
			jsr	_LD482				; 
			ldx	VDU_TMP6			; 
_BD6DA:			jsr	_LD864				; set a screen address
			ldx	VDU_TMP5			; X=&DE
			jsr	_LD10F				; check for window violations
			lsr					; A=A/2
			bne	_LD70E				; if A<>0 then exit
			bcc	_BD6E9				; else if C clear D6E9
			ldx	#$00				; 
_BD6E9:			ldy	VDU_TMP6			; 
			sec					; 
			lda	VDU_G_WIN_L,Y			; 
			sbc	VDU_G_WIN_L,X			; 
			sta	VDU_TMP3			; 
			lda	VDU_G_WIN_L_HI,Y		; 
			sbc	VDU_G_WIN_L_HI,X		; 
			sta	VDU_TMP4			; 
			lda	#$00				; 
_BD6FE:			asl					; 
			ora	VDU_G_PIX_MASK			; 
			ldy	VDU_TMP3			; 
			bne	_BD719				; 
			dec	VDU_TMP4			; 
			bpl	_BD719				; 
			sta	VDU_G_PIX_MASK			; 
			jsr	_LD0F0				; display a point
_LD70E:			ldx	VDU_TMP6			; restore X
			pla					; and A
			sta	VDU_G_WIN_L_HI,X		; store it
			pla					; get back A
			sta	VDU_G_WIN_L,X			; and store it
			rts					; exit
								;
_BD719:			dec	VDU_TMP3			; 
			tax					; 
			bpl	_BD6FE				; 
			sta	VDU_G_PIX_MASK			; 
			jsr	_LD0F0				; display a point
			ldx	VDU_TMP3			; 
			inx					; 
			bne	_BD72A				; 
			inc	VDU_TMP4			; 
_BD72A:			txa					; 
			pha					; 
			lsr	VDU_TMP4			; 
			ror					; 
			ldy	VDU_PIX_BYTE			; number of pixels/byte
			cpy	#$03				; if 3 mode = goto D73B
			beq	_BD73B				; 
			bcc	_BD73E				; else if <3 mode 2 goto D73E
			lsr	VDU_TMP4			; else rotate bottom bit of &DD
			ror					; into Accumulator

_BD73B:			lsr	VDU_TMP4			; rotate bottom bit of &DD
			lsr					; into Accumulator
_BD73E:			ldy	VDU_G_CURS_SCAN			; Y=line in current graphics cell containing current
								; point
			tax					; X=A
			beq	_BD753				; 
_BD744:			tya					; Y=Y-8
			sec					; 
			sbc	#$08				; 
			tay					; 

			bcs	_BD74D				; 
			dec	VDU_G_MEM_HI			; decrement byte of top line off current graphics cell
_BD74D:			jsr	_LD104				; display a point
			dex					; 
			bne	_BD744				; 
_BD753:			pla					; 
			and	VDU_PIX_BYTE			; pixels/byte
			beq	_LD70E				; 
			tax					; 
			lda	#$00				; A=0
_BD75C:			asl					; 
			ora	VDU_MASK_LEFT			; or with right colour mask
			dex					; 
			bne	_BD75C				; 
			sta	VDU_G_PIX_MASK			; store as byte mask
			tya					; Y=Y-8
			sec					; 
			sbc	#$08				; 
			tay					; 
			bcs	_BD76E				; if carry clear
			dec	VDU_G_MEM_HI			; decrement byte of top line off current graphics cell
_BD76E:			jsr	_LD0F3				; display a point
			jmp	_LD70E				; and exit via D70E

_LD774:			inc	VDU_T_WIN_L,X			; 
			bne	_BD77C				; 
			inc	VDU_T_WIN_B,X			; 
_BD77C:			sec					; 
			lda	VDU_G_WIN_L,X			; 
			sbc	VDU_G_WIN_B,X			; 
			sta	VDU_G_WIN_L,X			; 
			lda	VDU_G_WIN_L_HI,X		; 
			sbc	VDU_G_WIN_B_HI,X		; 
			sta	VDU_G_WIN_L_HI,X		; 
			bpl	_BD7C1				; 
_BD791:			lda	VDU_T_WIN_R,X			; 
			bmi	_BD7A1				; 
			inc	VDU_G_WIN_T,X			; 
			bne	_LD7AC				; 
			inc	VDU_G_WIN_T_HI,X		; 
			jmp	_LD7AC				; 
_BD7A1:			lda	VDU_G_WIN_T,X			; 
			bne	_BD7A9				; 
			dec	VDU_G_WIN_T_HI,X		; 
_BD7A9:			dec	VDU_G_WIN_T,X			; 
_LD7AC:			clc					; 
			lda	VDU_G_WIN_L,X			; 
			adc	VDU_G_WIN_R,X			; 
			sta	VDU_G_WIN_L,X			; 
			lda	VDU_G_WIN_L_HI,X		; 
			adc	VDU_G_WIN_R_HI,X		; 
			sta	VDU_G_WIN_L_HI,X		; 
			bmi	_BD791				; 
_BD7C1:			rts					; 


;*************************************************************************
;*									 *
;*	 OSBYTE 135 - READ CHARACTER AT TEXT CURSOR POSITION		 *
;*									 *
;*************************************************************************

_OSBYTE_135:		ldy	VDU_COL_MASK			; get number of logical colours
			bne	_BD7DC				; if Y<>0 mode <>7 so D7DC
			lda	(VDU_TOP_SCAN),Y		; get address of top scan line of current text chr
			ldy	#$02				; Y=2
_BD7CB:			cmp	_TELETEXT_CHAR_TAB+1,Y		; compare with conversion table
			bne	_BD7D4				; if not equal D7d4
			lda	_TELETEXT_CHAR_TAB,Y		; else get next lower byte from table
			dey					; Y=Y-1
_BD7D4:			dey					; Y=Y-1
			bpl	_BD7CB				; and if +ve do it again
_BD7D7:			ldy	VDU_MODE			; Y=current screen mode
			tax					; return with character in X
			rts					; 
								;
_BD7DC:			jsr	_LD808				; set up copy of the pattern bytes at text cursor
			ldx	#$20				; X=&20
_BD7E1:			txa					; A=&20
			pha					; Save it
			jsr	_LD03E				; get pattern address for code in A
			pla					; get back A
			tax					; and X
_BD7E8:			ldy	#$07				; Y=7
_BD7EA:			lda	VDU_BITMAP_READ,Y		; get byte in pattern copy
			cmp	(VDU_TMP5),Y			; check against pattern source
			bne	_BD7F9				; if not the same D7F9
			dey					; else Y=Y-1
			bpl	_BD7EA				; and if +ve D7EA
			txa					; A=X
			cpx	#$7f				; is X=&7F (delete)
			bne	_BD7D7				; if not D7D7
_BD7F9:			inx					; else X=X+1
			lda	VDU_TMP5			; get byte lo address
			clc					; clear carry
			adc	#$08				; add 8
			sta	VDU_TMP5			; store it
			bne	_BD7E8				; and go back to check next character if <>0

			txa					; A=X
			bne	_BD7E1				; if <>0 D7E1
			beq	_BD7D7				; else D7D7

;***************** set up pattern copy ***********************************

_LD808:			ldy	#$07				; Y=7

_BD80A:			sty	VDU_TMP1			; &DA=Y
			lda	#$01				; A=1
			sta	VDU_TMP2			; &DB=A
_BD810:			lda	VDU_MASK_RIGHT			; A=left colour mask
			sta	VDU_TMP3			; store an &DC
			lda	(VDU_TOP_SCAN),Y		; get a byte from current text character
			eor	VDU_T_BG			; EOR with text background colour
			clc					; clear carry
_BD81B:			bit	VDU_TMP3			; and check bits of colour mask
			beq	_BD820				; if result =0 then D820
			sec					; else set carry
_BD820:			rol	VDU_TMP2			; &DB=&DB+Carry
			bcs	_BD82E				; if carry now set (bit 7 DB originally set) D82E
			lsr	VDU_TMP3			; else	&DC=&DC/2
			bcc	_BD81B				; if carry clear D81B
			tya					; A=Y
			adc	#$07				; ADD ( (7+carry)
			tay					; Y=A
			bcc	_BD810				; 
_BD82E:			ldy	VDU_TMP1			; read modified values into Y and A
			lda	VDU_TMP2			; 
			sta	VDU_BITMAP_READ,Y		; store copy
			dey					; and do it again
			bpl	_BD80A				; until 8 bytes copied
			rts					; exit

;********* pixel reading *************************************************

_LD839:			pha					; store A
			tax					; X=A
			jsr	_LD149				; set up positional data
			pla					; get back A
			tax					; X=A
			jsr	_LD85F				; set a screen address after checking for window
								; violations
			bne	_BD85A				; if A<>0 D85A to exit with A=&FF
			lda	(VDU_G_MEM),Y			; else get top line of current graphics cell
_BD847:			asl					; A=A*2 C=bit 7
			rol	VDU_TMP1			; &DA=&DA+2 +C	C=bit 7 &DA
			asl	VDU_G_PIX_MASK			; byte mask=bM*2 +carry from &DA
			php					; save flags
			bcs	_BD851				; if carry set D851
			lsr	VDU_TMP1			; else restore &DA with bit '=0
_BD851:			plp					; pull flags
			bne	_BD847				; if Z set D847
			lda	VDU_TMP1			; else A=&DA AND number of colours in current mode -1
			and	VDU_COL_MASK			; 
			rts					; then exit
								;
_BD85A:			lda	#$ff				; A=&FF
_BD85C:			rts					; exit

;********** check for window violations and set up screen address **********

_LD85D:			ldx	#$20				; X=&20
_LD85F:			jsr	_LD10F				; 
			bne	_BD85C				; if A<>0 there is a window violation so D85C
_LD864:			lda	VDU_G_WIN_B,X			; else set up graphics scan line variable
			eor	#$ff				; 
			tay					; 
			and	#$07				; 
			sta	VDU_G_CURS_SCAN			; in 31A
			tya					; A=Y
			lsr					; A=A/2
			lsr					; A=A/2
			lsr					; A=A/2
			asl					; A=A*2 this gives integer value bit 0 =0
			tay					; Y=A
			lda	(VDU_ROW_MULT),Y		; get high byte of offset from screen RAM start
			sta	VDU_TMP1			; store it
			iny					; Y=Y+1
			lda	(VDU_ROW_MULT),Y		; get lo byte
			ldy	VDU_MAP_TYPE			; get screen map type
			beq	_BD884				; if 0 (modes 0,1,2) goto D884
			lsr	VDU_TMP1			; else &DA=&DA/2
			ror					; and A=A/2 +C if set
								; so 2 byte offset =offset/2

_BD884:			adc	VDU_MEM				; add screen top left hand corner lo
			sta	VDU_G_MEM			; store it
			lda	VDU_TMP1			; get high  byte
			adc	VDU_MEM_HI			; add top left hi
			sta	VDU_G_MEM_HI			; store it
			lda	VDU_G_WIN_L_HI,X		; 
			sta	VDU_TMP1			; 
			lda	VDU_G_WIN_L,X			; 
			pha					; 
			and	VDU_PIX_BYTE			; and then Add pixels per byte-1
			adc	VDU_PIX_BYTE			; 
			tay					; Y=A
			lda	_LC406,Y			; A=&80 /2^Y using look up table
			sta	VDU_G_PIX_MASK			; store it
			pla					; get back A
			ldy	VDU_PIX_BYTE			; Y=&number of pixels/byte
			cpy	#$03				; is Y=3 (modes 1,6)
			beq	_BD8B2				; goto D8B2
			bcs	_BD8B5				; if mode =1 or 4 D8B5
			asl					; A/&DA =A/&DA *2
			rol	VDU_TMP1			; 

_BD8B2:			asl					; 
			rol	VDU_TMP1			; 

_BD8B5:			and	#$f8				; clear bits 0-2
			clc					; clear carry

			adc	VDU_G_MEM			; add A/&DA to &D6/7
			sta	VDU_G_MEM			; 
			lda	VDU_TMP1			; 
			adc	VDU_G_MEM_HI			; 
			bpl	_BD8C6				; if result +ve D8C6
			sec					; else set carry
			sbc	VDU_MEM_PAGES			; and subtract screen memory size making it wrap round

_BD8C6:			sta	VDU_G_MEM_HI			; store it in &D7
			ldy	VDU_G_CURS_SCAN			; get line in graphics cell containing current graphics
_BD8CB:			lda	#$00				; point	 A=0
			rts					; And exit
								;
_LD8CE:			pha					; Push A
			lda	#$a0				; A=&A0
			ldx	OSB_VDU_QSIZE			; X=number of items in VDU queque
			bne	_BD916				; if not 0 D916
			bit	VDU_STATUS			; else check VDU status byte
			bne	_BD916				; if either VDU is disabled or plot to graphics
								; cursor enabled then D916
			bvs	_BD8F5				; if cursor editing enabled D8F5
			lda	VDU_CURS_PREV			; else get 6845 register start setting
			and	#$9f				; clear bits 5 and 6
			ora	#$40				; set bit 6 to modify last cursor size setting
			jsr	_LC954				; change write cursor format
			ldx	#$18				; X=&18
			ldy	#$64				; Y=&64
			jsr	_LD482				; set text input cursor from text output cursor
			jsr	_LCD7A				; modify character at cursor poistion
			lda	#$02				; A=2
			jsr	_LC59D				; bit 1 of VDU status is set to bar scrolling


_BD8F5:			lda	#$bf				; A=&BF
			jsr	_LC5A8				; bit 6 of VDU status =0
			pla					; Pull A
			and	#$7f				; clear hi bit (7)
			jsr	_VDUCHR				; entire VDU routine !!
			lda	#$40				; A=&40
			jmp	_LC59D				; exit


_LD905:			lda	#$20				; A=&20
			bit	VDU_STATUS			; if bit 6 cursor editing is set
			bvc	_BD8CB				; 
			bne	_BD8CB				; or bit 5 is set exit &D8CB
			jsr	_OSBYTE_135			; read a character from the screen
			beq	_BD917				; if A=0 on return exit via D917
			pha					; else store A
			jsr	_VDU_9				; perform cursor right

_BD916:			pla					; restore A
_BD917:			rts					; and exit
								;
_LD918:			lda	#$bd				; zero bits 2 and 6 of VDU status
			jsr	_LC5A8				; 
			jsr	_LC951				; set normal cursor
			lda	#$0d				; A=&0D
			rts					; and return
								; this is response of CR as end of edit line


;*************************************************************************
;*									 *
;*	 OSBYTE 132 - READ BOTTOM OF DISPLAY RAM			 *
;*									 *
;*************************************************************************

_OSBYTE_132:		ldx	VDU_MODE			; Get current screen mode


;*************************************************************************
;*									 *
;*	 OSBYTE 133 - READ LOWEST ADDRESS FOR GIVEN MODE		 *
;*									 *
;*************************************************************************

_OSBYTE_133:		txa					; A=X
			and	#$07				; Ensure mode 0-7
			tay					; Pass to Y into index into screen size table
			ldx	_LC440,Y			; X=screen size type, 0-4
			lda	_VDU_MEMLOC_TAB,X		; A=high byte of start address for screen type
			ldx	#$00				; Returned address is &xx00
			bit	OSB_RAM_PAGES			; Check available RAM
			bmi	_BD93E				; If bit 7 set then 32K RAM, so return address
			and	#$3f				; 16K RAM, so drop address to bottom 16K
			cpy	#$04				; Check screen mode
			bcs	_BD93E				; If mode 4-7, return the address
			txa					; If mode 0-3, return &0000 as not enough memory
; exit
_BD93E:			tay					; Pass high byte of address to Y
			rts					; and return address in YX


