// tests 120000 x 330050 = 64'h9 38B3 9980, checks that LO = 32'h 38B3 9980

.config
	ARCH v
	ASSERT 32'h38B39980


.text
	LUI $1 #0x1
	ADDIU $1 $1 #0x74C0
	ADDIU $1 $1 #0x6000
	LUI $2 #0x5
	ADDIU $2 $2 #0x0942
	MULTU $1 $2
	MFLO $2
	JR $0

.data


	