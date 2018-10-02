;OS SERIES 8
;GEOFF COX

;*************************************************************************
;*                                                                       *
;*        OSBYTE &F7 (247) INTERCEPT BREAK                               *
;*                                                                       *
;*************************************************************************

.org		$ead9

		lda	$0287		; get BREAK vector code
		eor	#$4C		; produces 0 if JMP not in &287
		bne	$EAF3		; if not goto EAF3
		jmp	$0287		; else jump to user BREAK code


;*************************************************************************
;*                                                                       *
;*        OSBYTE &90 (144)   *TV                                         *
;*                                                                       *
;*************************************************************************

		; X=display delay
		; Y=interlace flag

		lda	$0290		; VDU vertical adjustment
		stx	$0290		; store new value
		tax			; put old value in X
		tya			; put interlace flag in A
		and	#$01		; maximum value =1
		ldy	$0291		; get old value into Y
		sta	$0291		; put new value into A
		rts			; and Exit


;*************************************************************************
;*                                                                       *
;*        OSBYTE &93 (147)  WRITE TO FRED                                *
;*                                                                       *
;*************************************************************************
		; X is offset within page
		; Y is byte to write
		tya			; 
		sta	$FC00,X		; 
		rts			; 


;*************************************************************************
;*                                                                       *
;*        OSBYTE &95 (149)  WRITE TO JIM                                 *
;*                                                                       *
;*************************************************************************
		; X is offset within page
		; Y is byte to write
		; 
		tya			; 
		sta	$FD00,X		; 
		rts			; 


;*************************************************************************
;*                                                                       *
;*        OSBYTE &97 (151)  WRITE TO SHEILA                              *
;*                                                                       *
;*************************************************************************
		; X is offset within page
		; Y is byte to write
		; 
		tya			; 
		sta	$FE00,X		; 
		rts			; 

;****************** Silence a sound channel *******************************
		; X=channel number

		lda	#$04		; mark end of release phase
		sta	$0808,X		; to channel X
		lda	#$C0		; load code for zero volume

;****** if sound not disabled set sound generator volume ******************

		sta	$0804,X		; store A to give basic sound level of Zero
		ldy	$0262		; get sound output/enable flag
		beq	$EB14		; if sound enabled goto EB14
		lda	#$C0		; else load zero sound code
		sec			; set carry
		sbc	#$40		; subtract &40
		lsr			; divide by 8
		lsr			; to get into bits 0 - 3
		lsr			; 
		eor	#$0F		; invert bits 0-3
		ora	$EB3C,X		; get channel number into top nybble
		ora	#$10		; 

		php			; 

		sei			; disable interrupts
		ldy	#$FF		; System VIA port A all outputs
		sty	$FE43		; set
		sta	$FE4F		; output A on port A
		iny			; Y=0
		sty	$FE40		; enable sound chip
		ldy	#$02		; set and
		dey			; execute short delay
		bne	$EB31		; 
		ldy	#$08		; then disable sound chip again
		sty	$FE40		; 
		ldy	#$04		; set delay
		dey			; and loop delay
		bne	$EB3B		; 
		plp			; get back flags
		rts			; and exit

;*******: Sound parameters look up table **********************************

		.byte	$E0,$C0,$A0,$80

		jmp	$EC59		; just to allow relative branches in early part
					; of sound interrupt routine


