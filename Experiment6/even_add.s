	area odd_even_checker, code, readonly
	entry
	
main
	ldr r0, value
	tst r0, #1 ; if it is even, the Z = 0
	beq even
	
	beq odd
even
	mov r1, #2
	b exit
	
odd
	mov r1, #1
	b exit



	
exit
	swi &11
	
value 	dcd &0000000a
	
	end
