// greater than to 0 (should not branch)

.config
	ARCH v
	ASSERT 6

.text
	ADDIU $3 $0 #40
	SW $3 #0($gp)
	LW $1 #0($gp)
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

