;**************************************************************************                                                                       *
;*        OSBYTE LOOK UP TABLE                                           *
;*                                                                       *
;*************************************************************************

.org		$e5b3

_LE5B3:		.byte	$21,$E8		; OSBYTE   0  (&E821)
		.byte	$88,$E9		; OSBYTE   1  (&E988)
		.byte	$D3,$E6		; OSBYTE   2  (&E6D3)
		.byte	$97,$E9		; OSBYTE   3  (&E997)
		.byte	$97,$E9		; OSBYTE   4  (&E997)
		.byte	$76,$E9		; OSBYTE   5  (&E976)
		.byte	$88,$E9		; OSBYTE   6  (&E988)
		.byte	$8B,$E6		; OSBYTE   7  (&E68B)
		.byte	$89,$E6		; OSBYTE   8  (&E689)
		.byte	$B0,$E6		; OSBYTE   9  (&E6B0)
		.byte	$B2,$E6		; OSBYTE  10  (&E6B2)
		.byte	$95,$E9		; OSBYTE  11  (&E995)
		.byte	$8C,$E9		; OSBYTE  12  (&E98C)
		.byte	$F9,$E6		; OSBYTE  13  (&E6F9)
		.byte	$FA,$E6		; OSBYTE  14  (&E6FA)
		.byte	$A8,$F0		; OSBYTE  15  (&F0A8)
		.byte	$06,$E7		; OSBYTE  16  (&E706)
		.byte	$8C,$DE		; OSBYTE  17  (&DE8C)
		.byte	$C8,$E9		; OSBYTE  18  (&E9C8)
		.byte	$B6,$E9		; OSBYTE  19  (&E9B6)
		.byte	$07,$CD		; OSBYTE  20  (&CD07)
		.byte	$B4,$F0		; OSBYTE  21  (&F0B4)
		.byte	$6C,$E8		; OSBYTE 117  (&E86C)
		.byte	$D9,$E9		; OSBYTE 118  (&E9D9)
		.byte	$75,$E2		; OSBYTE 119  (&E275)
		.byte	$45,$F0		; OSBYTE 120  (&F045)
		.byte	$CF,$F0		; OSBYTE 121  (&F0CF)
		.byte	$CD,$F0		; OSBYTE 122  (&F0CD)
		.byte	$97,$E1		; OSBYTE 123  (&E197)
		.byte	$73,$E6		; OSBYTE 124  (&E673)
		.byte	$74,$E6		; OSBYTE 125  (&E674)
		.byte	$5C,$E6		; OSBYTE 126  (&E65C)
		.byte	$35,$E0		; OSBYTE 127  (&E035)
		.byte	$4F,$E7		; OSBYTE 128  (&E74F)
		.byte	$13,$E7		; OSBYTE 129  (&E713)
		.byte	$29,$E7		; OSBYTE 130  (&E729)
		.byte	$85,$F0		; OSBYTE 131  (&F085)
		.byte	$23,$D9		; OSBYTE 132  (&D923)
		.byte	$26,$D9		; OSBYTE 133  (&D926)
		.byte	$47,$D6		; OSBYTE 134  (&D647)
		.byte	$C2,$D7		; OSBYTE 135  (&D7C2)
		.byte	$57,$E6		; OSBYTE 136  (&E657)
		.byte	$7F,$E6		; OSBYTE 137  (&E67F)
		.byte	$AF,$E4		; OSBYTE 138  (&E4AF)
		.byte	$34,$E0		; OSBYTE 139  (&E034)
		.byte	$35,$F1		; OSBYTE 140  (&F135)
		.byte	$35,$F1		; OSBYTE 141  (&F135)
		.byte	$E7,$DB		; OSBYTE 142  (&DBE7)
		.byte	$68,$F1		; OSBYTE 143  (&F168)
		.byte	$E3,$EA		; OSBYTE 144  (&EAE3)
		.byte	$60,$E4		; OSBYTE 145  (&E460)
		.byte	$AA,$FF		; OSBYTE 146  (&FFAA)
		.byte	$F4,$EA		; OSBYTE 147  (&EAF4)
		.byte	$AE,$FF		; OSBYTE 148  (&FFAE)
		.byte	$F9,$EA		; OSBYTE 149  (&EAF9)
		.byte	$B2,$FF		; OSBYTE 150  (&FFB2)
		.byte	$FE,$EA		; OSBYTE 151  (&EAFE)
		.byte	$5B,$E4		; OSBYTE 152  (&E45B)
		.byte	$F3,$E4		; OSBYTE 153  (&E4F3)
		.byte	$FF,$E9		; OSBYTE 154  (&E9FF)
		.byte	$10,$EA		; OSBYTE 155  (&EA10)
		.byte	$7C,$E1		; OSBYTE 156  (&E17C)
		.byte	$A7,$FF		; OSBYTE 157  (&FFA7)
		.byte	$6D,$EE		; OSBYTE 158  (&EE6D)
		.byte	$7F,$EE		; OSBYTE 159  (&EE7F)
		.byte	$C0,$E9		; OSBYTE 160  (&E9C0)
		.byte	$9C,$E9		; OSBYTE 166+
		.byte	$59,$E6		; OSWORD &E0+


