;**** STRINGS ****

			.org	$df0c

_MSG_COPYSYM:		.byte	")C(",0				; Copyright string match

;**** COMMMANDS ****
;				  Command    Address	   Call goes to
_OSCLI_TABLE:		.byte	".",$e0,$31,$05			; *.	    &E031, A=5	   FSCV, XY=>String
			.byte	"FX",$e3,$42,$ff		; *FX	    &E342, A=&FF   Number parameters
			.byte	"BASIC",$e0,$18,$00		; *BASIC    &E018, A=0	   XY=>String
			.byte	"CAT",$e0,$31,$05		; *CAT	    &E031, A=5	   FSCV, XY=>String
			.byte	"CODE",$e3,$48,$88		; *CODE	    &E348, A=&88   OSBYTE &88
			.byte	"EXEC",$f6,$8d,$00		; *EXEC	    &F68D, A=0	   XY=>String
			.byte	"HELP",$f0,$b9,$ff		; *HELP	    &F0B9, A=&FF   F2/3=>String
			.byte	"KEY",$e3,$27,$ff		; *KEY	    &E327, A=&FF   F2/3=>String
			.byte	"LOAD",$e2,$3c,$00		; *LOAD	    &E23C, A=0	   XY=>String
			.byte	"LINE",$e6,$59,$01		; *LINE	    &E659, A=1	   USERV, XY=>String
			.byte	"MOTOR",$e3,$48,$89		; *MOTOR    &E348, A=&89   OSBYTE
			.byte	"OPT",$e3,$48,$8b		; *OPT	    &E348, A=&8B   OSBYTE
			.byte	"RUN",$e0,$31,$04		; *RUN	    &E031, A=4	   FSCV, XY=>String
			.byte	"ROM",$e3,$48,$8d		; *ROM	    &E348, A=&8D   OSBYTE
			.byte	"SAVE",$e2,$3e,$00		; *SAVE	    &E23E, A=0	   XY=>String
			.byte	"SPOOL",$e2,$81,$00		; *SPOOL    &E281, A=0	   XY=>String
			.byte	"TAPE",$e3,$48,$8c		; *TAPE	    &E348, A=&8C   OSBYTE
			.byte	"TV",$e3,$48,$90		; *TV	    &E348, A=&90   OSBYTE
			.byte	"",$e0,$31,$03			; Unmatched &E031, A=3	   FSCV, XY=>String
			.byte	$00				; Table end marker

; Command routines are entered with XY=>command tail, A=table parameter,
; &F2/3,&E6=>start of command string
; If table parameter if <&80, F2/3,Y converted to XY before entering


;*************************************************************************
;*   CLI - COMMAND LINE INTERPRETER					 *
;*									 *
;*   ENTRY: XY=>Command line						 *
;*   EXIT:  All registers corrupted					 *
;*   [ A=13 - unterminated string ]					 *
;*************************************************************************

_CLIV:			stx	TEXT_PTR			; Store XY in &F2/3
			sty	TEXT_PTR_HI			
			lda	#$08				
			jsr	_OSCLI_FSCV			; Inform filing system CLI being processed
			ldy	#$00				; Check the line is correctly terminated
__cliv_not_newline:	lda	(TEXT_PTR),Y			
			cmp	#$0d				; Loop until CR is found
			beq	_BDF9E				
			iny					; Move to next character
			bne	__cliv_not_newline		; Loop back if less than 256 bytes long
			rts					; Exit if string > 255 characters

; String is terminated - skip prepended spaces and '*'s
_BDF9E:			ldy	#$ff				
_BDFA0:			jsr	_SKIP_SPACES_NXT		; Skip any spaces
			beq	__get_text_ptr_done		; Exit if at CR
			cmp	#$2a				; Is this character '*'?
			beq	_BDFA0				; Loop back to skip it, and check for spaces again

			jsr	_SKIP_SPACE			; Skip any more spaces
			beq	__get_text_ptr_done		; Exit if at CR
			cmp	#$7c				; Is it '|' - a comment
			beq	__get_text_ptr_done		; Exit if so
			cmp	#$2f				; Is it '/' - pass straight to filing system
			bne	__cliv_not_slash		; Jump forward if not
			iny					; Move past the '/'
			jsr	_LE009				; Convert &F2/3,Y->XY, ignore returned A
			lda	#$02				; 2=RunSlashCommand
			bne	_OSCLI_FSCV			; Jump to pass to FSCV

