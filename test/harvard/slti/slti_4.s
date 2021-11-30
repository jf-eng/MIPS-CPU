.config
	ARCH h
	ASSERT 0

.text
	LW $1 #0($0)
	JR $0
	SLTI $2 $1 #0xFFFF // -1

.data
	#0xFFFFFFFF // -1

