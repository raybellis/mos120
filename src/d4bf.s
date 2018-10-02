;OS SERIES IV
;GEOFF COX

;*************************************************************************
;*                                                                       *
;*  LATERAL FILL ROUTINE                                                 *
;*                                                                       *
;*************************************************************************

.org		$d4bf

_LD4BF:		jsr	_LD4AA		; check current screen state
		and	$D1		; if A and &D1 <> 0 a plotted point has been found
		bne	_BD4B9		; so D4B9
		ldx	#$00		; X=0
		jsr	_LD592		; update pointers
		beq	_BD4FA		; if 0 then D4FA
		ldy	$031a		; else Y=graphics scan line
		asl	$D1		; 
		bcs	_BD4D9		; if carry set D4D9
		jsr	_LD574		; else D574
		bcc	_BD4FA		; if carry clear D4FA
_BD4D9:		jsr	_LD3FD		; else D3FD to pick up colour multiplier
		lda	($D6),Y		; get graphics cell line
		eor	$035a		; EOR with background colour
		sta	$DA		; and store
		bne	_BD4F7		; if not 0 D4F7
		sec			; else set carry
		txa			; A=X
		adc	$0361		; add pixels/byte
		bcc	_BD4F0		; and if carry clear D4F0
		inc	$DB		; else increment &DB
		bpl	_BD4F7		; and if +ve D4F7

_BD4F0:		tax			; else X=A
		jsr	_LD104		; display a pixel
		sec			; set carry
		bcs	_BD4D9		; goto D4D9

_BD4F7:		jsr	_LD574		; 
_BD4FA:		ldy	#$00		; Y=0
		jsr	_LD5AC		; 
		ldy	#$20		; 
		ldx	#$24		; 
		jsr	_LCDE6		; exchange 300/3 +Y with 300/3+X
_LD506:		jsr	_LD4AA		; check screen pixel
		ldx	#$04		; Y=5
		jsr	_LD592		; 
		txa			; A=x
		bne	_BD513		; if A<>0 d513
		dec	$DB		; else  &DB=&dB-1

_BD513:		dex			; X=X-1
_BD514:		jsr	_LD54B		; 
		bcc	_BD540		; 
_BD519:		jsr	_LD3ED		; update pointers
		lda	($D6),Y		; get byte from graphics line
		eor	$035a		; EOR with background colour
		sta	$DA		; and store it
		lda	$DC		; 
		bne	_BD514		; If A-0 back to D514
		lda	$DA		; else A=&DA
		bne	_BD53D		; if A<>d53D
		sec			; else set carry
		txa			; A=x
		adc	$0361		; Add number of pixels/byte
		bcc	_BD536		; and if carry clear D536
		inc	$DB		; else inc DB
		bpl	_BD53D		; and if +ve D53D
_BD536:		tax			; get back X
		jsr	_LD104		; display a point
		sec			; set carry
		bcs	_BD519		; goto D519

_BD53D:		jsr	_LD54B		; 
_BD540:		ldy	#$04		; 
		jsr	_LD5AC		; 

_LD545:		jsr	_BD0D9		; 
		jmp	_LD1B8		; scale pointers

_LD54B:		lda	$D1		; get byte mask
		pha			; save it
		clc			; clear carry
		bcc	_BD560		; 

_BD551:		pla			; get back A
		inx			; X=X+1
		bne	_BD559		; if not 0 D559
		inc	$DB		; else inc &DB
		bpl	_BD56F		; if +ve D56F
_BD559:		lsr	$D1		; 
		bcs	_BD56F		; if Bit 7 D1 set D56F
		ora	$D1		; else or withA
		pha			; save result
_BD560:		lda	$D1		; A=&D1
		bit	$DA		; test bits 6 and 7 of &DA
		php			; save flags
		pla			; get into A
		eor	$DC		; EOR and DC
		pha			; save A
		plp			; 
		beq	_BD551		; 

		pla			; A=A EOR &D1 (byte mask)
		eor	$D1		; 
_BD56F:		sta	$D1		; store it
		jmp	_BD0F0		; and display a pixel

_LD574:		lda	#$00		; A=0
		clc			; Clear carry

		bcc	_BD583		; goto D583 if carry clear