; Look command up in command table
__cliv_not_slash:	sty	MOS_WS				; Store offset to start of command
			ldx	#$00				
			beq	_BDFD7				

_BDFC4:			eor	_OSCLI_TABLE,X			
			and	#$df				
			bne	_BDFE2				
			iny					
			clc					

_BDFCD:			bcs	_BDFF4				
			inx					
			lda	(TEXT_PTR),Y			
			jsr	_LE4E3				
			bcc	_BDFC4				

_BDFD7:			lda	_OSCLI_TABLE,X			
			bmi	_BDFF2				
			lda	(TEXT_PTR),Y			
			cmp	#$2e				
			beq	_BDFE6				
_BDFE2:			clc					
			ldy	MOS_WS				
			dey					
_BDFE6:			iny					
			inx					
_BDFE8:			inx					
			lda	_MSG_COPYSYM + 2,X		
			beq	__nobasic			
			bpl	_BDFE8				
			bmi	_BDFCD				

_BDFF2:			inx					
			inx					

_BDFF4:			dex					
			dex					
			pha					
			lda	_MSG_COPYSYM + 5,X		
			pha					
			jsr	_SKIP_SPACE			
			clc					
			php					
			jsr	_LE004				
			rti					; Jump to routine

_LE004:			lda	_OSCLI_TABLE + 2,X		; Get table parameter
			bmi	__get_text_ptr_done		; If >=&80, number follow
;		       ; else string follows

_LE009:			tya					; Pass Y line offset to A for later
			ldy	_OSCLI_TABLE + 2,X		; Get looked-up parameter from table

; Convert &F2/3,A to XY, put Y in A
_GET_TEXT_PTR:		clc					
			adc	TEXT_PTR			
			tax					
			tya					; Pass supplied Y into A
			ldy	TEXT_PTR_HI			
			bcc	__get_text_ptr_done		
			iny					

__get_text_ptr_done:	rts					


; *BASIC
; ======
_OSCLI_BASIC:		ldx	OSB_BASIC_ROM			; Get BASIC ROM number
			bmi	__nobasic			; If none set, jump to pass command on
			sec					; Set Carry = not entering from RESET
			jmp	_OSBYTE_142			; Enter language rom in X

; Pass command on to other ROMs and to filing system
__nobasic:		ldy	MOS_WS				; Restore pointer to start of command
			ldx	#$04				; 4=UnknownCommand
			jsr	_OSBYTE_143			; Pass to sideways ROMs
			beq	__get_text_ptr_done		; If claimed, exit
			lda	MOS_WS				; Restore pointer to start of command
			jsr	_GET_TEXT_PTR			; Convert &F2/3,A to XY, ignore returned A
			lda	#$03				; 3=PassCommandToFilingSystem

; Pass to current filing system
_OSCLI_FSCV:		jmp	(VEC_FSCV)			

_OSBYTE_139:		asl	A				
_OSBYTE_127:		and	#$01				
			bpl	_OSCLI_FSCV			

; Skip spaces
_SKIP_SPACES_NXT:	iny					
_SKIP_SPACE:		lda	(TEXT_PTR),Y			
			cmp	#$20				
			beq	_SKIP_SPACES_NXT		
__compare_newline:	cmp	#$0d				
			rts					

_LE043:			bcc	_SKIP_SPACE			
_SKIP_COMMA:		jsr	_SKIP_SPACE			
			cmp	#$2c				
			bne	__compare_newline		
			iny					
			rts					

_LE04E:			jsr	_SKIP_SPACE			
			jsr	_CHECK_FOR_DIGIT		
			bcc	__not_digit			
