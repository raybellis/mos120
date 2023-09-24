;************************** Check window limits *************************
				;
			.org	$d10d

_LD10D:			ldx	#$24				; X=&24
_LD10F:			ldy	#$00				; Y=0
			sty	VDU_TMP1			; &DA=0
			ldy	#$02				; Y=2
			jsr	_LD128				; check vertical graphics position 326/7
								; bottom and top margins 302/3, 306/7
			asl	VDU_TMP1			; DATA is set in &DA bits 0 and 1 then shift left
			asl	VDU_TMP1			; twice to make room for next pass
			dex					; X=&22
			dex					; 
			ldy	#$00				; Y=0
			jsr	_LD128				; left and right margins 300/1, 304/5
								; cursor horizontal position 324/5
			inx					; X=X+2
			inx					; 
			lda	VDU_TMP1			; A=&DA
			rts					; exit

;*** cursor and margins check ******************************************
				;
_LD128:			lda	VDU_G_WIN_B,X			; check for window violation
			cmp	VDU_G_WIN_L,Y			; 300/1 +Y > 302/3+X
			lda	VDU_G_WIN_B_HI,X		; then window fault
			sbc	VDU_G_WIN_L_HI,Y		; 
			bmi	_BD146				; so D146

			lda	VDU_G_WIN_R,Y			; check other windows
			cmp	VDU_G_WIN_B,X			; 
			lda	VDU_G_WIN_R_HI,Y		; 
			sbc	VDU_G_WIN_B_HI,X		; 
			bpl	_BD148				; if no violation exit
			inc	VDU_TMP1			; else DA=DA+1

_BD146:			inc	VDU_TMP1			; DA=DA+1
_BD148:			rts					; and exit  DA=0 no problems DA=1 first check 2, 2nd

;***********set up and adjust positional data ****************************

_LD149:			lda	#$ff				; A=&FF
			bne	_BD150				; then &D150

_LD14D:			lda	VDU_QUEUE_4			; get first parameter in plot

_BD150:			sta	VDU_TMP1			; store in &DA
			ldy	#$02				; Y=2
			jsr	_LD176				; set up vertical coordinates/2
			jsr	_LD1AD				; /2 again to convert 1023 to 0-255 for internal use
								; this is why minimum vertical plot separation is 4
			ldy	#$00				; Y=0
			dex					; X=x-2
			dex					; 
			jsr	_LD176				; set up horiz. coordinates/2 this is OK for mode0,4
			ldy	VDU_PIX_BYTE			; get number of pixels/byte (-1)
			cpy	#$03				; if Y=3 (modes 1 and 5)
			beq	_BD16D				; D16D
			bcs	_BD170				; for modes 0 & 4 this is 7 so D170
			jsr	_LD1AD				; for other modes divide by 2 twice

_BD16D:			jsr	_LD1AD				; divide by 2
_BD170:			lda	VDU_MAP_TYPE			; get screen display type
			bne	_LD1AD				; if not 0 (modes 3-7) divide by 2 again
			rts					; and exit

;for mode 0 1 division	1280 becomes 640 = horizontal resolution
;for mode 1 2 divisions 1280 becomes 320 = horizontal resolution
;for mode 2 3 divisions 1280 becomes 160 = horizontal resolution
;for mode 4 2 divisions 1280 becomes 320 = horizontal resolution
;for mode 5 3 divisions 1280 becomes 160 = horizontal resolution

;********** calculate external coordinates in internal format ***********
;on entry X is usually &1E or &20

_LD176:			clc					; clear carry
			lda	VDU_TMP1			; get &DA
			and	#$04				; if bit 2=0
			beq	_BD186				; then D186 to calculate relative coordinates
			lda	VDU_G_WIN_B,X			; else get coordinate
			pha					; 
			lda	VDU_G_WIN_B_HI,X		; 
			bcc	_BD194				; and goto D194

_BD186:			lda	VDU_G_WIN_B,X			; get coordinate
			adc	VDU_G_CUR_XX,Y			; add cursor position
			pha					; save it
			lda	VDU_G_WIN_B_HI,X		; 
			adc	VDU_G_CUR_XX_HI,Y		; add cursor
			clc					; clear carry

