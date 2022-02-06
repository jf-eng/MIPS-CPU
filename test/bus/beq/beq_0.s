// BEQ branch true

.config
	ARCH v
	ASSERT 32'h404

.text
	ADDIU $4 $0 #0X400
	SW $4 #0($gp)
	SW $4 #4($gp)
	LW $1 #0($gp)
	LW $3 #4($gp)
	BEQ $1 $3 here
	ADDIU $2 $1 #4 // $2 = #0x404
	ADDIU $2 $1 #4
	ADDIU $2 $1 #4
	ADDIU $2 $1 #4
	ADDIU $2 $1 #4
	ADDIU $2 $1 #4
here:
	JR $0
	NOP

.data
