.config
	ARCH v
	ASSERT 0

.text
	ADDIU $2 $2 #0xFFFF
	JR $0
	SLTI $2 $1 #0x0 // -1

.data
	one #0xFFFFFFFF // -1

