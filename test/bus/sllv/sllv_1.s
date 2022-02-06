// transfers value of 5 into $2 and 3 into $1 using addiu instruction, sllv then should load 5 * 2^3 = 40 back into $2, but fails

.config
	ARCH v
	ASSERT 40

.text
	ADDIU $2 $0 #5
    ADDIU $1 $0 #3
    SLLV $2 $2 $1
	JR $0

.data
