// +ve, quotient and remainder, 69/7 = 9R6, Q + R = 15, overwrite initial contents of HILO

.config
	ARCH v
	ASSERT 15

.text
    ADDIU $3 $0 #420
    MTHI $3
    MTLO $3
	ADDIU $1 $0 #69
	ADDIU $2 $0 #7
	DIV $1 $2
	MFHI $3
    MFLO $4
    ADDU $2 $3 $4
	JR $0

.data
