; OS SERIES 8
; GEOFF COX

;*************************************************************************
;*									 *
;*	  OSBYTE &F7 (247) INTERCEPT BREAK				 *
;*									 *
;*************************************************************************

			.org	$ead9

_LEAD9:			lda	OSB_BRK_INT_JMP			; get BREAK vector code
			eor	#$4c				; produces 0 if JMP not in &287
			bne	_BEAF3				; if not goto EAF3
			jmp	OSB_BRK_INT_JMP			; else jump to user BREAK code


;*************************************************************************
;*									 *
;*	  OSBYTE &90 (144)   *TV					 *
;*									 *
;*************************************************************************

				; X=display delay
				; Y=interlace flag

_OSBYTE_144:		lda	VDU_ADJUST			; VDU vertical adjustment
			stx	VDU_ADJUST			; store new value
			tax					; put old value in X
			tya					; put interlace flag in A
			and	#$01				; maximum value =1
			ldy	VDU_INTERLACE			; get old value into Y
			sta	VDU_INTERLACE			; put new value into A
_BEAF3:			rts					; and Exit


;*************************************************************************
;*									 *
;*	  OSBYTE &93 (147)  WRITE TO FRED				 *
;*									 *
;*************************************************************************
				; X is offset within page
				; Y is byte to write
_OSBYTE_147:		tya					; 
			sta	FRED,X				; 
			rts					; 


;*************************************************************************
;*									 *
;*	  OSBYTE &95 (149)  WRITE TO JIM				 *
;*									 *
;*************************************************************************
				; X is offset within page
				; Y is byte to write
				;
_OSBYTE_149:		tya					; 
			sta	JIM,X				; 
			rts					; 


;*************************************************************************
;*									 *
;*	  OSBYTE &97 (151)  WRITE TO SHEILA				 *
;*									 *
;*************************************************************************
				; X is offset within page
				; Y is byte to write
				;
_OSBYTE_151:		tya					; 
			sta	CRTC_ADDRESS,X			; 
			rts					; 

;****************** Silence a sound channel *******************************
				; X=channel number

_LEB03:			lda	#$04				; mark end of release phase
			sta	SOUND_AMPLITUDE,X		; to channel X
			lda	#$c0				; load code for zero volume

;****** if sound not disabled set sound generator volume ******************

_LEB0A:			sta	SOUND_QUEUE,X			; store A to give basic sound level of Zero
			ldy	OSB_SOUND_OFF			; get sound output/enable flag
			beq	_BEB14				; if sound enabled goto EB14
			lda	#$c0				; else load zero sound code
_BEB14:			sec					; set carry
			sbc	#$40				; subtract &40
			lsr					; divide by 8
			lsr					; to get into bits 0 - 3
			lsr					; 
			eor	#$0f				; invert bits 0-3
			ora	_LEB3C,X			; get channel number into top nybble
			ora	#$10				; 

_LEB21:			php					; 

_LEB22:			sei					; disable interrupts
			ldy	#$ff				; System VIA port A all outputs
			sty	SYS_VIA_DDRA			; set
			sta	SYS_VIA_IORB_NH			; output A on port A
			iny					; Y=0
			sty	SYS_VIA_IORB			; enable sound chip
			ldy	#$02				; set and
_BEB31:			dey					; execute short delay
			bne	_BEB31				; 
			ldy	#$08				; then disable sound chip again
			sty	SYS_VIA_IORB			; 
			ldy	#$04				; set delay
_BEB3B:			dey					; and loop delay
_LEB3C:			bne	_BEB3B				; 
			plp					; get back flags
			rts					; and exit

;*******: Sound parameters look up table **********************************

			.byte	$e0,$c0,$a0,$80			

_BEB44:			jmp	_LEC59				; just to allow relative branches in early part
								; of sound interrupt routine


;*************************************************************************
;*									 *
;*	 PROCESS SOUND INTERRUPT					 *
;*									 *
;*************************************************************************

_SOUND_IRQ:		lda	#$00				; 
			sta	SOUND_SYNC_HOLD_COUNT		; zero number of channels on hold for sync
			lda	SOUND_SYNC_CHANS		; get number of channels required for sync
			bne	_BEB57				; if this <>0 then EB57
			inc	SOUND_SYNC_HOLD_COUNT		; else number of chanels on hold for sync =1
			dec	SOUND_SYNC_CHANS		; number of channels required for sync =255

