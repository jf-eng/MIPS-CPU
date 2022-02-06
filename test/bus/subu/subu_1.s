.config
	ARCH v
	ASSERT 32'hFFFFFFFC

.text
		ADDIU $1 $0 #0x2
		ADDIU $2 $0 #1
		SUBU $2 $2 $1
        ADDIU $1 $0 #3
        SUBU $2 $2 $1
		JR $0


.data
