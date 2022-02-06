.config
	ARCH v
	ASSERT 32'h80000000
.text
	ADDIU $1 $0 #0x251 // $1 = #0h1
	SLL $2 $1 #31   // $2 = #0b0
	JR $0
.data



