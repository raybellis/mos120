;; code below shouldn't be here - duplicated from previous file
; CDED	PHA         ;store it
; CDEE	LDA &0300,Y ;get byte pointed to by Y
; CDF1	STA &0300,X ;put it in 300+X
; CDF4	PLA         ;get back A
; CDF5	STA &0300,Y ;put it in 300+Y
; CDF8	INX         ;increment pointers
; CDF9	INY         ;
; CDFA	DEC &DA     ;decrement loop counter
; CDFC	BNE &CDEA   ;and if not 0 do it again
; CDFE	RTS         ;and exit

;******** execute upward scroll ******************************************
;
.org		$cdff

		jsr	$CE5B		; exchange line and column cursors with workspace copies
		ldy	$030B		; top of text window
		sty	$0319		; current text line
		jsr	$CF06		; set up display address
		jsr	$CAD4		; add bytes per char. row
		bpl	$CE14		; 
		sec			; 
		sbc	$0354		; screen RAM size hi byte

		sta	$DB		; (&DA)=X/A
		stx	$DA		; 
		sta	$DC		; &DC=A
		bcc	$CE22		; 
		jsr	$CE73		; copy line to new position
					; using (&DA) for read
					; and (&D8) for write
		jmp	$CE2A		; exit


		jsr	$CAD4		; add bytes per char. row
		bmi	$CE1C		; if outside screen RAM CE1C
		jsr	$CE38		; perform a copy
		lda	$DC		; 
		ldx	$DA		; 
		sta	$D9		; 
		stx	$D8		; 
		dec	$DE		; decrement window height
		bne	$CE0B		; CE0B if not 0
		beq	$CDDA		; exchange text column/linelse CDDA


;*********** copy routines ***********************************************

		ldx	$034D		; text window width hi (bytes)
		beq	$CE4D		; if no more than 256 bytes to copy X=0 so CE4D

		ldy	#$00		; Y=0 to set loop counter

		lda	($DA),Y		; copy 256 bytes
		sta	($D8),Y		; 
		iny			; 
		bne	$CE3F		; Till Y=0 again
		inc	$D9		; increment hi bytes
		inc	$DB		; 
		dex			; decrement window width
		bne	$CE3F		; if not 0 go back and do loop again

		ldy	$034C		; text window width lo (bytes)
		beq	$CE5A		; if Y=0 CE5A

		dey			; else Y=Y-1
		lda	($DA),Y		; copy Y bytes
		sta	($D8),Y		; 
		tya			; A=Y
		bne	$CE52		; if not 0 CE52
		rts			; and exit
;

		jsr	$CDDA		; exchange text column/line with workspace
		sec			; set carry
		lda	$0309		; bottom margin
		sbc	$030B		; top of text window
		sta	$DE		; store it
		bne	$CE6E		; set text column to left hand column
		pla			; get back return address
		pla			; 
		jmp	$CDDA		; exchange text column/line with workspace

		lda	$0308		; text window left
		bpl	$CEE3		; Jump CEE3 always!

		lda	$DA		; get back A
		pha			; push A
		sec			; set carry
		lda	$030A		; text window right
		sbc	$0308		; text window left
		sta	$DF		; 
		ldy	$034F		; bytes per character to set loop counter

		dey			; copy loop
		lda	($DA),Y		; 
		sta	($D8),Y		; 
		dey			; 
		bpl	$CE83		; 

		ldx	#$02		; X=2
		clc			; clear carry
		lda	$D8,X		; 
		adc	$034F		; bytes per character
		sta	$D8,X		; 
		lda	$D9,X		; 
		adc	#$00		; 
		bpl	$CE9E		; if this remains in screen RAM OK

		sec			; else wrap around screen
		sbc	$0354		; screen RAM size hi byte
		sta	$D9,X		; 
		dex			; X=X-2
		dex			; 
		beq	$CE8C		; if X=0 adjust second set of pointers
		dec	$DF		; decrement window width
		bpl	$CE7F		; and if still +ve do it all again
		pla			; get back A
		sta	$DA		; and store it
		rts			; then exit