_BE056:			sta	MOS_WS				
			jsr	_CHECK_FOR_DIGIT_NXT		
			bcc	_BE076				
			tax					
			lda	MOS_WS				
			asl	A				
			bcs	__not_digit			
			asl	A				
			bcs	__not_digit			
			adc	MOS_WS				
			bcs	__not_digit			
			asl	A				
			bcs	__not_digit			
			sta	MOS_WS				
			txa					
			adc	MOS_WS				
			bcs	__not_digit			
			bcc	_BE056				
_BE076:			ldx	MOS_WS				
			cmp	#$0d				
			sec					
			rts					

_CHECK_FOR_DIGIT_NXT:	iny					
_CHECK_FOR_DIGIT:	lda	(TEXT_PTR),Y			
			cmp	#$3a				
			bcs	__not_digit			
			cmp	#$30				
			bcc	__not_digit			
			and	#$0f				
			rts					

__next_field:		jsr	_SKIP_COMMA			
__not_digit:		clc					
			rts					

_CHECK_FOR_HEX:		jsr	_CHECK_FOR_DIGIT		
			bcs	__check_hex_done		
			and	#$df				
			cmp	#$47				
			bcs	__next_field			
			cmp	#$41				
			bcc	__next_field			
			php					
			sbc	#$37				
			plp					
__check_hex_done:	iny					
			rts					

; WRCH control routine
; ====================
_NVWRCH:		pha					; Save all registers
			txa					
			pha					
			tya					
			pha					
			tsx					
			lda	STACK+3,X			; Get A back from stack
			pha					; Save A
			bit	OSB_OSWRCH_INT			; Check OSWRCH interception flag
			bpl	__no_intercept			; Not set, skip interception call
			tay					; Pass character to Y
			lda	#$04				; A=4 for OSWRCH call
			jsr	_NETV				; Call interception code
			bcs	_BE10D				; If claimed, jump past to exit

__no_intercept:		clc					; Prepare to not send this to printer
			lda	#$02				; Check output destination
			bit	OSB_OUT_STREAM			; Is VDU driver disabled?
			bne	_BE0C8				; Yes, skip past VDU driver
			pla					; Get character back
			pha					; Resave character
			jsr	_VDUCHR				; Call VDU driver
								; On exit, C=1 if character to be sent to printer

_BE0C8:			lda	#$08				; Check output destination
			bit	OSB_OUT_STREAM			; Is printer seperately enabled?
			bne	_BE0D1				; Yes, jump to call printer driver
			bcc	_BE0D6				; Carry clear, don't sent to printer
_BE0D1:			pla					; Get character back
			pha					; Resave character
			jsr	_PRINTER_OUT			; Call printer driver

_BE0D6:			lda	OSB_OUT_STREAM			; Check output destination
			ror	A				; Is serial output enabled?
			bcc	_BE0F7				; No, skip past serial output
			ldy	RS423_TIMEOUT			; Get serial timout counter
			dey					; Decrease counter
			bpl	_BE0F7				; Timed out, skip past serial code
			pla					; Get character back
			pha					; Resave character
			php					; Save IRQs
			sei					; Disable IRQs
			ldx	#$02				; X=2 for serial output buffer
			pha					; Save character
			jsr	_OSBYTE_152			; Examine serial output buffer
			bcc	_BE0F0				; Buffer not full, jump to send character
			jsr	_LE170				; Wait for buffer to empty a bit
_BE0F0:			pla					; Get character back
			ldx	#$02				; X=2 for serial output buffer
			jsr	_BUFFER_SAVE			; Send character to serial output buffer
			plp					; Restore IRQs

_BE0F7:			lda	#$10				; Check output destination
			bit	OSB_OUT_STREAM			; Is SPOOL output disabled?
			bne	_BE10D				; Yes, skip past SPOOL output
			ldy	OSB_SPOOL_HND			; Get SPOOL handle
			beq	_BE10D				; If not open, skip past SPOOL output
			pla					; Get character back
			pha					; Resave character
			sec					
			ror	CRFS_ACTIVE			; Set RFS/CFS's 'spooling' flag
			jsr	OSBPUT				; Write character to SPOOL channel
			lsr	CRFS_ACTIVE			; Reset RFS/CFS's 'spooling' flag

_BE10D:			pla					; Restore all registers
			pla					
			tay					
			pla					
			tax					
			pla					
			rts					; Exit