_BD194:			sta	VDU_G_CUR_XX_HI,Y		; save new cursor
			adc	VDU_G_ORG_XX_HI,Y		; add graphics origin
			sta	VDU_G_WIN_B_HI,X		; store it
			pla					; get back lo byte
			sta	VDU_G_CUR_XX,Y			; save it in new cursor lo
			clc					; clear carry
			adc	VDU_G_ORG_XX,Y			; add to graphics orgin
			sta	VDU_G_WIN_B,X			; store it
			bcc	_LD1AD				; if carry set
			inc	VDU_G_WIN_B_HI,X		; increment hi byte as you would expect!

_LD1AD:			lda	VDU_G_WIN_B_HI,X		; get hi byte
			asl					; 
			ror	VDU_G_WIN_B_HI,X		; divide by 2
			ror	VDU_G_WIN_B,X			; 
			rts					; and exit

;***** calculate external coordinates from internal coordinates************

_LD1B8:			ldy	#$10				; Y=10
			jsr	_LD488				; copy 324/7 to 310/3 i.e.current graphics cursor
								; position to position in external values
			ldx	#$02				; X=2
			ldy	#$02				; Y=2
			jsr	_LD1D5				; multiply 312/3 by 4 and subtract graphics origin
			ldx	#$00				; X=0
			ldy	#$04				; Y=4
			lda	VDU_PIX_BYTE			; get  number of pixels/byte
_BD1CB:			dey					; Y=Y-1
			lsr					; divide by 2
			bne	_BD1CB				; if result not 0 D1CB
			lda	VDU_MAP_TYPE			; else get screen display type
			beq	_LD1D5				; and if 0 D1D5
			iny					; 

_LD1D5:			asl	VDU_G_CUR_XX,X			; multiply coordinate by 2
			rol	VDU_G_CUR_XX_HI,X		; 
			dey					; Y-Y-1
			bne	_LD1D5				; and if Y<>0 do it again
			sec					; set carry
			jsr	_LD1E3				; 
			inx					; increment X

_LD1E3:			lda	VDU_G_CUR_XX,X			; get current graphics position in external coordinates
			sbc	VDU_G_ORG_XX,X			; subtract origin
			sta	VDU_G_CUR_XX,X			; store in graphics position
			rts					; and exit

;************* compare X and Y PLOT spans ********************************

_LD1ED:			jsr	_LD40D				; Set X and Y spans in workspace 328/9 32A/B
			lda	VDU_BITMAP_RD_3			; compare spans
			eor	VDU_BITMAP_RD_1			; if result -ve spans are different in sign so
			bmi	_BD207				; goto D207
			lda	VDU_BITMAP_RD_2			; else A=hi byte of difference in spans
			cmp	VDU_BITMAP_READ			; 
			lda	VDU_BITMAP_RD_3			; 
			sbc	VDU_BITMAP_RD_1			; 
			jmp	_LD214				; and goto D214

_BD207:			lda	VDU_BITMAP_READ			; A = hi byte of SUM of spans
			clc					; 
			adc	VDU_BITMAP_RD_2			; 
			lda	VDU_BITMAP_RD_1			; 
			adc	VDU_BITMAP_RD_3			; 

_LD214:			ror					; A=A/2
			ldx	#$00				; X=0
			eor	VDU_BITMAP_RD_3			; 
			bpl	_BD21E				; if positive result D21E

			ldx	#$02				; else X=2

_BD21E:			stx	VDU_TMP5			; store it
			lda	_LC4AA,X			; set up vector address
			sta	VDU_JUMPVEC			; in 35D
			lda	_LC4AA + 1,X			; 
			sta	VDU_JUMPVEC_HI			; and 35E
			lda	VDU_BITMAP_RD_1,X		; get hi byte of span
			bpl	_BD235				; if +ve D235
			ldx	#$24				; X=&24
			bne	_BD237				; jump to D237

