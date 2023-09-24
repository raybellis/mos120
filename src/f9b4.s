; OS SERIES 10
; LAST PART
; GEOFF COX
;****************************** LOAD *************************************

			.org	$f9b4

_CRFS_LOAD_FILE:	tya					; A=Y
			beq	_BF9C4				; 
			jsr	_CRFS_PRINT_MSG			; print message following call

			.byte	$0d				; 
			.byte	"Loading"			; 
			.byte	$0d				; 
			brk					; 

_BF9C4:			sta	CRFS_BLOCK_FLAG			; current block flag
			ldx	#$ff				; X=&FF
			lda	CRFS_CRC_RESULT			; Checksum result
			bne	_LF9D9				; if not 0 F9D9
			jsr	_LFA72				; else check filename header block matches searched
								; filename if this returns NE then no match
			php					; save flags on stack
			ldx	#$ff				; X=&FF
			ldy	#$99				; Y=&99
			lda	#$fa				; A=&FA this set Y/A to point to 'File?' FA99
			plp					; get back flags
			bne	_BF9F5				; report a query unexpected file name

_LF9D9:			ldy	#$8e				; making Y/A point to 'Data' FA8E for CRC error
			lda	CRFS_CRC_RESULT			; Checksum result
			beq	_BF9E3				; if 0 F9E3
			lda	#$fa				; A=&FA
			bne	_BF9F5				; jump to F9F5

_BF9E3:			lda	CFS_BLK_NUM			; block number
			cmp	CRFS_EXEC			; current block no. lo
			bne	_BF9F1				; if not eual F9F1
			lda	CFS_BLK_NUM_HI			; block number hi
			cmp	CRFS_EXEC_HI			; current block no. hi
			beq	_BFA04				; if equal FA04

_BF9F1:			ldy	#$a4				; Y=&A4
			lda	#$fa				; A=&FA	 point to 'Block?' error unexpected block no.

				; at this point an error HAS occurred

_BF9F5:			pha					; save A on stack
			tya					; A=Y
			pha					; save Y on stack
			txa					; A=X
			pha					; save X on stack
			jsr	_LF8B6				; print CR if indicated by current block flag
			pla					; get back A
			tax					; X=A
			pla					; get back A
			tay					; Y=A
			pla					; get back A
			bne	_BFA18				; jump to FA18

_BFA04:			txa					; A=X
			pha					; save A on stack
			jsr	_LF8A9				; report
			jsr	_LFAD6				; check loading progress, read another byte
			pla					; get back A
			tax					; X=A
			lda	CRFS_CRC_TMP			; CRC workspace
			ora	CRFS_CRC_TMP_HI			; CRC workspace
			beq	_BFA8D				; 
			ldy	#$8e				; Y=&8E
			lda	#$fa				; A=&FA	 FA8E points to 'Data?'
_BFA18:			dec	CRFS_BLOCK_FLAG			; current block flag
			pha					; save A on stack
			bit	CRFS_ACTIVE			; CFS Active flag
			bmi	_BFA2C				; if active FA2C
			txa					; A=X
			and	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			bne	_BFA2C				; 
			txa					; A=X
			and	#$11				; 
			and	CRFS_OPTS			; current OPTions
			beq	_BFA3C				; ignore errors
_BFA2C:			pla					; get back A
			sta	CRFS_ERR_PTR_HI			; store A on &B9
			sty	CRFS_ERR_PTR			; store Y on &B8
			jsr	_LF68B				; do *EXEC 0 to tidy up
			lsr	CRFS_ACTIVE			; halve CFS Active flag to clear bit 7

			jsr	_LFAE8				; bell, reset ACIA & motor
			jmp	(CRFS_ERR_PTR)			; display selected error report

_BFA3C:			pla					; get back A
			iny					; Y=Y+1
			bne	_BFA43				; 
			clc					; clear carry flag
			adc	#$01				; Add 1
_BFA43:			pha					; save A on stack
			tya					; A=Y
			pha					; save Y on stack
_CRFS_PRINT_MSG:	jsr	_CFS_CHECK_BUSY			; check if free to print message
			tay					; Y=A
