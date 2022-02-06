.config
	ARCH v
	ASSERT 0

.text
	ADDIU $3 $0 #0x20
	SW $3 #0($gp)
	LW $1 #0($gp)
	JR $0
	SLTI $2 $1 #0xFFFF // -1

.data

