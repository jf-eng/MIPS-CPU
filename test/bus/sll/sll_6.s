.config
	ARCH v
	ASSERT 32'h0
.text
	ADDIU $1 $0 #0 // $1 = #0h1
	SLL $2 $1 #0  // $2 = #0b0
	JR $0
.data

