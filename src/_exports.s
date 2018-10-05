;
; Non-relocatable symbols
;

.export FS_LOAD		:= $b0
.export FS_EXEC		:= $b4
.export MSG_PTR		:= $b8
.export MSG_PTR_HI	:= $b9

.export CFS_INTERBLOCK	:= $c7

.export VDU_STATUS	:= $d0
.export VDU_G_PIX_MASK	:= $d1
.export VDU_T_OR_MASK	:= $d2
.export VDU_T_EOR_MASK	:= $d3
.export VDU_G_OR_MASK	:= $d4
.export VDU_G_EOR_MASK	:= $d5
.export VDU_G_MEM	:= $d6
.export VDU_G_MEM_HI	:= $d7

.export VDU_TMP1	:= $da
.export VDU_TMP2	:= $db
.export VDU_TMP3	:= $dc
.export VDU_TMP4	:= $dd
.export VDU_TMP5	:= $de
.export VDU_TMP6	:= $df

.export TEXT_PTR	:= $f2
.export TEXT_PTR_HI	:= $f3
.export ROM_SELECT	:= $f4

.export VEC_USERV	:= $0200
.export VEC_BRKV	:= $0202
.export VEC_IRQ1V	:= $0204
.export VEC_IRQ2V	:= $0206
.export VEC_OSCLI	:= $0208
.export VEC_OSBYTE	:= $020a
.export VEC_OSWORD	:= $020c
.export VEC_OSWRCH	:= $020e
.export VEC_OSRDCH	:= $0210
.export VEC_OSFILE	:= $0212
.export VEC_OSARGS	:= $0214
.export VEC_OSBGET	:= $0216
.export VEC_OSBPUT	:= $0218
.export VEC_OSGBPB	:= $021a
.export VEC_OSFIND	:= $021c
.export VEC_FSCV	:= $021e
.export VEC_EVNTV	:= $0220
.export VEC_UPTV	:= $0222
.export VEC_NETV	:= $0224
.export VEC_VDUV	:= $0226
.export VEC_KEYV	:= $0228
.export VEC_INSV	:= $022a
.export VEC_REMV	:= $022c
.export VEC_CNPV	:= $022e
.export VEC_IND1V	:= $0230
.export VEC_IND2V	:= $0232
.export VEC_IND3V	:= $0234

; OSBYTE variables
.export OSB_BASE	:= $0236
.export OSB_EXT_VEC	:= $0238
.export OSB_ROM_TABLE	:= $023a
.export OSB_KEY_TABLE	:= $023c
.export OSB_VDU_TABLE	:= $023e

.export OSB_CFS_TIMEOUT	:= $0240
.export OSB_IN_STREAM	:= $0241
.export OSB_KEY_SEM	:= $0242
.export OSB_OSHWM_DEF	:= $0243
.export OSB_OSHWM_CUR   := $0244
.export OSB_RS423_MODE	:= $0245
.export OSB_CHAR_EXPL	:= $0246
.export OSB_CFSRFC_SW	:= $0247
.export OSB_VIDPROC_CTL	:= $0248
.export OSB_VIDPROC_PAL	:= $0249
.export OSB_LAST_ROM	:= $024a
.export OSB_BASIC_ROM	:= $024b
.export OSB_ADC_CHAN	:= $024c
.export OSB_ADC_MAX	:= $024d
.export OSB_ADC_ACC	:= $024e
.export OSB_RS423_USE	:= $024f
.export OSB_RS423_CTL	:= $0250
.export OSB_FLASH_TIME	:= $0251
.export OSB_FLASH_SPC	:= $0252
.export OSB_FLASH_MARK	:= $0253
.export OSB_KEY_DELAY	:= $0254
.export OSB_KEY_REPEAT	:= $0255
.export OSB_EXEC_HND	:= $0256
.export OSB_SPOOL_HND	:= $0257
.export OSB_ESC_BRK	:= $0258
.export OSB_KEY_DISABLE	:= $0259
.export OSB_KEY_STATUS	:= $025a
.export OSB_SER_BUF_EX	:= $025b
.export OSB_SER_BUF_SUP	:= $025c
.export OSB_SER_CAS_FLG	:= $025d
.export OSB_ECONET_INT	:= $025e
.export OSB_OSRDCH_INT	:= $025f
.export OSB_OSWRCH_INT	:= $0260
.export OSB_SPEECH_OFF	:= $0261
.export OSB_SOUND_OFF	:= $0262
.export OSB_BELL_CHAN	:= $0263
.export OSB_BELL_ENV	:= $0264
.export OSB_BELL_FREQ	:= $0265
.export OSB_BELL_LEN	:= $0266
.export OSB_VDU_QSIZE	:= $026a
.export OSB_TAB		:= $026b
.export OSB_ESCAPE	:= $026c

.export OSB_UVIA_IRQ_M	:= $0277
.export OSB_ACIA_IRQ_M	:= $0278
.export OSB_SVIA_IRQ_M	:= $0279
.export OSB_TUBE_FOUND	:= $027a
.export OSB_SPCH_FOUND	:= $027b

.export ROM_TABLE	:= $02a1

