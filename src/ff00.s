;********** EXTENDED VECTOR ENTRY POINTS**********************************
;vectors are pointed to &F000 +vector No. vectors may then be directed thru
;a three byte vector table whose XY address is given by osbyte A8, X=0, Y=&FF
;this is set up as lo-hi byte in ROM and ROM number

			.org	$ff00

			jsr	_EXTENDED			; XUSERV
			jsr	_EXTENDED			; XBRKV
			jsr	_EXTENDED			; XIRQ1V
			jsr	_EXTENDED			; XIRQ2V
			jsr	_EXTENDED			; XCLIV
			jsr	_EXTENDED			; XBYTEV
			jsr	_EXTENDED			; XWORDV
			jsr	_EXTENDED			; XWRCHV
			jsr	_EXTENDED			; XRDCHV
			jsr	_EXTENDED			; XFILEV
			jsr	_EXTENDED			; XARGSV
			jsr	_EXTENDED			; XBGETV
			jsr	_EXTENDED			; XBPUTV
			jsr	_EXTENDED			; XGBPBV
			jsr	_EXTENDED			; XFINDV
			jsr	_EXTENDED			; XFSCV
			jsr	_EXTENDED			; XEVENTV
			jsr	_EXTENDED			; XUPTV
			jsr	_EXTENDED			; XNETV
			jsr	_EXTENDED			; XVDUV
			jsr	_EXTENDED			; XKEYV
			jsr	_EXTENDED			; XINSV
			jsr	_EXTENDED			; XREMV
			jsr	_EXTENDED			; XCNPV
			jsr	_EXTENDED			; XIND1V
			jsr	_EXTENDED			; XIND2V
			jsr	_EXTENDED			; XIND3V

;at this point the stack will hold 4 bytes (at least)
;S 0,1 extended vector address
;S 2,3 address of calling routine
;A,X,Y,P will be as at entry

_EXTENDED:		pha					; save A on stack
			pha					; save A on stack
			pha					; save A on stack
			pha					; save A on stack
			pha					; save A on stack
			php					; save flags on stack
			pha					; save A on stack
			txa					; A=X
			pha					; save X on stack
			tya					; A=Y
			pha					; save Y on stack
			tsx					; get stack pointer into X (&F2 or less)
			lda	#$ff				; A=&FF
			sta	STACK+8,X			; A
			lda	#$88				; 
			sta	STACK+7,X			; 
			ldy	STACK+$A,X			; this is VECTOR number*3+2!!
			lda	$0d9d,Y				; lo byte of action address
			sta	STACK+5,X			; store it on stack
			lda	$0d9e,Y				; get hi byte
			sta	STACK+6,X			; store it on stack
								; at this point stack has YXAP and action address
								; followed by return address and 5 more bytes
			lda	ROM_SELECT			; 
			sta	STACK+9,X			; store original ROM number below this
			lda	$0d9f,Y				; get new ROM number
			sta	ROM_SELECT			; store it as ram copy
			sta	ROM_LATCH			; and switch to that ROM
			pla					; get back A
			tay					; Y=A
			pla					; get back A
			tax					; X=A
			pla					; get back A
			rti					; get back flags and jump to ROM vectored entry
								; leaving return address and 5 more bytes on stack

;************ return address from ROM indirection ************************

;at this point stack comprises original ROM number,return from JSR &FF51,
;return from original call the return from FF51 is garbage so;

			php					; save flags on stack
			pha					; save A on stack
			txa					; A=X
			pha					; save X on stack
			tsx					; (&F7 or less)
			lda	STACK+2,X			; STORE A AND P OVER
			sta	STACK+5,X			; return address from (JSR &FF51)
			lda	STACK+3,X			; hiding garbage by duplicating A and X just saved
			sta	STACK+6,X			; 
								; now we have
								; flags,
								; A,
								; X,
								; ROM number,
								; A,
								; flags,
								; and original return address on stack
								; so
			pla					; get back X
			tax					; X=A
			pla					; get back A lose next two bytes
			pla					; get back A lose
			pla					; get back A ROM number
			sta	ROM_SELECT			; store it
			sta	ROM_LATCH			; and set it
			pla					; get back A
			plp					; get back flags
