.config
    ARCH h
    ASSERT 32'hc

.text
        ADDIU $1 $0 #21
        SUBU $2 $1 $0
        ADDIU $1 $0 #3
        SUBU $2 $2 $1
        SUBU $2 $2 $1
        SUBU $2 $2 $1
		JR $0

.data
