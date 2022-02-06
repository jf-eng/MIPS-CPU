.config
	ARCH v
	ASSERT 32'h9bdf

.text
	ADDIU $3 $0 #0X1357
	SH $3 #0($gp)
	ADDIU $3 $0 #0X9BDF
	SH $3 #2($gp)
	ADDIU $3 $0 #0X1234
	SH $3 #4($gp)
	LW $1 #0($gp)
	SH $1 #4($gp)
	JR $0
	LHU $2 #4($gp)

.data

