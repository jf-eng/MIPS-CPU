.config
        ARCH h
        ASSERT 3
.text
        ADDIU $1 $0 #1
        ADDIU $2 $0 #4
        BLTZ $2 jump
        SUBU $2 $2 $1
        jump:
        SUBU $2 $2 $1
        end:
        JR $0
.data



