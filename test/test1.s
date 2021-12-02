.config
	ARCH v
	ASSERT 60

.text
	LW $2 a
	LW $2 b
	LW $2 c
	SW $2 a
	SW $2 b
	SW $2 c

	// LB $2 #3($0)
	// SB $2 #2($0)
	// LWR $2 #6($0)
	JR $0

.data
	a #1
	b #2
	c #60

