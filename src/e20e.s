;OS SERIES VI
;GEOFF COX

;*************************************************************************
;*                                                                       *
;*       *SAVE/*LOAD SETUP                                               *
;*                                                                       *
;*************************************************************************

;**************: clear osfile control block workspace ********************

.org		$e20e

_LE20E:		pha			; push A
		lda	#$00		; A=0
		sta	$02ee,X		; clear osfile control block workspace
		sta	$02ef,X		; 
		sta	$02f0,X		; 
		sta	$02f1,X		; 
		pla			; get back A
		rts			; and exit

;*********** shift through osfile control block **************************

_LE21F:		sty	$E6		; &E6=Y
		rol			; A=A*2
		rol			; *4
		rol			; *8
		rol			; *16
		ldy	#$04		; Y=4
_BE227:		rol			; A=A*32
		rol	$02ee,X		; shift bit 7 of A into shift register
		rol	$02ef,X		; and
		rol	$02f0,X		; shift
		rol	$02f1,X		; along
		bcs	_BE267		; if carry set on exit then register has overflowed
					; so bad address error
		dey			; decrement Y
		bne	_BE227		; and if Y>0 then do another shift
		ldy	$E6		; get back original Y
		rts			; and exit


;*************************************************************************
;*                                                                       *
;*       *LOAD ENTRY                                                     *
;*                                                                       *
;*************************************************************************

		lda	#$FF		; signal that load is being performed


;*************************************************************************
;*                                                                       *
;*       *SAVE ENTRY                                                     *
;*                                                                       *
;*************************************************************************
;on entry A=0 for save &ff for load

		stx	$F2		; store address of rest of command line
		sty	$F3		; 
		stx	$02ee		; x and Y are stored in OSfile control block
		sty	$02ef		; 
		pha			; Push A
		ldx	#$02		; X=2
		jsr	_LE20E		; clear the shift register
		ldy	#$FF		; Y=255
		sty	$02f4		; store im 2F4
		iny			; increment Y
		jsr	_LEA1D		; and call GSINIT to prepare for reading text line
_BE257:		jsr	_LEA2F		; read a code from text line if OK read next
		bcc	_BE257		; until end of line reached
		pla			; get back A without stack changes
		pha			; 
		beq	_BE2C2		; IF A=0 (SAVE)  E2C2
		jsr	_LE2AD		; set up file block
		bcs	_BE2A0		; if carry set do OSFILE
		beq	_BE2A5		; else if A=0 goto OSFILE

_BE267:		brk			; 
		.byte	$FC		; 
		.byte	"Bad address"		; error
		brk			; 


;*************************************************************************
;*                                                                       *
;*       OSBYTE 119             ENTRY                                    *
;*       CLOSE SPOOL/ EXEC FILES                                         *
;*                                                                       *
;*************************************************************************

_LE275:		ldx	#$10		; X=10 issue *SPOOL/EXEC files warning
		jsr	_LF168		; and issue call
		beq	_BE29F		; if a rom accepts and issues a 0 then E29F to return
		jsr	_LF68B		; else close the current exec file
		lda	#$00		; A=0


;**************************************************************************
;*                                                                        *
;*      *SPOOL                                                            *
;*                                                                        *
;**************************************************************************

		php			; if A=0 file is closed so
		sty	$E6		; Store Y
		ldy	$0257		; get file handle
		sta	$0257		; store A as file handle
		beq	_BE28F		; if Y<>0 then E28F
		jsr	OSFIND		; else close file via osfind
_BE28F:		ldy	$E6		; get back original Y
		plp			; pull flags
		beq	_BE29F		; if A=0 on entry then exit
		lda	#$80		; else A=&80
		jsr	OSFIND		; to open file Y for output
		tay			; Y=A
		beq	_LE310		; and if this is =0 then E310 BAD COMMAND ERROR
		sta	$0257		; store file handle
_BE29F:		rts			; and exit

_BE2A0:		bne	_LE310		; if NE then BAD COMMAND error
		inc	$02f4		; increment 2F4 to 00
_BE2A5:		ldx	#$EE		; X=&EE
		ldy	#$02		; Y=&02
		pla			; get back A
		jmp	OSFILE		; and JUMP to OSFILE

;**** check for hex digit ************************************************

_LE2AD:		jsr	_LE03A		; look for NEWline
		jsr	_LE08F		; carry is set if it finds hex digit
		bcc	_BE2C1		; so E2C1 exit
		jsr	_LE20E		; clear shift register

;************** shift byte into control block ***************************

_BE2B8:		jsr	_LE21F		; shift lower nybble of A into shift register
		jsr	_LE08F		; then check for Hex digit
		bcs	_BE2B8		; if found then do it again
		sec			; else set carry
_BE2C1:		rts			; and exit

;**************; set up OSfile control block ****************************

_BE2C2:		ldx	#$0A		; X=0A
		jsr	_LE2AD		; 
		bcc	_LE310		; if no hex digit found EXIT via BAD Command error
		clv			; clear bit 6

;******************READ file length from text line************************

		lda	($F2),Y		; read next byte from text line
		cmp	#$2B		; is it '+'
		bne	_BE2D4		; if not assume its a last byte address so e2d4
		bit	_BD9B7		; else set V and M flags
		iny			; increment Y to point to hex group

_BE2D4:		ldx	#$0E		; X=E
		jsr	_LE2AD		; 
		bcc	_LE310		; if carry clear no hex digit so exit via error
		php			; save flags
		bvc	_BE2ED		; if V set them E2ED explicit end address found
		ldx	#$FC		; else X=&FC
		clc			; clear carry
_BE2E1:		lda	$01fc,X		; and add length data to start address
		adc	$0200,X		; 
		sta	$0200,X		; 
		inx			; 
		bne	_BE2E1		; repeat until X=0

_BE2ED:		ldx	#$03		; X=3
_BE2EF:		lda	$02f8,X		; copy start adddress to load and execution addresses
		sta	$02f4,X		; 
		sta	$02f0,X		; 
		dex			; 
		bpl	_BE2EF		; 
		plp			; get back flag
		beq	_BE2A5		; if end of command line reached then E2A5
					;  to do osfile
		ldx	#$06		; else set up execution address
		jsr	_LE2AD		; 
		bcc	_LE310		; if error BAD COMMAND
		beq	_BE2A5		; and if end of line reached do OSFILE

		ldx	#$02		; else set up load address
		jsr	_LE2AD		; 
		bcc	_LE310		; if error BAD command
		beq	_BE2A5		; else on end of line do OSFILE
					; anything else is an error!!!!

;******** Bad command error ************************************

_LE310:		brk			; 
		.byte	$FE		; error number
		.byte	"Bad command"		; 
_BE31D:		brk	
		.byte	$FB		; 
		.byte	"Bad key"		; 
		brk	


;*************************************************************************
;*                                                                       *
;*       *KEY ENTRY                                                      *
;*                                                                       *
;*************************************************************************

		jsr	_LE04E		; set up key number in A
		bcc	_BE31D		; if not valid number give error
		cpx	#$10		; if key number greater than 15
		bcs	_BE31D		; if greater then give error
		jsr	_LE045		; otherwise skip commas, and check for CR
		php			; save flags for later
		ldx	$0b10		; get pointer to top of existing key strings
		tya			; save Y
		pha			; to preserve text pointer
		jsr	_LE3D1		; set up soft key definition
		pla			; get back Y
		tay			; 
		plp			; and flags
		bne	_BE377		; if CR found return else E377 to set up new string
		rts			; else return to set null string


;*************************************************************************
;*                                                                       *
;*       *FX   OSBYTE                                                    *
;*                                                                       *
;*************************************************************************
; ###     	A=number

		jsr	_LE04E		; convert the number to binary
		bcc	_LE310		; if bad number call bad command
		txa			; save X


;*************************************************************************
;*                                                                       *
;*       *CODE   *MOTOR   *OPT   *ROM   *TAPE   *TV                      *
;*                                                                       *
;*************************************************************************
		; enter codes    *CODE   &88
;    	                *MOTOR  &89
;    	                *OPT    &8B
;    	                *TAPE   &8C
;    	                *ROM    &8D
;    	                *TV     &90

		pha			; save A
		lda	#$00		; clear &E4/E5
		sta	$E5		; 
		sta	$E4		; 
		jsr	_LE043		; skip commas and check for newline (CR)
		beq	_BE36C		; if CR found E36C
		jsr	_LE04E		; convert character to binary
		bcc	_LE310		; if bad character bad command error
		stx	$E5		; else save it
		jsr	_LE045		; skip comma and check CR
		beq	_BE36C		; if CR then E36C
		jsr	_LE04E		; get another parameter
		bcc	_LE310		; if bad error
		stx	$E4		; else store in E4
		jsr	_LE03A		; now we must have a newline
		bne	_LE310		; if none then output an error

_BE36C:		ldy	$E4		; Y=third osbyte parameter
		ldx	$E5		; X=2nd
		pla			; A=first
		jsr	OSBYTE		; call osbyte
		bvs	_LE310		; if V set on return then error
		rts			; else RETURN

;********* *KEY CONTINUED ************************************************
		; X points to last byte of current key definitions
_BE377:		sec			; 
		jsr	_LEA1E		; look for '"' on return bit 6 E4=1 bit 7=1 if '"'found
					; this is a GSINIT call without initial CLC
_BE37B:		jsr	_LEA2F		; call GSREAD carry is set if end of line found
		bcs	_BE388		; E388 to deal with end of line
		inx			; point to first byte of new key definition
		beq	_BE31D		; if X=0 buffer WILL overflow so exit with BAD KEY error
		sta	$0b00,X		; store character
		bcc	_BE37B		; and loop to get next byte if end of line not found
_BE388:		bne	_BE31D		; if Z clear then no matching '"' found or for some
					; other reason line doesn't terminate properly
		php			; else if all OK save flags
		sei			; bar interrupts
		jsr	_LE3D1		; and move string

		ldx	#$10		; set loop counter

_BE391:		cpx	$E6		; if key being defined is found
		beq	_BE3A3		; then skip rest of loop
		lda	$0b00,X		; else get start of string X
		cmp	$0b00,Y		; compare with start of string Y
		bne	_BE3A3		; if not the same then skip rest of loop
		lda	$0b10		; else store top of string definition
		sta	$0b00,X		; in designated key pointer
_BE3A3:		dex			; decrement loop pointer X
		bpl	_BE391		; and do it all again
		plp			; get back flags
		rts			; and exit

;***********: set string lengths *****************************************

_LE3A8:		php			; push flags
		sei			; bar interrupts
		lda	$0b10		; get top of currently defined strings
		sec			; 
		sbc	$0b00,Y		; subtract to get the number of bytes in strings
					; above end of string Y
		sta	$FB		; store this
		txa			; save X
		pha			; 
		ldx	#$10		; and X=16

_BE3B7:		lda	$0b00,X		; get start offset (from B00) of key string X
		sec			; 
		sbc	$0b00,Y		; subtract offset of string we are working on
		bcc	_BE3C8		; if carry clear (B00+Y>B00+X) or
		beq	_BE3C8		; result (in A)=0
		cmp	$FB		; or greater or equal to number of bytes above
					; string we are working on
		bcs	_BE3C8		; then E3C8
		sta	$FB		; else store A in &FB

_BE3C8:		dex			; point to next lower key offset
		bpl	_BE3B7		; and if 0 or +ve go back and do it again
		pla			; else get back value of X
		tax			; 
		lda	$FB		; get back latest value of A
		plp			; pull flags
		rts			; and return

;***********: set up soft key definition *********************************

_LE3D1:		php			; push P
		sei			; bar interrupts
		txa			; save X
		pha			; push A
		ldy	$E6		; get key number

		jsr	_LE3A8		; and set up &FB
		lda	$0b00,Y		; get start of string
		tay			; put it in Y
		clc			; clear carry
		adc	$FB		; add number of bytes above string
		tax			; put this in X
		sta	$FA		; and store it
		lda	$0268		; check number of bytes left to remove from key buffer
					; if not 0 key is being used (definition expanded so
					; error.  This stops *KEY 1 "*key1 FRED" etc.
		beq	_BE3F6		; if not in use continue

		brk			; 
		.byte	$FA		; error number
		.byte	"Key in use"		; 
		brk			; 

_BE3F6:		dec	$0284		; decrement consistence flag to &FF to warn that key
					; definitions are being changed
		pla			; pull A
		sec			; 
		sbc	$FA		; subtract &FA
		sta	$FA		; and re store it
		beq	_BE40D		; if 0 then E40D

_BE401:		lda	$0b01,X		; else move string
		sta	$0b01,Y		; from X to Y
		iny			; 
		inx			; 
		dec	$FA		; for length of string
		bne	_BE401		; 

_BE40D:		tya			; store end of moved string(s)
		pha			; 
		ldy	$E6		; get back key number
		ldx	#$10		; point at top of last string

_BE413:		lda	$0b00,X		; get this value
		cmp	$0b00,Y		; compare it with start of new or re defined key
		bcc	_BE422		; if less then E422
		beq	_BE422		; if = then E422
		sbc	$FB		; shift key definitions accordingly
		sta	$0b00,X		; 
_BE422:		dex			; point to next lowest string def
		bpl	_BE413		; and if =>0 then loop and do it again
		lda	$0b10		; else make top of key definitions
		sta	$0b00,Y		; the start of our key def
		pla			; get new end of strings
		sta	$0b10		; and store it
		tax			; put A in X
		inc	$0284		; reset consistency flag
		plp			; restore flags
		rts			; and exit


