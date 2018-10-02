;************ Keyboard Input and housekeeping ************************
		; entered from &F00C

.org		$eeda

		ldx	#$FF		; 
		lda	$EC		; get value of most recently pressed key
		ora	$ED		; Or it with previous key to check for presses
		bne	$EEE8		; if A=0 no keys pressed so off you go
		lda	#$81		; else enable keybd interupt only by writing bit 7
		sta	$FE4E		; and bit 0 of system VIA interupt register
		inx			; set X=0
		stx	$0242		; reset keyboard semaphore

;**********: Turn on Keyboard indicators *******************************
		php			; save flags
		lda	$025A		; read keyboard status;
					; Bit 7  =1 shift enabled
					; Bit 6  =1 control pressed
					; bit 5  =0 shift lock
					; Bit 4  =0 Caps lock
					; Bit 3  =1 shift pressed
		lsr			; shift Caps bit into bit 3
		and	#$18		; mask out all but 4 and 3
		ora	#$06		; returns 6 if caps lock OFF &E if on
		sta	$FE40		; turn on or off caps light if required
		lsr			; bring shift bit into bit 3
		ora	#$07		; 
		sta	$FE40		; turn on or off shift  lock light
		jsr	$F12E		; set keyboard counter
		pla			; get back flags
		rts			; return


;*************************************************************************
;*                                                                       *
;* MAIN KEYBOARD HANDLING ROUTINE   ENTRY FROM KEYV                      *
;* ==========================================================            *
;*                                                                       *
;*                       ENTRY CONDITIONS                                *
;*                       ================                                *
;* C=0, V=0 Test Shift and CTRL keys.. exit with N set if CTRL pressed   *
;*                                 ........with V set if Shift pressed   *
;*                                                                       *
;* C=1, V=0 Scan Keyboard as OSBYTE &79                                  *
;*                                                                       *
;* C=0, V=1 Key pressed interrupt entry                                  *
;*                                                                       *
;* C=1, V=1 Timer interrupt entry                                        *
;*                                                                       *
;*************************************************************************

		bvc	$EF0E		; if V is clear then leave interrupt routine
		lda	#$01		; disable keyboard interrupts
		sta	$FE4E		; by writing to VIA interrupt vector
		bcs	$EF13		; if timer interrupt then EF13
		jmp	$F00F		; else to F00F

		bcc	$EF16		; if test SHFT & CTRL goto EF16
		jmp	$F0D1		; else to F0D1
					; to scan keyboard
;*************************************************************************
;*       Timer interrupt entry                                           *
;*************************************************************************

		inc	$0242		; increment keyboard semaphore (to 0)


;*************************************************************************
;*       Test Shift and Control Keys entry                               *
;*************************************************************************

		lda	$025A		; read keyboard status;
					; Bit 7  =1 shift enabled
					; Bit 6  =1 control pressed
					; bit 5  =0 shift lock
					; Bit 4  =0 Caps lock
					; Bit 3  =1 shift pressed
		and	#$B7		; zero bits 3 and 6
		ldx	#$00		; zero X to test for shift key press
		jsr	$F02A		; interrogate keyboard X=&80 if key determined by
					; X on entry is pressed
		stx	$FA		; save X
		clv			; clear V
		bpl	$EF2A		; if no key press (X=0) then EF2A else
		bit	$D9B7		; set M and V
		ora	#$08		; set bit 3 to indicate Shift was pressed
		inx			; check the control key
		jsr	$F02A		; via keyboard interrogate
		bcc	$EEEB		; if carry clear (entry via EF16) then off to EEEB
					; to turn on keyboard lights as required
		bpl	$EF34		; if key not pressed goto EF30
		ora	#$40		; or set CTRL pressed bit in keyboard status byte in A
		sta	$025A		; save status byte
		ldx	$EC		; if no key previously pressed
		beq	$EF4D		; then EF4D
		jsr	$F02A		; else check to see if key still pressed
		bmi	$EF50		; if so enter repeat routine at EF50
		cpx	$EC		; else compare X with last key pressed (set flags)
		stx	$EC		; store X in last key pressed
		bne	$EF4D		; if different from previous (Z clear) then EF4D
		ldx	#$00		; else zero
		stx	$EC		; last key pressed
		jsr	$F01F		; and reset repeat system
		jmp	$EFE9		; 