;*************************************************************************
;*									 *
;*	 PRINTER DRIVER							 *
;*									 *
;*************************************************************************

;A=character to print

_PRINTER_OUT:		bit	OSB_OUT_STREAM			; if bit 6 of VDU byte =1 printer is disabled
			bvs	__printer_out_done		; so E139

			cmp	OSB_PRINT_IGN			; compare with printer ignore character
			beq	__printer_out_done		; if the same E139

_PRINTER_OUT_ALWAYS:	php					; else save flags
			sei					; bar interrupts
			tax					; X=A
			lda	#$04				; A=4
			bit	OSB_OUT_STREAM			; read bit 2 'disable printer driver'
			bne	__printer_out_done_plp		; if set printer is disabled so exit E138
			txa					; else A=X
			ldx	#$03				; X=3
			jsr	_BUFFER_SAVE			; and put character in printer buffer
			bcs	__printer_out_done_plp		; if carry set on return exit, buffer not full (empty?)

			bit	BUFFER_3_BUSY			; else check buffer busy flag if 0
			bpl	__printer_out_done_plp		; then E138 to exit
			jsr	_LE13A				; else E13A to open printer cahnnel

__printer_out_done_plp: plp					; get back flags
__printer_out_done:	rts					; and exit

_LE13A:			lda	OSB_PRINT_DEST			; check printer destination
			beq	_LE1AD				; if 0 then E1AD clear printer buffer and exit
			cmp	#$01				; if parallel printer not selected
			bne	_BE164				; E164
			jsr	_OSBYTE_145			; else read a byte from the printer buffer
			ror	BUFFER_3_BUSY			; if carry is set then 2d2 is -ve
			bmi	_BE190				; so return via E190
			ldy	#$82				; else enable interrupt 1 of the external VIA
			sty	USR_VIA_IER			; 
			sta	USR_VIA_IORA			; pass code to centronics port
			lda	USR_VIA_PCR			; pulse CA2 line to generate STROBE signal
			and	#$f1				; to advise printer that
			ora	#$0c				; valid data is
			sta	USR_VIA_PCR			; waiting
			ora	#$0e				; 
			sta	USR_VIA_PCR			; 
			bne	_BE190				; then exit

;*********:serial printer *********************************************

_BE164:			cmp	#$02				; is it Serial printer??
			bne	_BE191				; if not E191
			ldy	RS423_TIMEOUT			; else is RS423 in use by cassette??
			dey					; 
			bpl	_LE1AD				; if so E1AD to flush buffer

			lsr	BUFFER_3_BUSY			; else clear buffer busy flag
_LE170:			lsr	OSB_RS423_USE			; and RS423 busy flag
_LE173:			jsr	_LE741				; count buffer if C is clear on return
			bcc	_BE190				; no room in buffer so exit
			ldx	#$20				; else
_LE17A:			ldy	#$9f				; 


;*************************************************************************
;*									 *
;*	 OSBYTE 156 update ACIA setting and RAM copy			 *
;*									 *
;*************************************************************************
;on entry

_OSBYTE_156:		php					; push flags
			sei					; bar interrupts
			tya					; A=Y
			stx	MOS_WS_0			; &FA=X
			and	OSB_RS423_CTL			; A=old value AND Y EOR X
			eor	MOS_WS_0			; 
			ldx	OSB_RS423_CTL			; get old value in X
_LE189:			sta	OSB_RS423_CTL			; put new value in
			sta	ACIA_CSR			; and store to ACIA control register
			plp					; get back flags
_BE190:			rts					; and exit

;************ printer is neither serial or parallel so its user type *****

_BE191:			clc					; clear carry
			lda	#$01				; A=1
			jsr	_LE1A2				; 


;*************************************************************************
;*									 *
;*	 OSBYTE 123 Warn printer driver going dormant			 *
;*									 *
;*************************************************************************

_OSBYTE_123:		ror	BUFFER_3_BUSY			; mark printer buffer empty for osbyte
_BE19A:			rts					; and exit

_LE19B:			bit	BUFFER_3_BUSY			; if bit 7 is set buffer is empty
			bmi	_BE19A				; so exit

			lda	#$00				; else A=0

