.config
	ARCH v
	ASSERT 32'hBFC00029

.text
	NOP
	NOP
	LW $1 0($gp)
	NOP
	BGEZAL $1 #3
	ADDIU $2 $31 #0
	JR $0
	NOP
	ADDIU $2 $31 #1
	JR $0

.data

