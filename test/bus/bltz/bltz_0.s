// BLTZ branch false test

.config
	ARCH v
	ASSERT 2

.text
		ADDIU $1 $0 #1 // $1 = 1
		ADDIU $2 $0 #4 // $2 = 4
		BLTZ $2 jump   // no branch
		SUBU $2 $2 $1  // $2 = 3
	jump:
		SUBU $2 $2 $1  // $2 = 2
	end:
		JR $0

.data
