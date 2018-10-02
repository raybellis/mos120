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

		sta	$FC		; save A
		pla			; get back status (flags)
		pha			; and save again
		and	#$10		; check if BRK flag set
		bne	$DC27		; if so goto DC27
		jmp	($0204)		; else JMP (IRQ1V)


;*************************************************************************
;*                                                                       *
;*               BRK handling routine                                    *
;*                                                                       *
;*************************************************************************

		txa			; save X on stack
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
		sta	$024A		; and store it in &24A
		stx	$F0		; store stack pointer in &F0
		ldx	#$06		; and issue ROM service call 6
		jsr	$F168		; (User BRK) to ROMs
					; at this point &FD/E point to byte after BRK
					; ROMS may use BRK for their own purposes

		ldx	$028C		; get current language
		jsr	$DC16		; and activate it
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

		ldy	#$00		; Y=0 to point to byte after BRK
		jsr	$DEB1		; print message

		lda	$0267		; if BIT 0 set and DISC EXEC error
		ror			; occurs
		bcs	$DC5D		; hang up machine!!!!

		jsr	OSNEWL		; else print two newlines
		jsr	OSNEWL		; 
		jmp	$DBB8		; and set tape speed before entering current
					; language

; ACIA IRQ, RxRDY but both Serial and Printer buffers empty
; ---------------------------------------------------------
		sec	
		ror	$024F		; Set b7 of RS423 busy flag
		bit	$0250		; check bit 7 of current ACIA control register
		bpl	$DC78		; if interrupts NOT enabled DC78
		jsr	$E741		; else E741 to check if serial buffer full
		ldx	#$00		; X=&00 to set RTS low
		bcs	$DC7A		; if carry set goto DC7A to transfer data

		ldx	#$40		; X=&40 to set RTS high
		jmp	$E17A		; Jump to set ACIA control register

; Serial IRQ and RxRDY - Get byte and store in serial buffer
; ----------------------------------------------------------
		ldy	$FE09		; Read data from ACIA
		and	#$3A		; Check PE:RO:FE:DCD
		bne	$DCB8		; If any set, jump to generate Serial Error Event

; Serial IRQ and RxRDY, no errors
; -------------------------------
		ldx	$025C		; Read RS423 input suppression flag
		bne	$DC92		; If not 0, jump to ignore
		inx			; X=1, serial input buffer
		jsr	$E4F3		; Put byte in buffer
		jsr	$E741		; Check if serial buffer almost full
		bcc	$DC78		; If almost full, jump to set RTS high
		rts			; Return


;*************************************************************************
;*                                                                       *
;*       Main IRQ Handling routines, default IRQ1V destination           *
;*                                                                       *
;*************************************************************************

		cld			; Clear decimal flag
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
		lda	$FE08		; Read ACIA status register
		bvs	$DCA9		; b6 set, jump with serial parity error
		bpl	$DD06		; b7=0, no ACIA interrupt, jump to check VIAs

; ACIA Interrupt or ACIA Parity Error
; -----------------------------------
		ldx	$EA		; Get RS423 timeout counter
		dex			; Decrement it
		bmi	$DCDE		; If 0 or <0, RS423 owns 6850, jump to DCDE
		bvs	$DCDD		; If &41..&80, nobody owns 6850, jump to exit
		jmp	$F588		; CFS owns 6850, jump to read ACIA in CFS routines

; ACIA Data Carrier Detect
; ------------------------
		ldy	$FE09		; Read ACIA data
		rol	A		; 
		asl	A		; Rotate ACIA Status back
		tax			; X=ACIA Status
		tya			; A=ACIA Data
		ldy	#$07		; Y=07 for RS423 Error Event
		jmp	$E494		; Jump to issue event

