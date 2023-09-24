;******** execute upward scroll ******************************************

			.org	$cdff

_LCDFF:			jsr	_LCE5B				; exchange line and column cursors with workspace copies
			ldy	VDU_T_WIN_T			; top of text window
			sty	VDU_T_CURS_Y			; current text line
			jsr	_LCF06				; set up display address
_BCE0B:			jsr	_LCAD4				; add bytes per char. row
			bpl	_BCE14				; 
			sec					; 
			sbc	VDU_MEM_PAGES			; screen RAM size hi byte

_BCE14:			sta	VDU_TMP2			; (&DA)=X/A
			stx	VDU_TMP1			; 
			sta	VDU_TMP3			; &DC=A
			bcc	_BCE22				; 
_BCE1C:			jsr	_LCE73				; copy line to new position
								; using (&DA) for read
								; and (&D8) for write
			jmp	_LCE2A				; exit


_BCE22:			jsr	_LCAD4				; add bytes per char. row
			bmi	_BCE1C				; if outside screen RAM CE1C
			jsr	_LCE38				; perform a copy
_LCE2A:			lda	VDU_TMP3			; 
			ldx	VDU_TMP1			; 
			sta	VDU_TOP_SCAN_HI			; 
			stx	VDU_TOP_SCAN			; 
			dec	VDU_TMP5			; decrement window height
			bne	_BCE0B				; CE0B if not 0
			beq	_LCDDA				; exchange text column/linelse CDDA


;*********** copy routines ***********************************************

_LCE38:			ldx	VDU_T_WIN_SZ_HI			; text window width hi (bytes)
			beq	_BCE4D				; if no more than 256 bytes to copy X=0 so CE4D

			ldy	#$00				; Y=0 to set loop counter

_BCE3F:			lda	(VDU_TMP1),Y			; copy 256 bytes
			sta	(VDU_TOP_SCAN),Y		; 
			iny					; 
			bne	_BCE3F				; Till Y=0 again
			inc	VDU_TOP_SCAN_HI			; increment hi bytes
			inc	VDU_TMP2			; 
			dex					; decrement window width
			bne	_BCE3F				; if not 0 go back and do loop again

_BCE4D:			ldy	VDU_T_WIN_SZ			; text window width lo (bytes)
			beq	_BCE5A				; if Y=0 CE5A

_BCE52:			dey					; else Y=Y-1
			lda	(VDU_TMP1),Y			; copy Y bytes
			sta	(VDU_TOP_SCAN),Y		; 
			tya					; A=Y
			bne	_BCE52				; if not 0 CE52
_BCE5A:			rts					; and exit


_LCE5B:			jsr	_LCDDA				; exchange text column/line with workspace
			sec					; set carry
			lda	VDU_T_WIN_B			; bottom margin
			sbc	VDU_T_WIN_T			; top of text window
			sta	VDU_TMP5			; store it
			bne	_LCE6E				; set text column to left hand column
			pla					; get back return address
			pla					; 
			jmp	_LCDDA				; exchange text column/line with workspace

_LCE6E:			lda	VDU_T_WIN_L			; text window left
			bpl	_BCEE3				; Jump CEE3 always!

_LCE73:			lda	VDU_TMP1			; get back A
			pha					; push A
			sec					; set carry
			lda	VDU_T_WIN_R			; text window right
			sbc	VDU_T_WIN_L			; text window left
			sta	VDU_TMP6			; 
_BCE7F:			ldy	VDU_BPC				; bytes per character to set loop counter

			dey					; copy loop
_BCE83:			lda	(VDU_TMP1),Y			; 
			sta	(VDU_TOP_SCAN),Y		; 
			dey					; 
			bpl	_BCE83				; 

			ldx	#$02				; X=2
_BCE8C:			clc					; clear carry
			lda	VDU_TOP_SCAN,X			; 
			adc	VDU_BPC				; bytes per character
			sta	VDU_TOP_SCAN,X			; 
			lda	VDU_TOP_SCAN_HI,X		; 
			adc	#$00				; 
			bpl	_BCE9E				; if this remains in screen RAM OK

			sec					; else wrap around screen
			sbc	VDU_MEM_PAGES			; screen RAM size hi byte
_BCE9E:			sta	VDU_TOP_SCAN_HI,X		; 
			dex					; X=X-2
			dex					; 
			beq	_BCE8C				; if X=0 adjust second set of pointers
			dec	VDU_TMP6			; decrement window width
			bpl	_BCE7F				; and if still +ve do it all again
			pla					; get back A
			sta	VDU_TMP1			; and store it
			rts					; then exit

