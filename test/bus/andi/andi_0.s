// simple AND check

.config
	ARCH v
	ASSERT 32'h10

.text
		ADDIU $2 $0 #0x10
		ANDI $2 $2 #0x10
		JR $0

.data






