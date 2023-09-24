;************ Keyboard Input and housekeeping ************************
				; entered from &F00C

			.org	$eeda

_LEEDA:			ldx	#$ff				; 
			lda	KEYNUM_FIRST			; get value of most recently pressed key
			ora	KEYNUM_LAST			; Or it with previous key to check for presses
			bne	_BEEE8				; if A=0 no keys pressed so off you go
			lda	#$81				; else enable keybd interupt only by writing bit 7
			sta	SYS_VIA_IER			; and bit 0 of system VIA interupt register
			inx					; set X=0
_BEEE8:			stx	OSB_KEY_SEM			; reset keyboard semaphore

;**********: Turn on Keyboard indicators *******************************
_SET_LEDS:		php					; save flags
			lda	OSB_KEY_STATUS			; read keyboard status;
								; Bit 7	 =1 shift enabled
								; Bit 6	 =1 control pressed
								; bit 5	 =0 shift lock
								; Bit 4	 =0 Caps lock
								; Bit 3	 =1 shift pressed
			lsr					; shift Caps bit into bit 3
			and	#$18				; mask out all but 4 and 3
			ora	#$06				; returns 6 if caps lock OFF &E if on
			sta	SYS_VIA_IORB			; turn on or off caps light if required
			lsr					; bring shift bit into bit 3
			ora	#$07				; 
			sta	SYS_VIA_IORB			; turn on or off shift	lock light
			jsr	_LF12E				; set keyboard counter
			pla					; get back flags
			rts					; return


;*************************************************************************
;*									 *
;* MAIN KEYBOARD HANDLING ROUTINE   ENTRY FROM KEYV			 *
;* ==========================================================		 *
;*									 *
;*			 ENTRY CONDITIONS				 *
;*			 ================				 *
;* C=0, V=0 Test Shift and CTRL keys.. exit with N set if CTRL pressed	 *
;*				   ........with V set if Shift pressed	 *
;*									 *
;* C=1, V=0 Scan Keyboard as OSBYTE &79					 *
;*									 *
;* C=0, V=1 Key pressed interrupt entry					 *
;*									 *
;* C=1, V=1 Timer interrupt entry					 *
;*									 *
;*************************************************************************

_KEYV:			bvc	_BEF0E				; if V is clear then leave interrupt routine
			lda	#$01				; disable keyboard interrupts
			sta	SYS_VIA_IER			; by writing to VIA interrupt vector
			bcs	_BEF13				; if timer interrupt then EF13
			jmp	_KEYBOARD_IRQ			; else to F00F

_BEF0E:			bcc	_BEF16				; if test SHFT & CTRL goto EF16
			jmp	_LF0D1				; else to F0D1
								; to scan keyboard
;*************************************************************************
;*	 Timer interrupt entry						 *
;*************************************************************************

_BEF13:			inc	OSB_KEY_SEM			; increment keyboard semaphore (to 0)


;*************************************************************************
;*	 Test Shift and Control Keys entry				 *
;*************************************************************************

_BEF16:			lda	OSB_KEY_STATUS			; read keyboard status;
								; Bit 7	 =1 shift enabled
								; Bit 6	 =1 control pressed
								; bit 5	 =0 shift lock
								; Bit 4	 =0 Caps lock
								; Bit 3	 =1 shift pressed
			and	#$b7				; zero bits 3 and 6
			ldx	#$00				; zero X to test for shift key press
			jsr	_KEYBOARD_SCAN			; interrogate keyboard X=&80 if key determined by
								; X on entry is pressed
			stx	MOS_WS_0			; save X
			clv					; clear V
			bpl	_BEF2A				; if no key press (X=0) then EF2A else
			bit	_BD9B7				; set M and V
			ora	#$08				; set bit 3 to indicate Shift was pressed
_BEF2A:			inx					; check the control key
			jsr	_KEYBOARD_SCAN			; via keyboard interrogate
			bcc	_SET_LEDS			; if carry clear (entry via EF16) then off to EEEB
								; to turn on keyboard lights as required
			bpl	_BEF34				; if key not pressed goto EF30
			ora	#$40				; or set CTRL pressed bit in keyboard status byte in A
