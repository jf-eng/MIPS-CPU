// eq to 0

.config
	ARCH v
	ASSERT 3

.text
	LW $1 #0($gp)
	BLEZ $0 here
	ADDIU $2 $0 #1 // $2 = 1
	ADDIU $2 $2 #1
	ADDIU $2 $2 #1
	ADDIU $2 $2 #1
	ADDIU $2 $2 #1
here:
  ADDIU $2 $2 #1 // $2 = 2
	JR $0
	ADDIU $2 $2 #1 // $2 = 3

.data
