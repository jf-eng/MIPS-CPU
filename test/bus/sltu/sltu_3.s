.config
        ARCH v
        ASSERT 1
.text
        ADDIU $3 $0 #0xFFFF
        ADDIU $1 $0 #0xFFFE
        SLTU $2 $1 $3
        JR $0
.data
