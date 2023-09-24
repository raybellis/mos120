;**************************************************************************									  *
;*	  OSBYTE LOOK UP TABLE						 *
;*									 *
;*************************************************************************

			.org	$e5b3

_OSBYTE_TABLE:		.word	_OSBYTE_0			; OSBYTE   0  (&E821)
			.word	_OSBYTE_1_6			; OSBYTE   1  (&E988)
			.word	_OSBYTE_2			; OSBYTE   2  (&E6D3)
			.word	_OSBYTE_3_4			; OSBYTE   3  (&E997)
			.word	_OSBYTE_3_4			; OSBYTE   4  (&E997)
			.word	_OSBYTE_5			; OSBYTE   5  (&E976)
			.word	_OSBYTE_1_6			; OSBYTE   6  (&E988)
			.word	_OSBYTE_7			; OSBYTE   7  (&E68B)
			.word	_OSBYTE_8			; OSBYTE   8  (&E689)
			.word	_OSBYTE_9			; OSBYTE   9  (&E6B0)
			.word	_OSBYTE_10			; OSBYTE  10  (&E6B2)
			.word	_OSBYTE_11			; OSBYTE  11  (&E995)
			.word	_OSBYTE_12			; OSBYTE  12  (&E98C)
			.word	_OSBYTE_13			; OSBYTE  13  (&E6F9)
			.word	_OSBYTE_14			; OSBYTE  14  (&E6FA)
			.word	_OSBYTE_15			; OSBYTE  15  (&F0A8)
			.word	_OSBYTE_16			; OSBYTE  16  (&E706)
			.word	_OSBYTE_17			; OSBYTE  17  (&DE8C)
			.word	_OSBYTE_18			; OSBYTE  18  (&E9C8)
			.word	_OSBYTE_19			; OSBYTE  19  (&E9B6)
			.word	_OSBYTE_20			; OSBYTE  20  (&CD07)
			.word	_OSBYTE_21			; OSBYTE  21  (&F0B4)
			.word	_OSBYTE_117			; OSBYTE 117  (&E86C)
			.word	_OSBYTE_118			; OSBYTE 118  (&E9D9)
			.word	_OSBYTE_119			; OSBYTE 119  (&E275)
			.word	_OSBYTE_120			; OSBYTE 120  (&F045)
			.word	_OSBYTE_121			; OSBYTE 121  (&F0CF)
			.word	_OSBYTE_122			; OSBYTE 122  (&F0CD)
			.word	_OSBYTE_123			; OSBYTE 123  (&E197)
			.word	_OSBYTE_124			; OSBYTE 124  (&E673)
			.word	_OSBYTE_125			; OSBYTE 125  (&E674)
			.word	_OSBYTE_126			; OSBYTE 126  (&E65C)
			.word	_OSBYTE_127			; OSBYTE 127  (&E035)
			.word	_OSBYTE_128			; OSBYTE 128  (&E74F)
			.word	_OSBYTE_129			; OSBYTE 129  (&E713)
			.word	_OSBYTE_130			; OSBYTE 130  (&E729)
			.word	_OSBYTE_131			; OSBYTE 131  (&F085)
			.word	_OSBYTE_132			; OSBYTE 132  (&D923)
			.word	_OSBYTE_133			; OSBYTE 133  (&D926)
			.word	_OSBYTE_134			; OSBYTE 134  (&D647)
			.word	_OSBYTE_135			; OSBYTE 135  (&D7C2)
			.word	_OSBYTE_136			; OSBYTE 136  (&E657)
			.word	_OSBYTE_137			; OSBYTE 137  (&E67F)
			.word	_OSBYTE_138			; OSBYTE 138  (&E4AF)
			.word	_OSBYTE_139			; OSBYTE 139  (&E034)
			.word	_OSBYTE_140_141			; OSBYTE 140  (&F135)
			.word	_OSBYTE_140_141			; OSBYTE 141  (&F135)
			.word	_OSBYTE_142			; OSBYTE 142  (&DBE7)
			.word	_OSBYTE_143			; OSBYTE 143  (&F168)
			.word	_OSBYTE_144			; OSBYTE 144  (&EAE3)
			.word	_OSBYTE_145			; OSBYTE 145  (&E460)
			.word	_OSBYTE_146			; OSBYTE 146  (&FFAA)
			.word	_OSBYTE_147			; OSBYTE 147  (&EAF4)
			.word	_OSBYTE_148			; OSBYTE 148  (&FFAE)
			.word	_OSBYTE_149			; OSBYTE 149  (&EAF9)
			.word	_OSBYTE_150			; OSBYTE 150  (&FFB2)
			.word	_OSBYTE_151			; OSBYTE 151  (&EAFE)
			.word	_OSBYTE_152			; OSBYTE 152  (&E45B)
			.word	_OSBYTE_153			; OSBYTE 153  (&E4F3)
			.word	_OSBYTE_154			; OSBYTE 154  (&E9FF)
			.word	_OSBYTE_155			; OSBYTE 155  (&EA10)
			.word	_OSBYTE_156			; OSBYTE 156  (&E17C)
			.word	_OSBYTE_157			; OSBYTE 157  (&FFA7)
			.word	_OSBYTE_158			; OSBYTE 158  (&EE6D)
			.word	_OSBYTE_159			; OSBYTE 159  (&EE7F)
			.word	_OSBYTE_160			; OSBYTE 160  (&E9C0)
			.word	_OSBYTE_166_255			; OSBYTE 166+
			.word	_OSCLI_USERV			; OSWORD &E0+


