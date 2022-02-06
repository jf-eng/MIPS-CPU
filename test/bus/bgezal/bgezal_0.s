.config
	ARCH v
	ASSERT 32'h1

.text
        ADDIU $1 $0 #1
        ADDIU $2 $0 #3
        BGEZAL $2 jump
        SUBU $2 $2 $1
        jump:
        SUBU $2 $2 $1
        end:
		JR $0
.data