_PRINT_MSG:		pla					; get back A
			sta	CRFS_ERR_PTR			; &B8=8
			pla					; get back A
			sta	CRFS_ERR_PTR_HI			; &B9=A
			tya					; A=Y
			php					; save flags on stack
_LFA52:			inc	CRFS_ERR_PTR			; 
			bne	_BFA58				; 
			inc	CRFS_ERR_PTR_HI			; 
_BFA58:			ldy	#$00				; Y=0
			lda	(CRFS_ERR_PTR),Y		; get byte
			beq	_BFA68				; if 0 Fa68
			plp					; get back flags
			php					; save flags on stack
			beq	_LFA52				; if 0 FA52 to get next character
			jsr	OSASCI				; else print
			jmp	_LFA52				; and do it again

_BFA68:			plp					; get back flags
			inc	CRFS_ERR_PTR			; increment pointers
			bne	_BFA6F				; 
			inc	CRFS_ERR_PTR_HI			; 
_BFA6F:			jmp	(CRFS_ERR_PTR)			; and print error message so no error condition
								; occcurs

;************ compare filenames ******************************************

_LFA72:			ldx	#$ff				; X=&FF inx will mean X=0

_BFA74:			inx					; X=X+1
			lda	CFS_FIND_NAME,X			; sought filename byte
			bne	_BFA81				; if not 0 FA81
			txa					; else A=X
			beq	_BFA80				; if X=0 A=0 exit
			lda	CFS_FILENAME,X			; else A=filename byte
_BFA80:			rts					; return
								;
_BFA81:			jsr	_LE4E3				; set carry if byte in A is not upper case Alpha
			eor	CFS_FILENAME,X			; compare with filename
			bcs	_BFA8B				; if carry set FA8B
			and	#$df				; else convert to upper case
_BFA8B:			beq	_BFA74				; and if A=0 filename characters match so do it again
_BFA8D:			rts					; return
								;
			brk					; 
			.byte	$d8				; error number
			.byte	$0d,"Data?"			; 
			brk					; 

			bne	_BFAAE				; 

			brk					; 
			.byte	$db				; error number
			.byte	$0d,"File?"			; 
			brk					; 

			bne	_BFAAE				; 

			brk					; 
			.byte	$da				; error number
			.byte	$0d,"Block?"			
			brk					; 

_BFAAE:			lda	CRFS_BLOCK_FLAG			; current block flag
			beq	_BFAD3				; if 0 FAD3 else
			txa					; A=X
			beq	_BFAD3				; If X=0 FAD3
			lda	#$22				; A=&22
			bit	CRFS_OPTS			; current OPTions checking bits 1 and 5
			beq	_BFAD3				; if neither set no  retry so FAD3 else
			jsr	_RESET_ACIA			; reset ACIA
			tay					; Y=A
			jsr	_PRINT_MSG			; print following message

			.byte	$0d				; Carriage RETURN
			.byte	$07				; BEEP
			.byte	"Rewind tape"			; 
			.word	$0d0d				; two more newlines
			brk					; 

_BFAD2:			rts					; return

_BFAD3:			jsr	_CRFS_PRINT_NEWLINE		; print CR if CFS not operational
_LFAD6:			lda	CRFS_PROGRESS			; filename length/progress flag
			beq	_BFAD2				; if 0 return else
			jsr	_CFS_READY			; confirm ESC not set and CFS not executing
			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_LFAD6				; if CFS FAD6
			jsr	_CRFS_READ			; else set up ACIA etc
			jmp	_LFAD6				; and loop back again

;********** sound bell, reset ACIA, motor off ****************************

_LFAE8:			jsr	_CFS_CHECK_BUSY			; check if free to print message
			beq	_LFAF2				; enable second processor and reset serial system
			lda	#$07				; beep
			jsr	OSWRCH				; 
_LFAF2:			lda	#$80				; 
			jsr	_LFBBD				; enable 2nd proc. if present and set up osfile block
			ldx	#$00				; 
			jsr	_LFB95				; switch on motor
_LFAFC:			php					; save flags on stack
			sei					; prevent IRQ interrupts
			lda	OSB_SERPROC			; get serial ULA control register setting
			sta	SERIAL_ULA			; write to serial ULA control register setting
			lda	#$00				; A=0
			sta	RS423_TIMEOUT			; store A RS423 timeout counter
			beq	_BFB0B				; jump FB0B

