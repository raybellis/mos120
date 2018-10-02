;OS SERIES 9
;GEOFF COX
;*************************************************************************
;*                                                                       *
;*       OSBYTE 140  *TAPE                                               *
;*       selects TAPE filing system                                      *
;*                                                                       *
;*       OSBYTE 141  *ROM                                                *
;*       selects ROM filing system                                       *
;*                                                                       *
;*************************************************************************

.org		$f135

_LF135:		eor	#$8C		; if it's *TAPE A=0 *ROM A=1
_LF137:		asl			; double it
		sta	$0247		; store it in filing system flag store
		cpx	#$03		; if X>=3 C set X=3 Z set
		jmp	_LF14B		; 

;******** set cassette options *******************************************
		; called after BREAK etc
		; lower nybble sets sequential access
		; upper sets load and save options

		; 0000   Ignore errors,          no messages
		; 0001   Abort if error,         no messages
		; 0010   Retry after error,      no messages
		; 1000   Ignore error            short messages
		; 1001   Abort if error          short messages
		; 1010   Retry after error       short messages
		; 1100   Ignore error            long messages
		; 1101   Abort if error          long messages
		; 1110   Retry after error       long messages

_LF140:		php			; save flags
		lda	#$A1		; set sequential access abort if error, no messages
		sta	$E3		; set load/save retry if error, short messages
		lda	#$19		; set interblock gap
		sta	$03d1		; and store it
		plp			; get back flags

_LF14B:		php			; push flags
		lda	#$06		; get close files command to FSCV
		jsr	_LE031		; and gosub OSFSC
		ldx	#$06		; 
		plp			; get back flags
		beq	_BF157		; if Z set earlier
		dex			; do not decrement X
_BF157:		stx	$C6		; set current baud rate X=5 300 baud X=6 1200 baud

;********* reset FILEV,ARGSV,BGETV,BPUTV,GBPBV,FINDV,FSCV ******************
;**********   to F27D, F18E, F4C9, F529, FFA6, F3CA, F1B1 ******************

		ldx	#$0E		; RESET VECTORS FOR FILE RELATED OPERATIONS
_BF15B:		lda	_LD940 + $11,X		; 
		sta	$0211,X		; 
		dex			; 
		bne	_BF15B		; 

		stx	$C2		; &C2=0 PROGRESS FLAG
		ldx	#$0F		; set X to make Rom service call &F claim vectors!


;*************************************************************************
;*                                                                       *
;*       OSBYTE 143                                                      *
;*       Pass service commands to sideways ROMs                          *
;*                                                                       *
;*************************************************************************
		;  On entry X=service call number
		;           Y=any additional parameter
		;  On entry X=0 if claimed, or preserved if unclaimed
		;           Y=any returned parameter
		;           When called internally, EQ set if call claimed

_LF168:		lda	$F4		; Get current ROM number
		pha			; Save it
		txa			; Pass service call number to  A
		ldx	#$0F		; Start at ROM 15

		;  Issue service call loop
_BF16E:		inc	$02a1,X		; Read bit 7 on ROM type table (no ROM has type 254 &FE)
		dec	$02a1,X		; 
		bpl	_BF183		; If not set (+ve result), step to next ROM down
		stx	$F4		; Otherwise, select this ROM, &F4 RAM copy
		stx	$fe30		; Page in selected ROM
		jsr	$8003		; Call the ROM's service entry
					;  X and P do not need to be preserved by the ROM
		tax			; On exit pass A to X to chech if claimed
		beq	_BF186		; If 0, service call claimed, reselect ROM and exit
		ldx	$F4		; Otherwise, get current ROM back
_BF183:		dex			; Step to next ROM down
		bpl	_BF16E		; Loop until done ROM 0

_BF186:		pla			; Get back original ROM number
		sta	$F4		; Set ROM number RAM copy
		sta	$fe30		; Page in the original ROM
		txa			; Pass X back to A to set zero flag
		rts			; And return


;*************************************************************************
;*                                                                       *
;*       CFS OSARGS entry point                                          *
;*
;*************************************************************************

