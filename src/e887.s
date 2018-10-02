;*************************************************************************
;*************************************************************************
;**                                                                     **
;**      SOUND SYSTEM                                                   **
;**                                                                     **
;*************************************************************************
;*************************************************************************

;-------------------------------------------------------------------------
;|                                                                       |
;|       OSWORD  07 - Make a sound                                       |
;|                                                                       |
;-------------------------------------------------------------------------
; On entry, control block pointed to by &F0/1
;           Y=0 on entry
; XY +0  Channel - &hsfc for Hold, Sync, Flush, Channel
;     2  Amplitude/Envelope
;     4  Pitch
;     6  Duration

.org		$e82d

		iny	
		lda	($F0),Y		; Get channel high byte byte
		cmp	#$FF
		beq	_BE88D		; Channel &FFxx, speech command
		cmp	#$20		; Is channel>=&20 ?
		ldx	#$08		; Prepare X=8 for unrecognised OSWORD call
		bcs	_BE7CA		; Pass to sideways ROMs for channel &2000+
		dey			; Point back to channel low byte
		jsr	_LE8C9		; Get Channel 0-3, and Cy if >=&10 for Flush
		ora	#$04		; Convert to buffer number 4-7
		tax	
		bcc	_BE848		; If not Flush, skip past
		jsr	_LE1AE		; Flush buffer
		ldy	#$01		; Point back to channel high byte

_BE848:		jsr	_LE8C9		; Get Sync 0-3, and Cy if >=&10 for Hold
		sta	$FA		; Save Sync in &FA
		php			; Stack flags
		ldy	#$06
		lda	($F0),Y		; Get Duration byte
		pha			; and stack it
		ldy	#$04
		lda	($F0),Y		; Get pitch byte
		pha			; and stack it
		ldy	#$02		; 
		lda	($F0),Y		; Get amplitude/envelope byte
		rol			; Move Hold into bit 0
		sec			; set carry
		sbc	#$02		; subract 2
		asl			; multiply by 4
		asl			; 
		ora	$FA		; add S byte (0-3)

		;  At this point,
		;  b7,   0=envelope, 1=volume
		;  b6-3, envelope-1 or volume+15
		;  b2,   Hold
		;  b1-0, Sync

		jsr	_LE1F8		; Insert into buffer
		bcc	_BE887		; Buffer not full, jump to insert the rest
_BE869:		pla			; Drop stacked pitch
		pla			; Drop stacked duration
		plp			; Restore flags
					;  And exit

;-------------------------------------------------------------------------
;|                                                                       |
;|       OSBYTE  117 - Read VDU status                                   |
;|                                                                       |
;-------------------------------------------------------------------------

		ldx	$D0		; get VDU status byte in X
		rts			; and return

;************* set up sound data for Bell ********************************

_LE86F:		php			; push P
		sei			; bar interrupts
		lda	$0263		; get bell channel number in A
		and	#$07		; (bits 0-3 only set)
		ora	#$04		; set bit 2
		tax			; X=A = bell channel number +4=buffer number
		lda	$0264		; get bell amplitude/envelope number
		jsr	_LE4B0		; store it in buffer pointed to by X
		lda	$0266		; get bell duration
		pha			; save it
		lda	$0265		; get bell frequency
		pha			; save it

; Insert sound pitch and duration into sound buffer
;
_BE887:		sec			; Set carry
		ror	$0800,X		; Set bit 7 of channel flags to indicate it's active
		bmi	_BE8A4		; Jump forward to insert pitch and duration

;-------------------------------------------------------------------------
;|                                                                       |
;|       SOUND &FFxx - Speech System                                     |
;|                                                                       |
;-------------------------------------------------------------------------
; On entry, control block pointed to by &F0/1
;           Y=1 on entry
; XY +0  Channel - &FFxx - xx=Speech command
;     2  Word number/Address
;     4  Ignored
;     6  Ignored

_BE88D:		php			; Save flags
		iny			; Y=2
		lda	($F0),Y		; Get word number low byte
		pha			; and stack it
		iny			; Y=3
		lda	($F0),Y		; Get word number high byte
		pha			; and stack it
		ldy	#$00		; Y=0
		lda	($F0),Y		; Get speech command
		ldx	#$08		; X=8 for Speech buffer
		jsr	_LE1F8		; Insert speech command into speech buffer
		bcs	_BE869		; Buffer full, drop stack and abandon
		ror	$02d7		; Clear bit 7 of speech buffer busy flag

