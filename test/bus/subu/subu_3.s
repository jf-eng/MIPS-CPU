// Subtraction of 0 by the largest numbers
.config
	ARCH v
	ASSERT 32'h1

.text
		ADDIU $1 $0 #0xFFFF
		ADDIU $2 $0 #0x0
		SUBU $2 $2 $1
		JR $0


.data
