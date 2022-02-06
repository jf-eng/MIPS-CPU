.config
	ARCH v
	ASSERT 34

.text
	ADDIU $1 $0 #34
	MTHI $1
	MFHI $2
	JR $0

.data

