;**** STRINGS ****

.org		$df0c

_LDF0C:		.byte	")C(",0		; Copyright string match

;**** COMMMANDS ****
;				  Command    Address       Call goes to
_LDF10:		.byte	".",$e0,$31,$05		; *.        &E031, A=5     FSCV, XY=>String
		.byte	"FX",$e3,$42,$ff		; *FX       &E342, A=&FF   Number parameters
		.byte	"BASIC",$e0,$18,$00		; *BASIC    &E018, A=0     XY=>String
		.byte	"CAT",$e0,$31,$05		; *CAT      &E031, A=5     FSCV, XY=>String
		.byte	"CODE",$e3,$48,$88		; *CODE     &E348, A=&88   OSBYTE &88
		.byte	"EXEC",$f6,$8d,$00		; *EXEC     &F68D, A=0     XY=>String
		.byte	"HELP",$f0,$b9,$ff		; *HELP     &F0B9, A=&FF   F2/3=>String
		.byte	"KEY",$e3,$27,$ff		; *KEY      &E327, A=&FF   F2/3=>String
		.byte	"LOAD",$e2,$3c,$00		; *LOAD     &E23C, A=0     XY=>String
		.byte	"LINE",$e6,$59,$01		; *LINE     &E659, A=1     USERV, XY=>String
		.byte	"MOTOR",$e3,$48,$89		; *MOTOR    &E348, A=&89   OSBYTE
		.byte	"OPT",$e3,$48,$8b		; *OPT      &E348, A=&8B   OSBYTE
		.byte	"RUN",$e0,$31,$04		; *RUN      &E031, A=4     FSCV, XY=>String
		.byte	"ROM",$e3,$48,$8d		; *ROM      &E348, A=&8D   OSBYTE
		.byte	"SAVE",$e2,$3e,$00		; *SAVE     &E23E, A=0     XY=>String
		.byte	"SPOOL",$e2,$81,$00		; *SPOOL    &E281, A=0     XY=>String
		.byte	"TAPE",$e3,$48,$8c		; *TAPE     &E348, A=&8C   OSBYTE
		.byte	"TV",$e3,$48,$90		; *TV       &E348, A=&90   OSBYTE
		.byte	"",$e0,$31,$03		; Unmatched &E031, A=3     FSCV, XY=>String
		.byte	$00		; Table end marker

; Command routines are entered with XY=>command tail, A=table parameter,
; &F2/3,&E6=>start of command string
; If table parameter if <&80, F2/3,Y converted to XY before entering


;*************************************************************************
;*   CLI - COMMAND LINE INTERPRETER                                      *
;*                                                                       *
;*   ENTRY: XY=>Command line                                             *
;*   EXIT:  All registers corrupted                                      *
;*   [ A=13 - unterminated string ]                                      *
;*************************************************************************
;
_LDF89:		stx	$F2		; Store XY in &F2/3
		sty	$F3
		lda	#$08
		jsr	_LE031		; Inform filing system CLI being processed
		ldy	#$00		; Check the line is correctly terminated
_BDF94:		lda	($F2),Y
		cmp	#$0D		; Loop until CR is found
		beq	_BDF9E
		iny			; Move to next character
		bne	_BDF94		; Loop back if less than 256 bytes long
		rts			; Exit if string > 255 characters

; String is terminated - skip prepended spaces and '*'s
_BDF9E:		ldy	#$FF
_BDFA0:		jsr	_LE039		; Skip any spaces
		beq	_BE017		; Exit if at CR
		cmp	#$2A		; Is this character '*'?
		beq	_BDFA0		; Loop back to skip it, and check for spaces again

		jsr	_LE03A		; Skip any more spaces
		beq	_BE017		; Exit if at CR
		cmp	#$7C		; Is it '|' - a comment
		beq	_BE017		; Exit if so
		cmp	#$2F		; Is it '/' - pass straight to filing system
		bne	_BDFBE		; Jump forward if not
		iny			; Move past the '/'
		jsr	_LE009		; Convert &F2/3,Y->XY, ignore returned A
		lda	#$02		; 2=RunSlashCommand
		bne	_LE031		; Jump to pass to FSCV
;
; Look command up in command table
_BDFBE:		sty	$E6		; Store offset to start of command
		ldx	#$00
		beq	_BDFD7
;   	
_BDFC4:		eor	_LDF10,X
		and	#$DF
		bne	_BDFE2
		iny	
		clc	
;   	
_BDFCD:		bcs	_BDFF4
		inx	
		lda	($F2),Y
		jsr	_LE4E3
		bcc	_BDFC4
