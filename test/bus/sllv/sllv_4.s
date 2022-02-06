// largest shift possible 32 bits

.config
	ARCH v
	ASSERT 32'h80000000

.text
	ADDIU $2 $0 #0xFFFF
    ADDIU $1 $0 #0xFFFF
    SLLV $2 $2 $1
	JR $0

.data


