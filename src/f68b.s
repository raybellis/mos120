;********  CLOSE EXEC FILE  **********************************************

			.org	$f68b

_LF68B:			lda	#$00				; A=0

;*************************************************************************
;*									 *
;*	 *EXEC								 *
;*									 *
;*************************************************************************

_OSCLI_EXEC:		php					; save flags on stack
			sty	MOS_WS				; &E6=Y
			ldy	OSB_EXEC_HND			; EXEC file handle
			sta	OSB_EXEC_HND			; EXEC file handle
			beq	_BF69B				; if not 0 close file via OSFIND
			jsr	OSFIND				; 
_BF69B:			ldy	MOS_WS				; else Y= original Y
			plp					; get back flags
			beq	_BF6AB				; if A=0 on entry exit else
			lda	#$40				; A=&40
			jsr	OSFIND				; to open an input file
			tay					; Y=A
			beq	_BF674				; If Y=0 'File not found' else store
			sta	OSB_EXEC_HND			; EXEC file handle
_BF6AB:			rts					; return

;******* read a block	 *************************************************

_LF6AC:			ldx	#$a6				; X=&A6
			jsr	_LFB81				; copy from 301/C+X to 3D2/C sought filename
			jsr	_LF77B				; read block header
_LF6B4:			lda	CFS_BLK_FLAG			; block flag
			lsr					; A=A/2 bit 0 into carry to check for locked file
			bcc	_BF6BD				; if not set then skip next instruction
			jmp	_LF1F6				; 'locked' file routine

_BF6BD:			lda	CFS_BLK_GET			; Expected BGET file block number lo
			sta	CRFS_EXEC			; current block no. lo
			lda	CFS_BLK_GET_HI			; expected BGET file block number hi
			sta	CRFS_EXEC_HI			; current block no. hi
			lda	#$00				; A=0
			sta	CRFS_LOAD			; current load address
			lda	#$0a				; A=&A setting current load address to the CFS/RFS
			sta	CRFS_LOAD_HI			; current load address buffer at &A00
			lda	#$ff				; A=&FF to set other 2 bytes
			sta	CRFS_LOAD_VHI			; current load address high word
			sta	CRFS_LOAD_XHI			; current load address high word
			jsr	_LF7D5				; reset flags
			jsr	_CRFS_LOAD_FILE			; load file from tape
			bne	_BF702				; if return non zero F702 else
			lda	BUFFER_RS423_RX+$FF		; get last character from input buffer
			sta	CFS_LAST_INPUT			; last character currently resident block
			jsr	_LFB69				; inc. current block no.
			stx	CFS_BLK_GET			; expected BGET file block number lo
			sty	CFS_BLK_GET_HI			; expected BGET file block number hi
			ldx	#$02				; X=2
_BF6EE:			lda	CFS_BLK_LEN,X			; read bytes from block flag/block length
			sta	CFS_BLOCK_SZ,X			; store into current values of above
			dex					; X=X-1
			bpl	_BF6EE				; until X=-1 (&FF)

			bit	CFS_BLOCK_FLAG			; block flag of currently resident block
			bpl	_BF6FF				; 
			jsr	_LF249				; print newline if needed
_BF6FF:			jmp	_LFAF2				; enable second processor and reset serial system
_BF702:			jsr	_LF637				; search for a specified block
			bne	_LF6B4				; if NE check for locked condition else
_BF707:			cmp	#$2a				; is it Synchronising byte &2A?
			beq	_BF742				; if so F742
			cmp	#$23				; else is it &23 (header substitute in ROM files)
			bne	_BF71E				; if not BAD ROM error

			inc	CFS_BLK_NUM			; block number
			bne	_BF717				; 
			inc	CFS_BLK_NUM_HI			; block number hi
_BF717:			ldx	#$ff				; X=&FF
			bit	_BD9B7				; to set V & M
			bne	_BF773				; and jump (ALWAYS!!) to F773

_BF71E:			lda	#$f7				; clear bit 3 of RFS status (current CAT status)
			jsr	_LF33D				; RFS status =RFS status AND A

			brk					; and cause error
			.byte	$d7				; error number
			.byte	"Bad ROM"			
			brk					; 

;**********: pick up a header ********************************************

