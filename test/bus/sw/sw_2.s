.config
	ARCH v
	ASSERT 32'hFFFFFFFF

.text
	ADDIU $3 $0 #0xFFFF
	SH $3 #0($gp)
	SH $3 #2($gp)
	ADDIU $3 $0 #3
	SW $3 #8($gp)
	LW $1 #0($gp)
	SW $1 #8($gp)
	JR $0
	LW $2 #8($gp)


.data
