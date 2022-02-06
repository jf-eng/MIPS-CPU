.config
	ARCH v
	ASSERT 32'h5

.text
        ADDIU $1 $0 #1
        ADDIU $2 $0 #3
        BGEZAL $2 jump
        SUBU $2 $2 $1
        ADDIU $2 $0 #5
        JR $0
        NOP

    jump:
        SUBU $2 $2 $1
        JR $31
        ADDU $0 $0 $0
    end:
        JR $0
.data
