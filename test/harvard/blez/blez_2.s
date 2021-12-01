// greater than to 0 (should not branch)

.config
	ARCH h
	ASSERT 6

.text
	LW $1 #0($0)
	BLEZ $1 here
	ADDIU $2 $0 #1 // $2 = 1
	ADDIU $2 $2 #1
	ADDIU $2 $2 #1
	ADDIU $2 $2 #1
	ADDIU $2 $2 #1 // $2 = 5
here:
	JR $0
	ADDIU $2 $2 #1 // $2 = 6

.data
	#40