;*************************************************************************
;*									 *
;*	  OSWORD LOOK UP TABLE						 *
;*									 *
;*************************************************************************

			.word	_OSWORD_0			; OSWORD   0  (&E902)
			.word	_OSWORD_1			; OSWORD   1  (&E8D5)
			.word	_OSWORD_2			; OSWORD   2  (&E8E8)
			.word	_OSWORD_3			; OSWORD   3  (&E8D1)
			.word	_OSWORD_4			; OSWORD   4  (&E8E4)
			.word	_OSWORD_5			; OSWORD   5  (&E803)
			.word	_OSWORD_6			; OSWORD   6  (&E80B)
			.word	_OSWORD_7			; OSWORD   7  (&E82D)
			.word	_OSWORD_8			; OSWORD   8  (&E8AE)
			.word	_OSWORD_9			; OSWORD   9  (&C735)
			.word	_OSWORD_10			; OSWORD  10  (&CBF3)
			.word	_OSWORD_11			; OSWORD  11  (&C748)
			.word	_OSWORD_12			; OSWORD  12  (&C8E0)
			.word	_OSWORD_13			; OSWORD  13  (&D5CE)


;*************************************************************************
;*									 *
;*	 OSBYTE 136   Execute Code via User Vector			 *
;*									 *
;*	 *CODE effectively						 *
;*									 *
;*************************************************************************

_OSBYTE_136:		lda	#00				; A=0


;*************************************************************************
;*									 *
;*	 *LINE	 entry							 *
;*									 *
;*************************************************************************

_OSCLI_USERV:		jmp	(VEC_USERV)			; Jump via USERV


;*************************************************************************
;*									 *
;*	 OSBYTE	 126  Acknowledge detection of ESCAPE condition		 *
;*									 *
;*************************************************************************

_OSBYTE_126:		ldx	#$00				; X=0
			bit	ESCAPE_FLAG			; if bit 7 not set there is no ESCAPE condition
			bpl	_OSBYTE_124			; so E673
			lda	OSB_ESC_EFFECTS			; else get ESCAPE Action, if this is 0
								; Clear ESCAPE
								; close EXEC files
								; purge all buffers
								; reset VDU paging counter
			bne	_BE671				; else do none of the above
			cli					; allow interrupts
			sta	OSB_HALT_LINES			; number of lines printed since last halt in paged
								; mode = 0
			jsr	_OSCLI_EXEC			; close any open EXEC files
			jsr	_LF0AA				; clear all buffers
_BE671:			ldx	#$ff				; X=&FF to indicate ESCAPE acknowledged


;*************************************************************************
;*									 *
;*	 OSBYTE	 124  Clear ESCAPE condition				 *
;*									 *
;*************************************************************************

