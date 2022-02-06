// testing the overflow mechanism and using different registers
.config
	ARCH v
	ASSERT 3510

.text
		ADDIU $1 $0 #15151
		ADDIU $3 $0 #18661
		SUBU $2 $3 $1
		JR $0


.data
