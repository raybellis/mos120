; BBC Operation System OS 1.20		Startup Strings and Tables

			.org	$c300

STARTUP:		jmp	$cb1d				; Initialise screen with mode in A.

			.byte	$0d,"BBC Computer ",0		

			.byte	"16K",7,0			

			.byte	"32K",7,0			

			.byte	$08,$0d,$0d			; Termination byte in next table


;****** 16 COLOUR MODE BYTE MASK LOOK UP TABLE******

_COL16_MASK_TAB:	.byte	$00				; 00000000
			.byte	$11				; 00010001
			.byte	$22				; 00100010
			.byte	$33				; 00110011
			.byte	$44				; 01000100
			.byte	$55				; 01010101
			.byte	$66				; 01100110
			.byte	$77				; 01110111
			.byte	$88				; 10001000
			.byte	$99				; 10011001
			.byte	$aa				; 10101010
			.byte	$bb				; 10111011
			.byte	$cc				; 11001100
			.byte	$dd				; 11011101
			.byte	$ee				; 11101110
			.byte	$ff				; 11111111


;****** 4 COLOUR MODE BYTE MASK LOOK UP TABLE******

_COL4_MASK_TAB:		.byte	$00				; 00000000
			.byte	$55				; 01010101
			.byte	$aa				; 10101010
			.byte	$ff				; 11111111


;****** VDU ENTRY POINT LO	 LOOK UP TABLE******

_VDU_TABLE_LO:		.byte	$11				; 00010001
			.byte	$3b				; 00111011
			.byte	$96				; 10010110
			.byte	$a1				; 10100001
			.byte	$ad				; 10101101
			.byte	$b9				; 10111001
			.byte	$11				; 00010001
			.byte	$6f				; 01101111
			.byte	$c5				; 11000101
			.byte	$64				; 01100100
			.byte	$f0				; 11110000
			.byte	$5b				; 01011011
			.byte	$59				; 01011001
			.byte	$af				; 10101111
			.byte	$8d				; 10001101
			.byte	$a6				; 10100110
			.byte	$c0				; 11000000
			.byte	$f9				; 11111001
			.byte	$fd				; 11111101
			.byte	$92				; 10010010
			.byte	$39				; 00111001
			.byte	$9b				; 10011011
			.byte	$eb				; 11101011
			.byte	$f1				; 11110001
			.byte	$39				; 00111001
			.byte	$8c				; 10001100
			.byte	$bd				; 10111101
			.byte	$11				; 00010001
			.byte	$fa				; 11111010
			.byte	$a2				; 10100010
			.byte	$79				; 01111001
			.byte	$87				; 10000111
			.byte	$ac				; 10101100


;****** VDU ENTRY POINT HI PARAMETER LOOK UP TABLE******

; 1xxxxxxx - no parameters, address high byte
; 0aaapppp - parameter count 16-p, address high byte &C3+a

