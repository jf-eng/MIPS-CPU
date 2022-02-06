// largest shift possible 32 bits

.config
	ARCH v
	ASSERT 32'h2510000

.text
	ADDIU $2 $0 #0x251
    ADDIU $1 $0 #16
    SLLV $2 $2 $1
	JR $0

.data


