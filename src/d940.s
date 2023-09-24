;*************************************************************************
;*************************************************************************
;**									**
;**	 SYSTEM STARTUP							**
;**									**
;*************************************************************************
;*************************************************************************

;* DEFAULT PAGE &02 SETTINGS (VECTORS, OSBYTE VARIABLES)
;* RESET CODE

;*************************************************************************
;*									 *
;*	 DEFAULT SYSTEM SETTINGS FOR PAGE &02				 *
;*									 *
;*************************************************************************

; -------------------------------------------------------------------------
; |									  |
; |	  DEFAULT VECTOR TABLE						  |
; |									  |
; -------------------------------------------------------------------------

			.org	$d940

_VECTOR_TABLE:		.word	_USERV				; USERV				&200
			.word	_BRKV				; BRKV				&202
			.word	_IRQ1V				; IRQ1V				&204
			.word	_IRQ2V				; IRQ2V				&206
			.word	_CLIV				; CLIV				&208
			.word	_BYTEV				; BYTEV				&20A
			.word	_WORDV				; WORDV				&20C
			.word	_NVWRCH				; WRCHV				&20E
			.word	_NVRDCH				; RDCHV				&210
			.word	_FILEV				; FILEV				&212
			.word	_ARGSV				; ARGSV				&214
			.word	_BGETV				; BGETV				&216
			.word	_BPUTV				; BPUTV				&218
			.word	_NOTIMPV			; GBPBV				&21A
			.word	_FINDV				; FINDV				&21C
			.word	_FSCV				; FSCV				&21E
			.word	_NOTIMPV			; EVNTV				&220
			.word	_NOTIMPV			; UPTV				&222
			.word	_NOTIMPV			; NETV				&224
			.word	_NOTIMPV			; VDUV				&226
			.word	_KEYV				; KEYV				&228
			.word	_INSBV				; INSBV				&22A
			.word	_REMVB				; REMVB				&22C
			.word	_CNPV				; CNPV				&22E
			.word	_NOTIMPV			; IND1V				&230
			.word	_NOTIMPV			; IND2V				&232
			.word	_NOTIMPV			; IND3V				&234

; -------------------------------------------------------------------------
; |									  |
; |	  DEFAULT MOS VARIABLES SETTINGS				  |
; |									  |
; -------------------------------------------------------------------------

