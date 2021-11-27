.config
	ARCH h
	ASSERT 0x5

.text
	ADDIU $1 $0 #20
	ADDIU $2 $0 #4
	DIV $1 $2
	MFLO $2
	JR $0

.data
