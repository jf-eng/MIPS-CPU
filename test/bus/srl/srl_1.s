.config
        ARCH v
        ASSERT 3
.text
        ADDIU $2 $2 #0xFFFF
        SRL $2 $2 #30
        JR $0
.data

  