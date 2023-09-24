;*************************************************************************
;*									 *
;*	 VDU 24 - DEFINE GRAPHICS WINDOW				 *
;*									 *
;*	 8 parameters							 *
;*									 *
;*************************************************************************
;&31C/D Left margin
;&31E/F Bottom margin
;&320/1 Right margin
;&322/3 Top margin

			.org	$ca39

_VDU_24:		jsr	_LCA81				; exchange 310/3 with 328/3
			ldx	#$1c				; 
			ldy	#$2c				; 
			jsr	_LD411				; calculate width=right - left
								; height = top-bottom
			ora	VDU_BITMAP_RD_5			; 
			bmi	_LCA81				; exchange 310/3 with 328/3 and exit
			ldx	#$20				; X=&20
			jsr	_LD149				; scale pointers to mode
			ldx	#$1c				; X=&1C
			jsr	_LD149				; scale pointers to mode
			lda	VDU_QUEUE_4			; check for negative margins
			ora	VDU_QUEUE_2			; 
			bmi	_LCA81				; if found exchange 310/3 with 328/3 and exit
			lda	VDU_QUEUE_8			; 
			bne	_LCA81				; exchange 310/3 with 328/3 and exit
			ldx	VDU_MODE			; screen mode
			lda	VDU_QUEUE_6			; right margin hi
			sta	VDU_TMP1			; store it
			lda	VDU_QUEUE_5			; right margin lo
			lsr	VDU_TMP1			; /2
			ror					; A=A/2
			lsr	VDU_TMP1			; /2
			bne	_LCA81				; exchange 310/3 with 328/3
			ror					; A=A/2
			lsr					; A=A/2
			cmp	_TEXT_COL_TABLE,X		; text window right hand margin maximum
			beq	_BCA7A				; if equal CA7A
			bpl	_LCA81				; exchange 310/3 with 328/3

_BCA7A:			ldy	#$00				; Y=0
			ldx	#$1c				; X=&1C
			jsr	_LD47C				; set(300/7+Y) from (300/7+X)

;***************** exchange 310/3 with 328/3 *****************************

_LCA81:			ldx	#$10				; X=10
			ldy	#$28				; Y=&28
			jmp	_LCDE6				; exchange 300/3+Y and 300/3+X

_LCA88:			iny					; Y=Y+1
			tya					; A=Y
			ldy	#$00				; Y=0
			sty	VDU_T_WIN_SZ_HI			; text window width hi (bytes)
			sta	VDU_T_WIN_SZ			; text window width lo (bytes)
			lda	VDU_BPC				; bytes per character
			lsr					; /2
			beq	_BCAA1				; if 0 exit
_BCA98:			asl	VDU_T_WIN_SZ			; text window width lo (bytes)
			rol	VDU_T_WIN_SZ_HI			; text window width hi (bytes)
			lsr					; /2
			bcc	_BCA98				; 
_BCAA1:			rts					; 


;*************************************************************************
;*									 *
;*	 VDU 29 - SET GRAPHICS ORIGIN					 *
;*									 *
;*	 4 parameters							 *
;*									 *
;*************************************************************************

_VDU_29:		ldx	#$20				; 
			ldy	#$0c				; 
			jsr	_LD48A				; (&300/3+Y)=(&300/3+X)
			jmp	_LD1B8				; set up external coordinates for graphics


;*************************************************************************
;*									 *
;*	 VDU 127 (&7F) - DELETE (entry 32)				 *
;*									 *
;*************************************************************************

_VDU_127:		jsr	_VDU_8				; cursor left
			jsr	_LC588				; A=0 if text cursor A=&20 if graphics cursor
			bne	__vdu_del_modeX			; if graphics then CAC7
			ldx	VDU_COL_MASK			; number of logical colours less 1
			beq	__vdu_del_mode7			; if mode 7 CAC2
			sta	VDU_TMP5			; else store A (always 0)
			lda	#$c0				; A=&C0
			sta	VDU_TMP6			; store in &DF (&DE) now points to C300 SPACE pattern
			jmp	_LCFBF				; display a space

