;OS SERIES 8
;GEOFF COX

;*************************************************************************
;*                                                                       *
;*        OSBYTE &F7 (247) INTERCEPT BREAK                               *
;*                                                                       *
;*************************************************************************

.org		$ead9

_LEAD9:		lda	$0287		; get BREAK vector code
		eor	#$4C		; produces 0 if JMP not in &287
		bne	_BEAF3		; if not goto EAF3
		jmp	$0287		; else jump to user BREAK code


;*************************************************************************
;*                                                                       *
;*        OSBYTE &90 (144)   *TV                                         *
;*                                                                       *
;*************************************************************************

		; X=display delay
		; Y=interlace flag

_LEAE3:		lda	$0290		; VDU vertical adjustment
		stx	$0290		; store new value
		tax			; put old value in X
		tya			; put interlace flag in A
		and	#$01		; maximum value =1
		ldy	$0291		; get old value into Y
		sta	$0291		; put new value into A
_BEAF3:		rts			; and Exit


;*************************************************************************
;*                                                                       *
;*        OSBYTE &93 (147)  WRITE TO FRED                                *
;*                                                                       *
;*************************************************************************
		; X is offset within page
		; Y is byte to write
_LEAF4:		tya			; 
		sta	$fc00,X		; 
		rts			; 


;*************************************************************************
;*                                                                       *
;*        OSBYTE &95 (149)  WRITE TO JIM                                 *
;*                                                                       *
;*************************************************************************
		; X is offset within page
		; Y is byte to write
		; 
_LEAF9:		tya			; 
		sta	$fd00,X		; 
		rts			; 


;*************************************************************************
;*                                                                       *
;*        OSBYTE &97 (151)  WRITE TO SHEILA                              *
;*                                                                       *
;*************************************************************************
		; X is offset within page
		; Y is byte to write
		; 
_LEAFE:		tya			; 
		sta	$fe00,X		; 
		rts			; 

;****************** Silence a sound channel *******************************
		; X=channel number

_LEB03:		lda	#$04		; mark end of release phase
		sta	$0808,X		; to channel X
		lda	#$C0		; load code for zero volume

;****** if sound not disabled set sound generator volume ******************

_LEB0A:		sta	$0804,X		; store A to give basic sound level of Zero
		ldy	$0262		; get sound output/enable flag
		beq	_BEB14		; if sound enabled goto EB14
		lda	#$C0		; else load zero sound code
_BEB14:		sec			; set carry
		sbc	#$40		; subtract &40
		lsr			; divide by 8
		lsr			; to get into bits 0 - 3
		lsr			; 
		eor	#$0F		; invert bits 0-3
		ora	_LEB3C,X		; get channel number into top nybble
		ora	#$10		; 

_LEB21:		php			; 

_LEB22:		sei			; disable interrupts
		ldy	#$FF		; System VIA port A all outputs
		sty	$fe43		; set
		sta	$fe4f		; output A on port A
		iny			; Y=0
		sty	$fe40		; enable sound chip
		ldy	#$02		; set and
_BEB31:		dey			; execute short delay
		bne	_BEB31		; 
		ldy	#$08		; then disable sound chip again
		sty	$fe40		; 
		ldy	#$04		; set delay
_BEB3B:		dey			; and loop delay
_LEB3C:		bne	_BEB3B		; 
		plp			; get back flags
		rts			; and exit

;*******: Sound parameters look up table **********************************

		.byte	$E0,$C0,$A0,$80

_BEB44:		jmp	_LEC59		; just to allow relative branches in early part
					; of sound interrupt routine


;*************************************************************************
;*                                                                       *
;*       PROCESS SOUND INTERRUPT                                         *
;*                                                                       *
;*************************************************************************

_LEB47:		lda	#$00		; 
		sta	$083b		; zero number of channels on hold for sync
		lda	$0838		; get number of channels required for sync
		bne	_BEB57		; if this <>0 then EB57
		inc	$083b		; else number of chanels on hold for sync =1
		dec	$0838		; number of channels required for sync =255

_BEB57:		ldx	#$08		; set loop counter
_LEB59:		dex			; loop
		lda	$0800,X		; get value of &800 +offset (sound queue occupancy)
		beq	_BEB44		; if 0 goto EC59 no sound this channel
		lda	$02cf,X		; else get buffer busy flag
		bmi	_BEB69		; if negative (buffer empty) goto EB69
		lda	$0818,X		; else if duration count not zer0
		bne	_BEB6C		; goto EB6C
