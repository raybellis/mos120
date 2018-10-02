;************** FRED 1MHz Bus memory-mapped I/O **************************

.org		$fc00

		;test	hardware
; ### FC10-13 ;teletext
; ### FC14-1F ;Prestel
; ### FC20-27 ;IEEE interface
		;	
; ### FC40-47 ;winchester disc interface
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;paging	register for JIM expansion memory

;************** JIM 1MHz Bus memory-expansion page ***********************

; ### FD00-FF ;
		;ecosoak	Vector

;************** SHEILA MOS memory-mapped I/O ***************************

		; DEVICE         WRITE                   READ
		;6845	CRTC      address register
		;6845	CRTC      data register
		;border	colour  border colour
		;	
		;	
		;	
		;	
		;	
		;6850	ACIA      control register        status register
		;6850	ACIA      transmit data           recieve data
		;	
		;	
		;	
		;	
		;	
		;	
		;serial	ULA     control register
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;68b54	ADLC     Disable interrupts      Econet station ID
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;video	ULA      control register
		;video	ULA      palette register        palette register
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;rom	latch      paged ROM ID            write only
		;altair	RAM protect
		;	
		;	
		;shadow	RAM     B+ only         note different OS
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;mos	6522 VIA Output Register B                 Input Register B
		;mos	6522 VIA Output Register A                 Input Register A
		;mos	6522 VIA data direction register B
		;mos	6522 VIA data direction register A
		;mos	6522 VIA T1C-L  latches                    T1 low Order counter
		;mos	6522 VIA T1C-H  counter
		;mos	6522 VIA T1L-L low order latches
		;mos	6522 VIA T1L-H high order latches
		;mos	6522 VIA T2C-L latches                     T2C-L lo order counter
		;mos	6522 VIA T2C-H T2 high order counter
		;mos	6522 VIA shift register
		;mos	6522 VIA auxilliary control register ACR
		;mos	6522 VIA Peripheral control register PCR
		;mos	6522 VIA Interrupt  flag    register IFR
		;mos	6522 VIA Interrupt enable   register IER
		;mos	6522 VIA ORB/IRB but no handshake
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;user	6522 VIA Output Register B                Input Register B
		;user	6522 VIA Output Register A                Input Register A
		;user	6522 VIA data direction register B
		;user	6522 VIA data direction register A
		;user	6522 VIA T1C-L  latches                   T1 low Order counter
		;user	6522 VIA T1C-H  counter
		;user	6522 VIA T1L-L low order latches
		;user	6522 VIA T1L-H high order latches
		;user	6522 VIA T2C-L latches                    T2C-L lo order counter
		;user	6522 VIA T2C-H T2 high order counter
		;user	6522 VIA shift register
		;user	6522 VIA auxilliary control register ACR
		;user	6522 VIA Peripheral control register PCR
		;user	6522 VIA Interrupt  flag    register IFR
		;user	6522 VIA Interrupt enable   register IER
		;user	6522 VIA ORB/IRB but no handshake
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;8271	FDC       command register                status register
		;8271	FDC       parameter register              result register
		;8271	FDC       reset register
		;8271	FDC       illegal                         illegal
		;8271	FDC       data                            data
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;68b54	ADLC     control register 1              status register 1
		;68b54	ADLC     control register 2/3            status register 2/3
		;68b54	ADLC     Tx FIFO (frame continue)        Rx      FIFO
		;68b54	ADLC     Tx FIFO (frame terminate)       Rx      FIFO
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;7002	ADC       data latch A/D start            status
		;7002	ADC       hi data byte
		;7002	ADC       lo data byte
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;tube	FIFO1     status register
		;tube	FIFO1
		;tube	FIFO2     status register
		;tube	FIFO2
		;tube	FIFO3     status register
		;tube	FIFO3
		;tube	FIFO4     status register
		;tube	FIFO4
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
		;	
