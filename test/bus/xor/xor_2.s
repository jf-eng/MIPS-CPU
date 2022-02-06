.config
        ARCH v
        ASSERT 32'h0

.text
        ADDIU $1 $0 #0xFFFF
        ADDIU $3 $0 #0xFFFF
        XOR $2 $1 $3
        JR $0
.data






