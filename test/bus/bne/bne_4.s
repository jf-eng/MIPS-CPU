// branch false case

.config
	ARCH v
	ASSERT 32'hFFFFFFFE

.text
		ADDIU $1 $0 #0xFFFF
		ADDIU $2 $0 #0xFFFF
        BNE $2 $1 jump
		ADDU $2 $2 $1
		JR $0
        NOP
    jump:
        ADDIU $2 $0 #0x12
    end:
        JR $0
.data




