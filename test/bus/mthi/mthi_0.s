// transfers value of 69 from $1 to register HI in ALU using MTHI, then uses MFHI to transfer value to $2, the register whose contents are asserted

.config
	ARCH v
	ASSERT 69

.text
	ADDIU $1 $0 #69
	MTHI $1
	MFHI $2
	JR $0

.data
