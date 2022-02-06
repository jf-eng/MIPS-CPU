// test if shifted only by last 5 bits of rs

.config
	ARCH v
	ASSERT 32'h2510

.text
	ADDIU $2 $0 #0x251
    ADDIU $1 $0 #0xff04
    SLLV $2 $2 $1
	JR $0

.data


