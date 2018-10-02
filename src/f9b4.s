;OS SERIES 10
;LAST PART
;GEOFF COX
;****************************** LOAD *************************************

.org		$f9b4

		tya			; A=Y
		beq	$F9C4		; 
		jsr	$FA46		; print message following call

		.byte	$0D		; 
		.byte	"Loading"		; 
		.byte	$0D		; 
		brk			; 

		sta	$BA		; current block flag
		ldx	#$FF		; X=&FF
		lda	$C1		; Checksum result
		bne	$F9D9		; if not 0 F9D9
		jsr	$FA72		; else check filename header block matches searched
					; filename if this returns NE then no match
		php			; save flags on stack
		ldx	#$FF		; X=&FF
		ldy	#$99		; Y=&99
		lda	#$FA		; A=&FA this set Y/A to point to 'File?' FA99
		plp			; get back flags
		bne	$F9F5		; report a query unexpected file name

		ldy	#$8E		; making Y/A point to 'Data' FA8E for CRC error
		lda	$C1		; Checksum result
		beq	$F9E3		; if 0 F9E3
		lda	#$FA		; A=&FA
		bne	$F9F5		; jump to F9F5

		lda	$03C6		; block number
		cmp	$B4		; current block no. lo
		bne	$F9F1		; if not eual F9F1
		lda	$03C7		; block number hi
		cmp	$B5		; current block no. hi
		beq	$FA04		; if equal FA04

		ldy	#$A4		; Y=&A4
		lda	#$FA		; A=&FA  point to 'Block?' error unexpected block no.

		; at this point an error HAS occurred

		pha			; save A on stack
		tya			; A=Y
		pha			; save Y on stack
		txa			; A=X
		pha			; save X on stack
		jsr	$F8B6		; print CR if indicated by current block flag
		pla			; get back A
		tax			; X=A
		pla			; get back A
		tay			; Y=A
		pla			; get back A
		bne	$FA18		; jump to FA18

		txa			; A=X
		pha			; save A on stack
		jsr	$F8A9		; report
		jsr	$FAD6		; check loading progress, read another byte
		pla			; get back A
		tax			; X=A
		lda	$BE		; CRC workspace
		ora	$BF		; CRC workspace
		beq	$FA8D		; 
		ldy	#$8E		; Y=&8E
		lda	#$FA		; A=&FA  FA8E points to 'Data?'
		dec	$BA		; current block flag
		pha			; save A on stack
		bit	$EB		; CFS Active flag
		bmi	$FA2C		; if active FA2C
		txa			; A=X
		and	$0247		; filing system flag 0=CFS 2=RFS
		bne	$FA2C		; 
		txa			; A=X
		and	#$11		; 
		and	$BB		; current OPTions
		beq	$FA3C		; ignore errors
		pla			; get back A
		sta	$B9		; store A on &B9
		sty	$B8		; store Y on &B8
		jsr	$F68B		; do *EXEC 0 to tidy up
		lsr	$EB		; halve CFS Active flag to clear bit 7

		jsr	$FAE8		; bell, reset ACIA & motor
		jmp	($00B8)		; display selected error report

		pla			; get back A
		iny			; Y=Y+1
		bne	$FA43		; 
		clc			; clear carry flag
		adc	#$01		; Add 1
		pha			; save A on stack
		tya			; A=Y
		pha			; save Y on stack
		jsr	$E7DC		; check if free to print message
		tay			; Y=A
		pla			; get back A
		sta	$B8		; &B8=8
		pla			; get back A
		sta	$B9		; &B9=A
		tya			; A=Y
		php			; save flags on stack
		inc	$B8		; 
		bne	$FA58		; 
		inc	$B9		; 
		ldy	#$00		; Y=0
		lda	($B8),Y		; get byte
		beq	$FA68		; if 0 Fa68
		plp			; get back flags
		php			; save flags on stack
		beq	$FA52		; if 0 FA52 to get next character
		jsr	OSASCI		; else print
		jmp	$FA52		; and do it again

		plp			; get back flags
		inc	$B8		; increment pointers
		bne	$FA6F		; 
		inc	$B9		; 
		jmp	($00B8)		; and print error message so no error condition
					; occcurs