_VDU_TABLE_HI:		.byte	$c5				; 11000101  VDU 0   - &C511, no parameters
			.byte	$2f				; 00101111  VDU 1   - &C53B, 1 parameter
			.byte	$c5				; 11000101  VDU 2   - &C596, no parameters
			.byte	$c5				; 11000101  VDU 3   - &C5A1, no parameters
			.byte	$c5				; 11000101  VDU 4   - &C5AD, no parameters
			.byte	$c5				; 11000101  VDU 5   - &C5B9, no parameters
			.byte	$c5				; 11000101  VDU 6   - &C511, no parameters
			.byte	$e8				; 11101000  VDU 7   - &E86F, no parameters
			.byte	$c5				; 11000101  VDU 8   - &C5C5, no parameters
			.byte	$c6				; 11000110  VDU 9   - &C664, no parameters
			.byte	$c6				; 11000110  VDU 10  - &C6F0, no parameters
			.byte	$c6				; 11000110  VDU 11  - &C65B, no parameters
			.byte	$c7				; 11000111  VDU 12  - &C759, no parameters
			.byte	$c7				; 11000111  VDU 13  - &C7AF, no parameters
			.byte	$c5				; 11000101  VDU 14  - &C58D, no parameters
			.byte	$c5				; 11000101  VDU 15  - &C5A6, no parameters
			.byte	$c7				; 11000111  VDU 16  - &C7C0, no parameters
			.byte	$4f				; 01001111  VDU 17  - &C7F9, 1 parameter
			.byte	$4e				; 01001110  VDU 18  - &C7FD, 2 parameters
			.byte	$5b				; 01011011  VDU 19  - &C892, 5 parameters
			.byte	$c8				; 11001000  VDU 20  - &C839, no parameters
			.byte	$c5				; 11000101  VDU 21  - &C59B, no parameters
			.byte	$5f				; 01011111  VDU 22  - &C8EB, 1 parameter
			.byte	$57				; 01010111  VDU 23  - &C8F1, 9 parameters
			.byte	$78				; 01111000  VDU 24  - &CA39, 8 parameters
			.byte	$6b				; 01101011  VDU 25  - &C98C, 5 parameters
			.byte	$c9				; 11001001  VDU 26  - &C9BD, no parameters
			.byte	$c5				; 11000101  VDU 27  - &C511, no parameters
			.byte	$3c				; 00111100  VDU 28  - &C6FA, 4 parameters
			.byte	$7c				; 01111100  VDU 29  - &CAA2, 4 parameters
			.byte	$c7				; 11000111  VDU 30  - &C779, no parameters
			.byte	$4e				; 01001110  VDU 31  - &C787, 2 parameters
			.byte	$ca				; 11001010  VDU 127 - &CAAC, no parameters


;****** 640 MULTIPLICATION TABLE  40COL, 80COL MODES  HIBYTE, LOBYTE ******

_MUL640_TABLE:		.word	$0000				; 0*640 = &0000
			.word	$8002				; 1*640 = &0280
			.word	$0005				; 2*640 = &0500
			.word	$8007				; 3*640 = &0780
			.word	$000a				; 4*
			.word	$800c				; 5*
			.word	$000f				; 6*
			.word	$8011				; 7*
			.word	$0014				; 8*
			.word	$8016				; 9*
			.word	$0019				; 10*
			.word	$801b				; 11*
			.word	$001e				; 12*
			.word	$8020				; 13*
			.word	$0023				; 14*
			.word	$8025				; 15*
			.word	$0028				; 16*
			.word	$802a				; 17*
			.word	$002d				; 18*
			.word	$802f				; 19*
			.word	$0032				; 20*
			.word	$8034				; 21*
			.word	$0037				; 22*
			.word	$8039				; 23*
			.word	$003c				; 24*
			.word	$803e				; 25*
			.word	$0041				; 26*
			.word	$8043				; 27*
			.word	$0046				; 28*
			.word	$8048				; 29*
			.word	$004b				; 30*
			.word	$804d				; 31*640 = &4D80


;****** *40 MULTIPLICATION TABLE  TELETEXT  MODE   HIBYTE, LOBYTE  ******

_MUL40_TABLE:		.word	$0000				; 0*40 = &0000
			.word	$2800				; 1*40 = &0028
			.word	$5000				; 2
			.word	$7800				; 3
			.word	$a000				; 4
			.word	$c800				; 5
			.word	$f000				; 6
			.word	$1801				; 7
			.word	$4001				; 8
			.word	$6801				; 9
			.word	$9001				; 10
			.word	$b801				; 11
			.word	$e001				; 12
			.word	$0802				; 13
			.word	$3002				; 14
			.word	$5802				; 15
			.word	$8002				; 16
			.word	$a802				; 17
			.word	$d002				; 18
			.word	$f802				; 19
			.word	$2003				; 20
			.word	$4803				; 21
			.word	$7003				; 22
			.word	$9803				; 23*40 = &0398
			.word	$c003				; 24*40 = &03C0


;****** TEXT WINDOW -BOTTOM ROW LOOK UP TABLE ******

_TEXT_ROW_TABLE:	.byte	$1f				; MODE 0 - 32 ROWS
			.byte	$1f				; MODE 1 - 32 ROWS
			.byte	$1f				; MODE 2 - 32 ROWS
			.byte	$18				; MODE 3 - 25 ROWS
			.byte	$1f				; MODE 4 - 32 ROWS
			.byte	$1f				; MODE 5 - 32 ROWS
			.byte	$18				; MODE 6 - 25 ROWS
			.byte	$18				; MODE 7 - 25 ROWS


