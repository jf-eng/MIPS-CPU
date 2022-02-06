.config
	ARCH v
	ASSERT 32'hFFFFFFFF

.text
	ADDIU $t0 $zero #0xFFFF
	ORI $v0 $t0 #0
	JR $0

.data
