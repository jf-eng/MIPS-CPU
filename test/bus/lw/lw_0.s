.config
	ARCH v
	ASSERT 3

.text
	ADDIU $1 $0 #3
	SW $1 #0($gp)
	LW $2 #0($gp)
	JR $0

.data