_BEF34:			sta	OSB_KEY_STATUS			; save status byte
			ldx	KEYNUM_FIRST			; if no key previously pressed
			beq	_BEF4D				; then EF4D
			jsr	_KEYBOARD_SCAN			; else check to see if key still pressed
			bmi	_BEF50				; if so enter repeat routine at EF50
			cpx	KEYNUM_FIRST			; else compare X with last key pressed (set flags)
_BEF42:			stx	KEYNUM_FIRST			; store X in last key pressed
			bne	_BEF4D				; if different from previous (Z clear) then EF4D
			ldx	#$00				; else zero
			stx	KEYNUM_FIRST			; last key pressed
_BEF4A:			jsr	_LF01F				; and reset repeat system
_BEF4D:			jmp	_LEFE9				; 

;********** REPEAT ACTION *************************************************

_BEF50:			cpx	KEYNUM_FIRST			; if X<>than last key pressed
			bne	_BEF42				; then back to EF42
			lda	AUTO_REPEAT_TIMER		; else get value of AUTO REPEAT COUNTDOWN TIMER
			beq	_BEF7B				; if 0 goto EF7B
			dec	AUTO_REPEAT_TIMER		; else decrement
			bne	_BEF7B				; and if not 0 goto EF7B
								; this means that either the repeat system is dormant
								; or it is not at the end of its count
			lda	KEY_REPEAT_CNT			; next value for countdown timer
			sta	AUTO_REPEAT_TIMER		; store it
			lda	OSB_KEY_REPEAT			; get auto repeat rate from 0255
			sta	KEY_REPEAT_CNT			; store it as next value for Countdown timer
			lda	OSB_KEY_STATUS			; get keyboard status
			ldx	KEYNUM_FIRST			; get last key pressed
			cpx	#$d0				; if not SHIFT LOCK key (&D0) goto
			bne	_BEF7E				; EF7E
			ora	#$90				; sets shift enabled, & no caps lock all else preserved
			eor	#$a0				; reverses shift lock disables Caps lock and Shift enab
_LEF74:			sta	OSB_KEY_STATUS			; reset keyboard status
			lda	#$00				; and set timer
			sta	AUTO_REPEAT_TIMER		; to 0
_BEF7B:			jmp	_LEFE9				; 

_BEF7E:			cpx	#$c0				; if not CAPS LOCK
			bne	_BEF91				; goto EF91
			ora	#$a0				; sets shift enabled and disables SHIFT LOCK
			bit	MOS_WS_0			; if bit 7 not set by (EF20) shift NOT pressed
			bpl	_BEF8C				; goto EF8C
			ora	#$10				; else set CAPS LOCK not enabled
			eor	#$80				; reverse SHIFT enabled

_BEF8C:			eor	#$90				; reverse both SHIFT enabled and CAPs Lock
			jmp	_LEF74				; reset keyboard status and set timer

;*********** get ASCII code *********************************************
				; on entry X=key pressed internal number

_BEF91:			lda	_LEFAB,X			; get code from look up table
			bne	_BEF99				; if not zero goto EF99 else TAB pressed
			lda	OSB_TAB				; get TAB character

_BEF99:			ldx	OSB_KEY_STATUS			; get keyboard status
			stx	MOS_WS_0			; store it in &FA
			rol	MOS_WS_0			; rotate to get CTRL pressed into bit 7
			bpl	_BEFA9				; if CTRL NOT pressed EFA9

			ldx	KEYNUM_LAST			; get no. of previously pressed key
_BEFA4:			bne	_BEF4A				; if not 0 goto EF4A to reset repeat system etc.
			jsr	_LEABF				; else perform code changes for CTRL

_BEFA9:			rol	MOS_WS_0			; move shift lock into bit 7
_LEFAB:			bmi	_BEFB5				; if not effective goto EFB5 else
			jsr	_LEA9C				; make code changes for SHIFT

			rol	MOS_WS_0			; move CAPS LOCK into bit 7
			jmp	_LEFC1				; and Jump to EFC1

