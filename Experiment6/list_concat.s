	area list_con, code, readonly
	entry

main
	nop
	ldr r0, =list
	mov	r1, #4
	mov	r2, #0
	
loop
	ldrb r3, [r0], #1
	and r3, r3, #&f
	lsl r2, #4
	orr r2, r2, r3
	subs r1, r1, #1
	
	bne loop
	
	
	
	ldr r0, =list
	mov r1, #4
	mov r4, #0
loop1
	ldrb r3, [r0], #1
	and r3, r3, #&F0
	lsr r3, r3, #4
	lsl r4, #4
	orr r4, r4, r3
	subs r1, r1, #1
	bne loop1
	
	lsl r4, #16
	orr r4, r4, r2
	
	ldr r3, result
	
	str r4, [r3]
	
	swi &11
	
	
	swi &11
list	dcb &41
		dcb &32
		dcb &23
		dcb &14
result 	dcd &40000000
		end