_BEB69:		jsr	_LEC6B		; check and pick up new sound if required
_BEB6C:		lda	$0818,X		; if duration count 0
		beq	_BEB84		; goto EB84
		cmp	#$FF		; else if it is &FF (infinite duration)
		beq	_BEB87		; go onto EB87
		dec	$081c,X		; decrement 10 mS count
		bne	_BEB87		; and if 0
		lda	#$05		; reset to 5
		sta	$081c,X		; to give 50 mSec delay
		dec	$0818,X		; and decrement main counter
		bne	_BEB87		; if not zero then EB87
_BEB84:		jsr	_LEC6B		; else check and get nw sound
_BEB87:		lda	$0824,X		; if step progress counter is 0 no envelope involved
		beq	_BEB91		; so jump to EB91
		dec	$0824,X		; else decrement it
		bne	_BEB44		; and if not zero go on to EC59
_BEB91:		ldy	$0820,X		; get  envelope data offset from (8C0)
		cpy	#$FF		; if 255 no envelope set so
		beq	_BEB44		; goto EC59
		lda	$08c0,Y		; else get get step length
		and	#$7F		; zero repeat bit
		sta	$0824,X		; and store it
		lda	$0808,X		; get phase counter
		cmp	#$04		; if release phase completed
		beq	_BEC07		; goto EC07
		lda	$0808,X		; else start new step by getting phase
		clc			; 
		adc	$0820,X		; add it to interval multiplier
		tay			; transfer to Y
		lda	$08cb,Y		; and get target value base for envelope
		sec			; 
		sbc	#$3F		; 
		sta	$083a		; store modified number as current target amplitude
		lda	$08c7,Y		; get byte from envelope store
		sta	$0839		; store as current amplitude step
		lda	$0804,X		; get base volumelevel
		pha			; save it
		clc			; clear carry
		adc	$0839		; add to current amplitude step
		bvc	_BEBCF		; if no overflow
		rol			; double it Carry = bit 7
		lda	#$3F		; if bit =1 A=&3F
		bcs	_BEBCF		; into &EBCF
		eor	#$FF		; else toggle bits (A=&C0)

		; at this point the BASIC volume commands are converted
		;  &C0 (0) to &38 (-15) 3 times, In fact last 3 bits
		; are ignored so &3F represents -15

_BEBCF:		sta	$0804,X		; store in current volume
		rol			; multiply by 2
		eor	$0804,X		; if bits 6 and 7 are equal
		bpl	_BEBE1		; goto &EBE1
		lda	#$3F		; if carry clear A=&3F (maximum)
		bcc	_BEBDE		; or
		eor	#$FF		; &C0 minimum

_BEBDE:		sta	$0804,X		; and this is stored in current volume

_BEBE1:		dec	$0839		; decrement amplitude change per step
		lda	$0804,X		; get volume again
		sec			; set carry
		sbc	$083a		; subtract target value
		eor	$0839		; negative value undicates correct trend
		bmi	_BEBF9		; so jump to next part
		lda	$083a		; else enter new phase
		sta	$0804,X		; 
		inc	$0808,X		; 

_BEBF9:		pla			; get the old volume level
		eor	$0804,X		; and compare with the old
		and	#$F8		; 
		beq	_BEC07		; if they are the same goto EC07
		lda	$0804,X		; else set new level
		jsr	_LEB0A		; via EB0A
_BEC07:		lda	$0810,X		; get absolute pitch value
		cmp	#$03		; if it =3
		beq	_LEC59		; skip rest of loop as all sections are finished
		lda	$0814,X		; else if 814,X is not 0 current section is not
					; complete
		bne	_BEC3D		; so EC3D
		inc	$0810,X		; else implement a section change
		lda	$0810,X		; check if its complete
		cmp	#$03		; if not
		bne	_BEC2D		; goto EC2D
		ldy	$0820,X		; else set A from
		lda	$08c0,Y		; &820 and &8C0 (first envelope byte)
		bmi	_LEC59		; if negative there is no repeat
		lda	#$00		; else restart section sequence
		sta	$0830,X		; 
		sta	$0810,X		; 

_BEC2D:		lda	$0810,X		; get number of steps in new section
		clc			; 
		adc	$0820,X		; 
		tay			; 
		lda	$08c4,Y		; 
		sta	$0814,X		; set in 814+X
		beq	_LEC59		; and if 0 then EC59

_BEC3D:		dec	$0814,X		; decrement
		lda	$0820,X		; and pick up rate of pitch change
		clc			; 
		adc	$0810,X		; 
		tay			; 
		lda	$08c1,Y		; 
		clc			; 
		adc	$0830,X		; add to rate of differential pitch change
		sta	$0830,X		; and save it
		clc			; 
		adc	$080c,X		; ad to base pitch
		jsr	_LED01		; and set new pitch

