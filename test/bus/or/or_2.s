// two largest numbers

.config
	ARCH v
	ASSERT 32'hFFFFFFFF

.text
	ADDIU $2 $0 #0xFFFF
    ADDIU $3 $0 #0xFFFF
    OR $2 $2 $3
    JR $0

.data