_OSBYTE_124:		clc					; clear carry


;*************************************************************************
;*									 *
;*	 OSBYTE	 125  Set ESCAPE flag					 *
;*									 *
;*************************************************************************

_OSBYTE_125:		ror	ESCAPE_FLAG			; clear	 bit 7 of ESCAPE flag
			bit	OSB_TUBE_FOUND			; read bit 7 of Tube flag
			bmi	_BE67C				; if set TUBE exists so E67C
			rts					; else RETURN
								;
_BE67C:			jmp	TUBE_ENTRY_1			; Jump to Tube entry point


;*************************************************************************
;*									 *
;*	 OSBYTE	 137  Turn on Tape motor				 *
;*									 *
;*************************************************************************

_OSBYTE_137:		lda	OSB_SERPROC			; get serial ULA control setting
			tay					; Y=A
			rol					; rotate left to get bit 7 into carry
			cpx	#$01				; if X=1 then user wants motor on so CARRY set else
								; carry is cleared
			ror					; put carry back in control RAM copy
			bvc	_LE6A7				; if bit 6 is clear then cassette is selected
								; so write to control register and RAM copy

_OSBYTE_8:		lda	#$38				; A=ASCII 8


;*************************************************************************
;*									 *
;*	 OSBYTE 08/07 set serial baud rates				 *
;*									 *
;*************************************************************************
;	on entry X=baud rate
;	     A=8 transmit
;	     A=7 receive

_OSBYTE_7:		eor	#$3f				; converts ASCII 8 to 7 binary and ASCII 7 to 8 binary
			sta	MOS_WS_0			; store result
			ldy	OSB_SERPROC			; get serial ULA control register setting
			cpx	#$09				; is it 9 or more?
			bcs	_BE6AD				; if so exit
			and	_BAUD_TABLE,X			; and with byte from look up table
			sta	MOS_WS_1			; store it
			tya					; put Y in A
			ora	MOS_WS_0			; and or with Accumulator
			eor	MOS_WS_0			; zero the three bits set true
			ora	MOS_WS_1			; set up data read from look up table + bit 6
			ora	#$40				; 
			eor	OSB_SER_CAS_FLG			; write cassette/RS423 flag

_LE6A7:			sta	OSB_SERPROC			; store serial ULA flag
			sta	SERIAL_ULA			; and write to control register
_BE6AD:			tya					; put Y in A to save old contents
_BE6AE:			tax					; write new setting to X
			rts					; and return

; OS SERIES VII
; GEOFF COX

;*************************************************************************
;*									 *
;*	 OSBYTE	 9   Duration of first colour				 *
;*									 *
;*************************************************************************
;on entry Y=0, X=new value

_OSBYTE_9:		iny					; Y is incremented to 1
			clc					; clear carry


;*************************************************************************
;*									 *
;*	 OSBYTE	 10   Duration of second colour				 *
;*									 *
;*************************************************************************

;on entry Y=0 or 1 if from FX 9 call, X=new value

_OSBYTE_10:		lda	OSB_FLASH_SPC,Y			; get mark period count
			pha					; push it
			txa					; get new count
			sta	OSB_FLASH_SPC,Y			; store it
			pla					; get back original value
			tay					; put it in Y
			lda	OSB_FLASH_TIME			; get value of flash counter
			bne	_BE6D1				; if not zero E6D1

			stx	OSB_FLASH_TIME			; else restore old value
			lda	OSB_VIDPROC_CTL			; get current video ULA control register setting
			php					; push flags
			ror					; rotate bit 0 into carry, carry into bit 7
			plp					; get back flags
			rol					; rotate back carry into bit 0
			sta	OSB_VIDPROC_CTL			; store it in RAM copy
			sta	VID_ULA_CTRL			; and ULA control register

_BE6D1:			bvc	_BE6AD				; then exit via OSBYTE 7/8


;*************************************************************************
;*									 *
;*	 OSBYTE	 2   select input stream				 *
;*									 *
;*************************************************************************

;on input X contains stream number