_BEB57:			ldx	#$08				; set loop counter
_LEB59:			dex					; loop
			lda	SOUND_WORKSPACE,X		; get value of &800 +offset (sound queue occupancy)
			beq	_BEB44				; if 0 goto EC59 no sound this channel
			lda	BUFFER_0_BUSY,X			; else get buffer busy flag
			bmi	_BEB69				; if negative (buffer empty) goto EB69
			lda	SOUND_STEPS,X			; else if duration count not zer0
			bne	_BEB6C				; goto EB6C
_BEB69:			jsr	_LEC6B				; check and pick up new sound if required
_BEB6C:			lda	SOUND_STEPS,X			; if duration count 0
			beq	_BEB84				; goto EB84
			cmp	#$ff				; else if it is &FF (infinite duration)
			beq	_BEB87				; go onto EB87
			dec	SOUND_DURATION,X		; decrement 10 mS count
			bne	_BEB87				; and if 0
			lda	#$05				; reset to 5
			sta	SOUND_DURATION,X		; to give 50 mSec delay
			dec	SOUND_STEPS,X			; and decrement main counter
			bne	_BEB87				; if not zero then EB87
_BEB84:			jsr	_LEC6B				; else check and get nw sound
_BEB87:			lda	SOUND_ENV_REPEAT,X		; if step progress counter is 0 no envelope involved
			beq	_BEB91				; so jump to EB91
			dec	SOUND_ENV_REPEAT,X		; else decrement it
			bne	_BEB44				; and if not zero go on to EC59
_BEB91:			ldy	SOUND_INTERVAL_MUL,X		; get  envelope data offset from (8C0)
			cpy	#$ff				; if 255 no envelope set so
			beq	_BEB44				; goto EC59
			lda	ENV_STEP,Y			; else get get step length
			and	#$7f				; zero repeat bit
			sta	SOUND_ENV_REPEAT,X		; and store it
			lda	SOUND_AMPLITUDE,X		; get phase counter
			cmp	#$04				; if release phase completed
			beq	_BEC07				; goto EC07
			lda	SOUND_AMPLITUDE,X		; else start new step by getting phase
			clc					; 
			adc	SOUND_INTERVAL_MUL,X		; add it to interval multiplier
			tay					; transfer to Y
			lda	ENV_ALA,Y			; and get target value base for envelope
			sec					; 
			sbc	#$3f				; 
			sta	SOUND_AMP_TARGET		; store modified number as current target amplitude
			lda	ENV_AA,Y			; get byte from envelope store
			sta	SOUND_AMP_STEP			; store as current amplitude step
			lda	SOUND_QUEUE,X			; get base volumelevel
			pha					; save it
			clc					; clear carry
			adc	SOUND_AMP_STEP			; add to current amplitude step
			bvc	_BEBCF				; if no overflow
			rol					; double it Carry = bit 7
			lda	#$3f				; if bit =1 A=&3F
			bcs	_BEBCF				; into &EBCF
			eor	#$ff				; else toggle bits (A=&C0)

				; at this point the BASIC volume commands are converted
				; &C0 (0) to &38 (-15) 3 times, In fact last 3 bits
				; are ignored so &3F represents -15

_BEBCF:			sta	SOUND_QUEUE,X			; store in current volume
			rol					; multiply by 2
			eor	SOUND_QUEUE,X			; if bits 6 and 7 are equal
			bpl	_BEBE1				; goto &EBE1
			lda	#$3f				; if carry clear A=&3F (maximum)
			bcc	_BEBDE				; or
			eor	#$ff				; &C0 minimum

_BEBDE:			sta	SOUND_QUEUE,X			; and this is stored in current volume

_BEBE1:			dec	SOUND_AMP_STEP			; decrement amplitude change per step
			lda	SOUND_QUEUE,X			; get volume again
			sec					; set carry
			sbc	SOUND_AMP_TARGET		; subtract target value
			eor	SOUND_AMP_STEP			; negative value undicates correct trend
			bmi	_BEBF9				; so jump to next part
			lda	SOUND_AMP_TARGET		; else enter new phase
			sta	SOUND_QUEUE,X			; 
			inc	SOUND_AMPLITUDE,X		; 

_BEBF9:			pla					; get the old volume level
			eor	SOUND_QUEUE,X			; and compare with the old
			and	#$f8				; 
			beq	_BEC07				; if they are the same goto EC07
			lda	SOUND_QUEUE,X			; else set new level
			jsr	_LEB0A				; via EB0A
