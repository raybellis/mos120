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


