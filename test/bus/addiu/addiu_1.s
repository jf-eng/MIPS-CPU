.config
	ARCH v
	ASSERT 32'hFFFFFFFF

.text

	ADDIU $2 $0 #0x8000
	ADDIU $2 $2 #0x7FFF
	JR $0
	

.data