;   	
_BDFD7:		lda	_LDF10,X
		bmi	_BDFF2
		lda	($F2),Y
		cmp	#$2E
		beq	_BDFE6
_BDFE2:		clc	
		ldy	$E6
		dey	
_BDFE6:		iny	
		inx	
_BDFE8:		inx	
		lda	_LDF0C + 2,X
		beq	_BE021
		bpl	_BDFE8
		bmi	_BDFCD
;   	
_BDFF2:		inx	
		inx	
;   	
_BDFF4:		dex	
		dex	
		pha	
		lda	_LDF0C + 5,X
		pha	
		jsr	_LE03A
		clc	
		php	
		jsr	_LE004
		rti			; Jump to routine

_LE004:		lda	_LDF0C + 6,X		; Get table parameter
		bmi	_BE017		; If >=&80, number follow
;                      ; else string follows

_LE009:		tya			; Pass Y line offset to A for later
		ldy	_LDF0C + 6,X		; Get looked-up parameter from table

; Convert &F2/3,A to XY, put Y in A
_LE00D:		clc	
		adc	$F2
		tax	
		tya			; Pass supplied Y into A
		ldy	$F3
		bcc	_BE017
		iny	
;   	
_BE017:		rts	


; *BASIC
; ======
		ldx	$024b		; Get BASIC ROM number
		bmi	_BE021		; If none set, jump to pass command on
		sec			; Set Carry = not entering from RESET
		jmp	_LDBE7		; Enter language rom in X

; Pass command on to other ROMs and to filing system
_BE021:		ldy	$E6		; Restore pointer to start of command
		ldx	#$04		; 4=UnknownCommand
		jsr	_LF168		; Pass to sideways ROMs
		beq	_BE017		; If claimed, exit
		lda	$E6		; Restore pointer to start of command
		jsr	_LE00D		; Convert &F2/3,A to XY, ignore returned A
		lda	#$03		; 3=PassCommandToFilingSystem

; Pass to current filing system
_LE031:		jmp	($021e)

		asl	A
		and	#$01
		bpl	_LE031

; Skip spaces
_LE039:		iny	
_LE03A:		lda	($F2),Y
		cmp	#$20
		beq	_LE039
_BE040:		cmp	#$0D
		rts	

_LE043:		bcc	_LE03A
_LE045:		jsr	_LE03A
		cmp	#$2C
		bne	_BE040
		iny	
		rts	

_LE04E:		jsr	_LE03A
		jsr	_LE07D
		bcc	_BE08D
_BE056:		sta	$E6
		jsr	_LE07C
		bcc	_BE076
		tax	
		lda	$E6
		asl	A
		bcs	_BE08D
		asl	A
		bcs	_BE08D
		adc	$E6
		bcs	_BE08D
		asl	A
		bcs	_BE08D
		sta	$E6
		txa	
		adc	$E6
		bcs	_BE08D
		bcc	_BE056
_BE076:		ldx	$E6
		cmp	#$0D
		sec	
		rts	

_LE07C:		iny	
_LE07D:		lda	($F2),Y
		cmp	#$3A
		bcs	_BE08D
		cmp	#$30
		bcc	_BE08D
		and	#$0F
		rts	

_BE08A:		jsr	_LE045
_BE08D:		clc	
		rts	

_LE08F:		jsr	_LE07D
		bcs	_BE0A2
		and	#$DF
		cmp	#$47
		bcs	_BE08A
		cmp	#$41
		bcc	_BE08A
		php	
		sbc	#$37
		plp	
_BE0A2:		iny	
		rts	

; WRCH control routine
; ====================
_LE0A4:		pha			; Save all registers
		txa	
		pha	
		tya	
		pha	
		tsx	
		lda	$0103,X		; Get A back from stack
		pha			; Save A
		bit	$0260		; Check OSWRCH interception flag
		bpl	_BE0BB		; Not set, skip interception call
		tay			; Pass character to Y
		lda	#$04		; A=4 for OSWRCH call
		jsr	_LE57E		; Call interception code
		bcs	_BE10D		; If claimed, jump past to exit

_BE0BB:		clc			; Prepare to not send this to printer
		lda	#$02		; Check output destination
		bit	$027c		; Is VDU driver disabled?
		bne	_BE0C8		; Yes, skip past VDU driver
		pla			; Get character back
		pha			; Resave character
		jsr	_LC4C0		; Call VDU driver
					;  On exit, C=1 if character to be sent to printer