;
;*********** clear a line ************************************************

		lda	$0318		; text column
		pha			; save it
		jsr	$CE6E		; set text column to left hand column
		jsr	$CF06		; set up display address
		sec			; set carry
		lda	$030A		; text window right
		sbc	$0308		; text window left
		sta	$DC		; as window width
		lda	$0358		; background text colour
		ldy	$034F		; bytes per character

		dey			; Y=Y-1 decrementing loop counter
		sta	($D8),Y		; store background colour at this point on screen
		bne	$CEC5		; if Y<>0 do it again
		txa			; else A=X
		clc			; clear carry to add
		adc	$034F		; bytes per character
		tax			; X=A restoring it
		lda	$D9		; get hi byte
		adc	#$00		; Add carry if any
		bpl	$CEDA		; if +ve CeDA
		sec			; else wrap around
		sbc	$0354		; screen RAM size hi byte






		stx	$D8		; restore D8/9
		sta	$D9		; 
		dec	$DC		; decrement window width
		bpl	$CEBF		; ind if not 0 do it all again
		pla			; get back A
		sta	$0318		; restore text column
		sec			; set carry
		rts			; and exit
;

		ldx	$0318		; text column
		cpx	$0308		; text window left
		bmi	$CEE6		; if less than left margin return with carry set
		cpx	$030A		; text window right
		beq	$CEF7		; if equal to right margin thats OK
		bpl	$CEE6		; if greater than right margin return with carry set

		ldx	$0319		; current text line
		cpx	$030B		; top of text window
		bmi	$CEE6		; if less than top margin
		cpx	$0309		; bottom margin
		beq	$CF06		; set up display address
		bpl	$CEE6		; or greater than bottom margin return with carry set



;************:set up display address *************************************

;Mode 0: (0319)*640+(0318)* 8
;Mode 1: (0319)*640+(0318)*16
;Mode 2: (0319)*640+(0318)*32
;Mode 3: (0319)*640+(0318)* 8
;Mode 4: (0319)*320+(0318)* 8
;Mode 5: (0319)*320+(0318)*16
;Mode 6: (0319)*320+(0318)* 8
;Mode 7: (0319)* 40+(0318)
;this gives a displacement relative to the screen RAM start address
;which is added to the calculated number and stored in in 34A/B
;if the result is less than &8000, the top of screen RAM it is copied into X/A
;and D8/9.
;if the result is greater than &7FFF the hi byte of screen RAM size is
;subtracted to wraparound the screen. X/A, D8/9 are then set from this

		lda	$0319		; current text line
		asl			; A=A*2
		tay			; Y=A
		lda	($E0),Y		; get CRTC multiplication table pointer
		sta	$D9		; &D9=A
		iny			; Y=Y+1
		lda	#$02		; A=2
		and	$0356		; memory map type
		php			; save flags
		lda	($E0),Y		; get CRTC multiplication table pointer
		plp			; pull flags
		beq	$CF1E		; 
		lsr	$D9		; &D9=&D9/2
		ror			; A=A/2 +(128*carry)
		adc	$0350		; window area start address lo
		sta	$D8		; store it
		lda	$D9		; 
		adc	$0351		; window area start address hi
		tay			; 
		lda	$0318		; text column
		ldx	$034F		; bytes per character
		dex			; X=X-1
		beq	$CF44		; if X=0 mode 7 CF44
		cpx	#$0F		; is it mode 1 or mode 5?
		beq	$CF39		; yes CF39 with carry set
		bcc	$CF3A		; if its less (mode 0,3,4,6) CF3A
		asl			; A=A*16 if entered here (mode 2)

		asl			; A=A*8 if entered here

		asl			; A=A*4 if entered here
		asl			; 
		bcc	$CF40		; if carry clear
		iny			; Y=Y+2
		iny			; 
		asl			; A=A*2
		bcc	$CF45		; if carry clear add to &D8
		iny			; if not Y=Y+1

		clc			; clear carry
		adc	$D8		; add to &D8
		sta	$D8		; and store it
		sta	$034A		; text cursor 6845 address
		tax			; X=A
		tya			; A=Y
		adc	#$00		; Add carry if set
		sta	$034B		; text cursor 6845 address
		bpl	$CF59		; if less than &800 goto &CF59
		sec			; else wrap around
		sbc	$0354		; screen RAM size hi byte

		sta	$D9		; store in high byte
		clc			; clear carry
		rts			; and exit


