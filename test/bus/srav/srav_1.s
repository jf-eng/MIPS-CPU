// pad 0's arithmetic

.config
	ARCH v
	ASSERT 32'h7FFFC

.text
	LUI $1 #0x7FF
	ADDIU $1 $1 #0x7CCD
	ADDIU $1 $1 #0x5000
	ADDIU $1 $1 #0x3000
	ADDIU $2 $2 #8
	JR $0
	SRAV $2 $1 $2

.data
	