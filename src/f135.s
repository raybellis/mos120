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

		eor	#$8C		; if it's *TAPE A=0 *ROM A=1
		asl			; double it
		sta	$0247		; store it in filing system flag store
		cpx	#$03		; if X>=3 C set X=3 Z set
		jmp	$F14B		; 

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

		php			; save flags
		lda	#$A1		; set sequential access abort if error, no messages
		sta	$E3		; set load/save retry if error, short messages
		lda	#$19		; set interblock gap
		sta	$03D1		; and store it
		plp			; get back flags

		php			; push flags
		lda	#$06		; get close files command to FSCV
		jsr	$E031		; and gosub OSFSC
		ldx	#$06		; 
		plp			; get back flags
		beq	$F157		; if Z set earlier
		dex			; do not decrement X
		stx	$C6		; set current baud rate X=5 300 baud X=6 1200 baud

;********* reset FILEV,ARGSV,BGETV,BPUTV,GBPBV,FINDV,FSCV ******************
;**********   to F27D, F18E, F4C9, F529, FFA6, F3CA, F1B1 ******************

		ldx	#$0E		; RESET VECTORS FOR FILE RELATED OPERATIONS
		lda	$D951,X		; 
		sta	$0211,X		; 
		dex			; 
		bne	$F15B		; 

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

		lda	$F4		; Get current ROM number
		pha			; Save it
		txa			; Pass service call number to  A
		ldx	#$0F		; Start at ROM 15

		;  Issue service call loop
		inc	$02A1,X		; Read bit 7 on ROM type table (no ROM has type 254 &FE)
		dec	$02A1,X		; 
		bpl	$F183		; If not set (+ve result), step to next ROM down
		stx	$F4		; Otherwise, select this ROM, &F4 RAM copy
		stx	$FE30		; Page in selected ROM
		jsr	$8003		; Call the ROM's service entry
					;  X and P do not need to be preserved by the ROM
		tax			; On exit pass A to X to chech if claimed
		beq	$F186		; If 0, service call claimed, reselect ROM and exit
		ldx	$F4		; Otherwise, get current ROM back
		dex			; Step to next ROM down
		bpl	$F16E		; Loop until done ROM 0

		pla			; Get back original ROM number
		sta	$F4		; Set ROM number RAM copy
		sta	$FE30		; Page in the original ROM
		txa			; Pass X back to A to set zero flag
		rts			; And return


;*************************************************************************
;*                                                                       *
;*       CFS OSARGS entry point                                          *
;*
;*************************************************************************

		ora	#$00		; is A=00
		bne	$F1A2		; if not return
		cpy	#$00		; is Y=0
		bne	$F1A2		; if not return
		lda	$C6		; else get current baud rate and zero bit 2
		and	#$FB		; C6=5 becomes 1, 6 becomes 2
		ora	$0247		; if cassette selected A=0 else A=2
		asl			; multiply by 2
		ora	$0247		; Or it again
		lsr			; divide by 2
		rts			; return cassette =0

;*************************************************************************
;*                                                                       *
;*       FSC     VECTOR  TABLE                                           *
;*                                                                       *
;*************************************************************************

		.byte	$4c,$f5		; *OPT            (F54C)
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

		cmp	#$07		; if A>6
		bcs	$F1A2		; goto F1A2 (RTS)
		stx	$BC		; else save X
		asl			; A=A*2
		tax			; X=A to get offset
		lda	$F1A4,X		; get hi byte of address
		pha			; push it
		lda	$F1A3,X		; get lo byte of address
		pha			; push it
		ldx	$BC		; get back X
		rts			; this now jumps to the address got from the table +1
					; the next RTS takes us back to CLI


;*************************************************************************
;*                                                                       *
;*       LOAD FILE                                                       *
;*                                                                       *
;*************************************************************************

		php			; save flags on stack
		pha			; save A on stack
		jsr	$FB27		; Set cassette optionsinto (BB),set C7=6
					; claim serial system for cassette
		lda	$03C2		; execution address LO
		pha			; save A on stack
		jsr	$F631		; search for file
		pla			; get back A
		beq	$F1ED		; if A=0 F1ED
		ldx	#$03		; else X=3
		lda	#$FF		; A=&FF
		pha			; save A on stack
		lda	$03BE,X		; get load address
		sta	$B0,X		; store it as current load address
		pla			; get back A
		and	$B0,X		; 
		dex			; X=X-1
		bpl	$F1D7		; until all 4 bytes copied

		cmp	#$FF		; if all bytes contain don't contain &FF
		bne	$F1ED		; continue
		jsr	$FAE8		; else sound bell, reset ACIA & motor off
		jmp	$E267		; 'Bad Address' error

		lda	$03CA		; block flag
		lsr			; set carry from bit 0
		pla			; get back A
		beq	$F202		; if A=0 F202
		bcc	$F209		; if carry clear F209

