;********  CLOSE EXEC FILE  **********************************************

.org		$f68b

		lda	#$00		; A=0

;*************************************************************************
;*                                                                       *
;*       *EXEC                                                           *
;*                                                                       *
;*************************************************************************

		php			; save flags on stack
		sty	$E6		; &E6=Y
		ldy	$0256		; EXEC file handle
		sta	$0256		; EXEC file handle
		beq	$F69B		; if not 0 close file via OSFIND
		jsr	OSFIND		; 
		ldy	$E6		; else Y= original Y
		plp			; get back flags
		beq	$F6AB		; if A=0 on entry exit else
		lda	#$40		; A=&40
		jsr	OSFIND		; to open an input file
		tay			; Y=A
		beq	$F674		; If Y=0 'File not found' else store
		sta	$0256		; EXEC file handle
		rts			; return

;******* read a block    *************************************************

		ldx	#$A6		; X=&A6
		jsr	$FB81		; copy from 301/C+X to 3D2/C sought filename
		jsr	$F77B		; read block header
		lda	$03CA		; block flag
		lsr			; A=A/2 bit 0 into carry to check for locked file
		bcc	$F6BD		; if not set then skip next instruction
		jmp	$F1F6		; 'locked' file routine

		lda	$03DD		; Expected BGET file block number lo
		sta	$B4		; current block no. lo
		lda	$03DE		; expected BGET file block number hi
		sta	$B5		; current block no. hi
		lda	#$00		; A=0
		sta	$B0		; current load address
		lda	#$0A		; A=&A setting current load address to the CFS/RFS
		sta	$B1		; current load address buffer at &A00
		lda	#$FF		; A=&FF to set other 2 bytes
		sta	$B2		; current load address high word
		sta	$B3		; current load address high word
		jsr	$F7D5		; reset flags
		jsr	$F9B4		; load file from tape
		bne	$F702		; if return non zero F702 else
		lda	$0AFF		; get last character from input buffer
		sta	$02ED		; last character currently resident block
		jsr	$FB69		; inc. current block no.
		stx	$03DD		; expected BGET file block number lo
		sty	$03DE		; expected BGET file block number hi
		ldx	#$02		; X=2
		lda	$03C8,X		; read bytes from block flag/block length
		sta	$02EA,X		; store into current values of above
		dex			; X=X-1
		bpl	$F6EE		; until X=-1 (&FF)

		bit	$02EC		; block flag of currently resident block
		bpl	$F6FF		; 
		jsr	$F249		; print newline if needed
		jmp	$FAF2		; enable second processor and reset serial system
		jsr	$F637		; search for a specified block
		bne	$F6B4		; if NE check for locked condition else
		cmp	#$2A		; is it Synchronising byte &2A?
		beq	$F742		; if so F742
		cmp	#$23		; else is it &23 (header substitute in ROM files)
		bne	$F71E		; if not BAD ROM error

		inc	$03C6		; block number
		bne	$F717		; 
		inc	$03C7		; block number hi
		ldx	#$FF		; X=&FF
		bit	$D9B7		; to set V & M
		bne	$F773		; and jump (ALWAYS!!) to F773

		lda	#$F7		; clear bit 3 of RFS status (current CAT status)
		jsr	$F33D		; RFS status =RFS status AND A

		brk			; and cause error
		.byte	$D7		; error number
		.byte	"Bad ROM"
		brk			; 

;**********: pick up a header ********************************************

;; was missing immediate in original source
		ldy	#$FF		; get ESCAPE flag
		jsr	$FB90		; switch Motor on
		lda	#$01		; A=1
		sta	$C2		; progress flag
		jsr	$FB50		; control serial system
		jsr	$F995		; confirm ESC not set and CFS not executing
		lda	#$03		; A=3
		cmp	$C2		; progress flag
		bne	$F739		; back until &C2=3

		ldy	#$00		; Y=0
		jsr	$FB7C		; zero checksum bytes
		jsr	$F797		; get character from file and do CRC
		bvc	$F766		; if V clear on exit F766
		sta	$03B2,Y		; else store
		beq	$F757		; or if A=0 F757
		iny			; Y=Y+1
		cpy	#$0B		; if Y<>&B
		bne	$F747		; go back for next character
		dey			; Y=Y-1

		ldx	#$0C		; X=12
		jsr	$F797		; get character from file and do CRC
		bvc	$F766		; if V clear on exit F766
		sta	$03B2,X		; else store byte
		inx			; X=X+1
		cpx	#$1F		; if X<>31
		bne	$F759		; goto F759

		tya			; A=Y
		tax			; X=A
		lda	#$00		; A=0
		sta	$03B2,Y		; store it
		lda	$BE		; CRC workspace
		ora	$BF		; CRC workspace
		sta	$C1		; Checksum result
		jsr	$FB78		; set (BE/C0) to 0
		sty	$C2		; progress flag
		txa			; A=X
		bne	$F7D4		; 
		lda	$0247		; filing system flag 0=CFS 2=RFS
		beq	$F72D		; if cassette F72D
		jsr	$EE51		; read RFS data rom or Phrom
		cmp	#$2B		; is it ROM file terminator?
		bne	$F707		; if not F707

