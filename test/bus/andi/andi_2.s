.config
	ARCH v
	ASSERT 32'h0000C220

.text
		ADDIU $2 $0 #0xC678
		ANDI $2 $2 #0xF321
		JR $0

.data


