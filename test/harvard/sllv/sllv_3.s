// 32'b1011 1111 1101 1011 0010 1010 1001 1000 (32'hBFDB2A98) << 1 = 32'b0111 1111 1011 0110 0101 0101 0011 0000 (32'h7FB65530)
// Edge case as MSB of 1 is shifted out, meaning rd != rt * 2^rs

.config
	ARCH h
	ASSERT 32'h7FB65530

.text
	LW $3 0($0)
    ADDIU $1 $0 #1
    SLLV $2 $3 $1
	JR $0

.data
	#0xBFDB2A98
