.config
        ARCH h
        ASSERT 7
.text
        ADDIU $1 $0 #56
        SRL $2 $1 #3
        JR $0
.data
