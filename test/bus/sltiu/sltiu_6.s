.config
	ARCH v
	ASSERT 1

.text
	LW $1 one
	JR $0
	SLTIU $2 $1 #0xFFFF

.data
	one #0x7FFFFFFF

	