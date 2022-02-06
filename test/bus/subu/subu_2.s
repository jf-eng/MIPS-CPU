// Subtraction of the largest numbers
.config
	ARCH v
	ASSERT 32'h0

.text
		ADDIU $1 $0 #0xFFFF
		ADDIU $2 $0 #0xFFFF
		SUBU $2 $2 $1
		JR $0


.data
