// largest numbers possible multiplication
// -1*-1
.config
	ARCH v
	ASSERT 32'h1

.text
	ADDIU $2 $0 #0xFFFF
    ADDIU $1 $0 #0xFFFF
    MULT $2 $1
    MFLO $2
    MFHI $1
    //ADDU $2 $2 $1
    JR $0
.data



