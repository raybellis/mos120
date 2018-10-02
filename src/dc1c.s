;**************************************************************************
;**************************************************************************
;**                                                                      **
;**      MAIN IRQ Entry point                                            **
;**                                                                      **
;**                                                                      **
;**************************************************************************
;**************************************************************************
;ON ENTRY STACK contains        STATUS REGISTER,PCH,PCL                 ;

.org		$dc1c

_IRQ:		sta	$FC		; save A
		pla			; get back status (flags)
		pha			; and save again
		and	#$10		; check if BRK flag set
		bne	_BDC27		; if so goto DC27
		jmp	($0204)		; else JMP (IRQ1V)


;*************************************************************************
;*                                                                       *
;*               BRK handling routine                                    *
;*                                                                       *
;*************************************************************************

_BDC27:		txa			; save X on stack
		pha			; 
		tsx			; get status pointer
		lda	$0103,X		; get Program Counter lo
		cld			; 
		sec			; set carry
		sbc	#$01		; subtract 2 (1+carry)
		sta	$FD		; and store it in &FD
		lda	$0104,X		; get hi byte
		sbc	#$00		; subtract 1 if necessary
		sta	$FE		; and store in &FE
		lda	$F4		; get currently active ROM
		sta	$024a		; and store it in &24A
		stx	$F0		; store stack pointer in &F0
		ldx	#$06		; and issue ROM service call 6
		jsr	_LF168		; (User BRK) to ROMs
					; at this point &FD/E point to byte after BRK
					; ROMS may use BRK for their own purposes

		ldx	$028c		; get current language
		jsr	_LDC16		; and activate it
		pla			; get back original value of X
		tax			; 
		lda	$FC		; get back original value of A
		cli			; allow interrupts
		jmp	($0202)		; and JUMP via BRKV (normally into current language)


;*************************************************************************
;*                                                                       *
;*       DEFAULT BRK HANDLER                                             *
;*                                                                       *
;*************************************************************************

_LDC54:		ldy	#$00		; Y=0 to point to byte after BRK
		jsr	_LDEB1		; print message

		lda	$0267		; if BIT 0 set and DISC EXEC error
		ror			; occurs
_BDC5D:		bcs	_BDC5D		; hang up machine!!!!

		jsr	OSNEWL		; else print two newlines
		jsr	OSNEWL		; 
		jmp	_BDBB8		; and set tape speed before entering current
					; language

; ACIA IRQ, RxRDY but both Serial and Printer buffers empty
; ---------------------------------------------------------
_BDC68:		sec	
		ror	$024f		; Set b7 of RS423 busy flag
		bit	$0250		; check bit 7 of current ACIA control register
		bpl	_BDC78		; if interrupts NOT enabled DC78
		jsr	_LE741		; else E741 to check if serial buffer full
		ldx	#$00		; X=&00 to set RTS low
		bcs	_BDC7A		; if carry set goto DC7A to transfer data

_BDC78:		ldx	#$40		; X=&40 to set RTS high
_BDC7A:		jmp	_LE17A		; Jump to set ACIA control register

; Serial IRQ and RxRDY - Get byte and store in serial buffer
; ----------------------------------------------------------
_BDC7D:		ldy	$fe09		; Read data from ACIA
		and	#$3A		; Check PE:RO:FE:DCD
		bne	_BDCB8		; If any set, jump to generate Serial Error Event

; Serial IRQ and RxRDY, no errors
; -------------------------------
		ldx	$025c		; Read RS423 input suppression flag
		bne	_BDC92		; If not 0, jump to ignore
		inx			; X=1, serial input buffer
		jsr	_LE4F3		; Put byte in buffer
		jsr	_LE741		; Check if serial buffer almost full
		bcc	_BDC78		; If almost full, jump to set RTS high
_BDC92:		rts			; Return


;*************************************************************************
;*                                                                       *
;*       Main IRQ Handling routines, default IRQ1V destination           *
;*                                                                       *
;*************************************************************************

