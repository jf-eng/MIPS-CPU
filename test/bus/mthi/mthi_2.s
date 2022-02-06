// check rs unchanged

.config
	ARCH v
	ASSERT 69

.text
	ADDIU $2 $0 #69
	MTHI $2
	JR $0

.data
