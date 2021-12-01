// negative < positive

.config
	ARCH h
	ASSERT 1

.text
	LW $1 #0($0)
	JR $0
	SLTI $2 $1 #5

.data
	#0xFFFFAAAA