_LDC93:		cld			; Clear decimal flag
		lda	$FC		; Get original value of A
		pha			; Save it
		txa			; Save X
		pha			; 
		tya			; and Y
		pha			; 
		lda	#$DE		; Stack return address to &DE82
		pha	
		lda	#$81
		pha	
		clv			; Clear V flag
_LDCA2:		lda	$fe08		; Read ACIA status register
		bvs	_BDCA9		; b6 set, jump with serial parity error
		bpl	_BDD06		; b7=0, no ACIA interrupt, jump to check VIAs

; ACIA Interrupt or ACIA Parity Error
; -----------------------------------
_BDCA9:		ldx	$EA		; Get RS423 timeout counter
		dex			; Decrement it
		bmi	_BDCDE		; If 0 or <0, RS423 owns 6850, jump to DCDE
		bvs	_BDCDD		; If &41..&80, nobody owns 6850, jump to exit
		jmp	_LF588		; CFS owns 6850, jump to read ACIA in CFS routines

; ACIA Data Carrier Detect
; ------------------------
_BDCB3:		ldy	$fe09		; Read ACIA data
		rol	A		; 
		asl	A		; Rotate ACIA Status back
_BDCB8:		tax			; X=ACIA Status
		tya			; A=ACIA Data
		ldy	#$07		; Y=07 for RS423 Error Event
		jmp	_LE494		; Jump to issue event

; ACIA IRQ, TxRDY - Send a byte
; -----------------------------
_BDCBF:		ldx	#$02
		jsr	_LE460		; Read from Serial output buffer
		bcc	_BDCD6		; Buffer is not empty, jump to send byte
		lda	$0285		; Read printer destination
		cmp	#$02		; Is it serial printer??
		bne	_BDC68		; Serial buffer empty, not Serial printer, jump to ... DC68
		inx			; X=3 for Printer buffer
		jsr	_LE460		; Read from Printer buffer
		ror	$02d2		; Copy Byte Fetched/Not fetched into Printer Buffer full flag
		bmi	_BDC68		; Printer buffer was empty, so jump to ... DC68

_BDCD6:		sta	$fe09		; Send byte to ACIA
		lda	#$E7		; Set timeout counter to &E7
		sta	$EA		; Serial owns 6850 for 103 more calls
_BDCDD:		rts			; Exit IRQ

; RS423 owns 6850, PE or RxRDY interupt occured
; ---------------------------------------------
; On entry, A contains ACIA status
;
_BDCDE:		and	$0278		; AND with ACIA IRQ mask (normally &FF)
		lsr	A		; Move RxRDY into Carry
		bcc	_BDCEB		; If no RxData, jump to check DCD and TxRDY
;
; Data in RxData, check for errors
;
		bvs	_BDCEB		; If IRQ=1 (now in b6) RxIRQ must have occured, so jump to DCEB
;
; RxData but no RxIRQ, check that IRQs are actually disabled
;
		ldy	$0250		; Get ACIA control setting
		bmi	_BDC7D		; If bit 7=1, IRQs enabled so jump to read byte and insert into buffer
;
; DCE9 -> RxData, no RxIRQ, IRQs disabled
; DCE4 -> RxData and RxIRQ
; DCE2 -> No RxData
;
; Check TxRDY and DCD, if neither set, send a Serial Error Event
; --------------------------------------------------------------
_BDCEB:		lsr	A		; Move TxRDY into Carry
		ror	A		; Rotate TxRDY into b7 and DCD into Carry
		bcs	_BDCB3		; If Data Carrier Detected, jump to DCB3
		bmi	_BDCBF		; If TxRDY (now in b7) jump to to DCBF to send a byte
		bvs	_BDCDD		; b6 should always be zero by now, but if set, then jump to exit

