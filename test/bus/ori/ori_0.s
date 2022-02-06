.config
	ARCH v
	ASSERT 32'h40002202

.text
	LUI $t0 #0x4000
	ADDIU $t0 $t0 #0x2
	ORI $v0 $t0 #0x2200
	JR $0

.data
