// tests 120000 x 330050 = 64'h9 38B3 9980, checks that LO = 32'h 38B3 9980

.config
	ARCH h
	ASSERT 32'h38B39980


.text
	LW $1 op1
	LW $2 op2
	MULTU $1 $2
	MFLO $2
	JR $0


.data
    op1 #120000
    op2 #330050
	