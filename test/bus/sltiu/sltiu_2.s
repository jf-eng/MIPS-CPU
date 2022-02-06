.config
	ARCH v
	ASSERT 1

.text
	ADDIU $1 $0 #0
	JR $0
	SLTIU $2 $1 #2

.data
