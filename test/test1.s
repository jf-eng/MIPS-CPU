.config
    ARCH v
    ASSERT 1

.text
    LW $1 one
    LW $3 two
    JR $0
    ADDU $2 $1 $3

.data
    one #0xFFFFFFFF
    two #0x00000002
	