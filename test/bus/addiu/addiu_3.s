.config
	ARCH v
	ASSERT 32'hFFF

.text
	ADDIU $2 $0 #0x1000
	ADDIU $2 $2 #-1
	JR $0
	

.data






