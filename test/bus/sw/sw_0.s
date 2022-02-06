.config
	ARCH v
	ASSERT 3040

.text
	ADDIU $3 $0 #3040
	SW $3 #0($gp)
	LW $1 #0($gp)
	SW $1 #4($gp)
	JR $0
	LW $2 #4($gp)


.data