__vdu_del_mode7:	lda	#$20				; A=&20
			jmp	_VDU_OUT_MODE7			; and return to display a space

__vdu_del_modeX:	lda	#$7f				; for graphics cursor
			jsr	_LD03E				; set up character definition pointers
			ldx	VDU_G_BG			; Background graphics colour
			ldy	#$00				; Y=0
			jmp	_LCF63				; invert pattern data (to background colour)

;***** Add number of bytes in a line to X/A ******************************

_LCAD4:			pha					; store A
			txa					; A=X
			clc					; clear carry
			adc	VDU_BPR				; bytes per character row
			tax					; X=A
			pla					; get back A
			adc	VDU_BPR_HI			; bytes per character row
			rts					; and return

;********* control scrolling in paged mode *******************************

_BCAE0:			jsr	_LCB14				; zero paged mode line counter
_LCAE3:			jsr	_OSBYTE_118			; osbyte 118 check keyboard status; set LEDs
			bcc	_BCAEA				; if carry clear CAEA
			bmi	_BCAE0				; if M set CAE0 do it again

_BCAEA:			lda	VDU_STATUS			; VDU status byte
			eor	#$04				; invert bit 2 paged scrolling
			and	#$46				; and if 2 cursors, paged mode off, or scrolling
			bne	_BCB1C				; barred then CB1C to exit

			lda	OSB_HALT_LINES			; paged mode counter
			bmi	_BCB19				; if negative then exit via CB19

			lda	VDU_T_CURS_Y			; current text line
			cmp	VDU_T_WIN_B			; bottom margin
			bcc	_BCB19				; increment line counter and exit

			lsr					; A=A/4
			lsr					; 
			sec					; set carry
			adc	OSB_HALT_LINES			; paged mode counter
			adc	VDU_T_WIN_T			; top of text window
			cmp	VDU_T_WIN_B			; bottom margin
			bcc	_BCB19				; increment line counter and exit

			clc					; clear carry
_BCB0E:			jsr	_OSBYTE_118			; osbyte 118 check keyboard status; set LEDs
			sec					; set carry
			bpl	_BCB0E				; if +ve result then loop till shift pressed

;**************** zero paged mode  counter *******************************

_LCB14:			lda	#$ff				; 
			sta	OSB_HALT_LINES			; paged mode counter
_BCB19:			inc	OSB_HALT_LINES			; paged mode counter
_BCB1C:			rts					; 

;********* intitialise VDU driver with MODE in A *************************

_VDU_INIT_MODE:		pha					; Save MODE in A
			ldx	#$7f				; Prepare X=&7F for reset loop
			lda	#$00				; A=0
			sta	VDU_STATUS			; Clear VDU status byte to set default conditions

__vdu_mode_init_loop:	sta	OSFILE_CB_17,X			; Zero VDU workspace at &300 to &37E
			dex					
			bne	__vdu_mode_init_loop		

			jsr	_OSBYTE_20			; Implode character definitions
			pla					; Get initial MODE back to A
			ldx	#$7f				; X=&7F
			stx	VDU_TTX_CURSOR			; MODE 7 copy cursor character (could have set this at CB1E)

;********* enter here from VDU 22,n - MODE *******************************

_LCB33:			bit	OSB_RAM_PAGES			; Check available RAM
			bmi	_BCB3A				; If 32K, use all MODEs
			ora	#$04				; Only 16K available, force to use MODEs 4-7