_NOTIMPV:		rts					; return and exit pulling original return address
								; from stack
;FFA6 is also default input for CFS OSBPGB, VDUV, IND1V,IND2V,IND3V
;as these functions are not implemented by the OS but may be used
;by software or other filing systems or ROMs


;*************************************************************************
;*									 *
;*	 OSBYTE &9D    FAST BPUT					 *
;*									 *
;*************************************************************************
_OSBYTE_157:		txa					; A=X
			bcs	OSBPUT				; carry always set, jump to BPUT


;*************************************************************************
;*									 *
;*	 OSBYTE &92	 READ A BYTE FROM FRED				 *
;*									 *
;*************************************************************************	 ;

_OSBYTE_146:		ldy	FRED,X				; read a byte from FRED area
			rts					; return


;*************************************************************************
;*									 *
;*	 OSBYTE &94	 READ A BYTE FROM JIM				 *
;*									 *
;*************************************************************************	 ;
				;
_OSBYTE_148:		ldy	JIM,X				; read a byte from JIM area
			rts					; return


;*************************************************************************
;*									 *
;*	 OSBYTE &96	 READ A BYTE FROM SHEILA			 *
;*									 *
;*************************************************************************	 ;
				;
_OSBYTE_150:		ldy	CRTC_ADDRESS,X			; read a byte from SHEILA memory mapped I/O area
			rts					; return


;*********** DEFAULT VECTOR TABLE ****************************************

			.byte	$36				; length of look up table in bytes
			.word	_VECTOR_TABLE			; address of this table


;**************************************************************************
;**************************************************************************
;**									 **
;**	 OPERATING SYSTEM FUNCTION CALLS				 **
;**									 **
;**************************************************************************
;**************************************************************************

OSRDRM:			jmp	_OSRDRM				; OSRDRM get a byte from sideways ROM
VDUCHR:			jmp	_VDUCHR				; VDUCHR VDU character output
OSEVEN:			jmp	_OSEVEN				; OSEVEN generate an EVENT
GSINIT:			jmp	_GSINIT				; GSINIT initialise OS string
GSREAD:			jmp	_GSREAD				; GSREAD read character from input stream
NVRDCH:			jmp	_NVRDCH				; NVRDCH non vectored OSRDCH
NVWRCH:			jmp	_NVWRCH				; NVWRCH non vectored OSWRCH
OSFIND:			jmp	(VEC_OSFIND)			; OSFIND open or close a file
			jmp	(VEC_OSGBPB)			; OSGBPB transfer block to or from a file
OSBPUT:			jmp	(VEC_OSBPUT)			; OSBPUT save a byte to file
OSBGET:			jmp	(VEC_OSBGET)			; OSBGET get a byte from file
OSARGS:			jmp	(VEC_OSARGS)			; OSARGS read or write file arguments
OSFILE:			jmp	(VEC_OSFILE)			; OSFILE read or write a file
OSRDCH:			jmp	(VEC_OSRDCH)			; OSRDCH get a byte from current input stream
OSASCI:			cmp	#$0d				; OSASCI output a byte to VDU stream expanding
			bne	OSWRCH				; carriage returns (&0D) to LF/CR (&0A,&0D)
OSNEWL:			lda	#$0a				; OSNEWL output a CR/LF to VDU stream
			jsr	OSWRCH				; Outputs A followed by CR to VDU stream
			lda	#$0d				; OSWRCR output a CR to VDU stream
OSWRCH:			jmp	(VEC_OSWRCH)			; OSWRCH output a character to the VDU stream
OSWORD:			jmp	(VEC_OSWORD)			; OSWORD perform operation using parameter table
OSBYTE:			jmp	(VEC_OSBYTE)			; OSBYTE perform operation with single bytes
OSCLI:			jmp	(VEC_OSCLI)			; OSCLI	 pass string to command line interpreter


;*************************************************************************
;*									 *
;*	 6502 Vectors							 *
;*									 *
;*************************************************************************

			.word	NMI_HANDLER			; NMI	address
			.word	_RESET_HANDLER			; RESET address
			.word	_IRQ_HANDLER			; IRQ	address

; That's it the end of the series and the end of Micronet.

; See you on the new system or in the paper mags.

; Geoff

