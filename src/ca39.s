;*************************************************************************
;*                                                                       *
;*       VDU 24 - DEFINE GRAPHICS WINDOW                                 *
;*                                                                       *
;*       8 parameters                                                    *
;*                                                                       *
;*************************************************************************
;&31C/D Left margin
;&31E/F Bottom margin
;&320/1 Right margin
;&322/3 Top margin

.org		$ca39

		jsr	$CA81		; exchange 310/3 with 328/3
		ldx	#$1C		; 
		ldy	#$2C		; 
		jsr	$D411		; calculate width=right - left
					;           height = top-bottom
		ora	$032D		; 
		bmi	$CA81		; exchange 310/3 with 328/3 and exit
		ldx	#$20		; X=&20
		jsr	$D149		; scale pointers to mode
		ldx	#$1C		; X=&1C
		jsr	$D149		; scale pointers to mode
		lda	$031F		; check for negative margins
		ora	$031D		; 
		bmi	$CA81		; if found exchange 310/3 with 328/3 and exit
		lda	$0323		; 
		bne	$CA81		; exchange 310/3 with 328/3 and exit
		ldx	$0355		; screen mode
		lda	$0321		; right margin hi
		sta	$DA		; store it
		lda	$0320		; right margin lo
		lsr	$DA		; /2
		ror			; A=A/2
		lsr	$DA		; /2
		bne	$CA81		; exchange 310/3 with 328/3
		ror			; A=A/2
		lsr			; A=A/2
		cmp	$c3ef,X		; text window right hand margin maximum
		beq	$CA7A		; if equal CA7A
		bpl	$CA81		; exchange 310/3 with 328/3

		ldy	#$00		; Y=0
		ldx	#$1C		; X=&1C
		jsr	$D47C		; set(300/7+Y) from (300/7+X)

;***************** exchange 310/3 with 328/3 *****************************

		ldx	#$10		; X=10
		ldy	#$28		; Y=&28
		jmp	$CDE6		; exchange 300/3+Y and 300/3+X

		iny			; Y=Y+1
		tya			; A=Y
		ldy	#$00		; Y=0
		sty	$034D		; text window width hi (bytes)
		sta	$034C		; text window width lo (bytes)
		lda	$034F		; bytes per character
		lsr			; /2
		beq	$CAA1		; if 0 exit
		asl	$034C		; text window width lo (bytes)
		rol	$034D		; text window width hi (bytes)
		lsr			; /2
		bcc	$CA98		; 
		rts			; 


;*************************************************************************
;*                                                                       *
;*       VDU 29 - SET GRAPHICS ORIGIN                                    *
;*                                                                       *
;*       4 parameters                                                    *
;*                                                                       *
;*************************************************************************
;
		ldx	#$20		; 
		ldy	#$0C		; 
		jsr	$D48A		; (&300/3+Y)=(&300/3+X)
		jmp	$D1B8		; set up external coordinates for graphics


;*************************************************************************
;*                                                                       *
;*       VDU 127 (&7F) - DELETE (entry 32)                               *
;*                                                                       *
;*************************************************************************

		jsr	$C5C5		; cursor left
		jsr	$C588		; A=0 if text cursor A=&20 if graphics cursor
		bne	$CAC7		; if graphics then CAC7
		ldx	$0360		; number of logical colours less 1
		beq	$CAC2		; if mode 7 CAC2
		sta	$DE		; else store A (always 0)
		lda	#$C0		; A=&C0
		sta	$DF		; store in &DF (&DE) now points to C300 SPACE pattern
		jmp	$CFBF		; display a space

		lda	#$20		; A=&20
		jmp	$CFDC		; and return to display a space

		lda	#$7F		; for graphics cursor
		jsr	$D03E		; set up character definition pointers
		ldx	$035A		; Background graphics colour
		ldy	#$00		; Y=0
		jmp	$CF63		; invert pattern data (to background colour)

