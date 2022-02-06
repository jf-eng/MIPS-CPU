.config
	ARCH v
	ASSERT 0
.text
	ADDIU $1 $0 #0x0 // $1 = #0hFFFFFFFF
	SLL $2 $1 #32   // $2 = #0b0
	JR $0
.data



