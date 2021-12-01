// SLTIU is sign extended then treated as unsigned

.config
	ARCH h
	ASSERT 1

.text
	LW $1 #0($0)
	JR $0
	SLTIU $2 $1 #0xFFFF // $1 is less than 0xFFFF since 0xFFFF is sign extended

.data
	#0x0FFFAAAA

	