.export OSFILE_CB	:= $02ee
.export OSFILE_CB_1	:= $02ef
.export OSFILE_CB_2	:= $02f0
.export OSFILE_CB_3	:= $02f1

.export VDU_QUEUE_4	:= $031f
.export VDU_QUEUE_3	:= $0320
.export VDU_QUEUE_2	:= $0321
.export VDU_QUEUE_1	:= $0322
.export VDU_QUEUE	:= $0323

.export VDU_G_WIN_L	:= $0300
.export VDU_G_WIN_L_HI	:= $0301
.export VDU_G_WIN_B	:= $0302
.export VDU_G_WIN_B_HI	:= $0303
.export VDU_G_WIN_R	:= $0304
.export VDU_G_WIN_R_HI	:= $0305
.export VDU_G_WIN_T	:= $0306
.export VDU_G_WIN_T_HI	:= $0307

.export VDU_T_WIN_L	:= $0308
.export VDU_T_WIN_B	:= $0309
.export VDU_T_WIN_R	:= $030a
.export VDU_T_WIN_T	:= $030b

.export VDU_MEM_PAGES	:= $0354
.export VDU_MODE	:= $0355
.export VDU_MAP_TYPE	:= $0356
.export VDU_T_FG	:= $0357
.export VDU_T_BG	:= $0358
.export VDU_G_FG	:= $0359
.export VDU_COL_MASK	:= $0360
.export VDU_G_BG	:= $035a
.export VDU_P_FG	:= $035b
.export VDU_P_BG	:= $035c

.export VDU_JUMPVEC	:= $035d
.export VDU_JUMPVEC_HI	:= $035e

.export CFS_BLOCK_LEN	:= $03c8

.export NMI		:= $0d00

.export ROM_LANGUAGE	:= $8000
.export ROM_SERVICE	:= $8003
.export ROM_TYPE	:= $8006
.export	ROM_CC_OFFSET	:= $8007

.export FRED		:= $fc00
.export JIM		:= $fd00
.export SHEILA		:= $fe00

.export CRTC_ADDRESS	:= $fe00
.export CRTC_DATA	:= $fe01
.export CRTC_BORDER	:= $fe02

.export ACIA_CSR	:= $fe08
.export ACIA_TXRX	:= $fe09

.export SERIAL_ULA	:= $fe10

.export ADLC		:= $fe18

.export VID_ULA_CTRL	:= $fe20
.export VID_ULA_PALETTE	:= $fe21

.export ROM_LATCH	:= $fe30

.export SYS_VIA_IORB	:= $fe40
.export SYS_VIA_IORA	:= $fe41
.export SYS_VIA_DDRB	:= $fe42
.export SYS_VIA_DDRA	:= $fe43
.export SYS_VIA_T1C_L	:= $fe44
.export SYS_VIA_T1C_H	:= $fe45
.export SYS_VIA_T1L_L	:= $fe46
.export SYS_VIA_T1L_H	:= $fe47
.export SYS_VIA_T2C_L	:= $fe48
.export SYS_VIA_T2C_H	:= $fe49
.export SYS_VIA_SHIFT	:= $fe4a
.export SYS_VIA_ACR	:= $fe4b
.export SYS_VIA_PCR	:= $fe4c
.export SYS_VIA_IFR	:= $fe4d
.export SYS_VIA_IER	:= $fe4e
.export SYS_VIA_IORB_NH	:= $fe4f

.export USR_VIA_IORB	:= $fe60
.export USR_VIA_IORA	:= $fe61
.export USR_VIA_DDRB	:= $fe62
.export USR_VIA_DDRA	:= $fe63
.export USR_VIA_T1C_L	:= $fe64
.export USR_VIA_T1C_H	:= $fe65
.export USR_VIA_T1L_L	:= $fe66
.export USR_VIA_T1L_H	:= $fe67
.export USR_VIA_T2C_L	:= $fe68
.export USR_VIA_T2C_H	:= $fe69
.export USR_VIA_SHIFT	:= $fe6a
.export USR_VIA_ACR	:= $fe6b
.export USR_VIA_PCR	:= $fe6c
.export USR_VIA_IFR	:= $fe6d
.export USR_VIA_IER	:= $fe6e
.export USR_VIA_IORB_NH	:= $fe6f

.export FDC_CSR		:= $fe80
.export FDC_PRR		:= $fe81
.export FDC_RESET	:= $fe82
.export FDC_ILLEGAL	:= $fe83
.export FDC_DATA	:= $fe84

.export ADLC_CSR1	:= $fea0
.export ADLC_CSR2_3	:= $fea1
.export ADLC_TXRX_FC	:= $fea2
.export ADLC_TXRX_FT	:= $fea3

.export ADC_SR		:= $fec0
.export ADC_HI		:= $fec1
.export ADC_LO		:= $fec2

.export TUBE_FIFO1_SR	:= $fee0
.export TUBE_FIFO1	:= $fee1
.export TUBE_FIFO2_SR	:= $fee2
.export TUBE_FIFO2	:= $fee3
.export TUBE_FIFO3_SR	:= $fee4
.export TUBE_FIFO3	:= $fee5
.export TUBE_FIFO4_SR	:= $fee6
.export TUBE_FIFO4	:= $fee7

.segment "STARTUP"
.segment "CODE"


