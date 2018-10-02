;************************** Check window limits *************************
		; 
.org		$d10d

_LD10D:		ldx	#$24		; X=&24
_LD10F:		ldy	#$00		; Y=0
		sty	$DA		; &DA=0
		ldy	#$02		; Y=2
		jsr	_LD128		; check vertical graphics position 326/7
					; bottom and top margins 302/3, 306/7
		asl	$DA		; DATA is set in &DA bits 0 and 1 then shift left
		asl	$DA		; twice to make room for next pass
		dex			; X=&22
		dex			; 
		ldy	#$00		; Y=0
		jsr	_LD128		; left and right margins 300/1, 304/5
					; cursor horizontal position 324/5
		inx			; X=X+2
		inx			; 
		lda	$DA		; A=&DA
		rts			; exit

;*** cursor and margins check ******************************************
		; 
_LD128:		lda	$0302,X		; check for window violation
		cmp	$0300,Y		; 300/1 +Y > 302/3+X
		lda	$0303,X		; then window fault
		sbc	$0301,Y		; 
		bmi	_BD146		; so D146

		lda	$0304,Y		; check other windows
		cmp	$0302,X		; 
		lda	$0305,Y		; 
		sbc	$0303,X		; 
		bpl	_BD148		; if no violation exit
		inc	$DA		; else DA=DA+1

_BD146:		inc	$DA		; DA=DA+1
_BD148:		rts			; and exit  DA=0 no problems DA=1 first check 2, 2nd

;***********set up and adjust positional data ****************************

_LD149:		lda	#$FF		; A=&FF
		bne	_BD150		; then &D150

_LD14D:		lda	$031f		; get first parameter in plot

_BD150:		sta	$DA		; store in &DA
		ldy	#$02		; Y=2
		jsr	_LD176		; set up vertical coordinates/2
		jsr	_LD1AD		; /2 again to convert 1023 to 0-255 for internal use
					; this is why minimum vertical plot separation is 4
		ldy	#$00		; Y=0
		dex			; X=x-2
		dex			; 
		jsr	_LD176		; set up horiz. coordinates/2 this is OK for mode0,4
		ldy	$0361		; get number of pixels/byte (-1)
		cpy	#$03		; if Y=3 (modes 1 and 5)
		beq	_BD16D		; D16D
		bcs	_BD170		; for modes 0 & 4 this is 7 so D170
		jsr	_LD1AD		; for other modes divide by 2 twice

_BD16D:		jsr	_LD1AD		; divide by 2
_BD170:		lda	$0356		; get screen display type
		bne	_LD1AD		; if not 0 (modes 3-7) divide by 2 again
		rts			; and exit

;for mode 0 1 division  1280 becomes 640 = horizontal resolution
;for mode 1 2 divisions 1280 becomes 320 = horizontal resolution
;for mode 2 3 divisions 1280 becomes 160 = horizontal resolution
;for mode 4 2 divisions 1280 becomes 320 = horizontal resolution
;for mode 5 3 divisions 1280 becomes 160 = horizontal resolution

;********** calculate external coordinates in internal format ***********
;on entry X is usually &1E or &20

_LD176:		clc			; clear carry
		lda	$DA		; get &DA
		and	#$04		; if bit 2=0
		beq	_BD186		; then D186 to calculate relative coordinates
		lda	$0302,X		; else get coordinate
		pha			; 
		lda	$0303,X		; 
		bcc	_BD194		; and goto D194

_BD186:		lda	$0302,X		; get coordinate
		adc	$0310,Y		; add cursor position
		pha			; save it
		lda	$0303,X		; 
		adc	$0311,Y		; add cursor
		clc			; clear carry

_BD194:		sta	$0311,Y		; save new cursor
		adc	$030d,Y		; add graphics origin
		sta	$0303,X		; store it
		pla			; get back lo byte
		sta	$0310,Y		; save it in new cursor lo
		clc			; clear carry
		adc	$030c,Y		; add to graphics orgin
		sta	$0302,X		; store it
		bcc	_LD1AD		; if carry set
		inc	$0303,X		; increment hi byte as you would expect!

