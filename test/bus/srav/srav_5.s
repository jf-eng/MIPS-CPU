// Shifting by the largest number where the result is non zero 

.config
	ARCH v
	ASSERT 32'h7FFFFFF
.text
	LUI $1 #0x7FFF
	ADDIU $1 $1 #0x7FFF
	ADDIU $1 $1 #0x5000
	ADDIU $1 $1 #0x3000
	ADDIU $2 $0 #0x4
	SRAV $2 $1 $2
	JR $0

.data
