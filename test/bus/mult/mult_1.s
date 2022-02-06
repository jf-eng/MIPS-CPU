// pos * neg

.config
	ARCH v
	ASSERT -200

.text
	ADDIU $4 $0 #40
	ADDIU $5 $0 #0xFFFB //-5 in unsigned int 
	MULT $4 $5
	MFLO $2
	MFHI $5
	JR $0



.data