;****** TEXT WINDOW -RIGHT HAND COLUMN LOOK UP TABLE ******

_TEXT_COL_TABLE:	.byte	$4f				; MODE 0 - 80 COLUMNS
			.byte	$27				; MODE 1 - 40 COLUMNS
			.byte	$13				; MODE 2 - 20 COLUMNS
			.byte	$4f				; MODE 3 - 80 COLUMNS
			.byte	$27				; MODE 4 - 40 COLUMNS
			.byte	$13				; MODE 5 - 20 COLUMNS
			.byte	$27				; MODE 6 - 40 COLUMNS
			.byte	$27				; MODE 7 - 40 COLUMNS


;*************************************************************************
;*									 *
;*	 SEVERAL OF THE FOLLOWING TABLES OVERLAP EACH OTHER		 *
;*	 SOME ARE DUAL PURPOSE						 *
;*									 *
;*************************************************************************

;************** VIDEO ULA CONTROL REGISTER SETTINGS ***********************

_ULA_SETTINGS:		.byte	$9c				; 10011100
			.byte	$d8				; 11011000
			.byte	$f4				; 11110100
			.byte	$9c				; 10011100
			.byte	$88				; 10001000
			.byte	$c4				; 11000100
			.byte	$88				; 10001000
			.byte	$4b				; 01001011


;******** NUMBER OF BYTES PER CHARACTER FOR EACH DISPLAY MODE ************

_TXT_BPC_TABLE:		.byte	$08				; 00001000
			.byte	$10				; 00010000
			.byte	$20				; 00100000
			.byte	$08				; 00001000
			.byte	$08				; 00001000
			.byte	$10				; 00010000
			.byte	$08				; 00001000
_LC406:			.byte	$01				; 00000001


;******************* MASK TABLE FOR  2 COLOUR MODES **********************

_COL2_MASK_TAB:		.byte	$aa				; 10101010
			.byte	$55				; 01010101


;****************** MASK TABLE FOR  4 COLOUR MODES ***********************

			.byte	$88				; 10001000
			.byte	$44				; 01000100
			.byte	$22				; 00100010
			.byte	$11				; 00010001


;********** MASK TABLE FOR  4 COLOUR MODES FONT FLAG MASK TABLE **********

_LC40D:			.byte	$80				; 10000000
			.byte	$40				; 01000000
			.byte	$20				; 00100000
			.byte	$10				; 00010000
			.byte	$08				; 00001000
			.byte	$04				; 00000100
			.byte	$02				; 00000010  -  NEXT BYTE IN FOLLOWING TABLE


;********* NUMBER OF TEXT COLOURS -1 FOR EACH MODE ************************

_LC414:			.byte	$01				; MODE 0 - 2 COLOURS
			.byte	$03				; MODE 1 - 4 COLOURS
			.byte	$0f				; MODE 2 - 16 COLOURS
			.byte	$01				; MODE 3 - 2 COLOURS
			.byte	$01				; MODE 4 - 2 COLOURS
			.byte	$03				; MODE 5 - 4 COLOURS
			.byte	$01				; MODE 6 - 2 COLOURS
_LC41B:			.byte	$00				; MODE 7 - 1 'COLOUR'


;************** GCOL PLOT OPTIONS PROCESSING LOOK UP TABLE ***************

_LC41C:			.byte	$ff				; 11111111
_LC41D:			.byte	$00				; 00000000
			.byte	$00				; 00000000
			.byte	$ff				; 11111111
_LC420:			.byte	$ff				; 11111111
			.byte	$ff				; 11111111
			.byte	$ff				; 11111111
_LC423:			.byte	$00				; 00000000


;********** 2 COLOUR MODES PARAMETER LOOK UP TABLE WITHIN TABLE **********

			.byte	$00				; 00000000
			.byte	$ff				; 11111111


