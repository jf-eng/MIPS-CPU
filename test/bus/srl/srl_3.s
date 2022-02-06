//largest number shifted by max ammount
.config
        ARCH v
        ASSERT 0
.text
        LUI $2 #0x7FFF
	ADDIU $2 $2 #0x7FFF
	ADDIU $2 $2 #0x5000
	ADDIU $2 $2 #0x3000
        SRL $2 $2 #31
        JR $0
.data



  