; Issue Unknown Interupt service call
; ===================================
_BDCF3:		ldx	#$05
		jsr	_LF168		; Issue service call 5, 'Unknown Interrupt'
		beq	_BDCDD		; If claimed, then jump to exit
		pla			; Otherwise drop return address from stack
		pla			; 
		pla			; And restore registers
		tay			; 
		pla			; 
		tax			; 
		pla			; 
		sta	$FC		; Store A in IRQA
		jmp	($0206)		; And pass the IRQ in to IRQ2V


;*************************************************************************
;*                                                                       *
;* VIA INTERUPTS ROUTINES                                                *
;*                                                                       *
;*************************************************************************

_BDD06:		lda	$fe4d		; Read System VIA interrupt flag register
		bpl	_BDD47		; No System VIA interrupt, jump to check User VIA

; System VIA interupt
;
		and	$0279		; Mask with System VIA bit mask
		and	$fe4e		; and interrupt enable register
		ror			; Rotate to check for CA1 interupt (frame sync)
		ror			; 
		bcc	_BDD69		; No CA1 (frame sync), jump to check speech

; System VIA CA1 interupt (Frame Sync)
;
		dec	$0240		; decrement vertical sync counter
		lda	$EA		; A=RS423 Timeout counter
		bpl	_BDD1E		; if +ve then DD1E
		inc	$EA		; else increment it
_BDD1E:		lda	$0251		; load flash counter
		beq	_BDD3D		; if 0 then system is not in use, ignore it
		dec	$0251		; else decrement counter
		bne	_BDD3D		; and if not 0 go on past reset routine

		ldx	$0252		; else get mark period count in X
		lda	$0248		; current VIDEO ULA control setting in A
		lsr			; shift bit 0 into C to check if first colour
		bcc	_BDD34		; is effective if so C=0 jump to DD34

		ldx	$0253		; else get space period count in X
_BDD34:		rol			; restore bit
		eor	#$01		; and invert it
		jsr	_LEA00		; then change colour

		stx	$0251		; &0251=X resetting the counter

_BDD3D:		ldy	#$04		; Y=4 and call E494 to check and implement vertical
		jsr	_LE494		; sync event (4) if necessary
		lda	#$02		; A=2
		jmp	_LDE6E		; clear interrupt 1 and exit


;*************************************************************************
;*                                                                       *
;*       PRINTER INTERRUPT USER VIA 1                                    *
;*                                                                       *
;*************************************************************************

_BDD47:		lda	$fe6d		; Read User VIA interrupt flag register
		bpl	_BDCF3		; No User VIA interrupt, jump to pass to ROMs

; User VIA interupt
;
		and	$0277		; else check for USER IRQ 1
		and	$fe6e		; 
		ror			; 
		ror			; 
		bcc	_BDCF3		; if bit 1=0 the no interrupt 1 so DCF3
		ldy	$0285		; else get printer type
		dey			; decrement
		bne	_BDCF3		; if not parallel then DCF3
		lda	#$02		; reset interrupt 1 flag
		sta	$fe6d		; 
		sta	$fe6e		; disable interrupt 1
		ldx	#$03		; and output data to parallel printer
		jmp	_LE13A		; 


;*************************************************************************
;*                                                                       *
;*       SYSTEM INTERRUPT 5   Speech                                     *
;*                                                                       *
;*************************************************************************

_BDD69:		rol			; Rotate bit 5 into bit 7
		rol			; 
		rol			; 
		rol			; 
		bpl	_BDDCA		; Not a Timer 2 interrupt, jump to check timers

; System VIA Timer 2 interupt - Speech interupt
;
		lda	#$20		; Prepare to clear VIA interupt
		ldx	#$00
		sta	$fe4d		; Clear VIA interupt
		stx	$fe49		; Zero high byte of T2 Timer
_LDD79:		ldx	#$08		; X=8 for Speech buffer
		stx	$FB		; Prepare to loop up to four times for Speak from RAM