;*************** 4 COLOUR MODES PARAMETER LOOK UP TABLE ******************

			.byte	$00				; 00000000
			.byte	$0f				; 00001111
			.byte	$f0				; 11110000
			.byte	$ff				; 11111111


;***************16 COLOUR MODES PARAMETER LOOK UP TABLE ******************

			.byte	$00				; 00000000
			.byte	$03				; 00000011
			.byte	$0c				; 00001100
			.byte	$0f				; 00001111
			.byte	$30				; 00110000
			.byte	$33				; 00110011
			.byte	$3c				; 00111100
			.byte	$3f				; 00111111
			.byte	$c0				; 11000000
			.byte	$c3				; 11000011
			.byte	$cc				; 11001100
			.byte	$cf				; 11001111
			.byte	$f0				; 11110000
			.byte	$f3				; 11110011
			.byte	$fc				; 11111100
			.byte	$ff				; 11111111


;********** DISPLAY MODE PIXELS/BYTE-1 TABLE *********************

_LC43A:			.byte	$07				; MODE 0 - 8 PIXELS/BYTE
			.byte	$03				; MODE 1 - 4 PIXELS/BYTE
			.byte	$01				; MODE 2 - 2 PIXELS/BYTE
_LC43D:			.byte	$00				; MODE 3 - 1 PIXEL/BYTE (NON-GRAPHICS)
			.byte	$07				; MODE 4 - 8 PIXELS/BYTE
			.byte	$03				; MODE 5 - 4 PIXELS/BYTE

;********* SCREEN DISPLAY MEMORY TYPE TABLE OVERLAPS ************

_LC440:			.byte	$00				; MODE 6 - 1 PIXEL/BYTE	 //  MODE 0 - TYPE 0

;***** SOUND PITCH OFFSET BY CHANNEL TABLE WITHIN TABLE **********

			.byte	$00				; MODE 7 - 1 PIXEL/BYTE	 //  MODE 1 - TYPE 0  //  CHANNEL 0
			.byte	$00				; //  MODE 2 - TYPE 0  //  CHANNEL 1
			.byte	$01				; //  MODE 3 - TYPE 1  //  CHANNEL 2
			.byte	$02				; //  MODE 4 - TYPE 2  //  CHANNEL 3

;**** REST OF DISPLAY MEMORY TYPE TABLE ****

			.byte	$02				; //  MODE 5 - TYPE 2
			.byte	$03				; //  MODE 6 - TYPE 3

;***************** VDU SECTION CONTROL NUMBERS ***************************

_LC447:			.byte	$04				; 00000100		  //  MODE 7 - TYPE 4
			.byte	$00				; 00000000
			.byte	$06				; 00000110
			.byte	$02				; 00000010

;*********** CRTC SETUP PARAMETERS TABLE 1 WITHIN TABLE ******************

_LC44B:			.byte	$0d				; 00001101
			.byte	$05				; 00000101
			.byte	$0d				; 00001101
			.byte	$05				; 00000101

;*********** CRTC SETUP PARAMETERS TABLE 2 WITHIN TABLE *****************

_LC44F:			.byte	$04				; 00000100
			.byte	$04				; 00000100
			.byte	$0c				; 00001100
			.byte	$0c				; 00001100
			.byte	$04				; 00000100

;**** REST OF VDU SECTION CONTROL NUMBERS ****

_LC454:			.byte	$02				; 00000010
			.byte	$32				; 00110010
			.byte	$7a				; 01111010
			.byte	$92				; 10010010
			.byte	$e6				; 11100110


;************** MSB OF MEMORY OCCUPIED BY SCREEN BUFFER	 *****************

_VDU_MEMSZ_TAB:		.byte	$50				; Type 0: &5000 - 20K
			.byte	$40				; Type 1: &4000 - 16K
			.byte	$28				; Type 2: &2800 - 10K
			.byte	$20				; Type 3: &2000 - 8K
			.byte	$04				; Type 4: &0400 - 1K


;************ MSB OF FIRST LOCATION OCCUPIED BY SCREEN BUFFER ************

_VDU_MEMLOC_TAB:	.byte	$30				; Type 0: &3000
			.byte	$40				; Type 1: &4000
			.byte	$58				; Type 2: &5800
			.byte	$60				; Type 3: &6000
			.byte	$7c				; Type 4: &7C00


