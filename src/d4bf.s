;OS SERIES IV
;GEOFF COX

;*************************************************************************
;*                                                                       *
;*  LATERAL FILL ROUTINE                                                 *
;*                                                                       *
;*************************************************************************

.org		$d4bf

		jsr	$D4AA		; check current screen state
		and	$D1		; if A and &D1 <> 0 a plotted point has been found
		bne	$D4B9		; so D4B9
		ldx	#$00		; X=0
		jsr	$D592		; update pointers
		beq	$D4FA		; if 0 then D4FA
		ldy	$031A		; else Y=graphics scan line
		asl	$D1		; 
		bcs	$D4D9		; if carry set D4D9
		jsr	$D574		; else D574
		bcc	$D4FA		; if carry clear D4FA
		jsr	$D3FD		; else D3FD to pick up colour multiplier
		lda	($D6),Y		; get graphics cell line
		eor	$035A		; EOR with background colour
		sta	$DA		; and store
		bne	$D4F7		; if not 0 D4F7
		sec			; else set carry
		txa			; A=X
		adc	$0361		; add pixels/byte
		bcc	$D4F0		; and if carry clear D4F0
		inc	$DB		; else increment &DB
		bpl	$D4F7		; and if +ve D4F7

		tax			; else X=A
		jsr	$D104		; display a pixel
		sec			; set carry
		bcs	$D4D9		; goto D4D9

		jsr	$D574		; 
		ldy	#$00		; Y=0
		jsr	$D5AC		; 
		ldy	#$20		; 
		ldx	#$24		; 
		jsr	$CDE6		; exchange 300/3 +Y with 300/3+X
		jsr	$D4AA		; check screen pixel
		ldx	#$04		; Y=5
		jsr	$D592		; 
		txa			; A=x
		bne	$D513		; if A<>0 d513
		dec	$DB		; else  &DB=&dB-1

		dex			; X=X-1
		jsr	$D54B		; 
		bcc	$D540		; 
		jsr	$D3ED		; update pointers
		lda	($D6),Y		; get byte from graphics line
		eor	$035A		; EOR with background colour
		sta	$DA		; and store it
		lda	$DC		; 
		bne	$D514		; If A-0 back to D514
		lda	$DA		; else A=&DA
		bne	$D53D		; if A<>d53D
		sec			; else set carry
		txa			; A=x
		adc	$0361		; Add number of pixels/byte
		bcc	$D536		; and if carry clear D536
		inc	$DB		; else inc DB
		bpl	$D53D		; and if +ve D53D
		tax			; get back X
		jsr	$D104		; display a point
		sec			; set carry
		bcs	$D519		; goto D519

		jsr	$D54B		; 
		ldy	#$04		; 
		jsr	$D5AC		; 

		jsr	$D0D9		; 
		jmp	$D1B8		; scale pointers

		lda	$D1		; get byte mask
		pha			; save it
		clc			; clear carry
		bcc	$D560		; 

		pla			; get back A
		inx			; X=X+1
		bne	$D559		; if not 0 D559
		inc	$DB		; else inc &DB
		bpl	$D56F		; if +ve D56F
		lsr	$D1		; 
		bcs	$D56F		; if Bit 7 D1 set D56F
		ora	$D1		; else or withA
		pha			; save result
		lda	$D1		; A=&D1
		bit	$DA		; test bits 6 and 7 of &DA
		php			; save flags
		pla			; get into A
		eor	$DC		; EOR and DC
		pha			; save A
		plp			; 
		beq	$D551		; 

		pla			; A=A EOR &D1 (byte mask)
		eor	$D1		; 
		sta	$D1		; store it
		jmp	$D0F0		; and display a pixel

		lda	#$00		; A=0
		clc			; Clear carry

		bcc	$D583		; goto D583 if carry clear

		inx			; X=X+1
		bne	$D580		; If <>0 D580
		inc	$DB		; else inc &DB
		bpl	$D56F		; and if +ve d56F

		asl			; A=A*2
		bcs	$D58E		; if C set D58E
		ora	$D1		; else A=A OR (&D1)
		bit	$DA		; set V and M from &DA b6 b7
		beq	$D579		; 
		eor	$D1		; A=AEOR &D1
		lsr			; /2
		bcc	$D56F		; if carry clear D56F
		ror			; *2
		sec			; set carry
		bcs	$D56F		; to D56F

		lda	$0300,X		; Y/A=(&300/1 +X)-(&320/1)
		sec			; 
		sbc	$0320		; 
		tay			; 
		lda	$0301,X		; 
		sbc	$0321		; 
		bmi	$D5A5		; if result -ve D5A5
		jsr	$D49B		; or negate Y/A
		sta	$DB		; store A
		tya			; A=Y
		tax			; X=A
		ora	$DB		; 
		rts			; exit

		sty	$DA		; Y=&DA
		txa			; A=X
		tay			; Y=A
		lda	$DB		; A=&DB
		bmi	$D5B6		; if -ve D5B6
		lda	#$00		; A=0
		ldx	$DA		; X=&DA
		bne	$D5BD		; if <>0 D5BD
		jsr	$D49B		; negate
		pha			; 
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
		jsr	$D5D5		; 
		lda	#$07		; A=7
		pha			; Save A
		jsr	$CDE2		; exchange last 2 graphics cursor coordinates with
					; current coordinates
		jsr	$D1B8		; convert to external coordinates
		ldx	#$03		; X=3
		pla			; save A
		tay			; Y=A
		lda	$0310,X		; get graphics coordinate
		sta	($F0),Y		; store it in OS buffer
		dey			; decrement Y and X
		dex			; 
		bpl	$D5E0		; if +ve do it again
		rts			; then Exit