_BDD7D:		jsr	_LE45B		; Examine Speech buffer
		ror	$02d7		; Shift carry into bit 7
		bmi	_BDDC9		; Buffer empty, so exit
		tay			; Buffer not empty, A=first byte waiting
		beq	_BDD8D		; Waiting byte=&00 (Speak, no reset), skip past
		jsr	_LEE6D		; control speech chip
		bmi	_BDDC9		; if negative exit

_BDD8D:		jsr	_LE460		; Fetch Speech command byte from buffer
		sta	$F5		; Store it
		jsr	_LE460		; Fetch Speech word high byte from buffer
		sta	$F7		; Store it
		jsr	_LE460		; Fetch Speech word low byte from buffer
		sta	$F6		; Store it, giving &F6/7=address to be accessed
		ldy	$F5		; Y=Speech command byte
		beq	_BDDBB		; SOUND &FF00 - Speak from RAM, no reset
		bpl	_BDDB8		; SOUND &FF01-&FF7F - Speak from RAM, with reset
		bit	$F5		; Check bit 6 of Speech command
		bvs	_BDDAB		; SOUND &FFC0-&FFFF - Speak word number

; SOUND &FF80-&FFBF - Speak from absolute address
; &F5=command &80-&BF (b0-b3=PHROM number), &F6/7=address
;
		jsr	_LEEBB		; Write address to speech processor
		bvc	_BDDB2		; Skip forward to speak from selected address

; SOUND &FFC0-&FFFF - Speak word number
; &F5=command &C0-&FF (b0-b3=PHROM number), &F6/7=word number
;
_BDDAB:		asl	$F6		; Multiply address by 2 to index into word table
		rol	$F7		; 
		jsr	_LEE3B		; Read address from specified PHROM

; Speak from PHROM address
; By now, the address in the PHROM specified in Command b0-b3 has been set
; to the start of the speech data to be voiced.
;
_BDDB2:		ldy	$0261		; Fetch command code, usually &50=Speak or &00=Nop
		jmp	_LEE7F		; Jump to send command to speak from current address

; SOUND &FF01-&FF7F - Speak from RAM with reset
; Y=Speech command byte, &F6/7=Speech data
; Use SOUND &FF60 to send Speak External command
;
_BDDB8:		jsr	_LEE7F		; Send command byte to Speech processor

; SOUND &FF00 - Speak from RAM without reset
; &6/7=Speech data
;
_BDDBB:		ldy	$F6
		jsr	_LEE7F		; Send Speech data low byte
		ldy	$F7
		jsr	_LEE7F		; Send Speech data high byte
		lsr	$FB		; Shift loop counter
		bne	_BDD7D		; Loop to send up to four byte-pairs
_BDDC9:		rts	

;***********************************************************************
;*                                                                       *
;*       SYSTEM INTERRUPT 6 10mS Clock                                   *
;*                                                                       *
;*************************************************************************

_BDDCA:		bcc	_BDE47		; bit 6 is in carry so if clear there is no 6 int
					; so go on to DE47
		lda	#$40		; Clear interrupt 6
		sta	$fe4d		; 

;UPDATE timers routine, There are 2 timer stores &292-6 and &297-B
;these are updated by adding 1 to the current timer and storing the
;result in the other, the direction of transfer being changed each
;time of update.  This ensures that at least 1 timer is valid at any call
;as the current timer is only read.  Other methods would cause inaccuracies
;if a timer was read whilst being updated.

		lda	$0283		; get current system clock store pointer (5,or 10)
		tax			; put A in X
		eor	#$0F		; and invert lo nybble (5 becomes 10 and vv)
		pha			; store A
		tay			; put A in Y

		; Carry is always set at this point
_BDDD9:		lda	$0291,X		; get timer value
		adc	#$00		; update it
		sta	$0291,Y		; store result in alternate
		dex			; decrement X
		beq	_BDDE7		; if 0 exit
		dey			; else decrement Y
		bne	_BDDD9		; and go back and do next byte