_BF72D:			ldy	#$ff				; get ESCAPE flag
			jsr	_LFB90				; switch Motor on
			lda	#$01				; A=1
			sta	CRFS_PROGRESS			; progress flag
			jsr	_LFB50				; control serial system
_BF739:			jsr	_CFS_READY			; confirm ESC not set and CFS not executing
			lda	#$03				; A=3
			cmp	CRFS_PROGRESS			; progress flag
			bne	_BF739				; back until &C2=3

_BF742:			ldy	#$00				; Y=0
			jsr	_LFB7C				; zero checksum bytes
_BF747:			jsr	_LF797				; get character from file and do CRC
			bvc	_BF766				; if V clear on exit F766
			sta	CFS_FILENAME,Y			; else store
			beq	_BF757				; or if A=0 F757
			iny					; Y=Y+1
			cpy	#$0b				; if Y<>&B
			bne	_BF747				; go back for next character
			dey					; Y=Y-1

_BF757:			ldx	#$0c				; X=12
_BF759:			jsr	_LF797				; get character from file and do CRC
			bvc	_BF766				; if V clear on exit F766
			sta	CFS_FILENAME,X			; else store byte
			inx					; X=X+1
			cpx	#$1f				; if X<>31
			bne	_BF759				; goto F759

_BF766:			tya					; A=Y
			tax					; X=A
			lda	#$00				; A=0
			sta	CFS_FILENAME,Y			; store it
			lda	CRFS_CRC_TMP			; CRC workspace
			ora	CRFS_CRC_TMP_HI			; CRC workspace
			sta	CRFS_CRC_RESULT			; Checksum result
_BF773:			jsr	_LFB78				; set (BE/C0) to 0
			sty	CRFS_PROGRESS			; progress flag
			txa					; A=X
			bne	_BF7D4				; 
_LF77B:			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_BF72D				; if cassette F72D
_BF780:			jsr	_RFS_READ_ROM			; read RFS data rom or Phrom
			cmp	#$2b				; is it ROM file terminator?
			bne	_BF707				; if not F707

;********* terminator found **********************************************

			lda	#$08				; A=8 isolating bit 3 CAT status
			and	CRFS_STATUS			; CFS status byte
			beq	_BF790				; if clera skip next instruction
			jsr	_CRFS_PRINT_NEWLINE		; print CR if CFS not operational
_BF790:			jsr	_LEE18				; get byte from data Rom
			bcc	_BF780				; if carry set F780
			clv					; clear overflow flag
			rts					; return

;****************  get character from file and do CRC  *******************
				;
_LF797:			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_BF7AD				; if cassette F7AD
			txa					; A=X to save X and Y
			pha					; save X on stack
			tya					; A=Y
			pha					; save Y on stack
			jsr	_RFS_READ_ROM			; read RFS data rom or Phrom
			sta	CRFS_BLK_LAST			; put it in temporary storage
			lda	#$ff				; A=&FF
			sta	CRFS_BUFFER_FLAG		; filing system buffer flag
			pla					; get back Y
			tay					; Y=A
			pla					; get back X
			tax					; X=A
_BF7AD:			jsr	_LF884				; check for Escape and loop till bit 7 of FS buffer
								; flag=1

;************************** perform CRC **********************************

_LF7B0:			php					; save flags on stack
			pha					; save A on stack
			sec					; set carry flag
			ror	CRFS_CRC_BIT_CNT		; CRC Bit counter
			eor	CRFS_CRC_TMP_HI			; CRC workspace
			sta	CRFS_CRC_TMP_HI			; CRC workspace
_BF7B9:			lda	CRFS_CRC_TMP_HI			; CRC workspace
			rol					; A=A*2 C=bit 7
			bcc	_BF7CA				; 
			ror					; A=A/2
			eor	#$08				; 
			sta	CRFS_CRC_TMP_HI			; CRC workspace
			lda	CRFS_CRC_TMP			; CRC workspace
			eor	#$10				; 
			sta	CRFS_CRC_TMP			; CRC workspace
			sec					; set carry flag

_BF7CA:			rol	CRFS_CRC_TMP			; CRC workspace
			rol	CRFS_CRC_TMP_HI			; CRC workspace
			lsr	CRFS_CRC_BIT_CNT		; CRC Bit counter
			bne	_BF7B9				; 
			pla					; get back A
			plp					; get back flags
_BF7D4:			rts					; return

