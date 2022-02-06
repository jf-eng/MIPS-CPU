// transfers value of 49 into $2 and 3 into $1 using addiu instruction, srlv then should load 49 % 2^3 = 6 back into $2, but fails

.config
	ARCH v
	ASSERT 6

.text
	ADDIU $2 $0 #49
    ADDIU $1 $0 #3
    SRLV $2 $2 $1
	JR $0

.data