_LEC59:		cpx	#$04		; if X=4 (last channel)
		beq	_BEC6A		; goto EC6A (RTS)
		jmp	_LEB59		; else do loop again

_LEC60:		ldx	#$08		; X=7 again
_BEC62:		dex			; loop
		jsr	_LECA2		; clear channel
		cpx	#$04		; if not 4
		bne	_BEC62		; do it again
_BEC6A:		rts			; and return
					; 
_LEC6B:		lda	$0808,X		; check for last channel
		cmp	#$04		; is it 4 (release complete)
		beq	_BEC77		; if so EC77
		lda	#$03		; else mark release in progress
		sta	$0808,X		; and store it
_BEC77:		lda	$02cf,X		; is buffer not empty
		beq	_BEC90		; if so EC90
		lda	#$00		; else mark buffer not empty
		sta	$02cf,X		; an store it

		ldy	#$04		; loop counter
_BEC83:		sta	$082b,Y		; zero sync bytes
		dey			; 
		bne	_BEC83		; until Y=0

		sta	$0818,X		; zero duration count
		dey			; and set sync count to
		sty	$0838		; &FF
_BEC90:		lda	$0828,X		; get synchronising flag
		beq	_BECDB		; if its 0 then ECDB
		lda	$083b		; else get number of channels on hold
		beq	_BECD0		; if 0 then ECD0
		lda	#$00		; else
		sta	$0828,X		; zero note length interval
_BEC9F:		jmp	_LED98		; and goto ED98

_LECA2:		jsr	_LEB03		; silence the channel
		tya			; Y=0 A=Y
		sta	$0818,X		; zero main count
		sta	$02cf,X		; mark buffer not empty
		sta	$0800,X		; mark channel dormant
		ldy	#$03		; loop counter
_BECB1:		sta	$082c,Y		; zero sync flags
		dey			; 
		bpl	_BECB1		; 

		sty	$0838		; number of channels to &FF
		bmi	_BED06		; jump to ED06 ALWAYS

_BECBC:		php			; save flags
		sei			; and disable interrupts
		lda	$0808,X		; check for end of release
		cmp	#$04		; 
		bne	_BECCF		; and if not found ECCF
		jsr	_LE45B		; elseexamine buffer
		bcc	_BECCF		; if not empty ECCF
		lda	#$00		; else mark channel dormant
		sta	$0800,X		; 
_BECCF:		plp			; get back flags

_BECD0:		ldy	$0820,X		; if no envelope 820=&FF
		cpy	#$FF		; 
		bne	_BECDA		; then terminate sound
		jsr	_LEB03		; via EB03
_BECDA:		rts			; else return

;************ Synchronise sound routines **********************************

_BECDB:		jsr	_LE45B		; examine buffer if empty carry set
		bcs	_BECBC		; 
		and	#$03		; else examine next word if>3 or 0
		beq	_BEC9F		; goto ED98 (via EC9F)
		lda	$0838		; else get synchronising count
		beq	_BECFE		; in 0 (complete) goto ECFE
		inc	$0828,X		; else set sync flag
		bit	$0838		; if 0838 is +ve S has already been set so
		bpl	_BECFB		; jump to ECFB
		jsr	_LE45B		; else get first byte
		and	#$03		; mask bits 0,1
		sta	$0838		; and store result
		bpl	_BECFE		; Jump to ECFE (ALWAYS!!)

_BECFB:		dec	$0838		; decrement 0838
_BECFE:		jmp	_BECD0		; and silence the channel if envelope not in use

;************ Pitch setting ***********************************************

_LED01:		cmp	$082c,X		; If A=&82C,X then pitch is unchanged
		beq	_BECDA		; then exit via ECDA
_BED06:		sta	$082c,X		; store new pitch
		cpx	#$04		; if X<>4 then not noise so
		bne	_BED16		; jump to ED16

;*********** Noise setting ************************************************

		and	#$0F		; convert to chip format
		ora	_LEB3C,X		; 
		php			; save flags
		jmp	_LED95		; and pass to chip control routine at EB22 via ED95

_BED16:		pha			; 
		and	#$03		; 
		sta	$083c		; lose eigth tone surplus
		lda	#$00		; 
		sta	$083d		; 
		pla			; get back A
		lsr			; divide by 12
		lsr			; 
