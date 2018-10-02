;********  CLOSE EXEC FILE  **********************************************

.org		$f68b

_LF68B:		lda	#$00		; A=0

;*************************************************************************
;*                                                                       *
;*       *EXEC                                                           *
;*                                                                       *
;*************************************************************************

_LF68D:		php			; save flags on stack
		sty	$E6		; &E6=Y
		ldy	$0256		; EXEC file handle
		sta	$0256		; EXEC file handle
		beq	_BF69B		; if not 0 close file via OSFIND
		jsr	OSFIND		; 
_BF69B:		ldy	$E6		; else Y= original Y
		plp			; get back flags
		beq	_BF6AB		; if A=0 on entry exit else
		lda	#$40		; A=&40
		jsr	OSFIND		; to open an input file
		tay			; Y=A
		beq	_BF674		; If Y=0 'File not found' else store
		sta	$0256		; EXEC file handle
_BF6AB:		rts			; return

;******* read a block    *************************************************

_LF6AC:		ldx	#$A6		; X=&A6
		jsr	_LFB81		; copy from 301/C+X to 3D2/C sought filename
		jsr	_LF77B		; read block header
_LF6B4:		lda	$03ca		; block flag
		lsr			; A=A/2 bit 0 into carry to check for locked file
		bcc	_BF6BD		; if not set then skip next instruction
		jmp	_LF1F6		; 'locked' file routine

_BF6BD:		lda	$03dd		; Expected BGET file block number lo
		sta	$B4		; current block no. lo
		lda	$03de		; expected BGET file block number hi
		sta	$B5		; current block no. hi
		lda	#$00		; A=0
		sta	$B0		; current load address
		lda	#$0A		; A=&A setting current load address to the CFS/RFS
		sta	$B1		; current load address buffer at &A00
		lda	#$FF		; A=&FF to set other 2 bytes
		sta	$B2		; current load address high word
		sta	$B3		; current load address high word
		jsr	_LF7D5		; reset flags
		jsr	_LF9B4		; load file from tape
		bne	_BF702		; if return non zero F702 else
		lda	$0aff		; get last character from input buffer
		sta	$02ed		; last character currently resident block
		jsr	_LFB69		; inc. current block no.
		stx	$03dd		; expected BGET file block number lo
		sty	$03de		; expected BGET file block number hi
		ldx	#$02		; X=2
_BF6EE:		lda	$03c8,X		; read bytes from block flag/block length
		sta	$02ea,X		; store into current values of above
		dex			; X=X-1
		bpl	_BF6EE		; until X=-1 (&FF)

		bit	$02ec		; block flag of currently resident block
		bpl	_BF6FF		; 
		jsr	_LF249		; print newline if needed
_BF6FF:		jmp	_LFAF2		; enable second processor and reset serial system
_BF702:		jsr	_LF637		; search for a specified block
		bne	_LF6B4		; if NE check for locked condition else
_BF707:		cmp	#$2A		; is it Synchronising byte &2A?
		beq	_BF742		; if so F742
		cmp	#$23		; else is it &23 (header substitute in ROM files)
		bne	_BF71E		; if not BAD ROM error

		inc	$03c6		; block number
		bne	_BF717		; 
		inc	$03c7		; block number hi
_BF717:		ldx	#$FF		; X=&FF
		bit	_BD9B7		; to set V & M
		bne	_BF773		; and jump (ALWAYS!!) to F773

_BF71E:		lda	#$F7		; clear bit 3 of RFS status (current CAT status)
		jsr	_LF33D		; RFS status =RFS status AND A

		brk			; and cause error
		.byte	$D7		; error number
		.byte	"Bad ROM"
		brk			; 

;**********: pick up a header ********************************************

;; was missing immediate in original source
_BF72D:		ldy	#$FF		; get ESCAPE flag
		jsr	_LFB90		; switch Motor on
		lda	#$01		; A=1
		sta	$C2		; progress flag
		jsr	_LFB50		; control serial system
_BF739:		jsr	_LF995		; confirm ESC not set and CFS not executing
		lda	#$03		; A=3
		cmp	$C2		; progress flag
		bne	_BF739		; back until &C2=3

_BF742:		ldy	#$00		; Y=0
		jsr	_LFB7C		; zero checksum bytes
_BF747:		jsr	_LF797		; get character from file and do CRC
		bvc	_BF766		; if V clear on exit F766
		sta	$03b2,Y		; else store
		beq	_BF757		; or if A=0 F757
		iny			; Y=Y+1
		cpy	#$0B		; if Y<>&B
		bne	_BF747		; go back for next character
		dey			; Y=Y-1