;*************************************************************************
;*                                                                       *
;*        OSWORD LOOK UP TABLE                                           *
;*                                                                       *
;*************************************************************************

		.byte	$02,$E9		; OSWORD   0  (&E902)
		.byte	$D5,$E8		; OSWORD   1  (&E8D5)
		.byte	$E8,$E8		; OSWORD   2  (&E8E8)
		.byte	$D1,$E8		; OSWORD   3  (&E8D1)
		.byte	$E4,$E8		; OSWORD   4  (&E8E4)
		.byte	$03,$E8		; OSWORD   5  (&E803)
		.byte	$0B,$E8		; OSWORD   6  (&E80B)
		.byte	$2D,$E8		; OSWORD   7  (&E82D)
		.byte	$AE,$E8		; OSWORD   8  (&E8AE)
		.byte	$35,$C7		; OSWORD   9  (&C735)
		.byte	$F3,$CB		; OSWORD  10  (&CBF3)
		.byte	$48,$C7		; OSWORD  11  (&C748)
		.byte	$E0,$C8		; OSWORD  12  (&C8E0)
		.byte	$CE,$D5		; OSWORD  13  (&D5CE)


;*************************************************************************
;*                                                                       *
;*       OSBYTE 136   Execute Code via User Vector                       *
;*                                                                       *
;*       *CODE effectively                                               *
;*                                                                       *
;*************************************************************************

		lda	#00		; A=0


;*************************************************************************
;*                                                                       *
;*       *LINE   entry                                                   *
;*                                                                       *
;*************************************************************************

		jmp	($0200)		; Jump via USERV


;*************************************************************************
;*                                                                       *
;*       OSBYTE  126  Acknowledge detection of ESCAPE condition          *
;*                                                                       *
;*************************************************************************

		ldx	#$00		; X=0
		bit	$FF		; if bit 7 not set there is no ESCAPE condition
		bpl	_BE673		; so E673
		lda	$0276		; else get ESCAPE Action, if this is 0
					; Clear ESCAPE
					; close EXEC files
					; purge all buffers
					; reset VDU paging counter
		bne	_BE671		; else do none of the above
		cli			; allow interrupts
		sta	$0269		; number of lines printed since last halt in paged
					; mode = 0
		jsr	_LF68D		; close any open EXEC files
		jsr	_LF0AA		; clear all buffers
_BE671:		ldx	#$FF		; X=&FF to indicate ESCAPE acknowledged


;*************************************************************************
;*                                                                       *
;*       OSBYTE  124  Clear ESCAPE condition                             *
;*                                                                       *
;*************************************************************************

_BE673:		clc			; clear carry


