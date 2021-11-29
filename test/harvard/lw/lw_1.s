// hi this is a commnet h'9 200 230 s

.config
	ARCH h
	ASSERT 32'hD2F1ACB0

.text
	LW $2 0($0)
	// XORI $2 $2 #0x25FB
	JR $0

.data
	#0xD2F1ACB0
