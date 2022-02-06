// Takes output of a MULTU and does a MFLO

.config
	ARCH v
	ASSERT 32'haff20000

.text
	ADDIU $3 $0 #0x25c2
	SH $3 #0($gp)
	LW $1 #0($gp)
	ADDIU $2 $0 #25
	MULTU $2 $1
	MFLO $1
	MFLO $2
	JR $0

.data

