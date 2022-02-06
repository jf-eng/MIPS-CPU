// ZERO extend check

.config
	ARCH v
	ASSERT 32'h00008000

.text
		ADDIU $2 $0 #0x8000
		ANDI $2 $2 #0xFFFF
		JR $0

.data



