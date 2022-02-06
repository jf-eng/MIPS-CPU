// fourth byte no sign extend

.config
	ARCH v
	ASSERT 32'h000000F7

.text
	LUI $1 #0x1234
	ADDIU $1 $1 #0x56F7
	SW $1 #0($gp)
	LBU $2 #3($gp)
	JR $0

.data
  