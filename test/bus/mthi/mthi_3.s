// check lo reg not being written to

.config
	ARCH v
	ASSERT 69

.text
	ADDIU $3 $0 #69
    MTLO $3
    ADDIU $1 $0 #420 
	MTHI $1
	MFLO $2
	JR $0

.data
