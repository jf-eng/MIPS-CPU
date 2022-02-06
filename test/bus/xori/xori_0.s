// rt = 32'b1101 0010 1111 0001 1010 1100 1011 0000 (32'hD2F1ACB0), imm = 16'b0010 0101 1111 1011 (16'h25FB) (zero extended to 32-bits to perform op)
// outcome of XOR op should be: rd = 32'b1101 0010 1111 0001 1000 1001 0100 1011 (32'hD2F1894B)

.config
	ARCH v
	ASSERT 32'hD2F1894B

.text
	ADDIU $3 $0 #0xD2F1
	SH $3 #0($gp)
	ADDIU $3 $0 #0xACB0
	SH $3 #2($gp)
	LW $1 #0($gp)
	XORI $2 $1 #0x25FB
	JR $0

.data
