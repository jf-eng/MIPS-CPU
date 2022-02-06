// branch false

.config
	ARCH v
	ASSERT 32'hf

.text
		LUI $2 0x7FFF
		ADDIU $2 $2 0x7FFF
		ADDIU $2 $2 0x5000
		ADDIU $2 $2 0x3000
		BGEZ $2 loop
		ADDIU $2 $0 #0x10
		JR $0
		NOP
	loop:
		ADDIU $2 $0 #15
	end:
		JR $0
.data
	one #0xF1234567



