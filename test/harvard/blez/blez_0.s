// less than 0

.config
	ARCH h
	ASSERT 2

.text
	LW $1 #0($0)
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
	#-50