_LD1AD:		lda	$0303,X		; get hi byte
		asl			; 
		ror	$0303,X		; divide by 2
		ror	$0302,X		; 
		rts			; and exit

;***** calculate external coordinates from internal coordinates************

_LD1B8:		ldy	#$10		; Y=10
		jsr	_LD488		; copy 324/7 to 310/3 i.e.current graphics cursor
					; position to position in external values
		ldx	#$02		; X=2
		ldy	#$02		; Y=2
		jsr	_LD1D5		; multiply 312/3 by 4 and subtract graphics origin
		ldx	#$00		; X=0
		ldy	#$04		; Y=4
		lda	$0361		; get  number of pixels/byte
_BD1CB:		dey			; Y=Y-1
		lsr			; divide by 2
		bne	_BD1CB		; if result not 0 D1CB
		lda	$0356		; else get screen display type
		beq	_LD1D5		; and if 0 D1D5
		iny			; 

_LD1D5:		asl	$0310,X		; multiply coordinate by 2
		rol	$0311,X		; 
		dey			; Y-Y-1
		bne	_LD1D5		; and if Y<>0 do it again
		sec			; set carry
		jsr	_LD1E3		; 
		inx			; increment X

_LD1E3:		lda	$0310,X		; get current graphics position in external coordinates
		sbc	$030c,X		; subtract origin
		sta	$0310,X		; store in graphics position
		rts			; and exit

;************* compare X and Y PLOT spans ********************************

_LD1ED:		jsr	_LD40D		; Set X and Y spans in workspace 328/9 32A/B
		lda	$032b		; compare spans
		eor	$0329		; if result -ve spans are different in sign so
		bmi	_BD207		; goto D207
		lda	$032a		; else A=hi byte of difference in spans
		cmp	$0328		; 
		lda	$032b		; 
		sbc	$0329		; 
		jmp	_LD214		; and goto D214

_BD207:		lda	$0328		; A = hi byte of SUM of spans
		clc			; 
		adc	$032a		; 
		lda	$0329		; 
		adc	$032b		; 

_LD214:		ror			; A=A/2
		ldx	#$00		; X=0
		eor	$032b		; 
		bpl	_BD21E		; if positive result D21E

		ldx	#$02		; else X=2

_BD21E:		stx	$DE		; store it
		lda	_LC4AA,X		; set up vector address
		sta	$035d		; in 35D
		lda	_LC4AB,X		; 
		sta	$035e		; and 35E
		lda	$0329,X		; get hi byte of span
		bpl	_BD235		; if +ve D235
		ldx	#$24		; X=&24
		bne	_BD237		; jump to D237

_BD235:		ldx	#$20		; X=&20
_BD237:		stx	$DF		; store it
		ldy	#$2C		; Y=&2C
		jsr	_LD48A		; get X coordinate data or horizontal coord of
					; curent graphics cursor
		lda	$DF		; get back original X
		eor	#$04		; covert &20 to &24 and vice versa
		sta	$DD		; 
		ora	$DE		; 
		tax			; 
		jsr	_LD480		; copy 330/1 to 300/1+X
		lda	$031f		; get plot type
		and	#$10		; check bit 4
		asl			; 
		asl			; 
		asl			; move to bit 7
		sta	$DB		; store it
		ldx	#$2C		; X=&2C
		jsr	_LD10F		; check for window violations
		sta	$DC		; 
		beq	_BD263		; if none then D263
		lda	#$40		; else set bit 6 of &DB
		ora	$DB		; 
		sta	$DB		; 

_BD263:		ldx	$DD		; 
		jsr	_LD10F		; check window violations again
		bit	$DC		; if bit 7 of &DC NOT set
		beq	_BD26D		; D26D
		rts			; else exit
					; 
_BD26D:		ldx	$DE		; X=&DE
		beq	_BD273		; if X=0 D273
		lsr			; A=A/2
		lsr			; A=A/2

