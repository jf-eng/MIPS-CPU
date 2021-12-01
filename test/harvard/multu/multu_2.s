// tests 12 x 33 = 396 = 32'h 18C, checks that LO = 32'h18C

.config
	ARCH h
	ASSERT 32'h18C

.text
    LW $1 op1
    LW $2 op2
	MULTU $1 $2
	MFLO $2
	JR $0

.data
    op1 #12
    op2 #33
	
