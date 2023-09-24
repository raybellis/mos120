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
