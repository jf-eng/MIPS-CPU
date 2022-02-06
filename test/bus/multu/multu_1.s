// tests 120000 x 330050 = 64'h9 38B3 9980, checks that HI = 32'h9

.config
	ARCH v
	ASSERT 32'h9
	

.text
	LUI $1 #0x1
	ADDIU $1 $1 #0x74C0
	ADDIU $1 $1 #0x6000
	LUI $2 #0x5
	ADDIU $2 $2 #0x0942
	MULTU $1 $2
	MFHI $2
	JR $0


.data