;******** Graphics cursor display routine ********************************

		ldx	$0359		; foreground graphics colour
		ldy	$035B		; foreground graphics plot mode (GCOL n)
		jsr	$D0B3		; set graphics byte mask in &D4/5
		jsr	$D486		; copy (324/7) graphics cursor to workspace (328/B)
		ldy	#$00		; Y=0
		sty	$DC		; &DC=Y
		ldy	$DC		; Y=&DC
		lda	($DE),Y		; get pattern byte
		beq	$CF86		; if A=0 CF86
		sta	$DD		; else &DD=A
		bpl	$CF7A		; and if >0 CF7A
		jsr	$D0E3		; else display a pixel
		inc	$0324		; current horizontal graphics cursor
		bne	$CF82		; 
		inc	$0325		; current horizontal graphics cursor

		asl	$DD		; &DD=&DD*2
		bne	$CF75		; and if<>0 CF75
		ldx	#$28		; point to workspace
		ldy	#$24		; point to horizontal graphics cursor
		jsr	$D482		; 0300/1+Y=0300/1+X
		ldy	$0326		; current vertical graphics cursor
		bne	$CF95		; 
		dec	$0327		; current vertical graphics cursor
		dec	$0326		; current vertical graphics cursor
		ldy	$DC		; 
		iny			; 
		cpy	#$08		; if Y<8 then do loop again
		bne	$CF6B		; else
		ldx	#$28		; point to workspace
		ldy	#$24		; point to graphics cursor
		jmp	$D48A		; (&300/3+Y)=(&300/3+X)


;*********** home graphics cursor ***************************************

		ldx	#$06		; point to graphics window TOP
		ldy	#$26		; point to workspace
		jsr	$D482		; 0300/1+Y=0300/1+X


;************* set graphics cursor to left hand column *******************

		ldx	#$00		; X=0 point to graphics window left
		ldy	#$24		; Y=&24
		jsr	$D482		; 0300/1+Y=0300/1+X
		jmp	$D1B8		; set up external coordinates for graphics
		ldx	$0360		; number of logical colours less 1
		beq	$CFDC		; if MODE 7 CFDC

		jsr	$D03E		; set up character definition pointers
		ldx	$0360		; number of logical colours less 1
		lda	$D0		; VDU status byte
		and	#$20		; and out bit 5 printing at graphics cursor
		bne	$CF5D		; if set CF5D
		ldy	#$07		; else Y=7
		cpx	#$03		; if X=3
		beq	$CFEE		; goto CFEE to handle 4 colour modes
		bcs	$D01E		; else if X>3 D01E to deal with 16 colours

		lda	($DE),Y		; get pattern byte
		ora	$D2		; text colour byte to be orred or EORed into memory
		eor	$D3		; text colour byte to be orred or EORed into memory
		sta	($D8),Y		; write to screen
		dey			; Y=Y-1
		bpl	$CFD0		; if still +ve do loop again
		rts			; and exit

;******* convert teletext characters *************************************
;mode 7
		ldy	#$02		; Y=2
		cmp	$C4B6,Y		; compare with teletext conversion table
		beq	$CFE9		; if equal then CFE9
		dey			; else Y=Y-1
		bpl	$CFDE		; and if +ve CFDE

		sta	($D8,X)		; if not write byte to screen
		rts			; and exit



		lda	$C4B7,Y		; convert with teletext conversion table
		bne	$CFE6		; and write it