_BD579:		inx			; X=X+1
		bne	_BD580		; If <>0 D580
		inc	$DB		; else inc &DB
		bpl	_BD56F		; and if +ve d56F

_BD580:		asl			; A=A*2
		bcs	_BD58E		; if C set D58E
_BD583:		ora	$D1		; else A=A OR (&D1)
		bit	$DA		; set V and M from &DA b6 b7
		beq	_BD579		; 
		eor	$D1		; A=AEOR &D1
		lsr			; /2
		bcc	_BD56F		; if carry clear D56F
_BD58E:		ror			; *2
		sec			; set carry
		bcs	_BD56F		; to D56F

_LD592:		lda	$0300,X		; Y/A=(&300/1 +X)-(&320/1)
		sec			; 
		sbc	$0320		; 
		tay			; 
		lda	$0301,X		; 
		sbc	$0321		; 
		bmi	_BD5A5		; if result -ve D5A5
		jsr	_LD49B		; or negate Y/A
_BD5A5:		sta	$DB		; store A
		tya			; A=Y
		tax			; X=A
		ora	$DB		; 
		rts			; exit

_LD5AC:		sty	$DA		; Y=&DA
		txa			; A=X
		tay			; Y=A
		lda	$DB		; A=&DB
		bmi	_BD5B6		; if -ve D5B6
		lda	#$00		; A=0
_BD5B6:		ldx	$DA		; X=&DA
		bne	_BD5BD		; if <>0 D5BD
		jsr	_LD49B		; negate
_BD5BD:		pha			; 
		clc			; 
		tya			; 
		adc	$0300,X		; Y/A+(&300/1 +X)=(&320/1)
		sta	$0320		; 
		pla			; 
		adc	$0301,X		; 
		sta	$0321		; 
		rts			; return


;*************************************************************************
;*                                                                       *
;*       OSWORD 13 - READ LAST TWO GRAPHIC CURSOR POSITIONS              *
;*                                                                       *
;*************************************************************************
		; 
		lda	#$03		; A=3
		jsr	_LD5D5		; 
		lda	#$07		; A=7
_LD5D5:		pha			; Save A
		jsr	_LCDE2		; exchange last 2 graphics cursor coordinates with
					; current coordinates
		jsr	_LD1B8		; convert to external coordinates
		ldx	#$03		; X=3
		pla			; save A
		tay			; Y=A
_BD5E0:		lda	$0310,X		; get graphics coordinate
		sta	($F0),Y		; store it in OS buffer
		dey			; decrement Y and X
		dex			; 
		bpl	_BD5E0		; if +ve do it again
		rts			; then Exit


;*************************************************************************
;*                                                                       *
;*       PLOT Fill triangle routine                                      *
;*                                                                       *
;*************************************************************************

_LD5EA:		ldx	#$20		; X=&20
		ldy	#$3E		; Y=&3E
		jsr	_LD47C		; copy 300/7+X to 300/7+Y
					; this gets XY data parameters and current graphics
					; cursor position
		jsr	_LD632		; exchange 320/3 with 324/7 if 316/7=<322/3
		ldx	#$14		; X=&14
		ldy	#$24		; Y=&24
		jsr	_LD636		; 
		jsr	_LD632		; 

		ldx	#$20		; 
		ldy	#$2A		; 
		jsr	_LD411		; calculate 032A/B-(324/5-320/1)
		lda	$032b		; and store
		sta	$0332		; result

		ldx	#$28		; set pointers
		jsr	_LD459		; 
		ldy	#$2E		; 

		jsr	_LD0DE		; copy 320/3 32/31
		jsr	_LCDE2		; exchange 314/7 with 324/7
		clc			; 
		jsr	_LD658		; execute fill routine

		jsr	_LCDE2		; 
		ldx	#$20		; 
		jsr	_LCDE4		; 
		sec			; 
		jsr	_LD658		; 

		ldx	#$3E		; ;X=&3E
		ldy	#$20		; ;Y=&20
		jsr	_LD47C		; ;copy 300/7+X to 300/7+Y
		jmp	_BD0D9		; ;this gets XY data parameters and current graphics
					; cursor position

_LD632:		ldx	#$20		; X=&20
		ldy	#$14		; Y=&14