;***** Add number of bytes in a line to X/A ******************************

		pha			; store A
		txa			; A=X
		clc			; clear carry
		adc	$0352		; bytes per character row
		tax			; X=A
		pla			; get back A
		adc	$0353		; bytes per character row
		rts			; and return
;
;********* control scrolling in paged mode *******************************

		jsr	$CB14		; zero paged mode line counter
		jsr	$E9D9		; osbyte 118 check keyboard status; set LEDs
		bcc	$CAEA		; if carry clear CAEA
		bmi	$CAE0		; if M set CAE0 do it again

		lda	$D0		; VDU status byte
		eor	#$04		; invert bit 2 paged scrolling
		and	#$46		; and if 2 cursors, paged mode off, or scrolling
		bne	$CB1C		; barred then CB1C to exit

		lda	$0269		; paged mode counter
		bmi	$CB19		; if negative then exit via CB19

		lda	$0319		; current text line
		cmp	$0309		; bottom margin
		bcc	$CB19		; increment line counter and exit

		lsr			; A=A/4
		lsr			; 
		sec			; set carry
		adc	$0269		; paged mode counter
		adc	$030B		; top of text window
		cmp	$0309		; bottom margin
		bcc	$CB19		; increment line counter and exit

		clc			; clear carry
		jsr	$E9D9		; osbyte 118 check keyboard status; set LEDs
		sec			; set carry
		bpl	$CB0E		; if +ve result then loop till shift pressed

;**************** zero paged mode  counter *******************************

		lda	#$FF		; 
		sta	$0269		; paged mode counter
		inc	$0269		; paged mode counter
		rts			; 

;********* intitialise VDU driver with MODE in A *************************

		pha			; Save MODE in A
		ldx	#$7F		; Prepare X=&7F for reset loop
		lda	#$00		; A=0
		sta	$D0		; Clear VDU status byte to set default conditions

		sta	$02FF,X		; Zero VDU workspace at &300 to &37E
		dex	
		bne	$CB24

		jsr	$CD07		; Implode character definitions
		pla			; Get initial MODE back to A
		ldx	#$7F		; X=&7F
		stx	$0366		; MODE 7 copy cursor character (could have set this at CB1E)

