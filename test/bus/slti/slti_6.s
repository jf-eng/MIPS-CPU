.config
	ARCH v
	ASSERT 0

.text
	LUI $2 #0x7FFF
	ADDIU $2 $2 #0x7FFF
	ADDIU $2 $2 #0x5000
	ADDIU $2 $2 #0x3000
	JR $0
	SLTI $2 $1 #0xFFFF // -1

.data
	one #0xFFFFFFFF // -1