;********* terminator found **********************************************

		lda	#$08		; A=8 isolating bit 3 CAT status
		and	$E2		; CFS status byte
		beq	$F790		; if clera skip next instruction
		jsr	$F24D		; print CR if CFS not operational
		jsr	$EE18		; get byte from data Rom
		bcc	$F780		; if carry set F780
		clv			; clear overflow flag
		rts			; return

;****************  get character from file and do CRC  *******************
		; 
		lda	$0247		; filing system flag 0=CFS 2=RFS
		beq	$F7AD		; if cassette F7AD
		txa			; A=X to save X and Y
		pha			; save X on stack
		tya			; A=Y
		pha			; save Y on stack
		jsr	$EE51		; read RFS data rom or Phrom
		sta	$BD		; put it in temporary storage
		lda	#$FF		; A=&FF
		sta	$C0		; filing system buffer flag
		pla			; get back Y
		tay			; Y=A
		pla			; get back X
		tax			; X=A
		jsr	$F884		; check for Escape and loop till bit 7 of FS buffer
					; flag=1

;************************** perform CRC **********************************

		php			; save flags on stack
		pha			; save A on stack
		sec			; set carry flag
		ror	$CB		; CRC Bit counter
		eor	$BF		; CRC workspace
		sta	$BF		; CRC workspace
		lda	$BF		; CRC workspace
		rol			; A=A*2 C=bit 7
		bcc	$F7CA		; 
		ror			; A=A/2
		eor	#$08		; 
		sta	$BF		; CRC workspace
		lda	$BE		; CRC workspace
		eor	#$10		; 
		sta	$BE		; CRC workspace
		sec			; set carry flag

		rol	$BE		; CRC workspace
		rol	$BF		; CRC workspace
		lsr	$CB		; CRC Bit counter
		bne	$F7B9		; 
		pla			; get back A
		plp			; get back flags
		rts			; return

		lda	#$00		; A=0
		sta	$BD		; &BD=character temporary storage buffer=0
		ldx	#$00		; X=0
		stx	$BC		; file status or temporary store
		bvc	$F7E9		; 
		lda	$03C8		; block length
		ora	$03C9		; block length hi
		beq	$F7E9		; if 0 F7E9

		ldx	#$04		; else X=4
		stx	$C2		; filename length/progress flag
		rts			; return

;*************** SAVE A BLOCK ********************************************

		php			; save flags on stack
		ldx	#$03		; X=3
		lda	#$00		; A=0
		sta	$03CB,X		; clear 03CB/E (RFS EOF+1?)
		dex			; X=X-1
		bpl	$F7F1		; 

		lda	$03C6		; block number
		ora	$03C7		; block number hi
		bne	$F804		; if block =0 F804 else
		jsr	$F892		; generate a 5 second delay
		beq	$F807		; goto F807


		jsr	$F896		; generate delay set by interblock gap
		lda	#$2A		; A=&2A
		sta	$BD		; store it in temporary file
		jsr	$FB78		; set (BE/C0) to 0
		jsr	$FB4A		; set ACIA control register
		jsr	$F884		; check for Escape and loop till bit 7 of FS buffer
					; flag=1
		dey			; Y=Y-1
		iny			; Y=Y+1
		lda	$03D2,Y		; move sought filename
		sta	$03B2,Y		; into filename block
		jsr	$F875		; transfer byte to CFS and do CRC
		bne	$F815		; if filename not complet then do it again