_OSBYTE_2:		txa					; A=X
			and	#$01				; blank out bits 1 - 7
			pha					; push A
			lda	OSB_RS423_CTL			; and get current ACIA control setting
			rol					; Bit 7 into carry
			cpx	#$01				; if X>=1 then
			ror					; bit 7 of A=1
			cmp	OSB_RS423_CTL			; compare this with ACIA control setting
			php					; push processor
			sta	OSB_RS423_CTL			; put A into ACIA control setting
			sta	ACIA_CSR			; and write to control register
			jsr	_LE173				; set up RS423 buffer
			plp					; get back P
			beq	_BE6F1				; if new setting different from old E6F1 else
			bit	ACIA_TXRX			; set bit 6 and 7

_BE6F1:			ldx	OSB_IN_STREAM			; get current input buffer number
			pla					; get back A
			sta	OSB_IN_STREAM			; store it
			rts					; and return


;*************************************************************************
;*									 *
;*	 OSBYTE	 13   disable events					 *
;*									 *
;*************************************************************************

				; X contains event number 0-9

_OSBYTE_13:		tya					; Y=0 A=0


;*************************************************************************
;*									 *
;*	 OSBYTE	 14   enable events					 *
;*									 *
;*************************************************************************
;X contains event number 0-9

_OSBYTE_14:		cpx	#$0a				; if X>9
			bcs	_BE6AE				; goto E6AE for exit
			ldy	EVENT_ENABLE,X			; else get event enable flag
			sta	EVENT_ENABLE,X			; store new value in flag
			bvc	_BE6AD				; and exit via E6AD


;*************************************************************************
;*									 *
;*	 OSBYTE	 16   Select A/D channel				 *
;*									 *
;*************************************************************************
;X contains channel number or 0 if disable conversion

_OSBYTE_16:		beq	_BE70B				; if X=0 then E70B
			jsr	_OSBYTE_17			; start conversion

_BE70B:			lda	OSB_ADC_MAX			; get  current maximum ADC channel number
			stx	OSB_ADC_MAX			; store new value
			tax					; put old value in X
			rts					; and exit


;*************************************************************************
;*									 *
;*	 OSBYTE 129   Read key within time limit			 *
;*									 *
;*************************************************************************
;X and Y contains either time limit in centi seconds Y=&7F max
; or Y=&FF and X=-ve INKEY value

_OSBYTE_129:		tya					; A=Y
			bmi	_BE721				; if Y=&FF the E721
			cli					; else allow interrupts
			jsr	_LDEBB				; and go to timed routine
			bcs	_BE71F				; if carry set then E71F
			tax					; then X=A
			lda	#$00				; A=0

_BE71F:			tay					; Y=A
			rts					; and return
								;
								; scan keyboard
_BE721:			txa					; A=X
			eor	#$7f				; convert to keyboard input
			tax					; X=A
			jsr	_LF068				; then scan keyboard
			rol					; put bit 7 into carry
_OSBYTE_130:		ldx	#$ff				; X=&FF
			ldy	#$ff				; Y=&FF
			bcs	_BE731				; if bit 7 of A was set goto E731 (RTS)
			inx					; else X=0
			iny					; and Y=0
_BE731:			rts					; and exit

;********** check occupancy of input or free space of output buffer *******
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

_BE732:			txa					; buffer number in A
			eor	#$ff				; invert it
			tax					; X=A
			cpx	#$02				; is X>1
_LE738:			clv					; clear V flag
			bvc	_BE73E				; and goto E73E count buffer

_LE73B:			bit	_BD9B7				; set V
_BE73E:			jmp	(VEC_CNPV)			; CNPV defaults to E1D1

;************* check RS423 input buffer ************************************

_LE741:			sec					
			ldx	#$01				; X=1 to point to buffer
			jsr	_LE738				; and count it
			cpy	#$01				; if the hi byte of the answer is 1 or more
			bcs	_BE74E				; then Return
			cpx	OSB_SER_BUF_EX			; else compare with minimum buffer space
_BE74E:			rts					; and exit


;*************************************************************************
;*									 *
;*	 OSBYTE 128  READ ADC CHANNEL					 *
;*									 *
;*************************************************************************

