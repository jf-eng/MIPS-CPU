.config
	ARCH h
	ASSERT 32'h12

.text
		ADDIU $1 $0 #15
		ADDIU $2 $0 #5
        BNE $2 $1 jump
		ADDU $2 $2 $1
		JR $0
        NOP
    jump:
        ADDIU $2 $0 #0x12
    end:
        JR $0
.data









