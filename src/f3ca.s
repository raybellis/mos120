;*************************************************************************
;*									 *
;*	 OSFIND	 ENTRY							 *
;*	 file handling							 *
;*									 *
;*************************************************************************
;on entry A determines Action Y may contain file handle or
;X/Y point to filename terminated by &0D in memory
;A=0	closes file in channel Y if Y=0 closes all files
;A=&40	open a file for input  (reading) X/Y points to filename
;A=&80	open a file for output (writing) X/Y points to filename
;A=&C0	open a file for input and output (random access)
;ON EXIT Y=0 if no file found else Y=channel number in use for file

				; save A X and Y
			.org	$f3ca

_FINDV:			sta	CRFS_BLK_OFFSET			; file status or temporary store
			txa					; A=X
			pha					; save X on stack
			tya					; A=Y
			pha					; save Y on stack
			lda	CRFS_BLK_OFFSET			; file status or temporary store
			bne	_BF3F2				; if A is non zero open a file via F3F2

;************ close a file ***********************************************

			tya					; A=Y
			bne	_BF3E3				; if A<> 0 close specified file else close them all
			jsr	_OSBYTE_119			; close spool/exec files via OSBYTE 77
			jsr	_LF478				; tidy up
_BF3DD:			lsr	CRFS_STATUS			; CFS status byte is shifted left and right to zero
			asl	CRFS_STATUS			; bit 0
			bcc	_BF3EF				; and if carry clear no input file was open so F3EF

_BF3E3:			lsr					; A contains file handle so shift bit 0 into carry
			bcs	_BF3DD				; if carry set close input file
			lsr					; else shift bit 1 into carry
			bcs	_BF3EC				; if carry set close output file
			jmp	_LFBB1				; else report 'Channel Error' as CFS can only support
								; 1 input and 1 output file

_BF3EC:			jsr	_LF478				; tidy up
_BF3EF:			jmp	_LF471				; and exit

;************ OPEN A FILE ************************************************

_BF3F2:			jsr	_LF25A				; get filename from BUFFER
			bit	CRFS_BLK_OFFSET			; file status or temporary store
			bvc	_BF436				; check A at input if bit 6 not set its an output file

;********* Input files +**************************************************

			lda	#$00				; else its an input file
			sta	CFS_BGET_OFFSET			; BGET buffer offset for next byte
			sta	CFS_BLK_GET			; Expected BGET file block number lo
			sta	CFS_BLK_GET_HI			; expected BGET file block number hi
			lda	#$3e				; A=&3E
			jsr	_LF33D				; CFS status =CFS status AND A
			jsr	_LFB1A				; claim serial system and set OPTions
			php					; save flags on stack
			jsr	_LF631				; search for file
			jsr	_LF6B4				; check protection bit of block status and respond
			plp					; get back flags
			ldx	#$ff				; X=&FF increment to 0 on next instruction

_BF416:			inx					; X=X+1
			lda	CFS_FILENAME,X			; get file name and
			sta	CFS_BGET_FILE,X			; store as BGET filename
			bne	_BF416				; until end of filename

			lda	#$01				; A=1 to show file open
			jsr	_LF344				; set status bits from A
			lda	CFS_BLOCK_SZ			; CFS currently resident file block length lo
			ora	CFS_BLOCK_SZ_HI			; CFS currently resident file block length hi
			bne	_BF42F				; if block length is 0
			jsr	_LF342				; set CFS status bit 3 (EOF reached)
								; else
_BF42F:			lda	#$01				; A=1
			ora	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			bne	_LF46F				; and exit after restoring registers

;******************* open an output file***********************************

_BF436:			txa					; A=X

			bne	_BF43C				; if X=0 then zero length filename so
			jmp	_LEA8F				; Bad String error

_BF43C:			ldx	#$ff				; X=&FF
_BF43E:			inx					; X=X+1
								; copy sought filename to header block
			lda	CFS_FIND_NAME,X			; sought filename
			sta	BPUT_FILENAME,X			; BPUT file header block
			bne	_BF43E				; until A=0 end of filename
			lda	#$ff				; A=&FF
			ldx	#$08				; X=8

