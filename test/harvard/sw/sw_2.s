.config
	ARCH h
	ASSERT 32'hFFFFFFFF

.text
	LW $1 one
	SW $1 three
	JR $0
	LW $2 three


.data
	one #0xFFFFFFFF
	two #0
	three #3
