.config
	ARCH v
	ASSERT 32'h8

.text
		ADDIU $1 $0 #5
		ADDIU $2 $0 #2
        J loop
        SUBU $2 $1 $2
        ADDIU $2 $0 #15
		JR $0
    loop:
        ADDU $2 $2 $1
    end:
		JR $0

.data
