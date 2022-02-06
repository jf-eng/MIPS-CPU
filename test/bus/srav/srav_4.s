// Shifting by a larger number than 31

.config
	ARCH v
	ASSERT 32'h7

.text
	LUI $1 #0x7FFF
	ADDIU $1 $1 #0x7FFF
	ADDIU $1 $1 #0x5000
	ADDIU $1 $1 #0x3000
	ADDIU $2 $0 #28
	JR $0
	SRAV $2 $1 $2

.data

	