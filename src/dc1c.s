;**************************************************************************
;**************************************************************************
;**									 **
;**	 MAIN IRQ Entry point						 **
;**									 **
;**									 **
;**************************************************************************
;**************************************************************************
;ON ENTRY STACK contains	STATUS REGISTER,PCH,PCL			;

			.org	$dc1c

_IRQ_HANDLER:		sta	IRQ_COPY_A			; save A
			pla					; get back status (flags)
			pha					; and save again
			and	#$10				; check if BRK flag set
			bne	_BRK				; if so goto DC27
			jmp	(VEC_IRQ1V)			; else JMP (IRQ1V)


;*************************************************************************
;*									 *
;*		 BRK handling routine					 *
;*									 *
;*************************************************************************

_BRK:			txa					; save X on stack
			pha					; 
			tsx					; get status pointer
			lda	STACK+3,X			; get Program Counter lo
			cld					; 
			sec					; set carry
			sbc	#$01				; subtract 2 (1+carry)
			sta	ERR_MSG_PTR			; and store it in &FD
			lda	STACK+4,X			; get hi byte
			sbc	#$00				; subtract 1 if necessary
			sta	ERR_MSG_PTR_HI			; and store in &FE
			lda	ROM_SELECT			; get currently active ROM
			sta	OSB_LAST_ROM			; and store it in &24A
			stx	OSW_X				; store stack pointer in &F0
			ldx	#$06				; and issue ROM service call 6
			jsr	_OSBYTE_143			; (User BRK) to ROMs
								; at this point &FD/E point to byte after BRK
								; ROMS may use BRK for their own purposes

			ldx	OSB_CUR_LANG			; get current language
			jsr	_LDC16				; and activate it
			pla					; get back original value of X
			tax					; 
			lda	IRQ_COPY_A			; get back original value of A
			cli					; allow interrupts
			jmp	(VEC_BRKV)			; and JUMP via BRKV (normally into current language)


;*************************************************************************
;*									 *
;*	 DEFAULT BRK HANDLER						 *
;*									 *
;*************************************************************************

_BRKV:			ldy	#$00				; Y=0 to point to byte after BRK
			jsr	_LDEB1				; print message

			lda	OSB_BOOT_DISP			; if BIT 0 set and DISC EXEC error
			ror					; occurs
_HCF:			bcs	_HCF				; hang up machine!!!!

			jsr	OSNEWL				; else print two newlines
			jsr	OSNEWL				; 
			jmp	_LDBB8				; and set tape speed before entering current
								; language

; ACIA IRQ, RxRDY but both Serial and Printer buffers empty
; ---------------------------------------------------------
_BDC68:			sec					
			ror	OSB_RS423_USE			; Set b7 of RS423 busy flag
			bit	OSB_RS423_CTL			; check bit 7 of current ACIA control register
			bpl	_BDC78				; if interrupts NOT enabled DC78
			jsr	_LE741				; else E741 to check if serial buffer full
			ldx	#$00				; X=&00 to set RTS low
			bcs	_BDC7A				; if carry set goto DC7A to transfer data

_BDC78:			ldx	#$40				; X=&40 to set RTS high
_BDC7A:			jmp	_LE17A				; Jump to set ACIA control register

; Serial IRQ and RxRDY - Get byte and store in serial buffer
; ----------------------------------------------------------
_BDC7D:			ldy	ACIA_TXRX			; Read data from ACIA
			and	#$3a				; Check PE:RO:FE:DCD
			bne	_BDCB8				; If any set, jump to generate Serial Error Event

; Serial IRQ and RxRDY, no errors
; -------------------------------
			ldx	OSB_SER_BUF_SUP			; Read RS423 input suppression flag
			bne	_BDC92				; If not 0, jump to ignore
			inx					; X=1, serial input buffer
			jsr	_OSBYTE_153			; Put byte in buffer
			jsr	_LE741				; Check if serial buffer almost full
			bcc	_BDC78				; If almost full, jump to set RTS high
_BDC92:			rts					; Return


;*************************************************************************
;*									 *
;*	 Main IRQ Handling routines, default IRQ1V destination		 *
;*									 *
;*************************************************************************