;*********** clear a line ************************************************

_LCEAC:			lda	VDU_T_CURS_X			; text column
			pha					; save it
			jsr	_LCE6E				; set text column to left hand column
			jsr	_LCF06				; set up display address
			sec					; set carry
			lda	VDU_T_WIN_R			; text window right
			sbc	VDU_T_WIN_L			; text window left
			sta	VDU_TMP3			; as window width
_BCEBF:			lda	VDU_T_BG			; background text colour
			ldy	VDU_BPC				; bytes per character

_BCEC5:			dey					; Y=Y-1 decrementing loop counter
			sta	(VDU_TOP_SCAN),Y		; store background colour at this point on screen
			bne	_BCEC5				; if Y<>0 do it again
			txa					; else A=X
			clc					; clear carry to add
			adc	VDU_BPC				; bytes per character
			tax					; X=A restoring it
			lda	VDU_TOP_SCAN_HI			; get hi byte
			adc	#$00				; Add carry if any
			bpl	_BCEDA				; if +ve CeDA
			sec					; else wrap around
			sbc	VDU_MEM_PAGES			; screen RAM size hi byte






_BCEDA:			stx	VDU_TOP_SCAN			; restore D8/9
			sta	VDU_TOP_SCAN_HI			; 
			dec	VDU_TMP3			; decrement window width
			bpl	_BCEBF				; ind if not 0 do it all again
			pla					; get back A
_BCEE3:			sta	VDU_T_CURS_X			; restore text column
_BCEE6:			sec					; set carry
			rts					; and exit


_LCEE8:			ldx	VDU_T_CURS_X			; text column
			cpx	VDU_T_WIN_L			; text window left
			bmi	_BCEE6				; if less than left margin return with carry set
			cpx	VDU_T_WIN_R			; text window right
			beq	_BCEF7				; if equal to right margin thats OK
			bpl	_BCEE6				; if greater than right margin return with carry set

_BCEF7:			ldx	VDU_T_CURS_Y			; current text line
			cpx	VDU_T_WIN_T			; top of text window
			bmi	_BCEE6				; if less than top margin
			cpx	VDU_T_WIN_B			; bottom margin
			beq	_LCF06				; set up display address
			bpl	_BCEE6				; or greater than bottom margin return with carry set



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

_LCF06:			lda	VDU_T_CURS_Y			; current text line
			asl					; A=A*2
			tay					; Y=A
			lda	(VDU_ROW_MULT),Y		; get CRTC multiplication table pointer
			sta	VDU_TOP_SCAN_HI			; &D9=A
			iny					; Y=Y+1
			lda	#$02				; A=2
			and	VDU_MAP_TYPE			; memory map type
			php					; save flags
			lda	(VDU_ROW_MULT),Y		; get CRTC multiplication table pointer
			plp					; pull flags
			beq	_BCF1E				; 
			lsr	VDU_TOP_SCAN_HI			; &D9=&D9/2
			ror					; A=A/2 +(128*carry)
_BCF1E:			adc	VDU_MEM				; window area start address lo
			sta	VDU_TOP_SCAN			; store it
			lda	VDU_TOP_SCAN_HI			; 
			adc	VDU_MEM_HI			; window area start address hi
			tay					; 
			lda	VDU_T_CURS_X			; text column
			ldx	VDU_BPC				; bytes per character
			dex					; X=X-1
			beq	_BCF44				; if X=0 mode 7 CF44
			cpx	#$0f				; is it mode 1 or mode 5?
			beq	_BCF39				; yes CF39 with carry set
			bcc	_BCF3A				; if its less (mode 0,3,4,6) CF3A
			asl					; A=A*16 if entered here (mode 2)

_BCF39:			asl					; A=A*8 if entered here

_BCF3A:			asl					; A=A*4 if entered here
			asl					; 
			bcc	_BCF40				; if carry clear
			iny					; Y=Y+2
			iny					; 
_BCF40:			asl					; A=A*2
			bcc	_BCF45				; if carry clear add to &D8
			iny					; if not Y=Y+1

_BCF44:			clc					; clear carry
_BCF45:			adc	VDU_TOP_SCAN			; add to &D8
			sta	VDU_TOP_SCAN			; and store it
			sta	VDU_CRTC_CUR			; text cursor 6845 address
			tax					; X=A
			tya					; A=Y
			adc	#$00				; Add carry if set
			sta	VDU_CRTC_CUR_HI			; text cursor 6845 address
			bpl	_BCF59				; if less than &800 goto &CF59
			sec					; else wrap around
			sbc	VDU_MEM_PAGES			; screen RAM size hi byte

