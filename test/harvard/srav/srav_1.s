// pad 0's arithmetic

.config
	ARCH h
	ASSERT 32'h7FFFC

.text
	LW $1 #0($0)
	LW $2 #4($0)
	JR $0
	SRAV $2 $1 $2

.data
	#0x7FFFCCD
	#8
	