;***************** NUMBER OF BYTES PER ROW *******************************

_LC463:			.byte	$28				; 00101000
			.byte	$40				; 01000000
			.byte	$80				; 10000000


;******** ROW MULTIPLIACTION TABLE POINTER TO LOOK UP TABLE **************

_LC466:			.byte	$b5				; 10110101
			.byte	$75				; 01110101
			.byte	$75				; 01110101


;********** CRTC CURSOR END REGISTER SETTING LOOK UP TABLE ***************

_LC469:			.byte	$0b				; 00001011
			.byte	$17				; 00010111
			.byte	$23				; 00100011
			.byte	$2f				; 00101111
			.byte	$3b				; 00111011


;************* 6845 REGISTERS 0-11 FOR SCREEN TYPE 0 - MODES 0-2 *********

_CRTC_REG_TAB:		.byte	$7f				; 0 Horizontal Total	 =128
			.byte	$50				; 1 Horizontal Displayed =80
			.byte	$62				; 2 Horizontal Sync	 =&62
			.byte	$28				; 3 HSync Width+VSync	 =&28  VSync=2, HSync Width=8
			.byte	$26				; 4 Vertical Total	 =38
			.byte	$00				; 5 Vertial Adjust	 =0
			.byte	$20				; 6 Vertical Displayed	 =32
			.byte	$22				; 7 VSync Position	 =&22
			.byte	$01				; 8 Interlace+Cursor	 =&01  Cursor=0, Display=0, Interlace=Sync
			.byte	$07				; 9 Scan Lines/Character =8
			.byte	$67				; 10 Cursor Start Line	  =&67	Blink=On, Speed=1/32, Line=7
			.byte	$08				; 11 Cursor End Line	  =8


;************* 6845 REGISTERS 0-11 FOR SCREEN TYPE 1 - MODE 3 ************

			.byte	$7f				; 0 Horizontal Total	 =128
			.byte	$50				; 1 Horizontal Displayed =80
			.byte	$62				; 2 Horizontal Sync	 =&62
			.byte	$28				; 3 HSync Width+VSync	 =&28  VSync=2, HSync=8
			.byte	$1e				; 4 Vertical Total	 =30
			.byte	$02				; 5 Vertical Adjust	 =2
			.byte	$19				; 6 Vertical Displayed	 =25
			.byte	$1b				; 7 VSync Position	 =&1B
			.byte	$01				; 8 Interlace+Cursor	 =&01  Cursor=0, Display=0, Interlace=Sync
			.byte	$09				; 9 Scan Lines/Character =10
			.byte	$67				; 10 Cursor Start Line	  =&67	Blink=On, Speed=1/32, Line=7
			.byte	$09				; 11 Cursor End Line	  =9


;************ 6845 REGISTERS 0-11 FOR SCREEN TYPE 2 - MODES 4-5 **********

			.byte	$3f				; 0 Horizontal Total	 =64
			.byte	$28				; 1 Horizontal Displayed =40
			.byte	$31				; 2 Horizontal Sync	 =&31
			.byte	$24				; 3 HSync Width+VSync	 =&24  VSync=2, HSync=4
			.byte	$26				; 4 Vertical Total	 =38
			.byte	$00				; 5 Vertical Adjust	 =0
			.byte	$20				; 6 Vertical Displayed	 =32
			.byte	$22				; 7 VSync Position	 =&22
			.byte	$01				; 8 Interlace+Cursor	 =&01  Cursor=0, Display=0, Interlace=Sync
			.byte	$07				; 9 Scan Lines/Character =8
			.byte	$67				; 10 Cursor Start Line	  =&67	Blink=On, Speed=1/32, Line=7
			.byte	$08				; 11 Cursor End Line	  =8


