// branch true

.config
	ARCH v
	ASSERT 5

.text
	ADDIU $1 $0 #4 // $1 = 4
	BGEZ $1 here
	ADDIU $1 $1 #1 // $1 = 5
	ADDIU $1 $1 #1
	ADDIU $1 $1 #1
	ADDIU $1 $1 #1
	ADDIU $1 $1 #1
here:
	JR $0
	ADDU $2 $1 $0 // MOV $2 $1

.data

