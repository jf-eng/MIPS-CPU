// tests 24/5, checks for quotient of 5

.config
	ARCH v
	ASSERT 4

.text
	ADDIU $1 $0 #24
	ADDIU $2 $0 #5
	DIVU $1 $2
	MFLO $2
	JR $0

.data