_BF757:		ldx	#$0C		; X=12
_BF759:		jsr	_LF797		; get character from file and do CRC
		bvc	_BF766		; if V clear on exit F766
		sta	$03b2,X		; else store byte
		inx			; X=X+1
		cpx	#$1F		; if X<>31
		bne	_BF759		; goto F759

_BF766:		tya			; A=Y
		tax			; X=A
		lda	#$00		; A=0
		sta	$03b2,Y		; store it
		lda	$BE		; CRC workspace
		ora	$BF		; CRC workspace
		sta	$C1		; Checksum result
_BF773:		jsr	_LFB78		; set (BE/C0) to 0
		sty	$C2		; progress flag
		txa			; A=X
		bne	_BF7D4		; 
_LF77B:		lda	$0247		; filing system flag 0=CFS 2=RFS
		beq	_BF72D		; if cassette F72D
_BF780:		jsr	_LEE51		; read RFS data rom or Phrom
		cmp	#$2B		; is it ROM file terminator?
		bne	_BF707		; if not F707

;********* terminator found **********************************************

		lda	#$08		; A=8 isolating bit 3 CAT status
		and	$E2		; CFS status byte
		beq	_BF790		; if clera skip next instruction
		jsr	_LF24D		; print CR if CFS not operational
_BF790:		jsr	_BEE18		; get byte from data Rom
		bcc	_BF780		; if carry set F780
		clv			; clear overflow flag
		rts			; return

;****************  get character from file and do CRC  *******************
		; 
_LF797:		lda	$0247		; filing system flag 0=CFS 2=RFS
		beq	_BF7AD		; if cassette F7AD
		txa			; A=X to save X and Y
		pha			; save X on stack
		tya			; A=Y
		pha			; save Y on stack
		jsr	_LEE51		; read RFS data rom or Phrom
		sta	$BD		; put it in temporary storage
		lda	#$FF		; A=&FF
		sta	$C0		; filing system buffer flag
		pla			; get back Y
		tay			; Y=A
		pla			; get back X
		tax			; X=A
_BF7AD:		jsr	_LF884		; check for Escape and loop till bit 7 of FS buffer
					; flag=1

;************************** perform CRC **********************************

_LF7B0:		php			; save flags on stack
		pha			; save A on stack
		sec			; set carry flag
		ror	$CB		; CRC Bit counter
		eor	$BF		; CRC workspace
		sta	$BF		; CRC workspace
_BF7B9:		lda	$BF		; CRC workspace
		rol			; A=A*2 C=bit 7
		bcc	_BF7CA		; 
		ror			; A=A/2
		eor	#$08		; 
		sta	$BF		; CRC workspace
		lda	$BE		; CRC workspace
		eor	#$10		; 
		sta	$BE		; CRC workspace
		sec			; set carry flag

_BF7CA:		rol	$BE		; CRC workspace
		rol	$BF		; CRC workspace
		lsr	$CB		; CRC Bit counter
		bne	_BF7B9		; 
		pla			; get back A
		plp			; get back flags
_BF7D4:		rts			; return

_LF7D5:		lda	#$00		; A=0
_LF7D7:		sta	$BD		; &BD=character temporary storage buffer=0
		ldx	#$00		; X=0
		stx	$BC		; file status or temporary store
		bvc	_BF7E9		; 
		lda	$03c8		; block length
		ora	$03c9		; block length hi
		beq	_BF7E9		; if 0 F7E9

		ldx	#$04		; else X=4
_BF7E9:		stx	$C2		; filename length/progress flag
		rts			; return

;*************** SAVE A BLOCK ********************************************

_LF7EC:		php			; save flags on stack
		ldx	#$03		; X=3
		lda	#$00		; A=0
_BF7F1:		sta	$03cb,X		; clear 03CB/E (RFS EOF+1?)
		dex			; X=X-1
		bpl	_BF7F1		; 

		lda	$03c6		; block number
		ora	$03c7		; block number hi
		bne	_BF804		; if block =0 F804 else
		jsr	_LF892		; generate a 5 second delay
		beq	_BF807		; goto F807


_BF804:		jsr	_LF896		; generate delay set by interblock gap
_BF807:		lda	#$2A		; A=&2A
		sta	$BD		; store it in temporary file
		jsr	_LFB78		; set (BE/C0) to 0
		jsr	_LFB4A		; set ACIA control register
		jsr	_LF884		; check for Escape and loop till bit 7 of FS buffer
					; flag=1
		dey			; Y=Y-1
_BF815:		iny			; Y=Y+1
		lda	$03d2,Y		; move sought filename
		sta	$03b2,Y		; into filename block
		jsr	_LF875		; transfer byte to CFS and do CRC
		bne	_BF815		; if filename not complet then do it again

;******: deal with rest of header ****************************************

		ldx	#$0C		; X=12