_BCB3A:			and	#$07				; X=A and 7 ensure legal mode
			tax					; X=mode
			stx	VDU_MODE			; Save current screen MODE
			lda	_LC414,X			; Get number of colours -1 for this MODE
			sta	VDU_COL_MASK			; Set current number of logical colours less 1
			lda	_TXT_BPC_TABLE,X		; Get bytes/character for this MODE
			sta	VDU_BPC				; Set bytes per character
			lda	_LC43A,X			; Get pixels/byte for this MODE
			sta	VDU_PIX_BYTE			; Set pixels per byte
			bne	_BCB56				; If non-zero, skip past
			lda	#$07				; byte/pixel=0, this is MODE 7, prepare A=7 offset into mask table

_BCB56:			asl					; A=A*2
			tay					; Y=A

			lda	_LC406,Y			; mask table
			sta	VDU_MASK_LEFT			; colour mask left
_BCB5E:			asl					; A=A*2
			bpl	_BCB5E				; If still +ve CB5E
			sta	VDU_MASK_RIGHT			; colour mask right
			ldy	_LC440,X			; screen display memory index table
			sty	VDU_MAP_TYPE			; memory map type
			lda	_LC44F,Y			; VDU section control
			jsr	_WRITE_SYS_VIA_PORTB		; set hardware scrolling to VIA
			lda	_LC44B,Y			; VDU section control
			jsr	_WRITE_SYS_VIA_PORTB		; set hardware scrolling to VIA
			lda	_VDU_MEMSZ_TAB,Y		; Screen RAM size hi byte table
			sta	VDU_MEM_PAGES			; screen RAM size hi byte
			lda	_VDU_MEMLOC_TAB,Y		; screen ram address hi byte
			sta	VDU_PAGE			; hi byte of screen RAM address
			tya					; Y=A
			adc	#$02				; Add 2
			eor	#$07				; 
			lsr					; /2
			tax					; X=A
			lda	_LC466,X			; row multiplication table pointer
			sta	VDU_ROW_MULT			; store it
			lda	#$c3				; A=&C3
			sta	VDU_ROW_MULT_HI			; store it (&E0) now points to C3B5 or C375
			lda	_LC463,X			; get nuber of bytes per row from table
			sta	VDU_BPR				; store as bytes per character row
			stx	VDU_BPR_HI			; bytes per character row
			lda	#$43				; A=&43
			jsr	_LC5A8				; A=A and &D0:&D0=A
			ldx	VDU_MODE			; screen mode
			lda	_ULA_SETTINGS,X			; get video ULA control setting
			jsr	_LEA00				; set video ULA using osbyte 154 code
			php					; push flags
			sei					; set interrupts
			ldx	_LC469,Y			; get cursor end register data from table
			ldy	#$0b				; Y=11

_BCBB0:			lda	_CRTC_REG_TAB,X			; get end of 6845 registers 0-11 table
			jsr	_LC95E				; set register Y
			dex					; reduce pointers
			dey					; 
			bpl	_BCBB0				; and if still >0 do it again

			plp					; pull flags
			jsr	_VDU_20				; set default colours
			jsr	_VDU_26				; set default windows

_LCBC1:			ldx	#$00				; X=0
			lda	VDU_PAGE			; hi byte of screen RAM address
			stx	VDU_MEM				; window area start address lo
			sta	VDU_MEM_HI			; window area start address hi
			jsr	_LC9F6				; use X and Y to set new cursor address
			ldy	#$0c				; Y=12
			jsr	_LCA2B				; set registers 12 and 13 in CRTC
			lda	VDU_T_BG			; background text colour
			ldx	VDU_MAP_TYPE			; memory map type
			ldy	_LC454,X			; get section control number
			sty	VDU_JUMPVEC			; set it in jump vector lo
			ldy	#$cc				; Y=&CC
			sty	VDU_JUMPVEC_HI			; upper byte of link address
			ldx	#$00				; X=0
			stx	OSB_HALT_LINES			; paged mode counter
			stx	VDU_T_CURS_X			; text column
			stx	VDU_T_CURS_Y			; current text line
			jmp	(VDU_JUMPVEC)			; jump vector set up previously to clear screen memory


