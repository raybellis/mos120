; OS SERIES 9
; GEOFF COX
;*************************************************************************
;*									 *
;*	 OSBYTE 140  *TAPE						 *
;*	 selects TAPE filing system					 *
;*									 *
;*	 OSBYTE 141  *ROM						 *
;*	 selects ROM filing system					 *
;*									 *
;*************************************************************************

			.org	$f135

_OSBYTE_140_141:	eor	#$8c				; if it's *TAPE A=0 *ROM A=1
_LF137:			asl					; double it
			sta	OSB_CFSRFC_SW			; store it in filing system flag store
			cpx	#$03				; if X>=3 C set X=3 Z set
			jmp	_LF14B				; 

;******** set cassette options *******************************************
				; called after BREAK etc
				; lower nybble sets sequential access
				; upper sets load and save options

				; 0000	 Ignore errors,		 no messages
				; 0001	 Abort if error,	 no messages
				; 0010	 Retry after error,	 no messages
				; 1000	 Ignore error		 short messages
				; 1001	 Abort if error		 short messages
				; 1010	 Retry after error	 short messages
				; 1100	 Ignore error		 long messages
				; 1101	 Abort if error		 long messages
				; 1110	 Retry after error	 long messages

_LF140:			php					; save flags
			lda	#$a1				; set sequential access abort if error, no messages
			sta	CRFS_OPTIONS			; set load/save retry if error, short messages
			lda	#$19				; set interblock gap
			sta	SEQ_BLOCK_GAP			; and store it
			plp					; get back flags

_LF14B:			php					; push flags
			lda	#$06				; get close files command to FSCV
			jsr	_OSCLI_FSCV			; and gosub OSFSC
			ldx	#$06				; 
			plp					; get back flags
			beq	_BF157				; if Z set earlier
			dex					; do not decrement X
_BF157:			stx	CFS_BAUD_RATE			; set current baud rate X=5 300 baud X=6 1200 baud

;********* reset FILEV,ARGSV,BGETV,BPUTV,GBPBV,FINDV,FSCV ******************
;**********   to F27D, F18E, F4C9, F529, FFA6, F3CA, F1B1 ******************

			ldx	#$0e				; RESET VECTORS FOR FILE RELATED OPERATIONS
__vec_reset_loop:	lda	_VECTOR_TABLE + $11,X		; 
			sta	VEC_USERV + $11,X		; 
			dex					; 
			bne	__vec_reset_loop		; 

			stx	CRFS_PROGRESS			; &C2=0 PROGRESS FLAG
			ldx	#$0f				; set X to make Rom service call &F claim vectors!


;*************************************************************************
;*									 *
;*	 OSBYTE 143							 *
;*	 Pass service commands to sideways ROMs				 *
;*									 *
;*************************************************************************
				; On entry X=service call number
				; Y=any additional parameter
				; On entry X=0 if claimed, or preserved if unclaimed
				; Y=any returned parameter
				; When called internally, EQ set if call claimed

_OSBYTE_143:		lda	ROM_SELECT			; Get current ROM number
			pha					; Save it
			txa					; Pass service call number to  A
			ldx	#$0f				; Start at ROM 15

				; Issue service call loop
_BF16E:			inc	ROM_TABLE,X			; Read bit 7 on ROM type table (no ROM has type 254 &FE)
			dec	ROM_TABLE,X			; 
			bpl	_BF183				; If not set (+ve result), step to next ROM down
			stx	ROM_SELECT			; Otherwise, select this ROM, &F4 RAM copy
			stx	ROM_LATCH			; Page in selected ROM
			jsr	ROM_SERVICE			; Call the ROM's service entry
								; X and P do not need to be preserved by the ROM
			tax					; On exit pass A to X to chech if claimed
			beq	_BF186				; If 0, service call claimed, reselect ROM and exit
			ldx	ROM_SELECT			; Otherwise, get current ROM back
_BF183:			dex					; Step to next ROM down
			bpl	_BF16E				; Loop until done ROM 0

_BF186:			pla					; Get back original ROM number
			sta	ROM_SELECT			; Set ROM number RAM copy
			sta	ROM_LATCH			; Page in the original ROM
			txa					; Pass X back to A to set zero flag
			rts					; And return


;*************************************************************************
;*									 *
;*	 CFS OSARGS entry point						 *
;*
;*************************************************************************

