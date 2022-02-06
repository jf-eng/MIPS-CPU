.config
        ARCH v
        ASSERT 32'h12345678

.text
        LUI $2 #0x1234
        ADDIU $2 $2 #0x5678
        ADDIU $3 $0 #0x0000
        XOR $2 $2 $3
        JR $0
.data






