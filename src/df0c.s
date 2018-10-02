;**** STRINGS ****

.org		$df0c

		.byte	")C(",0		; Copyright string match

;**** COMMMANDS ****
;				  Command    Address       Call goes to
		.byte	".",$e0,$31,$05		; *.        &E031, A=5     FSCV, XY=>String
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
		stx	$F2		; Store XY in &F2/3
		sty	$F3
		lda	#$08
		jsr	$E031		; Inform filing system CLI being processed
		ldy	#$00		; Check the line is correctly terminated
		lda	($F2),Y
		cmp	#$0D		; Loop until CR is found
		beq	$DF9E
		iny			; Move to next character
		bne	$DF94		; Loop back if less than 256 bytes long
		rts			; Exit if string > 255 characters

; String is terminated - skip prepended spaces and '*'s
		ldy	#$FF
		jsr	$E039		; Skip any spaces
		beq	$E017		; Exit if at CR
		cmp	#$2A		; Is this character '*'?
		beq	$DFA0		; Loop back to skip it, and check for spaces again

		jsr	$E03A		; Skip any more spaces
		beq	$E017		; Exit if at CR
		cmp	#$7C		; Is it '|' - a comment
		beq	$E017		; Exit if so
		cmp	#$2F		; Is it '/' - pass straight to filing system
		bne	$DFBE		; Jump forward if not
		iny			; Move past the '/'
		jsr	$E009		; Convert &F2/3,Y->XY, ignore returned A
		lda	#$02		; 2=RunSlashCommand
		bne	$E031		; Jump to pass to FSCV
;
; Look command up in command table
		sty	$E6		; Store offset to start of command
		ldx	#$00
		beq	$DFD7
;   	
		eor	$DF10,X
		and	#$DF
		bne	$DFE2
		iny	
		clc	
;   	
		bcs	$DFF4
		inx	
		lda	($F2),Y
		jsr	$E4E3
		bcc	$DFC4
;   	
		lda	$DF10,X
		bmi	$DFF2
		lda	($F2),Y
		cmp	#$2E
		beq	$DFE6
		clc	
		ldy	$E6
		dey	
		iny	
		inx	
		inx	
		lda	$DF0E,X
		beq	$E021
		bpl	$DFE8
		bmi	$DFCD
;   	
		inx	
		inx	
;   	
		dex	
		dex	
		pha	
		lda	$DF11,X
		pha	
		jsr	$E03A
		clc	
		php	
		jsr	$E004
		rti			; Jump to routine

		lda	$DF12,X		; Get table parameter
		bmi	$E017		; If >=&80, number follow
;                      ; else string follows

		tya			; Pass Y line offset to A for later
		ldy	$DF12,X		; Get looked-up parameter from table

; Convert &F2/3,A to XY, put Y in A
		clc	
		adc	$F2
		tax	
		tya			; Pass supplied Y into A
		ldy	$F3
		bcc	$E017
		iny	
;   	
		rts	


; *BASIC
; ======
		ldx	$024B		; Get BASIC ROM number
		bmi	$E021		; If none set, jump to pass command on
		sec			; Set Carry = not entering from RESET
		jmp	$DBE7		; Enter language rom in X

; Pass command on to other ROMs and to filing system
		ldy	$E6		; Restore pointer to start of command
		ldx	#$04		; 4=UnknownCommand
		jsr	$F168		; Pass to sideways ROMs
		beq	$E017		; If claimed, exit
		lda	$E6		; Restore pointer to start of command
		jsr	$E00D		; Convert &F2/3,A to XY, ignore returned A
		lda	#$03		; 3=PassCommandToFilingSystem

; Pass to current filing system
		jmp	($021E)

		asl	A
		and	#$01
		bpl	$E031