;***********four colour modes ********************************************

		lda	($DE),Y		; get pattern byte
		pha			; save it
		lsr			; move hi nybble to lo
		lsr			; 
		lsr			; 
		lsr			; 
		tax			; X=A
		lda	$C31F,X		; 4 colour mode byte mask look up table
		ora	$D2		; text colour byte to be orred or EORed into memory
		eor	$D3		; text colour byte to be orred or EORed into memory
		sta	($D8),Y		; write to screen
		tya			; A=Y

		clc			; clear carry
		adc	#$08		; add 8 to move screen RAM pointer 8 bytes
		tay			; Y=A
		pla			; get back A
		and	#$0F		; clear high nybble
		tax			; X=A
		lda	$C31F,X		; 4 colour mode byte mask look up table
		ora	$D2		; text colour byte to be orred or EORed into memory
		eor	$D3		; text colour byte to be orred or EORed into memory
		sta	($D8),Y		; write to screen
		tya			; A=Y
		sbc	#$08		; A=A-9
		tay			; Y=A
		bpl	$CFEE		; if +ve do loop again
		rts			; exit



		tya			; Y=Y-&21
		sbc	#$21		; 
		bmi	$D017		; IF Y IS negative then RETURN
		tay			; else A=Y

;******* 16 COLOUR MODES *************************************************

		lda	($DE),Y		; get pattern byte
		sta	$DC		; store it
		sec			; set carry
		lda	#$00		; A=0
		rol	$DC		; carry now occupies bit 0 of DC
		beq	$D018		; when DC=0 again D018 to deal with next pattern byte
		rol			; get bit 7 from &DC into A bit 0
		asl	$DC		; rotate again to get second
		rol			; bit into A
		tax			; and store result in X
		lda	$C32F,X		; multiply by &55 using look up table
		ora	$D2		; and set colour factors
		eor	$D3		; 
		sta	($D8),Y		; and store result
		clc			; clear carry
		tya			; Y=Y+8 moving screen RAM pointer on 8 bytes
		adc	#$08		; 
		tay			; 
		bcc	$D023		; iloop to D023 to deal with next bit pair


;************* calculate pattern address for given code ******************
;A contains code on entry = 12345678

		asl			; 23456780  C holds 1
		rol			; 34567801  C holds 2
		rol			; 45678012  C holds 3
		sta	$DE		; save this pattern
		and	#$03		; 00000012
		rol			; 00000123 C=0
		tax			; X=A=0 - 7
		and	#$03		; A=00000023
		adc	#$BF		; A=&BF,C0 or C1
		tay			; this is used as a pointer
		lda	$C40D,X		; A=&80/2^X i.e.1,2,4,8,&10,&20,&40, or &80
		bit	$0367		; with font flag
		beq	$D057		; if 0 D057
		ldy	$0367,X		; else get hi byte from table
		sty	$DF		; store Y
		lda	$DE		; get back pattern
		and	#$F8		; convert to 45678000
		sta	$DE		; and re store it
		rts			; exit
					; 
;*************************************************************************
;*************************************************************************
;**                                                                      **
;**                                                                      **
;**      PLOT ROUTINES ENTER HERE                                        **
;**                                                                      **
;**                                                                      **
;*************************************************************************
;*************************************************************************
;on entry    ADDRESS    PARAMETER        DESCRIPTION
;   	    031F    1               plot type
;   	    0320/1  2,3             X coordinate
;   	    0322/3  4,5             Y coordinate

		ldx	#$20		; X=&20
		jsr	$D14D		; translate coordinates

		lda	$031F		; get plot type
		cmp	#$04		; if its 4
		beq	$D0D9		; D0D9 move absolute
		ldy	#$05		; Y=5
		and	#$03		; mask only bits 0 and 1
		beq	$D080		; if result is 0 then its a move (multiple of 8)
		lsr			; else move bit 0 int C
		bcs	$D078		; if set then D078 graphics colour required
		dey			; Y=4
		bne	$D080		; logic inverse colour must be wanted