_BE0C8:		lda	#$08		; Check output destination
		bit	$027c		; Is printer seperately enabled?
		bne	_BE0D1		; Yes, jump to call printer driver
		bcc	_BE0D6		; Carry clear, don't sent to printer
_BE0D1:		pla			; Get character back
		pha			; Resave character
		jsr	_LE114		; Call printer driver

_BE0D6:		lda	$027c		; Check output destination
		ror	A		; Is serial output enabled?
		bcc	_BE0F7		; No, skip past serial output
		ldy	$EA		; Get serial timout counter
		dey			; Decrease counter
		bpl	_BE0F7		; Timed out, skip past serial code
		pla			; Get character back
		pha			; Resave character
		php			; Save IRQs
		sei			; Disable IRQs
		ldx	#$02		; X=2 for serial output buffer
		pha			; Save character
		jsr	_LE45B		; Examine serial output buffer
		bcc	_BE0F0		; Buffer not full, jump to send character
		jsr	_LE170		; Wait for buffer to empty a bit
_BE0F0:		pla			; Get character back
		ldx	#$02		; X=2 for serial output buffer
		jsr	_LE1F8		; Send character to serial output buffer
		plp			; Restore IRQs

_BE0F7:		lda	#$10		; Check output destination
		bit	$027c		; Is SPOOL output disabled?
		bne	_BE10D		; Yes, skip past SPOOL output
		ldy	$0257		; Get SPOOL handle
		beq	_BE10D		; If not open, skip past SPOOL output
		pla			; Get character back
		pha			; Resave character
		sec	
		ror	$EB		; Set RFS/CFS's 'spooling' flag
		jsr	_LFFD4		; Write character to SPOOL channel
		lsr	$EB		; Reset RFS/CFS's 'spooling' flag

_BE10D:		pla			; Restore all registers
		pla	
		tay	
		pla	
		tax	
		pla	
		rts			; Exit


;*************************************************************************
;*                                                                       *
;*       PRINTER DRIVER                                                  *
;*                                                                       *
;*************************************************************************

;A=character to print

_LE114:		bit	$027c		; if bit 6 of VDU byte =1 printer is disabled
		bvs	_BE139		; so E139

		cmp	$0286		; compare with printer ignore character
		beq	_BE139		; if the same E139

_LE11E:		php			; else save flags
		sei			; bar interrupts
		tax			; X=A
		lda	#$04		; A=4
		bit	$027c		; read bit 2 'disable printer driver'
		bne	_BE138		; if set printer is disabled so exit E138
		txa			; else A=X
		ldx	#$03		; X=3
		jsr	_LE1F8		; and put character in printer buffer
		bcs	_BE138		; if carry set on return exit, buffer not full (empty?)

		bit	$02d2		; else check buffer busy flag if 0
		bpl	_BE138		; then E138 to exit
		jsr	_LE13A		; else E13A to open printer cahnnel

_BE138:		plp			; get back flags
_BE139:		rts			; and exit

_LE13A:		lda	$0285		; check printer destination
		beq	_BE1AD		; if 0 then E1AD clear printer buffer and exit
		cmp	#$01		; if parallel printer not selected
		bne	_BE164		; E164
		jsr	_LE460		; else read a byte from the printer buffer
		ror	$02d2		; if carry is set then 2d2 is -ve
		bmi	_BE190		; so return via E190
		ldy	#$82		; else enable interrupt 1 of the external VIA
		sty	$fe6e		; 
		sta	$fe61		; pass code to centronics port
		lda	$fe6c		; pulse CA2 line to generate STROBE signal
		and	#$F1		; to advise printer that
		ora	#$0C		; valid data is
		sta	$fe6c		; waiting
		ora	#$0E		; 
		sta	$fe6c		; 
		bne	_BE190		; then exit

;*********:serial printer *********************************************

_BE164:		cmp	#$02		; is it Serial printer??
		bne	_BE191		; if not E191
		ldy	$EA		; else is RS423 in use by cassette??
		dey			; 
		bpl	_BE1AD		; if so E1AD to flush buffer

		lsr	$02d2		; else clear buffer busy flag
_LE170:		lsr	$024f		; and RS423 busy flag
_LE173:		jsr	_LE741		; count buffer if C is clear on return
		bcc	_BE190		; no room in buffer so exit
		ldx	#$20		; else
_LE17A:		ldy	#$9F		; 


;*************************************************************************
;*                                                                       *
;*       OSBYTE 156 update ACIA setting and RAM copy                     *
;*                                                                       *
;*************************************************************************
;on entry

		php			; push flags
		sei			; bar interrupts
		tya			; A=Y
		stx	$FA		; &FA=X
		and	$0250		; A=old value AND Y EOR X
		eor	$FA		; 
		ldx	$0250		; get old value in X
