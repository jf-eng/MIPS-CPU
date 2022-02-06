//largest number shifted by max ammount
.config
        ARCH v
        ASSERT 1
.text
        LUI $1 #0x7FFF
	ADDIU $1 $1 #0x7FFF
	ADDIU $1 $1 #0x5000
	ADDIU $1 $1 #0x3000
        SRL $2 $1 #30
        JR $0
.data



  