;*************************************************************************
;*                                                                       *
;*       PROCESS SOUND INTERRUPT                                         *
;*                                                                       *
;*************************************************************************

		lda	#$00		; 
		sta	$083B		; zero number of channels on hold for sync
		lda	$0838		; get number of channels required for sync
		bne	$EB57		; if this <>0 then EB57
		inc	$083B		; else number of chanels on hold for sync =1
		dec	$0838		; number of channels required for sync =255

		ldx	#$08		; set loop counter
		dex			; loop
		lda	$0800,X		; get value of &800 +offset (sound queue occupancy)
		beq	$EB44		; if 0 goto EC59 no sound this channel
		lda	$02CF,X		; else get buffer busy flag
		bmi	$EB69		; if negative (buffer empty) goto EB69
		lda	$0818,X		; else if duration count not zer0
		bne	$EB6C		; goto EB6C
		jsr	$EC6B		; check and pick up new sound if required
		lda	$0818,X		; if duration count 0
		beq	$EB84		; goto EB84
		cmp	#$FF		; else if it is &FF (infinite duration)
		beq	$EB87		; go onto EB87
		dec	$081C,X		; decrement 10 mS count
		bne	$EB87		; and if 0
		lda	#$05		; reset to 5
		sta	$081C,X		; to give 50 mSec delay
		dec	$0818,X		; and decrement main counter
		bne	$EB87		; if not zero then EB87
		jsr	$EC6B		; else check and get nw sound
		lda	$0824,X		; if step progress counter is 0 no envelope involved
		beq	$EB91		; so jump to EB91
		dec	$0824,X		; else decrement it
		bne	$EB44		; and if not zero go on to EC59
		ldy	$0820,X		; get  envelope data offset from (8C0)
		cpy	#$FF		; if 255 no envelope set so
		beq	$EB44		; goto EC59
		lda	$08C0,Y		; else get get step length
		and	#$7F		; zero repeat bit
		sta	$0824,X		; and store it
		lda	$0808,X		; get phase counter
		cmp	#$04		; if release phase completed
		beq	$EC07		; goto EC07
		lda	$0808,X		; else start new step by getting phase
		clc			; 
		adc	$0820,X		; add it to interval multiplier
		tay			; transfer to Y
		lda	$08CB,Y		; and get target value base for envelope
		sec			; 
		sbc	#$3F		; 
		sta	$083A		; store modified number as current target amplitude
		lda	$08C7,Y		; get byte from envelope store
		sta	$0839		; store as current amplitude step
		lda	$0804,X		; get base volumelevel
		pha			; save it
		clc			; clear carry
		adc	$0839		; add to current amplitude step
		bvc	$EBCF		; if no overflow
		rol			; double it Carry = bit 7
		lda	#$3F		; if bit =1 A=&3F
		bcs	$EBCF		; into &EBCF
		eor	#$FF		; else toggle bits (A=&C0)

		; at this point the BASIC volume commands are converted
		;  &C0 (0) to &38 (-15) 3 times, In fact last 3 bits
		; are ignored so &3F represents -15

		sta	$0804,X		; store in current volume
		rol			; multiply by 2
		eor	$0804,X		; if bits 6 and 7 are equal
		bpl	$EBE1		; goto &EBE1
		lda	#$3F		; if carry clear A=&3F (maximum)
		bcc	$EBDE		; or
		eor	#$FF		; &C0 minimum

		sta	$0804,X		; and this is stored in current volume

		dec	$0839		; decrement amplitude change per step
		lda	$0804,X		; get volume again
		sec			; set carry
		sbc	$083A		; subtract target value
		eor	$0839		; negative value undicates correct trend
		bmi	$EBF9		; so jump to next part
		lda	$083A		; else enter new phase
		sta	$0804,X		; 
		inc	$0808,X		; 

		pla			; get the old volume level
		eor	$0804,X		; and compare with the old
		and	#$F8		; 
		beq	$EC07		; if they are the same goto EC07
		lda	$0804,X		; else set new level
		jsr	$EB0A		; via EB0A
		lda	$0810,X		; get absolute pitch value
		cmp	#$03		; if it =3
		beq	$EC59		; skip rest of loop as all sections are finished
		lda	$0814,X		; else if 814,X is not 0 current section is not
					; complete
		bne	$EC3D		; so EC3D
		inc	$0810,X		; else implement a section change
		lda	$0810,X		; check if its complete
		cmp	#$03		; if not
		bne	$EC2D		; goto EC2D
		ldy	$0820,X		; else set A from
		lda	$08C0,Y		; &820 and &8C0 (first envelope byte)
		bmi	$EC59		; if negative there is no repeat
		lda	#$00		; else restart section sequence
		sta	$0830,X		; 
		sta	$0810,X		; 

		lda	$0810,X		; get number of steps in new section
		clc			; 
		adc	$0820,X		; 
		tay			; 
		lda	$08C4,Y		; 
		sta	$0814,X		; set in 814+X
		beq	$EC59		; and if 0 then EC59

		dec	$0814,X		; decrement
		lda	$0820,X		; and pick up rate of pitch change
		clc			; 
		adc	$0810,X		; 
		tay			; 
		lda	$08C1,Y		; 
		clc			; 
		adc	$0830,X		; add to rate of differential pitch change
		sta	$0830,X		; and save it
		clc			; 
		adc	$080C,X		; ad to base pitch
		jsr	$ED01		; and set new pitch

		cpx	#$04		; if X=4 (last channel)
		beq	$EC6A		; goto EC6A (RTS)
		jmp	$EB59		; else do loop again

		ldx	#$08		; X=7 again
		dex			; loop
		jsr	$ECA2		; clear channel
		cpx	#$04		; if not 4
		bne	$EC62		; do it again
		rts			; and return
					; 
		lda	$0808,X		; check for last channel
		cmp	#$04		; is it 4 (release complete)
		beq	$EC77		; if so EC77
		lda	#$03		; else mark release in progress
		sta	$0808,X		; and store it
		lda	$02CF,X		; is buffer not empty
		beq	$EC90		; if so EC90
		lda	#$00		; else mark buffer not empty
		sta	$02CF,X		; an store it

		ldy	#$04		; loop counter
		sta	$082B,Y		; zero sync bytes
		dey			; 
		bne	$EC83		; until Y=0

		sta	$0818,X		; zero duration count
		dey			; and set sync count to
		sty	$0838		; &FF
		lda	$0828,X		; get synchronising flag
		beq	$ECDB		; if its 0 then ECDB
		lda	$083B		; else get number of channels on hold
		beq	$ECD0		; if 0 then ECD0
		lda	#$00		; else
		sta	$0828,X		; zero note length interval
		jmp	$ED98		; and goto ED98

		jsr	$EB03		; silence the channel
		tya			; Y=0 A=Y
		sta	$0818,X		; zero main count
		sta	$02CF,X		; mark buffer not empty
		sta	$0800,X		; mark channel dormant
		ldy	#$03		; loop counter
		sta	$082C,Y		; zero sync flags
		dey			; 
		bpl	$ECB1		; 

		sty	$0838		; number of channels to &FF
		bmi	$ED06		; jump to ED06 ALWAYS

		php			; save flags
		sei			; and disable interrupts
		lda	$0808,X		; check for end of release
		cmp	#$04		; 
		bne	$ECCF		; and if not found ECCF
		jsr	$E45B		; elseexamine buffer
		bcc	$ECCF		; if not empty ECCF
		lda	#$00		; else mark channel dormant
		sta	$0800,X		; 
		plp			; get back flags

		ldy	$0820,X		; if no envelope 820=&FF
		cpy	#$FF		; 
		bne	$ECDA		; then terminate sound
		jsr	$EB03		; via EB03
		rts			; else return