_IRQ1V:			cld					; Clear decimal flag
			lda	IRQ_COPY_A			; Get original value of A
			pha					; Save it
			txa					; Save X
			pha					; 
			tya					; and Y
			pha					; 
			lda	#$de				; Stack return address to &DE82
			pha					
			lda	#$81				
			pha					
			clv					; Clear V flag
_POLL_ACIA_IRQ:		lda	ACIA_CSR			; Read ACIA status register
			bvs	__irq_acia			; b6 set, jump with serial parity error
			bpl	_POLL_SYS_VIA_IRQ		; b7=0, no ACIA interrupt, jump to check VIAs

; ACIA Interrupt or ACIA Parity Error
; -----------------------------------
__irq_acia:		ldx	RS423_TIMEOUT			; Get RS423 timeout counter
			dex					; Decrement it
			bmi	_BDCDE				; If 0 or <0, RS423 owns 6850, jump to DCDE
			bvs	_BDCDD				; If &41..&80, nobody owns 6850, jump to exit
			jmp	_CRFS_READ			; CFS owns 6850, jump to read ACIA in CFS routines

; ACIA Data Carrier Detect
; ------------------------
_BDCB3:			ldy	ACIA_TXRX			; Read ACIA data
			rol	A				; 
			asl	A				; Rotate ACIA Status back
_BDCB8:			tax					; X=ACIA Status
			tya					; A=ACIA Data
			ldy	#$07				; Y=07 for RS423 Error Event
			jmp	_OSEVEN				; Jump to issue event

; ACIA IRQ, TxRDY - Send a byte
; -----------------------------
_BDCBF:			ldx	#$02				
			jsr	_OSBYTE_145			; Read from Serial output buffer
			bcc	_BDCD6				; Buffer is not empty, jump to send byte
			lda	OSB_PRINT_DEST			; Read printer destination
			cmp	#$02				; Is it serial printer??
			bne	_BDC68				; Serial buffer empty, not Serial printer, jump to ... DC68
			inx					; X=3 for Printer buffer
			jsr	_OSBYTE_145			; Read from Printer buffer
			ror	BUFFER_3_BUSY			; Copy Byte Fetched/Not fetched into Printer Buffer full flag
			bmi	_BDC68				; Printer buffer was empty, so jump to ... DC68

_BDCD6:			sta	ACIA_TXRX			; Send byte to ACIA
			lda	#$e7				; Set timeout counter to &E7
			sta	RS423_TIMEOUT			; Serial owns 6850 for 103 more calls
_BDCDD:			rts					; Exit IRQ

; RS423 owns 6850, PE or RxRDY interupt occured
; ---------------------------------------------
; On entry, A contains ACIA status

_BDCDE:			and	OSB_ACIA_IRQ_M			; AND with ACIA IRQ mask (normally &FF)
			lsr	A				; Move RxRDY into Carry
			bcc	_BDCEB				; If no RxData, jump to check DCD and TxRDY

; Data in RxData, check for errors

			bvs	_BDCEB				; If IRQ=1 (now in b6) RxIRQ must have occured, so jump to DCEB

; RxData but no RxIRQ, check that IRQs are actually disabled

			ldy	OSB_RS423_CTL			; Get ACIA control setting
			bmi	_BDC7D				; If bit 7=1, IRQs enabled so jump to read byte and insert into buffer

; DCE9 -> RxData, no RxIRQ, IRQs disabled
; DCE4 -> RxData and RxIRQ
; DCE2 -> No RxData

; Check TxRDY and DCD, if neither set, send a Serial Error Event
; --------------------------------------------------------------
_BDCEB:			lsr	A				; Move TxRDY into Carry
			ror	A				; Rotate TxRDY into b7 and DCD into Carry
			bcs	_BDCB3				; If Data Carrier Detected, jump to DCB3
			bmi	_BDCBF				; If TxRDY (now in b7) jump to to DCBF to send a byte
			bvs	_BDCDD				; b6 should always be zero by now, but if set, then jump to exit

; Issue Unknown Interupt service call
; ===================================
_IRQ_UNKNOWN:		ldx	#$05				
			jsr	_OSBYTE_143			; Issue service call 5, 'Unknown Interrupt'
			beq	_BDCDD				; If claimed, then jump to exit
			pla					; Otherwise drop return address from stack
			pla					; 
			pla					; And restore registers
			tay					; 
			pla					; 
			tax					; 
			pla					; 
			sta	IRQ_COPY_A			; Store A in IRQA
			jmp	(VEC_IRQ2V)			; And pass the IRQ in to IRQ2V