_BF44B:			sta	BPUT_LOAD_LO-1,X		; set 38C/93 to &FF
			dex					; X=X-1
			bne	_BF44B				; 

			txa					; A=X=0
			ldx	#$14				; X=14
_BF454:			sta	BPUT_FILENAME,X			; BPUT file header block
			inx					; X=X+1
			cpx	#$1e				; this zeros 394/D
			bne	_BF454				; 

			rol	BPUT_BLK_LEN_HI			; 
			jsr	_CFS_CLAIM_SERIAL		; Set cassette optionsinto (BB),set C7=6
								; claim serial system for cassette
			jsr	_LF934				; prompt to start recording
			jsr	_LFAF2				; enable second processor and reset serial system
			lda	#$02				; A=2
			jsr	_LF344				; set status bits from A
			lda	#$02				; A=2
_LF46F:			sta	CRFS_BLK_OFFSET			; file status or temporary store
_LF471:			pla					; get back A
			tay					; Y=A
			pla					; get back A
			tax					; X=A
			lda	CRFS_BLK_OFFSET			; file status or temporary store
_BF477:			rts					; return
								;

_LF478:			lda	#$02				; A=2 clearing all but bit 1 of status byte
			and	CRFS_STATUS			; CFS status byte, with output file open
			beq	_BF477				; if file not open then exit
			lda	#$00				; else A=0
			sta	BPUT_BLK_LEN_HI			; setting block length to current value of BPUT offset
			lda	#$80				; A=&80
			ldx	CFS_BPUT_OFFSET			; get BPUT buffer ofset
			stx	BPUT_BLK_LEN			; setting block length to current value of BPUT offset
			sta	BPUT_BLK_FLAG			; mark current block as last
			jsr	_LF496				; save block to tape
			lda	#$fd				; A=&FD
			jmp	_LF33D				; CFS status =CFS status AND A

;*********** SAVE BLOCK TO TAPE ********************************************

_LF496:			jsr	_LFB1A				; claim serial system and set OPTions

			ldx	#$11				; X=11
_BF49B:			lda	BPUT_LOAD_LO,X			; copy header block from 38C-39D
			sta	CFS_LOAD_LO,X			; to 3BE/DF
			dex					; X=X-1
			bpl	_BF49B				; 
								; X=&FF
			stx	CRFS_LOAD_VHI			; current load address high word
			stx	CRFS_LOAD_XHI			; current load address high word
			inx					; X=X+1, (X=0)
			stx	CRFS_LOAD			; current load address lo byte set to &00
			lda	#$09				; A=9 to set current load address at &900
			sta	CRFS_LOAD_HI			; current load address
			ldx	#$7f				; X=&7F
			jsr	_LFB81				; copy from 301/C+X to 3D2/C sought filename
			sta	CFS_LAST_FLAGS			; copy of last read block flag
			jsr	_LFB8E				; switch Motor On
			jsr	_LFBE2				; set up CFS for write operation
			jsr	_LF7EC				; write block to Tape
			inc	BPUT_BLK_NUM			; block number lo
			bne	_BF4C8				; 
			inc	BPUT_BLK_NUM_HI			; block number hi
_BF4C8:			rts					; return


;*************************************************************************
;*									 *
;*									 *
;*	 OSBGET	 get a byte from a file					 *
;*									 *
;*									 *
;*************************************************************************
				; on ENTRY	 Y contains channel number
				; on EXIT	 X and Y are preserved C=0 indicates valid character
				; A contains character (or error) A=&FE End Of File

				; push X and Y
_BGETV:			txa					; A=X
			pha					; save A on stack
			tya					; A=Y
			pha					; save A on stack
			lda	#$01				; A=1
			jsr	_LFB9C				; check conditions for OSBGET are OK
			lda	CRFS_STATUS			; CFS status byte
			asl					; shift bit 7 into carry (EOF warning given)
			bcs	_BF523				; if carry set F523
			asl					; shift bit 6 into carry
			bcc	_BF4E3				; if clear EOF not reached F4E3
			lda	#$80				; else A=&80 setting bit 7 of status byte EOF warning
			jsr	_LF344				; set status bits from A
			lda	#$fe				; A=&FE
			bcs	_BF51B				; if carry set F51B

