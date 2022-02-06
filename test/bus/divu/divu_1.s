// tests 24/5, check for remainder of 4

.config
	ARCH v
	ASSERT 4

.text
	ADDIU $1 $0 #24
	ADDIU $2 $0 #5
	DIVU $1 $2
	MFHI $2
	JR $0

.data
