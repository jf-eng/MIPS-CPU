.config
	ARCH h
	ASSERT 32'hFFFFFFFF

.text
        ADDIU $1 $0 #4
        ADDIU $2 $0 #3
        BGEZAL $2 jump
        SUBU $2 $2 $1
        JR $0
        jump:
        ADDU $2 $2 $1
        end:
		JR $0
.data
