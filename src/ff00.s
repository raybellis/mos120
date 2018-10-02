;********** EXTENDED VECTOR ENTRY POINTS**********************************
;vectors are pointed to &F000 +vector No. vectors may then be directed thru
;a three byte vector table whose XY address is given by osbyte A8, X=0, Y=&FF
;this is set up as lo-hi byte in ROM and ROM number

.org		$ff00

		jsr	$FF51		; XUSERV
		jsr	$FF51		; XBRKV
		jsr	$FF51		; XIRQ1V
		jsr	$FF51		; XIRQ2V
		jsr	$FF51		; XCLIV
		jsr	$FF51		; XBYTEV
		jsr	$FF51		; XWORDV
		jsr	$FF51		; XWRCHV
		jsr	$FF51		; XRDCHV
		jsr	$FF51		; XFILEV
		jsr	$FF51		; XARGSV
		jsr	$FF51		; XBGETV
		jsr	$FF51		; XBPUTV
		jsr	$FF51		; XGBPBV
		jsr	$FF51		; XFINDV
		jsr	$FF51		; XFSCV
		jsr	$FF51		; XEVENTV
		jsr	$FF51		; XUPTV
		jsr	$FF51		; XNETV
		jsr	$FF51		; XVDUV
		jsr	$FF51		; XKEYV
		jsr	$FF51		; XINSV
		jsr	$FF51		; XREMV
		jsr	$FF51		; XCNPV
		jsr	$FF51		; XIND1V
		jsr	$FF51		; XIND2V
		jsr	$FF51		; XIND3V

;at this point the stack will hold 4 bytes (at least)
;S 0,1 extended vector address
;S 2,3 address of calling routine
;A,X,Y,P will be as at entry

		pha			; save A on stack
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
		ldy	$010A,X		; this is VECTOR number*3+2!!
		lda	$0D9D,Y		; lo byte of action address
		sta	$0105,X		; store it on stack
		lda	$0D9E,Y		; get hi byte
		sta	$0106,X		; store it on stack
					; at this point stack has YXAP and action address
					; followed by return address and 5 more bytes
		lda	$F4		; 
		sta	$0109,X		; store original ROM number below this
		lda	$0D9F,Y		; get new ROM number
		sta	$F4		; store it as ram copy
		sta	$FE30		; and switch to that ROM
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
		sta	$FE30		; and set it
		pla			; get back A
		plp			; get back flags
		rts			; return and exit pulling original return address
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
		bcs	$FFD4		; carry always set, jump to BPUT


;*************************************************************************
;*                                                                       *
;*       OSBYTE &92      READ A BYTE FROM FRED                           *
;*                                                                       *
;*************************************************************************       ;

		ldy	$FC00,X		; read a byte from FRED area
		rts			; return


;*************************************************************************
;*                                                                       *
;*       OSBYTE &94      READ A BYTE FROM JIM                            *
;*                                                                       *
;*************************************************************************       ;
		; 
		ldy	$FD00,X		; read a byte from JIM area
		rts			; return


;*************************************************************************
;*                                                                       *
;*       OSBYTE &96      READ A BYTE FROM SHEILA                         *
;*                                                                       *
;*************************************************************************       ;
		; 
		ldy	$FE00,X		; read a byte from SHEILA memory mapped I/O area
		rts			; return


;*********** DEFAULT VECTOR TABLE ****************************************

		.byte	$36		; length of look up table in bytes
		.byte	$40		; low byte of address of this table
		.byte	$d9		; high byte of address of this table


;**************************************************************************
;**************************************************************************
;**                                                                      **
;**      OPERATING SYSTEM FUNCTION CALLS                                 **
;**                                                                      **
;**************************************************************************
;**************************************************************************

		jmp	$DC0B		; OSRDRM get a byte from sideways ROM
		jmp	$C4C0		; VDUCHR VDU character output
		jmp	$E494		; OSEVEN generate an EVENT
		jmp	$EA1E		; GSINIT initialise OS string
		jmp	$EA2F		; GSREAD read character from input stream
		jmp	$DEC5		; NVRDCH non vectored OSRDCH
		jmp	$E0A4		; NVWRCH non vectored OSWRCH
		jmp	($021C)		; OSFIND open or close a file
		jmp	($021A)		; OSGBPB transfer block to or from a file
		jmp	($0218)		; OSBPUT save a byte to file
		jmp	($0216)		; OSBGET get a byte from file
		jmp	($0214)		; OSARGS read or write file arguments
		jmp	($0212)		; OSFILE read or write a file
		jmp	($0210)		; OSRDCH get a byte from current input stream
		cmp	#$0D		; OSASCI output a byte to VDU stream expanding
		bne	$FFEE		; carriage returns (&0D) to LF/CR (&0A,&0D)
		lda	#$0A		; OSNEWL output a CR/LF to VDU stream
		jsr	OSWRCH		; Outputs A followed by CR to VDU stream
		lda	#$0D		; OSWRCR output a CR to VDU stream
		jmp	($020E)		; OSWRCH output a character to the VDU stream
		jmp	($020C)		; OSWORD perform operation using parameter table
		jmp	($020A)		; OSBYTE perform operation with single bytes
		jmp	($0208)		; OSCLI  pass string to command line interpreter


;*************************************************************************
;*                                                                       *
;*       6502 Vectors                                                    *
;*                                                                       *
;*************************************************************************

		.word	$0D00		; NMI   address
		.word	$D9CD		; RESET address
		.word	$DC1C		; IRQ   address

; ### That's it the end of the series and the end of Micronet.

; ### See you on the new system or in the paper mags.

; ### Geoff