;ON Entry: X=0		   Exit Y contains number of last channel converted
;	   X=channel number	  X,Y contain 16 bit value read from channe
;	   X<0 Y=&FF		  X returns information about various buffers
;	   X=&FF (keyboard )	  X=number of characters in buffer
;	   X=&FE (RS423 Input)	  X=number of characters in buffer
;	   X=&FD (RS423 output)	  X=number of empty spaces in buffer
;	   X=&FC (Printer)	  X=number of empty spaces in buffer
;	   X=&FB (sound 0)	  X=number of empty spaces in buffer
;	   X=&FA (sound 1)	  X=number of empty spaces in buffer
;	   X=&F9 (sound 2)	  X=number of empty spaces in buffer
;	   X=&F8 (sound 3)	  X=number of empty spaces in buffer
;	   X=&F7 (Speech )	  X=number of empty spaces in buffer

_OSBYTE_128:		bmi	_BE732				; if X is -ve then E732 count spaces
			beq	_BE75F				; if X=0 then E75F
			cpx	#$05				; else check for Valid channel
			bcs	_OSBYTE_130			; if not E729 set X & Y to 0 and exit
			ldy	ADC_CHAN4_LO,X			; get conversion values for channel of interest Hi &
			lda	OSW0_MAX_CHAR,X			; lo byte
			tax					; X=lo byte
			rts					; and exit

_BE75F:			lda	SYS_VIA_IORB			; read system VIA port B
			ror					; move high nybble to low
			ror					; 
			ror					; 
			ror					; 
			eor	#$ff				; and invert it
			and	#$03				; isolate the FIRE buttons
			ldy	ADC_CHAN_FLAG			; get analogue system flag byte
			stx	ADC_CHAN_FLAG			; store X here
			tax					; A=X bits 0 and 1 indicate fire buttons
			rts					; and return


;**************************************************************************
;**************************************************************************
;**									 **
;**	 OSBYTE	 DEFAULT ENTRY POINT					 **
;**									 **
;**	 pointed to by default BYTEV					 **
;**									 **
;**************************************************************************
;**************************************************************************

_BYTEV:			pha					; save A
			php					; save Processor flags
			sei					; disable interrupts
			sta	OSW_A				; store A,X,Y in zero page
			stx	OSW_X				; 
			sty	OSW_Y				; 
			ldx	#$07				; X=7 to signal osbyte is being attempted
			cmp	#$75				; if A=0-116
			bcc	_BE7C2				; then E7C2
			cmp	#$a1				; if A<161
			bcc	_BE78E				; then E78E
			cmp	#$a6				; if A=161-165
			bcc	_BE7C8				; then EC78
			clc					; clear carry

_BE78A:			lda	#$a1				; A=&A1
			adc	#$00				; 

;********* process osbyte calls 117 - 160 *****************************

_BE78E:			sec					; set carry
			sbc	#$5f				; convert to &16 to &41 (22-65)

_BE791:			asl					; double it (44-130)
			sec					; set carry

_BE793:			sty	OSW_Y				; store Y
			tay					; Y=A
			bit	OSB_ECONET_INT			; read econet intercept flag
			bpl	_BE7A2				; if no econet intercept required E7A2

			txa					; else A=X
			clv					; V=0
			jsr	_NETV				; to JMP via ECONET vector
			bvs	_LE7BC				; if return with V set E7BC

_BE7A2:			lda	_OSBYTE_TABLE + 1,Y		; get address from table
			sta	MOS_WS_1			; store it as hi byte
			lda	_OSBYTE_TABLE,Y			; repeat for lo byte
			sta	MOS_WS_0			; 
			lda	OSW_A				; restore A
			ldy	OSW_Y				; Y
			bcs	_BE7B6				; if carry is set E7B6

			ldy	#$00				; else
			lda	(OSW_X),Y			; get value from address pointed to by &F0/1 (Y,X)

_BE7B6:			sec					; set carry
			ldx	OSW_X				; restore X
			jsr	_LF058				; call &FA/B

