;
; Non-relocatable symbols
;

.export MSG_PTR		:= $b8
.export MSG_PTR_HI	:= $b9
.export TEXT_PTR	:= $f2
.export TEXT_PTR_HI	:= $f3
.export ROM_SELECT	:= $f4

.export VEC_IRQ1V	:= $0204
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

.export OSB_BASE	:= $0236
.export OSB_EXT_VEC	:= $0238
.export OSB_ROM_TABLE	:= $023a
.export OSB_KEY_TABLE	:= $023c
.export OSB_VDU_TABLE	:= $023e

.export OSB_OSHWM_DEF	:= $0243
.export OSB_OSHWM_CUR   := $0244
.export OSB_BASIC_ROM	:= $024b
.export OSB_OSRDCH_INT	:= $025f
.export OSB_OSWRCH_INT	:= $0260
.export OSB_BELL_CHAN	:= $0263
.export OSB_BELL_ENV	:= $0264
.export OSB_BELL_FREQ	:= $0265
.export OSB_BELL_LEN	:= $0266
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

.export VDU_JUMPVEC	:= $035d
.export VDU_JUMPVEC_HI	:= $035e

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

.export SULA		:= $fe10

.export ADLC		:= $fe18

.export VULA_CTRL	:= $fe20
.export VULA_PALETTE	:= $fe21

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


