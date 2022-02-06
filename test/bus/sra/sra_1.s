// fill with 1's case / arithmetic shift

.config
	ARCH v
	ASSERT 32'hFFFFFFFF

.text
	ADDIU $1 $0 #0xFFFF
	SRA $2 $1 #6
	JR $0

.data