_LE7BC:			ror					; C=bit 0
			plp					; get back flags
			rol					; bit 0=Carry
			pla					; get back A
			clv					; clear V
			rts					; and exit

;*************** Process OSBYTE CALLS BELOW &75 **************************

_BE7C2:			ldy	#$00				; Y=0
			cmp	#$16				; if A<&16
			bcc	_BE791				; goto E791

_BE7C8:			php					; push flags
			php					; push flags

_BE7CA:			pla					; pull flags
			pla					; pull flags
			jsr	_OSBYTE_143			; offer paged ROMS service 7/8 unrecognised osbyte/word
			bne	_BE7D6				; if roms don't recognise it then E7D6
			ldx	OSW_X				; else restore X
			jmp	_LE7BC				; and exit

_BE7D6:			plp					; else pull flags
			pla					; and A
			bit	_BD9B7				; set V and C
			rts					; and return

_CFS_CHECK_BUSY:	lda	CRFS_ACTIVE			; read cassette critical flag bit 7 = busy
			bmi	_BE812				; if busy then EB12

			lda	#$08				; else A=8 to check current Catalogue status
			and	CRFS_STATUS			; by anding with CFS status flag
			bne	__check_busy_cfs_done		; if not set (not in use) then E7EA RTS
			lda	#$88				; A=%10001000
			and	CRFS_OPTS			; AND with FS options (short msg bits)
__check_busy_cfs_done:	rts					; RETURN


;**************************************************************************
;**************************************************************************
;**									 **
;**	 OSWORD	 DEFAULT ENTRY POINT					 **
;**									 **
;**	 pointed to by default WORDV					 **
;**									 **
;**************************************************************************
;**************************************************************************

_WORDV:			pha					; Push A
			php					; Push flags
			sei					; disable interrupts
			sta	OSW_A				; store A,X,Y
			stx	OSW_X				; 
			sty	OSW_Y				; 
			ldx	#$08				; X=8
			cmp	#$e0				; if A=>224
			bcs	_BE78A				; then E78A with carry set

			cmp	#$0e				; else if A=>14
			bcs	_BE7C8				; else E7C8 with carry set pass to ROMS & exit

			adc	#$44				; add to form pointer to table
			asl					; double it
			bcc	_BE793				; goto E793 ALWAYS!! (carry clear E7F8)
								; this reads bytes from table and enters routine


;*************************************************************************
;*									 *
;*	 OSWORD	 05   ENTRY POINT					 *
;*									 *
;*	 read a byte from I/O memory					 *
;*									 *
;*************************************************************************
;block of 4 bytes set at address pointed to by 00F0/1 (Y,X)
;XY +0	ADDRESS of byte
;   +4	on exit byte read

_OSWORD_5:		jsr	_LE815				; set up address of data block
			lda	(MOS_WS_0-1,X)			; get byte
			sta	(OSW_X),Y			; store it
			rts					; exit


;*************************************************************************
;*									 *
;*	 OSWORD	 06   ENTRY POINT					 *
;*									 *
;*	 write a byte to I/O memory					 *
;*									 *
;*************************************************************************
;block of 5 bytes set at address pointed to by 00F0/1 (Y,X)
;XY +0	ADDRESS of byte
;   +4	byte to be written

_OSWORD_6:		jsr	_LE815				; set up address
			lda	(OSW_X),Y			; get byte
			sta	(MOS_WS_0-1,X)			; store it
_BE812:			lda	#$00				; a=0
			rts					; exit

;********************: set up data block *********************************

_LE815:			sta	MOS_WS_0			; &FA=A
			iny					; Y=1
			lda	(OSW_X),Y			; get byte from block
			sta	MOS_WS_1			; store it
			ldy	#$04				; Y=4
_BE81E:			ldx	#$01				; X=1
			rts					; and exit


;*************************************************************************
;*									 *
;*	 OSBYTE	 00   ENTRY POINT					 *
;*									 *
;*	 read OS version number						 *
;*									 *
;*************************************************************************

_OSBYTE_0:		bne	_BE81E				; if A <> 0 then exit else print error
			brk					; 
			.byte	$f7				; error number
			.byte	"OS 1.20"			; error message
			brk					


