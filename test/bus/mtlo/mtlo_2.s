// check rs unchanged

.config
	ARCH v
	ASSERT 69

.text
	ADDIU $2 $0 #69
	MTLO $2
	JR $0

.data
