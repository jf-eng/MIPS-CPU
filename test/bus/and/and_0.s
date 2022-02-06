//truth table, rd same as rs

.config
	ARCH v
	ASSERT 32'b0001

.text
	ADDIU $2 $0 #0b0011
	ADDIU $3 $0 #0b0101
	AND $2 $2 $3
	JR $0

.data
