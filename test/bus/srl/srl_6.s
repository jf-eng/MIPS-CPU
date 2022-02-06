//largest number shifted by max ammount
.config
        ARCH v
        ASSERT 32'hFFFFFFF0
.text
        ADDIU $2 $2 #0xFFF0
        SRL $2 $2 #0
        JR $0
.data



  