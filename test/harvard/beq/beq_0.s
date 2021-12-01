// BEQ branch true

.config
	ARCH h
	ASSERT 32'h404

.text
	LW $1 #0($0)
	LW $3 #4($0)
	BEQ $1 $3 here
	ADDIU $2 $1 #4 // $2 = #0x404
	ADDIU $2 $1 #4
	ADDIU $2 $1 #4
	ADDIU $2 $1 #4
	ADDIU $2 $1 #4
	ADDIU $2 $1 #4
here:
	JR $0
	NOP

.data
	#0x400
	#0x400

	