_BF823:		lda	$03b2,X		; get filename byte
		jsr	_LF875		; transfer byte to CFS and do CRC
		inx			; X=X+1
		cpx	#$1D		; until X=29
		bne	_BF823		; 

		jsr	_LF87B		; save checksum to TAPE reset buffer flag
		lda	$03c8		; block length
		ora	$03c9		; block length hi
		beq	_BF855		; if 0 F855

		ldy	#$00		; else Y=0
		jsr	_LFB7C		; zero checksum bytes
_BF83E:		lda	($B0),Y		; get a data byte
		jsr	_LFBD3		; check if second processor file test tube prescence
		beq	_BF848		; if not F848 else

		ldx	$fee5		; Tube FIFO3

_BF848:		txa			; A=X
		jsr	_LF875		; transfer byte to CFS and do CRC
		iny			; Y=Y+1
		cpy	$03c8		; block length
		bne	_BF83E		; 
		jsr	_LF87B		; save checksum to TAPE reset buffer flag
_BF855:		jsr	_LF884		; check for Escape and loop till bit 7 of FS buffer
					; flag=1
		jsr	_LF884		; check for Escape and loop till bit 7 of FS buffer
					; flag=1
		jsr	_LFB46		; reset ACIA

		lda	#$01		; A=1
		jsr	_LF898		; generate 0.1 * A second delay
		plp			; get back flags
		jsr	_LF8B9		; update block flag, PRINT filename (& address if reqd)
		bit	$03ca		; block flag
		bpl	_BF874		; is this last block (bit 7 set)?
		php			; save flags on stack
		jsr	_LF892		; generate a 5 second delay
		jsr	_LF246		; sound bell and abort
		plp			; get back flags
_BF874:		rts			; return

;****************** transfer byte to CFS and do CRC **********************
		; 
_LF875:		jsr	_LF882		; save byte to buffer, transfer to CFS & reset flag
		jmp	_LF7B0		; perform CRC

;***************** save checksum to TAPE reset buffer flag ****************

_LF87B:		lda	$BF		; CRC workspace
		jsr	_LF882		; save byte to buffer, transfer to CFS & reset flag
		lda	$BE		; CRC workspace

;************** save byte to buffer, transfer to CFS & reset flag ********

_LF882:		sta	$BD		; store A in temporary buffer

;***** check for Escape and loop untill bit 7 of FS buffer flag=1 ***********

_LF884:		jsr	_LF995		; confirm ESC not set and CFS not executing
		bit	$C0		; filing system buffer flag
		bpl	_LF884		; loop until bit 7 of &C0 is set

		lda	#$00		; A=0
		sta	$C0		; filing system buffer flag
		lda	$BD		; get temporary store byte
		rts			; return

;****************** generate a 5 second delay  ***************************

_LF892:		lda	#$32		; A=50
		bne	_LF898		; generate delay 100ms *A (5 seconds)

;*************** generate delay set by interblock gap ********************

_LF896:		lda	$C7		; get current interblock flag

;*************** generate delay ******************************************

_LF898:		ldx	#$05		; X=5
_BF89A:		sta	$0240		; CFS timeout counter
_BF89D:		jsr	_LF995		; confirm ESC not set and CFS not executing
		bit	$0240		; CFS timeout counter (decremented each 20ms)
		bpl	_BF89D		; if +ve F89D
		dex			; X=X-1
		bne	_BF89A		; 
		rts			; return

;************: generate screen reports ***********************************

_LF8A9:		lda	$03c6		; block number
		ora	$03c7		; block number hi
		beq	_BF8B6		; if 0 F8B6
		bit	$03df		; copy of last read block flag
		bpl	_LF8B9		; update block flag, PRINT filename (& address if reqd)
_BF8B6:		jsr	_LF249		; print newline if needed

;************** update block flag, PRINT filename (& address if reqd) ****

