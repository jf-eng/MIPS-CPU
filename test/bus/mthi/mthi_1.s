// mthi performed twice

.config
	ARCH v
	ASSERT 420

.text
	ADDIU $2 $0 #69
    ADDIU $1 $0 #420 
	MTHI $2
    MTHI $1
	MFHI $2
	JR $0

.data