_BD235:			ldx	#$20				; X=&20
_BD237:			stx	VDU_TMP6			; store it
			ldy	#$2c				; Y=&2C
			jsr	_LD48A				; get X coordinate data or horizontal coord of
								; curent graphics cursor
			lda	VDU_TMP6			; get back original X
			eor	#$04				; covert &20 to &24 and vice versa
			sta	VDU_TMP4			; 
			ora	VDU_TMP5			; 
			tax					; 
			jsr	_LD480				; copy 330/1 to 300/1+X
			lda	VDU_QUEUE_4			; get plot type
			and	#$10				; check bit 4
			asl					; 
			asl					; 
			asl					; move to bit 7
			sta	VDU_TMP2			; store it
			ldx	#$2c				; X=&2C
			jsr	_LD10F				; check for window violations
			sta	VDU_TMP3			; 
			beq	_BD263				; if none then D263
			lda	#$40				; else set bit 6 of &DB
			ora	VDU_TMP2			; 
			sta	VDU_TMP2			; 

_BD263:			ldx	VDU_TMP4			; 
			jsr	_LD10F				; check window violations again
			bit	VDU_TMP3			; if bit 7 of &DC NOT set
			beq	_BD26D				; D26D
			rts					; else exit
								;
_BD26D:			ldx	VDU_TMP5			; X=&DE
			beq	_BD273				; if X=0 D273
			lsr					; A=A/2
			lsr					; A=A/2

_BD273:			and	#$02				; clear all but bit 2
			beq	_BD27E				; if bit 2 set D27E
			txa					; else A=X
			ora	#$04				; A=A or 4 setting bit 3
			tax					; X=A
			jsr	_LD480				; set 300/1+x to 330/1
_BD27E:			jsr	_LD42C				; more calcualtions
			lda	VDU_TMP5			; A=&DE EOR 2
			eor	#$02				; 
			tax					; X=A
			tay					; Y=A
			lda	VDU_BITMAP_RD_1			; compare upper byte of spans
			eor	VDU_BITMAP_RD_3			; 
			bpl	_BD290				; if signs are the same D290
			inx					; else X=X+1
_BD290:			lda	_LC4AE,X			; get vector addresses and store 332/3
			sta	VDU_WORKSPACE+2			; 
			lda	_LC4B2,X			; 
			sta	VDU_WORKSPACE+3			; 

			lda	#$7f				; A=&7F
			sta	VDU_WORKSPACE+4			; store it
			bit	VDU_TMP2			; if bit 6 set
			bvs	_BD2CE				; the D2CE
			lda	_LC447,X			; get VDU section number
			tax					; X=A
			sec					; set carry
			lda	VDU_G_WIN_L,X			; subtract coordinates
			sbc	VDU_BITMAP_RD_4,Y		; 
			sta	VDU_TMP1			; 
			lda	VDU_G_WIN_L_HI,X		; 
			sbc	VDU_BITMAP_RD_5,Y		; 
			ldy	VDU_TMP1			; Y=hi
			tax					; X=lo=A
			bpl	_BD2C0				; and if A+Ve D2C0
			jsr	_LD49B				; negate Y/A

_BD2C0:			tax					; X=A increment Y/A
			iny					; Y=Y+1
			bne	_BD2C5				; 
			inx					; X=X+1
_BD2C5:			txa					; A=X
			beq	_BD2CA				; if A=0 D2CA
			ldy	#$00				; else Y=0

_BD2CA:			sty	VDU_TMP6			; &DF=Y
			beq	_BD2D7				; if 0 then D2D7
_BD2CE:			txa					; A=X
			lsr					; A=A/4
			ror					; 
			ora	#$02				; bit 1 set
			eor	VDU_TMP5			; 
			sta	VDU_TMP5			; and store
_BD2D7:			ldx	#$2c				; X=&2C
			jsr	_LD864				; 
			ldx	VDU_TMP3			; 
			bne	_BD2E2				; 
			dec	VDU_TMP4			; 