_LD636:		lda	$0302,X		; 
		cmp	$0302,Y		; 
		lda	$0303,X		; 
		sbc	$0303,Y		; 
		bmi	_BD657		; if 302/3+Y>302/3+X return
		jmp	_LCDE6		; else swap 302/3+X with 302/3+Y


;*************************************************************************
;*                                                                       *
;*       OSBYTE 134 - READ CURSOR POSITION                               *
;*                                                                       *
;*************************************************************************

		lda	$0318		; read current text cursor (X)
		sec			; set carry
		sbc	$0308		; subtract left hand column of current text window
		tax			; X=A
		lda	$0319		; get current text cursor (Y)
		sec			; 
		sbc	$030b		; suptract top row of current window
		tay			; Y=A
_BD657:		rts			; and exit

		; PLOT routines continue
		; many of the following routines are just manipulations
		; only points of interest will be explained
_LD658:		php			; store flags
		ldx	#$20		; X=&20
		ldy	#$35		; Y=&35
		jsr	_LD411		; 335/6=(324/5+X-320/1)
		lda	$0336		; 
		sta	$033d		; 
		ldx	#$33		; 
		jsr	_LD459		; set pointers

		ldy	#$39		; set 339/C=320/3
		jsr	_LD0DE		; 
		sec			; 
		lda	$0322		; 
		sbc	$0326		; 
		sta	$031b		; 
		lda	$0323		; 
		sbc	$0327		; 
		sta	$031c		; 
		ora	$031b		; check VDU queque
		beq	_BD69F		; 

_BD688:		jsr	_LD6A2		; display a line
		ldx	#$33		; 
		jsr	_LD774		; update pointers
		ldx	#$28		; 
		jsr	_LD774		; and again!
		inc	$031b		; update VDU queque
		bne	_BD688		; and if not empty do it again
		inc	$031c		; else increment next byte
		bne	_BD688		; and do it again

_BD69F:		plp			; pull flags
		bcc	_BD657		; if carry clear exit
_LD6A2:		ldx	#$39		; 
		ldy	#$2E		; 
_LD6A6:		stx	$DE		; 
		lda	$0300,X		; is 300/1+x<300/1+Y
		cmp	$0300,Y		; 
		lda	$0301,X		; 
		sbc	$0301,Y		; 
		bmi	_BD6BC		; if so D6BC
		tya			; else A=Y
		ldy	$DE		; Y=&DE
		tax			; X=A
		stx	$DE		; &DE=X
_BD6BC:		sty	$DF		; &DF=Y
		lda	$0300,Y		; 
		pha			; 
		lda	$0301,Y		; 
		pha			; 
		ldx	$DF		; 
		jsr	_LD10F		; check for window violations
		beq	_BD6DA		; 
		cmp	#$02		; 
		bne	_BD70E		; 
		ldx	#$04		; 
		ldy	$DF		; 
		jsr	_LD482		; 
		ldx	$DF		; 
_BD6DA:		jsr	_LD864		; set a screen address
		ldx	$DE		; X=&DE
		jsr	_LD10F		; check for window violations
		lsr			; A=A/2
		bne	_BD70E		; if A<>0 then exit
		bcc	_BD6E9		; else if C clear D6E9
		ldx	#$00		; 
_BD6E9:		ldy	$DF		; 
		sec			; 
		lda	$0300,Y		; 
		sbc	$0300,X		; 
		sta	$DC		; 
		lda	$0301,Y		; 
		sbc	$0301,X		; 
		sta	$DD		; 
		lda	#$00		; 
_BD6FE:		asl			; 
		ora	$D1		; 
		ldy	$DC		; 
		bne	_BD719		; 
		dec	$DD		; 
		bpl	_BD719		; 
		sta	$D1		; 
		jsr	_BD0F0		; display a point
_BD70E:		ldx	$DF		; restore X
		pla			; and A
		sta	$0301,X		; store it
		pla			; get back A
		sta	$0300,X		; and store it
		rts			; exit
					; 
_BD719:		dec	$DC		; 
		tax			; 
		bpl	_BD6FE		; 
		sta	$D1		; 
		jsr	_BD0F0		; display a point
		ldx	$DC		; 
		inx			; 
		bne	_BD72A		; 
		inc	$DD		; 
