;*************************************************************************
;*************************************************************************
;**									**
;**	 SOUND SYSTEM							**
;**									**
;*************************************************************************
;*************************************************************************

; -------------------------------------------------------------------------
; |									  |
; |	  OSWORD  07 - Make a sound					  |
; |									  |
; -------------------------------------------------------------------------
; On entry, control block pointed to by &F0/1
;	    Y=0 on entry
; XY +0	 Channel - &hsfc for Hold, Sync, Flush, Channel
;     2	 Amplitude/Envelope
;     4	 Pitch
;     6	 Duration

			.org	$e82d

_OSWORD_7:		iny					
			lda	(OSW_X),Y			; Get channel high byte byte
			cmp	#$ff				
			beq	_SOUND_FF			; Channel &FFxx, speech command
			cmp	#$20				; Is channel>=&20 ?
			ldx	#$08				; Prepare X=8 for unrecognised OSWORD call
			bcs	_BE7CA				; Pass to sideways ROMs for channel &2000+
			dey					; Point back to channel low byte
			jsr	_LE8C9				; Get Channel 0-3, and Cy if >=&10 for Flush
			ora	#$04				; Convert to buffer number 4-7
			tax					
			bcc	_BE848				; If not Flush, skip past
			jsr	_LE1AE				; Flush buffer
			ldy	#$01				; Point back to channel high byte

_BE848:			jsr	_LE8C9				; Get Sync 0-3, and Cy if >=&10 for Hold
			sta	MOS_WS_0			; Save Sync in &FA
			php					; Stack flags
			ldy	#$06				
			lda	(OSW_X),Y			; Get Duration byte
			pha					; and stack it
			ldy	#$04				
			lda	(OSW_X),Y			; Get pitch byte
			pha					; and stack it
			ldy	#$02				; 
			lda	(OSW_X),Y			; Get amplitude/envelope byte
			rol					; Move Hold into bit 0
			sec					; set carry
			sbc	#$02				; subract 2
			asl					; multiply by 4
			asl					; 
			ora	MOS_WS_0			; add S byte (0-3)

				; At this point,
				; b7,	0=envelope, 1=volume
				; b6-3, envelope-1 or volume+15
				; b2,	Hold
				; b1-0, Sync

			jsr	_BUFFER_SAVE			; Insert into buffer
			bcc	_BE887				; Buffer not full, jump to insert the rest
_BE869:			pla					; Drop stacked pitch
			pla					; Drop stacked duration
			plp					; Restore flags
								; And exit

; -------------------------------------------------------------------------
; |									  |
; |	  OSBYTE  117 - Read VDU status					  |
; |									  |
; -------------------------------------------------------------------------

_OSBYTE_117:		ldx	VDU_STATUS			; get VDU status byte in X
			rts					; and return

;************* set up sound data for Bell ********************************

_VDU_7:			php					; push P
			sei					; bar interrupts
			lda	OSB_BELL_CHAN			; get bell channel number in A
			and	#$07				; (bits 0-3 only set)
			ora	#$04				; set bit 2
			tax					; X=A = bell channel number +4=buffer number
			lda	OSB_BELL_ENV			; get bell amplitude/envelope number
			jsr	_INSV				; store it in buffer pointed to by X
			lda	OSB_BELL_LEN			; get bell duration
			pha					; save it
			lda	OSB_BELL_FREQ			; get bell frequency
			pha					; save it

; Insert sound pitch and duration into sound buffer

_BE887:			sec					; Set carry
			ror	SOUND_WORKSPACE,X		; Set bit 7 of channel flags to indicate it's active
			bmi	_BE8A4				; Jump forward to insert pitch and duration

; -------------------------------------------------------------------------
; |									  |
; |	  SOUND &FFxx - Speech System					  |
; |									  |
; -------------------------------------------------------------------------
; On entry, control block pointed to by &F0/1
;	    Y=1 on entry
; XY +0	 Channel - &FFxx - xx=Speech command
;     2	 Word number/Address
;     4	 Ignored
;     6	 Ignored