_BED24:		cmp	#$0C		; 
		bcc	_BED2F		; 
		inc	$083d		; store result
		sbc	#$0C		; with remainder in A
		bne	_BED24		; 
					; at this point 83D defines the Octave
					; A the semitone within the octave
_BED2F:		tay			; Y=A
		lda	$083d		; get octave number into A
		pha			; push it
		lda	_LEDFB,Y		; get byte from look up table
		sta	$083d		; store it
		lda	_LEE07,Y		; get byte from second table
		pha			; push it
		and	#$03		; keep two LS bits only
		sta	$083e		; save them
		pla			; pull second table byte
		lsr			; push hi nybble into lo nybble
		lsr			; 
		lsr			; 
		lsr			; 
		sta	$083f		; store it
		lda	$083d		; get back octave number
		ldy	$083c		; adjust for surplus eighth tones
		beq	_BED5F		; 
_BED53:		sec			; 
		sbc	$083f		; 
		bcs	_BED5C		; 
		dec	$083e		; 
_BED5C:		dey			; 
		bne	_BED53		; 
_BED5F:		sta	$083d		; 
		pla			; 
		tay			; 
		beq	_BED6F		; 
_BED66:		lsr	$083e		; 
		ror	$083d		; 
		dey			; 
		bne	_BED66		; 
_BED6F:		lda	$083d		; 
		clc			; 
		adc	_LC43D,X		; 
		sta	$083d		; 
		bcc	_BED7E		; 
		inc	$083e		; 
_BED7E:		and	#$0F		; 
		ora	_LEB3C,X		; 
		php			; push P
		sei			; bar interrupts
		jsr	_LEB21		; set up chip access 1
		lda	$083d		; 
		lsr	$083e		; 
		ror			; 
		lsr	$083e		; 
		ror			; 
		lsr			; 
		lsr			; 
_LED95:		jmp	_LEB22		; set up chip access 2 and return

;**************** Pick up and interpret sound buffer data *****************

_LED98:		php			; push flags
		sei			; disable interrupts
		jsr	_LE460		; read a byte from buffer
		pha			; push A
		and	#$04		; isolate H bit
		beq	_BEDB7		; if 0 then EDB7
		pla			; get back A
		ldy	$0820,X		; if &820,X=&FF
		cpy	#$FF		; envelope is not in use
		bne	_BEDAD		; 
		jsr	_LEB03		; so call EB03 to silence channel

_BEDAD:		jsr	_LE460		; clear buffer of redundant data
		jsr	_LE460		; and again
		plp			; get back flags
		jmp	_LEDF7		; set main duration count using last byte from buffer

_BEDB7:		pla			; get back A
		and	#$F8		; zero bits 0-2
		asl			; put bit 7 into carry
		bcc	_BEDC8		; if zero (envelope) jump to EDC8
		eor	#$FF		; invert A
		lsr			; shift right
		sec			; 
		sbc	#$40		; subtract &40
		jsr	_LEB0A		; and set volume
		lda	#$FF		; A=&FF

_BEDC8:		sta	$0820,X		; get envelope no.-1 *16 into A
		lda	#$05		; set duration sub-counter
		sta	$081c,X		; 
		lda	#$01		; set phase counter
		sta	$0824,X		; 
		lda	#$00		; set step counter
		sta	$0814,X		; 
		sta	$0808,X		; and envelope phase
		sta	$0830,X		; and pitch differential
		lda	#$FF		; 
		sta	$0810,X		; set step count
		jsr	_LE460		; read pitch
		sta	$080c,X		; set it
		jsr	_LE460		; read buffer
		plp			; 
		pha			; save duration
		lda	$080c,X		; get back pitch value
		jsr	_LED01		; and set it
		pla			; get back duration
_LEDF7:		sta	$0818,X		; set it
		rts			; and return

;********************* Pitch look up table 1*****************************
_LEDFB:		.byte	$F0
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

_LEE07:		.byte	$E7
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
_LEE13:		lda	#$EF		; get ROM
		sta	$F5		; store it
		rts			; return

;********** Get byte from data ROM ***************************************

_BEE18:		ldx	#$0D		; X=13
		inc	$F5		; 
		ldy	$F5		; get Rom
		bpl	_BEE59		; if +ve it's a sideways ROM else it's a PHROM
		ldx	#$00		; PHROM
		stx	$F7		; set address pointer in PHROM
		inx			; 
		stx	$F6		; to 0001
		jsr	_LEEBB		; pass info to speech processor
		ldx	#$03		; X=3