_LE189:		sta	$0250		; put new value in
		sta	$fe08		; and store to ACIA control register
		plp			; get back flags
_BE190:		rts			; and exit

;************ printer is neither serial or parallel so its user type *****

_BE191:		clc			; clear carry
		lda	#$01		; A=1
		jsr	_LE1A2		; 


;*************************************************************************
;*                                                                       *
;*       OSBYTE 123 Warn printer driver going dormant                    *
;*                                                                       *
;*************************************************************************

		ror	$02d2		; mark printer buffer empty for osbyte
_BE19A:		rts			; and exit

_LE19B:		bit	$02d2		; if bit 7 is set buffer is empty
		bmi	_BE19A		; so exit

		lda	#$00		; else A=0

_LE1A2:		ldx	#$03		; X=3
_LE1A4:		ldy	$0285		; Y=printer destination
		jsr	_LE57E		; to JMP (NETV)
		jmp	($0222)		; jump to PRINT VECTOR for special routines

;*************** Buffer handling *****************************************
		; X=buffer number
		; Buffer number  Address         Flag    Out pointer     In pointer
		; 0=Keyboard     3E0-3FF         2CF     2D8             2E1
		; 1=RS423 Input  A00-AFF         2D0     2D9             2E2
		; 2=RS423 output 900-9BF         2D1     2DA             2E3
		; 3=printer      880-8BF         2D2     2DB             2E4
		; 4=sound0       840-84F         2D3     2DC             2E5
		; 5=sound1       850-85F         2D4     2DD             2E6
		; 6=sound2       860-86F         2D5     2DE             2E7
		; 7=sound3       870-87F         2D6     2DF             2E8
		; 8=speech       8C0-8FF         2D7     2E0             2E9

_BE1AD:		clc			; clear carry
_LE1AE:		pha			; save A
		php			; save flags
		sei			; set interrupts
		bcs	_BE1BB		; if carry set on entry then E1BB
		lda	_LE9AD,X		; else get byte from baud rate/sound data table
		bpl	_BE1BB		; if +ve the E1BB
		jsr	_LECA2		; else clear sound data

_BE1BB:		sec			; set carry
		ror	$02cf,X		; rotate buffer flag to show buffer empty
		cpx	#$02		; if X>1 then its not an input buffer
		bcs	_BE1CB		; so E1CB

		lda	#$00		; else Input buffer so A=0
		sta	$0268		; store as length of key string
		sta	$026a		; and length of VDU queque
_BE1CB:		jsr	_LE73B		; then enter via count purge vector any user routines
		plp			; restore flags
		pla			; restore A
		rts			; and exit


;*************************************************************************
;*                                                                       *
;*       COUNT PURGE VECTOR      DEFAULT ENTRY                           *
;*                                                                       *
;*************************************************************************
;on entry if V set clear buffer
;   	  if C set get space left
;   	  else get bytes used

_LE1D1:		bvc	_BE1DA		; if bit 6 is set then E1DA
		lda	$02d8,X		; else start of buffer=end of buffer
		sta	$02e1,X		; 
		rts			; and exit

_BE1DA:		php			; push flags
		sei			; bar interrupts
		php			; push flags
		sec			; set carry
		lda	$02e1,X		; get end of buffer
		sbc	$02d8,X		; subtract start of buffer
		bcs	_BE1EA		; if carry caused E1EA
		sec			; set carry
		sbc	_LE447,X		; subtract buffer start offset (i.e. add buffer length)
_BE1EA:		plp			; pull flags
		bcc	_BE1F3		; if carry clear E1F3 to exit
		clc			; clear carry
		adc	_LE447,X		; adc to get bytes used
		eor	#$FF		; and invert to get space left
_BE1F3:		ldy	#$00		; Y=0
		tax			; X=A
		plp			; get back flags
		rts			; and exit

;********** enter byte in buffer, wait and flash lights if full **********

_LE1F8:		sei			; prevent interrupts
		jsr	_LE4B0		; enter a byte in buffer X
		bcc	_BE20D		; if successful exit
		jsr	_LE9EA		; else switch on both keyboard lights
		php			; push p
		pha			; push A
		jsr	_LEEEB		; switch off unselected LEDs
		pla			; get back A
		plp			; and flags
		bmi	_BE20D		; if return is -ve Escape pressed so exit
		cli			; else allow interrupts
		bcs	_LE1F8		; if byte didn't enter buffer go and try it again
_BE20D:		rts			; then return