_SOUND_FF:		php					; Save flags
			iny					; Y=2
			lda	(OSW_X),Y			; Get word number low byte
			pha					; and stack it
			iny					; Y=3
			lda	(OSW_X),Y			; Get word number high byte
			pha					; and stack it
			ldy	#$00				; Y=0
			lda	(OSW_X),Y			; Get speech command
			ldx	#$08				; X=8 for Speech buffer
			jsr	_BUFFER_SAVE			; Insert speech command into speech buffer
			bcs	_BE869				; Buffer full, drop stack and abandon
			ror	BUFFER_8_BUSY			; Clear bit 7 of speech buffer busy flag

; Insert two bytes into buffer

_BE8A4:			pla					; Get word number high byte or pitch back
			jsr	_INSV				; Insert into speech buffer
			pla					; Get word number low byte or duration back
			jsr	_INSV				; Insert into speech buffer
			plp					; Restore flags
			rts					; and return


;*************************************************************************
;*									 *
;*	 OSWORD	 08 - Define Envelope					 *
;*									 *
;*************************************************************************
; On entry, control block pointed to by &F0/1
;	    Y=0 on entry
;	    A=envelope number from (&F0),0
;XY +0	Envelope number, also in A
;    1	bits 0-6 length of each step in centi-secsonds bit 7=0 auto repeat
;    2	change of Pitch per step (-128-+127) in section 1
;    3	change of Pitch per step (-128-+127) in section 2
;    4	change of Pitch per step (-128-+127) in section 3
;    5	number of steps in section 1 (0-255)
;    6	number of steps in section 2 (0-255)
;    7	number of steps in section 3 (0-255)
;    8	change of amplitude per step during attack  phase (-127 to +127)
;    9	change of amplitude per step during decay   phase (-127 to +127)
;   10	change of amplitude per step during sustain phase (-127 to +127)
;   11	change of amplitude per step during release phase (-127 to +127)
;   12	target level at end of attack phase   (0-126)
;   13	target level at end of decay  phase   (0-126)

_OSWORD_8:		sbc	#$01				; set up appropriate displacement to storage area
			asl					; A=(A-1)*16 or 15
			asl					; 
			asl					; 
			asl					; 
			ora	#$0f				; 
			tax					; X=A
			lda	#$00				; A=0

			ldy	#$10				; Y=&10

_BE8BB:			cpy	#$0e				; is Y>=14??
			bcs	_BE8C1				; yes then E8C1
			lda	(OSW_X),Y			; else get byte from parameter block
_BE8C1:			sta	ENV_STEP,X			; and store it in appropriate area
			dex					; decrement X
			dey					; Decrement Y
			bne	_BE8BB				; if not 0 then do it again
			rts					; else exit
								; note that envelope number is NOT transferred

_LE8C9:			lda	(OSW_X),Y			; get byte
			cmp	#$10				; is it greater than 15, if so set carry
			and	#$03				; and 3 to clear bits 2-7
			iny					; increment Y
			rts					; and exit


;*************************************************************************
;*									 *
;*	 OSWORD	 03   ENTRY POINT					 *
;*									 *
;*	 read interval timer						 *
;*									 *
;*************************************************************************
;F0/1 points to block to store data

_OSWORD_3:		ldx	#$0f				; X=&F displacement from clock to timer
			bne	_BE8D8				; jump to E8D8


;*************************************************************************
;*									 *
;*	 OSWORD	 01   ENTRY POINT					 *
;*									 *
;*	 read system clock						 *
;*									 *
;*************************************************************************
;F0/1 points to block to store data

_OSWORD_1:		ldx	OSB_TIME_SWITCH			; X=current system clock store pointer

_BE8D8:			ldy	#$04				; Y=4
_BE8DA:			lda	OSB_LAST_BREAK,X		; read byte
			sta	(OSW_X),Y			; store it in parameter block
			inx					; X=x+1
			dey					; Y=Y-1
			bpl	_BE8DA				; if Y>0 then do it again