_BCF59:			sta	VDU_TOP_SCAN_HI			; store in high byte
			clc					; clear carry
			rts					; and exit


;******** Graphics cursor display routine ********************************

_BCF5D:			ldx	VDU_G_FG			; foreground graphics colour
			ldy	VDU_P_FG			; foreground graphics plot mode (GCOL n)
_LCF63:			jsr	_LD0B3				; set graphics byte mask in &D4/5
			jsr	_LD486				; copy (324/7) graphics cursor to workspace (328/B)
			ldy	#$00				; Y=0
_BCF6B:			sty	VDU_TMP3			; &DC=Y
			ldy	VDU_TMP3			; Y=&DC
			lda	(VDU_TMP5),Y			; get pattern byte
			beq	_BCF86				; if A=0 CF86
			sta	VDU_TMP4			; else &DD=A
_BCF75:			bpl	_BCF7A				; and if >0 CF7A
			jsr	_LD0E3				; else display a pixel
_BCF7A:			inc	VDU_G_CURS_H			; current horizontal graphics cursor
			bne	_BCF82				; 
			inc	VDU_G_CURS_H_HI			; current horizontal graphics cursor

_BCF82:			asl	VDU_TMP4			; &DD=&DD*2
			bne	_BCF75				; and if<>0 CF75
_BCF86:			ldx	#$28				; point to workspace
			ldy	#$24				; point to horizontal graphics cursor
			jsr	_LD482				; 0300/1+Y=0300/1+X
			ldy	VDU_G_CURS_V			; current vertical graphics cursor
			bne	_BCF95				; 
			dec	VDU_G_CURS_V_HI			; current vertical graphics cursor
_BCF95:			dec	VDU_G_CURS_V			; current vertical graphics cursor
			ldy	VDU_TMP3			; 
			iny					; 
			cpy	#$08				; if Y<8 then do loop again
			bne	_BCF6B				; else
			ldx	#$28				; point to workspace
			ldy	#$24				; point to graphics cursor
			jmp	_LD48A				; (&300/3+Y)=(&300/3+X)


;*********** home graphics cursor ***************************************

_LCFA6:			ldx	#$06				; point to graphics window TOP
			ldy	#$26				; point to workspace
			jsr	_LD482				; 0300/1+Y=0300/1+X


;************* set graphics cursor to left hand column *******************

_LCFAD:			ldx	#$00				; X=0 point to graphics window left
			ldy	#$24				; Y=&24
			jsr	_LD482				; 0300/1+Y=0300/1+X
			jmp	_LD1B8				; set up external coordinates for graphics
_VDU_OUT_CHAR:		ldx	VDU_COL_MASK			; number of logical colours less 1
			beq	_VDU_OUT_MODE7			; if MODE 7 CFDC

			jsr	_LD03E				; set up character definition pointers
_LCFBF:			ldx	VDU_COL_MASK			; number of logical colours less 1
			lda	VDU_STATUS			; VDU status byte
			and	#$20				; and out bit 5 printing at graphics cursor
			bne	_BCF5D				; if set CF5D
			ldy	#$07				; else Y=7
			cpx	#$03				; if X=3
			beq	_VDU_OUT_COL4			; goto CFEE to handle 4 colour modes
			bcs	_VDU_OUT_COL16			; else if X>3 D01E to deal with 16 colours

_BCFD0:			lda	(VDU_TMP5),Y			; get pattern byte
			ora	VDU_T_OR_MASK			; text colour byte to be orred or EORed into memory
			eor	VDU_T_EOR_MASK			; text colour byte to be orred or EORed into memory
			sta	(VDU_TOP_SCAN),Y		; write to screen
			dey					; Y=Y-1
			bpl	_BCFD0				; if still +ve do loop again
			rts					; and exit

;******* convert teletext characters *************************************
;mode 7
_VDU_OUT_MODE7:		ldy	#$02				; Y=2
__mode7_xlate_loop:	cmp	_TELETEXT_CHAR_TAB,Y		; compare with teletext conversion table
			beq	__mode7_xlate_char		; if equal then CFE9
			dey					; else Y=Y-1
			bpl	__mode7_xlate_loop		; and if +ve CFDE

__mode7_out_char:	sta	(VDU_TOP_SCAN,X)		; if not write byte to screen
			rts					; and exit



