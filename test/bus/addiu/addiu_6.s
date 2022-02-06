.config
	ARCH v
	ASSERT 32'hFFFFFFFE

.text
	ADDIU $2 $0 #0xFFFF
	ADDIU $2 $2 #0xFFFF
	JR $0
.data






