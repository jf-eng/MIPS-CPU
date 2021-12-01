.config
	ARCH h
	ASSERT 1

.text
		LW $1 #0($0)
		LW $3 #4($0)
		JR $0
		ADDU $2 $1 $3

.data
	#0xFFFFFFFF
	#0x00000002