;* Read/Written by OSBYTE &A6 to &FC

			.word	$0190				; OSBYTE variables base address		 &236	*FX166/7
								; (address to add to osbyte number)
			.word	$0d9f				; Address of extended vectors		 &238	*FX168/9
			.word	ROM_TABLE			; Address of ROM information table	 &23A	*FX170/1
			.word	_KEY_TRANS_TABLE_1 - $10	; Address of key translation table	 &23C	*FX172/3
			.word	VDU_G_WIN_L			; Address of VDU variables		 &23E	*FX174/5

			.byte	$00				; CFS/Vertical sync Timeout counter	 &240	*FX176
			.byte	$00				; Current input buffer number		 &241	*FX177
			.byte	$ff				; Keyboard interrupt processing flag	 &242	*FX178
			.byte	$00				; Primary OSHWM (default PAGE)		 &243	*FX179
			.byte	$00				; Current OSHWM (PAGE)			 &244	*FX180
			.byte	$01				; RS423 input mode			 &245	*FX181
			.byte	$00				; Character explosion state		 &246	*FX182
			.byte	$00				; CFS/RFS selection, CFS=0 ROM=2	 &247	*FX183
			.byte	$00				; Video ULA control register copy	 &248	*FX184
			.byte	$00				; Pallette setting copy			 &249	*FX185
			.byte	$00				; ROM number selected at last BRK	 &24A	*FX186
			.byte	$ff				; BASIC ROM number			 &24B	*FX187
			.byte	$04				; Current ADC channel number		 &24C	*FX188
			.byte	$04				; Maximum ADC channel number		 &24D	*FX189
			.byte	$00				; ADC conversion 0/8bit/12bit		 &24E	*FX190
			.byte	$ff				; RS423 busy flag (bit 7=0, busy)	 &24F	*FX191

			.byte	$56				; ACIA control register copy		 &250	*FX192
			.byte	$19				; Flash counter				 &251	*FX193
			.byte	$19				; Flash mark period count		 &252	*FX194
			.byte	$19				; Flash space period count		 &253	*FX195
			.byte	$32				; Keyboard auto-repeat delay		 &254	*FX196
			.byte	$08				; Keyboard auto-repeat rate		 &255	*FX197
			.byte	$00				; *EXEC file handle			 &256	*FX198
			.byte	$00				; *SPOOL file handle			 &257	*FX199
			.byte	$00				; Break/Escape handing			 &258	*FX200
			.byte	$00				; Econet keyboard disable flag		 &259	*FX201
			.byte	$20				; Keyboard status			 &25A	*FX202
								; bit 3=1 shift pressed
								; bit 4=0 caps	lock
								; bit 5=0 shift lock
								; bit 6=1 control bit
								; bit 7=1 shift enabled
			.byte	$09				; Serial input buffer full threshold	 &25B	*FX203
			.byte	$00				; Serial input suppression flag		 &25C	*FX204
			.byte	$00				; Cassette/RS423 flag (0=CFS, &40=RS423) &25D	*FX205
			.byte	$00				; Econet OSBYTE/OSWORD interception flag &25E	*FX206
			.byte	$00				; Econet OSRDCH interception flag	 &25F	*FX207

			.byte	$00				; Econet OSWRCH interception flag	 &260	*FX208
			.byte	$50				; Speech enable/disable flag (&20/&50)	 &261	*FX209
			.byte	$00				; Sound output disable flag		 &262	*FX210
			.byte	$03				; BELL channel number			 &263	*FX211
			.byte	$90				; BELL amplitude/Envelope number	 &264	*FX212
			.byte	$64				; BELL frequency			 &265	*FX213
			.byte	$06				; BELL duration				 &266	*FX214
			.byte	$81				; Startup message/!BOOT error status	 &267	*FX215
			.byte	$00				; Length of current soft key string	 &268	*FX216
			.byte	$00				; Lines printed since last paged halt	 &269	*FX217
			.byte	$00				; 0-(Number of items in VDU queue)	 &26A	*FX218
			.byte	$09				; TAB key value				 &26B	*FX219
			.byte	$1b				; ESCAPE character			 &26C	*FX220

				; The following are input buffer code interpretation variables for
				; bytes entered into the input buffer with b7 set (is 128-255).
				; The standard keyboard only enters characters &80-&BF with the
				; function keys, but other characters can be entered, for instance
				; via serial input of via other keyboard input systems.
				; 0=ignore key
				; 1=expand as soft key
				; 2-FF add to base for ASCII code
			.byte	$01				; C0-&CF				 &26D	*FX221
			.byte	$d0				; D0-&DF				 &26E	*FX222
			.byte	$e0				; E0-&EF				 &26F	*FX223
			.byte	$f0				; F0-&FF				 &270	*FX224
			.byte	$01				; 80-&8F function key			 &271	*FX225
			.byte	$80				; 90-&9F Shift+function key		 &272	*FX226
			.byte	$90				; A0-&AF Ctrl+function key		 &273	*FX227
			.byte	$00				; B0-&BF Shift+Ctrl+function key	 &274	*FX228

			.byte	$00				; ESCAPE key status (0=ESC, 1=ASCII)	 &275	*FX229
			.byte	$00				; ESCAPE action				 &276	*FX230
_BD9B7:			.byte	$ff				; USER 6522 Bit IRQ mask		 &277	*FX231
			.byte	$ff				; 6850 ACIA Bit IRQ bit mask		 &278	*FX232
			.byte	$ff				; System 6522 IRQ bit mask		 &279	*FX233
			.byte	$00				; Tube prescence flag			 &27A	*FX234
			.byte	$00				; Speech processor prescence flag	 &27B	*FX235
			.byte	$00				; Character destination status		 &27C	*FX236
			.byte	$00				; Cursor editing status			 &27D	*FX237

;****************** Soft Reset high water mark ***************************

			.byte	$00				; unused				 &27E	*FX238
			.byte	$00				; unused				 &27F	*FX239
			.byte	$00				; Country code				 &280	*FX240
			.byte	$00				; User flag				 &281	*FX241
			.byte	$64				; Serial ULA control register copy	 &282	*FX242
			.byte	$05				; Current system clock state		 &283	*FX243
			.byte	$ff				; Soft key consitancy flag		 &284	*FX244
			.byte	$01				; Printer destination			 &285	*FX245
			.byte	$0a				; Printer ignore character		 &286	*FX246

