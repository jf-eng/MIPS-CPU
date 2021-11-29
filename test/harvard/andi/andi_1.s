.config
	ARCH h
	ASSERT 32'hFFFF8000

.text
		ADDIU $2 $0 #0x8000
		ANDI $2 $2 #0xFFFF
		JR $0

.data