_BD72A:		txa			; 
		pha			; 
		lsr	$DD		; 
		ror			; 
		ldy	$0361		; number of pixels/byte
		cpy	#$03		; if 3 mode = goto D73B
		beq	_BD73B		; 
		bcc	_BD73E		; else if <3 mode 2 goto D73E
		lsr	$DD		; else rotate bottom bit of &DD
		ror			; into Accumulator

_BD73B:		lsr	$DD		; rotate bottom bit of &DD
		lsr			; into Accumulator
_BD73E:		ldy	$031a		; Y=line in current graphics cell containing current
					; point
		tax			; X=A
		beq	_BD753		; 
_BD744:		tya			; Y=Y-8
		sec			; 
		sbc	#$08		; 
		tay			; 

		bcs	_BD74D		; 
		dec	$D7		; decrement byte of top line off current graphics cell
_BD74D:		jsr	_LD104		; display a point
		dex			; 
		bne	_BD744		; 
_BD753:		pla			; 
		and	$0361		; pixels/byte
		beq	_BD70E		; 
		tax			; 
		lda	#$00		; A=0
_BD75C:		asl			; 
		ora	$0363		; or with right colour mask
		dex			; 
		bne	_BD75C		; 
		sta	$D1		; store as byte mask
		tya			; Y=Y-8
		sec			; 
		sbc	#$08		; 
		tay			; 
		bcs	_BD76E		; if carry clear
		dec	$D7		; decrement byte of top line off current graphics cell
_BD76E:		jsr	_LD0F3		; display a point
		jmp	_BD70E		; and exit via D70E

_LD774:		inc	$0308,X		; 
		bne	_BD77C		; 
		inc	$0309,X		; 
_BD77C:		sec			; 
		lda	$0300,X		; 
		sbc	$0302,X		; 
		sta	$0300,X		; 
		lda	$0301,X		; 
		sbc	$0303,X		; 
		sta	$0301,X		; 
		bpl	_BD7C1		; 
_BD791:		lda	$030a,X		; 
		bmi	_BD7A1		; 
		inc	$0306,X		; 
		bne	_BD7AC		; 
		inc	$0307,X		; 
		jmp	_BD7AC		; 
_BD7A1:		lda	$0306,X		; 
		bne	_BD7A9		; 
		dec	$0307,X		; 
_BD7A9:		dec	$0306,X		; 
_BD7AC:		clc			; 
		lda	$0300,X		; 
		adc	$0304,X		; 
		sta	$0300,X		; 
		lda	$0301,X		; 
		adc	$0305,X		; 
		sta	$0301,X		; 
		bmi	_BD791		; 
_BD7C1:		rts			; 


;*************************************************************************
;*                                                                       *
;*       OSBYTE 135 - READ CHARACTER AT TEXT CURSOR POSITION             *
;*                                                                       *
;*************************************************************************

_LD7C2:		ldy	$0360		; get number of logical colours
		bne	_BD7DC		; if Y<>0 mode <>7 so D7DC
		lda	($D8),Y		; get address of top scan line of current text chr
		ldy	#$02		; Y=2
_BD7CB:		cmp	_LC4B7,Y		; compare with conversion table
		bne	_BD7D4		; if not equal D7d4
		lda	_LC4B6,Y		; else get next lower byte from table
		dey			; Y=Y-1
_BD7D4:		dey			; Y=Y-1
		bpl	_BD7CB		; and if +ve do it again
_BD7D7:		ldy	$0355		; Y=current screen mode
		tax			; return with character in X
		rts			; 
					; 
_BD7DC:		jsr	_LD808		; set up copy of the pattern bytes at text cursor
		ldx	#$20		; X=&20
_BD7E1:		txa			; A=&20
		pha			; Save it
		jsr	_LD03E		; get pattern address for code in A
		pla			; get back A
		tax			; and X
_BD7E8:		ldy	#$07		; Y=7
_BD7EA:		lda	$0328,Y		; get byte in pattern copy
		cmp	($DE),Y		; check against pattern source
		bne	_BD7F9		; if not the same D7F9
		dey			; else Y=Y-1
		bpl	_BD7EA		; and if +ve D7EA
		txa			; A=X
		cpx	#$7F		; is X=&7F (delete)
		bne	_BD7D7		; if not D7D7