; ACIA IRQ, TxRDY - Send a byte
; -----------------------------
		ldx	#$02
		jsr	$E460		; Read from Serial output buffer
		bcc	$DCD6		; Buffer is not empty, jump to send byte
		lda	$0285		; Read printer destination
		cmp	#$02		; Is it serial printer??
		bne	$DC68		; Serial buffer empty, not Serial printer, jump to ... DC68
		inx			; X=3 for Printer buffer
		jsr	$E460		; Read from Printer buffer
		ror	$02D2		; Copy Byte Fetched/Not fetched into Printer Buffer full flag
		bmi	$DC68		; Printer buffer was empty, so jump to ... DC68

		sta	$FE09		; Send byte to ACIA
		lda	#$E7		; Set timeout counter to &E7
		sta	$EA		; Serial owns 6850 for 103 more calls
		rts			; Exit IRQ

; RS423 owns 6850, PE or RxRDY interupt occured
; ---------------------------------------------
; On entry, A contains ACIA status
;
		and	$0278		; AND with ACIA IRQ mask (normally &FF)
		lsr	A		; Move RxRDY into Carry
		bcc	$DCEB		; If no RxData, jump to check DCD and TxRDY
;
; Data in RxData, check for errors
;
		bvs	$DCEB		; If IRQ=1 (now in b6) RxIRQ must have occured, so jump to DCEB
;
; RxData but no RxIRQ, check that IRQs are actually disabled
;
		ldy	$0250		; Get ACIA control setting
		bmi	$DC7D		; If bit 7=1, IRQs enabled so jump to read byte and insert into buffer
;
; DCE9 -> RxData, no RxIRQ, IRQs disabled
; DCE4 -> RxData and RxIRQ
; DCE2 -> No RxData
;
; Check TxRDY and DCD, if neither set, send a Serial Error Event
; --------------------------------------------------------------
		lsr	A		; Move TxRDY into Carry
		ror	A		; Rotate TxRDY into b7 and DCD into Carry
		bcs	$DCB3		; If Data Carrier Detected, jump to DCB3
		bmi	$DCBF		; If TxRDY (now in b7) jump to to DCBF to send a byte
		bvs	$DCDD		; b6 should always be zero by now, but if set, then jump to exit

; Issue Unknown Interupt service call
; ===================================
		ldx	#$05
		jsr	$F168		; Issue service call 5, 'Unknown Interrupt'
		beq	$DCDD		; If claimed, then jump to exit
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

		lda	$FE4D		; Read System VIA interrupt flag register
		bpl	$DD47		; No System VIA interrupt, jump to check User VIA

; System VIA interupt
;
		and	$0279		; Mask with System VIA bit mask
		and	$FE4E		; and interrupt enable register
		ror			; Rotate to check for CA1 interupt (frame sync)
		ror			; 
		bcc	$DD69		; No CA1 (frame sync), jump to check speech

; System VIA CA1 interupt (Frame Sync)
;
		dec	$0240		; decrement vertical sync counter
		lda	$EA		; A=RS423 Timeout counter
		bpl	$DD1E		; if +ve then DD1E
		inc	$EA		; else increment it
		lda	$0251		; load flash counter
		beq	$DD3D		; if 0 then system is not in use, ignore it
		dec	$0251		; else decrement counter
		bne	$DD3D		; and if not 0 go on past reset routine

		ldx	$0252		; else get mark period count in X
		lda	$0248		; current VIDEO ULA control setting in A
		lsr			; shift bit 0 into C to check if first colour
		bcc	$DD34		; is effective if so C=0 jump to DD34

		ldx	$0253		; else get space period count in X
		rol			; restore bit
		eor	#$01		; and invert it
		jsr	$EA00		; then change colour

		stx	$0251		; &0251=X resetting the counter

		ldy	#$04		; Y=4 and call E494 to check and implement vertical
		jsr	$E494		; sync event (4) if necessary
		lda	#$02		; A=2
		jmp	$DE6E		; clear interrupt 1 and exit