_BE8E3:			rts					; else exit


;*************************************************************************
;*									 *
;*	 OSWORD	 04   ENTRY POINT					 *
;*									 *
;*	 write interval timer						 *
;*									 *
;*************************************************************************
; F0/1 points to block to store data

_OSWORD_4:		lda	#$0f				; offset between clock and timer
			bne	_BE8EE				; jump to E8EE ALWAYS!!


;*************************************************************************
;*									 *
;*	 OSWORD	 02   ENTRY POINT					 *
;*									 *
;*	 write system clock						 *
;*									 *
;*************************************************************************
; F0/1 points to block to store data

_OSWORD_2:		lda	OSB_TIME_SWITCH			; get current clock store pointer
			eor	#$0f				; and invert to get inactive timer
			clc					; clear carry

_BE8EE:			pha					; store A
			tax					; X=A
			ldy	#$04				; Y=4
_BE8F2:			lda	(OSW_X),Y			; and transfer all 5 bytes
			sta	OSB_LAST_BREAK,X		; to the clock or timer
			inx					; 
			dey					; 
			bpl	_BE8F2				; if Y>0 then E8F2
			pla					; get back stack
			bcs	_BE8E3				; if set (write to timer) E8E3 exit
			sta	OSB_TIME_SWITCH			; write back current clock store
			rts					; and exit


;*************************************************************************
;*									 *
;*	 OSWORD	 00   ENTRY POINT					 *
;*									 *
;*	 read line from current input to memory				 *
;*									 *
;*************************************************************************
;F0/1 points to parameter block
;	+0/1 Buffer address for input
;	+2   Maximum line length
;	+3   minimum acceptable ASCII value
;	+4   maximum acceptable ASCII value

_OSWORD_0:		ldy	#$04				; Y=4

_BE904:			lda	(OSW_X),Y			; transfer bytes 4,3,2 to 2B3-2B5
			sta	INKEY_TIMER,Y			; 
			dey					; decrement Y
			cpy	#$02				; until Y=1
			bcs	_BE904				; 

			lda	(OSW_X),Y			; get address of input buffer
			sta	OSW_0_PTR_HI			; store it in &E9 as temporary buffer
			dey					; decrement Y
			sty	OSB_HALT_LINES			; Y=0 store in print line counter for paged mode
			lda	(OSW_X),Y			; get lo byte of address
			sta	OSW_0_PTR			; and store in &E8
			cli					; allow interrupts
			bcc	_BE924				; Jump to E924

_BE91D:			lda	#$07				; A=7
_BE91F:			dey					; decrement Y
_BE920:			iny					; increment Y
_BE921:			jsr	OSWRCH				; and call OSWRCH

_BE924:			jsr	OSRDCH				; else read character  from input stream
			bcs	_BE972				; if carry set then illegal character or other error
								; exit via E972
			tax					; X=A
			lda	OSB_OUT_STREAM			; A=&27C get character destination status
			ror					; put VDU driver bit in carry
			ror					; if this is 1 VDU driver is disabled
			txa					; X=A
			bcs	_BE937				; if Carry set E937
			ldx	OSB_VDU_QSIZE			; get number of items in VDU queque
			bne	_BE921				; if not 0 output character and loop round again

_BE937:			cmp	#$7f				; if character is not delete
			bne	_BE942				; goto E942
			cpy	#$00				; else is Y=0
			beq	_BE924				; and goto E924
			dey					; decrement Y
			bcs	_BE921				; and if carry set E921 to output it
_BE942:			cmp	#$15				; is it delete line &21
			bne	_BE953				; if not E953
			tya					; else Y=A, if its 0 we are still reading first
								; character
			beq	_BE924				; so E924
			lda	#$7f				; else output DELETES

_BE94B:			jsr	OSWRCH				; until Y=0
			dey					; 
			bne	_BE94B				; 

			beq	_BE924				; then read character again