_LF7D5:			lda	#$00				; A=0
_LF7D7:			sta	CRFS_BLK_LAST			; &BD=character temporary storage buffer=0
			ldx	#$00				; X=0
			stx	CRFS_BLK_OFFSET			; file status or temporary store
			bvc	_BF7E9				; 
			lda	CFS_BLK_LEN			; block length
			ora	CFS_BLK_LEN_HI			; block length hi
			beq	_BF7E9				; if 0 F7E9

			ldx	#$04				; else X=4
_BF7E9:			stx	CRFS_PROGRESS			; filename length/progress flag
			rts					; return

;*************** SAVE A BLOCK ********************************************

_LF7EC:			php					; save flags on stack
			ldx	#$03				; X=3
			lda	#$00				; A=0
_BF7F1:			sta	CFS_RFS_LO,X			; clear 03CB/E (RFS EOF+1?)
			dex					; X=X-1
			bpl	_BF7F1				; 

			lda	CFS_BLK_NUM			; block number
			ora	CFS_BLK_NUM_HI			; block number hi
			bne	_BF804				; if block =0 F804 else
			jsr	_CFS_DELAY_5_S			; generate a 5 second delay
			beq	_BF807				; goto F807


_BF804:			jsr	_CFS_DELAY_INTERBLOCK		; generate delay set by interblock gap
_BF807:			lda	#$2a				; A=&2A
			sta	CRFS_BLK_LAST			; store it in temporary file
			jsr	_LFB78				; set (BE/C0) to 0
			jsr	_SET_ACIA_CONTROL		; set ACIA control register
			jsr	_LF884				; check for Escape and loop till bit 7 of FS buffer
								; flag=1
			dey					; Y=Y-1
_BF815:			iny					; Y=Y+1
			lda	CFS_FIND_NAME,Y			; move sought filename
			sta	CFS_FILENAME,Y			; into filename block
			jsr	_LF875				; transfer byte to CFS and do CRC
			bne	_BF815				; if filename not complet then do it again

;******: deal with rest of header ****************************************

			ldx	#$0c				; X=12
_BF823:			lda	CFS_FILENAME,X			; get filename byte
			jsr	_LF875				; transfer byte to CFS and do CRC
			inx					; X=X+1
			cpx	#$1d				; until X=29
			bne	_BF823				; 

			jsr	_LF87B				; save checksum to TAPE reset buffer flag
			lda	CFS_BLK_LEN			; block length
			ora	CFS_BLK_LEN_HI			; block length hi
			beq	_BF855				; if 0 F855

			ldy	#$00				; else Y=0
			jsr	_LFB7C				; zero checksum bytes
_BF83E:			lda	(CRFS_LOAD),Y			; get a data byte
			jsr	_LFBD3				; check if second processor file test tube prescence
			beq	_BF848				; if not F848 else

			ldx	TUBE_FIFO3			; Tube FIFO3

_BF848:			txa					; A=X
			jsr	_LF875				; transfer byte to CFS and do CRC
			iny					; Y=Y+1
			cpy	CFS_BLK_LEN			; block length
			bne	_BF83E				; 
			jsr	_LF87B				; save checksum to TAPE reset buffer flag
_BF855:			jsr	_LF884				; check for Escape and loop till bit 7 of FS buffer
								; flag=1
			jsr	_LF884				; check for Escape and loop till bit 7 of FS buffer
								; flag=1
			jsr	_RESET_ACIA			; reset ACIA

			lda	#$01				; A=1
			jsr	_CFS_DELAY_100_MS		; generate 0.1 * A second delay
			plp					; get back flags
			jsr	_CRFS_PRINT_FILENAME		; update block flag, PRINT filename (& address if reqd)
			bit	CFS_BLK_FLAG			; block flag
			bpl	_BF874				; is this last block (bit 7 set)?
			php					; save flags on stack
			jsr	_CFS_DELAY_5_S			; generate a 5 second delay
			jsr	_LF246				; sound bell and abort
			plp					; get back flags
_BF874:			rts					; return

;****************** transfer byte to CFS and do CRC **********************
				;
_LF875:			jsr	_LF882				; save byte to buffer, transfer to CFS & reset flag
			jmp	_LF7B0				; perform CRC

;***************** save checksum to TAPE reset buffer flag ****************

_LF87B:			lda	CRFS_CRC_TMP_HI			; CRC workspace
			jsr	_LF882				; save byte to buffer, transfer to CFS & reset flag
			lda	CRFS_CRC_TMP			; CRC workspace