;******: deal with rest of header ****************************************

		ldx	#$0C		; X=12
		lda	$03B2,X		; get filename byte
		jsr	$F875		; transfer byte to CFS and do CRC
		inx			; X=X+1
		cpx	#$1D		; until X=29
		bne	$F823		; 

		jsr	$F87B		; save checksum to TAPE reset buffer flag
		lda	$03C8		; block length
		ora	$03C9		; block length hi
		beq	$F855		; if 0 F855

		ldy	#$00		; else Y=0
		jsr	$FB7C		; zero checksum bytes
		lda	($B0),Y		; get a data byte
		jsr	$FBD3		; check if second processor file test tube prescence
		beq	$F848		; if not F848 else

		ldx	$FEE5		; Tube FIFO3

		txa			; A=X
		jsr	$F875		; transfer byte to CFS and do CRC
		iny			; Y=Y+1
		cpy	$03C8		; block length
		bne	$F83E		; 
		jsr	$F87B		; save checksum to TAPE reset buffer flag
		jsr	$F884		; check for Escape and loop till bit 7 of FS buffer
					; flag=1
		jsr	$F884		; check for Escape and loop till bit 7 of FS buffer
					; flag=1
		jsr	$FB46		; reset ACIA

		lda	#$01		; A=1
		jsr	$F898		; generate 0.1 * A second delay
		plp			; get back flags
		jsr	$F8B9		; update block flag, PRINT filename (& address if reqd)
		bit	$03CA		; block flag
		bpl	$F874		; is this last block (bit 7 set)?
		php			; save flags on stack
		jsr	$F892		; generate a 5 second delay
		jsr	$F246		; sound bell and abort
		plp			; get back flags
		rts			; return

;****************** transfer byte to CFS and do CRC **********************
		; 
		jsr	$F882		; save byte to buffer, transfer to CFS & reset flag
		jmp	$F7B0		; perform CRC

;***************** save checksum to TAPE reset buffer flag ****************

		lda	$BF		; CRC workspace
		jsr	$F882		; save byte to buffer, transfer to CFS & reset flag
		lda	$BE		; CRC workspace

;************** save byte to buffer, transfer to CFS & reset flag ********

		sta	$BD		; store A in temporary buffer

;***** check for Escape and loop untill bit 7 of FS buffer flag=1 ***********

		jsr	$F995		; confirm ESC not set and CFS not executing
		bit	$C0		; filing system buffer flag
		bpl	$F884		; loop until bit 7 of &C0 is set

		lda	#$00		; A=0
		sta	$C0		; filing system buffer flag
		lda	$BD		; get temporary store byte
		rts			; return

;****************** generate a 5 second delay  ***************************

		lda	#$32		; A=50
		bne	$F898		; generate delay 100ms *A (5 seconds)

;*************** generate delay set by interblock gap ********************

		lda	$C7		; get current interblock flag

;*************** generate delay ******************************************

		ldx	#$05		; X=5
		sta	$0240		; CFS timeout counter
		jsr	$F995		; confirm ESC not set and CFS not executing
		bit	$0240		; CFS timeout counter (decremented each 20ms)
		bpl	$F89D		; if +ve F89D
		dex			; X=X-1
		bne	$F89A		; 
		rts			; return

;************: generate screen reports ***********************************

		lda	$03C6		; block number
		ora	$03C7		; block number hi
		beq	$F8B6		; if 0 F8B6
		bit	$03DF		; copy of last read block flag
		bpl	$F8B9		; update block flag, PRINT filename (& address if reqd)
		jsr	$F249		; print newline if needed

