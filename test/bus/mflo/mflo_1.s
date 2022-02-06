.config
	ARCH v
	ASSERT 32'hFFFFFFFF

.text
	ADDIU $3 $0 #0xFFFF
	SH $3 #0($gp)
	SH $3 #2($gp)
	LW $1 #0($gp)
	MTLO $1
	JR $0
	MFLO $2

.data

