start:
	.cseg
	.org 	0x00
	
	ldi r16, 0x00
	out DDRB, r16; setting pin to input

check_input:

	SBIS PBINB, 0; 0 implies switch is on
	rjmp light_led ; 
	
	ldi r17, 0x0
	OUT PORTD, r17
	rjmp check_input

light_led:
	ldi r16, 0xFF;
	OUT PORTD, r17
	ldi r17, 0x1
	OUT PORTD, r17
	rjmp check_input

