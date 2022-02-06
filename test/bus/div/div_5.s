// -ve, quotient and remainder, -69/-7 = 9R-6, Q + R = 3

.config
	ARCH v
	ASSERT 3

.text
	ADDIU $1 $0 #-69
	ADDIU $2 $0 #-7
	DIV $1 $2
	MFHI $3
    MFLO $4
    ADDU $2 $3 $4
	JR $0

.data
