;************************** Check window limits *************************
		; 
.org		$d10d

		ldx	#$24		; X=&24
		ldy	#$00		; Y=0
		sty	$DA		; &DA=0
		ldy	#$02		; Y=2
		jsr	$D128		; check vertical graphics position 326/7
					; bottom and top margins 302/3, 306/7
		asl	$DA		; DATA is set in &DA bits 0 and 1 then shift left
		asl	$DA		; twice to make room for next pass
		dex			; X=&22
		dex			; 
		ldy	#$00		; Y=0
		jsr	$D128		; left and right margins 300/1, 304/5
					; cursor horizontal position 324/5
		inx			; X=X+2
		inx			; 
		lda	$DA		; A=&DA
		rts			; exit

;*** cursor and margins check ******************************************
		; 
		lda	$0302,X		; check for window violation
		cmp	$0300,Y		; 300/1 +Y > 302/3+X
		lda	$0303,X		; then window fault
		sbc	$0301,Y		; 
		bmi	$D146		; so D146

		lda	$0304,Y		; check other windows
		cmp	$0302,X		; 
		lda	$0305,Y		; 
		sbc	$0303,X		; 
		bpl	$D148		; if no violation exit
		inc	$DA		; else DA=DA+1

		inc	$DA		; DA=DA+1
		rts			; and exit  DA=0 no problems DA=1 first check 2, 2nd

;***********set up and adjust positional data ****************************

		lda	#$FF		; A=&FF
		bne	$D150		; then &D150

		lda	$031F		; get first parameter in plot

		sta	$DA		; store in &DA
		ldy	#$02		; Y=2
		jsr	$D176		; set up vertical coordinates/2
		jsr	$D1AD		; /2 again to convert 1023 to 0-255 for internal use
					; this is why minimum vertical plot separation is 4
		ldy	#$00		; Y=0
		dex			; X=x-2
		dex			; 
		jsr	$D176		; set up horiz. coordinates/2 this is OK for mode0,4
		ldy	$0361		; get number of pixels/byte (-1)
		cpy	#$03		; if Y=3 (modes 1 and 5)
		beq	$D16D		; D16D
		bcs	$D170		; for modes 0 & 4 this is 7 so D170
		jsr	$D1AD		; for other modes divide by 2 twice

		jsr	$D1AD		; divide by 2
		lda	$0356		; get screen display type
		bne	$D1AD		; if not 0 (modes 3-7) divide by 2 again
		rts			; and exit

;for mode 0 1 division  1280 becomes 640 = horizontal resolution
;for mode 1 2 divisions 1280 becomes 320 = horizontal resolution
;for mode 2 3 divisions 1280 becomes 160 = horizontal resolution
;for mode 4 2 divisions 1280 becomes 320 = horizontal resolution
;for mode 5 3 divisions 1280 becomes 160 = horizontal resolution

;********** calculate external coordinates in internal format ***********
;on entry X is usually &1E or &20

		clc			; clear carry
		lda	$DA		; get &DA
		and	#$04		; if bit 2=0
		beq	$D186		; then D186 to calculate relative coordinates
		lda	$0302,X		; else get coordinate
		pha			; 
		lda	$0303,X		; 
		bcc	$D194		; and goto D194

		lda	$0302,X		; get coordinate
		adc	$0310,Y		; add cursor position
		pha			; save it
		lda	$0303,X		; 
		adc	$0311,Y		; add cursor
		clc			; clear carry

		sta	$0311,Y		; save new cursor
		adc	$030D,Y		; add graphics origin
		sta	$0303,X		; store it
		pla			; get back lo byte
		sta	$0310,Y		; save it in new cursor lo
		clc			; clear carry
		adc	$030C,Y		; add to graphics orgin
		sta	$0302,X		; store it
		bcc	$D1AD		; if carry set
		inc	$0303,X		; increment hi byte as you would expect!

		lda	$0303,X		; get hi byte
		asl			; 
		ror	$0303,X		; divide by 2
		ror	$0302,X		; 
		rts			; and exit

;***** calculate external coordinates from internal coordinates************

		ldy	#$10		; Y=10
		jsr	$D488		; copy 324/7 to 310/3 i.e.current graphics cursor
					; position to position in external values
		ldx	#$02		; X=2
		ldy	#$02		; Y=2
		jsr	$D1D5		; multiply 312/3 by 4 and subtract graphics origin
		ldx	#$00		; X=0
		ldy	#$04		; Y=4
		lda	$0361		; get  number of pixels/byte
		dey			; Y=Y-1
		lsr			; divide by 2
		bne	$D1CB		; if result not 0 D1CB
		lda	$0356		; else get screen display type
		beq	$D1D5		; and if 0 D1D5
		iny			; 

		asl	$0310,X		; multiply coordinate by 2
		rol	$0311,X		; 
		dey			; Y-Y-1
		bne	$D1D5		; and if Y<>0 do it again
		sec			; set carry
		jsr	$D1E3		; 
		inx			; increment X

		lda	$0310,X		; get current graphics position in external coordinates
		sbc	$030C,X		; subtract origin
		sta	$0310,X		; store in graphics position
		rts			; and exit

