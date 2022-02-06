.config
	ARCH v
	ASSERT 32'h5777

.text
	ADDIU $t0 $zero #0x1234
	ORI $v0 $t0 #0x4567
	JR $0

.data
