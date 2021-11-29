.config
	ARCH h
	ASSERT 32'hFFFFFFFF

.text
	LW $1 0($0)
	MTLO $1
	JR $0
	MFLO $2

.data
	#0xFFFFFFFF