;************* compare X and Y PLOT spans ********************************

		jsr	$D40D		; Set X and Y spans in workspace 328/9 32A/B
		lda	$032B		; compare spans
		eor	$0329		; if result -ve spans are different in sign so
		bmi	$D207		; goto D207
		lda	$032A		; else A=hi byte of difference in spans
		cmp	$0328		; 
		lda	$032B		; 
		sbc	$0329		; 
		jmp	$D214		; and goto D214

		lda	$0328		; A = hi byte of SUM of spans
		clc			; 
		adc	$032A		; 
		lda	$0329		; 
		adc	$032B		; 

		ror			; A=A/2
		ldx	#$00		; X=0
		eor	$032B		; 
		bpl	$D21E		; if positive result D21E

		ldx	#$02		; else X=2

		stx	$DE		; store it
		lda	$C4AA,X		; set up vector address
		sta	$035D		; in 35D
		lda	$C4AB,X		; 
		sta	$035E		; and 35E
		lda	$0329,X		; get hi byte of span
		bpl	$D235		; if +ve D235
		ldx	#$24		; X=&24
		bne	$D237		; jump to D237

		ldx	#$20		; X=&20
		stx	$DF		; store it
		ldy	#$2C		; Y=&2C
		jsr	$D48A		; get X coordinate data or horizontal coord of
					; curent graphics cursor
		lda	$DF		; get back original X
		eor	#$04		; covert &20 to &24 and vice versa
		sta	$DD		; 
		ora	$DE		; 
		tax			; 
		jsr	$D480		; copy 330/1 to 300/1+X
		lda	$031F		; get plot type
		and	#$10		; check bit 4
		asl			; 
		asl			; 
		asl			; move to bit 7
		sta	$DB		; store it
		ldx	#$2C		; X=&2C
		jsr	$D10F		; check for window violations
		sta	$DC		; 
		beq	$D263		; if none then D263
		lda	#$40		; else set bit 6 of &DB
		ora	$DB		; 
		sta	$DB		; 

		ldx	$DD		; 
		jsr	$D10F		; check window violations again
		bit	$DC		; if bit 7 of &DC NOT set
		beq	$D26D		; D26D
		rts			; else exit
					; 
		ldx	$DE		; X=&DE
		beq	$D273		; if X=0 D273
		lsr			; A=A/2
		lsr			; A=A/2

		and	#$02		; clear all but bit 2
		beq	$D27E		; if bit 2 set D27E
		txa			; else A=X
		ora	#$04		; A=A or 4 setting bit 3
		tax			; X=A
		jsr	$D480		; set 300/1+x to 330/1
		jsr	$D42C		; more calcualtions
		lda	$DE		; A=&DE EOR 2
		eor	#$02		; 
		tax			; X=A
		tay			; Y=A
		lda	$0329		; compare upper byte of spans
		eor	$032B		; 
		bpl	$D290		; if signs are the same D290
		inx			; else X=X+1
		lda	$C4AE,X		; get vector addresses and store 332/3
		sta	$0332		; 
		lda	$C4B2,X		; 
		sta	$0333		; 

		lda	#$7F		; A=&7F
		sta	$0334		; store it
		bit	$DB		; if bit 6 set
		bvs	$D2CE		; the D2CE
		lda	$C447,X		; get VDU section number
		tax			; X=A
		sec			; set carry
		lda	$0300,X		; subtract coordinates
		sbc	$032C,Y		; 
		sta	$DA		; 
		lda	$0301,X		; 
		sbc	$032D,Y		; 
		ldy	$DA		; Y=hi
		tax			; X=lo=A
		bpl	$D2C0		; and if A+Ve D2C0
		jsr	$D49B		; negate Y/A

		tax			; X=A increment Y/A
		iny			; Y=Y+1
		bne	$D2C5		; 
		inx			; X=X+1
		txa			; A=X
		beq	$D2CA		; if A=0 D2CA
		ldy	#$00		; else Y=0

		sty	$DF		; &DF=Y
		beq	$D2D7		; if 0 then D2D7
		txa			; A=X
		lsr			; A=A/4
		ror			; 
		ora	#$02		; bit 1 set
		eor	$DE		; 
		sta	$DE		; and store
		ldx	#$2C		; X=&2C
		jsr	$D864		; 
		ldx	$DC		; 
		bne	$D2E2		; 
		dec	$DD		; 
		dex			; X=X-1
		lda	$DB		; A=&3B
		beq	$D306		; if 0 D306
		bpl	$D2F9		; else if +ve D2F9
		bit	$0334		; 
		bpl	$D2F3		; if bit 7=0 D2F3
		dec	$0334		; else decrement
		bne	$D316		; and if not 0 D316

		inc	$0334		; 
		asl			; A=A*2
		bpl	$D306		; if +ve D306
		stx	$DC		; 
		ldx	#$2C		; 
		jsr	$D85F		; calcualte screen position
		ldx	$DC		; get back original X
		ora	#$00		; 
		bne	$D316		; 
		lda	$D1		; byte mask for current graphics point
		and	$D4		; and with graphics colour byte
		ora	($D6),Y		; or  with curent graphics cell line
		sta	$DA		; store result
		lda	$D5		; same again with next byte (hi??)
		and	$D1		; 
		eor	$DA		; 
		sta	($D6),Y		; then store it inm current graphics line
		sec			; set carry
		lda	$0335		; A=&335/6-&337/8
		sbc	$0337		; 
		sta	$0335		; 
		lda	$0336		; 
		sbc	$0338		; 
		bcs	$D339		; if carry set D339
		sta	$DA		; 
		lda	$0335		; 
		adc	$0339		; 
		sta	$0335		; 
		lda	$DA		; 
		adc	$033A		; 
		clc			; 
		sta	$0336		; 
		php			; 
		bcs	$D348		; if carry clear jump to VDU routine else D348
		jmp	($0332)		; 

