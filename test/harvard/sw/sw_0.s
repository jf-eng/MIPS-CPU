.config
	ARCH h
	ASSERT 3040

.text
	LW $1 #0($0)
	SW $1 #16($0)
	JR $0
	LW $2 #16($0)


.data
	#3040