;*************************************************************************
;*                                                                       *
;*       PRINTER INTERRUPT USER VIA 1                                    *
;*                                                                       *
;*************************************************************************

		lda	$FE6D		; Read User VIA interrupt flag register
		bpl	$DCF3		; No User VIA interrupt, jump to pass to ROMs

; User VIA interupt
;
		and	$0277		; else check for USER IRQ 1
		and	$FE6E		; 
		ror			; 
		ror			; 
		bcc	$DCF3		; if bit 1=0 the no interrupt 1 so DCF3
		ldy	$0285		; else get printer type
		dey			; decrement
		bne	$DCF3		; if not parallel then DCF3
		lda	#$02		; reset interrupt 1 flag
		sta	$FE6D		; 
		sta	$FE6E		; disable interrupt 1
		ldx	#$03		; and output data to parallel printer
		jmp	$E13A		; 


;*************************************************************************
;*                                                                       *
;*       SYSTEM INTERRUPT 5   Speech                                     *
;*                                                                       *
;*************************************************************************

		rol			; Rotate bit 5 into bit 7
		rol			; 
		rol			; 
		rol			; 
		bpl	$DDCA		; Not a Timer 2 interrupt, jump to check timers

; System VIA Timer 2 interupt - Speech interupt
;
		lda	#$20		; Prepare to clear VIA interupt
		ldx	#$00
		sta	$FE4D		; Clear VIA interupt
		stx	$FE49		; Zero high byte of T2 Timer
		ldx	#$08		; X=8 for Speech buffer
		stx	$FB		; Prepare to loop up to four times for Speak from RAM

		jsr	$E45B		; Examine Speech buffer
		ror	$02D7		; Shift carry into bit 7
		bmi	$DDC9		; Buffer empty, so exit
		tay			; Buffer not empty, A=first byte waiting
		beq	$DD8D		; Waiting byte=&00 (Speak, no reset), skip past
		jsr	$EE6D		; control speech chip
		bmi	$DDC9		; if negative exit

		jsr	$E460		; Fetch Speech command byte from buffer
		sta	$F5		; Store it
		jsr	$E460		; Fetch Speech word high byte from buffer
		sta	$F7		; Store it
		jsr	$E460		; Fetch Speech word low byte from buffer
		sta	$F6		; Store it, giving &F6/7=address to be accessed
		ldy	$F5		; Y=Speech command byte
		beq	$DDBB		; SOUND &FF00 - Speak from RAM, no reset
		bpl	$DDB8		; SOUND &FF01-&FF7F - Speak from RAM, with reset
		bit	$F5		; Check bit 6 of Speech command
		bvs	$DDAB		; SOUND &FFC0-&FFFF - Speak word number

; SOUND &FF80-&FFBF - Speak from absolute address
; &F5=command &80-&BF (b0-b3=PHROM number), &F6/7=address
;
		jsr	$EEBB		; Write address to speech processor
		bvc	$DDB2		; Skip forward to speak from selected address

; SOUND &FFC0-&FFFF - Speak word number
; &F5=command &C0-&FF (b0-b3=PHROM number), &F6/7=word number
;
		asl	$F6		; Multiply address by 2 to index into word table
		rol	$F7		; 
		jsr	$EE3B		; Read address from specified PHROM

; Speak from PHROM address
; By now, the address in the PHROM specified in Command b0-b3 has been set
; to the start of the speech data to be voiced.
;
		ldy	$0261		; Fetch command code, usually &50=Speak or &00=Nop
		jmp	$EE7F		; Jump to send command to speak from current address

; SOUND &FF01-&FF7F - Speak from RAM with reset
; Y=Speech command byte, &F6/7=Speech data
; Use SOUND &FF60 to send Speak External command
;
		jsr	$EE7F		; Send command byte to Speech processor

; SOUND &FF00 - Speak from RAM without reset
; &6/7=Speech data
;
		ldy	$F6
		jsr	$EE7F		; Send Speech data low byte
		ldy	$F7
		jsr	$EE7F		; Send Speech data high byte
		lsr	$FB		; Shift loop counter
		bne	$DD7D		; Loop to send up to four byte-pairs
		rts	