;****** vertical scan module 1******************************************

		dey			; Y=Y-1
		bpl	$D348		; if + D348
		jsr	$D3D3		; else d3d3 to advance pointers
		jmp	($035D)		; and JUMP (&35D)

;****** vertical scan module 2******************************************

		iny			; Y=Y+1
		cpy	#$08		; if Y<>8
		bne	$D348		; then D348
		clc			; else clear carry
		lda	$D6		; get address of top line of cuirrent graphics cell
		adc	$0352		; add number of bytes/character row
		sta	$D6		; store it
		lda	$D7		; do same for hibyte
		adc	$0353		; 
		bpl	$D363		; if result -ve then we are above screen RAM
		sec			; so
		sbc	$0354		; subtract screen memory size hi
		sta	$D7		; store it this wraps around point to screen RAM
		ldy	#$00		; Y=0
		jmp	($035D)		; 

;****** horizontal scan module 1******************************************

		lsr	$D1		; shift byte mask
		bcc	$D348		; if carry clear (&D1 was +ve) goto D348
		jsr	$D3ED		; else reset pointers
		jmp	($035D)		; and off to do more

;****** horizontal scan module 2******************************************

		asl	$D1		; shift byte mask
		bcc	$D348		; if carry clear (&D1 was +ve) goto D348
		jsr	$D3FD		; else reset pointers
		jmp	($035D)		; and off to do more

		dey			; Y=Y-1
		bpl	$D38D		; if +ve D38D
		jsr	$D3D3		; advance pointers
		bne	$D38D		; goto D38D normally
		lsr	$D1		; shift byte mask
		bcc	$D38D		; if carry clear (&D1 was +ve) goto D348
		jsr	$D3ED		; else reset pointers
		plp			; pull flags
		inx			; X=X+1
		bne	$D395		; if X>0 D395
		inc	$DD		; else increment &DD
		beq	$D39F		; and if not 0 D39F
		bit	$DB		; else if BIT 6 = 1
		bvs	$D3A0		; goto D3A0
		bcs	$D3D0		; if BIT 7=1 D3D0
		dec	$DF		; else Decrement &DF
		bne	$D3D0		; and if not Zero D3D0
		rts			; else return
					; 
		lda	$DE		; A=&DE
		stx	$DC		; &DC=X
		and	#$02		; clear all but bit 1
		tax			; X=A
		bcs	$D3C2		; and if carry set goto D3C2
		bit	$DE		; if Bit 7 of &DE =1
		bmi	$D3B7		; then D3B7
		inc	$032C,X		; else increment
		bne	$D3C2		; and if not 0 D3C2
		inc	$032D,X		; else increment hi byte
		bcc	$D3C2		; and if carry clear D3C2
		lda	$032C,X		; esle A=32C,X
		bne	$D3BF		; and if not 0 D3BF
		dec	$032D,X		; decrement hi byte
		dec	$032C,X		; decrement lo byte

		txa			; A=X
		eor	#$02		; invert bit 2
		tax			; X=A
		inc	$032C,X		; Increment 32C/D
		bne	$D3CE		; 
		inc	$032D,X		; 
		ldx	$DC		; X=&DC
		jmp	$D2E3		; jump to D2E3