;*************************************************************************
;*                                                                       *
;*       PLOT Fill triangle routine                                      *
;*                                                                       *
;*************************************************************************

		ldx	#$20		; X=&20
		ldy	#$3E		; Y=&3E
		jsr	$D47C		; copy 300/7+X to 300/7+Y
					; this gets XY data parameters and current graphics
					; cursor position
		jsr	$D632		; exchange 320/3 with 324/7 if 316/7=<322/3
		ldx	#$14		; X=&14
		ldy	#$24		; Y=&24
		jsr	$D636		; 
		jsr	$D632		; 

		ldx	#$20		; 
		ldy	#$2A		; 
		jsr	$D411		; calculate 032A/B-(324/5-320/1)
		lda	$032B		; and store
		sta	$0332		; result

		ldx	#$28		; set pointers
		jsr	$D459		; 
		ldy	#$2E		; 

		jsr	$D0DE		; copy 320/3 32/31
		jsr	$CDE2		; exchange 314/7 with 324/7
		clc			; 
		jsr	$D658		; execute fill routine

		jsr	$CDE2		; 
		ldx	#$20		; 
		jsr	$CDE4		; 
		sec			; 
		jsr	$D658		; 

		ldx	#$3E		; ;X=&3E
		ldy	#$20		; ;Y=&20
		jsr	$D47C		; ;copy 300/7+X to 300/7+Y
		jmp	$D0D9		; ;this gets XY data parameters and current graphics
					; cursor position

		ldx	#$20		; X=&20
		ldy	#$14		; Y=&14
		lda	$0302,X		; 
		cmp	$0302,Y		; 
		lda	$0303,X		; 
		sbc	$0303,Y		; 
		bmi	$D657		; if 302/3+Y>302/3+X return
		jmp	$CDE6		; else swap 302/3+X with 302/3+Y


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
		sbc	$030B		; suptract top row of current window
		tay			; Y=A
		rts			; and exit

		; PLOT routines continue
		; many of the following routines are just manipulations
		; only points of interest will be explained
		php			; store flags
		ldx	#$20		; X=&20
		ldy	#$35		; Y=&35
		jsr	$D411		; 335/6=(324/5+X-320/1)
		lda	$0336		; 
		sta	$033D		; 
		ldx	#$33		; 
		jsr	$D459		; set pointers

		ldy	#$39		; set 339/C=320/3
		jsr	$D0DE		; 
		sec			; 
		lda	$0322		; 
		sbc	$0326		; 
		sta	$031B		; 
		lda	$0323		; 
		sbc	$0327		; 
		sta	$031C		; 
		ora	$031B		; check VDU queque
		beq	$D69F		; 

		jsr	$D6A2		; display a line
		ldx	#$33		; 
		jsr	$D774		; update pointers
		ldx	#$28		; 
		jsr	$D774		; and again!
		inc	$031B		; update VDU queque
		bne	$D688		; and if not empty do it again
		inc	$031C		; else increment next byte
		bne	$D688		; and do it again

		plp			; pull flags
		bcc	$D657		; if carry clear exit
		ldx	#$39		; 
		ldy	#$2E		; 
		stx	$DE		; 
		lda	$0300,X		; is 300/1+x<300/1+Y
		cmp	$0300,Y		; 
		lda	$0301,X		; 
		sbc	$0301,Y		; 
		bmi	$D6BC		; if so D6BC
		tya			; else A=Y
		ldy	$DE		; Y=&DE
		tax			; X=A
		stx	$DE		; &DE=X
		sty	$DF		; &DF=Y
		lda	$0300,Y		; 
		pha			; 
		lda	$0301,Y		; 
		pha			; 
		ldx	$DF		; 
		jsr	$D10F		; check for window violations
		beq	$D6DA		; 
		cmp	#$02		; 
		bne	$D70E		; 
		ldx	#$04		; 
		ldy	$DF		; 
		jsr	$D482		; 
		ldx	$DF		; 
		jsr	$D864		; set a screen address
		ldx	$DE		; X=&DE
		jsr	$D10F		; check for window violations
		lsr			; A=A/2
		bne	$D70E		; if A<>0 then exit
		bcc	$D6E9		; else if C clear D6E9
		ldx	#$00		; 
		ldy	$DF		; 
		sec			; 
		lda	$0300,Y		; 
		sbc	$0300,X		; 
		sta	$DC		; 
		lda	$0301,Y		; 
		sbc	$0301,X		; 
		sta	$DD		; 
		lda	#$00		; 
		asl			; 
		ora	$D1		; 
		ldy	$DC		; 
		bne	$D719		; 
		dec	$DD		; 
		bpl	$D719		; 
		sta	$D1		; 
		jsr	$D0F0		; display a point
		ldx	$DF		; restore X
		pla			; and A
		sta	$0301,X		; store it
		pla			; get back A
		sta	$0300,X		; and store it
		rts			; exit
					; 
		dec	$DC		; 
		tax			; 
		bpl	$D6FE		; 
		sta	$D1		; 
		jsr	$D0F0		; display a point
		ldx	$DC		; 
		inx			; 
		bne	$D72A		; 
		inc	$DD		; 
		txa			; 
		pha			; 
		lsr	$DD		; 
		ror			; 
		ldy	$0361		; number of pixels/byte
		cpy	#$03		; if 3 mode = goto D73B
		beq	$D73B		; 
		bcc	$D73E		; else if <3 mode 2 goto D73E
		lsr	$DD		; else rotate bottom bit of &DD
		ror			; into Accumulator

		lsr	$DD		; rotate bottom bit of &DD
		lsr			; into Accumulator
		ldy	$031A		; Y=line in current graphics cell containing current
					; point
		tax			; X=A
		beq	$D753		; 
		tya			; Y=Y-8
		sec			; 
		sbc	#$08		; 
		tay			; 

		bcs	$D74D		; 
		dec	$D7		; decrement byte of top line off current graphics cell
		jsr	$D104		; display a point
		dex			; 
		bne	$D744		; 
		pla			; 
		and	$0361		; pixels/byte
		beq	$D70E		; 
		tax			; 
		lda	#$00		; A=0
		asl			; 
		ora	$0363		; or with right colour mask
		dex			; 
		bne	$D75C		; 
		sta	$D1		; store as byte mask
		tya			; Y=Y-8
		sec			; 
		sbc	#$08		; 
		tay			; 
		bcs	$D76E		; if carry clear
		dec	$D7		; decrement byte of top line off current graphics cell
		jsr	$D0F3		; display a point
		jmp	$D70E		; and exit via D70E

		inc	$0308,X		; 
		bne	$D77C		; 
		inc	$0309,X		; 
		sec			; 
		lda	$0300,X		; 
		sbc	$0302,X		; 
		sta	$0300,X		; 
		lda	$0301,X		; 
		sbc	$0303,X		; 
		sta	$0301,X		; 
		bpl	$D7C1		; 
		lda	$030A,X		; 
		bmi	$D7A1		; 
		inc	$0306,X		; 
		bne	$D7AC		; 
		inc	$0307,X		; 
		jmp	$D7AC		; 
		lda	$0306,X		; 
		bne	$D7A9		; 
		dec	$0307,X		; 
		dec	$0306,X		; 
		clc			; 
		lda	$0300,X		; 
		adc	$0304,X		; 
		sta	$0300,X		; 
		lda	$0301,X		; 
		adc	$0305,X		; 
		sta	$0301,X		; 
		bmi	$D791		; 
		rts			; 