;********* enter here from VDU 22,n - MODE *******************************

		bit	$028E		; Check available RAM
		bmi	$CB3A		; If 32K, use all MODEs
		ora	#$04		; Only 16K available, force to use MODEs 4-7

		and	#$07		; X=A and 7 ensure legal mode
		tax			; X=mode
		stx	$0355		; Save current screen MODE
		lda	$C414,X		; Get number of colours -1 for this MODE
		sta	$0360		; Set current number of logical colours less 1
		lda	$C3FF,X		; Get bytes/character for this MODE
		sta	$034F		; Set bytes per character
		lda	$C43A,X		; Get pixels/byte for this MODE
		sta	$0361		; Set pixels per byte
		bne	$CB56		; If non-zero, skip past
		lda	#$07		; byte/pixel=0, this is MODE 7, prepare A=7 offset into mask table

		asl			; A=A*2
		tay			; Y=A

		lda	$C406,Y		; mask table
		sta	$0363		; colour mask left
		asl			; A=A*2
		bpl	$CB5E		; If still +ve CB5E
		sta	$0362		; colour mask right
		ldy	$C440,X		; screen display memory index table
		sty	$0356		; memory map type
		lda	$C44F,Y		; VDU section control
		jsr	$E9F8		; set hardware scrolling to VIA
		lda	$C44B,Y		; VDU section control
		jsr	$E9F8		; set hardware scrolling to VIA
		lda	$C459,Y		; Screen RAM size hi byte table
		sta	$0354		; screen RAM size hi byte
		lda	$C45E,Y		; screen ram address hi byte
		sta	$034E		; hi byte of screen RAM address
		tya			; Y=A
		adc	#$02		; Add 2
		eor	#$07		; 
		lsr			; /2
		tax			; X=A
		lda	$C466,X		; row multiplication table pointer
		sta	$E0		; store it
		lda	#$C3		; A=&C3
		sta	$E1		; store it (&E0) now points to C3B5 or C375
		lda	$C463,X		; get nuber of bytes per row from table
		sta	$0352		; store as bytes per character row
		stx	$0353		; bytes per character row
		lda	#$43		; A=&43
		jsr	$C5A8		; A=A and &D0:&D0=A
		ldx	$0355		; screen mode
		lda	$C3F7,X		; get video ULA control setting
		jsr	$EA00		; set video ULA using osbyte 154 code
		php			; push flags
		sei			; set interrupts
		ldx	$C469,Y		; get cursor end register data from table
		ldy	#$0B		; Y=11

		lda	$C46E,X		; get end of 6845 registers 0-11 table
		jsr	$C95E		; set register Y
		dex			; reduce pointers
		dey			; 
		bpl	$CBB0		; and if still >0 do it again

		plp			; pull flags
		jsr	$C839		; set default colours
		jsr	$C9BD		; set default windows

		ldx	#$00		; X=0
		lda	$034E		; hi byte of screen RAM address
		stx	$0350		; window area start address lo
		sta	$0351		; window area start address hi
		jsr	$C9F6		; use X and Y to set new cursor address
		ldy	#$0C		; Y=12
		jsr	$CA2B		; set registers 12 and 13 in CRTC
		lda	$0358		; background text colour
		ldx	$0356		; memory map type
		ldy	$C454,X		; get section control number
		sty	$035D		; set it in jump vector lo
		ldy	#$CC		; Y=&CC
		sty	$035E		; upper byte of link address
		ldx	#$00		; X=0
		stx	$0269		; paged mode counter
		stx	$0318		; text column
		stx	$0319		; current text line
		jmp	($035D)		; jump vector set up previously to clear screen memory


;*************************************************************************
;*                                                                       *
;*       OSWORD 10 - READ CHARACTER DEFINITION                           *
;*                                                                       *
;*************************************************************************
;&EF=A:&F0=X:&F1=Y, on entry YX contains character number to be read
;(&DE) points to address
;on exit byte YX+1 to YX+8 contain definition

		jsr	$D03E		; set up character definition pointers
		ldy	#$00		; Y=0
		lda	($DE),Y		; get first byte
		iny			; Y=Y+1
		sta	($F0),Y		; store it in YX
		cpy	#$08		; until Y=8
		bne	$CBF8		; 
		rts			; then exit


;*************************************************************************
;*                                                                       *
;*       MAIN SCREEN CLEARANCE ROUTINE                                   *
;*                                                                       *
;*************************************************************************
;on entry A contains background colour which is set in every byte
;of the screen

;************************ Mode 0,1,2 entry point *************************

		sta	$3000,X		; 
		sta	$3100,X		; 
		sta	$3200,X		; 
		sta	$3300,X		; 
		sta	$3400,X		; 
		sta	$3500,X		; 
		sta	$3600,X		; 
		sta	$3700,X		; 
		sta	$3800,X		; 
		sta	$3900,X		; 
		sta	$3A00,X		; 
		sta	$3B00,X		; 
		sta	$3C00,X		; 
		sta	$3D00,X		; 
		sta	$3E00,X		; 
		sta	$3F00,X		; 

;************************ Mode 3 entry point *****************************

		sta	$4000,X		; 
		sta	$4100,X		; 
		sta	$4200,X		; 
		sta	$4300,X		; 
		sta	$4400,X		; 
		sta	$4500,X		; 
		sta	$4600,X		; 
		sta	$4700,X		; 
		sta	$4800,X		; 
		sta	$4900,X		; 
		sta	$4A00,X		; 
		sta	$4B00,X		; 
		sta	$4C00,X		; 
		sta	$4D00,X		; 
		sta	$4E00,X		; 
		sta	$4F00,X		; 
		sta	$5000,X		; 
		sta	$5100,X		; 
		sta	$5200,X		; 
		sta	$5300,X		; 
		sta	$5400,X		; 
		sta	$5500,X		; 
		sta	$5600,X		; 
		sta	$5700,X		; 