;*************************************************************************
;*									 *
;* VIA INTERUPTS ROUTINES						 *
;*									 *
;*************************************************************************

_POLL_SYS_VIA_IRQ:	lda	SYS_VIA_IFR			; Read System VIA interrupt flag register
			bpl	_POLL_USER_VIA_IRQ		; No System VIA interrupt, jump to check User VIA

; System VIA interupt

			and	OSB_SVIA_IRQ_M			; Mask with System VIA bit mask
			and	SYS_VIA_IER			; and interrupt enable register
_POLL_FRAME_SYNC_IRQ:	ror					; Rotate to check for CA1 interupt (frame sync)
			ror					; 
			bcc	_POLL_TIMER2_IRQ		; No CA1 (frame sync), jump to check speech

; System VIA CA1 interupt (Frame Sync)

			dec	OSB_CFS_TIMEOUT			; decrement vertical sync counter
			lda	RS423_TIMEOUT			; A=RS423 Timeout counter
			bpl	_BDD1E				; if +ve then DD1E
			inc	RS423_TIMEOUT			; else increment it
_BDD1E:			lda	OSB_FLASH_TIME			; load flash counter
			beq	_BDD3D				; if 0 then system is not in use, ignore it
			dec	OSB_FLASH_TIME			; else decrement counter
			bne	_BDD3D				; and if not 0 go on past reset routine

			ldx	OSB_FLASH_SPC			; else get mark period count in X
			lda	OSB_VIDPROC_CTL			; current VIDEO ULA control setting in A
			lsr					; shift bit 0 into C to check if first colour
			bcc	_BDD34				; is effective if so C=0 jump to DD34

			ldx	OSB_FLASH_MARK			; else get space period count in X
_BDD34:			rol					; restore bit
			eor	#$01				; and invert it
			jsr	_LEA00				; then change colour

			stx	OSB_FLASH_TIME			; &0251=X resetting the counter

_BDD3D:			ldy	#$04				; Y=4 and call E494 to check and implement vertical
			jsr	_OSEVEN				; sync event (4) if necessary
			lda	#$02				; A=2
			jmp	_LDE6E				; clear interrupt 1 and exit


;*************************************************************************
;*									 *
;*	 PRINTER INTERRUPT USER VIA 1					 *
;*									 *
;*************************************************************************

_POLL_USER_VIA_IRQ:	lda	USR_VIA_IFR			; Read User VIA interrupt flag register
			bpl	_IRQ_UNKNOWN			; No User VIA interrupt, jump to pass to ROMs

; User VIA interupt

			and	OSB_UVIA_IRQ_M			; else check for USER IRQ 1
			and	USR_VIA_IER			; 
			ror					; 
			ror					; 
			bcc	_IRQ_UNKNOWN			; if bit 1=0 the no interrupt 1 so DCF3
			ldy	OSB_PRINT_DEST			; else get printer type
			dey					; decrement
			bne	_IRQ_UNKNOWN			; if not parallel then DCF3
			lda	#$02				; reset interrupt 1 flag
			sta	USR_VIA_IFR			; 
			sta	USR_VIA_IER			; disable interrupt 1
			ldx	#$03				; and output data to parallel printer
			jmp	_LE13A				; 


;*************************************************************************
;*									 *
;*	 SYSTEM INTERRUPT 5   Speech					 *
;*									 *
;*************************************************************************

_POLL_TIMER2_IRQ:	rol					; Rotate bit 5 into bit 7
			rol					; 
			rol					; 
			rol					; 
			bpl	_POLL_TIMER_IRQ			; Not a Timer 2 interrupt, jump to check timers

; System VIA Timer 2 interupt - Speech interupt

			lda	#$20				; Prepare to clear VIA interupt
			ldx	#$00				
			sta	SYS_VIA_IFR			; Clear VIA interupt
			stx	SYS_VIA_T2C_H			; Zero high byte of T2 Timer
_LDD79:			ldx	#$08				; X=8 for Speech buffer
			stx	MOS_WS_1			; Prepare to loop up to four times for Speak from RAM