;*************************************************************************
;*                                                                       *
;*       OSBYTE 135 - READ CHARACTER AT TEXT CURSOR POSITION             *
;*                                                                       *
;*************************************************************************

		ldy	$0360		; get number of logical colours
		bne	$D7DC		; if Y<>0 mode <>7 so D7DC
		lda	($D8),Y		; get address of top scan line of current text chr
		ldy	#$02		; Y=2
		cmp	$C4B7,Y		; compare with conversion table
		bne	$D7D4		; if not equal D7d4
		lda	$C4B6,Y		; else get next lower byte from table
		dey			; Y=Y-1
		dey			; Y=Y-1
		bpl	$D7CB		; and if +ve do it again
		ldy	$0355		; Y=current screen mode
		tax			; return with character in X
		rts			; 
					; 
		jsr	$D808		; set up copy of the pattern bytes at text cursor
		ldx	#$20		; X=&20
		txa			; A=&20
		pha			; Save it
		jsr	$D03E		; get pattern address for code in A
		pla			; get back A
		tax			; and X
		ldy	#$07		; Y=7
		lda	$0328,Y		; get byte in pattern copy
		cmp	($DE),Y		; check against pattern source
		bne	$D7F9		; if not the same D7F9
		dey			; else Y=Y-1
		bpl	$D7EA		; and if +ve D7EA
		txa			; A=X
		cpx	#$7F		; is X=&7F (delete)
		bne	$D7D7		; if not D7D7
		inx			; else X=X+1
		lda	$DE		; get byte lo address
		clc			; clear carry
		adc	#$08		; add 8
		sta	$DE		; store it
		bne	$D7E8		; and go back to check next character if <>0

		txa			; A=X
		bne	$D7E1		; if <>0 D7E1
		beq	$D7D7		; else D7D7

