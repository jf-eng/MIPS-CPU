// transfers value of 7 into $3 and 4 into $1 using addiu instruction, sllv then should load 7 * 2^4 = 40 into $2, but fails

.config
	ARCH v
	ASSERT 112

.text
	ADDIU $3 $0 #7
    ADDIU $1 $0 #4
    SLLV $2 $3 $1
	JR $0

.data