;*************************************************************************
;*                                                                       *
;*       OSBYTE  125  Set ESCAPE flag                                    *
;*                                                                       *
;*************************************************************************

_LE674:		ror	$FF		; clear  bit 7 of ESCAPE flag
		bit	$027a		; read bit 7 of Tube flag
		bmi	_BE67C		; if set TUBE exists so E67C
		rts			; else RETURN
					; 
_BE67C:		jmp	$0403		; Jump to Tube entry point


;*************************************************************************
;*                                                                       *
;*       OSBYTE  137  Turn on Tape motor                                 *
;*                                                                       *
;*************************************************************************

		lda	$0282		; get serial ULA control setting
		tay			; Y=A
		rol			; rotate left to get bit 7 into carry
		cpx	#$01		; if X=1 then user wants motor on so CARRY set else
					; carry is cleared
		ror			; put carry back in control RAM copy
		bvc	_LE6A7		; if bit 6 is clear then cassette is selected
					; so write to control register and RAM copy

		lda	#$38		; A=ASCII 8


;*************************************************************************
;*                                                                       *
;*       OSBYTE 08/07 set serial baud rates                              *
;*                                                                       *
;*************************************************************************
; ###     	on entry X=baud rate
; ###     	     A=8 transmit
; ###     	     A=7 receive

		eor	#$3F		; converts ASCII 8 to 7 binary and ASCII 7 to 8 binary
		sta	$FA		; store result
		ldy	$0282		; get serial ULA control register setting
		cpx	#$09		; is it 9 or more?
		bcs	_BE6AD		; if so exit
		and	_LE9AD,X		; and with byte from look up table
		sta	$FB		; store it
		tya			; put Y in A
		ora	$FA		; and or with Accumulator
		eor	$FA		; zero the three bits set true
		ora	$FB		; set up data read from look up table + bit 6
		ora	#$40		; 
		eor	$025d		; write cassette/RS423 flag

_LE6A7:		sta	$0282		; store serial ULA flag
		sta	$fe10		; and write to control register
_BE6AD:		tya			; put Y in A to save old contents
_BE6AE:		tax			; write new setting to X
		rts			; and return

; ### OS SERIES VII
; ### GEOFF COX

;*************************************************************************
;*                                                                       *
;*       OSBYTE  9   Duration of first colour                            *
;*                                                                       *
;*************************************************************************
;on entry Y=0, X=new value

		iny			; Y is incremented to 1
		clc			; clear carry


;*************************************************************************
;*                                                                       *
;*       OSBYTE  10   Duration of second colour                          *
;*                                                                       *
;*************************************************************************

;on entry Y=0 or 1 if from FX 9 call, X=new value

		lda	$0252,Y		; get mark period count
		pha			; push it
		txa			; get new count
		sta	$0252,Y		; store it
		pla			; get back original value
		tay			; put it in Y
		lda	$0251		; get value of flash counter
		bne	_BE6D1		; if not zero E6D1

		stx	$0251		; else restore old value
		lda	$0248		; get current video ULA control register setting
		php			; push flags
		ror			; rotate bit 0 into carry, carry into bit 7
		plp			; get back flags
		rol			; rotate back carry into bit 0
		sta	$0248		; store it in RAM copy
		sta	$fe20		; and ULA control register

_BE6D1:		bvc	_BE6AD		; then exit via OSBYTE 7/8


;*************************************************************************
;*                                                                       *
;*       OSBYTE  2   select input stream                                 *
;*                                                                       *
;*************************************************************************

;on input X contains stream number

		txa			; A=X
		and	#$01		; blank out bits 1 - 7
		pha			; push A
		lda	$0250		; and get current ACIA control setting
		rol			; Bit 7 into carry
		cpx	#$01		; if X>=1 then
		ror			; bit 7 of A=1
		cmp	$0250		; compare this with ACIA control setting
		php			; push processor
		sta	$0250		; put A into ACIA control setting
		sta	$fe08		; and write to control register
		jsr	_LE173		; set up RS423 buffer
		plp			; get back P
		beq	_BE6F1		; if new setting different from old E6F1 else
		bit	$fe09		; set bit 6 and 7

