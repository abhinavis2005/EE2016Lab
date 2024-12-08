* factorial
	TTL FACTORIAL
	AREA Program , CODE, READONLY
	ENTRY
Main
	LDR R0 , Value1
	SWI &11
	MOV R1 , R0
LOOP
	SUB R1 , R1 , #1
	CMP R1 , #0
	BEQ loopend
	MUL R4 , R0 , R1
	MOV R0 , R4
	B LOOP
loopend
	SWI &11
Value1 DCD &00000006
	END

