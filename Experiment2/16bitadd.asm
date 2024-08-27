start:
	.def	num1L = r16	; define lower byte of number 1 as r16
	.def	num1H = r17	; define upper byte of number 1 as r17
	.def	num2L = r18	; define lower byte of number 2 as r18
	.def	num2H = r19	; define upper byte of number 2 as r19	

	.cseg
	.org	0x00
	ldi	num1L,0x56	; load 0x56 into r16 
	ldi	num1H,0x34	; load 0x34 into r17 
	ldi	num2L,0x78	; load 0x78 into r18 
	ldi	num2H,0x12	; load 0x12 into r19 

	add	num1L,num2L	; add lower bytes of number
	adc	num1H,num2H	; add upper bytes of number with carry

