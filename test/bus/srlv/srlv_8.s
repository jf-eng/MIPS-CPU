.config
	ARCH v
	ASSERT 32'h0

.text
	ADDIU $2 $2 #0
	ADDIU $1 $0 #0
	SRLV $2 $2 $1      
	JR $0

.data