_BE6F1:		ldx	$0241		; get current input buffer number
		pla			; get back A
		sta	$0241		; store it
		rts			; and return


;*************************************************************************
;*                                                                       *
;*       OSBYTE  13   disable events                                     *
;*                                                                       *
;*************************************************************************

		; X contains event number 0-9

		tya			; Y=0 A=0


;*************************************************************************
;*                                                                       *
;*       OSBYTE  14   enable events                                      *
;*                                                                       *
;*************************************************************************
;X contains event number 0-9

		cpx	#$0A		; if X>9
		bcs	_BE6AE		; goto E6AE for exit
		ldy	$02bf,X		; else get event enable flag
		sta	$02bf,X		; store new value in flag
		bvc	_BE6AD		; and exit via E6AD


;*************************************************************************
;*                                                                       *
;*       OSBYTE  16   Select A/D channel                                 *
;*                                                                       *
;*************************************************************************
;X contains channel number or 0 if disable conversion

		beq	_BE70B		; if X=0 then E70B
		jsr	_LDE8C		; start conversion

_BE70B:		lda	$024d		; get  current maximum ADC channel number
		stx	$024d		; store new value
		tax			; put old value in X
		rts			; and exit


;*************************************************************************
;*                                                                       *
;*       OSBYTE 129   Read key within time limit                         *
;*                                                                       *
;*************************************************************************
;X and Y contains either time limit in centi seconds Y=&7F max
; or Y=&FF and X=-ve INKEY value

		tya			; A=Y
		bmi	_BE721		; if Y=&FF the E721
		cli			; else allow interrupts
		jsr	_LDEBB		; and go to timed routine
		bcs	_BE71F		; if carry set then E71F
		tax			; then X=A
		lda	#$00		; A=0

_BE71F:		tay			; Y=A
		rts			; and return
					; 
					; scan keyboard
_BE721:		txa			; A=X
		eor	#$7F		; convert to keyboard input
		tax			; X=A
		jsr	_LF068		; then scan keyboard
		rol			; put bit 7 into carry
_BE729:		ldx	#$FF		; X=&FF
		ldy	#$FF		; Y=&FF
		bcs	_BE731		; if bit 7 of A was set goto E731 (RTS)
		inx			; else X=0
		iny			; and Y=0
_BE731:		rts			; and exit

;********** check occupancy of input or free space of output buffer *******
		; X=buffer number
		; Buffer number  Address         Flag    Out pointer     In pointer
		; 0=Keyboard     3E0-3FF         2CF     2D8             2E1
		; 1=RS423 Input  A00-AFF         2D0     2D9             2E2
		; 2=RS423 output 900-9BF         2D1     2DA             2E3
		; 3=printer      880-8BF         2D2     2DB             2E4
		; 4=sound0       840-84F         2D3     2DC             2E5
		; 5=sound1       850-85F         2D4     2DD             2E6
		; 6=sound2       860-86F         2D5     2DE             2E7
		; 7=sound3       870-87F         2D6     2DF             2E8
		; 8=speech       8C0-8FF         2D7     2E0             2E9

_BE732:		txa			; buffer number in A
		eor	#$FF		; invert it
		tax			; X=A
		cpx	#$02		; is X>1
_LE738:		clv			; clear V flag
		bvc	_BE73E		; and goto E73E count buffer

_LE73B:		bit	_BD9B7		; set V
_BE73E:		jmp	($022e)		; CNPV defaults to E1D1

;************* check RS423 input buffer ************************************

_LE741:		sec	
		ldx	#$01		; X=1 to point to buffer
		jsr	_LE738		; and count it
		cpy	#$01		; if the hi byte of the answer is 1 or more
		bcs	_BE74E		; then Return
		cpx	$025b		; else compare with minimum buffer space
_BE74E:		rts			; and exit


