.config
	ARCH v
	ASSERT 32'h1

.text
	LUI $2 #0x7FFF
	ADDIU $2 $2 #0x7FFF
    ADDIU $2 $2 #0x5000
    ADDIU $2 $2 #0x3000
    LUI $1 #0x7FFF
	ADDIU $1 $1 #0x7FFF
    ADDIU $1 $1 #0x7000
    ADDIU $1 $1 #0x1000
    MULT $2 $1
    MFLO $2
    //MFHI $2
    JR $0
.data
	
