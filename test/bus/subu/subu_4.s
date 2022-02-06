// testing the overflow mechanism and using different registers
.config
	ARCH v
	ASSERT 32'hFFFFFFFF

.text
		ADDIU $1 $0 #0xFFFF
		ADDIU $3 $0 #0xFFFE
		SUBU $2 $3 $1
		JR $0


.data