;**********move display point up a line **********************************
		sec			; SET CARRY
		lda	$D6		; subtract number of bytes/line from address of
		sbc	$0352		; top line of current graphics cell
		sta	$D6		; 
		lda	$D7		; 
		sbc	$0353		; 
		cmp	$034E		; compare with bottom of screen memory
		bcs	$D3E8		; if outside screen RAM
		adc	$0354		; add screen memory size to wrap it around
		sta	$D7		; store in current address of graphics cell top line
		ldy	#$07		; Y=7
		rts			; and RETURN

		lda	$0362		; get current left colour mask
		sta	$D1		; store it
		lda	$D6		; get current top line of graphics cell
		adc	#$07		; ADD 7
		sta	$D6		; 
		bcc	$D3FC		; 
		inc	$D7		; 
		rts			; and return

		lda	$0363		; get right colour mask
		sta	$D1		; store it
		lda	$D6		; A=top line graphics cell low
		bne	$D408		; if not 0 D408
		dec	$D7		; else decrement hi byte

		sbc	#$08		; subtract 9 (8 + carry)
		sta	$D6		; and store in low byte
		rts			; return

;********:: coordinate subtraction ***************************************

		ldy	#$28		; X=&28
		ldx	#$20		; Y=&20
		jsr	$D418		; 
		inx			; X=X+2
		inx			; 
		iny			; Y=Y+2
		iny			; 

		sec			; set carry
		lda	$0304,X		; subtract coordinates
		sbc	$0300,X		; 
		sta	$0300,Y		; 
		lda	$0305,X		; 
		sbc	$0301,X		; 
		sta	$0301,Y		; 
		rts			; and return

		lda	$DE		; A=&DE
		bne	$D437		; if A=0 D437
		ldx	#$28		; X=&28
		ldy	#$2A		; Y=&2A
		jsr	$CDDE		; exchange 300/1+Y with 300/1+X
					; IN THIS CASE THE X AND Y SPANS!

		ldx	#$28		; X=&28
		ldy	#$37		; Y=&37
		jsr	$D48A		; copy &300/4+Y to &300/4+X
					; transferring X and Y spans in this case
		sec			; set carry
		ldx	$DE		; X=&DE
		lda	$0330		; subtract 32C/D,X from 330/1
		sbc	$032C,X		; 
		tay			; partial answer in Y
		lda	$0331		; 
		sbc	$032D,X		; 
		bmi	$D453		; if -ve D453
		jsr	$D49B		; else negate Y/A

		sta	$DD		; store A
		sty	$DC		; and Y
		ldx	#$35		; X=&35
		jsr	$D467		; get coordinates
		lsr			; 
		sta	$0301,X		; 
		tya			; 
		ror			; 
		sta	$0300,X		; 
		dex			; 
		dex			; 

		ldy	$0304,X		; 
		lda	$0305,X		; 
		bpl	$D47B		; if A is +ve RETURN
		jsr	$D49B		; else negate Y/A
		sta	$0305,X		; store back again
		pha			; 
		tya			; 
		sta	$0304,X		; 
		pla			; get back A
		rts			; and exit
					; 
		lda	#$08		; A=8
		bne	$D48C		; copy 8 bytes
		ldy	#$30		; Y=&30
		lda	#$02		; A=2
		bne	$D48C		; copy 2 bytes
		ldy	#$28		; copy 4 bytes from 324/7 to 328/B
		ldx	#$24		; 
		lda	#$04		; 

;***********copy A bytes from 300,X to 300,Y ***************************

		sta	$DA		; 
		lda	$0300,X		; 
		sta	$0300,Y		; 
		inx			; 
		iny			; 
		dec	$DA		; 
		bne	$D48E		; 
		rts			; and return

;************* negation routine ******************************************

		pha			; save A
		tya			; A=Y
		eor	#$FF		; invert
		tay			; Y=A
		pla			; get back A
		eor	#$FF		; invert
		iny			; Y=Y+1
		bne	$D4A9		; if not 0 exit
		clc			; else
		adc	#$01		; add 1 to A
		rts			; return
					; 
		jsr	$D85D		; check window boundaries and set up screen pointer
		bne	$D4B7		; if A<>0 D4B7
		lda	($D6),Y		; else get byte from current graphics cell
		eor	$035A		; compare with current background colour
		sta	$DA		; store it
		rts			; and RETURN

		pla			; get back return link
		pla			; 
		inc	$0326		; increment current graphics cursor vertical lo
		jmp	$D545		; 