_BEE2C:		jsr	_LEE62		; check for speech processor and output until
					; it reports, read byte from ROM
		cmp	_LDF0C,X		; if A<> DF0C+X then EE18 (DF0C = (C))
		bne	_BEE18		; 
		dex			; else decrement X
		bpl	_BEE2C		; and do it again
		lda	#$3E		; 
		sta	$F6		; get noe lo byte address
_LEE3B:		jsr	_LEEBB		; pass info to speech processor
		ldx	#$FF		; 
_BEE40:		jsr	_LEE62		; check for speech proc. etc.
		ldy	#$08		; 
_BEE45:		asl			; 
		ror	$F7,X		; 
		dey			; 
		bne	_BEE45		; 
		inx			; 
		beq	_BEE40		; 
		clc			; 
		bcc	_LEEBB		; 

;************ ROM SERVICE ************************************************

_LEE51:		ldx	#$0E		; 
		ldy	$F5		; if Y is negative (PHROM)
		bmi	_LEE62		; GOTO EE62
		ldy	#$FF		; else Y=255
_BEE59:		php			; push flags
		jsr	_LF168		; offer paged rom service
		plp			; pull processor flags
		cmp	#$01		; if A>0  set carry
		tya			; A=Y
		rts			; return

;********* PHROM SERVICE *************************************************
		; 
_LEE62:		php			; push processor flags
		sei			; disable interrupts
		ldy	#$10		; Y=16
		jsr	_LEE7F		; call EE7F (osbyte 159 write to speech processor
		ldy	#$00		; Y=0
		beq	_BEE84		; Jump to EE84 (ALWAYS!!)


;*************************************************************************
;*                                                                       *
;*       OSBYTE 158 read from speech processor                           *
;*                                                                       *
;*************************************************************************

_LEE6D:		ldy	#$00		; Y=0 to set speech proc to read
		beq	_BEE82		; jump to EE82 always

		; write A to speech processor as two nybbles

_LEE71:		pha			; push A
		jsr	_LEE7A		; to write to speech processor
		pla			; get back A
		ror			; bring upper nybble to lower nybble
		ror			; by rotate right
		ror			; 4 times
		ror			; 

_LEE7A:		and	#$0F		; Y=lo nybble A +&40
		ora	#$40		; 
		tay			; forming command for speech processor


;*************************************************************************
;*                                                                       *
;*       OSBYTE 159 Write to speech processor                            *
;*                                                                       *
;*************************************************************************
;       on entry data or command in Y

_LEE7F:		tya			; transfer command to A
		ldy	#$01		; to set speech proc to write

		; if Y=0 read speech processor
		; if Y=1 write speech processor

_BEE82:		php			; push flags
		sei			; disable interrupts
_BEE84:		bit	$027b		; test for prescence of speech processor
		bpl	_BEEAA		; if not there goto EEAA
		pha			; else push A
		lda	_LF075,Y		; 
		sta	$fe43		; set DDRA of system VIA to give 8 bit input (Y=0)
					; or 8 bit output (Y=1)
		pla			; get back A
		sta	$fe4f		; and send to speech chip
		lda	_LF075 + 2,Y		; output Prt B of system VIA
		sta	$fe40		; to select read or write (dependent on Y)
_BEE9A:		bit	$fe40		; loop until
		bmi	_BEE9A		; speech proceessor reports ready (bit 7 Prt B=0)
		lda	$fe4f		; read speech processor data if  input selected
		pha			; push A
		lda	_LF075 + 4,Y		; reset speech
		sta	$fe40		; processor
		pla			; get back A

_BEEAA:		plp			; get back flags
		tay			; transfer A to Y
		rts			; and exit routine
					; 
_LEEAD:		lda	$03cb		; set rom displacement pointer
		sta	$F6		; in &F6
		lda	$03cc		; 
		sta	$F7		; And &F7
		lda	$F5		; if F5 is +ve ROM is selected so
		bpl	_BEED9		; goto EED9

_LEEBB:		php			; else push processor
		sei			; disable interrupts
		lda	$F6		; get lo displacement
		jsr	_LEE71		; pass two nyblles to speech proc.
		lda	$F5		; &FA=&F5
		sta	$FA		; 
		lda	$F7		; get hi displacement value
		rol			; replace two most significant bits of A
		rol			; by 2 LSBs of &FA
		lsr	$FA		; 
		ror			; 
		lsr	$FA		; 
		ror			; 
		jsr	_LEE71		; pass two nybbles to speech processor
		lda	$FA		; FA has now been divided by 4 so pass
		jsr	_LEE7A		; lower nybble to speech proc.
		plp			; get back flags
_BEED9:		rts			; and Return