_BD273:		and	#$02		; clear all but bit 2
		beq	_BD27E		; if bit 2 set D27E
		txa			; else A=X
		ora	#$04		; A=A or 4 setting bit 3
		tax			; X=A
		jsr	_LD480		; set 300/1+x to 330/1
_BD27E:		jsr	_LD42C		; more calcualtions
		lda	$DE		; A=&DE EOR 2
		eor	#$02		; 
		tax			; X=A
		tay			; Y=A
		lda	$0329		; compare upper byte of spans
		eor	$032b		; 
		bpl	_BD290		; if signs are the same D290
		inx			; else X=X+1
_BD290:		lda	_LC4AE,X		; get vector addresses and store 332/3
		sta	$0332		; 
		lda	_LC4B2,X		; 
		sta	$0333		; 

		lda	#$7F		; A=&7F
		sta	$0334		; store it
		bit	$DB		; if bit 6 set
		bvs	_BD2CE		; the D2CE
		lda	_LC447,X		; get VDU section number
		tax			; X=A
		sec			; set carry
		lda	$0300,X		; subtract coordinates
		sbc	$032c,Y		; 
		sta	$DA		; 
		lda	$0301,X		; 
		sbc	$032d,Y		; 
		ldy	$DA		; Y=hi
		tax			; X=lo=A
		bpl	_BD2C0		; and if A+Ve D2C0
		jsr	_LD49B		; negate Y/A

_BD2C0:		tax			; X=A increment Y/A
		iny			; Y=Y+1
		bne	_BD2C5		; 
		inx			; X=X+1
_BD2C5:		txa			; A=X
		beq	_BD2CA		; if A=0 D2CA
		ldy	#$00		; else Y=0

_BD2CA:		sty	$DF		; &DF=Y
		beq	_BD2D7		; if 0 then D2D7
_BD2CE:		txa			; A=X
		lsr			; A=A/4
		ror			; 
		ora	#$02		; bit 1 set
		eor	$DE		; 
		sta	$DE		; and store
_BD2D7:		ldx	#$2C		; X=&2C
		jsr	_LD864		; 
		ldx	$DC		; 
		bne	_BD2E2		; 
		dec	$DD		; 
_BD2E2:		dex			; X=X-1
_LD2E3:		lda	$DB		; A=&3B
		beq	_BD306		; if 0 D306
		bpl	_BD2F9		; else if +ve D2F9
		bit	$0334		; 
		bpl	_BD2F3		; if bit 7=0 D2F3
		dec	$0334		; else decrement
		bne	_BD316		; and if not 0 D316

_BD2F3:		inc	$0334		; 
		asl			; A=A*2
		bpl	_BD306		; if +ve D306
_BD2F9:		stx	$DC		; 
		ldx	#$2C		; 
		jsr	_LD85F		; calcualte screen position
		ldx	$DC		; get back original X
		ora	#$00		; 
		bne	_BD316		; 
_BD306:		lda	$D1		; byte mask for current graphics point
		and	$D4		; and with graphics colour byte
		ora	($D6),Y		; or  with curent graphics cell line
		sta	$DA		; store result
		lda	$D5		; same again with next byte (hi??)
		and	$D1		; 
		eor	$DA		; 
		sta	($D6),Y		; then store it inm current graphics line
_BD316:		sec			; set carry
		lda	$0335		; A=&335/6-&337/8
		sbc	$0337		; 
		sta	$0335		; 
		lda	$0336		; 
		sbc	$0338		; 
		bcs	_BD339		; if carry set D339
		sta	$DA		; 
		lda	$0335		; 
		adc	$0339		; 
		sta	$0335		; 
		lda	$DA		; 
		adc	$033a		; 
		clc			; 
_BD339:		sta	$0336		; 
		php			; 
		bcs	_BD348		; if carry clear jump to VDU routine else D348
		jmp	($0332)		; 

;****** vertical scan module 1******************************************

		dey			; Y=Y-1
		bpl	_BD348		; if + D348
		jsr	_LD3D3		; else d3d3 to advance pointers
_BD348:		jmp	($035d)		; and JUMP (&35D)

