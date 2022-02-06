// largest positive number

.config
	ARCH v
	ASSERT 32'hf

.text
		ADDIU $2 $0 #0x8000
		BLEZ $2 loop
		ADDIU $2 $2 #0xFFFF
		ADDIU $2 $0 #14
		JR $0
		NOP
	loop:
		ADDIU $2 $0 #15
		NOP
	end:
		JR $0
		NOP
.data
	one #0



