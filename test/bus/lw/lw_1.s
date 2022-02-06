.config
	ARCH v
	ASSERT 32'hFFFFFFFF

.text
	ADDIU $1 $0 #0xFFFF
	SH $1 #4($gp)
	SH $1 #6($gp)
	LW $2 #4($gp)
	JR $0

.data
