.config
	ARCH h
	ASSERT 32'hFFFFFFFF

.text
	JR $0
	LW $2 4($0)

.data
	#0xD2F1ACB0
	#0xFFFFFFFF