; Insert two bytes into buffer
;
_BE8A4:		pla			; Get word number high byte or pitch back
		jsr	_LE4B0		; Insert into speech buffer
		pla			; Get word number low byte or duration back
		jsr	_LE4B0		; Insert into speech buffer
		plp			; Restore flags
		rts			; and return


;*************************************************************************
;*                                                                       *
;*       OSWORD  08 - Define Envelope                                    *
;*                                                                       *
;*************************************************************************
; On entry, control block pointed to by &F0/1
;           Y=0 on entry
;           A=envelope number from (&F0),0
;XY +0  Envelope number, also in A
;    1  bits 0-6 length of each step in centi-secsonds bit 7=0 auto repeat
;    2  change of Pitch per step (-128-+127) in section 1
;    3  change of Pitch per step (-128-+127) in section 2
;    4  change of Pitch per step (-128-+127) in section 3
;    5  number of steps in section 1 (0-255)
;    6  number of steps in section 2 (0-255)
;    7  number of steps in section 3 (0-255)
;    8  change of amplitude per step during attack  phase (-127 to +127)
;    9  change of amplitude per step during decay   phase (-127 to +127)
;   10  change of amplitude per step during sustain phase (-127 to +127)
;   11  change of amplitude per step during release phase (-127 to +127)
;   12  target level at end of attack phase   (0-126)
;   13  target level at end of decay  phase   (0-126)

		sbc	#$01		; set up appropriate displacement to storage area
		asl			; A=(A-1)*16 or 15
		asl			; 
		asl			; 
		asl			; 
		ora	#$0F		; 
		tax			; X=A
		lda	#$00		; A=0

		ldy	#$10		; Y=&10

_BE8BB:		cpy	#$0E		; is Y>=14??
		bcs	_BE8C1		; yes then E8C1
		lda	($F0),Y		; else get byte from parameter block
_BE8C1:		sta	$08c0,X		; and store it in appropriate area
		dex			; decrement X
		dey			; Decrement Y
		bne	_BE8BB		; if not 0 then do it again
		rts			; else exit
					; note that envelope number is NOT transferred
;
_LE8C9:		lda	($F0),Y		; get byte
		cmp	#$10		; is it greater than 15, if so set carry
		and	#$03		; and 3 to clear bits 2-7
		iny			; increment Y
		rts			; and exit


;*************************************************************************
;*                                                                       *
;*       OSWORD  03   ENTRY POINT                                        *
;*                                                                       *
;*       read interval timer                                             *
;*                                                                       *
;*************************************************************************
;F0/1 points to block to store data

		ldx	#$0F		; X=&F displacement from clock to timer
		bne	_BE8D8		; jump to E8D8


;*************************************************************************
;*                                                                       *
;*       OSWORD  01   ENTRY POINT                                        *
;*                                                                       *
;*       read system clock                                               *
;*                                                                       *
;*************************************************************************
;F0/1 points to block to store data

		ldx	$0283		; X=current system clock store pointer

_BE8D8:		ldy	#$04		; Y=4
_BE8DA:		lda	$028d,X		; read byte
		sta	($F0),Y		; store it in parameter block
		inx			; X=x+1
		dey			; Y=Y-1
		bpl	_BE8DA		; if Y>0 then do it again
_BE8E3:		rts			; else exit


;*************************************************************************
;*                                                                       *
;*       OSWORD  04   ENTRY POINT                                        *
;*                                                                       *
;*       write interval timer                                            *
;*                                                                       *
;*************************************************************************
;F0/1 points to block to store data

		lda	#$0F		; offset between clock and timer
		bne	_BE8EE		; jump to E8EE ALWAYS!!


;*************************************************************************
;*                                                                       *
;*       OSWORD  02   ENTRY POINT                                        *
;*                                                                       *
;*       write system clock                                              *
;*                                                                       *
;*************************************************************************
;F0/1 points to block to store data

		lda	$0283		; get current clock store pointer
		eor	#$0F		; and invert to get inactive timer
		clc			; clear carry

