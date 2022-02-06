.config
	ARCH v
	ASSERT 0

.text
	ADDIU $3 $0 #0xFFFF
	SH $3 #0($gp)
	ADDIU $3 $0 #0xAAAA
	SH $3 #2($gp)
	LW $1 #0($gp)
	JR $0
	SLTIU $2 $1 #0x4FFF

.data

	