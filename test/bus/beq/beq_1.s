// BEQ branch false

.config
	ARCH v
	ASSERT 32'h40C

.text
	ADDIU $4 $0 #0X400
	SW $4 #0($gp)
	ADDIU $4 $0 #0X401
	SW $4 #4($gp)
	LW $1 #0($gp)
	LW $3 #4($gp)
	BEQ $1 $3 here
	ADDIU $2 $1 #4 // $2 = #0x404
	ADDIU $2 $2 #4 // $2 = #0x408
	ADDIU $2 $2 #4 // $2 = #0x40C
here:
	JR $0
	NOP

.data
