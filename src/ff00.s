;********** EXTENDED VECTOR ENTRY POINTS**********************************
;vectors are pointed to &F000 +vector No. vectors may then be directed thru
;a three byte vector table whose XY address is given by osbyte A8, X=0, Y=&FF
;this is set up as lo-hi byte in ROM and ROM number

.org		$ff00

		jsr	_LFF51		; XUSERV
		jsr	_LFF51		; XBRKV
		jsr	_LFF51		; XIRQ1V
		jsr	_LFF51		; XIRQ2V
		jsr	_LFF51		; XCLIV
		jsr	_LFF51		; XBYTEV
		jsr	_LFF51		; XWORDV
		jsr	_LFF51		; XWRCHV
		jsr	_LFF51		; XRDCHV
		jsr	_LFF51		; XFILEV
		jsr	_LFF51		; XARGSV
		jsr	_LFF51		; XBGETV
		jsr	_LFF51		; XBPUTV
		jsr	_LFF51		; XGBPBV
		jsr	_LFF51		; XFINDV
		jsr	_LFF51		; XFSCV
		jsr	_LFF51		; XEVENTV
		jsr	_LFF51		; XUPTV
		jsr	_LFF51		; XNETV
		jsr	_LFF51		; XVDUV
		jsr	_LFF51		; XKEYV
		jsr	_LFF51		; XINSV
		jsr	_LFF51		; XREMV
		jsr	_LFF51		; XCNPV
		jsr	_LFF51		; XIND1V
		jsr	_LFF51		; XIND2V
		jsr	_LFF51		; XIND3V

;at this point the stack will hold 4 bytes (at least)
;S 0,1 extended vector address
;S 2,3 address of calling routine
;A,X,Y,P will be as at entry

_LFF51:		pha			; save A on stack
		pha			; save A on stack
		pha			; save A on stack
		pha			; save A on stack
		pha			; save A on stack
		php			; save flags on stack
		pha			; save A on stack
		txa			; A=X
		pha			; save X on stack
		tya			; A=Y
		pha			; save Y on stack
		tsx			; get stack pointer into X (&F2 or less)
		lda	#$FF		; A=&FF
		sta	$0108,X		; A
		lda	#$88		; 
		sta	$0107,X		; 
		ldy	$010a,X		; this is VECTOR number*3+2!!
		lda	$0d9d,Y		; lo byte of action address
		sta	$0105,X		; store it on stack
		lda	$0d9e,Y		; get hi byte
		sta	$0106,X		; store it on stack
					; at this point stack has YXAP and action address
					; followed by return address and 5 more bytes
		lda	$F4		; 
		sta	$0109,X		; store original ROM number below this
		lda	$0d9f,Y		; get new ROM number
		sta	$F4		; store it as ram copy
		sta	$fe30		; and switch to that ROM
		pla			; get back A
		tay			; Y=A
		pla			; get back A
		tax			; X=A
		pla			; get back A
		rti			; get back flags and jump to ROM vectored entry
					; leaving return address and 5 more bytes on stack

;************ return address from ROM indirection ************************

;at this point stack comprises original ROM number,return from JSR &FF51,
;return from original call the return from FF51 is garbage so;

		php			; save flags on stack
		pha			; save A on stack
		txa			; A=X
		pha			; save X on stack
		tsx			; (&F7 or less)
		lda	$0102,X		; STORE A AND P OVER
		sta	$0105,X		; return address from (JSR &FF51)
		lda	$0103,X		; hiding garbage by duplicating A and X just saved
		sta	$0106,X		; 
					; now we have
					; flags,
					; A,
					; X,
					; ROM number,
					; A,
					; flags,
					; and original return address on stack
					; so
		pla			; get back X
		tax			; X=A
		pla			; get back A lose next two bytes
		pla			; get back A lose
		pla			; get back A ROM number
		sta	$F4		; store it
		sta	$fe30		; and set it
		pla			; get back A
		plp			; get back flags
_LFFA6:		rts			; return and exit pulling original return address
					; from stack
;FFA6 is also default input for CFS OSBPGB, VDUV, IND1V,IND2V,IND3V
;as these functions are not implemented by the OS but may be used
;by software or other filing systems or ROMs


;*************************************************************************
;*                                                                       *
;*       OSBYTE &9D    FAST BPUT                                         *
;*                                                                       *
;*************************************************************************
		txa			; A=X
		bcs	_LFFD4		; carry always set, jump to BPUT


;*************************************************************************
;*                                                                       *
;*       OSBYTE &92      READ A BYTE FROM FRED                           *
;*                                                                       *
;*************************************************************************       ;

		ldy	$fc00,X		; read a byte from FRED area
		rts			; return


;*************************************************************************
;*                                                                       *
;*       OSBYTE &94      READ A BYTE FROM JIM                            *
;*                                                                       *
;*************************************************************************       ;
		; 
		ldy	$fd00,X		; read a byte from JIM area
		rts			; return


;*************************************************************************
;*                                                                       *
;*       OSBYTE &96      READ A BYTE FROM SHEILA                         *
;*                                                                       *
;*************************************************************************       ;
		; 
_LFFB2:		ldy	$fe00,X		; read a byte from SHEILA memory mapped I/O area
		rts			; return


;*********** DEFAULT VECTOR TABLE ****************************************

		.byte	$36		; length of look up table in bytes
_LFFB7:		.byte	$40		; low byte of address of this table
		.byte	$d9		; high byte of address of this table


;**************************************************************************
;**************************************************************************
;**                                                                      **
;**      OPERATING SYSTEM FUNCTION CALLS                                 **
;**                                                                      **
;**************************************************************************
;**************************************************************************

		jmp	_LDC0B		; OSRDRM get a byte from sideways ROM
		jmp	_LC4C0		; VDUCHR VDU character output
		jmp	_LE494		; OSEVEN generate an EVENT
		jmp	_LEA1E		; GSINIT initialise OS string
		jmp	_LEA2F		; GSREAD read character from input stream
		jmp	_LDEC5		; NVRDCH non vectored OSRDCH
		jmp	_LE0A4		; NVWRCH non vectored OSWRCH
		jmp	($021c)		; OSFIND open or close a file
		jmp	($021a)		; OSGBPB transfer block to or from a file
_LFFD4:		jmp	($0218)		; OSBPUT save a byte to file
		jmp	($0216)		; OSBGET get a byte from file
		jmp	($0214)		; OSARGS read or write file arguments
		jmp	($0212)		; OSFILE read or write a file
		jmp	($0210)		; OSRDCH get a byte from current input stream
		cmp	#$0D		; OSASCI output a byte to VDU stream expanding
		bne	_BFFEE		; carriage returns (&0D) to LF/CR (&0A,&0D)
		lda	#$0A		; OSNEWL output a CR/LF to VDU stream
		jsr	OSWRCH		; Outputs A followed by CR to VDU stream
		lda	#$0D		; OSWRCR output a CR to VDU stream
_BFFEE:		jmp	($020e)		; OSWRCH output a character to the VDU stream
		jmp	($020c)		; OSWORD perform operation using parameter table
		jmp	($020a)		; OSBYTE perform operation with single bytes
		jmp	($0208)		; OSCLI  pass string to command line interpreter


;*************************************************************************
;*                                                                       *
;*       6502 Vectors                                                    *
;*                                                                       *
;*************************************************************************

		.word	$0d00		; NMI   address
		.word	_RESET		; RESET address
		.word	_IRQ		; IRQ   address

; ### That's it the end of the series and the end of Micronet.

; ### See you on the new system or in the paper mags.

; ### Geoff