_BD7F9:		inx			; else X=X+1
		lda	$DE		; get byte lo address
		clc			; clear carry
		adc	#$08		; add 8
		sta	$DE		; store it
		bne	_BD7E8		; and go back to check next character if <>0

		txa			; A=X
		bne	_BD7E1		; if <>0 D7E1
		beq	_BD7D7		; else D7D7

;***************** set up pattern copy ***********************************

_LD808:		ldy	#$07		; Y=7

_BD80A:		sty	$DA		; &DA=Y
		lda	#$01		; A=1
		sta	$DB		; &DB=A
_BD810:		lda	$0362		; A=left colour mask
		sta	$DC		; store an &DC
		lda	($D8),Y		; get a byte from current text character
		eor	$0358		; EOR with text background colour
		clc			; clear carry
_BD81B:		bit	$DC		; and check bits of colour mask
		beq	_BD820		; if result =0 then D820
		sec			; else set carry
_BD820:		rol	$DB		; &DB=&DB+Carry
		bcs	_BD82E		; if carry now set (bit 7 DB originally set) D82E
		lsr	$DC		; else  &DC=&DC/2
		bcc	_BD81B		; if carry clear D81B
		tya			; A=Y
		adc	#$07		; ADD ( (7+carry)
		tay			; Y=A
		bcc	_BD810		; 
_BD82E:		ldy	$DA		; read modified values into Y and A
		lda	$DB		; 
		sta	$0328,Y		; store copy
		dey			; and do it again
		bpl	_BD80A		; until 8 bytes copied
		rts			; exit

;********* pixel reading *************************************************

_LD839:		pha			; store A
		tax			; X=A
		jsr	_LD149		; set up positional data
		pla			; get back A
		tax			; X=A
		jsr	_LD85F		; set a screen address after checking for window
					; violations
		bne	_BD85A		; if A<>0 D85A to exit with A=&FF
		lda	($D6),Y		; else get top line of current graphics cell
_BD847:		asl			; A=A*2 C=bit 7
		rol	$DA		; &DA=&DA+2 +C  C=bit 7 &DA
		asl	$D1		; byte mask=bM*2 +carry from &DA
		php			; save flags
		bcs	_BD851		; if carry set D851
		lsr	$DA		; else restore &DA with bit '=0
_BD851:		plp			; pull flags
		bne	_BD847		; if Z set D847
		lda	$DA		; else A=&DA AND number of colours in current mode -1
		and	$0360		; 
		rts			; then exit
					; 
_BD85A:		lda	#$FF		; A=&FF
_BD85C:		rts			; exit

;********** check for window violations and set up screen address **********

_LD85D:		ldx	#$20		; X=&20
_LD85F:		jsr	_LD10F		; 
		bne	_BD85C		; if A<>0 there is a window violation so D85C
_LD864:		lda	$0302,X		; else set up graphics scan line variable
		eor	#$FF		; 
		tay			; 
		and	#$07		; 
		sta	$031a		; in 31A
		tya			; A=Y
		lsr			; A=A/2
		lsr			; A=A/2
		lsr			; A=A/2
		asl			; A=A*2 this gives integer value bit 0 =0
		tay			; Y=A
		lda	($E0),Y		; get high byte of offset from screen RAM start
		sta	$DA		; store it
		iny			; Y=Y+1
		lda	($E0),Y		; get lo byte
		ldy	$0356		; get screen map type
		beq	_BD884		; if 0 (modes 0,1,2) goto D884
		lsr	$DA		; else &DA=&DA/2
		ror			; and A=A/2 +C if set
					; so 2 byte offset =offset/2

_BD884:		adc	$0350		; add screen top left hand corner lo
		sta	$D6		; store it
		lda	$DA		; get high  byte
		adc	$0351		; add top left hi
		sta	$D7		; store it
		lda	$0301,X		; 
		sta	$DA		; 
		lda	$0300,X		; 
		pha			; 
		and	$0361		; and then Add pixels per byte-1
		adc	$0361		; 
		tay			; Y=A
		lda	_LC406,Y		; A=&80 /2^Y using look up table
		sta	$D1		; store it
		pla			; get back A
		ldy	$0361		; Y=&number of pixels/byte
		cpy	#$03		; is Y=3 (modes 1,6)
		beq	_BD8B2		; goto D8B2
		bcs	_BD8B5		; if mode =1 or 4 D8B5
		asl			; A/&DA =A/&DA *2
		rol	$DA		; 

