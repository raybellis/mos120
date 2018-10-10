;
; Non-relocatable symbols
;

.exportzp CRFS_LOAD		:= $b0
.exportzp CRFS_LOAD_HI		:= $b1
.exportzp CRFS_LOAD_VHI		:= $b2
.exportzp CRFS_LOAD_XHI		:= $b3
.exportzp CRFS_EXEC		:= $b4
.exportzp CRFS_EXEC_HI		:= $b5
.exportzp CRFS_NEXT_BLK		:= $b6
.exportzp CRFS_NEXT_BLK_HI	:= $b7
.exportzp CRFS_ERR_PTR		:= $b8
.exportzp CRFS_ERR_PTR_HI	:= $b9
.exportzp CRFS_BLOCK_FLAG	:= $ba
.exportzp CRFS_OPTS		:= $bb
.exportzp CRFS_BLK_OFFSET	:= $bc
.exportzp CRFS_BLK_LAST		:= $bd
.exportzp CRFS_CRC_TMP		:= $be
.exportzp CRFS_CRC_TMP_HI	:= $bf

.exportzp CRFS_BUFFER_FLAG	:= $c0
.exportzp CRFS_CRC_RESULT	:= $c1
.exportzp CRFS_PROGRESS		:= $c2
.exportzp CFS_HANDLE		:= $c3
.exportzp CRFS_TMP		:= $c4
.exportzp CFS_BAUD_RATE		:= $c6
.exportzp CFS_INTERBLOCK	:= $c7
.exportzp CRFS_OSFILE_PTR	:= $c8
.exportzp CRFS_OSFILE_PTR_HI	:= $c9
.exportzp CFS_SERIAL_CTRL	:= $ca
.exportzp CRFS_CRC_BIT_CNT	:= $cb
.exportzp CRFS_FILE_SIZE	:= $cc
.exportzp CRFS_FILE_SIZE_HI	:= $cd

.exportzp VDU_STATUS		:= $d0
.exportzp VDU_G_PIX_MASK	:= $d1
.exportzp VDU_T_OR_MASK		:= $d2
.exportzp VDU_T_EOR_MASK	:= $d3
.exportzp VDU_G_OR_MASK		:= $d4
.exportzp VDU_G_EOR_MASK	:= $d5
.exportzp VDU_G_MEM		:= $d6
.exportzp VDU_G_MEM_HI		:= $d7
.exportzp VDU_TOP_SCAN		:= $d8
.exportzp VDU_TOP_SCAN_HI	:= $d9
.exportzp VDU_TMP1		:= $da
.exportzp VDU_TMP2		:= $db
.exportzp VDU_TMP3		:= $dc
.exportzp VDU_TMP4		:= $dd
.exportzp VDU_TMP5		:= $de
.exportzp VDU_TMP6		:= $df
.exportzp VDU_ROW_MULT		:= $e0
.exportzp VDU_ROW_MULT_HI	:= $e1
.exportzp CRFS_STATUS		:= $e2
.exportzp CRFS_OPTIONS		:= $e3
.exportzp OSBYTE_PAR_3		:= $e4
.exportzp OSBYTE_PAR_2		:= $e5
.exportzp MOS_WS		:= $e6
.exportzp AUTO_REPEAT_TIMER	:= $e7
.exportzp OSW_0_PTR		:= $e8
.exportzp OSW_0_PTR_HI		:= $e9
.exportzp RS423_TIMEOUT		:= $ea
.exportzp CRFS_ACTIVE		:= $eb
.exportzp KEYNUM_FIRST		:= $ec
.exportzp KEYNUM_LAST		:= $ed

.exportzp OSW_A			:= $ef
.exportzp OSW_X			:= $f0
.exportzp OSW_Y			:= $f1
.exportzp TEXT_PTR		:= $f2
.exportzp TEXT_PTR_HI		:= $f3
.exportzp ROM_SELECT		:= $f4
.exportzp RFS_SELECT		:= $f5
.exportzp ROM_PTR		:= $f6
.exportzp ROM_PTR_HI		:= $f7
.exportzp MOS_WS_0		:= $fa
.exportzp MOS_WS_1		:= $fb
.exportzp IRQ_COPY_A		:= $fc
.exportzp ERR_MSG_PTR		:= $fd
.exportzp ERR_MSG_PTR_HI	:= $fe
.exportzp ESCAPE_FLAG		:= $ff

.export STACK			:= $0100

.export VEC_USERV		:= $0200
.export VEC_BRKV		:= $0202
.export VEC_IRQ1V		:= $0204
.export VEC_IRQ2V		:= $0206
.export VEC_OSCLI		:= $0208
.export VEC_OSBYTE		:= $020a
.export VEC_OSWORD		:= $020c
.export VEC_OSWRCH		:= $020e
.export VEC_OSRDCH		:= $0210
.export VEC_OSFILE		:= $0212
.export VEC_OSARGS		:= $0214
.export VEC_OSBGET		:= $0216
.export VEC_OSBPUT		:= $0218
.export VEC_OSGBPB		:= $021a
.export VEC_OSFIND		:= $021c
.export VEC_FSCV		:= $021e
.export VEC_EVNTV		:= $0220
.export VEC_UPTV		:= $0222
.export VEC_NETV		:= $0224
.export VEC_VDUV		:= $0226
.export VEC_KEYV		:= $0228
.export VEC_INSV		:= $022a
.export VEC_REMV		:= $022c
.export VEC_CNPV		:= $022e
.export VEC_IND1V		:= $0230
.export VEC_IND2V		:= $0232
.export VEC_IND3V		:= $0234

; OSBYTE variables
.export OSB_BASE		:= $0236
.export OSB_EXT_VEC		:= $0238
.export OSB_ROM_TABLE		:= $023a
.export OSB_KEY_TABLE		:= $023c
.export OSB_VDU_TABLE		:= $023e

.export OSB_CFS_TIMEOUT		:= $0240
.export OSB_IN_STREAM		:= $0241
.export OSB_KEY_SEM		:= $0242
.export OSB_OSHWM_DEF		:= $0243
.export OSB_OSHWM_CUR   	:= $0244
.export OSB_RS423_MODE		:= $0245
.export OSB_CHAR_EXPL		:= $0246
.export OSB_CFSRFC_SW		:= $0247
.export OSB_VIDPROC_CTL		:= $0248
.export OSB_VIDPROC_PAL		:= $0249
.export OSB_LAST_ROM		:= $024a
.export OSB_BASIC_ROM		:= $024b
.export OSB_ADC_CHAN		:= $024c
.export OSB_ADC_MAX		:= $024d
.export OSB_ADC_ACC		:= $024e
.export OSB_RS423_USE		:= $024f
.export OSB_RS423_CTL		:= $0250
.export OSB_FLASH_TIME		:= $0251
.export OSB_FLASH_SPC		:= $0252
.export OSB_FLASH_MARK		:= $0253
.export OSB_KEY_DELAY		:= $0254
.export OSB_KEY_REPEAT		:= $0255
.export OSB_EXEC_HND		:= $0256
.export OSB_SPOOL_HND		:= $0257
.export OSB_ESC_BRK		:= $0258
.export OSB_KEY_DISABLE		:= $0259
.export OSB_KEY_STATUS		:= $025a
.export OSB_SER_BUF_EX		:= $025b
.export OSB_SER_BUF_SUP		:= $025c
.export OSB_SER_CAS_FLG		:= $025d
.export OSB_ECONET_INT		:= $025e
.export OSB_OSRDCH_INT		:= $025f
.export OSB_OSWRCH_INT		:= $0260
.export OSB_SPEECH_OFF		:= $0261
.export OSB_SOUND_OFF		:= $0262
.export OSB_BELL_CHAN		:= $0263
.export OSB_BELL_ENV		:= $0264
.export OSB_BELL_FREQ		:= $0265
.export OSB_BELL_LEN		:= $0266
.export OSB_BOOT_DISP		:= $0267
.export OSB_SOFT_KEYLEN		:= $0268
.export OSB_HALT_LINES		:= $0269
.export OSB_VDU_QSIZE		:= $026a
.export OSB_TAB			:= $026b
.export OSB_ESCAPE		:= $026c
.export OSB_CHAR_C0		:= $026d
.export OSB_CHAR_D0		:= $026e
.export OSB_CHAR_E0		:= $026f
.export OSB_CHAR_F0		:= $0270
.export OSB_CHAR_80		:= $0271
.export OSB_CHAR_90		:= $0272
.export OSB_CHAR_a0		:= $0273
.export OSB_CHAR_b0		:= $0274
.export OSB_ESC_ACTION		:= $0275
.export OSB_ESC_EFFECTS		:= $0276
.export OSB_UVIA_IRQ_M		:= $0277
.export OSB_ACIA_IRQ_M		:= $0278
.export OSB_SVIA_IRQ_M		:= $0279
.export OSB_TUBE_FOUND		:= $027a
.export OSB_SPCH_FOUND		:= $027b
.export OSB_OUT_STREAM		:= $027c
.export OSB_CURSOR_STAT		:= $027d
.export OSB_KEYPAD_BASE		:= $027e
.export OSB_SHADOW_RAM		:= $027f
.export OSB_COUNTRY		:= $0280
.export OSB_USER_FLAG		:= $0281
.export OSB_SERPROC		:= $0282
.export OSB_TIME_SWITCH		:= $0283
.export OSB_SOFTKEY_FLG		:= $0284
.export OSB_PRINT_DEST		:= $0285
.export OSB_PRINT_IGN		:= $0286
.export OSB_BRK_INT_JMP		:= $0287
.export OSB_BRK_INT_LO		:= $0288
.export OSB_BRK_INT_HI		:= $0289
.export OSB_FA_UNUSED		:= $028a
.export OSB_FB_UNUSED		:= $028b
.export OSB_CUR_LANG		:= $028c
.export OSB_LAST_BREAK		:= $028d
.export OSB_RAM_PAGES		:= $028e
.export OSB_STARTUP_OPT		:= $028f

.export VDU_ADJUST		:= $0290
.export VDU_INTERLACE		:= $0291

.export TIME_VAL1_MSB		:= $0292
.export TIME_VAL1_LSB		:= $0296
.export TIME_VAL2_MSB		:= $0297
.export TIME_VAL2_LSB		:= $029b
.export COUNTER_MSB		:= $029c
.export COUNTER_LSB		:= $029f

.export ROM_TABLE		:= $02a1

.export INKEY_TIMER		:= $02b1
.export INKEY_TIMER_HI		:= $02b2
.export OSW0_MAX_LINE		:= $02b3
.export OSW0_MIN_CHAR		:= $02b4
.export OSW0_MAX_CHAR		:= $02b5

.export ADC_CHAN1_LO		:= $02b6
.export ADC_CHAN2_LO		:= $02b7
.export ADC_CHAN3_LO		:= $02b8
.export ADC_CHAN4_LO		:= $02b9
.export ADC_CHAN1_HI		:= $02ba
.export ADC_CHAN2_HI		:= $02bb
.export ADC_CHAN3_HI		:= $02bc
.export ADC_CHAN4_HI		:= $02bd
.export ADC_CHAN_FLAG		:= $02be

.export EVENT_ENABLE		:= $02bf

.export SOFTKEY_EX_PTR		:= $02c9

.export KEY_REPEAT_CNT		:= $02ca
.export KEY_ROLLOVER_1		:= $02cb
.export KEY_ROLLOVER_2		:= $02cd
.export SOUND_SEMAPHORE		:= $02ce

.export BUFFER_0_BUSY		:= $02cf
.export BUFFER_1_BUSY		:= $02d0
.export BUFFER_2_BUSY		:= $02d1
.export BUFFER_3_BUSY		:= $02d2
.export BUFFER_4_BUSY		:= $02d3
.export BUFFER_5_BUSY		:= $02d4
.export BUFFER_6_BUSY		:= $02d5
.export BUFFER_7_BUSY		:= $02d6
.export BUFFER_8_BUSY		:= $02d7

.export BUFFER_0_OUT		:= $02d8
.export BUFFER_1_OUT		:= $02d9
.export BUFFER_2_OUT		:= $02da
.export BUFFER_3_OUT		:= $02db
.export BUFFER_4_OUT		:= $02dc
.export BUFFER_5_OUT		:= $02dd
.export BUFFER_6_OUT		:= $02de
.export BUFFER_7_OUT		:= $02df
.export BUFFER_8_OUT		:= $02e0

.export BUFFER_0_IN 		:= $02e1
.export BUFFER_1_IN 		:= $02e2
.export BUFFER_2_IN 		:= $02e3
.export BUFFER_3_IN 		:= $02e4
.export BUFFER_4_IN 		:= $02e5
.export BUFFER_5_IN 		:= $02e6
.export BUFFER_6_IN 		:= $02e7
.export BUFFER_7_IN 		:= $02e8
.export BUFFER_8_IN 		:= $02e9

.export CFS_BLOCK_SZ		:= $02ea
.export CFS_BLOCK_SZ_HI		:= $02eb
.export CFS_BLOCK_FLAG		:= $02ec
.export CFS_LAST_INPUT		:= $02ed

.export OSFILE_CB		:= $02ee
.export OSFILE_CB_1		:= $02ef
.export OSFILE_CB_2		:= $02f0
.export OSFILE_CB_3		:= $02f1
.export OSFILE_CB_4		:= $02f2
.export OSFILE_CB_5		:= $02f3
.export OSFILE_CB_6		:= $02f4
.export OSFILE_CB_7		:= $02f5
.export OSFILE_CB_8		:= $02f6
.export OSFILE_CB_9		:= $02f7
.export OSFILE_CB_10		:= $02f8
.export OSFILE_CB_11		:= $02f9
.export OSFILE_CB_12		:= $02fa
.export OSFILE_CB_13		:= $02fb
.export OSFILE_CB_14		:= $02fc
.export OSFILE_CB_15		:= $02fd
.export OSFILE_CB_16		:= $02fe
.export OSFILE_CB_17		:= $02ff

.export VDU_G_WIN_L		:= $0300
.export VDU_G_WIN_L_HI		:= $0301
.export VDU_G_WIN_B		:= $0302
.export VDU_G_WIN_B_HI		:= $0303
.export VDU_G_WIN_R		:= $0304
.export VDU_G_WIN_R_HI		:= $0305
.export VDU_G_WIN_T		:= $0306
.export VDU_G_WIN_T_HI		:= $0307
.export VDU_T_WIN_L		:= $0308
.export VDU_T_WIN_B		:= $0309
.export VDU_T_WIN_R		:= $030a
.export VDU_T_WIN_T		:= $030b
.export VDU_G_ORG_XX		:= $030c
.export VDU_G_ORG_XX_HI		:= $030d
.export VDU_G_ORG_YX		:= $030e
.export VDU_G_ORG_YX_HI		:= $030f
.export VDU_G_CUR_XX		:= $0310
.export VDU_G_CUR_XX_HI		:= $0311
.export VDU_G_CUR_YX		:= $0312
.export VDU_G_CUR_YX_HI		:= $0313

.export VDU_T_CURS_X		:= $0318
.export VDU_T_CURS_Y		:= $0319
.export VDU_G_CURS_SCAN		:= $031a
.export VDU_QUEUE		:= $031b
.export VDU_QUEUE_1		:= $031c
.export VDU_QUEUE_2		:= $031d
.export VDU_QUEUE_3		:= $031e
.export VDU_QUEUE_4		:= $031f
.export VDU_QUEUE_5		:= $0320
.export VDU_QUEUE_6		:= $0321
.export VDU_QUEUE_7		:= $0322
.export VDU_QUEUE_8		:= $0323
.export VDU_G_CURS_H		:= $0324
.export VDU_G_CURS_H_HI		:= $0325
.export VDU_G_CURS_V		:= $0326
.export VDU_G_CURS_V_HI		:= $0327
.export VDU_BITMAP_READ		:= $0328
.export VDU_BITMAP_RD_1		:= $0329
.export VDU_BITMAP_RD_2		:= $032a
.export VDU_BITMAP_RD_3		:= $032b
.export VDU_BITMAP_RD_4		:= $032c
.export VDU_BITMAP_RD_5		:= $032d
.export VDU_BITMAP_RD_6		:= $032e
.export VDU_BITMAP_RD_7		:= $032f

.export VDU_WORKSPACE		:= $0330

.export VDU_CRTC_CUR		:= $034a
.export VDU_CRTC_CUR_HI		:= $034b
.export VDU_T_WIN_SZ		:= $034c
.export VDU_T_WIN_SZ_HI		:= $034d
.export VDU_PAGE		:= $034e
.export VDU_BPC			:= $034f

.export VDU_MEM			:= $0350
.export VDU_MEM_HI		:= $0351
.export VDU_BPR			:= $0352
.export VDU_BPR_HI		:= $0353
.export VDU_MEM_PAGES		:= $0354
.export VDU_MODE		:= $0355
.export VDU_MAP_TYPE		:= $0356
.export VDU_T_FG		:= $0357
.export VDU_T_BG		:= $0358
.export VDU_G_FG		:= $0359
.export VDU_G_BG		:= $035a
.export VDU_P_FG		:= $035b
.export VDU_P_BG		:= $035c
.export VDU_JUMPVEC		:= $035d
.export VDU_JUMPVEC_HI		:= $035e
.export VDU_CURS_PREV		:= $035f

.export VDU_COL_MASK		:= $0360
.export VDU_PIX_BYTE		:= $0361
.export VDU_MASK_RIGHT		:= $0362
.export VDU_MASK_LEFT		:= $0363
.export VDU_TI_CURS_X		:= $0364
.export VDU_TI_CURS_Y		:= $0365
.export VDU_TTX_CURSOR		:= $0366
.export VDU_FONT_FLAGS		:= $0367
.export VDU_FONTLOC_20		:= $0368
.export VDU_FONTLOC_40		:= $0369
.export VDU_FONTLOC_60		:= $036a
.export VDU_FONTLOC_80		:= $036b
.export VDU_FONTLOC_A0		:= $036c
.export VDU_FONTLOC_B0		:= $036d
.export VDU_FONTLOC_C0		:= $036e
.export VDU_PALETTE		:= $036f

.export BPUT_FILENAME		:= $0380
.export BPUT_LOAD_LO		:= $038c
.export BPUT_LOAD_HI		:= $038d
.export BPUT_LOAD_VHI		:= $038e
.export BPUT_LOAD_XHI		:= $038f
.export BPUT_EXEC_LO		:= $0390
.export BPUT_EXEC_HI		:= $0391
.export BPUT_EXEC_VHI		:= $0392
.export BPUT_EXEC_XHI		:= $0393
.export BPUT_BLK_NUM		:= $0394
.export BPUT_BLK_NUM_HI		:= $0395
.export BPUT_BLK_LEN		:= $0396
.export BPUT_BLK_LEN_HI		:= $0397
.export BPUT_BLK_FLAG		:= $0398
.export BPUT_RFS_LO		:= $0399
.export BPUT_RFS_HI		:= $039a
.export BPUT_RFS_VHI		:= $039b
.export BPUT_RFS_XHI		:= $039c

.export CFS_BPUT_OFFSET		:= $039d
.export CFS_BGET_OFFSET		:= $039e
.export CFS_BGET_FILE		:= $03a7

.export CFS_FILENAME		:= $03b2
.export CFS_LOAD_LO		:= $03be
.export CFS_LOAD_HI		:= $03bf
.export CFS_LOAD_VHI		:= $03c0
.export CFS_LOAD_XHI		:= $03c1
.export CFS_EXEC_LO		:= $03c2
.export CFS_EXEC_HI		:= $03c3
.export CFS_EXEC_VHI		:= $03c4
.export CFS_EXEC_XHI		:= $03c5
.export CFS_BLK_NUM		:= $03c6
.export CFS_BLK_NUM_HI		:= $03c7
.export CFS_BLK_LEN		:= $03c8
.export CFS_BLK_LEN_HI		:= $03c9
.export CFS_BLK_FLAG		:= $03ca
.export CFS_RFS_LO		:= $03cb
.export CFS_RFS_HI		:= $03cc
.export CFS_RFS_VHI		:= $03cd
.export CFS_RFS_XHI		:= $03ce
.export CFS_CRC			:= $03cf
.export CFS_CRC_HI		:= $03d0
.export SEQ_BLOCK_GAP		:= $03d1
.export CFS_FIND_NAME		:= $03d2
.export CFS_BLK_GET		:= $03dd
.export CFS_BLK_GET_HI		:= $03de
.export CFS_LAST_FLAGS		:= $03df

.export BUFFER_KEYBOARD		:= $03e0

.export TUBE_ENTRY		:= $0400
.export TUBE_ENTRY_1		:= $0403
.export TUBE_ENTRY_2		:= $0406

.export SOUND_WORKSPACE		:= $0800
.export SOUND_QUEUE		:= $0804
.export SOUND_AMPLITUDE		:= $0808
.export SOUND_AMP_PHASES	:= $080c
.export SOUND_PITCH		:= $0810
.export SOUND_PITCH_PHASES	:= $0814
.export SOUND_STEPS		:= $0818
.export SOUND_DURATION		:= $081c
.export SOUND_INTERVAL_MUL	:= $0820
.export SOUND_ENV_REPEAT	:= $0824
.export SOUND_NOTE_REMAIN	:= $0828
.export SOUND_SYNC_HOLD_PARAM	:= $082c
.export SOUND_PITCH_SETTING	:= $0830
.export SOUND_PITCH_DEV		:= $0834
.export SOUND_SYNC_CHANS	:= $0838
.export SOUND_AMP_STEP		:= $0839
.export SOUND_AMP_TARGET	:= $083a
.export SOUND_SYNC_HOLD_COUNT	:= $083b
.export SOUND_WS_0		:= $083c
.export SOUND_FREQ_LO		:= $083d
.export SOUND_FREQ_HI		:= $083e
.export SOUND_WS_3		:= $083f

.export BUFFER_SOUND_0		:= $0840
.export BUFFER_SOUND_1		:= $0850
.export BUFFER_SOUND_2		:= $0860
.export BUFFER_SOUND_3		:= $0870
.export BUFFER_PRINTER		:= $0880

.export ENV_STEP		:= $08c0
.export ENV_PI1			:= $08c1
.export ENV_PI2			:= $08c2
.export ENV_PI3			:= $08c3
.export ENV_PN1			:= $08c4
.export ENV_PN2			:= $08c5
.export ENV_PN3			:= $08c6
.export ENV_AA			:= $08c7
.export ENV_AD			:= $08c8
.export ENV_AS			:= $08c9
.export ENV_AR			:= $08ca
.export ENV_ALA			:= $08cb
.export ENV_ALD			:= $08cc

.export BUFFER_RS423_TX		:= $0900
.export BUFFER_RS423_RX		:= $0a00

.export SOFTKEYS		:= $0b00

.export NMI_HANDLER		:= $0d00

.export ROM_LANGUAGE		:= $8000
.export ROM_SERVICE		:= $8003
.export ROM_TYPE		:= $8006
.export	ROM_CC_OFFSET		:= $8007

.export FRED			:= $fc00
.export JIM			:= $fd00
.export SHEILA			:= $fe00

.export CRTC_ADDRESS		:= $fe00
.export CRTC_DATA		:= $fe01
.export CRTC_BORDER		:= $fe02

.export ACIA_CSR		:= $fe08
.export ACIA_TXRX		:= $fe09

.export SERIAL_ULA		:= $fe10

.export ADLC			:= $fe18

.export VID_ULA_CTRL		:= $fe20
.export VID_ULA_PALETTE		:= $fe21

.export ROM_LATCH		:= $fe30

.export SYS_VIA_IORB		:= $fe40
.export SYS_VIA_IORA		:= $fe41
.export SYS_VIA_DDRB		:= $fe42
.export SYS_VIA_DDRA		:= $fe43
.export SYS_VIA_T1C_L		:= $fe44
.export SYS_VIA_T1C_H		:= $fe45
.export SYS_VIA_T1L_L		:= $fe46
.export SYS_VIA_T1L_H		:= $fe47
.export SYS_VIA_T2C_L		:= $fe48
.export SYS_VIA_T2C_H		:= $fe49
.export SYS_VIA_SHIFT		:= $fe4a
.export SYS_VIA_ACR		:= $fe4b
.export SYS_VIA_PCR		:= $fe4c
.export SYS_VIA_IFR		:= $fe4d
.export SYS_VIA_IER		:= $fe4e
.export SYS_VIA_IORB_NH		:= $fe4f

.export USR_VIA_IORB		:= $fe60
.export USR_VIA_IORA		:= $fe61
.export USR_VIA_DDRB		:= $fe62
.export USR_VIA_DDRA		:= $fe63
.export USR_VIA_T1C_L		:= $fe64
.export USR_VIA_T1C_H		:= $fe65
.export USR_VIA_T1L_L		:= $fe66
.export USR_VIA_T1L_H		:= $fe67
.export USR_VIA_T2C_L		:= $fe68
.export USR_VIA_T2C_H		:= $fe69
.export USR_VIA_SHIFT		:= $fe6a
.export USR_VIA_ACR		:= $fe6b
.export USR_VIA_PCR		:= $fe6c
.export USR_VIA_IFR		:= $fe6d
.export USR_VIA_IER		:= $fe6e
.export USR_VIA_IORB_NH		:= $fe6f

.export FDC_CSR			:= $fe80
.export FDC_PRR			:= $fe81
.export FDC_RESET		:= $fe82
.export FDC_ILLEGAL		:= $fe83
.export FDC_DATA		:= $fe84

.export ADLC_CSR1		:= $fea0
.export ADLC_CSR2_3		:= $fea1
.export ADLC_TXRX_FC		:= $fea2
.export ADLC_TXRX_FT		:= $fea3

.export ADC_SR			:= $fec0
.export ADC_HI			:= $fec1
.export ADC_LO			:= $fec2

.export TUBE_FIFO1_SR		:= $fee0
.export TUBE_FIFO1		:= $fee1
.export TUBE_FIFO2_SR		:= $fee2
.export TUBE_FIFO2		:= $fee3
.export TUBE_FIFO3_SR		:= $fee4
.export TUBE_FIFO3		:= $fee5
.export TUBE_FIFO4_SR		:= $fee6
.export TUBE_FIFO4		:= $fee7

.segment "STARTUP"
.segment "CODE"


; BBC Operating System OS 1.20
; ============================
; Commented disassembly by Geoff Cox, originally published on Micronet.
; Additional comments by J.G.Harston.

;***************** VDU CHARACTER FONT LOOK UP TABLE ****************************

; These are the default definitions for characters 32-127. The are accessed with
; OSWORD 10 (read character definition) and reprogrammed with VDU 23 (define
; character). If the character set is not exploded, then a block of 32 characters
; is copied to the soft character buffer at &0C00 when a character is defined.

			.org	$c000

			.byte	$00				; 00000000   ........	&20  32 - ' '
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........

			.byte	$18				; 00011000   ...**...	&21  33 - '!'
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$00				; 00000000   ........
			.byte	$18				; 00011000   ...**...
			.byte	$00				; 00000000   ........

			.byte	$6c				; 01101100   .**.**..	&22  34 - '"'
			.byte	$6c				; 01101100   .**.**..
			.byte	$6c				; 01101100   .**.**..
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........

			.byte	$36				; 00110110   ..**.**.	&23  35 - '#'
			.byte	$36				; 00110110   ..**.**.
			.byte	$7f				; 01111111   .*******
			.byte	$36				; 00110110   ..**.**.
			.byte	$7f				; 01111111   .*******
			.byte	$36				; 00110110   ..**.**.
			.byte	$36				; 00110110   ..**.**.
			.byte	$00				; 00000000   ........

			.byte	$0c				; 00001100   ....**..	&24  36 - '$'
			.byte	$3f				; 00111111   ..******
			.byte	$68				; 01101000   .**.*...
			.byte	$3e				; 00111110   ..*****.
			.byte	$0b				; 00001011   ....*.**
			.byte	$7e				; 01111110   .******.
			.byte	$18				; 00011000   ...**...
			.byte	$00				; 00000000   ........

			.byte	$60				; 01100000   .**.....	&25  37 - '%'
			.byte	$66				; 01100110   .**..**.
			.byte	$0c				; 00001100   ....**..
			.byte	$18				; 00011000   ...**...
			.byte	$30				; 00110000   ..**....
			.byte	$66				; 01100110   .**..**.
			.byte	$06				; 00000110   .....**.
			.byte	$00				; 00000000   ........

			.byte	$38				; 00111000   ..***...	&26  38 - '&'
			.byte	$6c				; 01101100   .**.**..
			.byte	$6c				; 01101100   .**.**..
			.byte	$38				; 00111000   ..***...
			.byte	$6d				; 01101101   .**.**.*
			.byte	$66				; 01100110   .**..**.
			.byte	$3b				; 00111011   ..***.**
			.byte	$00				; 00000000   ........

			.byte	$0c				; 00001100   ....**..	&27  39 - '''
			.byte	$18				; 00011000   ...**...
			.byte	$30				; 00110000   ..**....
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........

			.byte	$0c				; 00001100   ....**..	&28  40 - '('
			.byte	$18				; 00011000   ...**...
			.byte	$30				; 00110000   ..**....
			.byte	$30				; 00110000   ..**....
			.byte	$30				; 00110000   ..**....
			.byte	$18				; 00011000   ...**...
			.byte	$0c				; 00001100   ....**..
			.byte	$00				; 00000000   ........

			.byte	$30				; 00110000   ..**....	&29  41 - ')'
			.byte	$18				; 00011000   ...**...
			.byte	$0c				; 00001100   ....**..
			.byte	$0c				; 00001100   ....**..
			.byte	$0c				; 00001100   ....**..
			.byte	$18				; 00011000   ...**...
			.byte	$30				; 00110000   ..**....
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&2A  42 - '*'
			.byte	$18				; 00011000   ...**...
			.byte	$7e				; 01111110   .******.
			.byte	$3c				; 00111100   ..****..
			.byte	$7e				; 01111110   .******.
			.byte	$18				; 00011000   ...**...
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&2B  43 - '+'
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$7e				; 01111110   .******.
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&2C  44 - ','
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$30				; 00110000   ..**....

			.byte	$00				; 00000000   ........	&2D  45 - '-'
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$7e				; 01111110   .******.
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&2E  46 - '.'
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&2F  47 - '/'
			.byte	$06				; 00000110   .....**.
			.byte	$0c				; 00001100   ....**..
			.byte	$18				; 00011000   ...**...
			.byte	$30				; 00110000   ..**....
			.byte	$60				; 01100000   .**.....
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........

			.byte	$3c				; 00111100   ..****..	&30  48 - '0'
			.byte	$66				; 01100110   .**..**.
			.byte	$6e				; 01101110   .**.***.
			.byte	$7e				; 01111110   .******.
			.byte	$76				; 01110110   .***.**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$00				; 00000000   ........

			.byte	$18				; 00011000   ...**...	&31  49 - '1'
			.byte	$38				; 00111000   ..***...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$7e				; 01111110   .******.
			.byte	$00				; 00000000   ........

			.byte	$3c				; 00111100   ..****..	&32  50 - '2'
			.byte	$66				; 01100110   .**..**.
			.byte	$06				; 00000110   .....**.
			.byte	$0c				; 00001100   ....**..
			.byte	$18				; 00011000   ...**...
			.byte	$30				; 00110000   ..**....
			.byte	$7e				; 01111110   .******.
			.byte	$00				; 00000000   ........

			.byte	$3c				; 00111100   ..****..	&33  51 - '3'
			.byte	$66				; 01100110   .**..**.
			.byte	$06				; 00000110   .....**.
			.byte	$1c				; 00011100   ...***..
			.byte	$06				; 00000110   .....**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$00				; 00000000   ........

			.byte	$0c				; 00001100   ....**..	&34  52 - '4'
			.byte	$1c				; 00011100   ...***..
			.byte	$3c				; 00111100   ..****..
			.byte	$6c				; 01101100   .**.**..
			.byte	$7e				; 01111110   .******.
			.byte	$0c				; 00001100   ....**..
			.byte	$0c				; 00001100   ....**..
			.byte	$00				; 00000000   ........

			.byte	$7e				; 01111110   .******.	&35  53 - '5'
			.byte	$60				; 01100000   .**.....
			.byte	$7c				; 01111100   .*****..
			.byte	$06				; 00000110   .....**.
			.byte	$06				; 00000110   .....**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$00				; 00000000   ........

			.byte	$1c				; 00011100   ...***..	&36  54 - '6'
			.byte	$30				; 00110000   ..**....
			.byte	$60				; 01100000   .**.....
			.byte	$7c				; 01111100   .*****..
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$00				; 00000000   ........

			.byte	$7e				; 01111110   .******.	&37  55 - '7'
			.byte	$06				; 00000110   .....**.
			.byte	$0c				; 00001100   ....**..
			.byte	$18				; 00011000   ...**...
			.byte	$30				; 00110000   ..**....
			.byte	$30				; 00110000   ..**....
			.byte	$30				; 00110000   ..**....
			.byte	$00				; 00000000   ........

			.byte	$3c				; 00111100   ..****..	&38  56 - '8'
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$00				; 00000000   ........

			.byte	$3c				; 00111100   ..****..	&39  57 - '9'
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3e				; 00111110   ..*****.
			.byte	$06				; 00000110   .....**.
			.byte	$0c				; 00001100   ....**..
			.byte	$38				; 00111000   ..***...
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&3A  58 - ':'
			.byte	$00				; 00000000   ........
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$00				; 00000000   ........
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&3B  59 - ';'
			.byte	$00				; 00000000   ........
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$00				; 00000000   ........
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$30				; 00110000   ..**....

			.byte	$0c				; 00001100   ....**..	&3C  60 - '<'
			.byte	$18				; 00011000   ...**...
			.byte	$30				; 00110000   ..**....
			.byte	$60				; 01100000   .**.....
			.byte	$30				; 00110000   ..**....
			.byte	$18				; 00011000   ...**...
			.byte	$0c				; 00001100   ....**..
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&3D  61 - '='
			.byte	$00				; 00000000   ........
			.byte	$7e				; 01111110   .******.
			.byte	$00				; 00000000   ........
			.byte	$7e				; 01111110   .******.
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........

			.byte	$30				; 00110000   ..**....	&3E  62 - '>'
			.byte	$18				; 00011000   ...**...
			.byte	$0c				; 00001100   ....**..
			.byte	$06				; 00000110   .....**.
			.byte	$0c				; 00001100   ....**..
			.byte	$18				; 00011000   ...**...
			.byte	$30				; 00110000   ..**....
			.byte	$00				; 00000000   ........

			.byte	$3c				; 00111100   ..****..	&3F  63 - '?'
			.byte	$66				; 01100110   .**..**.
			.byte	$0c				; 00001100   ....**..
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$00				; 00000000   ........
			.byte	$18				; 00011000   ...**...
			.byte	$00				; 00000000   ........

			.byte	$3c				; 00111100   ..****..	&40  64 - '@'
			.byte	$66				; 01100110   .**..**.
			.byte	$6e				; 01101110   .**.***.
			.byte	$6a				; 01101010   .**.*.*.
			.byte	$6e				; 01101110   .**.***.
			.byte	$60				; 01100000   .**.....
			.byte	$3c				; 00111100   ..****..
			.byte	$00				; 00000000   ........

			.byte	$3c				; 00111100   ..****..	&41  65 - 'A'
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$7e				; 01111110   .******.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$00				; 00000000   ........

			.byte	$7c				; 01111100   .*****..	&42  66 - 'B'
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$7c				; 01111100   .*****..
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$7c				; 01111100   .*****..
			.byte	$00				; 00000000   ........

			.byte	$3c				; 00111100   ..****..	&43  67 - 'C'
			.byte	$66				; 01100110   .**..**.
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$00				; 00000000   ........

			.byte	$78				; 01111000   .****...	&44  68 - 'D'
			.byte	$6c				; 01101100   .**.**..
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$6c				; 01101100   .**.**..
			.byte	$78				; 01111000   .****...
			.byte	$00				; 00000000   ........

			.byte	$7e				; 01111110   .******.	&45  69 - 'E'
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$7c				; 01111100   .*****..
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$7e				; 01111110   .******.
			.byte	$00				; 00000000   ........

			.byte	$7e				; 01111110   .******.	&46  70 - 'F'
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$7c				; 01111100   .*****..
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$00				; 00000000   ........

			.byte	$3c				; 00111100   ..****..	&47  71 - 'G'
			.byte	$66				; 01100110   .**..**.
			.byte	$60				; 01100000   .**.....
			.byte	$6e				; 01101110   .**.***.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$00				; 00000000   ........

			.byte	$66				; 01100110   .**..**.	&48  72 - 'H'
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$7e				; 01111110   .******.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$00				; 00000000   ........

			.byte	$7e				; 01111110   .******.	&49  73 - 'I'
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$7e				; 01111110   .******.
			.byte	$00				; 00000000   ........

			.byte	$3e				; 00111110   ..*****.	&4A  74 - 'J'
			.byte	$0c				; 00001100   ....**..
			.byte	$0c				; 00001100   ....**..
			.byte	$0c				; 00001100   ....**..
			.byte	$0c				; 00001100   ....**..
			.byte	$6c				; 01101100   .**.**..
			.byte	$38				; 00111000   ..***...
			.byte	$00				; 00000000   ........

			.byte	$66				; 01100110   .**..**.	&4B  75 - 'K'
			.byte	$6c				; 01101100   .**.**..
			.byte	$78				; 01111000   .****...
			.byte	$70				; 01110000   .***....
			.byte	$78				; 01111000   .****...
			.byte	$6c				; 01101100   .**.**..
			.byte	$66				; 01100110   .**..**.
			.byte	$00				; 00000000   ........

			.byte	$60				; 01100000   .**.....	&4C  76 - 'L'
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$7e				; 01111110   .******.
			.byte	$00				; 00000000   ........

			.byte	$63				; 01100011   .**...**	&4D  77 - 'M'
			.byte	$77				; 01110111   .***.***
			.byte	$7f				; 01111111   .*******
			.byte	$6b				; 01101011   .**.*.**
			.byte	$6b				; 01101011   .**.*.**
			.byte	$63				; 01100011   .**...**
			.byte	$63				; 01100011   .**...**
			.byte	$00				; 00000000   ........

			.byte	$66				; 01100110   .**..**.	&4E  78 - 'N'
			.byte	$66				; 01100110   .**..**.
			.byte	$76				; 01110110   .***.**.
			.byte	$7e				; 01111110   .******.
			.byte	$6e				; 01101110   .**.***.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$00				; 00000000   ........

			.byte	$3c				; 00111100   ..****..	&4F  79 - 'O'
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$00				; 00000000   ........

			.byte	$7c				; 01111100   .*****..	&50  80 - 'P'
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$7c				; 01111100   .*****..
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$00				; 00000000   ........

			.byte	$3c				; 00111100   ..****..	&51  81 - 'Q'
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$6a				; 01101010   .**.*.*.
			.byte	$6c				; 01101100   .**.**..
			.byte	$36				; 00110110   ..**.**.
			.byte	$00				; 00000000   ........

			.byte	$7c				; 01111100   .*****..	&52  82 - 'R'
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$7c				; 01111100   .*****..
			.byte	$6c				; 01101100   .**.**..
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$00				; 00000000   ........

			.byte	$3c				; 00111100   ..****..	&53  83 - 'S'
			.byte	$66				; 01100110   .**..**.
			.byte	$60				; 01100000   .**.....
			.byte	$3c				; 00111100   ..****..
			.byte	$06				; 00000110   .....**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$00				; 00000000   ........

			.byte	$7e				; 01111110   .******.	&54  84 - 'T'
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$00				; 00000000   ........

			.byte	$66				; 01100110   .**..**.	&55  85 - 'U'
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$00				; 00000000   ........

			.byte	$66				; 01100110   .**..**.	&56  86 - 'V'
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$18				; 00011000   ...**...
			.byte	$00				; 00000000   ........

			.byte	$63				; 01100011   .**...**	&57  87 - 'W'
			.byte	$63				; 01100011   .**...**
			.byte	$6b				; 01101011   .**.*.**
			.byte	$6b				; 01101011   .**.*.**
			.byte	$7f				; 01111111   .*******
			.byte	$77				; 01110111   .***.***
			.byte	$63				; 01100011   .**...**
			.byte	$00				; 00000000   ........

			.byte	$66				; 01100110   .**..**.	&58  88 - 'X'
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$18				; 00011000   ...**...
			.byte	$3c				; 00111100   ..****..
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$00				; 00000000   ........

			.byte	$66				; 01100110   .**..**.	&59  89 - 'Y'
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$00				; 00000000   ........

			.byte	$7e				; 01111110   .******.	&5A  90 - 'Z'
			.byte	$06				; 00000110   .....**.
			.byte	$0c				; 00001100   ....**..
			.byte	$18				; 00011000   ...**...
			.byte	$30				; 00110000   ..**....
			.byte	$60				; 01100000   .**.....
			.byte	$7e				; 01111110   .******.
			.byte	$00				; 00000000   ........

			.byte	$7c				; 01111100   .*****..	&5B  91 - '['
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$7c				; 01111100   .*****..
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&5C  92 - '\'
			.byte	$60				; 01100000   .**.....
			.byte	$30				; 00110000   ..**....
			.byte	$18				; 00011000   ...**...
			.byte	$0c				; 00001100   ....**..
			.byte	$06				; 00000110   .....**.
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........

			.byte	$3e				; 00111110   ..*****.	&5D  93 - ']'
			.byte	$06				; 00000110   .....**.
			.byte	$06				; 00000110   .....**.
			.byte	$06				; 00000110   .....**.
			.byte	$06				; 00000110   .....**.
			.byte	$06				; 00000110   .....**.
			.byte	$3e				; 00111110   ..*****.
			.byte	$00				; 00000000   ........

			.byte	$18				; 00011000   ...**...	&5E  94 - '^'
			.byte	$3c				; 00111100   ..****..
			.byte	$66				; 01100110   .**..**.
			.byte	$42				; 01000010   .*....*.
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&5F  95 - '_'
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$ff				; 11111111   ********

			.byte	$1c				; 00011100   ...***..	&60  96 - '`'
			.byte	$36				; 00110110   ..**.**.
			.byte	$30				; 00110000   ..**....
			.byte	$7c				; 01111100   .*****..
			.byte	$30				; 00110000   ..**....
			.byte	$30				; 00110000   ..**....
			.byte	$7e				; 01111110   .******.
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&61  97 - 'a'
			.byte	$00				; 00000000   ........
			.byte	$3c				; 00111100   ..****..
			.byte	$06				; 00000110   .....**.
			.byte	$3e				; 00111110   ..*****.
			.byte	$66				; 01100110   .**..**.
			.byte	$3e				; 00111110   ..*****.
			.byte	$00				; 00000000   ........

			.byte	$60				; 01100000   .**.....	&62  98 - 'b'
			.byte	$60				; 01100000   .**.....
			.byte	$7c				; 01111100   .*****..
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$7c				; 01111100   .*****..
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&63  99 - 'c'
			.byte	$00				; 00000000   ........
			.byte	$3c				; 00111100   ..****..
			.byte	$66				; 01100110   .**..**.
			.byte	$60				; 01100000   .**.....
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$00				; 00000000   ........

			.byte	$06				; 00000110   .....**.	&64  100 - 'd'
			.byte	$06				; 00000110   .....**.
			.byte	$3e				; 00111110   ..*****.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3e				; 00111110   ..*****.
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&65  101 - 'e'
			.byte	$00				; 00000000   ........
			.byte	$3c				; 00111100   ..****..
			.byte	$66				; 01100110   .**..**.
			.byte	$7e				; 01111110   .******.
			.byte	$60				; 01100000   .**.....
			.byte	$3c				; 00111100   ..****..
			.byte	$00				; 00000000   ........

			.byte	$1c				; 00011100   ...***..	&66  102 - 'f'
			.byte	$30				; 00110000   ..**....
			.byte	$30				; 00110000   ..**....
			.byte	$7c				; 01111100   .*****..
			.byte	$30				; 00110000   ..**....
			.byte	$30				; 00110000   ..**....
			.byte	$30				; 00110000   ..**....
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&67  103 - 'g'
			.byte	$00				; 00000000   ........
			.byte	$3e				; 00111110   ..*****.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3e				; 00111110   ..*****.
			.byte	$06				; 00000110   .....**.
			.byte	$3c				; 00111100   ..****..

			.byte	$60				; 01100000   .**.....	&68  104 - 'h'
			.byte	$60				; 01100000   .**.....
			.byte	$7c				; 01111100   .*****..
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$00				; 00000000   ........

			.byte	$18				; 00011000   ...**...	&69  105 - 'i'
			.byte	$00				; 00000000   ........
			.byte	$38				; 00111000   ..***...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$3c				; 00111100   ..****..
			.byte	$00				; 00000000   ........

			.byte	$18				; 00011000   ...**...	&6A  106 - 'j'
			.byte	$00				; 00000000   ........
			.byte	$38				; 00111000   ..***...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$70				; 01110000   .***....

			.byte	$60				; 01100000   .**.....	&6B  107 - 'k'
			.byte	$60				; 01100000   .**.....
			.byte	$66				; 01100110   .**..**.
			.byte	$6c				; 01101100   .**.**..
			.byte	$78				; 01111000   .****...
			.byte	$6c				; 01101100   .**.**..
			.byte	$66				; 01100110   .**..**.
			.byte	$00				; 00000000   ........

			.byte	$38				; 00111000   ..***...	&6C  108 - 'l'
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$3c				; 00111100   ..****..
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&6D  109 - 'm'
			.byte	$00				; 00000000   ........
			.byte	$36				; 00110110   ..**.**.
			.byte	$7f				; 01111111   .*******
			.byte	$6b				; 01101011   .**.*.**
			.byte	$6b				; 01101011   .**.*.**
			.byte	$63				; 01100011   .**...**
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&6E  110 - 'n'
			.byte	$00				; 00000000   ........
			.byte	$7c				; 01111100   .*****..
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&6F  111 - 'o'
			.byte	$00				; 00000000   ........
			.byte	$3c				; 00111100   ..****..
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&70  112 - 'p'
			.byte	$00				; 00000000   ........
			.byte	$7c				; 01111100   .*****..
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$7c				; 01111100   .*****..
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....

			.byte	$00				; 00000000   ........	&71  113 - 'q'
			.byte	$00				; 00000000   ........
			.byte	$3e				; 00111110   ..*****.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3e				; 00111110   ..*****.
			.byte	$06				; 00000110   .....**.
			.byte	$07				; 00000111   .....***

			.byte	$00				; 00000000   ........	&72  114 - 'r'
			.byte	$00				; 00000000   ........
			.byte	$6c				; 01101100   .**.**..
			.byte	$76				; 01110110   .***.**.
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$60				; 01100000   .**.....
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&73  115 - 's'
			.byte	$00				; 00000000   ........
			.byte	$3e				; 00111110   ..*****.
			.byte	$60				; 01100000   .**.....
			.byte	$3c				; 00111100   ..****..
			.byte	$06				; 00000110   .....**.
			.byte	$7c				; 01111100   .*****..
			.byte	$00				; 00000000   ........

			.byte	$30				; 00110000   ..**....	&74  116 - 't'
			.byte	$30				; 00110000   ..**....
			.byte	$7c				; 01111100   .*****..
			.byte	$30				; 00110000   ..**....
			.byte	$30				; 00110000   ..**....
			.byte	$30				; 00110000   ..**....
			.byte	$1c				; 00011100   ...***..
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&75  117 - 'u'
			.byte	$00				; 00000000   ........
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3e				; 00111110   ..*****.
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&76  118 - 'v'
			.byte	$00				; 00000000   ........
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$18				; 00011000   ...**...
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&77  119 - 'w'
			.byte	$00				; 00000000   ........
			.byte	$63				; 01100011   .**...**
			.byte	$6b				; 01101011   .**.*.**
			.byte	$6b				; 01101011   .**.*.**
			.byte	$7f				; 01111111   .*******
			.byte	$36				; 00110110   ..**.**.
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&78  120 - 'x'
			.byte	$00				; 00000000   ........
			.byte	$66				; 01100110   .**..**.
			.byte	$3c				; 00111100   ..****..
			.byte	$18				; 00011000   ...**...
			.byte	$3c				; 00111100   ..****..
			.byte	$66				; 01100110   .**..**.
			.byte	$00				; 00000000   ........

			.byte	$00				; 00000000   ........	&79  121 - 'y'
			.byte	$00				; 00000000   ........
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$66				; 01100110   .**..**.
			.byte	$3e				; 00111110   ..*****.
			.byte	$06				; 00000110   .....**.
			.byte	$3c				; 00111100   ..****..

			.byte	$00				; 00000000   ........	&7A  122 - 'z'
			.byte	$00				; 00000000   ........
			.byte	$7e				; 01111110   .******.
			.byte	$0c				; 00001100   ....**..
			.byte	$18				; 00011000   ...**...
			.byte	$30				; 00110000   ..**....
			.byte	$7e				; 01111110   .******.
			.byte	$00				; 00000000   ........

			.byte	$0c				; 00001100   ....**..	&7B  123 - '{'
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$70				; 01110000   .***....
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$0c				; 00001100   ....**..
			.byte	$00				; 00000000   ........

			.byte	$18				; 00011000   ...**...	&7C  124 - '|'
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$00				; 00000000   ........
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$00				; 00000000   ........

			.byte	$30				; 00110000   ..**....	&7D  125 - '}'
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$0e				; 00001110   ....***.
			.byte	$18				; 00011000   ...**...
			.byte	$18				; 00011000   ...**...
			.byte	$30				; 00110000   ..**....
			.byte	$00				; 00000000   ........

			.byte	$31				; 00110001   ..**...*	&7E  126 - '~'
			.byte	$6b				; 01101011   .**.*.**
			.byte	$46				; 01000110   .*...**.
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........
			.byte	$00				; 00000000   ........

			.byte	$ff				; 11111111   ********	&7F  127 - DEL
			.byte	$ff				; 11111111   ********
			.byte	$ff				; 11111111   ********
			.byte	$ff				; 11111111   ********
			.byte	$ff				; 11111111   ********
			.byte	$ff				; 11111111   ********
			.byte	$ff				; 11111111   ********
			.byte	$ff				; 11111111   ********

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

.macro vdu_lo		addr
			.byte	<(addr)
.endmacro

.macro vdu_hi		addr, count
	.ifblank	count
			.byte	>(addr)
	.else
			.byte	(>(addr - $c300) << 4) + (16 - count)
	.endif
.endmacro

_VDU_TABLE_LO:		vdu_lo	_VDU_0
			vdu_lo	_VDU_1
			vdu_lo	_VDU_2
			vdu_lo	_VDU_3
			vdu_lo	_VDU_4
			vdu_lo	_VDU_5
			vdu_lo	_VDU_6
			vdu_lo	_VDU_7
			vdu_lo	_VDU_8
			vdu_lo	_VDU_9
			vdu_lo	_VDU_10
			vdu_lo	_VDU_11
			vdu_lo	_VDU_12
			vdu_lo	_VDU_13
			vdu_lo	_VDU_14
			vdu_lo	_VDU_15
			vdu_lo	_VDU_16
			vdu_lo	_VDU_17
			vdu_lo	_VDU_18
			vdu_lo	_VDU_19
			vdu_lo	_VDU_20
			vdu_lo	_VDU_21
			vdu_lo	_VDU_22
			vdu_lo	_VDU_23
			vdu_lo	_VDU_24
			vdu_lo	_VDU_25
			vdu_lo	_VDU_26
			vdu_lo	_VDU_27
			vdu_lo	_VDU_28
			vdu_lo	_VDU_29
			vdu_lo	_VDU_30
			vdu_lo	_VDU_31
			vdu_lo	_VDU_127


;****** VDU ENTRY POINT HI PARAMETER LOOK UP TABLE******

; 1xxxxxxx - no parameters, address high byte
; 0aaapppp - parameter count 16-p, address high byte &C3+a

_VDU_TABLE_HI:		vdu_hi	_VDU_0				; VDU  0   - &C511, no parameters
			vdu_hi	_VDU_1, 1			; VDU  1   - &C53B, 1 parameter
			vdu_hi	_VDU_2				; VDU  2   - &C596, no parameters
			vdu_hi	_VDU_3				; VDU  3   - &C5A1, no parameters
			vdu_hi	_VDU_4				; VDU  4   - &C5AD, no parameters
			vdu_hi	_VDU_5				; VDU  5   - &C5B9, no parameters
			vdu_hi	_VDU_6				; VDU  6   - &C511, no parameters
			vdu_hi	_VDU_7				; VDU  7   - &E86F, no parameters
			vdu_hi	_VDU_8				; VDU  8   - &C5C5, no parameters
			vdu_hi	_VDU_9				; VDU  9   - &C664, no parameters
			vdu_hi	_VDU_10				; VDU 10  - &C6F0, no parameters
			vdu_hi	_VDU_11				; VDU 11  - &C65B, no parameters
			vdu_hi	_VDU_12				; VDU 12  - &C759, no parameters
			vdu_hi	_VDU_13				; VDU 13  - &C7AF, no parameters
			vdu_hi	_VDU_14				; VDU 14  - &C58D, no parameters
			vdu_hi	_VDU_15				; VDU 15  - &C5A6, no parameters
			vdu_hi	_VDU_16				; VDU 16  - &C7C0, no parameters
			vdu_hi	_VDU_17, 1			; VDU 17  - &C7F9, 1 parameter
			vdu_hi	_VDU_18, 2			; VDU 18  - &C7FD, 2 parameters
			vdu_hi	_VDU_19, 5			; VDU 19  - &C892, 5 parameters
			vdu_hi	_VDU_20				; VDU 20  - &C839, no parameters
			vdu_hi	_VDU_21				; VDU 21  - &C59B, no parameters
			vdu_hi	_VDU_22, 1			; VDU 22  - &C8EB, 1 parameter
			vdu_hi	_VDU_23, 9			; VDU 23  - &C8F1, 9 parameters
			vdu_hi	_VDU_24, 8			; VDU 24  - &CA39, 8 parameters
			vdu_hi	_VDU_25, 5			; VDU 25  - &C9AC, 5 parameters
			vdu_hi	_VDU_26				; VDU 26  - &C9BD, no parameters
			vdu_hi	_VDU_27				; VDU 27  - &C511, no parameters
			vdu_hi	_VDU_28, 4			; VDU 28  - &C6FA, 4 parameters
			vdu_hi	_VDU_29, 4			; VDU 29  - &CAA2, 4 parameters
			vdu_hi	_VDU_30				; VDU 30  - &C779, no parameters
			vdu_hi	_VDU_31, 2			; VDU 31  - &C787, 2 parameters
			vdu_hi	_VDU_127			; VDU 127 - &CAAC, no parameters


;****** 640 MULTIPLICATION TABLE  40COL, 80COL MODES  HIBYTE, LOBYTE ******

_MUL640_TABLE:		.dbyt	640 *  0
			.dbyt	640 *  1
			.dbyt	640 *  2
			.dbyt	640 *  3
			.dbyt	640 *  4
			.dbyt	640 *  5
			.dbyt	640 *  6
			.dbyt	640 *  7
			.dbyt	640 *  8
			.dbyt	640 *  9
			.dbyt	640 * 10
			.dbyt	640 * 11
			.dbyt	640 * 12
			.dbyt	640 * 13
			.dbyt	640 * 14
			.dbyt	640 * 15
			.dbyt	640 * 16
			.dbyt	640 * 17
			.dbyt	640 * 18
			.dbyt	640 * 19
			.dbyt	640 * 20
			.dbyt	640 * 21
			.dbyt	640 * 22
			.dbyt	640 * 23
			.dbyt	640 * 24
			.dbyt	640 * 25
			.dbyt	640 * 26
			.dbyt	640 * 27
			.dbyt	640 * 28
			.dbyt	640 * 29
			.dbyt	640 * 30
			.dbyt	640 * 31

;****** *40 MULTIPLICATION TABLE  TELETEXT  MODE   HIBYTE, LOBYTE  ******

_MUL40_TABLE:		.dbyt	40 *  0
			.dbyt	40 *  1
			.dbyt	40 *  2
			.dbyt	40 *  3
			.dbyt	40 *  4
			.dbyt	40 *  5
			.dbyt	40 *  6
			.dbyt	40 *  7
			.dbyt	40 *  8
			.dbyt	40 *  9
			.dbyt	40 * 10
			.dbyt	40 * 11
			.dbyt	40 * 12
			.dbyt	40 * 13
			.dbyt	40 * 14
			.dbyt	40 * 15
			.dbyt	40 * 16
			.dbyt	40 * 17
			.dbyt	40 * 18
			.dbyt	40 * 19
			.dbyt	40 * 20
			.dbyt	40 * 21
			.dbyt	40 * 22
			.dbyt	40 * 23
			.dbyt	40 * 24


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

_LC4AA:			.addr	_LD386
			.addr	_LD37E


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

; BBC Operation System OS 1.20		VDU Main Routines

;**************************************************************************
;**************************************************************************
;**									 **
;**	 OSWRCH	 MAIN ROUTINE  entry from E0C5				 **
;**									 **
;**	 output a byte via the VDU stream				 **
;**									 **
;**************************************************************************
;**************************************************************************
;This routine takes up over 40% of the operating system ROM
;Entry points are variable, as are the results achieved.
;Tracing any particular path is relatively easy but generalising for
;commenting is not. For clarity comments will not be as detailed as
;for later parts of the Operating System.

			.org	$c4c0

_VDUCHR:		ldx	OSB_VDU_QSIZE			; get number of items in VDU queue
			bne	_BC512				; if parameters needed then C512
			bit	VDU_STATUS			; else check status byte
			bvc	__vdu_check_delete		; if cursor editing enabled two cursors exist
			jsr	_LC568				; swap values
			jsr	_LCD6A				; then set up write cursor
			bmi	__vdu_check_delete		; if display disabled C4D8
			cmp	#$0d				; else if character in A=RETURN teminate edit
			bne	__vdu_check_delete		; else C4D8

			jsr	_LD918				; terminate edit

__vdu_check_delete:	cmp	#$7f				; is character DELETE ?
			beq	_BC4ED				; if so C4ED

			cmp	#$20				; is it less than space? (i.e. VDU control code)
			bcc	_BC4EF				; if so C4EF
			bit	VDU_STATUS			; else check VDU byte ahain
			bmi	_BC4EA				; if screen disabled C4EA
			jsr	_VDU_OUT_CHAR			; else display a character
			jsr	_VDU_9				; and cursor right
_BC4EA:			jmp	_LC55E				; 

;********* read link addresses and number of parameters *****************

_BC4ED:			lda	#$20				; to replace delete character

;********* read link addresses and number of parameters *****************

_BC4EF:			tay					; Y=A
			lda	_VDU_TABLE_LO,Y			; get lo byte of link address
			sta	VDU_JUMPVEC			; store it in jump vector
			lda	_VDU_TABLE_HI,Y			; get hi byte
			bmi	_BC545				; if negative (as it will be if a direct address)
								; there are no parameters needed
								; so C545
			tax					; else X=A
			ora	#$f0				; set up negated parameter count
			sta	OSB_VDU_QSIZE			; store it as number of items in VDU queue
			txa					; get back A
			lsr					; A=A/16
			lsr					; 
			lsr					; 
			lsr					; 
			clc					; clear carry
			adc	#$c3				; add &C3 to get hi byte of link address
			sta	VDU_JUMPVEC_HI			; 
			bit	VDU_STATUS			; check if cursor editing enabled
			bvs	_BC52F				; if so re-exchange pointers
			clc					; clear carry
_VDU_0_6_27:
_VDU_0:
_VDU_6:
_VDU_27:		rts					; and exit

;return with carry clear indicates that printer action not required.

;********** parameters are outstanding ***********************************
; X=&26A = 2 complement of number of parameters X=&FF for 1, FE for 2 etc.

_BC512:			sta	VDU_QUEUE_8 - 255,X		; store parameter in queue
			inx					; increment X
			stx	OSB_VDU_QSIZE			; store it as VDU queue
			bne	_BC532				; if not 0 C532 as more parameters are needed
			bit	VDU_STATUS			; get VDU status byte
			bmi	_BC534				; if screen disabled C534
			bvs	_BC526				; else if cursor editing C526
			jsr	_VDU_JUMP			; execute required function
			clc					; clear carry
			rts					; and exit

_BC526:			jsr	_LC568				; swap values of cursors
			jsr	_LCD6A				; set up write cursor
			jsr	_VDU_JUMP			; execute required function
_BC52F:			jsr	_LC565				; re-exchange pointers

_BC532:			clc					; carry clear
			rts					; exit

;*************************************************************************
;*									 *
;*	 VDU 1 - SEND NEXT CHARACTER TO PRINTER				 *
;*									 *
;*	 1 parameter required						 *
;*									 *
;*************************************************************************

_BC534:			ldy	VDU_JUMPVEC_HI			; if upper byte of link address not &C5
			cpy	#$c5				; printer is not interested
			bne	_BC532				; so C532
_VDU_1:			tax					; else X=A
			lda	VDU_STATUS			; A=VDU status byte
			lsr					; get bit 0 into carry
			bcc	_VDU_0_6_27			; if printer not enabled exit
			txa					; restore A
			jmp	_PRINTER_OUT_ALWAYS		; else send byte in A (next byte) to printer

;*********** if explicit link address found, no parameters ***************

_BC545:			sta	VDU_JUMPVEC_HI			; upper byte of link address
			tya					; restore A
			cmp	#$08				; is it 7 or less?
			bcc	_BC553				; if so C553
			eor	#$ff				; invert it
			cmp	#$f2				; c is set if A >&0D
			eor	#$ff				; re invert

_BC553:			bit	VDU_STATUS			; VDU status byte
			bmi	_BC580				; if display disabled C580
			php					; push processor flags
			jsr	_VDU_JUMP			; execute required function
			plp					; get back flags
			bcc	_BC561				; if carry clear (from C54B/F)

;**************** main exit routine **************************************

_LC55E:			lda	VDU_STATUS			; VDU status byte
			lsr					; Carry is set if printer is enabled
_BC561:			bit	VDU_STATUS			; VDU status byte
			bvc	_VDU_0_6_27			; if no cursor editing	C511 to exit

;***************** cursor editing routines *******************************

_LC565:			jsr	_LCD7A				; restore normal write cursor

_LC568:			php					; save flags and
			pha					; A
			ldx	#$18				; X=&18
			ldy	#$64				; Y=&64
			jsr	_LCDDE				; exchange &300/1+X with &300/1+Y
			jsr	_LCF06				; set up display address
			jsr	_LCA02				; set cursor position
			lda	VDU_STATUS			; VDU status byte
			eor	#$02				; invert bit 1 to allow or bar scrolling
			sta	VDU_STATUS			; VDU status byte
			pla					; restore flags and A
			plp					; 
			rts					; and exit

_BC580:			eor	#$06				; if A<>6
			bne	_BC58C				; return via C58C
			lda	#$7f				; A=&7F
			bcc	_LC5A8				; and goto C5A8 ALWAYS!!

;******************* check text cursor in use ***************************

_LC588:			lda	VDU_STATUS			; VDU status byte
			and	#$20				; set A from bit 5 of status byte
_BC58C:			rts					; and exit

; A=0 if text cursor, &20 if graphics

;*************************************************************************
;*									 *
;*	 VDU 14 - SET PAGED MODE					 *
;*									 *
;*************************************************************************

_VDU_14:		ldy	#$00				; Y=0
			sty	OSB_HALT_LINES			; paged mode counter
			lda	#$04				; A=04
			bne	_LC59D				; jump to C59D

;*************************************************************************
;*									 *
;*	 VDU 2	- PRINTER ON (START PRINT JOB)				 *
;*									 *
;*************************************************************************

_VDU_2:			jsr	_LE1A2				; select printer buffer and output character
			lda	#$94				; A=&94
								; when inverted at C59B this becomes =&01

;*************************************************************************
;*									 *
;*	 VDU 21 - DISABLE DISPLAY					 *
;*									 *
;*************************************************************************

_VDU_21:		eor	#$95				; if A=&15 A now =&80: if A=&94 A now =1

_LC59D:			ora	VDU_STATUS			; VDU status byte set bit 0 or bit 7
			bne	_BC5AA				; branch forward to store



;*************************************************************************
;*									 *
;*	 VDU 3	- PRINTER OFF (END PRINT JOB)				 *
;*									 *
;*************************************************************************

_VDU_3:			jsr	_LE1A2				; select printer buffer and output character
			lda	#$0a				; A=10 to clear status bits below...

;*************************************************************************
;*									 *
;*	 VDU 15 - PAGED MODE OFF					 *
;*									 *
;*************************************************************************
; A=&F or &A

_VDU_15:		eor	#$f4				; convert to &FB or &FE
_LC5A8:			and	VDU_STATUS			; VDU status byte clear bit 0 or bit 2 of status
_BC5AA:			sta	VDU_STATUS			; VDU status byte
_BC5AC:			rts					; exit

;*************************************************************************
;*									 *
;*	 VDU 4	- OUTPUT AT TEXT CURSOR					 *
;*									 *
;*************************************************************************

_VDU_4:			lda	VDU_PIX_BYTE			; pixels per byte
			beq	_BC5AC				; if no graphics in current mode C5AC
			jsr	_LC951				; set CRT controller for text cursor
			lda	#$df				; this to clear bit 5 of status byte
			bne	_LC5A8				; via C5A8 exit

;*************************************************************************
;*									 *
;*	 VDU 5	- OUTPUT AT GRAPHICS CURSOR				 *
;*									 *
;*************************************************************************

_VDU_5:			lda	VDU_PIX_BYTE			; pixels per byte
			beq	_BC5AC				; if none this is text mode so exit
			lda	#$20				; set up graphics cursor
			jsr	_LC954				; via C954
			bne	_LC59D				; set bit 5 via exit C59D

;*************************************************************************
;*									 *
;*	 VDU 8	- CURSOR LEFT						 *
;*									 *
;*************************************************************************

_VDU_8:			jsr	_LC588				; A=0 if text cursor A=&20 if graphics cursor
			bne	_BC61F				; move cursor left 8 pixels if graphics
			dec	VDU_T_CURS_X			; else decrement text column
			ldx	VDU_T_CURS_X			; store new text column
			cpx	VDU_T_WIN_L			; if it is less than text window left
			bmi	__curs_t_wrap_left		; do wraparound	 cursor to rt of screen 1 line up
			lda	VDU_CRTC_CUR			; text cursor 6845 address
			sec					; subtract
			sbc	VDU_BPC				; bytes per character
			tax					; put in X
			lda	VDU_CRTC_CUR_HI			; get text cursor 6845 address
			sbc	#$00				; subtract 0
			cmp	VDU_PAGE			; compare with hi byte of screen RAM address
			bcs	__curs_t_wrap_top		; if = or greater
			adc	VDU_MEM_PAGES			; add screen RAM size hi byte to wrap around
__curs_t_wrap_top:	tay					; Y=A
			jmp	_LC9F6				; Y hi and X lo byte of cursor position

;***************** execute wraparound left-up*****************************

__curs_t_wrap_left:	lda	VDU_T_WIN_R			; text window right
			sta	VDU_T_CURS_X			; text column

;*************** cursor up ***********************************************

_BC5F4:			dec	OSB_HALT_LINES			; paged mode counter
			bpl	_BC5FC				; if still greater than 0 skip next instruction
			inc	OSB_HALT_LINES			; paged mode counter to restore X=0
_BC5FC:			ldx	VDU_T_CURS_Y			; current text line
			cpx	VDU_T_WIN_T			; top of text window
			beq	_BC60A				; if its at top of window C60A
			dec	VDU_T_CURS_Y			; else decrement current text line
			jmp	_LC6AF				; and carry on moving cursor

;******** cursor at top of window ****************************************

_BC60A:			clc					; clear carry
			jsr	_LCD3F				; check for window violatations
			lda	#$08				; A=8 to check for software scrolling
			bit	VDU_STATUS			; compare against VDU status byte
			bne	_BC619				; if not enabled C619
			jsr	_LC994				; set screen start register and adjust RAM
			bne	_BC61C				; jump C61C

_BC619:			jsr	_LCDA4				; soft scroll 1 line
_BC61C:			jmp	_LC6AC				; and exit

;**********cursor left and down with graphics cursor in use **************

_BC61F:			ldx	#$00				; X=0 to select horizontal parameters

;********** cursor down with graphics in use *****************************
;X=2 for vertical or 0 for horizontal

_LC621:			stx	VDU_TMP2			; store X
			jsr	_LD10D				; check for window violations
			ldx	VDU_TMP2			; restore X
			sec					; set carry
			lda	VDU_G_CURS_H,X			; current graphics cursor X>1=vertical
			sbc	#$08				; subtract 8 to move back 1 character
			sta	VDU_G_CURS_H,X			; store in current graphics cursor X>1=verticaal
			bcs	_BC636				; if carry set skip next
			dec	VDU_G_CURS_H_HI,X		; current graphics cursor hi -1
_BC636:			lda	VDU_TMP1			; &DA=0 if no violation else 1 if vert violation
								; 2 if horizontal violation
			bne	_BC658				; if violation C658
			jsr	_LD10D				; check for window violations
			beq	_BC658				; if none C658

			ldx	VDU_TMP2			; else get back X
			lda	VDU_G_WIN_R,X			; graphics window rt X=0 top X=2
			cpx	#$01				; is X=0
			bcs	_BC64A				; if not C64A
			sbc	#$06				; else subtract 7

_BC64A:			sta	VDU_G_CURS_H,X			; current graphics cursor X>1=vertical
			lda	VDU_G_WIN_R_HI,X		; graphics window hi rt X=0 top X=2
			sbc	#$00				; subtract carry
			sta	VDU_G_CURS_H_HI,X		; current graphics cursor X<2=horizontal else vertical
			txa					; A=X
			beq	_BC660				; cursor up
_BC658:			jmp	_LD1B8				; set up external coordinates for graphics

;*************************************************************************
;*									 *
;*	 VDU 11 - CURSOR UP						 *
;*									 *
;*************************************************************************

_VDU_11:		jsr	_LC588				; A=0 if text cursor A=&20 if graphics cursor
			beq	_BC5F4				; if text cursor then C5F4
_BC660:			ldx	#$02				; else X=2
			bne	_BC6B6				; goto C6B6

;*************************************************************************
;*									 *
;*	 VDU 9	- CURSOR RIGHT						 *
;*									 *
;*************************************************************************

_VDU_9:			lda	VDU_STATUS			; VDU status byte
			and	#$20				; check bit 5
			bne	_BC6B4				; if set then graphics cursor in use so C6B4
			ldx	VDU_T_CURS_X			; text column
			cpx	VDU_T_WIN_R			; text window right
			bcs	_BC684				; if X exceeds window right then C684
			inc	VDU_T_CURS_X			; text column
			lda	VDU_CRTC_CUR			; text cursor 6845 address
			adc	VDU_BPC				; add bytes per character
			tax					; X=A
			lda	VDU_CRTC_CUR_HI			; text cursor 6845 address
			adc	#$00				; add carry if set
			jmp	_LC9F6				; use X and Y to set new cursor address

;********: text cursor down and right *************************************

_BC684:			lda	VDU_T_WIN_L			; text window left
			sta	VDU_T_CURS_X			; text column

;********: text cursor down *************************************

_BC68A:			clc					; clear carry
			jsr	_LCAE3				; check bottom margin, X=line count
			ldx	VDU_T_CURS_Y			; current text line
			cpx	VDU_T_WIN_B			; bottom margin
			bcs	_BC69B				; if X=>current bottom margin C69B
			inc	VDU_T_CURS_Y			; else increment current text line
			bcc	_LC6AF				; 
_BC69B:			jsr	_LCD3F				; check for window violations
			lda	#$08				; check bit 3
			bit	VDU_STATUS			; VDU status byte
			bne	_BC6A9				; if software scrolling enabled C6A9
			jsr	_LC9A4				; perform hardware scroll
			bne	_LC6AC				; 
_BC6A9:			jsr	_LCDFF				; execute upward scroll
_LC6AC:			jsr	_LCEAC				; clear a line

_LC6AF:			jsr	_LCF06				; set up display address
			bcc	_BC732				; 

;*********** graphic cursor right ****************************************

_BC6B4:			ldx	#$00				; 

;************** graphic cursor up  (X=2) **********************************

_BC6B6:			stx	VDU_TMP2			; store X
			jsr	_LD10D				; check for window violations
			ldx	VDU_TMP2			; get back X
			clc					; clear carry
			lda	VDU_G_CURS_H,X			; current graphics cursor X>1=vertical
			adc	#$08				; Add 8 pixels
			sta	VDU_G_CURS_H,X			; current graphics cursor X>1=vertical
			bcc	_BC6CB				; 
			inc	VDU_G_CURS_H_HI,X		; current graphics cursor X<2=horizontal else vertical
_BC6CB:			lda	VDU_TMP1			; A=0 no window violations 1 or 2 indicates violation
			bne	_BC658				; if outside window C658
			jsr	_LD10D				; check for window violations
			beq	_BC658				; if no violations C658

			ldx	VDU_TMP2			; get back X
			lda	VDU_G_WIN_L,X			; graphics window X<2 =left else bottom
			cpx	#$01				; If X=0
			bcc	_BC6DF				; C6DF
			adc	#$06				; else add 7
_BC6DF:			sta	VDU_G_CURS_H,X			; current graphics cursor X>1=vertical
			lda	VDU_G_WIN_L_HI,X		; graphics window hi X<2 =left else bottom
			adc	#$00				; add anny carry
			sta	VDU_G_CURS_H_HI,X		; current graphics cursor X<2=horizontal else vertical
			txa					; A=X
			beq	_BC6F5				; if X=0 C6F5 cursor down
			jmp	_LD1B8				; set up external coordinates for graphics

;*************************************************************************
;*									 *
;*	 VDU 10	 - CURSOR DOWN						 *
;*									 *
;*************************************************************************

_VDU_10:		jsr	_LC588				; A=0 if text cursor A=&20 if graphics cursor
			beq	_BC68A				; if text cursor back to C68A
_BC6F5:			ldx	#$02				; else X=2 to indicate vertical movement
			jmp	_LC621				; move graphics cursor down

;*************************************************************************
;*									 *
;*	 VDU 28 - DEFINE TEXT WINDOW					 *
;*									 *
;*	 4 parameters							 *
;*									 *
;*************************************************************************
;parameters are set up thus
;0320  P1 left margin
;0321  P2 bottom margin
;0322  P3 right margin
;0323  P4 top margin
;Note that last parameter is always in 0323

_VDU_28:		ldx	VDU_MODE			; screen mode
			lda	VDU_QUEUE_6			; get bottom margin
			cmp	VDU_QUEUE_8			; compare with top margin
			bcc	_BC758				; if bottom margin exceeds top return
			cmp	_TEXT_ROW_TABLE,X		; text window bottom margin maximum
			beq	_BC70C				; if equal then its OK
			bcs	_BC758				; else exit

_BC70C:			lda	VDU_QUEUE_7			; get right margin
			tay					; put it in Y
			cmp	_TEXT_COL_TABLE,X		; text window right hand margin maximum
			beq	_BC717				; if equal then OK
			bcs	_BC758				; if greater than maximum exit

_BC717:			sec					; set carry to subtract
			sbc	VDU_QUEUE_5			; left margin
			bmi	_BC758				; if left greater than right exit
			tay					; else A=Y (window width)
			jsr	_LCA88				; calculate number of bytes in a line
			lda	#$08				; A=8 to set bit  of &D0
			jsr	_LC59D				; indicating that text window is defined
			ldx	#$20				; point to parameters
			ldy	#$08				; point to text window margins
			jsr	_LD48A				; (&300/3+Y)=(&300/3+X)
			jsr	_LCEE8				; set up screen address
			bcs	_VDU_30				; home cursor within window
_BC732:			jmp	_LCA02				; set cursor position


;*************************************************************************
;*									 *
;*	 OSWORD 9  - READ A PIXEL					 *
;*	 =POINT(X,Y)							 *
;*									 *
;*************************************************************************
;on entry  &EF=A=9
;	   &F0=X=low byte of parameter block address
;	   &F1=Y=high byte of parameter block address
;	PARAMETER BLOCK
;	0,1=X coordinate
;	2,3=Y coordinate
;on exit, result in BLOCK+4
;     =&FF if point was of screen or logical colour of point if on screen

			.org	$c735

_OSWORD_9:		ldy	#$03				; Y=3 to point to hi byte of Y coordinate
_BC737:			lda	(OSW_X),Y			; get it
			sta	VDU_BITMAP_READ,Y		; store it
			dey					; point to next byte
			bpl	_BC737				; transfer till Y=&FF lo byte of X coordinate in &328
			lda	#$28				; 
			jsr	_LD839				; check window boundaries
			ldy	#$04				; Y=4
			bne	_BC750				; jump to C750


;*************************************************************************
;*									 *
;*	 OSWORD 11 - READ PALLETTE					 *
;*									 *
;*************************************************************************
;on entry  &EF=A=11
;	   &F0=X=low byte of parameter block address
;	   &F1=Y=high byte of parameter block address
;	PARAMETER BLOCK
;	0=logical colour to read
;on exit, result in BLOCK
;	0=logical colour
;	1=physical colour
;	2=red colour component	\
;	3=green colour component } when set using analogue colours
;	4=blue colour component /

_OSWORD_11:		and	VDU_COL_MASK			; number of logical colours less 1
			tax					; put it in X
			lda	VDU_PALETTE,X			; colour pallette
_BC74F:			iny					; increment Y to point to byte 1

_BC750:			sta	(OSW_X),Y			; store data
			lda	#$00				; issue 0s
			cpy	#$04				; to next bytes until Y=4
			bne	_BC74F				; 

_BC758:			rts					; and exit


;*************************************************************************
;*									 *
;*	 VDU 12 - CLEAR TEXT SCREEN					 *
;*	 CLS								 *
;*									 *
;*************************************************************************

_VDU_12:		jsr	_LC588				; A=0 if text cursor A=&20 if graphics cursor
			bne	_BC7BD				; if graphics cursor &C7BD
			lda	VDU_STATUS			; VDU status byte
			and	#$08				; check if software scrolling (text window set)
			bne	_BC767				; if so C767
			jmp	_LCBC1				; initialise screen display and home cursor

_BC767:			ldx	VDU_T_WIN_T			; top of text window
_BC76A:			stx	VDU_T_CURS_Y			; current text line
			jsr	_LCEAC				; clear a line

			ldx	VDU_T_CURS_Y			; current text line
			cpx	VDU_T_WIN_B			; bottom margin
			inx					; X=X+1
			bcc	_BC76A				; if X at compare is less than bottom margin clear next


;*************************************************************************
;*									 *
;*	 VDU 30 - HOME CURSOR						 *
;*									 *
;*************************************************************************

_VDU_30:		jsr	_LC588				; A=0 if text cursor A=&20 if graphics cursor
			beq	_BC781				; if text cursor C781
			jmp	_LCFA6				; home graphic cursor if graphic
_BC781:			sta	VDU_QUEUE_8			; store 0 in last two parameters
			sta	VDU_QUEUE_7			; 


;*************************************************************************
;*									 *
;*	 VDU 31 - POSITION TEXT CURSOR					 *
;*	 TAB(X,Y)							 *
;*									 *
;*	 2 parameters							 *
;*									 *
;*************************************************************************
;0322 = supplied X coordinate
;0323 = supplied Y coordinate

_VDU_31:		jsr	_LC588				; A=0 if text cursor A=&20 if graphics cursor
			bne	_BC758				; exit
			jsr	_LC7A8				; exchange text column/line with workspace 0328/9
			clc					; clear carry
			lda	VDU_QUEUE_7			; get X coordinate
			adc	VDU_T_WIN_L			; add to text window left
			sta	VDU_T_CURS_X			; store as text column
			lda	VDU_QUEUE_8			; get Y coordinate
			clc					; 
			adc	VDU_T_WIN_T			; add top of text window
			sta	VDU_T_CURS_Y			; current text line
			jsr	_LCEE8				; set up screen address
			bcc	_BC732				; set cursor position if C=0 (point on screen)
_LC7A8:			ldx	#$18				; else point to workspace
			ldy	#$28				; and line/column to restore old values
			jmp	_LCDDE				; exchange &300/1+X with &300/1+Y


;*************************************************************************
;*									 *
;*	 VDU 13 - CARRIAGE RETURN					 *
;*									 *
;*************************************************************************

_VDU_13:		jsr	_LC588				; A=0 if text cursor A=&20 if graphics cursor
			beq	_BC7B7				; if text C7B7
			jmp	_LCFAD				; else set graphics cursor to left hand columm

_BC7B7:			jsr	_LCE6E				; set text column to left hand column
			jmp	_LC6AF				; set up cursor and display address

_BC7BD:			jsr	_LCFA6				; home graphic cursor


;*************************************************************************
;*									 *
;*	 VDU 16 - CLEAR GRAPHICS SCREEN					 *
;*	 CLG								 *
;*									 *
;*************************************************************************

_VDU_16:		lda	VDU_PIX_BYTE			; pixels per byte
			beq	_BC7F8				; if 0 current mode has no graphics so exit
			ldx	VDU_G_BG			; Background graphics colour
			ldy	VDU_P_BG			; background graphics plot mode (GCOL n)
			jsr	_LD0B3				; set graphics byte mask in &D4/5
			ldx	#$00				; graphics window
			ldy	#$28				; workspace
			jsr	_LD47C				; set(300/7+Y) from (300/7+X)
			sec					; set carry
			lda	VDU_G_WIN_T			; graphics window top lo.
			sbc	VDU_G_WIN_B			; graphics window bottom lo
			tay					; Y=difference
			iny					; increment
			sty	VDU_WORKSPACE			; and store in workspace (this is line count)
_BC7E1:			ldx	#$2c				; 
			ldy	#$28				; 
			jsr	_VDU_G_CLR_LINE			; clear line
			lda	VDU_BITMAP_RD_6			; decrement window height in pixels
			bne	_BC7F0				; 
			dec	VDU_BITMAP_RD_7			; 
_BC7F0:			dec	VDU_BITMAP_RD_6			; 
			dec	VDU_WORKSPACE			; decrement line count
			bne	_BC7E1				; if <>0 then do it again
_BC7F8:			rts					; exit


;*************************************************************************
;*									 *
;*	 VDU 17 - DEFINE TEXT COLOUR					 *
;*	 COLOUR n							 *
;*									 *
;*	 1 parameter							 *
;*									 *
;*************************************************************************
;parameter in &0323

_VDU_17:		ldy	#$00				; Y=0
			beq	_BC7FF				; jump to C7FF


;*************************************************************************
;*									 *
;*	 VDU 18 - DEFINE GRAPHICS COLOUR				 *
;*	 GCOL k,c							 *
;*									 *
;*	 2 parameters							 *
;*									 *
;*************************************************************************
;parameters in 323,322

_VDU_18:		ldy	#$02				; Y=2

_BC7FF:			lda	VDU_QUEUE_8			; get last parameter
			bpl	_BC805				; if +ve it's foreground colour so C805
			iny					; else Y=Y+1
_BC805:			and	VDU_COL_MASK			; number of logical colours less 1
			sta	VDU_TMP1			; store it
			lda	VDU_COL_MASK			; number of logical colours less 1
			beq	_BC82B				; if none exit
			and	#$07				; else limit to an available colour and clear M
			clc					; clear carry
			adc	VDU_TMP1			; Add last parameter to get pointer to table
			tax					; pointer into X

			lda	_LC423,X			; get plot options from table
			sta	VDU_T_FG,Y			; colour Y=0=text fgnd 1= text bkgnd 2=graphics fg etc
			cpy	#$02				; If Y>1
			bcs	_BC82C				; then its graphics so C82C else
			lda	VDU_T_FG			; foreground text colour
			eor	#$ff				; invert
			sta	VDU_T_EOR_MASK			; text colour byte to be orred or EORed into memory
			eor	VDU_T_BG			; background text colour
			sta	VDU_T_OR_MASK			; text colour byte to be orred or EORed into memory
_BC82B:			rts					; and exit

_BC82C:			lda	VDU_QUEUE_7			; get first parameter
			sta	VDU_G_FG,Y			; text colour Y=0=foreground 1=background etc.
			rts					; exit

_BC833:			lda	#$20				; 
			sta	VDU_T_BG			; background text colour
			rts					; 


;*************************************************************************
;*									 *
;*	 VDU 20 - RESTORE DEFAULT COLOURS				 *
;*									 *
;*************************************************************************

_VDU_20:		ldx	#$05				; X=5

			lda	#$00				; A=0
_BC83D:			sta	VDU_T_FG,X			; zero all colours
			dex					; 
			bpl	_BC83D				; until X=&FF
			ldx	VDU_COL_MASK			; number of logical colours less 1
			beq	_BC833				; if none its MODE 7 so C833
			lda	#$ff				; A=&FF
			cpx	#$0f				; if not mode 2 (16 colours)
			bne	_BC850				; goto C850

			lda	#$3f				; else A=&3F
_BC850:			sta	VDU_T_FG			; foreground text colour
			sta	VDU_G_FG			; foreground graphics colour
			eor	#$ff				; invert A
			sta	VDU_T_OR_MASK			; text colour byte to be orred or EORed into memory
			sta	VDU_T_EOR_MASK			; text colour byte to be orred or EORed into memory
			stx	VDU_QUEUE_4			; set first parameter of 5
			cpx	#$03				; if there are 4 colours
			beq	_BC874				; goto C874
			bcc	_BC885				; if less there are 2 colours goto C885
								; else there are 16 colours
			stx	VDU_QUEUE_5			; set second parameter
_BC868:			jsr	_VDU_19				; do VDU 19 etc
			dec	VDU_QUEUE_5			; decrement first parameter
			dec	VDU_QUEUE_4			; and last parameter
			bpl	_BC868				; 
			rts					; 

;********* 4 colour mode *************************************************

_BC874:			ldx	#$07				; X=7
			stx	VDU_QUEUE_5			; set first parameter
_BC879:			jsr	_VDU_19				; and do VDU 19
			lsr	VDU_QUEUE_5			; 
			dec	VDU_QUEUE_4			; 
			bpl	_BC879				; 
			rts					; exit

;********* 2 colour mode ************************************************

_BC885:			ldx	#$07				; X=7
			jsr	_LC88F				; execute VDU 19
			ldx	#$00				; X=0
			stx	VDU_QUEUE_4			; store it as
_LC88F:			stx	VDU_QUEUE_5			; both parameters


;*************************************************************************
;*									 *
;*	 VDU 19 - DEFINE COLOURS					 *
;*	[COLOUR l,p]							 *
;*	[COLOUR l,r,g,b]						 *
;*									 *
;*	 5 parameters							 *
;*									 *
;*************************************************************************
;&31F=first parameter logical colour
;&320=second physical colour

_VDU_19:		php					; push processor flags
			sei					; disable interrupts
			lda	VDU_QUEUE_4			; get first parameter and
			and	VDU_COL_MASK			; number of logical colours less 1
			tax					; toi make legal  X=A
			lda	VDU_QUEUE_5			; A=second parameter
_LC89E:			and	#$0f				; make legal
			sta	VDU_PALETTE,X			; colour pallette
			tay					; Y=A
			lda	VDU_COL_MASK			; number of logical colours less 1
			sta	MOS_WS_0			; store it
			cmp	#$03				; is it 4 colour mode??
			php					; save flags
			txa					; A=X
_BC8AD:			ror					; rotate A into &FA
			ror	MOS_WS_0			; 
			bcs	_BC8AD				; 
			asl	MOS_WS_0			; 
			tya					; A=Y
			ora	MOS_WS_0			; 
			tax					; 
			ldy	#$00				; Y=0
_BC8BA:			plp					; check flags
			php					; 
			bne	_BC8CC				; if A<>3 earlier C8CC
			and	#$60				; else A=&60 to test bits 5 and 6
			beq	_BC8CB				; if not set C8CB
			cmp	#$60				; else if both set
			beq	_BC8CB				; C8CB
			txa					; A=X
			eor	#$60				; invert
			bne	_BC8CC				; and if not 0 C8CC

_BC8CB:			txa					; X=A
_BC8CC:			jsr	_LEA11				; call Osbyte 155 pass data to pallette register
			tya					; 
			sec					; 
			adc	VDU_COL_MASK			; number of logical colours less 1
			tay					; 
			txa					; 
			adc	#$10				; 
			tax					; 
			cpy	#$10				; if Y<16 do it again
			bcc	_BC8BA				; 
			plp					; pull flags twice
			plp					; 
			rts					; and exit


;*************************************************************************
;*									 *
;*	 OSWORD 12 - WRITE PALLETTE					 *
;*									 *
;*************************************************************************
;on entry X=&F0:Y=&F1:YX points to parameter block
;byte 0 = logical colour;  byte 1 physical colour; bytes 2-4=0

_OSWORD_12:		php					; push flags
			and	VDU_COL_MASK			; and with number of logical colours less 1
			tax					; X=A
			iny					; Y=Y+1
			lda	(OSW_X),Y			; get phsical colour
			jmp	_LC89E				; do VDU19 with parameters in X and A


;*************************************************************************
;*									 *
;*	 VDU 22 - SELECT MODE						 *
;*	 MODE n								 *
;*									 *
;*	 1 parameter							 *
;*									 *
;*************************************************************************
;parameter in &323

_VDU_22:		lda	VDU_QUEUE_8			; get parameter
			jmp	_LCB33				; goto CB33


;*************************************************************************
;*									 *
;*	 VDU 23 - DEFINE CHARACTERS					 *
;*									 *
;*	 9 parameters							 *
;*									 *
;*************************************************************************
;parameters are:-
;31B character to define
;31C to 323 definition

_VDU_23:		lda	VDU_QUEUE			; get character to define
			cmp	#$20				; is it ' '
			bcc	_VDU_23_CTRL			; if less then it is a control instruction, goto C93F
_VDU_23_DEFINE_CHAR:	pha					; else save parameter
			lsr					; A=A/32
			lsr					; 
			lsr					; 
			lsr					; 
			lsr					; 
			tax					; X=A
			lda	_LC40D,X			; get font flag mask from table (A=&80/2^X)
			bit	VDU_FONT_FLAGS			; font flag
			bne	_BC927				; and if A<>0 C927 storage area is established already
			ora	VDU_FONT_FLAGS			; or with font flag to set bit found to be 0
			sta	VDU_FONT_FLAGS			; font flag
			txa					; get back A
			and	#$03				; And 3 to clear all but bits 0 and 1
			clc					; clear carry
			adc	#$bf				; add &BF (A=&C0,&C1,&C2) to select a character page
			sta	VDU_TMP6			; store it
			lda	VDU_FONT_FLAGS,X		; get font location byte (normally &0C)
			sta	VDU_TMP4			; store it
			ldy	#$00				; Y=0 so (&DE) holds (&C000 -&C2FF)
			sty	VDU_TMP3			; 
			sty	VDU_TMP5			; 
_BC920:			lda	(VDU_TMP5),Y			; transfer page to storage area
			sta	(VDU_TMP3),Y			; 
			dey					; 
			bne	_BC920				; 

_BC927:			pla					; get back A
			jsr	_LD03E				; set up character definition pointers

			ldy	#$07				; Y=7
_BC92D:			lda	VDU_QUEUE_1,Y			; transfer definition parameters
			sta	(VDU_TMP5),Y			; to RAM definition
			dey					; 
			bpl	_BC92D				; 
			rts					; and exit

			pla					; Pull A
_BC937:			rts					; and exit


;************ VDU EXTENSION **********************************************

_LC938:			lda	VDU_QUEUE_4			; A=fifth VDU parameter
			clc					; clear carry
__vdu_23_vduv:		jmp	(VEC_VDUV)			; jump via VDUV vector

;********** VDU control commands *****************************************

_VDU_23_CTRL:		cmp	#$01				; is A=1
			bcc	_VDU_23_SET_CRTC		; if less (0) then set CRT register directly

			bne	__vdu_23_vduv			; if not 1 jump to VDUV for VDU extension

;********** turn cursor on/off *******************************************

			jsr	_LC588				; A=0 if text cursor, A=&20 if graphics cursor
			bne	_BC937				; if graphics exit
			lda	#$20				; A=&20 - preload to turn cursor off
			ldy	VDU_QUEUE_1			; Y=second VDU parameter
			beq	_LC954				; if 0, jump to C954 to turn cursor off
_LC951:			lda	VDU_CURS_PREV			; get last setting of CRT controller register
								; for cursor on
_LC954:			ldy	#$0a				; Y=10 - cursor control register number
			bne	_BC985				; jump to C985, Y=register, Y=value

;********** set CRT controller *******************************************

_VDU_23_SET_CRTC:	lda	VDU_QUEUE_2			; get third
			ldy	VDU_QUEUE_1			; and second parameter
_LC95E:			cpy	#$07				; is Y=7
			bcc	_BC985				; if less C985
			bne	_BC967				; else if >7 C967
			adc	VDU_ADJUST			; else ADD screen vertical display adjustment

_BC967:			cpy	#$08				; If Y<>8
			bne	_BC972				; C972
			ora	#$00				; if bit 7 set
			bmi	_BC972				; C972
			eor	VDU_INTERLACE			; else EOR with interlace toggle

_BC972:			cpy	#$0a				; Y=10??
			bne	_BC985				; if not C985
			sta	VDU_CURS_PREV			; last setting of CRT controller register
			tay					; Y=A
			lda	VDU_STATUS			; VDU status byte
			and	#$20				; check bit 5 printing at graphics cursor??
			php					; push flags
			tya					; Y=A
			ldy	#$0a				; Y=10
			plp					; pull flags
			bne	_BC98B				; if graphics in use then C98B


_BC985:			sty	CRTC_ADDRESS			; else set CRTC address register
			sta	CRTC_DATA			; and poke new value to register Y
_BC98B:			rts					; exit


;*************************************************************************
;*									 *
;*	 VDU 25 - PLOT							 *
;*	 PLOT k,x,y							 *
;*	 DRAW x,y							 *
;*	 MOVE x,y							 *
;*	 PLOT x,y							 *
;*	 5 parameters							 *
;*									 *
;*************************************************************************

_VDU_25:		ldx	VDU_PIX_BYTE			; pixels per byte
			beq	_LC938				; if no graphics available go to VDU Extension
			jmp	_LD060				; else enter Plot routine at D060

;********** adjust screen RAM addresses **********************************

_LC994:			ldx	VDU_MEM				; window area start address lo
			lda	VDU_MEM_HI			; window area start address hi
			jsr	_LCCF8				; subtract bytes per character row from this
			bcs	_BC9B3				; if no wraparound needed C9B3

			adc	VDU_MEM_PAGES			; screen RAM size hi byte to wrap around
			bcc	_BC9B3				; 

_LC9A4:			ldx	VDU_MEM				; window area start address lo
			lda	VDU_MEM_HI			; window area start address hi
			jsr	_LCAD4				; add bytes per char. row
			bpl	_BC9B3				; 

			sec					; wrap around i other direction
			sbc	VDU_MEM_PAGES			; screen RAM size hi byte
_BC9B3:			sta	VDU_MEM_HI			; window area start address hi
			stx	VDU_MEM				; window area start address lo
			ldy	#$0c				; Y=12
			bne	_BCA0E				; jump to CA0E


;*************************************************************************
;*									 *
;*	 VDU 26 - SET DEFAULT WINDOWS					 *
;*									 *
;*************************************************************************

_VDU_26:		lda	#$00				; A=0
			ldx	#$2c				; X=&2C

_BC9C1:			sta	VDU_G_WIN_L,X			; clear all windows
			dex					; 
			bpl	_BC9C1				; until X=&FF

			ldx	VDU_MODE			; screen mode
			ldy	_TEXT_COL_TABLE,X		; text window right hand margin maximum
			sty	VDU_T_WIN_R			; text window right
			jsr	_LCA88				; calculate number of bytes in a line
			ldy	_TEXT_ROW_TABLE,X		; text window bottom margin maximum
			sty	VDU_T_WIN_B			; bottom margin
			ldy	#$03				; Y=3
			sty	VDU_QUEUE_8			; set as last parameter
			iny					; increment Y
			sty	VDU_QUEUE_6			; set parameters
			dec	VDU_QUEUE_7			; 
			dec	VDU_QUEUE_5			; 
			jsr	_VDU_24				; and do VDU 24
			lda	#$f7				; 
			jsr	_LC5A8				; clear bit 3 of &D0
			ldx	VDU_MEM				; window area start address lo
			lda	VDU_MEM_HI			; window area start address hi
_LC9F6:			stx	VDU_CRTC_CUR			; text cursor 6845 address
			sta	VDU_CRTC_CUR_HI			; text cursor 6845 address
			bpl	_LCA02				; set cursor position
			sec					; 
			sbc	VDU_MEM_PAGES			; screen RAM size hi byte

;**************** set cursor position ************************************

_LCA02:			stx	VDU_TOP_SCAN			; set &D8/9 from X/A
			sta	VDU_TOP_SCAN_HI			; 
			ldx	VDU_CRTC_CUR			; text cursor 6845 address
			lda	VDU_CRTC_CUR_HI			; text cursor 6845 address
			ldy	#$0e				; Y=15
_BCA0E:			pha					; Push A
			lda	VDU_MODE			; screen mode
			cmp	#$07				; is it mode 7?
			pla					; get back A
			bcs	_BCA27				; if mode 7 selected CA27
			stx	VDU_TMP1			; else store X
			lsr					; divide X/A by 8
			ror	VDU_TMP1			; 
			lsr					; 
			ror	VDU_TMP1			; 
			lsr					; 
			ror	VDU_TMP1			; 
			ldx	VDU_TMP1			; 
			jmp	_LCA2B				; goto CA2B

_BCA27:			sbc	#$74				; mode 7 subtract &74
			eor	#$20				; EOR with &20
_LCA2B:			sty	CRTC_ADDRESS			; write to CRTC address file register
			sta	CRTC_DATA			; and to relevant address (register 14)
			iny					; Increment Y
			sty	CRTC_ADDRESS			; write to CRTC address file register
			stx	CRTC_DATA			; and to relevant address (register 15)
			rts					; and RETURN

;*************************************************************************
;*									 *
;*	 VDU 24 - DEFINE GRAPHICS WINDOW				 *
;*									 *
;*	 8 parameters							 *
;*									 *
;*************************************************************************
;&31C/D Left margin
;&31E/F Bottom margin
;&320/1 Right margin
;&322/3 Top margin

			.org	$ca39

_VDU_24:		jsr	_LCA81				; exchange 310/3 with 328/3
			ldx	#$1c				; 
			ldy	#$2c				; 
			jsr	_LD411				; calculate width=right - left
								; height = top-bottom
			ora	VDU_BITMAP_RD_5			; 
			bmi	_LCA81				; exchange 310/3 with 328/3 and exit
			ldx	#$20				; X=&20
			jsr	_LD149				; scale pointers to mode
			ldx	#$1c				; X=&1C
			jsr	_LD149				; scale pointers to mode
			lda	VDU_QUEUE_4			; check for negative margins
			ora	VDU_QUEUE_2			; 
			bmi	_LCA81				; if found exchange 310/3 with 328/3 and exit
			lda	VDU_QUEUE_8			; 
			bne	_LCA81				; exchange 310/3 with 328/3 and exit
			ldx	VDU_MODE			; screen mode
			lda	VDU_QUEUE_6			; right margin hi
			sta	VDU_TMP1			; store it
			lda	VDU_QUEUE_5			; right margin lo
			lsr	VDU_TMP1			; /2
			ror					; A=A/2
			lsr	VDU_TMP1			; /2
			bne	_LCA81				; exchange 310/3 with 328/3
			ror					; A=A/2
			lsr					; A=A/2
			cmp	_TEXT_COL_TABLE,X		; text window right hand margin maximum
			beq	_BCA7A				; if equal CA7A
			bpl	_LCA81				; exchange 310/3 with 328/3

_BCA7A:			ldy	#$00				; Y=0
			ldx	#$1c				; X=&1C
			jsr	_LD47C				; set(300/7+Y) from (300/7+X)

;***************** exchange 310/3 with 328/3 *****************************

_LCA81:			ldx	#$10				; X=10
			ldy	#$28				; Y=&28
			jmp	_LCDE6				; exchange 300/3+Y and 300/3+X

_LCA88:			iny					; Y=Y+1
			tya					; A=Y
			ldy	#$00				; Y=0
			sty	VDU_T_WIN_SZ_HI			; text window width hi (bytes)
			sta	VDU_T_WIN_SZ			; text window width lo (bytes)
			lda	VDU_BPC				; bytes per character
			lsr					; /2
			beq	_BCAA1				; if 0 exit
_BCA98:			asl	VDU_T_WIN_SZ			; text window width lo (bytes)
			rol	VDU_T_WIN_SZ_HI			; text window width hi (bytes)
			lsr					; /2
			bcc	_BCA98				; 
_BCAA1:			rts					; 


;*************************************************************************
;*									 *
;*	 VDU 29 - SET GRAPHICS ORIGIN					 *
;*									 *
;*	 4 parameters							 *
;*									 *
;*************************************************************************

_VDU_29:		ldx	#$20				; 
			ldy	#$0c				; 
			jsr	_LD48A				; (&300/3+Y)=(&300/3+X)
			jmp	_LD1B8				; set up external coordinates for graphics


;*************************************************************************
;*									 *
;*	 VDU 127 (&7F) - DELETE (entry 32)				 *
;*									 *
;*************************************************************************

_VDU_127:		jsr	_VDU_8				; cursor left
			jsr	_LC588				; A=0 if text cursor A=&20 if graphics cursor
			bne	__vdu_del_modeX			; if graphics then CAC7
			ldx	VDU_COL_MASK			; number of logical colours less 1
			beq	__vdu_del_mode7			; if mode 7 CAC2
			sta	VDU_TMP5			; else store A (always 0)
			lda	#$c0				; A=&C0
			sta	VDU_TMP6			; store in &DF (&DE) now points to C300 SPACE pattern
			jmp	_LCFBF				; display a space

__vdu_del_mode7:	lda	#$20				; A=&20
			jmp	_VDU_OUT_MODE7			; and return to display a space

__vdu_del_modeX:	lda	#$7f				; for graphics cursor
			jsr	_LD03E				; set up character definition pointers
			ldx	VDU_G_BG			; Background graphics colour
			ldy	#$00				; Y=0
			jmp	_LCF63				; invert pattern data (to background colour)

;***** Add number of bytes in a line to X/A ******************************

_LCAD4:			pha					; store A
			txa					; A=X
			clc					; clear carry
			adc	VDU_BPR				; bytes per character row
			tax					; X=A
			pla					; get back A
			adc	VDU_BPR_HI			; bytes per character row
			rts					; and return

;********* control scrolling in paged mode *******************************

_BCAE0:			jsr	_LCB14				; zero paged mode line counter
_LCAE3:			jsr	_OSBYTE_118			; osbyte 118 check keyboard status; set LEDs
			bcc	_BCAEA				; if carry clear CAEA
			bmi	_BCAE0				; if M set CAE0 do it again

_BCAEA:			lda	VDU_STATUS			; VDU status byte
			eor	#$04				; invert bit 2 paged scrolling
			and	#$46				; and if 2 cursors, paged mode off, or scrolling
			bne	_BCB1C				; barred then CB1C to exit

			lda	OSB_HALT_LINES			; paged mode counter
			bmi	_BCB19				; if negative then exit via CB19

			lda	VDU_T_CURS_Y			; current text line
			cmp	VDU_T_WIN_B			; bottom margin
			bcc	_BCB19				; increment line counter and exit

			lsr					; A=A/4
			lsr					; 
			sec					; set carry
			adc	OSB_HALT_LINES			; paged mode counter
			adc	VDU_T_WIN_T			; top of text window
			cmp	VDU_T_WIN_B			; bottom margin
			bcc	_BCB19				; increment line counter and exit

			clc					; clear carry
_BCB0E:			jsr	_OSBYTE_118			; osbyte 118 check keyboard status; set LEDs
			sec					; set carry
			bpl	_BCB0E				; if +ve result then loop till shift pressed

;**************** zero paged mode  counter *******************************

_LCB14:			lda	#$ff				; 
			sta	OSB_HALT_LINES			; paged mode counter
_BCB19:			inc	OSB_HALT_LINES			; paged mode counter
_BCB1C:			rts					; 

;********* intitialise VDU driver with MODE in A *************************

_VDU_INIT_MODE:		pha					; Save MODE in A
			ldx	#$7f				; Prepare X=&7F for reset loop
			lda	#$00				; A=0
			sta	VDU_STATUS			; Clear VDU status byte to set default conditions

__vdu_mode_init_loop:	sta	OSFILE_CB_17,X			; Zero VDU workspace at &300 to &37E
			dex					
			bne	__vdu_mode_init_loop		

			jsr	_OSBYTE_20			; Implode character definitions
			pla					; Get initial MODE back to A
			ldx	#$7f				; X=&7F
			stx	VDU_TTX_CURSOR			; MODE 7 copy cursor character (could have set this at CB1E)

;********* enter here from VDU 22,n - MODE *******************************

_LCB33:			bit	OSB_RAM_PAGES			; Check available RAM
			bmi	_BCB3A				; If 32K, use all MODEs
			ora	#$04				; Only 16K available, force to use MODEs 4-7

_BCB3A:			and	#$07				; X=A and 7 ensure legal mode
			tax					; X=mode
			stx	VDU_MODE			; Save current screen MODE
			lda	_LC414,X			; Get number of colours -1 for this MODE
			sta	VDU_COL_MASK			; Set current number of logical colours less 1
			lda	_TXT_BPC_TABLE,X		; Get bytes/character for this MODE
			sta	VDU_BPC				; Set bytes per character
			lda	_LC43A,X			; Get pixels/byte for this MODE
			sta	VDU_PIX_BYTE			; Set pixels per byte
			bne	_BCB56				; If non-zero, skip past
			lda	#$07				; byte/pixel=0, this is MODE 7, prepare A=7 offset into mask table

_BCB56:			asl					; A=A*2
			tay					; Y=A

			lda	_LC406,Y			; mask table
			sta	VDU_MASK_LEFT			; colour mask left
_BCB5E:			asl					; A=A*2
			bpl	_BCB5E				; If still +ve CB5E
			sta	VDU_MASK_RIGHT			; colour mask right
			ldy	_LC440,X			; screen display memory index table
			sty	VDU_MAP_TYPE			; memory map type
			lda	_LC44F,Y			; VDU section control
			jsr	_WRITE_SYS_VIA_PORTB		; set hardware scrolling to VIA
			lda	_LC44B,Y			; VDU section control
			jsr	_WRITE_SYS_VIA_PORTB		; set hardware scrolling to VIA
			lda	_VDU_MEMSZ_TAB,Y		; Screen RAM size hi byte table
			sta	VDU_MEM_PAGES			; screen RAM size hi byte
			lda	_VDU_MEMLOC_TAB,Y		; screen ram address hi byte
			sta	VDU_PAGE			; hi byte of screen RAM address
			tya					; Y=A
			adc	#$02				; Add 2
			eor	#$07				; 
			lsr					; /2
			tax					; X=A
			lda	_LC466,X			; row multiplication table pointer
			sta	VDU_ROW_MULT			; store it
			lda	#$c3				; A=&C3
			sta	VDU_ROW_MULT_HI			; store it (&E0) now points to C3B5 or C375
			lda	_LC463,X			; get nuber of bytes per row from table
			sta	VDU_BPR				; store as bytes per character row
			stx	VDU_BPR_HI			; bytes per character row
			lda	#$43				; A=&43
			jsr	_LC5A8				; A=A and &D0:&D0=A
			ldx	VDU_MODE			; screen mode
			lda	_ULA_SETTINGS,X			; get video ULA control setting
			jsr	_LEA00				; set video ULA using osbyte 154 code
			php					; push flags
			sei					; set interrupts
			ldx	_LC469,Y			; get cursor end register data from table
			ldy	#$0b				; Y=11

_BCBB0:			lda	_CRTC_REG_TAB,X			; get end of 6845 registers 0-11 table
			jsr	_LC95E				; set register Y
			dex					; reduce pointers
			dey					; 
			bpl	_BCBB0				; and if still >0 do it again

			plp					; pull flags
			jsr	_VDU_20				; set default colours
			jsr	_VDU_26				; set default windows

_LCBC1:			ldx	#$00				; X=0
			lda	VDU_PAGE			; hi byte of screen RAM address
			stx	VDU_MEM				; window area start address lo
			sta	VDU_MEM_HI			; window area start address hi
			jsr	_LC9F6				; use X and Y to set new cursor address
			ldy	#$0c				; Y=12
			jsr	_LCA2B				; set registers 12 and 13 in CRTC
			lda	VDU_T_BG			; background text colour
			ldx	VDU_MAP_TYPE			; memory map type
			ldy	_LC454,X			; get section control number
			sty	VDU_JUMPVEC			; set it in jump vector lo
			ldy	#$cc				; Y=&CC
			sty	VDU_JUMPVEC_HI			; upper byte of link address
			ldx	#$00				; X=0
			stx	OSB_HALT_LINES			; paged mode counter
			stx	VDU_T_CURS_X			; text column
			stx	VDU_T_CURS_Y			; current text line
			jmp	(VDU_JUMPVEC)			; jump vector set up previously to clear screen memory


;*************************************************************************
;*									 *
;*	 OSWORD 10 - READ CHARACTER DEFINITION				 *
;*									 *
;*************************************************************************
;&EF=A:&F0=X:&F1=Y, on entry YX contains character number to be read
;(&DE) points to address
;on exit byte YX+1 to YX+8 contain definition

_OSWORD_10:		jsr	_LD03E				; set up character definition pointers
			ldy	#$00				; Y=0
_BCBF8:			lda	(VDU_TMP5),Y			; get first byte
			iny					; Y=Y+1
			sta	(OSW_X),Y			; store it in YX
			cpy	#$08				; until Y=8
			bne	_BCBF8				; 
			rts					; then exit


;*************************************************************************
;*									 *
;*	 MAIN SCREEN CLEARANCE ROUTINE					 *
;*									 *
;*************************************************************************
;on entry A contains background colour which is set in every byte
;of the screen

;************************ Mode 0,1,2 entry point *************************

_VDU_CLEAR:		sta	$3000,X				; 
			sta	$3100,X				; 
			sta	$3200,X				; 
			sta	$3300,X				; 
			sta	$3400,X				; 
			sta	$3500,X				; 
			sta	$3600,X				; 
			sta	$3700,X				; 
			sta	$3800,X				; 
			sta	$3900,X				; 
			sta	$3a00,X				; 
			sta	$3b00,X				; 
			sta	$3c00,X				; 
			sta	$3d00,X				; 
			sta	$3e00,X				; 
			sta	$3f00,X				; 

;************************ Mode 3 entry point *****************************

			sta	$4000,X				; 
			sta	$4100,X				; 
			sta	$4200,X				; 
			sta	$4300,X				; 
			sta	$4400,X				; 
			sta	$4500,X				; 
			sta	$4600,X				; 
			sta	$4700,X				; 
			sta	$4800,X				; 
			sta	$4900,X				; 
			sta	$4a00,X				; 
			sta	$4b00,X				; 
			sta	$4c00,X				; 
			sta	$4d00,X				; 
			sta	$4e00,X				; 
			sta	$4f00,X				; 
			sta	$5000,X				; 
			sta	$5100,X				; 
			sta	$5200,X				; 
			sta	$5300,X				; 
			sta	$5400,X				; 
			sta	$5500,X				; 
			sta	$5600,X				; 
			sta	$5700,X				; 

;************************ Mode 4,5 entry point ***************************

			sta	$5800,X				; 
			sta	$5900,X				; 
			sta	$5a00,X				; 
			sta	$5b00,X				; 
			sta	$5c00,X				; 
			sta	$5d00,X				; 
			sta	$5e00,X				; 
			sta	$5f00,X				; 

;************************ Mode 6 entry point *****************************

			sta	$6000,X				; 
			sta	$6100,X				; 
			sta	$6200,X				; 
			sta	$6300,X				; 
			sta	$6400,X				; 
			sta	$6500,X				; 
			sta	$6600,X				; 
			sta	$6700,X				; 
			sta	$6800,X				; 
			sta	$6900,X				; 
			sta	$6a00,X				; 
			sta	$6b00,X				; 
			sta	$6c00,X				; 
			sta	$6d00,X				; 
			sta	$6e00,X				; 
			sta	$6f00,X				; 
			sta	$7000,X				; 
			sta	$7100,X				; 
			sta	$7200,X				; 
			sta	$7300,X				; 
			sta	$7400,X				; 
			sta	$7500,X				; 
			sta	$7600,X				; 
			sta	$7700,X				; 
			sta	$7800,X				; 
			sta	$7900,X				; 
			sta	$7a00,X				; 
			sta	$7b00,X				; 

;************************ Mode 7 entry point *****************************

			sta	$7c00,X				; 
			sta	$7d00,X				; 
			sta	$7e00,X				; 
			sta	$7f00,X				; 
			inx					; 
			beq	_BCD65				; exit

;****************** execute required function ****************************

_VDU_JUMP:		jmp	(VDU_JUMPVEC)			; jump vector set up previously

;********* subtract bytes per line from X/A ******************************

_LCCF8:			pha					; Push A
			txa					; A=X
			sec					; set carry for subtraction
			sbc	VDU_BPR				; bytes per character row
			tax					; restore X
			pla					; and A
			sbc	VDU_BPR_HI			; bytes per character row
			cmp	VDU_PAGE			; hi byte of screen RAM address
_BCD06:			rts					; return


;*************************************************************************
;*									 *
;*	 OSBYTE 20 - EXPLODE CHARACTERS					 *
;*									 *
;*************************************************************************

_OSBYTE_20:		lda	#$0f				; A=15
			sta	VDU_FONT_FLAGS			; font flag indicating that page &0C,&C0-&C2 are
								; used for user defined characters
			lda	#$0c				; A=&0C
			ldy	#$06				; set loop counter

_BCD10:			sta	VDU_FONTLOC_20,Y		; set all font location bytes
			dey					; to page &0C to indicate only page available
			bpl	_BCD10				; for user character definitions

			cpx	#$07				; is X= 7 or greater
			bcc	_BCD1C				; if not CD1C
			ldx	#$06				; else X=6
_BCD1C:			stx	OSB_CHAR_EXPL			; character definition explosion switch
			lda	OSB_OSHWM_DEF			; A=primary OSHWM
			ldx	#$00				; X=0

_BCD24:			cpx	OSB_CHAR_EXPL			; character definition explosion switch
			bcs	_BCD34				; 
			ldy	_LC4BA,X			; get soft character  RAM allocation
			sta	VDU_FONTLOC_20,Y		; font location bytes
			adc	#$01				; Add 1
			inx					; X=X+1
			bne	_BCD24				; if X<>0 then CD24

_BCD34:			sta	OSB_OSHWM_CUR			; current value of page (OSHWM)
			tay					; Y=A
			beq	_BCD06				; return via CD06 (ERROR?)

			ldx	#$11				; X=&11
			jmp	_OSBYTE_143			; issue paged ROM service call &11
								; font implosion/explosion warning

;******** move text cursor to next line **********************************

_LCD3F:			lda	#$02				; A=2 to check if scrolling disabled
			bit	VDU_STATUS			; VDU status byte
			bne	_BCD47				; if scrolling is barred CD47
			bvc	_BCD79				; if cursor editing mode disabled RETURN

_BCD47:			lda	VDU_T_WIN_B			; bottom margin
			bcc	_BCD4F				; if carry clear on entry CD4F
			lda	VDU_T_WIN_T			; else if carry set get top of text window
_BCD4F:			bvs	_BCD59				; and if cursor editing enabled CD59
			sta	VDU_T_CURS_Y			; get current text line
			pla					; pull return link from stack
			pla					; 
			jmp	_LC6AF				; set up cursor and display address

_BCD59:			php					; push flags
			cmp	VDU_TI_CURS_Y			; Y coordinate of text input cursor
			beq	_BCD78				; if A=line count of text input cursor CD78 to exit
			plp					; get back flags
			bcc	_BCD66				; 
			dec	VDU_TI_CURS_Y			; Y coordinate of text input cursor

_BCD65:			rts					; exit

_BCD66:			inc	VDU_TI_CURS_Y			; Y coordinate of text input cursor
			rts					; exit

;*********************** set up write cursor ********************************

_LCD6A:			php					; save flags
			pha					; save A
			ldy	VDU_BPC				; bytes per character
			dey					; Y=Y-1
			bne	_BCD8F				; if Y=0 Mode 7 is in use

			lda	VDU_WORKSPACE+8			; so get mode 7 write character cursor character &7F
			sta	(VDU_TOP_SCAN),Y		; store it at top scan line of current character
_LCD77:			pla					; pull A
_BCD78:			plp					; pull flags
_BCD79:			rts					; and exit

_LCD7A:			php					; push flags
			pha					; push A
			ldy	VDU_BPC				; bytes per character
			dey					; 
			bne	_BCD8F				; if not mode 7
			lda	(VDU_TOP_SCAN),Y		; get cursor from top scan line
			sta	VDU_WORKSPACE+8			; store it
			lda	VDU_TTX_CURSOR			; mode 7 write cursor character
			sta	(VDU_TOP_SCAN),Y		; store it at scan line
			jmp	_LCD77				; and exit

_BCD8F:			lda	#$ff				; A=&FF =cursor
			cpy	#$1f				; except in mode 2 (Y=&1F)
			bne	_BCD97				; if not CD97
			lda	#$3f				; load cursor byte mask

;********** produce white block write cursor *****************************

_BCD97:			sta	VDU_TMP1			; store it
_BCD99:			lda	(VDU_TOP_SCAN),Y		; get scan line byte
			eor	VDU_TMP1			; invert it
			sta	(VDU_TOP_SCAN),Y		; store it on scan line
			dey					; decrement scan line counter
			bpl	_BCD99				; do it again
			bmi	_LCD77				; then jump to &CD77

_LCDA4:			jsr	_LCE5B				; exchange line and column cursors with workspace copies
			lda	VDU_T_WIN_B			; bottom margin
			sta	VDU_T_CURS_Y			; current text line
			jsr	_LCF06				; set up display address
_BCDB0:			jsr	_LCCF8				; subtract bytes per character row from this
			bcs	_BCDB8				; wraparound if necessary
			adc	VDU_MEM_PAGES			; screen RAM size hi byte
_BCDB8:			sta	VDU_TMP2			; store A
			stx	VDU_TMP1			; X
			sta	VDU_TMP3			; A again
			bcs	_BCDC6				; if C set there was no wraparound so CDC6
_BCDC0:			jsr	_LCE73				; copy line to new position
								; using (&DA) for read
								; and (&D8) for write
			jmp	_LCDCE				; 

_BCDC6:			jsr	_LCCF8				; subtract bytes per character row from X/A
			bcc	_BCDC0				; if a result is outside screen RAM CDC0
			jsr	_LCE38				; perform a copy

_LCDCE:			lda	VDU_TMP3			; set write pointer from read pointer
			ldx	VDU_TMP1			; 
			sta	VDU_TOP_SCAN_HI			; 
			stx	VDU_TOP_SCAN			; 
			dec	VDU_TMP5			; decrement window height
			bne	_BCDB0				; and if not zero CDB0
_LCDDA:			ldx	#$28				; point to workspace
			ldy	#$18				; point to text column/line
_LCDDE:			lda	#$02				; number of bytes to swap
			bne	_BCDE8				; exchange (328/9)+Y with (318/9)+X
_LCDE2:			ldx	#$24				; point to graphics cursor
_LCDE4:			ldy	#$14				; point to last graphics cursor
								; A=4 to swap X and Y coordinates

;*************** exchange 300/3+Y with 300/3+X ***************************

_LCDE6:			lda	#$04				; A =4

;************** exchange (300/300+A)+Y with (300/300+A)+X *****************

_BCDE8:			sta	VDU_TMP1			; store it as loop counter

_BCDEA:			lda	VDU_G_WIN_L,X			; get byte
			pha					; store it
			lda	VDU_G_WIN_L,Y			; get byte pointed to by Y
			sta	VDU_G_WIN_L,X			; put it in 300+X
			pla					; get back A
			sta	VDU_G_WIN_L,Y			; put it in 300+Y
			inx					; increment pointers
			iny					; 
			dec	VDU_TMP1			; decrement loop counter
			bne	_BCDEA				; and if not 0 do it again
			rts					; and exit

;******** execute upward scroll ******************************************

			.org	$cdff

_LCDFF:			jsr	_LCE5B				; exchange line and column cursors with workspace copies
			ldy	VDU_T_WIN_T			; top of text window
			sty	VDU_T_CURS_Y			; current text line
			jsr	_LCF06				; set up display address
_BCE0B:			jsr	_LCAD4				; add bytes per char. row
			bpl	_BCE14				; 
			sec					; 
			sbc	VDU_MEM_PAGES			; screen RAM size hi byte

_BCE14:			sta	VDU_TMP2			; (&DA)=X/A
			stx	VDU_TMP1			; 
			sta	VDU_TMP3			; &DC=A
			bcc	_BCE22				; 
_BCE1C:			jsr	_LCE73				; copy line to new position
								; using (&DA) for read
								; and (&D8) for write
			jmp	_LCE2A				; exit


_BCE22:			jsr	_LCAD4				; add bytes per char. row
			bmi	_BCE1C				; if outside screen RAM CE1C
			jsr	_LCE38				; perform a copy
_LCE2A:			lda	VDU_TMP3			; 
			ldx	VDU_TMP1			; 
			sta	VDU_TOP_SCAN_HI			; 
			stx	VDU_TOP_SCAN			; 
			dec	VDU_TMP5			; decrement window height
			bne	_BCE0B				; CE0B if not 0
			beq	_LCDDA				; exchange text column/linelse CDDA


;*********** copy routines ***********************************************

_LCE38:			ldx	VDU_T_WIN_SZ_HI			; text window width hi (bytes)
			beq	_BCE4D				; if no more than 256 bytes to copy X=0 so CE4D

			ldy	#$00				; Y=0 to set loop counter

_BCE3F:			lda	(VDU_TMP1),Y			; copy 256 bytes
			sta	(VDU_TOP_SCAN),Y		; 
			iny					; 
			bne	_BCE3F				; Till Y=0 again
			inc	VDU_TOP_SCAN_HI			; increment hi bytes
			inc	VDU_TMP2			; 
			dex					; decrement window width
			bne	_BCE3F				; if not 0 go back and do loop again

_BCE4D:			ldy	VDU_T_WIN_SZ			; text window width lo (bytes)
			beq	_BCE5A				; if Y=0 CE5A

_BCE52:			dey					; else Y=Y-1
			lda	(VDU_TMP1),Y			; copy Y bytes
			sta	(VDU_TOP_SCAN),Y		; 
			tya					; A=Y
			bne	_BCE52				; if not 0 CE52
_BCE5A:			rts					; and exit


_LCE5B:			jsr	_LCDDA				; exchange text column/line with workspace
			sec					; set carry
			lda	VDU_T_WIN_B			; bottom margin
			sbc	VDU_T_WIN_T			; top of text window
			sta	VDU_TMP5			; store it
			bne	_LCE6E				; set text column to left hand column
			pla					; get back return address
			pla					; 
			jmp	_LCDDA				; exchange text column/line with workspace

_LCE6E:			lda	VDU_T_WIN_L			; text window left
			bpl	_BCEE3				; Jump CEE3 always!

_LCE73:			lda	VDU_TMP1			; get back A
			pha					; push A
			sec					; set carry
			lda	VDU_T_WIN_R			; text window right
			sbc	VDU_T_WIN_L			; text window left
			sta	VDU_TMP6			; 
_BCE7F:			ldy	VDU_BPC				; bytes per character to set loop counter

			dey					; copy loop
_BCE83:			lda	(VDU_TMP1),Y			; 
			sta	(VDU_TOP_SCAN),Y		; 
			dey					; 
			bpl	_BCE83				; 

			ldx	#$02				; X=2
_BCE8C:			clc					; clear carry
			lda	VDU_TOP_SCAN,X			; 
			adc	VDU_BPC				; bytes per character
			sta	VDU_TOP_SCAN,X			; 
			lda	VDU_TOP_SCAN_HI,X		; 
			adc	#$00				; 
			bpl	_BCE9E				; if this remains in screen RAM OK

			sec					; else wrap around screen
			sbc	VDU_MEM_PAGES			; screen RAM size hi byte
_BCE9E:			sta	VDU_TOP_SCAN_HI,X		; 
			dex					; X=X-2
			dex					; 
			beq	_BCE8C				; if X=0 adjust second set of pointers
			dec	VDU_TMP6			; decrement window width
			bpl	_BCE7F				; and if still +ve do it all again
			pla					; get back A
			sta	VDU_TMP1			; and store it
			rts					; then exit

;*********** clear a line ************************************************

_LCEAC:			lda	VDU_T_CURS_X			; text column
			pha					; save it
			jsr	_LCE6E				; set text column to left hand column
			jsr	_LCF06				; set up display address
			sec					; set carry
			lda	VDU_T_WIN_R			; text window right
			sbc	VDU_T_WIN_L			; text window left
			sta	VDU_TMP3			; as window width
_BCEBF:			lda	VDU_T_BG			; background text colour
			ldy	VDU_BPC				; bytes per character

_BCEC5:			dey					; Y=Y-1 decrementing loop counter
			sta	(VDU_TOP_SCAN),Y		; store background colour at this point on screen
			bne	_BCEC5				; if Y<>0 do it again
			txa					; else A=X
			clc					; clear carry to add
			adc	VDU_BPC				; bytes per character
			tax					; X=A restoring it
			lda	VDU_TOP_SCAN_HI			; get hi byte
			adc	#$00				; Add carry if any
			bpl	_BCEDA				; if +ve CeDA
			sec					; else wrap around
			sbc	VDU_MEM_PAGES			; screen RAM size hi byte






_BCEDA:			stx	VDU_TOP_SCAN			; restore D8/9
			sta	VDU_TOP_SCAN_HI			; 
			dec	VDU_TMP3			; decrement window width
			bpl	_BCEBF				; ind if not 0 do it all again
			pla					; get back A
_BCEE3:			sta	VDU_T_CURS_X			; restore text column
_BCEE6:			sec					; set carry
			rts					; and exit


_LCEE8:			ldx	VDU_T_CURS_X			; text column
			cpx	VDU_T_WIN_L			; text window left
			bmi	_BCEE6				; if less than left margin return with carry set
			cpx	VDU_T_WIN_R			; text window right
			beq	_BCEF7				; if equal to right margin thats OK
			bpl	_BCEE6				; if greater than right margin return with carry set

_BCEF7:			ldx	VDU_T_CURS_Y			; current text line
			cpx	VDU_T_WIN_T			; top of text window
			bmi	_BCEE6				; if less than top margin
			cpx	VDU_T_WIN_B			; bottom margin
			beq	_LCF06				; set up display address
			bpl	_BCEE6				; or greater than bottom margin return with carry set



;************:set up display address *************************************

;Mode 0: (0319)*640+(0318)* 8
;Mode 1: (0319)*640+(0318)*16
;Mode 2: (0319)*640+(0318)*32
;Mode 3: (0319)*640+(0318)* 8
;Mode 4: (0319)*320+(0318)* 8
;Mode 5: (0319)*320+(0318)*16
;Mode 6: (0319)*320+(0318)* 8
;Mode 7: (0319)* 40+(0318)
;this gives a displacement relative to the screen RAM start address
;which is added to the calculated number and stored in in 34A/B
;if the result is less than &8000, the top of screen RAM it is copied into X/A
;and D8/9.
;if the result is greater than &7FFF the hi byte of screen RAM size is
;subtracted to wraparound the screen. X/A, D8/9 are then set from this

_LCF06:			lda	VDU_T_CURS_Y			; current text line
			asl					; A=A*2
			tay					; Y=A
			lda	(VDU_ROW_MULT),Y		; get CRTC multiplication table pointer
			sta	VDU_TOP_SCAN_HI			; &D9=A
			iny					; Y=Y+1
			lda	#$02				; A=2
			and	VDU_MAP_TYPE			; memory map type
			php					; save flags
			lda	(VDU_ROW_MULT),Y		; get CRTC multiplication table pointer
			plp					; pull flags
			beq	_BCF1E				; 
			lsr	VDU_TOP_SCAN_HI			; &D9=&D9/2
			ror					; A=A/2 +(128*carry)
_BCF1E:			adc	VDU_MEM				; window area start address lo
			sta	VDU_TOP_SCAN			; store it
			lda	VDU_TOP_SCAN_HI			; 
			adc	VDU_MEM_HI			; window area start address hi
			tay					; 
			lda	VDU_T_CURS_X			; text column
			ldx	VDU_BPC				; bytes per character
			dex					; X=X-1
			beq	_BCF44				; if X=0 mode 7 CF44
			cpx	#$0f				; is it mode 1 or mode 5?
			beq	_BCF39				; yes CF39 with carry set
			bcc	_BCF3A				; if its less (mode 0,3,4,6) CF3A
			asl					; A=A*16 if entered here (mode 2)

_BCF39:			asl					; A=A*8 if entered here

_BCF3A:			asl					; A=A*4 if entered here
			asl					; 
			bcc	_BCF40				; if carry clear
			iny					; Y=Y+2
			iny					; 
_BCF40:			asl					; A=A*2
			bcc	_BCF45				; if carry clear add to &D8
			iny					; if not Y=Y+1

_BCF44:			clc					; clear carry
_BCF45:			adc	VDU_TOP_SCAN			; add to &D8
			sta	VDU_TOP_SCAN			; and store it
			sta	VDU_CRTC_CUR			; text cursor 6845 address
			tax					; X=A
			tya					; A=Y
			adc	#$00				; Add carry if set
			sta	VDU_CRTC_CUR_HI			; text cursor 6845 address
			bpl	_BCF59				; if less than &800 goto &CF59
			sec					; else wrap around
			sbc	VDU_MEM_PAGES			; screen RAM size hi byte

_BCF59:			sta	VDU_TOP_SCAN_HI			; store in high byte
			clc					; clear carry
			rts					; and exit


;******** Graphics cursor display routine ********************************

_BCF5D:			ldx	VDU_G_FG			; foreground graphics colour
			ldy	VDU_P_FG			; foreground graphics plot mode (GCOL n)
_LCF63:			jsr	_LD0B3				; set graphics byte mask in &D4/5
			jsr	_LD486				; copy (324/7) graphics cursor to workspace (328/B)
			ldy	#$00				; Y=0
_BCF6B:			sty	VDU_TMP3			; &DC=Y
			ldy	VDU_TMP3			; Y=&DC
			lda	(VDU_TMP5),Y			; get pattern byte
			beq	_BCF86				; if A=0 CF86
			sta	VDU_TMP4			; else &DD=A
_BCF75:			bpl	_BCF7A				; and if >0 CF7A
			jsr	_LD0E3				; else display a pixel
_BCF7A:			inc	VDU_G_CURS_H			; current horizontal graphics cursor
			bne	_BCF82				; 
			inc	VDU_G_CURS_H_HI			; current horizontal graphics cursor

_BCF82:			asl	VDU_TMP4			; &DD=&DD*2
			bne	_BCF75				; and if<>0 CF75
_BCF86:			ldx	#$28				; point to workspace
			ldy	#$24				; point to horizontal graphics cursor
			jsr	_LD482				; 0300/1+Y=0300/1+X
			ldy	VDU_G_CURS_V			; current vertical graphics cursor
			bne	_BCF95				; 
			dec	VDU_G_CURS_V_HI			; current vertical graphics cursor
_BCF95:			dec	VDU_G_CURS_V			; current vertical graphics cursor
			ldy	VDU_TMP3			; 
			iny					; 
			cpy	#$08				; if Y<8 then do loop again
			bne	_BCF6B				; else
			ldx	#$28				; point to workspace
			ldy	#$24				; point to graphics cursor
			jmp	_LD48A				; (&300/3+Y)=(&300/3+X)


;*********** home graphics cursor ***************************************

_LCFA6:			ldx	#$06				; point to graphics window TOP
			ldy	#$26				; point to workspace
			jsr	_LD482				; 0300/1+Y=0300/1+X


;************* set graphics cursor to left hand column *******************

_LCFAD:			ldx	#$00				; X=0 point to graphics window left
			ldy	#$24				; Y=&24
			jsr	_LD482				; 0300/1+Y=0300/1+X
			jmp	_LD1B8				; set up external coordinates for graphics
_VDU_OUT_CHAR:		ldx	VDU_COL_MASK			; number of logical colours less 1
			beq	_VDU_OUT_MODE7			; if MODE 7 CFDC

			jsr	_LD03E				; set up character definition pointers
_LCFBF:			ldx	VDU_COL_MASK			; number of logical colours less 1
			lda	VDU_STATUS			; VDU status byte
			and	#$20				; and out bit 5 printing at graphics cursor
			bne	_BCF5D				; if set CF5D
			ldy	#$07				; else Y=7
			cpx	#$03				; if X=3
			beq	_VDU_OUT_COL4			; goto CFEE to handle 4 colour modes
			bcs	_VDU_OUT_COL16			; else if X>3 D01E to deal with 16 colours

_BCFD0:			lda	(VDU_TMP5),Y			; get pattern byte
			ora	VDU_T_OR_MASK			; text colour byte to be orred or EORed into memory
			eor	VDU_T_EOR_MASK			; text colour byte to be orred or EORed into memory
			sta	(VDU_TOP_SCAN),Y		; write to screen
			dey					; Y=Y-1
			bpl	_BCFD0				; if still +ve do loop again
			rts					; and exit

;******* convert teletext characters *************************************
;mode 7
_VDU_OUT_MODE7:		ldy	#$02				; Y=2
__mode7_xlate_loop:	cmp	_TELETEXT_CHAR_TAB,Y		; compare with teletext conversion table
			beq	__mode7_xlate_char		; if equal then CFE9
			dey					; else Y=Y-1
			bpl	__mode7_xlate_loop		; and if +ve CFDE

__mode7_out_char:	sta	(VDU_TOP_SCAN,X)		; if not write byte to screen
			rts					; and exit



__mode7_xlate_char:	lda	_TELETEXT_CHAR_TAB+1,Y		; convert with teletext conversion table
			bne	__mode7_out_char		; and write it


;***********four colour modes ********************************************

_VDU_OUT_COL4:		lda	(VDU_TMP5),Y			; get pattern byte
			pha					; save it
			lsr					; move hi nybble to lo
			lsr					; 
			lsr					; 
			lsr					; 
			tax					; X=A
			lda	_COL16_MASK_TAB,X		; 4 colour mode byte mask look up table
			ora	VDU_T_OR_MASK			; text colour byte to be orred or EORed into memory
			eor	VDU_T_EOR_MASK			; text colour byte to be orred or EORed into memory
			sta	(VDU_TOP_SCAN),Y		; write to screen
			tya					; A=Y

			clc					; clear carry
			adc	#$08				; add 8 to move screen RAM pointer 8 bytes
			tay					; Y=A
			pla					; get back A
			and	#$0f				; clear high nybble
			tax					; X=A
			lda	_COL16_MASK_TAB,X		; 4 colour mode byte mask look up table
			ora	VDU_T_OR_MASK			; text colour byte to be orred or EORed into memory
			eor	VDU_T_EOR_MASK			; text colour byte to be orred or EORed into memory
			sta	(VDU_TOP_SCAN),Y		; write to screen
			tya					; A=Y
			sbc	#$08				; A=A-9
			tay					; Y=A
			bpl	_VDU_OUT_COL4			; if +ve do loop again
_BD017:			rts					; exit



_BD018:			tya					; Y=Y-&21
			sbc	#$21				; 
			bmi	_BD017				; IF Y IS negative then RETURN
			tay					; else A=Y

;******* 16 COLOUR MODES *************************************************

_VDU_OUT_COL16:		lda	(VDU_TMP5),Y			; get pattern byte
			sta	VDU_TMP3			; store it
			sec					; set carry
_BD023:			lda	#$00				; A=0
			rol	VDU_TMP3			; carry now occupies bit 0 of DC
			beq	_BD018				; when DC=0 again D018 to deal with next pattern byte
			rol					; get bit 7 from &DC into A bit 0
			asl	VDU_TMP3			; rotate again to get second
			rol					; bit into A
			tax					; and store result in X
			lda	_COL4_MASK_TAB,X		; multiply by &55 using look up table
			ora	VDU_T_OR_MASK			; and set colour factors
			eor	VDU_T_EOR_MASK			; 
			sta	(VDU_TOP_SCAN),Y		; and store result
			clc					; clear carry
			tya					; Y=Y+8 moving screen RAM pointer on 8 bytes
			adc	#$08				; 
			tay					; 
			bcc	_BD023				; iloop to D023 to deal with next bit pair


;************* calculate pattern address for given code ******************
;A contains code on entry = 12345678

_LD03E:			asl					; 23456780  C holds 1
			rol					; 34567801  C holds 2
			rol					; 45678012  C holds 3
			sta	VDU_TMP5			; save this pattern
			and	#$03				; 00000012
			rol					; 00000123 C=0
			tax					; X=A=0 - 7
			and	#$03				; A=00000023
			adc	#$bf				; A=&BF,C0 or C1
			tay					; this is used as a pointer
			lda	_LC40D,X			; A=&80/2^X i.e.1,2,4,8,&10,&20,&40, or &80
			bit	VDU_FONT_FLAGS			; with font flag
			beq	_BD057				; if 0 D057
			ldy	VDU_FONT_FLAGS,X		; else get hi byte from table
_BD057:			sty	VDU_TMP6			; store Y
			lda	VDU_TMP5			; get back pattern
			and	#$f8				; convert to 45678000
			sta	VDU_TMP5			; and re store it
			rts					; exit
								;
;*************************************************************************
;*************************************************************************
;**									 **
;**									 **
;**	 PLOT ROUTINES ENTER HERE					 **
;**									 **
;**									 **
;*************************************************************************
;*************************************************************************
;on entry    ADDRESS	PARAMETER	 DESCRIPTION
;	    031F    1		    plot type
;	    0320/1  2,3		    X coordinate
;	    0322/3  4,5		    Y coordinate

_LD060:			ldx	#$20				; X=&20
			jsr	_LD14D				; translate coordinates

			lda	VDU_QUEUE_4			; get plot type
			cmp	#$04				; if its 4
			beq	_LD0D9				; D0D9 move absolute
			ldy	#$05				; Y=5
			and	#$03				; mask only bits 0 and 1
			beq	_BD080				; if result is 0 then its a move (multiple of 8)
			lsr					; else move bit 0 int C
			bcs	_BD078				; if set then D078 graphics colour required
			dey					; Y=4
			bne	_BD080				; logic inverse colour must be wanted

;******** graphics colour wanted *****************************************

_BD078:			tax					; X=A if A=0 its a foreground colour 1 its background
			ldy	VDU_P_FG,X			; get fore or background graphics PLOT mode
			lda	VDU_G_FG,X			; get fore or background graphics colour
			tax					; X=A

_BD080:			jsr	_LD0B3				; set up colour masks in D4/5

			lda	VDU_QUEUE_4			; get plot type
			bmi	_BD0AB				; if &80-&FF then D0AB type not implemented
			asl					; bit 7=bit 6
			bpl	_BD0C6				; if bit 6 is 0 then plot type is 0-63 so D0C6
			and	#$f0				; else mask out lower nybble
			asl					; shift old bit 6 into C bit old 5 into bit 7
			beq	_BD0D6				; if 0 then type 64-71 was called single point plot
								; goto D0D6
			eor	#$40				; if bit 6 NOT set type &80-&87 fill triangle
			beq	_BD0A8				; so D0A8
			pha					; else push A
			jsr	_LD0DC				; copy 0320/3 to 0324/7 setting XY in current graphics
								; coordinates
			pla					; get back A
			eor	#$60				; if BITS 6 and 5 NOT SET type 72-79 lateral fill
			beq	_BD0AE				; so D0AE
			cmp	#$40				; if type 88-95 horizontal line blanking
			bne	_BD0AB				; so D0AB

			lda	#$02				; else A=2
			sta	VDU_TMP3			; store it
			jmp	_LD506				; and jump to D506 type not implemented

_BD0A8:			jmp	_LD5EA				; to fill triangle routine

_BD0AB:			jmp	_LC938				; VDU extension access entry

_BD0AE:			sta	VDU_TMP3			; store A
			jmp	_LD4BF				; 

;*********:set colour masks **********************************************
;graphics mode in Y
;colour in X

_LD0B3:			txa					; A=X
			ora	_LC41C,Y			; or with GCOL plot options table byte
			eor	_LC41D,Y			; EOR with following byte
			sta	VDU_G_OR_MASK			; and store it
			txa					; A=X
			ora	_LC41B,Y			; 
			eor	_LC420,Y			; 
			sta	VDU_G_EOR_MASK			; 
			rts					; exit with masks in &D4/5


;************** analyse first parameter in 0-63 range ********************
				;
_BD0C6:			asl					; shift left again
			bmi	_BD0AB				; if -ve options are in range 32-63 not implemented
			asl					; shift left twice more
			asl					; 
			bpl	_BD0D0				; if still +ve type is 0-7 or 16-23 so D0D0
			jsr	_LD0EB				; else display a point

_BD0D0:			jsr	_LD1ED				; perform calculations
			jmp	_LD0D9				; 


;*************************************************************************
;*									 *
;*	 PLOT A SINGLE POINT						 *
;*									 *
;*************************************************************************

_BD0D6:			jsr	_LD0EB				; display a point
_LD0D9:			jsr	_LCDE2				; swap current and last graphics position
_LD0DC:			ldy	#$24				; Y=&24
_LD0DE:			ldx	#$20				; X=&20
			jmp	_LD48A				; copy parameters to 324/7 (300/3 +Y)


_LD0E3:			ldx	#$24				; 
			jsr	_LD85F				; calculate position
			beq	_LD0F0				; if result =0 then D0F0
			rts					; else exit
								;
_LD0EB:			jsr	_LD85D				; calculate position
			bne	_BD103				; if A<>0 D103 and return
_LD0F0:			ldy	VDU_G_CURS_SCAN			; else get current graphics scan line
_LD0F3:			lda	VDU_G_PIX_MASK			; pick up and modify screen byte
			and	VDU_G_OR_MASK			; 
			ora	(VDU_G_MEM),Y			; 
			sta	VDU_TMP1			; 
			lda	VDU_G_EOR_MASK			; 
			and	VDU_G_PIX_MASK			; 
			eor	VDU_TMP1			; 
			sta	(VDU_G_MEM),Y			; put it back again
_BD103:			rts					; and exit
								;

_LD104:			lda	(VDU_G_MEM),Y			; this is a more simplistic version of the above
			ora	VDU_G_OR_MASK			; 
			eor	VDU_G_EOR_MASK			; 
			sta	(VDU_G_MEM),Y			; 
			rts					; and exit



;************************** Check window limits *************************
				;
			.org	$d10d

_LD10D:			ldx	#$24				; X=&24
_LD10F:			ldy	#$00				; Y=0
			sty	VDU_TMP1			; &DA=0
			ldy	#$02				; Y=2
			jsr	_LD128				; check vertical graphics position 326/7
								; bottom and top margins 302/3, 306/7
			asl	VDU_TMP1			; DATA is set in &DA bits 0 and 1 then shift left
			asl	VDU_TMP1			; twice to make room for next pass
			dex					; X=&22
			dex					; 
			ldy	#$00				; Y=0
			jsr	_LD128				; left and right margins 300/1, 304/5
								; cursor horizontal position 324/5
			inx					; X=X+2
			inx					; 
			lda	VDU_TMP1			; A=&DA
			rts					; exit

;*** cursor and margins check ******************************************
				;
_LD128:			lda	VDU_G_WIN_B,X			; check for window violation
			cmp	VDU_G_WIN_L,Y			; 300/1 +Y > 302/3+X
			lda	VDU_G_WIN_B_HI,X		; then window fault
			sbc	VDU_G_WIN_L_HI,Y		; 
			bmi	_BD146				; so D146

			lda	VDU_G_WIN_R,Y			; check other windows
			cmp	VDU_G_WIN_B,X			; 
			lda	VDU_G_WIN_R_HI,Y		; 
			sbc	VDU_G_WIN_B_HI,X		; 
			bpl	_BD148				; if no violation exit
			inc	VDU_TMP1			; else DA=DA+1

_BD146:			inc	VDU_TMP1			; DA=DA+1
_BD148:			rts					; and exit  DA=0 no problems DA=1 first check 2, 2nd

;***********set up and adjust positional data ****************************

_LD149:			lda	#$ff				; A=&FF
			bne	_BD150				; then &D150

_LD14D:			lda	VDU_QUEUE_4			; get first parameter in plot

_BD150:			sta	VDU_TMP1			; store in &DA
			ldy	#$02				; Y=2
			jsr	_LD176				; set up vertical coordinates/2
			jsr	_LD1AD				; /2 again to convert 1023 to 0-255 for internal use
								; this is why minimum vertical plot separation is 4
			ldy	#$00				; Y=0
			dex					; X=x-2
			dex					; 
			jsr	_LD176				; set up horiz. coordinates/2 this is OK for mode0,4
			ldy	VDU_PIX_BYTE			; get number of pixels/byte (-1)
			cpy	#$03				; if Y=3 (modes 1 and 5)
			beq	_BD16D				; D16D
			bcs	_BD170				; for modes 0 & 4 this is 7 so D170
			jsr	_LD1AD				; for other modes divide by 2 twice

_BD16D:			jsr	_LD1AD				; divide by 2
_BD170:			lda	VDU_MAP_TYPE			; get screen display type
			bne	_LD1AD				; if not 0 (modes 3-7) divide by 2 again
			rts					; and exit

;for mode 0 1 division	1280 becomes 640 = horizontal resolution
;for mode 1 2 divisions 1280 becomes 320 = horizontal resolution
;for mode 2 3 divisions 1280 becomes 160 = horizontal resolution
;for mode 4 2 divisions 1280 becomes 320 = horizontal resolution
;for mode 5 3 divisions 1280 becomes 160 = horizontal resolution

;********** calculate external coordinates in internal format ***********
;on entry X is usually &1E or &20

_LD176:			clc					; clear carry
			lda	VDU_TMP1			; get &DA
			and	#$04				; if bit 2=0
			beq	_BD186				; then D186 to calculate relative coordinates
			lda	VDU_G_WIN_B,X			; else get coordinate
			pha					; 
			lda	VDU_G_WIN_B_HI,X		; 
			bcc	_BD194				; and goto D194

_BD186:			lda	VDU_G_WIN_B,X			; get coordinate
			adc	VDU_G_CUR_XX,Y			; add cursor position
			pha					; save it
			lda	VDU_G_WIN_B_HI,X		; 
			adc	VDU_G_CUR_XX_HI,Y		; add cursor
			clc					; clear carry

_BD194:			sta	VDU_G_CUR_XX_HI,Y		; save new cursor
			adc	VDU_G_ORG_XX_HI,Y		; add graphics origin
			sta	VDU_G_WIN_B_HI,X		; store it
			pla					; get back lo byte
			sta	VDU_G_CUR_XX,Y			; save it in new cursor lo
			clc					; clear carry
			adc	VDU_G_ORG_XX,Y			; add to graphics orgin
			sta	VDU_G_WIN_B,X			; store it
			bcc	_LD1AD				; if carry set
			inc	VDU_G_WIN_B_HI,X		; increment hi byte as you would expect!

_LD1AD:			lda	VDU_G_WIN_B_HI,X		; get hi byte
			asl					; 
			ror	VDU_G_WIN_B_HI,X		; divide by 2
			ror	VDU_G_WIN_B,X			; 
			rts					; and exit

;***** calculate external coordinates from internal coordinates************

_LD1B8:			ldy	#$10				; Y=10
			jsr	_LD488				; copy 324/7 to 310/3 i.e.current graphics cursor
								; position to position in external values
			ldx	#$02				; X=2
			ldy	#$02				; Y=2
			jsr	_LD1D5				; multiply 312/3 by 4 and subtract graphics origin
			ldx	#$00				; X=0
			ldy	#$04				; Y=4
			lda	VDU_PIX_BYTE			; get  number of pixels/byte
_BD1CB:			dey					; Y=Y-1
			lsr					; divide by 2
			bne	_BD1CB				; if result not 0 D1CB
			lda	VDU_MAP_TYPE			; else get screen display type
			beq	_LD1D5				; and if 0 D1D5
			iny					; 

_LD1D5:			asl	VDU_G_CUR_XX,X			; multiply coordinate by 2
			rol	VDU_G_CUR_XX_HI,X		; 
			dey					; Y-Y-1
			bne	_LD1D5				; and if Y<>0 do it again
			sec					; set carry
			jsr	_LD1E3				; 
			inx					; increment X

_LD1E3:			lda	VDU_G_CUR_XX,X			; get current graphics position in external coordinates
			sbc	VDU_G_ORG_XX,X			; subtract origin
			sta	VDU_G_CUR_XX,X			; store in graphics position
			rts					; and exit

;************* compare X and Y PLOT spans ********************************

_LD1ED:			jsr	_LD40D				; Set X and Y spans in workspace 328/9 32A/B
			lda	VDU_BITMAP_RD_3			; compare spans
			eor	VDU_BITMAP_RD_1			; if result -ve spans are different in sign so
			bmi	_BD207				; goto D207
			lda	VDU_BITMAP_RD_2			; else A=hi byte of difference in spans
			cmp	VDU_BITMAP_READ			; 
			lda	VDU_BITMAP_RD_3			; 
			sbc	VDU_BITMAP_RD_1			; 
			jmp	_LD214				; and goto D214

_BD207:			lda	VDU_BITMAP_READ			; A = hi byte of SUM of spans
			clc					; 
			adc	VDU_BITMAP_RD_2			; 
			lda	VDU_BITMAP_RD_1			; 
			adc	VDU_BITMAP_RD_3			; 

_LD214:			ror					; A=A/2
			ldx	#$00				; X=0
			eor	VDU_BITMAP_RD_3			; 
			bpl	_BD21E				; if positive result D21E

			ldx	#$02				; else X=2

_BD21E:			stx	VDU_TMP5			; store it
			lda	_LC4AA,X			; set up vector address
			sta	VDU_JUMPVEC			; in 35D
			lda	_LC4AA + 1,X			; 
			sta	VDU_JUMPVEC_HI			; and 35E
			lda	VDU_BITMAP_RD_1,X		; get hi byte of span
			bpl	_BD235				; if +ve D235
			ldx	#$24				; X=&24
			bne	_BD237				; jump to D237

_BD235:			ldx	#$20				; X=&20
_BD237:			stx	VDU_TMP6			; store it
			ldy	#$2c				; Y=&2C
			jsr	_LD48A				; get X coordinate data or horizontal coord of
								; curent graphics cursor
			lda	VDU_TMP6			; get back original X
			eor	#$04				; covert &20 to &24 and vice versa
			sta	VDU_TMP4			; 
			ora	VDU_TMP5			; 
			tax					; 
			jsr	_LD480				; copy 330/1 to 300/1+X
			lda	VDU_QUEUE_4			; get plot type
			and	#$10				; check bit 4
			asl					; 
			asl					; 
			asl					; move to bit 7
			sta	VDU_TMP2			; store it
			ldx	#$2c				; X=&2C
			jsr	_LD10F				; check for window violations
			sta	VDU_TMP3			; 
			beq	_BD263				; if none then D263
			lda	#$40				; else set bit 6 of &DB
			ora	VDU_TMP2			; 
			sta	VDU_TMP2			; 

_BD263:			ldx	VDU_TMP4			; 
			jsr	_LD10F				; check window violations again
			bit	VDU_TMP3			; if bit 7 of &DC NOT set
			beq	_BD26D				; D26D
			rts					; else exit
								;
_BD26D:			ldx	VDU_TMP5			; X=&DE
			beq	_BD273				; if X=0 D273
			lsr					; A=A/2
			lsr					; A=A/2

_BD273:			and	#$02				; clear all but bit 2
			beq	_BD27E				; if bit 2 set D27E
			txa					; else A=X
			ora	#$04				; A=A or 4 setting bit 3
			tax					; X=A
			jsr	_LD480				; set 300/1+x to 330/1
_BD27E:			jsr	_LD42C				; more calcualtions
			lda	VDU_TMP5			; A=&DE EOR 2
			eor	#$02				; 
			tax					; X=A
			tay					; Y=A
			lda	VDU_BITMAP_RD_1			; compare upper byte of spans
			eor	VDU_BITMAP_RD_3			; 
			bpl	_BD290				; if signs are the same D290
			inx					; else X=X+1
_BD290:			lda	_LC4AE,X			; get vector addresses and store 332/3
			sta	VDU_WORKSPACE+2			; 
			lda	_LC4B2,X			; 
			sta	VDU_WORKSPACE+3			; 

			lda	#$7f				; A=&7F
			sta	VDU_WORKSPACE+4			; store it
			bit	VDU_TMP2			; if bit 6 set
			bvs	_BD2CE				; the D2CE
			lda	_LC447,X			; get VDU section number
			tax					; X=A
			sec					; set carry
			lda	VDU_G_WIN_L,X			; subtract coordinates
			sbc	VDU_BITMAP_RD_4,Y		; 
			sta	VDU_TMP1			; 
			lda	VDU_G_WIN_L_HI,X		; 
			sbc	VDU_BITMAP_RD_5,Y		; 
			ldy	VDU_TMP1			; Y=hi
			tax					; X=lo=A
			bpl	_BD2C0				; and if A+Ve D2C0
			jsr	_LD49B				; negate Y/A

_BD2C0:			tax					; X=A increment Y/A
			iny					; Y=Y+1
			bne	_BD2C5				; 
			inx					; X=X+1
_BD2C5:			txa					; A=X
			beq	_BD2CA				; if A=0 D2CA
			ldy	#$00				; else Y=0

_BD2CA:			sty	VDU_TMP6			; &DF=Y
			beq	_BD2D7				; if 0 then D2D7
_BD2CE:			txa					; A=X
			lsr					; A=A/4
			ror					; 
			ora	#$02				; bit 1 set
			eor	VDU_TMP5			; 
			sta	VDU_TMP5			; and store
_BD2D7:			ldx	#$2c				; X=&2C
			jsr	_LD864				; 
			ldx	VDU_TMP3			; 
			bne	_BD2E2				; 
			dec	VDU_TMP4			; 
_BD2E2:			dex					; X=X-1
_LD2E3:			lda	VDU_TMP2			; A=&3B
			beq	_BD306				; if 0 D306
			bpl	_BD2F9				; else if +ve D2F9
			bit	VDU_WORKSPACE+4			; 
			bpl	_BD2F3				; if bit 7=0 D2F3
			dec	VDU_WORKSPACE+4			; else decrement
			bne	_BD316				; and if not 0 D316

_BD2F3:			inc	VDU_WORKSPACE+4			; 
			asl					; A=A*2
			bpl	_BD306				; if +ve D306
_BD2F9:			stx	VDU_TMP3			; 
			ldx	#$2c				; 
			jsr	_LD85F				; calcualte screen position
			ldx	VDU_TMP3			; get back original X
			ora	#$00				; 
			bne	_BD316				; 
_BD306:			lda	VDU_G_PIX_MASK			; byte mask for current graphics point
			and	VDU_G_OR_MASK			; and with graphics colour byte
			ora	(VDU_G_MEM),Y			; or  with curent graphics cell line
			sta	VDU_TMP1			; store result
			lda	VDU_G_EOR_MASK			; same again with next byte (hi??)
			and	VDU_G_PIX_MASK			; 
			eor	VDU_TMP1			; 
			sta	(VDU_G_MEM),Y			; then store it inm current graphics line
_BD316:			sec					; set carry
			lda	VDU_WORKSPACE+5			; A=&335/6-&337/8
			sbc	VDU_WORKSPACE+7			; 
			sta	VDU_WORKSPACE+5			; 
			lda	VDU_WORKSPACE+6			; 
			sbc	VDU_WORKSPACE+8			; 
			bcs	_BD339				; if carry set D339
			sta	VDU_TMP1			; 
			lda	VDU_WORKSPACE+5			; 
			adc	VDU_WORKSPACE+9			; 
			sta	VDU_WORKSPACE+5			; 
			lda	VDU_TMP1			; 
			adc	VDU_WORKSPACE+$A		; 
			clc					; 
_BD339:			sta	VDU_WORKSPACE+6			; 
			php					; 
			bcs	_BD348				; if carry clear jump to VDU routine else D348
			jmp	(VDU_WORKSPACE+2)		; 

;****** vertical scan module 1******************************************

			dey					; Y=Y-1
			bpl	_BD348				; if + D348
			jsr	_LD3D3				; else d3d3 to advance pointers
_BD348:			jmp	(VDU_JUMPVEC)			; and JUMP (&35D)

;****** vertical scan module 2******************************************

			iny					; Y=Y+1
			cpy	#$08				; if Y<>8
			bne	_BD348				; then D348
			clc					; else clear carry
			lda	VDU_G_MEM			; get address of top line of cuirrent graphics cell
			adc	VDU_BPR				; add number of bytes/character row
			sta	VDU_G_MEM			; store it
			lda	VDU_G_MEM_HI			; do same for hibyte
			adc	VDU_BPR_HI			; 
			bpl	_BD363				; if result -ve then we are above screen RAM
			sec					; so
			sbc	VDU_MEM_PAGES			; subtract screen memory size hi
_BD363:			sta	VDU_G_MEM_HI			; store it this wraps around point to screen RAM
			ldy	#$00				; Y=0
			jmp	(VDU_JUMPVEC)			; 

;****** horizontal scan module 1******************************************

			lsr	VDU_G_PIX_MASK			; shift byte mask
			bcc	_BD348				; if carry clear (&D1 was +ve) goto D348
			jsr	_LD3ED				; else reset pointers
			jmp	(VDU_JUMPVEC)			; and off to do more

;****** horizontal scan module 2******************************************

			asl	VDU_G_PIX_MASK			; shift byte mask
			bcc	_BD348				; if carry clear (&D1 was +ve) goto D348
			jsr	_LD3FD				; else reset pointers
			jmp	(VDU_JUMPVEC)			; and off to do more

_LD37E:			dey					; Y=Y-1
			bpl	_BD38D				; if +ve D38D
			jsr	_LD3D3				; advance pointers
			bne	_BD38D				; goto D38D normally
_LD386:			lsr	VDU_G_PIX_MASK			; shift byte mask
			bcc	_BD38D				; if carry clear (&D1 was +ve) goto D348
			jsr	_LD3ED				; else reset pointers
_BD38D:			plp					; pull flags
			inx					; X=X+1
			bne	_BD395				; if X>0 D395
			inc	VDU_TMP4			; else increment &DD
			beq	_BD39F				; and if not 0 D39F
_BD395:			bit	VDU_TMP2			; else if BIT 6 = 1
			bvs	_BD3A0				; goto D3A0
			bcs	_BD3D0				; if BIT 7=1 D3D0
			dec	VDU_TMP6			; else Decrement &DF
			bne	_BD3D0				; and if not Zero D3D0
_BD39F:			rts					; else return
								;
_BD3A0:			lda	VDU_TMP5			; A=&DE
			stx	VDU_TMP3			; &DC=X
			and	#$02				; clear all but bit 1
			tax					; X=A
			bcs	_BD3C2				; and if carry set goto D3C2
			bit	VDU_TMP5			; if Bit 7 of &DE =1
			bmi	_BD3B7				; then D3B7
			inc	VDU_BITMAP_RD_4,X		; else increment
			bne	_BD3C2				; and if not 0 D3C2
			inc	VDU_BITMAP_RD_5,X		; else increment hi byte
			bcc	_BD3C2				; and if carry clear D3C2
_BD3B7:			lda	VDU_BITMAP_RD_4,X		; esle A=32C,X
			bne	_BD3BF				; and if not 0 D3BF
			dec	VDU_BITMAP_RD_5,X		; decrement hi byte
_BD3BF:			dec	VDU_BITMAP_RD_4,X		; decrement lo byte

_BD3C2:			txa					; A=X
			eor	#$02				; invert bit 2
			tax					; X=A
			inc	VDU_BITMAP_RD_4,X		; Increment 32C/D
			bne	_BD3CE				; 
			inc	VDU_BITMAP_RD_5,X		; 
_BD3CE:			ldx	VDU_TMP3			; X=&DC
_BD3D0:			jmp	_LD2E3				; jump to D2E3

;**********move display point up a line **********************************
_LD3D3:			sec					; SET CARRY
			lda	VDU_G_MEM			; subtract number of bytes/line from address of
			sbc	VDU_BPR				; top line of current graphics cell
			sta	VDU_G_MEM			; 
			lda	VDU_G_MEM_HI			; 
			sbc	VDU_BPR_HI			; 
			cmp	VDU_PAGE			; compare with bottom of screen memory
			bcs	_BD3E8				; if outside screen RAM
			adc	VDU_MEM_PAGES			; add screen memory size to wrap it around
_BD3E8:			sta	VDU_G_MEM_HI			; store in current address of graphics cell top line
			ldy	#$07				; Y=7
			rts					; and RETURN

_LD3ED:			lda	VDU_MASK_RIGHT			; get current left colour mask
			sta	VDU_G_PIX_MASK			; store it
			lda	VDU_G_MEM			; get current top line of graphics cell
			adc	#$07				; ADD 7
			sta	VDU_G_MEM			; 
			bcc	_BD3FC				; 
			inc	VDU_G_MEM_HI			; 
_BD3FC:			rts					; and return

_LD3FD:			lda	VDU_MASK_LEFT			; get right colour mask
			sta	VDU_G_PIX_MASK			; store it
			lda	VDU_G_MEM			; A=top line graphics cell low
			bne	_BD408				; if not 0 D408
			dec	VDU_G_MEM_HI			; else decrement hi byte

_BD408:			sbc	#$08				; subtract 9 (8 + carry)
			sta	VDU_G_MEM			; and store in low byte
			rts					; return

;********:: coordinate subtraction ***************************************

_LD40D:			ldy	#$28				; X=&28
			ldx	#$20				; Y=&20
_LD411:			jsr	_LD418				; 
			inx					; X=X+2
			inx					; 
			iny					; Y=Y+2
			iny					; 

_LD418:			sec					; set carry
			lda	VDU_G_WIN_R,X			; subtract coordinates
			sbc	VDU_G_WIN_L,X			; 
			sta	VDU_G_WIN_L,Y			; 
			lda	VDU_G_WIN_R_HI,X		; 
			sbc	VDU_G_WIN_L_HI,X		; 
			sta	VDU_G_WIN_L_HI,Y		; 
			rts					; and return

_LD42C:			lda	VDU_TMP5			; A=&DE
			bne	_BD437				; if A=0 D437
			ldx	#$28				; X=&28
			ldy	#$2a				; Y=&2A
			jsr	_LCDDE				; exchange 300/1+Y with 300/1+X
								; IN THIS CASE THE X AND Y SPANS!

_BD437:			ldx	#$28				; X=&28
			ldy	#$37				; Y=&37
			jsr	_LD48A				; copy &300/4+Y to &300/4+X
								; transferring X and Y spans in this case
			sec					; set carry
			ldx	VDU_TMP5			; X=&DE
			lda	VDU_WORKSPACE			; subtract 32C/D,X from 330/1
			sbc	VDU_BITMAP_RD_4,X		; 
			tay					; partial answer in Y
			lda	VDU_WORKSPACE+1			; 
			sbc	VDU_BITMAP_RD_5,X		; 
			bmi	_BD453				; if -ve D453
			jsr	_LD49B				; else negate Y/A

_BD453:			sta	VDU_TMP4			; store A
			sty	VDU_TMP3			; and Y
			ldx	#$35				; X=&35
_LD459:			jsr	_LD467				; get coordinates
			lsr					; 
			sta	VDU_G_WIN_L_HI,X		; 
			tya					; 
			ror					; 
			sta	VDU_G_WIN_L,X			; 
			dex					; 
			dex					; 

_LD467:			ldy	VDU_G_WIN_R,X			; 
			lda	VDU_G_WIN_R_HI,X		; 
			bpl	_BD47B				; if A is +ve RETURN
			jsr	_LD49B				; else negate Y/A
			sta	VDU_G_WIN_R_HI,X		; store back again
			pha					; 
			tya					; 
			sta	VDU_G_WIN_R,X			; 
			pla					; get back A
_BD47B:			rts					; and exit
								;
_LD47C:			lda	#$08				; A=8
			bne	_VDU_VAR_COPY			; copy 8 bytes
_LD480:			ldy	#$30				; Y=&30
_LD482:			lda	#$02				; A=2
			bne	_VDU_VAR_COPY			; copy 2 bytes
_LD486:			ldy	#$28				; copy 4 bytes from 324/7 to 328/B
_LD488:			ldx	#$24				; 
_LD48A:			lda	#$04				; 

;***********copy A bytes from 300,X to 300,Y ***************************

_VDU_VAR_COPY:		sta	VDU_TMP1			; 
__vdu_var_copy_next:	lda	VDU_G_WIN_L,X			; 
			sta	VDU_G_WIN_L,Y			; 
			inx					; 
			iny					; 
			dec	VDU_TMP1			; 
			bne	__vdu_var_copy_next		; 
			rts					; and return

;************* negation routine ******************************************

_LD49B:			pha					; save A
			tya					; A=Y
			eor	#$ff				; invert
			tay					; Y=A
			pla					; get back A
			eor	#$ff				; invert
			iny					; Y=Y+1
			bne	_BD4A9				; if not 0 exit
			clc					; else
			adc	#$01				; add 1 to A
_BD4A9:			rts					; return
								;
_LD4AA:			jsr	_LD85D				; check window boundaries and set up screen pointer
			bne	_BD4B7				; if A<>0 D4B7
			lda	(VDU_G_MEM),Y			; else get byte from current graphics cell
			eor	VDU_G_BG			; compare with current background colour
			sta	VDU_TMP1			; store it
			rts					; and RETURN

_BD4B7:			pla					; get back return link
			pla					; 
_BD4B9:			inc	VDU_G_CURS_V			; increment current graphics cursor vertical lo
			jmp	_LD545				; 


; OS SERIES IV
; GEOFF COX

;*************************************************************************
;*									 *
;*  LATERAL FILL ROUTINE						 *
;*									 *
;*************************************************************************

			.org	$d4bf

_LD4BF:			jsr	_LD4AA				; check current screen state
			and	VDU_G_PIX_MASK			; if A and &D1 <> 0 a plotted point has been found
			bne	_BD4B9				; so D4B9
			ldx	#$00				; X=0
			jsr	_LD592				; update pointers
			beq	_BD4FA				; if 0 then D4FA
			ldy	VDU_G_CURS_SCAN			; else Y=graphics scan line
			asl	VDU_G_PIX_MASK			; 
			bcs	_BD4D9				; if carry set D4D9
			jsr	_LD574				; else D574
			bcc	_BD4FA				; if carry clear D4FA
_BD4D9:			jsr	_LD3FD				; else D3FD to pick up colour multiplier
			lda	(VDU_G_MEM),Y			; get graphics cell line
			eor	VDU_G_BG			; EOR with background colour
			sta	VDU_TMP1			; and store
			bne	_BD4F7				; if not 0 D4F7
			sec					; else set carry
			txa					; A=X
			adc	VDU_PIX_BYTE			; add pixels/byte
			bcc	_BD4F0				; and if carry clear D4F0
			inc	VDU_TMP2			; else increment &DB
			bpl	_BD4F7				; and if +ve D4F7

_BD4F0:			tax					; else X=A
			jsr	_LD104				; display a pixel
			sec					; set carry
			bcs	_BD4D9				; goto D4D9

_BD4F7:			jsr	_LD574				; 
_BD4FA:			ldy	#$00				; Y=0
			jsr	_LD5AC				; 
			ldy	#$20				; 
			ldx	#$24				; 
			jsr	_LCDE6				; exchange 300/3 +Y with 300/3+X
_LD506:			jsr	_LD4AA				; check screen pixel
			ldx	#$04				; Y=5
			jsr	_LD592				; 
			txa					; A=x
			bne	_BD513				; if A<>0 d513
			dec	VDU_TMP2			; else	&DB=&dB-1

_BD513:			dex					; X=X-1
_BD514:			jsr	_LD54B				; 
			bcc	_BD540				; 
_BD519:			jsr	_LD3ED				; update pointers
			lda	(VDU_G_MEM),Y			; get byte from graphics line
			eor	VDU_G_BG			; EOR with background colour
			sta	VDU_TMP1			; and store it
			lda	VDU_TMP3			; 
			bne	_BD514				; If A-0 back to D514
			lda	VDU_TMP1			; else A=&DA
			bne	_BD53D				; if A<>d53D
			sec					; else set carry
			txa					; A=x
			adc	VDU_PIX_BYTE			; Add number of pixels/byte
			bcc	_BD536				; and if carry clear D536
			inc	VDU_TMP2			; else inc DB
			bpl	_BD53D				; and if +ve D53D
_BD536:			tax					; get back X
			jsr	_LD104				; display a point
			sec					; set carry
			bcs	_BD519				; goto D519

_BD53D:			jsr	_LD54B				; 
_BD540:			ldy	#$04				; 
			jsr	_LD5AC				; 

_LD545:			jsr	_LD0D9				; 
			jmp	_LD1B8				; scale pointers

_LD54B:			lda	VDU_G_PIX_MASK			; get byte mask
			pha					; save it
			clc					; clear carry
			bcc	_BD560				; 

_BD551:			pla					; get back A
			inx					; X=X+1
			bne	_BD559				; if not 0 D559
			inc	VDU_TMP2			; else inc &DB
			bpl	_BD56F				; if +ve D56F
_BD559:			lsr	VDU_G_PIX_MASK			; 
			bcs	_BD56F				; if Bit 7 D1 set D56F
			ora	VDU_G_PIX_MASK			; else or withA
			pha					; save result
_BD560:			lda	VDU_G_PIX_MASK			; A=&D1
			bit	VDU_TMP1			; test bits 6 and 7 of &DA
			php					; save flags
			pla					; get into A
			eor	VDU_TMP3			; EOR and DC
			pha					; save A
			plp					; 
			beq	_BD551				; 

			pla					; A=A EOR &D1 (byte mask)
			eor	VDU_G_PIX_MASK			; 
_BD56F:			sta	VDU_G_PIX_MASK			; store it
			jmp	_LD0F0				; and display a pixel

_LD574:			lda	#$00				; A=0
			clc					; Clear carry

			bcc	_BD583				; goto D583 if carry clear

_BD579:			inx					; X=X+1
			bne	_BD580				; If <>0 D580
			inc	VDU_TMP2			; else inc &DB
			bpl	_BD56F				; and if +ve d56F

_BD580:			asl					; A=A*2
			bcs	_BD58E				; if C set D58E
_BD583:			ora	VDU_G_PIX_MASK			; else A=A OR (&D1)
			bit	VDU_TMP1			; set V and M from &DA b6 b7
			beq	_BD579				; 
			eor	VDU_G_PIX_MASK			; A=AEOR &D1
			lsr					; /2
			bcc	_BD56F				; if carry clear D56F
_BD58E:			ror					; *2
			sec					; set carry
			bcs	_BD56F				; to D56F

_LD592:			lda	VDU_G_WIN_L,X			; Y/A=(&300/1 +X)-(&320/1)
			sec					; 
			sbc	VDU_QUEUE_5			; 
			tay					; 
			lda	VDU_G_WIN_L_HI,X		; 
			sbc	VDU_QUEUE_6			; 
			bmi	_BD5A5				; if result -ve D5A5
			jsr	_LD49B				; or negate Y/A
_BD5A5:			sta	VDU_TMP2			; store A
			tya					; A=Y
			tax					; X=A
			ora	VDU_TMP2			; 
			rts					; exit

_LD5AC:			sty	VDU_TMP1			; Y=&DA
			txa					; A=X
			tay					; Y=A
			lda	VDU_TMP2			; A=&DB
			bmi	_BD5B6				; if -ve D5B6
			lda	#$00				; A=0
_BD5B6:			ldx	VDU_TMP1			; X=&DA
			bne	_BD5BD				; if <>0 D5BD
			jsr	_LD49B				; negate
_BD5BD:			pha					; 
			clc					; 
			tya					; 
			adc	VDU_G_WIN_L,X			; Y/A+(&300/1 +X)=(&320/1)
			sta	VDU_QUEUE_5			; 
			pla					; 
			adc	VDU_G_WIN_L_HI,X		; 
			sta	VDU_QUEUE_6			; 
			rts					; return


;*************************************************************************
;*									 *
;*	 OSWORD 13 - READ LAST TWO GRAPHIC CURSOR POSITIONS		 *
;*									 *
;*************************************************************************
				;
_OSWORD_13:		lda	#$03				; A=3
			jsr	_LD5D5				; 
			lda	#$07				; A=7
_LD5D5:			pha					; Save A
			jsr	_LCDE2				; exchange last 2 graphics cursor coordinates with
								; current coordinates
			jsr	_LD1B8				; convert to external coordinates
			ldx	#$03				; X=3
			pla					; save A
			tay					; Y=A
_BD5E0:			lda	VDU_G_CUR_XX,X			; get graphics coordinate
			sta	(OSW_X),Y			; store it in OS buffer
			dey					; decrement Y and X
			dex					; 
			bpl	_BD5E0				; if +ve do it again
			rts					; then Exit


;*************************************************************************
;*									 *
;*	 PLOT Fill triangle routine					 *
;*									 *
;*************************************************************************

_LD5EA:			ldx	#$20				; X=&20
			ldy	#$3e				; Y=&3E
			jsr	_LD47C				; copy 300/7+X to 300/7+Y
								; this gets XY data parameters and current graphics
								; cursor position
			jsr	_LD632				; exchange 320/3 with 324/7 if 316/7=<322/3
			ldx	#$14				; X=&14
			ldy	#$24				; Y=&24
			jsr	_LD636				; 
			jsr	_LD632				; 

			ldx	#$20				; 
			ldy	#$2a				; 
			jsr	_LD411				; calculate 032A/B-(324/5-320/1)
			lda	VDU_BITMAP_RD_3			; and store
			sta	VDU_WORKSPACE+2			; result

			ldx	#$28				; set pointers
			jsr	_LD459				; 
			ldy	#$2e				; 

			jsr	_LD0DE				; copy 320/3 32/31
			jsr	_LCDE2				; exchange 314/7 with 324/7
			clc					; 
			jsr	_LD658				; execute fill routine

			jsr	_LCDE2				; 
			ldx	#$20				; 
			jsr	_LCDE4				; 
			sec					; 
			jsr	_LD658				; 

			ldx	#$3e				; ;X=&3E
			ldy	#$20				; ;Y=&20
			jsr	_LD47C				; ;copy 300/7+X to 300/7+Y
			jmp	_LD0D9				; ;this gets XY data parameters and current graphics
								; cursor position

_LD632:			ldx	#$20				; X=&20
			ldy	#$14				; Y=&14
_LD636:			lda	VDU_G_WIN_B,X			; 
			cmp	VDU_G_WIN_B,Y			; 
			lda	VDU_G_WIN_B_HI,X		; 
			sbc	VDU_G_WIN_B_HI,Y		; 
			bmi	_BD657				; if 302/3+Y>302/3+X return
			jmp	_LCDE6				; else swap 302/3+X with 302/3+Y


;*************************************************************************
;*									 *
;*	 OSBYTE 134 - READ CURSOR POSITION				 *
;*									 *
;*************************************************************************

_OSBYTE_134:		lda	VDU_T_CURS_X			; read current text cursor (X)
			sec					; set carry
			sbc	VDU_T_WIN_L			; subtract left hand column of current text window
			tax					; X=A
			lda	VDU_T_CURS_Y			; get current text cursor (Y)
			sec					; 
			sbc	VDU_T_WIN_T			; suptract top row of current window
			tay					; Y=A
_BD657:			rts					; and exit

				; PLOT routines continue
				; many of the following routines are just manipulations
				; only points of interest will be explained
_LD658:			php					; store flags
			ldx	#$20				; X=&20
			ldy	#$35				; Y=&35
			jsr	_LD411				; 335/6=(324/5+X-320/1)
			lda	VDU_WORKSPACE+6			; 
			sta	VDU_WORKSPACE+$D		; 
			ldx	#$33				; 
			jsr	_LD459				; set pointers

			ldy	#$39				; set 339/C=320/3
			jsr	_LD0DE				; 
			sec					; 
			lda	VDU_QUEUE_7			; 
			sbc	VDU_G_CURS_V			; 
			sta	VDU_QUEUE			; 
			lda	VDU_QUEUE_8			; 
			sbc	VDU_G_CURS_V_HI			; 
			sta	VDU_QUEUE_1			; 
			ora	VDU_QUEUE			; check VDU queque
			beq	_BD69F				; 

_BD688:			jsr	_LD6A2				; display a line
			ldx	#$33				; 
			jsr	_LD774				; update pointers
			ldx	#$28				; 
			jsr	_LD774				; and again!
			inc	VDU_QUEUE			; update VDU queque
			bne	_BD688				; and if not empty do it again
			inc	VDU_QUEUE_1			; else increment next byte
			bne	_BD688				; and do it again

_BD69F:			plp					; pull flags
			bcc	_BD657				; if carry clear exit
_LD6A2:			ldx	#$39				; 
			ldy	#$2e				; 
_VDU_G_CLR_LINE:	stx	VDU_TMP5			; 
			lda	VDU_G_WIN_L,X			; is 300/1+x<300/1+Y
			cmp	VDU_G_WIN_L,Y			; 
			lda	VDU_G_WIN_L_HI,X		; 
			sbc	VDU_G_WIN_L_HI,Y		; 
			bmi	_BD6BC				; if so D6BC
			tya					; else A=Y
			ldy	VDU_TMP5			; Y=&DE
			tax					; X=A
			stx	VDU_TMP5			; &DE=X
_BD6BC:			sty	VDU_TMP6			; &DF=Y
			lda	VDU_G_WIN_L,Y			; 
			pha					; 
			lda	VDU_G_WIN_L_HI,Y		; 
			pha					; 
			ldx	VDU_TMP6			; 
			jsr	_LD10F				; check for window violations
			beq	_BD6DA				; 
			cmp	#$02				; 
			bne	_LD70E				; 
			ldx	#$04				; 
			ldy	VDU_TMP6			; 
			jsr	_LD482				; 
			ldx	VDU_TMP6			; 
_BD6DA:			jsr	_LD864				; set a screen address
			ldx	VDU_TMP5			; X=&DE
			jsr	_LD10F				; check for window violations
			lsr					; A=A/2
			bne	_LD70E				; if A<>0 then exit
			bcc	_BD6E9				; else if C clear D6E9
			ldx	#$00				; 
_BD6E9:			ldy	VDU_TMP6			; 
			sec					; 
			lda	VDU_G_WIN_L,Y			; 
			sbc	VDU_G_WIN_L,X			; 
			sta	VDU_TMP3			; 
			lda	VDU_G_WIN_L_HI,Y		; 
			sbc	VDU_G_WIN_L_HI,X		; 
			sta	VDU_TMP4			; 
			lda	#$00				; 
_BD6FE:			asl					; 
			ora	VDU_G_PIX_MASK			; 
			ldy	VDU_TMP3			; 
			bne	_BD719				; 
			dec	VDU_TMP4			; 
			bpl	_BD719				; 
			sta	VDU_G_PIX_MASK			; 
			jsr	_LD0F0				; display a point
_LD70E:			ldx	VDU_TMP6			; restore X
			pla					; and A
			sta	VDU_G_WIN_L_HI,X		; store it
			pla					; get back A
			sta	VDU_G_WIN_L,X			; and store it
			rts					; exit
								;
_BD719:			dec	VDU_TMP3			; 
			tax					; 
			bpl	_BD6FE				; 
			sta	VDU_G_PIX_MASK			; 
			jsr	_LD0F0				; display a point
			ldx	VDU_TMP3			; 
			inx					; 
			bne	_BD72A				; 
			inc	VDU_TMP4			; 
_BD72A:			txa					; 
			pha					; 
			lsr	VDU_TMP4			; 
			ror					; 
			ldy	VDU_PIX_BYTE			; number of pixels/byte
			cpy	#$03				; if 3 mode = goto D73B
			beq	_BD73B				; 
			bcc	_BD73E				; else if <3 mode 2 goto D73E
			lsr	VDU_TMP4			; else rotate bottom bit of &DD
			ror					; into Accumulator

_BD73B:			lsr	VDU_TMP4			; rotate bottom bit of &DD
			lsr					; into Accumulator
_BD73E:			ldy	VDU_G_CURS_SCAN			; Y=line in current graphics cell containing current
								; point
			tax					; X=A
			beq	_BD753				; 
_BD744:			tya					; Y=Y-8
			sec					; 
			sbc	#$08				; 
			tay					; 

			bcs	_BD74D				; 
			dec	VDU_G_MEM_HI			; decrement byte of top line off current graphics cell
_BD74D:			jsr	_LD104				; display a point
			dex					; 
			bne	_BD744				; 
_BD753:			pla					; 
			and	VDU_PIX_BYTE			; pixels/byte
			beq	_LD70E				; 
			tax					; 
			lda	#$00				; A=0
_BD75C:			asl					; 
			ora	VDU_MASK_LEFT			; or with right colour mask
			dex					; 
			bne	_BD75C				; 
			sta	VDU_G_PIX_MASK			; store as byte mask
			tya					; Y=Y-8
			sec					; 
			sbc	#$08				; 
			tay					; 
			bcs	_BD76E				; if carry clear
			dec	VDU_G_MEM_HI			; decrement byte of top line off current graphics cell
_BD76E:			jsr	_LD0F3				; display a point
			jmp	_LD70E				; and exit via D70E

_LD774:			inc	VDU_T_WIN_L,X			; 
			bne	_BD77C				; 
			inc	VDU_T_WIN_B,X			; 
_BD77C:			sec					; 
			lda	VDU_G_WIN_L,X			; 
			sbc	VDU_G_WIN_B,X			; 
			sta	VDU_G_WIN_L,X			; 
			lda	VDU_G_WIN_L_HI,X		; 
			sbc	VDU_G_WIN_B_HI,X		; 
			sta	VDU_G_WIN_L_HI,X		; 
			bpl	_BD7C1				; 
_BD791:			lda	VDU_T_WIN_R,X			; 
			bmi	_BD7A1				; 
			inc	VDU_G_WIN_T,X			; 
			bne	_LD7AC				; 
			inc	VDU_G_WIN_T_HI,X		; 
			jmp	_LD7AC				; 
_BD7A1:			lda	VDU_G_WIN_T,X			; 
			bne	_BD7A9				; 
			dec	VDU_G_WIN_T_HI,X		; 
_BD7A9:			dec	VDU_G_WIN_T,X			; 
_LD7AC:			clc					; 
			lda	VDU_G_WIN_L,X			; 
			adc	VDU_G_WIN_R,X			; 
			sta	VDU_G_WIN_L,X			; 
			lda	VDU_G_WIN_L_HI,X		; 
			adc	VDU_G_WIN_R_HI,X		; 
			sta	VDU_G_WIN_L_HI,X		; 
			bmi	_BD791				; 
_BD7C1:			rts					; 


;*************************************************************************
;*									 *
;*	 OSBYTE 135 - READ CHARACTER AT TEXT CURSOR POSITION		 *
;*									 *
;*************************************************************************

_OSBYTE_135:		ldy	VDU_COL_MASK			; get number of logical colours
			bne	_BD7DC				; if Y<>0 mode <>7 so D7DC
			lda	(VDU_TOP_SCAN),Y		; get address of top scan line of current text chr
			ldy	#$02				; Y=2
_BD7CB:			cmp	_TELETEXT_CHAR_TAB+1,Y		; compare with conversion table
			bne	_BD7D4				; if not equal D7d4
			lda	_TELETEXT_CHAR_TAB,Y		; else get next lower byte from table
			dey					; Y=Y-1
_BD7D4:			dey					; Y=Y-1
			bpl	_BD7CB				; and if +ve do it again
_BD7D7:			ldy	VDU_MODE			; Y=current screen mode
			tax					; return with character in X
			rts					; 
								;
_BD7DC:			jsr	_LD808				; set up copy of the pattern bytes at text cursor
			ldx	#$20				; X=&20
_BD7E1:			txa					; A=&20
			pha					; Save it
			jsr	_LD03E				; get pattern address for code in A
			pla					; get back A
			tax					; and X
_BD7E8:			ldy	#$07				; Y=7
_BD7EA:			lda	VDU_BITMAP_READ,Y		; get byte in pattern copy
			cmp	(VDU_TMP5),Y			; check against pattern source
			bne	_BD7F9				; if not the same D7F9
			dey					; else Y=Y-1
			bpl	_BD7EA				; and if +ve D7EA
			txa					; A=X
			cpx	#$7f				; is X=&7F (delete)
			bne	_BD7D7				; if not D7D7
_BD7F9:			inx					; else X=X+1
			lda	VDU_TMP5			; get byte lo address
			clc					; clear carry
			adc	#$08				; add 8
			sta	VDU_TMP5			; store it
			bne	_BD7E8				; and go back to check next character if <>0

			txa					; A=X
			bne	_BD7E1				; if <>0 D7E1
			beq	_BD7D7				; else D7D7

;***************** set up pattern copy ***********************************

_LD808:			ldy	#$07				; Y=7

_BD80A:			sty	VDU_TMP1			; &DA=Y
			lda	#$01				; A=1
			sta	VDU_TMP2			; &DB=A
_BD810:			lda	VDU_MASK_RIGHT			; A=left colour mask
			sta	VDU_TMP3			; store an &DC
			lda	(VDU_TOP_SCAN),Y		; get a byte from current text character
			eor	VDU_T_BG			; EOR with text background colour
			clc					; clear carry
_BD81B:			bit	VDU_TMP3			; and check bits of colour mask
			beq	_BD820				; if result =0 then D820
			sec					; else set carry
_BD820:			rol	VDU_TMP2			; &DB=&DB+Carry
			bcs	_BD82E				; if carry now set (bit 7 DB originally set) D82E
			lsr	VDU_TMP3			; else	&DC=&DC/2
			bcc	_BD81B				; if carry clear D81B
			tya					; A=Y
			adc	#$07				; ADD ( (7+carry)
			tay					; Y=A
			bcc	_BD810				; 
_BD82E:			ldy	VDU_TMP1			; read modified values into Y and A
			lda	VDU_TMP2			; 
			sta	VDU_BITMAP_READ,Y		; store copy
			dey					; and do it again
			bpl	_BD80A				; until 8 bytes copied
			rts					; exit

;********* pixel reading *************************************************

_LD839:			pha					; store A
			tax					; X=A
			jsr	_LD149				; set up positional data
			pla					; get back A
			tax					; X=A
			jsr	_LD85F				; set a screen address after checking for window
								; violations
			bne	_BD85A				; if A<>0 D85A to exit with A=&FF
			lda	(VDU_G_MEM),Y			; else get top line of current graphics cell
_BD847:			asl					; A=A*2 C=bit 7
			rol	VDU_TMP1			; &DA=&DA+2 +C	C=bit 7 &DA
			asl	VDU_G_PIX_MASK			; byte mask=bM*2 +carry from &DA
			php					; save flags
			bcs	_BD851				; if carry set D851
			lsr	VDU_TMP1			; else restore &DA with bit '=0
_BD851:			plp					; pull flags
			bne	_BD847				; if Z set D847
			lda	VDU_TMP1			; else A=&DA AND number of colours in current mode -1
			and	VDU_COL_MASK			; 
			rts					; then exit
								;
_BD85A:			lda	#$ff				; A=&FF
_BD85C:			rts					; exit

;********** check for window violations and set up screen address **********

_LD85D:			ldx	#$20				; X=&20
_LD85F:			jsr	_LD10F				; 
			bne	_BD85C				; if A<>0 there is a window violation so D85C
_LD864:			lda	VDU_G_WIN_B,X			; else set up graphics scan line variable
			eor	#$ff				; 
			tay					; 
			and	#$07				; 
			sta	VDU_G_CURS_SCAN			; in 31A
			tya					; A=Y
			lsr					; A=A/2
			lsr					; A=A/2
			lsr					; A=A/2
			asl					; A=A*2 this gives integer value bit 0 =0
			tay					; Y=A
			lda	(VDU_ROW_MULT),Y		; get high byte of offset from screen RAM start
			sta	VDU_TMP1			; store it
			iny					; Y=Y+1
			lda	(VDU_ROW_MULT),Y		; get lo byte
			ldy	VDU_MAP_TYPE			; get screen map type
			beq	_BD884				; if 0 (modes 0,1,2) goto D884
			lsr	VDU_TMP1			; else &DA=&DA/2
			ror					; and A=A/2 +C if set
								; so 2 byte offset =offset/2

_BD884:			adc	VDU_MEM				; add screen top left hand corner lo
			sta	VDU_G_MEM			; store it
			lda	VDU_TMP1			; get high  byte
			adc	VDU_MEM_HI			; add top left hi
			sta	VDU_G_MEM_HI			; store it
			lda	VDU_G_WIN_L_HI,X		; 
			sta	VDU_TMP1			; 
			lda	VDU_G_WIN_L,X			; 
			pha					; 
			and	VDU_PIX_BYTE			; and then Add pixels per byte-1
			adc	VDU_PIX_BYTE			; 
			tay					; Y=A
			lda	_LC406,Y			; A=&80 /2^Y using look up table
			sta	VDU_G_PIX_MASK			; store it
			pla					; get back A
			ldy	VDU_PIX_BYTE			; Y=&number of pixels/byte
			cpy	#$03				; is Y=3 (modes 1,6)
			beq	_BD8B2				; goto D8B2
			bcs	_BD8B5				; if mode =1 or 4 D8B5
			asl					; A/&DA =A/&DA *2
			rol	VDU_TMP1			; 

_BD8B2:			asl					; 
			rol	VDU_TMP1			; 

_BD8B5:			and	#$f8				; clear bits 0-2
			clc					; clear carry

			adc	VDU_G_MEM			; add A/&DA to &D6/7
			sta	VDU_G_MEM			; 
			lda	VDU_TMP1			; 
			adc	VDU_G_MEM_HI			; 
			bpl	_BD8C6				; if result +ve D8C6
			sec					; else set carry
			sbc	VDU_MEM_PAGES			; and subtract screen memory size making it wrap round

_BD8C6:			sta	VDU_G_MEM_HI			; store it in &D7
			ldy	VDU_G_CURS_SCAN			; get line in graphics cell containing current graphics
_BD8CB:			lda	#$00				; point	 A=0
			rts					; And exit
								;
_LD8CE:			pha					; Push A
			lda	#$a0				; A=&A0
			ldx	OSB_VDU_QSIZE			; X=number of items in VDU queque
			bne	_BD916				; if not 0 D916
			bit	VDU_STATUS			; else check VDU status byte
			bne	_BD916				; if either VDU is disabled or plot to graphics
								; cursor enabled then D916
			bvs	_BD8F5				; if cursor editing enabled D8F5
			lda	VDU_CURS_PREV			; else get 6845 register start setting
			and	#$9f				; clear bits 5 and 6
			ora	#$40				; set bit 6 to modify last cursor size setting
			jsr	_LC954				; change write cursor format
			ldx	#$18				; X=&18
			ldy	#$64				; Y=&64
			jsr	_LD482				; set text input cursor from text output cursor
			jsr	_LCD7A				; modify character at cursor poistion
			lda	#$02				; A=2
			jsr	_LC59D				; bit 1 of VDU status is set to bar scrolling


_BD8F5:			lda	#$bf				; A=&BF
			jsr	_LC5A8				; bit 6 of VDU status =0
			pla					; Pull A
			and	#$7f				; clear hi bit (7)
			jsr	_VDUCHR				; entire VDU routine !!
			lda	#$40				; A=&40
			jmp	_LC59D				; exit


_LD905:			lda	#$20				; A=&20
			bit	VDU_STATUS			; if bit 6 cursor editing is set
			bvc	_BD8CB				; 
			bne	_BD8CB				; or bit 5 is set exit &D8CB
			jsr	_OSBYTE_135			; read a character from the screen
			beq	_BD917				; if A=0 on return exit via D917
			pha					; else store A
			jsr	_VDU_9				; perform cursor right

_BD916:			pla					; restore A
_BD917:			rts					; and exit
								;
_LD918:			lda	#$bd				; zero bits 2 and 6 of VDU status
			jsr	_LC5A8				; 
			jsr	_LC951				; set normal cursor
			lda	#$0d				; A=&0D
			rts					; and return
								; this is response of CR as end of edit line


;*************************************************************************
;*									 *
;*	 OSBYTE 132 - READ BOTTOM OF DISPLAY RAM			 *
;*									 *
;*************************************************************************

_OSBYTE_132:		ldx	VDU_MODE			; Get current screen mode


;*************************************************************************
;*									 *
;*	 OSBYTE 133 - READ LOWEST ADDRESS FOR GIVEN MODE		 *
;*									 *
;*************************************************************************

_OSBYTE_133:		txa					; A=X
			and	#$07				; Ensure mode 0-7
			tay					; Pass to Y into index into screen size table
			ldx	_LC440,Y			; X=screen size type, 0-4
			lda	_VDU_MEMLOC_TAB,X		; A=high byte of start address for screen type
			ldx	#$00				; Returned address is &xx00
			bit	OSB_RAM_PAGES			; Check available RAM
			bmi	_BD93E				; If bit 7 set then 32K RAM, so return address
			and	#$3f				; 16K RAM, so drop address to bottom 16K
			cpy	#$04				; Check screen mode
			bcs	_BD93E				; If mode 4-7, return the address
			txa					; If mode 0-3, return &0000 as not enough memory
; exit
_BD93E:			tay					; Pass high byte of address to Y
			rts					; and return address in YX


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

_VECTOR_TABLE:		.addr	_USERV				; USERV				&200
			.addr	_BRKV				; BRKV				&202
			.addr	_IRQ1V				; IRQ1V				&204
			.addr	_IRQ2V				; IRQ2V				&206
			.addr	_CLIV				; CLIV				&208
			.addr	_BYTEV				; BYTEV				&20A
			.addr	_WORDV				; WORDV				&20C
			.addr	_NVWRCH				; WRCHV				&20E
			.addr	_NVRDCH				; RDCHV				&210
			.addr	_FILEV				; FILEV				&212
			.addr	_ARGSV				; ARGSV				&214
			.addr	_BGETV				; BGETV				&216
			.addr	_BPUTV				; BPUTV				&218
			.addr	_NOTIMPV			; GBPBV				&21A
			.addr	_FINDV				; FINDV				&21C
			.addr	_FSCV				; FSCV				&21E
			.addr	_NOTIMPV			; EVNTV				&220
			.addr	_NOTIMPV			; UPTV				&222
			.addr	_NOTIMPV			; NETV				&224
			.addr	_NOTIMPV			; VDUV				&226
			.addr	_KEYV				; KEYV				&228
			.addr	_INSBV				; INSBV				&22A
			.addr	_REMVB				; REMVB				&22C
			.addr	_CNPV				; CNPV				&22E
			.addr	_NOTIMPV			; IND1V				&230
			.addr	_NOTIMPV			; IND2V				&232
			.addr	_NOTIMPV			; IND3V				&234

; -------------------------------------------------------------------------
; |									  |
; |	  DEFAULT MOS VARIABLES SETTINGS				  |
; |									  |
; -------------------------------------------------------------------------

;* Read/Written by OSBYTE &A6 to &FC

			.addr	$0190				; OSBYTE variables base address		 &236	*FX166/7
								; (address to add to osbyte number)
			.addr	$0d9f				; Address of extended vectors		 &238	*FX168/9
			.addr	ROM_TABLE			; Address of ROM information table	 &23A	*FX170/1
			.addr	_KEY_TRANS_TABLE_1 - $10	; Address of key translation table	 &23C	*FX172/3
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

;**************************************************************************
;**************************************************************************
;**									 **
;**	 MAIN IRQ Entry point						 **
;**									 **
;**									 **
;**************************************************************************
;**************************************************************************
;ON ENTRY STACK contains	STATUS REGISTER,PCH,PCL			;

			.org	$dc1c

_IRQ_HANDLER:		sta	IRQ_COPY_A			; save A
			pla					; get back status (flags)
			pha					; and save again
			and	#$10				; check if BRK flag set
			bne	_BRK				; if so goto DC27
			jmp	(VEC_IRQ1V)			; else JMP (IRQ1V)


;*************************************************************************
;*									 *
;*		 BRK handling routine					 *
;*									 *
;*************************************************************************

_BRK:			txa					; save X on stack
			pha					; 
			tsx					; get status pointer
			lda	STACK+3,X			; get Program Counter lo
			cld					; 
			sec					; set carry
			sbc	#$01				; subtract 2 (1+carry)
			sta	ERR_MSG_PTR			; and store it in &FD
			lda	STACK+4,X			; get hi byte
			sbc	#$00				; subtract 1 if necessary
			sta	ERR_MSG_PTR_HI			; and store in &FE
			lda	ROM_SELECT			; get currently active ROM
			sta	OSB_LAST_ROM			; and store it in &24A
			stx	OSW_X				; store stack pointer in &F0
			ldx	#$06				; and issue ROM service call 6
			jsr	_OSBYTE_143			; (User BRK) to ROMs
								; at this point &FD/E point to byte after BRK
								; ROMS may use BRK for their own purposes

			ldx	OSB_CUR_LANG			; get current language
			jsr	_LDC16				; and activate it
			pla					; get back original value of X
			tax					; 
			lda	IRQ_COPY_A			; get back original value of A
			cli					; allow interrupts
			jmp	(VEC_BRKV)			; and JUMP via BRKV (normally into current language)


;*************************************************************************
;*									 *
;*	 DEFAULT BRK HANDLER						 *
;*									 *
;*************************************************************************

_BRKV:			ldy	#$00				; Y=0 to point to byte after BRK
			jsr	_LDEB1				; print message

			lda	OSB_BOOT_DISP			; if BIT 0 set and DISC EXEC error
			ror					; occurs
_HCF:			bcs	_HCF				; hang up machine!!!!

			jsr	OSNEWL				; else print two newlines
			jsr	OSNEWL				; 
			jmp	_LDBB8				; and set tape speed before entering current
								; language

; ACIA IRQ, RxRDY but both Serial and Printer buffers empty
; ---------------------------------------------------------
_BDC68:			sec					
			ror	OSB_RS423_USE			; Set b7 of RS423 busy flag
			bit	OSB_RS423_CTL			; check bit 7 of current ACIA control register
			bpl	_BDC78				; if interrupts NOT enabled DC78
			jsr	_LE741				; else E741 to check if serial buffer full
			ldx	#$00				; X=&00 to set RTS low
			bcs	_BDC7A				; if carry set goto DC7A to transfer data

_BDC78:			ldx	#$40				; X=&40 to set RTS high
_BDC7A:			jmp	_LE17A				; Jump to set ACIA control register

; Serial IRQ and RxRDY - Get byte and store in serial buffer
; ----------------------------------------------------------
_BDC7D:			ldy	ACIA_TXRX			; Read data from ACIA
			and	#$3a				; Check PE:RO:FE:DCD
			bne	_BDCB8				; If any set, jump to generate Serial Error Event

; Serial IRQ and RxRDY, no errors
; -------------------------------
			ldx	OSB_SER_BUF_SUP			; Read RS423 input suppression flag
			bne	_BDC92				; If not 0, jump to ignore
			inx					; X=1, serial input buffer
			jsr	_OSBYTE_153			; Put byte in buffer
			jsr	_LE741				; Check if serial buffer almost full
			bcc	_BDC78				; If almost full, jump to set RTS high
_BDC92:			rts					; Return


;*************************************************************************
;*									 *
;*	 Main IRQ Handling routines, default IRQ1V destination		 *
;*									 *
;*************************************************************************

_IRQ1V:			cld					; Clear decimal flag
			lda	IRQ_COPY_A			; Get original value of A
			pha					; Save it
			txa					; Save X
			pha					; 
			tya					; and Y
			pha					; 
			lda	#$de				; Stack return address to &DE82
			pha					
			lda	#$81				
			pha					
			clv					; Clear V flag
_POLL_ACIA_IRQ:		lda	ACIA_CSR			; Read ACIA status register
			bvs	__irq_acia			; b6 set, jump with serial parity error
			bpl	_POLL_SYS_VIA_IRQ		; b7=0, no ACIA interrupt, jump to check VIAs

; ACIA Interrupt or ACIA Parity Error
; -----------------------------------
__irq_acia:		ldx	RS423_TIMEOUT			; Get RS423 timeout counter
			dex					; Decrement it
			bmi	_BDCDE				; If 0 or <0, RS423 owns 6850, jump to DCDE
			bvs	_BDCDD				; If &41..&80, nobody owns 6850, jump to exit
			jmp	_CRFS_READ			; CFS owns 6850, jump to read ACIA in CFS routines

; ACIA Data Carrier Detect
; ------------------------
_BDCB3:			ldy	ACIA_TXRX			; Read ACIA data
			rol	A				; 
			asl	A				; Rotate ACIA Status back
_BDCB8:			tax					; X=ACIA Status
			tya					; A=ACIA Data
			ldy	#$07				; Y=07 for RS423 Error Event
			jmp	_OSEVEN				; Jump to issue event

; ACIA IRQ, TxRDY - Send a byte
; -----------------------------
_BDCBF:			ldx	#$02				
			jsr	_OSBYTE_145			; Read from Serial output buffer
			bcc	_BDCD6				; Buffer is not empty, jump to send byte
			lda	OSB_PRINT_DEST			; Read printer destination
			cmp	#$02				; Is it serial printer??
			bne	_BDC68				; Serial buffer empty, not Serial printer, jump to ... DC68
			inx					; X=3 for Printer buffer
			jsr	_OSBYTE_145			; Read from Printer buffer
			ror	BUFFER_3_BUSY			; Copy Byte Fetched/Not fetched into Printer Buffer full flag
			bmi	_BDC68				; Printer buffer was empty, so jump to ... DC68

_BDCD6:			sta	ACIA_TXRX			; Send byte to ACIA
			lda	#$e7				; Set timeout counter to &E7
			sta	RS423_TIMEOUT			; Serial owns 6850 for 103 more calls
_BDCDD:			rts					; Exit IRQ

; RS423 owns 6850, PE or RxRDY interupt occured
; ---------------------------------------------
; On entry, A contains ACIA status

_BDCDE:			and	OSB_ACIA_IRQ_M			; AND with ACIA IRQ mask (normally &FF)
			lsr	A				; Move RxRDY into Carry
			bcc	_BDCEB				; If no RxData, jump to check DCD and TxRDY

; Data in RxData, check for errors

			bvs	_BDCEB				; If IRQ=1 (now in b6) RxIRQ must have occured, so jump to DCEB

; RxData but no RxIRQ, check that IRQs are actually disabled

			ldy	OSB_RS423_CTL			; Get ACIA control setting
			bmi	_BDC7D				; If bit 7=1, IRQs enabled so jump to read byte and insert into buffer

; DCE9 -> RxData, no RxIRQ, IRQs disabled
; DCE4 -> RxData and RxIRQ
; DCE2 -> No RxData

; Check TxRDY and DCD, if neither set, send a Serial Error Event
; --------------------------------------------------------------
_BDCEB:			lsr	A				; Move TxRDY into Carry
			ror	A				; Rotate TxRDY into b7 and DCD into Carry
			bcs	_BDCB3				; If Data Carrier Detected, jump to DCB3
			bmi	_BDCBF				; If TxRDY (now in b7) jump to to DCBF to send a byte
			bvs	_BDCDD				; b6 should always be zero by now, but if set, then jump to exit

; Issue Unknown Interupt service call
; ===================================
_IRQ_UNKNOWN:		ldx	#$05				
			jsr	_OSBYTE_143			; Issue service call 5, 'Unknown Interrupt'
			beq	_BDCDD				; If claimed, then jump to exit
			pla					; Otherwise drop return address from stack
			pla					; 
			pla					; And restore registers
			tay					; 
			pla					; 
			tax					; 
			pla					; 
			sta	IRQ_COPY_A			; Store A in IRQA
			jmp	(VEC_IRQ2V)			; And pass the IRQ in to IRQ2V


;*************************************************************************
;*									 *
;* VIA INTERUPTS ROUTINES						 *
;*									 *
;*************************************************************************

_POLL_SYS_VIA_IRQ:	lda	SYS_VIA_IFR			; Read System VIA interrupt flag register
			bpl	_POLL_USER_VIA_IRQ		; No System VIA interrupt, jump to check User VIA

; System VIA interupt

			and	OSB_SVIA_IRQ_M			; Mask with System VIA bit mask
			and	SYS_VIA_IER			; and interrupt enable register
_POLL_FRAME_SYNC_IRQ:	ror					; Rotate to check for CA1 interupt (frame sync)
			ror					; 
			bcc	_POLL_TIMER2_IRQ		; No CA1 (frame sync), jump to check speech

; System VIA CA1 interupt (Frame Sync)

			dec	OSB_CFS_TIMEOUT			; decrement vertical sync counter
			lda	RS423_TIMEOUT			; A=RS423 Timeout counter
			bpl	_BDD1E				; if +ve then DD1E
			inc	RS423_TIMEOUT			; else increment it
_BDD1E:			lda	OSB_FLASH_TIME			; load flash counter
			beq	_BDD3D				; if 0 then system is not in use, ignore it
			dec	OSB_FLASH_TIME			; else decrement counter
			bne	_BDD3D				; and if not 0 go on past reset routine

			ldx	OSB_FLASH_SPC			; else get mark period count in X
			lda	OSB_VIDPROC_CTL			; current VIDEO ULA control setting in A
			lsr					; shift bit 0 into C to check if first colour
			bcc	_BDD34				; is effective if so C=0 jump to DD34

			ldx	OSB_FLASH_MARK			; else get space period count in X
_BDD34:			rol					; restore bit
			eor	#$01				; and invert it
			jsr	_LEA00				; then change colour

			stx	OSB_FLASH_TIME			; &0251=X resetting the counter

_BDD3D:			ldy	#$04				; Y=4 and call E494 to check and implement vertical
			jsr	_OSEVEN				; sync event (4) if necessary
			lda	#$02				; A=2
			jmp	_LDE6E				; clear interrupt 1 and exit


;*************************************************************************
;*									 *
;*	 PRINTER INTERRUPT USER VIA 1					 *
;*									 *
;*************************************************************************

_POLL_USER_VIA_IRQ:	lda	USR_VIA_IFR			; Read User VIA interrupt flag register
			bpl	_IRQ_UNKNOWN			; No User VIA interrupt, jump to pass to ROMs

; User VIA interupt

			and	OSB_UVIA_IRQ_M			; else check for USER IRQ 1
			and	USR_VIA_IER			; 
			ror					; 
			ror					; 
			bcc	_IRQ_UNKNOWN			; if bit 1=0 the no interrupt 1 so DCF3
			ldy	OSB_PRINT_DEST			; else get printer type
			dey					; decrement
			bne	_IRQ_UNKNOWN			; if not parallel then DCF3
			lda	#$02				; reset interrupt 1 flag
			sta	USR_VIA_IFR			; 
			sta	USR_VIA_IER			; disable interrupt 1
			ldx	#$03				; and output data to parallel printer
			jmp	_LE13A				; 


;*************************************************************************
;*									 *
;*	 SYSTEM INTERRUPT 5   Speech					 *
;*									 *
;*************************************************************************

_POLL_TIMER2_IRQ:	rol					; Rotate bit 5 into bit 7
			rol					; 
			rol					; 
			rol					; 
			bpl	_POLL_TIMER_IRQ			; Not a Timer 2 interrupt, jump to check timers

; System VIA Timer 2 interupt - Speech interupt

			lda	#$20				; Prepare to clear VIA interupt
			ldx	#$00				
			sta	SYS_VIA_IFR			; Clear VIA interupt
			stx	SYS_VIA_T2C_H			; Zero high byte of T2 Timer
_LDD79:			ldx	#$08				; X=8 for Speech buffer
			stx	MOS_WS_1			; Prepare to loop up to four times for Speak from RAM

_BDD7D:			jsr	_OSBYTE_152			; Examine Speech buffer
			ror	BUFFER_8_BUSY			; Shift carry into bit 7
			bmi	_BDDC9				; Buffer empty, so exit
			tay					; Buffer not empty, A=first byte waiting
			beq	_BDD8D				; Waiting byte=&00 (Speak, no reset), skip past
			jsr	_OSBYTE_158			; control speech chip
			bmi	_BDDC9				; if negative exit

_BDD8D:			jsr	_OSBYTE_145			; Fetch Speech command byte from buffer
			sta	RFS_SELECT			; Store it
			jsr	_OSBYTE_145			; Fetch Speech word high byte from buffer
			sta	ROM_PTR_HI			; Store it
			jsr	_OSBYTE_145			; Fetch Speech word low byte from buffer
			sta	ROM_PTR				; Store it, giving &F6/7=address to be accessed
			ldy	RFS_SELECT			; Y=Speech command byte
			beq	_BDDBB				; SOUND &FF00 - Speak from RAM, no reset
			bpl	_BDDB8				; SOUND &FF01-&FF7F - Speak from RAM, with reset
			bit	RFS_SELECT			; Check bit 6 of Speech command
			bvs	_BDDAB				; SOUND &FFC0-&FFFF - Speak word number

; SOUND &FF80-&FFBF - Speak from absolute address
; &F5=command &80-&BF (b0-b3=PHROM number), &F6/7=address

			jsr	_LEEBB				; Write address to speech processor
			bvc	_BDDB2				; Skip forward to speak from selected address

; SOUND &FFC0-&FFFF - Speak word number
; &F5=command &C0-&FF (b0-b3=PHROM number), &F6/7=word number

_BDDAB:			asl	ROM_PTR				; Multiply address by 2 to index into word table
			rol	ROM_PTR_HI			; 
			jsr	_LEE3B				; Read address from specified PHROM

; Speak from PHROM address
; By now, the address in the PHROM specified in Command b0-b3 has been set
; to the start of the speech data to be voiced.

_BDDB2:			ldy	OSB_SPEECH_OFF			; Fetch command code, usually &50=Speak or &00=Nop
			jmp	_OSBYTE_159			; Jump to send command to speak from current address

; SOUND &FF01-&FF7F - Speak from RAM with reset
; Y=Speech command byte, &F6/7=Speech data
; Use SOUND &FF60 to send Speak External command

_BDDB8:			jsr	_OSBYTE_159			; Send command byte to Speech processor

; SOUND &FF00 - Speak from RAM without reset
; &6/7=Speech data

_BDDBB:			ldy	ROM_PTR				
			jsr	_OSBYTE_159			; Send Speech data low byte
			ldy	ROM_PTR_HI			
			jsr	_OSBYTE_159			; Send Speech data high byte
			lsr	MOS_WS_1			; Shift loop counter
			bne	_BDD7D				; Loop to send up to four byte-pairs
_BDDC9:			rts					

;***********************************************************************
;*									 *
;*	 SYSTEM INTERRUPT 6 10mS Clock					 *
;*									 *
;*************************************************************************

_POLL_TIMER_IRQ:	bcc	_POLL_ADC_IRQ			; bit 6 is in carry so if clear there is no 6 int
								; so go on to DE47
			lda	#$40				; Clear interrupt 6
			sta	SYS_VIA_IFR			; 

;UPDATE timers routine, There are 2 timer stores &292-6 and &297-B
;these are updated by adding 1 to the current timer and storing the
;result in the other, the direction of transfer being changed each
;time of update.  This ensures that at least 1 timer is valid at any call
;as the current timer is only read.  Other methods would cause inaccuracies
;if a timer was read whilst being updated.

			lda	OSB_TIME_SWITCH			; get current system clock store pointer (5,or 10)
			tax					; put A in X
			eor	#$0f				; and invert lo nybble (5 becomes 10 and vv)
			pha					; store A
			tay					; put A in Y

				; Carry is always set at this point
_BDDD9:			lda	TIME_VAL1_MSB-1,X		; get timer value
			adc	#$00				; update it
			sta	TIME_VAL1_MSB-1,Y		; store result in alternate
			dex					; decrement X
			beq	_BDDE7				; if 0 exit
			dey					; else decrement Y
			bne	_BDDD9				; and go back and do next byte

_BDDE7:			pla					; get back A
			sta	OSB_TIME_SWITCH			; and store back in clock pointer (i.e. inverse previous
								; contents)
			ldx	#$05				; set loop pointer for countdown timer
_BDDED:			inc	COUNTER_MSB-1,X			; increment byte and if
			bne	_BDDFA				; not 0 then DDFA
			dex					; else decrement pointer
			bne	_BDDED				; and if not 0 do it again
			ldy	#$05				; process EVENT 5 interval timer
			jsr	_OSEVEN				; 

_BDDFA:			lda	INKEY_TIMER			; get byte of inkey countdown timer
			bne	_BDE07				; if not 0 then DE07
			lda	INKEY_TIMER_HI			; else get next byte
			beq	_BDE0A				; if 0 DE0A
			dec	INKEY_TIMER_HI			; decrement 2B2
_BDE07:			dec	INKEY_TIMER			; and 2B1

_BDE0A:			bit	SOUND_SEMAPHORE			; read bit 7 of envelope processing byte
			bpl	_BDE1A				; if 0 then DE1A
			inc	SOUND_SEMAPHORE			; else increment to 0
			cli					; allow interrupts
			jsr	_SOUND_IRQ			; and do routine sound processes
			sei					; bar interrupts
			dec	SOUND_SEMAPHORE			; DEC envelope processing byte back to 0

_BDE1A:			bit	BUFFER_8_BUSY			; read speech buffer busy flag
			bmi	_BDE2B				; if set speech buffer is empty, skip routine
			jsr	_OSBYTE_158			; update speech system variables
			eor	#$a0				; 
			cmp	#$60				; 
			bcc	_BDE2B				; if result >=&60 DE2B
			jsr	_LDD79				; else more speech work

_BDE2B:			bit	_BD9B7				; set V and C
			jsr	_POLL_ACIA_IRQ			; check if ACIA needs attention
			lda	KEYNUM_FIRST			; check if key has been pressed
			ora	KEYNUM_LAST			; 
			and	OSB_KEY_SEM			; (this is 0 if keyboard is to be ignored, else &FF)
			beq	_BDE3E				; if 0 ignore keyboard
			sec					; else set carry
			jsr	_LF065				; and call keyboard
_BDE3E:			jsr	_LE19B				; check for data in user defined printer channel
			bit	ADC_SR				; if ADC bit 6 is set ADC is not busy
			bvs	_BDE4A				; so DE4A
			rts					; else return


;*************************************************************************
;*									 *
;*	 SYSTEM INTERRUPT 4 ADC end of conversion			 *
;*									 *
;*************************************************************************

_POLL_ADC_IRQ:		rol					; put original bit 4 from FE4D into bit 7 of A
			bpl	_BDE72				; if not set DE72

_BDE4A:			ldx	OSB_ADC_CHAN			; else get current ADC channel
			beq	_BDE6C				; if 0 DE6C
			lda	ADC_LO				; read low data byte
			sta	OSW0_MAX_CHAR,X			; store it in &2B6,7,8 or 9
			lda	ADC_HI				; get high data byte
			sta	ADC_CHAN4_LO,X			; and store it in hi byte
			stx	ADC_CHAN_FLAG			; store in Analogue system flag marking last channel
			ldy	#$03				; handle event 3 conversion complete
			jsr	_OSEVEN				; 

			dex					; decrement X
			bne	_BDE69				; if X=0
			ldx	OSB_ADC_MAX			; get highest ADC channel preseny
_BDE69:			jsr	_LDE8F				; and start new conversion
_BDE6C:			lda	#$10				; reset interrupt 4
_LDE6E:			sta	SYS_VIA_IFR			; 
			rts					; and return


;*************************************************************************
;*									 *
;*	 SYSTEM INTERRUPT 0 Keyboard					 *
;*									 *
;*************************************************************************

_BDE72:			rol					; get original bit 0 in bit 7 position
			rol					; 
			rol					; 
			rol					; 
			bpl	_BDE7F				; if bit 7 clear not a keyboard interrupt
			jsr	_LF065				; else scan keyboard
			lda	#$01				; A=1
			bne	_LDE6E				; and off to reset interrupt and exit

_BDE7F:			jmp	_IRQ_UNKNOWN			; 

;************** exit routine *********************************************

			pla					; restore registers
			tay					; 
			pla					; 
			tax					; 
			pla					; 
			sta	IRQ_COPY_A			; store A


;*************************************************************************
;*									 *
;*	 IRQ2V default entry						 *
;*									 *
;*************************************************************************

_IRQ2V:			lda	IRQ_COPY_A			; get back original value of A
			rti					; and return to calling routine


;*************************************************************************
;*									 *
;*	 OSBYTE 17 Start conversion					 *
;*									 *
;*************************************************************************

_OSBYTE_17:		sty	ADC_CHAN_FLAG			; set last channel to finish conversion
_LDE8F:			cpx	#$05				; if X<4 then
			bcc	_BDE95				; DE95
			ldx	#$04				; else X=4

_BDE95:			stx	OSB_ADC_CHAN			; store it as current ADC channel
			ldy	OSB_ADC_ACC			; get conversion type
			dey					; decrement
			tya					; A=Y
			and	#$08				; and it with 08
			clc					; clear carry
			adc	OSB_ADC_CHAN			; add to current ADC
			sbc	#$00				; -1
			sta	ADC_SR				; store to the A/D control panel
			rts					; and return

_PRINT_PAGEC3_STRING:	lda	#$c3				; point to start of string @&C300
_PRINT_PAGE_STRING:	sta	ERR_MSG_PTR_HI			; store it
			lda	#$00				; point to lo byte
			sta	ERR_MSG_PTR			; store it and start loop@

_LDEB1:			iny					; print character in string
			lda	(ERR_MSG_PTR),Y			; pointed to by &FD/E
			jsr	OSASCI				; print it expanding Carriage returns
			tax					; store A in X
			bne	_LDEB1				; and loop again if not =0
			rts					; else exit

;*********** OSBYTE 129 TIMED ROUTINE ******************************
;ON ENTRY TIME IS IN X,Y

_LDEBB:			stx	INKEY_TIMER			; store time in INKEY countdown timer
			sty	INKEY_TIMER_HI			; which is decremented every 10ms
			lda	#$ff				; A=&FF to flag timed wait
			bne	_BDEC7				; goto DEC7


;**************************************************************************
;**************************************************************************
;**									 **
;**	 OSRDCH Default entry point					 **
;**									 **
;**	 RDCHV entry point	 read a character			 **
;**									 **
;**************************************************************************
;**************************************************************************

_NVRDCH:		lda	#$00				; A=0 to flag wait forever

_BDEC7:			sta	MOS_WS				; store entry value of A
			txa					; save X and Y
			pha					; 
			tya					; 
			pha					; 
			ldy	OSB_EXEC_HND			; get *EXEC file handle
			beq	_BDEE6				; if 0 (not open) then DEE6
			sec					; set carry
			ror	CRFS_ACTIVE			; set bit 7 of CFS active flag to prevent clashes
			jsr	OSBGET				; get a byte from the file
			php					; push processor flags to preserve carry
			lsr	CRFS_ACTIVE			; restore &EB
			plp					; get back flags
			bcc	_BDF03				; and if carry clear, character found so exit via DF03
			lda	#$00				; else A=00 as EXEC file empty
			sta	OSB_EXEC_HND			; store it in exec file handle
			jsr	OSFIND				; and close file via OSFIND

_BDEE6:			bit	ESCAPE_FLAG			; check ESCAPE flag, if bit 7 set Escape pressed
			bmi	_BDF00				; so off to DF00
			ldx	OSB_IN_STREAM			; else get current input buffer number
			jsr	_LE577				; get a byte from input buffer
			bcc	_BDF03				; and exit if character returned

			bit	MOS_WS				; (E6=0 or FF)
			bvc	_BDEE6				; if entry was OSRDCH not timed keypress, so go back and
								; do it again i.e. perform GET function
			lda	INKEY_TIMER			; else check timers
			ora	INKEY_TIMER_HI			; 
			bne	_BDEE6				; and if not zero go round again
			bcs	_BDF05				; else exit

_BDF00:			sec					
			lda	#$1b				
_BDF03:			sta	MOS_WS				
_BDF05:			pla					
			tay					
			pla					
			tax					
			lda	MOS_WS				
			rts					


;**** STRINGS ****

			.org	$df0c

_MSG_COPYSYM:		.byte	")C(",0				; Copyright string match

;**** COMMMANDS ****
;				  Command    Address	   Call goes to
_OSCLI_TABLE:		.byte	".",$e0,$31,$05			; *.	    &E031, A=5	   FSCV, XY=>String
			.byte	"FX",$e3,$42,$ff		; *FX	    &E342, A=&FF   Number parameters
			.byte	"BASIC",$e0,$18,$00		; *BASIC    &E018, A=0	   XY=>String
			.byte	"CAT",$e0,$31,$05		; *CAT	    &E031, A=5	   FSCV, XY=>String
			.byte	"CODE",$e3,$48,$88		; *CODE	    &E348, A=&88   OSBYTE &88
			.byte	"EXEC",$f6,$8d,$00		; *EXEC	    &F68D, A=0	   XY=>String
			.byte	"HELP",$f0,$b9,$ff		; *HELP	    &F0B9, A=&FF   F2/3=>String
			.byte	"KEY",$e3,$27,$ff		; *KEY	    &E327, A=&FF   F2/3=>String
			.byte	"LOAD",$e2,$3c,$00		; *LOAD	    &E23C, A=0	   XY=>String
			.byte	"LINE",$e6,$59,$01		; *LINE	    &E659, A=1	   USERV, XY=>String
			.byte	"MOTOR",$e3,$48,$89		; *MOTOR    &E348, A=&89   OSBYTE
			.byte	"OPT",$e3,$48,$8b		; *OPT	    &E348, A=&8B   OSBYTE
			.byte	"RUN",$e0,$31,$04		; *RUN	    &E031, A=4	   FSCV, XY=>String
			.byte	"ROM",$e3,$48,$8d		; *ROM	    &E348, A=&8D   OSBYTE
			.byte	"SAVE",$e2,$3e,$00		; *SAVE	    &E23E, A=0	   XY=>String
			.byte	"SPOOL",$e2,$81,$00		; *SPOOL    &E281, A=0	   XY=>String
			.byte	"TAPE",$e3,$48,$8c		; *TAPE	    &E348, A=&8C   OSBYTE
			.byte	"TV",$e3,$48,$90		; *TV	    &E348, A=&90   OSBYTE
			.byte	"",$e0,$31,$03			; Unmatched &E031, A=3	   FSCV, XY=>String
			.byte	$00				; Table end marker

; Command routines are entered with XY=>command tail, A=table parameter,
; &F2/3,&E6=>start of command string
; If table parameter if <&80, F2/3,Y converted to XY before entering


;*************************************************************************
;*   CLI - COMMAND LINE INTERPRETER					 *
;*									 *
;*   ENTRY: XY=>Command line						 *
;*   EXIT:  All registers corrupted					 *
;*   [ A=13 - unterminated string ]					 *
;*************************************************************************

_CLIV:			stx	TEXT_PTR			; Store XY in &F2/3
			sty	TEXT_PTR_HI			
			lda	#$08				
			jsr	_OSCLI_FSCV			; Inform filing system CLI being processed
			ldy	#$00				; Check the line is correctly terminated
__cliv_not_newline:	lda	(TEXT_PTR),Y			
			cmp	#$0d				; Loop until CR is found
			beq	_BDF9E				
			iny					; Move to next character
			bne	__cliv_not_newline		; Loop back if less than 256 bytes long
			rts					; Exit if string > 255 characters

; String is terminated - skip prepended spaces and '*'s
_BDF9E:			ldy	#$ff				
_BDFA0:			jsr	_SKIP_SPACES_NXT		; Skip any spaces
			beq	__get_text_ptr_done		; Exit if at CR
			cmp	#$2a				; Is this character '*'?
			beq	_BDFA0				; Loop back to skip it, and check for spaces again

			jsr	_SKIP_SPACE			; Skip any more spaces
			beq	__get_text_ptr_done		; Exit if at CR
			cmp	#$7c				; Is it '|' - a comment
			beq	__get_text_ptr_done		; Exit if so
			cmp	#$2f				; Is it '/' - pass straight to filing system
			bne	__cliv_not_slash		; Jump forward if not
			iny					; Move past the '/'
			jsr	_LE009				; Convert &F2/3,Y->XY, ignore returned A
			lda	#$02				; 2=RunSlashCommand
			bne	_OSCLI_FSCV			; Jump to pass to FSCV

; Look command up in command table
__cliv_not_slash:	sty	MOS_WS				; Store offset to start of command
			ldx	#$00				
			beq	_BDFD7				

_BDFC4:			eor	_OSCLI_TABLE,X			
			and	#$df				
			bne	_BDFE2				
			iny					
			clc					

_BDFCD:			bcs	_BDFF4				
			inx					
			lda	(TEXT_PTR),Y			
			jsr	_LE4E3				
			bcc	_BDFC4				

_BDFD7:			lda	_OSCLI_TABLE,X			
			bmi	_BDFF2				
			lda	(TEXT_PTR),Y			
			cmp	#$2e				
			beq	_BDFE6				
_BDFE2:			clc					
			ldy	MOS_WS				
			dey					
_BDFE6:			iny					
			inx					
_BDFE8:			inx					
			lda	_MSG_COPYSYM + 2,X		
			beq	__nobasic			
			bpl	_BDFE8				
			bmi	_BDFCD				

_BDFF2:			inx					
			inx					

_BDFF4:			dex					
			dex					
			pha					
			lda	_MSG_COPYSYM + 5,X		
			pha					
			jsr	_SKIP_SPACE			
			clc					
			php					
			jsr	_LE004				
			rti					; Jump to routine

_LE004:			lda	_OSCLI_TABLE + 2,X		; Get table parameter
			bmi	__get_text_ptr_done		; If >=&80, number follow
;		       ; else string follows

_LE009:			tya					; Pass Y line offset to A for later
			ldy	_OSCLI_TABLE + 2,X		; Get looked-up parameter from table

; Convert &F2/3,A to XY, put Y in A
_GET_TEXT_PTR:		clc					
			adc	TEXT_PTR			
			tax					
			tya					; Pass supplied Y into A
			ldy	TEXT_PTR_HI			
			bcc	__get_text_ptr_done		
			iny					

__get_text_ptr_done:	rts					


; *BASIC
; ======
_OSCLI_BASIC:		ldx	OSB_BASIC_ROM			; Get BASIC ROM number
			bmi	__nobasic			; If none set, jump to pass command on
			sec					; Set Carry = not entering from RESET
			jmp	_OSBYTE_142			; Enter language rom in X

; Pass command on to other ROMs and to filing system
__nobasic:		ldy	MOS_WS				; Restore pointer to start of command
			ldx	#$04				; 4=UnknownCommand
			jsr	_OSBYTE_143			; Pass to sideways ROMs
			beq	__get_text_ptr_done		; If claimed, exit
			lda	MOS_WS				; Restore pointer to start of command
			jsr	_GET_TEXT_PTR			; Convert &F2/3,A to XY, ignore returned A
			lda	#$03				; 3=PassCommandToFilingSystem

; Pass to current filing system
_OSCLI_FSCV:		jmp	(VEC_FSCV)			

_OSBYTE_139:		asl	A				
_OSBYTE_127:		and	#$01				
			bpl	_OSCLI_FSCV			

; Skip spaces
_SKIP_SPACES_NXT:	iny					
_SKIP_SPACE:		lda	(TEXT_PTR),Y			
			cmp	#$20				
			beq	_SKIP_SPACES_NXT		
__compare_newline:	cmp	#$0d				
			rts					

_LE043:			bcc	_SKIP_SPACE			
_SKIP_COMMA:		jsr	_SKIP_SPACE			
			cmp	#$2c				
			bne	__compare_newline		
			iny					
			rts					

_LE04E:			jsr	_SKIP_SPACE			
			jsr	_CHECK_FOR_DIGIT		
			bcc	__not_digit			
_BE056:			sta	MOS_WS				
			jsr	_CHECK_FOR_DIGIT_NXT		
			bcc	_BE076				
			tax					
			lda	MOS_WS				
			asl	A				
			bcs	__not_digit			
			asl	A				
			bcs	__not_digit			
			adc	MOS_WS				
			bcs	__not_digit			
			asl	A				
			bcs	__not_digit			
			sta	MOS_WS				
			txa					
			adc	MOS_WS				
			bcs	__not_digit			
			bcc	_BE056				
_BE076:			ldx	MOS_WS				
			cmp	#$0d				
			sec					
			rts					

_CHECK_FOR_DIGIT_NXT:	iny					
_CHECK_FOR_DIGIT:	lda	(TEXT_PTR),Y			
			cmp	#$3a				
			bcs	__not_digit			
			cmp	#$30				
			bcc	__not_digit			
			and	#$0f				
			rts					

__next_field:		jsr	_SKIP_COMMA			
__not_digit:		clc					
			rts					

_CHECK_FOR_HEX:		jsr	_CHECK_FOR_DIGIT		
			bcs	__check_hex_done		
			and	#$df				
			cmp	#$47				
			bcs	__next_field			
			cmp	#$41				
			bcc	__next_field			
			php					
			sbc	#$37				
			plp					
__check_hex_done:	iny					
			rts					

; WRCH control routine
; ====================
_NVWRCH:		pha					; Save all registers
			txa					
			pha					
			tya					
			pha					
			tsx					
			lda	STACK+3,X			; Get A back from stack
			pha					; Save A
			bit	OSB_OSWRCH_INT			; Check OSWRCH interception flag
			bpl	__no_intercept			; Not set, skip interception call
			tay					; Pass character to Y
			lda	#$04				; A=4 for OSWRCH call
			jsr	_NETV				; Call interception code
			bcs	_BE10D				; If claimed, jump past to exit

__no_intercept:		clc					; Prepare to not send this to printer
			lda	#$02				; Check output destination
			bit	OSB_OUT_STREAM			; Is VDU driver disabled?
			bne	_BE0C8				; Yes, skip past VDU driver
			pla					; Get character back
			pha					; Resave character
			jsr	_VDUCHR				; Call VDU driver
								; On exit, C=1 if character to be sent to printer

_BE0C8:			lda	#$08				; Check output destination
			bit	OSB_OUT_STREAM			; Is printer seperately enabled?
			bne	_BE0D1				; Yes, jump to call printer driver
			bcc	_BE0D6				; Carry clear, don't sent to printer
_BE0D1:			pla					; Get character back
			pha					; Resave character
			jsr	_PRINTER_OUT			; Call printer driver

_BE0D6:			lda	OSB_OUT_STREAM			; Check output destination
			ror	A				; Is serial output enabled?
			bcc	_BE0F7				; No, skip past serial output
			ldy	RS423_TIMEOUT			; Get serial timout counter
			dey					; Decrease counter
			bpl	_BE0F7				; Timed out, skip past serial code
			pla					; Get character back
			pha					; Resave character
			php					; Save IRQs
			sei					; Disable IRQs
			ldx	#$02				; X=2 for serial output buffer
			pha					; Save character
			jsr	_OSBYTE_152			; Examine serial output buffer
			bcc	_BE0F0				; Buffer not full, jump to send character
			jsr	_LE170				; Wait for buffer to empty a bit
_BE0F0:			pla					; Get character back
			ldx	#$02				; X=2 for serial output buffer
			jsr	_BUFFER_SAVE			; Send character to serial output buffer
			plp					; Restore IRQs

_BE0F7:			lda	#$10				; Check output destination
			bit	OSB_OUT_STREAM			; Is SPOOL output disabled?
			bne	_BE10D				; Yes, skip past SPOOL output
			ldy	OSB_SPOOL_HND			; Get SPOOL handle
			beq	_BE10D				; If not open, skip past SPOOL output
			pla					; Get character back
			pha					; Resave character
			sec					
			ror	CRFS_ACTIVE			; Set RFS/CFS's 'spooling' flag
			jsr	OSBPUT				; Write character to SPOOL channel
			lsr	CRFS_ACTIVE			; Reset RFS/CFS's 'spooling' flag

_BE10D:			pla					; Restore all registers
			pla					
			tay					
			pla					
			tax					
			pla					
			rts					; Exit


;*************************************************************************
;*									 *
;*	 PRINTER DRIVER							 *
;*									 *
;*************************************************************************

;A=character to print

_PRINTER_OUT:		bit	OSB_OUT_STREAM			; if bit 6 of VDU byte =1 printer is disabled
			bvs	__printer_out_done		; so E139

			cmp	OSB_PRINT_IGN			; compare with printer ignore character
			beq	__printer_out_done		; if the same E139

_PRINTER_OUT_ALWAYS:	php					; else save flags
			sei					; bar interrupts
			tax					; X=A
			lda	#$04				; A=4
			bit	OSB_OUT_STREAM			; read bit 2 'disable printer driver'
			bne	__printer_out_done_plp		; if set printer is disabled so exit E138
			txa					; else A=X
			ldx	#$03				; X=3
			jsr	_BUFFER_SAVE			; and put character in printer buffer
			bcs	__printer_out_done_plp		; if carry set on return exit, buffer not full (empty?)

			bit	BUFFER_3_BUSY			; else check buffer busy flag if 0
			bpl	__printer_out_done_plp		; then E138 to exit
			jsr	_LE13A				; else E13A to open printer cahnnel

__printer_out_done_plp: plp					; get back flags
__printer_out_done:	rts					; and exit

_LE13A:			lda	OSB_PRINT_DEST			; check printer destination
			beq	_LE1AD				; if 0 then E1AD clear printer buffer and exit
			cmp	#$01				; if parallel printer not selected
			bne	_BE164				; E164
			jsr	_OSBYTE_145			; else read a byte from the printer buffer
			ror	BUFFER_3_BUSY			; if carry is set then 2d2 is -ve
			bmi	_BE190				; so return via E190
			ldy	#$82				; else enable interrupt 1 of the external VIA
			sty	USR_VIA_IER			; 
			sta	USR_VIA_IORA			; pass code to centronics port
			lda	USR_VIA_PCR			; pulse CA2 line to generate STROBE signal
			and	#$f1				; to advise printer that
			ora	#$0c				; valid data is
			sta	USR_VIA_PCR			; waiting
			ora	#$0e				; 
			sta	USR_VIA_PCR			; 
			bne	_BE190				; then exit

;*********:serial printer *********************************************

_BE164:			cmp	#$02				; is it Serial printer??
			bne	_BE191				; if not E191
			ldy	RS423_TIMEOUT			; else is RS423 in use by cassette??
			dey					; 
			bpl	_LE1AD				; if so E1AD to flush buffer

			lsr	BUFFER_3_BUSY			; else clear buffer busy flag
_LE170:			lsr	OSB_RS423_USE			; and RS423 busy flag
_LE173:			jsr	_LE741				; count buffer if C is clear on return
			bcc	_BE190				; no room in buffer so exit
			ldx	#$20				; else
_LE17A:			ldy	#$9f				; 


;*************************************************************************
;*									 *
;*	 OSBYTE 156 update ACIA setting and RAM copy			 *
;*									 *
;*************************************************************************
;on entry

_OSBYTE_156:		php					; push flags
			sei					; bar interrupts
			tya					; A=Y
			stx	MOS_WS_0			; &FA=X
			and	OSB_RS423_CTL			; A=old value AND Y EOR X
			eor	MOS_WS_0			; 
			ldx	OSB_RS423_CTL			; get old value in X
_LE189:			sta	OSB_RS423_CTL			; put new value in
			sta	ACIA_CSR			; and store to ACIA control register
			plp					; get back flags
_BE190:			rts					; and exit

;************ printer is neither serial or parallel so its user type *****

_BE191:			clc					; clear carry
			lda	#$01				; A=1
			jsr	_LE1A2				; 


;*************************************************************************
;*									 *
;*	 OSBYTE 123 Warn printer driver going dormant			 *
;*									 *
;*************************************************************************

_OSBYTE_123:		ror	BUFFER_3_BUSY			; mark printer buffer empty for osbyte
_BE19A:			rts					; and exit

_LE19B:			bit	BUFFER_3_BUSY			; if bit 7 is set buffer is empty
			bmi	_BE19A				; so exit

			lda	#$00				; else A=0

_LE1A2:			ldx	#$03				; X=3
_LE1A4:			ldy	OSB_PRINT_DEST			; Y=printer destination
			jsr	_NETV				; to JMP (NETV)
			jmp	(VEC_UPTV)			; jump to PRINT VECTOR for special routines

;*************** Buffer handling *****************************************
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

_LE1AD:			clc					; clear carry
_LE1AE:			pha					; save A
			php					; save flags
			sei					; set interrupts
			bcs	_BE1BB				; if carry set on entry then E1BB
			lda	_BAUD_TABLE,X			; else get byte from baud rate/sound data table
			bpl	_BE1BB				; if +ve the E1BB
			jsr	_LECA2				; else clear sound data

_BE1BB:			sec					; set carry
			ror	BUFFER_0_BUSY,X			; rotate buffer flag to show buffer empty
			cpx	#$02				; if X>1 then its not an input buffer
			bcs	_BE1CB				; so E1CB

			lda	#$00				; else Input buffer so A=0
			sta	OSB_SOFT_KEYLEN			; store as length of key string
			sta	OSB_VDU_QSIZE			; and length of VDU queque
_BE1CB:			jsr	_LE73B				; then enter via count purge vector any user routines
			plp					; restore flags
			pla					; restore A
			rts					; and exit


;*************************************************************************
;*									 *
;*	 COUNT PURGE VECTOR	 DEFAULT ENTRY				 *
;*									 *
;*************************************************************************
;on entry if V set clear buffer
;	  if C set get space left
;	  else get bytes used

_CNPV:			bvc	_BE1DA				; if bit 6 is set then E1DA
			lda	BUFFER_0_OUT,X			; else start of buffer=end of buffer
			sta	BUFFER_0_IN,X			; 
			rts					; and exit

_BE1DA:			php					; push flags
			sei					; bar interrupts
			php					; push flags
			sec					; set carry
			lda	BUFFER_0_IN,X			; get end of buffer
			sbc	BUFFER_0_OUT,X			; subtract start of buffer
			bcs	_BE1EA				; if carry caused E1EA
			sec					; set carry
			sbc	_BUFFER_OFFSET_TABLE,X		; subtract buffer start offset (i.e. add buffer length)
_BE1EA:			plp					; pull flags
			bcc	_BE1F3				; if carry clear E1F3 to exit
			clc					; clear carry
			adc	_BUFFER_OFFSET_TABLE,X		; adc to get bytes used
			eor	#$ff				; and invert to get space left
_BE1F3:			ldy	#$00				; Y=0
			tax					; X=A
			plp					; get back flags
			rts					; and exit

;********** enter byte in buffer, wait and flash lights if full **********

_BUFFER_SAVE:		sei					; prevent interrupts
			jsr	_INSV				; enter a byte in buffer X
			bcc	__buffer_save_done		; if successful exit
			jsr	_SET_LEDS_TEST_ESCAPE		; else switch on both keyboard lights
			php					; push p
			pha					; push A
			jsr	_SET_LEDS			; switch off unselected LEDs
			pla					; get back A
			plp					; and flags
			bmi	__buffer_save_done		; if return is -ve Escape pressed so exit
			cli					; else allow interrupts
			bcs	_BUFFER_SAVE			; if byte didn't enter buffer go and try it again
__buffer_save_done:	rts					; then return

; OS SERIES VI
; GEOFF COX

;*************************************************************************
;*									 *
;*	 *SAVE/*LOAD SETUP						 *
;*									 *
;*************************************************************************

;**************: clear osfile control block workspace ********************

			.org	$e20e

_CLEAR_OSFILE_CB:	pha					; push A
			lda	#$00				; A=0
			sta	OSFILE_CB,X			; clear osfile control block workspace
			sta	OSFILE_CB_1,X			; 
			sta	OSFILE_CB_2,X			; 
			sta	OSFILE_CB_3,X			; 
			pla					; get back A
			rts					; and exit

;*********** shift through osfile control block **************************

_LE21F:			sty	MOS_WS				; &E6=Y
			rol					; A=A*2
			rol					; *4
			rol					; *8
			rol					; *16
			ldy	#$04				; Y=4
_BE227:			rol					; A=A*32
			rol	OSFILE_CB,X			; shift bit 7 of A into shift register
			rol	OSFILE_CB_1,X			; and
			rol	OSFILE_CB_2,X			; shift
			rol	OSFILE_CB_3,X			; along
			bcs	_LE267				; if carry set on exit then register has overflowed
								; so bad address error
			dey					; decrement Y
			bne	_BE227				; and if Y>0 then do another shift
			ldy	MOS_WS				; get back original Y
			rts					; and exit


;*************************************************************************
;*									 *
;*	 *LOAD ENTRY							 *
;*									 *
;*************************************************************************

_OSCLI_LOAD:		lda	#$ff				; signal that load is being performed


;*************************************************************************
;*									 *
;*	 *SAVE ENTRY							 *
;*									 *
;*************************************************************************
;on entry A=0 for save &ff for load

_OSCLI_SAVE:		stx	TEXT_PTR			; store address of rest of command line
			sty	TEXT_PTR_HI			; 
			stx	OSFILE_CB			; x and Y are stored in OSfile control block
			sty	OSFILE_CB_1			; 
			pha					; Push A
			ldx	#$02				; X=2
			jsr	_CLEAR_OSFILE_CB		; clear the shift register
			ldy	#$ff				; Y=255
			sty	OSFILE_CB_6			; store im 2F4
			iny					; increment Y
			jsr	_LEA1D				; and call GSINIT to prepare for reading text line
_BE257:			jsr	_GSREAD				; read a code from text line if OK read next
			bcc	_BE257				; until end of line reached
			pla					; get back A without stack changes
			pha					; 
			beq	_BE2C2				; IF A=0 (SAVE)	 E2C2
			jsr	_LE2AD				; set up file block
			bcs	_BE2A0				; if carry set do OSFILE
			beq	_BE2A5				; else if A=0 goto OSFILE

_LE267:			brk					; 
			.byte	$fc				; 
			.byte	"Bad address"			; error
			brk					; 


;*************************************************************************
;*									 *
;*	 OSBYTE 119		ENTRY					 *
;*	 CLOSE SPOOL/ EXEC FILES					 *
;*									 *
;*************************************************************************

_OSBYTE_119:		ldx	#$10				; X=10 issue *SPOOL/EXEC files warning
			jsr	_OSBYTE_143			; and issue call
			beq	_BE29F				; if a rom accepts and issues a 0 then E29F to return
			jsr	_LF68B				; else close the current exec file
			lda	#$00				; A=0


;**************************************************************************
;*									  *
;*	*SPOOL								  *
;*									  *
;**************************************************************************

_OSCLI_SPOOL:		php					; if A=0 file is closed so
			sty	MOS_WS				; Store Y
			ldy	OSB_SPOOL_HND			; get file handle
			sta	OSB_SPOOL_HND			; store A as file handle
			beq	_BE28F				; if Y<>0 then E28F
			jsr	OSFIND				; else close file via osfind
_BE28F:			ldy	MOS_WS				; get back original Y
			plp					; pull flags
			beq	_BE29F				; if A=0 on entry then exit
			lda	#$80				; else A=&80
			jsr	OSFIND				; to open file Y for output
			tay					; Y=A
			beq	_USERV				; and if this is =0 then E310 BAD COMMAND ERROR
			sta	OSB_SPOOL_HND			; store file handle
_BE29F:			rts					; and exit

_BE2A0:			bne	_USERV				; if NE then BAD COMMAND error
			inc	OSFILE_CB_6			; increment 2F4 to 00
_BE2A5:			ldx	#$ee				; X=&EE
			ldy	#$02				; Y=&02
			pla					; get back A
			jmp	OSFILE				; and JUMP to OSFILE

;**** check for hex digit ************************************************

_LE2AD:			jsr	_SKIP_SPACE			; look for NEWline
			jsr	_CHECK_FOR_HEX			; carry is set if it finds hex digit
			bcc	_BE2C1				; so E2C1 exit
			jsr	_CLEAR_OSFILE_CB		; clear shift register

;************** shift byte into control block ***************************

_BE2B8:			jsr	_LE21F				; shift lower nybble of A into shift register
			jsr	_CHECK_FOR_HEX			; then check for Hex digit
			bcs	_BE2B8				; if found then do it again
			sec					; else set carry
_BE2C1:			rts					; and exit

;**************; set up OSfile control block ****************************

_BE2C2:			ldx	#$0a				; X=0A
			jsr	_LE2AD				; 
			bcc	_USERV				; if no hex digit found EXIT via BAD Command error
			clv					; clear bit 6

;******************READ file length from text line************************

			lda	(TEXT_PTR),Y			; read next byte from text line
			cmp	#$2b				; is it '+'
			bne	_BE2D4				; if not assume its a last byte address so e2d4
			bit	_BD9B7				; else set V and M flags
			iny					; increment Y to point to hex group

_BE2D4:			ldx	#$0e				; X=E
			jsr	_LE2AD				; 
			bcc	_USERV				; if carry clear no hex digit so exit via error
			php					; save flags
			bvc	_BE2ED				; if V set them E2ED explicit end address found
			ldx	#$fc				; else X=&FC
			clc					; clear carry
_BE2E1:			lda	$01fc,X				; and add length data to start address
			adc	VEC_USERV,X			; 
			sta	VEC_USERV,X			; 
			inx					; 
			bne	_BE2E1				; repeat until X=0

_BE2ED:			ldx	#$03				; X=3
_BE2EF:			lda	OSFILE_CB_10,X			; copy start adddress to load and execution addresses
			sta	OSFILE_CB_6,X			; 
			sta	OSFILE_CB_2,X			; 
			dex					; 
			bpl	_BE2EF				; 
			plp					; get back flag
			beq	_BE2A5				; if end of command line reached then E2A5
								; to do osfile
			ldx	#$06				; else set up execution address
			jsr	_LE2AD				; 
			bcc	_USERV				; if error BAD COMMAND
			beq	_BE2A5				; and if end of line reached do OSFILE

			ldx	#$02				; else set up load address
			jsr	_LE2AD				; 
			bcc	_USERV				; if error BAD command
			beq	_BE2A5				; else on end of line do OSFILE
								; anything else is an error!!!!

;******** Bad command error ************************************

_USERV:			brk					; 
			.byte	$fe				; error number
			.byte	"Bad command"			; 
_BE31D:			brk					
			.byte	$fb				; 
			.byte	"Bad key"			; 
			brk					


;*************************************************************************
;*									 *
;*	 *KEY ENTRY							 *
;*									 *
;*************************************************************************

_OSCLI_KEY:		jsr	_LE04E				; set up key number in A
			bcc	_BE31D				; if not valid number give error
			cpx	#$10				; if key number greater than 15
			bcs	_BE31D				; if greater then give error
			jsr	_SKIP_COMMA			; otherwise skip commas, and check for CR
			php					; save flags for later
			ldx	$0b10				; get pointer to top of existing key strings
			tya					; save Y
			pha					; to preserve text pointer
			jsr	_LE3D1				; set up soft key definition
			pla					; get back Y
			tay					; 
			plp					; and flags
			bne	_BE377				; if CR found return else E377 to set up new string
			rts					; else return to set null string


;*************************************************************************
;*									 *
;*	 *FX   OSBYTE							 *
;*									 *
;*************************************************************************
;	A=number

_OSCLI_FX:		jsr	_LE04E				; convert the number to binary
			bcc	_USERV				; if bad number call bad command
			txa					; save X


;*************************************************************************
;*									 *
;*	 *CODE	 *MOTOR	  *OPT	 *ROM	*TAPE	*TV			 *
;*									 *
;*************************************************************************
				; enter codes	 *CODE	 &88
;			*MOTOR	&89
;			*OPT	&8B
;			*TAPE	&8C
;			*ROM	&8D
;			*TV	&90

_OSCLI_OSBYTE:		pha					; save A
			lda	#$00				; clear &E4/E5
			sta	OSBYTE_PAR_2			; 
			sta	OSBYTE_PAR_3			; 
			jsr	_LE043				; skip commas and check for newline (CR)
			beq	_BE36C				; if CR found E36C
			jsr	_LE04E				; convert character to binary
			bcc	_USERV				; if bad character bad command error
			stx	OSBYTE_PAR_2			; else save it
			jsr	_SKIP_COMMA			; skip comma and check CR
			beq	_BE36C				; if CR then E36C
			jsr	_LE04E				; get another parameter
			bcc	_USERV				; if bad error
			stx	OSBYTE_PAR_3			; else store in E4
			jsr	_SKIP_SPACE			; now we must have a newline
			bne	_USERV				; if none then output an error

_BE36C:			ldy	OSBYTE_PAR_3			; Y=third osbyte parameter
			ldx	OSBYTE_PAR_2			; X=2nd
			pla					; A=first
			jsr	OSBYTE				; call osbyte
			bvs	_USERV				; if V set on return then error
			rts					; else RETURN

;********* *KEY CONTINUED ************************************************
				; X points to last byte of current key definitions
_BE377:			sec					; 
			jsr	_GSINIT				; look for '"' on return bit 6 E4=1 bit 7=1 if '"'found
								; this is a GSINIT call without initial CLC
_BE37B:			jsr	_GSREAD				; call GSREAD carry is set if end of line found
			bcs	_BE388				; E388 to deal with end of line
			inx					; point to first byte of new key definition
			beq	_BE31D				; if X=0 buffer WILL overflow so exit with BAD KEY error
			sta	SOFTKEYS,X			; store character
			bcc	_BE37B				; and loop to get next byte if end of line not found
_BE388:			bne	_BE31D				; if Z clear then no matching '"' found or for some
								; other reason line doesn't terminate properly
			php					; else if all OK save flags
			sei					; bar interrupts
			jsr	_LE3D1				; and move string

			ldx	#$10				; set loop counter

_BE391:			cpx	MOS_WS				; if key being defined is found
			beq	_BE3A3				; then skip rest of loop
			lda	SOFTKEYS,X			; else get start of string X
			cmp	SOFTKEYS,Y			; compare with start of string Y
			bne	_BE3A3				; if not the same then skip rest of loop
			lda	$0b10				; else store top of string definition
			sta	SOFTKEYS,X			; in designated key pointer
_BE3A3:			dex					; decrement loop pointer X
			bpl	_BE391				; and do it all again
			plp					; get back flags
			rts					; and exit

;***********: set string lengths *****************************************

_LE3A8:			php					; push flags
			sei					; bar interrupts
			lda	$0b10				; get top of currently defined strings
			sec					; 
			sbc	SOFTKEYS,Y			; subtract to get the number of bytes in strings
								; above end of string Y
			sta	MOS_WS_1			; store this
			txa					; save X
			pha					; 
			ldx	#$10				; and X=16

_BE3B7:			lda	SOFTKEYS,X			; get start offset (from B00) of key string X
			sec					; 
			sbc	SOFTKEYS,Y			; subtract offset of string we are working on
			bcc	_BE3C8				; if carry clear (B00+Y>B00+X) or
			beq	_BE3C8				; result (in A)=0
			cmp	MOS_WS_1			; or greater or equal to number of bytes above
								; string we are working on
			bcs	_BE3C8				; then E3C8
			sta	MOS_WS_1			; else store A in &FB

_BE3C8:			dex					; point to next lower key offset
			bpl	_BE3B7				; and if 0 or +ve go back and do it again
			pla					; else get back value of X
			tax					; 
			lda	MOS_WS_1			; get back latest value of A
			plp					; pull flags
			rts					; and return

;***********: set up soft key definition *********************************

_LE3D1:			php					; push P
			sei					; bar interrupts
			txa					; save X
			pha					; push A
			ldy	MOS_WS				; get key number

			jsr	_LE3A8				; and set up &FB
			lda	SOFTKEYS,Y			; get start of string
			tay					; put it in Y
			clc					; clear carry
			adc	MOS_WS_1			; add number of bytes above string
			tax					; put this in X
			sta	MOS_WS_0			; and store it
			lda	OSB_SOFT_KEYLEN			; check number of bytes left to remove from key buffer
								; if not 0 key is being used (definition expanded so
								; error.  This stops *KEY 1 "*key1 FRED" etc.
			beq	_BE3F6				; if not in use continue

			brk					; 
			.byte	$fa				; error number
			.byte	"Key in use"			; 
			brk					; 

_BE3F6:			dec	OSB_SOFTKEY_FLG			; decrement consistence flag to &FF to warn that key
								; definitions are being changed
			pla					; pull A
			sec					; 
			sbc	MOS_WS_0			; subtract &FA
			sta	MOS_WS_0			; and re store it
			beq	_BE40D				; if 0 then E40D

_BE401:			lda	$0b01,X				; else move string
			sta	$0b01,Y				; from X to Y
			iny					; 
			inx					; 
			dec	MOS_WS_0			; for length of string
			bne	_BE401				; 

_BE40D:			tya					; store end of moved string(s)
			pha					; 
			ldy	MOS_WS				; get back key number
			ldx	#$10				; point at top of last string

_BE413:			lda	SOFTKEYS,X			; get this value
			cmp	SOFTKEYS,Y			; compare it with start of new or re defined key
			bcc	_BE422				; if less then E422
			beq	_BE422				; if = then E422
			sbc	MOS_WS_1			; shift key definitions accordingly
			sta	SOFTKEYS,X			; 
_BE422:			dex					; point to next lowest string def
			bpl	_BE413				; and if =>0 then loop and do it again
			lda	$0b10				; else make top of key definitions
			sta	SOFTKEYS,Y			; the start of our key def
			pla					; get new end of strings
			sta	$0b10				; and store it
			tax					; put A in X
			inc	OSB_SOFTKEY_FLG			; reset consistency flag
			plp					; restore flags
			rts					; and exit


;**************** BUFFER ADDRESS HI LOOK UP TABLE ************************
			.org	$e435

_BUFFER_HI_TABLE:	.byte	$03				; keyboard
			.byte	$0a				; rs423 input
			.byte	$08				; rs423 output
			.byte	$07				; printer
			.byte	$07				; sound 0
			.byte	$07				; sound 1
			.byte	$07				; sound 2
			.byte	$07				; sound 3
			.byte	$09				; speech

;**************** BUFFER ADDRESS LO LOOK UP TABLE ************************
_BUFFER_LO_TABLE:	.byte	$00				
			.byte	$00				
			.byte	$c0				
			.byte	$c0				
			.byte	$50				
			.byte	$60				
			.byte	$70				
			.byte	$80				
			.byte	$00				

;**************** BUFFER START ADDRESS OFFSET ****************************
_BUFFER_OFFSET_TABLE:	.byte	$e0				
			.byte	$00				
			.byte	$40				
			.byte	$c0				
			.byte	$f0				
			.byte	$f0				
			.byte	$f0				
			.byte	$f0				
			.byte	$c0				

;*******: get nominal buffer addresses in &FA/B **************************

				; ON ENTRY X=buffer number
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

_GET_BUFFER_ADDRESS:	lda	_BUFFER_LO_TABLE,X		; get buffer base address lo
			sta	MOS_WS_0			; store it
			lda	_BUFFER_HI_TABLE,X		; get buffer base address hi
			sta	MOS_WS_1			; store it
			rts					; exit


;*************************************************************************
;*									 *
;*	 OSBYTE 152 Examine Buffer status				 *
;*									 *
;*************************************************************************
;on entry X = buffer number
;on exit FA/B points to buffer start  Y is offset to next character
;if buffer is empty C=1, Y is preserved else C=0

_OSBYTE_152:		bit	_BD9B7				; set V and
			bvs	_BE461				; jump to E461


;*************************************************************************
;*									 *
;*	 OSBYTE 145 Get byte from Buffer				 *
;*									 *
;*************************************************************************
;on entry X = buffer number
; ON EXIT Y is character extracted
;if buffer is empty C=1, else C=0

_OSBYTE_145:		clv					; clear V

_BE461:			jmp	(VEC_REMV)			; Jump via REMV


;*************************************************************************
;*									 *
;*	 REMV buffer remove vector default entry point			 *
;*									 *
;*************************************************************************
;on entry X = buffer number
;on exit if buffer is empty C=1, Y is preserved else C=0

_REMVB:			php					; push flags
			sei					; bar interrupts
			lda	BUFFER_0_OUT,X			; get output pointer for buffer X
			cmp	BUFFER_0_IN,X			; compare to input pointer
			beq	_BE4E0				; if equal buffer is empty so E4E0 to exit
			tay					; else A=Y
			jsr	_GET_BUFFER_ADDRESS		; and get buffer pointer into FA/B
			lda	(MOS_WS_0),Y			; read byte from buffer
			bvs	_BE491				; if V is set (on input) exit with CARRY clear
								; Osbyte 152 has been done
			pha					; else must be osbyte 145 so save byte
			iny					; increment Y
			tya					; A=Y
			bne	_BE47E				; if end of buffer not reached <>0 E47E

			lda	_BUFFER_OFFSET_TABLE,X		; get pointer start from offset table

_BE47E:			sta	BUFFER_0_OUT,X			; set buffer output pointer
			cpx	#$02				; if buffer is input (0 or 1)
			bcc	_BE48F				; then E48F

			cmp	BUFFER_0_IN,X			; else for output buffers compare with buffer start
			bne	_BE48F				; if not the same buffer is not empty so E48F

			ldy	#$00				; buffer is empty so Y=0
			jsr	_OSEVEN				; and enter EVENT routine to signal EVENT 0 buffer
								; becoming empty

_BE48F:			pla					; get back byte from buffer
			tay					; put it in Y
_BE491:			plp					; get back flags
			clc					; clear carry to indicate success
			rts					; and exit


;**************************************************************************
;**************************************************************************
;**									 **
;**	 CAUSE AN EVENT							 **
;**									 **
;**************************************************************************
;**************************************************************************
;on entry Y=event number
;A and X may be significant Y=A, A=event no. when event generated @E4A1
;on exit carry clear indicates action has been taken else carry set

_OSEVEN:		php					; push flags
			sei					; bar interrupts
			pha					; push A
			sta	MOS_WS_0			; &FA=A
			lda	EVENT_ENABLE,Y			; get enable event flag
			beq	_BE4DF				; if 0 event is not enabled so exit
			tya					; else A=Y
			ldy	MOS_WS_0			; Y=A
			jsr	_LF0A5				; vector through &220
			pla					; get back A
			plp					; get back flags
			clc					; clear carry for success
			rts					; and exit

;********* check event 2 character entering buffer ***********************

_BE4A8:			tya					; A=Y
			ldy	#$02				; Y=2
			jsr	_OSEVEN				; check event
			tay					; Y=A


;*************************************************************************
;*									 *
;*	 OSBYTE 138 Put byte into Buffer				 *
;*									 *
;*************************************************************************
;on entry X is buffer number, Y is character to be written

_OSBYTE_138:		tya					; A=Y

_INSV:			jmp	(VEC_INSV)			; jump to INSBV


;*************************************************************************
;*									 *
;*	 INSBV insert character in buffer vector default entry point	 *
;*									 *
;*************************************************************************
;on entry X is buffer number, A is character to be written

_INSBV:			php					; save flags
			sei					; bar interrupts
			pha					; save A
			ldy	BUFFER_0_IN,X			; get buffer input pointer
			iny					; increment Y
			bne	_BE4BF				; if Y=0 then buffer is full else E4BF
			ldy	_BUFFER_OFFSET_TABLE,X		; get default buffer start

_BE4BF:			tya					; put it in A
			cmp	BUFFER_0_OUT,X			; compare it with input pointer
			beq	_BE4D4				; if equal buffer is full so E4D4
			ldy	BUFFER_0_IN,X			; else get buffer end in Y
			sta	BUFFER_0_IN,X			; and set it from A
			jsr	_GET_BUFFER_ADDRESS		; and point &FA/B at it
			pla					; get back byte
			sta	(MOS_WS_0),Y			; store it in buffer
			plp					; pull flags
			clc					; clear carry for success
			rts					; and exit

_BE4D4:			pla					; get back byte
			cpx	#$02				; if we are working on input buffer
			bcs	_BE4E0				; then E4E0

			ldy	#$01				; else Y=1
			jsr	_OSEVEN				; to service input buffer full event
			pha					; push A

;***** return with carry set *********************************************

_BE4DF:			pla					; restore A

_BE4E0:			plp					; restore flags
			sec					; set carry
			rts					; and exit


;***************** CODE MODIFIER ROUTINE *********************************
;*		   CHECK FOR ALPHA CHARACTER				 *
;*************************************************************************
				; ENTRY	 character in A
				; exit with carry set if non-Alpha character
_LE4E3:			pha					; Save A
			and	#$df				; convert lower to upper case
			cmp	#$41				; is it 'A' or greater ??
			bcc	_BE4EE				; if not exit routine with carry set
			cmp	#$5b				; is it less than 'Z'
			bcc	_BE4EF				; if so exit with carry clear
_BE4EE:			sec					; else clear carry
_BE4EF:			pla					; get back original value of A
			rts					; and Return

;*******: INSERT byte in Keyboard buffer *********************************

_LE4F1:			ldx	#$00				; X=0 to indicate keyboard buffer

;*************************************************************************
;*									 *
;*	 OSBYTE 153 Put byte in input Buffer checking for ESCAPE	 *
;*									 *
;*************************************************************************
;on entry X = buffer number (either 0 or 1)
;X=1 is RS423 input
;X=0 is Keyboard
;Y is character to be written

_OSBYTE_153:		txa					; A=buffer number
			and	OSB_RS423_MODE			; and with RS423 mode (0 treat as keyboard
								; 1 ignore Escapes no events no soft keys)
			bne	_OSBYTE_138			; so if RS423 buffer AND RS423 in normal mode (1) E4AF

			tya					; else Y=A character to write
			eor	OSB_ESCAPE			; compare with current escape ASCII code (0=match)
			ora	OSB_ESC_ACTION			; or with current ESCAPE status (0=ESC, 1=ASCII)
			bne	_BE4A8				; if ASCII or no match E4A8 to enter byte in buffer
			lda	OSB_ESC_BRK			; else get ESCAPE/BREAK action byte
			ror					; Rotate to get ESCAPE bit into carry
			tya					; get character back in A
			bcs	_BE513				; and if escape disabled exit with carry clear
			ldy	#$06				; else signal EVENT 6 Escape pressed
			jsr	_OSEVEN				; 
			bcc	_BE513				; if event handles ESCAPE then exit with carry clear
			jsr	_OSBYTE_125			; else set ESCAPE flag
_BE513:			clc					; clear carry
			rts					; and exit

;******** get a byte from keyboard buffer and interpret as necessary *****
;on entry A=cursor editing status 1=return &87-&8B,
;2= use cursor keys as soft keys 11-15
;this area not reached if cursor editing is normal

_BE515:			ror					; get bit 1 into carry
			pla					; get back A
			bcs	_BE592				; if carry is set return
								; else cursor keys are 'soft'
_BE519:			tya					; A=Y get back original key code (&80-&FF)
			pha					; PUSH A
			lsr					; get high nybble into lo
			lsr					; 
			lsr					; 
			lsr					; A=8-&F
			eor	#$04				; and invert bit 2
								; &8 becomes &C
								; &9 becomes &D
								; &A becomes &E
								; &B becomes &F
								; &C becomes &8
								; &D becomes &9
								; &E becomes &A
								; &F becomes &B

			tay					; Y=A = 8-F
			lda	OSB_BELL_FREQ,Y			; read 026D to 0274 code interpretation status
								; 0=ignore key, 1=expand as 'soft' key
								; 2-&FF add this to base for ASCII code
								; note that provision is made for keypad operation
								; as codes &C0-&FF cannot be generated from keyboard
								; but are recognised by OS
								;
			cmp	#$01				; is it 01
			beq	_BE594				; if so expand as 'soft' key via E594
			pla					; else get back original byte
			bcc	_BE539				; if above CMP generated Carry then code 0 must have
								; been returned so E539 to ignore
			and	#$0f				; else add ASCII to BASE key number so clear hi nybble
			clc					; clear carry
			adc	OSB_BELL_FREQ,Y			; add ASCII base
			clc					; clear carry
			rts					; and exit
								;
;*********** ERROR MADE IN USING EDIT FACILITY ***************************

_BE534:			jsr	_VDU_7				; produce bell
			pla					; get back A, buffer number
			tax					; X=buffer number

;********get byte from buffer ********************************************

_BE539:			jsr	_OSBYTE_145			; get byte from buffer X
			bcs	_BE593				; if buffer empty E593 to exit
			pha					; else Push byte
			cpx	#$01				; and if RS423 input buffer is not the one
			bne	_BE549				; then E549

			jsr	_LE173				; else oswrch
			ldx	#$01				; X=1 (RS423 input buffer)
			sec					; set carry

_BE549:			pla					; get back original byte
			bcc	_BE551				; if carry clear (I.E not RS423 input) E551
			ldy	OSB_RS423_MODE			; else Y=RS423 mode (0 treat as keyboard )
			bne	_BE592				; if not 0 ignore escapes etc. goto E592

_BE551:			tay					; Y=A
			bpl	_BE592				; if code is less that &80 its simple so E592
			and	#$0f				; else clear high nybble
			cmp	#$0b				; if less than 11 then treat as special code
			bcc	_BE519				; or function key and goto E519
			adc	#$7b				; else add &7C (&7B +C) to convert codes B-F to 7-B
			pha					; Push A
			lda	OSB_CURSOR_STAT			; get cursor editing status
			bne	_BE515				; if not 0 (normal) E515
			lda	OSB_OUT_STREAM			; else get character destination status

;Bit 0 enables	RS423 driver
;BIT 1 disables VDU driver
;Bit 2 disables printer driver
;BIT 3 enables	printer independent of CTRL B or CTRL C
;Bit 4 disables spooled output
;BIT 5 not used
;Bit 6 disables printer driver unless VDU 1 precedes character
;BIT 7 not used

			ror					; get bit 1 into carry
			ror					; 
			pla					; 
			bcs	_BE539				; if carry is set E539 screen disabled
			cmp	#$87				; else is it COPY key
			beq	_BE5A6				; if so E5A6

			tay					; else Y=A
			txa					; A=X
			pha					; Push X
			tya					; get back Y
			jsr	_LD8CE				; execute edit action

			pla					; restore X
			tax					; 
_LE577:			bit	OSB_OSRDCH_INT			; check econet RDCH flag
			bpl	_BE581				; if not set goto E581
			lda	#$06				; else Econet function 6
_NETV:			jmp	(VEC_NETV)			; to the Econet vector

;********* get byte from key string **************************************
;on entry 0268 contains key length
;and 02C9 key string pointer to next byte

_BE581:			lda	OSB_SOFT_KEYLEN			; get length of keystring
			beq	_BE539				; if 0 E539 get a character from the buffer
			ldy	SOFTKEY_EX_PTR			; get soft key expansion pointer
			lda	SOFTKEYS+1,Y			; get character from string
			inc	SOFTKEY_EX_PTR			; increment pointer
			dec	OSB_SOFT_KEYLEN			; decrement length

;************** exit with carry clear ************************************

_BE592:			clc					; 
_BE593:			rts					; exit
								;
;*** expand soft key strings *********************************************
; Y=pointer to sring number

_BE594:			pla					; restore original code
			and	#$0f				; blank hi nybble to get key string number
			tay					; Y=A
			jsr	_LE3A8				; get string length in A
			sta	OSB_SOFT_KEYLEN			; and store it
			lda	SOFTKEYS,Y			; get start point
			sta	SOFTKEY_EX_PTR			; and store it
			bne	_LE577				; if not 0 then get byte via E577 and exit

;*********** deal with COPY key ******************************************

_BE5A6:			txa					; A=X
			pha					; Push A
			jsr	_LD905				; read a character from the screen
			tay					; Y=A
			beq	_BE534				; if not valid A=0 so BEEP
			pla					; else restore X
			tax					; 
			tya					; and Y
			clc					; clear carry
			rts					; and exit


;**************************************************************************									  *
;*	  OSBYTE LOOK UP TABLE						 *
;*									 *
;*************************************************************************

			.org	$e5b3

_OSBYTE_TABLE:		.addr	_OSBYTE_0			; OSBYTE   0  (&E821)
			.addr	_OSBYTE_1_6			; OSBYTE   1  (&E988)
			.addr	_OSBYTE_2			; OSBYTE   2  (&E6D3)
			.addr	_OSBYTE_3_4			; OSBYTE   3  (&E997)
			.addr	_OSBYTE_3_4			; OSBYTE   4  (&E997)
			.addr	_OSBYTE_5			; OSBYTE   5  (&E976)
			.addr	_OSBYTE_1_6			; OSBYTE   6  (&E988)
			.addr	_OSBYTE_7			; OSBYTE   7  (&E68B)
			.addr	_OSBYTE_8			; OSBYTE   8  (&E689)
			.addr	_OSBYTE_9			; OSBYTE   9  (&E6B0)
			.addr	_OSBYTE_10			; OSBYTE  10  (&E6B2)
			.addr	_OSBYTE_11			; OSBYTE  11  (&E995)
			.addr	_OSBYTE_12			; OSBYTE  12  (&E98C)
			.addr	_OSBYTE_13			; OSBYTE  13  (&E6F9)
			.addr	_OSBYTE_14			; OSBYTE  14  (&E6FA)
			.addr	_OSBYTE_15			; OSBYTE  15  (&F0A8)
			.addr	_OSBYTE_16			; OSBYTE  16  (&E706)
			.addr	_OSBYTE_17			; OSBYTE  17  (&DE8C)
			.addr	_OSBYTE_18			; OSBYTE  18  (&E9C8)
			.addr	_OSBYTE_19			; OSBYTE  19  (&E9B6)
			.addr	_OSBYTE_20			; OSBYTE  20  (&CD07)
			.addr	_OSBYTE_21			; OSBYTE  21  (&F0B4)
			.addr	_OSBYTE_117			; OSBYTE 117  (&E86C)
			.addr	_OSBYTE_118			; OSBYTE 118  (&E9D9)
			.addr	_OSBYTE_119			; OSBYTE 119  (&E275)
			.addr	_OSBYTE_120			; OSBYTE 120  (&F045)
			.addr	_OSBYTE_121			; OSBYTE 121  (&F0CF)
			.addr	_OSBYTE_122			; OSBYTE 122  (&F0CD)
			.addr	_OSBYTE_123			; OSBYTE 123  (&E197)
			.addr	_OSBYTE_124			; OSBYTE 124  (&E673)
			.addr	_OSBYTE_125			; OSBYTE 125  (&E674)
			.addr	_OSBYTE_126			; OSBYTE 126  (&E65C)
			.addr	_OSBYTE_127			; OSBYTE 127  (&E035)
			.addr	_OSBYTE_128			; OSBYTE 128  (&E74F)
			.addr	_OSBYTE_129			; OSBYTE 129  (&E713)
			.addr	_OSBYTE_130			; OSBYTE 130  (&E729)
			.addr	_OSBYTE_131			; OSBYTE 131  (&F085)
			.addr	_OSBYTE_132			; OSBYTE 132  (&D923)
			.addr	_OSBYTE_133			; OSBYTE 133  (&D926)
			.addr	_OSBYTE_134			; OSBYTE 134  (&D647)
			.addr	_OSBYTE_135			; OSBYTE 135  (&D7C2)
			.addr	_OSBYTE_136			; OSBYTE 136  (&E657)
			.addr	_OSBYTE_137			; OSBYTE 137  (&E67F)
			.addr	_OSBYTE_138			; OSBYTE 138  (&E4AF)
			.addr	_OSBYTE_139			; OSBYTE 139  (&E034)
			.addr	_OSBYTE_140_141			; OSBYTE 140  (&F135)
			.addr	_OSBYTE_140_141			; OSBYTE 141  (&F135)
			.addr	_OSBYTE_142			; OSBYTE 142  (&DBE7)
			.addr	_OSBYTE_143			; OSBYTE 143  (&F168)
			.addr	_OSBYTE_144			; OSBYTE 144  (&EAE3)
			.addr	_OSBYTE_145			; OSBYTE 145  (&E460)
			.addr	_OSBYTE_146			; OSBYTE 146  (&FFAA)
			.addr	_OSBYTE_147			; OSBYTE 147  (&EAF4)
			.addr	_OSBYTE_148			; OSBYTE 148  (&FFAE)
			.addr	_OSBYTE_149			; OSBYTE 149  (&EAF9)
			.addr	_OSBYTE_150			; OSBYTE 150  (&FFB2)
			.addr	_OSBYTE_151			; OSBYTE 151  (&EAFE)
			.addr	_OSBYTE_152			; OSBYTE 152  (&E45B)
			.addr	_OSBYTE_153			; OSBYTE 153  (&E4F3)
			.addr	_OSBYTE_154			; OSBYTE 154  (&E9FF)
			.addr	_OSBYTE_155			; OSBYTE 155  (&EA10)
			.addr	_OSBYTE_156			; OSBYTE 156  (&E17C)
			.addr	_OSBYTE_157			; OSBYTE 157  (&FFA7)
			.addr	_OSBYTE_158			; OSBYTE 158  (&EE6D)
			.addr	_OSBYTE_159			; OSBYTE 159  (&EE7F)
			.addr	_OSBYTE_160			; OSBYTE 160  (&E9C0)
			.addr	_OSBYTE_166_255			; OSBYTE 166+
			.addr	_OSCLI_USERV			; OSWORD &E0+


;*************************************************************************
;*									 *
;*	  OSWORD LOOK UP TABLE						 *
;*									 *
;*************************************************************************

			.addr	_OSWORD_0			; OSWORD   0  (&E902)
			.addr	_OSWORD_1			; OSWORD   1  (&E8D5)
			.addr	_OSWORD_2			; OSWORD   2  (&E8E8)
			.addr	_OSWORD_3			; OSWORD   3  (&E8D1)
			.addr	_OSWORD_4			; OSWORD   4  (&E8E4)
			.addr	_OSWORD_5			; OSWORD   5  (&E803)
			.addr	_OSWORD_6			; OSWORD   6  (&E80B)
			.addr	_OSWORD_7			; OSWORD   7  (&E82D)
			.addr	_OSWORD_8			; OSWORD   8  (&E8AE)
			.addr	_OSWORD_9			; OSWORD   9  (&C735)
			.addr	_OSWORD_10			; OSWORD  10  (&CBF3)
			.addr	_OSWORD_11			; OSWORD  11  (&C748)
			.addr	_OSWORD_12			; OSWORD  12  (&C8E0)
			.addr	_OSWORD_13			; OSWORD  13  (&D5CE)


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


;*************************************************************************
;*************************************************************************
;**									**
;**	 SOUND SYSTEM							**
;**									**
;*************************************************************************
;*************************************************************************

; -------------------------------------------------------------------------
; |									  |
; |	  OSWORD  07 - Make a sound					  |
; |									  |
; -------------------------------------------------------------------------
; On entry, control block pointed to by &F0/1
;	    Y=0 on entry
; XY +0	 Channel - &hsfc for Hold, Sync, Flush, Channel
;     2	 Amplitude/Envelope
;     4	 Pitch
;     6	 Duration

			.org	$e82d

_OSWORD_7:		iny					
			lda	(OSW_X),Y			; Get channel high byte byte
			cmp	#$ff				
			beq	_SOUND_FF			; Channel &FFxx, speech command
			cmp	#$20				; Is channel>=&20 ?
			ldx	#$08				; Prepare X=8 for unrecognised OSWORD call
			bcs	_BE7CA				; Pass to sideways ROMs for channel &2000+
			dey					; Point back to channel low byte
			jsr	_LE8C9				; Get Channel 0-3, and Cy if >=&10 for Flush
			ora	#$04				; Convert to buffer number 4-7
			tax					
			bcc	_BE848				; If not Flush, skip past
			jsr	_LE1AE				; Flush buffer
			ldy	#$01				; Point back to channel high byte

_BE848:			jsr	_LE8C9				; Get Sync 0-3, and Cy if >=&10 for Hold
			sta	MOS_WS_0			; Save Sync in &FA
			php					; Stack flags
			ldy	#$06				
			lda	(OSW_X),Y			; Get Duration byte
			pha					; and stack it
			ldy	#$04				
			lda	(OSW_X),Y			; Get pitch byte
			pha					; and stack it
			ldy	#$02				; 
			lda	(OSW_X),Y			; Get amplitude/envelope byte
			rol					; Move Hold into bit 0
			sec					; set carry
			sbc	#$02				; subract 2
			asl					; multiply by 4
			asl					; 
			ora	MOS_WS_0			; add S byte (0-3)

				; At this point,
				; b7,	0=envelope, 1=volume
				; b6-3, envelope-1 or volume+15
				; b2,	Hold
				; b1-0, Sync

			jsr	_BUFFER_SAVE			; Insert into buffer
			bcc	_BE887				; Buffer not full, jump to insert the rest
_BE869:			pla					; Drop stacked pitch
			pla					; Drop stacked duration
			plp					; Restore flags
								; And exit

; -------------------------------------------------------------------------
; |									  |
; |	  OSBYTE  117 - Read VDU status					  |
; |									  |
; -------------------------------------------------------------------------

_OSBYTE_117:		ldx	VDU_STATUS			; get VDU status byte in X
			rts					; and return

;************* set up sound data for Bell ********************************

_VDU_7:			php					; push P
			sei					; bar interrupts
			lda	OSB_BELL_CHAN			; get bell channel number in A
			and	#$07				; (bits 0-3 only set)
			ora	#$04				; set bit 2
			tax					; X=A = bell channel number +4=buffer number
			lda	OSB_BELL_ENV			; get bell amplitude/envelope number
			jsr	_INSV				; store it in buffer pointed to by X
			lda	OSB_BELL_LEN			; get bell duration
			pha					; save it
			lda	OSB_BELL_FREQ			; get bell frequency
			pha					; save it

; Insert sound pitch and duration into sound buffer

_BE887:			sec					; Set carry
			ror	SOUND_WORKSPACE,X		; Set bit 7 of channel flags to indicate it's active
			bmi	_BE8A4				; Jump forward to insert pitch and duration

; -------------------------------------------------------------------------
; |									  |
; |	  SOUND &FFxx - Speech System					  |
; |									  |
; -------------------------------------------------------------------------
; On entry, control block pointed to by &F0/1
;	    Y=1 on entry
; XY +0	 Channel - &FFxx - xx=Speech command
;     2	 Word number/Address
;     4	 Ignored
;     6	 Ignored

_SOUND_FF:		php					; Save flags
			iny					; Y=2
			lda	(OSW_X),Y			; Get word number low byte
			pha					; and stack it
			iny					; Y=3
			lda	(OSW_X),Y			; Get word number high byte
			pha					; and stack it
			ldy	#$00				; Y=0
			lda	(OSW_X),Y			; Get speech command
			ldx	#$08				; X=8 for Speech buffer
			jsr	_BUFFER_SAVE			; Insert speech command into speech buffer
			bcs	_BE869				; Buffer full, drop stack and abandon
			ror	BUFFER_8_BUSY			; Clear bit 7 of speech buffer busy flag

; Insert two bytes into buffer

_BE8A4:			pla					; Get word number high byte or pitch back
			jsr	_INSV				; Insert into speech buffer
			pla					; Get word number low byte or duration back
			jsr	_INSV				; Insert into speech buffer
			plp					; Restore flags
			rts					; and return


;*************************************************************************
;*									 *
;*	 OSWORD	 08 - Define Envelope					 *
;*									 *
;*************************************************************************
; On entry, control block pointed to by &F0/1
;	    Y=0 on entry
;	    A=envelope number from (&F0),0
;XY +0	Envelope number, also in A
;    1	bits 0-6 length of each step in centi-secsonds bit 7=0 auto repeat
;    2	change of Pitch per step (-128-+127) in section 1
;    3	change of Pitch per step (-128-+127) in section 2
;    4	change of Pitch per step (-128-+127) in section 3
;    5	number of steps in section 1 (0-255)
;    6	number of steps in section 2 (0-255)
;    7	number of steps in section 3 (0-255)
;    8	change of amplitude per step during attack  phase (-127 to +127)
;    9	change of amplitude per step during decay   phase (-127 to +127)
;   10	change of amplitude per step during sustain phase (-127 to +127)
;   11	change of amplitude per step during release phase (-127 to +127)
;   12	target level at end of attack phase   (0-126)
;   13	target level at end of decay  phase   (0-126)

_OSWORD_8:		sbc	#$01				; set up appropriate displacement to storage area
			asl					; A=(A-1)*16 or 15
			asl					; 
			asl					; 
			asl					; 
			ora	#$0f				; 
			tax					; X=A
			lda	#$00				; A=0

			ldy	#$10				; Y=&10

_BE8BB:			cpy	#$0e				; is Y>=14??
			bcs	_BE8C1				; yes then E8C1
			lda	(OSW_X),Y			; else get byte from parameter block
_BE8C1:			sta	ENV_STEP,X			; and store it in appropriate area
			dex					; decrement X
			dey					; Decrement Y
			bne	_BE8BB				; if not 0 then do it again
			rts					; else exit
								; note that envelope number is NOT transferred

_LE8C9:			lda	(OSW_X),Y			; get byte
			cmp	#$10				; is it greater than 15, if so set carry
			and	#$03				; and 3 to clear bits 2-7
			iny					; increment Y
			rts					; and exit


;*************************************************************************
;*									 *
;*	 OSWORD	 03   ENTRY POINT					 *
;*									 *
;*	 read interval timer						 *
;*									 *
;*************************************************************************
;F0/1 points to block to store data

_OSWORD_3:		ldx	#$0f				; X=&F displacement from clock to timer
			bne	_BE8D8				; jump to E8D8


;*************************************************************************
;*									 *
;*	 OSWORD	 01   ENTRY POINT					 *
;*									 *
;*	 read system clock						 *
;*									 *
;*************************************************************************
;F0/1 points to block to store data

_OSWORD_1:		ldx	OSB_TIME_SWITCH			; X=current system clock store pointer

_BE8D8:			ldy	#$04				; Y=4
_BE8DA:			lda	OSB_LAST_BREAK,X		; read byte
			sta	(OSW_X),Y			; store it in parameter block
			inx					; X=x+1
			dey					; Y=Y-1
			bpl	_BE8DA				; if Y>0 then do it again
_BE8E3:			rts					; else exit


;*************************************************************************
;*									 *
;*	 OSWORD	 04   ENTRY POINT					 *
;*									 *
;*	 write interval timer						 *
;*									 *
;*************************************************************************
; F0/1 points to block to store data

_OSWORD_4:		lda	#$0f				; offset between clock and timer
			bne	_BE8EE				; jump to E8EE ALWAYS!!


;*************************************************************************
;*									 *
;*	 OSWORD	 02   ENTRY POINT					 *
;*									 *
;*	 write system clock						 *
;*									 *
;*************************************************************************
; F0/1 points to block to store data

_OSWORD_2:		lda	OSB_TIME_SWITCH			; get current clock store pointer
			eor	#$0f				; and invert to get inactive timer
			clc					; clear carry

_BE8EE:			pha					; store A
			tax					; X=A
			ldy	#$04				; Y=4
_BE8F2:			lda	(OSW_X),Y			; and transfer all 5 bytes
			sta	OSB_LAST_BREAK,X		; to the clock or timer
			inx					; 
			dey					; 
			bpl	_BE8F2				; if Y>0 then E8F2
			pla					; get back stack
			bcs	_BE8E3				; if set (write to timer) E8E3 exit
			sta	OSB_TIME_SWITCH			; write back current clock store
			rts					; and exit


;*************************************************************************
;*									 *
;*	 OSWORD	 00   ENTRY POINT					 *
;*									 *
;*	 read line from current input to memory				 *
;*									 *
;*************************************************************************
;F0/1 points to parameter block
;	+0/1 Buffer address for input
;	+2   Maximum line length
;	+3   minimum acceptable ASCII value
;	+4   maximum acceptable ASCII value

_OSWORD_0:		ldy	#$04				; Y=4

_BE904:			lda	(OSW_X),Y			; transfer bytes 4,3,2 to 2B3-2B5
			sta	INKEY_TIMER,Y			; 
			dey					; decrement Y
			cpy	#$02				; until Y=1
			bcs	_BE904				; 

			lda	(OSW_X),Y			; get address of input buffer
			sta	OSW_0_PTR_HI			; store it in &E9 as temporary buffer
			dey					; decrement Y
			sty	OSB_HALT_LINES			; Y=0 store in print line counter for paged mode
			lda	(OSW_X),Y			; get lo byte of address
			sta	OSW_0_PTR			; and store in &E8
			cli					; allow interrupts
			bcc	_BE924				; Jump to E924

_BE91D:			lda	#$07				; A=7
_BE91F:			dey					; decrement Y
_BE920:			iny					; increment Y
_BE921:			jsr	OSWRCH				; and call OSWRCH

_BE924:			jsr	OSRDCH				; else read character  from input stream
			bcs	_BE972				; if carry set then illegal character or other error
								; exit via E972
			tax					; X=A
			lda	OSB_OUT_STREAM			; A=&27C get character destination status
			ror					; put VDU driver bit in carry
			ror					; if this is 1 VDU driver is disabled
			txa					; X=A
			bcs	_BE937				; if Carry set E937
			ldx	OSB_VDU_QSIZE			; get number of items in VDU queque
			bne	_BE921				; if not 0 output character and loop round again

_BE937:			cmp	#$7f				; if character is not delete
			bne	_BE942				; goto E942
			cpy	#$00				; else is Y=0
			beq	_BE924				; and goto E924
			dey					; decrement Y
			bcs	_BE921				; and if carry set E921 to output it
_BE942:			cmp	#$15				; is it delete line &21
			bne	_BE953				; if not E953
			tya					; else Y=A, if its 0 we are still reading first
								; character
			beq	_BE924				; so E924
			lda	#$7f				; else output DELETES

_BE94B:			jsr	OSWRCH				; until Y=0
			dey					; 
			bne	_BE94B				; 

			beq	_BE924				; then read character again

_BE953:			sta	(OSW_0_PTR),Y			; store character in designated buffer
			cmp	#$0d				; is it CR?
			beq	_BE96C				; if so E96C
			cpy	OSW0_MAX_LINE			; else check the line length
			bcs	_BE91D				; if = or greater loop to ring bell
			cmp	OSW0_MIN_CHAR			; check minimum character
			bcc	_BE91F				; if less than minimum backspace
			cmp	OSW0_MAX_CHAR			; check maximum character
			beq	_BE920				; if equal E920
			bcc	_BE920				; or less E920
			bcs	_BE91F				; then JUMP E91F

_BE96C:			jsr	OSNEWL				; output CR/LF
			jsr	_NETV				; call Econet vector

_BE972:			lda	ESCAPE_FLAG			; A=ESCAPE FLAG
			rol					; put bit 7 into carry
			rts					; and exit routine


;*************************************************************************
;*									 *
;*	 OSBYTE	 05   ENTRY POINT					 *
;*									 *
;*	 SELECT PRINTER TYPE						 *
;*									 *
;*************************************************************************

_OSBYTE_5:		cli					; allow interrupts briefly
			sei					; bar interrupts
			bit	ESCAPE_FLAG			; check if ESCAPE is pending
			bmi	_BE9AC				; if it is E9AC
			bit	BUFFER_3_BUSY			; else check bit 7 buffer 3 (printer)
			bpl	_OSBYTE_5			; if not empty bit 7=0 E976

			jsr	_LE1A4				; check for user defined routine
			ldy	#$00				; Y=0
			sty	OSW_Y				; F1=0


;*************************************************************************
;*									 *
;*	 OSBYTE	 01   ENTRY POINT					 *
;*									 *
;*	 READ/WRITE USER FLAG (&281)					 *
;*									 *
;*	    AND								 *
;*									 *
;*	 OSBYTE	 06   ENTRY POINT					 *
;*									 *
;*	 SET PRINTER IGNORE CHARACTER					 *
;*									 *
;*************************************************************************
; A contains osbyte number

_OSBYTE_1_6:		ora	#$f0				; A=osbyte +&F0
			bne	_BE99A				; JUMP to E99A


;*************************************************************************
;*									 *
;*	 OSBYTE	 0C   ENTRY POINT					 *
;*									 *
;*	 SET  KEYBOARD AUTOREPEAT RATE					 *
;*									 *
;*************************************************************************

_OSBYTE_12:		bne	_OSBYTE_11			; if &F0<>0 goto E995
			ldx	#$32				; if X=0 in original call then X=32
			stx	OSB_KEY_DELAY			; to set keyboard autorepeat delay ram copy
			ldx	#$08				; X=8


;*************************************************************************
;*									 *
;*	 OSBYTE	 0B   ENTRY POINT					 *
;*									 *
;*	 SET  KEYBOARD AUTOREPEAT DELAY					 *
;*									 *
;*************************************************************************

_OSBYTE_11:		adc	#$cf				; A=A+&D0 (carry set)


;*************************************************************************
;*									 *
;*	 OSBYTE	 03   ENTRY POINT					 *
;*									 *
;*	 SELECT OUTPUT STREAM						 *
;*									 *
;*		 AND							 *
;*									 *
;*									 *
;*	 OSBYTE	 04   ENTRY POINT					 *
;*									 *
;*	 ENABLE/DISABLE CURSOR EDITING					 *
;*									 *
;*************************************************************************

_OSBYTE_3_4:		clc					; c,ear carry
			adc	#$e9				; A=A+&E9

_BE99A:			stx	OSW_X				; store X


;*************************************************************************
;*									 *
;*	 OSBYTE	 A6-FF	 ENTRY POINT					 *
;*									 *
;*	 READ/ WRITE SYSTEM VARIABLE OSBYTE NO. +&190			 *
;*									 *
;*************************************************************************

_OSBYTE_166_255:	tay					; Y=A
			lda	$0190,Y				; i.e. A=&190 +osbyte call!
			tax					; preserve this
			and	OSW_Y				; new value = OLD value AND Y EOR X!
			eor	OSW_X				; 
			sta	$0190,Y				; store it
			lda	$0191,Y				; get value of next byte into A
			tay					; Y=A
_BE9AC:			rts					; and exit

;******* SERIAL BAUD RATE LOOK UP TABLE ************************************

_BAUD_TABLE:		.byte	$64				; % 01100100	  75
			.byte	$7f				; % 01111111	 150
			.byte	$5b				; % 01011011	 300
			.byte	$6d				; % 01101101	1200
			.byte	$c9				; % 11001001	2400
			.byte	$f6				; % 11110110	4800
			.byte	$d2				; % 11010010	9600
			.byte	$e4				; % 11100100   19200
			.byte	$40				; % 01000000

;*************************************************************************
;*									 *
;*	 OSBYTE	 &13   ENTRY POINT					 *
;*									 *
;*	 Wait for VSync							 *
;*									 *
;*************************************************************************

_OSBYTE_19:		lda	OSB_CFS_TIMEOUT			; read vertical sync counter
_BE9B9:			cli					; allow interrupts briefly
			sei					; bar interrupts
			cmp	OSB_CFS_TIMEOUT			; has it changed?
			beq	_BE9B9				; no then E9B9
; falls through and reads VDU variable X

;*************************************************************************
;*									 *
;*	 OSBYTE	 160   ENTRY POINT					 *
;*									 *
;*	 READ VDU VARIABLE						 *
;*									 *
;*************************************************************************
;X contains the variable number
;0 =lefthand column in pixels current graphics window
;2 =Bottom row in pixels current graphics window
;4 =Right hand column in pixels current graphics window
;6 =Top row in pixels current graphics window
;8 =lefthand column in absolute characters current text window
;9 =Bottom row in absolute characters current text window
;10 =Right hand column in absolute characters current text window
;11 =Top row in absolute characters current text window
;12-15 current graphics origin in external coordinates
;16-19 current graphics cursor in external coordina4es
;20-23 old graphics cursor in internal coordinates
;24 current text cursor in X and Y

_OSBYTE_160:		ldy	VDU_G_WIN_L_HI,X		; get VDU variable hi
			lda	VDU_G_WIN_L,X			; low
			tax					; X=low byte
			rts					; and exit


;*************************************************************************
;*									 *
;*	 OSBYTE	 18   ENTRY POINT					 *
;*									 *
;*	 RESET SOFT KEYS						 *
;*									 *
;*************************************************************************

_OSBYTE_18:		lda	#$10				; set consistency flag
			sta	OSB_SOFTKEY_FLG			; 

			ldx	#$00				; X=0

_BE9CF:			sta	SOFTKEYS,X			; and wipe clean
			inx					; soft key buffer
			bne	_BE9CF				; until X=0 again

			stx	OSB_SOFTKEY_FLG			; zero consistency flag
			rts					; and exit


;*************************************************************************
;*									 *
;*	  OSBYTE &76 (118) SET LEDs to Keyboard Status			 *
;*									 *
;*************************************************************************
				; osbyte entry with carry set
				; called from &CB0E, &CAE3, &DB8B

_OSBYTE_118:		php					; PUSH P
			sei					; DISABLE INTERUPTS
			lda	#$40				; switch on CAPS and SHIFT lock lights
			jsr	_SET_LEDS_TEST_ESCAPE		; via subroutine
			bmi	__led_escape			; if ESCAPE exists (M set) E9E7
			clc					; else clear V and C
			clv					; before calling main keyboard routine to
			jsr	_LF068				; switch on lights as required
__led_escape:		plp					; get back flags
			rol					; and rotate carry into bit 0
			rts					; Return to calling routine
								;
;***************** Turn on keyboard lights and Test Escape flag ************
				; called from &E1FE, &E9DD
				;
_SET_LEDS_TEST_ESCAPE:	bcc	_BE9F5				; if carry clear
			ldy	#$07				; switch on shift lock light
			sty	SYS_VIA_IORB			; 
			dey					; Y=6
			sty	SYS_VIA_IORB			; switch on Caps lock light
_BE9F5:			bit	ESCAPE_FLAG			; set minus flag if bit 7 of &00FF is set indicating
			rts					; that ESCAPE condition exists, then return
								;
;****************** Write A to SYSTEM VIA register B *************************
				; called from &CB6D, &CB73
_WRITE_SYS_VIA_PORTB:	php					; push flags
			sei					; disable interupts
			sta	SYS_VIA_IORB			; write register B from Accumulator
			plp					; get back flags
			rts					; and exit


;*************************************************************************
;*									 *
;*	 OSBYTE 154 (&9A) SET VIDEO ULA					 *
;*									 *
;*************************************************************************

_OSBYTE_154:		txa					; osbyte entry! X transferred to A thence to

;*******Set Video ULA control register **entry from VDU routines **************
				; called from &CBA6, &DD37

_LEA00:			php					; save flags
			sei					; disable interupts
			sta	OSB_VIDPROC_CTL			; save RAM copy of new parameter
			sta	VID_ULA_CTRL			; write to control register
			lda	OSB_FLASH_MARK			; read	space count
			sta	OSB_FLASH_TIME			; set flash counter to this value
			plp					; get back status
			rts					; and return


;*************************************************************************
;*									 *
;*	  OSBYTE &9B (155) write to palette register			 *
;*									 *
;*************************************************************************
;entry X contains value to write
_OSBYTE_155:		txa					; A=X
_LEA11:			eor	#$07				; convert to palette format
			php					; 
			sei					; prevent interrupts
			sta	OSB_VIDPROC_PAL			; store as current palette setting
			sta	VID_ULA_PALETTE			; store actual colour in register
			plp					; get back flags
			rts					; and exit


;*************************************************************************
;*	 GSINIT	 string initialisation					 *
;*	 F2/3 points to string offset by Y				 *
;*									 *
;*	 ON EXIT							 *
;*	 Z flag set indicates null string,				 *
;*	 Y points to first non blank character				 *
;*	 A contains first non blank character				 *
;*************************************************************************

_LEA1D:			clc					; clear carry

_GSINIT:		ror	OSBYTE_PAR_3			; Rotate moves carry to &E4
			jsr	_SKIP_SPACE			; get character from text
			iny					; increment Y to point at next character
			cmp	#$22				; check to see if its '"'
			beq	_BEA2A				; if so EA2A (carry set)
			dey					; decrement Y
			clc					; clear carry
_BEA2A:			ror	OSBYTE_PAR_3			; move bit 7 to bit 6 and put carry in bit 7
			cmp	#$0d				; check to see if its CR to set Z
			rts					; and return


;*************************************************************************
;*	 GSREAD	 string read routine					 *
;*	 F2/3 points to string offset by Y				 *
;*									 *
;*************************************************************************
				;
_GSREAD:		lda	#$00				; A=0
_BEA31:			sta	OSBYTE_PAR_2			; store A
			lda	(TEXT_PTR),Y			; read first character
			cmp	#$0d				; is it CR
			bne	_BEA3F				; if not goto EA3F
			bit	OSBYTE_PAR_3			; if bit 7=1 no 2nd '"' found
			bmi	_LEA8F				; goto EA8F
			bpl	_BEA5A				; if not EA5A

_BEA3F:			cmp	#$20				; is less than a space?
			bcc	_LEA8F				; goto EA8F
			bne	_BEA4B				; if its not a space EA4B
			bit	OSBYTE_PAR_3			; is bit 7 of &E4 =1
			bmi	_BEA89				; if so goto EA89
			bvc	_BEA5A				; if bit 6 = 0 EA5A
_BEA4B:			cmp	#$22				; is it '"'
			bne	_BEA5F				; if not EA5F
			bit	OSBYTE_PAR_3			; if so and Bit 7 of &E4 =0 (no previous ")
			bpl	_BEA89				; then EA89
			iny					; else point at next character
			lda	(TEXT_PTR),Y			; get it
			cmp	#$22				; is it '"'
			beq	_BEA89				; if so then EA89

_BEA5A:			jsr	_SKIP_SPACE			; read a byte from text
			sec					; and return with
			rts					; carry set
								;
_BEA5F:			cmp	#$7c				; is it '|'
			bne	_BEA89				; if not EA89
			iny					; if so increase Y to point to next character
			lda	(TEXT_PTR),Y			; get it
			cmp	#$7c				; and compare it with '|' again
			beq	_BEA89				; if its '|' then EA89
			cmp	#$22				; else is it '"'
			beq	_BEA89				; if so then EA89
			cmp	#$21				; is it !
			bne	_BEA77				; if not then EA77
			iny					; increment Y again
			lda	#$80				; set bit 7
			bne	_BEA31				; loop back to EA31 to set bit 7 in next CHR
_BEA77:			cmp	#$20				; is it a space
			bcc	_LEA8F				; if less than EA8F Bad String Error
			cmp	#$3f				; is it '?'
			beq	_BEA87				; if so EA87
			jsr	_LEABF				; else modify code as if CTRL had been pressed
			bit	_BD9B7				; if bit 6 set
			bvs	_BEA8A				; then EA8A
_BEA87:			lda	#$7f				; else set bits 0 to 6 in A

_BEA89:			clv					; clear V
_BEA8A:			iny					; increment Y
			ora	OSBYTE_PAR_2			; 
			clc					; clear carry
			rts					; Return
								;
_LEA8F:			brk					; 
			.byte	$fd				; error number
			.byte	"Bad string"			; message
			brk					; 

;************ Modify code as if SHIFT pressed *****************************

_LEA9C:			cmp	#$30				; if A='0' skip routine
			beq	_BEABE				; 
			cmp	#$40				; if A='@' skip routine
			beq	_BEABE				; 
			bcc	_BEAB8				; if A<'@' then EAB8
			cmp	#$7f				; else is it DELETE

			beq	_BEABE				; if so skip routine
			bcs	_BEABC				; if greater than &7F then toggle bit 4
_BEAAC:			eor	#$30				; reverse bits 4 and 5
			cmp	#$6f				; is it &6F (previously ' _' (&5F))
			beq	_BEAB6				; goto EAB6
			cmp	#$50				; is it &50 (previously '`' (&60))
			bne	_BEAB8				; if not EAB8
_BEAB6:			eor	#$1f				; else continue to convert ` _
_BEAB8:			cmp	#$21				; compare &21 '!'
			bcc	_BEABE				; if less than return
_BEABC:			eor	#$10				; else finish conversion by toggling bit 4
_BEABE:			rts					; exit
								;
								; ASCII codes &00 &20 no change
								; 21-3F have bit 4 reverses (31-3F)
								; 41-5E A-Z have bit 5 reversed a-z
								; 5F & 60 are reversed
								; 61-7E bit 5 reversed a-z becomes A-Z
								; DELETE unchanged
								; &80+ has bit 4 changed

;************** Implement CTRL codes *************************************

_LEABF:			cmp	#$7f				; is it DEL
			beq	_BEAD1				; if so ignore routine
			bcs	_BEAAC				; if greater than &7F go to EAAC
			cmp	#$60				; if A<>'`'
			bne	_BEACB				; goto EACB
			lda	#$5f				; if A=&60, A=&5F

_BEACB:			cmp	#$40				; if A<&40
			bcc	_BEAD1				; goto EAD1  and return unchanged
			and	#$1f				; else zero bits 5 to 7
_BEAD1:			rts					; return
								;
			.byte	"/!BOOT",$0d			


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


;************ Keyboard Input and housekeeping ************************
				; entered from &F00C

			.org	$eeda

_LEEDA:			ldx	#$ff				; 
			lda	KEYNUM_FIRST			; get value of most recently pressed key
			ora	KEYNUM_LAST			; Or it with previous key to check for presses
			bne	_BEEE8				; if A=0 no keys pressed so off you go
			lda	#$81				; else enable keybd interupt only by writing bit 7
			sta	SYS_VIA_IER			; and bit 0 of system VIA interupt register
			inx					; set X=0
_BEEE8:			stx	OSB_KEY_SEM			; reset keyboard semaphore

;**********: Turn on Keyboard indicators *******************************
_SET_LEDS:		php					; save flags
			lda	OSB_KEY_STATUS			; read keyboard status;
								; Bit 7	 =1 shift enabled
								; Bit 6	 =1 control pressed
								; bit 5	 =0 shift lock
								; Bit 4	 =0 Caps lock
								; Bit 3	 =1 shift pressed
			lsr					; shift Caps bit into bit 3
			and	#$18				; mask out all but 4 and 3
			ora	#$06				; returns 6 if caps lock OFF &E if on
			sta	SYS_VIA_IORB			; turn on or off caps light if required
			lsr					; bring shift bit into bit 3
			ora	#$07				; 
			sta	SYS_VIA_IORB			; turn on or off shift	lock light
			jsr	_LF12E				; set keyboard counter
			pla					; get back flags
			rts					; return


;*************************************************************************
;*									 *
;* MAIN KEYBOARD HANDLING ROUTINE   ENTRY FROM KEYV			 *
;* ==========================================================		 *
;*									 *
;*			 ENTRY CONDITIONS				 *
;*			 ================				 *
;* C=0, V=0 Test Shift and CTRL keys.. exit with N set if CTRL pressed	 *
;*				   ........with V set if Shift pressed	 *
;*									 *
;* C=1, V=0 Scan Keyboard as OSBYTE &79					 *
;*									 *
;* C=0, V=1 Key pressed interrupt entry					 *
;*									 *
;* C=1, V=1 Timer interrupt entry					 *
;*									 *
;*************************************************************************

_KEYV:			bvc	_BEF0E				; if V is clear then leave interrupt routine
			lda	#$01				; disable keyboard interrupts
			sta	SYS_VIA_IER			; by writing to VIA interrupt vector
			bcs	_BEF13				; if timer interrupt then EF13
			jmp	_KEYBOARD_IRQ			; else to F00F

_BEF0E:			bcc	_BEF16				; if test SHFT & CTRL goto EF16
			jmp	_LF0D1				; else to F0D1
								; to scan keyboard
;*************************************************************************
;*	 Timer interrupt entry						 *
;*************************************************************************

_BEF13:			inc	OSB_KEY_SEM			; increment keyboard semaphore (to 0)


;*************************************************************************
;*	 Test Shift and Control Keys entry				 *
;*************************************************************************

_BEF16:			lda	OSB_KEY_STATUS			; read keyboard status;
								; Bit 7	 =1 shift enabled
								; Bit 6	 =1 control pressed
								; bit 5	 =0 shift lock
								; Bit 4	 =0 Caps lock
								; Bit 3	 =1 shift pressed
			and	#$b7				; zero bits 3 and 6
			ldx	#$00				; zero X to test for shift key press
			jsr	_KEYBOARD_SCAN			; interrogate keyboard X=&80 if key determined by
								; X on entry is pressed
			stx	MOS_WS_0			; save X
			clv					; clear V
			bpl	_BEF2A				; if no key press (X=0) then EF2A else
			bit	_BD9B7				; set M and V
			ora	#$08				; set bit 3 to indicate Shift was pressed
_BEF2A:			inx					; check the control key
			jsr	_KEYBOARD_SCAN			; via keyboard interrogate
			bcc	_SET_LEDS			; if carry clear (entry via EF16) then off to EEEB
								; to turn on keyboard lights as required
			bpl	_BEF34				; if key not pressed goto EF30
			ora	#$40				; or set CTRL pressed bit in keyboard status byte in A
_BEF34:			sta	OSB_KEY_STATUS			; save status byte
			ldx	KEYNUM_FIRST			; if no key previously pressed
			beq	_BEF4D				; then EF4D
			jsr	_KEYBOARD_SCAN			; else check to see if key still pressed
			bmi	_BEF50				; if so enter repeat routine at EF50
			cpx	KEYNUM_FIRST			; else compare X with last key pressed (set flags)
_BEF42:			stx	KEYNUM_FIRST			; store X in last key pressed
			bne	_BEF4D				; if different from previous (Z clear) then EF4D
			ldx	#$00				; else zero
			stx	KEYNUM_FIRST			; last key pressed
_BEF4A:			jsr	_LF01F				; and reset repeat system
_BEF4D:			jmp	_LEFE9				; 

;********** REPEAT ACTION *************************************************

_BEF50:			cpx	KEYNUM_FIRST			; if X<>than last key pressed
			bne	_BEF42				; then back to EF42
			lda	AUTO_REPEAT_TIMER		; else get value of AUTO REPEAT COUNTDOWN TIMER
			beq	_BEF7B				; if 0 goto EF7B
			dec	AUTO_REPEAT_TIMER		; else decrement
			bne	_BEF7B				; and if not 0 goto EF7B
								; this means that either the repeat system is dormant
								; or it is not at the end of its count
			lda	KEY_REPEAT_CNT			; next value for countdown timer
			sta	AUTO_REPEAT_TIMER		; store it
			lda	OSB_KEY_REPEAT			; get auto repeat rate from 0255
			sta	KEY_REPEAT_CNT			; store it as next value for Countdown timer
			lda	OSB_KEY_STATUS			; get keyboard status
			ldx	KEYNUM_FIRST			; get last key pressed
			cpx	#$d0				; if not SHIFT LOCK key (&D0) goto
			bne	_BEF7E				; EF7E
			ora	#$90				; sets shift enabled, & no caps lock all else preserved
			eor	#$a0				; reverses shift lock disables Caps lock and Shift enab
_LEF74:			sta	OSB_KEY_STATUS			; reset keyboard status
			lda	#$00				; and set timer
			sta	AUTO_REPEAT_TIMER		; to 0
_BEF7B:			jmp	_LEFE9				; 

_BEF7E:			cpx	#$c0				; if not CAPS LOCK
			bne	_BEF91				; goto EF91
			ora	#$a0				; sets shift enabled and disables SHIFT LOCK
			bit	MOS_WS_0			; if bit 7 not set by (EF20) shift NOT pressed
			bpl	_BEF8C				; goto EF8C
			ora	#$10				; else set CAPS LOCK not enabled
			eor	#$80				; reverse SHIFT enabled

_BEF8C:			eor	#$90				; reverse both SHIFT enabled and CAPs Lock
			jmp	_LEF74				; reset keyboard status and set timer

;*********** get ASCII code *********************************************
				; on entry X=key pressed internal number

_BEF91:			lda	_LEFAB,X			; get code from look up table
			bne	_BEF99				; if not zero goto EF99 else TAB pressed
			lda	OSB_TAB				; get TAB character

_BEF99:			ldx	OSB_KEY_STATUS			; get keyboard status
			stx	MOS_WS_0			; store it in &FA
			rol	MOS_WS_0			; rotate to get CTRL pressed into bit 7
			bpl	_BEFA9				; if CTRL NOT pressed EFA9

			ldx	KEYNUM_LAST			; get no. of previously pressed key
_BEFA4:			bne	_BEF4A				; if not 0 goto EF4A to reset repeat system etc.
			jsr	_LEABF				; else perform code changes for CTRL

_BEFA9:			rol	MOS_WS_0			; move shift lock into bit 7
_LEFAB:			bmi	_BEFB5				; if not effective goto EFB5 else
			jsr	_LEA9C				; make code changes for SHIFT

			rol	MOS_WS_0			; move CAPS LOCK into bit 7
			jmp	_LEFC1				; and Jump to EFC1

_BEFB5:			rol	MOS_WS_0			; move CAPS LOCK into bit 7
			bmi	_BEFC6				; if not effective goto EFC6
			jsr	_LE4E3				; else make changes for CAPS LOCK on, return with
								; C clear for Alphabetic codes
			bcs	_BEFC6				; if carry set goto EFC6 else make changes for
			jsr	_LEA9C				; SHIFT as above

_LEFC1:			ldx	OSB_KEY_STATUS			; if shift enabled bit is clear
			bpl	_BEFD1				; goto EFD1
_BEFC6:			rol	MOS_WS_0			; else get shift bit into 7
			bpl	_BEFD1				; if not set goto EFD1
			ldx	KEYNUM_LAST			; get previous key press
			bne	_BEFA4				; if not 0 reset repeat system etc. via EFA4
			jsr	_LEA9C				; else make code changes for SHIFT
_BEFD1:			cmp	OSB_ESCAPE			; if A<> ESCAPE code
			bne	_BEFDD				; goto EFDD
			ldx	OSB_ESC_ACTION			; get Escape key status
			bne	_BEFDD				; if ESCAPE returns ASCII code goto EFDD
			stx	AUTO_REPEAT_TIMER		; store in Auto repeat countdown timer

_BEFDD:			tay					; 
			jsr	_LF129				; disable keyboard
			lda	OSB_KEY_DISABLE			; read Keyboard disable flag used by Econet
			bne	_LEFE9				; if keyboard locked goto EFE9
			jsr	_LE4F1				; put character in input buffer
_LEFE9:			ldx	KEYNUM_LAST			; get previous keypress
			beq	_BEFF8				; if none  EFF8
			jsr	_KEYBOARD_SCAN			; examine to see if key still pressed
			stx	KEYNUM_LAST			; store result
			bmi	_BEFF8				; if pressed goto EFF8
			ldx	#$00				; else zero X
			stx	KEYNUM_LAST			; and &ED

_BEFF8:			ldx	KEYNUM_LAST			; get &ED
			bne	_BF012				; if not 0 goto F012
			ldy	#$ec				; get first keypress into Y
			jsr	_LF0CC				; scan keyboard from &10 (osbyte 122)

			bmi	_BF00C				; if exit is negative goto F00C
			lda	KEYNUM_FIRST			; else make last key the
			sta	KEYNUM_LAST			; first key pressed i.e. rollover

_BF007:			stx	KEYNUM_FIRST			; save X into &EC
			jsr	_LF01F				; set keyboard repeat delay
_BF00C:			jmp	_LEEDA				; go back to EEDA


;*************************************************************************
;*   Key pressed interrupt entry point					 *
;*************************************************************************
				; enters with X=key
_KEYBOARD_IRQ:		jsr	_KEYBOARD_SCAN			; check if key pressed

_BF012:			lda	KEYNUM_FIRST			; get previous key press
			bne	_BF00C				; if none back to housekeeping routine
			ldy	#$ed				; get last keypress into Y
			jsr	_LF0CC				; and scan keyboard
			bmi	_BF00C				; if negative on exit back to housekeeping
			bpl	_BF007				; else back to store X and reset keyboard delay etc.

;**************** Set Autorepeat countdown timer **************************

_LF01F:			ldx	#$01				; set timer to 1
			stx	AUTO_REPEAT_TIMER		; 
			ldx	OSB_KEY_DELAY			; get next timer value
			stx	KEY_REPEAT_CNT			; and store it
			rts					; 

;*************** Interrogate Keyboard routine ***********************
				;
_KEYBOARD_SCAN:		ldy	#$03				; stop Auto scan
			sty	SYS_VIA_IORB			; by writing to system VIA
			ldy	#$7f				; set bits 0 to 6 of port A to input on bit 7
								; output on bits 0 to 6
			sty	SYS_VIA_DDRA			; 
			stx	SYS_VIA_IORB_NH			; write X to Port A system VIA
			ldx	SYS_VIA_IORB_NH			; read back &80 if key pressed (M set)
			rts					; and return


;*************************************************************************
;*									 *
;*	 KEY TRANSLATION TABLES						 *
;*									 *
;*	 7 BLOCKS interspersed with unrelated code			 *
;*************************************************************************

; key data block 1

_KEY_TRANS_TABLE_1:	.byte	$71,$33,$34,$35,$84,$38,$87,$2d,$5e,$8c
								; q ,3 ,4 ,5 ,f4,8 ,f7,- ,^ ,rt


;*************************************************************************
;*									 *
;*	 OSBYTE 120  Write KEY pressed Data				 *
;*									 *
;*************************************************************************

_OSBYTE_120:		sty	KEYNUM_FIRST			; store Y as latest key pressed
			stx	KEYNUM_LAST			; store X as previous key pressed
			rts					; and exit
			brk					

; key data block 2

_KEY_TRANS_TABLE_2:	.byte	$80,$77,$65,$74,$37,$69,$39,$30,$5f,$8e
								; f0,w ,e ,t ,7 ,i ,9 ,0 ,_ ,lft

_LF055:			jmp	($fdfe)				; Jim paged entry vector
_LF058:			jmp	(MOS_WS_0)			; 

; key data block 3

_KEY_TRANS_TABLE_3:	.byte	$31,$32,$64,$72,$36,$75,$6f,$70,$5b,$8f
								; 1 ,2 ,d ,r ,6 ,u ,o ,p ,[ ,dn


;*************************************************************************
;*									 *
;* Main entry to keyboard routines					 *
;*									 *
;*************************************************************************

_LF065:			bit	_BD9B7				; set V and M
_LF068:			jmp	(VEC_KEYV)			; i.e. KEYV

; key data block 4

_KEY_TRANS_TABLE_4:	.byte	$01,$61,$78,$66,$79,$6a,$6b,$40,$3a,$0d
								; CL,a ,x ,f ,y ,j ,k ,@ ,: ,RETN  N.B CL=CAPS LOCK

; speech routine data
_SPEECH_DATA:		.byte	$00,$ff				
			.byte	$01,$02				
			.byte	$09,$0a				

; key data block 5

_KEY_TRANS_TABLE_5:	.byte	$02,$73,$63,$67,$68,$6e,$6c,$3b,$5d,$7f
								; SL,s ,c ,g ,h ,n ,l ,; ,] ,DEL N.B. SL=SHIFT LOCK


;*************************************************************************
;*									 *
;*	 OSBYTE 131  READ OSHWM	 (PAGE in BASIC)			 *
;*									 *
;*************************************************************************

_OSBYTE_131:		ldy	OSB_OSHWM_CUR			; read current OSHWM
			ldx	#$00				; 
			rts					; 

; key data block 6

_KEY_TRANS_TABLE_7:	.byte	$00,$7a,$20,$76,$62,$6d,$2c,$2e,$2f,$8b
								; TAB,Z ,SPACE,V ,b ,m ,, ,. ,/ ,copy

;***** set input buffer number and flush it *****************************

_BF095:			ldx	OSB_IN_STREAM			; get current input buffer
_BF098:			jmp	_LE1AD				; flush it

; key data block 7

_KEY_TRANS_TABLE_8:	.byte	$1b,$81,$82,$83,$85,$86,$88,$89,$5c,$8d
								; ESC,f1,f2,f3,f5,f6,f8,f9,\ ,

_LF0A5:			jmp	(VEC_EVNTV)			; goto eventV handling routine


;*************************************************************************
;*									 *
;*	 OSBYTE 15  FLUSH SELECTED BUFFER CLASS				 *
;*									 *
;*************************************************************************

				; flush selected buffer
				; X=0 flush all buffers
				; X>1 flush input buffer

_OSBYTE_15:		bne	_BF095				; if X<>1 flush input buffer only
_LF0AA:			ldx	#$08				; else load highest buffer number (8)
_BF0AC:			cli					; allow interrupts
			sei					; briefly!
			jsr	_OSBYTE_21			; flush buffer
			dex					; decrement X to point at next buffer
			bpl	_BF0AC				; if X>=0 flush next buffer
								; at this point X=255


;*************************************************************************
;*									 *
;*	 OSBYTE 21  FLUSH SPECIFIC BUFFER				 *
;*									 *
;*************************************************************************
;on entry X=buffer number

_OSBYTE_21:		cpx	#$09				; is X<9?
			bcc	_BF098				; if so flush buffer or else
			rts					; exit

;*************************************************************************
;*									 *
;*		 Issue *HELP to ROMS					 *
;*									 *
;*************************************************************************
_OSCLI_HELP:		ldx	#$09				; 
			jsr	_OSBYTE_143			; 
			jsr	_PRINT_MSG			; print following message routine return after BRK
			.byte	$0d				; carriage return
			.byte	"OS 1.20"			; help message
			.byte	$0d				; carriage return
			brk					; 
			rts					; 

;*************************************************************************
;*									 *
;*	 OSBYTE 122  KEYBOARD SCAN FROM &10 (16)			 *
;*									 *
;*************************************************************************

_LF0CC:			clc					; clear carry
_OSBYTE_122:		ldx	#$10				; set X to 10


;*************************************************************************
;*									 *
;*	 OSBYTE 121  KEYBOARD SCAN FROM VALUE IN X			 *
;*									 *
;*************************************************************************

_OSBYTE_121:		bcs	_LF068				; if carry set (by osbyte 121) F068
								; Jmps via KEYV and hence back to;


;*************************************************************************
;*	  Scan Keyboard C=1, V=0 entry via KEYV				 *
;*************************************************************************

_LF0D1:			txa					; if X is +ve goto F0D9
			bpl	_BF0D9				; 
			jsr	_KEYBOARD_SCAN			; else interrogate keyboard
			bcs	_LF12E				; if carry set F12E to set Auto scan else
_BF0D9:			php					; push flags
			bcc	_BF0DE				; if carry clear goto FODE else
			ldy	#$ee				; set Y so next operation saves to 2cd
_BF0DE:			sta	$01df,Y				; can be 2cb,2cc or 2cd
			ldx	#$09				; set X to 9
_BF0E3:			jsr	_LF129				; select auto scan
			lda	#$7f				; set port A for input on bit 7 others outputs
			sta	SYS_VIA_DDRA			; 
			lda	#$03				; stop auto scan
			sta	SYS_VIA_IORB			; 
			lda	#$0f				; select non-existent keyboard column F (0-9 only!)
			sta	SYS_VIA_IORB_NH			; 
			lda	#$01				; cancel keyboard interrupt
			sta	SYS_VIA_IFR			; 
			stx	SYS_VIA_IORB_NH			; select column X (9 max)
			bit	SYS_VIA_IFR			; if bit 1 =0 there is no keyboard interrupt so
			beq	_BF123				; goto F123
			txa					; else put column address in A

_BF103:			cmp	$01df,Y				; compare with 1DF+Y
			bcc	_BF11E				; if less then F11E
			sta	SYS_VIA_IORB_NH			; else select column again
			bit	SYS_VIA_IORB_NH			; and if bit 7 is 0
			bpl	_BF11E				; then F11E
			plp					; else push and pull flags
			php					; 
			bcs	_BF127				; and if carry set goto F127
			pha					; else Push A
			eor	$0000,Y				; EOR with EC,ED, or EE depending on Y value
			asl					; shift left
			cmp	#$01				; set carry if = or greater than number holds EC,ED,EE
			pla					; get back A
			bcs	_BF127				; if carry set F127
_BF11E:			clc					; else clear carry
			adc	#$10				; add 16
			bpl	_BF103				; and do it again if 0=<result<128
_BF123:			dex					; decrement X
			bpl	_BF0E3				; scan again if greater than 0
			txa					; 
_BF127:			tax					; 
			plp					; pull flags

_LF129:			jsr	_LF12E				; call autoscan
			cli					; allow interrupts
			sei					; disable interrupts

;*************Enable counter scan of keyboard columns *******************
				; called from &EEFD, &F129

_LF12E:			lda	#$0b				; select auto scan of keyboard
			sta	SYS_VIA_IORB			; tell VIA
			txa					; Get A into X
			rts					; and return


; OS SERIES 9
; GEOFF COX
;*************************************************************************
;*									 *
;*	 OSBYTE 140  *TAPE						 *
;*	 selects TAPE filing system					 *
;*									 *
;*	 OSBYTE 141  *ROM						 *
;*	 selects ROM filing system					 *
;*									 *
;*************************************************************************

			.org	$f135

_OSBYTE_140_141:	eor	#$8c				; if it's *TAPE A=0 *ROM A=1
_LF137:			asl					; double it
			sta	OSB_CFSRFC_SW			; store it in filing system flag store
			cpx	#$03				; if X>=3 C set X=3 Z set
			jmp	_LF14B				; 

;******** set cassette options *******************************************
				; called after BREAK etc
				; lower nybble sets sequential access
				; upper sets load and save options

				; 0000	 Ignore errors,		 no messages
				; 0001	 Abort if error,	 no messages
				; 0010	 Retry after error,	 no messages
				; 1000	 Ignore error		 short messages
				; 1001	 Abort if error		 short messages
				; 1010	 Retry after error	 short messages
				; 1100	 Ignore error		 long messages
				; 1101	 Abort if error		 long messages
				; 1110	 Retry after error	 long messages

_LF140:			php					; save flags
			lda	#$a1				; set sequential access abort if error, no messages
			sta	CRFS_OPTIONS			; set load/save retry if error, short messages
			lda	#$19				; set interblock gap
			sta	SEQ_BLOCK_GAP			; and store it
			plp					; get back flags

_LF14B:			php					; push flags
			lda	#$06				; get close files command to FSCV
			jsr	_OSCLI_FSCV			; and gosub OSFSC
			ldx	#$06				; 
			plp					; get back flags
			beq	_BF157				; if Z set earlier
			dex					; do not decrement X
_BF157:			stx	CFS_BAUD_RATE			; set current baud rate X=5 300 baud X=6 1200 baud

;********* reset FILEV,ARGSV,BGETV,BPUTV,GBPBV,FINDV,FSCV ******************
;**********   to F27D, F18E, F4C9, F529, FFA6, F3CA, F1B1 ******************

			ldx	#$0e				; RESET VECTORS FOR FILE RELATED OPERATIONS
__vec_reset_loop:	lda	_VECTOR_TABLE + $11,X		; 
			sta	VEC_USERV + $11,X		; 
			dex					; 
			bne	__vec_reset_loop		; 

			stx	CRFS_PROGRESS			; &C2=0 PROGRESS FLAG
			ldx	#$0f				; set X to make Rom service call &F claim vectors!


;*************************************************************************
;*									 *
;*	 OSBYTE 143							 *
;*	 Pass service commands to sideways ROMs				 *
;*									 *
;*************************************************************************
				; On entry X=service call number
				; Y=any additional parameter
				; On entry X=0 if claimed, or preserved if unclaimed
				; Y=any returned parameter
				; When called internally, EQ set if call claimed

_OSBYTE_143:		lda	ROM_SELECT			; Get current ROM number
			pha					; Save it
			txa					; Pass service call number to  A
			ldx	#$0f				; Start at ROM 15

				; Issue service call loop
_BF16E:			inc	ROM_TABLE,X			; Read bit 7 on ROM type table (no ROM has type 254 &FE)
			dec	ROM_TABLE,X			; 
			bpl	_BF183				; If not set (+ve result), step to next ROM down
			stx	ROM_SELECT			; Otherwise, select this ROM, &F4 RAM copy
			stx	ROM_LATCH			; Page in selected ROM
			jsr	ROM_SERVICE			; Call the ROM's service entry
								; X and P do not need to be preserved by the ROM
			tax					; On exit pass A to X to chech if claimed
			beq	_BF186				; If 0, service call claimed, reselect ROM and exit
			ldx	ROM_SELECT			; Otherwise, get current ROM back
_BF183:			dex					; Step to next ROM down
			bpl	_BF16E				; Loop until done ROM 0

_BF186:			pla					; Get back original ROM number
			sta	ROM_SELECT			; Set ROM number RAM copy
			sta	ROM_LATCH			; Page in the original ROM
			txa					; Pass X back to A to set zero flag
			rts					; And return


;*************************************************************************
;*									 *
;*	 CFS OSARGS entry point						 *
;*
;*************************************************************************

_ARGSV:			ora	#$00				; is A=00
			bne	_BF1A2				; if not return
			cpy	#$00				; is Y=0
			bne	_BF1A2				; if not return
			lda	CFS_BAUD_RATE			; else get current baud rate and zero bit 2
			and	#$fb				; C6=5 becomes 1, 6 becomes 2
			ora	OSB_CFSRFC_SW			; if cassette selected A=0 else A=2
			asl					; multiply by 2
			ora	OSB_CFSRFC_SW			; Or it again
			lsr					; divide by 2
_BF1A2:			rts					; return cassette =0

;*************************************************************************
;*									 *
;*	 FSC	 VECTOR	 TABLE						 *
;*									 *
;*************************************************************************

_FSCV_TABLE:		.addr	_FSCV_OPT - 1			; *OPT		  (F54C)
			.addr	_FSCV_EOF - 1			; check EOF	  (F61D)
			.addr	_FSCV_RUN - 1			; */		  (F304)
			.addr	_USERV - 1			; unknown command (E30F)
			.addr	_FSCV_RUN - 1			; *RUN		  (F304)
			.addr	_FSCV_CAT - 1			; *CAT		  (F32A)
			.addr	_OSBYTE_119 - 1			; osbyte 77	  (E274)


;*************************************************************************
;*	 Filing System control entry	 OSFSC				 *
;*	 Entry via 021E FSCV						 *
;*	 A= index 0 to 7						 *
;*************************************************************************
				; on entry A is reason code
				; A=0	 A *OPT command has been used X & Y are the 2 parameters
				; A=1	 EOF is being checked, on entry	 X=File handle
;				  on Exit X=FF = EOF exists else 00
				; A=2	 A */ command has been used *RUN the file
				; A=3	 An unrecognised OS command has ben used X,Y point at command
				; A=4	 A *RUN command has been used X,Y point at filename
				; A=5	 A *CAT cammand has been issued X,Y point to rest of command
				; A=6	 New filing system about to take over, close SPOOL & EXEC files
				; A=7	 Return in X and Y lowest and highest file handle used
				; A=8	 OS about to process *command

_FSCV:			cmp	#$07				; if A>6
			bcs	_BF1A2				; goto F1A2 (RTS)
			stx	CRFS_BLK_OFFSET			; else save X
			asl					; A=A*2
			tax					; X=A to get offset
			lda	_FSCV_TABLE + 1,X		; get hi byte of address
			pha					; push it
			lda	_FSCV_TABLE,X			; get lo byte of address
			pha					; push it
			ldx	CRFS_BLK_OFFSET			; get back X
			rts					; this now jumps to the address got from the table +1
								; the next RTS takes us back to CLI


;*************************************************************************
;*									 *
;*	 LOAD FILE							 *
;*									 *
;*************************************************************************

_LF1C4:			php					; save flags on stack
			pha					; save A on stack
			jsr	_CFS_CLAIM_SERIAL		; Set cassette optionsinto (BB),set C7=6
								; claim serial system for cassette
			lda	CFS_EXEC_LO			; execution address LO
			pha					; save A on stack
			jsr	_LF631				; search for file
			pla					; get back A
			beq	_BF1ED				; if A=0 F1ED
			ldx	#$03				; else X=3
			lda	#$ff				; A=&FF
_BF1D7:			pha					; save A on stack
			lda	CFS_LOAD_LO,X			; get load address
			sta	CRFS_LOAD,X			; store it as current load address
			pla					; get back A
			and	CRFS_LOAD,X			; 
			dex					; X=X-1
			bpl	_BF1D7				; until all 4 bytes copied

			cmp	#$ff				; if all bytes contain don't contain &FF
			bne	_BF1ED				; continue
			jsr	_LFAE8				; else sound bell, reset ACIA & motor off
			jmp	_LE267				; 'Bad Address' error

_BF1ED:			lda	CFS_BLK_FLAG			; block flag
			lsr					; set carry from bit 0
			pla					; get back A
			beq	_BF202				; if A=0 F202
			bcc	_BF209				; if carry clear F209

;*************** LOCKED FILE ROUTINE *************************************

_LF1F6:			jsr	_LFAF2				; enable second processor and reset serial system

			brk					; 
			.byte	$d5				; error number	;; was &E5
			.byte	"Locked"			; 
			brk					; 

_BF202:			bcc	_BF209				; if carry clear F209
			lda	#$03				; else A=3
			sta	OSB_ESC_BRK			; store to cause ESCAPE disable and memory
								; clear on break

_BF209:			lda	#$30				; 
			and	CRFS_OPTS			; current OPTions
			beq	_BF213				; if options and #&30 =0 ignore error condition is set
			lda	CRFS_CRC_RESULT			; else get checksum result
			bne	_BF21D				; and if not 0 F21D

_BF213:			tya					; A=Y
			pha					; save A on stack
			jsr	_LFBBB				; read from second processor if present
			pla					; get back A
			tay					; Y=A
			jsr	_LF7D5				; reset flags and check block length
_BF21D:			jsr	_CRFS_LOAD_FILE			; load file from tape
			bne	_BF255				; if not found return to search
			jsr	_LFB69				; increment current block number
			bit	CFS_BLK_FLAG			; block flag
			bmi	_BF232				; if bit 7=1 then this is last block so F232
			jsr	_INC_LOAD_ADDRESS		; else increment current load address
			jsr	_LF77B				; read block header
			bne	_BF209				; and goto F209

;******** store data in OSFILE parameter block ***************************

_BF232:			ldy	#$0a				; Y=&0A
			lda	CRFS_FILE_SIZE			; file length counter lo
			sta	(CRFS_OSFILE_PTR),Y		; OSFILE parameter  block
			iny					; Y=Y+1
			lda	CRFS_FILE_SIZE_HI		; file length counter hi
			sta	(CRFS_OSFILE_PTR),Y		; OSFILE parameter  block
			lda	#$00				; A=0
			iny					; Y=Y+1
			sta	(CRFS_OSFILE_PTR),Y		; OSFILE parameter  block
			iny					; Y=Y+1
			sta	(CRFS_OSFILE_PTR),Y		; OSFILE parameter  block
			plp					; get back flags
_LF246:			jsr	_LFAE8				; bell, reset ACIA & motor
_LF249:			bit	CRFS_BLOCK_FLAG			; current block flag
			bmi	_BF254				; return
_CRFS_PRINT_NEWLINE:	php					; save flags on stack
			jsr	_CRFS_PRINT_MSG			; print message following call (in this case NEWLINE!)
			.byte	$0d,$00				; message
			plp					; restore flags
_BF254:			rts					; return
								;
;************RETRY AFTER A FAILURE ROUTINE *******************************

_BF255:			jsr	_LF637				; search for a specified block
			bne	_BF209				; goto F209

;*********** Read Filename using Command Line Interpreter ****************

;filename pointed to by X and Y

_LF25A:			stx	TEXT_PTR			; OS filename/command line pointer lo
			sty	TEXT_PTR_HI			; OS filename/command line pointer
			ldy	#$00				; Y=0
			jsr	_LEA1D				; initialise string
			ldx	#$00				; X=0
_BF265:			jsr	_GSREAD				; GSREAD call
			bcs	_BF277				; if end of character string F277
			beq	_BF274				; if 0 found F274
			sta	CFS_FIND_NAME,X			; else store character in CFS filename area
			inx					; X=X+1
			cpx	#$0b				; if X<>11
			bne	_BF265				; then read next
_BF274:			jmp	_LEA8F				; else Bad String error

;************* terminate Filename ****************************************

_BF277:			lda	#$00				; terminate filename with 0
			sta	CFS_FIND_NAME,X			; 
			rts					; return


;*************************************************************************
;*									 *
;*	 OSFILE ENTRY							 *
;*									 *
;*	 on entry A determines action					 *
;*	 A=0	 save block of memory as a file				 *
;*	 A=1	 write catalogue info for existing file			 *
;*	 A=2	 write load address only for existing file		 *
;*	 A=3	 write execution address only for existing file		 *
;*	 A=4	 write attributes only for existing file		 *
;*	 A=5	 Read catalogue info, return file type in A		 *
;*	 A=6	 Delete named file					 *
;*	 A=&FF	 load the named file if lo byte of Exec address=0 use	 *
;*		 address in parameter block else files own load address	 *
;*	 X,Y	 point to parameter block				 *
;*	 bytes	 0,1 filename address, 2-5 load,6-9 exec,A-D length or	 *
;*		 start of data for save, 0E End address /attributes	 *
;*************************************************************************

;parameter block located by XY
;0/1	Address of Filename terminated by &0D
;2/4	Load Address of File
;6/9	Execution Address of File
;A/D	Start address of data for write operations or length of file
;	for read operations
;E/11	End address of Data; i.e. byte AFTER last byte to be written
;	or file attributes

;On Entry action is determined by value in A

;A=0	Save section of memory as named file, write catalogue information
;A=1	Write catalogue information for named file
;A=2	Write the LOAD	     address (only) for the named File
;A=3	Write the EXECUTION  address (only) for the named File
;A=4	Write the ATTRIBUTES for the named File
;A=5	Read the named files catalogue information Place file type in A
;A=6	Delete the named file
;A=&FF	Load the named file and read its catalogue information

_FILEV:			pha					; save A on stack
			stx	CRFS_OSFILE_PTR			; osfile block pointer lo
			sty	CRFS_OSFILE_PTR_HI		; osfile block pointer hi
			ldy	#$00				; Y=0
			lda	(CRFS_OSFILE_PTR),Y		; OSFILE parameter  block
			tax					; X=A
			iny					; Y=Y+1
			lda	(CRFS_OSFILE_PTR),Y		; OSFILE parameter  block
			tay					; Y=A
			jsr	_LF25A				; get filename from BUFFER
			ldy	#$02				; Y=2

__crfs_param_copy:	lda	(CRFS_OSFILE_PTR),Y		; copy parameters to Cassette block at 3BE/C5
			sta	CFS_LOAD_LO-2,Y			; from LOAD and EXEC address
			sta	CRFS_LOAD-2,Y			; make second copy at B0-B8
			iny					; Y=Y+1
			cpy	#$0a				; until Y=10
			bne	__crfs_param_copy		; 

			pla					; get back A
			beq	_BF2A7				; if A=0 F2A7
			cmp	#$ff				; else if A<>&FF
			bne	_BF254				; RETURN as cassette has no other options
			jmp	_LF1C4				; load file

;************** Save a file **********************************************

_BF2A7:			sta	CFS_BLK_NUM			; zero block number
			sta	CFS_BLK_NUM_HI			; zero block number hi

_BF2AD:			lda	(CRFS_OSFILE_PTR),Y		; OSFILE parameter  block
			sta	$00a6,Y				; store to Zero page copy (&B0 to &B7)
			iny					; data start and data end address
			cpy	#$12				; until Y=18
			bne	_BF2AD				; 
			txa					; A=X
			beq	_BF274				; if X=0 no filename found so B274 else BAD STRING error

			jsr	_CFS_CLAIM_SERIAL		; Set cassette option sinto (BB),set C7=6
								; claim serial system for cassette
			jsr	_LF934				; prompt to start recording

			lda	#$00				; A=0
			jsr	_LFBBD				; enable 2nd proc. if present and set up osfile block
			jsr	_LFBE2				; set up CFS for write operation
_BF2C8:			sec					; set carry flag
			ldx	#$fd				; X=&FD

_BF2CB:			lda	CRFS_EXEC + 65283,X		; set 03C8/A block length and block flag
			sbc	CRFS_LOAD + 65283,X		; to B4/6-B0/2 the number of pages (blocks) to be
								; saved
			sta	CFS_BLK_LEN - $fd,X		; 
			inx					; X=X+1
			bne	_BF2CB				; 

			tay					; Y=A
			bne	_BF2E8				; if last byte is non zero F2E8 else
			cpx	CFS_BLK_LEN			; compare X with block length
			lda	#$01				; A=1
			sbc	CFS_BLK_LEN_HI			; subtract block length hi
			bcc	_BF2E8				; if carry clear F2E8

			ldx	#$80				; X=&80
			bne	_BF2F0				; jump F2F0

_BF2E8:			lda	#$01				; A=1
			sta	CFS_BLK_LEN_HI			; block length hi
			stx	CFS_BLK_LEN			; block length
_BF2F0:			stx	CFS_BLK_FLAG			; block flag
			jsr	_LF7EC				; write block to Tape
			bmi	_BF341				; return if negative
			jsr	_INC_LOAD_ADDRESS		; increment current load address
			inc	CFS_BLK_NUM			; block number
			bne	_BF2C8				; if not 0 loop back again else
			inc	CFS_BLK_NUM_HI			; block number hi
			bne	_BF2C8				; and loop back again


;*************************************************************************
;*									 *
;*	 *RUN	 ENTRY							 *
;*									 *
;*************************************************************************

_FSCV_RUN:		jsr	_LF25A				; get filename from BUFFER
			ldx	#$ff				; X=&FF
			stx	CFS_EXEC_LO			; execution address
			jsr	_LF1C4				; load file
			bit	OSB_TUBE_FOUND			; &FF if tube present
			bpl	_BF31F				; so if not present F31F else
			lda	CFS_EXEC_VHI			; execution address extend
			and	CFS_EXEC_XHI			; execution address extend
			cmp	#$ff				; if they are NOT both &FF i.e.for base processor
			bne	_BF322				; F322 else
_BF31F:			jmp	(CFS_EXEC_LO)			; RUN file

_BF322:			ldx	#$c2				; point to execution address
			ldy	#$03				; (&03C2)
			lda	#$04				; Tube call 4
			jmp	_LFBC7				; and issue to Tube to run file


;*************************************************************************
;*									 *
;*	 *CAT	 ENTRY							 *
;*									 *
;*************************************************************************

				; CASSETTE OPTIONS in &E2

				; bit 0	 input file open
				; bit 1	 output file open
				; bit 2,4,5  not used
				; bit 3	 current CATalogue status
				; bit 6	 EOF reached
				; bit 7	 EOF warning given

_FSCV_CAT:		lda	#$08				; A=8
			jsr	_LF344				; set status bits from A
			jsr	_CFS_CLAIM_SERIAL		; Set cassette options into (BB),set C7=6
								; claim serial system for cassette
			lda	#$00				; A=0
			jsr	_LF348				; read data from CFS/RFS
			jsr	_LFAFC				; perform read
_LF33B:			lda	#$f7				; A=&F7
_LF33D:			and	CRFS_STATUS			; clear bit 3 of CFS status bit
_BF33F:			sta	CRFS_STATUS			; 
_BF341:			rts					; return

_LF342:			lda	#$40				; set bit 6 of E2 cassette options
_LF344:			ora	CRFS_STATUS			; 
			bne	_BF33F				; and Jump F33F

;********** search routine ***********************************************

_LF348:			pha					; save A on stack
			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_BF359				; if CFS F359 else
			jsr	_LEE13				; set current Filing System ROM/PHROM
			jsr	_LEE18				; get byte from data Romcheck type
			bcc	_BF359				; if carry clear F359 else
			clv					; clear overflow flag
			bvc	_BF39A				; JUMP F39A

;*********** cassette routine********************************************

_BF359:			jsr	_LF77B				; read block header
			lda	CFS_BLK_NUM			; block number
			sta	CRFS_EXEC			; current block no. lo
			lda	CFS_BLK_NUM_HI			; block number hi
			sta	CRFS_EXEC_HI			; current block no. hi
			ldx	#$ff				; X=&FF
			stx	CFS_LAST_FLAGS			; copy of last read block flag
			inx					; X=X+1
			stx	CRFS_BLOCK_FLAG			; current block flag
			beq	_BF376				; if  0 F376

_BF370:			jsr	_LFB69				; inc. current block no.
			jsr	_LF77B				; read block header
_BF376:			lda	OSB_CFSRFC_SW			; get filing system flag 0=CFS 2=RFS
			beq	_BF37D				; if CFS F37D
			bvc	_BF39A				; if V clear F39A
_BF37D:			pla					; get back A
			pha					; save A on stack
			beq	_BF3AE				; if A=0 F3AE
			jsr	_LFA72				; else check filename header block matches searched Fn
			bne	_BF39C				; if so F39C
			lda	#$30				; else A=30 to clear all but bits 4/5 of current OPTions

			and	CRFS_OPTS			; current OPTions
			beq	_BF39A				; if 0 F39A else

			lda	CFS_BLK_NUM			; block number
			cmp	CRFS_NEXT_BLK			; next block no. lo
			bne	_BF39C				; 
			lda	CFS_BLK_NUM_HI			; block number hi
			cmp	CRFS_NEXT_BLK_HI		; next block no. hi
			bne	_BF39C				; 
_BF39A:			pla					; get back A
			rts					; return
								;
_BF39C:			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_BF3AE				; if tape F3AE
_BF3A1:			jsr	_LEEAD				; else set ROM displacement address

_BF3A4:			lda	#$ff				; A=&FF
			sta	CFS_BLK_NUM			; block number
			sta	CFS_BLK_NUM_HI			; block number hi
			bne	_BF370				; jump F370

_BF3AE:			bvc	_BF3B5				; if carry clear F3B5
			lda	#$ff				; A=&FF
			jsr	_LF7D7				; set flags
_BF3B5:			ldx	#$00				; X=0
			jsr	_LF9D9				; report 'DATA?'
			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_BF3C3				; 
			bit	CRFS_OPTS			; current OPTions
			bvc	_BF3A1				; long messages not required if BIT 6 =0
_BF3C3:			bit	CFS_BLK_FLAG			; block flag
			bmi	_BF3A4				; if -ve F3A4
			bpl	_BF370				; else loop back and do it again

;*************************************************************************
;*									 *
;*	 OSFIND	 ENTRY							 *
;*	 file handling							 *
;*									 *
;*************************************************************************
;on entry A determines Action Y may contain file handle or
;X/Y point to filename terminated by &0D in memory
;A=0	closes file in channel Y if Y=0 closes all files
;A=&40	open a file for input  (reading) X/Y points to filename
;A=&80	open a file for output (writing) X/Y points to filename
;A=&C0	open a file for input and output (random access)
;ON EXIT Y=0 if no file found else Y=channel number in use for file

				; save A X and Y
			.org	$f3ca

_FINDV:			sta	CRFS_BLK_OFFSET			; file status or temporary store
			txa					; A=X
			pha					; save X on stack
			tya					; A=Y
			pha					; save Y on stack
			lda	CRFS_BLK_OFFSET			; file status or temporary store
			bne	_BF3F2				; if A is non zero open a file via F3F2

;************ close a file ***********************************************

			tya					; A=Y
			bne	_BF3E3				; if A<> 0 close specified file else close them all
			jsr	_OSBYTE_119			; close spool/exec files via OSBYTE 77
			jsr	_LF478				; tidy up
_BF3DD:			lsr	CRFS_STATUS			; CFS status byte is shifted left and right to zero
			asl	CRFS_STATUS			; bit 0
			bcc	_BF3EF				; and if carry clear no input file was open so F3EF

_BF3E3:			lsr					; A contains file handle so shift bit 0 into carry
			bcs	_BF3DD				; if carry set close input file
			lsr					; else shift bit 1 into carry
			bcs	_BF3EC				; if carry set close output file
			jmp	_LFBB1				; else report 'Channel Error' as CFS can only support
								; 1 input and 1 output file

_BF3EC:			jsr	_LF478				; tidy up
_BF3EF:			jmp	_LF471				; and exit

;************ OPEN A FILE ************************************************

_BF3F2:			jsr	_LF25A				; get filename from BUFFER
			bit	CRFS_BLK_OFFSET			; file status or temporary store
			bvc	_BF436				; check A at input if bit 6 not set its an output file

;********* Input files +**************************************************

			lda	#$00				; else its an input file
			sta	CFS_BGET_OFFSET			; BGET buffer offset for next byte
			sta	CFS_BLK_GET			; Expected BGET file block number lo
			sta	CFS_BLK_GET_HI			; expected BGET file block number hi
			lda	#$3e				; A=&3E
			jsr	_LF33D				; CFS status =CFS status AND A
			jsr	_LFB1A				; claim serial system and set OPTions
			php					; save flags on stack
			jsr	_LF631				; search for file
			jsr	_LF6B4				; check protection bit of block status and respond
			plp					; get back flags
			ldx	#$ff				; X=&FF increment to 0 on next instruction

_BF416:			inx					; X=X+1
			lda	CFS_FILENAME,X			; get file name and
			sta	CFS_BGET_FILE,X			; store as BGET filename
			bne	_BF416				; until end of filename

			lda	#$01				; A=1 to show file open
			jsr	_LF344				; set status bits from A
			lda	CFS_BLOCK_SZ			; CFS currently resident file block length lo
			ora	CFS_BLOCK_SZ_HI			; CFS currently resident file block length hi
			bne	_BF42F				; if block length is 0
			jsr	_LF342				; set CFS status bit 3 (EOF reached)
								; else
_BF42F:			lda	#$01				; A=1
			ora	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			bne	_LF46F				; and exit after restoring registers

;******************* open an output file***********************************

_BF436:			txa					; A=X

			bne	_BF43C				; if X=0 then zero length filename so
			jmp	_LEA8F				; Bad String error

_BF43C:			ldx	#$ff				; X=&FF
_BF43E:			inx					; X=X+1
								; copy sought filename to header block
			lda	CFS_FIND_NAME,X			; sought filename
			sta	BPUT_FILENAME,X			; BPUT file header block
			bne	_BF43E				; until A=0 end of filename
			lda	#$ff				; A=&FF
			ldx	#$08				; X=8

_BF44B:			sta	BPUT_LOAD_LO-1,X		; set 38C/93 to &FF
			dex					; X=X-1
			bne	_BF44B				; 

			txa					; A=X=0
			ldx	#$14				; X=14
_BF454:			sta	BPUT_FILENAME,X			; BPUT file header block
			inx					; X=X+1
			cpx	#$1e				; this zeros 394/D
			bne	_BF454				; 

			rol	BPUT_BLK_LEN_HI			; 
			jsr	_CFS_CLAIM_SERIAL		; Set cassette optionsinto (BB),set C7=6
								; claim serial system for cassette
			jsr	_LF934				; prompt to start recording
			jsr	_LFAF2				; enable second processor and reset serial system
			lda	#$02				; A=2
			jsr	_LF344				; set status bits from A
			lda	#$02				; A=2
_LF46F:			sta	CRFS_BLK_OFFSET			; file status or temporary store
_LF471:			pla					; get back A
			tay					; Y=A
			pla					; get back A
			tax					; X=A
			lda	CRFS_BLK_OFFSET			; file status or temporary store
_BF477:			rts					; return
								;

_LF478:			lda	#$02				; A=2 clearing all but bit 1 of status byte
			and	CRFS_STATUS			; CFS status byte, with output file open
			beq	_BF477				; if file not open then exit
			lda	#$00				; else A=0
			sta	BPUT_BLK_LEN_HI			; setting block length to current value of BPUT offset
			lda	#$80				; A=&80
			ldx	CFS_BPUT_OFFSET			; get BPUT buffer ofset
			stx	BPUT_BLK_LEN			; setting block length to current value of BPUT offset
			sta	BPUT_BLK_FLAG			; mark current block as last
			jsr	_LF496				; save block to tape
			lda	#$fd				; A=&FD
			jmp	_LF33D				; CFS status =CFS status AND A

;*********** SAVE BLOCK TO TAPE ********************************************

_LF496:			jsr	_LFB1A				; claim serial system and set OPTions

			ldx	#$11				; X=11
_BF49B:			lda	BPUT_LOAD_LO,X			; copy header block from 38C-39D
			sta	CFS_LOAD_LO,X			; to 3BE/DF
			dex					; X=X-1
			bpl	_BF49B				; 
								; X=&FF
			stx	CRFS_LOAD_VHI			; current load address high word
			stx	CRFS_LOAD_XHI			; current load address high word
			inx					; X=X+1, (X=0)
			stx	CRFS_LOAD			; current load address lo byte set to &00
			lda	#$09				; A=9 to set current load address at &900
			sta	CRFS_LOAD_HI			; current load address
			ldx	#$7f				; X=&7F
			jsr	_LFB81				; copy from 301/C+X to 3D2/C sought filename
			sta	CFS_LAST_FLAGS			; copy of last read block flag
			jsr	_LFB8E				; switch Motor On
			jsr	_LFBE2				; set up CFS for write operation
			jsr	_LF7EC				; write block to Tape
			inc	BPUT_BLK_NUM			; block number lo
			bne	_BF4C8				; 
			inc	BPUT_BLK_NUM_HI			; block number hi
_BF4C8:			rts					; return


;*************************************************************************
;*									 *
;*									 *
;*	 OSBGET	 get a byte from a file					 *
;*									 *
;*									 *
;*************************************************************************
				; on ENTRY	 Y contains channel number
				; on EXIT	 X and Y are preserved C=0 indicates valid character
				; A contains character (or error) A=&FE End Of File

				; push X and Y
_BGETV:			txa					; A=X
			pha					; save A on stack
			tya					; A=Y
			pha					; save A on stack
			lda	#$01				; A=1
			jsr	_LFB9C				; check conditions for OSBGET are OK
			lda	CRFS_STATUS			; CFS status byte
			asl					; shift bit 7 into carry (EOF warning given)
			bcs	_BF523				; if carry set F523
			asl					; shift bit 6 into carry
			bcc	_BF4E3				; if clear EOF not reached F4E3
			lda	#$80				; else A=&80 setting bit 7 of status byte EOF warning
			jsr	_LF344				; set status bits from A
			lda	#$fe				; A=&FE
			bcs	_BF51B				; if carry set F51B

_BF4E3:			ldx	CFS_BGET_OFFSET			; BGET buffer offset for next byte
			inx					; X=X+1
			cpx	CFS_BLOCK_SZ			; CFS currently resident file block length lo
			bne	_BF516				; read a byte
								; else
			bit	CFS_BLOCK_FLAG			; block flag of currently resident block
			bmi	_BF513				; if bit 7=1 this is the last block so F513 else
			lda	CFS_LAST_INPUT			; last character of currently resident block
			pha					; save A on stack
			jsr	_LFB1A				; claim serial system and set OPTions
			php					; save flags on stack
			jsr	_LF6AC				; read in a new block
			plp					; get back flags
			pla					; get back A
			sta	CRFS_BLK_OFFSET			; file status or temporary store
			clc					; clear carry flag
			bit	CFS_BLOCK_FLAG			; block flag of currently resident block
			bpl	_BF51D				; if not last block (bit 7=0)
			lda	CFS_BLOCK_SZ			; CFS currently resident file block length lo
			ora	CFS_BLOCK_SZ_HI			; CFS currently resident file block length hi
			bne	_BF51D				; if block size not 0 F51D else
			jsr	_LF342				; set CFS status bit 6 (EOF reached)
			bne	_BF51D				; goto F51D

_BF513:			jsr	_LF342				; set CFS status bit 6 (EOF reached)
_BF516:			dex					; X=X-1
			clc					; clear carry flag
			lda	BUFFER_RS423_RX,X		; read byte from cassette buffer

_BF51B:			sta	CRFS_BLK_OFFSET			; file status or temporary store
_BF51D:			inc	CFS_BGET_OFFSET			; BGET buffer offset for next byte
			jmp	_LF471				; exit via F471

_BF523:			brk					; 
			.byte	$df				; error number
			.byte	"EOF"				; 
			brk					; 


;*************************************************************************
;*									 *
;*									 *
;*	 OSBPUT	 WRITE A BYTE TO FILE					 *
;*									 *
;*									 *
;*************************************************************************
;ON ENTRY  Y contains channel number A contains byte to be written

_BPUTV:			sta	CRFS_TMP			; store A in temorary store
			txa					; and stack X and Y
			pha					; save	on stack
			tya					; A=Y
			pha					; save on stack

			lda	#$02				; A=2
			jsr	_LFB9C				; check conditions necessary for OSBPUT are OK
			ldx	CFS_BPUT_OFFSET			; BPUT buffer offset for next byte
			lda	CRFS_TMP			; get back original value of A
			sta	BUFFER_RS423_TX,X		; Cassette buffer
			inx					; X=X+1
			bne	_BF545				; if not 0 F545, otherwise buffer is full so
			jsr	_LF496				; save block to tape
			jsr	_LFAF2				; enable second processor and reset serial system
_BF545:			inc	CFS_BPUT_OFFSET			; BPUT buffer offset for next byte
			lda	CRFS_TMP			; get back A
			jmp	_LF46F				; and exit


;*************************************************************************
;*									 *
;*									 *
;*	 OSBYTE 139	 Select file options				 *
;*									 *
;*									 *
;*************************************************************************
;ON ENTRY  Y contains option value  X contains option No. see *OPT X,Y
;this applies largely to CFS LOAD SAVE CAT and RUN
;X=1	is message switch
;	Y=0 no messages
;	Y=1 short messages
;	Y=2 gives detailed information on load and execution addresses

;X=2	is error handling
;	Y=0 ignore errors
;	Y=1 prompt for a retry
;	Y=2 abort operation

;X=3	is interblock gap for BPUT# and PRINT#
;	Y=0-127 set gap in 1/10ths Second
;	Y > 127 use default values

_FSCV_OPT:		txa					; A=X
			beq	_BF57E				; if A=0 F57E
			cpx	#$03				; if X=3
			beq	_BF573				; F573 to set interblock gap
			cpy	#$03				; else if Y>2 then BAD COMMAND error
			bcs	_BF55E				; 
			dex					; X=X-1
			beq	_BF561				; i.e. if X=1 F561 message control
			dex					; X=X-1
			beq	_BF568				; i.e. if X=2 F568 error response
_BF55E:			jmp	_USERV				; else E310 to issue Bad Command error

;*********** message control *********************************************

_BF561:			lda	#$33				; to set lower two bits of each nybble as mask
			iny					; Y=Y+1
			iny					; Y=Y+1
			iny					; Y=Y+1
			bne	_BF56A				; goto F56A

;*********** error response *********************************************

_BF568:			lda	#$cc				; setting top two bits of each nybble as mask
_BF56A:			iny					; Y=Y+1
			and	CRFS_OPTIONS			; clear lower two bits of each nybble
_BF56D:			ora	_LF581,Y			; or with table value
			sta	CRFS_OPTIONS			; store it in &E3
			rts					; return

				; setting of &E3
				;
				; lower nybble sets LOAD options
				; upper sets SAVE options

				; 0000	 Ignore errors,		 no messages
				; 0001	 Abort if error,	 no messages
				; 0010	 Retry after error,	 no messages
				; 1000	 Ignore error		 short messages
				; 1001	 Abort if error		 short messages
				; 1010	 Retry after error	 short messages
				; 1100	 Ignore error		 long messages
				; 1101	 Abort if error		 long messages
				; 1110	 Retry after error	 long messages

;***********set interblock gap *******************************************

_BF573:			tya					; A=Y
			bmi	_BF578				; if Y>127 use default values
			bne	_BF57A				; if Y<>0 skip next instruction
_BF578:			lda	#$19				; else A=&19

_BF57A:			sta	SEQ_BLOCK_GAP			; sequential block gap
			rts					; return
								;
_BF57E:			tay					; Y=A
			beq	_BF56D				; jump to F56D

;*********** DEFAULT OPT VALUES TABLE ************************************

_LF581:			.byte	$a1				; %1010 0001
			.byte	$00				; %0000 0000
			.byte	$22				; %0010 0010
			.byte	$11				; %0001 0001
			.byte	$00				; %0000 0000
			.byte	$88				; %1000 1000
			.byte	$cc				; %1100 1100

_CRFS_READ:		dec	CRFS_BUFFER_FLAG		; filing system buffer flag
			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	__crfs_read_acia		; if CFS F596

			jsr	_RFS_READ_ROM			; read RFS data rom or Phrom
			tay					; Y=A
			clc					; clear carry flag
			bcc	_BF5B0				; jump to F5B0

__crfs_read_acia:	lda	ACIA_CSR			; ACIA status register
			pha					; save A on stack
			and	#$02				; clear all but bits 0,1 A=(0-3)
			beq	_BF5A9				; if 0 F5A9 transmit data register full or RDR empty
			ldy	CFS_SERIAL_CTRL			; 
			beq	_BF5A9				; 
			pla					; get back A
			lda	CRFS_BLK_LAST			; character temporary storage
			sta	ACIA_TXRX			; ACIA transmit data register
			rts					; return
								;
_BF5A9:			ldy	ACIA_TXRX			; read ACIA recieve data register
			pla					; get back A
			lsr					; bit 2 to carry (data carrier detect)
			lsr					; 
			lsr					; 

_BF5B0:			ldx	CRFS_PROGRESS			; progress flag
			beq	_BF61D				; if &C2=0 exit
			dex					; X=X-1
			bne	_BF5BD				; if &C2>1 then F5BD
			bcc	_BF61D				; else if carrier tone from cassette detected exit

			ldy	#$02				; Y=2

			bne	_BF61B				; 
_BF5BD:			dex					; X=X-1
			bne	_BF5D3				; if &C2>2
			bcs	_BF61D				; if carrier tone from cassette not detected  exit
			tya					; A=Y
			jsr	_LFB78				; set (BE/C0) to 0
			ldy	#$03				; Y=3
			cmp	#$2a				; is A= to synchronising byte &2A?
			beq	_BF61B				; if so F61B
			jsr	_LFB50				; control cassette system
			ldy	#$01				; Y=1
			bne	_BF61B				; goto F61B
_BF5D3:			dex					; X=X-1
			bne	_BF5E2				; if &C2>3
			bcs	_BF5DC				; 
			sty	CRFS_BLK_LAST			; get character read into Y
			beq	_BF61D				; if 0 exit via F61D
_BF5DC:			lda	#$80				; else A=&80
			sta	CRFS_BUFFER_FLAG		; filing system buffer flag
			bne	_BF61D				; and exit

_BF5E2:			dex					; X=X-1
			bne	_BF60E				; if &C2>4 F60E
			bcs	_BF616				; if carry set F616
			tya					; A=Y
			jsr	_LF7B0				; perform CRC
			ldy	CRFS_BLK_OFFSET			; file status or temporary store
			inc	CRFS_BLK_OFFSET			; file status or temporary store
			bit	CRFS_BLK_LAST			; if bit 7 set this is the last byte read
			bmi	_BF600				; so F600
			jsr	_LFBD3				; check if second processor file test tube prescence
			beq	_BF5FD				; if return with A=0 F5FD
			stx	TUBE_FIFO3			; Tube FIFO3
			bne	_BF600				; 

_BF5FD:			txa					; A=X restore value
			sta	(CRFS_LOAD),Y			; store to current load address
_BF600:			iny					; Y=Y+1
			cpy	CFS_BLK_LEN			; block length
			bne	_BF61D				; exit
			lda	#$01				; A=1
			sta	CRFS_BLK_OFFSET			; file status or temporary store
			ldy	#$05				; Y=5
			bne	_BF61B				; exit

_BF60E:			tya					; A=Y
			jsr	_LF7B0				; perform CRC
			dec	CRFS_BLK_OFFSET			; file status or temporary store
			bpl	_BF61D				; exit

_BF616:			jsr	_RESET_ACIA			; reset ACIA
			ldy	#$00				; Y=0
_BF61B:			sty	CRFS_PROGRESS			; progress flag
_BF61D:			rts					; return


;*************************************************************************
;*									 *
;*	 FSCV &01 - check for end of file				 *
;*									 *
;*************************************************************************
				;
_FSCV_EOF:		pha					; save A on stack
			tya					; A=Y
			pha					; save Y on stack
			txa					; A=X to put X into Y
			tay					; Y=A
			lda	#$03				; A=3
			jsr	_LFB9C				; confirm file is open
			lda	CRFS_STATUS			; CFS status byte
			and	#$40				; 
			tax					; X=A
			pla					; get back A
			tay					; Y=A
			pla					; get back A
			rts					; return
								;
_LF631:			lda	#$00				; A=0
			sta	CRFS_EXEC			; current block no. lo
			sta	CRFS_EXEC_HI			; current block no. hi
_LF637:			lda	CRFS_EXEC			; current block no. lo
			pha					; save A on stack
			sta	CRFS_NEXT_BLK			; next block no. lo
			lda	CRFS_EXEC_HI			; current block no. hi
			pha					; save A on stack
			sta	CRFS_NEXT_BLK_HI		; next block no. hi
			jsr	_CRFS_PRINT_MSG			; print message following call

			.byte	"Searching"			; 
			.byte	$0d				; newline
			brk					; 

			lda	#$ff				; A=&FF
			jsr	_LF348				; read data from CFS/RFS
			pla					; get back A
			sta	CRFS_EXEC_HI			; current block no. hi
			pla					; get back A
			sta	CRFS_EXEC			; current block no. lo
			lda	CRFS_NEXT_BLK			; next block no. lo
			ora	CRFS_NEXT_BLK_HI		; next block no. hi
			bne	_BF66D				; 
			sta	CRFS_EXEC			; current block no. lo
			sta	CRFS_EXEC_HI			; current block no. hi
			lda	CRFS_CRC_RESULT			; checksum result
			bne	_BF66D				; 
			ldx	#$b1				; current load address
			jsr	_LFB81				; copy from 301/C+X to 3D2/C sought filename
_BF66D:			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_BF685				; if cassette F685
			bvs	_BF685				; 

_BF674:			brk					; 
			.byte	$d6				; Error number
			.byte	"File not found"		
			brk					; 

_BF685:			ldy	#$ff				; Y=&FF
			sty	CFS_LAST_FLAGS			; copy of last read block flag
			rts					; return


;********  CLOSE EXEC FILE  **********************************************

			.org	$f68b

_LF68B:			lda	#$00				; A=0

;*************************************************************************
;*									 *
;*	 *EXEC								 *
;*									 *
;*************************************************************************

_OSCLI_EXEC:		php					; save flags on stack
			sty	MOS_WS				; &E6=Y
			ldy	OSB_EXEC_HND			; EXEC file handle
			sta	OSB_EXEC_HND			; EXEC file handle
			beq	_BF69B				; if not 0 close file via OSFIND
			jsr	OSFIND				; 
_BF69B:			ldy	MOS_WS				; else Y= original Y
			plp					; get back flags
			beq	_BF6AB				; if A=0 on entry exit else
			lda	#$40				; A=&40
			jsr	OSFIND				; to open an input file
			tay					; Y=A
			beq	_BF674				; If Y=0 'File not found' else store
			sta	OSB_EXEC_HND			; EXEC file handle
_BF6AB:			rts					; return

;******* read a block	 *************************************************

_LF6AC:			ldx	#$a6				; X=&A6
			jsr	_LFB81				; copy from 301/C+X to 3D2/C sought filename
			jsr	_LF77B				; read block header
_LF6B4:			lda	CFS_BLK_FLAG			; block flag
			lsr					; A=A/2 bit 0 into carry to check for locked file
			bcc	_BF6BD				; if not set then skip next instruction
			jmp	_LF1F6				; 'locked' file routine

_BF6BD:			lda	CFS_BLK_GET			; Expected BGET file block number lo
			sta	CRFS_EXEC			; current block no. lo
			lda	CFS_BLK_GET_HI			; expected BGET file block number hi
			sta	CRFS_EXEC_HI			; current block no. hi
			lda	#$00				; A=0
			sta	CRFS_LOAD			; current load address
			lda	#$0a				; A=&A setting current load address to the CFS/RFS
			sta	CRFS_LOAD_HI			; current load address buffer at &A00
			lda	#$ff				; A=&FF to set other 2 bytes
			sta	CRFS_LOAD_VHI			; current load address high word
			sta	CRFS_LOAD_XHI			; current load address high word
			jsr	_LF7D5				; reset flags
			jsr	_CRFS_LOAD_FILE			; load file from tape
			bne	_BF702				; if return non zero F702 else
			lda	BUFFER_RS423_RX+$FF		; get last character from input buffer
			sta	CFS_LAST_INPUT			; last character currently resident block
			jsr	_LFB69				; inc. current block no.
			stx	CFS_BLK_GET			; expected BGET file block number lo
			sty	CFS_BLK_GET_HI			; expected BGET file block number hi
			ldx	#$02				; X=2
_BF6EE:			lda	CFS_BLK_LEN,X			; read bytes from block flag/block length
			sta	CFS_BLOCK_SZ,X			; store into current values of above
			dex					; X=X-1
			bpl	_BF6EE				; until X=-1 (&FF)

			bit	CFS_BLOCK_FLAG			; block flag of currently resident block
			bpl	_BF6FF				; 
			jsr	_LF249				; print newline if needed
_BF6FF:			jmp	_LFAF2				; enable second processor and reset serial system
_BF702:			jsr	_LF637				; search for a specified block
			bne	_LF6B4				; if NE check for locked condition else
_BF707:			cmp	#$2a				; is it Synchronising byte &2A?
			beq	_BF742				; if so F742
			cmp	#$23				; else is it &23 (header substitute in ROM files)
			bne	_BF71E				; if not BAD ROM error

			inc	CFS_BLK_NUM			; block number
			bne	_BF717				; 
			inc	CFS_BLK_NUM_HI			; block number hi
_BF717:			ldx	#$ff				; X=&FF
			bit	_BD9B7				; to set V & M
			bne	_BF773				; and jump (ALWAYS!!) to F773

_BF71E:			lda	#$f7				; clear bit 3 of RFS status (current CAT status)
			jsr	_LF33D				; RFS status =RFS status AND A

			brk					; and cause error
			.byte	$d7				; error number
			.byte	"Bad ROM"			
			brk					; 

;**********: pick up a header ********************************************

_BF72D:			ldy	#$ff				; get ESCAPE flag
			jsr	_LFB90				; switch Motor on
			lda	#$01				; A=1
			sta	CRFS_PROGRESS			; progress flag
			jsr	_LFB50				; control serial system
_BF739:			jsr	_CFS_READY			; confirm ESC not set and CFS not executing
			lda	#$03				; A=3
			cmp	CRFS_PROGRESS			; progress flag
			bne	_BF739				; back until &C2=3

_BF742:			ldy	#$00				; Y=0
			jsr	_LFB7C				; zero checksum bytes
_BF747:			jsr	_LF797				; get character from file and do CRC
			bvc	_BF766				; if V clear on exit F766
			sta	CFS_FILENAME,Y			; else store
			beq	_BF757				; or if A=0 F757
			iny					; Y=Y+1
			cpy	#$0b				; if Y<>&B
			bne	_BF747				; go back for next character
			dey					; Y=Y-1

_BF757:			ldx	#$0c				; X=12
_BF759:			jsr	_LF797				; get character from file and do CRC
			bvc	_BF766				; if V clear on exit F766
			sta	CFS_FILENAME,X			; else store byte
			inx					; X=X+1
			cpx	#$1f				; if X<>31
			bne	_BF759				; goto F759

_BF766:			tya					; A=Y
			tax					; X=A
			lda	#$00				; A=0
			sta	CFS_FILENAME,Y			; store it
			lda	CRFS_CRC_TMP			; CRC workspace
			ora	CRFS_CRC_TMP_HI			; CRC workspace
			sta	CRFS_CRC_RESULT			; Checksum result
_BF773:			jsr	_LFB78				; set (BE/C0) to 0
			sty	CRFS_PROGRESS			; progress flag
			txa					; A=X
			bne	_BF7D4				; 
_LF77B:			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_BF72D				; if cassette F72D
_BF780:			jsr	_RFS_READ_ROM			; read RFS data rom or Phrom
			cmp	#$2b				; is it ROM file terminator?
			bne	_BF707				; if not F707

;********* terminator found **********************************************

			lda	#$08				; A=8 isolating bit 3 CAT status
			and	CRFS_STATUS			; CFS status byte
			beq	_BF790				; if clera skip next instruction
			jsr	_CRFS_PRINT_NEWLINE		; print CR if CFS not operational
_BF790:			jsr	_LEE18				; get byte from data Rom
			bcc	_BF780				; if carry set F780
			clv					; clear overflow flag
			rts					; return

;****************  get character from file and do CRC  *******************
				;
_LF797:			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_BF7AD				; if cassette F7AD
			txa					; A=X to save X and Y
			pha					; save X on stack
			tya					; A=Y
			pha					; save Y on stack
			jsr	_RFS_READ_ROM			; read RFS data rom or Phrom
			sta	CRFS_BLK_LAST			; put it in temporary storage
			lda	#$ff				; A=&FF
			sta	CRFS_BUFFER_FLAG		; filing system buffer flag
			pla					; get back Y
			tay					; Y=A
			pla					; get back X
			tax					; X=A
_BF7AD:			jsr	_LF884				; check for Escape and loop till bit 7 of FS buffer
								; flag=1

;************************** perform CRC **********************************

_LF7B0:			php					; save flags on stack
			pha					; save A on stack
			sec					; set carry flag
			ror	CRFS_CRC_BIT_CNT		; CRC Bit counter
			eor	CRFS_CRC_TMP_HI			; CRC workspace
			sta	CRFS_CRC_TMP_HI			; CRC workspace
_BF7B9:			lda	CRFS_CRC_TMP_HI			; CRC workspace
			rol					; A=A*2 C=bit 7
			bcc	_BF7CA				; 
			ror					; A=A/2
			eor	#$08				; 
			sta	CRFS_CRC_TMP_HI			; CRC workspace
			lda	CRFS_CRC_TMP			; CRC workspace
			eor	#$10				; 
			sta	CRFS_CRC_TMP			; CRC workspace
			sec					; set carry flag

_BF7CA:			rol	CRFS_CRC_TMP			; CRC workspace
			rol	CRFS_CRC_TMP_HI			; CRC workspace
			lsr	CRFS_CRC_BIT_CNT		; CRC Bit counter
			bne	_BF7B9				; 
			pla					; get back A
			plp					; get back flags
_BF7D4:			rts					; return

_LF7D5:			lda	#$00				; A=0
_LF7D7:			sta	CRFS_BLK_LAST			; &BD=character temporary storage buffer=0
			ldx	#$00				; X=0
			stx	CRFS_BLK_OFFSET			; file status or temporary store
			bvc	_BF7E9				; 
			lda	CFS_BLK_LEN			; block length
			ora	CFS_BLK_LEN_HI			; block length hi
			beq	_BF7E9				; if 0 F7E9

			ldx	#$04				; else X=4
_BF7E9:			stx	CRFS_PROGRESS			; filename length/progress flag
			rts					; return

;*************** SAVE A BLOCK ********************************************

_LF7EC:			php					; save flags on stack
			ldx	#$03				; X=3
			lda	#$00				; A=0
_BF7F1:			sta	CFS_RFS_LO,X			; clear 03CB/E (RFS EOF+1?)
			dex					; X=X-1
			bpl	_BF7F1				; 

			lda	CFS_BLK_NUM			; block number
			ora	CFS_BLK_NUM_HI			; block number hi
			bne	_BF804				; if block =0 F804 else
			jsr	_CFS_DELAY_5_S			; generate a 5 second delay
			beq	_BF807				; goto F807


_BF804:			jsr	_CFS_DELAY_INTERBLOCK		; generate delay set by interblock gap
_BF807:			lda	#$2a				; A=&2A
			sta	CRFS_BLK_LAST			; store it in temporary file
			jsr	_LFB78				; set (BE/C0) to 0
			jsr	_SET_ACIA_CONTROL		; set ACIA control register
			jsr	_LF884				; check for Escape and loop till bit 7 of FS buffer
								; flag=1
			dey					; Y=Y-1
_BF815:			iny					; Y=Y+1
			lda	CFS_FIND_NAME,Y			; move sought filename
			sta	CFS_FILENAME,Y			; into filename block
			jsr	_LF875				; transfer byte to CFS and do CRC
			bne	_BF815				; if filename not complet then do it again

;******: deal with rest of header ****************************************

			ldx	#$0c				; X=12
_BF823:			lda	CFS_FILENAME,X			; get filename byte
			jsr	_LF875				; transfer byte to CFS and do CRC
			inx					; X=X+1
			cpx	#$1d				; until X=29
			bne	_BF823				; 

			jsr	_LF87B				; save checksum to TAPE reset buffer flag
			lda	CFS_BLK_LEN			; block length
			ora	CFS_BLK_LEN_HI			; block length hi
			beq	_BF855				; if 0 F855

			ldy	#$00				; else Y=0
			jsr	_LFB7C				; zero checksum bytes
_BF83E:			lda	(CRFS_LOAD),Y			; get a data byte
			jsr	_LFBD3				; check if second processor file test tube prescence
			beq	_BF848				; if not F848 else

			ldx	TUBE_FIFO3			; Tube FIFO3

_BF848:			txa					; A=X
			jsr	_LF875				; transfer byte to CFS and do CRC
			iny					; Y=Y+1
			cpy	CFS_BLK_LEN			; block length
			bne	_BF83E				; 
			jsr	_LF87B				; save checksum to TAPE reset buffer flag
_BF855:			jsr	_LF884				; check for Escape and loop till bit 7 of FS buffer
								; flag=1
			jsr	_LF884				; check for Escape and loop till bit 7 of FS buffer
								; flag=1
			jsr	_RESET_ACIA			; reset ACIA

			lda	#$01				; A=1
			jsr	_CFS_DELAY_100_MS		; generate 0.1 * A second delay
			plp					; get back flags
			jsr	_CRFS_PRINT_FILENAME		; update block flag, PRINT filename (& address if reqd)
			bit	CFS_BLK_FLAG			; block flag
			bpl	_BF874				; is this last block (bit 7 set)?
			php					; save flags on stack
			jsr	_CFS_DELAY_5_S			; generate a 5 second delay
			jsr	_LF246				; sound bell and abort
			plp					; get back flags
_BF874:			rts					; return

;****************** transfer byte to CFS and do CRC **********************
				;
_LF875:			jsr	_LF882				; save byte to buffer, transfer to CFS & reset flag
			jmp	_LF7B0				; perform CRC

;***************** save checksum to TAPE reset buffer flag ****************

_LF87B:			lda	CRFS_CRC_TMP_HI			; CRC workspace
			jsr	_LF882				; save byte to buffer, transfer to CFS & reset flag
			lda	CRFS_CRC_TMP			; CRC workspace

;************** save byte to buffer, transfer to CFS & reset flag ********

_LF882:			sta	CRFS_BLK_LAST			; store A in temporary buffer

;***** check for Escape and loop untill bit 7 of FS buffer flag=1 ***********

_LF884:			jsr	_CFS_READY			; confirm ESC not set and CFS not executing
			bit	CRFS_BUFFER_FLAG		; filing system buffer flag
			bpl	_LF884				; loop until bit 7 of &C0 is set

			lda	#$00				; A=0
			sta	CRFS_BUFFER_FLAG		; filing system buffer flag
			lda	CRFS_BLK_LAST			; get temporary store byte
			rts					; return

;****************** generate a 5 second delay  ***************************

_CFS_DELAY_5_S:		lda	#$32				; A=50
			bne	_CFS_DELAY_100_MS		; generate delay 100ms *A (5 seconds)

;*************** generate delay set by interblock gap ********************

_CFS_DELAY_INTERBLOCK:	lda	CFS_INTERBLOCK			; get current interblock flag

;*************** generate delay ******************************************

_CFS_DELAY_100_MS:	ldx	#$05				; X=5
_BF89A:			sta	OSB_CFS_TIMEOUT			; CFS timeout counter
_BF89D:			jsr	_CFS_READY			; confirm ESC not set and CFS not executing
			bit	OSB_CFS_TIMEOUT			; CFS timeout counter (decremented each 20ms)
			bpl	_BF89D				; if +ve F89D
			dex					; X=X-1
			bne	_BF89A				; 
			rts					; return

;************: generate screen reports ***********************************

_LF8A9:			lda	CFS_BLK_NUM			; block number
			ora	CFS_BLK_NUM_HI			; block number hi
			beq	_LF8B6				; if 0 F8B6
			bit	CFS_LAST_FLAGS			; copy of last read block flag
			bpl	_CRFS_PRINT_FILENAME		; update block flag, PRINT filename (& address if reqd)
_LF8B6:			jsr	_LF249				; print newline if needed

;************** update block flag, PRINT filename (& address if reqd) ****

_CRFS_PRINT_FILENAME:	ldy	#$00				; Y=0
			sty	CRFS_BLOCK_FLAG			; current block flag
			lda	CFS_BLK_FLAG			; block flag
			sta	CFS_LAST_FLAGS			; copy of last read block flag
			jsr	_CFS_CHECK_BUSY			; check if free to print message
			beq	_BF933				; if A=0 on return Cassette system is busy
			lda	#$0d				; else A=&0D :carriage return
			jsr	OSWRCH				; print it (note no linefeed as it's via OSWRCH)
__crfs_print_nextch:	lda	CFS_FILENAME,Y			; get byte from filename
			beq	_BF8E2				; if 0 filename is ended
			cmp	#$20				; if <SPACE
			bcc	__crfs_print_ctrlch		; F8DA
			cmp	#$7f				; if less than DELETE
			bcc	__crfs_print_filech		; its a printable character for F8DC else

;*******************Control characters in RFS/CFS filename ******************

__crfs_print_ctrlch:	lda	#$3f				; else A='?'
__crfs_print_filech:	jsr	OSWRCH				; and print it

			iny					; Y=Y+1
			bne	__crfs_print_nextch		; back to get rest of filename

;***************** end of filename ***************************************

_BF8E2:			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_BF8EB				; if cassette F8EB
			bit	CRFS_OPTS			; test current OPTions
			bvc	_BF933				; if bit 6 clear no,long messages needed F933
_BF8EB:			jsr	_PRINT_SPACE			; print a space
			iny					; Y=Y+1
			cpy	#$0b				; if Y<11 then
			bcc	_BF8E2				; loop again to fill out filename with spaces

			lda	CFS_BLK_NUM			; block number
			tax					; X=A
			jsr	_PRINT_HEX			; print ASCII equivalent of hex byte
			bit	CFS_BLK_FLAG			; block flag
			bpl	_BF933				; if not end of file return
			txa					; A=X
			clc					; clear carry flag
			adc	CFS_BLK_LEN_HI			; block length hi
			sta	CRFS_FILE_SIZE_HI		; file length counter hi
			jsr	_PRINT_SPACE_HEX		; print space + ASCII equivalent of hex byte
			lda	CFS_BLK_LEN			; block length
			sta	CRFS_FILE_SIZE			; file length counter lo
			jsr	_PRINT_HEX			; print ASCII equivalent of hex byte
			bit	CRFS_OPTS			; current OPTions
			bvc	_BF933				; if bit 6 clear no long messages required so F933

			ldx	#$04				; X=4
_BF917:			jsr	_PRINT_SPACE			; print a space
			dex					; X=X-1
			bne	_BF917				; loop to print 4 spaces

			ldx	#$0f				; X=&0F to point to load address
			jsr	_LF927				; print 4 bytes from CFS block header
			jsr	_PRINT_SPACE			; print a space
			ldx	#$13				; X=&13 point to Execution address

;************** print 4 bytes from CFS block header **********************

_LF927:			ldy	#$04				; loop pointer
_BF929:			lda	CFS_FILENAME,X			; block header
			jsr	_PRINT_HEX			; print ASCII equivalent of hex byte
			dex					; X=X-1
			dey					; Y=Y-1
			bne	_BF929				; 

_BF933:			rts					; return

;*********** print prompt for SAVE on TAPE *******************************

_LF934:			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_BF93C				; if cassette F93C
			jmp	_USERV				; else 'Bad Command error message'
_BF93C:			jsr	_LFB8E				; switch Motor On
			jsr	_LFBE2				; set up CFS for write operation
			jsr	_CFS_CHECK_BUSY			; check if free to print message
			beq	_BF933				; if not exit else
			jsr	_CRFS_PRINT_MSG			; print message following call

			.byte	"RECORD then RETURN"		; 
			brk					; 

;************ wait for RETURN key to be pressed **************************

_WAIT_FOR_RETURN:	jsr	_CFS_READY			; confirm CFS not operating, nor ESCAPE flag set
			jsr	OSRDCH				; wait for keypress
			cmp	#$0d				; is it &0D (RETURN)
			bne	_WAIT_FOR_RETURN		; no then do it again

			jmp	OSNEWL				; output Carriage RETURN and LINE FEED

;************* increment current load address ****************************

_INC_LOAD_ADDRESS:	inc	CRFS_LOAD_HI			; current load address
			bne	_BF974				; 
			inc	CRFS_LOAD_VHI			; current load address high word
			bne	_BF974				; 
			inc	CRFS_LOAD_XHI			; current load address high word
_BF974:			rts					; return

;************* print a space + ASCII equivalent of hex byte **************

_PRINT_SPACE_HEX:	pha					; save A on stack
			jsr	_PRINT_SPACE			; print a space
			pla					; get back A

;************** print ASCII equivalent of hex byte  **********************

_PRINT_HEX:		pha					; save A on stack
			lsr					; /16 to put high nybble in lo
			lsr					; 
			lsr					; 
			lsr					; 
			jsr	_PRINT_HEX_NYBBLE		; print its ASCII equivalent
			pla					; get back A

_PRINT_HEX_NYBBLE:	clc					; clear carry flag
			and	#$0f				; clear high nybble
			adc	#$30				; Add &30 to convert 0-9 to ASCII A-F to : ; < = > ?
			cmp	#$3a				; if A< ASC(':')
			bcc	__print_hex_done		; goto F98E
			adc	#$06				; else add 7 to convert : ; < = > ? to A B C D E F

__print_hex_done:	jmp	OSWRCH				; print character and return

;******************** print a space  *************************************

_PRINT_SPACE:		lda	#$20				; A=' '
			bne	__print_hex_done		; goto F98E to print it

;******************** confirm CFS not operating, nor ESCAPE flag set *****

_CFS_READY:		php					; save flags on stack
			bit	CRFS_ACTIVE			; CFS Active flag
			bmi	_BF99E				; 
			bit	ESCAPE_FLAG			; if ESCAPE condition
			bmi	_BF9A0				; goto F9A0
_BF99E:			plp					; get back flags
			rts					; return

_BF9A0:			jsr	_LF33B				; close input file
			jsr	_LFAF2				; enable second processor and reset serial system
			lda	#$7e				; A=&7E (126) Acknowledge ESCAPE
			jsr	OSBYTE				; OSBYTE Call

			brk					; 
			.byte	$11				; error 17
			.byte	"Escape"			; 
			brk					; 


; OS SERIES 10
; LAST PART
; GEOFF COX
;****************************** LOAD *************************************

			.org	$f9b4

_CRFS_LOAD_FILE:	tya					; A=Y
			beq	_BF9C4				; 
			jsr	_CRFS_PRINT_MSG			; print message following call

			.byte	$0d				; 
			.byte	"Loading"			; 
			.byte	$0d				; 
			brk					; 

_BF9C4:			sta	CRFS_BLOCK_FLAG			; current block flag
			ldx	#$ff				; X=&FF
			lda	CRFS_CRC_RESULT			; Checksum result
			bne	_LF9D9				; if not 0 F9D9
			jsr	_LFA72				; else check filename header block matches searched
								; filename if this returns NE then no match
			php					; save flags on stack
			ldx	#$ff				; X=&FF
			ldy	#$99				; Y=&99
			lda	#$fa				; A=&FA this set Y/A to point to 'File?' FA99
			plp					; get back flags
			bne	_BF9F5				; report a query unexpected file name

_LF9D9:			ldy	#$8e				; making Y/A point to 'Data' FA8E for CRC error
			lda	CRFS_CRC_RESULT			; Checksum result
			beq	_BF9E3				; if 0 F9E3
			lda	#$fa				; A=&FA
			bne	_BF9F5				; jump to F9F5

_BF9E3:			lda	CFS_BLK_NUM			; block number
			cmp	CRFS_EXEC			; current block no. lo
			bne	_BF9F1				; if not eual F9F1
			lda	CFS_BLK_NUM_HI			; block number hi
			cmp	CRFS_EXEC_HI			; current block no. hi
			beq	_BFA04				; if equal FA04

_BF9F1:			ldy	#$a4				; Y=&A4
			lda	#$fa				; A=&FA	 point to 'Block?' error unexpected block no.

				; at this point an error HAS occurred

_BF9F5:			pha					; save A on stack
			tya					; A=Y
			pha					; save Y on stack
			txa					; A=X
			pha					; save X on stack
			jsr	_LF8B6				; print CR if indicated by current block flag
			pla					; get back A
			tax					; X=A
			pla					; get back A
			tay					; Y=A
			pla					; get back A
			bne	_BFA18				; jump to FA18

_BFA04:			txa					; A=X
			pha					; save A on stack
			jsr	_LF8A9				; report
			jsr	_LFAD6				; check loading progress, read another byte
			pla					; get back A
			tax					; X=A
			lda	CRFS_CRC_TMP			; CRC workspace
			ora	CRFS_CRC_TMP_HI			; CRC workspace
			beq	_BFA8D				; 
			ldy	#$8e				; Y=&8E
			lda	#$fa				; A=&FA	 FA8E points to 'Data?'
_BFA18:			dec	CRFS_BLOCK_FLAG			; current block flag
			pha					; save A on stack
			bit	CRFS_ACTIVE			; CFS Active flag
			bmi	_BFA2C				; if active FA2C
			txa					; A=X
			and	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			bne	_BFA2C				; 
			txa					; A=X
			and	#$11				; 
			and	CRFS_OPTS			; current OPTions
			beq	_BFA3C				; ignore errors
_BFA2C:			pla					; get back A
			sta	CRFS_ERR_PTR_HI			; store A on &B9
			sty	CRFS_ERR_PTR			; store Y on &B8
			jsr	_LF68B				; do *EXEC 0 to tidy up
			lsr	CRFS_ACTIVE			; halve CFS Active flag to clear bit 7

			jsr	_LFAE8				; bell, reset ACIA & motor
			jmp	(CRFS_ERR_PTR)			; display selected error report

_BFA3C:			pla					; get back A
			iny					; Y=Y+1
			bne	_BFA43				; 
			clc					; clear carry flag
			adc	#$01				; Add 1
_BFA43:			pha					; save A on stack
			tya					; A=Y
			pha					; save Y on stack
_CRFS_PRINT_MSG:	jsr	_CFS_CHECK_BUSY			; check if free to print message
			tay					; Y=A
_PRINT_MSG:		pla					; get back A
			sta	CRFS_ERR_PTR			; &B8=8
			pla					; get back A
			sta	CRFS_ERR_PTR_HI			; &B9=A
			tya					; A=Y
			php					; save flags on stack
_LFA52:			inc	CRFS_ERR_PTR			; 
			bne	_BFA58				; 
			inc	CRFS_ERR_PTR_HI			; 
_BFA58:			ldy	#$00				; Y=0
			lda	(CRFS_ERR_PTR),Y		; get byte
			beq	_BFA68				; if 0 Fa68
			plp					; get back flags
			php					; save flags on stack
			beq	_LFA52				; if 0 FA52 to get next character
			jsr	OSASCI				; else print
			jmp	_LFA52				; and do it again

_BFA68:			plp					; get back flags
			inc	CRFS_ERR_PTR			; increment pointers
			bne	_BFA6F				; 
			inc	CRFS_ERR_PTR_HI			; 
_BFA6F:			jmp	(CRFS_ERR_PTR)			; and print error message so no error condition
								; occcurs

;************ compare filenames ******************************************

_LFA72:			ldx	#$ff				; X=&FF inx will mean X=0

_BFA74:			inx					; X=X+1
			lda	CFS_FIND_NAME,X			; sought filename byte
			bne	_BFA81				; if not 0 FA81
			txa					; else A=X
			beq	_BFA80				; if X=0 A=0 exit
			lda	CFS_FILENAME,X			; else A=filename byte
_BFA80:			rts					; return
								;
_BFA81:			jsr	_LE4E3				; set carry if byte in A is not upper case Alpha
			eor	CFS_FILENAME,X			; compare with filename
			bcs	_BFA8B				; if carry set FA8B
			and	#$df				; else convert to upper case
_BFA8B:			beq	_BFA74				; and if A=0 filename characters match so do it again
_BFA8D:			rts					; return
								;
			brk					; 
			.byte	$d8				; error number
			.byte	$0d,"Data?"			; 
			brk					; 

			bne	_BFAAE				; 

			brk					; 
			.byte	$db				; error number
			.byte	$0d,"File?"			; 
			brk					; 

			bne	_BFAAE				; 

			brk					; 
			.byte	$da				; error number
			.byte	$0d,"Block?"			
			brk					; 

_BFAAE:			lda	CRFS_BLOCK_FLAG			; current block flag
			beq	_BFAD3				; if 0 FAD3 else
			txa					; A=X
			beq	_BFAD3				; If X=0 FAD3
			lda	#$22				; A=&22
			bit	CRFS_OPTS			; current OPTions checking bits 1 and 5
			beq	_BFAD3				; if neither set no  retry so FAD3 else
			jsr	_RESET_ACIA			; reset ACIA
			tay					; Y=A
			jsr	_PRINT_MSG			; print following message

			.byte	$0d				; Carriage RETURN
			.byte	$07				; BEEP
			.byte	"Rewind tape"			; 
			.byte	$0d, $0d			; two more newlines
			brk					; 

_BFAD2:			rts					; return

_BFAD3:			jsr	_CRFS_PRINT_NEWLINE		; print CR if CFS not operational
_LFAD6:			lda	CRFS_PROGRESS			; filename length/progress flag
			beq	_BFAD2				; if 0 return else
			jsr	_CFS_READY			; confirm ESC not set and CFS not executing
			lda	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			beq	_LFAD6				; if CFS FAD6
			jsr	_CRFS_READ			; else set up ACIA etc
			jmp	_LFAD6				; and loop back again

;********** sound bell, reset ACIA, motor off ****************************

_LFAE8:			jsr	_CFS_CHECK_BUSY			; check if free to print message
			beq	_LFAF2				; enable second processor and reset serial system
			lda	#$07				; beep
			jsr	OSWRCH				; 
_LFAF2:			lda	#$80				; 
			jsr	_LFBBD				; enable 2nd proc. if present and set up osfile block
			ldx	#$00				; 
			jsr	_LFB95				; switch on motor
_LFAFC:			php					; save flags on stack
			sei					; prevent IRQ interrupts
			lda	OSB_SERPROC			; get serial ULA control register setting
			sta	SERIAL_ULA			; write to serial ULA control register setting
			lda	#$00				; A=0
			sta	RS423_TIMEOUT			; store A RS423 timeout counter
			beq	_BFB0B				; jump FB0B

_LFB0A:			php					; save flags on stacksave flags
_BFB0B:			jsr	_RESET_ACIA			; release ACIA (by &FE08=3)
			lda	OSB_RS423_CTL			; get last setting of ACIA
			jmp	_LE189				; set ACIA and &250 from A before exit

_BFB14:			plp					; get back flags
			bit	ESCAPE_FLAG			; if bit 7of ESCAPE flag not set
			bpl	_BFB31				; then FB31
			rts					; else return as unserviced ESCAPE is pending


;*************************************************************************
;*									 *
;*	 Claim serial system for sequential Access			 *
;*									 *
;*************************************************************************

_LFB1A:			lda	CRFS_OPTIONS			; get cassette filing system options byte
								; high nybble used for LOAD & SAVE operations
								; low nybble used for sequential access

				; 0000	 Ignore errors,		 no messages
				; 0001	 Abort if error,	 no messages
				; 0010	 Retry after error,	 no messages
				; 1000	 Ignore error		 short messages
				; 1001	 Abort if error		 short messages
				; 1010	 Retry after error	 short messages
				; 1100	 Ignore error		 long messages
				; 1101	 Abort if error		 long messages
				; 1110	 Retry after error	 long messages

			asl					; move low nybble into high nybble
			asl					; 
			asl					; 
			asl					; 
			sta	CRFS_OPTS			; current OPTions save into &BB
			lda	SEQ_BLOCK_GAP			; get sequential block gap
			bne	_BFB2F				; goto to &FB2F


;*************************************************************************
;*									 *
;*	 claim serial system for cassette etc.				 *
;*									 *
;*************************************************************************

_CFS_CLAIM_SERIAL:	lda	CRFS_OPTIONS			; get cassette filing system options byte
								; high nybble used for LOAD & SAVE operations
								; low nybble used for sequential access

				; 0000	 Ignore errors,		 no messages
				; 0001	 Abort if error,	 no messages
				; 0010	 Retry after error,	 no messages
				; 1000	 Ignore error		 short messages
				; 1001	 Abort if error		 short messages
				; 1010	 Retry after error	 short messages
				; 1100	 Ignore error		 long messages
				; 1101	 Abort if error		 long messages
				; 1110	 Retry after error	 long messages

			and	#$f0				; clear low nybble
			sta	CRFS_OPTS			; as current OPTions
			lda	#$06				; set current interblock gap
_BFB2F:			sta	CFS_INTERBLOCK			; to 6

_BFB31:			cli					; allow interrupts
			php					; save flags on stack
			sei					; prevent interrupts
			bit	OSB_RS423_USE			; check if RS423 is busy
			bpl	_BFB14				; if not FB14
			lda	RS423_TIMEOUT			; see if RS423 has timed out
			bmi	_BFB14				; if not FB14

			lda	#$01				; else load RS423 timeout counter with
			sta	RS423_TIMEOUT			; 1 to indicate that cassette has 6850
			jsr	_RESET_ACIA			; reset ACIA with &FE80=3
			plp					; get back flags
			rts					; return

_RESET_ACIA:		lda	#$03				; A=3
			bne	_BFB65				; and exit after resetting ACIA


;**********************	 set ACIA control register  **********************

_SET_ACIA_CONTROL:	lda	#$30				; set current ACIA control register
			sta	CFS_SERIAL_CTRL			; to &30
			bne	_LFB63				; and goto FB63
								; if bit 7=0 motor off 1=motor on

;***************** control cassette system *******************************

_LFB50:			lda	#$05				; set &FE10 to 5
			sta	SERIAL_ULA			; setting a transmit baud rate of 300,motor off

			ldx	#$ff				; 
__cfs_delay_loop:	dex					; delay loop
			bne	__cfs_delay_loop		; 

			stx	CFS_SERIAL_CTRL			; &CA=0
			lda	#$85				; Turn motor on and keep baud rate at 300 recieve
			sta	SERIAL_ULA			; 19200 transmit
			lda	#$d0				; A=&D0

_LFB63:			ora	CFS_BAUD_RATE			; 
_BFB65:			sta	ACIA_CSR			; set up ACIA control register
			rts					; returnand return

_LFB69:			ldx	CFS_BLK_NUM			; block number
			ldy	CFS_BLK_NUM_HI			; block number hi
			inx					; X=X+1
			stx	CRFS_EXEC			; current block no. lo
			bne	_BFB75				; 
			iny					; Y=Y+1
_BFB75:			sty	CRFS_EXEC_HI			; current block no. hi
			rts					; return
								;
_LFB78:			ldy	#$00				; 
			sty	CRFS_BUFFER_FLAG		; filing system buffer flag

;*****************set (zero) checksum bytes ******************************

_LFB7C:			sty	CRFS_CRC_TMP			; CRC workspace
			sty	CRFS_CRC_TMP_HI			; CRC workspace
			rts					; return

;*********** copy sought filename routine ********************************

_LFB81:			ldy	#$ff				; Y=&FF
_BFB83:			iny					; Y=Y+1
			inx					; X=X+1
			lda	VDU_G_WIN_L,X			; 
			sta	CFS_FIND_NAME,Y			; sought filename
			bne	_BFB83				; until end of filename (0)
			rts					; return
								;
_LFB8E:			ldy	#$00				; Y=0

;********************** switch Motor on **********************************

_LFB90:			cli					; allow	  IRQ interrupts
			ldx	#$01				; X=1
			sty	CFS_HANDLE			; store Y as current file handle

;********************: control motor ************************************

_LFB95:			lda	#$89				; do osbyte 137
			ldy	CFS_HANDLE			; get back file handle (preserved thru osbyte)
			jmp	OSBYTE				; turn on motor

;****************** confirm file is open  ********************************

_LFB9C:			sta	CRFS_BLK_OFFSET			; file status or temporary store
			tya					; A=Y
			eor	OSB_CFSRFC_SW			; filing system flag 0=CFS 2=RFS
			tay					; Y=A
			lda	CRFS_STATUS			; CFS status byte
			and	CRFS_BLK_OFFSET			; file status or temporary store
			lsr					; A=A/2
			dey					; Y=Y-1
			beq	_BFBAF				; 
			lsr					; A=A/2
			dey					; Y=Y-1
			bne	_LFBB1				; 
_BFBAF:			bcs	_BFBFE				; 

_LFBB1:			brk					; 
			.byte	$de				; error number
			.byte	"Channel"			; 
			brk					; 

;************* read from second processor ********************************

_LFBBB:			lda	#$01				; A=1
_LFBBD:			jsr	_LFBD3				; check if second processor file test tube prescence
			beq	_BFBFE				; if not exit
			txa					; A=X
			ldx	#$b0				; current load address
			ldy	#$00				; Y=00
_LFBC7:			pha					; save A on stack
			lda	#$c0				; filing system buffer flag
_BFBCA:			jsr	TUBE_ENTRY_2			; and out to TUBE
			bcc	_BFBCA				; 
			pla					; get back A
			jmp	TUBE_ENTRY_2			; 

;*************** check if second processor file test tube prescence ******

_LFBD3:			tax					; X=A
			lda	CRFS_LOAD_VHI			; current load address high word
			and	CRFS_LOAD_XHI			; current load address high word
			cmp	#$ff				; 
			beq	_BFBE1				; if &FF then its for base processor
			lda	OSB_TUBE_FOUND			; &FF if tube present
			and	#$80				; to set bit 7 alone
_BFBE1:			rts					; return

;******** control ACIA and Motor *****************************************

_LFBE2:			lda	#$85				; A=&85
			sta	SERIAL_ULA			; write to serial ULA control register setting
			jsr	_RESET_ACIA			; reset ACIA
			lda	#$10				; A=16
			jsr	_LFB63				; set ACIA to CFS baud rate
_BFBEF:			jsr	_CFS_READY			; confirm ESC not set and CFS not executing
			lda	ACIA_CSR			; read ACIA status register
			and	#$02				; clear all but bit 1
			beq	_BFBEF				; if clear FBEF
			lda	#$aa				; else A=&AA
			sta	ACIA_TXRX			; transmit data register
_BFBFE:			rts					; return

			brk					; 

;************** FRED 1MHz Bus memory-mapped I/O **************************

; FC00	;test hardware
; FC10-13 ;teletext
; FC14-1F ;Prestel
; FC20-27 ;IEEE interface
; FC30	 ;
; FC40-47 ;winchester disc interface
; FC50	;
; FC60	;
; FC70	;
; FC80	;
; FC90	;
; FCA0	;
; FCB0	;
; FCC0	;
; FCD0	;
; FCE0	;
; FCF0	;
; FCFF	;paging register for JIM expansion memory

;************** JIM 1MHz Bus memory-expansion page ***********************

; FD00-FF ;
; FDFE	;Ecosoak Vector

;************** SHEILA MOS memory-mapped I/O ***************************

				; DEVICE	 WRITE			 READ
; FE00	;6845 CRTC	address register
; FE01	;6845 CRTC	data register
; FE02	;Border colour	border colour
; FE03	;
; FE04	;
; FE05	;
; FE06	;
; FE07	;
; FE08	;6850 ACIA	control register	status register
; FE09	;6850 ACIA	transmit data		recieve data
; FE0A	;
; FE0B	;
; FE0C	;
; FE0D	;
; FE0E	;
; FE0F	;
; FE10	;SERIAL ULA	control register
; FE11	;
; FE12	;
; FE13	;
; FE14	;
; FE15	;
; FE16	;
; FE17	;
; FE18	;68B54 ADLC	Disable interrupts	Econet station ID
; FE19	;
; FE1A	;
; FE1B	;
; FE1C	;
; FE1D	;
; FE1E	;
; FE1F	;
; FE20	;Video ULA	control register
; FE21	;Video ULA	palette register	palette register
; FE22	;
; FE23	;
; FE24	;
; FE25	;
; FE26	;
; FE27	;
; FE28	;
; FE29	;
; FE2A	;
; FE2B	;
; FE2C	;
; FE2D	;
; FE2E	;
; FE2F	;
; FE30	;ROM latch	paged ROM ID		write only
; FE31	;ALTAIR		RAM protect
; FE32	;
; FE33	;
; FE34	;Shadow RAM	B+ only		note different OS
; FE35	;
; FE36	;
; FE37	;
; FE38	;
; FE39	;
; FE3A	;
; FE3B	;
; FE3C	;
; FE3D	;
; FE3E	;
; FE3F	;
; FE40	;MOS 6522 VIA Output Register B			Input Register B
; FE41	;MOS 6522 VIA Output Register A			Input Register A
; FE42	;MOS 6522 VIA data direction register B
; FE43	;MOS 6522 VIA data direction register A
; FE44	;MOS 6522 VIA T1C-L  latches			T1 low Order counter
; FE45	;MOS 6522 VIA T1C-H  counter
; FE46	;MOS 6522 VIA T1L-L low order latches
; FE47	;MOS 6522 VIA T1L-H high order latches
; FE48	;MOS 6522 VIA T2C-L latches			T2C-L lo order counter
; FE49	;MOS 6522 VIA T2C-H T2 high order counter
; FE4A	;MOS 6522 VIA shift register
; FE4B	;MOS 6522 VIA auxilliary control register ACR
; FE4C	;MOS 6522 VIA Peripheral control register PCR
; FE4D	;MOS 6522 VIA Interrupt	 flag	 register IFR
; FE4E	;MOS 6522 VIA Interrupt enable	 register IER
; FE4F	;MOS 6522 VIA ORB/IRB but no handshake
; FE50	;
; FE51	;
; FE52	;
; FE53	;
; FE54	;
; FE55	;
; FE56	;
; FE57	;
; FE58	;
; FE59	;
; FE5A	;
; FE5B	;
; FE5C	;
; FE5D	;
; FE5E	;
; FE5F	;
; FE60	;USER 6522 VIA Output Register B		Input Register B
; FE61	;USER 6522 VIA Output Register A		Input Register A
; FE62	;USER 6522 VIA data direction register B
; FE63	;USER 6522 VIA data direction register A
; FE64	;USER 6522 VIA T1C-L  latches			T1 low Order counter
; FE65	;USER 6522 VIA T1C-H  counter
; FE66	;USER 6522 VIA T1L-L low order latches
; FE67	;USER 6522 VIA T1L-H high order latches
; FE68	;USER 6522 VIA T2C-L latches			T2C-L lo order counter
; FE69	;USER 6522 VIA T2C-H T2 high order counter
; FE6A	;USER 6522 VIA shift register
; FE6B	;USER 6522 VIA auxilliary control register ACR
; FE6C	;USER 6522 VIA Peripheral control register PCR
; FE6D	;USER 6522 VIA Interrupt  flag	  register IFR
; FE6E	;USER 6522 VIA Interrupt enable	  register IER
; FE6F	;USER 6522 VIA ORB/IRB but no handshake
; FE70	;
; FE71	;
; FE72	;
; FE73	;
; FE74	;
; FE75	;
; FE76	;
; FE77	;
; FE78	;
; FE79	;
; FE7A	;
; FE7B	;
; FE7C	;
; FE7D	;
; FE7E	;
; FE7F	;
; FE80	;8271 FDC	command register		status register
; FE81	;8271 FDC	parameter register		result register
; FE82	;8271 FDC	reset register
; FE83	;8271 FDC	illegal				illegal
; FE84	;8271 FDC	data				data
; FE85	;
; FE86	;
; FE87	;
; FE88	;
; FE89	;
; FE8A	;
; FE8B	;
; FE8C	;
; FE8D	;
; FE8E	;
; FE8F	;
; FE90	;
; FE91	;
; FE92	;
; FE93	;
; FE94	;
; FE95	;
; FE96	;
; FE97	;
; FE98	;
; FE99	;
; FE9A	;
; FE9B	;
; FE9C	;
; FE9D	;
; FE9E	;
; FE9F	;
; FEA0	;68B54 ADLC	control register 1		status register 1
; FEA1	;68B54 ADLC	control register 2/3		status register 2/3
; FEA2	;68B54 ADLC	Tx FIFO (frame continue)	Rx	FIFO
; FEA3	;68B54 ADLC	Tx FIFO (frame terminate)	Rx	FIFO
; FEA4	;
; FEA5	;
; FEA6	;
; FEA7	;
; FEA8	;
; FEA9	;
; FEAA	;
; FEAB	;
; FEAC	;
; FEAD	;
; FEAE	;
; FEAF	;
; FEB0	;
; FEB1	;
; FEB2	;
; FEB3	;
; FEB4	;
; FEB5	;
; FEB6	;
; FEB7	;
; FEB8	;
; FEB9	;
; FEBA	;
; FEBB	;
; FEBC	;
; FEBD	;
; FEBE	;
; FEBF	;
; FEC0	;7002 ADC	data latch A/D start		status
; FEC1	;7002 ADC	hi data byte
; FEC2	;7002 ADC	lo data byte
; FEC3	;
; FEC4	;
; FEC5	;
; FEC6	;
; FEC7	;
; FEC8	;
; FEC9	;
; FECA	;
; FECB	;
; FECC	;
; FECD	;
; FECE	;
; FECF	;
; FED0	;
; FED1	;
; FED2	;
; FED3	;
; FED4	;
; FED5	;
; FED6	;
; FED7	;
; FED8	;
; FED9	;
; FEDA	;
; FEDB	;
; FEDC	;
; FEDD	;
; FEDE	;
; FEDF	;
; FEE0	;TUBE FIFO1	status register
; FEE1	;TUBE FIFO1
; FEE2	;TUBE FIFO2	status register
; FEE3	;TUBE FIFO2
; FEE4	;TUBE FIFO3	status register
; FEE5	;TUBE FIFO3
; FEE6	;TUBE FIFO4	status register
; FEE7	;TUBE FIFO4
; FEE8	;
; FEE9	;
; FEEA	;
; FEEB	;
; FEEC	;
; FEED	;
; FEEE	;
; FEEF	;
; FEF0	;
; FEF1	;
; FEF2	;
; FEF3	;
; FEF4	;
; FEF5	;
; FEF6	;
; FEF7	;
; FEF8	;
; FEF9	;
; FEFA	;
; FEFB	;
; FEFC	;
; FEFD	;
; FEFE	;
; FEFF	;
		.org		$fc00

		.byte		"(C) 1981 Acorn Computers Ltd."
		.byte		"Thanks are due to the following "
		.byte		"contributors to the development "
		.byte		"of the BBC Computer (among others "
		.byte		"too numerous to mention):- "
		.byte		"David Allen,"
		.byte		"Bob Austin,"
		.byte		"Ram Banerjee,"
		.byte		"Paul Bond,"
		.byte		"Allen Boothroyd,"
		.byte		"Cambridge,"
		.byte		"Cleartone,"
		.byte		"John Coll,"
		.byte		"John Cox,"
		.byte		"Andy Cripps,"
		.byte		"Chris Curry,"
		.byte		"6502 designers,"
		.byte		"Jeremy Dion,"
		.byte		"Tim Dobson,"
		.byte		"Joe Dunn,"
		.byte		"Paul Farrell,"
		.byte		"Ferranti,"
		.byte		"Steve Furber,"
		.byte		"Jon Gibbons,"
		.byte		"Andrew Gordon,"
		.byte		"Lawrence Hardwick,"
		.byte		"Dylan Harris,"
		.byte		"Hermann Hauser,"
		.byte		"Hitachi,"
		.byte		"Andy Hopper,"
		.byte		"ICL,"
		.byte		"Martin Jackson,"
		.byte		"Brian Jones,"
		.byte		"Chris Jordan,"
		.byte		"David King,"
		.byte		"David Kitson,"
		.byte		"Paul Kriwaczek,"
		.byte		"Computer Laboratory,"
		.byte		"Peter Miller,"
		.byte		"Arthur Norman,"
		.byte		"Glyn Phillips,"
		.byte		"Mike Prees,"
		.byte		"John Radcliffe,"
		.byte		"Wilberforce Road,"
		.byte		"Peter Robinson,"
		.byte		"Richard Russell,"
		.byte		"Kim Spence-Jones,"
		.byte		"Graham Tebby,"
		.byte		"Jon Thackray,"
		.byte		"Chris Turner,"
		.byte		"Adrian Warner,"
		.byte		"Roger Wilson,"
		.byte		"Alan Wright."
		.addr		_RESET_HANDLER


;********** EXTENDED VECTOR ENTRY POINTS**********************************
;vectors are pointed to &F000 +vector No. vectors may then be directed thru
;a three byte vector table whose XY address is given by osbyte A8, X=0, Y=&FF
;this is set up as lo-hi byte in ROM and ROM number

			.org	$ff00

			jsr	_EXTENDED			; XUSERV
			jsr	_EXTENDED			; XBRKV
			jsr	_EXTENDED			; XIRQ1V
			jsr	_EXTENDED			; XIRQ2V
			jsr	_EXTENDED			; XCLIV
			jsr	_EXTENDED			; XBYTEV
			jsr	_EXTENDED			; XWORDV
			jsr	_EXTENDED			; XWRCHV
			jsr	_EXTENDED			; XRDCHV
			jsr	_EXTENDED			; XFILEV
			jsr	_EXTENDED			; XARGSV
			jsr	_EXTENDED			; XBGETV
			jsr	_EXTENDED			; XBPUTV
			jsr	_EXTENDED			; XGBPBV
			jsr	_EXTENDED			; XFINDV
			jsr	_EXTENDED			; XFSCV
			jsr	_EXTENDED			; XEVENTV
			jsr	_EXTENDED			; XUPTV
			jsr	_EXTENDED			; XNETV
			jsr	_EXTENDED			; XVDUV
			jsr	_EXTENDED			; XKEYV
			jsr	_EXTENDED			; XINSV
			jsr	_EXTENDED			; XREMV
			jsr	_EXTENDED			; XCNPV
			jsr	_EXTENDED			; XIND1V
			jsr	_EXTENDED			; XIND2V
			jsr	_EXTENDED			; XIND3V

;at this point the stack will hold 4 bytes (at least)
;S 0,1 extended vector address
;S 2,3 address of calling routine
;A,X,Y,P will be as at entry

_EXTENDED:		pha					; save A on stack
			pha					; save A on stack
			pha					; save A on stack
			pha					; save A on stack
			pha					; save A on stack
			php					; save flags on stack
			pha					; save A on stack
			txa					; A=X
			pha					; save X on stack
			tya					; A=Y
			pha					; save Y on stack
			tsx					; get stack pointer into X (&F2 or less)
			lda	#$ff				; A=&FF
			sta	STACK+8,X			; A
			lda	#$88				; 
			sta	STACK+7,X			; 
			ldy	STACK+$A,X			; this is VECTOR number*3+2!!
			lda	$0d9d,Y				; lo byte of action address
			sta	STACK+5,X			; store it on stack
			lda	$0d9e,Y				; get hi byte
			sta	STACK+6,X			; store it on stack
								; at this point stack has YXAP and action address
								; followed by return address and 5 more bytes
			lda	ROM_SELECT			; 
			sta	STACK+9,X			; store original ROM number below this
			lda	$0d9f,Y				; get new ROM number
			sta	ROM_SELECT			; store it as ram copy
			sta	ROM_LATCH			; and switch to that ROM
			pla					; get back A
			tay					; Y=A
			pla					; get back A
			tax					; X=A
			pla					; get back A
			rti					; get back flags and jump to ROM vectored entry
								; leaving return address and 5 more bytes on stack

;************ return address from ROM indirection ************************

;at this point stack comprises original ROM number,return from JSR &FF51,
;return from original call the return from FF51 is garbage so;

			php					; save flags on stack
			pha					; save A on stack
			txa					; A=X
			pha					; save X on stack
			tsx					; (&F7 or less)
			lda	STACK+2,X			; STORE A AND P OVER
			sta	STACK+5,X			; return address from (JSR &FF51)
			lda	STACK+3,X			; hiding garbage by duplicating A and X just saved
			sta	STACK+6,X			; 
								; now we have
								; flags,
								; A,
								; X,
								; ROM number,
								; A,
								; flags,
								; and original return address on stack
								; so
			pla					; get back X
			tax					; X=A
			pla					; get back A lose next two bytes
			pla					; get back A lose
			pla					; get back A ROM number
			sta	ROM_SELECT			; store it
			sta	ROM_LATCH			; and set it
			pla					; get back A
			plp					; get back flags
_NOTIMPV:		rts					; return and exit pulling original return address
								; from stack
;FFA6 is also default input for CFS OSBPGB, VDUV, IND1V,IND2V,IND3V
;as these functions are not implemented by the OS but may be used
;by software or other filing systems or ROMs


;*************************************************************************
;*									 *
;*	 OSBYTE &9D    FAST BPUT					 *
;*									 *
;*************************************************************************
_OSBYTE_157:		txa					; A=X
			bcs	OSBPUT				; carry always set, jump to BPUT


;*************************************************************************
;*									 *
;*	 OSBYTE &92	 READ A BYTE FROM FRED				 *
;*									 *
;*************************************************************************	 ;

_OSBYTE_146:		ldy	FRED,X				; read a byte from FRED area
			rts					; return


;*************************************************************************
;*									 *
;*	 OSBYTE &94	 READ A BYTE FROM JIM				 *
;*									 *
;*************************************************************************	 ;
				;
_OSBYTE_148:		ldy	JIM,X				; read a byte from JIM area
			rts					; return


;*************************************************************************
;*									 *
;*	 OSBYTE &96	 READ A BYTE FROM SHEILA			 *
;*									 *
;*************************************************************************	 ;
				;
_OSBYTE_150:		ldy	CRTC_ADDRESS,X			; read a byte from SHEILA memory mapped I/O area
			rts					; return


;*********** DEFAULT VECTOR TABLE ****************************************

			.byte	$36				; length of look up table in bytes
			.addr	_VECTOR_TABLE			; address of this table


;**************************************************************************
;**************************************************************************
;**									 **
;**	 OPERATING SYSTEM FUNCTION CALLS				 **
;**									 **
;**************************************************************************
;**************************************************************************

OSRDRM:			jmp	_OSRDRM				; OSRDRM get a byte from sideways ROM
VDUCHR:			jmp	_VDUCHR				; VDUCHR VDU character output
OSEVEN:			jmp	_OSEVEN				; OSEVEN generate an EVENT
GSINIT:			jmp	_GSINIT				; GSINIT initialise OS string
GSREAD:			jmp	_GSREAD				; GSREAD read character from input stream
NVRDCH:			jmp	_NVRDCH				; NVRDCH non vectored OSRDCH
NVWRCH:			jmp	_NVWRCH				; NVWRCH non vectored OSWRCH
OSFIND:			jmp	(VEC_OSFIND)			; OSFIND open or close a file
			jmp	(VEC_OSGBPB)			; OSGBPB transfer block to or from a file
OSBPUT:			jmp	(VEC_OSBPUT)			; OSBPUT save a byte to file
OSBGET:			jmp	(VEC_OSBGET)			; OSBGET get a byte from file
OSARGS:			jmp	(VEC_OSARGS)			; OSARGS read or write file arguments
OSFILE:			jmp	(VEC_OSFILE)			; OSFILE read or write a file
OSRDCH:			jmp	(VEC_OSRDCH)			; OSRDCH get a byte from current input stream
OSASCI:			cmp	#$0d				; OSASCI output a byte to VDU stream expanding
			bne	OSWRCH				; carriage returns (&0D) to LF/CR (&0A,&0D)
OSNEWL:			lda	#$0a				; OSNEWL output a CR/LF to VDU stream
			jsr	OSWRCH				; Outputs A followed by CR to VDU stream
			lda	#$0d				; OSWRCR output a CR to VDU stream
OSWRCH:			jmp	(VEC_OSWRCH)			; OSWRCH output a character to the VDU stream
OSWORD:			jmp	(VEC_OSWORD)			; OSWORD perform operation using parameter table
OSBYTE:			jmp	(VEC_OSBYTE)			; OSBYTE perform operation with single bytes
OSCLI:			jmp	(VEC_OSCLI)			; OSCLI	 pass string to command line interpreter


;*************************************************************************
;*									 *
;*	 6502 Vectors							 *
;*									 *
;*************************************************************************

			.addr	NMI_HANDLER			; NMI	address
			.addr	_RESET_HANDLER			; RESET address
			.addr	_IRQ_HANDLER			; IRQ	address

; That's it the end of the series and the end of Micronet.

; See you on the new system or in the paper mags.

; Geoff