_BEFB5:			rol	MOS_WS_0			; move CAPS LOCK into bit 7
			bmi	_BEFC6				; if not effective goto EFC6
			jsr	_LE4E3				; else make changes for CAPS LOCK on, return with
								; C clear for Alphabetic codes
			bcs	_BEFC6				; if carry set goto EFC6 else make changes for
			jsr	_LEA9C				; SHIFT as above

_LEFC1:			ldx	OSB_KEY_STATUS			; if shift enabled bit is clear
			bpl	_BEFD1				; goto EFD1
_BEFC6:			rol	MOS_WS_0			; else get shift bit into 7
			bpl	_BEFD1				; if not set goto EFD1
			ldx	KEYNUM_LAST			; get previous key press
			bne	_BEFA4				; if not 0 reset repeat system etc. via EFA4
			jsr	_LEA9C				; else make code changes for SHIFT
_BEFD1:			cmp	OSB_ESCAPE			; if A<> ESCAPE code
			bne	_BEFDD				; goto EFDD
			ldx	OSB_ESC_ACTION			; get Escape key status
			bne	_BEFDD				; if ESCAPE returns ASCII code goto EFDD
			stx	AUTO_REPEAT_TIMER		; store in Auto repeat countdown timer

_BEFDD:			tay					; 
			jsr	_LF129				; disable keyboard
			lda	OSB_KEY_DISABLE			; read Keyboard disable flag used by Econet
			bne	_LEFE9				; if keyboard locked goto EFE9
			jsr	_LE4F1				; put character in input buffer
_LEFE9:			ldx	KEYNUM_LAST			; get previous keypress
			beq	_BEFF8				; if none  EFF8
			jsr	_KEYBOARD_SCAN			; examine to see if key still pressed
			stx	KEYNUM_LAST			; store result
			bmi	_BEFF8				; if pressed goto EFF8
			ldx	#$00				; else zero X
			stx	KEYNUM_LAST			; and &ED

_BEFF8:			ldx	KEYNUM_LAST			; get &ED
			bne	_BF012				; if not 0 goto F012
			ldy	#$ec				; get first keypress into Y
			jsr	_LF0CC				; scan keyboard from &10 (osbyte 122)

			bmi	_BF00C				; if exit is negative goto F00C
			lda	KEYNUM_FIRST			; else make last key the
			sta	KEYNUM_LAST			; first key pressed i.e. rollover

_BF007:			stx	KEYNUM_FIRST			; save X into &EC
			jsr	_LF01F				; set keyboard repeat delay
_BF00C:			jmp	_LEEDA				; go back to EEDA


;*************************************************************************
;*   Key pressed interrupt entry point					 *
;*************************************************************************
				; enters with X=key
_KEYBOARD_IRQ:		jsr	_KEYBOARD_SCAN			; check if key pressed

_BF012:			lda	KEYNUM_FIRST			; get previous key press
			bne	_BF00C				; if none back to housekeeping routine
			ldy	#$ed				; get last keypress into Y
			jsr	_LF0CC				; and scan keyboard
			bmi	_BF00C				; if negative on exit back to housekeeping
			bpl	_BF007				; else back to store X and reset keyboard delay etc.

;**************** Set Autorepeat countdown timer **************************

_LF01F:			ldx	#$01				; set timer to 1
			stx	AUTO_REPEAT_TIMER		; 
			ldx	OSB_KEY_DELAY			; get next timer value
			stx	KEY_REPEAT_CNT			; and store it
			rts					; 

;*************** Interrogate Keyboard routine ***********************
				;
_KEYBOARD_SCAN:		ldy	#$03				; stop Auto scan
			sty	SYS_VIA_IORB			; by writing to system VIA
			ldy	#$7f				; set bits 0 to 6 of port A to input on bit 7
								; output on bits 0 to 6
			sty	SYS_VIA_DDRA			; 
			stx	SYS_VIA_IORB_NH			; write X to Port A system VIA
			ldx	SYS_VIA_IORB_NH			; read back &80 if key pressed (M set)
			rts					; and return


