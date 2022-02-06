// branch false

.config
	ARCH v
	ASSERT 32'hF

.text
		ADDIU $2 $0 #0
		BGEZ $2 loop
		ADDIU $2 $0 #0xFFFF
		JR $0
		NOP
	loop:
		ADDIU $2 $0 #15
	end:
		JR $0
.data
	one #0xF1234567



