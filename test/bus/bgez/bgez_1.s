// branch false

.config
	ARCH v
	ASSERT 32'hF123456C

.text
	ADDIU $3 $0 #0XF123
	SH $3 #0($gp)
	ADDIU $3 $0 #0X4567
	SH $3 #2($gp)
	LW $1 #0($gp)
	BGEZ $1 here
	ADDIU $1 $1 #1 // $1 = 0xF1234568
	ADDIU $1 $1 #1
	ADDIU $1 $1 #1
	ADDIU $1 $1 #1
	ADDIU $1 $1 #1 // $1 = 0xF123456C
here:
	JR $0
	ADDU $2 $1 $0 // MOV $2 $1

.data