_BEC07:			lda	SOUND_PITCH,X			; get absolute pitch value
			cmp	#$03				; if it =3
			beq	_LEC59				; skip rest of loop as all sections are finished
			lda	SOUND_PITCH_PHASES,X		; else if 814,X is not 0 current section is not
								; complete
			bne	_BEC3D				; so EC3D
			inc	SOUND_PITCH,X			; else implement a section change
			lda	SOUND_PITCH,X			; check if its complete
			cmp	#$03				; if not
			bne	_BEC2D				; goto EC2D
			ldy	SOUND_INTERVAL_MUL,X		; else set A from
			lda	ENV_STEP,Y			; &820 and &8C0 (first envelope byte)
			bmi	_LEC59				; if negative there is no repeat
			lda	#$00				; else restart section sequence
			sta	SOUND_PITCH_SETTING,X		; 
			sta	SOUND_PITCH,X			; 

_BEC2D:			lda	SOUND_PITCH,X			; get number of steps in new section
			clc					; 
			adc	SOUND_INTERVAL_MUL,X		; 
			tay					; 
			lda	ENV_PN1,Y			; 
			sta	SOUND_PITCH_PHASES,X		; set in 814+X
			beq	_LEC59				; and if 0 then EC59

_BEC3D:			dec	SOUND_PITCH_PHASES,X		; decrement
			lda	SOUND_INTERVAL_MUL,X		; and pick up rate of pitch change
			clc					; 
			adc	SOUND_PITCH,X			; 
			tay					; 
			lda	ENV_PI1,Y			; 
			clc					; 
			adc	SOUND_PITCH_SETTING,X		; add to rate of differential pitch change
			sta	SOUND_PITCH_SETTING,X		; and save it
			clc					; 
			adc	SOUND_AMP_PHASES,X		; ad to base pitch
			jsr	_LED01				; and set new pitch

_LEC59:			cpx	#$04				; if X=4 (last channel)
			beq	_BEC6A				; goto EC6A (RTS)
			jmp	_LEB59				; else do loop again

_LEC60:			ldx	#$08				; X=7 again
_BEC62:			dex					; loop
			jsr	_LECA2				; clear channel
			cpx	#$04				; if not 4
			bne	_BEC62				; do it again
_BEC6A:			rts					; and return
								;
_LEC6B:			lda	SOUND_AMPLITUDE,X		; check for last channel
			cmp	#$04				; is it 4 (release complete)
			beq	_BEC77				; if so EC77
			lda	#$03				; else mark release in progress
			sta	SOUND_AMPLITUDE,X		; and store it
_BEC77:			lda	BUFFER_0_BUSY,X			; is buffer not empty
			beq	_BEC90				; if so EC90
			lda	#$00				; else mark buffer not empty
			sta	BUFFER_0_BUSY,X			; an store it

			ldy	#$04				; loop counter
_BEC83:			sta	SOUND_SYNC_HOLD_PARAM-1,Y	; zero sync bytes
			dey					; 
			bne	_BEC83				; until Y=0

			sta	SOUND_STEPS,X			; zero duration count
			dey					; and set sync count to
			sty	SOUND_SYNC_CHANS		; &FF
_BEC90:			lda	SOUND_NOTE_REMAIN,X		; get synchronising flag
			beq	_BECDB				; if its 0 then ECDB
			lda	SOUND_SYNC_HOLD_COUNT		; else get number of channels on hold
			beq	_LECD0				; if 0 then ECD0
			lda	#$00				; else
			sta	SOUND_NOTE_REMAIN,X		; zero note length interval
_BEC9F:			jmp	_LED98				; and goto ED98

_LECA2:			jsr	_LEB03				; silence the channel
			tya					; Y=0 A=Y
			sta	SOUND_STEPS,X			; zero main count
			sta	BUFFER_0_BUSY,X			; mark buffer not empty
			sta	SOUND_WORKSPACE,X		; mark channel dormant
			ldy	#$03				; loop counter
_BECB1:			sta	SOUND_SYNC_HOLD_PARAM,Y		; zero sync flags
			dey					; 
			bpl	_BECB1				; 

			sty	SOUND_SYNC_CHANS		; number of channels to &FF
			bmi	_BED06				; jump to ED06 ALWAYS

_BECBC:			php					; save flags
			sei					; and disable interrupts
			lda	SOUND_AMPLITUDE,X		; check for end of release
			cmp	#$04				; 
			bne	_BECCF				; and if not found ECCF
			jsr	_OSBYTE_152			; elseexamine buffer
			bcc	_BECCF				; if not empty ECCF
			lda	#$00				; else mark channel dormant
			sta	SOUND_WORKSPACE,X		; 
