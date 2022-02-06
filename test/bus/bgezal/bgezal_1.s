.config
	ARCH v
	ASSERT 32'h3

.text
        ADDIU $1 $0 #4
        ADDIU $2 $0 #3
        SUBU $2 $2 $1
        BGEZAL $2 jump
        ADDIU $2 $0 #5 
        ADDIU $2 $0 #5
        NOP
        JR $0
        jump:
        ADDIU $2 $0 #3
		JR $0
.data
