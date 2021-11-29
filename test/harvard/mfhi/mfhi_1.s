.config
	ARCH h
	ASSERT 32'hFFFFFFFF

.text
	LW $1 0($0)
	MTHI $1
	JR $0
	MFHI $2

.data
	#0xFFFFFFFF