_ARGSV:			ora	#$00				; is A=00
			bne	_BF1A2				; if not return
			cpy	#$00				; is Y=0
			bne	_BF1A2				; if not return
			lda	CFS_BAUD_RATE			; else get current baud rate and zero bit 2
			and	#$fb				; C6=5 becomes 1, 6 becomes 2
			ora	OSB_CFSRFC_SW			; if cassette selected A=0 else A=2
			asl					; multiply by 2
			ora	OSB_CFSRFC_SW			; Or it again
			lsr					; divide by 2
_BF1A2:			rts					; return cassette =0

;*************************************************************************
;*									 *
;*	 FSC	 VECTOR	 TABLE						 *
;*									 *
;*************************************************************************

_FSCV_TABLE:		.word	_FSCV_OPT - 1			; *OPT		  (F54C)
			.word	_FSCV_EOF - 1			; check EOF	  (F61D)
			.word	_FSCV_RUN - 1			; */		  (F304)
			.word	_USERV - 1			; unknown command (E30F)
			.word	_FSCV_RUN - 1			; *RUN		  (F304)
			.word	_FSCV_CAT - 1			; *CAT		  (F32A)
			.word	_OSBYTE_119 - 1			; osbyte 77	  (E274)


;*************************************************************************
;*	 Filing System control entry	 OSFSC				 *
;*	 Entry via 021E FSCV						 *
;*	 A= index 0 to 7						 *
;*************************************************************************
				; on entry A is reason code
				; A=0	 A *OPT command has been used X & Y are the 2 parameters
				; A=1	 EOF is being checked, on entry	 X=File handle
;				  on Exit X=FF = EOF exists else 00
				; A=2	 A */ command has been used *RUN the file
				; A=3	 An unrecognised OS command has ben used X,Y point at command
				; A=4	 A *RUN command has been used X,Y point at filename
				; A=5	 A *CAT cammand has been issued X,Y point to rest of command
				; A=6	 New filing system about to take over, close SPOOL & EXEC files
				; A=7	 Return in X and Y lowest and highest file handle used
				; A=8	 OS about to process *command

_FSCV:			cmp	#$07				; if A>6
			bcs	_BF1A2				; goto F1A2 (RTS)
			stx	CRFS_BLK_OFFSET			; else save X
			asl					; A=A*2
			tax					; X=A to get offset
			lda	_FSCV_TABLE + 1,X		; get hi byte of address
			pha					; push it
			lda	_FSCV_TABLE,X			; get lo byte of address
			pha					; push it
			ldx	CRFS_BLK_OFFSET			; get back X
			rts					; this now jumps to the address got from the table +1
								; the next RTS takes us back to CLI


;*************************************************************************
;*									 *
;*	 LOAD FILE							 *
;*									 *
;*************************************************************************

_LF1C4:			php					; save flags on stack
			pha					; save A on stack
			jsr	_CFS_CLAIM_SERIAL		; Set cassette optionsinto (BB),set C7=6
								; claim serial system for cassette
			lda	CFS_EXEC_LO			; execution address LO
			pha					; save A on stack
			jsr	_LF631				; search for file
			pla					; get back A
			beq	_BF1ED				; if A=0 F1ED
			ldx	#$03				; else X=3
			lda	#$ff				; A=&FF
_BF1D7:			pha					; save A on stack
			lda	CFS_LOAD_LO,X			; get load address
			sta	CRFS_LOAD,X			; store it as current load address
			pla					; get back A
			and	CRFS_LOAD,X			; 
			dex					; X=X-1
			bpl	_BF1D7				; until all 4 bytes copied

			cmp	#$ff				; if all bytes contain don't contain &FF
			bne	_BF1ED				; continue
			jsr	_LFAE8				; else sound bell, reset ACIA & motor off
			jmp	_LE267				; 'Bad Address' error

_BF1ED:			lda	CFS_BLK_FLAG			; block flag
			lsr					; set carry from bit 0
			pla					; get back A
			beq	_BF202				; if A=0 F202
			bcc	_BF209				; if carry clear F209

;*************** LOCKED FILE ROUTINE *************************************

_LF1F6:			jsr	_LFAF2				; enable second processor and reset serial system

			brk					; 
			.byte	$d5				; error number	;; was &E5
			.byte	"Locked"			; 
			brk					; 

_BF202:			bcc	_BF209				; if carry clear F209
			lda	#$03				; else A=3
			sta	OSB_ESC_BRK			; store to cause ESCAPE disable and memory
								; clear on break