;********** REPEAT ACTION *************************************************

		cpx	$EC		; if X<>than last key pressed
		bne	$EF42		; then back to EF42
		lda	$E7		; else get value of AUTO REPEAT COUNTDOWN TIMER
		beq	$EF7B		; if 0 goto EF7B
		dec	$E7		; else decrement
		bne	$EF7B		; and if not 0 goto EF7B
					; this means that either the repeat system is dormant
					; or it is not at the end of its count
		lda	$02CA		; next value for countdown timer
		sta	$E7		; store it
		lda	$0255		; get auto repeat rate from 0255
		sta	$02CA		; store it as next value for Countdown timer
		lda	$025A		; get keyboard status
		ldx	$EC		; get last key pressed
		cpx	#$D0		; if not SHIFT LOCK key (&D0) goto
		bne	$EF7E		; EF7E
		ora	#$90		; sets shift enabled, & no caps lock all else preserved
		eor	#$A0		; reverses shift lock disables Caps lock and Shift enab
		sta	$025A		; reset keyboard status
		lda	#$00		; and set timer
		sta	$E7		; to 0
		jmp	$EFE9		; 

		cpx	#$C0		; if not CAPS LOCK
		bne	$EF91		; goto EF91
		ora	#$A0		; sets shift enabled and disables SHIFT LOCK
		bit	$FA		; if bit 7 not set by (EF20) shift NOT pressed
		bpl	$EF8C		; goto EF8C
		ora	#$10		; else set CAPS LOCK not enabled
		eor	#$80		; reverse SHIFT enabled

		eor	#$90		; reverse both SHIFT enabled and CAPs Lock
		jmp	$EF74		; reset keyboard status and set timer

;*********** get ASCII code *********************************************
		; on entry X=key pressed internal number

		lda	$EFAB,X		; get code from look up table
		bne	$EF99		; if not zero goto EF99 else TAB pressed
		lda	$026B		; get TAB character

		ldx	$025A		; get keyboard status
		stx	$FA		; store it in &FA
		rol	$FA		; rotate to get CTRL pressed into bit 7
		bpl	$EFA9		; if CTRL NOT pressed EFA9

		ldx	$ED		; get no. of previously pressed key
		bne	$EF4A		; if not 0 goto EF4A to reset repeat system etc.
		jsr	$EABF		; else perform code changes for CTRL

		rol	$FA		; move shift lock into bit 7
		bmi	$EFB5		; if not effective goto EFB5 else
		jsr	$EA9C		; make code changes for SHIFT

		rol	$FA		; move CAPS LOCK into bit 7
		jmp	$EFC1		; and Jump to EFC1

		rol	$FA		; move CAPS LOCK into bit 7
		bmi	$EFC6		; if not effective goto EFC6
		jsr	$E4E3		; else make changes for CAPS LOCK on, return with
					; C clear for Alphabetic codes
		bcs	$EFC6		; if carry set goto EFC6 else make changes for
		jsr	$EA9C		; SHIFT as above

		ldx	$025A		; if shift enabled bit is clear
		bpl	$EFD1		; goto EFD1
		rol	$FA		; else get shift bit into 7
		bpl	$EFD1		; if not set goto EFD1
;; duplicate line EFC8	BPL &EFD1   ;if not set goto EFD1
		ldx	$ED		; get previous key press
		bne	$EFA4		; if not 0 reset repeat system etc. via EFA4
		jsr	$EA9C		; else make code changes for SHIFT
		cmp	$026C		; if A<> ESCAPE code
		bne	$EFDD		; goto EFDD
		ldx	$0275		; get Escape key status
		bne	$EFDD		; if ESCAPE returns ASCII code goto EFDD
		stx	$E7		; store in Auto repeat countdown timer

		tay			; 
		jsr	$F129		; disable keyboard
		lda	$0259		; read Keyboard disable flag used by Econet
		bne	$EFE9		; if keyboard locked goto EFE9
		jsr	$E4F1		; put character in input buffer
		ldx	$ED		; get previous keypress
		beq	$EFF8		; if none  EFF8
		jsr	$F02A		; examine to see if key still pressed
		stx	$ED		; store result
		bmi	$EFF8		; if pressed goto EFF8
		ldx	#$00		; else zero X
		stx	$ED		; and &ED

		ldx	$ED		; get &ED
		bne	$F012		; if not 0 goto F012
		ldy	#$EC		; get first keypress into Y
		jsr	$F0CC		; scan keyboard from &10 (osbyte 122)

		bmi	$F00C		; if exit is negative goto F00C
		lda	$EC		; else make last key the
		sta	$ED		; first key pressed i.e. rollover

		stx	$EC		; save X into &EC
		jsr	$F01F		; set keyboard repeat delay
		jmp	$EEDA		; go back to EEDA


