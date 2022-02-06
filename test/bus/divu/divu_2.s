// tests 4/45, check for quotient of 0

.config
	ARCH v
	ASSERT 0

.text
	ADDIU $1 $0 #4
	ADDIU $2 $0 #45
	DIVU $1 $2
	MFLO $2
	JR $0

.data
