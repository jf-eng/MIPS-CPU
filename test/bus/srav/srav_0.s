.config
	ARCH v
	ASSERT 32'hC

.text
	ADDIU $1 $0 #0xCCD
	ADDIU $2 $0 #8
	JR $0
	SRAV $2 $1 $2

.data
	one #0xCCD
	two #8
	