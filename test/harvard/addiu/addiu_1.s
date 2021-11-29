.config
	ARCH h
	ASSERT 32'h8111

.text
	ADDIU $2 $0 #0x8111
	JR $0

.data
