// shifting the largest non negative number by 31 (the largest shift)

.config
	ARCH v
	ASSERT 32'h0

.text
	ADDIU $1 $1 #0x0
	SRA $2 $1 #0
	JR $0

.data