_BF209:			lda	#$30				; 
			and	CRFS_OPTS			; current OPTions
			beq	_BF213				; if options and #&30 =0 ignore error condition is set
			lda	CRFS_CRC_RESULT			; else get checksum result
			bne	_BF21D				; and if not 0 F21D

_BF213:			tya					; A=Y
			pha					; save A on stack
			jsr	_LFBBB				; read from second processor if present
			pla					; get back A
			tay					; Y=A
			jsr	_LF7D5				; reset flags and check block length
_BF21D:			jsr	_CRFS_LOAD_FILE			; load file from tape
			bne	_BF255				; if not found return to search
			jsr	_LFB69				; increment current block number
			bit	CFS_BLK_FLAG			; block flag
			bmi	_BF232				; if bit 7=1 then this is last block so F232
			jsr	_INC_LOAD_ADDRESS		; else increment current load address
			jsr	_LF77B				; read block header
			bne	_BF209				; and goto F209

;******** store data in OSFILE parameter block ***************************

_BF232:			ldy	#$0a				; Y=&0A
			lda	CRFS_FILE_SIZE			; file length counter lo
			sta	(CRFS_OSFILE_PTR),Y		; OSFILE parameter  block
			iny					; Y=Y+1
			lda	CRFS_FILE_SIZE_HI		; file length counter hi
			sta	(CRFS_OSFILE_PTR),Y		; OSFILE parameter  block
			lda	#$00				; A=0
			iny					; Y=Y+1
			sta	(CRFS_OSFILE_PTR),Y		; OSFILE parameter  block
			iny					; Y=Y+1
			sta	(CRFS_OSFILE_PTR),Y		; OSFILE parameter  block
			plp					; get back flags
_LF246:			jsr	_LFAE8				; bell, reset ACIA & motor
_LF249:			bit	CRFS_BLOCK_FLAG			; current block flag
			bmi	_BF254				; return
_CRFS_PRINT_NEWLINE:	php					; save flags on stack
			jsr	_CRFS_PRINT_MSG			; print message following call (in this case NEWLINE!)
			.byte	$0d,$00				; message
			plp					; restore flags
_BF254:			rts					; return
								;
;************RETRY AFTER A FAILURE ROUTINE *******************************

_BF255:			jsr	_LF637				; search for a specified block
			bne	_BF209				; goto F209

;*********** Read Filename using Command Line Interpreter ****************

;filename pointed to by X and Y

_LF25A:			stx	TEXT_PTR			; OS filename/command line pointer lo
			sty	TEXT_PTR_HI			; OS filename/command line pointer
			ldy	#$00				; Y=0
			jsr	_LEA1D				; initialise string
			ldx	#$00				; X=0
_BF265:			jsr	_GSREAD				; GSREAD call
			bcs	_BF277				; if end of character string F277
			beq	_BF274				; if 0 found F274
			sta	CFS_FIND_NAME,X			; else store character in CFS filename area
			inx					; X=X+1
			cpx	#$0b				; if X<>11
			bne	_BF265				; then read next
_BF274:			jmp	_LEA8F				; else Bad String error

;************* terminate Filename ****************************************

_BF277:			lda	#$00				; terminate filename with 0
			sta	CFS_FIND_NAME,X			; 
			rts					; return


;*************************************************************************
;*									 *
;*	 OSFILE ENTRY							 *
;*									 *
;*	 on entry A determines action					 *
;*	 A=0	 save block of memory as a file				 *
;*	 A=1	 write catalogue info for existing file			 *
;*	 A=2	 write load address only for existing file		 *
;*	 A=3	 write execution address only for existing file		 *
;*	 A=4	 write attributes only for existing file		 *
;*	 A=5	 Read catalogue info, return file type in A		 *
;*	 A=6	 Delete named file					 *
;*	 A=&FF	 load the named file if lo byte of Exec address=0 use	 *
;*		 address in parameter block else files own load address	 *
;*	 X,Y	 point to parameter block				 *
;*	 bytes	 0,1 filename address, 2-5 load,6-9 exec,A-D length or	 *
;*		 start of data for save, 0E End address /attributes	 *
;*************************************************************************

;parameter block located by XY
;0/1	Address of Filename terminated by &0D
;2/4	Load Address of File
;6/9	Execution Address of File
;A/D	Start address of data for write operations or length of file
;	for read operations
;E/11	End address of Data; i.e. byte AFTER last byte to be written
;	or file attributes

;On Entry action is determined by value in A

