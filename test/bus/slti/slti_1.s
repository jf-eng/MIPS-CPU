// negative < positive

.config
	ARCH v
	ASSERT 1

.text
	LW $1 one
	JR $0
	SLTI $2 $1 #5

.data
	one #0xFFFFAAAA