_BD2E2:			dex					; X=X-1
_LD2E3:			lda	VDU_TMP2			; A=&3B
			beq	_BD306				; if 0 D306
			bpl	_BD2F9				; else if +ve D2F9
			bit	VDU_WORKSPACE+4			; 
			bpl	_BD2F3				; if bit 7=0 D2F3
			dec	VDU_WORKSPACE+4			; else decrement
			bne	_BD316				; and if not 0 D316

_BD2F3:			inc	VDU_WORKSPACE+4			; 
			asl					; A=A*2
			bpl	_BD306				; if +ve D306
_BD2F9:			stx	VDU_TMP3			; 
			ldx	#$2c				; 
			jsr	_LD85F				; calcualte screen position
			ldx	VDU_TMP3			; get back original X
			ora	#$00				; 
			bne	_BD316				; 
_BD306:			lda	VDU_G_PIX_MASK			; byte mask for current graphics point
			and	VDU_G_OR_MASK			; and with graphics colour byte
			ora	(VDU_G_MEM),Y			; or  with curent graphics cell line
			sta	VDU_TMP1			; store result
			lda	VDU_G_EOR_MASK			; same again with next byte (hi??)
			and	VDU_G_PIX_MASK			; 
			eor	VDU_TMP1			; 
			sta	(VDU_G_MEM),Y			; then store it inm current graphics line
_BD316:			sec					; set carry
			lda	VDU_WORKSPACE+5			; A=&335/6-&337/8
			sbc	VDU_WORKSPACE+7			; 
			sta	VDU_WORKSPACE+5			; 
			lda	VDU_WORKSPACE+6			; 
			sbc	VDU_WORKSPACE+8			; 
			bcs	_BD339				; if carry set D339
			sta	VDU_TMP1			; 
			lda	VDU_WORKSPACE+5			; 
			adc	VDU_WORKSPACE+9			; 
			sta	VDU_WORKSPACE+5			; 
			lda	VDU_TMP1			; 
			adc	VDU_WORKSPACE+$A		; 
			clc					; 
_BD339:			sta	VDU_WORKSPACE+6			; 
			php					; 
			bcs	_BD348				; if carry clear jump to VDU routine else D348
			jmp	(VDU_WORKSPACE+2)		; 

;****** vertical scan module 1******************************************

			dey					; Y=Y-1
			bpl	_BD348				; if + D348
			jsr	_LD3D3				; else d3d3 to advance pointers
_BD348:			jmp	(VDU_JUMPVEC)			; and JUMP (&35D)

;****** vertical scan module 2******************************************

			iny					; Y=Y+1
			cpy	#$08				; if Y<>8
			bne	_BD348				; then D348
			clc					; else clear carry
			lda	VDU_G_MEM			; get address of top line of cuirrent graphics cell
			adc	VDU_BPR				; add number of bytes/character row
			sta	VDU_G_MEM			; store it
			lda	VDU_G_MEM_HI			; do same for hibyte
			adc	VDU_BPR_HI			; 
			bpl	_BD363				; if result -ve then we are above screen RAM
			sec					; so
			sbc	VDU_MEM_PAGES			; subtract screen memory size hi
_BD363:			sta	VDU_G_MEM_HI			; store it this wraps around point to screen RAM
			ldy	#$00				; Y=0
			jmp	(VDU_JUMPVEC)			; 

;****** horizontal scan module 1******************************************

			lsr	VDU_G_PIX_MASK			; shift byte mask
			bcc	_BD348				; if carry clear (&D1 was +ve) goto D348
			jsr	_LD3ED				; else reset pointers
			jmp	(VDU_JUMPVEC)			; and off to do more

;****** horizontal scan module 2******************************************

			asl	VDU_G_PIX_MASK			; shift byte mask
			bcc	_BD348				; if carry clear (&D1 was +ve) goto D348
			jsr	_LD3FD				; else reset pointers
			jmp	(VDU_JUMPVEC)			; and off to do more

_LD37E:			dey					; Y=Y-1
			bpl	_BD38D				; if +ve D38D
			jsr	_LD3D3				; advance pointers
			bne	_BD38D				; goto D38D normally
