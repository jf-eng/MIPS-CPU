.config
	ARCH v
	ASSERT 32'h1

.text
	ADDIU $2 $0 #0xFFFF
	ADDIU $1 $0 #31
	SRLV $2 $2 $1      
	JR $0

.data