_LF18E:		ora	#$00		; is A=00
		bne	_BF1A2		; if not return
		cpy	#$00		; is Y=0
		bne	_BF1A2		; if not return
		lda	$C6		; else get current baud rate and zero bit 2
		and	#$FB		; C6=5 becomes 1, 6 becomes 2
		ora	$0247		; if cassette selected A=0 else A=2
		asl			; multiply by 2
		ora	$0247		; Or it again
		lsr			; divide by 2
_BF1A2:		rts			; return cassette =0

;*************************************************************************
;*                                                                       *
;*       FSC     VECTOR  TABLE                                           *
;*                                                                       *
;*************************************************************************

_LF1A3:		.byte	$4c,$f5		; *OPT            (F54C)
		.byte	$1d,$f6		; check EOF       (F61D)
		.byte	$04,$f3		; */              (F304)
		.byte	$0f,$e3		; unknown command (E30F)
		.byte	$04,$f3		; *RUN            (F304)
		.byte	$2a,$f3		; *CAT            (F32A)
		.byte	$74,$e2		; osbyte 77       (E274)


;*************************************************************************
;*       Filing System control entry     OSFSC                           *
;*       Entry via 021E FSCV                                             *
;*       A= index 0 to 7                                                 *
;*************************************************************************
		; on entry A is reason code
		; A=0    A *OPT command has been used X & Y are the 2 parameters
		; A=1    EOF is being checked, on entry  X=File handle
; ###     	                          on Exit X=FF = EOF exists else 00
		; A=2    A */ command has been used *RUN the file
		; A=3    An unrecognised OS command has ben used X,Y point at command
		; A=4    A *RUN command has been used X,Y point at filename
		; A=5    A *CAT cammand has been issued X,Y point to rest of command
		; A=6    New filing system about to take over, close SPOOL & EXEC files
		; A=7    Return in X and Y lowest and highest file handle used
		; A=8    OS about to process *command

_LF1B1:		cmp	#$07		; if A>6
		bcs	_BF1A2		; goto F1A2 (RTS)
		stx	$BC		; else save X
		asl			; A=A*2
		tax			; X=A to get offset
		lda	_LF1A3 + 1,X		; get hi byte of address
		pha			; push it
		lda	_LF1A3,X		; get lo byte of address
		pha			; push it
		ldx	$BC		; get back X
		rts			; this now jumps to the address got from the table +1
					; the next RTS takes us back to CLI


;*************************************************************************
;*                                                                       *
;*       LOAD FILE                                                       *
;*                                                                       *
;*************************************************************************

_LF1C4:		php			; save flags on stack
		pha			; save A on stack
		jsr	_LFB27		; Set cassette optionsinto (BB),set C7=6
					; claim serial system for cassette
		lda	$03c2		; execution address LO
		pha			; save A on stack
		jsr	_LF631		; search for file
		pla			; get back A
		beq	_BF1ED		; if A=0 F1ED
		ldx	#$03		; else X=3
		lda	#$FF		; A=&FF
_BF1D7:		pha			; save A on stack
		lda	$03be,X		; get load address
		sta	$B0,X		; store it as current load address
		pla			; get back A
		and	$B0,X		; 
		dex			; X=X-1
		bpl	_BF1D7		; until all 4 bytes copied

		cmp	#$FF		; if all bytes contain don't contain &FF
		bne	_BF1ED		; continue
		jsr	_LFAE8		; else sound bell, reset ACIA & motor off
		jmp	_BE267		; 'Bad Address' error

_BF1ED:		lda	$03ca		; block flag
		lsr			; set carry from bit 0
		pla			; get back A
		beq	_BF202		; if A=0 F202
		bcc	_BF209		; if carry clear F209

;*************** LOCKED FILE ROUTINE *************************************

_LF1F6:		jsr	_LFAF2		; enable second processor and reset serial system

		brk			; 
		.byte	$D5		; error number	;; was &E5
		.byte	"Locked"		; 
		brk			; 

_BF202:		bcc	_BF209		; if carry clear F209
		lda	#$03		; else A=3
		sta	$0258		; store to cause ESCAPE disable and memory
					; clear on break