;************ compare filenames ******************************************

		ldx	#$FF		; X=&FF inx will mean X=0

		inx			; X=X+1
		lda	$03D2,X		; sought filename byte
		bne	$FA81		; if not 0 FA81
		txa			; else A=X
		beq	$FA80		; if X=0 A=0 exit
		lda	$03B2,X		; else A=filename byte
		rts			; return
					; 
		jsr	$E4E3		; set carry if byte in A is not upper case Alpha
		eor	$03B2,X		; compare with filename
		bcs	$FA8B		; if carry set FA8B
		and	#$DF		; else convert to upper case
		beq	$FA74		; and if A=0 filename characters match so do it again
		rts			; return
					; 
		brk			; 
		.byte	$D8		; error number
		.byte	$0d,"Data?"		; ;; fixed here
		brk			; 

		bne	$FAAE		; 

		brk			; 
		.byte	$DB		; error number
		.byte	$0D,"File?"		; 
		brk			; 

		bne	$FAAE		; 

		brk			; 
		.byte	$DA		; error number
		.byte	$0D,"Block?"
		brk			; 

		lda	$BA		; current block flag
		beq	$FAD3		; if 0 FAD3 else
		txa			; A=X
		beq	$FAD3		; If X=0 FAD3
		lda	#$22		; A=&22
		bit	$BB		; current OPTions checking bits 1 and 5
		beq	$FAD3		; if neither set no  retry so FAD3 else
		jsr	$FB46		; reset ACIA
		tay			; Y=A
		jsr	$FA4A		; print following message

		.byte	$0D		; Carriage RETURN
		.byte	$07		; BEEP
		.byte	"Rewind tape"		; 
		.word	$0D0D		; two more newlines
		brk			; 

		rts			; return

		jsr	$F24D		; print CR if CFS not operational
		lda	$C2		; filename length/progress flag
		beq	$FAD2		; if 0 return else
		jsr	$F995		; confirm ESC not set and CFS not executing
		lda	$0247		; filing system flag 0=CFS 2=RFS
		beq	$FAD6		; if CFS FAD6
		jsr	$F588		; else set up ACIA etc
		jmp	$FAD6		; and loop back again

;********** sound bell, reset ACIA, motor off ****************************

		jsr	$E7DC		; check if free to print message
		beq	$FAF2		; enable second processor and reset serial system
		lda	#$07		; beep
		jsr	OSWRCH		; 
		lda	#$80		; 
		jsr	$FBBD		; enable 2nd proc. if present and set up osfile block
		ldx	#$00		; 
		jsr	$FB95		; switch on motor
		php			; save flags on stack
		sei			; prevent IRQ interrupts
		lda	$0282		; get serial ULA control register setting
		sta	$FE10		; write to serial ULA control register setting
		lda	#$00		; A=0
		sta	$EA		; store A RS423 timeout counter
		beq	$FB0B		; jump FB0B

		php			; save flags on stacksave flags
		jsr	$FB46		; release ACIA (by &FE08=3)
		lda	$0250		; get last setting of ACIA
		jmp	$E189		; set ACIA and &250 from A before exit

		plp			; get back flags
		bit	$FF		; if bit 7of ESCAPE flag not set
		bpl	$FB31		; then FB31
		rts			; else return as unserviced ESCAPE is pending


;*************************************************************************
;*                                                                       *
;*       Claim serial system for sequential Access                       *
;*                                                                       *
;*************************************************************************

		lda	$E3		; get cassette filing system options byte
					; high nybble used for LOAD & SAVE operations
					; low nybble used for sequential access

		; 0000   Ignore errors,          no messages
		; 0001   Abort if error,         no messages
		; 0010   Retry after error,      no messages
		; 1000   Ignore error            short messages
		; 1001   Abort if error          short messages
		; 1010   Retry after error       short messages
		; 1100   Ignore error            long messages
		; 1101   Abort if error          long messages
		; 1110   Retry after error       long messages

		asl			; move low nybble into high nybble
		asl			; 
		asl			; 
		asl			; 
		sta	$BB		; current OPTions save into &BB
		lda	$03D1		; get sequential block gap
		bne	$FB2F		; goto to &FB2F


;*************************************************************************
;*                                                                       *
;*       claim serial system for cassette etc.                           *
;*                                                                       *
;*************************************************************************

		lda	$E3		; get cassette filing system options byte
					; high nybble used for LOAD & SAVE operations
					; low nybble used for sequential access

		; 0000   Ignore errors,          no messages
		; 0001   Abort if error,         no messages
		; 0010   Retry after error,      no messages
		; 1000   Ignore error            short messages
		; 1001   Abort if error          short messages
		; 1010   Retry after error       short messages
		; 1100   Ignore error            long messages
		; 1101   Abort if error          long messages
		; 1110   Retry after error       long messages

		and	#$F0		; clear low nybble
		sta	$BB		; as current OPTions
		lda	#$06		; set current interblock gap
		sta	$C7		; to 6

		cli			; allow interrupts
		php			; save flags on stack
		sei			; prevent interrupts
		bit	$024F		; check if RS423 is busy
		bpl	$FB14		; if not FB14
		lda	$EA		; see if RS423 has timed out
		bmi	$FB14		; if not FB14

		lda	#$01		; else load RS423 timeout counter with
		sta	$EA		; 1 to indicate that cassette has 6850
		jsr	$FB46		; reset ACIA with &FE80=3
		plp			; get back flags
		rts			; return

		lda	#$03		; A=3
		bne	$FB65		; and exit after resetting ACIA


