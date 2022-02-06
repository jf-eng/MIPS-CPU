// two largest numbers

.config
	ARCH v
	ASSERT 32'hFFFFF67C

.text
	ADDIU $2 $0 #0xF678
    ADDIU $3 $0 #0x1234
    OR $2 $2 $3
    JR $0

.data

