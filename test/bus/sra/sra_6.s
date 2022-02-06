// shifting the largest non negative number by 31 (the largest shift)

.config
	ARCH v
	ASSERT 32'h7FFFFFFF

.text
    LUI $1 #0x7FFF
	ADDIU $1 $1 #0x7FFF
    ADDIU $1 $1 #0x5000
    ADDIU $1 $1 #0x3000
	SRA $2 $1 #0
	JR $0

.data
