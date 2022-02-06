// shift by 0

.config
	ARCH v
	ASSERT 32'h3756

.text
	ADDIU $1 $0 #0x3756
	SRA $2 $1 #0
	JR $0

.data