_LD386:			lsr	VDU_G_PIX_MASK			; shift byte mask
			bcc	_BD38D				; if carry clear (&D1 was +ve) goto D348
			jsr	_LD3ED				; else reset pointers
_BD38D:			plp					; pull flags
			inx					; X=X+1
			bne	_BD395				; if X>0 D395
			inc	VDU_TMP4			; else increment &DD
			beq	_BD39F				; and if not 0 D39F
_BD395:			bit	VDU_TMP2			; else if BIT 6 = 1
			bvs	_BD3A0				; goto D3A0
			bcs	_BD3D0				; if BIT 7=1 D3D0
			dec	VDU_TMP6			; else Decrement &DF
			bne	_BD3D0				; and if not Zero D3D0
_BD39F:			rts					; else return
								;
_BD3A0:			lda	VDU_TMP5			; A=&DE
			stx	VDU_TMP3			; &DC=X
			and	#$02				; clear all but bit 1
			tax					; X=A
			bcs	_BD3C2				; and if carry set goto D3C2
			bit	VDU_TMP5			; if Bit 7 of &DE =1
			bmi	_BD3B7				; then D3B7
			inc	VDU_BITMAP_RD_4,X		; else increment
			bne	_BD3C2				; and if not 0 D3C2
			inc	VDU_BITMAP_RD_5,X		; else increment hi byte
			bcc	_BD3C2				; and if carry clear D3C2
_BD3B7:			lda	VDU_BITMAP_RD_4,X		; esle A=32C,X
			bne	_BD3BF				; and if not 0 D3BF
			dec	VDU_BITMAP_RD_5,X		; decrement hi byte
_BD3BF:			dec	VDU_BITMAP_RD_4,X		; decrement lo byte

_BD3C2:			txa					; A=X
			eor	#$02				; invert bit 2
			tax					; X=A
			inc	VDU_BITMAP_RD_4,X		; Increment 32C/D
			bne	_BD3CE				; 
			inc	VDU_BITMAP_RD_5,X		; 
_BD3CE:			ldx	VDU_TMP3			; X=&DC
_BD3D0:			jmp	_LD2E3				; jump to D2E3

;**********move display point up a line **********************************
_LD3D3:			sec					; SET CARRY
			lda	VDU_G_MEM			; subtract number of bytes/line from address of
			sbc	VDU_BPR				; top line of current graphics cell
			sta	VDU_G_MEM			; 
			lda	VDU_G_MEM_HI			; 
			sbc	VDU_BPR_HI			; 
			cmp	VDU_PAGE			; compare with bottom of screen memory
			bcs	_BD3E8				; if outside screen RAM
			adc	VDU_MEM_PAGES			; add screen memory size to wrap it around
_BD3E8:			sta	VDU_G_MEM_HI			; store in current address of graphics cell top line
			ldy	#$07				; Y=7
			rts					; and RETURN

_LD3ED:			lda	VDU_MASK_RIGHT			; get current left colour mask
			sta	VDU_G_PIX_MASK			; store it
			lda	VDU_G_MEM			; get current top line of graphics cell
			adc	#$07				; ADD 7
			sta	VDU_G_MEM			; 
			bcc	_BD3FC				; 
			inc	VDU_G_MEM_HI			; 
_BD3FC:			rts					; and return

_LD3FD:			lda	VDU_MASK_LEFT			; get right colour mask
			sta	VDU_G_PIX_MASK			; store it
			lda	VDU_G_MEM			; A=top line graphics cell low
			bne	_BD408				; if not 0 D408
			dec	VDU_G_MEM_HI			; else decrement hi byte

_BD408:			sbc	#$08				; subtract 9 (8 + carry)
			sta	VDU_G_MEM			; and store in low byte
			rts					; return

;********:: coordinate subtraction ***************************************

_LD40D:			ldy	#$28				; X=&28
			ldx	#$20				; Y=&20
_LD411:			jsr	_LD418				; 
			inx					; X=X+2
			inx					; 
			iny					; Y=Y+2
			iny					; 

