.config
	ARCH v
	ASSERT 32'hFFFFFFFF

.text
	ADDIU $2 $0 #0xFFFF
    ADDIU $1 $0 #2
    MULT $2 $1
    //MFLO $2
    //MFHI $2
    JR $0
.data