;****************** Hard Reset High water mark ***************************

			.byte	$00				; Break Intercept Vector JMP opcode	 &288	*FX247
			.byte	$00				; Break Intercept Vector address low	 &288	*FX248
			.byte	$00				; Break Intercept Vector address high	 &289	*FX249
			.byte	$00				; unused (memory used for VDU)		 &28A	*FX250
			.byte	$00				; unused (memory used for display)	 &28B	*FX251
			.byte	$ff				; Current language ROM number		 &28C	*FX252

;****************** Power-On Reset High Water mark ***********************


;**************************************************************************
;**************************************************************************
;**									 **
;**	 RESET (BREAK) ENTRY POINT					 **
;**									 **
;**	 Power up Enter with nothing set, 6522 System VIA IER bits	 **
;**	 0 to 6 will be clear						 **
;**									 **
;**	 BREAK IER bits 0 to 6 one or more will be set 6522 IER		 **
;**	 not reset by BREAK						 **
;**									 **
;**************************************************************************
;**************************************************************************

_RESET_HANDLER:		lda	#$40				; set NMI first instruction to RTI
			sta	NMI_HANDLER			; NMI ram start

			sei					; disable interrupts just in case
			cld					; clear decimal flag
			ldx	#$ff				; reset stack to where it should be
			txs					; (&1FF)
			lda	SYS_VIA_IER			; read interupt enable register of the system VIA
			asl					; shift bit 7 into carry
			pha					; save what's left
			beq	_RESET_MEMCLR			; if Power up A=0 so D9E7
			lda	OSB_ESC_BRK			; else if BREAK pressed read BREAK Action flags (set by
								; *FX200,n)
			lsr					; divide by 2
			cmp	#$01				; if (bit 1 not set by *FX200)
			bne	__reset_setup_sys_via		; then &DA03
			lsr					; divide A by 2 again (A=0 if *FX200,2/3 else A=n/4

;********** clear memory routine ******************************************

_RESET_MEMCLR:		ldx	#$04				; get page to start clearance from (4)
			stx	$01				; store it in ZP 01
			sta	$00				; store A at 00

			tay					; and in Y to set loop counter

__reset_memclr_loop:	sta	($00),Y				; clear store
			cmp	$01				; until address &01 =0
			beq	__reset_memclr_done		; 
			iny					; increment pointer
			bne	__reset_memclr_loop		; if not zero loop round again
			iny					; else increment again (Y=1) this avoids overwriting
								; RTI instruction at &D00
			inx					; increment X
			inc	$01				; increment &01
			bpl	__reset_memclr_loop		; loop until A=&80 then exit
								; note that RAM addressing for 16k loops around so
								; &4000=&00 hence checking &01 for 00.	This avoids
								; overwriting zero page on BREAK


__reset_memclr_done:	stx	OSB_RAM_PAGES			; writes marker for available RAM 40 =16k,80=32
			stx	OSB_SOFTKEY_FLG			; write soft key consistency flag

;**+********** set up system VIA *****************************************

__reset_setup_sys_via:	ldx	#$0f				; set PORT B to output on bits 0-3 Input 4-7
			stx	SYS_VIA_DDRB			; 


;*************************************************************************
;*									 *
;*	  set addressable latch IC 32 for peripherals via PORT B	 *
;*									 *
;*	 ;bit 3 set sets addressed latch high adds 8 to VIA address	 *
;*	 ;bit 3 reset sets addressed latch low				 *
;*									 *
;*	 Peripheral		 VIA bit 3=0		 VIA bit 3=1	 *
;*									 *
;*	 Sound chip		 Enabled		 Disabled	 *
;*	 speech chip (RS)	 Low			 High		 *
;*	 speech chip (WS)	 Low			 High		 *
;*	 Keyboard Auto Scan	 Disabled		 Enabled	 *
;*	 C0 address modifier	 Low			 High		 *
;*	 C1 address modifier	 Low			 High		 *
;*	 Caps lock  LED		 ON			 OFF		 *
;*	 Shift lock LED		 ON			 OFF		 *
;*									 *
;*	 C0 & C1 are involved with hardware scroll screen address	 *
;*************************************************************************

				; X=&F on entry

_RESET_LATCH:		dex					; loop start
			stx	SYS_VIA_IORB			; write latch IC32
			cpx	#$09				; is it 9
			bcs	_RESET_LATCH			; if so go back and do it again
								; X=8 at this point
								; Caps lock On, SHIFT lock undetermined
								; Keyboard Autoscan on
								; sound disabled (may still sound)
			inx					; X=9
__reset_keyread_loop:	txa					; A=X
			jsr	_KEYBOARD_SCAN			; interrogate keyboard
			cpx	#$80				; for keyboard links 9-2 and CTRL key (1)
			ror	IRQ_COPY_A			; rotate MSB into bit 7 of &FC

			tax					; get back value of X for loop
			dex					; decrement it
			bne	__reset_keyread_loop		; and if >0 do loop again
								; on exit if Carry set link 3 made
								; link 2 = bit 0 of &FC and so on
								; if CTRL pressed bit 7 of &FC=1
								; X=0
			stx	OSB_LAST_BREAK			; clear last BREAK flag
			rol	IRQ_COPY_A			; CTRL is now in carry &FC is keyboard links
			jsr	_SET_LEDS			; set LEDs carry on entry  bit 7 of A on exit
			ror					; get carry back into carry flag

;****** set up page 2 ****************************************************

			ldx	#$9c				; 
			ldy	#$8d				; 
			pla					; get back A from &D9DB
			beq	_BDA36				; if A=0 power up reset so DA36 with X=&9C Y=&8D
			ldy	#$7e				; else Y=&7E
			bcc	_BDA42				; and if not CTRL-BREAK DA42 WARM RESET
			ldy	#$87				; else Y=&87 COLD RESET
			inc	OSB_LAST_BREAK			; &28D=1

_BDA36:			inc	OSB_LAST_BREAK			; &28D=&28D+1
			lda	IRQ_COPY_A			; get keyboard links set
			eor	#$ff				; invert
			sta	OSB_STARTUP_OPT			; and store at &28F
			ldx	#$90				; X=&90

;**********: set up page 2 *************************************************

				; on entry    &28D=0 Warm reset, X=&9C, Y=&7E
				; &28D=1 Power up  , X=&90, Y=&8D
				; &28D=2 Cold reset, X=&9C, Y=&87

_BDA42:			lda	#$00				; A=0
_BDA44:			cpx	#$ce				; zero &200+X to &2CD
			bcc	_BDA4A				; 
			lda	#$ff				; then set &2CE to &2FF to &FF
_BDA4A:			sta	VEC_USERV,X			; 
			inx					; 
			bne	_BDA44				; 
								; A=&FF X=0
			sta	USR_VIA_DDRA			; set port A of user via to all outputs (printer out)

			txa					; A=0
			ldx	#$e2				; X=&E2
_BDA56:			sta	$00,X				; zero zeropage &E2 to &FF
			inx					; 
			bne	_BDA56				; X=0

_BDA5B:			lda	_VECTOR_TABLE-1,Y		; copy data from &D93F+Y
			sta	VEC_USERV-1,Y			; to &1FF+Y
			dey					; until
			bne	_BDA5B				; 1FF+Y=&200

			lda	#$62				; A=&62
			sta	KEYNUM_LAST			; store in &ED
			jsr	_LFB0A				; set up ACIA
								; X=0

;************** clear interrupt and enable registers of Both VIAs ********

_RESET_VIAS:		lda	#$7f				; 
			inx					; 
__reset_vias_loop:	sta	SYS_VIA_IFR,X			; 
			sta	USR_VIA_IFR,X			; 
			dex					; 
			bpl	__reset_vias_loop		; 

			cli					; briefly allow interrupts to clear anything pending
			sei					; disallow again N.B. All VIA IRQs are disabled
			bit	IRQ_COPY_A			; if bit 6=1 then JSR &F055 (normally 0)
			bvc	__reset_vias_setirqs		; else DA80
			jsr	_LF055				; F055 JMP (&FDFE) probably causes a BRK unless
								; hardware there redirects it.
								;
__reset_vias_setirqs:	ldx	#$f2				; enable interrupts 1,4,5,6 of system VIA
			stx	SYS_VIA_IER			; 
								; 0	 Keyboard enabled as needed
								; 1	 Frame sync pulse
								; 4	 End of A/D conversion
								; 5	 T2 counter (for speech)
								; 6	 T1 counter (10 mSec intervals)
								;
			ldx	#$04				; set system VIA PCR
			stx	SYS_VIA_PCR			; 
								; CA1 to interrupt on negative edge (Frame sync)
								; CA2 Handshake output for Keyboard
								; CB1 interrupt on negative edge (end of conversion)
								; CB2 Negative edge (Light pen strobe)
								;
			lda	#$60				; set system VIA ACR
			sta	SYS_VIA_ACR			; 
								; disable latching
								; disable shift register
								; T1 counter continuous interrupts
								; T2 counter timed interrupt

			lda	#$0e				; set system VIA T1 counter (Low)
			sta	SYS_VIA_T1L_L			; 
								; this becomes effective when T1 hi set

			sta	USR_VIA_PCR			; set user VIA PCR
								; CA1 interrupt on -ve edge (Printer Acknowledge)
								; CA2 High output (printer strobe)
								; CB1 Interrupt on -ve edge (user port)
								; CB2 Negative edge (user port)

			sta	ADC_SR				; set up A/D converter
								; Bits 0 & 1 determine channel selected
								; Bit 3=0 8 bit conversion bit 3=1 12 bit

			cmp	USR_VIA_PCR			; read user VIA IER if = &0E then DAA2 chip present
			beq	_BDAA2				; so goto DAA2
			inc	OSB_UVIA_IRQ_M			; else increment user VIA mask to 0 to bar all
								; user VIA interrupts

_BDAA2:			lda	#$27				; set T1 (hi) to &27 this sets T1 to &270E (9998 uS)
			sta	SYS_VIA_T1L_H			; or 10msec, interrupts occur every 10msec therefore
			sta	SYS_VIA_T1C_H			; 

			jsr	_LEC60				; clear the sound channels

			lda	OSB_SERPROC			; read serial ULA control register
			and	#$7f				; zero bit 7
			jsr	_LE6A7				; and set up serial ULA

			ldx	OSB_SOFTKEY_FLG			; get soft key status flag
			beq	_BDABD				; if 0 (keys OK) then DABD
			jsr	_OSBYTE_18			; else reset function keys


;*************************************************************************
;*									 *
;*	 Check sideways ROMs and make ROM list				 *
;*									 *
;*************************************************************************

				; X=0
_BDABD:			jsr	_LDC16				; set up ROM latch and RAM copy to X
			ldx	#$03				; set X to point to offset in table
			ldy	ROM_CC_OFFSET			; get copyright offset from ROM

				; DF0C = ")C(",0
_BDAC5:			lda	ROM_LANGUAGE,Y			; get first byte
			cmp	_MSG_COPYSYM,X			; compare it with table byte
			bne	_BDAFB				; if not the same then goto DAFB
			iny					; point to next byte
			dex					; (s)
			bpl	_BDAC5				; and if still +ve go back to check next byte

				; this point is reached if 5 bytes indicate valid
				; ROM (offset +4 in (C) string)


;*************************************************************************
;* Check first 1K of each ROM against higher priority ROMs to ensure that*
;* there are no duplicates, if duplicate found ignore lower priority ROM *
;*************************************************************************

			ldx	ROM_SELECT			; get RAM copy of ROM No. in X
			ldy	ROM_SELECT			; and Y

_BDAD5:			iny					; increment Y to check
			cpy	#$10				; if ROM 15 is current ROM
			bcs	_BDAFF				; if equal or more than 16 goto &DAFF
								; to store catalogue byte
			tya					; else put Y in A
			eor	#$ff				; invert it
			sta	MOS_WS_0			; and store at &FA
			lda	#$7f				; store &7F at
			sta	MOS_WS_1			; &FB to get address &7FFF-Y

_BDAE3:			sty	ROM_LATCH			; set new ROM
			lda	(MOS_WS_0),Y			; Get byte
			stx	ROM_LATCH			; switch back to previous ROM
			cmp	(MOS_WS_0),Y			; and compare with previous byte called
			bne	_BDAD5				; if not the same then go back and do it again
								; with next rom up
			inc	MOS_WS_0			; else increment &FA to point to new location
			bne	_BDAE3				; if &FA<>0 then check next byte
			inc	MOS_WS_1			; else inc &FB
			lda	MOS_WS_1			; and check that it doesn't exceed
			cmp	#$84				; &84 (1k checked)
			bcc	_BDAE3				; then check next byte(s)

_BDAFB:			ldx	ROM_SELECT			; X=(&F4)
			bpl	_BDB0C				; if +ve then &DB0C

_BDAFF:			lda	ROM_TYPE			; get rom type
			sta	ROM_TABLE,X			; store it in catalogue
			and	#$8f				; check for BASIC (bit 7 not set)
			bne	_BDB0C				; if not BASIC the DB0C
			stx	OSB_BASIC_ROM			; else store X at BASIC pointer

_BDB0C:			inx					; increment X to point to next ROM
			cpx	#$10				; is it 15 or less
			bcc	_BDABD				; if so goto &DABD for next ROM

; OS SERIES V
; GEOFF COX
;*************************************************************************
;*									 *
;*	 Check SPEECH System						 *
;*									 *
;*************************************************************************

				; X=&10
			bit	SYS_VIA_IORB			; if bit 7 low then we have speech system fitted
			bmi	_BDB27				; else goto DB27

			dec	OSB_SPCH_FOUND			; (027B)=&FF to indicate speech present

_BDB19:			ldy	#$ff				; Y=&FF
			jsr	_OSBYTE_159			; initialise speech generator
			dex					; via this
			bne	_BDB19				; loop
								; X=0
			stx	SYS_VIA_T2C_L			; set T2 timer for speech
			stx	SYS_VIA_T2C_H			; 

;*********** SCREEN SET UP **********************************************
				; X=0
_BDB27:			lda	OSB_STARTUP_OPT			; get back start up options (mode)
			jsr	STARTUP				; then jump to screen initialisation

			ldy	#$ca				; Y=&CA
			jsr	_LE4F1				; to enter this in keyboard buffer
								; this enables the *KEY 10 facility

;********* enter BREAK intercept with Carry Clear ************************

			jsr	_LEAD9				; check to see if BOOT address is set up, if so
								; JMP to it

			jsr	_LF140				; set up cassette options
			lda	#$81				; test for tube to FIFO buffer 1
			sta	TUBE_FIFO1_SR			; 
			lda	TUBE_FIFO1_SR			; 
			ror					; put bit 0 into carry
			bcc	_BDB4D				; if no tube then DB4D
			ldx	#$ff				; else
			jsr	_OSBYTE_143			; issue ROM service call &FF
								; to initialise TUBE system
			bne	_BDB4D				; if not 0 on exit (Tube not initialised) DB4D
			dec	OSB_TUBE_FOUND			; else set tube flag to show it's active

_BDB4D:			ldy	#$0e				; set current value of PAGE
			ldx	#$01				; issue claim absolute workspace call
			jsr	_OSBYTE_143			; via F168
			ldx	#$02				; send private workspace claim call
			jsr	_OSBYTE_143			; via F168
			sty	OSB_OSHWM_DEF			; set primary OSHWM
			sty	OSB_OSHWM_CUR			; set current OSHWM
			ldx	#$fe				; issue call for Tube to explode character set etc.
			ldy	OSB_TUBE_FOUND			; Y=FF if tube present else Y=0
			jsr	_OSBYTE_143			; and make call via F168

			and	OSB_BOOT_DISP			; if A=&FE and bit 7 of 0267 is set then continue
			bpl	_BDB87				; else ignore start up message
			ldy	#$02				; output to screen
			jsr	_PRINT_PAGEC3_STRING		; 'BBC Computer ' message
			lda	OSB_LAST_BREAK			; 0=warm reset, anything else continue
			beq	_BDB82				; 
			ldy	#$16				; by checking length of RAM
			bit	OSB_RAM_PAGES			; 
			bmi	_BDB7F				; and either
			ldy	#$11				; 
_BDB7F:			jsr	_PRINT_PAGEC3_STRING		; finishing message with '16K' or '32K'
_BDB82:			ldy	#$1b				; and two newlines
			jsr	_PRINT_PAGEC3_STRING		; 

;*********: enter BREAK INTERCEPT ROUTINE WITH CARRY SET (call 1)

_BDB87:			sec					; 
			jsr	_LEAD9				; look for break intercept jump do *TV etc
			jsr	_OSBYTE_118			; set up LEDs in accordance with keyboard status
			php					; save flags
			pla					; and get back in A
			lsr					; zero bits 4-7 and bits 0-2 bit 4 which was bit 7
			lsr					; may be set
			lsr					; 
			lsr					; 
			eor	OSB_STARTUP_OPT			; eor with start-up options which may or may not
			and	#$08				; invert bit 4
			tay					; Y=A
			ldx	#$03				; make fs initialisation call, passing boot option in Y
			jsr	_OSBYTE_143			; Eg, RUN, EXEC or LOAD !BOOT file
			beq	_BDBBE				; if a ROM accepts this call then DBBE
			tya					; else put Y in A
			bne	_LDBB8				; if Y<>0 DBB8
			lda	#$8d				; else set up standard cassete baud rates
			jsr	_OSBYTE_140_141			; via &F135

			ldx	#$d2				; 
			ldy	#$ea				; 
			dec	OSB_BOOT_DISP			; decrement ignore start up message flag
			jsr	OSCLI				; and execute */!BOOT
			inc	OSB_BOOT_DISP			; restore start up message flag
			bne	_BDBBE				; if not zero then DBBE

_LDBB8:			lda	#$00				; else A=0
			tax					; X=0
			jsr	_LF137				; set tape speed

;******** Preserve current language on soft RESET ************************

_BDBBE:			lda	OSB_LAST_BREAK			; get last RESET Type
			bne	_BDBC8				; if not soft reset DBC8

			ldx	OSB_CUR_LANG			; else get current language ROM address
			bpl	_BDBE6				; if +ve (language available) then skip search routine


;*************************************************************************
;*									 *
;*	 SEARCH FOR LANGUAGE TO ENTER (Highest priority)		 *
;*									 *
;*************************************************************************

_BDBC8:			ldx	#$0f				; set pointer to highest available rom

_BDBCA:			lda	ROM_TABLE,X			; get rom type from map
			rol					; put hi-bit into carry, bit 6 into bit 7
			bmi	_BDBE6				; if bit 7 set then ROM has a language entry so DBE6

			dex					; else search for language until X=&ff
			bpl	_BDBCA				; 

;*************** check if tube present ***********************************

			lda	#$00				; if bit 7 of tube flag is set BMI succeeds
			bit	OSB_TUBE_FOUND			; and TUBE is connected else
			bmi	_START_TUBE			; make error

;********* no language error ***********************************************

			brk					; 
			.byte	$f9				; error number
			.byte	"Language?"			; message
			brk					; 

_BDBE6:			clc					; 


;*************************************************************************
;*									 *
;*	 OSBYTE 142 - ENTER LANGUAGE ROM AT &8000			 *
;*									 *
;*	 X=rom number C set if OSBYTE call clear if initialisation	 *
;*									 *
;*************************************************************************

_OSBYTE_142:		php					; save flags
			stx	OSB_CUR_LANG			; put X in current ROM page
			jsr	_LDC16				; select that ROM
			lda	#$80				; A=128
			ldy	#$08				; Y=8
			jsr	_PRINT_PAGE_STRING		; display text string held in ROM at &8008,Y
			sty	ERR_MSG_PTR			; save Y on exit (end of language string)
			jsr	OSNEWL				; two line feeds
			jsr	OSNEWL				; are output
			plp					; then get back flags
			lda	#$01				; A=1 required for language entry
			bit	OSB_TUBE_FOUND			; check if tube exists
			bmi	_START_TUBE			; and goto DC08 if it does
			jmp	ROM_LANGUAGE			; else enter language at &8000


;*************************************************************************
;*									 *
;*	 TUBE FOUND, ENTER TUBE SOFTWARE				 *
;*									 *
;*************************************************************************

_START_TUBE:		jmp	TUBE_ENTRY			; enter tube environment


;*************************************************************************
;*									 *
;*	 OSRDRM entry point						 *
;*									 *
;*	 get byte from PHROM or page ROM				 *
;*	 Y= rom number, address is in &F6/7				 *
;*************************************************************************

_OSRDRM:		ldx	ROM_SELECT			; get current ROM number into X
			sty	ROM_SELECT			; store new number in &F4
			sty	ROM_LATCH			; switch in ROM
			ldy	#$00				; get current PHROM address
			lda	(ROM_PTR),Y			; and get byte

;******** Set up Sideways ROM latch and RAM copy *************************
				; on entry X=ROM number

_LDC16:			stx	ROM_SELECT			; RAM copy of rom latch
			stx	ROM_LATCH			; write to rom latch
			rts					; and return

