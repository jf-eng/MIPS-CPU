// largest numbers*0
// -1*-1
.config
	ARCH v
	ASSERT 32'h0

.text
	ADDIU $2 $0 #0xFFFF
    //ADDIU $1 $0 #0xFFFF
    MULT $2 $1
    MFLO $2
    MFHI $1
    JR $0
    ADDU $2 $2 $1

.data


    