_BDD7D:			jsr	_OSBYTE_152			; Examine Speech buffer
			ror	BUFFER_8_BUSY			; Shift carry into bit 7
			bmi	_BDDC9				; Buffer empty, so exit
			tay					; Buffer not empty, A=first byte waiting
			beq	_BDD8D				; Waiting byte=&00 (Speak, no reset), skip past
			jsr	_OSBYTE_158			; control speech chip
			bmi	_BDDC9				; if negative exit

_BDD8D:			jsr	_OSBYTE_145			; Fetch Speech command byte from buffer
			sta	RFS_SELECT			; Store it
			jsr	_OSBYTE_145			; Fetch Speech word high byte from buffer
			sta	ROM_PTR_HI			; Store it
			jsr	_OSBYTE_145			; Fetch Speech word low byte from buffer
			sta	ROM_PTR				; Store it, giving &F6/7=address to be accessed
			ldy	RFS_SELECT			; Y=Speech command byte
			beq	_BDDBB				; SOUND &FF00 - Speak from RAM, no reset
			bpl	_BDDB8				; SOUND &FF01-&FF7F - Speak from RAM, with reset
			bit	RFS_SELECT			; Check bit 6 of Speech command
			bvs	_BDDAB				; SOUND &FFC0-&FFFF - Speak word number

; SOUND &FF80-&FFBF - Speak from absolute address
; &F5=command &80-&BF (b0-b3=PHROM number), &F6/7=address

			jsr	_LEEBB				; Write address to speech processor
			bvc	_BDDB2				; Skip forward to speak from selected address

; SOUND &FFC0-&FFFF - Speak word number
; &F5=command &C0-&FF (b0-b3=PHROM number), &F6/7=word number

_BDDAB:			asl	ROM_PTR				; Multiply address by 2 to index into word table
			rol	ROM_PTR_HI			; 
			jsr	_LEE3B				; Read address from specified PHROM

; Speak from PHROM address
; By now, the address in the PHROM specified in Command b0-b3 has been set
; to the start of the speech data to be voiced.

_BDDB2:			ldy	OSB_SPEECH_OFF			; Fetch command code, usually &50=Speak or &00=Nop
			jmp	_OSBYTE_159			; Jump to send command to speak from current address

; SOUND &FF01-&FF7F - Speak from RAM with reset
; Y=Speech command byte, &F6/7=Speech data
; Use SOUND &FF60 to send Speak External command

_BDDB8:			jsr	_OSBYTE_159			; Send command byte to Speech processor

; SOUND &FF00 - Speak from RAM without reset
; &6/7=Speech data

_BDDBB:			ldy	ROM_PTR				
			jsr	_OSBYTE_159			; Send Speech data low byte
			ldy	ROM_PTR_HI			
			jsr	_OSBYTE_159			; Send Speech data high byte
			lsr	MOS_WS_1			; Shift loop counter
			bne	_BDD7D				; Loop to send up to four byte-pairs
_BDDC9:			rts					

;***********************************************************************
;*									 *
;*	 SYSTEM INTERRUPT 6 10mS Clock					 *
;*									 *
;*************************************************************************

_POLL_TIMER_IRQ:	bcc	_POLL_ADC_IRQ			; bit 6 is in carry so if clear there is no 6 int
								; so go on to DE47
			lda	#$40				; Clear interrupt 6
			sta	SYS_VIA_IFR			; 

;UPDATE timers routine, There are 2 timer stores &292-6 and &297-B
;these are updated by adding 1 to the current timer and storing the
;result in the other, the direction of transfer being changed each
;time of update.  This ensures that at least 1 timer is valid at any call
;as the current timer is only read.  Other methods would cause inaccuracies
;if a timer was read whilst being updated.

			lda	OSB_TIME_SWITCH			; get current system clock store pointer (5,or 10)
			tax					; put A in X
			eor	#$0f				; and invert lo nybble (5 becomes 10 and vv)
			pha					; store A
			tay					; put A in Y

				; Carry is always set at this point
_BDDD9:			lda	TIME_VAL1_MSB-1,X		; get timer value
			adc	#$00				; update it
			sta	TIME_VAL1_MSB-1,Y		; store result in alternate
			dex					; decrement X
			beq	_BDDE7				; if 0 exit
			dey					; else decrement Y
			bne	_BDDD9				; and go back and do next byte

