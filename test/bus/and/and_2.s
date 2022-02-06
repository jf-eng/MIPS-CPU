//0x00000000 AND 0xFFFFFFFF

.config
	ARCH v
	ASSERT 32'b0

.text
	ADDIU $1 $0 #0xFFFF
	AND $2 $1 $0
	JR $0

.data
