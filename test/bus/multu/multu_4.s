// largest numbers possible multiplication
// -1*-1
.config
	ARCH v
	ASSERT 32'hFFFFFFFE
.text
	ADDIU $2 $0 #0xFFFF
    ADDIU $1 $0 #0xFFFF
    MULTU $2 $1
    MFLO $2
    MFHI $2
    JR $0

.data




   