;************** update block flag, PRINT filename (& address if reqd) ****

		ldy	#$00		; Y=0
		sty	$BA		; current block flag
		lda	$03CA		; block flag
		sta	$03DF		; copy of last read block flag
		jsr	$E7DC		; check if free to print message
		beq	$F933		; if A=0 on return Cassette system is busy
		lda	#$0D		; else A=&0D :carriage return
		jsr	OSWRCH		; print it (note no linefeed as it's via OSWRCH)
		lda	$03B2,Y		; get byte from filename
		beq	$F8E2		; if 0 filename is ended
		cmp	#$20		; if <SPACE
		bcc	$F8DA		; F8DA
		cmp	#$7F		; if less than DELETE
		bcc	$F8DC		; its a printable character for F8DC else

;*******************Control characters in RFS/CFS filename ******************

		lda	#$3F		; else A='?'
		jsr	OSWRCH		; and print it

		iny			; Y=Y+1
		bne	$F8CD		; back to get rest of filename

;***************** end of filename ***************************************

		lda	$0247		; filing system flag 0=CFS 2=RFS
		beq	$F8EB		; if cassette F8EB
		bit	$BB		; test current OPTions
		bvc	$F933		; if bit 6 clear no,long messages needed F933
		jsr	$F991		; print a space
		iny			; Y=Y+1
		cpy	#$0B		; if Y<11 then
		bcc	$F8E2		; loop again to fill out filename with spaces

		lda	$03C6		; block number
		tax			; X=A
		jsr	$F97A		; print ASCII equivalent of hex byte
		bit	$03CA		; block flag
		bpl	$F933		; if not end of file return
		txa			; A=X
		clc			; clear carry flag
		adc	$03C9		; block length hi
		sta	$CD		; file length counter hi
		jsr	$F975		; print space + ASCII equivalent of hex byte
		lda	$03C8		; block length
		sta	$CC		; file length counter lo
		jsr	$F97A		; print ASCII equivalent of hex byte
		bit	$BB		; current OPTions
		bvc	$F933		; if bit 6 clear no long messages required so F933

		ldx	#$04		; X=4
		jsr	$F991		; print a space
		dex			; X=X-1
		bne	$F917		; loop to print 4 spaces

		ldx	#$0F		; X=&0F to point to load address
		jsr	$F927		; print 4 bytes from CFS block header
		jsr	$F991		; print a space
		ldx	#$13		; X=&13 point to Execution address

;************** print 4 bytes from CFS block header **********************

		ldy	#$04		; loop pointer
		lda	$03B2,X		; block header
		jsr	$F97A		; print ASCII equivalent of hex byte
		dex			; X=X-1
		dey			; Y=Y-1
		bne	$F929		; 

		rts			; return

;*********** print prompt for SAVE on TAPE *******************************

		lda	$0247		; filing system flag 0=CFS 2=RFS
		beq	$F93C		; if cassette F93C
		jmp	$E310		; else 'Bad Command error message'
		jsr	$FB8E		; switch Motor On
		jsr	$FBE2		; set up CFS for write operation
		jsr	$E7DC		; check if free to print message
		beq	$F933		; if not exit else
		jsr	$FA46		; print message following call

		.byte	"RECORD then RETURN"		; 
		brk			; 

		jsr	$F995		; confirm CFS not operating, nor ESCAPE flag set

;************ wait for RETURN key to be pressed **************************

		jsr	OSRDCH		; wait for keypress
		cmp	#$0D		; is it &0D (RETURN)
		bne	$F95D		; no then do it again

		jmp	OSNEWL		; output Carriage RETURN and LINE FEED

;************* increment current load address ****************************

		inc	$B1		; current load address
		bne	$F974		; 
		inc	$B2		; current load address high word
		bne	$F974		; 
		inc	$B3		; current load address high word
		rts			; return

;************* print a space + ASCII equivalent of hex byte **************

		pha			; save A on stack
		jsr	$F991		; print a space
		pla			; get back A

;************** print ASCII equivalent of hex byte  **********************

		pha			; save A on stack
		lsr			; /16 to put high nybble in lo
		lsr			; 
		lsr			; 
		lsr			; 
		jsr	$F983		; print its ASCII equivalent
		pla			; get back A

		clc			; clear carry flag
		and	#$0F		; clear high nybble
		adc	#$30		; Add &30 to convert 0-9 to ASCII A-F to : ; < = > ?
		cmp	#$3A		; if A< ASC(':')
		bcc	$F98E		; goto F98E
		adc	#$06		; else add 7 to convert : ; < = > ? to A B C D E F

		jmp	OSWRCH		; print character and return

;******************** print a space  *************************************

		lda	#$20		; A=' '
		bne	$F98E		; goto F98E to print it

;******************** confirm CFS not operating, nor ESCAPE flag set *****

		php			; save flags on stack
		bit	$EB		; CFS Active flag
		bmi	$F99E		; 
		bit	$FF		; if ESCAPE condition
		bmi	$F9A0		; goto F9A0
		plp			; get back flags
		rts			; return

		jsr	$F33B		; close input file
		jsr	$FAF2		; enable second processor and reset serial system
		lda	#$7E		; A=&7E (126) Acknowledge ESCAPE
		jsr	OSBYTE		; OSBYTE Call

		brk			; 
		.byte	$11		; error 17
		.byte	"Escape"		; 
		brk			; 