;*************** LOCKED FILE ROUTINE *************************************

		jsr	$FAF2		; enable second processor and reset serial system

		brk			; 
		.byte	$D5		; error number	;; was &E5
		.byte	"Locked"		; 
		brk			; 

		bcc	$F209		; if carry clear F209
		lda	#$03		; else A=3
		sta	$0258		; store to cause ESCAPE disable and memory
					; clear on break

		lda	#$30		; 
		and	$BB		; current OPTions
		beq	$F213		; if options and #&30 =0 ignore error condition is set
		lda	$C1		; else get checksum result
		bne	$F21D		; and if not 0 F21D

		tya			; A=Y
		pha			; save A on stack
		jsr	$FBBB		; read from second processor if present
		pla			; get back A
		tay			; Y=A
		jsr	$F7D5		; reset flags and check block length
		jsr	$F9B4		; load file from tape
		bne	$F255		; if not found return to search
		jsr	$FB69		; increment current block number
		bit	$03CA		; block flag
		bmi	$F232		; if bit 7=1 then this is last block so F232
		jsr	$F96A		; else increment current load address
		jsr	$F77B		; read block header
		bne	$F209		; and goto F209

;******** store data in OSFILE parameter block ***************************

		ldy	#$0A		; Y=&0A
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
		jsr	$FAE8		; bell, reset ACIA & motor
		bit	$BA		; current block flag
		bmi	$F254		; return
		php			; save flags on stack
		jsr	$FA46		; print message following call (in this case NEWLINE!)
		.byte	$0D,$00		; message
		plp			; ; missing in original listing
		rts			; return
					; 
;************RETRY AFTER A FAILURE ROUTINE *******************************

		jsr	$F637		; search for a specified block
		bne	$F209		; goto F209

;*********** Read Filename using Command Line Interpreter ****************

;filename pointed to by X and Y

		stx	$F2		; OS filename/command line pointer lo
		sty	$F3		; OS filename/command line pointer
		ldy	#$00		; Y=0
		jsr	$EA1D		; initialise string
		ldx	#$00		; X=0
		jsr	$EA2F		; GSREAD call
		bcs	$F277		; if end of character string F277
		beq	$F274		; if 0 found F274
		sta	$03D2,X		; else store character in CFS filename area
		inx			; X=X+1
		cpx	#$0B		; if X<>11
		bne	$F265		; then read next
		jmp	$EA8F		; else Bad String error

;************* terminate Filename ****************************************

		lda	#$00		; terminate filename with 0
		sta	$03D2,X		; 
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

		pha			; save A on stack
		stx	$C8		; osfile block pointer lo
		sty	$C9		; osfile block pointer hi
		ldy	#$00		; Y=0
		lda	($C8),Y		; OSFILE parameter  block
		tax			; X=A
		iny			; Y=Y+1
		lda	($C8),Y		; OSFILE parameter  block
		tay			; Y=A
		jsr	$F25A		; get filename from BUFFER
		ldy	#$02		; Y=2

		lda	($C8),Y		; copy parameters to Cassette block at 3BE/C5
		sta	$03BC,Y		; from LOAD and EXEC address
		sta	$00AE,Y		; make second copy at B0-B8
		iny			; Y=Y+1
		cpy	#$0A		; until Y=10
		bne	$F290		; 

		pla			; get back A
		beq	$F2A7		; if A=0 F2A7
		cmp	#$FF		; else if A<>&FF
		bne	$F254		; RETURN as cassette has no other options
		jmp	$F1C4		; load file

;************** Save a file **********************************************

		sta	$03C6		; zero block number
		sta	$03C7		; zero block number hi

		lda	($C8),Y		; OSFILE parameter  block
		sta	$00A6,Y		; store to Zero page copy (&B0 to &B7)
		iny			; data start and data end address
		cpy	#$12		; until Y=18
		bne	$F2AD		; 
		txa			; A=X
		beq	$F274		; if X=0 no filename found so B274 else BAD STRING error

		jsr	$FB27		; Set cassette option sinto (BB),set C7=6
					; claim serial system for cassette
		jsr	$F934		; prompt to start recording

		lda	#$00		; A=0
		jsr	$FBBD		; enable 2nd proc. if present and set up osfile block
		jsr	$FBE2		; set up CFS for write operation
		sec			; set carry flag
		ldx	#$FD		; X=&FD

		lda	$FFB7,X		; set 03C8/A block length and block flag
		sbc	$FFB3,X		; to B4/6-B0/2 the number of pages (blocks) to be
					; saved
		sta	$02CB,X		; 
		inx			; X=X+1
		bne	$F2CB		; 

		tay			; Y=A
		bne	$F2E8		; if last byte is non zero F2E8 else
		cpx	$03C8		; compare X with block length
		lda	#$01		; A=1
		sbc	$03C9		; subtract block length hi
		bcc	$F2E8		; if carry clear F2E8

		ldx	#$80		; X=&80
		bne	$F2F0		; jump F2F0

		lda	#$01		; A=1
		sta	$03C9		; block length hi
		stx	$03C8		; block length
		stx	$03CA		; block flag
		jsr	$F7EC		; write block to Tape
		bmi	$F341		; return if negative
		jsr	$F96A		; increment current load address
		inc	$03C6		; block number
		bne	$F2C8		; if not 0 loop back again else
		inc	$03C7		; block number hi
		bne	$F2C8		; and loop back again


