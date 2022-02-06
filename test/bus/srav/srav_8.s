// test if shifted only by last 5 bits of rs

.config
	ARCH v
	ASSERT 32'hFFFFF832

.text
	ADDIU $2 $0 #0x8321
    ADDIU $1 $0 #0xFF04
    SRAV $2 $2 $1
	JR $0

.data