_BE953:			sta	(OSW_0_PTR),Y			; store character in designated buffer
			cmp	#$0d				; is it CR?
			beq	_BE96C				; if so E96C
			cpy	OSW0_MAX_LINE			; else check the line length
			bcs	_BE91D				; if = or greater loop to ring bell
			cmp	OSW0_MIN_CHAR			; check minimum character
			bcc	_BE91F				; if less than minimum backspace
			cmp	OSW0_MAX_CHAR			; check maximum character
			beq	_BE920				; if equal E920
			bcc	_BE920				; or less E920
			bcs	_BE91F				; then JUMP E91F

_BE96C:			jsr	OSNEWL				; output CR/LF
			jsr	_NETV				; call Econet vector

_BE972:			lda	ESCAPE_FLAG			; A=ESCAPE FLAG
			rol					; put bit 7 into carry
			rts					; and exit routine


;*************************************************************************
;*									 *
;*	 OSBYTE	 05   ENTRY POINT					 *
;*									 *
;*	 SELECT PRINTER TYPE						 *
;*									 *
;*************************************************************************

_OSBYTE_5:		cli					; allow interrupts briefly
			sei					; bar interrupts
			bit	ESCAPE_FLAG			; check if ESCAPE is pending
			bmi	_BE9AC				; if it is E9AC
			bit	BUFFER_3_BUSY			; else check bit 7 buffer 3 (printer)
			bpl	_OSBYTE_5			; if not empty bit 7=0 E976

			jsr	_LE1A4				; check for user defined routine
			ldy	#$00				; Y=0
			sty	OSW_Y				; F1=0


;*************************************************************************
;*									 *
;*	 OSBYTE	 01   ENTRY POINT					 *
;*									 *
;*	 READ/WRITE USER FLAG (&281)					 *
;*									 *
;*	    AND								 *
;*									 *
;*	 OSBYTE	 06   ENTRY POINT					 *
;*									 *
;*	 SET PRINTER IGNORE CHARACTER					 *
;*									 *
;*************************************************************************
; A contains osbyte number

_OSBYTE_1_6:		ora	#$f0				; A=osbyte +&F0
			bne	_BE99A				; JUMP to E99A


;*************************************************************************
;*									 *
;*	 OSBYTE	 0C   ENTRY POINT					 *
;*									 *
;*	 SET  KEYBOARD AUTOREPEAT RATE					 *
;*									 *
;*************************************************************************

_OSBYTE_12:		bne	_OSBYTE_11			; if &F0<>0 goto E995
			ldx	#$32				; if X=0 in original call then X=32
			stx	OSB_KEY_DELAY			; to set keyboard autorepeat delay ram copy
			ldx	#$08				; X=8


;*************************************************************************
;*									 *
;*	 OSBYTE	 0B   ENTRY POINT					 *
;*									 *
;*	 SET  KEYBOARD AUTOREPEAT DELAY					 *
;*									 *
;*************************************************************************

_OSBYTE_11:		adc	#$cf				; A=A+&D0 (carry set)


;*************************************************************************
;*									 *
;*	 OSBYTE	 03   ENTRY POINT					 *
;*									 *
;*	 SELECT OUTPUT STREAM						 *
;*									 *
;*		 AND							 *
;*									 *
;*									 *
;*	 OSBYTE	 04   ENTRY POINT					 *
;*									 *
;*	 ENABLE/DISABLE CURSOR EDITING					 *
;*									 *
;*************************************************************************

_OSBYTE_3_4:		clc					; c,ear carry
			adc	#$e9				; A=A+&E9

_BE99A:			stx	OSW_X				; store X


;*************************************************************************
;*									 *
;*	 OSBYTE	 A6-FF	 ENTRY POINT					 *
;*									 *
;*	 READ/ WRITE SYSTEM VARIABLE OSBYTE NO. +&190			 *
;*									 *
;*************************************************************************

