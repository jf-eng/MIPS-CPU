.config
	ARCH v
	ASSERT 1
.text
	ADDIU $1 $0 #6
	ADDIU $3 $1 #6
	SLTU $2 $1 $3
	JR $0
.data
