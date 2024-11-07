	.include "m8def.inc"


	.def 	mask 	= r16
	.def	ledR	= r17
	.def	oLoopR	= r18
	.def	iLooprl	= r24
	.def	iLookrh = r25
	
	.equ oVal = 71
	.equ iVal = 1760

	.cseg
	.org 0x00
	clr	ledR
	ldi	mask, (1<<PINB0)
	out	DDRB, MASK	; set pinB0 to output	

start:
	eor	ledR, mask
	out PORTB, ledR

	ldi oLoop#, oVal

oLoop:
	ldi iLooprl, LOW(iVal)
	ldi iLoopRh, HIGH(iVal)

iLoop:
	sbiw iLoop1, 1; decrement inner loop registers
	brne iLoop

	dec oLoopR
	brne oLoop


	rjmp start

