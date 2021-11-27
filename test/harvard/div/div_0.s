.config
	ARCH h
	ASSERT 

.text
	ADDIU $1 $0 #20
	ADDIU $2 $0 #4
	DIV $1 $2
	MFLO

.data