_BECCF:			plp					; get back flags

_LECD0:			ldy	SOUND_INTERVAL_MUL,X		; if no envelope 820=&FF
			cpy	#$ff				; 
			bne	_BECDA				; then terminate sound
			jsr	_LEB03				; via EB03
_BECDA:			rts					; else return

;************ Synchronise sound routines **********************************

_BECDB:			jsr	_OSBYTE_152			; examine buffer if empty carry set
			bcs	_BECBC				; 
			and	#$03				; else examine next word if>3 or 0
			beq	_BEC9F				; goto ED98 (via EC9F)
			lda	SOUND_SYNC_CHANS		; else get synchronising count
			beq	_BECFE				; in 0 (complete) goto ECFE
			inc	SOUND_NOTE_REMAIN,X		; else set sync flag
			bit	SOUND_SYNC_CHANS		; if 0838 is +ve S has already been set so
			bpl	_BECFB				; jump to ECFB
			jsr	_OSBYTE_152			; else get first byte
			and	#$03				; mask bits 0,1
			sta	SOUND_SYNC_CHANS		; and store result
			bpl	_BECFE				; Jump to ECFE (ALWAYS!!)

_BECFB:			dec	SOUND_SYNC_CHANS		; decrement 0838
_BECFE:			jmp	_LECD0				; and silence the channel if envelope not in use

;************ Pitch setting ***********************************************

_LED01:			cmp	SOUND_SYNC_HOLD_PARAM,X		; If A=&82C,X then pitch is unchanged
			beq	_BECDA				; then exit via ECDA
_BED06:			sta	SOUND_SYNC_HOLD_PARAM,X		; store new pitch
			cpx	#$04				; if X<>4 then not noise so
			bne	_BED16				; jump to ED16

;*********** Noise setting ************************************************

			and	#$0f				; convert to chip format
			ora	_LEB3C,X			; 
			php					; save flags
			jmp	_LED95				; and pass to chip control routine at EB22 via ED95

_BED16:			pha					; 
			and	#$03				; 
			sta	SOUND_WS_0			; lose eigth tone surplus
			lda	#$00				; 
			sta	SOUND_FREQ_LO			; 
			pla					; get back A
			lsr					; divide by 12
			lsr					; 
_BED24:			cmp	#$0c				; 
			bcc	_BED2F				; 
			inc	SOUND_FREQ_LO			; store result
			sbc	#$0c				; with remainder in A
			bne	_BED24				; 
								; at this point 83D defines the Octave
								; A the semitone within the octave
_BED2F:			tay					; Y=A
			lda	SOUND_FREQ_LO			; get octave number into A
			pha					; push it
			lda	_SOUND_PITCH_TABLE_1,Y		; get byte from look up table
			sta	SOUND_FREQ_LO			; store it
			lda	_SOUND_PITCH_TABLE_2,Y		; get byte from second table
			pha					; push it
			and	#$03				; keep two LS bits only
			sta	SOUND_FREQ_HI			; save them
			pla					; pull second table byte
			lsr					; push hi nybble into lo nybble
			lsr					; 
			lsr					; 
			lsr					; 
			sta	SOUND_WS_3			; store it
			lda	SOUND_FREQ_LO			; get back octave number
			ldy	SOUND_WS_0			; adjust for surplus eighth tones
			beq	_BED5F				; 
_BED53:			sec					; 
			sbc	SOUND_WS_3			; 
			bcs	_BED5C				; 
			dec	SOUND_FREQ_HI			; 
_BED5C:			dey					; 
			bne	_BED53				; 
_BED5F:			sta	SOUND_FREQ_LO			; 
			pla					; 
			tay					; 
			beq	_BED6F				; 
_BED66:			lsr	SOUND_FREQ_HI			; 
			ror	SOUND_FREQ_LO			; 
			dey					; 
			bne	_BED66				; 
_BED6F:			lda	SOUND_FREQ_LO			; 
			clc					; 
			adc	_LC43D,X			; 
			sta	SOUND_FREQ_LO			; 
			bcc	_BED7E				; 
			inc	SOUND_FREQ_HI			; 
_BED7E:			and	#$0f				; 
			ora	_LEB3C,X			; 
			php					; push P
			sei					; bar interrupts
			jsr	_LEB21				; set up chip access 1
			lda	SOUND_FREQ_LO			; 
			lsr	SOUND_FREQ_HI			; 
			ror					; 
			lsr	SOUND_FREQ_HI			; 
			ror					; 
			lsr					; 
			lsr					; 
