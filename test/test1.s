//BRANCH ON LESS THAN ZERO AND LINK - SHOULDN'T WORK

.config
	ARCH h
	ASSERT 0

.text
		ADDIU $1 $0 #2
		ADDIU $3 $0 #4
		ADDU $1 $1 $3
		BLTZAL $2 jump
		NOP
		JR $0
	jump:
		ADDIU $2 $0 #69
		JR $31
		NOP

.data