;****** vertical scan module 2******************************************

		iny			; Y=Y+1
		cpy	#$08		; if Y<>8
		bne	_BD348		; then D348
		clc			; else clear carry
		lda	$D6		; get address of top line of cuirrent graphics cell
		adc	$0352		; add number of bytes/character row
		sta	$D6		; store it
		lda	$D7		; do same for hibyte
		adc	$0353		; 
		bpl	_BD363		; if result -ve then we are above screen RAM
		sec			; so
		sbc	$0354		; subtract screen memory size hi
_BD363:		sta	$D7		; store it this wraps around point to screen RAM
		ldy	#$00		; Y=0
		jmp	($035d)		; 

;****** horizontal scan module 1******************************************

		lsr	$D1		; shift byte mask
		bcc	_BD348		; if carry clear (&D1 was +ve) goto D348
		jsr	_LD3ED		; else reset pointers
		jmp	($035d)		; and off to do more

;****** horizontal scan module 2******************************************

		asl	$D1		; shift byte mask
		bcc	_BD348		; if carry clear (&D1 was +ve) goto D348
		jsr	_LD3FD		; else reset pointers
		jmp	($035d)		; and off to do more

		dey			; Y=Y-1
		bpl	_BD38D		; if +ve D38D
		jsr	_LD3D3		; advance pointers
		bne	_BD38D		; goto D38D normally
		lsr	$D1		; shift byte mask
		bcc	_BD38D		; if carry clear (&D1 was +ve) goto D348
		jsr	_LD3ED		; else reset pointers
_BD38D:		plp			; pull flags
		inx			; X=X+1
		bne	_BD395		; if X>0 D395
		inc	$DD		; else increment &DD
		beq	_BD39F		; and if not 0 D39F
_BD395:		bit	$DB		; else if BIT 6 = 1
		bvs	_BD3A0		; goto D3A0
		bcs	_BD3D0		; if BIT 7=1 D3D0
		dec	$DF		; else Decrement &DF
		bne	_BD3D0		; and if not Zero D3D0
_BD39F:		rts			; else return
					; 
_BD3A0:		lda	$DE		; A=&DE
		stx	$DC		; &DC=X
		and	#$02		; clear all but bit 1
		tax			; X=A
		bcs	_BD3C2		; and if carry set goto D3C2
		bit	$DE		; if Bit 7 of &DE =1
		bmi	_BD3B7		; then D3B7
		inc	$032c,X		; else increment
		bne	_BD3C2		; and if not 0 D3C2
		inc	$032d,X		; else increment hi byte
		bcc	_BD3C2		; and if carry clear D3C2
_BD3B7:		lda	$032c,X		; esle A=32C,X
		bne	_BD3BF		; and if not 0 D3BF
		dec	$032d,X		; decrement hi byte
_BD3BF:		dec	$032c,X		; decrement lo byte

_BD3C2:		txa			; A=X
		eor	#$02		; invert bit 2
		tax			; X=A
		inc	$032c,X		; Increment 32C/D
		bne	_BD3CE		; 
		inc	$032d,X		; 
_BD3CE:		ldx	$DC		; X=&DC
_BD3D0:		jmp	_LD2E3		; jump to D2E3

;**********move display point up a line **********************************
_LD3D3:		sec			; SET CARRY
		lda	$D6		; subtract number of bytes/line from address of
		sbc	$0352		; top line of current graphics cell
		sta	$D6		; 
		lda	$D7		; 
		sbc	$0353		; 
		cmp	$034e		; compare with bottom of screen memory
		bcs	_BD3E8		; if outside screen RAM
		adc	$0354		; add screen memory size to wrap it around
_BD3E8:		sta	$D7		; store in current address of graphics cell top line
		ldy	#$07		; Y=7
		rts			; and RETURN

_LD3ED:		lda	$0362		; get current left colour mask
		sta	$D1		; store it
		lda	$D6		; get current top line of graphics cell
		adc	#$07		; ADD 7
		sta	$D6		; 
		bcc	_BD3FC		; 
		inc	$D7		; 
_BD3FC:		rts			; and return