;*************************************************************************
;*									 *
;*	 KEY TRANSLATION TABLES						 *
;*									 *
;*	 7 BLOCKS interspersed with unrelated code			 *
;*************************************************************************

; key data block 1

_KEY_TRANS_TABLE_1:	.byte	$71,$33,$34,$35,$84,$38,$87,$2d,$5e,$8c
								; q ,3 ,4 ,5 ,f4,8 ,f7,- ,^ ,rt


;*************************************************************************
;*									 *
;*	 OSBYTE 120  Write KEY pressed Data				 *
;*									 *
;*************************************************************************

_OSBYTE_120:		sty	KEYNUM_FIRST			; store Y as latest key pressed
			stx	KEYNUM_LAST			; store X as previous key pressed
			rts					; and exit
			brk					

; key data block 2

_KEY_TRANS_TABLE_2:	.byte	$80,$77,$65,$74,$37,$69,$39,$30,$5f,$8e
								; f0,w ,e ,t ,7 ,i ,9 ,0 ,_ ,lft

_LF055:			jmp	($fdfe)				; Jim paged entry vector
_LF058:			jmp	(MOS_WS_0)			; 

; key data block 3

_KEY_TRANS_TABLE_3:	.byte	$31,$32,$64,$72,$36,$75,$6f,$70,$5b,$8f
								; 1 ,2 ,d ,r ,6 ,u ,o ,p ,[ ,dn


;*************************************************************************
;*									 *
;* Main entry to keyboard routines					 *
;*									 *
;*************************************************************************

_LF065:			bit	_BD9B7				; set V and M
_LF068:			jmp	(VEC_KEYV)			; i.e. KEYV

; key data block 4

_KEY_TRANS_TABLE_4:	.byte	$01,$61,$78,$66,$79,$6a,$6b,$40,$3a,$0d
								; CL,a ,x ,f ,y ,j ,k ,@ ,: ,RETN  N.B CL=CAPS LOCK

; speech routine data
_SPEECH_DATA:		.byte	$00,$ff				
			.byte	$01,$02				
			.byte	$09,$0a				

; key data block 5

_KEY_TRANS_TABLE_5:	.byte	$02,$73,$63,$67,$68,$6e,$6c,$3b,$5d,$7f
								; SL,s ,c ,g ,h ,n ,l ,; ,] ,DEL N.B. SL=SHIFT LOCK


;*************************************************************************
;*									 *
;*	 OSBYTE 131  READ OSHWM	 (PAGE in BASIC)			 *
;*									 *
;*************************************************************************

_OSBYTE_131:		ldy	OSB_OSHWM_CUR			; read current OSHWM
			ldx	#$00				; 
			rts					; 

; key data block 6

_KEY_TRANS_TABLE_7:	.byte	$00,$7a,$20,$76,$62,$6d,$2c,$2e,$2f,$8b
								; TAB,Z ,SPACE,V ,b ,m ,, ,. ,/ ,copy

;***** set input buffer number and flush it *****************************

_BF095:			ldx	OSB_IN_STREAM			; get current input buffer
_BF098:			jmp	_LE1AD				; flush it

; key data block 7

_KEY_TRANS_TABLE_8:	.byte	$1b,$81,$82,$83,$85,$86,$88,$89,$5c,$8d
								; ESC,f1,f2,f3,f5,f6,f8,f9,\ ,

_LF0A5:			jmp	(VEC_EVNTV)			; goto eventV handling routine


;*************************************************************************
;*									 *
;*	 OSBYTE 15  FLUSH SELECTED BUFFER CLASS				 *
;*									 *
;*************************************************************************

				; flush selected buffer
				; X=0 flush all buffers
				; X>1 flush input buffer

_OSBYTE_15:		bne	_BF095				; if X<>1 flush input buffer only
_LF0AA:			ldx	#$08				; else load highest buffer number (8)
_BF0AC:			cli					; allow interrupts
			sei					; briefly!
			jsr	_OSBYTE_21			; flush buffer
			dex					; decrement X to point at next buffer
			bpl	_BF0AC				; if X>=0 flush next buffer
								; at this point X=255


