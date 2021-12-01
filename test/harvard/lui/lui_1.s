.config
	ARCH h
	ASSERT 32'hFFFF0000

.text
		JR $0
		LUI $2 #0xFFFF

.data