;************ Synchronise sound routines **********************************

		jsr	$E45B		; examine buffer if empty carry set
		bcs	$ECBC		; 
		and	#$03		; else examine next word if>3 or 0
		beq	$EC9F		; goto ED98 (via EC9F)
		lda	$0838		; else get synchronising count
		beq	$ECFE		; in 0 (complete) goto ECFE
		inc	$0828,X		; else set sync flag
		bit	$0838		; if 0838 is +ve S has already been set so
		bpl	$ECFB		; jump to ECFB
		jsr	$E45B		; else get first byte
		and	#$03		; mask bits 0,1
		sta	$0838		; and store result
		bpl	$ECFE		; Jump to ECFE (ALWAYS!!)

		dec	$0838		; decrement 0838
		jmp	$ECD0		; and silence the channel if envelope not in use

;************ Pitch setting ***********************************************

		cmp	$082C,X		; If A=&82C,X then pitch is unchanged
		beq	$ECDA		; then exit via ECDA
		sta	$082C,X		; store new pitch
		cpx	#$04		; if X<>4 then not noise so
		bne	$ED16		; jump to ED16

;*********** Noise setting ************************************************

		and	#$0F		; convert to chip format
		ora	$EB3C,X		; 
		php			; save flags
		jmp	$ED95		; and pass to chip control routine at EB22 via ED95

		pha			; 
		and	#$03		; 
		sta	$083C		; lose eigth tone surplus
		lda	#$00		; 
		sta	$083D		; 
		pla			; get back A
		lsr			; divide by 12
		lsr			; 
		cmp	#$0C		; 
		bcc	$ED2F		; 
		inc	$083D		; store result
		sbc	#$0C		; with remainder in A
		bne	$ED24		; 
					; at this point 83D defines the Octave
					; A the semitone within the octave
		tay			; Y=A
		lda	$083D		; get octave number into A
		pha			; push it
		lda	$EDFB,Y		; get byte from look up table
		sta	$083D		; store it
		lda	$EE07,Y		; get byte from second table
		pha			; push it
		and	#$03		; keep two LS bits only
		sta	$083E		; save them
		pla			; pull second table byte
		lsr			; push hi nybble into lo nybble
		lsr			; 
		lsr			; 
		lsr			; 
		sta	$083F		; store it
		lda	$083D		; get back octave number
		ldy	$083C		; adjust for surplus eighth tones
		beq	$ED5F		; 
		sec			; 
		sbc	$083F		; 
		bcs	$ED5C		; 
		dec	$083E		; 
		dey			; 
		bne	$ED53		; 
		sta	$083D		; 
		pla			; 
		tay			; 
		beq	$ED6F		; 
		lsr	$083E		; 
		ror	$083D		; 
		dey			; 
		bne	$ED66		; 
		lda	$083D		; 
		clc			; 
		adc	$C43D,X		; 
		sta	$083D		; 
		bcc	$ED7E		; 
		inc	$083E		; 
		and	#$0F		; 
		ora	$EB3C,X		; 
		php			; push P
		sei			; bar interrupts
		jsr	$EB21		; set up chip access 1
		lda	$083D		; 
		lsr	$083E		; 
		ror			; 
		lsr	$083E		; 
		ror			; 
		lsr			; 
		lsr			; 
		jmp	$EB22		; set up chip access 2 and return

