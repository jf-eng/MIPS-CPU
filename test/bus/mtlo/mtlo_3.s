// check hi reg not being written to

.config
	ARCH v
	ASSERT 69

.text
	ADDIU $3 $0 #69
    MTHI $3
    ADDIU $1 $0 #420 
	MTLO $1
	MFHI $2
	JR $0

.data
