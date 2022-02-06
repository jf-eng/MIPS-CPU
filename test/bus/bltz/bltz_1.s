# BLTZ branch true test

.config
	ARCH v
	ASSERT 6

.text
	ADDIU $3 $0 #0XF0
	SB $3 #0($gp)
	LW $1 #0($gp)
	BLTZ $1 here
	ADDIU $2 $2 #3 // $2 = 3
	ADDIU $2 $2 #3 // not done
	ADDIU $2 $2 #3 // not done
here:
	JR $0
	ADDIU $2 $2 #3 // $2 = 6

.data

