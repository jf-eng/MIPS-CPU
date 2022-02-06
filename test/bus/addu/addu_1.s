#no overflow

.config
	ARCH v
	ASSERT 32'h13

.text
		ADDIU $2 $0 #0x11
		ADDIU $3 $0 #2
		ADDU $2 $2 $3
		JR $0

.data
