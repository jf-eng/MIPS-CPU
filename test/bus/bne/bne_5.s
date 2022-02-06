// branch false case

.config
	ARCH v
	ASSERT 32'hFFFFFFFE

.text
		LUI $1 0x7FFF
        ADDIU $1 $1 0x7FFF
        ADDIU $1 $1 0x5000
        ADDIU $1 $1 0x3000
		LUI $2 0x7FFF
        ADDIU $2 $2 0x7FFF
        ADDIU $2 $2 0x5000
        ADDIU $2 $2 0x3000
        BNE $2 $1 jump
		ADDU $2 $2 $1
		JR $0
        NOP
    jump:
        ADDIU $2 $0 #0x12
    end:
        JR $0
.data