; Skip spaces
		iny	
		lda	($F2),Y
		cmp	#$20
		beq	$E039
		cmp	#$0D
		rts	

		bcc	$E03A
		jsr	$E03A
		cmp	#$2C
		bne	$E040
		iny	
		rts	

		jsr	$E03A
		jsr	$E07D
		bcc	$E08D
		sta	$E6
		jsr	$E07C
		bcc	$E076
		tax	
		lda	$E6
		asl	A
		bcs	$E08D
		asl	A
		bcs	$E08D
		adc	$E6
		bcs	$E08D
		asl	A
		bcs	$E08D
		sta	$E6
		txa	
		adc	$E6
		bcs	$E08D
		bcc	$E056
		ldx	$E6
		cmp	#$0D
		sec	
		rts	

		iny	
		lda	($F2),Y
		cmp	#$3A
		bcs	$E08D
		cmp	#$30
		bcc	$E08D
		and	#$0F
		rts	

		jsr	$E045
		clc	
		rts	

		jsr	$E07D
		bcs	$E0A2
		and	#$DF
		cmp	#$47
		bcs	$E08A
		cmp	#$41
		bcc	$E08A
		php	
		sbc	#$37
		plp	
		iny	
		rts	

; WRCH control routine
; ====================
		pha			; Save all registers
		txa	
		pha	
		tya	
		pha	
		tsx	
		lda	$0103,X		; Get A back from stack
		pha			; Save A
		bit	$0260		; Check OSWRCH interception flag
		bpl	$E0BB		; Not set, skip interception call
		tay			; Pass character to Y
		lda	#$04		; A=4 for OSWRCH call
		jsr	$E57E		; Call interception code
		bcs	$E10D		; If claimed, jump past to exit

		clc			; Prepare to not send this to printer
		lda	#$02		; Check output destination
		bit	$027C		; Is VDU driver disabled?
		bne	$E0C8		; Yes, skip past VDU driver
		pla			; Get character back
		pha			; Resave character
		jsr	$C4C0		; Call VDU driver
					;  On exit, C=1 if character to be sent to printer

		lda	#$08		; Check output destination
		bit	$027C		; Is printer seperately enabled?
		bne	$E0D1		; Yes, jump to call printer driver
		bcc	$E0D6		; Carry clear, don't sent to printer
		pla			; Get character back
		pha			; Resave character
		jsr	$E114		; Call printer driver

		lda	$027C		; Check output destination
		ror	A		; Is serial output enabled?
		bcc	$E0F7		; No, skip past serial output
		ldy	$EA		; Get serial timout counter
		dey			; Decrease counter
		bpl	$E0F7		; Timed out, skip past serial code
		pla			; Get character back
		pha			; Resave character
		php			; Save IRQs
		sei			; Disable IRQs
		ldx	#$02		; X=2 for serial output buffer
		pha			; Save character
		jsr	$E45B		; Examine serial output buffer
		bcc	$E0F0		; Buffer not full, jump to send character
		jsr	$E170		; Wait for buffer to empty a bit
		pla			; Get character back
		ldx	#$02		; X=2 for serial output buffer
		jsr	$E1F8		; Send character to serial output buffer
		plp			; Restore IRQs

		lda	#$10		; Check output destination
		bit	$027C		; Is SPOOL output disabled?
		bne	$E10D		; Yes, skip past SPOOL output
		ldy	$0257		; Get SPOOL handle
		beq	$E10D		; If not open, skip past SPOOL output
		pla			; Get character back
		pha			; Resave character
		sec	
		ror	$EB		; Set RFS/CFS's 'spooling' flag
		jsr	$FFD4		; Write character to SPOOL channel
		lsr	$EB		; Reset RFS/CFS's 'spooling' flag

		pla			; Restore all registers
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

		bit	$027C		; if bit 6 of VDU byte =1 printer is disabled
		bvs	$E139		; so E139

		cmp	$0286		; compare with printer ignore character
		beq	$E139		; if the same E139

		php			; else save flags
		sei			; bar interrupts
		tax			; X=A
		lda	#$04		; A=4
		bit	$027C		; read bit 2 'disable printer driver'
		bne	$E138		; if set printer is disabled so exit E138
		txa			; else A=X
		ldx	#$03		; X=3
		jsr	$E1F8		; and put character in printer buffer
		bcs	$E138		; if carry set on return exit, buffer not full (empty?)

		bit	$02D2		; else check buffer busy flag if 0
		bpl	$E138		; then E138 to exit
		jsr	$E13A		; else E13A to open printer cahnnel

		plp			; get back flags
		rts			; and exit

		lda	$0285		; check printer destination
		beq	$E1AD		; if 0 then E1AD clear printer buffer and exit
		cmp	#$01		; if parallel printer not selected
		bne	$E164		; E164
		jsr	$E460		; else read a byte from the printer buffer
		ror	$02D2		; if carry is set then 2d2 is -ve
		bmi	$E190		; so return via E190
		ldy	#$82		; else enable interrupt 1 of the external VIA
		sty	$FE6E		; 
		sta	$FE61		; pass code to centronics port
		lda	$FE6C		; pulse CA2 line to generate STROBE signal
		and	#$F1		; to advise printer that
		ora	#$0C		; valid data is
		sta	$FE6C		; waiting
		ora	#$0E		; 
		sta	$FE6C		; 
		bne	$E190		; then exit