;**************** Pick up and interpret sound buffer data *****************

		php			; push flags
		sei			; disable interrupts
		jsr	$E460		; read a byte from buffer
		pha			; push A
		and	#$04		; isolate H bit
		beq	$EDB7		; if 0 then EDB7
		pla			; get back A
		ldy	$0820,X		; if &820,X=&FF
		cpy	#$FF		; envelope is not in use
		bne	$EDAD		; 
		jsr	$EB03		; so call EB03 to silence channel

		jsr	$E460		; clear buffer of redundant data
		jsr	$E460		; and again
		plp			; get back flags
		jmp	$EDF7		; set main duration count using last byte from buffer

		pla			; get back A
		and	#$F8		; zero bits 0-2
		asl			; put bit 7 into carry
		bcc	$EDC8		; if zero (envelope) jump to EDC8
		eor	#$FF		; invert A
		lsr			; shift right
		sec			; 
		sbc	#$40		; subtract &40
		jsr	$EB0A		; and set volume
		lda	#$FF		; A=&FF

		sta	$0820,X		; get envelope no.-1 *16 into A
		lda	#$05		; set duration sub-counter
		sta	$081C,X		; 
		lda	#$01		; set phase counter
		sta	$0824,X		; 
		lda	#$00		; set step counter
		sta	$0814,X		; 
		sta	$0808,X		; and envelope phase
		sta	$0830,X		; and pitch differential
		lda	#$FF		; 
		sta	$0810,X		; set step count
		jsr	$E460		; read pitch
		sta	$080C,X		; set it
		jsr	$E460		; read buffer
		plp			; 
		pha			; save duration
		lda	$080C,X		; get back pitch value
		jsr	$ED01		; and set it
		pla			; get back duration
		sta	$0818,X		; set it
		rts			; and return

;********************* Pitch look up table 1*****************************
		.byte	$F0
		.byte	$B7
		.byte	$82
		.byte	$4F
		.byte	$20
		.byte	$F3
		.byte	$C8
		.byte	$A0
		.byte	$7B
		.byte	$57
		.byte	$35
		.byte	$16

;********************* Pitch look up table 2 *****************************

		.byte	$E7
		.byte	$D7
		.byte	$CB
		.byte	$C3
		.byte	$B7
		.byte	$AA
		.byte	$A2
		.byte	$9A
		.byte	$92
		.byte	$8A
		.byte	$82
		.byte	$7A

;*********: set current filing system ROM/PHROM **************************
		lda	#$EF		; get ROM
		sta	$F5		; store it
		rts			; return