__mode7_xlate_char:	lda	_TELETEXT_CHAR_TAB+1,Y		; convert with teletext conversion table
			bne	__mode7_out_char		; and write it


;***********four colour modes ********************************************

_VDU_OUT_COL4:		lda	(VDU_TMP5),Y			; get pattern byte
			pha					; save it
			lsr					; move hi nybble to lo
			lsr					; 
			lsr					; 
			lsr					; 
			tax					; X=A
			lda	_COL16_MASK_TAB,X		; 4 colour mode byte mask look up table
			ora	VDU_T_OR_MASK			; text colour byte to be orred or EORed into memory
			eor	VDU_T_EOR_MASK			; text colour byte to be orred or EORed into memory
			sta	(VDU_TOP_SCAN),Y		; write to screen
			tya					; A=Y

			clc					; clear carry
			adc	#$08				; add 8 to move screen RAM pointer 8 bytes
			tay					; Y=A
			pla					; get back A
			and	#$0f				; clear high nybble
			tax					; X=A
			lda	_COL16_MASK_TAB,X		; 4 colour mode byte mask look up table
			ora	VDU_T_OR_MASK			; text colour byte to be orred or EORed into memory
			eor	VDU_T_EOR_MASK			; text colour byte to be orred or EORed into memory
			sta	(VDU_TOP_SCAN),Y		; write to screen
			tya					; A=Y
			sbc	#$08				; A=A-9
			tay					; Y=A
			bpl	_VDU_OUT_COL4			; if +ve do loop again
_BD017:			rts					; exit



_BD018:			tya					; Y=Y-&21
			sbc	#$21				; 
			bmi	_BD017				; IF Y IS negative then RETURN
			tay					; else A=Y

;******* 16 COLOUR MODES *************************************************

_VDU_OUT_COL16:		lda	(VDU_TMP5),Y			; get pattern byte
			sta	VDU_TMP3			; store it
			sec					; set carry
_BD023:			lda	#$00				; A=0
			rol	VDU_TMP3			; carry now occupies bit 0 of DC
			beq	_BD018				; when DC=0 again D018 to deal with next pattern byte
			rol					; get bit 7 from &DC into A bit 0
			asl	VDU_TMP3			; rotate again to get second
			rol					; bit into A
			tax					; and store result in X
			lda	_COL4_MASK_TAB,X		; multiply by &55 using look up table
			ora	VDU_T_OR_MASK			; and set colour factors
			eor	VDU_T_EOR_MASK			; 
			sta	(VDU_TOP_SCAN),Y		; and store result
			clc					; clear carry
			tya					; Y=Y+8 moving screen RAM pointer on 8 bytes
			adc	#$08				; 
			tay					; 
			bcc	_BD023				; iloop to D023 to deal with next bit pair


;************* calculate pattern address for given code ******************
;A contains code on entry = 12345678

_LD03E:			asl					; 23456780  C holds 1
			rol					; 34567801  C holds 2
			rol					; 45678012  C holds 3
			sta	VDU_TMP5			; save this pattern
			and	#$03				; 00000012
			rol					; 00000123 C=0
			tax					; X=A=0 - 7
			and	#$03				; A=00000023
			adc	#$bf				; A=&BF,C0 or C1
			tay					; this is used as a pointer
			lda	_LC40D,X			; A=&80/2^X i.e.1,2,4,8,&10,&20,&40, or &80
			bit	VDU_FONT_FLAGS			; with font flag
			beq	_BD057				; if 0 D057
			ldy	VDU_FONT_FLAGS,X		; else get hi byte from table
_BD057:			sty	VDU_TMP6			; store Y
			lda	VDU_TMP5			; get back pattern
			and	#$f8				; convert to 45678000
			sta	VDU_TMP5			; and re store it
			rts					; exit
								;
;*************************************************************************
;*************************************************************************
;**									 **
;**									 **
;**	 PLOT ROUTINES ENTER HERE					 **
;**									 **
;**									 **
;*************************************************************************
;*************************************************************************
;on entry    ADDRESS	PARAMETER	 DESCRIPTION
;	    031F    1		    plot type
;	    0320/1  2,3		    X coordinate
;	    0322/3  4,5		    Y coordinate

_LD060:			ldx	#$20				; X=&20
			jsr	_LD14D				; translate coordinates

			lda	VDU_QUEUE_4			; get plot type
			cmp	#$04				; if its 4
			beq	_LD0D9				; D0D9 move absolute
			ldy	#$05				; Y=5
			and	#$03				; mask only bits 0 and 1
			beq	_BD080				; if result is 0 then its a move (multiple of 8)
			lsr					; else move bit 0 int C
			bcs	_BD078				; if set then D078 graphics colour required
			dey					; Y=4
			bne	_BD080				; logic inverse colour must be wanted

