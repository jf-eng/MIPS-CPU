// pos * neg

.config
	ARCH h
	ASSERT -200

.text
	LW $4 first
	LW $5 second
	MULT $4 $5
	JR $0
	MFLO $2

.data
	first #40
	second #-5