;*************************************************************************
;*									 *
;*	 OSWORD 10 - READ CHARACTER DEFINITION				 *
;*									 *
;*************************************************************************
;&EF=A:&F0=X:&F1=Y, on entry YX contains character number to be read
;(&DE) points to address
;on exit byte YX+1 to YX+8 contain definition

_OSWORD_10:		jsr	_LD03E				; set up character definition pointers
			ldy	#$00				; Y=0
_BCBF8:			lda	(VDU_TMP5),Y			; get first byte
			iny					; Y=Y+1
			sta	(OSW_X),Y			; store it in YX
			cpy	#$08				; until Y=8
			bne	_BCBF8				; 
			rts					; then exit


;*************************************************************************
;*									 *
;*	 MAIN SCREEN CLEARANCE ROUTINE					 *
;*									 *
;*************************************************************************
;on entry A contains background colour which is set in every byte
;of the screen

;************************ Mode 0,1,2 entry point *************************

_VDU_CLEAR:		sta	$3000,X				; 
			sta	$3100,X				; 
			sta	$3200,X				; 
			sta	$3300,X				; 
			sta	$3400,X				; 
			sta	$3500,X				; 
			sta	$3600,X				; 
			sta	$3700,X				; 
			sta	$3800,X				; 
			sta	$3900,X				; 
			sta	$3a00,X				; 
			sta	$3b00,X				; 
			sta	$3c00,X				; 
			sta	$3d00,X				; 
			sta	$3e00,X				; 
			sta	$3f00,X				; 

;************************ Mode 3 entry point *****************************

			sta	$4000,X				; 
			sta	$4100,X				; 
			sta	$4200,X				; 
			sta	$4300,X				; 
			sta	$4400,X				; 
			sta	$4500,X				; 
			sta	$4600,X				; 
			sta	$4700,X				; 
			sta	$4800,X				; 
			sta	$4900,X				; 
			sta	$4a00,X				; 
			sta	$4b00,X				; 
			sta	$4c00,X				; 
			sta	$4d00,X				; 
			sta	$4e00,X				; 
			sta	$4f00,X				; 
			sta	$5000,X				; 
			sta	$5100,X				; 
			sta	$5200,X				; 
			sta	$5300,X				; 
			sta	$5400,X				; 
			sta	$5500,X				; 
			sta	$5600,X				; 
			sta	$5700,X				; 

;************************ Mode 4,5 entry point ***************************

			sta	$5800,X				; 
			sta	$5900,X				; 
			sta	$5a00,X				; 
			sta	$5b00,X				; 
			sta	$5c00,X				; 
			sta	$5d00,X				; 
			sta	$5e00,X				; 
			sta	$5f00,X				; 

;************************ Mode 6 entry point *****************************

			sta	$6000,X				; 
			sta	$6100,X				; 
			sta	$6200,X				; 
			sta	$6300,X				; 
			sta	$6400,X				; 
			sta	$6500,X				; 
			sta	$6600,X				; 
			sta	$6700,X				; 
			sta	$6800,X				; 
			sta	$6900,X				; 
			sta	$6a00,X				; 
			sta	$6b00,X				; 
			sta	$6c00,X				; 
			sta	$6d00,X				; 
			sta	$6e00,X				; 
			sta	$6f00,X				; 
			sta	$7000,X				; 
			sta	$7100,X				; 
			sta	$7200,X				; 
			sta	$7300,X				; 
			sta	$7400,X				; 
			sta	$7500,X				; 
			sta	$7600,X				; 
			sta	$7700,X				; 
			sta	$7800,X				; 
			sta	$7900,X				; 
			sta	$7a00,X				; 
			sta	$7b00,X				; 

;************************ Mode 7 entry point *****************************

			sta	$7c00,X				; 
			sta	$7d00,X				; 
			sta	$7e00,X				; 
			sta	$7f00,X				; 
			inx					; 
			beq	_BCD65				; exit

