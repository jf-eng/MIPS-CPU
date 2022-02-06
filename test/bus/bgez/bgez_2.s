// branch false

.config
	ARCH v
	ASSERT 32'hF123456C

.text
	LW $1 one
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
	one #0xF1234567