;********** 6845 REGISTERS 0-11 FOR SCREEN TYPE 3 - MODE 6 ***************

			.byte	$3f				; 0 Horizontal Total	 =64
			.byte	$28				; 1 Horizontal Displayed =40
			.byte	$31				; 2 Horizontal Sync	 =&31
			.byte	$24				; 3 HSync Width+VSync	 =&24  VSync=2, HSync=4
			.byte	$1e				; 4 Vertical Total	 =30
			.byte	$02				; 5 Vertical Adjust	 =0
			.byte	$19				; 6 Vertical Displayed	 =25
			.byte	$1b				; 7 VSync Position	 =&1B
			.byte	$01				; 8 Interlace+Cursor	 =&01  Cursor=0, Display=0, Interlace=Sync
			.byte	$09				; 9 Scan Lines/Character =10
			.byte	$67				; 10 Cursor Start Line	  =&67	Blink=On, Speed=1/32, Line=7
			.byte	$09				; 11 Cursor End Line	  =9


;********* 6845 REGISTERS 0-11 FOR SCREEN TYPE 4 - MODE 7 ****************

			.byte	$3f				; 0 Horizontal Total	 =64
			.byte	$28				; 1 Horizontal Displayed =40
			.byte	$33				; 2 Horizontal Sync	 =&33  Note: &31 is a better value
			.byte	$24				; 3 HSync Width+VSync	 =&24  VSync=2, HSync=4
			.byte	$1e				; 4 Vertical Total	 =30
			.byte	$02				; 5 Vertical Adjust	 =2
			.byte	$19				; 6 Vertical Displayed	 =25
			.byte	$1b				; 7 VSync Position	 =&1B
			.byte	$93				; 8 Interlace+Cursor	 =&93  Cursor=2, Display=1, Interlace=Sync+Video
			.byte	$12				; 9 Scan Lines/Character =19
			.byte	$72				; 10 Cursor Start Line	  =&72	Blink=On, Speed=1/32, Line=18
			.byte	$13				; 11 Cursor End Line	  =19


;************* VDU ROUTINE VECTOR ADDRESSES   ******************************

_LC4AA:			.word	_LD386				
			.word	_LD37E				


;************ VDU ROUTINE BRANCH VECTOR ADDRESS LO ***********************

_LC4AE:			.byte	$6a				; 01101010
			.byte	$74				; 01110100
			.byte	$42				; 01000010
			.byte	$4b				; 01001011


;************ VDU ROUTINE BRANCH VECTOR ADDRESS HI ***********************

_LC4B2:			.byte	$d3				; 11010011
			.byte	$d3				; 11010011
			.byte	$d3				; 11010011
			.byte	$d3				; 11010011


;*********** TELETEXT CHARACTER CONVERSION TABLE  ************************

_TELETEXT_CHAR_TAB:	.byte	$23				; '#' -> '_'
			.byte	$5f				; '_' -> '`'
			.byte	$60				; '`' -> '#'
			.byte	$23				; '#'


;*********** SOFT CHARACTER RAM ALLOCATION   *****************************

_LC4BA:			.byte	$04				; &20-&3F - OSHWM+&0400
			.byte	$05				; &40-&5F - OSHWM+&0500
			.byte	$06				; &60-&7F - OSHWM+&0600
			.byte	$00				; &80-&9F - OSHWM+&0000
			.byte	$01				; &A0-&BF - OSHWM+&0100
			.byte	$02				; &C0-&DF - OSHWM+&0200

;*************************************************************************
;*									 *
;*	 VDU FUNCTION ADDRESSES						 *
;*									 *
;*************************************************************************

				; VDU	Address	     Parameters		function

				; 0    &C511	       0       does nothing
				; 1    &C53B	       1       next character to printer only
				; 2    &C596	       0       enable printer
				; 3    &C5A1	       0       disable printer
				; 4    &C5AD	       0       select text cursor
				; 5    &C5B9	       0       select graphics cursor
				; 6    &C511	       0       enable display
				; 7    &E86F	       0       bell
				; 8    &C5C5	       0       cursor left
				; 9    &C664	       0       cursor right
				; 10	&C6F0		0	cursor down
				; 11	&C65B		0	cursor up
				; 12	&C759		0	clear text window
				; 13	&C7AF		0	newline
				; 14	&C58D		0	select paged mode
				; 15	&C5A6		0	cancel paged mode
				; 16	&C7C0		0	clear graphics screen
				; 17	&C7F9		1	define text colour
				; 18	&C7FD		2	define graphics colour
				; 19	&C892		5	define logical colour
				; 20	&C839		0	restore default colours
				; 21	&C59B		0	disable display
				; 22	&C8EB		1	select screen MODE
				; 23	&C8F1		9	define character
				; 24	&CA39		8	define graphics window
				; 25	&C98C		5	PLOT
				; 26	&C9BD		0	set default windows
				; 27	&C511		0	ESCAPE (does nothing)
				; 28	&C6FA		4	define text window
				; 29	&CAA2		4	define graphics origin
				; 30	&C779		0	home cursor
				; 31	&C787		2	position text cursor (TAB)
				; 127	 &CAAC		 0	 delete

