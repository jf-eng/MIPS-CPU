// tests 12 x 33 = 396 = 32'h 18C, checks that LO = 32'h18C

.config
	ARCH v
	ASSERT 32'h18C

.text
    ADDIU $1 $0 #12
	ADDIU $2 $0 #33
	MULTU $1 $2
	MFLO $2
	JR $0

.data
	
