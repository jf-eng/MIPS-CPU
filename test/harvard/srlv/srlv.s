// transfers value of 7 into $3 and 4 into $1 using addiu instruction, sllv then should load 7 * 2^4 = 112 into $2, but fails

.config
	ARCH h
	ASSERT 427

.text
	ADDIU $2 $0 #54783
  ADDIU $1 $0 #7
  SRLV $2 $2 $1
	JR $0

.data