_LE1A2:			ldx	#$03				; X=3
_LE1A4:			ldy	OSB_PRINT_DEST			; Y=printer destination
			jsr	_NETV				; to JMP (NETV)
			jmp	(VEC_UPTV)			; jump to PRINT VECTOR for special routines

;*************** Buffer handling *****************************************
				; X=buffer number
				; Buffer number	 Address	 Flag	 Out pointer	 In pointer
				; 0=Keyboard	 3E0-3FF	 2CF	 2D8		 2E1
				; 1=RS423 Input	 A00-AFF	 2D0	 2D9		 2E2
				; 2=RS423 output 900-9BF	 2D1	 2DA		 2E3
				; 3=printer	 880-8BF	 2D2	 2DB		 2E4
				; 4=sound0	 840-84F	 2D3	 2DC		 2E5
				; 5=sound1	 850-85F	 2D4	 2DD		 2E6
				; 6=sound2	 860-86F	 2D5	 2DE		 2E7
				; 7=sound3	 870-87F	 2D6	 2DF		 2E8
				; 8=speech	 8C0-8FF	 2D7	 2E0		 2E9

_LE1AD:			clc					; clear carry
_LE1AE:			pha					; save A
			php					; save flags
			sei					; set interrupts
			bcs	_BE1BB				; if carry set on entry then E1BB
			lda	_BAUD_TABLE,X			; else get byte from baud rate/sound data table
			bpl	_BE1BB				; if +ve the E1BB
			jsr	_LECA2				; else clear sound data

_BE1BB:			sec					; set carry
			ror	BUFFER_0_BUSY,X			; rotate buffer flag to show buffer empty
			cpx	#$02				; if X>1 then its not an input buffer
			bcs	_BE1CB				; so E1CB

			lda	#$00				; else Input buffer so A=0
			sta	OSB_SOFT_KEYLEN			; store as length of key string
			sta	OSB_VDU_QSIZE			; and length of VDU queque
_BE1CB:			jsr	_LE73B				; then enter via count purge vector any user routines
			plp					; restore flags
			pla					; restore A
			rts					; and exit


;*************************************************************************
;*									 *
;*	 COUNT PURGE VECTOR	 DEFAULT ENTRY				 *
;*									 *
;*************************************************************************
;on entry if V set clear buffer
;	  if C set get space left
;	  else get bytes used

_CNPV:			bvc	_BE1DA				; if bit 6 is set then E1DA
			lda	BUFFER_0_OUT,X			; else start of buffer=end of buffer
			sta	BUFFER_0_IN,X			; 
			rts					; and exit

_BE1DA:			php					; push flags
			sei					; bar interrupts
			php					; push flags
			sec					; set carry
			lda	BUFFER_0_IN,X			; get end of buffer
			sbc	BUFFER_0_OUT,X			; subtract start of buffer
			bcs	_BE1EA				; if carry caused E1EA
			sec					; set carry
			sbc	_BUFFER_OFFSET_TABLE,X		; subtract buffer start offset (i.e. add buffer length)
_BE1EA:			plp					; pull flags
			bcc	_BE1F3				; if carry clear E1F3 to exit
			clc					; clear carry
			adc	_BUFFER_OFFSET_TABLE,X		; adc to get bytes used
			eor	#$ff				; and invert to get space left
_BE1F3:			ldy	#$00				; Y=0
			tax					; X=A
			plp					; get back flags
			rts					; and exit

;********** enter byte in buffer, wait and flash lights if full **********

_BUFFER_SAVE:		sei					; prevent interrupts
			jsr	_INSV				; enter a byte in buffer X
			bcc	__buffer_save_done		; if successful exit
			jsr	_SET_LEDS_TEST_ESCAPE		; else switch on both keyboard lights
			php					; push p
			pha					; push A
			jsr	_SET_LEDS			; switch off unselected LEDs
			pla					; get back A
			plp					; and flags
			bmi	__buffer_save_done		; if return is -ve Escape pressed so exit
			cli					; else allow interrupts
			bcs	_BUFFER_SAVE			; if byte didn't enter buffer go and try it again
__buffer_save_done:	rts					; then return

