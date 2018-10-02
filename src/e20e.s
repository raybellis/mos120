;OS SERIES VI
;GEOFF COX

;*************************************************************************
;*                                                                       *
;*       *SAVE/*LOAD SETUP                                               *
;*                                                                       *
;*************************************************************************

;**************: clear osfile control block workspace ********************

.org		$e20e

		pha			; push A
		lda	#$00		; A=0
		sta	$02EE,X		; clear osfile control block workspace
		sta	$02EF,X		; 
		sta	$02F0,X		; 
		sta	$02F1,X		; 
		pla			; get back A
		rts			; and exit

;*********** shift through osfile control block **************************

		sty	$E6		; &E6=Y
		rol			; A=A*2
		rol			; *4
		rol			; *8
		rol			; *16
		ldy	#$04		; Y=4
		rol			; A=A*32
		rol	$02EE,X		; shift bit 7 of A into shift register
		rol	$02EF,X		; and
		rol	$02F0,X		; shift
		rol	$02F1,X		; along
		bcs	$E267		; if carry set on exit then register has overflowed
					; so bad address error
		dey			; decrement Y
		bne	$E227		; and if Y>0 then do another shift
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
		stx	$02EE		; x and Y are stored in OSfile control block
		sty	$02EF		; 
		pha			; Push A
		ldx	#$02		; X=2
		jsr	$E20E		; clear the shift register
		ldy	#$FF		; Y=255
		sty	$02F4		; store im 2F4
		iny			; increment Y
		jsr	$EA1D		; and call GSINIT to prepare for reading text line
		jsr	$EA2F		; read a code from text line if OK read next
		bcc	$E257		; until end of line reached
		pla			; get back A without stack changes
		pha			; 
		beq	$E2C2		; IF A=0 (SAVE)  E2C2
		jsr	$E2AD		; set up file block
		bcs	$E2A0		; if carry set do OSFILE
		beq	$E2A5		; else if A=0 goto OSFILE

		brk			; 
		.byte	$FC		; 
		.byte	"Bad address"		; error
		brk			; 


;*************************************************************************
;*                                                                       *
;*       OSBYTE 119             ENTRY                                    *
;*       CLOSE SPOOL/ EXEC FILES                                         *
;*                                                                       *
;*************************************************************************

		ldx	#$10		; X=10 issue *SPOOL/EXEC files warning
		jsr	$F168		; and issue call
		beq	$E29F		; if a rom accepts and issues a 0 then E29F to return
		jsr	$F68B		; else close the current exec file
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
		beq	$E28F		; if Y<>0 then E28F
		jsr	OSFIND		; else close file via osfind
		ldy	$E6		; get back original Y
		plp			; pull flags
		beq	$E29F		; if A=0 on entry then exit
		lda	#$80		; else A=&80
		jsr	OSFIND		; to open file Y for output
		tay			; Y=A
		beq	$E310		; and if this is =0 then E310 BAD COMMAND ERROR
		sta	$0257		; store file handle
		rts			; and exit

		bne	$E310		; if NE then BAD COMMAND error
		inc	$02F4		; increment 2F4 to 00
		ldx	#$EE		; X=&EE
		ldy	#$02		; Y=&02
		pla			; get back A
		jmp	OSFILE		; and JUMP to OSFILE

;**** check for hex digit ************************************************

		jsr	$E03A		; look for NEWline
		jsr	$E08F		; carry is set if it finds hex digit
		bcc	$E2C1		; so E2C1 exit
		jsr	$E20E		; clear shift register

;************** shift byte into control block ***************************

		jsr	$E21F		; shift lower nybble of A into shift register
		jsr	$E08F		; then check for Hex digit
		bcs	$E2B8		; if found then do it again
		sec			; else set carry
		rts			; and exit

;**************; set up OSfile control block ****************************

		ldx	#$0A		; X=0A
		jsr	$E2AD		; 
		bcc	$E310		; if no hex digit found EXIT via BAD Command error
		clv			; clear bit 6

;******************READ file length from text line************************

		lda	($F2),Y		; read next byte from text line
		cmp	#$2B		; is it '+'
		bne	$E2D4		; if not assume its a last byte address so e2d4
		bit	$D9B7		; else set V and M flags
		iny			; increment Y to point to hex group

		ldx	#$0E		; X=E
		jsr	$E2AD		; 
		bcc	$E310		; if carry clear no hex digit so exit via error
		php			; save flags
		bvc	$E2ED		; if V set them E2ED explicit end address found
		ldx	#$FC		; else X=&FC
		clc			; clear carry
		lda	$01FC,X		; and add length data to start address
		adc	$0200,X		; 
		sta	$0200,X		; 
		inx			; 
		bne	$E2E1		; repeat until X=0

		ldx	#$03		; X=3
		lda	$02F8,X		; copy start adddress to load and execution addresses
		sta	$02F4,X		; 
		sta	$02F0,X		; 
		dex			; 
		bpl	$E2EF		; 
		plp			; get back flag
		beq	$E2A5		; if end of command line reached then E2A5
					;  to do osfile
		ldx	#$06		; else set up execution address
		jsr	$E2AD		; 
		bcc	$E310		; if error BAD COMMAND
		beq	$E2A5		; and if end of line reached do OSFILE

		ldx	#$02		; else set up load address
		jsr	$E2AD		; 
		bcc	$E310		; if error BAD command
		beq	$E2A5		; else on end of line do OSFILE
					; anything else is an error!!!!

;******** Bad command error ************************************

		brk			; 
		.byte	$FE		; error number
		.byte	"Bad command"		; 
		brk	
		.byte	$FB		; 
		.byte	"Bad key"		; 
		brk	


;*************************************************************************
;*                                                                       *
;*       *KEY ENTRY                                                      *
;*                                                                       *
;*************************************************************************

		jsr	$E04E		; set up key number in A
		bcc	$E31D		; if not valid number give error
		cpx	#$10		; if key number greater than 15
		bcs	$E31D		; if greater then give error
		jsr	$E045		; otherwise skip commas, and check for CR
		php			; save flags for later
		ldx	$0B10		; get pointer to top of existing key strings
		tya			; save Y
		pha			; to preserve text pointer
		jsr	$E3D1		; set up soft key definition
		pla			; get back Y
		tay			; 
		plp			; and flags
		bne	$E377		; if CR found return else E377 to set up new string
		rts			; else return to set null string


;*************************************************************************
;*                                                                       *
;*       *FX   OSBYTE                                                    *
;*                                                                       *
;*************************************************************************
; ###     	A=number

		jsr	$E04E		; convert the number to binary
		bcc	$E310		; if bad number call bad command
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
		jsr	$E043		; skip commas and check for newline (CR)
		beq	$E36C		; if CR found E36C
		jsr	$E04E		; convert character to binary
		bcc	$E310		; if bad character bad command error
		stx	$E5		; else save it
		jsr	$E045		; skip comma and check CR
		beq	$E36C		; if CR then E36C
		jsr	$E04E		; get another parameter
		bcc	$E310		; if bad error
		stx	$E4		; else store in E4
		jsr	$E03A		; now we must have a newline
		bne	$E310		; if none then output an error

		ldy	$E4		; Y=third osbyte parameter
		ldx	$E5		; X=2nd
		pla			; A=first
		jsr	OSBYTE		; call osbyte
		bvs	$E310		; if V set on return then error
		rts			; else RETURN

;********* *KEY CONTINUED ************************************************
		; X points to last byte of current key definitions
		sec			; 
		jsr	$EA1E		; look for '"' on return bit 6 E4=1 bit 7=1 if '"'found
					; this is a GSINIT call without initial CLC
		jsr	$EA2F		; call GSREAD carry is set if end of line found
		bcs	$E388		; E388 to deal with end of line
		inx			; point to first byte of new key definition
		beq	$E31D		; if X=0 buffer WILL overflow so exit with BAD KEY error
		sta	$0B00,X		; store character
		bcc	$E37B		; and loop to get next byte if end of line not found
		bne	$E31D		; if Z clear then no matching '"' found or for some
					; other reason line doesn't terminate properly
		php			; else if all OK save flags
		sei			; bar interrupts
		jsr	$E3D1		; and move string

		ldx	#$10		; set loop counter

		cpx	$E6		; if key being defined is found
		beq	$E3A3		; then skip rest of loop
		lda	$0B00,X		; else get start of string X
		cmp	$0B00,Y		; compare with start of string Y
		bne	$E3A3		; if not the same then skip rest of loop
		lda	$0B10		; else store top of string definition
		sta	$0B00,X		; in designated key pointer
		dex			; decrement loop pointer X
		bpl	$E391		; and do it all again
		plp			; get back flags
		rts			; and exit

;***********: set string lengths *****************************************

		php			; push flags
		sei			; bar interrupts
		lda	$0B10		; get top of currently defined strings
		sec			; 
		sbc	$0B00,Y		; subtract to get the number of bytes in strings
					; above end of string Y
		sta	$FB		; store this
		txa			; save X
		pha			; 
		ldx	#$10		; and X=16

		lda	$0B00,X		; get start offset (from B00) of key string X
		sec			; 
		sbc	$0B00,Y		; subtract offset of string we are working on
		bcc	$E3C8		; if carry clear (B00+Y>B00+X) or
		beq	$E3C8		; result (in A)=0
		cmp	$FB		; or greater or equal to number of bytes above
					; string we are working on
		bcs	$E3C8		; then E3C8
		sta	$FB		; else store A in &FB

		dex			; point to next lower key offset
		bpl	$E3B7		; and if 0 or +ve go back and do it again
		pla			; else get back value of X
		tax			; 
		lda	$FB		; get back latest value of A
		plp			; pull flags
		rts			; and return

;***********: set up soft key definition *********************************

		php			; push P
		sei			; bar interrupts
		txa			; save X
		pha			; push A
		ldy	$E6		; get key number

		jsr	$E3A8		; and set up &FB
		lda	$0B00,Y		; get start of string
		tay			; put it in Y
		clc			; clear carry
		adc	$FB		; add number of bytes above string
		tax			; put this in X
		sta	$FA		; and store it
		lda	$0268		; check number of bytes left to remove from key buffer
					; if not 0 key is being used (definition expanded so
					; error.  This stops *KEY 1 "*key1 FRED" etc.
		beq	$E3F6		; if not in use continue

		brk			; 
		.byte	$FA		; error number
		.byte	"Key in use"		; 
		brk			; 

		dec	$0284		; decrement consistence flag to &FF to warn that key
					; definitions are being changed
		pla			; pull A
		sec			; 
		sbc	$FA		; subtract &FA
		sta	$FA		; and re store it
		beq	$E40D		; if 0 then E40D

		lda	$0B01,X		; else move string
		sta	$0B01,Y		; from X to Y
		iny			; 
		inx			; 
		dec	$FA		; for length of string
		bne	$E401		; 

		tya			; store end of moved string(s)
		pha			; 
		ldy	$E6		; get back key number
		ldx	#$10		; point at top of last string

		lda	$0B00,X		; get this value
		cmp	$0B00,Y		; compare it with start of new or re defined key
		bcc	$E422		; if less then E422
		beq	$E422		; if = then E422
		sbc	$FB		; shift key definitions accordingly
		sta	$0B00,X		; 
		dex			; point to next lowest string def
		bpl	$E413		; and if =>0 then loop and do it again
		lda	$0B10		; else make top of key definitions
		sta	$0B00,Y		; the start of our key def
		pla			; get new end of strings
		sta	$0B10		; and store it
		tax			; put A in X
		inc	$0284		; reset consistency flag
		plp			; restore flags
		rts			; and exit