_BE8EE:		pha			; store A
		tax			; X=A
		ldy	#$04		; Y=4
_BE8F2:		lda	($F0),Y		; and transfer all 5 bytes
		sta	$028d,X		; to the clock or timer
		inx			; 
		dey			; 
		bpl	_BE8F2		; if Y>0 then E8F2
		pla			; get back stack
		bcs	_BE8E3		; if set (write to timer) E8E3 exit
		sta	$0283		; write back current clock store
		rts			; and exit


;*************************************************************************
;*                                                                       *
;*       OSWORD  00   ENTRY POINT                                        *
;*                                                                       *
;*       read line from current input to memory                          *
;*                                                                       *
;*************************************************************************
;F0/1 points to parameter block
;   	+0/1 Buffer address for input
;   	+2   Maximum line length
;   	+3   minimum acceptable ASCII value
;   	+4   maximum acceptable ASCII value

		ldy	#$04		; Y=4

_BE904:		lda	($F0),Y		; transfer bytes 4,3,2 to 2B3-2B5
		sta	$02b1,Y		; 
		dey			; decrement Y
		cpy	#$02		; until Y=1
		bcs	_BE904		; 

		lda	($F0),Y		; get address of input buffer
		sta	$E9		; store it in &E9 as temporary buffer
		dey			; decrement Y
		sty	$0269		; Y=0 store in print line counter for paged mode
		lda	($F0),Y		; get lo byte of address
		sta	$E8		; and store in &E8
		cli			; allow interrupts
		bcc	_BE924		; Jump to E924

_BE91D:		lda	#$07		; A=7
_BE91F:		dey			; decrement Y
_BE920:		iny			; increment Y
_BE921:		jsr	OSWRCH		; and call OSWRCH

_BE924:		jsr	OSRDCH		; else read character  from input stream
		bcs	_BE972		; if carry set then illegal character or other error
					; exit via E972
		tax			; X=A
		lda	$027c		; A=&27C get character destination status
		ror			; put VDU driver bit in carry
		ror			; if this is 1 VDU driver is disabled
		txa			; X=A
		bcs	_BE937		; if Carry set E937
		ldx	$026a		; get number of items in VDU queque
		bne	_BE921		; if not 0 output character and loop round again

_BE937:		cmp	#$7F		; if character is not delete
		bne	_BE942		; goto E942
		cpy	#$00		; else is Y=0
		beq	_BE924		; and goto E924
		dey			; decrement Y
		bcs	_BE921		; and if carry set E921 to output it
_BE942:		cmp	#$15		; is it delete line &21
		bne	_BE953		; if not E953
		tya			; else Y=A, if its 0 we are still reading first
					; character
		beq	_BE924		; so E924
		lda	#$7F		; else output DELETES

_BE94B:		jsr	OSWRCH		; until Y=0
		dey			; 
		bne	_BE94B		; 

		beq	_BE924		; then read character again

_BE953:		sta	($E8),Y		; store character in designated buffer
		cmp	#$0D		; is it CR?
		beq	_BE96C		; if so E96C
		cpy	$02b3		; else check the line length
		bcs	_BE91D		; if = or greater loop to ring bell
		cmp	$02b4		; check minimum character
		bcc	_BE91F		; if less than minimum backspace
		cmp	$02b5		; check maximum character
		beq	_BE920		; if equal E920
		bcc	_BE920		; or less E920
		bcs	_BE91F		; then JUMP E91F

_BE96C:		jsr	OSNEWL		; output CR/LF
		jsr	_LE57E		; call Econet vector

_BE972:		lda	$FF		; A=ESCAPE FLAG
		rol			; put bit 7 into carry
		rts			; and exit routine


;*************************************************************************
;*                                                                       *
;*       OSBYTE  05   ENTRY POINT                                        *
;*                                                                       *
;*       SELECT PRINTER TYPE                                             *
;*                                                                       *
;*************************************************************************

_BE976:		cli			; allow interrupts briefly
		sei			; bar interrupts
		bit	$FF		; check if ESCAPE is pending
		bmi	_BE9AC		; if it is E9AC
		bit	$02d2		; else check bit 7 buffer 3 (printer)
		bpl	_BE976		; if not empty bit 7=0 E976

		jsr	_LE1A4		; check for user defined routine
		ldy	#$00		; Y=0
		sty	$F1		; F1=0


