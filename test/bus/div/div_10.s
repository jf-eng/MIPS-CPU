// check rs remains same after DIV

.config
	ARCH v
	ASSERT -69

.text
	ADDIU $1 $0 #-69
	ADDIU $2 $0 #7
	DIV $1 $2
    ADDU $2 $1 $0
	JR $0

.data
