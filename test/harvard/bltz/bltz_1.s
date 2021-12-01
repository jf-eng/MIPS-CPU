# BLTZ branch true test

.config
	ARCH h
	ASSERT 6

.text
	LW $1 0($0)
	BLTZ $1 here
	ADDIU $2 $2 #3 // $2 = 3
	ADDIU $2 $2 #3 // not done
	ADDIU $2 $2 #3 // not done
here:
	JR $0
	ADDIU $2 $2 #3 // $2 = 6

.data
	#0xF0000000