_BF4E3:			ldx	CFS_BGET_OFFSET			; BGET buffer offset for next byte
			inx					; X=X+1
			cpx	CFS_BLOCK_SZ			; CFS currently resident file block length lo
			bne	_BF516				; read a byte
								; else
			bit	CFS_BLOCK_FLAG			; block flag of currently resident block
			bmi	_BF513				; if bit 7=1 this is the last block so F513 else
			lda	CFS_LAST_INPUT			; last character of currently resident block
			pha					; save A on stack
			jsr	_LFB1A				; claim serial system and set OPTions
			php					; save flags on stack
			jsr	_LF6AC				; read in a new block
			plp					; get back flags
			pla					; get back A
			sta	CRFS_BLK_OFFSET			; file status or temporary store
			clc					; clear carry flag
			bit	CFS_BLOCK_FLAG			; block flag of currently resident block
			bpl	_BF51D				; if not last block (bit 7=0)
			lda	CFS_BLOCK_SZ			; CFS currently resident file block length lo
			ora	CFS_BLOCK_SZ_HI			; CFS currently resident file block length hi
			bne	_BF51D				; if block size not 0 F51D else
			jsr	_LF342				; set CFS status bit 6 (EOF reached)
			bne	_BF51D				; goto F51D

_BF513:			jsr	_LF342				; set CFS status bit 6 (EOF reached)
_BF516:			dex					; X=X-1
			clc					; clear carry flag
			lda	BUFFER_RS423_RX,X		; read byte from cassette buffer

_BF51B:			sta	CRFS_BLK_OFFSET			; file status or temporary store
_BF51D:			inc	CFS_BGET_OFFSET			; BGET buffer offset for next byte
			jmp	_LF471				; exit via F471

_BF523:			brk					; 
			.byte	$df				; error number
			.byte	"EOF"				; 
			brk					; 


;*************************************************************************
;*									 *
;*									 *
;*	 OSBPUT	 WRITE A BYTE TO FILE					 *
;*									 *
;*									 *
;*************************************************************************
;ON ENTRY  Y contains channel number A contains byte to be written

_BPUTV:			sta	CRFS_TMP			; store A in temorary store
			txa					; and stack X and Y
			pha					; save	on stack
			tya					; A=Y
			pha					; save on stack

			lda	#$02				; A=2
			jsr	_LFB9C				; check conditions necessary for OSBPUT are OK
			ldx	CFS_BPUT_OFFSET			; BPUT buffer offset for next byte
			lda	CRFS_TMP			; get back original value of A
			sta	BUFFER_RS423_TX,X		; Cassette buffer
			inx					; X=X+1
			bne	_BF545				; if not 0 F545, otherwise buffer is full so
			jsr	_LF496				; save block to tape
			jsr	_LFAF2				; enable second processor and reset serial system
_BF545:			inc	CFS_BPUT_OFFSET			; BPUT buffer offset for next byte
			lda	CRFS_TMP			; get back A
			jmp	_LF46F				; and exit


;*************************************************************************
;*									 *
;*									 *
;*	 OSBYTE 139	 Select file options				 *
;*									 *
;*									 *
;*************************************************************************
;ON ENTRY  Y contains option value  X contains option No. see *OPT X,Y
;this applies largely to CFS LOAD SAVE CAT and RUN
;X=1	is message switch
;	Y=0 no messages
;	Y=1 short messages
;	Y=2 gives detailed information on load and execution addresses

;X=2	is error handling
;	Y=0 ignore errors
;	Y=1 prompt for a retry
;	Y=2 abort operation

;X=3	is interblock gap for BPUT# and PRINT#
;	Y=0-127 set gap in 1/10ths Second
;	Y > 127 use default values

_FSCV_OPT:		txa					; A=X
			beq	_BF57E				; if A=0 F57E
			cpx	#$03				; if X=3
			beq	_BF573				; F573 to set interblock gap
			cpy	#$03				; else if Y>2 then BAD COMMAND error
			bcs	_BF55E				; 
			dex					; X=X-1
			beq	_BF561				; i.e. if X=1 F561 message control
			dex					; X=X-1
			beq	_BF568				; i.e. if X=2 F568 error response
