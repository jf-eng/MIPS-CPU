.config
	ARCH v
	ASSERT 156

.text
	ADDIU $2 $0 #20000 // $2 = #0b100111000100000
	ADDIU $1 $0 #7     // $1 = #7
	SRLV $2 $2 $1      // $2 = #0b10011100 = #156
	JR $0

.data
