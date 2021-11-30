.config
	ARCH h
	ASSERT 0

.text
	LW $1 #0($0)
	JR $0
	SLTIU $2 $1 #0x4FFF

.data
	#0xFFFFAAAA

	