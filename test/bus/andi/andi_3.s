.config
	ARCH v
	ASSERT 32'hFFFF

.text
		ADDIU $2 $0 #0xFFFF
		ANDI $2 $2 #0xFFFF
		JR $0

.data