_LF8B9:		ldy	#$00		; Y=0
		sty	$BA		; current block flag
		lda	$03ca		; block flag
		sta	$03df		; copy of last read block flag
		jsr	_LE7DC		; check if free to print message
		beq	_BF933		; if A=0 on return Cassette system is busy
		lda	#$0D		; else A=&0D :carriage return
		jsr	OSWRCH		; print it (note no linefeed as it's via OSWRCH)
_BF8CD:		lda	$03b2,Y		; get byte from filename
		beq	_BF8E2		; if 0 filename is ended
		cmp	#$20		; if <SPACE
		bcc	_BF8DA		; F8DA
		cmp	#$7F		; if less than DELETE
		bcc	_BF8DC		; its a printable character for F8DC else

;*******************Control characters in RFS/CFS filename ******************

_BF8DA:		lda	#$3F		; else A='?'
_BF8DC:		jsr	OSWRCH		; and print it

		iny			; Y=Y+1
		bne	_BF8CD		; back to get rest of filename

;***************** end of filename ***************************************

_BF8E2:		lda	$0247		; filing system flag 0=CFS 2=RFS
		beq	_BF8EB		; if cassette F8EB
		bit	$BB		; test current OPTions
		bvc	_BF933		; if bit 6 clear no,long messages needed F933
_BF8EB:		jsr	_LF991		; print a space
		iny			; Y=Y+1
		cpy	#$0B		; if Y<11 then
		bcc	_BF8E2		; loop again to fill out filename with spaces

		lda	$03c6		; block number
		tax			; X=A
		jsr	_LF97A		; print ASCII equivalent of hex byte
		bit	$03ca		; block flag
		bpl	_BF933		; if not end of file return
		txa			; A=X
		clc			; clear carry flag
		adc	$03c9		; block length hi
		sta	$CD		; file length counter hi
		jsr	_LF975		; print space + ASCII equivalent of hex byte
		lda	$03c8		; block length
		sta	$CC		; file length counter lo
		jsr	_LF97A		; print ASCII equivalent of hex byte
		bit	$BB		; current OPTions
		bvc	_BF933		; if bit 6 clear no long messages required so F933

		ldx	#$04		; X=4
_BF917:		jsr	_LF991		; print a space
		dex			; X=X-1
		bne	_BF917		; loop to print 4 spaces

		ldx	#$0F		; X=&0F to point to load address
		jsr	_LF927		; print 4 bytes from CFS block header
		jsr	_LF991		; print a space
		ldx	#$13		; X=&13 point to Execution address

;************** print 4 bytes from CFS block header **********************

_LF927:		ldy	#$04		; loop pointer
_BF929:		lda	$03b2,X		; block header
		jsr	_LF97A		; print ASCII equivalent of hex byte
		dex			; X=X-1
		dey			; Y=Y-1
		bne	_BF929		; 

_BF933:		rts			; return

;*********** print prompt for SAVE on TAPE *******************************

_LF934:		lda	$0247		; filing system flag 0=CFS 2=RFS
		beq	_BF93C		; if cassette F93C
		jmp	_LE310		; else 'Bad Command error message'
_BF93C:		jsr	_LFB8E		; switch Motor On
		jsr	_LFBE2		; set up CFS for write operation
		jsr	_LE7DC		; check if free to print message
		beq	_BF933		; if not exit else
		jsr	_LFA46		; print message following call

		.byte	"RECORD then RETURN"		; 
		brk			; 

_BF95D:		jsr	_LF995		; confirm CFS not operating, nor ESCAPE flag set

;************ wait for RETURN key to be pressed **************************

		jsr	OSRDCH		; wait for keypress
		cmp	#$0D		; is it &0D (RETURN)
		bne	_BF95D		; no then do it again

		jmp	OSNEWL		; output Carriage RETURN and LINE FEED

;************* increment current load address ****************************

_LF96A:		inc	$B1		; current load address
		bne	_BF974		; 
		inc	$B2		; current load address high word
		bne	_BF974		; 
		inc	$B3		; current load address high word
_BF974:		rts			; return

;************* print a space + ASCII equivalent of hex byte **************

_LF975:		pha			; save A on stack
		jsr	_LF991		; print a space
		pla			; get back A

;************** print ASCII equivalent of hex byte  **********************

_LF97A:		pha			; save A on stack
		lsr			; /16 to put high nybble in lo
		lsr			; 
		lsr			; 
		lsr			; 
		jsr	_LF983		; print its ASCII equivalent
		pla			; get back A

_LF983:		clc			; clear carry flag
		and	#$0F		; clear high nybble
		adc	#$30		; Add &30 to convert 0-9 to ASCII A-F to : ; < = > ?
		cmp	#$3A		; if A< ASC(':')
		bcc	_BF98E		; goto F98E
		adc	#$06		; else add 7 to convert : ; < = > ? to A B C D E F

_BF98E:		jmp	OSWRCH		; print character and return

;******************** print a space  *************************************

_LF991:		lda	#$20		; A=' '
		bne	_BF98E		; goto F98E to print it

;******************** confirm CFS not operating, nor ESCAPE flag set *****

_LF995:		php			; save flags on stack
		bit	$EB		; CFS Active flag
		bmi	_BF99E		; 
		bit	$FF		; if ESCAPE condition
		bmi	_BF9A0		; goto F9A0
_BF99E:		plp			; get back flags
		rts			; return

_BF9A0:		jsr	_LF33B		; close input file
		jsr	_LFAF2		; enable second processor and reset serial system
		lda	#$7E		; A=&7E (126) Acknowledge ESCAPE
		jsr	OSBYTE		; OSBYTE Call

		brk			; 
		.byte	$11		; error 17
		.byte	"Escape"		; 
		brk			; 