;*************************************************************************
;*   Key pressed interrupt entry point                                   *
;*************************************************************************
		; enters with X=key
		jsr	$F02A		; check if key pressed

		lda	$EC		; get previous key press
		bne	$F00C		; if none back to housekeeping routine
		ldy	#$ED		; get last keypress into Y
		jsr	$F0CC		; and scan keyboard
		bmi	$F00C		; if negative on exit back to housekeeping
		bpl	$F007		; else back to store X and reset keyboard delay etc.

;**************** Set Autorepeat countdown timer **************************

		ldx	#$01		; set timer to 1
		stx	$E7		; 
		ldx	$0254		; get next timer value
		stx	$02CA		; and store it
		rts			; 

;*************** Interrogate Keyboard routine ***********************
		; 
		ldy	#$03		; stop Auto scan
		sty	$FE40		; by writing to system VIA
		ldy	#$7F		; set bits 0 to 6 of port A to input on bit 7
					; output on bits 0 to 6
		sty	$FE43		; 
		stx	$FE4F		; write X to Port A system VIA
		ldx	$FE4F		; read back &80 if key pressed (M set)
		rts			; and return


;*************************************************************************
;*                                                                       *
;*       KEY TRANSLATION TABLES                                          *
;*                                                                       *
;*       7 BLOCKS interspersed with unrelated code                       *
;*************************************************************************

; ### key data block 1

		.byte	$71,$33,$34,$35,$84,$38,$87,$2d,$5e,$8c
					;        q ,3 ,4 ,5 ,f4,8 ,f7,- ,^ ,rt


;*************************************************************************
;*                                                                       *
;*       OSBYTE 120  Write KEY pressed Data                              *
;*                                                                       *
;*************************************************************************

		sty	$EC		; store Y as latest key pressed
		stx	$ED		; store X as previous key pressed
		rts			; and exit

; ### key data block 2

;; missing NUL byte was here

		.byte	0,$80,$77,$65,$74,$37,$69,$39,$30,$5f,$8e
					;        f0,w ,e ,t ,7 ,i ,9 ,0 ,_ ,lft

		jmp	($FDFE)		; Jim paged entry vector
		jmp	($FA)		; 

; ### key data block 3

		.byte	$31,$32,$64,$72,$36,$75,$6f,$70,$5b,$8f
					;        1 ,2 ,d ,r ,6 ,u ,o ,p ,[ ,dn


;*************************************************************************
;*                                                                       *
;* Main entry to keyboard routines                                       *
;*                                                                       *
;*************************************************************************

		bit	$D9B7		; set V and M
		jmp	($0228)		; i.e. KEYV

; ### key data block 4

		.byte	$01,$61,$78,$66,$79,$6a,$6b,$40,$3a,$0d
					;        CL,a ,x ,f ,y ,j ,k ,@ ,: ,RETN  N.B CL=CAPS LOCK

; ### speech routine data
		.byte	$00,$ff,$01,$02,$09,$0a

; ### key data block 5

		.byte	$02,$73,$63,$67,$68,$6e,$6c,$3b,$5d,$7f
					;        SL,s ,c ,g ,h ,n ,l ,; ,] ,DEL N.B. SL=SHIFT LOCK


;*************************************************************************
;*                                                                       *
;*       OSBYTE 131  READ OSHWM  (PAGE in BASIC)                         *
;*                                                                       *
;*************************************************************************

		ldy	$0244		; read current OSHWM
		ldx	#$00		; 
		rts			; 

; ### key data block 6

		.byte	$00,$7a,$20,$76,$62,$6d,$2c,$2e,$2f,$8b
					;                TAB,Z ,SPACE,V ,b ,m ,, ,. ,/ ,copy

;***** set input buffer number and flush it *****************************

		ldx	$0241		; get current input buffer
		jmp	$E1AD		; flush it

; ### key data block 7

		.byte	$1b,$81,$82,$83,$85,$86,$88,$89,$5c,$8d
					;       ESC,f1,f2,f3,f5,f6,f8,f9,\ ,

		jmp	($0220)		; goto eventV handling routine


