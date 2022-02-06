.config
	ARCH v
	ASSERT 32'hFFFFFFFF
.text
	ADDIU $1 $0 #0xFFFF // $1 = #0hFFFFFFFF
	SLL $2 $1 #0   // $2 = #0b0
	JR $0
.data