_BDDE7:			pla					; get back A
			sta	OSB_TIME_SWITCH			; and store back in clock pointer (i.e. inverse previous
								; contents)
			ldx	#$05				; set loop pointer for countdown timer
_BDDED:			inc	COUNTER_MSB-1,X			; increment byte and if
			bne	_BDDFA				; not 0 then DDFA
			dex					; else decrement pointer
			bne	_BDDED				; and if not 0 do it again
			ldy	#$05				; process EVENT 5 interval timer
			jsr	_OSEVEN				; 

_BDDFA:			lda	INKEY_TIMER			; get byte of inkey countdown timer
			bne	_BDE07				; if not 0 then DE07
			lda	INKEY_TIMER_HI			; else get next byte
			beq	_BDE0A				; if 0 DE0A
			dec	INKEY_TIMER_HI			; decrement 2B2
_BDE07:			dec	INKEY_TIMER			; and 2B1

_BDE0A:			bit	SOUND_SEMAPHORE			; read bit 7 of envelope processing byte
			bpl	_BDE1A				; if 0 then DE1A
			inc	SOUND_SEMAPHORE			; else increment to 0
			cli					; allow interrupts
			jsr	_SOUND_IRQ			; and do routine sound processes
			sei					; bar interrupts
			dec	SOUND_SEMAPHORE			; DEC envelope processing byte back to 0

_BDE1A:			bit	BUFFER_8_BUSY			; read speech buffer busy flag
			bmi	_BDE2B				; if set speech buffer is empty, skip routine
			jsr	_OSBYTE_158			; update speech system variables
			eor	#$a0				; 
			cmp	#$60				; 
			bcc	_BDE2B				; if result >=&60 DE2B
			jsr	_LDD79				; else more speech work

_BDE2B:			bit	_BD9B7				; set V and C
			jsr	_POLL_ACIA_IRQ			; check if ACIA needs attention
			lda	KEYNUM_FIRST			; check if key has been pressed
			ora	KEYNUM_LAST			; 
			and	OSB_KEY_SEM			; (this is 0 if keyboard is to be ignored, else &FF)
			beq	_BDE3E				; if 0 ignore keyboard
			sec					; else set carry
			jsr	_LF065				; and call keyboard
_BDE3E:			jsr	_LE19B				; check for data in user defined printer channel
			bit	ADC_SR				; if ADC bit 6 is set ADC is not busy
			bvs	_BDE4A				; so DE4A
			rts					; else return


;*************************************************************************
;*									 *
;*	 SYSTEM INTERRUPT 4 ADC end of conversion			 *
;*									 *
;*************************************************************************

_POLL_ADC_IRQ:		rol					; put original bit 4 from FE4D into bit 7 of A
			bpl	_BDE72				; if not set DE72

_BDE4A:			ldx	OSB_ADC_CHAN			; else get current ADC channel
			beq	_BDE6C				; if 0 DE6C
			lda	ADC_LO				; read low data byte
			sta	OSW0_MAX_CHAR,X			; store it in &2B6,7,8 or 9
			lda	ADC_HI				; get high data byte
			sta	ADC_CHAN4_LO,X			; and store it in hi byte
			stx	ADC_CHAN_FLAG			; store in Analogue system flag marking last channel
			ldy	#$03				; handle event 3 conversion complete
			jsr	_OSEVEN				; 

			dex					; decrement X
			bne	_BDE69				; if X=0
			ldx	OSB_ADC_MAX			; get highest ADC channel preseny
_BDE69:			jsr	_LDE8F				; and start new conversion
_BDE6C:			lda	#$10				; reset interrupt 4
_LDE6E:			sta	SYS_VIA_IFR			; 
			rts					; and return


;*************************************************************************
;*									 *
;*	 SYSTEM INTERRUPT 0 Keyboard					 *
;*									 *
;*************************************************************************

_BDE72:			rol					; get original bit 0 in bit 7 position
			rol					; 
			rol					; 
			rol					; 
			bpl	_BDE7F				; if bit 7 clear not a keyboard interrupt
			jsr	_LF065				; else scan keyboard
			lda	#$01				; A=1
			bne	_LDE6E				; and off to reset interrupt and exit

