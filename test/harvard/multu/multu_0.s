// tests 120000 x 330050 = 64'h9 38B3 9980, checks that LO = 32'h 38B3 9980

.config
	ARCH h
	ASSERT 32'h38B39980

.text
	ADDIU $1 $0 #120000
	ADDIU $2 $0 #330050
	MULTU $1 $2
	MFLO $2
	JR $0

.data
