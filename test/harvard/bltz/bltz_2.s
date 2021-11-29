// #0 edge case test

.config
	ARCH h
	ASSERT 12

.text
	LW $1 0($0)
	BLTZ $1 here
	ADDIU $2 $2 #3 // $2 = 3
	ADDIU $2 $2 #3 // $2 = 6
	ADDIU $2 $2 #3 // $2 = 9
here:
	JR $0
	ADDIU $2 $2 #3 // $2 = 12

.data
	#0x00000000
