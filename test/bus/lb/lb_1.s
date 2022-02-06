.config
	ARCH v
	ASSERT 32'h00000057

.text
	LUI $1 #0x1357
	ADDIU $1 $1 #0x7bdf
	SW $1 #0($gp)

  LB $2 #1($gp)
	JR $0

.data
  