_LED95:			jmp	_LEB22				; set up chip access 2 and return

;**************** Pick up and interpret sound buffer data *****************

_LED98:			php					; push flags
			sei					; disable interrupts
			jsr	_OSBYTE_145			; read a byte from buffer
			pha					; push A
			and	#$04				; isolate H bit
			beq	_BEDB7				; if 0 then EDB7
			pla					; get back A
			ldy	SOUND_INTERVAL_MUL,X		; if &820,X=&FF
			cpy	#$ff				; envelope is not in use
			bne	_BEDAD				; 
			jsr	_LEB03				; so call EB03 to silence channel

_BEDAD:			jsr	_OSBYTE_145			; clear buffer of redundant data
			jsr	_OSBYTE_145			; and again
			plp					; get back flags
			jmp	_LEDF7				; set main duration count using last byte from buffer

_BEDB7:			pla					; get back A
			and	#$f8				; zero bits 0-2
			asl					; put bit 7 into carry
			bcc	_BEDC8				; if zero (envelope) jump to EDC8
			eor	#$ff				; invert A
			lsr					; shift right
			sec					; 
			sbc	#$40				; subtract &40
			jsr	_LEB0A				; and set volume
			lda	#$ff				; A=&FF

_BEDC8:			sta	SOUND_INTERVAL_MUL,X		; get envelope no.-1 *16 into A
			lda	#$05				; set duration sub-counter
			sta	SOUND_DURATION,X		; 
			lda	#$01				; set phase counter
			sta	SOUND_ENV_REPEAT,X		; 
			lda	#$00				; set step counter
			sta	SOUND_PITCH_PHASES,X		; 
			sta	SOUND_AMPLITUDE,X		; and envelope phase
			sta	SOUND_PITCH_SETTING,X		; and pitch differential
			lda	#$ff				; 
			sta	SOUND_PITCH,X			; set step count
			jsr	_OSBYTE_145			; read pitch
			sta	SOUND_AMP_PHASES,X		; set it
			jsr	_OSBYTE_145			; read buffer
			plp					; 
			pha					; save duration
			lda	SOUND_AMP_PHASES,X		; get back pitch value
			jsr	_LED01				; and set it
			pla					; get back duration
_LEDF7:			sta	SOUND_STEPS,X			; set it
			rts					; and return

;********************* Pitch look up table 1*****************************
_SOUND_PITCH_TABLE_1:	.byte	$f0				
			.byte	$b7				
			.byte	$82				
			.byte	$4f				
			.byte	$20				
			.byte	$f3				
			.byte	$c8				
			.byte	$a0				
			.byte	$7b				
			.byte	$57				
			.byte	$35				
			.byte	$16				

;********************* Pitch look up table 2 *****************************

_SOUND_PITCH_TABLE_2:	.byte	$e7				
			.byte	$d7				
			.byte	$cb				
			.byte	$c3				
			.byte	$b7				
			.byte	$aa				
			.byte	$a2				
			.byte	$9a				
			.byte	$92				
			.byte	$8a				
			.byte	$82				
			.byte	$7a				

;*********: set current filing system ROM/PHROM **************************
_LEE13:			lda	#$ef				; get ROM
			sta	RFS_SELECT			; store it
			rts					; return

;********** Get byte from data ROM ***************************************

_LEE18:			ldx	#$0d				; X=13
			inc	RFS_SELECT			; 
			ldy	RFS_SELECT			; get Rom
			bpl	__rfs_read_pagedrom		; if +ve it's a sideways ROM else it's a PHROM
			ldx	#$00				; PHROM
			stx	ROM_PTR_HI			; set address pointer in PHROM
			inx					; 
			stx	ROM_PTR				; to 0001
			jsr	_LEEBB				; pass info to speech processor
			ldx	#$03				; X=3

_BEE2C:			jsr	_RFS_READ_PHROM			; check for speech processor and output until
								; it reports, read byte from ROM
			cmp	_MSG_COPYSYM,X			; if A<> DF0C+X then EE18 (DF0C = (C))
			bne	_LEE18				; 
			dex					; else decrement X
			bpl	_BEE2C				; and do it again
			lda	#$3e				; 
			sta	ROM_PTR				; get noe lo byte address
_LEE3B:			jsr	_LEEBB				; pass info to speech processor
			ldx	#$ff				; 
_BEE40:			jsr	_RFS_READ_PHROM			; check for speech proc. etc.
			ldy	#$08				; 
