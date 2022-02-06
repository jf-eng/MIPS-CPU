.config
	ARCH v
	ASSERT 32'h7125F333

.text
	LUI $1 0x7125
	ADDIU $1 $1 0x7123
	ORI $2 $1 #0xA231
	JR $0

.data