;***********************************************************************
;*                                                                       *
;*       SYSTEM INTERRUPT 6 10mS Clock                                   *
;*                                                                       *
;*************************************************************************

		bcc	$DE47		; bit 6 is in carry so if clear there is no 6 int
					; so go on to DE47
		lda	#$40		; Clear interrupt 6
		sta	$FE4D		; 

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
		lda	$0291,X		; get timer value
		adc	#$00		; update it
		sta	$0291,Y		; store result in alternate
		dex			; decrement X
		beq	$DDE7		; if 0 exit
		dey			; else decrement Y
		bne	$DDD9		; and go back and do next byte

		pla			; get back A
		sta	$0283		; and store back in clock pointer (i.e. inverse previous
					; contents)
		ldx	#$05		; set loop pointer for countdown timer
		inc	$029B,X		; increment byte and if
		bne	$DDFA		; not 0 then DDFA
		dex			; else decrement pointer
		bne	$DDED		; and if not 0 do it again
		ldy	#$05		; process EVENT 5 interval timer
		jsr	$E494		; 

		lda	$02B1		; get byte of inkey countdown timer
		bne	$DE07		; if not 0 then DE07
		lda	$02B2		; else get next byte
		beq	$DE0A		; if 0 DE0A
		dec	$02B2		; decrement 2B2
		dec	$02B1		; and 2B1

		bit	$02CE		; read bit 7 of envelope processing byte
		bpl	$DE1A		; if 0 then DE1A
		inc	$02CE		; else increment to 0
		cli			; allow interrupts
		jsr	$EB47		; and do routine sound processes
		sei			; bar interrupts
		dec	$02CE		; DEC envelope processing byte back to 0

		bit	$02D7		; read speech buffer busy flag
		bmi	$DE2B		; if set speech buffer is empty, skip routine
		jsr	$EE6D		; update speech system variables
		eor	#$A0		; 
		cmp	#$60		; 
		bcc	$DE2B		; if result >=&60 DE2B
		jsr	$DD79		; else more speech work

		bit	$D9B7		; set V and C
		jsr	$DCA2		; check if ACIA needs attention
		lda	$EC		; check if key has been pressed
		ora	$ED		; 
		and	$0242		; (this is 0 if keyboard is to be ignored, else &FF)
		beq	$DE3E		; if 0 ignore keyboard
		sec			; else set carry
		jsr	$F065		; and call keyboard
		jsr	$E19B		; check for data in user defined printer channel
		bit	$FEC0		; if ADC bit 6 is set ADC is not busy
		bvs	$DE4A		; so DE4A
		rts			; else return


;*************************************************************************
;*                                                                       *
;*       SYSTEM INTERRUPT 4 ADC end of conversion                        *
;*                                                                       *
;*************************************************************************

		rol			; put original bit 4 from FE4D into bit 7 of A
		bpl	$DE72		; if not set DE72

		ldx	$024C		; else get current ADC channel
		beq	$DE6C		; if 0 DE6C
		lda	$FEC2		; read low data byte
		sta	$02B5,X		; store it in &2B6,7,8 or 9
		lda	$FEC1		; get high data byte
		sta	$02B9,X		; and store it in hi byte
		stx	$02BE		; store in Analogue system flag marking last channel
		ldy	#$03		; handle event 3 conversion complete
		jsr	$E494		; 

		dex			; decrement X
		bne	$DE69		; if X=0
		ldx	$024D		; get highest ADC channel preseny
		jsr	$DE8F		; and start new conversion
		lda	#$10		; reset interrupt 4
		sta	$FE4D		; 
		rts			; and return


