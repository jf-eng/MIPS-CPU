// basic OR truth table: $3 = 32'b0000 0000 0000 0000 0000 0000 0000 0011 (0x3), $2 = 32'b0000 0000 0000 0000 0000 0000 0000 0101 (0x5)
//outcome should be $2 = 32b'0000 0000 0000 0000 0000 0000 0000 0111 (0x7)

.config
	ARCH h
	ASSERT 32'b0111

.text
	ADDIU $2 $0 #0b0101
	ADDIU $3 $0 #0b0011
	OR $2 $2 $3
	JR $0

.data