_LFB0A:			php					; save flags on stacksave flags
_BFB0B:			jsr	_RESET_ACIA			; release ACIA (by &FE08=3)
			lda	OSB_RS423_CTL			; get last setting of ACIA
			jmp	_LE189				; set ACIA and &250 from A before exit

_BFB14:			plp					; get back flags
			bit	ESCAPE_FLAG			; if bit 7of ESCAPE flag not set
			bpl	_BFB31				; then FB31
			rts					; else return as unserviced ESCAPE is pending


;*************************************************************************
;*									 *
;*	 Claim serial system for sequential Access			 *
;*									 *
;*************************************************************************

_LFB1A:			lda	CRFS_OPTIONS			; get cassette filing system options byte
								; high nybble used for LOAD & SAVE operations
								; low nybble used for sequential access

				; 0000	 Ignore errors,		 no messages
				; 0001	 Abort if error,	 no messages
				; 0010	 Retry after error,	 no messages
				; 1000	 Ignore error		 short messages
				; 1001	 Abort if error		 short messages
				; 1010	 Retry after error	 short messages
				; 1100	 Ignore error		 long messages
				; 1101	 Abort if error		 long messages
				; 1110	 Retry after error	 long messages

			asl					; move low nybble into high nybble
			asl					; 
			asl					; 
			asl					; 
			sta	CRFS_OPTS			; current OPTions save into &BB
			lda	SEQ_BLOCK_GAP			; get sequential block gap
			bne	_BFB2F				; goto to &FB2F


;*************************************************************************
;*									 *
;*	 claim serial system for cassette etc.				 *
;*									 *
;*************************************************************************

_CFS_CLAIM_SERIAL:	lda	CRFS_OPTIONS			; get cassette filing system options byte
								; high nybble used for LOAD & SAVE operations
								; low nybble used for sequential access

				; 0000	 Ignore errors,		 no messages
				; 0001	 Abort if error,	 no messages
				; 0010	 Retry after error,	 no messages
				; 1000	 Ignore error		 short messages
				; 1001	 Abort if error		 short messages
				; 1010	 Retry after error	 short messages
				; 1100	 Ignore error		 long messages
				; 1101	 Abort if error		 long messages
				; 1110	 Retry after error	 long messages

			and	#$f0				; clear low nybble
			sta	CRFS_OPTS			; as current OPTions
			lda	#$06				; set current interblock gap
_BFB2F:			sta	CFS_INTERBLOCK			; to 6

_BFB31:			cli					; allow interrupts
			php					; save flags on stack
			sei					; prevent interrupts
			bit	OSB_RS423_USE			; check if RS423 is busy
			bpl	_BFB14				; if not FB14
			lda	RS423_TIMEOUT			; see if RS423 has timed out
			bmi	_BFB14				; if not FB14

			lda	#$01				; else load RS423 timeout counter with
			sta	RS423_TIMEOUT			; 1 to indicate that cassette has 6850
			jsr	_RESET_ACIA			; reset ACIA with &FE80=3
			plp					; get back flags
			rts					; return

_RESET_ACIA:		lda	#$03				; A=3
			bne	_BFB65				; and exit after resetting ACIA


;**********************	 set ACIA control register  **********************

_SET_ACIA_CONTROL:	lda	#$30				; set current ACIA control register
			sta	CFS_SERIAL_CTRL			; to &30
			bne	_LFB63				; and goto FB63
								; if bit 7=0 motor off 1=motor on

;***************** control cassette system *******************************

_LFB50:			lda	#$05				; set &FE10 to 5
			sta	SERIAL_ULA			; setting a transmit baud rate of 300,motor off

			ldx	#$ff				; 
__cfs_delay_loop:	dex					; delay loop
			bne	__cfs_delay_loop		; 

			stx	CFS_SERIAL_CTRL			; &CA=0
			lda	#$85				; Turn motor on and keep baud rate at 300 recieve
			sta	SERIAL_ULA			; 19200 transmit
			lda	#$d0				; A=&D0

