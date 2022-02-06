#addu 0

.config
	ARCH v
	ASSERT 32'h5

.text
		ADDIU $3 $0 #5
		ADDU $2 $3 $0
		JR $0

.data