;************************ Mode 4,5 entry point ***************************

		sta	$5800,X		; 
		sta	$5900,X		; 
		sta	$5A00,X		; 
		sta	$5B00,X		; 
		sta	$5C00,X		; 
		sta	$5D00,X		; 
		sta	$5E00,X		; 
		sta	$5F00,X		; 

;************************ Mode 6 entry point *****************************

		sta	$6000,X		; 
		sta	$6100,X		; 
		sta	$6200,X		; 
		sta	$6300,X		; 
		sta	$6400,X		; 
		sta	$6500,X		; 
		sta	$6600,X		; 
		sta	$6700,X		; 
		sta	$6800,X		; 
		sta	$6900,X		; 
		sta	$6A00,X		; 
		sta	$6B00,X		; 
		sta	$6C00,X		; 
		sta	$6D00,X		; 
		sta	$6E00,X		; 
		sta	$6F00,X		; 
		sta	$7000,X		; 
		sta	$7100,X		; 
		sta	$7200,X		; 
		sta	$7300,X		; 
		sta	$7400,X		; 
		sta	$7500,X		; 
		sta	$7600,X		; 
		sta	$7700,X		; 
		sta	$7800,X		; 
		sta	$7900,X		; 
		sta	$7A00,X		; 
		sta	$7B00,X		; 

;************************ Mode 7 entry point *****************************

		sta	$7C00,X		; 
		sta	$7D00,X		; 
		sta	$7E00,X		; 
		sta	$7F00,X		; 
		inx			; 
		beq	$CD65		; exit

;****************** execute required function ****************************

		jmp	($035D)		; jump vector set up previously

;********* subtract bytes per line from X/A ******************************

		pha			; Push A
		txa			; A=X
		sec			; set carry for subtraction
		sbc	$0352		; bytes per character row
		tax			; restore X
		pla			; and A
		sbc	$0353		; bytes per character row
		cmp	$034E		; hi byte of screen RAM address
		rts			; return


;*************************************************************************
;*                                                                       *
;*       OSBYTE 20 - EXPLODE CHARACTERS                                  *
;*                                                                       *
;*************************************************************************
;
		lda	#$0F		; A=15
		sta	$0367		; font flag indicating that page &0C,&C0-&C2 are
					; used for user defined characters
		lda	#$0C		; A=&0C
		ldy	#$06		; set loop counter

		sta	$0368,Y		; set all font location bytes
		dey			; to page &0C to indicate only page available
		bpl	$CD10		; for user character definitions

		cpx	#$07		; is X= 7 or greater
		bcc	$CD1C		; if not CD1C
		ldx	#$06		; else X=6
		stx	$0246		; character definition explosion switch
		lda	$0243		; A=primary OSHWM
		ldx	#$00		; X=0

		cpx	$0246		; character definition explosion switch
		bcs	$CD34		; 
		ldy	$C4BA,X		; get soft character  RAM allocation
		sta	$0368,Y		; font location bytes
		adc	#$01		; Add 1
		inx			; X=X+1
		bne	$CD24		; if X<>0 then CD24

		sta	$0244		; current value of page (OSHWM)
		tay			; Y=A
		beq	$CD06		; return via CD06 (ERROR?)

		ldx	#$11		; X=&11
		jmp	$F168		; issue paged ROM service call &11
					; font implosion/explosion warning