;*************************************************************************
;*                                                                       *
;*       OSBYTE 128  READ ADC CHANNEL                                    *
;*                                                                       *
;*************************************************************************

;ON Entry: X=0             Exit Y contains number of last channel converted
;   	   X=channel number       X,Y contain 16 bit value read from channe
;   	   X<0 Y=&FF              X returns information about various buffers
;   	   X=&FF (keyboard )      X=number of characters in buffer
;   	   X=&FE (RS423 Input)    X=number of characters in buffer
;   	   X=&FD (RS423 output)   X=number of empty spaces in buffer
;   	   X=&FC (Printer)        X=number of empty spaces in buffer
;   	   X=&FB (sound 0)        X=number of empty spaces in buffer
;   	   X=&FA (sound 1)        X=number of empty spaces in buffer
;   	   X=&F9 (sound 2)        X=number of empty spaces in buffer
;   	   X=&F8 (sound 3)        X=number of empty spaces in buffer
;   	   X=&F7 (Speech )        X=number of empty spaces in buffer

		bmi	_BE732		; if X is -ve then E732 count spaces
		beq	_BE75F		; if X=0 then E75F
		cpx	#$05		; else check for Valid channel
		bcs	_BE729		; if not E729 set X & Y to 0 and exit
		ldy	$02b9,X		; get conversion values for channel of interest Hi &
		lda	$02b5,X		; lo byte
		tax			; X=lo byte
		rts			; and exit

_BE75F:		lda	$fe40		; read system VIA port B
		ror			; move high nybble to low
		ror			; 
		ror			; 
		ror			; 
		eor	#$FF		; and invert it
		and	#$03		; isolate the FIRE buttons
		ldy	$02be		; get analogue system flag byte
		stx	$02be		; store X here
		tax			; A=X bits 0 and 1 indicate fire buttons
		rts			; and return


;**************************************************************************
;**************************************************************************
;**                                                                      **
;**      OSBYTE  DEFAULT ENTRY POINT                                     **
;**                                                                      **
;**      pointed to by default BYTEV                                     **
;**                                                                      **
;**************************************************************************
;**************************************************************************

_LE772:		pha			; save A
		php			; save Processor flags
		sei			; disable interrupts
		sta	$EF		; store A,X,Y in zero page
		stx	$F0		; 
		sty	$F1		; 
		ldx	#$07		; X=7 to signal osbyte is being attempted
		cmp	#$75		; if A=0-116
		bcc	_BE7C2		; then E7C2
		cmp	#$A1		; if A<161
		bcc	_BE78E		; then E78E
		cmp	#$A6		; if A=161-165
		bcc	_BE7C8		; then EC78
		clc			; clear carry

_BE78A:		lda	#$A1		; A=&A1
		adc	#$00		; 

;********* process osbyte calls 117 - 160 *****************************

_BE78E:		sec			; set carry
		sbc	#$5F		; convert to &16 to &41 (22-65)

_BE791:		asl			; double it (44-130)
		sec			; set carry

_BE793:		sty	$F1		; store Y
		tay			; Y=A
		bit	$025e		; read econet intercept flag
		bpl	_BE7A2		; if no econet intercept required E7A2

		txa			; else A=X
		clv			; V=0
		jsr	_LE57E		; to JMP via ECONET vector
		bvs	_BE7BC		; if return with V set E7BC

_BE7A2:		lda	_LE5B3 + 1,Y		; get address from table
		sta	$FB		; store it as hi byte
		lda	_LE5B3,Y		; repeat for lo byte
		sta	$FA		; 
		lda	$EF		; restore A
		ldy	$F1		; Y
		bcs	_BE7B6		; if carry is set E7B6

		ldy	#$00		; else
		lda	($F0),Y		; get value from address pointed to by &F0/1 (Y,X)

_BE7B6:		sec			; set carry
		ldx	$F0		; restore X
		jsr	_LF058		; call &FA/B

