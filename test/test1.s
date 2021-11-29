//BRANCH ON LESS THAN ZERO AND LINK - SHOULDN'T WORK

.config
	ARCH h
	ASSERT 60

.text
	LW $1 a
	LW $2 4($0)
	SW $2 8($0)
	SW $2 c

.data
	a #50
	b #60
	c #0
