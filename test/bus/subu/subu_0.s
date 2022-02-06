.config
    ARCH v
    ASSERT 32'hFFFFFFFD

.text
        ADDIU $1 $0 #21
        SUBU $2 $1 $0
        ADDIU $1 $0 #3
        SUBU $2 $2 $1
        SUBU $2 $2 $1
        SUBU $2 $2 $1
        ADDIU $1 $0 #15
        SUBU $2 $2 $1
		JR $0

.data