;**********************  set ACIA control register  **********************

		lda	#$30		; set current ACIA control register
		sta	$CA		; to &30
		bne	$FB63		; and goto FB63
					; if bit 7=0 motor off 1=motor on

;***************** control cassette system *******************************

		lda	#$05		; set &FE10 to 5
		sta	$FE10		; setting a transmit baud rate of 300,motor off

		ldx	#$FF		; 
		dex			; delay loop
		bne	$FB57		; 

		stx	$CA		; &CA=0
		lda	#$85		; Turn motor on and keep baud rate at 300 recieve
		sta	$FE10		; 19200 transmit
		lda	#$D0		; A=&D0

		ora	$C6		; 
		sta	$FE08		; set up ACIA control register
		rts			; returnand return

		ldx	$03C6		; block number
		ldy	$03C7		; block number hi
		inx			; X=X+1
		stx	$B4		; current block no. lo
		bne	$FB75		; 
		iny			; Y=Y+1
		sty	$B5		; current block no. hi
		rts			; return
					; 
		ldy	#$00		; 
		sty	$C0		; filing system buffer flag

;*****************set (zero) checksum bytes ******************************

		sty	$BE		; CRC workspace
		sty	$BF		; CRC workspace
		rts			; return

;*********** copy sought filename routine ********************************

		ldy	#$FF		; Y=&FF
		iny			; Y=Y+1
		inx			; X=X+1
		lda	$0300,X		; 
		sta	$03D2,Y		; sought filename
		bne	$FB83		; until end of filename (0)
		rts			; return
					; 
		ldy	#$00		; Y=0

;********************** switch Motor on **********************************

		cli			; allow   IRQ interrupts
		ldx	#$01		; X=1
		sty	$C3		; store Y as current file handle

;********************: control motor ************************************

		lda	#$89		; do osbyte 137
		ldy	$C3		; get back file handle (preserved thru osbyte)
		jmp	OSBYTE		; turn on motor

;****************** confirm file is open  ********************************

		sta	$BC		; file status or temporary store
		tya			; A=Y
		eor	$0247		; filing system flag 0=CFS 2=RFS
		tay			; Y=A
		lda	$E2		; CFS status byte
		and	$BC		; file status or temporary store
		lsr			; A=A/2
		dey			; Y=Y-1
		beq	$FBAF		; 
		lsr			; A=A/2
		dey			; Y=Y-1
		bne	$FBB1		; 
		bcs	$FBFE		; 

		brk			; 
		.byte	$DE		; error number
		.byte	"Channel"		; 
		brk			; 

;************* read from second processor ********************************

		lda	#$01		; A=1
		jsr	$FBD3		; check if second processor file test tube prescence
		beq	$FBFE		; if not exit
		txa			; A=X
		ldx	#$B0		; current load address
		ldy	#$00		; Y=00
		pha			; save A on stack
		lda	#$C0		; filing system buffer flag
		jsr	$0406		; and out to TUBE
		bcc	$FBCA		; 
		pla			; get back A
		jmp	$0406		; 

;*************** check if second processor file test tube prescence ******

		tax			; X=A
		lda	$B2		; current load address high word
		and	$B3		; current load address high word
		cmp	#$FF		; 
		beq	$FBE1		; if &FF then its for base processor
		lda	$027A		; &FF if tube present
		and	#$80		; to set bit 7 alone
		rts			; return

;******** control ACIA and Motor *****************************************

		lda	#$85		; A=&85
		sta	$FE10		; write to serial ULA control register setting
		jsr	$FB46		; reset ACIA
		lda	#$10		; A=16
		jsr	$FB63		; set ACIA to CFS baud rate
		jsr	$F995		; confirm ESC not set and CFS not executing
		lda	$FE08		; read ACIA status register
		and	#$02		; clear all but bit 1
		beq	$FBEF		; if clear FBEF
		lda	#$AA		; else A=&AA
		sta	$FE09		; transmit data register
		rts			; return

		brk			; 