;****************** execute required function ****************************

_VDU_JUMP:		jmp	(VDU_JUMPVEC)			; jump vector set up previously

;********* subtract bytes per line from X/A ******************************

_LCCF8:			pha					; Push A
			txa					; A=X
			sec					; set carry for subtraction
			sbc	VDU_BPR				; bytes per character row
			tax					; restore X
			pla					; and A
			sbc	VDU_BPR_HI			; bytes per character row
			cmp	VDU_PAGE			; hi byte of screen RAM address
_BCD06:			rts					; return


;*************************************************************************
;*									 *
;*	 OSBYTE 20 - EXPLODE CHARACTERS					 *
;*									 *
;*************************************************************************

_OSBYTE_20:		lda	#$0f				; A=15
			sta	VDU_FONT_FLAGS			; font flag indicating that page &0C,&C0-&C2 are
								; used for user defined characters
			lda	#$0c				; A=&0C
			ldy	#$06				; set loop counter

_BCD10:			sta	VDU_FONTLOC_20,Y		; set all font location bytes
			dey					; to page &0C to indicate only page available
			bpl	_BCD10				; for user character definitions

			cpx	#$07				; is X= 7 or greater
			bcc	_BCD1C				; if not CD1C
			ldx	#$06				; else X=6
_BCD1C:			stx	OSB_CHAR_EXPL			; character definition explosion switch
			lda	OSB_OSHWM_DEF			; A=primary OSHWM
			ldx	#$00				; X=0

_BCD24:			cpx	OSB_CHAR_EXPL			; character definition explosion switch
			bcs	_BCD34				; 
			ldy	_LC4BA,X			; get soft character  RAM allocation
			sta	VDU_FONTLOC_20,Y		; font location bytes
			adc	#$01				; Add 1
			inx					; X=X+1
			bne	_BCD24				; if X<>0 then CD24

_BCD34:			sta	OSB_OSHWM_CUR			; current value of page (OSHWM)
			tay					; Y=A
			beq	_BCD06				; return via CD06 (ERROR?)

			ldx	#$11				; X=&11
			jmp	_OSBYTE_143			; issue paged ROM service call &11
								; font implosion/explosion warning

;******** move text cursor to next line **********************************

_LCD3F:			lda	#$02				; A=2 to check if scrolling disabled
			bit	VDU_STATUS			; VDU status byte
			bne	_BCD47				; if scrolling is barred CD47
			bvc	_BCD79				; if cursor editing mode disabled RETURN

_BCD47:			lda	VDU_T_WIN_B			; bottom margin
			bcc	_BCD4F				; if carry clear on entry CD4F
			lda	VDU_T_WIN_T			; else if carry set get top of text window
_BCD4F:			bvs	_BCD59				; and if cursor editing enabled CD59
			sta	VDU_T_CURS_Y			; get current text line
			pla					; pull return link from stack
			pla					; 
			jmp	_LC6AF				; set up cursor and display address

_BCD59:			php					; push flags
			cmp	VDU_TI_CURS_Y			; Y coordinate of text input cursor
			beq	_BCD78				; if A=line count of text input cursor CD78 to exit
			plp					; get back flags
			bcc	_BCD66				; 
			dec	VDU_TI_CURS_Y			; Y coordinate of text input cursor

_BCD65:			rts					; exit

_BCD66:			inc	VDU_TI_CURS_Y			; Y coordinate of text input cursor
			rts					; exit

;*********************** set up write cursor ********************************

_LCD6A:			php					; save flags
			pha					; save A
			ldy	VDU_BPC				; bytes per character
			dey					; Y=Y-1
			bne	_BCD8F				; if Y=0 Mode 7 is in use

			lda	VDU_WORKSPACE+8			; so get mode 7 write character cursor character &7F
			sta	(VDU_TOP_SCAN),Y		; store it at top scan line of current character
