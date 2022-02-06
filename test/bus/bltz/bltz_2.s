// #0 edge case test

.config
	ARCH v
	ASSERT 12

.text
	LW $1 #0($gp)
	BLTZ $1 here
	ADDIU $2 $2 #3 // $2 = 3
	ADDIU $2 $2 #3 // $2 = 6
	ADDIU $2 $2 #3 // $2 = 9
here:
	JR $0
	ADDIU $2 $2 #3 // $2 = 12

.data