_LD3FD:		lda	$0363		; get right colour mask
		sta	$D1		; store it
		lda	$D6		; A=top line graphics cell low
		bne	_BD408		; if not 0 D408
		dec	$D7		; else decrement hi byte

_BD408:		sbc	#$08		; subtract 9 (8 + carry)
		sta	$D6		; and store in low byte
		rts			; return

;********:: coordinate subtraction ***************************************

_LD40D:		ldy	#$28		; X=&28
		ldx	#$20		; Y=&20
_LD411:		jsr	_LD418		; 
		inx			; X=X+2
		inx			; 
		iny			; Y=Y+2
		iny			; 

_LD418:		sec			; set carry
		lda	$0304,X		; subtract coordinates
		sbc	$0300,X		; 
		sta	$0300,Y		; 
		lda	$0305,X		; 
		sbc	$0301,X		; 
		sta	$0301,Y		; 
		rts			; and return

_LD42C:		lda	$DE		; A=&DE
		bne	_BD437		; if A=0 D437
		ldx	#$28		; X=&28
		ldy	#$2A		; Y=&2A
		jsr	_LCDDE		; exchange 300/1+Y with 300/1+X
					; IN THIS CASE THE X AND Y SPANS!

_BD437:		ldx	#$28		; X=&28
		ldy	#$37		; Y=&37
		jsr	_LD48A		; copy &300/4+Y to &300/4+X
					; transferring X and Y spans in this case
		sec			; set carry
		ldx	$DE		; X=&DE
		lda	$0330		; subtract 32C/D,X from 330/1
		sbc	$032c,X		; 
		tay			; partial answer in Y
		lda	$0331		; 
		sbc	$032d,X		; 
		bmi	_BD453		; if -ve D453
		jsr	_LD49B		; else negate Y/A

_BD453:		sta	$DD		; store A
		sty	$DC		; and Y
		ldx	#$35		; X=&35
_LD459:		jsr	_LD467		; get coordinates
		lsr			; 
		sta	$0301,X		; 
		tya			; 
		ror			; 
		sta	$0300,X		; 
		dex			; 
		dex			; 

_LD467:		ldy	$0304,X		; 
		lda	$0305,X		; 
		bpl	_BD47B		; if A is +ve RETURN
		jsr	_LD49B		; else negate Y/A
		sta	$0305,X		; store back again
		pha			; 
		tya			; 
		sta	$0304,X		; 
		pla			; get back A
_BD47B:		rts			; and exit
					; 
_LD47C:		lda	#$08		; A=8
		bne	_BD48C		; copy 8 bytes
_LD480:		ldy	#$30		; Y=&30
_LD482:		lda	#$02		; A=2
		bne	_BD48C		; copy 2 bytes
_LD486:		ldy	#$28		; copy 4 bytes from 324/7 to 328/B
_LD488:		ldx	#$24		; 
_LD48A:		lda	#$04		; 

;***********copy A bytes from 300,X to 300,Y ***************************

_BD48C:		sta	$DA		; 
_BD48E:		lda	$0300,X		; 
		sta	$0300,Y		; 
		inx			; 
		iny			; 
		dec	$DA		; 
		bne	_BD48E		; 
		rts			; and return

;************* negation routine ******************************************

_LD49B:		pha			; save A
		tya			; A=Y
		eor	#$FF		; invert
		tay			; Y=A
		pla			; get back A
		eor	#$FF		; invert
		iny			; Y=Y+1
		bne	_BD4A9		; if not 0 exit
		clc			; else
		adc	#$01		; add 1 to A
_BD4A9:		rts			; return
					; 
_LD4AA:		jsr	_LD85D		; check window boundaries and set up screen pointer
		bne	_BD4B7		; if A<>0 D4B7
		lda	($D6),Y		; else get byte from current graphics cell
		eor	$035a		; compare with current background colour
		sta	$DA		; store it
		rts			; and RETURN

_BD4B7:		pla			; get back return link
		pla			; 
_BD4B9:		inc	$0326		; increment current graphics cursor vertical lo
		jmp	_LD545		; 