;***************** set up pattern copy ***********************************

		ldy	#$07		; Y=7

		sty	$DA		; &DA=Y
		lda	#$01		; A=1
		sta	$DB		; &DB=A
		lda	$0362		; A=left colour mask
		sta	$DC		; store an &DC
		lda	($D8),Y		; get a byte from current text character
		eor	$0358		; EOR with text background colour
		clc			; clear carry
		bit	$DC		; and check bits of colour mask
		beq	$D820		; if result =0 then D820
		sec			; else set carry
		rol	$DB		; &DB=&DB+Carry
		bcs	$D82E		; if carry now set (bit 7 DB originally set) D82E
		lsr	$DC		; else  &DC=&DC/2
		bcc	$D81B		; if carry clear D81B
		tya			; A=Y
		adc	#$07		; ADD ( (7+carry)
		tay			; Y=A
		bcc	$D810		; 
		ldy	$DA		; read modified values into Y and A
		lda	$DB		; 
		sta	$0328,Y		; store copy
		dey			; and do it again
		bpl	$D80A		; until 8 bytes copied
		rts			; exit

;********* pixel reading *************************************************

		pha			; store A
		tax			; X=A
		jsr	$D149		; set up positional data
		pla			; get back A
		tax			; X=A
		jsr	$D85F		; set a screen address after checking for window
					; violations
		bne	$D85A		; if A<>0 D85A to exit with A=&FF
		lda	($D6),Y		; else get top line of current graphics cell
		asl			; A=A*2 C=bit 7
		rol	$DA		; &DA=&DA+2 +C  C=bit 7 &DA
		asl	$D1		; byte mask=bM*2 +carry from &DA
		php			; save flags
		bcs	$D851		; if carry set D851
		lsr	$DA		; else restore &DA with bit '=0
		plp			; pull flags
		bne	$D847		; if Z set D847
		lda	$DA		; else A=&DA AND number of colours in current mode -1
		and	$0360		; 
		rts			; then exit
					; 
		lda	#$FF		; A=&FF
		rts			; exit

