// tests 25/5, checks for quotient of 5

.config
	ARCH v
	ASSERT 5

.text
	ADDIU $1 $0 #25
	ADDIU $2 $0 #5
	DIVU $1 $2
	MFLO $2
	JR $0

.data
