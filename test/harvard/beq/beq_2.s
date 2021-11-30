// BEQ branch true large

.config
	ARCH h
	ASSERT 32'hFFFFFFFF

.text
	LW $1 #0($0)
	LW $3 #4($0)
	BEQ $1 $3 here
	ADDU $2 $1 $0
	ADDIU $2 $2 #4
	ADDIU $2 $2 #4
here:
	JR $0
	NOP

.data
	#0xFFFFFFFF
	#0xFFFFFFFF
	