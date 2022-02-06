.config
        ARCH v
        ASSERT 32'b11010

.text
        ADDIU $1 $0 #0b10101
        ADDIU $3 $0 #0b01111
        XOR $2 $1 $3
        JR $0
.data



