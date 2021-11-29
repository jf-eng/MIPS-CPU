.config
	ARCH h
	ASSERT 34

.text
	LW $1 0($0)
	MTLO $1
	MFLO $2
	JR $0

.data
	#34

