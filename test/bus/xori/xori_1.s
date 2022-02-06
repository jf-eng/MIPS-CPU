// XORI check zero extend

.config
	ARCH v
	ASSERT 32'hFFFF000F

.text
	ADDIU $1 $0 #0xFFFF
	SH $1 #0($gp)
	SH $1 #2($gp)
	LW $2 #0($gp)
	XORI $2 $2 #0xFFF0
	JR $0

.data