;******** graphics colour wanted *****************************************

_BD078:			tax					; X=A if A=0 its a foreground colour 1 its background
			ldy	VDU_P_FG,X			; get fore or background graphics PLOT mode
			lda	VDU_G_FG,X			; get fore or background graphics colour
			tax					; X=A

_BD080:			jsr	_LD0B3				; set up colour masks in D4/5

			lda	VDU_QUEUE_4			; get plot type
			bmi	_BD0AB				; if &80-&FF then D0AB type not implemented
			asl					; bit 7=bit 6
			bpl	_BD0C6				; if bit 6 is 0 then plot type is 0-63 so D0C6
			and	#$f0				; else mask out lower nybble
			asl					; shift old bit 6 into C bit old 5 into bit 7
			beq	_BD0D6				; if 0 then type 64-71 was called single point plot
								; goto D0D6
			eor	#$40				; if bit 6 NOT set type &80-&87 fill triangle
			beq	_BD0A8				; so D0A8
			pha					; else push A
			jsr	_LD0DC				; copy 0320/3 to 0324/7 setting XY in current graphics
								; coordinates
			pla					; get back A
			eor	#$60				; if BITS 6 and 5 NOT SET type 72-79 lateral fill
			beq	_BD0AE				; so D0AE
			cmp	#$40				; if type 88-95 horizontal line blanking
			bne	_BD0AB				; so D0AB

			lda	#$02				; else A=2
			sta	VDU_TMP3			; store it
			jmp	_LD506				; and jump to D506 type not implemented

_BD0A8:			jmp	_LD5EA				; to fill triangle routine

_BD0AB:			jmp	_LC938				; VDU extension access entry

_BD0AE:			sta	VDU_TMP3			; store A
			jmp	_LD4BF				; 

;*********:set colour masks **********************************************
;graphics mode in Y
;colour in X

_LD0B3:			txa					; A=X
			ora	_LC41C,Y			; or with GCOL plot options table byte
			eor	_LC41D,Y			; EOR with following byte
			sta	VDU_G_OR_MASK			; and store it
			txa					; A=X
			ora	_LC41B,Y			; 
			eor	_LC420,Y			; 
			sta	VDU_G_EOR_MASK			; 
			rts					; exit with masks in &D4/5


;************** analyse first parameter in 0-63 range ********************
				;
_BD0C6:			asl					; shift left again
			bmi	_BD0AB				; if -ve options are in range 32-63 not implemented
			asl					; shift left twice more
			asl					; 
			bpl	_BD0D0				; if still +ve type is 0-7 or 16-23 so D0D0
			jsr	_LD0EB				; else display a point

_BD0D0:			jsr	_LD1ED				; perform calculations
			jmp	_LD0D9				; 


;*************************************************************************
;*									 *
;*	 PLOT A SINGLE POINT						 *
;*									 *
;*************************************************************************

_BD0D6:			jsr	_LD0EB				; display a point
_LD0D9:			jsr	_LCDE2				; swap current and last graphics position
_LD0DC:			ldy	#$24				; Y=&24
_LD0DE:			ldx	#$20				; X=&20
			jmp	_LD48A				; copy parameters to 324/7 (300/3 +Y)


_LD0E3:			ldx	#$24				; 
			jsr	_LD85F				; calculate position
			beq	_LD0F0				; if result =0 then D0F0
			rts					; else exit
								;
_LD0EB:			jsr	_LD85D				; calculate position
			bne	_BD103				; if A<>0 D103 and return
_LD0F0:			ldy	VDU_G_CURS_SCAN			; else get current graphics scan line
_LD0F3:			lda	VDU_G_PIX_MASK			; pick up and modify screen byte
			and	VDU_G_OR_MASK			; 
			ora	(VDU_G_MEM),Y			; 
			sta	VDU_TMP1			; 
			lda	VDU_G_EOR_MASK			; 
			and	VDU_G_PIX_MASK			; 
			eor	VDU_TMP1			; 
			sta	(VDU_G_MEM),Y			; put it back again
_BD103:			rts					; and exit
								;

_LD104:			lda	(VDU_G_MEM),Y			; this is a more simplistic version of the above
			ora	VDU_G_OR_MASK			; 
			eor	VDU_G_EOR_MASK			; 
			sta	(VDU_G_MEM),Y			; 
			rts					; and exit