_BF55E:			jmp	_USERV				; else E310 to issue Bad Command error

;*********** message control *********************************************

_BF561:			lda	#$33				; to set lower two bits of each nybble as mask
			iny					; Y=Y+1
			iny					; Y=Y+1
			iny					; Y=Y+1
			bne	_BF56A				; goto F56A

;*********** error response *********************************************

_BF568:			lda	#$cc				; setting top two bits of each nybble as mask
_BF56A:			iny					; Y=Y+1
			and	CRFS_OPTIONS			; clear lower two bits of each nybble
_BF56D:			ora	_LF581,Y			; or with table value
			sta	CRFS_OPTIONS			; store it in &E3
			rts					; return

				; setting of &E3
				;
				; lower nybble sets LOAD options
				; upper sets SAVE options

				; 0000	 Ignore errors,		 no messages
				; 0001	 Abort if error,	 no messages
				; 0010	 Retry after error,	 no messages
				; 1000	 Ignore error		 short messages
				; 1001	 Abort if error		 short messages
				; 1010	 Retry after error	 short messages
				; 1100	 Ignore error		 long messages
				; 1101	 Abort if error		 long messages
				; 1110	 Retry after error	 long messages

;***********set interblock gap *******************************************

_BF573:			tya					; A=Y
			bmi	_BF578				; if Y>127 use default values
			bne	_BF57A				; if Y<>0 skip next instruction
_BF578:			lda	#$19				; else A=&19

_BF57A:			sta	SEQ_BLOCK_GAP			; sequential block gap
			rts					; return
								;
_BF57E:			tay					; Y=A
			beq	_BF56D				; jump to F56D

;*********** DEFAULT OPT VALUES TABLE ************************************

_LF581:			.byte	$a1				; %1010 0001
			.byte	$00				; %0000 0000
			.byte	$22				; %0010 0010
			.byte	$11				; %0001 0001
			.byte	$00				; %0000 0000
			.byte	$88				; %1000 1000
			.byte	$cc				; %1100 1100

_CRFS_READ:		dec	CRFS_BUFFER_FLAG		; filing system buffer flag
			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	__crfs_read_acia		; if CFS F596

			jsr	_RFS_READ_ROM			; read RFS data rom or Phrom
			tay					; Y=A
			clc					; clear carry flag
			bcc	_BF5B0				; jump to F5B0

__crfs_read_acia:	lda	ACIA_CSR			; ACIA status register
			pha					; save A on stack
			and	#$02				; clear all but bits 0,1 A=(0-3)
			beq	_BF5A9				; if 0 F5A9 transmit data register full or RDR empty
			ldy	CFS_SERIAL_CTRL			; 
			beq	_BF5A9				; 
			pla					; get back A
			lda	CRFS_BLK_LAST			; character temporary storage
			sta	ACIA_TXRX			; ACIA transmit data register
			rts					; return
								;
_BF5A9:			ldy	ACIA_TXRX			; read ACIA recieve data register
			pla					; get back A
			lsr					; bit 2 to carry (data carrier detect)
			lsr					; 
			lsr					; 

_BF5B0:			ldx	CRFS_PROGRESS			; progress flag
			beq	_BF61D				; if &C2=0 exit
			dex					; X=X-1
			bne	_BF5BD				; if &C2>1 then F5BD
			bcc	_BF61D				; else if carrier tone from cassette detected exit

			ldy	#$02				; Y=2

			bne	_BF61B				; 
_BF5BD:			dex					; X=X-1
			bne	_BF5D3				; if &C2>2
			bcs	_BF61D				; if carrier tone from cassette not detected  exit
			tya					; A=Y
			jsr	_LFB78				; set (BE/C0) to 0
			ldy	#$03				; Y=3
			cmp	#$2a				; is A= to synchronising byte &2A?
			beq	_BF61B				; if so F61B
			jsr	_LFB50				; control cassette system
			ldy	#$01				; Y=1
			bne	_BF61B				; goto F61B
_BF5D3:			dex					; X=X-1
			bne	_BF5E2				; if &C2>3
			bcs	_BF5DC				; 
			sty	CRFS_BLK_LAST			; get character read into Y
			beq	_BF61D				; if 0 exit via F61D
