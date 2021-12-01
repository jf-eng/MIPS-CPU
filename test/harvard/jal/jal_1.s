.config
	ARCH h
	ASSERT 60

.text
	JAL func
	LW $2 0($0)
	JR $0
	NOP

	func: // add20 to r2
		JR $31
		ADDIU $2 $2 #20

.data
	#40

