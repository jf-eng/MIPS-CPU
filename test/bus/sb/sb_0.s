.config
	ARCH v
	ASSERT 32'hdf

.text
	ADDIU $3 $0 #0x1357
	SH $3 #0($gp)
	ADDIU $3 $0 #0X9BDF
	SH $3 #2($gp)
	LW $1 #0($gp)		// 0
	SB $1 #4($gp) 		// 4
	JR $0				// 8
	LBU $2 #4($gp)		// 12
						// 16

.data