_BDE7F:			jmp	_IRQ_UNKNOWN			; 

;************** exit routine *********************************************

			pla					; restore registers
			tay					; 
			pla					; 
			tax					; 
			pla					; 
			sta	IRQ_COPY_A			; store A


;*************************************************************************
;*									 *
;*	 IRQ2V default entry						 *
;*									 *
;*************************************************************************

_IRQ2V:			lda	IRQ_COPY_A			; get back original value of A
			rti					; and return to calling routine


;*************************************************************************
;*									 *
;*	 OSBYTE 17 Start conversion					 *
;*									 *
;*************************************************************************

_OSBYTE_17:		sty	ADC_CHAN_FLAG			; set last channel to finish conversion
_LDE8F:			cpx	#$05				; if X<4 then
			bcc	_BDE95				; DE95
			ldx	#$04				; else X=4

_BDE95:			stx	OSB_ADC_CHAN			; store it as current ADC channel
			ldy	OSB_ADC_ACC			; get conversion type
			dey					; decrement
			tya					; A=Y
			and	#$08				; and it with 08
			clc					; clear carry
			adc	OSB_ADC_CHAN			; add to current ADC
			sbc	#$00				; -1
			sta	ADC_SR				; store to the A/D control panel
			rts					; and return

_PRINT_PAGEC3_STRING:	lda	#$c3				; point to start of string @&C300
_PRINT_PAGE_STRING:	sta	ERR_MSG_PTR_HI			; store it
			lda	#$00				; point to lo byte
			sta	ERR_MSG_PTR			; store it and start loop@

_LDEB1:			iny					; print character in string
			lda	(ERR_MSG_PTR),Y			; pointed to by &FD/E
			jsr	OSASCI				; print it expanding Carriage returns
			tax					; store A in X
			bne	_LDEB1				; and loop again if not =0
			rts					; else exit

;*********** OSBYTE 129 TIMED ROUTINE ******************************
;ON ENTRY TIME IS IN X,Y

_LDEBB:			stx	INKEY_TIMER			; store time in INKEY countdown timer
			sty	INKEY_TIMER_HI			; which is decremented every 10ms
			lda	#$ff				; A=&FF to flag timed wait
			bne	_BDEC7				; goto DEC7


;**************************************************************************
;**************************************************************************
;**									 **
;**	 OSRDCH Default entry point					 **
;**									 **
;**	 RDCHV entry point	 read a character			 **
;**									 **
;**************************************************************************
;**************************************************************************

_NVRDCH:		lda	#$00				; A=0 to flag wait forever

_BDEC7:			sta	MOS_WS				; store entry value of A
			txa					; save X and Y
			pha					; 
			tya					; 
			pha					; 
			ldy	OSB_EXEC_HND			; get *EXEC file handle
			beq	_BDEE6				; if 0 (not open) then DEE6
			sec					; set carry
			ror	CRFS_ACTIVE			; set bit 7 of CFS active flag to prevent clashes
			jsr	OSBGET				; get a byte from the file
			php					; push processor flags to preserve carry
			lsr	CRFS_ACTIVE			; restore &EB
			plp					; get back flags
			bcc	_BDF03				; and if carry clear, character found so exit via DF03
			lda	#$00				; else A=00 as EXEC file empty
			sta	OSB_EXEC_HND			; store it in exec file handle
			jsr	OSFIND				; and close file via OSFIND

_BDEE6:			bit	ESCAPE_FLAG			; check ESCAPE flag, if bit 7 set Escape pressed
			bmi	_BDF00				; so off to DF00
			ldx	OSB_IN_STREAM			; else get current input buffer number
			jsr	_LE577				; get a byte from input buffer
			bcc	_BDF03				; and exit if character returned

			bit	MOS_WS				; (E6=0 or FF)
			bvc	_BDEE6				; if entry was OSRDCH not timed keypress, so go back and
								; do it again i.e. perform GET function
			lda	INKEY_TIMER			; else check timers
			ora	INKEY_TIMER_HI			; 
			bne	_BDEE6				; and if not zero go round again
			bcs	_BDF05				; else exit

_BDF00:			sec					
			lda	#$1b				
_BDF03:			sta	MOS_WS				
_BDF05:			pla					
			tay					
			pla					
			tax					
			lda	MOS_WS				
			rts					