_LFB63:			ora	CFS_BAUD_RATE			; 
_BFB65:			sta	ACIA_CSR			; set up ACIA control register
			rts					; returnand return

_LFB69:			ldx	CFS_BLK_NUM			; block number
			ldy	CFS_BLK_NUM_HI			; block number hi
			inx					; X=X+1
			stx	CRFS_EXEC			; current block no. lo
			bne	_BFB75				; 
			iny					; Y=Y+1
_BFB75:			sty	CRFS_EXEC_HI			; current block no. hi
			rts					; return
								;
_LFB78:			ldy	#$00				; 
			sty	CRFS_BUFFER_FLAG		; filing system buffer flag

;*****************set (zero) checksum bytes ******************************

_LFB7C:			sty	CRFS_CRC_TMP			; CRC workspace
			sty	CRFS_CRC_TMP_HI			; CRC workspace
			rts					; return

;*********** copy sought filename routine ********************************

_LFB81:			ldy	#$ff				; Y=&FF
_BFB83:			iny					; Y=Y+1
			inx					; X=X+1
			lda	VDU_G_WIN_L,X			; 
			sta	CFS_FIND_NAME,Y			; sought filename
			bne	_BFB83				; until end of filename (0)
			rts					; return
								;
_LFB8E:			ldy	#$00				; Y=0

;********************** switch Motor on **********************************

_LFB90:			cli					; allow	  IRQ interrupts
			ldx	#$01				; X=1
			sty	CFS_HANDLE			; store Y as current file handle

;********************: control motor ************************************

_LFB95:			lda	#$89				; do osbyte 137
			ldy	CFS_HANDLE			; get back file handle (preserved thru osbyte)
			jmp	OSBYTE				; turn on motor

;****************** confirm file is open  ********************************

_LFB9C:			sta	CRFS_BLK_OFFSET			; file status or temporary store
			tya					; A=Y
			eor	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			tay					; Y=A
			lda	CRFS_STATUS			; CFS status byte
			and	CRFS_BLK_OFFSET			; file status or temporary store
			lsr					; A=A/2
			dey					; Y=Y-1
			beq	_BFBAF				; 
			lsr					; A=A/2
			dey					; Y=Y-1
			bne	_LFBB1				; 
_BFBAF:			bcs	_BFBFE				; 

_LFBB1:			brk					; 
			.byte	$de				; error number
			.byte	"Channel"			; 
			brk					; 

;************* read from second processor ********************************

_LFBBB:			lda	#$01				; A=1
_LFBBD:			jsr	_LFBD3				; check if second processor file test tube prescence
			beq	_BFBFE				; if not exit
			txa					; A=X
			ldx	#$b0				; current load address
			ldy	#$00				; Y=00
_LFBC7:			pha					; save A on stack
			lda	#$c0				; filing system buffer flag
_BFBCA:			jsr	TUBE_ENTRY_2			; and out to TUBE
			bcc	_BFBCA				; 
			pla					; get back A
			jmp	TUBE_ENTRY_2			; 

;*************** check if second processor file test tube prescence ******

_LFBD3:			tax					; X=A
			lda	CRFS_LOAD_VHI			; current load address high word
			and	CRFS_LOAD_XHI			; current load address high word
			cmp	#$ff				; 
			beq	_BFBE1				; if &FF then its for base processor
			lda	OSB_TUBE_FOUND			; &FF if tube present
			and	#$80				; to set bit 7 alone
_BFBE1:			rts					; return

;******** control ACIA and Motor *****************************************

_LFBE2:			lda	#$85				; A=&85
			sta	SERIAL_ULA			; write to serial ULA control register setting
			jsr	_RESET_ACIA			; reset ACIA
			lda	#$10				; A=16
			jsr	_LFB63				; set ACIA to CFS baud rate
_BFBEF:			jsr	_CFS_READY			; confirm ESC not set and CFS not executing
			lda	ACIA_CSR			; read ACIA status register
			and	#$02				; clear all but bit 1
			beq	_BFBEF				; if clear FBEF
			lda	#$aa				; else A=&AA
			sta	ACIA_TXRX			; transmit data register
_BFBFE:			rts					; return

			brk					; 