;*************************************************************************
;*                                                                       *
;*       OSBYTE  01   ENTRY POINT                                        *
;*                                                                       *
;*       READ/WRITE USER FLAG (&281)                                     *
;*                                                                       *
;*          AND                                                          *
;*                                                                       *
;*       OSBYTE  06   ENTRY POINT                                        *
;*                                                                       *
;*       SET PRINTER IGNORE CHARACTER                                    *
;*                                                                       *
;*************************************************************************
; A contains osbyte number

		ora	#$F0		; A=osbyte +&F0
		bne	_BE99A		; JUMP to E99A


;*************************************************************************
;*                                                                       *
;*       OSBYTE  0C   ENTRY POINT                                        *
;*                                                                       *
;*       SET  KEYBOARD AUTOREPEAT RATE                                   *
;*                                                                       *
;*************************************************************************

		bne	_BE995		; if &F0<>0 goto E995
		ldx	#$32		; if X=0 in original call then X=32
		stx	$0254		; to set keyboard autorepeat delay ram copy
		ldx	#$08		; X=8


;*************************************************************************
;*                                                                       *
;*       OSBYTE  0B   ENTRY POINT                                        *
;*                                                                       *
;*       SET  KEYBOARD AUTOREPEAT DELAY                                  *
;*                                                                       *
;*************************************************************************

_BE995:		adc	#$CF		; A=A+&D0 (carry set)


;*************************************************************************
;*                                                                       *
;*       OSBYTE  03   ENTRY POINT                                        *
;*                                                                       *
;*       SELECT OUTPUT STREAM                                            *
;*                                                                       *
;*               AND                                                     *
;*                                                                       *
;*                                                                       *
;*       OSBYTE  04   ENTRY POINT                                        *
;*                                                                       *
;*       ENABLE/DISABLE CURSOR EDITING                                   *
;*                                                                       *
;*************************************************************************

		clc			; c,ear carry
		adc	#$E9		; A=A+&E9

_BE99A:		stx	$F0		; store X


;*************************************************************************
;*                                                                       *
;*       OSBYTE  A6-FF   ENTRY POINT                                     *
;*                                                                       *
;*       READ/ WRITE SYSTEM VARIABLE OSBYTE NO. +&190                    *
;*                                                                       *
;*************************************************************************

		tay			; Y=A
		lda	$0190,Y		; i.e. A=&190 +osbyte call!
		tax			; preserve this
		and	$F1		; new value = OLD value AND Y EOR X!
		eor	$F0		; 
		sta	$0190,Y		; store it
		lda	$0191,Y		; get value of next byte into A
		tay			; Y=A
_BE9AC:		rts			; and exit

;******* SERIAL BAUD RATE LOOK UP TABLE ************************************

_LE9AD:		.byte	$64		; % 01100100      75
		.byte	$7F		; % 01111111     150
		.byte	$5B		; % 01011011     300
		.byte	$6D		; % 01101101    1200
		.byte	$C9		; % 11001001    2400
		.byte	$F6		; % 11110110    4800
		.byte	$D2		; % 11010010    9600
		.byte	$E4		; % 11100100   19200
		.byte	$40		; % 01000000

;*************************************************************************
;*                                                                       *
;*       OSBYTE  &13   ENTRY POINT                                       *
;*                                                                       *
;*       Wait for VSync                                                  *
;*                                                                       *
;*************************************************************************

		lda	$0240		; read vertical sync counter
_BE9B9:		cli			; allow interrupts briefly
		sei			; bar interrupts
		cmp	$0240		; has it changed?
		beq	_BE9B9		; no then E9B9
; falls through and reads VDU variable X

;*************************************************************************
;*                                                                       *
;*       OSBYTE  160   ENTRY POINT                                       *
;*                                                                       *
;*       READ VDU VARIABLE                                               *
;*                                                                       *
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

		ldy	$0301,X		; get VDU variable hi
		lda	$0300,X		; low
		tax			; X=low byte
		rts			; and exit


;*************************************************************************
;*                                                                       *
;*       OSBYTE  18   ENTRY POINT                                        *
;*                                                                       *
;*       RESET SOFT KEYS                                                 *
;*                                                                       *
;*************************************************************************

