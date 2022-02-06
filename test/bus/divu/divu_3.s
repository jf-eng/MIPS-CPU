// tests 4/45, check for remainder of 4

.config
	ARCH v
	ASSERT 4

.text
	ADDIU $1 $0 #4
	ADDIU $2 $0 #45
	DIVU $1 $2
	MFHI $2
	JR $0

.data
