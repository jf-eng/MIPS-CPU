// BEQ branch true large

.config
	ARCH v
	ASSERT 32'hFFFFFFFF

.text
	ADDIU $4 $0 #0XFFFF
	SH $4 #0($gp)
	SH $4 #2($gp)
	SH $4 #4($gp)
	SH $4 #6($gp)
	LW $1 #0($gp)
	LW $3 #4($gp)
	BEQ $1 $3 here
	ADDU $2 $1 $0
	ADDIU $2 $2 #4
	ADDIU $2 $2 #4
here:
	JR $0
	NOP

.data