;*************************************************************************
;*                                                                       *
;*       SYSTEM INTERRUPT 0 Keyboard                                     *
;*                                                                       *
;*************************************************************************

		rol			; get original bit 0 in bit 7 position
		rol			; 
		rol			; 
		rol			; 
		bpl	$DE7F		; if bit 7 clear not a keyboard interrupt
		jsr	$F065		; else scan keyboard
		lda	#$01		; A=1
		bne	$DE6E		; and off to reset interrupt and exit

		jmp	$DCF3		; 

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

		lda	$FC		; get back original value of A
		rti			; and return to calling routine


;*************************************************************************
;*                                                                       *
;*       OSBYTE 17 Start conversion                                      *
;*                                                                       *
;*************************************************************************

		sty	$02BE		; set last channel to finish conversion
		cpx	#$05		; if X<4 then
		bcc	$DE95		; DE95
		ldx	#$04		; else X=4

		stx	$024C		; store it as current ADC channel
		ldy	$024E		; get conversion type
		dey			; decrement
		tya			; A=Y
		and	#$08		; and it with 08
		clc			; clear carry
		adc	$024C		; add to current ADC
		sbc	#$00		; -1
		sta	$FEC0		; store to the A/D control panel
		rts			; and return

		lda	#$C3		; point to start of string @&C300
		sta	$FE		; store it
		lda	#$00		; point to lo byte
		sta	$FD		; store it and start loop@

		iny			; print character in string
		lda	($FD),Y		; pointed to by &FD/E
		jsr	OSASCI		; print it expanding Carriage returns
		tax			; store A in X
		bne	$DEB1		; and loop again if not =0
		rts			; else exit

;*********** OSBYTE 129 TIMED ROUTINE ******************************
;ON ENTRY TIME IS IN X,Y

		stx	$02B1		; store time in INKEY countdown timer
		sty	$02B2		; which is decremented every 10ms
		lda	#$FF		; A=&FF to flag timed wait
		bne	$DEC7		; goto DEC7


;**************************************************************************
;**************************************************************************
;**                                                                      **
;**      OSRDCH Default entry point                                      **
;**                                                                      **
;**      RDCHV entry point       read a character                        **
;**                                                                      **
;**************************************************************************
;**************************************************************************

		lda	#$00		; A=0 to flag wait forever

		sta	$E6		; store entry value of A
		txa			; save X and Y
		pha			; 
		tya			; 
		pha			; 
		ldy	$0256		; get *EXEC file handle
		beq	$DEE6		; if 0 (not open) then DEE6
		sec			; set carry
		ror	$EB		; set bit 7 of CFS active flag to prevent clashes
		jsr	OSBGET		; get a byte from the file
		php			; push processor flags to preserve carry
		lsr	$EB		; restore &EB
		plp			; get back flags
		bcc	$DF03		; and if carry clear, character found so exit via DF03
		lda	#$00		; else A=00 as EXEC file empty
		sta	$0256		; store it in exec file handle
		jsr	OSFIND		; and close file via OSFIND

		bit	$FF		; check ESCAPE flag, if bit 7 set Escape pressed
		bmi	$DF00		; so off to DF00
		ldx	$0241		; else get current input buffer number
		jsr	$E577		; get a byte from input buffer
		bcc	$DF03		; and exit if character returned

		bit	$E6		; (E6=0 or FF)
		bvc	$DEE6		; if entry was OSRDCH not timed keypress, so go back and
					; do it again i.e. perform GET function
		lda	$02B1		; else check timers
		ora	$02B2		; 
		bne	$DEE6		; and if not zero go round again
		bcs	$DF05		; else exit

;; duplicate code
; DEF0	BCC &DF03
; DEF2	BIT &E6
; DEF4	BVC &DEE6
; DEF6	LDA &02B1
; DEF9	ORA &02B2
; DEFC	BNE &DEE6
; DEFE	BCS &DF05

		sec	
		lda	#$1B
		sta	$E6
		pla	
		tay	
		pla	
		tax	
		lda	$E6
		rts	