;A=0	Save section of memory as named file, write catalogue information
;A=1	Write catalogue information for named file
;A=2	Write the LOAD	     address (only) for the named File
;A=3	Write the EXECUTION  address (only) for the named File
;A=4	Write the ATTRIBUTES for the named File
;A=5	Read the named files catalogue information Place file type in A
;A=6	Delete the named file
;A=&FF	Load the named file and read its catalogue information

_FILEV:			pha					; save A on stack
			stx	CRFS_OSFILE_PTR			; osfile block pointer lo
			sty	CRFS_OSFILE_PTR_HI		; osfile block pointer hi
			ldy	#$00				; Y=0
			lda	(CRFS_OSFILE_PTR),Y		; OSFILE parameter  block
			tax					; X=A
			iny					; Y=Y+1
			lda	(CRFS_OSFILE_PTR),Y		; OSFILE parameter  block
			tay					; Y=A
			jsr	_LF25A				; get filename from BUFFER
			ldy	#$02				; Y=2

__crfs_param_copy:	lda	(CRFS_OSFILE_PTR),Y		; copy parameters to Cassette block at 3BE/C5
			sta	CFS_LOAD_LO-2,Y			; from LOAD and EXEC address
			sta	CRFS_LOAD-2,Y			; make second copy at B0-B8
			iny					; Y=Y+1
			cpy	#$0a				; until Y=10
			bne	__crfs_param_copy		; 

			pla					; get back A
			beq	_BF2A7				; if A=0 F2A7
			cmp	#$ff				; else if A<>&FF
			bne	_BF254				; RETURN as cassette has no other options
			jmp	_LF1C4				; load file

;************** Save a file **********************************************

_BF2A7:			sta	CFS_BLK_NUM			; zero block number
			sta	CFS_BLK_NUM_HI			; zero block number hi

_BF2AD:			lda	(CRFS_OSFILE_PTR),Y		; OSFILE parameter  block
			sta	$00a6,Y				; store to Zero page copy (&B0 to &B7)
			iny					; data start and data end address
			cpy	#$12				; until Y=18
			bne	_BF2AD				; 
			txa					; A=X
			beq	_BF274				; if X=0 no filename found so B274 else BAD STRING error

			jsr	_CFS_CLAIM_SERIAL		; Set cassette option sinto (BB),set C7=6
								; claim serial system for cassette
			jsr	_LF934				; prompt to start recording

			lda	#$00				; A=0
			jsr	_LFBBD				; enable 2nd proc. if present and set up osfile block
			jsr	_LFBE2				; set up CFS for write operation
_BF2C8:			sec					; set carry flag
			ldx	#$fd				; X=&FD

_BF2CB:			lda	CRFS_EXEC + 65283,X		; set 03C8/A block length and block flag
			sbc	CRFS_LOAD + 65283,X		; to B4/6-B0/2 the number of pages (blocks) to be
								; saved
			sta	CFS_BLK_LEN - $fd,X		; 
			inx					; X=X+1
			bne	_BF2CB				; 

			tay					; Y=A
			bne	_BF2E8				; if last byte is non zero F2E8 else
			cpx	CFS_BLK_LEN			; compare X with block length
			lda	#$01				; A=1
			sbc	CFS_BLK_LEN_HI			; subtract block length hi
			bcc	_BF2E8				; if carry clear F2E8

			ldx	#$80				; X=&80
			bne	_BF2F0				; jump F2F0

_BF2E8:			lda	#$01				; A=1
			sta	CFS_BLK_LEN_HI			; block length hi
			stx	CFS_BLK_LEN			; block length
_BF2F0:			stx	CFS_BLK_FLAG			; block flag
			jsr	_LF7EC				; write block to Tape
			bmi	_BF341				; return if negative
			jsr	_INC_LOAD_ADDRESS		; increment current load address
			inc	CFS_BLK_NUM			; block number
			bne	_BF2C8				; if not 0 loop back again else
			inc	CFS_BLK_NUM_HI			; block number hi
			bne	_BF2C8				; and loop back again


;*************************************************************************
;*									 *
;*	 *RUN	 ENTRY							 *
;*									 *
;*************************************************************************

_FSCV_RUN:		jsr	_LF25A				; get filename from BUFFER
			ldx	#$ff				; X=&FF
			stx	CFS_EXEC_LO			; execution address
			jsr	_LF1C4				; load file
			bit	OSB_TUBE_FOUND			; &FF if tube present
			bpl	_BF31F				; so if not present F31F else
			lda	CFS_EXEC_VHI			; execution address extend
			and	CFS_EXEC_XHI			; execution address extend
			cmp	#$ff				; if they are NOT both &FF i.e.for base processor
			bne	_BF322				; F322 else
