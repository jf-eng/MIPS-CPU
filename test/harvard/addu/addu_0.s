.config
	ARCH h
	ASSERT 32'h12

.text
		ADDIU $1 $0 #0x10
		ADDIU $2 $0 #2
		ADDU $2 $2 $1
		JR $0

.data
