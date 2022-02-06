// transfers value of 48 into $3 and 4 into $1 using addiu instruction, srlv then should load 48 % 2^4 = 3 into $2, but fails

.config
	ARCH v
	ASSERT 3

.text
	ADDIU $3 $0 #48
    ADDIU $1 $0 #4
    SRLV $2 $3 $1
	JR $0

.data