_BF209:		lda	#$30		; 
		and	$BB		; current OPTions
		beq	_BF213		; if options and #&30 =0 ignore error condition is set
		lda	$C1		; else get checksum result
		bne	_BF21D		; and if not 0 F21D

_BF213:		tya			; A=Y
		pha			; save A on stack
		jsr	_LFBBB		; read from second processor if present
		pla			; get back A
		tay			; Y=A
		jsr	_LF7D5		; reset flags and check block length
_BF21D:		jsr	_LF9B4		; load file from tape
		bne	_BF255		; if not found return to search
		jsr	_LFB69		; increment current block number
		bit	$03ca		; block flag
		bmi	_BF232		; if bit 7=1 then this is last block so F232
		jsr	_LF96A		; else increment current load address
		jsr	_LF77B		; read block header
		bne	_BF209		; and goto F209

;******** store data in OSFILE parameter block ***************************

_BF232:		ldy	#$0A		; Y=&0A
		lda	$CC		; file length counter lo
		sta	($C8),Y		; OSFILE parameter  block
		iny			; Y=Y+1
		lda	$CD		; file length counter hi
		sta	($C8),Y		; OSFILE parameter  block
		lda	#$00		; A=0
		iny			; Y=Y+1
		sta	($C8),Y		; OSFILE parameter  block
		iny			; Y=Y+1
		sta	($C8),Y		; OSFILE parameter  block
		plp			; get back flags
_LF246:		jsr	_LFAE8		; bell, reset ACIA & motor
_LF249:		bit	$BA		; current block flag
		bmi	_BF254		; return
_LF24D:		php			; save flags on stack
		jsr	_LFA46		; print message following call (in this case NEWLINE!)
		.byte	$0D,$00		; message
		plp			; ; missing in original listing
_BF254:		rts			; return
					; 
;************RETRY AFTER A FAILURE ROUTINE *******************************

_BF255:		jsr	_LF637		; search for a specified block
		bne	_BF209		; goto F209

;*********** Read Filename using Command Line Interpreter ****************

;filename pointed to by X and Y

_LF25A:		stx	$F2		; OS filename/command line pointer lo
		sty	$F3		; OS filename/command line pointer
		ldy	#$00		; Y=0
		jsr	_LEA1D		; initialise string
		ldx	#$00		; X=0
_BF265:		jsr	_LEA2F		; GSREAD call
		bcs	_BF277		; if end of character string F277
		beq	_BF274		; if 0 found F274
		sta	$03d2,X		; else store character in CFS filename area
		inx			; X=X+1
		cpx	#$0B		; if X<>11
		bne	_BF265		; then read next
_BF274:		jmp	_BEA8F		; else Bad String error

;************* terminate Filename ****************************************

_BF277:		lda	#$00		; terminate filename with 0
		sta	$03d2,X		; 
		rts			; return


;*************************************************************************
;*                                                                       *
;*       OSFILE ENTRY                                                    *
;*                                                                       *
;*       on entry A determines action                                    *
;*       A=0     save block of memory as a file                          *
;*       A=1     write catalogue info for existing file                  *
;*       A=2     write load address only for existing file               *
;*       A=3     write execution address only for existing file          *
;*       A=4     write attributes only for existing file                 *
;*       A=5     Read catalogue info, return file type in A              *
;*       A=6     Delete named file                                       *
;*       A=&FF   load the named file if lo byte of Exec address=0 use    *
;*               address in parameter block else files own load address  *
;*       X,Y     point to parameter block                                *
;*       bytes   0,1 filename address, 2-5 load,6-9 exec,A-D length or   *
;*               start of data for save, 0E End address /attributes      *
;*************************************************************************

;parameter block located by XY
;0/1	Address of Filename terminated by &0D
;2/4	Load Address of File
;6/9	Execution Address of File
;A/D	Start address of data for write operations or length of file
;   	for read operations
;E/11   End address of Data; i.e. byte AFTER last byte to be written
;   	or file attributes
;
;On Entry action is determined by value in A
;
;A=0	Save section of memory as named file, write catalogue information
;A=1	Write catalogue information for named file
;A=2	Write the LOAD       address (only) for the named File
;A=3	Write the EXECUTION  address (only) for the named File
;A=4	Write the ATTRIBUTES for the named File
;A=5	Read the named files catalogue information Place file type in A
;A=6	Delete the named file
;A=&FF  Load the named file and read its catalogue information

