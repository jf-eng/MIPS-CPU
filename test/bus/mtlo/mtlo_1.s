// mtlo performed twice

.config
	ARCH v
	ASSERT 420

.text
	ADDIU $2 $0 #69
    ADDIU $1 $0 #420 
	MTLO $2
    MTLO $1
	MFLO $2
	JR $0

.data