_BDDE7:		pla			; get back A
		sta	$0283		; and store back in clock pointer (i.e. inverse previous
					; contents)
		ldx	#$05		; set loop pointer for countdown timer
_BDDED:		inc	$029b,X		; increment byte and if
		bne	_BDDFA		; not 0 then DDFA
		dex			; else decrement pointer
		bne	_BDDED		; and if not 0 do it again
		ldy	#$05		; process EVENT 5 interval timer
		jsr	_LE494		; 

_BDDFA:		lda	$02b1		; get byte of inkey countdown timer
		bne	_BDE07		; if not 0 then DE07
		lda	$02b2		; else get next byte
		beq	_BDE0A		; if 0 DE0A
		dec	$02b2		; decrement 2B2
_BDE07:		dec	$02b1		; and 2B1

_BDE0A:		bit	$02ce		; read bit 7 of envelope processing byte
		bpl	_BDE1A		; if 0 then DE1A
		inc	$02ce		; else increment to 0
		cli			; allow interrupts
		jsr	_LEB47		; and do routine sound processes
		sei			; bar interrupts
		dec	$02ce		; DEC envelope processing byte back to 0

_BDE1A:		bit	$02d7		; read speech buffer busy flag
		bmi	_BDE2B		; if set speech buffer is empty, skip routine
		jsr	_LEE6D		; update speech system variables
		eor	#$A0		; 
		cmp	#$60		; 
		bcc	_BDE2B		; if result >=&60 DE2B
		jsr	_LDD79		; else more speech work

_BDE2B:		bit	_BD9B7		; set V and C
		jsr	_LDCA2		; check if ACIA needs attention
		lda	$EC		; check if key has been pressed
		ora	$ED		; 
		and	$0242		; (this is 0 if keyboard is to be ignored, else &FF)
		beq	_BDE3E		; if 0 ignore keyboard
		sec			; else set carry
		jsr	_LF065		; and call keyboard
_BDE3E:		jsr	_LE19B		; check for data in user defined printer channel
		bit	$fec0		; if ADC bit 6 is set ADC is not busy
		bvs	_BDE4A		; so DE4A
		rts			; else return


;*************************************************************************
;*                                                                       *
;*       SYSTEM INTERRUPT 4 ADC end of conversion                        *
;*                                                                       *
;*************************************************************************

_BDE47:		rol			; put original bit 4 from FE4D into bit 7 of A
		bpl	_BDE72		; if not set DE72

_BDE4A:		ldx	$024c		; else get current ADC channel
		beq	_BDE6C		; if 0 DE6C
		lda	$fec2		; read low data byte
		sta	$02b5,X		; store it in &2B6,7,8 or 9
		lda	$fec1		; get high data byte
		sta	$02b9,X		; and store it in hi byte
		stx	$02be		; store in Analogue system flag marking last channel
		ldy	#$03		; handle event 3 conversion complete
		jsr	_LE494		; 

		dex			; decrement X
		bne	_BDE69		; if X=0
		ldx	$024d		; get highest ADC channel preseny
_BDE69:		jsr	_LDE8F		; and start new conversion
_BDE6C:		lda	#$10		; reset interrupt 4
_LDE6E:		sta	$fe4d		; 
		rts			; and return


;*************************************************************************
;*                                                                       *
;*       SYSTEM INTERRUPT 0 Keyboard                                     *
;*                                                                       *
;*************************************************************************

_BDE72:		rol			; get original bit 0 in bit 7 position
		rol			; 
		rol			; 
		rol			; 
		bpl	_BDE7F		; if bit 7 clear not a keyboard interrupt
		jsr	_LF065		; else scan keyboard
		lda	#$01		; A=1
		bne	_LDE6E		; and off to reset interrupt and exit

_BDE7F:		jmp	_BDCF3		; 

;************** exit routine *********************************************

		pla			; restore registers
		tay			; 
		pla			; 
		tax			; 
		pla			; 
		sta	$FC		; store A