_OSBYTE_166_255:	tay					; Y=A
			lda	$0190,Y				; i.e. A=&190 +osbyte call!
			tax					; preserve this
			and	OSW_Y				; new value = OLD value AND Y EOR X!
			eor	OSW_X				; 
			sta	$0190,Y				; store it
			lda	$0191,Y				; get value of next byte into A
			tay					; Y=A
_BE9AC:			rts					; and exit

;******* SERIAL BAUD RATE LOOK UP TABLE ************************************

_BAUD_TABLE:		.byte	$64				; % 01100100	  75
			.byte	$7f				; % 01111111	 150
			.byte	$5b				; % 01011011	 300
			.byte	$6d				; % 01101101	1200
			.byte	$c9				; % 11001001	2400
			.byte	$f6				; % 11110110	4800
			.byte	$d2				; % 11010010	9600
			.byte	$e4				; % 11100100   19200
			.byte	$40				; % 01000000

;*************************************************************************
;*									 *
;*	 OSBYTE	 &13   ENTRY POINT					 *
;*									 *
;*	 Wait for VSync							 *
;*									 *
;*************************************************************************

_OSBYTE_19:		lda	OSB_CFS_TIMEOUT			; read vertical sync counter
_BE9B9:			cli					; allow interrupts briefly
			sei					; bar interrupts
			cmp	OSB_CFS_TIMEOUT			; has it changed?
			beq	_BE9B9				; no then E9B9
; falls through and reads VDU variable X

;*************************************************************************
;*									 *
;*	 OSBYTE	 160   ENTRY POINT					 *
;*									 *
;*	 READ VDU VARIABLE						 *
;*									 *
;*************************************************************************
;X contains the variable number
;0 =lefthand column in pixels current graphics window
;2 =Bottom row in pixels current graphics window
;4 =Right hand column in pixels current graphics window
;6 =Top row in pixels current graphics window
;8 =lefthand column in absolute characters current text window
;9 =Bottom row in absolute characters current text window
;10 =Right hand column in absolute characters current text window
;11 =Top row in absolute characters current text window
;12-15 current graphics origin in external coordinates
;16-19 current graphics cursor in external coordina4es
;20-23 old graphics cursor in internal coordinates
;24 current text cursor in X and Y

_OSBYTE_160:		ldy	VDU_G_WIN_L_HI,X		; get VDU variable hi
			lda	VDU_G_WIN_L,X			; low
			tax					; X=low byte
			rts					; and exit


;*************************************************************************
;*									 *
;*	 OSBYTE	 18   ENTRY POINT					 *
;*									 *
;*	 RESET SOFT KEYS						 *
;*									 *
;*************************************************************************

_OSBYTE_18:		lda	#$10				; set consistency flag
			sta	OSB_SOFTKEY_FLG			; 

			ldx	#$00				; X=0

_BE9CF:			sta	SOFTKEYS,X			; and wipe clean
			inx					; soft key buffer
			bne	_BE9CF				; until X=0 again

			stx	OSB_SOFTKEY_FLG			; zero consistency flag
			rts					; and exit


;*************************************************************************
;*									 *
;*	  OSBYTE &76 (118) SET LEDs to Keyboard Status			 *
;*									 *
;*************************************************************************
				; osbyte entry with carry set
				; called from &CB0E, &CAE3, &DB8B

_OSBYTE_118:		php					; PUSH P
			sei					; DISABLE INTERUPTS
			lda	#$40				; switch on CAPS and SHIFT lock lights
			jsr	_SET_LEDS_TEST_ESCAPE		; via subroutine
			bmi	__led_escape			; if ESCAPE exists (M set) E9E7
			clc					; else clear V and C
			clv					; before calling main keyboard routine to
			jsr	_LF068				; switch on lights as required
__led_escape:		plp					; get back flags
			rol					; and rotate carry into bit 0
			rts					; Return to calling routine
								;
;***************** Turn on keyboard lights and Test Escape flag ************
				; called from &E1FE, &E9DD
				;
