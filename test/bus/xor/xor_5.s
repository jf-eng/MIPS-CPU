.config
        ARCH v
        ASSERT 32'h88888887

.text
        LUI $2 #0x1234
        ADDIU $2 $2 #0x5678
        LUI $3 #0x9ABC
        ADDIU $3 $3 #0x7EFF
        ADDIU $3 $3 #0x6000
        XOR $2 $2 $3
        JR $0
.data






