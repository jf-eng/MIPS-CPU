// neg * neg

.config
	ARCH v
	ASSERT 200

.text
	ADDIU $5 $0 #0xFFD8
	ADDIU $4 $0 #0xFFFB
	MULT $4 $5
	JR $0
	MFLO $2

.data

