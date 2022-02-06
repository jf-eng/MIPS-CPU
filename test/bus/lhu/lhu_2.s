.config
	ARCH v
	ASSERT 32'h00009357

.text 
	LUI $1 #0x9357
	ADDIU $1 $1 #0x7bdf
	SW $1 #0($gp)
	LHU $2 #0($gp)
	JR $0

.data

  