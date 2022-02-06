.config
	ARCH v
	ASSERT 32'hdf

.text
	ADDIU $3 $0 #0X1357
	SH $3 #0($gp)
	ADDIU $3 $0 #0X9BDF
	SH $3 #2($gp)
	LW $1 #0($gp)
	SB $1 #7($gp)
	JR $0
	LBU $2 #7($gp)


.data
