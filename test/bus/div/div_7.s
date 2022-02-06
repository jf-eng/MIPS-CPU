// -veand +ve, only remainder

.config
	ARCH v
	ASSERT -5

.text
	ADDIU $1 $0 #-5
	ADDIU $2 $0 #6
	DIV $1 $2
	MFHI $2
	JR $0

.data