;*********:serial printer *********************************************

		cmp	#$02		; is it Serial printer??
		bne	$E191		; if not E191
		ldy	$EA		; else is RS423 in use by cassette??
		dey			; 
		bpl	$E1AD		; if so E1AD to flush buffer

		lsr	$02D2		; else clear buffer busy flag
		lsr	$024F		; and RS423 busy flag
		jsr	$E741		; count buffer if C is clear on return
		bcc	$E190		; no room in buffer so exit
		ldx	#$20		; else
		ldy	#$9F		; 


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
		sta	$0250		; put new value in
		sta	$FE08		; and store to ACIA control register
		plp			; get back flags
		rts			; and exit

;************ printer is neither serial or parallel so its user type *****

		clc			; clear carry
		lda	#$01		; A=1
		jsr	$E1A2		; 


;*************************************************************************
;*                                                                       *
;*       OSBYTE 123 Warn printer driver going dormant                    *
;*                                                                       *
;*************************************************************************

		ror	$02D2		; mark printer buffer empty for osbyte
		rts			; and exit

		bit	$02D2		; if bit 7 is set buffer is empty
		bmi	$E19A		; so exit

		lda	#$00		; else A=0

		ldx	#$03		; X=3
		ldy	$0285		; Y=printer destination
		jsr	$E57E		; to JMP (NETV)
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

		clc			; clear carry
		pha			; save A
		php			; save flags
		sei			; set interrupts
		bcs	$E1BB		; if carry set on entry then E1BB
		lda	$E9AD,X		; else get byte from baud rate/sound data table
		bpl	$E1BB		; if +ve the E1BB
		jsr	$ECA2		; else clear sound data

		sec			; set carry
		ror	$02CF,X		; rotate buffer flag to show buffer empty
		cpx	#$02		; if X>1 then its not an input buffer
		bcs	$E1CB		; so E1CB

		lda	#$00		; else Input buffer so A=0
		sta	$0268		; store as length of key string
		sta	$026A		; and length of VDU queque
		jsr	$E73B		; then enter via count purge vector any user routines
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

		bvc	$E1DA		; if bit 6 is set then E1DA
		lda	$02D8,X		; else start of buffer=end of buffer
		sta	$02E1,X		; 
		rts			; and exit

		php			; push flags
		sei			; bar interrupts
		php			; push flags
		sec			; set carry
		lda	$02E1,X		; get end of buffer
		sbc	$02D8,X		; subtract start of buffer
		bcs	$E1EA		; if carry caused E1EA
		sec			; set carry
		sbc	$E447,X		; subtract buffer start offset (i.e. add buffer length)
		plp			; pull flags
		bcc	$E1F3		; if carry clear E1F3 to exit
		clc			; clear carry
		adc	$E447,X		; adc to get bytes used
		eor	#$FF		; and invert to get space left
		ldy	#$00		; Y=0
		tax			; X=A
		plp			; get back flags
		rts			; and exit

;********** enter byte in buffer, wait and flash lights if full **********

		sei			; prevent interrupts
		jsr	$E4B0		; enter a byte in buffer X
		bcc	$E20D		; if successful exit
		jsr	$E9EA		; else switch on both keyboard lights
		php			; push p
		pha			; push A
		jsr	$EEEB		; switch off unselected LEDs
		pla			; get back A
		plp			; and flags
		bmi	$E20D		; if return is -ve Escape pressed so exit
		cli			; else allow interrupts
		bcs	$E1F8		; if byte didn't enter buffer go and try it again
		rts			; then return