;******** move text cursor to next line **********************************

		lda	#$02		; A=2 to check if scrolling disabled
		bit	$D0		; VDU status byte
		bne	$CD47		; if scrolling is barred CD47
		bvc	$CD79		; if cursor editing mode disabled RETURN

		lda	$0309		; bottom margin
		bcc	$CD4F		; if carry clear on entry CD4F
		lda	$030B		; else if carry set get top of text window
		bvs	$CD59		; and if cursor editing enabled CD59
		sta	$0319		; get current text line
		pla			; pull return link from stack
		pla			; 
		jmp	$C6AF		; set up cursor and display address

		php			; push flags
		cmp	$0365		; Y coordinate of text input cursor
		beq	$CD78		; if A=line count of text input cursor CD78 to exit
		plp			; get back flags
		bcc	$CD66		; 
		dec	$0365		; Y coordinate of text input cursor

		rts			; exit
;
		inc	$0365		; Y coordinate of text input cursor
		rts			; exit

;*********************** set up write cursor ********************************

		php			; save flags
		pha			; save A
		ldy	$034F		; bytes per character
		dey			; Y=Y-1
		bne	$CD8F		; if Y=0 Mode 7 is in use

		lda	$0338		; so get mode 7 write character cursor character &7F
		sta	($D8),Y		; store it at top scan line of current character
		pla			; pull A
		plp			; pull flags
		rts			; and exit
;
		php			; push flags
		pha			; push A
		ldy	$034F		; bytes per character
		dey			; 
		bne	$CD8F		; if not mode 7
		lda	($D8),Y		; get cursor from top scan line
		sta	$0338		; store it
		lda	$0366		; mode 7 write cursor character
		sta	($D8),Y		; store it at scan line
		jmp	$CD77		; and exit

		lda	#$FF		; A=&FF =cursor
		cpy	#$1F		; except in mode 2 (Y=&1F)
		bne	$CD97		; if not CD97
		lda	#$3F		; load cursor byte mask

;********** produce white block write cursor *****************************

		sta	$DA		; store it
		lda	($D8),Y		; get scan line byte
		eor	$DA		; invert it
		sta	($D8),Y		; store it on scan line
		dey			; decrement scan line counter
		bpl	$CD99		; do it again
		bmi	$CD77		; then jump to &CD77

		jsr	$CE5B		; exchange line and column cursors with workspace copies
		lda	$0309		; bottom margin
		sta	$0319		; current text line
		jsr	$CF06		; set up display address
		jsr	$CCF8		; subtract bytes per character row from this
		bcs	$CDB8		; wraparound if necessary
		adc	$0354		; screen RAM size hi byte
		sta	$DB		; store A
		stx	$DA		; X
		sta	$DC		; A again
		bcs	$CDC6		; if C set there was no wraparound so CDC6
		jsr	$CE73		; copy line to new position
					; using (&DA) for read
					; and (&D8) for write
		jmp	$CDCE		; 

		jsr	$CCF8		; subtract bytes per character row from X/A
		bcc	$CDC0		; if a result is outside screen RAM CDC0
		jsr	$CE38		; perform a copy

		lda	$DC		; set write pointer from read pointer
		ldx	$DA		; 
		sta	$D9		; 
		stx	$D8		; 
		dec	$DE		; decrement window height
		bne	$CDB0		; and if not zero CDB0
		ldx	#$28		; point to workspace
		ldy	#$18		; point to text column/line
		lda	#$02		; number of bytes to swap
		bne	$CDE8		; exchange (328/9)+Y with (318/9)+X
		ldx	#$24		; point to graphics cursor
		ldy	#$14		; point to last graphics cursor
					; A=4 to swap X and Y coordinates

;*************** exchange 300/3+Y with 300/3+X ***************************

		lda	#$04		; A =4

;************** exchange (300/300+A)+Y with (300/300+A)+X *****************

		sta	$DA		; store it as loop counter

		lda	$0300,X		; get byte
		pha			; store it
		lda	$0300,Y		; get byte pointed to by Y
		sta	$0300,X		; put it in 300+X
		pla			; get back A
		sta	$0300,Y		; put it in 300+Y
		inx			; increment pointers
		iny			; 
		dec	$DA		; decrement loop counter
		bne	$CDEA		; and if not 0 do it again
		rts			; and exit

