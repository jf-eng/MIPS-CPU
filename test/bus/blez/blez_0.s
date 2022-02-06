// less than 0

.config
	ARCH v
	ASSERT 2

.text
	ADDIU $3 $0 #0XFFFF
	SH $3 #0($gp)
	ADDIU $3 $0 #0XFFCE
	SH $3 #2($gp)
	LW $1 #0($gp)
	BLEZ $1 here
	ADDIU $2 $0 #1 // $2 = 1
	ADDIU $2 $2 #1
	ADDIU $2 $2 #1
	ADDIU $2 $2 #1
	ADDIU $2 $2 #1
here:
	JR $0
	ADDIU $2 $2 #1 // $2 = 2

.data
