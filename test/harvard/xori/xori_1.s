// XORI check zero extend

.config
	ARCH h
	ASSERT 32'hFFFF000F

.text
	LW $2 0($0)
	XORI $2 $2 #0xFFF0
	JR $0

.data
    #0xFFFFFFFF
