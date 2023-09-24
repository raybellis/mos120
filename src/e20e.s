; OS SERIES VI
; GEOFF COX

;*************************************************************************
;*									 *
;*	 *SAVE/*LOAD SETUP						 *
;*									 *
;*************************************************************************

;**************: clear osfile control block workspace ********************

			.org	$e20e

_CLEAR_OSFILE_CB:	pha					; push A
			lda	#$00				; A=0
			sta	OSFILE_CB,X			; clear osfile control block workspace
			sta	OSFILE_CB_1,X			; 
			sta	OSFILE_CB_2,X			; 
			sta	OSFILE_CB_3,X			; 
			pla					; get back A
			rts					; and exit

;*********** shift through osfile control block **************************

_LE21F:			sty	MOS_WS				; &E6=Y
			rol					; A=A*2
			rol					; *4
			rol					; *8
			rol					; *16
			ldy	#$04				; Y=4
_BE227:			rol					; A=A*32
			rol	OSFILE_CB,X			; shift bit 7 of A into shift register
			rol	OSFILE_CB_1,X			; and
			rol	OSFILE_CB_2,X			; shift
			rol	OSFILE_CB_3,X			; along
			bcs	_LE267				; if carry set on exit then register has overflowed
								; so bad address error
			dey					; decrement Y
			bne	_BE227				; and if Y>0 then do another shift
			ldy	MOS_WS				; get back original Y
			rts					; and exit


;*************************************************************************
;*									 *
;*	 *LOAD ENTRY							 *
;*									 *
;*************************************************************************

_OSCLI_LOAD:		lda	#$ff				; signal that load is being performed


;*************************************************************************
;*									 *
;*	 *SAVE ENTRY							 *
;*									 *
;*************************************************************************
;on entry A=0 for save &ff for load

_OSCLI_SAVE:		stx	TEXT_PTR			; store address of rest of command line
			sty	TEXT_PTR_HI			; 
			stx	OSFILE_CB			; x and Y are stored in OSfile control block
			sty	OSFILE_CB_1			; 
			pha					; Push A
			ldx	#$02				; X=2
			jsr	_CLEAR_OSFILE_CB		; clear the shift register
			ldy	#$ff				; Y=255
			sty	OSFILE_CB_6			; store im 2F4
			iny					; increment Y
			jsr	_LEA1D				; and call GSINIT to prepare for reading text line
_BE257:			jsr	_GSREAD				; read a code from text line if OK read next
			bcc	_BE257				; until end of line reached
			pla					; get back A without stack changes
			pha					; 
			beq	_BE2C2				; IF A=0 (SAVE)	 E2C2
			jsr	_LE2AD				; set up file block
			bcs	_BE2A0				; if carry set do OSFILE
			beq	_BE2A5				; else if A=0 goto OSFILE

_LE267:			brk					; 
			.byte	$fc				; 
			.byte	"Bad address"			; error
			brk					; 


;*************************************************************************
;*									 *
;*	 OSBYTE 119		ENTRY					 *
;*	 CLOSE SPOOL/ EXEC FILES					 *
;*									 *
;*************************************************************************

_OSBYTE_119:		ldx	#$10				; X=10 issue *SPOOL/EXEC files warning
			jsr	_OSBYTE_143			; and issue call
			beq	_BE29F				; if a rom accepts and issues a 0 then E29F to return
			jsr	_LF68B				; else close the current exec file
			lda	#$00				; A=0


;**************************************************************************
;*									  *
;*	*SPOOL								  *
;*									  *
;**************************************************************************

_OSCLI_SPOOL:		php					; if A=0 file is closed so
			sty	MOS_WS				; Store Y
			ldy	OSB_SPOOL_HND			; get file handle
			sta	OSB_SPOOL_HND			; store A as file handle
			beq	_BE28F				; if Y<>0 then E28F
			jsr	OSFIND				; else close file via osfind
_BE28F:			ldy	MOS_WS				; get back original Y
			plp					; pull flags
			beq	_BE29F				; if A=0 on entry then exit
			lda	#$80				; else A=&80
			jsr	OSFIND				; to open file Y for output
			tay					; Y=A
			beq	_USERV				; and if this is =0 then E310 BAD COMMAND ERROR
			sta	OSB_SPOOL_HND			; store file handle
_BE29F:			rts					; and exit

_BE2A0:			bne	_USERV				; if NE then BAD COMMAND error
			inc	OSFILE_CB_6			; increment 2F4 to 00
_BE2A5:			ldx	#$ee				; X=&EE
			ldy	#$02				; Y=&02
			pla					; get back A
			jmp	OSFILE				; and JUMP to OSFILE

;**** check for hex digit ************************************************

_LE2AD:			jsr	_SKIP_SPACE			; look for NEWline
			jsr	_CHECK_FOR_HEX			; carry is set if it finds hex digit
			bcc	_BE2C1				; so E2C1 exit
			jsr	_CLEAR_OSFILE_CB		; clear shift register

;************** shift byte into control block ***************************

_BE2B8:			jsr	_LE21F				; shift lower nybble of A into shift register
			jsr	_CHECK_FOR_HEX			; then check for Hex digit
			bcs	_BE2B8				; if found then do it again
			sec					; else set carry
_BE2C1:			rts					; and exit

;**************; set up OSfile control block ****************************

_BE2C2:			ldx	#$0a				; X=0A
			jsr	_LE2AD				; 
			bcc	_USERV				; if no hex digit found EXIT via BAD Command error
			clv					; clear bit 6

;******************READ file length from text line************************

			lda	(TEXT_PTR),Y			; read next byte from text line
			cmp	#$2b				; is it '+'
			bne	_BE2D4				; if not assume its a last byte address so e2d4
			bit	_BD9B7				; else set V and M flags
			iny					; increment Y to point to hex group

_BE2D4:			ldx	#$0e				; X=E
			jsr	_LE2AD				; 
			bcc	_USERV				; if carry clear no hex digit so exit via error
			php					; save flags
			bvc	_BE2ED				; if V set them E2ED explicit end address found
			ldx	#$fc				; else X=&FC
			clc					; clear carry
_BE2E1:			lda	$01fc,X				; and add length data to start address
			adc	VEC_USERV,X			; 
			sta	VEC_USERV,X			; 
			inx					; 
			bne	_BE2E1				; repeat until X=0

_BE2ED:			ldx	#$03				; X=3
_BE2EF:			lda	OSFILE_CB_10,X			; copy start adddress to load and execution addresses
			sta	OSFILE_CB_6,X			; 
			sta	OSFILE_CB_2,X			; 
			dex					; 
			bpl	_BE2EF				; 
			plp					; get back flag
			beq	_BE2A5				; if end of command line reached then E2A5
								; to do osfile
			ldx	#$06				; else set up execution address
			jsr	_LE2AD				; 
			bcc	_USERV				; if error BAD COMMAND
			beq	_BE2A5				; and if end of line reached do OSFILE

			ldx	#$02				; else set up load address
			jsr	_LE2AD				; 
			bcc	_USERV				; if error BAD command
			beq	_BE2A5				; else on end of line do OSFILE
								; anything else is an error!!!!

;******** Bad command error ************************************

_USERV:			brk					; 
			.byte	$fe				; error number
			.byte	"Bad command"			; 
_BE31D:			brk					
			.byte	$fb				; 
			.byte	"Bad key"			; 
			brk					


;*************************************************************************
;*									 *
;*	 *KEY ENTRY							 *
;*									 *
;*************************************************************************

_OSCLI_KEY:		jsr	_LE04E				; set up key number in A
			bcc	_BE31D				; if not valid number give error
			cpx	#$10				; if key number greater than 15
			bcs	_BE31D				; if greater then give error
			jsr	_SKIP_COMMA			; otherwise skip commas, and check for CR
			php					; save flags for later
			ldx	$0b10				; get pointer to top of existing key strings
			tya					; save Y
			pha					; to preserve text pointer
			jsr	_LE3D1				; set up soft key definition
			pla					; get back Y
			tay					; 
			plp					; and flags
			bne	_BE377				; if CR found return else E377 to set up new string
			rts					; else return to set null string


;*************************************************************************
;*									 *
;*	 *FX   OSBYTE							 *
;*									 *
;*************************************************************************
;	A=number

_OSCLI_FX:		jsr	_LE04E				; convert the number to binary
			bcc	_USERV				; if bad number call bad command
			txa					; save X


;*************************************************************************
;*									 *
;*	 *CODE	 *MOTOR	  *OPT	 *ROM	*TAPE	*TV			 *
;*									 *
;*************************************************************************
				; enter codes	 *CODE	 &88
;			*MOTOR	&89
;			*OPT	&8B
;			*TAPE	&8C
;			*ROM	&8D
;			*TV	&90

_OSCLI_OSBYTE:		pha					; save A
			lda	#$00				; clear &E4/E5
			sta	OSBYTE_PAR_2			; 
			sta	OSBYTE_PAR_3			; 
			jsr	_LE043				; skip commas and check for newline (CR)
			beq	_BE36C				; if CR found E36C
			jsr	_LE04E				; convert character to binary
			bcc	_USERV				; if bad character bad command error
			stx	OSBYTE_PAR_2			; else save it
			jsr	_SKIP_COMMA			; skip comma and check CR
			beq	_BE36C				; if CR then E36C
			jsr	_LE04E				; get another parameter
			bcc	_USERV				; if bad error
			stx	OSBYTE_PAR_3			; else store in E4
			jsr	_SKIP_SPACE			; now we must have a newline
			bne	_USERV				; if none then output an error

_BE36C:			ldy	OSBYTE_PAR_3			; Y=third osbyte parameter
			ldx	OSBYTE_PAR_2			; X=2nd
			pla					; A=first
			jsr	OSBYTE				; call osbyte
			bvs	_USERV				; if V set on return then error
			rts					; else RETURN

;********* *KEY CONTINUED ************************************************
				; X points to last byte of current key definitions
_BE377:			sec					; 
			jsr	_GSINIT				; look for '"' on return bit 6 E4=1 bit 7=1 if '"'found
								; this is a GSINIT call without initial CLC
_BE37B:			jsr	_GSREAD				; call GSREAD carry is set if end of line found
			bcs	_BE388				; E388 to deal with end of line
			inx					; point to first byte of new key definition
			beq	_BE31D				; if X=0 buffer WILL overflow so exit with BAD KEY error
			sta	SOFTKEYS,X			; store character
			bcc	_BE37B				; and loop to get next byte if end of line not found
_BE388:			bne	_BE31D				; if Z clear then no matching '"' found or for some
								; other reason line doesn't terminate properly
			php					; else if all OK save flags
			sei					; bar interrupts
			jsr	_LE3D1				; and move string

			ldx	#$10				; set loop counter

_BE391:			cpx	MOS_WS				; if key being defined is found
			beq	_BE3A3				; then skip rest of loop
			lda	SOFTKEYS,X			; else get start of string X
			cmp	SOFTKEYS,Y			; compare with start of string Y
			bne	_BE3A3				; if not the same then skip rest of loop
			lda	$0b10				; else store top of string definition
			sta	SOFTKEYS,X			; in designated key pointer
_BE3A3:			dex					; decrement loop pointer X
			bpl	_BE391				; and do it all again
			plp					; get back flags
			rts					; and exit

;***********: set string lengths *****************************************

_LE3A8:			php					; push flags
			sei					; bar interrupts
			lda	$0b10				; get top of currently defined strings
			sec					; 
			sbc	SOFTKEYS,Y			; subtract to get the number of bytes in strings
								; above end of string Y
			sta	MOS_WS_1			; store this
			txa					; save X
			pha					; 
			ldx	#$10				; and X=16

_BE3B7:			lda	SOFTKEYS,X			; get start offset (from B00) of key string X
			sec					; 
			sbc	SOFTKEYS,Y			; subtract offset of string we are working on
			bcc	_BE3C8				; if carry clear (B00+Y>B00+X) or
			beq	_BE3C8				; result (in A)=0
			cmp	MOS_WS_1			; or greater or equal to number of bytes above
								; string we are working on
			bcs	_BE3C8				; then E3C8
			sta	MOS_WS_1			; else store A in &FB

_BE3C8:			dex					; point to next lower key offset
			bpl	_BE3B7				; and if 0 or +ve go back and do it again
			pla					; else get back value of X
			tax					; 
			lda	MOS_WS_1			; get back latest value of A
			plp					; pull flags
			rts					; and return

;***********: set up soft key definition *********************************

_LE3D1:			php					; push P
			sei					; bar interrupts
			txa					; save X
			pha					; push A
			ldy	MOS_WS				; get key number

			jsr	_LE3A8				; and set up &FB
			lda	SOFTKEYS,Y			; get start of string
			tay					; put it in Y
			clc					; clear carry
			adc	MOS_WS_1			; add number of bytes above string
			tax					; put this in X
			sta	MOS_WS_0			; and store it
			lda	OSB_SOFT_KEYLEN			; check number of bytes left to remove from key buffer
								; if not 0 key is being used (definition expanded so
								; error.  This stops *KEY 1 "*key1 FRED" etc.
			beq	_BE3F6				; if not in use continue

			brk					; 
			.byte	$fa				; error number
			.byte	"Key in use"			; 
			brk					; 

_BE3F6:			dec	OSB_SOFTKEY_FLG			; decrement consistence flag to &FF to warn that key
								; definitions are being changed
			pla					; pull A
			sec					; 
			sbc	MOS_WS_0			; subtract &FA
			sta	MOS_WS_0			; and re store it
			beq	_BE40D				; if 0 then E40D

_BE401:			lda	$0b01,X				; else move string
			sta	$0b01,Y				; from X to Y
			iny					; 
			inx					; 
			dec	MOS_WS_0			; for length of string
			bne	_BE401				; 

_BE40D:			tya					; store end of moved string(s)
			pha					; 
			ldy	MOS_WS				; get back key number
			ldx	#$10				; point at top of last string

_BE413:			lda	SOFTKEYS,X			; get this value
			cmp	SOFTKEYS,Y			; compare it with start of new or re defined key
			bcc	_BE422				; if less then E422
			beq	_BE422				; if = then E422
			sbc	MOS_WS_1			; shift key definitions accordingly
			sta	SOFTKEYS,X			; 
_BE422:			dex					; point to next lowest string def
			bpl	_BE413				; and if =>0 then loop and do it again
			lda	$0b10				; else make top of key definitions
			sta	SOFTKEYS,Y			; the start of our key def
			pla					; get new end of strings
			sta	$0b10				; and store it
			tax					; put A in X
			inc	OSB_SOFTKEY_FLG			; reset consistency flag
			plp					; restore flags
			rts					; and exit


