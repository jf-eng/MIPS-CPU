.config
	ARCH v
	ASSERT 60

.text
	ADDIU $1 $0 #40
	SW $1 #0($gp)
	JAL func
	LW $2 #0($gp)
	JR $0
	NOP

	func: // add20 to r2
		JR $31
		ADDIU $2 $2 #20

.data