_BEE45:			asl					; 
			ror	ROM_PTR_HI,X			; 
			dey					; 
			bne	_BEE45				; 
			inx					; 
			beq	_BEE40				; 
			clc					; 
			bcc	_LEEBB				; 

;************ ROM SERVICE ************************************************

_RFS_READ_ROM:		ldx	#$0e				; 
			ldy	RFS_SELECT			; if Y is negative (PHROM)
			bmi	_RFS_READ_PHROM			; GOTO EE62
			ldy	#$ff				; else Y=255
__rfs_read_pagedrom:	php					; push flags
			jsr	_OSBYTE_143			; offer paged rom service
			plp					; pull processor flags
			cmp	#$01				; if A>0  set carry
			tya					; A=Y
			rts					; return

;********* PHROM SERVICE *************************************************
				;
_RFS_READ_PHROM:	php					; push processor flags
			sei					; disable interrupts
			ldy	#$10				; Y=16
			jsr	_OSBYTE_159			; call EE7F (osbyte 159 write to speech processor
			ldy	#$00				; Y=0
			beq	_BEE84				; Jump to EE84 (ALWAYS!!)


;*************************************************************************
;*									 *
;*	 OSBYTE 158 read from speech processor				 *
;*									 *
;*************************************************************************

_OSBYTE_158:		ldy	#$00				; Y=0 to set speech proc to read
			beq	_BEE82				; jump to EE82 always

				; write A to speech processor as two nybbles

_LEE71:			pha					; push A
			jsr	_LEE7A				; to write to speech processor
			pla					; get back A
			ror					; bring upper nybble to lower nybble
			ror					; by rotate right
			ror					; 4 times
			ror					; 

_LEE7A:			and	#$0f				; Y=lo nybble A +&40
			ora	#$40				; 
			tay					; forming command for speech processor


;*************************************************************************
;*									 *
;*	 OSBYTE 159 Write to speech processor				 *
;*									 *
;*************************************************************************
;	on entry data or command in Y

_OSBYTE_159:		tya					; transfer command to A
			ldy	#$01				; to set speech proc to write

				; if Y=0 read speech processor
				; if Y=1 write speech processor

_BEE82:			php					; push flags
			sei					; disable interrupts
_BEE84:			bit	OSB_SPCH_FOUND			; test for prescence of speech processor
			bpl	_BEEAA				; if not there goto EEAA
			pha					; else push A
			lda	_SPEECH_DATA,Y			; 
			sta	SYS_VIA_DDRA			; set DDRA of system VIA to give 8 bit input (Y=0)
								; or 8 bit output (Y=1)
			pla					; get back A
			sta	SYS_VIA_IORB_NH			; and send to speech chip
			lda	_SPEECH_DATA+2,Y		; output Prt B of system VIA
			sta	SYS_VIA_IORB			; to select read or write (dependent on Y)
_BEE9A:			bit	SYS_VIA_IORB			; loop until
			bmi	_BEE9A				; speech proceessor reports ready (bit 7 Prt B=0)
			lda	SYS_VIA_IORB_NH			; read speech processor data if	 input selected
			pha					; push A
			lda	_SPEECH_DATA+4,Y		; reset speech
			sta	SYS_VIA_IORB			; processor
			pla					; get back A

_BEEAA:			plp					; get back flags
			tay					; transfer A to Y
			rts					; and exit routine
								;
_LEEAD:			lda	CFS_RFS_LO			; set rom displacement pointer
			sta	ROM_PTR				; in &F6
			lda	CFS_RFS_HI			; 
			sta	ROM_PTR_HI			; And &F7
			lda	RFS_SELECT			; if F5 is +ve ROM is selected so
			bpl	_BEED9				; goto EED9

_LEEBB:			php					; else push processor
			sei					; disable interrupts
			lda	ROM_PTR				; get lo displacement
			jsr	_LEE71				; pass two nyblles to speech proc.
			lda	RFS_SELECT			; &FA=&F5
			sta	MOS_WS_0			; 
			lda	ROM_PTR_HI			; get hi displacement value
			rol					; replace two most significant bits of A
			rol					; by 2 LSBs of &FA
			lsr	MOS_WS_0			; 
			ror					; 
			lsr	MOS_WS_0			; 
			ror					; 
			jsr	_LEE71				; pass two nybbles to speech processor
			lda	MOS_WS_0			; FA has now been divided by 4 so pass
			jsr	_LEE7A				; lower nybble to speech proc.
			plp					; get back flags
_BEED9:			rts					; and Return