;********** check for window violations and set up screen address **********

		ldx	#$20		; X=&20
		jsr	$D10F		; 
		bne	$D85C		; if A<>0 there is a window violation so D85C
		lda	$0302,X		; else set up graphics scan line variable
		eor	#$FF		; 
		tay			; 
		and	#$07		; 
		sta	$031A		; in 31A
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
		beq	$D884		; if 0 (modes 0,1,2) goto D884
		lsr	$DA		; else &DA=&DA/2
		ror			; and A=A/2 +C if set
					; so 2 byte offset =offset/2

		adc	$0350		; add screen top left hand corner lo
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
		lda	$C406,Y		; A=&80 /2^Y using look up table
		sta	$D1		; store it
		pla			; get back A
		ldy	$0361		; Y=&number of pixels/byte
		cpy	#$03		; is Y=3 (modes 1,6)
		beq	$D8B2		; goto D8B2
		bcs	$D8B5		; if mode =1 or 4 D8B5
		asl			; A/&DA =A/&DA *2
		rol	$DA		; 

		asl			; 
		rol	$DA		; 

		and	#$F8		; clear bits 0-2
		clc			; clear carry

		adc	$D6		; add A/&DA to &D6/7
		sta	$D6		; 
		lda	$DA		; 
		adc	$D7		; 
		bpl	$D8C6		; if result +ve D8C6
		sec			; else set carry
		sbc	$0354		; and subtract screen memory size making it wrap round

		sta	$D7		; store it in &D7
		ldy	$031A		; get line in graphics cell containing current graphics
		lda	#$00		; point  A=0
		rts			; And exit
					; 
		pha			; Push A
		lda	#$A0		; A=&A0
		ldx	$026A		; X=number of items in VDU queque
		bne	$D916		; if not 0 D916
		bit	$D0		; else check VDU status byte
		bne	$D916		; if either VDU is disabled or plot to graphics
					; cursor enabled then D916
		bvs	$D8F5		; if cursor editing enabled D8F5
		lda	$035F		; else get 6845 register start setting
		and	#$9F		; clear bits 5 and 6
		ora	#$40		; set bit 6 to modify last cursor size setting
		jsr	$C954		; change write cursor format
		ldx	#$18		; X=&18
		ldy	#$64		; Y=&64
		jsr	$D482		; set text input cursor from text output cursor
		jsr	$CD7A		; modify character at cursor poistion
		lda	#$02		; A=2
		jsr	$C59D		; bit 1 of VDU status is set to bar scrolling


		lda	#$BF		; A=&BF
		jsr	$C5A8		; bit 6 of VDU status =0
		pla			; Pull A
		and	#$7F		; clear hi bit (7)
		jsr	$C4C0		; entire VDU routine !!
		lda	#$40		; A=&40
		jmp	$C59D		; exit


		lda	#$20		; A=&20
		bit	$D0		; if bit 6 cursor editing is set
		bvc	$D8CB		; 
		bne	$D8CB		; or bit 5 is set exit &D8CB
		jsr	$D7C2		; read a character from the screen
		beq	$D917		; if A=0 on return exit via D917
		pha			; else store A
		jsr	$C664		; perform cursor right

		pla			; restore A
		rts			; and exit
					; 
		lda	#$BD		; zero bits 2 and 6 of VDU status
		jsr	$C5A8		; 
		jsr	$C951		; set normal cursor
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
		ldx	$C440,Y		; X=screen size type, 0-4
		lda	$C45E,X		; A=high byte of start address for screen type
		ldx	#$00		; Returned address is &xx00
		bit	$028E		; Check available RAM
		bmi	$D93E		; If bit 7 set then 32K RAM, so return address
		and	#$3F		; 16K RAM, so drop address to bottom 16K
		cpy	#$04		; Check screen mode
		bcs	$D93E		; If mode 4-7, return the address
		txa			; If mode 0-3, return &0000 as not enough memory
; exit
		tay			; Pass high byte of address to Y
		rts			; and return address in YX