_LF27D:		pha			; save A on stack
		stx	$C8		; osfile block pointer lo
		sty	$C9		; osfile block pointer hi
		ldy	#$00		; Y=0
		lda	($C8),Y		; OSFILE parameter  block
		tax			; X=A
		iny			; Y=Y+1
		lda	($C8),Y		; OSFILE parameter  block
		tay			; Y=A
		jsr	_LF25A		; get filename from BUFFER
		ldy	#$02		; Y=2

_BF290:		lda	($C8),Y		; copy parameters to Cassette block at 3BE/C5
		sta	$03bc,Y		; from LOAD and EXEC address
		sta	$00ae,Y		; make second copy at B0-B8
		iny			; Y=Y+1
		cpy	#$0A		; until Y=10
		bne	_BF290		; 

		pla			; get back A
		beq	_BF2A7		; if A=0 F2A7
		cmp	#$FF		; else if A<>&FF
		bne	_BF254		; RETURN as cassette has no other options
		jmp	_LF1C4		; load file

;************** Save a file **********************************************

_BF2A7:		sta	$03c6		; zero block number
		sta	$03c7		; zero block number hi

_BF2AD:		lda	($C8),Y		; OSFILE parameter  block
		sta	$00a6,Y		; store to Zero page copy (&B0 to &B7)
		iny			; data start and data end address
		cpy	#$12		; until Y=18
		bne	_BF2AD		; 
		txa			; A=X
		beq	_BF274		; if X=0 no filename found so B274 else BAD STRING error

		jsr	_LFB27		; Set cassette option sinto (BB),set C7=6
					; claim serial system for cassette
		jsr	_LF934		; prompt to start recording

		lda	#$00		; A=0
		jsr	_LFBBD		; enable 2nd proc. if present and set up osfile block
		jsr	_LFBE2		; set up CFS for write operation
_BF2C8:		sec			; set carry flag
		ldx	#$FD		; X=&FD

_BF2CB:		lda	_LFFB7,X		; set 03C8/A block length and block flag
		sbc	_LFFB2+1,X		; to B4/6-B0/2 the number of pages (blocks) to be
					; saved
		sta	$02cb,X		; 
		inx			; X=X+1
		bne	_BF2CB		; 

		tay			; Y=A
		bne	_BF2E8		; if last byte is non zero F2E8 else
		cpx	$03c8		; compare X with block length
		lda	#$01		; A=1
		sbc	$03c9		; subtract block length hi
		bcc	_BF2E8		; if carry clear F2E8

		ldx	#$80		; X=&80
		bne	_BF2F0		; jump F2F0

_BF2E8:		lda	#$01		; A=1
		sta	$03c9		; block length hi
		stx	$03c8		; block length
_BF2F0:		stx	$03ca		; block flag
		jsr	_LF7EC		; write block to Tape
		bmi	_BF341		; return if negative
		jsr	_LF96A		; increment current load address
		inc	$03c6		; block number
		bne	_BF2C8		; if not 0 loop back again else
		inc	$03c7		; block number hi
		bne	_BF2C8		; and loop back again


;*************************************************************************
;*                                                                       *
;*       *RUN    ENTRY                                                   *
;*                                                                       *
;*************************************************************************

		jsr	_LF25A		; get filename from BUFFER
		ldx	#$FF		; X=&FF
		stx	$03c2		; execution address
		jsr	_LF1C4		; load file
		bit	$027a		; &FF if tube present
		bpl	_BF31F		; so if not present F31F else
		lda	$03c4		; execution address extend
		and	$03c5		; execution address extend
		cmp	#$FF		; if they are NOT both &FF i.e.for base processor
		bne	_BF322		; F322 else
_BF31F:		jmp	($03c2)		; RUN file

