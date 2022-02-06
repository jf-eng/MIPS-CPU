//largest number shifted by max ammount
.config
        ARCH v
        ASSERT 1
.text
        ADDIU $2 $2 #0xFFFF
        SRL $2 $2 #31
        JR $0
.data

  