_SET_LEDS_TEST_ESCAPE:	bcc	_BE9F5				; if carry clear
			ldy	#$07				; switch on shift lock light
			sty	SYS_VIA_IORB			; 
			dey					; Y=6
			sty	SYS_VIA_IORB			; switch on Caps lock light
_BE9F5:			bit	ESCAPE_FLAG			; set minus flag if bit 7 of &00FF is set indicating
			rts					; that ESCAPE condition exists, then return
								;
;****************** Write A to SYSTEM VIA register B *************************
				; called from &CB6D, &CB73
_WRITE_SYS_VIA_PORTB:	php					; push flags
			sei					; disable interupts
			sta	SYS_VIA_IORB			; write register B from Accumulator
			plp					; get back flags
			rts					; and exit


;*************************************************************************
;*									 *
;*	 OSBYTE 154 (&9A) SET VIDEO ULA					 *
;*									 *
;*************************************************************************

_OSBYTE_154:		txa					; osbyte entry! X transferred to A thence to

;*******Set Video ULA control register **entry from VDU routines **************
				; called from &CBA6, &DD37

_LEA00:			php					; save flags
			sei					; disable interupts
			sta	OSB_VIDPROC_CTL			; save RAM copy of new parameter
			sta	VID_ULA_CTRL			; write to control register
			lda	OSB_FLASH_MARK			; read	space count
			sta	OSB_FLASH_TIME			; set flash counter to this value
			plp					; get back status
			rts					; and return


;*************************************************************************
;*									 *
;*	  OSBYTE &9B (155) write to palette register			 *
;*									 *
;*************************************************************************
;entry X contains value to write
_OSBYTE_155:		txa					; A=X
_LEA11:			eor	#$07				; convert to palette format
			php					; 
			sei					; prevent interrupts
			sta	OSB_VIDPROC_PAL			; store as current palette setting
			sta	VID_ULA_PALETTE			; store actual colour in register
			plp					; get back flags
			rts					; and exit


;*************************************************************************
;*	 GSINIT	 string initialisation					 *
;*	 F2/3 points to string offset by Y				 *
;*									 *
;*	 ON EXIT							 *
;*	 Z flag set indicates null string,				 *
;*	 Y points to first non blank character				 *
;*	 A contains first non blank character				 *
;*************************************************************************

_LEA1D:			clc					; clear carry

_GSINIT:		ror	OSBYTE_PAR_3			; Rotate moves carry to &E4
			jsr	_SKIP_SPACE			; get character from text
			iny					; increment Y to point at next character
			cmp	#$22				; check to see if its '"'
			beq	_BEA2A				; if so EA2A (carry set)
			dey					; decrement Y
			clc					; clear carry
_BEA2A:			ror	OSBYTE_PAR_3			; move bit 7 to bit 6 and put carry in bit 7
			cmp	#$0d				; check to see if its CR to set Z
			rts					; and return


;*************************************************************************
;*	 GSREAD	 string read routine					 *
;*	 F2/3 points to string offset by Y				 *
;*									 *
;*************************************************************************
				;
_GSREAD:		lda	#$00				; A=0
_BEA31:			sta	OSBYTE_PAR_2			; store A
			lda	(TEXT_PTR),Y			; read first character
			cmp	#$0d				; is it CR
			bne	_BEA3F				; if not goto EA3F
			bit	OSBYTE_PAR_3			; if bit 7=1 no 2nd '"' found
			bmi	_LEA8F				; goto EA8F
			bpl	_BEA5A				; if not EA5A

_BEA3F:			cmp	#$20				; is less than a space?
			bcc	_LEA8F				; goto EA8F
			bne	_BEA4B				; if its not a space EA4B
			bit	OSBYTE_PAR_3			; is bit 7 of &E4 =1
			bmi	_BEA89				; if so goto EA89
			bvc	_BEA5A				; if bit 6 = 0 EA5A