_LE9C8:		lda	#$10		; set consistency flag
		sta	$0284		; 

		ldx	#$00		; X=0

_BE9CF:		sta	$0b00,X		; and wipe clean
		inx			; soft key buffer
		bne	_BE9CF		; until X=0 again

		stx	$0284		; zero consistency flag
		rts			; and exit


;*************************************************************************
;*                                                                       *
;*        OSBYTE &76 (118) SET LEDs to Keyboard Status                   *
;*                                                                       *
;*************************************************************************
		; osbyte entry with carry set
		; called from &CB0E, &CAE3, &DB8B

_LE9D9:		php			; PUSH P
		sei			; DISABLE INTERUPTS
		lda	#$40		; switch on CAPS and SHIFT lock lights
		jsr	_LE9EA		; via subroutine
		bmi	_BE9E7		; if ESCAPE exists (M set) E9E7
		clc			; else clear V and C
		clv			; before calling main keyboard routine to
		jsr	_LF068		; switch on lights as required
_BE9E7:		plp			; get back flags
		rol			; and rotate carry into bit 0
		rts			; Return to calling routine
					; 
;***************** Turn on keyboard lights and Test Escape flag ************
		; called from &E1FE, &E9DD
		; 
_LE9EA:		bcc	_BE9F5		; if carry clear
		ldy	#$07		; switch on shift lock light
		sty	$fe40		; 
		dey			; Y=6
		sty	$fe40		; switch on Caps lock light
_BE9F5:		bit	$FF		; set minus flag if bit 7 of &00FF is set indicating
		rts			; that ESCAPE condition exists, then return
					; 
;****************** Write A to SYSTEM VIA register B *************************
		; called from &CB6D, &CB73
_LE9F8:		php			; push flags
		sei			; disable interupts
		sta	$fe40		; write register B from Accumulator
		plp			; get back flags
		rts			; and exit


;*************************************************************************
;*                                                                       *
;*       OSBYTE 154 (&9A) SET VIDEO ULA                                  *
;*                                                                       *
;*************************************************************************

		txa			; osbyte entry! X transferred to A thence to

;*******Set Video ULA control register **entry from VDU routines **************
		; called from &CBA6, &DD37

_LEA00:		php			; save flags
		sei			; disable interupts
		sta	$0248		; save RAM copy of new parameter
		sta	$fe20		; write to control register
		lda	$0253		; read  space count
		sta	$0251		; set flash counter to this value
		plp			; get back status
		rts			; and return


;*************************************************************************
;*                                                                       *
;*        OSBYTE &9B (155) write to palette register                     *
;*                                                                       *
;*************************************************************************
;entry X contains value to write
		txa			; A=X
_LEA11:		eor	#$07		; convert to palette format
		php			; 
		sei			; prevent interrupts
		sta	$0249		; store as current palette setting
		sta	$fe21		; store actual colour in register
		plp			; get back flags
		rts			; and exit


;*************************************************************************
;*       GSINIT  string initialisation                                   *
;*       F2/3 points to string offset by Y                               *
;*                                                                       *
;*       ON EXIT                                                         *
;*       Z flag set indicates null string,                               *
;*       Y points to first non blank character                           *
;*       A contains first non blank character                            *
;*************************************************************************

_LEA1D:		clc			; clear carry

_LEA1E:		ror	$E4		; Rotate moves carry to &E4
		jsr	_LE03A		; get character from text
		iny			; increment Y to point at next character
		cmp	#$22		; check to see if its '"'
		beq	_BEA2A		; if so EA2A (carry set)
		dey			; decrement Y
		clc			; clear carry
_BEA2A:		ror	$E4		; move bit 7 to bit 6 and put carry in bit 7
		cmp	#$0D		; check to see if its CR to set Z
		rts			; and return


;*************************************************************************
;*       GSREAD  string read routine                                     *
;*       F2/3 points to string offset by Y                               *
;*                                                                       *
;*************************************************************************
		; 
_LEA2F:		lda	#$00		; A=0
_BEA31:		sta	$E5		; store A
		lda	($F2),Y		; read first character
		cmp	#$0D		; is it CR
		bne	_BEA3F		; if not goto EA3F
		bit	$E4		; if bit 7=1 no 2nd '"' found
		bmi	_BEA8F		; goto EA8F
		bpl	_BEA5A		; if not EA5A

