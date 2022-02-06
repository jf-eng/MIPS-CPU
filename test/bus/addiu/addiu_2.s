.config
	ARCH v
	ASSERT 32'hFFFF0000

.text
	ADDIU $2 $0 #0x8000
	ADDIU $2 $2 #0x8000
	JR $0
	

.data






