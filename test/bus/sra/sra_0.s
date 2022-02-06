// fill with zeros / logical shift right case

.config
	ARCH v
	ASSERT 32'b100011

.text
	ADDIU $1 $0 #0x238
	SRA $2 $1 #4
	JR $0

.data
