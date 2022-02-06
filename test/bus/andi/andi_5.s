.config
	ARCH v
	ASSERT 32'h1234

.text
		LUI $2 #0xFFFF
		ADDIU $2 $0 #0x1234
		ANDI $2 $2 #0xFFFF
		JR $0

.data