_LD418:			sec					; set carry
			lda	VDU_G_WIN_R,X			; subtract coordinates
			sbc	VDU_G_WIN_L,X			; 
			sta	VDU_G_WIN_L,Y			; 
			lda	VDU_G_WIN_R_HI,X		; 
			sbc	VDU_G_WIN_L_HI,X		; 
			sta	VDU_G_WIN_L_HI,Y		; 
			rts					; and return

_LD42C:			lda	VDU_TMP5			; A=&DE
			bne	_BD437				; if A=0 D437
			ldx	#$28				; X=&28
			ldy	#$2a				; Y=&2A
			jsr	_LCDDE				; exchange 300/1+Y with 300/1+X
								; IN THIS CASE THE X AND Y SPANS!

_BD437:			ldx	#$28				; X=&28
			ldy	#$37				; Y=&37
			jsr	_LD48A				; copy &300/4+Y to &300/4+X
								; transferring X and Y spans in this case
			sec					; set carry
			ldx	VDU_TMP5			; X=&DE
			lda	VDU_WORKSPACE			; subtract 32C/D,X from 330/1
			sbc	VDU_BITMAP_RD_4,X		; 
			tay					; partial answer in Y
			lda	VDU_WORKSPACE+1			; 
			sbc	VDU_BITMAP_RD_5,X		; 
			bmi	_BD453				; if -ve D453
			jsr	_LD49B				; else negate Y/A

_BD453:			sta	VDU_TMP4			; store A
			sty	VDU_TMP3			; and Y
			ldx	#$35				; X=&35
_LD459:			jsr	_LD467				; get coordinates
			lsr					; 
			sta	VDU_G_WIN_L_HI,X		; 
			tya					; 
			ror					; 
			sta	VDU_G_WIN_L,X			; 
			dex					; 
			dex					; 

_LD467:			ldy	VDU_G_WIN_R,X			; 
			lda	VDU_G_WIN_R_HI,X		; 
			bpl	_BD47B				; if A is +ve RETURN
			jsr	_LD49B				; else negate Y/A
			sta	VDU_G_WIN_R_HI,X		; store back again
			pha					; 
			tya					; 
			sta	VDU_G_WIN_R,X			; 
			pla					; get back A
_BD47B:			rts					; and exit
								;
_LD47C:			lda	#$08				; A=8
			bne	_VDU_VAR_COPY			; copy 8 bytes
_LD480:			ldy	#$30				; Y=&30
_LD482:			lda	#$02				; A=2
			bne	_VDU_VAR_COPY			; copy 2 bytes
_LD486:			ldy	#$28				; copy 4 bytes from 324/7 to 328/B
_LD488:			ldx	#$24				; 
_LD48A:			lda	#$04				; 

;***********copy A bytes from 300,X to 300,Y ***************************

_VDU_VAR_COPY:		sta	VDU_TMP1			; 
__vdu_var_copy_next:	lda	VDU_G_WIN_L,X			; 
			sta	VDU_G_WIN_L,Y			; 
			inx					; 
			iny					; 
			dec	VDU_TMP1			; 
			bne	__vdu_var_copy_next		; 
			rts					; and return

;************* negation routine ******************************************

_LD49B:			pha					; save A
			tya					; A=Y
			eor	#$ff				; invert
			tay					; Y=A
			pla					; get back A
			eor	#$ff				; invert
			iny					; Y=Y+1
			bne	_BD4A9				; if not 0 exit
			clc					; else
			adc	#$01				; add 1 to A
_BD4A9:			rts					; return
								;
_LD4AA:			jsr	_LD85D				; check window boundaries and set up screen pointer
			bne	_BD4B7				; if A<>0 D4B7
			lda	(VDU_G_MEM),Y			; else get byte from current graphics cell
			eor	VDU_G_BG			; compare with current background colour
			sta	VDU_TMP1			; store it
			rts					; and RETURN

_BD4B7:			pla					; get back return link
			pla					; 
_BD4B9:			inc	VDU_G_CURS_V			; increment current graphics cursor vertical lo
			jmp	_LD545				; 