;******** graphics colour wanted *****************************************

		tax			; X=A if A=0 its a foreground colour 1 its background
		ldy	$035B,X		; get fore or background graphics PLOT mode
		lda	$0359,X		; get fore or background graphics colour
		tax			; X=A

		jsr	$D0B3		; set up colour masks in D4/5

		lda	$031F		; get plot type
		bmi	$D0AB		; if &80-&FF then D0AB type not implemented
		asl			; bit 7=bit 6
		bpl	$D0C6		; if bit 6 is 0 then plot type is 0-63 so D0C6
		and	#$F0		; else mask out lower nybble
		asl			; shift old bit 6 into C bit old 5 into bit 7
		beq	$D0D6		; if 0 then type 64-71 was called single point plot
					; goto D0D6
		eor	#$40		; if bit 6 NOT set type &80-&87 fill triangle
		beq	$D0A8		; so D0A8
		pha			; else push A
		jsr	$D0DC		; copy 0320/3 to 0324/7 setting XY in current graphics
					; coordinates
		pla			; get back A
		eor	#$60		; if BITS 6 and 5 NOT SET type 72-79 lateral fill
		beq	$D0AE		; so D0AE
		cmp	#$40		; if type 88-95 horizontal line blanking
		bne	$D0AB		; so D0AB

		lda	#$02		; else A=2
		sta	$DC		; store it
		jmp	$D506		; and jump to D506 type not implemented

		jmp	$D5EA		; to fill triangle routine

		jmp	$C938		; VDU extension access entry

		sta	$DC		; store A
		jmp	$D4BF		; 

;*********:set colour masks **********************************************
;graphics mode in Y
;colour in X

		txa			; A=X
		ora	$C41C,Y		; or with GCOL plot options table byte
		eor	$C41D,Y		; EOR with following byte
		sta	$D4		; and store it
		txa			; A=X
		ora	$C41B,Y		; 
		eor	$C420,Y		; 
		sta	$D5		; 
		rts			; exit with masks in &D4/5


;************** analyse first parameter in 0-63 range ********************
		; 
		asl			; shift left again
		bmi	$D0AB		; if -ve options are in range 32-63 not implemented
		asl			; shift left twice more
		asl			; 
		bpl	$D0D0		; if still +ve type is 0-7 or 16-23 so D0D0
		jsr	$D0EB		; else display a point

		jsr	$D1ED		; perform calculations
		jmp	$D0D9		; 


;*************************************************************************
;*                                                                       *
;*       PLOT A SINGLE POINT                                             *
;*                                                                       *
;*************************************************************************

		jsr	$D0EB		; display a point
		jsr	$CDE2		; swap current and last graphics position
		ldy	#$24		; Y=&24
		ldx	#$20		; X=&20
		jmp	$D48A		; copy parameters to 324/7 (300/3 +Y)


		ldx	#$24		; 
		jsr	$D85F		; calculate position
		beq	$D0F0		; if result =0 then D0F0
		rts			; else exit
					; 
		jsr	$D85D		; calculate position
		bne	$D103		; if A<>0 D103 and return
		ldy	$031A		; else get current graphics scan line
		lda	$D1		; pick up and modify screen byte
		and	$D4		; 
		ora	($D6),Y		; 
		sta	$DA		; 
		lda	$D5		; 
		and	$D1		; 
		eor	$DA		; 
		sta	($D6),Y		; put it back again
		rts			; and exit
					; 

		lda	($D6),Y		; this is a more simplistic version of the above
		ora	$D4		; 
		eor	$D5		; 
		sta	($D6),Y		; 
		rts			; and exit



