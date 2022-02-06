.config
	ARCH v
	ASSERT 0

.text
	LW $1 one
	JR $0
	SLTIU $2 $1 #0

.data
	one #0xFFFFFFFF

	