;The interrupt pin chosen to be used is INT0 = PD2
.include "m8def.inc"
	.def ledR = r17
	.def ledtrig = r16
	.def outloopR = r18
	.def inloopRL = r24
	.def inloopRH = r25
	.def mloopR = r20; This is used to control the led blinking
	.equ inloopC = 1760;
	.equ outloopC = 71; These two together will make the led with a frequency of 1Hz
	.equ mloopC = 20; this makes sure the led toggles 20 times, for a total of 10 secs

	.cseg
	.org	0
	rjmp	reset; Jumps the interrupt vector table to the main

	.org 0x02
	rjmp isr

	org 0x100
reset:
	clr ledR
	ldi ledtrig, 0x01
	out DDRB, ledtrig
	ldi r31, 0x00
	out portB, r31

	ldi r19, HIGH(RAMEND)
	out SPH, r19
	ldi r19, LOW(RAMEND)
	out SPL, r19

 	sbi PORTD, 2
	ldi r19, 0x00
	out DDRD, r19

	ldi r19, 1<<INT0; can enable int0
	out GICR, r19; 
	sei; enables the interrupt

isr: ; isr, which accomplishes the led blink as required
	clr ledR
mloop:
	ldi mloopR, 20
l1:
	ldi ledtrig, 0x01
	eor ledR, ledtrig
	out PORTB, ledR
	ldi outloopR, outloopC
l2:
	ldi inloopRH, HIGH(inloopC)
	ldi inloopRL, LOW(inloopC)
l3:
	sbiw inloopRL, 1
	brne l3
	dec outloopR
	brne l2
	dec mloopR
	brne l1
	ldi r31, 0x00
	out PORTB, r31 ; turns the led off after the ISR execution
	reti : return of control to the previously executing process
		
