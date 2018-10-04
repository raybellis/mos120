;
; Non-relocatable symbols
;

.export ROM_SELECT	= $f4

.export NMI		= $0d00

.export VEC_OSCLI	= $0208
.export VEC_OSBYTE	= $020a
.export VEC_OSWORD	= $020c
.export VEC_OSWRCH	= $020e
.export VEC_OSRDCH	= $0210
.export VEC_OSFILE	= $0212
.export VEC_OSARGS	= $0214
.export VEC_OSBGET	= $0216
.export VEC_OSBPUT	= $0218
.export VEC_OSGBPB	= $021a
.export VEC_OSFIND	= $021c

.export FRED		= $fc00
.export JIM		= $fd00
.export SHEILA		= $fe00

.export CRTC_ADDRESS	= $fe00
.export CRTC_DATA	= $fe01
.export CRTC_BORDER	= $fe02

.export ACIA_CSR	= $fe08
.export ACIA_TXRX	= $fe09

.export SULA		= $fe10

.export ADLC		= $fe18

.export VULA_CTRL	= $fe20
.export VULA_PALETTE	= $fe21

.export ROM_LATCH	= $fe31

.export SYS_VIA_IORB	= $fe40
.export SYS_VIA_IORA	= $fe41
.export SYS_VIA_DDRB	= $fe42
.export SYS_VIA_DDRA	= $fe43
.export SYS_VIA_T1C_L	= $fe44
.export SYS_VIA_T1C_H	= $fe45
.export SYS_VIA_T1L_L	= $fe46
.export SYS_VIA_T1L_H	= $fe47
.export SYS_VIA_T2C_L	= $fe48
.export SYS_VIA_T2C_H	= $fe49
.export SYS_VIA_SHIFT	= $fe4a
.export SYS_VIA_ACR	= $fe4b
.export SYS_VIA_PCR	= $fe4c
.export SYS_VIA_IFR	= $fe4d
.export SYS_VIA_IER	= $fe4e
.export SYS_VIA_IORB_NH	= $fe4f

.export USR_VIA_IORB	= $fe60
.export USR_VIA_IORA	= $fe61
.export USR_VIA_DDRB	= $fe62
.export USR_VIA_DDRA	= $fe63
.export USR_VIA_T1C_L	= $fe64
.export USR_VIA_T1C_H	= $fe65
.export USR_VIA_T1L_L	= $fe66
.export USR_VIA_T1L_H	= $fe67
.export USR_VIA_T2C_L	= $fe68
.export USR_VIA_T2C_H	= $fe69
.export USR_VIA_SHIFT	= $fe6a
.export USR_VIA_ACR	= $fe6b
.export USR_VIA_PCR	= $fe6c
.export USR_VIA_IFR	= $fe6d
.export USR_VIA_IER	= $fe6e
.export USR_VIA_IORB_NH	= $fe6f