;*************************************************************************
;*                                                                       *
;*       *RUN    ENTRY                                                   *
;*                                                                       *
;*************************************************************************

		jsr	$F25A		; get filename from BUFFER
		ldx	#$FF		; X=&FF
		stx	$03C2		; execution address
		jsr	$F1C4		; load file
		bit	$027A		; &FF if tube present
		bpl	$F31F		; so if not present F31F else
		lda	$03C4		; execution address extend
		and	$03C5		; execution address extend
		cmp	#$FF		; if they are NOT both &FF i.e.for base processor
		bne	$F322		; F322 else
		jmp	($03C2)		; RUN file

		ldx	#$C2		; point to execution address
		ldy	#$03		; (&03C2)
		lda	#$04		; Tube call 4
		jmp	$FBC7		; and issue to Tube to run file


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
		jsr	$F344		; set status bits from A
		jsr	$FB27		; Set cassette options into (BB),set C7=6
					; claim serial system for cassette
		lda	#$00		; A=0
		jsr	$F348		; read data from CFS/RFS
		jsr	$FAFC		; perform read
		lda	#$F7		; A=&F7
		and	$E2		; clear bit 3 of CFS status bit
		sta	$E2		; 
		rts			; return

		lda	#$40		; set bit 6 of E2 cassette options
		ora	$E2		; 
		bne	$F33F		; and Jump F33F

;********** search routine ***********************************************

		pha			; save A on stack
		lda	$0247		; filing system flag 0=CFS 2=RFS
		beq	$F359		; if CFS F359 else
		jsr	$EE13		; set current Filing System ROM/PHROM
		jsr	$EE18		; get byte from data Romcheck type
		bcc	$F359		; if carry clear F359 else
		clv			; clear overflow flag
		bvc	$F39A		; JUMP F39A

;*********** cassette routine********************************************

		jsr	$F77B		; read block header
		lda	$03C6		; block number
		sta	$B4		; current block no. lo
		lda	$03C7		; block number hi
		sta	$B5		; current block no. hi
		ldx	#$FF		; X=&FF
		stx	$03DF		; copy of last read block flag
		inx			; X=X+1
		stx	$BA		; current block flag
		beq	$F376		; if  0 F376

		jsr	$FB69		; inc. current block no.
		jsr	$F77B		; read block header
		lda	$0247		; get filing system flag 0=CFS 2=RFS
		beq	$F37D		; if CFS F37D
		bvc	$F39A		; if V clear F39A
		pla			; get back A
		pha			; save A on stack
		beq	$F3AE		; if A=0 F3AE
		jsr	$FA72		; else check filename header block matches searched Fn
		bne	$F39C		; if so F39C
		lda	#$30		; else A=30 to clear all but bits 4/5 of current OPTions

		and	$BB		; current OPTions
		beq	$F39A		; if 0 F39A else

		lda	$03C6		; block number
		cmp	$B6		; next block no. lo
		bne	$F39C		; 
		lda	$03C7		; block number hi
		cmp	$B7		; next block no. hi
		bne	$F39C		; 
		pla			; get back A
		rts			; return
					; 
		lda	$0247		; filing system flag 0=CFS 2=RFS
		beq	$F3AE		; if tape F3AE
		jsr	$EEAD		; else set ROM displacement address

		lda	#$FF		; A=&FF
		sta	$03C6		; block number
		sta	$03C7		; block number hi
		bne	$F370		; jump F370

		bvc	$F3B5		; if carry clear F3B5
		lda	#$FF		; A=&FF
		jsr	$F7D7		; set flags
		ldx	#$00		; X=0
		jsr	$F9D9		; report 'DATA?'
		lda	$0247		; filing system flag 0=CFS 2=RFS
		beq	$F3C3		; 
		bit	$BB		; current OPTions
		bvc	$F3A1		; long messages not required if BIT 6 =0
		bit	$03CA		; block flag
		bmi	$F3A4		; if -ve F3A4
		bpl	$F370		; else loop back and do it again

