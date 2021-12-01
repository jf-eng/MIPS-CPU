.config
	ARCH h
	ASSERT 32'b0011

.text
	ADDIU $2 $0 #0b1011
	ADDIU $3 $0 #0b0111
	AND $2 $2 $3
	JR $0

.data
