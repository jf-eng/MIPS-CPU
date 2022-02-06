// test if shifted only by last 5 bits of rs

.config
	ARCH v
	ASSERT 32'h251

.text
	ADDIU $2 $0 #0x2510
    ADDIU $1 $0 #0xff04
    SRLV $2 $2 $1
	JR $0

.data

