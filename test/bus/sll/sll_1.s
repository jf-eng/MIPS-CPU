.config
	ARCH v
	ASSERT 96
.text
	ADDIU $1 $0 #12 // $1 = #0b1100
	SLL $2 $1 #3    // $2 = #0b1100000
	JR $0
.data
