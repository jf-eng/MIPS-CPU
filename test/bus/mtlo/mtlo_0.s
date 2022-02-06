// transfers value of 69 from $1 to register LO in ALU using MTLO, then uses MFLO to transfer value to $2, the register whose contents are asserted

.config
	ARCH v
	ASSERT 69

.text
	ADDIU $1 $0 #69
	MTLO $1
	MFLO $2
	JR $0

.data