_BF5DC:			lda	#$80				; else A=&80
			sta	CRFS_BUFFER_FLAG		; filing system buffer flag
			bne	_BF61D				; and exit

_BF5E2:			dex					; X=X-1
			bne	_BF60E				; if &C2>4 F60E
			bcs	_BF616				; if carry set F616
			tya					; A=Y
			jsr	_LF7B0				; perform CRC
			ldy	CRFS_BLK_OFFSET			; file status or temporary store
			inc	CRFS_BLK_OFFSET			; file status or temporary store
			bit	CRFS_BLK_LAST			; if bit 7 set this is the last byte read
			bmi	_BF600				; so F600
			jsr	_LFBD3				; check if second processor file test tube prescence
			beq	_BF5FD				; if return with A=0 F5FD
			stx	TUBE_FIFO3			; Tube FIFO3
			bne	_BF600				; 

_BF5FD:			txa					; A=X restore value
			sta	(CRFS_LOAD),Y			; store to current load address
_BF600:			iny					; Y=Y+1
			cpy	CFS_BLK_LEN			; block length
			bne	_BF61D				; exit
			lda	#$01				; A=1
			sta	CRFS_BLK_OFFSET			; file status or temporary store
			ldy	#$05				; Y=5
			bne	_BF61B				; exit

_BF60E:			tya					; A=Y
			jsr	_LF7B0				; perform CRC
			dec	CRFS_BLK_OFFSET			; file status or temporary store
			bpl	_BF61D				; exit

_BF616:			jsr	_RESET_ACIA			; reset ACIA
			ldy	#$00				; Y=0
_BF61B:			sty	CRFS_PROGRESS			; progress flag
_BF61D:			rts					; return


;*************************************************************************
;*									 *
;*	 FSCV &01 - check for end of file				 *
;*									 *
;*************************************************************************
				;
_FSCV_EOF:		pha					; save A on stack
			tya					; A=Y
			pha					; save Y on stack
			txa					; A=X to put X into Y
			tay					; Y=A
			lda	#$03				; A=3
			jsr	_LFB9C				; confirm file is open
			lda	CRFS_STATUS			; CFS status byte
			and	#$40				; 
			tax					; X=A
			pla					; get back A
			tay					; Y=A
			pla					; get back A
			rts					; return
								;
_LF631:			lda	#$00				; A=0
			sta	CRFS_EXEC			; current block no. lo
			sta	CRFS_EXEC_HI			; current block no. hi
_LF637:			lda	CRFS_EXEC			; current block no. lo
			pha					; save A on stack
			sta	CRFS_NEXT_BLK			; next block no. lo
			lda	CRFS_EXEC_HI			; current block no. hi
			pha					; save A on stack
			sta	CRFS_NEXT_BLK_HI		; next block no. hi
			jsr	_CRFS_PRINT_MSG			; print message following call

			.byte	"Searching"			; 
			.byte	$0d				; newline
			brk					; 

			lda	#$ff				; A=&FF
			jsr	_LF348				; read data from CFS/RFS
			pla					; get back A
			sta	CRFS_EXEC_HI			; current block no. hi
			pla					; get back A
			sta	CRFS_EXEC			; current block no. lo
			lda	CRFS_NEXT_BLK			; next block no. lo
			ora	CRFS_NEXT_BLK_HI		; next block no. hi
			bne	_BF66D				; 
			sta	CRFS_EXEC			; current block no. lo
			sta	CRFS_EXEC_HI			; current block no. hi
			lda	CRFS_CRC_RESULT			; checksum result
			bne	_BF66D				; 
			ldx	#$b1				; current load address
			jsr	_LFB81				; copy from 301/C+X to 3D2/C sought filename
_BF66D:			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_BF685				; if cassette F685
			bvs	_BF685				; 

_BF674:			brk					; 
			.byte	$d6				; Error number
			.byte	"File not found"		
			brk					; 

_BF685:			ldy	#$ff				; Y=&FF
			sty	CFS_LAST_FLAGS			; copy of last read block flag
			rts					; return


