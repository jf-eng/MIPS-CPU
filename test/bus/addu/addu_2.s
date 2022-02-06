#overflow, diff registers

.config
	ARCH v
	ASSERT 1

.text
	ADDIU $1 $0 #0xFFFF
	ADDIU $3 $0 #0x2
	JR $0
	ADDU $2 $1 $3

.data


