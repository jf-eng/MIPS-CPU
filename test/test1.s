.config
	ARCH v
	ASSERT 60

.text
	LW $v0 #4($gp)
	LW $v0 b
	ADDIU $sp $sp #4
	JR $0

.data
	a #1
	b #2
	c #60

