.config
	ARCH v
	ASSERT 32'hffff9357

.text 
	LUI $1 #0x9357
	ADDIU $1 $1 #0x7bdf
	SW $1 #0($gp)
	LH $2 #0($gp)
	JR $0

.data
  