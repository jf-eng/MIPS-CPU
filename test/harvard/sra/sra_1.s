// fill with 1's case / arithmetic shift

.config
	ARCH h
	ASSERT 32'hFFFFFFFF

.text
	LW $1 #0($0)
	SRA $2 $1 #6
	JR $0

.data
	#0xFFFFFFFF
