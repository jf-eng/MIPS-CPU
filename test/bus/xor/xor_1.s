.config
        ARCH v
        ASSERT 32'hFFFFFFFF

.text
        ADDIU $1 $0 #0xFFFF
        ADDIU $3 $0 #0x0000
        XOR $2 $1 $3
        JR $0
.data






