.config
	ARCH v
	ASSERT 0

.text
	ADDIU $2 $0 #0
	JR $0
	SLTI $2 $1 #0 // -1

.data
	one #0xFFFFFFFF // -1


