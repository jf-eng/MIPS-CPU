.config
	ARCH h
	ASSERT 3

.text
	LW $2 three
	JR $0

.data
	three #3 // addr = 0
	#2 // addr = 4
