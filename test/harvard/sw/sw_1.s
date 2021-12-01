.config
	ARCH h
	ASSERT 32'hFFFFFFFF

.text
	LW $1 #0($0)
	SW $1 #12($0)
	JR $0
	LW $2 #12($0)


.data
	#0xFFFFFFFF
