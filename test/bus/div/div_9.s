// same reg

.config
	ARCH v
	ASSERT 1

.text
	ADDIU $2 $0 #6
	DIV $2 $2
	MFLO $2
	JR $0

.data
