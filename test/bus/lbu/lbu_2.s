// third byte

.config
	ARCH v
	ASSERT 32'h56

.text
	LUI $1 #0x1234
	ADDIU $1 $1 #0x5678
	SW $1 #0($gp)
	LBU $2 #2($gp)
	JR $0

.data
  