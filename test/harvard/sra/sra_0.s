// fill with zeros / logical shift right case

.config
	ARCH h
	ASSERT 32'b100011

.text
	LW $1 #0($0)
	SRA $2 $1 #4
	JR $0

.data
	#568 // 0b1000111000
