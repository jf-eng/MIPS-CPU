.config
	ARCH v
	ASSERT 32'hFFFFFFFF

.text
	ADDIU $2 $0 #0x1
	ADDIU $2 $2 #0xFFFE
	JR $0
.data