_BD8B2:		asl			; 
		rol	$DA		; 

_BD8B5:		and	#$F8		; clear bits 0-2
		clc			; clear carry

		adc	$D6		; add A/&DA to &D6/7
		sta	$D6		; 
		lda	$DA		; 
		adc	$D7		; 
		bpl	_BD8C6		; if result +ve D8C6
		sec			; else set carry
		sbc	$0354		; and subtract screen memory size making it wrap round

_BD8C6:		sta	$D7		; store it in &D7
		ldy	$031a		; get line in graphics cell containing current graphics
_BD8CB:		lda	#$00		; point  A=0
		rts			; And exit
					; 
_LD8CE:		pha			; Push A
		lda	#$A0		; A=&A0
		ldx	$026a		; X=number of items in VDU queque
		bne	_BD916		; if not 0 D916
		bit	$D0		; else check VDU status byte
		bne	_BD916		; if either VDU is disabled or plot to graphics
					; cursor enabled then D916
		bvs	_BD8F5		; if cursor editing enabled D8F5
		lda	$035f		; else get 6845 register start setting
		and	#$9F		; clear bits 5 and 6
		ora	#$40		; set bit 6 to modify last cursor size setting
		jsr	_LC954		; change write cursor format
		ldx	#$18		; X=&18
		ldy	#$64		; Y=&64
		jsr	_LD482		; set text input cursor from text output cursor
		jsr	_LCD7A		; modify character at cursor poistion
		lda	#$02		; A=2
		jsr	_BC59D		; bit 1 of VDU status is set to bar scrolling


_BD8F5:		lda	#$BF		; A=&BF
		jsr	_BC5A8		; bit 6 of VDU status =0
		pla			; Pull A
		and	#$7F		; clear hi bit (7)
		jsr	_LC4C0		; entire VDU routine !!
		lda	#$40		; A=&40
		jmp	_BC59D		; exit


_LD905:		lda	#$20		; A=&20
		bit	$D0		; if bit 6 cursor editing is set
		bvc	_BD8CB		; 
		bne	_BD8CB		; or bit 5 is set exit &D8CB
		jsr	_LD7C2		; read a character from the screen
		beq	_BD917		; if A=0 on return exit via D917
		pha			; else store A
		jsr	_LC664		; perform cursor right

_BD916:		pla			; restore A
_BD917:		rts			; and exit
					; 
_LD918:		lda	#$BD		; zero bits 2 and 6 of VDU status
		jsr	_BC5A8		; 
		jsr	_LC951		; set normal cursor
		lda	#$0D		; A=&0D
		rts			; and return
					; this is response of CR as end of edit line


;*************************************************************************
;*                                                                       *
;*       OSBYTE 132 - READ BOTTOM OF DISPLAY RAM                         *
;*                                                                       *
;*************************************************************************

		ldx	$0355		; Get current screen mode


;*************************************************************************
;*                                                                       *
;*       OSBYTE 133 - READ LOWEST ADDRESS FOR GIVEN MODE                 *
;*                                                                       *
;*************************************************************************

		txa			; A=X
		and	#$07		; Ensure mode 0-7
		tay			; Pass to Y into index into screen size table
		ldx	_LC440,Y		; X=screen size type, 0-4
		lda	_LC45E,X		; A=high byte of start address for screen type
		ldx	#$00		; Returned address is &xx00
		bit	$028e		; Check available RAM
		bmi	_BD93E		; If bit 7 set then 32K RAM, so return address
		and	#$3F		; 16K RAM, so drop address to bottom 16K
		cpy	#$04		; Check screen mode
		bcs	_BD93E		; If mode 4-7, return the address
		txa			; If mode 0-3, return &0000 as not enough memory
; exit
_BD93E:		tay			; Pass high byte of address to Y
_LD93F:		rts			; and return address in YX