;********** Get byte from data ROM ***************************************

		ldx	#$0D		; X=13
		inc	$F5		; 
		ldy	$F5		; get Rom
		bpl	$EE59		; if +ve it's a sideways ROM else it's a PHROM
		ldx	#$00		; PHROM
		stx	$F7		; set address pointer in PHROM
		inx			; 
		stx	$F6		; to 0001
		jsr	$EEBB		; pass info to speech processor
		ldx	#$03		; X=3

		jsr	$EE62		; check for speech processor and output until
					; it reports, read byte from ROM
		cmp	$DF0C,X		; if A<> DF0C+X then EE18 (DF0C = (C))
		bne	$EE18		; 
		dex			; else decrement X
		bpl	$EE2C		; and do it again
		lda	#$3E		; 
		sta	$F6		; get noe lo byte address
		jsr	$EEBB		; pass info to speech processor
		ldx	#$FF		; 
		jsr	$EE62		; check for speech proc. etc.
		ldy	#$08		; 
		asl			; 
		ror	$F7,X		; 
		dey			; 
		bne	$EE45		; 
		inx			; 
		beq	$EE40		; 
		clc			; 
		bcc	$EEBB		; 

;************ ROM SERVICE ************************************************

		ldx	#$0E		; 
		ldy	$F5		; if Y is negative (PHROM)
		bmi	$EE62		; GOTO EE62
		ldy	#$FF		; else Y=255
		php			; push flags
		jsr	$F168		; offer paged rom service
		plp			; pull processor flags
		cmp	#$01		; if A>0  set carry
		tya			; A=Y
		rts			; return

;********* PHROM SERVICE *************************************************
		; 
		php			; push processor flags
		sei			; disable interrupts
		ldy	#$10		; Y=16
		jsr	$EE7F		; call EE7F (osbyte 159 write to speech processor
		ldy	#$00		; Y=0
		beq	$EE84		; Jump to EE84 (ALWAYS!!)


;*************************************************************************
;*                                                                       *
;*       OSBYTE 158 read from speech processor                           *
;*                                                                       *
;*************************************************************************

		ldy	#$00		; Y=0 to set speech proc to read
		beq	$EE82		; jump to EE82 always

		; write A to speech processor as two nybbles

		pha			; push A
		jsr	$EE7A		; to write to speech processor
		pla			; get back A
		ror			; bring upper nybble to lower nybble
		ror			; by rotate right
		ror			; 4 times
		ror			; 

		and	#$0F		; Y=lo nybble A +&40
		ora	#$40		; 
		tay			; forming command for speech processor


;*************************************************************************
;*                                                                       *
;*       OSBYTE 159 Write to speech processor                            *
;*                                                                       *
;*************************************************************************
;       on entry data or command in Y

		tya			; transfer command to A
		ldy	#$01		; to set speech proc to write

		; if Y=0 read speech processor
		; if Y=1 write speech processor

		php			; push flags
		sei			; disable interrupts
		bit	$027B		; test for prescence of speech processor
		bpl	$EEAA		; if not there goto EEAA
		pha			; else push A
		lda	$F075,Y		; 
		sta	$FE43		; set DDRA of system VIA to give 8 bit input (Y=0)
					; or 8 bit output (Y=1)
		pla			; get back A
		sta	$FE4F		; and send to speech chip
		lda	$F077,Y		; output Prt B of system VIA
		sta	$FE40		; to select read or write (dependent on Y)
		bit	$FE40		; loop until
		bmi	$EE9A		; speech proceessor reports ready (bit 7 Prt B=0)
		lda	$FE4F		; read speech processor data if  input selected
		pha			; push A
		lda	$F079,Y		; reset speech
		sta	$FE40		; processor
		pla			; get back A

		plp			; get back flags
		tay			; transfer A to Y
		rts			; and exit routine
					; 
		lda	$03CB		; set rom displacement pointer
		sta	$F6		; in &F6
		lda	$03CC		; 
		sta	$F7		; And &F7
		lda	$F5		; if F5 is +ve ROM is selected so
		bpl	$EED9		; goto EED9

		php			; else push processor
		sei			; disable interrupts
		lda	$F6		; get lo displacement
		jsr	$EE71		; pass two nyblles to speech proc.
		lda	$F5		; &FA=&F5
		sta	$FA		; 
		lda	$F7		; get hi displacement value
		rol			; replace two most significant bits of A
		rol			; by 2 LSBs of &FA
		lsr	$FA		; 
		ror			; 
		lsr	$FA		; 
		ror			; 
		jsr	$EE71		; pass two nybbles to speech processor
		lda	$FA		; FA has now been divided by 4 so pass
		jsr	$EE7A		; lower nybble to speech proc.
		plp			; get back flags
		rts			; and Return