;*************************************************************************
;*									 *
;*	VDU Variables							 *
;*									 *
;*************************************************************************

				; D0 VDU status
				; Bit	 0	 printer output enabled
				; 1	  scrolling disabled
				; 2	  paged scrolling enabled
				; 3	  software scrolling selected
				; 4	  not used
				; 5	  printing at graphics cursor enabled
				; 6	  cursor editing mode enabled
				; 7	  screen disabled

				; D1 byte mask for current graphics point
				; D2/3	 text colour bytes to be ORed and EORed into memory
				; D4/5	 graphics colour bytes to be ORed and EORed into memory
				; D6/7	 address of top line of current graphics cell
				; D8/9	 address of top scan line of current text character
				; DA/F	 temporary workspace
				; E0/1	 CRTC row multiplication table pointer


				; 246	 Character definition explosion switch

				; 248	 current video ULA control regiter setting
				; 249	 current pallette setting

				; 251	 flash counter
				; 252	 mark-space count
				; 253	 space period count

				; 256	 EXEC file handle
				; 257	 SPOOL file handle

				; 260	 Econet OSWRCH interception flag
				; 267	 bit 7 set ignore start up message
				; 268	 length of key string
				; 269	 print line counter
				; 26A	 number of items in VDU queque
				; 26B	 TAB key value
				; 26C	 ESCAPE character

				; 27D	 cursor editing status

				; 28F	 start up options (Keyboard links)
				; bits	  0-2	  default screen Mode
				; 3	reverse SHIFT/BREAK
				; 4-5	  disc timing parameters
				; 290	 screen display vertical adjustment
				; 291	 interlace toggle flag

				; 300/1	 graphics window left
				; 302/3	 graphics window bottom
				; 304/5	 graphics window right
				; 306/7	 graphics window top
				; 308	 text window left
				; 309	 text window bottom
				; 30A	 text window right
				; 30B	 text window top
				; 30C/D	 graphics origin, horizontal (external values)
				; 30E/F	 graphics origin, vertical   (external values)

				; 310/1	 current graphics cursor, horizontal (external values)
				; 312/3	 current graphics cursor, vertical   (external values)
				; 314/5	 last graphics cursor, horizontal    (external values)
				; 316/7	 last graphics cursor, vertical	     (external values)
				; 318	 text column
				; 319	 text line
				; 31A	 graphics scan line expressed as line of character
				; 31B-323 VDU parameters, last parameter in &323
				; 324/5	 current graphics cursor, horizontal (internal values)
				; 316/7	 current graphics cursor, vertical   (internal values)
				; 328-349 general workspace
				; 34A/B	 text cursor address to CRT controller
				; 34C/D	 width of text window in bytes
				; 34E	 hi byte of address of screen RAM start
				; 34F	 bytes per character
				; 350/1	 address of window area start
				; 352/3	 bytes per character row
				; 354	 high byte of screen RAM size
				; 355	 Mode
				; 356	 memory map type
				; 357/35A current colours
				; 35B/C	 graphics plot mode
				; 35D/E	 jump vector
				; 35F	 last setting of CRTC Cursor start register
				; 360	 number of logical colours less 1
				; 361	 pixels per byte (0  in text only modes)
				; 362/3	 colour masks
				; 364/5	 X/Y for text input cursor
				; 366	 output cursor character for MODE 7
				; 367	 Font flag
				; 368/E	 font location bytes
				; 36F-37E Colour palette