;*************************************************************************
;*                                                                       *
;*       IRQ2V default entry                                             *
;*                                                                       *
;*************************************************************************

_LDE89:		lda	$FC		; get back original value of A
		rti			; and return to calling routine


;*************************************************************************
;*                                                                       *
;*       OSBYTE 17 Start conversion                                      *
;*                                                                       *
;*************************************************************************

_LDE8C:		sty	$02be		; set last channel to finish conversion
_LDE8F:		cpx	#$05		; if X<4 then
		bcc	_BDE95		; DE95
		ldx	#$04		; else X=4

_BDE95:		stx	$024c		; store it as current ADC channel
		ldy	$024e		; get conversion type
		dey			; decrement
		tya			; A=Y
		and	#$08		; and it with 08
		clc			; clear carry
		adc	$024c		; add to current ADC
		sbc	#$00		; -1
		sta	$fec0		; store to the A/D control panel
		rts			; and return

_LDEA9:		lda	#$C3		; point to start of string @&C300
_LDEAB:		sta	$FE		; store it
		lda	#$00		; point to lo byte
		sta	$FD		; store it and start loop@

_LDEB1:		iny			; print character in string
		lda	($FD),Y		; pointed to by &FD/E
		jsr	OSASCI		; print it expanding Carriage returns
		tax			; store A in X
		bne	_LDEB1		; and loop again if not =0
		rts			; else exit

;*********** OSBYTE 129 TIMED ROUTINE ******************************
;ON ENTRY TIME IS IN X,Y

_LDEBB:		stx	$02b1		; store time in INKEY countdown timer
		sty	$02b2		; which is decremented every 10ms
		lda	#$FF		; A=&FF to flag timed wait
		bne	_BDEC7		; goto DEC7


;**************************************************************************
;**************************************************************************
;**                                                                      **
;**      OSRDCH Default entry point                                      **
;**                                                                      **
;**      RDCHV entry point       read a character                        **
;**                                                                      **
;**************************************************************************
;**************************************************************************

_LDEC5:		lda	#$00		; A=0 to flag wait forever

_BDEC7:		sta	$E6		; store entry value of A
		txa			; save X and Y
		pha			; 
		tya			; 
		pha			; 
		ldy	$0256		; get *EXEC file handle
		beq	_BDEE6		; if 0 (not open) then DEE6
		sec			; set carry
		ror	$EB		; set bit 7 of CFS active flag to prevent clashes
		jsr	OSBGET		; get a byte from the file
		php			; push processor flags to preserve carry
		lsr	$EB		; restore &EB
		plp			; get back flags
		bcc	_BDF03		; and if carry clear, character found so exit via DF03
		lda	#$00		; else A=00 as EXEC file empty
		sta	$0256		; store it in exec file handle
		jsr	OSFIND		; and close file via OSFIND

_BDEE6:		bit	$FF		; check ESCAPE flag, if bit 7 set Escape pressed
		bmi	_BDF00		; so off to DF00
		ldx	$0241		; else get current input buffer number
		jsr	_LE577		; get a byte from input buffer
		bcc	_BDF03		; and exit if character returned

		bit	$E6		; (E6=0 or FF)
		bvc	_BDEE6		; if entry was OSRDCH not timed keypress, so go back and
					; do it again i.e. perform GET function
		lda	$02b1		; else check timers
		ora	$02b2		; 
		bne	_BDEE6		; and if not zero go round again
		bcs	_BDF05		; else exit

;; duplicate code
; DEF0	BCC &DF03
; DEF2	BIT &E6
; DEF4	BVC &DEE6
; DEF6	LDA &02B1
; DEF9	ORA &02B2
; DEFC	BNE &DEE6
; DEFE	BCS &DF05

_BDF00:		sec	
		lda	#$1B
_BDF03:		sta	$E6
_BDF05:		pla	
		tay	
		pla	
		tax	
		lda	$E6
		rts	


