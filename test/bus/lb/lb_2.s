.config
	ARCH v
	ASSERT 32'h7B

.text
	LUI $1 #0x1357
	ADDIU $1 $1 #0x7bdf
	SW $1 #0($gp)

  LB $2 #2($gp)
	JR $0

.data
  