;************** save byte to buffer, transfer to CFS & reset flag ********

_LF882:			sta	CRFS_BLK_LAST			; store A in temporary buffer

;***** check for Escape and loop untill bit 7 of FS buffer flag=1 ***********

_LF884:			jsr	_CFS_READY			; confirm ESC not set and CFS not executing
			bit	CRFS_BUFFER_FLAG		; filing system buffer flag
			bpl	_LF884				; loop until bit 7 of &C0 is set

			lda	#$00				; A=0
			sta	CRFS_BUFFER_FLAG		; filing system buffer flag
			lda	CRFS_BLK_LAST			; get temporary store byte
			rts					; return

;****************** generate a 5 second delay  ***************************

_CFS_DELAY_5_S:		lda	#$32				; A=50
			bne	_CFS_DELAY_100_MS		; generate delay 100ms *A (5 seconds)

;*************** generate delay set by interblock gap ********************

_CFS_DELAY_INTERBLOCK:	lda	CFS_INTERBLOCK			; get current interblock flag

;*************** generate delay ******************************************

_CFS_DELAY_100_MS:	ldx	#$05				; X=5
_BF89A:			sta	OSB_CFS_TIMEOUT			; CFS timeout counter
_BF89D:			jsr	_CFS_READY			; confirm ESC not set and CFS not executing
			bit	OSB_CFS_TIMEOUT			; CFS timeout counter (decremented each 20ms)
			bpl	_BF89D				; if +ve F89D
			dex					; X=X-1
			bne	_BF89A				; 
			rts					; return

;************: generate screen reports ***********************************

_LF8A9:			lda	CFS_BLK_NUM			; block number
			ora	CFS_BLK_NUM_HI			; block number hi
			beq	_LF8B6				; if 0 F8B6
			bit	CFS_LAST_FLAGS			; copy of last read block flag
			bpl	_CRFS_PRINT_FILENAME		; update block flag, PRINT filename (& address if reqd)
_LF8B6:			jsr	_LF249				; print newline if needed

;************** update block flag, PRINT filename (& address if reqd) ****