;*************************************************************************
;*									 *
;*	 OSBYTE 21  FLUSH SPECIFIC BUFFER				 *
;*									 *
;*************************************************************************
;on entry X=buffer number

_OSBYTE_21:		cpx	#$09				; is X<9?
			bcc	_BF098				; if so flush buffer or else
			rts					; exit

;*************************************************************************
;*									 *
;*		 Issue *HELP to ROMS					 *
;*									 *
;*************************************************************************
_OSCLI_HELP:		ldx	#$09				; 
			jsr	_OSBYTE_143			; 
			jsr	_PRINT_MSG			; print following message routine return after BRK
			.byte	$0d				; carriage return
			.byte	"OS 1.20"			; help message
			.byte	$0d				; carriage return
			brk					; 
			rts					; 

;*************************************************************************
;*									 *
;*	 OSBYTE 122  KEYBOARD SCAN FROM &10 (16)			 *
;*									 *
;*************************************************************************

_LF0CC:			clc					; clear carry
_OSBYTE_122:		ldx	#$10				; set X to 10


;*************************************************************************
;*									 *
;*	 OSBYTE 121  KEYBOARD SCAN FROM VALUE IN X			 *
;*									 *
;*************************************************************************

_OSBYTE_121:		bcs	_LF068				; if carry set (by osbyte 121) F068
								; Jmps via KEYV and hence back to;


;*************************************************************************
;*	  Scan Keyboard C=1, V=0 entry via KEYV				 *
;*************************************************************************

_LF0D1:			txa					; if X is +ve goto F0D9
			bpl	_BF0D9				; 
			jsr	_KEYBOARD_SCAN			; else interrogate keyboard
			bcs	_LF12E				; if carry set F12E to set Auto scan else
_BF0D9:			php					; push flags
			bcc	_BF0DE				; if carry clear goto FODE else
			ldy	#$ee				; set Y so next operation saves to 2cd
_BF0DE:			sta	$01df,Y				; can be 2cb,2cc or 2cd
			ldx	#$09				; set X to 9
_BF0E3:			jsr	_LF129				; select auto scan
			lda	#$7f				; set port A for input on bit 7 others outputs
			sta	SYS_VIA_DDRA			; 
			lda	#$03				; stop auto scan
			sta	SYS_VIA_IORB			; 
			lda	#$0f				; select non-existent keyboard column F (0-9 only!)
			sta	SYS_VIA_IORB_NH			; 
			lda	#$01				; cancel keyboard interrupt
			sta	SYS_VIA_IFR			; 
			stx	SYS_VIA_IORB_NH			; select column X (9 max)
			bit	SYS_VIA_IFR			; if bit 1 =0 there is no keyboard interrupt so
			beq	_BF123				; goto F123
			txa					; else put column address in A

_BF103:			cmp	$01df,Y				; compare with 1DF+Y
			bcc	_BF11E				; if less then F11E
			sta	SYS_VIA_IORB_NH			; else select column again
			bit	SYS_VIA_IORB_NH			; and if bit 7 is 0
			bpl	_BF11E				; then F11E
			plp					; else push and pull flags
			php					; 
			bcs	_BF127				; and if carry set goto F127
			pha					; else Push A
			eor	$0000,Y				; EOR with EC,ED, or EE depending on Y value
			asl					; shift left
			cmp	#$01				; set carry if = or greater than number holds EC,ED,EE
			pla					; get back A
			bcs	_BF127				; if carry set F127
_BF11E:			clc					; else clear carry
			adc	#$10				; add 16
			bpl	_BF103				; and do it again if 0=<result<128
_BF123:			dex					; decrement X
			bpl	_BF0E3				; scan again if greater than 0
			txa					; 
_BF127:			tax					; 
			plp					; pull flags

_LF129:			jsr	_LF12E				; call autoscan
			cli					; allow interrupts
			sei					; disable interrupts

;*************Enable counter scan of keyboard columns *******************
				; called from &EEFD, &F129

_LF12E:			lda	#$0b				; select auto scan of keyboard
			sta	SYS_VIA_IORB			; tell VIA
			txa					; Get A into X
			rts					; and return


