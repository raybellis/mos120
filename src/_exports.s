;
; MOS Entry points
;

.export NMI	   = $0d00

.export OSCLI_VEC  = $0208
.export OSBYTE_VEC = $020a
.export OSWORD_VEC = $020c
.export OSWRCH_VEC = $020e
.export OSRDCH_VEC = $0210
.export OSFILE_VEC = $0212
.export OSARGS_VEC = $0214
.export OSBGET_VEC = $0216
.export OSBPUT_VEC = $0218
.export OSGBPB_VEC = $021a
.export OSFIND_VEC = $021c

.export FRED	   = $fc00
.export JIM	   = $fd00
.export SHEILA	   = $fe00