_CRFS_PRINT_FILENAME:	ldy	#$00				; Y=0
			sty	CRFS_BLOCK_FLAG			; current block flag
			lda	CFS_BLK_FLAG			; block flag
			sta	CFS_LAST_FLAGS			; copy of last read block flag
			jsr	_CFS_CHECK_BUSY			; check if free to print message
			beq	_BF933				; if A=0 on return Cassette system is busy
			lda	#$0d				; else A=&0D :carriage return
			jsr	OSWRCH				; print it (note no linefeed as it's via OSWRCH)
__crfs_print_nextch:	lda	CFS_FILENAME,Y			; get byte from filename
			beq	_BF8E2				; if 0 filename is ended
			cmp	#$20				; if <SPACE
			bcc	__crfs_print_ctrlch		; F8DA
			cmp	#$7f				; if less than DELETE
			bcc	__crfs_print_filech		; its a printable character for F8DC else

;*******************Control characters in RFS/CFS filename ******************

__crfs_print_ctrlch:	lda	#$3f				; else A='?'
__crfs_print_filech:	jsr	OSWRCH				; and print it

			iny					; Y=Y+1
			bne	__crfs_print_nextch		; back to get rest of filename

;***************** end of filename ***************************************

_BF8E2:			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_BF8EB				; if cassette F8EB
			bit	CRFS_OPTS			; test current OPTions
			bvc	_BF933				; if bit 6 clear no,long messages needed F933
_BF8EB:			jsr	_PRINT_SPACE			; print a space
			iny					; Y=Y+1
			cpy	#$0b				; if Y<11 then
			bcc	_BF8E2				; loop again to fill out filename with spaces

			lda	CFS_BLK_NUM			; block number
			tax					; X=A
			jsr	_PRINT_HEX			; print ASCII equivalent of hex byte
			bit	CFS_BLK_FLAG			; block flag
			bpl	_BF933				; if not end of file return
			txa					; A=X
			clc					; clear carry flag
			adc	CFS_BLK_LEN_HI			; block length hi
			sta	CRFS_FILE_SIZE_HI		; file length counter hi
			jsr	_PRINT_SPACE_HEX		; print space + ASCII equivalent of hex byte
			lda	CFS_BLK_LEN			; block length
			sta	CRFS_FILE_SIZE			; file length counter lo
			jsr	_PRINT_HEX			; print ASCII equivalent of hex byte
			bit	CRFS_OPTS			; current OPTions
			bvc	_BF933				; if bit 6 clear no long messages required so F933

			ldx	#$04				; X=4
_BF917:			jsr	_PRINT_SPACE			; print a space
			dex					; X=X-1
			bne	_BF917				; loop to print 4 spaces

			ldx	#$0f				; X=&0F to point to load address
			jsr	_LF927				; print 4 bytes from CFS block header
			jsr	_PRINT_SPACE			; print a space
			ldx	#$13				; X=&13 point to Execution address

;************** print 4 bytes from CFS block header **********************

_LF927:			ldy	#$04				; loop pointer
_BF929:			lda	CFS_FILENAME,X			; block header
			jsr	_PRINT_HEX			; print ASCII equivalent of hex byte
			dex					; X=X-1
			dey					; Y=Y-1
			bne	_BF929				; 

_BF933:			rts					; return

;*********** print prompt for SAVE on TAPE *******************************

_LF934:			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_BF93C				; if cassette F93C
			jmp	_USERV				; else 'Bad Command error message'
_BF93C:			jsr	_LFB8E				; switch Motor On
			jsr	_LFBE2				; set up CFS for write operation
			jsr	_CFS_CHECK_BUSY			; check if free to print message
			beq	_BF933				; if not exit else
			jsr	_CRFS_PRINT_MSG			; print message following call

			.byte	"RECORD then RETURN"		; 
			brk					; 

;************ wait for RETURN key to be pressed **************************

_WAIT_FOR_RETURN:	jsr	_CFS_READY			; confirm CFS not operating, nor ESCAPE flag set
			jsr	OSRDCH				; wait for keypress
			cmp	#$0d				; is it &0D (RETURN)
			bne	_WAIT_FOR_RETURN		; no then do it again

			jmp	OSNEWL				; output Carriage RETURN and LINE FEED

;************* increment current load address ****************************

_INC_LOAD_ADDRESS:	inc	CRFS_LOAD_HI			; current load address
			bne	_BF974				; 
			inc	CRFS_LOAD_VHI			; current load address high word
			bne	_BF974				; 
			inc	CRFS_LOAD_XHI			; current load address high word
_BF974:			rts					; return

;************* print a space + ASCII equivalent of hex byte **************

_PRINT_SPACE_HEX:	pha					; save A on stack
			jsr	_PRINT_SPACE			; print a space
			pla					; get back A

;************** print ASCII equivalent of hex byte  **********************

_PRINT_HEX:		pha					; save A on stack
			lsr					; /16 to put high nybble in lo
			lsr					; 
			lsr					; 
			lsr					; 
			jsr	_PRINT_HEX_NYBBLE		; print its ASCII equivalent
			pla					; get back A

_PRINT_HEX_NYBBLE:	clc					; clear carry flag
			and	#$0f				; clear high nybble
			adc	#$30				; Add &30 to convert 0-9 to ASCII A-F to : ; < = > ?
			cmp	#$3a				; if A< ASC(':')
			bcc	__print_hex_done		; goto F98E
			adc	#$06				; else add 7 to convert : ; < = > ? to A B C D E F

__print_hex_done:	jmp	OSWRCH				; print character and return

;******************** print a space  *************************************

_PRINT_SPACE:		lda	#$20				; A=' '
			bne	__print_hex_done		; goto F98E to print it

;******************** confirm CFS not operating, nor ESCAPE flag set *****

_CFS_READY:		php					; save flags on stack
			bit	CRFS_ACTIVE			; CFS Active flag
			bmi	_BF99E				; 
			bit	ESCAPE_FLAG			; if ESCAPE condition
			bmi	_BF9A0				; goto F9A0
_BF99E:			plp					; get back flags
			rts					; return

_BF9A0:			jsr	_LF33B				; close input file
			jsr	_LFAF2				; enable second processor and reset serial system
			lda	#$7e				; A=&7E (126) Acknowledge ESCAPE
			jsr	OSBYTE				; OSBYTE Call

			brk					; 
			.byte	$11				; error 17
			.byte	"Escape"			; 
			brk					; 


