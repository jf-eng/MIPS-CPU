// multiplication by zero
.config
	ARCH v
	ASSERT 32'h0
.text
	ADDIU $2 $0 #0xFFFF
    MULTU $2 $1
    MFLO $2
    MFHI $1
    JR $0

.data