_BE7BC:		ror			; C=bit 0
		plp			; get back flags
		rol			; bit 0=Carry
		pla			; get back A
		clv			; clear V
		rts			; and exit

;*************** Process OSBYTE CALLS BELOW &75 **************************

_BE7C2:		ldy	#$00		; Y=0
		cmp	#$16		; if A<&16
		bcc	_BE791		; goto E791

_BE7C8:		php			; push flags
		php			; push flags

_BE7CA:		pla			; pull flags
		pla			; pull flags
		jsr	_LF168		; offer paged ROMS service 7/8 unrecognised osbyte/word
		bne	_BE7D6		; if roms don't recognise it then E7D6
		ldx	$F0		; else restore X
		jmp	_BE7BC		; and exit

_BE7D6:		plp			; else pull flags
		pla			; and A
		bit	_BD9B7		; set V and C
		rts			; and return

_LE7DC:		lda	$EB		; read cassette critical flag bit 7 = busy
		bmi	_BE812		; if busy then EB12

		lda	#$08		; else A=8 to check current Catalogue status
		and	$E2		; by anding with CFS status flag
		bne	_BE7EA		; if not set (not in use) then E7EA RTS
		lda	#$88		; A=%10001000
		and	$BB		; AND with FS options (short msg bits)
_BE7EA:		rts			; RETURN


;**************************************************************************
;**************************************************************************
;**                                                                      **
;**      OSWORD  DEFAULT ENTRY POINT                                     **
;**                                                                      **
;**      pointed to by default WORDV                                     **
;**                                                                      **
;**************************************************************************
;**************************************************************************

_LE7EB:		pha			; Push A
		php			; Push flags
		sei			; disable interrupts
		sta	$EF		; store A,X,Y
		stx	$F0		; 
		sty	$F1		; 
		ldx	#$08		; X=8
		cmp	#$E0		; if A=>224
		bcs	_BE78A		; then E78A with carry set

		cmp	#$0E		; else if A=>14
		bcs	_BE7C8		; else E7C8 with carry set pass to ROMS & exit

		adc	#$44		; add to form pointer to table
		asl			; double it
		bcc	_BE793		; goto E793 ALWAYS!! (carry clear E7F8)
					; this reads bytes from table and enters routine


;*************************************************************************
;*                                                                       *
;*       OSWORD  05   ENTRY POINT                                        *
;*                                                                       *
;*       read a byte from I/O memory                                     *
;*                                                                       *
;*************************************************************************
;block of 4 bytes set at address pointed to by 00F0/1 (Y,X)
;XY +0  ADDRESS of byte
;   +4  on exit byte read

		jsr	_LE815		; set up address of data block
		lda	($F9,X)		; get byte
		sta	($F0),Y		; store it
		rts			; exit


;*************************************************************************
;*                                                                       *
;*       OSWORD  06   ENTRY POINT                                        *
;*                                                                       *
;*       write a byte to I/O memory                                      *
;*                                                                       *
;*************************************************************************
;block of 5 bytes set at address pointed to by 00F0/1 (Y,X)
;XY +0  ADDRESS of byte
;   +4  byte to be written

		jsr	_LE815		; set up address
		lda	($F0),Y		; get byte
		sta	($F9,X)		; store it
_BE812:		lda	#$00		; a=0
		rts			; exit

;********************: set up data block *********************************

_LE815:		sta	$FA		; &FA=A
		iny			; Y=1
		lda	($F0),Y		; get byte from block
		sta	$FB		; store it
		ldy	#$04		; Y=4
_BE81E:		ldx	#$01		; X=1
		rts			; and exit


;*************************************************************************
;*                                                                       *
;*       OSBYTE  00   ENTRY POINT                                        *
;*                                                                       *
;*       read OS version number                                          *
;*                                                                       *
;*************************************************************************

		bne	_BE81E		; if A <> 0 then exit else print error
		brk			; 
		.byte	$F7		; error number
		.byte	"OS 1.20"		; error message
		brk	