_BEA3F:		cmp	#$20		; is less than a space?
		bcc	_BEA8F		; goto EA8F
		bne	_BEA4B		; if its not a space EA4B
		bit	$E4		; is bit 7 of &E4 =1
		bmi	_BEA89		; if so goto EA89
		bvc	_BEA5A		; if bit 6 = 0 EA5A
_BEA4B:		cmp	#$22		; is it '"'
		bne	_BEA5F		; if not EA5F
		bit	$E4		; if so and Bit 7 of &E4 =0 (no previous ")
		bpl	_BEA89		; then EA89
		iny			; else point at next character
		lda	($F2),Y		; get it
		cmp	#$22		; is it '"'
		beq	_BEA89		; if so then EA89

_BEA5A:		jsr	_LE03A		; read a byte from text
		sec			; and return with
		rts			; carry set
					; 
_BEA5F:		cmp	#$7C		; is it '|'
		bne	_BEA89		; if not EA89
		iny			; if so increase Y to point to next character
		lda	($F2),Y		; get it
		cmp	#$7C		; and compare it with '|' again
		beq	_BEA89		; if its '|' then EA89
		cmp	#$22		; else is it '"'
		beq	_BEA89		; if so then EA89
		cmp	#$21		; is it !
		bne	_BEA77		; if not then EA77
		iny			; increment Y again
		lda	#$80		; set bit 7
		bne	_BEA31		; loop back to EA31 to set bit 7 in next CHR
_BEA77:		cmp	#$20		; is it a space
		bcc	_BEA8F		; if less than EA8F Bad String Error
		cmp	#$3F		; is it '?'
		beq	_BEA87		; if so EA87
		jsr	_LEABF		; else modify code as if CTRL had been pressed
		bit	_BD9B7		; if bit 6 set
		bvs	_BEA8A		; then EA8A
_BEA87:		lda	#$7F		; else set bits 0 to 6 in A

_BEA89:		clv			; clear V
_BEA8A:		iny			; increment Y
		ora	$E5		; 
		clc			; clear carry
		rts			; Return
					; 
_BEA8F:		brk			; 
		.byte	$FD		; error number
		.byte	"Bad string"		; message
		brk			; 

;************ Modify code as if SHIFT pressed *****************************

_LEA9C:		cmp	#$30		; if A='0' skip routine
		beq	_BEABE		; 
		cmp	#$40		; if A='@' skip routine
		beq	_BEABE		; 
		bcc	_BEAB8		; if A<'@' then EAB8
		cmp	#$7F		; else is it DELETE

		beq	_BEABE		; if so skip routine
		bcs	_BEABC		; if greater than &7F then toggle bit 4
_BEAAC:		eor	#$30		; reverse bits 4 and 5
		cmp	#$6F		; is it &6F (previously ' _' (&5F))
		beq	_BEAB6		; goto EAB6
		cmp	#$50		; is it &50 (previously '`' (&60))
		bne	_BEAB8		; if not EAB8
_BEAB6:		eor	#$1F		; else continue to convert ` _
_BEAB8:		cmp	#$21		; compare &21 '!'
		bcc	_BEABE		; if less than return
_BEABC:		eor	#$10		; else finish conversion by toggling bit 4
_BEABE:		rts			; exit
					; 
					; ASCII codes &00 &20 no change
					; 21-3F have bit 4 reverses (31-3F)
					; 41-5E A-Z have bit 5 reversed a-z
					; 5F & 60 are reversed
					; 61-7E bit 5 reversed a-z becomes A-Z
					; DELETE unchanged
					; &80+ has bit 4 changed

;************** Implement CTRL codes *************************************

_LEABF:		cmp	#$7F		; is it DEL
		beq	_BEAD1		; if so ignore routine
		bcs	_BEAAC		; if greater than &7F go to EAAC
		cmp	#$60		; if A<>'`'
		bne	_BEACB		; goto EACB
		lda	#$5F		; if A=&60, A=&5F

_BEACB:		cmp	#$40		; if A<&40
		bcc	_BEAD1		; goto EAD1  and return unchanged
		and	#$1F		; else zero bits 5 to 7
_BEAD1:		rts			; return
					; 
		.byte	"/!BOOT",$0D