_BEA4B:			cmp	#$22				; is it '"'
			bne	_BEA5F				; if not EA5F
			bit	OSBYTE_PAR_3			; if so and Bit 7 of &E4 =0 (no previous ")
			bpl	_BEA89				; then EA89
			iny					; else point at next character
			lda	(TEXT_PTR),Y			; get it
			cmp	#$22				; is it '"'
			beq	_BEA89				; if so then EA89

_BEA5A:			jsr	_SKIP_SPACE			; read a byte from text
			sec					; and return with
			rts					; carry set
								;
_BEA5F:			cmp	#$7c				; is it '|'
			bne	_BEA89				; if not EA89
			iny					; if so increase Y to point to next character
			lda	(TEXT_PTR),Y			; get it
			cmp	#$7c				; and compare it with '|' again
			beq	_BEA89				; if its '|' then EA89
			cmp	#$22				; else is it '"'
			beq	_BEA89				; if so then EA89
			cmp	#$21				; is it !
			bne	_BEA77				; if not then EA77
			iny					; increment Y again
			lda	#$80				; set bit 7
			bne	_BEA31				; loop back to EA31 to set bit 7 in next CHR
_BEA77:			cmp	#$20				; is it a space
			bcc	_LEA8F				; if less than EA8F Bad String Error
			cmp	#$3f				; is it '?'
			beq	_BEA87				; if so EA87
			jsr	_LEABF				; else modify code as if CTRL had been pressed
			bit	_BD9B7				; if bit 6 set
			bvs	_BEA8A				; then EA8A
_BEA87:			lda	#$7f				; else set bits 0 to 6 in A

_BEA89:			clv					; clear V
_BEA8A:			iny					; increment Y
			ora	OSBYTE_PAR_2			; 
			clc					; clear carry
			rts					; Return
								;
_LEA8F:			brk					; 
			.byte	$fd				; error number
			.byte	"Bad string"			; message
			brk					; 

;************ Modify code as if SHIFT pressed *****************************

_LEA9C:			cmp	#$30				; if A='0' skip routine
			beq	_BEABE				; 
			cmp	#$40				; if A='@' skip routine
			beq	_BEABE				; 
			bcc	_BEAB8				; if A<'@' then EAB8
			cmp	#$7f				; else is it DELETE

			beq	_BEABE				; if so skip routine
			bcs	_BEABC				; if greater than &7F then toggle bit 4
_BEAAC:			eor	#$30				; reverse bits 4 and 5
			cmp	#$6f				; is it &6F (previously ' _' (&5F))
			beq	_BEAB6				; goto EAB6
			cmp	#$50				; is it &50 (previously '`' (&60))
			bne	_BEAB8				; if not EAB8
_BEAB6:			eor	#$1f				; else continue to convert ` _
_BEAB8:			cmp	#$21				; compare &21 '!'
			bcc	_BEABE				; if less than return
_BEABC:			eor	#$10				; else finish conversion by toggling bit 4
_BEABE:			rts					; exit
								;
								; ASCII codes &00 &20 no change
								; 21-3F have bit 4 reverses (31-3F)
								; 41-5E A-Z have bit 5 reversed a-z
								; 5F & 60 are reversed
								; 61-7E bit 5 reversed a-z becomes A-Z
								; DELETE unchanged
								; &80+ has bit 4 changed

;************** Implement CTRL codes *************************************

_LEABF:			cmp	#$7f				; is it DEL
			beq	_BEAD1				; if so ignore routine
			bcs	_BEAAC				; if greater than &7F go to EAAC
			cmp	#$60				; if A<>'`'
			bne	_BEACB				; goto EACB
			lda	#$5f				; if A=&60, A=&5F

_BEACB:			cmp	#$40				; if A<&40
			bcc	_BEAD1				; goto EAD1  and return unchanged
			and	#$1f				; else zero bits 5 to 7
_BEAD1:			rts					; return
								;
			.byte	"/!BOOT",$0d			


