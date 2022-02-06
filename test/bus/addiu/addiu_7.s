.config
	ARCH v
	ASSERT 32'h80000000

.text
	LUI $2 0x7FFF
    ADDIU $2 $2 0x7FFF
    ADDIU $2 $2 0x5000
    ADDIU $2 $2 0x3000
	ADDIU $2 $2 #1
	JR $0
.data