_LCD77:			pla					; pull A
_BCD78:			plp					; pull flags
_BCD79:			rts					; and exit

_LCD7A:			php					; push flags
			pha					; push A
			ldy	VDU_BPC				; bytes per character
			dey					; 
			bne	_BCD8F				; if not mode 7
			lda	(VDU_TOP_SCAN),Y		; get cursor from top scan line
			sta	VDU_WORKSPACE+8			; store it
			lda	VDU_TTX_CURSOR			; mode 7 write cursor character
			sta	(VDU_TOP_SCAN),Y		; store it at scan line
			jmp	_LCD77				; and exit

_BCD8F:			lda	#$ff				; A=&FF =cursor
			cpy	#$1f				; except in mode 2 (Y=&1F)
			bne	_BCD97				; if not CD97
			lda	#$3f				; load cursor byte mask

;********** produce white block write cursor *****************************

_BCD97:			sta	VDU_TMP1			; store it
_BCD99:			lda	(VDU_TOP_SCAN),Y		; get scan line byte
			eor	VDU_TMP1			; invert it
			sta	(VDU_TOP_SCAN),Y		; store it on scan line
			dey					; decrement scan line counter
			bpl	_BCD99				; do it again
			bmi	_LCD77				; then jump to &CD77

_LCDA4:			jsr	_LCE5B				; exchange line and column cursors with workspace copies
			lda	VDU_T_WIN_B			; bottom margin
			sta	VDU_T_CURS_Y			; current text line
			jsr	_LCF06				; set up display address
_BCDB0:			jsr	_LCCF8				; subtract bytes per character row from this
			bcs	_BCDB8				; wraparound if necessary
			adc	VDU_MEM_PAGES			; screen RAM size hi byte
_BCDB8:			sta	VDU_TMP2			; store A
			stx	VDU_TMP1			; X
			sta	VDU_TMP3			; A again
			bcs	_BCDC6				; if C set there was no wraparound so CDC6
_BCDC0:			jsr	_LCE73				; copy line to new position
								; using (&DA) for read
								; and (&D8) for write
			jmp	_LCDCE				; 

_BCDC6:			jsr	_LCCF8				; subtract bytes per character row from X/A
			bcc	_BCDC0				; if a result is outside screen RAM CDC0
			jsr	_LCE38				; perform a copy

_LCDCE:			lda	VDU_TMP3			; set write pointer from read pointer
			ldx	VDU_TMP1			; 
			sta	VDU_TOP_SCAN_HI			; 
			stx	VDU_TOP_SCAN			; 
			dec	VDU_TMP5			; decrement window height
			bne	_BCDB0				; and if not zero CDB0
_LCDDA:			ldx	#$28				; point to workspace
			ldy	#$18				; point to text column/line
_LCDDE:			lda	#$02				; number of bytes to swap
			bne	_BCDE8				; exchange (328/9)+Y with (318/9)+X
_LCDE2:			ldx	#$24				; point to graphics cursor
_LCDE4:			ldy	#$14				; point to last graphics cursor
								; A=4 to swap X and Y coordinates

;*************** exchange 300/3+Y with 300/3+X ***************************

_LCDE6:			lda	#$04				; A =4

;************** exchange (300/300+A)+Y with (300/300+A)+X *****************

_BCDE8:			sta	VDU_TMP1			; store it as loop counter

_BCDEA:			lda	VDU_G_WIN_L,X			; get byte
			pha					; store it
			lda	VDU_G_WIN_L,Y			; get byte pointed to by Y
			sta	VDU_G_WIN_L,X			; put it in 300+X
			pla					; get back A
			sta	VDU_G_WIN_L,Y			; put it in 300+Y
			inx					; increment pointers
			iny					; 
			dec	VDU_TMP1			; decrement loop counter
			bne	_BCDEA				; and if not 0 do it again
			rts					; and exit

