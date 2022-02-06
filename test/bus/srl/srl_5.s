//largest number shifted by max ammount
.config
        ARCH v
        ASSERT 32'h7FFFFF
.text
        ADDIU $2 $2 #0xFFF0
        SRL $2 $2 #9
        JR $0
.data



  