.config
	ARCH v
	ASSERT 32'hef234567

.text 
	LUI $1 #0x0123
	ADDIU $1 $1 #0x4567
	SW $1 #0($gp)
	LUI $1 #0x89ab
	ADDIU $1 $1 #0x7def
	SW $1 #4($gp)
	LW $2 #0($gp)
	LWL $2 #7($gp)
	JR $0

.data