;*************************************************************************
;*                                                                       *
;*       OSBYTE 15  FLUSH SELECTED BUFFER CLASS                          *
;*                                                                       *
;*************************************************************************

		; flush selected buffer
		; X=0 flush all buffers
		; X>1 flush input buffer

		bne	$F095		; if X<>1 flush input buffer only
		ldx	#$08		; else load highest buffer number (8)
		cli			; allow interrupts
		sei			; briefly!
		jsr	$F0B4		; flush buffer
		dex			; decrement X to point at next buffer
		bpl	$F0AC		; if X>=0 flush next buffer
					; at this point X=255


;*************************************************************************
;*                                                                       *
;*       OSBYTE 21  FLUSH SPECIFIC BUFFER                                *
;*                                                                       *
;*************************************************************************
;on entry X=buffer number

		cpx	#$09		; is X<9?
		bcc	$F098		; if so flush buffer or else
		rts			; exit

;*************************************************************************
;*                                                                       *
;*               Issue *HELP to ROMS                                     *
;*                                                                       *
;*************************************************************************
		ldx	#$09		; 
		jsr	$F168		; 
		jsr	$FA4A		; print following message routine return after BRK
		.byte	$0D		; carriage return
		.byte	"OS 1.20"		; help message
		.byte	$0D		; carriage return
		brk			; 
		rts			; 

;*************************************************************************
;*                                                                       *
;*       OSBYTE 122  KEYBOARD SCAN FROM &10 (16)                         *
;*                                                                       *
;*************************************************************************

		clc			; clear carry
		ldx	#$10		; set X to 10


;*************************************************************************
;*                                                                       *
;*       OSBYTE 121  KEYBOARD SCAN FROM VALUE IN X                       *
;*                                                                       *
;*************************************************************************

		bcs	$F068		; if carry set (by osbyte 121) F068
					; Jmps via KEYV and hence back to;


;*************************************************************************
;*        Scan Keyboard C=1, V=0 entry via KEYV                          *
;*************************************************************************

		txa			; if X is +ve goto F0D9
		bpl	$F0D9		; 
		jsr	$F02A		; else interrogate keyboard
		bcs	$F12E		; if carry set F12E to set Auto scan else
		php			; push flags
		bcc	$F0DE		; if carry clear goto FODE else
		ldy	#$EE		; set Y so next operation saves to 2cd
		sta	$01DF,Y		; can be 2cb,2cc or 2cd
		ldx	#$09		; set X to 9
		jsr	$F129		; select auto scan
		lda	#$7F		; set port A for input on bit 7 others outputs
		sta	$FE43		; 
		lda	#$03		; stop auto scan
		sta	$FE40		; 
		lda	#$0F		; select non-existent keyboard column F (0-9 only!)
		sta	$FE4F		; 
		lda	#$01		; cancel keyboard interrupt
		sta	$FE4D		; 
		stx	$FE4F		; select column X (9 max)
		bit	$FE4D		; if bit 1 =0 there is no keyboard interrupt so
		beq	$F123		; goto F123
		txa			; else put column address in A

		cmp	$01DF,Y		; compare with 1DF+Y
		bcc	$F11E		; if less then F11E
		sta	$FE4F		; else select column again
		bit	$FE4F		; and if bit 7 is 0
		bpl	$F11E		; then F11E
		plp			; else push and pull flags
		php			; 
		bcs	$F127		; and if carry set goto F127
		pha			; else Push A
		eor	$0000,Y		; EOR with EC,ED, or EE depending on Y value
		asl			; shift left
		cmp	#$01		; set carry if = or greater than number holds EC,ED,EE
		pla			; get back A
		bcs	$F127		; if carry set F127
		clc			; else clear carry
		adc	#$10		; add 16
		bpl	$F103		; and do it again if 0=<result<128
		dex			; decrement X
		bpl	$F0E3		; scan again if greater than 0
		txa			; 
		tax			; 
		plp			; pull flags

		jsr	$F12E		; call autoscan
		cli			; allow interrupts
		sei			; disable interrupts

;*************Enable counter scan of keyboard columns *******************
		; called from &EEFD, &F129

		lda	#$0B		; select auto scan of keyboard
		sta	$FE40		; tell VIA
		txa			; Get A into X
		rts			; and return