_BF322:		ldx	#$C2		; point to execution address
		ldy	#$03		; (&03C2)
		lda	#$04		; Tube call 4
		jmp	_LFBC7		; and issue to Tube to run file


;*************************************************************************
;*                                                                       *
;*       *CAT    ENTRY                                                   *
;*                                                                       *
;*************************************************************************

		; CASSETTE OPTIONS in &E2

		; bit 0  input file open
		; bit 1  output file open
		; bit 2,4,5  not used
		; bit 3  current CATalogue status
		; bit 6  EOF reached
		; bit 7  EOF warning given

		lda	#$08		; A=8
		jsr	_LF344		; set status bits from A
		jsr	_LFB27		; Set cassette options into (BB),set C7=6
					; claim serial system for cassette
		lda	#$00		; A=0
		jsr	_LF348		; read data from CFS/RFS
		jsr	_LFAFC		; perform read
_LF33B:		lda	#$F7		; A=&F7
_LF33D:		and	$E2		; clear bit 3 of CFS status bit
_BF33F:		sta	$E2		; 
_BF341:		rts			; return

_LF342:		lda	#$40		; set bit 6 of E2 cassette options
_LF344:		ora	$E2		; 
		bne	_BF33F		; and Jump F33F

;********** search routine ***********************************************

_LF348:		pha			; save A on stack
		lda	$0247		; filing system flag 0=CFS 2=RFS
		beq	_BF359		; if CFS F359 else
		jsr	_LEE13		; set current Filing System ROM/PHROM
		jsr	_BEE18		; get byte from data Romcheck type
		bcc	_BF359		; if carry clear F359 else
		clv			; clear overflow flag
		bvc	_BF39A		; JUMP F39A

;*********** cassette routine********************************************

_BF359:		jsr	_LF77B		; read block header
		lda	$03c6		; block number
		sta	$B4		; current block no. lo
		lda	$03c7		; block number hi
		sta	$B5		; current block no. hi
		ldx	#$FF		; X=&FF
		stx	$03df		; copy of last read block flag
		inx			; X=X+1
		stx	$BA		; current block flag
		beq	_BF376		; if  0 F376

_BF370:		jsr	_LFB69		; inc. current block no.
		jsr	_LF77B		; read block header
_BF376:		lda	$0247		; get filing system flag 0=CFS 2=RFS
		beq	_BF37D		; if CFS F37D
		bvc	_BF39A		; if V clear F39A
_BF37D:		pla			; get back A
		pha			; save A on stack
		beq	_BF3AE		; if A=0 F3AE
		jsr	_LFA72		; else check filename header block matches searched Fn
		bne	_BF39C		; if so F39C
		lda	#$30		; else A=30 to clear all but bits 4/5 of current OPTions

		and	$BB		; current OPTions
		beq	_BF39A		; if 0 F39A else

		lda	$03c6		; block number
		cmp	$B6		; next block no. lo
		bne	_BF39C		; 
		lda	$03c7		; block number hi
		cmp	$B7		; next block no. hi
		bne	_BF39C		; 
_BF39A:		pla			; get back A
		rts			; return
					; 
_BF39C:		lda	$0247		; filing system flag 0=CFS 2=RFS
		beq	_BF3AE		; if tape F3AE
_BF3A1:		jsr	_LEEAD		; else set ROM displacement address

_BF3A4:		lda	#$FF		; A=&FF
		sta	$03c6		; block number
		sta	$03c7		; block number hi
		bne	_BF370		; jump F370

_BF3AE:		bvc	_BF3B5		; if carry clear F3B5
		lda	#$FF		; A=&FF
		jsr	_LF7D7		; set flags
_BF3B5:		ldx	#$00		; X=0
		jsr	_LF9D9		; report 'DATA?'
		lda	$0247		; filing system flag 0=CFS 2=RFS
		beq	_BF3C3		; 
		bit	$BB		; current OPTions
		bvc	_BF3A1		; long messages not required if BIT 6 =0
_BF3C3:		bit	$03ca		; block flag
		bmi	_BF3A4		; if -ve F3A4
		bpl	_BF370		; else loop back and do it again

