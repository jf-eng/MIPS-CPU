.config
	ARCH v
	ASSERT 34

.text
	ADDIU $1 $0 #34
	MTLO $1
	MFLO $2
	JR $0

.data