_BF31F:			jmp	(CFS_EXEC_LO)			; RUN file

_BF322:			ldx	#$c2				; point to execution address
			ldy	#$03				; (&03C2)
			lda	#$04				; Tube call 4
			jmp	_LFBC7				; and issue to Tube to run file


;*************************************************************************
;*									 *
;*	 *CAT	 ENTRY							 *
;*									 *
;*************************************************************************

				; CASSETTE OPTIONS in &E2

				; bit 0	 input file open
				; bit 1	 output file open
				; bit 2,4,5  not used
				; bit 3	 current CATalogue status
				; bit 6	 EOF reached
				; bit 7	 EOF warning given

_FSCV_CAT:		lda	#$08				; A=8
			jsr	_LF344				; set status bits from A
			jsr	_CFS_CLAIM_SERIAL		; Set cassette options into (BB),set C7=6
								; claim serial system for cassette
			lda	#$00				; A=0
			jsr	_LF348				; read data from CFS/RFS
			jsr	_LFAFC				; perform read
_LF33B:			lda	#$f7				; A=&F7
_LF33D:			and	CRFS_STATUS			; clear bit 3 of CFS status bit
_BF33F:			sta	CRFS_STATUS			; 
_BF341:			rts					; return

_LF342:			lda	#$40				; set bit 6 of E2 cassette options
_LF344:			ora	CRFS_STATUS			; 
			bne	_BF33F				; and Jump F33F

;********** search routine ***********************************************

_LF348:			pha					; save A on stack
			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_BF359				; if CFS F359 else
			jsr	_LEE13				; set current Filing System ROM/PHROM
			jsr	_LEE18				; get byte from data Romcheck type
			bcc	_BF359				; if carry clear F359 else
			clv					; clear overflow flag
			bvc	_BF39A				; JUMP F39A

;*********** cassette routine********************************************

_BF359:			jsr	_LF77B				; read block header
			lda	CFS_BLK_NUM			; block number
			sta	CRFS_EXEC			; current block no. lo
			lda	CFS_BLK_NUM_HI			; block number hi
			sta	CRFS_EXEC_HI			; current block no. hi
			ldx	#$ff				; X=&FF
			stx	CFS_LAST_FLAGS			; copy of last read block flag
			inx					; X=X+1
			stx	CRFS_BLOCK_FLAG			; current block flag
			beq	_BF376				; if  0 F376

_BF370:			jsr	_LFB69				; inc. current block no.
			jsr	_LF77B				; read block header
_BF376:			lda	OSB_CFSRFC_SW			; get filing system flag 0=CFS 2=RFS
			beq	_BF37D				; if CFS F37D
			bvc	_BF39A				; if V clear F39A
_BF37D:			pla					; get back A
			pha					; save A on stack
			beq	_BF3AE				; if A=0 F3AE
			jsr	_LFA72				; else check filename header block matches searched Fn
			bne	_BF39C				; if so F39C
			lda	#$30				; else A=30 to clear all but bits 4/5 of current OPTions

			and	CRFS_OPTS			; current OPTions
			beq	_BF39A				; if 0 F39A else

			lda	CFS_BLK_NUM			; block number
			cmp	CRFS_NEXT_BLK			; next block no. lo
			bne	_BF39C				; 
			lda	CFS_BLK_NUM_HI			; block number hi
			cmp	CRFS_NEXT_BLK_HI		; next block no. hi
			bne	_BF39C				; 
_BF39A:			pla					; get back A
			rts					; return
								;
_BF39C:			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_BF3AE				; if tape F3AE
_BF3A1:			jsr	_LEEAD				; else set ROM displacement address

_BF3A4:			lda	#$ff				; A=&FF
			sta	CFS_BLK_NUM			; block number
			sta	CFS_BLK_NUM_HI			; block number hi
			bne	_BF370				; jump F370

_BF3AE:			bvc	_BF3B5				; if carry clear F3B5
			lda	#$ff				; A=&FF
			jsr	_LF7D7				; set flags
_BF3B5:			ldx	#$00				; X=0
			jsr	_LF9D9				; report 'DATA?'
			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_BF3C3				; 
			bit	CRFS_OPTS			; current OPTions
			bvc	_BF3A1				; long messages not required if BIT 6 =0
_BF3C3:			bit	CFS_BLK_FLAG			; block flag
			bmi	_BF3A4				; if -ve F3A4
			bpl	_BF370				; else loop back and do it again

